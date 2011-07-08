<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="mess.Manager" %>
<%@ page import="mess.PMF" %>
<html>
	<H1 align="center" color="BLUE">  <BIG>NETAJI SUBHASH ENGINEERING COLLEGE</BIG> </H1>   
	<H2 align="center">DEPARTMENT OF COMPUTER SCIENCE AND ENGINEERING <br><br><br> </H2>

	<body> 

<a href="/home.jsp">HOME</a><BR><br>

	
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		PersistenceManager pm = PMF.get().getPersistenceManager();

		String manager1 = request.getParameter("item");
		String manager2 = request.getParameter("comments");
		String manager3= request.getParameter("price");
		
		double exp=0;

		Date date = new Date();
        Manager man= new Manager(user,manager1,manager2,manager3,exp,date);
	
		
        try {
            pm.makePersistent(man);
        } finally {
            pm.close();
        }
%>


<BR> OR  <a href="/showManager.jsp">SHOW DATABASE</a> 
<br>
THE FOLLOWING DATA : 
<br><br>
MAN1---<%= manager1 %> <br>
MAN2---<%= manager2 %> <br>
MAN3---<%= manager3 %> 
<br><br>
HAS BEEN POSTED...
<br>

	</body>
</html>