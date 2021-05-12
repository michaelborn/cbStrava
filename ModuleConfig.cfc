/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title          = "cbStrava";
	this.author         = "Ortus Solutions";
	this.webURL         = "https://www.ortussolutions.com";
	this.description    = "@MODULE_DESCRIPTION@";
	this.modelNamespace = "cbStrava";
	this.cfmapping      = "cbStrava";
	this.entryPoint     = "cbstrava";
	this.dependencies   = [ "hyper" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = {
			// Strava API Client SECRETS
			// Obtain these from https://www.strava.com/settings/api
			client_id    : getSystemSetting( "STRAVA_CLIENT_ID", "" ),
			client_secret: getSystemSetting( "STRAVA_CLIENT_SECRET", "" )

			/**
			 * Strava API base URL, including version number
			 */
			base_url     : "https://www.strava.com/api/v3/"
		};

		/**
		 * Custom Interception Points
		 */
		variables.interceptorSettings = {
			customInterceptionPoints : [
				/**
				 * Fires after a successful authorization of the Strava API.
				 * 
				 * You are expected to listen for this event and either
				 * 1. override the event view:
				 * `event.setView( "admin/stravaConnected" )` OR
				 * 2. redirect to your own handler to do stuff:
				 * `relocate( "admin.stravaConnected" )`
				 * 
				 * PS. You MUST take this opportunity to store the `data.access_token` and `data.refresh_token` args passed in the interception payload and PERSIST it in some manner,
				 * whether in the database, a simple `fileWrite()`, or whatever.
				 * If you don't take this simple step, you won't be able to use the creds for further Strava actions.
				 * 
				 * See https://developers.strava.com/docs/authentication/
				 */
				"onStravaConnected",

				/**
				 * Fires after a user denies the request to integrate with Strava.
				 * 
				 * There's not too much you can do at this point other than graciously offer the user a chance to change their mind, or perhaps redirect them to a rick roll video.
				 * 
				 * See https://developers.strava.com/docs/authentication/
				 */
				"onStravaAuthorizationDenied"
			]
		};
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){

		binder
			.map( "StravaClient" )
			.to( "hyper.models.HyperBuilder" )
			.asSingleton()
			.initWith(
					baseUrl = settings.base_url,
					headers = {
						"Authorization" = settings.access_token
					}
			);
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){

	}

}
