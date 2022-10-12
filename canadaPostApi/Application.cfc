component output="false"{

	This.name = "#createUUID()#";

	public any function onApplicationStart() {

		application.sysSettings = createObject( "java", "java.lang.System" );
		application.api_key = application.sysSettings.getProperty( "api_key", "6e93d53968881714:0bfa9fcb9853d1f51ee57a" );
		application.bearerToken = ToBase64(application.api_key )
		application.authorization = "Basic " & application.bearerToken;
		application.customerNumber = application.sysSettings.getProperty( "customerNumber", "2004381" );
		application.contractNumber = application.sysSettings.getProperty( "contractNumber", "42708517" );
		canadaPostCredentials = { apiKey = application.api_key, customerNumber = application.customerNumber, contractNumber = application.contractNumber};
		Application.root = '';
		Application.trackingObj = createobject("component","com.mitrahsoft.canadaPost.tracking").init(argumentcollection = canadaPostCredentials);
		// Application.ratingObj = createobject("component","rating").init(argumentcollection = canadaPostCredentials);

	}
	public any function onrequestStart(){
	}
}