<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String scity,dcity,btype,doj,bno;
doj=scity=dcity=btype=bno="";
int cost=0;
String pnr="";
int fg=0;
%>

<%


try
{
pnr=request.getParameter("pnrno");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
rs=stmt.executeQuery("select * from pnrsrcdest where pnr=" + pnr);
if(rs.next())
{

out.println("<h3>VIEW BUS TICKET</h3><hr>");
out.println("<table border><tr><td><b>PNR No.</td><td>" + pnr + "</td></tr>");
out.println("<tr><td><b>Source City</td><td>" + rs.getString(2) + "</td></tr>");
out.println("<tr><td><b>Destination City</td><td>" + rs.getString(3) + "</td></tr>");
out.println("<tr><td><b>Date of Journey</td><td>" + rs.getString(4) + "</td></tr>");
out.println("<tr><td><b>Number of Tickets</td><td>" + rs.getString(5) + "</td></tr>");
bno=rs.getString(6);
out.println("<tr><td><b>Bus No</td><td>" + bno + "</td></tr>");
out.println("<tr><td><b>Bus Type</td><td>" + rs.getString(7) + "</td></tr></table><br>");
fg=1;
}
rs.close();

if(fg==1)
{
rs=stmt.executeQuery("select cost from bus where bno='" + bno + "'");
if(rs.next())
cost=rs.getInt(1);
rs.close();

out.println("<table border><tr><td>Traveller Name</td><td>Age</td><td>Gender</td><td>Seats</td></tr>");
rs=stmt.executeQuery("select * from pnrtrav where pnr=" + pnr);
if(rs.next())
{
String []tnames=rs.getString(2).split(",");
String []tage=rs.getString(3).split(",");
String []tgend=rs.getString(4).split(",");
String []tsns=rs.getString(6).split(",");
for(int k=0;k<=tnames.length-1;k++)
{
out.println("<tr><td>" + tnames[k] + "</td><td>" + tage[k] + "</td><td>" + tgend[k]  + "</td><td>" + tsns[k] + "</td></tr>");
}
out.println("</table>");
out.println("<br>Total Fare " + (tnames.length)*cost);
}
rs.close();
}
else
out.println("<h3>VIEW BUS TICKET</h3><hr><B>Check PNR No.");
con.close();
}
catch(Exception ee)
{
out.println("<b>Check PNR.No!" + ee.getMessage() );
}

%>