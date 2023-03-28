<%@ page import="java.sql.*" %>
<%
Connection con;
Statement stmt;
ResultSet rs;
String tuid,tname;
%>
<%
try{
tuid=(String)session.getAttribute("suid");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
stmt=con.createStatement();
rs=stmt.executeQuery("select crname from crime where crid='" + tuid + "'");
if(rs.next())
{
out.println("Welcome Crime Operator,<b><font color=red>" + rs.getString(1) + "</b><hr>");
out.println("<a href='setvehstat.html' target='main'>Set Vehicle Status</a><br>");
out.println("<a href='viewvehstat.html' target='main'>View Vehicle Crime Status</a><br>");
out.println("<a href='monitorveh.html' target='main'>Monitor vehicle</a><br>");
out.println("<a href='index.html' target='_top'>Logout</a>");
}
con.close();
}
catch(Exception ee)
{
out.println("Error -->" + ee.getMessage());
}
%>