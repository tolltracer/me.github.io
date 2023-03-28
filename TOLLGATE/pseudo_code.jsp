//Pseudocode to initiate the request by the crime dept to sieze or allow the vehicle
// Import the package java.sql to enable usage of classes and methods for database connectivity
<%@ page import="java.sql.*" %>
<%
// Declare objects needed to connect to the database
Connection con;
ResultSet rs=null;
String vregno,dor,rmks,stat;
vregno=rmks=dor=stat="";
%>

<%
try
{
// Retrieve the parameters that indicate the vehicle regn no, date on which request placed, remarks and status
vregno=request.getParameter("vregno");
rmks=request.getParameter("rmks");
dor=request.getParameter("dor");
stat=request.getParameter("r1");
// Load the Oracle driver (thin) for communication
Class.forName("oracle.jdbc.driver.OracleDriver");
//Establish connection with the oracle database instance
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
// Fetch details of the owner and the vehicle for the specified vehicle regn no
rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor from regdvehs where vregno='" + vregno + "'");
//Display the fetched details
out.println("<h3>VEHICLE INFO</h3><hr>");
if(rs.next())
{
rs.close();
//If the status is to Stop then the record is inserted into the crimeveh table
if(stat.equals("Stop"))
{
stmt.executeUpdate("insert into crimeveh values('" + vregno + "','" + dor + "','" + rmks + "','-','-')");
out.println("<b>Vehicle Status set to Stop!");
}
else
{
//If the status is to Allow then the record is deleted from the crimeveh table
stmt.executeUpdate("delete from crimeveh where vregno='" + vregno + "'");
out.println("<b>Vehicle Allowed!");
}
}
con.close();
}
catch(Exception ee)
{
out.println("<b>Check Vehicle Reg.No exists!");
}

%>