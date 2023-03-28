<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
String r1="";
String tuid="";
int fg=0;
int ntp=0;
String sr1="";
%>

<%
try
{
tuid=(String)session.getAttribute("suid");
vregno=request.getParameter("vregno");
session.setAttribute("svregno",vregno);
r1=request.getParameter("r1");
if(r1.equals("2"))
{
session.setAttribute("sr1","Regn No");
sr1="Regn No";
}
else
{
session.setAttribute("sr1","Toll Pass");
sr1="Toll Pass";
}
//out.println(r1);

Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
rs=stmt.executeQuery("select tollid,location,vid,dot,tim,dir from attendance,tollopr where passtype='" + sr1 + "' and tollopr.usid=attendance.tollid and vid='" + vregno + "'");
out.println("<h3>MONITOR VEHICLE TRANSITS</h3><hr>");
out.println("<table border><tr><td><b>Toll Name</td><td><b>" + sr1 +"</td><td><b>Date</td><td><b>Time</td><td><b>Direction</td></tr>");
while(rs.next())
{
out.println("<tr><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5) + "</td><td>" + rs.getString(6)  + "</td></tr>");
}

con.close();
}
catch(Exception ee)
{
out.println("<b>Route with this ID already exists!" + ee.getMessage());
}

%>