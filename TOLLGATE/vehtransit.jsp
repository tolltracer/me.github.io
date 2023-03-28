<%@ page import="java.sql.*" %>
<%
Connection con;
ResultSet rs=null;
String vregno="";
String r1="";
String tuid="";
int fg=0;
int ntp=0;
java.util.Date dt=new java.util.Date();
String today=dt.getDate() + "/" + (dt.getMonth()+1) + "/" + (dt.getYear()+1900);
%>

<%
try
{
tuid=(String)session.getAttribute("suid");
vregno=request.getParameter("vregno");
session.setAttribute("svregno",vregno);
r1=request.getParameter("r1");
if(r1.equals("2"))
session.setAttribute("sr1","Regn No");
else
session.setAttribute("sr1","Toll Pass");
//out.println(r1);

Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();
out.println("<h3>VEHICLE INFO</h3><hr><script> function computefare(){ if(document.forms[0].j1[0].checked==true) f.fare.value=50; else f.fare.value=100; } </script><form name=f method=post action='vehtransit2.jsp'>");
out.println("Vehicle ID : <b>" + vregno + "<br></b>Date : " + new java.util.Date() +"<br>");
out.println("<table border><tr><td><b>Owner Name</td><td><b>Owner Address</td><td><b>Contact No</td><td><b>Manufacturer</td><td><b>Vehicle</td><td><b>Vehicle Type</td><td><b>Regn.Date</td><td><b>Toll Pass</td><td><b>Amount</td><td><b>Engine No</td><td><b>Chasis No</td></tr>");
//out.println("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt from regdvehs,tollpass where regdvehs.vregno='" + vregno + "' and regdvehs.vregno=tollpass.vregno");
if(r1.equals("2"))
{
 rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt,eno,chno from regdvehs,tollpass where  regdvehs.vregno='" + vregno + "' and regdvehs.vregno=tollpass.vregno");
   if(rs.next()){
	out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td><td>" + rs.getString(8)  + "</td><td>" + rs.getString(9) + "</td><td>" + rs.getString(10) + "</td><td>" + rs.getString(11)+ "</td></tr>");
fg=1;
    }
   else
    {
       rs.close();
       rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt,eno,chno from regdvehs,tollpass where  regdvehs.vregno='" + vregno + "'");
	if(rs.next())
	{
out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td><td>-</td><td>-</td>" + "</td><td>" + rs.getString(10) + "</td><td>" + rs.getString(11) + "</tr>");
ntp=1;
fg=1;
	}
	else
	out.println("<B><FONT COLOR=RED>FAKE NUMBER PLATE</font></b>");
    }
}
else
{
//out.println("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt,regdvehs.vregno from regdvehs,tollpass where  tollpass.tpassid=" + vregno );
 rs=stmt.executeQuery("select oname,oaddr,cno,manf,vname,vtype,dor,tpassid,depamt,eno,chno,regdvehs.vregno from regdvehs,tollpass where  tollpass.tpassid=" + vregno + " and regdvehs.vregno=tollpass.vregno" );
 if(rs.next())
 {

 out.println("<tr><td><b>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5)  + "</td><td>" + rs.getString(6)  + "</td><td>" + rs.getString(7) + "</td><td>" + rs.getString(8)  + "</td><td>" + rs.getString(9) + "</td><td>" + rs.getString(10) + "</td><td>" + rs.getString(11)  + "</td></tr>");
fg=1;
vregno=rs.getString(12);
//}
 }
 else
 {
 out.println("<B><FONT COLOR=RED>FAKE TOLL PASS</font></b>");
 }
}
rs.close();
out.println("</table><br>");

if(fg==1)
{
out.println(vregno);
rs=stmt.executeQuery("select * from crimeveh where vregno='" + vregno + "'");
if(rs.next()){
out.println("<b><Font color=red>SIEZE VEHICLE</font></b>");
rs.close();
stmt.executeUpdate("update crimeveh set docap='" + today + "',toprid='" + tuid + "' where vregno='" + vregno + "'");
}
else
{
out.println("<table><tr><td>Direction</td><td><select name=dir><option>North</option><option>South</option><option>East</option><option>West</option></select></td></tr>");
out.println("<tr><td>Journey </td><td>Uni <input type=radio name=j1 value=1 checked onClick='computefare()'> Bi <input type=radio name=j1 value=2 onClick='computefare()'></td></tr>");
out.println("<tr> <td>Fare</td><td><input type=text name=fare value='50'></td></tr>");
out.println("</table><input type=submit value='Allow Vehicle'></form>");

if(ntp==1)
out.println("<b>Payment through <font color=red>CASH</font>");

out.println("</form>");
}
}

con.close();
}
catch(Exception ee)
{
out.println("<b>Route1 with this ID already exists!" + ee.getMessage());
}

%>