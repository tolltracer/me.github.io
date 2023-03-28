<%@ page import="java.sql.*" %>
<%
Connection con;
Statement stmt;
ResultSet rs;
String tuid,tpwd,tut;

%>

<%
rs=null;
tuid=request.getParameter("uid");
tpwd=request.getParameter("pwd");
tut=request.getParameter("utype");
try{
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
stmt=con.createStatement();

if(tut.equals("RTA"))
rs=stmt.executeQuery("select * from rta where usid='" + tuid + "' and pswd='" + tpwd + "'");
else
if(tut.equals("Toll Operator"))
rs=stmt.executeQuery("select * from tollopr where usid='" + tuid + "' and pswd='" + tpwd + "'");
else
if(tut.equals("Crime Dept"))
rs=stmt.executeQuery("select * from crime where crid='" + tuid + "' and crpwd='" + tpwd + "'");
else
if(tut.equals("Customer"))
rs=stmt.executeQuery("select * from regdvehs where vregno='" + tuid + "' and cno='" + tpwd + "'");


if(rs.next())
{
session.setAttribute("suid",tuid); // creates session with user id as value
if(tut.equals("RTA"))
response.sendRedirect("rtaoptions.jsp");
else
if(tut.equals("Toll Operator"))
response.sendRedirect("tooptions.jsp");
else
if(tut.equals("Crime Dept"))
response.sendRedirect("croptions.jsp");
else
if(tut.equals("Customer"))
response.sendRedirect("cuoptions.jsp");
}
else
{
out.println("Check User Info!<br> To try again <a href='left.html'><b>Click</b></a> here.<br><br><img src='pics/ip1.jpg' width=250 height=150>");
}
con.close();
}
catch(Exception ee)
{
out.println("Error -->" + ee.getMessage());
}
%>