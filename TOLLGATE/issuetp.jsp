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
rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor from regdvehs where vregno='" + vregno + "'");
out.println("<h3>ISSUE TOLL PASS</h3><hr>");

if(rs.next())
{
out.println("<form method=post action='issuetp1.jsp'><table border><tr><td>Vehicle registration No</td><td><input type=text name=vregno size=12 value='"+ vregno + "'</td></tr>");
out.println("<tr><td><b>Owner Name</td><td><b>Owner Address</td><td><b>Contact No</td><td><b>Manufacturer</td><td><b>Vehicle</td><td><b>Vehicle Type</td><td><b>Regn.Date</td></tr>");
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td></tr>");
out.println("<tr><td>Deposit Amount</td><td><input type=number name='depamt' size=5 min=100 max=2000></td></tr></table><br>");
out.println("<table><tr><td></td><td><input type=submit value='Issue Pass'></table></form>");
}
else
{
out.println("<b><font color=red>Check Registration No." + vregno);
}
con.close();
}
catch(Exception ee)
{
out.println("<b>Route with this ID already exists!");
}

%>