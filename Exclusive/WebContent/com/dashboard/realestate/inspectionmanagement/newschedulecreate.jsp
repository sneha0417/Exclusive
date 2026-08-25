<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
 
<%

String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno");
String insdate=request.getParameter("insdate")==null || request.getParameter("insdate")==""?"":request.getParameter("insdate");

ClsCommon ClsCommon = new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int val=0;
try{
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement st=conn.createStatement();
	Statement st1=conn.createStatement();
	int insertval=0,updateval=0;
	java.sql.Date sqlinsdate = null; 
	String qry = "";
	  
	
	if(!(insdate.equalsIgnoreCase("undefined"))&&!(insdate.equalsIgnoreCase(""))&&!(insdate.equalsIgnoreCase("0"))){
		sqlinsdate=ClsCommon.changeStringtoSqlDate(insdate);       
    }
	    
	String strsql="insert into rl_scheduled (pdocno,date,userId,insdate) values('"+docno+"',now(),'"+userid+"','"+sqlinsdate+"') ";
	insertval=st.executeUpdate(strsql);
	 
	String strsql1="update rl_propertymaster set ins_date='"+sqlinsdate+"'  where doc_no="+docno+"";    
	updateval=st1.executeUpdate(strsql1); 
	  
	if(insertval>0 && updateval>0){ 
		val=1;
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);        
%>