<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
int result=0;
int errorstatus=0;
Connection conn=null;
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String propdocno = request.getParameter("propdocno")==null || request.getParameter("propdocno").equalsIgnoreCase("null")?"":request.getParameter("propdocno").trim();
try{
	ClsConnection objconn=new ClsConnection(); 
	ClsCommon objcommon =new ClsCommon();
	conn=objconn.getMyConnection();                   
	Statement stmt=conn.createStatement();
	
	String sql2="select doc from(select max(doc_no) doc from rl_tncm where handback=0 and prtype='"+propdocno+"' and status<>7 group by prtype)a where a.doc='"+docno+"'";     
	System.out.println("--------sql2----------"+sql2);     
	ResultSet rs12=stmt.executeQuery(sql2);      
	while(rs12.next()){
    	result=rs12.getInt("doc");     
    }
	if(result>0){
		errorstatus=1;    
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(errorstatus);
%>