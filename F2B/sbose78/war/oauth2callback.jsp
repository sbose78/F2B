
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>

<HTML>
<body>

Yeah.. here we are !

<%
 
 
 
 String code=request.getParameter("code");
 
 String authtok_uri="https://accounts.google.com/o/oauth2/token";
 String secret="2JqJG7um_BSEGSkqhjq-ksBL";
 String client_id="857748051873.apps.googleusercontent.com";
 
 String url2="https://accounts.google.com/o/oauth2/token?grant_type=authorization_code&client_id="+client_id+"&client_secret="+secret+
 "&redirect_uri=https://sbose78.appspot.com/auth2.jsp"+"&code="+code;
 
 /*
 try {
    // Construct data
    String data = URLEncoder.encode("client_id", "UTF-8") + "=" + URLEncoder.encode(client_id, "UTF-8");
    data += "&" + URLEncoder.encode("client_secret", "UTF-8") + "=" + URLEncoder.encode(secret, "UTF-8");
	data += "&" + URLEncoder.encode("grant_type", "UTF-8") + "=" + URLEncoder.encode("authorization_code", "UTF-8");
	data += "&" + URLEncoder.encode("redirect_uri", "UTF-8") + "=" + URLEncoder.encode("https://sbose78.appspot.com/auth2.jsp", "UTF-8");
	data += "&" + URLEncoder.encode("code", "UTF-8") + "=" + URLEncoder.encode(code, "UTF-8");
	 
	

    // Send data
    URL url = new URL("https://accounts.google.com/o/oauth2/token");
    URLConnection conn = url.openConnection();
    conn.setDoOutput(true);
	
	
	
	conn.setRequestProperty("Host","accounts.google.com");
	conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
	
	
    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
    wr.write(data);
    wr.flush();

    // Get the response
    BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    String line;
    while ((line = rd.readLine()) != null) {
        out.println(line);
    }
    wr.close();
    rd.close();
} 
catch (Exception e) 
{
}

*/


 %>
 
 
<form method="post"   action="<%=authtok_uri%>" >

<input name="client_id" value="<%=client_id%>"><br>
<input name="client_secret" value="<%=secret%>"><br>
<input name="code" value="<%=code%>"><br>
<input name="grant_type" value="authorization_code"><br>
<input name="redirect_uri" value="https://sbose78.appspot.com/auth2.jsp"><br>
<br>
<input type="submit"><br>



</form> 
 
 <br>
 <a href="<%=url2%>"><%=url2%></a>



</body>


</html>