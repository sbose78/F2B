<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script><script type="text/javascript">stLight.options({publisher:'cb1802af-537a-4be8-96c4-abfea7b3b89c'});</script>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="mess.Food" %>
<%@ page import="mess.Manager" %>
<%@ page import="mess.PMF" %>
<%@ page import="javax.jdo.Query" %>

<html>

 <table>
 
  <tr>

	
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
	
 </tr>	
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
	
	String query1 = "select from " + Manager.class.getName()+" order by date desc" ;
	Query q = pm.newQuery(query1);
		
	q.setRange(0,1);
	List<Manager> man = (List<Manager>) q.execute();  
	
	double sum=0;
	String man1="";
	String man2="";
	String man3="";
	
	for (Manager f : man){
		man1=f.getMan1() ; man2=f.getMan2() ; man3=f.getMan3() ; 
	}
	
    String query = "select from " + Food.class.getName()+" order by date desc"  ;
	
    List<Food> food = (List<Food>) pm.newQuery(query).execute();
	
	if (food.isEmpty()) {
%>
<p> NO FOOD IN DATABASE</p>

<%
    } 
	else
	{
	
%>

MANAGERS: <H3><%= man1%>,<%= man2%>,<%= man3 %>  </H3>


<table frame="box" width="1200">

  <tr>
    <th align="left">FOOD ITEM</th>
    <th align="left">REMARKS</th>
    <th align="left">PRICE</th>
	<th align="left">DATE</th>
  </tr>

  <%
        for (Food f : food)
		{   	sum+=f.getPrice();
%>
<tr>
    <td align="left"><%= f.getItem() %></td>
	<td align="left"><%= f.getComments()%></td>
    <td align="left"><%=f.getPrice() %> </td>
    <td align="left"><%= f.getDate() %></td>
	
</tr>

<%
        }
    }	
    pm.close();
%>

<tr>

	<td align="left"><H3>TOTAL EXPENDITURE</H3></td>
	<td align="left"></td>
    <td align="left"><H3><%= sum %></H3> </td>
    <td align="left"></td>

</tr>

<tr>

	<td align="left"><H3>ACTUAL AMOUNT REMAINING( TOTAL BUDGET - EXPENDITURE - COOK'S WAGES) </H3></td>
	<td align="left"></td>
	<% double rem = 18000 - sum - 2400 ;
	
	%>
	
    <td align="left"><H3> <%= rem %> </H3> </td>
    <td align="left"></td>

</tr>




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