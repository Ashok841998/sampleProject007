<cfoutput>
    <head>
        <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
    </head>
    <cfif structKeyExists(url,'delivery')>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='pinNumber' value=""><br>
                <button type="submit" class='badge bg-primary' name='pinNumber'>Delivery Confirmation Certificate</button><br />
            </form>
        </center>
        <cfif structKeyExists(form,'pinNumber')>
            <cfset deliveryConfirmationCertificate = Application.trackingObj.getDeliveryConfirmationCertificate( pinNumber = form.pinNumber )>
            <cfif structIsEmpty(deliveryConfirmationCertificate) neq 'Yes'>
                <cflocation url="./Assets/files/#deliveryConfirmationCertificate.filename#">
            <cfelse>
                No result
            </cfif>
        </cfif>
    </cfif>
    <cfif structKeyExists(url,'signature')>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='pinNumber' value=""><br>
                <button type="submit" class='badge bg-primary' name='pinNumber'>get Signature Image</button><br />
            </form>
        </center>
        <cfif structKeyExists(form,'pinNumber')>
            <cfset signatureImage = Application.trackingObj.getSignatureImage(pinNumber = "1371134583769923")>
            <cfif structIsEmpty(signatureImage) neq 'Yes'>
                <img src=".\Assets\files\#signatureImage.filename#">
            <cfelse>
                No result
            </cfif>
        </cfif>
    </cfif>
    <cfif structKeyExists(url,'trackingDetails')>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='pinNumber' value="" placeholder="pinNumber"><br>
                <button type="submit" class='badge bg-primary' name='getPinNumber'>getTrackingDetails</button><br />
            </form>
        </center>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='DNCnumber' value="" placeholder="dncNumber"><br>
                <button type="submit" class='badge bg-primary' name='getDNCnumber'>getTrackingDetails</button><br />
            </form>
        </center>
        <cfif structKeyExists(form,"pinNumber")>
            <cfset trackingDetailsPinNum = Application.trackingObj.getTrackingDetails(pinNumber = form.pinNumber)>
            <cfif ArrayIsEmpty(trackingDetailsPinNum) neq 'no'>
                <b>Tracking Details Pin Number</b>
                <table class="table">
                    <tr>
                        <th>Event Time</th>
                        <th>Event Date</th>
                        <th>Event Description</th>
                        <th>Event Province</th>
                        <th>Event Site</th>
                        <th>Event Time Zone</th>
                        <th>Event Identifier</th>
                    </tr>
                    <cfloop from="1" to="#arrayLen(trackingDetailsPinNum)#" index="i">
                        <cfset dataOfTrackingDetail = trackingDetailsPinNum[i]>
                        <tr>
                            <cfloop collection="#dataOfTrackingDetail#" item="key">
                                <td>#dataOfTrackingDetail[key]#</td>
                            </cfloop>
                        </tr>
                    </cfloop>
                </table><br>
            <cfelse>
                <b>Tracking Details Pin Number</b>
                <table border="1">
                    <tr>
                        <th>Code</th>
                        <th>Description</th>
                    </tr>
                    <cfloop from="1" to="#arrayLen(trackingDetailsPinNum)#" index="i">
                        <cfset dataOfTrackingDetail = trackingDetailsPinNum[i]>
                        <tr>
                            <cfloop collection="#dataOfTrackingDetail#" item="key">
                                <td>#dataOfTrackingDetail[key]#</td>
                            </cfloop>
                        </tr>
                    </cfloop>
                </table><br>
            </cfif>
        </cfif>
        <cfif structKeyExists(form,"DNCnumber")>
            <cfset trackingDetailsdncNum = Application.trackingObj.getTrackingDetails(dncNumber = form.DNCnumber)>
            <cfif ArrayIsEmpty(trackingDetailsdncNum) neq 'Yes'>
                <b>Tracking Details DNC Number</b>
                <table class="table">
                    <tr>
                        <th>Event Time</th>
                        <th>Event Date</th>
                        <th>Event Description</th>
                        <th>Event Province</th>
                        <th>Event Site</th>
                        <th>Event Time Zone</th>
                        <th>Event Identifier</th>
                    </tr>
                    <cfloop from="1" to="#arrayLen(trackingDetailsdncNum)#" index="i">
                        <cfset dataOfTrackingDetail = trackingDetailsdncNum[i]>
                        <tr>
                            <cfloop collection="#dataOfTrackingDetail#" item="key">
                                <td>#dataOfTrackingDetail[key]#</td>
                            </cfloop>
                        </tr>
                    </cfloop>
                </table>
            <cfelse>
                No result
            </cfif>
        </cfif>
    </cfif>
    <cfif structKeyExists(url,'TrackingSummary')>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='pinNumber' value="" placeholder="pinNumber"><br>
                <button type="submit" class='badge bg-primary' name='getPinNumber'>getTrackingDetails</button><br />
            </form>
        </center>
        <center>
            <form method="POST" name="getDeliveryConfirmationCertificate">
                <input type="text" name='DNCnumber' value="" placeholder="dncNumber"><br>
                <button type="submit" class='badge bg-primary' name='getDNCnumber'>getTrackingDetails</button><br />
            </form>
        </center>
        
        <cfif structKeyExists(form,'getPinNumber')>
            <cfset trackingSummaryPinNum = Application.trackingObj.getTrackingSummary(pinNumber = form.pinNumber)>
            <cfif structIsEmpty(trackingSummaryPinNum) neq 'Yes'>
                <b>Tracking Summary Pin Number</b>
                <table border="1">
                    <cfloop collection="#trackingSummaryPinNum#" item="key">
                        <tr>
                            <th>#key#</th>
                            <td>#trackingSummaryPinNum[key]#</td>
                        </tr>
                    </cfloop>
                </table><br>
            <cfelse>
                No result
            </cfif>
        </cfif>
        <cfif structKeyExists(form,'getDNCnumber')>
            <cfset trackingSummaryDncNum = Application.trackingObj.getTrackingSummary(dncNumber = form.DNCnumber)>
            <cfif structIsEmpty(trackingSummaryDncNum) neq 'Yes'>
                <b>Tracking Summary DNC Number</b>
                <table border="1">
                    <cfloop collection="#trackingSummaryDncNum#" item="key">
                        <tr>
                            <th>#key#</th>
                            <td>#trackingSummaryDncNum[key]#</td>
                        </tr>
                    </cfloop>
                </table>
            <cfelse>
                No result
            </cfif>
        </cfif>
        <cfset trackingSummaryReference = Application.trackingObj.getTrackingSummaryReference( mailingDateTo = "2015-04-05" , destinationPostalCode = "K0J1T0", mailingDateFrom = "2015-04-12", referenceNumber ='APRIL1REF1A')>
    </cfif>
</cfoutput>