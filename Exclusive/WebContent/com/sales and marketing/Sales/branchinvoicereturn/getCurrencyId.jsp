<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	Connection conn =  null;try
{
	String dtype=session.getAttribute("Code").toString();
  String clientid=request.getParameter("clientid").trim().toString();
    //System.out.println("clientid="+clientid);
	String brch=session.getAttribute("BRANCHID").toString();
	String strSql ="";	ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String strSq = "select multiCur from win_tbldet where trtype='"+dtype+"'";
	ResultSet rs1 = stmt.executeQuery(strSq);
	int multi = 0;
	while(rs1.next()){
	multi = rs1.getInt("multiCur");
	}
	
	if(!(clientid.equals("")||clientid.equals("0"))){
		strSql="select c.doc_no,c.code,c.c_rate from my_acbook ac left join my_curr c on (ac.curid=c.doc_no and ac.dtype='CRM') where ac.doc_no="+clientid+" and c.status=3";
	}
	else{
		strSql = "select c.doc_no,code,c.c_rate from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'";
	}
	
	System.out.println("===strSql===="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String curid="";
	String curcode="";
	String currate="";
	while(rs.next()) {
		curid+=rs.getInt("doc_no")+",";
		curcode+=rs.getString("code")+",";
		currate+=rs.getString("c_rate")+",";
  		} 
	curid=curid.substring(0, curid.length()-1);
	curcode=curcode.substring(0, curcode.length()-1);
	currate=currate.substring(0, currate.length()-1);
	System.out.println(curid+"####"+curcode+"####"+currate+"####"+multi);
	response.getWriter().write(curid+"####"+curcode+"####"+currate+"####"+multi);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  
