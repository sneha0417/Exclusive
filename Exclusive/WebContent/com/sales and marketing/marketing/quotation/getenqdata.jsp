 


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
String msdocno = request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
Connection conn = null;
try
{
int method=0;	ClsConnection ClsConnection=new ClsConnection();
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select if(m.cltype=0,m.clientid,0) clientid,m.doc_no,m.voc_no,if(m.cltype=0,a.refname,'') clients, "+
 " if(m.cltype=0,a.address,'') address from my_cusenqm m left join my_acbook a on a.cldocno=m.clientid and a.dtype='CRM' where m.doc_no='"+msdocno+"' ";

System.out.println("===chk==="+chk);

ResultSet rs=stmt.executeQuery(chk); 
int clientid=0;
int doc_no=0;
int voc_no=0;

String clientname="";
String address="";
if(rs.next())
{
	clientid=rs.getInt("clientid");
	doc_no=rs.getInt("doc_no");
	voc_no=rs.getInt("voc_no");
	clientname=rs.getString("clients");
	address=rs.getString("address");
}




   
	response.getWriter().print(clientid+"##"+doc_no+"##"+voc_no+"##"+clientname+"##"+address);
	stmt.close();
	conn.close();
}
catch (Exception e)
{
	e.printStackTrace();
	conn.close();
	
}
	
	
  %>
  









 