component output="TRUE" hint="Canada Post"{
	public any function init(
		required string apiKey,
		required string customerNumber,
		required string contractNumber
	){
		variables.apiKey = arguments.apiKey;
		variables.customerNumber = arguments.customerNumber;
		variables.contractNumber = arguments.contractNumber;

		variables.username = ListFirst(apiKey,':');
		variables.password = ListLast(apiKey,':');

		return this;
	}
	public any function getTrackingSummary(
		any pinNumber,
		any dncNumber
	){	
		if(structKeyExists(arguments,'pinNumber')){
			local.url = "https://ct.soa-gw.canadapost.ca/vis/track/pin/#arguments.pinNumber#/summary"
		}else{
			local.url = "https://ct.soa-gw.canadapost.ca/vis/track/dnc/#arguments.dncNumber#/summary"
		}

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.ship.rate-v3+xml");
			cfhttpparam( type="header", name="Authorization",value="#application.authorization#");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
		}
		local.resultOfStructure  = structNew();

		if( httpResponse.Statuscode eq '200 OK'){
			trackingSummaryXML = xmlparse(httpResponse.Filecontent);
			if(trackingSummaryXML.XmlRoot.xmlName eq "messages"){
				getTrackingDetail = trackingSummaryXML["messages"]["message"];
				getTrackingDetailNum = ArrayLen(getTrackingDetail);
				for(i = 1; i <= "#getTrackingDetailNum#"; i++){
					getTrackingDetailValue = {"code":#getTrackingDetail[i]["code"].XmlText#,"description":#getTrackingDetail[i]["description"].XmlText#}
					structAppend(local.resultOfStructure, getTrackingDetailValue);
				}
			}else{
				local.resultOfStructure = {"pin":#trackingSummaryXML["tracking-summary"]["pin-summary"]["pin"]["XmlText"]#, "destinationPostalID":#trackingSummaryXML["tracking-summary"]["pin-summary"]["destination-postal-id"]["XmlText"]#
				, "mailedOnDate":#trackingSummaryXML["tracking-summary"]["pin-summary"]["mailed-on-date"]["XmlText"]#
				, "actualDeliveryDate":#trackingSummaryXML["tracking-summary"]["pin-summary"]["actual-delivery-date"]["XmlText"]#
				, "expectedDeliveryDate":#trackingSummaryXML["tracking-summary"]["pin-summary"]["expected-delivery-date"]["XmlText"]#
				, "eventDescription":#trackingSummaryXML["tracking-summary"]["pin-summary"]["event-description"]["XmlText"]#}
			}
		}
		return local.resultOfStructure;
	}
	public any function getTrackingSummaryReference(
		required any mailingDateTo,
		required any destinationPostalCode,
		required any mailingDateFrom,
		required any referenceNumber
	){
		local.url = "https://ct.soa-gw.canadapost.ca/vis/track/ref/summary?mailingDateTo=" & #arguments.mailingDateTo# & "&mailingDateFrom=" & #arguments.mailingDateTo# & "&referenceNumber=" & #arguments.referenceNumber# & "&customerNumber=" & #variables.customerNumber# & "&destinationPostalCode=" & #arguments.destinationPostalCode#;

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.track+xml");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
		}

		local.resultOfStructure  = structNew();
		return local.resultOfStructure;
	}

	public any function getTrackingDetails(
		 	any pinNumber,
			any dncNumber
	){
		if(structKeyExists(arguments,'pinNumber')){
			local.url = "https://ct.soa-gw.canadapost.ca/vis/track/pin/#arguments.pinNumber#/detail";
		}else{
			local.url = "https://ct.soa-gw.canadapost.ca/vis/track/dnc/#arguments.dncNumber#/detail";
		}
		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.track-v2+xml");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
		}
		local.resultOfArray  = arrayNew(1);
		if(httpResponse.Statuscode eq '200 OK'){
			trackingDetailsXML = xmlparse(httpResponse.Filecontent);
			if(trackingDetailsXML.XmlRoot.xmlName eq "messages"){
				getTrackingDetail = trackingDetailsXML["messages"]["message"];
				getTrackingDetailNum = ArrayLen(getTrackingDetail);
				for(i = 1; i <= "#getTrackingDetailNum#"; i++){
					getTrackingDetailValue = {"code":#getTrackingDetail[i]["code"].XmlText#,"description":#getTrackingDetail[i]["description"].XmlText#}
					ArrayAppend(local.resultOfArray, getTrackingDetailValue);
				}
			}else{
				trackingDetail = trackingDetailsXML["tracking-detail"]["significant-events"]["occurrence"];
				getTrackingDetailNum = ArrayLen(trackingDetail);

				for(i = 1; i <= "#getTrackingDetailNum#"; i++){
					getTrackingDetailValue = {"event-identifier":#trackingDetail[i]["event-identifier"].XmlText#,
					"event-date":#trackingDetail[i]["event-date"].XmlText#,
					"event-time":#trackingDetail[i]["event-time"].XmlText#,
					"event-time-zone":#trackingDetail[i]["event-time-zone"].XmlText#,
					"event-description":#trackingDetail[i]["event-description"].XmlText#,
					"event-site":#trackingDetail[i]["event-site"].XmlText#,
					"event-province":#trackingDetail[i]["event-province"].XmlText#
					}
					ArrayAppend(local.resultOfArray, getTrackingDetailValue);
				}
			}
		}
		return local.resultOfArray;
	}

	public any function getSignatureImage(
		required any pinNumber
	){
		local.url = "https://ct.soa-gw.canadapost.ca/vis/signatureimage/#arguments.pinNumber#";

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.track+xml");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
		}
		local.resultOfStructure  = structNew();
		if(httpResponse.Statuscode eq '200 OK'){
			signatureImageXML = xmlparse(httpResponse.Filecontent);
			fileWrite('#expandPath('.')#\Assets\files\#signatureImageXML["signature-image"]["filename"]["XmlText"]#', '#ToBinary(signatureImageXML["signature-image"]["image"]["XmlText"])#');
			local.resultOfStructure = {"filename":#signatureImageXML["signature-image"]["filename"]["XmlText"]#};
		}
		return local.resultOfStructure;
	}

	public any function getDeliveryConfirmationCertificate(
		required any pinNumber
	){
		local.url = "https://ct.soa-gw.canadapost.ca/vis/certificate/#arguments.pinNumber#";

		cfhttp(method="get", result="httpResponse",url="#local.url#",username="#VARIABLES.username#",password="#VARIABLES.password#") {
			cfhttpparam( type="header", name="Accept",value="application/vnd.cpc.track+xml");
			cfhttpparam( type="header", name="Accept-language",value="en-CA");
		}
		local.resultOfStructure  = structNew();
		if(httpResponse.Statuscode eq '200 OK'){
			deliveryConfirmationXML = xmlparse(httpResponse.Filecontent);
			fileWrite('#expandPath('.')#\Assets\files\#deliveryConfirmationXML["delivery-confirmation-certificate"]["filename"]["XmlText"]#', '#ToBinary(deliveryConfirmationXML["delivery-confirmation-certificate"]["image"]["XmlText"])#');

			local.resultOfStructure = {"filename":deliveryConfirmationXML["delivery-confirmation-certificate"]["filename"]["XmlText"]};
		}
		return local.resultOfStructure;
	}
}