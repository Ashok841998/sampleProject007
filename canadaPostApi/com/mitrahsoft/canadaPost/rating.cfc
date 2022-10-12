component output="false" {
	public any function init(
		required string apiKey
		,required string customerNumber
		,required string contractNumber
	){
		variables.apiKey = arguments.apiKey;
		variables.customerNumber = arguments.customerNumber;
		variables.contractNumber = arguments.contractNumber;

		variables.username = ListFirst(apiKey,':');
		variables.password = ListLast(apiKey,':');

		return this;
	}

	public any function discoverServices(
		required any countryCode,
		required any originPostalCode,
		required any postalCode,
		){

		local.url = "https://ct.soa-gw.canadapost.ca/rs/ship/service?country="& #arguments.countryCode# & "&contract=" & #variables.contractNumber# & "&origpc=" & #arguments.originPostalCode# & "&destpc=" & #arguments.postalCode#;

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.ship.rate-v3+xml");
		}

		local.resultOfArray = arrayNew(1);
		if( httpResponse.Statuscode eq '200 OK'){
			discoverServicesXML = xmlparse(httpResponse.filecontent);
			discoverServiceDetail = discoverServicesXML["services"]["service"];
			discoverServiceNum = ArrayLen(discoverServiceDetail);

			for (i = 1; i <= "#discoverServiceNum#"; i++) {
			   getServiceValue = {"service-code":#discoverServiceDetail[i]["service-code"].XmlText#,"service-name":#discoverServiceDetail[i]["service-name"].XmlText#};
			   ArrayAppend(local.resultOfArray, getServiceValue);
			}
		}
		return local.resultOfArray;
	}

	public any function getOptions(
		required string countryCode
	){
		local.url = 'https://ct.soa-gw.canadapost.ca/rs/ship/option/' & arguments.countryCode;

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.ship.rate-v3+xml");
		}

		local.resultOfArray = arrayNew(1);
		if(httpResponse.Statuscode eq '200 OK'){
			getOptions = xmlparse(httpResponse.Filecontent);
			getOptionValue = {"option-code":#getOptions["option"]["option-code"]["XmlText"]#,"option-name":#getOptions["option"]["option-name"]["XmlText"]#};
			ArrayAppend(local.resultOfArray, getOptionValue);
		}
		
		return local.resultOfArray;
	}

	public any function getRates(
		required string originPostalCode,
		required string postalCode,
		required string countryCode,
		required string weight,
		required string length,
		required string width,
		required string height
	){
		var ratings = "
		<mailing-scenario xmlns = http://www.canadapost.ca/ws/ship/rate-v3>
			<customer-number>#variables.customerNumber#</customer-number>
			<parcel-characteristics>
				<dimensions>
					<length>#NumberFormat(arguments.length, ".9")#</length>
					<width>#NumberFormat(arguments.width, ".9")#</width>
					<height>#NumberFormat(arguments.height, ".9")#</height>
				</dimensions>
				<weight>#NumberFormat(arguments.weight, ".9")#</weight>
			</parcel-characteristics>
			<origin-postal-code>#arguments.originPostalCode#</origin-postal-code>
			<destination>
				<cfif arguments.countryCode EQ 'CA'>
					<domestic>
						<postal-code>#arguments.postalCode#</postal-code>
					</domestic>
				<cfelseif arguments.countryCode EQ 'us'>
					<united-states>
						<zip-code>#arguments.postalCode#</zip-code>
					</united-states>
				<cfelse>
					<international>
						<country-code>#arguments.countryCode#</country-code>
					</international>
				</cfif>
			</destination>
		</mailing-scenario>";

		savecontent variable="xmlRequest" {
			writeOutput("<?xml version='1.0' encoding='UTF-8'?>#ratings#");
		}

		local.url = "https://ct.soa-gw.canadapost.ca/rs/ship/price";

		cfhttp(method="post", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.ship.rate-v3+xml");
			cfhttpparam( type="xml",value="#trim(xmlRequest)#");
			cfhttpparam( type="header", name="Content-type",value="application/vnd.cpc.ship.rate-v3+xml");
		}

		local.resultOfArray = arrayNew(1);
		if(httpResponse.Statuscode eq '200 OK'){
			getRatesXML = xmlparse(httpResponse.Filecontent);
			getRatesDetail = getRatesXML["price-quotes"]["price-quote"];
			getRatesNum = ArrayLen(getRatesDetail);			

			for (i = 1; i <= "#getRatesNum#"; i++) {
			    getRatesValue = {"service-code":#getRatesDetail[i]["service-code"].XmlText#,"service-name":#getRatesDetail[i]["service-name"].XmlText#,"price-details":#getRatesDetail[i]["price-details"].due.XmlText#};
			    ArrayAppend(local.resultOfArray, getRatesValue);
			}
		}

		return local.resultOfArray;
	}

	public any function getservices(
		required string countryCode
	){
		local.url = 'https://ct.soa-gw.canadapost.ca/rs/ship/service/DOM.EP?country=' & arguments.countryCode;
		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.ship.rate-v3+xml");
		}
		local.resultOfArray = arrayNew(1);
		if(httpResponse.Statuscode eq '200 OK'){
			getServices = xmlparse(httpResponse.Filecontent);
			getServiceDetail = getServices["service"]["options"]["option"];
			getServiceNum = ArrayLen(getServiceDetail);
			for (i = 1; i <= "#getServiceNum#"; i++) {
			   getServiceValue = {"option-code":#getServiceDetail[i]["option-code"].XmlText#,"option-name":#getServiceDetail[i]["option-name"].XmlText#};
			   ArrayAppend(local.resultOfArray, getServiceValue);
			}
		}
		return local.resultOfArray
	}
}