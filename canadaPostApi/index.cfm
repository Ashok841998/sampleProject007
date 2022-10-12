<center>
    <h2>CANADA POST API</h2>
    <form action='submit.cfm' name='tracking' method="POST">
        <div class="container">
            <div class="row">
              <div class="col">
                <div class="card" style="width: 18rem; background-color:#ADD8E6;">
                  <head>
                    <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
                  </head>
                  <h4>Tracking</h4>
                  <button type="submit" class='badge bg-primary text-wrap fs-5 text' name='getDeliveryConfirmationCertificate'><a href="submit.cfm?delivery" class='text-white nounderline fs-5 text'>Delivery Confirmation Certificate</a></button><br />
                  <button type="submit" class='badge bg-primary text-wrap' name='submit.cfm'><a href="submit.cfm?signature" class='text-white nounderline fs-5 text'>Signature Image</a></button><br />
                  <button type="submit" class='badge bg-primary text-wrap' name='TrackingDetails'><a href="submit.cfm?trackingDetails" class='text-white nounderline fs-5 text'>Tracking Details</a></button><br />
                  <button type="submit" class='badge bg-primary text-wrap' name='TrackingSummary'><a href="submit.cfm?TrackingSummary" class='text-white nounderline fs-5 text'>Tracking Summary</a></button><br />
                </div>
              </div>
              <div class="col">
                <div class="card" style="width: 18rem; background-color:#ADD8E6;">
                    <h4>Rating</h4>
                    <button type="submit" class='badge bg-primary text-wrap' name='discoverServices'><a href="rating/discoverServices.cfm" class='text-white nounderline fs-5 text'>discover Services</a></button><br />
                    <button type="submit" class='badge bg-primary text-wrap' name='Option'><a href="rrating/getOption.cfm" class='text-white nounderline fs-5 text'>Option</a></button><br />
                    <button type="submit" class='badge bg-primary text-wrap' name='Rates'><a href="rating/getRates.cfm" class='text-white nounderline fs-5 text'>Rates</a></button><br />
                    <button type="submit" class='badge bg-primary text-wrap' name='Services'><a href="rating/getServices.cfm" class='text-white nounderline fs-5 text'>Services</a></button><br />
                </div>
              </div>
            </div>
        </div>
    </form>
</center>
<style>
    .nounderline {
  text-decoration: none !important
}
</style>