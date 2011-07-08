

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
   
   <H1 align="middle">THE FOOD ACCOUNTS PORTAL </H1>
   



 <table>
 
  <tr> <H3>

	<td align="middle" width="300"><a href="/home.jsp">HOME</a></td>
	<td align="middle" width="300"><a href="/showFood.jsp">SHOW FOOD ITEMS IN THE DATABASE</a> </td>
	<td align="middle" width="300"><a href="/submitManager.jsp">TRANSFER OF DUTY</a> </td>
	<td align="middle" width="300"><a href="/showManager.jsp">SHOW ALL MANAGER PARTNERSHIPS</a> </td>
	
   </H3></tr>	
 
 
</table>

	
<body>	
   
    
 <%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();   
%>
    
	
	<H2>		<p align="center" ><a href="/submitFood.jsp">SUBMIT 'SHOPPING' DETAILS</a>  </p>   </H2> 						
    
 <%
//		 Queue queue = QueueFactory.getDefaultQueue(); 
	//	 queue.add(url("/email-queue-send.jsp").param("emailid","sbose78@gmail.com").param("subject","NSEC CSE PORTAL").param("content",user.getEmail()+" SIGNED IN"));

		  
		  
 if(user != null)     {
%> 
		<p align="left" >Hello!
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">SIGN OUT</a> </p>
		  <br>

<% } %>


	
</body>

</html>
