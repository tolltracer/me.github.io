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
rs=stmt.executeQuery("select oname from regdvehs where vregno='" + tuid + "'");
if(rs.next())
{
out.println("Welcome Customer ,<b><font color=red>" + rs.getString(1) + "</b><hr>");
out.println("<a href='cviewvehinfo.jsp' target='main'>View Vehicle Info</a><br>");
out.println("<a href='index.html' target='_top'>Logout</a>");
}
con.close();
}
catch(Exception ee)
{
out.println("Error -->" + ee.getMessage());
}
%>