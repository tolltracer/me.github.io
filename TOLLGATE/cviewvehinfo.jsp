<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
%>

<%


try
{
vregno=(String)session.getAttribute("suid");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt from regdvehs,tollpass where regdvehs.vregno='" + vregno + "' and regdvehs.vregno=tollpass.vregno");
out.println("<h3>VEHICLE INFO</h3><hr>");
out.println("Vehicle Number : <b>" + vregno + "<br><br>");
out.println("<table border><tr><td><b>Owner Name</td><td><b>Owner Address</td><td><b>Contact No</td><td><b>Manufacturer</td><td><b>Vehicle</td><td><b>Vehicle Type</td><td><b>Regn.Date</td><td><b>Toll Pass</td><td><b>Amount</td></tr>");
while(rs.next())
{
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td><td>" + rs.getString(8)  + "</td><td>" + rs.getString(9) + "</td></tr>");
}
rs.close();
out.println("</table><p><a href='printpass.jsp' target='prn'> Print Pass </a>"); 
con.close();
}
catch(Exception ee)
{
out.println("<b>Route with this ID already exists!" + ee.getMessage());
}

%>