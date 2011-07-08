


<%@ page import="com.google.gdata.client.GoogleService" %>
<%@ page import="com.google.gdata.client.authn.oauth.*" %>
<%@ page import="com.google.gdata.data.BaseEntry" %>
<%@ page import="com.google.gdata.data.BaseFeed" %>
<%@ page import="com.google.gdata.data.Feed" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="sbose78.MyBlog" %>


<%

  
    


    // Initialize the variables needed to make the request
    URL feedUrl = new URL("http://www.blogger.com/feeds/default/blogs");
    out.println("Sending request to " + feedUrl.toString());
    out.println();

    // Set the OAuth credentials which were obtained from the step above.
		
			
    GoogleOAuthParameters oauthParameters = new GoogleOAuthParameters();
    oauthParameters.setOAuthConsumerKey("sbose78.appspot.com");

    oauthParameters.setOAuthConsumerSecret("81e8pQ8SC99K5FWvNK_mCGsj");



	HttpSession s = request.getSession(true);
	String ats=s.getAttribute("oauth_token_secret").toString();


        oauthParameters.setOAuthSignatureMethod("HMAC-SHA1");
	oauthParameters.setOAuthToken(request.getParameter("oauth_token"));
	oauthParameters.setOAuthTokenSecret(ats);

	OAuthSigner signer=new OAuthHmacSha1Signer();
	
    GoogleOAuthHelper oauthHelper = new GoogleOAuthHelper(signer);

	String accessToken = oauthHelper.getAccessToken(request.getQueryString(),oauthParameters);	


	s.setAttribute("accessToken",accessToken);
	
	out.println("<br> YOUR ACCESS_TOKEN FOR OAUTH 1.0 is :"+accessToken+"<br><br>");
	
	/************************************************************/

	MyBlog b=new MyBlog(oauthParameters, signer);
	String blogs[]=b.printUserBlogs();
	for(int i=0;i<blogs.length;i++)
	{
		out.println("<br>"+blogs[i]);
	}
	
	out.println("<a href='/search5.jsp'>CLICK TO GO TO NEXT PAGE</a>");
/*	
    GoogleService googleService =   new GoogleService("blogger", "sbose78");

    // Set the OAuth credentials which were obtained from the step above.
    googleService.setOAuthCredentials(oauthParameters, signer);

    // Make the request to Google
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
  
*/
 

%>
