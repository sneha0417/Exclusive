<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%              
String userid=request.getParameter("userid")==null?"0":request.getParameter("userid");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno"); 
int val=0;   
Connection conn=null;
try{          
	ClsConnection objconn=new ClsConnection();  
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	String strsql="";
	
	strsql="update rl_tncm set handbackuser='"+userid+"' where doc_no='"+docno+"'";
    val=stmt.executeUpdate(strsql);
	//System.out.println(val+"---->>>"+strsql);  
}   
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);   

%>