

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.google.appengine.api.labs.taskqueue.Queue"%>
<%@ page import="com.google.appengine.api.labs.taskqueue.QueueFactory"%>

<%@ page import="static com.google.appengine.api.labs.taskqueue.TaskOptions.Builder.*"%>
   
<html>   
   
<body>	



 <table>
 
  <tr> <H3>

	<td align="middle" width="300"><a href="/home.jsp">HOME</a></td>
	<td align="middle" width="300"><a href="/showFood.jsp">SHOW FOOD ITEMS IN THE DATABASE</a> </td>
	<td align="middle" width="300"><a href="/submitManager.jsp">TRANSFER OF DUTY</a> </td>
	<td align="middle" width="300"><a href="/showManager.jsp">SHOW ALL MANAGER PARTNERSHIPS</a> </td>
	
   </H3></tr>	
 
 
</table>

   
    
 <%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();   
%>
    
    <%
if( user !=null)
{
%>
	
			
			
	<form name="form1" action="/insertManager.jsp" method="post">
		<H2 align="middle"><BR> ADMINISTRATION  </H2><BR>
		
		<br>
	<table>	
	<tr> <td width="500"></td> 	<td>MANAGER 1:<input NAME="item" type="text"  value=""><BR><br> </td> </tr>
	
	<tr> <td width="500"></td> 	<td>MANAGER 2:<input NAME="comments" type="text"  value=""><BR><br> </td> </tr>
	<tr> <td width="500"></td>	<td>JUNIOUR MANAGER<input NAME="price" type="text" value=""><BR><br> </td></tr>
	<tr> <td width="500"></td>	<td><input NAME="enter" type="submit" value="FINALISE NEW SESSION"><BR><br>
		
	</table>	
		  
	</form>			
    
 <%
//		 Queue queue = QueueFactory.getDefaultQueue(); 
	//	 queue.add(url("/email-queue-send.jsp").param("emailid","sbose78@gmail.com").param("subject","NSEC CSE PORTAL").param("content",user.getEmail()+" SIGNED IN"));

%>		  
		  
		  
       
		<p align="center" >Hello!
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">SIGN OUT</a> </p>
		  <br>
		   


<%


 }
else
{
%>
	<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">SIGN IN USING YOUR GOOGLE ACCOUNT</a>
 
 <%  
 }
 %>
 
 
	
</body>

</html>
