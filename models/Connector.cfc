/**
 * Handle oAuth authorization to the Strava API.
 * 
 */
component accessors="true" {

  property name="authorizeURI" type = "string" default="https://www.strava.com/oauth/authorize";
  property name="client_id" inject="coldbox:setting:client_id@cbStrava";

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
	 * Connect to Strava API
	 * 
	 * Initiates a Strava API connection by redirecting the user to a Strava-hosted page
	 * which allows users to "authorize" this app to connect to their account and read their info.
	 *
   * @cite https://developers.strava.com/docs/authentication/
   */
  public function redirectToAuthURL(
    required string redirectURI,
    string scope = "activity:read",
    struct state = {}
  ){
    if ( variables.client_id == "" ){
      throw( 
        message = "Missing Strava API configuration.", 
        type = "InvalidStravaConfigException",
        detail = "A Strava API connection requires the `client_id` setting. You can configure this setting via coldbox moduleSettings or a `STRAVA_CLIENT_ID` environment variable."
      );
    }
    variables.controller.relocate(
      url = getAuthorizeURI(),
      querystring = getAuthorizeParams(
        redirectURI = arguments.redirectURI,
        scope = arguments.scope,
        state = arguments.state
      )
    );
  }

  private function getAuthorizeParams(
    required string redirectURI,
    required string scope,
    struct state = {}
  ){
    return {
      "response_type"  : "code",
      "client_id"      : variables.client_id,
      "redirect_uri"   : arguments.redirectURI,
      "approval_prompt": "auto",
      "scope"          : arguments.scope,
      "state"          : serializeJSON( arguments.state )
    }
  }
}