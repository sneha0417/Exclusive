
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
		String cldocno=request.getParameter("cldocno");
		String expirydate=request.getParameter("expirydate");
		String remarks=request.getParameter("remarks");
		String driversrno=request.getParameter("driversrno");
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
		int val=0,docNo=0;
		   
		  sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcde";
		  ResultSet resultSet = stmt.executeQuery(sql);
		  
		  while (resultSet.next()) {
				 docNo=resultSet.getInt("doc_no");
		   }
		  
		   if(process.equalsIgnoreCase("13")){
				 /*Follow-Up */
			     sql="insert into gl_bcde(doc_no, date, cldocno, dr_id, document, expiry_date, fdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+cldocno+"', '"+driversrno+"', '"+document+"', '"+sqlExpiryDate+"', '"+sqlDate+"', '"+remarks+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
				 val= stmt.executeUpdate(sql);
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCDE',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 int data= stmt.executeUpdate(sql);
		   }
		   
		   else  if(process.equalsIgnoreCase("14")){
			   /*Extended */
			    if(document.equalsIgnoreCase("Licence Expired") || document.equalsIgnoreCase("licence expired")){
				    sql="update gl_drdetails set led='"+sqlDate+"' where dr_id='"+driversrno+"'";
				    val= stmt.executeUpdate(sql); 	  
			    }
			   
			    if(document.equalsIgnoreCase("Passport Expired") || document.equalsIgnoreCase("passport expired")){
				    sql="update gl_drdetails set pass_exp='"+sqlDate+"' where dr_id='"+driversrno+"'";
				    val= stmt.executeUpdate(sql); 	  
			    }
			    
			    if(document.equalsIgnoreCase("Trade Licence Expired") || document.equalsIgnoreCase("trade licence expired")){
				    sql="update my_acbook set contract_upto='"+sqlDate+"' where dtype='CRM' and cldocno='"+cldocno+"'";
				    val= stmt.executeUpdate(sql); 	  
			    }
			   
			    sql="insert into gl_bcde(doc_no, date, cldocno, dr_id, document, expiry_date, extdate, remarks, bibpid, brhid, userid) values("+docNo+",now(), '"+cldocno+"', '"+driversrno+"', '"+document+"', '"+sqlExpiryDate+"', '"+sqlDate+"', '"+remarks+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
				val= stmt.executeUpdate(sql);
				sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCDE',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
