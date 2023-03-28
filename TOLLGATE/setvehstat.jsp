<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno,dor,rmks,stat;
vregno=rmks=dor=stat="";
%>

<%


try
{
vregno=request.getParameter("vregno");
rmks=request.getParameter("rmks");
dor=request.getParameter("dor");
stat=request.getParameter("r1");

Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor from regdvehs where vregno='" + vregno + "'");
out.println("<h3>VEHICLE INFO</h3><hr>");
if(rs.next())
{
rs.close();
if(stat.equals("Stop"))
{
stmt.executeUpdate("insert into crimeveh values('" + vregno + "','" + dor + "','" + rmks + "','-','-')");
out.println("<b>Vehicle Status set to Stop!");
}
else
{
stmt.executeUpdate("delete from crimeveh where vregno='" + vregno + "'");
out.println("<b>Vehicle Allowed!");
}
}
else
out.println("<b>Check Vehicle Reg.No exists!");
con.close();
}
catch(Exception ee)
{
out.println("<b>Check Vehicle Reg.No exists!");
}

%>