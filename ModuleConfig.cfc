/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title 				= "cbStrava";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "@MODULE_DESCRIPTION@";

	// Model Namespace
	this.modelNamespace		= "cbStrava";

	// CF Mapping
	this.cfmapping			= "cbStrava";

	// Dependencies
	this.dependencies 		= [ "hyper" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = {
			// Strava API Client SECRETS
			// Obtain these from https://www.strava.com/settings/api
			client_id : getSystemSetting( "STRAVA_CLIENT_ID", "" ),
			client_secret : getSystemSetting( "STRAVA_CLIENT_SECRET", "" ),
			access_token : getSystemSetting( "STRAVA_ACCESS_TOKEN", "" ),
			refresh_token : getSystemSetting( "STRAVA_REFRESH_TOKEN", "" )
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
					baseUrl = "https://www.strava.com/api/v3/",
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
