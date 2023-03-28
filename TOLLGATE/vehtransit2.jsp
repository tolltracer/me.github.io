<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
String r1="";
String tuid="";
int fg=0;
int ntp=0;
String fare="";
String dir="";
String jrn="";
java.util.Date dt=new java.util.Date();
String today=dt.getDate() + "/" + (dt.getMonth()+1) + "/" + (dt.getYear()+1900);
String tim=dt.getHours() + ":" + (dt.getMinutes()) + ":" + (dt.getSeconds());
%>

<%
try
{
String j1=request.getParameter("j1");
tuid=(String)session.getAttribute("suid");
vregno=(String)session.getAttribute("svregno");
r1=(String)session.getAttribute("sr1");
fare=request.getParameter("fare");
dir=request.getParameter("dir");
if(j1.equals("1"))
jrn="Uni";
else
jrn="Bi";

//out.println(r1);

Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
out.println("<h3>VEHICLE INFO</h3><hr>");
//out.println(tuid + ":" + vregno + ":" + r1 + ":" + fare + ":" + dir + ":" + today + ":" + jrn + ":" + tim);
stmt.executeUpdate("insert into attendance values('" + tuid +"','" + vregno + "','" + r1 + "','" + today + "','" + tim + "','" + dir + "','" + jrn + "'," + fare + ")");
//out.println(r1 + ":" + "update tollpass set depamt=depamt-" + fare + " where tpassid=" + vregno );
if(r1.equals("Toll Pass")){

int stat=stmt.executeUpdate("update tollpass set depamt=depamt - " + fare + " where tpassid=" + vregno + " and depamt>=" + fare);
out.println(stat);
if(stat>0)
out.println("<b>Amount Deducted!");
else
out.println("<b>Insufficient Balance ! Collect Cash");
}
out.println("<br><b>Attendance Marked. vehicle allowed to travel.");
con.close();
}
catch(Exception ee)
{
out.println("<b>Route with this ID already exists!" + ee.getMessage());
}

%>