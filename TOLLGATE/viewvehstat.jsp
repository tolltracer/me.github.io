<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
%>

<%


try
{
vregno=request.getParameter("vregno");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
rs=stmt.executeQuery("select * from crimeveh where vregno='" + vregno + "'");
out.println("<h3>VIEW VEHICLE CRIME STATUS</h3><hr>");
out.println("<table border><tr><td><b>Regn.No</td><td><b>Posted On</td><td><b>Remarks</td><td><b>Captured On</td><td><b>Toll Gate</td></tr>");
while(rs.next())
{
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td></tr>");
}
con.close();
}
catch(Exception ee)
{
out.println("<b>Check ID exists!");
}

%>