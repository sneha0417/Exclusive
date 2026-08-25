<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		 String docno=request.getParameter("docno");
	 	 String date=request.getParameter("date");
		 String chequeno=request.getParameter("chequeno");
		 String chequedate=request.getParameter("chequedate");
		 String remarks=request.getParameter("remarks");
		 String branchid=request.getParameter("branchid");
		
		 String sql=null,sql1=null,sql2=null,sql3=null;
		 int val=0,docNo=0;
		 
		 java.sql.Date sqlDate=null;
		 java.sql.Date sqlChequeDate=null;

	     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		 }
	     
	     if(!(chequedate.equalsIgnoreCase("undefined"))&&!(chequedate.equalsIgnoreCase(""))&&!(chequedate.equalsIgnoreCase("0"))){
	    	 sqlChequeDate=ClsCommon.changeStringtoSqlDate(chequedate);
		 }
		    
	     sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bscl";
	     ResultSet resultSet = stmt.executeQuery(sql);
	  
	     while (resultSet.next()) {
			 docNo=resultSet.getInt("doc_no");
	     }
		 
		 sql1="update my_secchq set chqclose=1 where chqclose=0 and brhid='"+branchid+"' and doc_no="+docno+"";
		 val= stmt.executeUpdate(sql1);
		 
		 sql2="insert into gl_bscl(doc_no, date, rdocno, rdate, chqno, chqdt, remarks, brhid, userid) values("+docNo+",now(), '"+docno+"', '"+sqlDate+"', '"+chequeno+"', '"+sqlChequeDate+"', '"+remarks+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql2);
	     
	     sql3="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BSCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	     int data= stmt.executeUpdate(sql3);
		
	     response.getWriter().print(val+"***"+docno);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
