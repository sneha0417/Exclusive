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
		
		String branchid=request.getParameter("branchid");
		String chequeno=request.getParameter("chequeno");
		String chequedate=request.getParameter("chequedate");
		String trno=request.getParameter("trno");
		String docno=request.getParameter("docno");
		String dtype=request.getParameter("dtype");
	    
		String sql=null;
	
		int val=0;
		java.sql.Date sqlDate=null;
		
		 /*Cheque Detail Update */
		 
		 chequedate.trim();
           if(!(chequedate.equalsIgnoreCase("undefined"))&&!(chequedate.equalsIgnoreCase(""))&&!(chequedate.equalsIgnoreCase("0")))
           {
        	   sqlDate = ClsCommon.changeStringtoSqlDate(chequedate);
           }
		 
		 if(!(dtype.equalsIgnoreCase("UCP"))){
			 
		 	sql="update my_chqbm set chqno='"+chequeno+"',chqdt='"+sqlDate+"' where tr_no="+trno+"";
    	 	val= stmt.executeUpdate(sql);
    	 	sql="update my_chqdet set chqno='"+chequeno+"',chqdt='"+sqlDate+"' where tr_no="+trno+"";
     	 	val= stmt.executeUpdate(sql);
		 
		 }else{
			 
			 sql="update my_unclrchqbm set chqno='"+chequeno+"',chqdt='"+sqlDate+"' where brhid="+branchid+" and doc_no="+docno+"";
	    	 val= stmt.executeUpdate(sql);
	    	 	
		 }
		 
	 	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchid+"','BCU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
   }finally{
	   conn.close();
   }
	%>
