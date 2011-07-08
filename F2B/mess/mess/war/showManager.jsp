<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script><script type="text/javascript">stLight.options({publisher:'cb1802af-537a-4be8-96c4-abfea7b3b89c'});</script>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="mess.Manager" %>
<%@ page import="mess.PMF" %>

<html>



 <table>
 
  <tr> 
  <H3>

	<td align="middle" width="300"><a href="/home.jsp">HOME</a></td>
	<td align="middle" width="300"><a href="/showFood.jsp">SHOW FOOD ITEMS IN THE DATABASE</a> </td>
	<td align="middle" width="300"><a href="/submitManager.jsp">TRANSFER OF DUTY</a> </td>
	<td align="middle" width="300"><a href="/showManager.jsp">SHOW ALL MANAGER PARTNERSHIPS</a> </td>
	<td align="middle" width="300"><a href="/submitFood.jsp">SUBMIT SHOPPING DETAILS</a> </td>
	
   </H3></tr>	
 
 </table>	
	
  
  <body> 
  <br><br>
  <span class="st_twitter_large" displayText="Tweet"></span><span class="st_facebook_large" displayText="Facebook"></span><span class="st_ybuzz_large" displayText="Yahoo! Buzz"></span><span class="st_gbuzz_large" displayText="Google Buzz"></span><span class="st_email_large" displayText="Email"></span><span class="st_sharethis_large" displayText="ShareThis"></span>

<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
%>
<p>Hello, <%= user.getNickname() %>! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    
	
		
%>

<%
    PersistenceManager pm = PMF.get().getPersistenceManager();
    String query = "select from " + Manager.class.getName()+" order by date desc"  ;
    List<Manager> manager = (List<Manager>) pm.newQuery(query).execute();
    if (manager.isEmpty()) {
%>
<p> NONE IN DATABASE</p>

<%
    } 
	else
	{
	
%>

<table frame="box" width="1200">

  <tr>
    <th align="left">MANAGER 1</th>
    <th align="left">MANAGER 2</th>
    <th align="left">JR.MANAGER </th>
	<th align="left">DATE OF COMMENCEMENT</th>
  </tr>

  <%
        for (Manager f : manager)
		{
%>
<tr>
    <td align="left"><%= f.getMan1() %></td>
	<td align="left"><%= f.getMan2()%></td>
    <td align="left"><%=f.getMan3() %> </td>
    <td align="left"><%= f.getDate() %></td>
	
</tr>
<%
        }
    }	
    pm.close();
%> </table>

<%	
  }
  else
  {
%>
		<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">SIGN IN USING YOUR GOOGLE ACCOUNT</a>
<%	
  }	
%>
<br>
 
	</body>
</html>