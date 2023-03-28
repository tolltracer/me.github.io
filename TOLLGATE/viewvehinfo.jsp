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
rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor,pic from regdvehs where vregno='" + vregno + "'");
out.println("<h3>VEHICLE INFO</h3><hr>");
out.println("<table border><tr><td><b>Owner Name</td><td><b>Owner Address</td><td><b>Contact No</td><td><b>Manufacturer</td><td><b>Vehicle</td><td><b>Vehicle Type</td><td><b>Regn.Date</td><td><b>Image</td></tr>");
int flag=0;
if(rs.next())
{
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td><td><img src='pics/" + rs.getString(8) + "' width=100 height=100></td></tr>");
flag=1;
}
out.println("</table>");
if(flag==0)
out.println("<b>This vehicle <u><font color=red>" + vregno + "</u></font> does not exist!");
con.close();
}
catch(Exception ee)
{
out.println("<b>Route with this ID already exists!");
}

%>