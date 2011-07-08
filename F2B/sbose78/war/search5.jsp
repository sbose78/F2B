


<%@ page import="com.google.gdata.client.GoogleService" %>
<%@ page import="com.google.gdata.client.*" %>
<%@ page import="com.google.gdata.client.authn.oauth.*" %>
<%@ page import="com.google.gdata.data.BaseEntry" %>
<%@ page import="com.google.gdata.data.BaseFeed" %>
<%@ page import="com.google.gdata.util.*" %>
<%@ page import="com.google.gdata.data.*" %>
<%@ page import="com.google.gdata.client.blogger.BloggerService"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="sbose78.MyBlog" %>


<%

  
    

	HttpSession s = request.getSession(true);


	String accessToken=s.getAttribute("accessToken").toString();
	String ats=s.getAttribute("oauth_token_secret").toString();


	out.println("ACCESS TOKEN: "+accessToken+"\n\n TOKEN SECRET"+ats);


if(!s.isNew()){
	

		
	GoogleOAuthParameters oauthParameters = new GoogleOAuthParameters();
        oauthParameters.setScope("https://www.blogger.com/feeds");
	oauthParameters.setOAuthConsumerKey("sbose78.appspot.com");
        oauthParameters.setOAuthConsumerSecret("81e8pQ8SC99K5FWvNK_mCGsj");//81e8pQ8SC99K5FWvNK_mCGsj 
	oauthParameters.setOAuthToken(accessToken);
	oauthParameters.setOAuthTokenSecret(ats);
	
        oauthParameters.setOAuthSignatureMethod("HMAC-SHA1");

	OAuthSigner signer=new OAuthHmacSha1Signer();	
/**********************************************************************************************************/
	 URL feedUrl = new URL("https://www.blogger.com/feeds/default/blogs");

    BloggerService googleService =   new BloggerService("sbose78");

    // Set the OAuth credentials which were obtained from the step above.
    googleService.setOAuthCredentials(oauthParameters, signer);

    // Make the request to Google

   try{	
  	  BaseFeed resultFeed = googleService.getFeed(feedUrl, Feed.class);
	  out.println("Response Data:");
	  out.println("=====================================================");
 	  out.println("| TITLE: " + resultFeed.getTitle().getPlainText());
	
          if (resultFeed.getEntries().size() == 0) {
  	        out.println("|\tNo entries found.");
  	  }

  	  else {
		      for (int i = 0; i < resultFeed.getEntries().size(); i++) {
		        BaseEntry entry = (BaseEntry) resultFeed.getEntries().get(i);
  		      	out.println("|\t" + (i + 1) + ": "+ entry.getTitle().getPlainText());
		      } 
  	   }
  }
  catch(AuthenticationException e)  
  {
	out.println("<BR>COULD NOT AUTHENTICATE<BR>");
  }  	
		
/***************************************************************************************************************/

/*
	MyBlog b=new MyBlog(oauthParameters, signer);
	String blogs[]=b.printUserBlogs();
	for(int i=0;i<blogs.length;i++)
	{
		out.println("<br>"+blogs[i]);
	}

*/

}
else{
	out.println("NEW SESSION MAN !");
}
 

%>
