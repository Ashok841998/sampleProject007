
# Sign in or sign up
- If you already have a Canada Post username and password, Sign in to the Canada Post website. Need a username and password? Sign up now.

# Join the Developer Program
- Once youâ€™ve signed in to our website, select Join Now. Read and accept the terms and conditions of the Program to become a member.

# Get your API keys
- API keys are unique codes that identify your application each time it makes a call to one of our services. Once youâ€™re a member of our Developer Program and are signed in to the Canada Post website, your keys will be displayed on the main Developer Program page.

# Service Summary
- Use the rating services to get shipping costs between two points at various speeds of service and with requested add-on features.

# Rating functionality

# Get Rates

Summary

- This call returns a list of shipping services, prices and transit times for a given item to be shipped

Name: | Get Rates 
---- | -------- 
Reason to Call: | To get a list of services, prices and transit times for a shipment.
Input: | Basic address and parcel information 
Output: | Service(s), price(s), transit time(s) and expected delivery date 
Error Example: | No services are appropriate for the shipment of the defined parcel. Validate the parcel criteria against product specifications. 
Typical prior call: | No directly related prior calls

# Request Details

- EndPoints: POST https://XX/rs/ship/price
- Accept: application/vnd.cpc.ship.rate-v4+xml

Replace...| With... 
----------|-------------------------
XX (Development) | ct.soa-gw.canadapost.ca*
XX (Production) | soa-gw.canadapost.ca

Code | Message 
---- | -------- 
1622 | The expected-mailing-date must not be in the past.
7050 | The {0} option requires the {1} option. Please add the prerequisite or remove the option. 
9111 | No services are appropriate for the shipment of the defined parcel. Validate the parcel criteria against product specifications. 
9112 | The service {0} is not available for the specified country or customer/contract. 


# Discover Services

Summary

- This call returns the list of available postal services for a given country, customer, contract, origin and/or destination postal code.

Name: | Discover Services 
---- | -------- 
Reason to Call: | To discover the list of postal services that can be used for a given destination country, customer, contract, origin and/or destination postal code.
Input: | Destination Country 
Output: | Service links and descriptions 

# Request Details

- Endpoint: GET https://XX/rs/ship/service?country={country code}&contract={contract-id}&origpc={origin-postal-code}&destpc={destination-postal-code}

- Accept: application/vnd.cpc.ship.rate-v4+xml

Replace...| With... 
----------|-------------------------
XX (Development) | ct.soa-gw.canadapost.ca
XX (Production) | soa-gw.canadapost.ca
{country code} | the desired 2-character country code
{contract-id} | The Canada Post contract number

- Response â€“ Possible Error Responses

Code| Description 
----------|-------------------------
2550 | The contract number is not valid.
7266 | Postal Code must be in format A9A or A9A9A9.
8534 | A valid destination country must be supplied.
9194 | The Canada Post contract number


# Get Service

Summary

- This call returns details of a given postal service in terms of the min/max weight and dimensions offered by the postal service. Also returned are details about the available add-on options.

Name: | Get Service 
---- | -------- 
Reason to Call: | To find out details for a given postal service such as the dimension and weight limits and the available options.
Input: | Service with optional country 
Output: | Service description, options and restrictions

# Request Details

- Endpoint: GET https://ct.soa-gw.canadapost.ca/rs/ship/service/DOM.EP?country=JP
- Accept: application/vnd.cpc.ship.rate-v4+xml

- Response â€“ Possible Error Responses

Code | Description 
---- | -------- 
8534 | A valid destination country must be supplied.

# Get Option

Summary 

- This call returns information about a given add-on option such as how it is used and whether it requires or conflicts with other options.

Name: | Get Option 
---- | -------- 
Reason to Call: | Used to retrieve details of a given option.
Input: | Option code or link from Get Service where rel=option 
Output: | Option description, prerequisites and conflicts

# Request Details

- Endpoint: GET https://ct.soa-gw.canadapost.ca/rs/ship/option/countryCode
- Accept: application/vnd.cpc.ship.rate-v4+xml

# Tracking functionality

# Get Tracking Summary

Summary

