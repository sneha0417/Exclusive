
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
		String branchid=request.getParameter("branchid");
		String empdocno=request.getParameter("empdocno");
		String empid=request.getParameter("empid");
		String expirydate=request.getParameter("expirydate");
		String remarks=request.getParameter("remarks");
		String documentid=request.getParameter("documentid");
		String document=request.getParameter("document");

		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    java.sql.Date sqlExpiryDate=null;

	    if(!(expirydate.equalsIgnoreCase("undefined"))&&!(expirydate.equalsIgnoreCase(""))&&!(expirydate.equalsIgnoreCase("0"))){
	    	sqlExpiryDate=ClsCommon.changeStringtoSqlDate(expirydate);
		}
	    
		String sql=null;
		int val=0,docNo=0,processNo=0;
		   
		  sql="select coalesce(max(doc_no)+1,1) doc_no from hr_bcde";
		  ResultSet resultSet = stmt.executeQuery(sql);
		  
		  while (resultSet.next()) {
				 docNo=resultSet.getInt("doc_no");
		   }
		  
		  sql="select rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Documents Expiry') and process='"+process+"'";
		  ResultSet resultSet1 = stmt.executeQuery(sql);
		  
		  while (resultSet1.next()) {
			  processNo=resultSet1.getInt("rowno");
		   }

		   if(process.trim().equalsIgnoreCase("Follow-Up")){
				 /*Follow-Up */
			     sql="insert into hr_bcde(doc_no, date, empdocno, emp_id, document, docid, expiry_date, fdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+empdocno+"', '"+empid+"', '"+document+"', '"+documentid+"', '"+sqlExpiryDate+"', '"+sqlDate+"', '"+remarks+"', '"+processNo+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
				 val= stmt.executeUpdate(sql);
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','HRBDE',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 int data= stmt.executeUpdate(sql);
		   }
		   
		   else if(process.trim().equalsIgnoreCase("Extended")){
			   /*Extended */
				sql="update hr_empdoc set expdt='"+sqlDate+"' where docid='"+documentid+"' and rdocno='"+empdocno+"'";
				val= stmt.executeUpdate(sql); 	  
			    sql="insert into hr_bcde(doc_no, date, empdocno, emp_id, document, expiry_date, extdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+empdocno+"', '"+empid+"', '"+document+"', '"+sqlExpiryDate+"', '"+sqlDate+"', '"+remarks+"', '"+processNo+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
			    val= stmt.executeUpdate(sql);
				sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','HRBDE',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
