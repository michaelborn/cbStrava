/**
 * Handle oAuth authorization to the Strava API.
 * 
 */
component accessors="true" {

  property name="authorizeURI" type = "string" default="https://www.strava.com/oauth/authorize";
  property name="client_id" inject="coldbox:setting:client_id@cbStrava";
  property name="client_secret" inject="coldbox:setting:client_secret@cbStrava";
  property name="base_url" inject="coldbox:setting:base_url@cbStrava";

  property name="Hyper"     inject="HyperBuilder@hyper";
  property name="controller" inject="coldbox";

  /**
   * Setup the OAuth Connector
   * 
   * Will happily throw an error if the API client settings are not configured - 
   * either via environment variables (.env and commandbox-dotenv, for example)
   * or via moduleSettings.cbStrava.clientID=xxx
   * 
   * @throws InvalidStravaConfigException
   */
  component function init(){
    return this;
  }

	/**
	 * Begin initial Authorization for Strava API
	 * 
	 * Initiates a Strava API connection by redirecting the user to a Strava-hosted page
	 * which allows users to "authorize" this app to connect to their account and read their info.
	 *
   * @cite https://developers.strava.com/docs/authentication/
   */
  public void function redirectToAuthURL(
    required string redirectURI,
    string scope = "activity:read",
    struct state = {}
  ){
    if ( variables.client_id == "" ){
      throw( 
        message = "Missing Strava API configuration.", 
        type = "InvalidStravaConfig",
        detail = "A Strava API connection requires the `client_id` setting. You can configure this setting via coldbox moduleSettings or a `STRAVA_CLIENT_ID` environment variable."
      );
    }
    variables.controller.relocate(
      url = getAuthorizeURI(),
      querystring = {
        "response_type"  : "code",
        "client_id"      : variables.client_id,
        "redirect_uri"   : arguments.redirectURI,
        "approval_prompt": "auto",
        "scope"          : arguments.scope,
        "state"          : serializeJSON( arguments.state )
      }
    );
  }

  /**
   * Exchange code for access token
   * 
   * @cite https://developers.strava.com/docs/authentication/
   */
  public function exchangeTokens( required string code, string grantType = "authorization_code" ){
    var response = variables.hyper
              .setMethod( "POST" )
              .setURL( "#variables.base_url#/oauth/token" )
              .setQueryParams( {
                "client_id"    : variables.client_id,
                "client_secret": variables.client_secret,
                "code"         : arguments.code,
                "grant_type"   : arguments.grantType
              })
              .send();

    handleTokenResponse( response );

    return response;
  }

  /**
   * 
   * @throws StravaAuthorizationFailure if response indicates an error with the access token request
   */
  private void function handleTokenResponse( required HyperResponse response ){
			if ( arguments.response.isSuccess() ){
				var result = arguments.response.json();

        /**
         * Allows implementing applications to hook in
         * and persist access tokens after a successful authentication.
         * 
         * See module readme.
         */
				controller.getInterceptorService().announce( "onStravaConnected", result );
			} else {

				var error = arguments.response.getData();
				var message = "Failed to acquire refresh token";

				if ( isJSON( error ) ){
					var data = deserializeJSON( error );
					if ( data.keyExists( "message" ) ){
						message &= ";" & deserializeJSON( error ).message;
					}
				}

				throw(
					message = "Unable to connect to Strava API",
					type = "StravaAuthorizationFailure",
					detail = isJSON( error ) ? arguments.response.json().message : "Failed to acquire refresh token",
					extendedInfo = arguments.response.getData()
				)
			}
  }
}