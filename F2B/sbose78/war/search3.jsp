


<%@ page import="com.google.gdata.client.GoogleService" %>
<%@ page import="com.google.gdata.client.authn.oauth.*" %>
<%@ page import="com.google.gdata.data.BaseEntry" %>
<%@ page import="com.google.gdata.data.BaseFeed" %>
<%@ page import="com.google.gdata.data.Feed" %>
<%@ page import="java.net.*" %>
<%@ page import="sbose78.Sanitize" %>
<%@ page import="java.util.*" %>



<%
////////////////////////////////////////////////////////////////////////////
    // STEP 1: Gather the user's information
    ////////////////////////////////////////////////////////////////////////////

    // This step collects information from the user, such as the consumer key
    // and which service to query.  This is just a general setup routine, and
    // the method by which you collect user information may be different in your
    // implementation.
   

    ////////////////////////////////////////////////////////////////////////////
    // STEP 2: Set up the OAuth objects
    ////////////////////////////////////////////////////////////////////////////

    GoogleOAuthParameters oauthParameters = new GoogleOAuthParameters();

    oauthParameters.setOAuthConsumerKey("sbose78.appspot.com");

    OAuthSigner signer;
	oauthParameters.setOAuthConsumerSecret("81e8pQ8SC99K5FWvNK_mCGsj");
     signer = new OAuthHmacSha1Signer();
		
		

    // Finally create a new GoogleOAuthHelperObject.  This is the object you
    // will use for all OAuth-related interaction.
    GoogleOAuthHelper oauthHelper = new GoogleOAuthHelper(signer);


    ////////////////////////////////////////////////////////////////////////////
    // STEP 3: Get the Authorization URL
    ////////////////////////////////////////////////////////////////////////////

    // Set the scope for this particular service.
    oauthParameters.setScope("http://www.blogger.com/feeds/");
	oauthParameters.setOAuthCallback("https://sbose78.appspot.com/insertBlogger.jsp");

    oauthHelper.getUnauthorizedRequestToken(oauthParameters);
	
	out.println("<br>Token secret="+oauthParameters.getOAuthTokenSecret());


// set the token secret as a session attribute.
	
	  HttpSession s = request.getSession(true);
	s.setAttribute("oauth_token_secret",oauthParameters.getOAuthTokenSecret());
	
	String sub=request.getParameter("subject");
	sub=Sanitize.removeTags(sub);
	
	String mes=request.getParameter("message");
	mes=Sanitize.removeTags(mes);
	
	//out.println("<BR>SUB: "+sub+"<BR>MES:"+mes);
	
	s.setAttribute("subject",sub);
	s.setAttribute("message",mes);



/***********************************/
	
	 Enumeration paramNames = request.getParameterNames();
    while(paramNames.hasMoreElements()) {
      String paramName = (String)paramNames.nextElement();
      out.println("<TR><TD>" + paramName + "\n<TD>");
      String[] paramValues = request.getParameterValues(paramName);
      if (paramValues.length == 1) {
        String paramValue = paramValues[0];
        if (paramValue.length() == 0)
          out.print("<I>No Value</I>");
        else
          out.print(paramValue);
      } else {
        out.println("<UL>");
        s.setAttribute("count",paramValues.length);
        for(int i=0; i<paramValues.length; i++) {
        
 	   s.setAttribute(paramName+i,paramValues[i]);       
          out.println("<LI>" + paramValues[i]);
        } 
        out.println("</UL>");
      }
    }
	
	
	
	
	/*************************************/




// the line is insignificant.

	String callback="https://sbose78.appspot.com/insertBlogger.jsp?oauth_token_secret="+java.net.URLEncoder.encode(oauthParameters.getOAuthTokenSecret(), "UTF-8");
	
	oauthParameters.setOAuthCallback(callback);

    String requestUrl = oauthHelper.createUserAuthorizationUrl(oauthParameters);
    out.println("<br>CLICK TO CONTINUE: ---  <a href='"+requestUrl+"'>"+requestUrl+"</a>");
	
	
	
%>
