

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
 
  <tr>

	<td align="middle" width="300"><a href="/home.jsp">HOME</a></td>
	<td align="middle" width="300"><a href="/showFood.jsp">SHOW FOOD ITEMS IN THE DATABASE</a> </td>
	<td align="middle" width="300"><a href="/submitManager.jsp">TRANSFER OF DUTY</a> </td>
	<td align="middle" width="300"><a href="/showManager.jsp">SHOW ALL MANAGER PARTNERSHIPS</a> </td>
	
 </tr>	
</table>	

   
    
 <%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();   
%>
    
    <%
if( user !=null)
{
%>
	
			
			
	<form name="form1" action="/insertFood.jsp" method="post">
		<H2 align="middle"><BR>SHOPPING DETAILS </H2><BR>
		
		<br>
	<table>	
	<tr> <td width="500"></td> 	<td>ITEM<input  NAME="item" type="text"  value=""><BR><br> </td> </tr>
	
	<tr> <td width="500"></td> 	<td>REMARKS<input NAME="comments" type="text"  value=""><BR><br> </td> </tr>
	<tr> <td width="500"></td>	<td>COST<input NAME="price" type="text" value="0">( INTEGER ONLY)<BR><br> </td></tr>
	<tr> <td width="500"></td>	<td>SUBMIT<input NAME="enter" type="submit" value="SUBMIT"><BR><br>
		
	</table>	
		  
	</form>			
    
 <%
//		 Queue queue = QueueFactory.getDefaultQueue(); 
	//	 queue.add(url("/email-queue-send.jsp").param("emailid","sbose78@gmail.com").param("subject","NSEC CSE PORTAL").param("content",user.getEmail()+" SIGNED IN"));

%>		  
		  
		  
       
		<p align="center" class="style2">Hello!
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
