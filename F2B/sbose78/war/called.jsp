
<HTML>
<body>

Yeah.. here we are !

<%


String client_id="857748051873.apps.googleusercontent.com";
String callback="https://sbose78.appspot.com/oauth2callback.jsp";

String url="https://accounts.google.com/o/oauth2/auth?client_id="+client_id+"&redirect_uri="+callback+"&scope=https://www.google.com/calendar/feeds/&response_type=code";

response.sendRedirect(url);

%>

</body>


</html>