Name: | Get Tracking Summary 
---- | -------- 
Reason to Call: | To get the most recent/significant tracking event for a parcel.
Input: | Parcel Identification Parameter(s) (e.g PIN Number / DNC Number or Reference parameters) 
Output: | Date, location and event type for the most recent/significant event
Error Examples: | PIN not found, duplicate PIN

# Request Details

- EndPoint: 

GET https://XX/vis/track/pin/{pin number}/summary
or
GET https://XX/vis/track/dnc/{dnc number}/summary
or
GET https://XX/vis/track/ref/summary?mailingDateTo=YYYY-MM-DD
&mailingDateFrom=YYYY-MM-DD&referenceNumber={reference number}
&customerNumber={customer number}&destinationPostalCode={destination postal code}


Replace... | With... 
---- | --------------
XX (Development) | ct.soa-gw.canadapost.ca
XX (Production) | soa-gw.canadapost.ca 
{pin number} | the parcel PIN
{dnc number} | the delivery notice card number
YYYY-MM-DD | the mailing from and to dates
{reference number} | the value you specified in either customer-ref-1 or customer-ref-2 fields when you created the shipment.
{customer number} | your customer number
{destination postal code} | the destination Postal Code of the parcel

# Response â€“ Possible Error Responses

Code | Description 
---- | --------------
002 | Duplicate Pin
004 | No Pin History 
006 | Reference number, mailed from date, mailed to date and destination Postal Code are required fields for a reference number search.
008 | Invalid Date


# Get Tracking Details

Summary 

- This call returns all tracking events recorded for a specified parcel. (The parcel is identified using a PIN or DNC).

Name: | Get Tracking Details 
---- | -------- 
Reason to Call: | To get all tracking events for a single parcel.
Input: | PIN/DNC Number 
Output: | Basic parcel information, dates, location and status for each event. Summary parcel information.
Error Examples: | no PIN History

# Request Details

- Endpoint

GET https://XX/vis/track/pin/{pin number}/detail
or
GET https://XX/vis/track/dnc/{dnc number}/detail

Replace... | With... 
---- | --------------
XX (Development) | ct.soa-gw.canadapost.ca
XX (Production) | soa-gw.canadapost.ca 
{pin number}| the parcel PIN
{dnc number} | the delivery notice card number

# Response â€“ Possible Error Responses

Code | Description 
---- | --------------
004 | No PIN History
002 | Duplicate PIN 

# Get Signature Image

Summary

- This call returns a signature image captured at delivery of the parcel if available. (The parcel is identified using a PIN only). Please note the following:
	- U.S.A. and international services do not support signature retrieval.
	- Signature images are available for 45 days after the last scan.
	- Recipients of parcels may request suppression of their signature image from view.


Name: | Get Signature Image 
---- | -------- 
Reason to Call: | To retrieve the image of the signature provided for a specific parcel.
Input: | PIN 
Output: | JPG image encoded as a string of bytes
Error Examples: | PIN not found, signature not available

# Request Details

- Endpoint: GET https://XX/vis/signatureimage/{pin number}

Replace... | With... 
---- | --------------
XX (Development) | ct.soa-gw.canadapost.ca
XX (Production) | soa-gw.canadapost.ca 
{pin number}| the parcel PIN

# Response â€“ Possible Error Responses

Code | Description 
---- | --------------
004 | No PIN History
002 | Duplicate PIN 
003 | No Signature Image Available

# Get Delivery Confirmation Certificate

Summary

- If the parcel has been delivered, this call provides a PDF document containing the following delivery details:
	- Tracking number, service used, reference numbers, delivery date, signatory name
	- Signature image (if available)
The parcel is identified using a PIN only.

Name: | Get Delivery Confirmation Certificate 
---- | -------- 
Reason to Call: | To retrieve the image of the delivery confirmation certificate (which is a document showing proof of delivery with details) for a given parcel.
Input: | PIN 
Output: | PDF document
Error Examples: | PIN not found, signature not available

# Request Details

- Endpoint: GET https://XX/vis/certificate/{pin number}

Replace... | With... 
---- | --------------
XX (Development) | ct.soa-gw.canadapost.ca
XX (Production) | soa-gw.canadapost.ca 
{pin number}| the parcel PIN

# Response â€“ Possible Error Responses

Code | Description 
---- | --------------
007 | No Delivery Information Available