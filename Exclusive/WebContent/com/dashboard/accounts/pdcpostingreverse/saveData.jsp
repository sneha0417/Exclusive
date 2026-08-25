
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
		
		String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
		String postedtrno=request.getParameter("postedtrno")==null?"0":request.getParameter("postedtrno");
	    
		String sql=null;
		int val=0,docNo=0,bankreconcile=0;
		   
		  sql="select sum(bankreconcile) bankreconcile from my_jvtran where tr_no='"+postedtrno+"'";
		  ResultSet resultSet1 = stmt.executeQuery(sql);
		  
		  while (resultSet1.next()) {
			  bankreconcile=resultSet1.getInt("bankreconcile");
		   }

		   if(bankreconcile==0) {
				 
			     sql="update my_jvma set status=7 where tr_no='"+postedtrno+"'";
				 val= stmt.executeUpdate(sql);
				 if(val<=0){
					 conn.close();
				 }
				 
				 sql="update my_jvtran set status=7 where tr_no='"+postedtrno+"'";
				 val= stmt.executeUpdate(sql);
				 if(val<=0){
					 conn.close();
				 }
				 
				 sql="delete from my_postm where tr_no='"+postedtrno+"'";
				 val= stmt.executeUpdate(sql);
				 if(val<=0){
					 conn.close();
				 }
				 
				 sql="update my_chqdet set status='E',postno=0,pdcposttrno=0 where tr_no='"+trno+"'";
				 val= stmt.executeUpdate(sql);
				 if(val<=0){
					 conn.close();
				 }
				 
				 sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bfpr";
		  		 ResultSet resultSet = stmt.executeQuery(sql);
		  
		  		 while (resultSet.next()) {
				 	docNo=resultSet.getInt("doc_no");
		         }
		  
			     sql="insert into gl_bfpr(doc_no, date, tr_no, posttrno, brhid, userid, status) values('"+docNo+"', now(), '"+trno+"', '"+postedtrno+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"', 3)";
				 val= stmt.executeUpdate(sql);
				 if(val<=0){
					 conn.close();
				 }
				 
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BFPR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
