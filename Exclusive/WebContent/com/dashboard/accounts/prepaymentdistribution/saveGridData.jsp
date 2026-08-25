<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement();
		 
		 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
		 String date=request.getParameter("date")==null?"0":request.getParameter("date");
		 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
		 String tranid=request.getParameter("tranid")==null?"0":request.getParameter("tranid");
		 String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");
		 String postacno=request.getParameter("postacno")==null?"0":request.getParameter("postacno");
		 String stdate=request.getParameter("stdate")==null?"0":request.getParameter("stdate");
		 String enddate=request.getParameter("enddate")==null?"0":request.getParameter("enddate");
		 String costtype=request.getParameter("costtype")==null?"0":request.getParameter("costtype");
		 String costcode=request.getParameter("costcode")==null?"0":request.getParameter("costcode");
		 String amount=request.getParameter("amount")==null?"0":request.getParameter("amount");
		 String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		 String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
		
		 java.sql.Date sqlDate=null;
		 java.sql.Date sqlStratDate=null;
		 java.sql.Date sqlEndDate=null;
		
		 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		 }
		 
		 if(!(stdate.equalsIgnoreCase("undefined"))&&!(stdate.equalsIgnoreCase(""))&&!(stdate.equalsIgnoreCase("0"))){
			 sqlStratDate=ClsCommon.changeStringtoSqlDate(stdate);
		 }
		 
		 if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
			 sqlEndDate=ClsCommon.changeStringtoSqlDate(enddate);
		 }
		
		 String sql=null;
		 int val=0,docNo=0;
	
		 if(mode.equalsIgnoreCase("E")) {
			 
			 /*Edit */
			 sql="select coalesce(max(rowno)+1,1) rowno from gl_bpd";
       		 ResultSet resultSet = stmt.executeQuery(sql);
  
        	 while (resultSet.next()) {
		   		docNo=resultSet.getInt("rowno");
        	 }
        	 
        	 sql="delete from gl_bpd where tranid='"+tranid+"'";
    		 val= stmt.executeUpdate(sql);
    		 
        	 sql="insert into gl_bpd(doc_no, dtype, date, tr_no, tranid, acno, postacno, stdate, enddate, costtype, costcode, amount, brhid, ebrhid, userid, status) values('"+docno+"', '"+dtype+"', '"+sqlDate+"', '"+trno+"', '"+tranid+"', '"+acno+"', '"+postacno+"', '"+sqlStratDate+"', '"+sqlEndDate+"', '"+costtype+"', '"+costcode+"', '"+amount+"', '"+brhid+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"', 3)";
    		 val= stmt.executeUpdate(sql);
    		 
	     	/*Edit Ends*/
	     	
		 } 
		 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BPD',now(),'"+session.getAttribute("USERID").toString()+"','"+mode+"')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
