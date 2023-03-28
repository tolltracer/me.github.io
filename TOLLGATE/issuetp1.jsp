<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
int depamt=0;
int ntpid=1;
Statement stmt=null;
%>

<%


try
{
vregno=request.getParameter("vregno");
depamt=Integer.parseInt(request.getParameter("depamt"));
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
stmt=con.createStatement();
rs=stmt.executeQuery("select max(tpassid) from tollpass");
out.println("<h3>ISSUE TOLL PASS</h3><hr>");
try{
if(rs.next())
{
ntpid=rs.getInt(1)+1;
}
}
catch(Exception e2)
{
ntpid=1;
}
rs.close();
if(depamt>0)
{
stmt.executeUpdate("insert into tollpass values('" + vregno + "'," + ntpid + "," + depamt + ")" );
out.println("<b>Pass Issued with ID No." + ntpid + " to vehicle " + vregno);
}
else
out.println("<b>Amount should be positive integer > 0");
con.close();
}
catch(Exception ee)
{
stmt.executeUpdate("update tollpass set depamt=depamt+" + depamt + " where vregno='" + vregno +"'");
out.println("<b>Account already exists! Amount added." );
}

%>