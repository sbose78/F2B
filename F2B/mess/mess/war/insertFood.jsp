<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="mess.Food" %>
<%@ page import="mess.Manager" %>
<%@ page import="mess.PMF" %>
<%@ page import="javax.jdo.Query" %>

<html>
	
	<H2 align="center">THE FOOD PORTAL <i>007</i> ... licensed to eat ! <br><br><br> </H2>

	<body> 

<a href="/home.jsp">HOME</a><BR><br>


	
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		
		
	String query1 = "select from " + Manager.class.getName()+" order by date desc" ;
	Query q = pm.newQuery(query1);
		
	q.setRange(0,1);
	List<Manager> man = (List<Manager>) q.execute();  
	String code="";
	for (Manager f : man){
		code=(f.getDate()).toString() ;
	}
		
		String item = request.getParameter("item");
		String comments = request.getParameter("comments");
		double price= Double.parseDouble(request.getParameter("price"));

		Date date = new Date();
        Food food= new Food(user,comments,item,price,code,date);
	
		
        try {
            pm.makePersistent(food);
        } finally {
            pm.close();
        }
%>

<form  action="/submitFood.jsp" method="post" >       
	<div><input type="submit" value="CONTINUE TO INSERTING MORE DATA...." /></div>
</form>

<BR> OR  <a href="/showFood.jsp">SHOW FOOD ITEMS IN THE DATABASE</a> 
<br>
THE FOLLOWING DATA : 
<br><br>
MAN.CODE--<%= code %><br>
ITEM--<%= item %> <br>
REMARKS--<%= comments %> <br>
PRICE--<%= price %> 
<br><br>
HAS BEEN POSTED...
<br>

	</body>
</html>