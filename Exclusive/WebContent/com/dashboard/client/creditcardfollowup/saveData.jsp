<%@page import="com.opensymphony.xwork2.util.TextParseUtil.ParsedValueEvaluator"%>
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
		String date=request.getParameter("date");
		String extdate=request.getParameter("extdate");
		String branchid=request.getParameter("branchid");
		String cldocno=request.getParameter("cldocno");
		String expirydate=request.getParameter("expirydate");
		String remarks=request.getParameter("remarks");
		String rentaltype=request.getParameter("rentaltype");
		String agreementno=request.getParameter("agreementno");
		String cardno=request.getParameter("cardno");
		String pytdocno=request.getParameter("pytdocno");
		
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
		  sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bccf";
		  ResultSet resultSet = stmt.executeQuery(sql);
		  
		  while (resultSet.next()) {
				 docNo=resultSet.getInt("doc_no");
		   }
		  
		   if(process.equalsIgnoreCase("23")){
				 /*Follow-Up */
			     sql="insert into gl_bccf(doc_no, date, cldocno, cardno, expiry_date, rtype, aggno, fdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+cldocno+"', '"+cardno+"', '"+expirydate+"', '"+rentaltype+"', '"+agreementno+"', '"+sqlDate+"', '"+remarks+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
				 val= stmt.executeUpdate(sql);
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCCF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 int data= stmt.executeUpdate(sql);
		   }
		   
		   else  if(process.equalsIgnoreCase("24")){
			   /*Extended */
			    if(rentaltype.equalsIgnoreCase("RAG") || rentaltype.equalsIgnoreCase("rag")){
			        sql="update gl_rpyt set expdate='"+extdate+"' where doc_no='"+pytdocno+"'";
			        val= stmt.executeUpdate(sql); 	
			    }
			    if(rentaltype.equalsIgnoreCase("LAG") || rentaltype.equalsIgnoreCase("lag")){
			    	sql="update gl_lpyt set expdate='"+extdate+"' where doc_no='"+pytdocno+"'";
			        val= stmt.executeUpdate(sql); 	
			    }
			    
			    sql="insert into gl_bccf(doc_no, date, cldocno, cardno, expiry_date, rtype, aggno, extdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+cldocno+"', '"+cardno+"', '"+expirydate+"', '"+rentaltype+"', '"+agreementno+"', '"+extdate+"', '"+remarks+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
				val= stmt.executeUpdate(sql);
				sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCCF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
