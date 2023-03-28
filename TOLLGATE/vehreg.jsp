<%@ page import="java.sql.*" %>

<%
String tregno,toname,taddr,tcno,tdor,temail,tvname,tmanf,teno,tvchno,tvtype,timgname;  
Connection con;
%>

<%
toname=request.getParameter("oname");
tvname=request.getParameter("vname");
taddr=request.getParameter("oaddr");

tdor=request.getParameter("dor");
tcno=request.getParameter("ocno");
temail=request.getParameter("oemail");

tmanf=request.getParameter("vmanf");
tvtype=request.getParameter("vtype");

teno=request.getParameter("veno");
tvchno=request.getParameter("vchno");

tregno=request.getParameter("vrno");
timgname=request.getParameter("imgname");
//out.println("aaaabd");
try
{

if(toname.equals("") || tvname.equals("") || temail.equals("") || taddr.equals("") || tdor.equals("") || tcno.equals("") || tmanf.equals("") || tvtype.equals("") || teno.equals("") || tvchno.equals("") || tregno.equals(""))
out.println("<b>All fields are mandatory!");
else
{

//out.println("Called from register.htm");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","tgate","tgate");
Statement stmt=con.createStatement();


//out.println("insert into regdvehs values('" + tregno + "','" + toname + "','" + tdor + "','" + taddr + "','" + tcno + "','" + temail + "','" + tmanf + "','" +  tvname + "','" + tvtype + "','" + teno + "','" + tvchno + "')");

stmt.executeUpdate("insert into regdvehs values('" + tregno + "','" + toname + "','" + tdor + "','" + taddr + "','" + tcno + "','" + temail + "','" + tmanf + "','" +  tvname + "','" + tvtype + "','" + teno + "','" + tvchno + "','"+ timgname +"' )");

out.println("<h3>VEHICLE REGISTRATION STATUS</h3><hr><br>Success! Vehicle Registered." );

con.close();
}
}
catch(Exception ee)
{

out.println("<b>Traveller with this ID already exists!" + ee.getMessage());
}

%>