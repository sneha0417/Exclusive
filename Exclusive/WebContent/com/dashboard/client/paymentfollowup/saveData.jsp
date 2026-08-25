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
		
		String process=request.getParameter("process");
		String processname=request.getParameter("processname");
		String date=request.getParameter("date");
		String branchid=request.getParameter("branchid");
		String docno=request.getParameter("docno");
		String accountno=request.getParameter("accountno");
		String remarks=request.getParameter("remarks");
		String cldocno=request.getParameter("cldocno");

		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
        sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcpf";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
  
        if(processname.equalsIgnoreCase("Follow-Up")){
        	
		 /*Follow-Up */
	     sql="insert into gl_bcpf(doc_no, date, rdocno, acno, fdate, remarks, bibpid, brhid, userid) values("+docNo+", now(), '"+cldocno+"', '"+accountno+"', '"+sqlDate+"', '"+remarks+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql);
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCPF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 int data= stmt.executeUpdate(sql);
		 
        }
        
        else if(processname.equalsIgnoreCase("Dropped")){
	    
        /*Dropped */
		int followuprowno=0;
		sql="select rowno from gl_bibp where process='Follow-Up' and bibdid=(select doc_no from gl_bibd where description='Payment Followup')";
		ResultSet resultSet1 = stmt.executeQuery(sql);		    
		while (resultSet1.next()) {
			followuprowno=resultSet1.getInt("rowno");
		}
		
        sql="update gl_bcpf set status=7 where bibpid="+followuprowno+" and rdocno='"+cldocno+"'";
    	val= stmt.executeUpdate(sql);
    	sql="insert into gl_bcpf(doc_no, date, rdocno, acno, fdate, remarks, bibpid, status, brhid, userid) values("+docNo+", now(), '"+cldocno+"', '"+accountno+"', '"+sqlDate+"', '"+remarks+"', '"+process+"', 7, '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql);
    	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCPF',now(),'"+session.getAttribute("USERID").toString()+"','D')";
    	int data= stmt.executeUpdate(sql);
    	
        }
        
		response.getWriter().print(val);

 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
