<html>
    <head>
      <title>My Great Website</title>
    </head>
    <body>
      <div id="fb-root"></div>
      <script src="http://connect.facebook.net/en_US/all.js">
      </script>
      <script>
         FB.init({ 
            appId:'114520588635685', cookie:true, 
            status:true, xfbml:true 
         });

         FB.ui({ method: 'feed', 
            message: 'Facebook for Websites is super-cool'});
      </script>
     </body>
 </html> 