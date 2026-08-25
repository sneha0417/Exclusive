 
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


	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
	String cmbText=request.getParameter("cmbText").trim();
	
	String refrowno=request.getParameter("refrowno");
	

	 Connection conn=null;

	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;

if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
	{
	sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	
System.out.println("="+cmbText);
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
	
	   if(cmbText.equalsIgnoreCase("Follow-Up"))
	   {
		   

		 /*   upsql="update  my_prfqd  set clstatus=1 where doc_no='"+docno+"' ";
		
		     val= stmt.executeUpdate(upsql); */
		     upsql="select coalesce(max(doc_no)+1,1) doc_no from my_bprfq";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		   upsql="insert into my_bprfq (doc_no,date, rdocno, bibpid, fdate, remarks, userid, status,refrowno)values('"+docval+"',now(),'"+docno+"','"+cmbinfo+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,'"+refrowno+"') ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','RFQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  }

	   else  if(cmbText.equalsIgnoreCase("Dropped"))
	   {
		   
		     
			     
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from my_bprfq";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
			     
		     upsql="insert into my_bprfq (doc_no,date, rdocno, bibpid, ddate, remarks, userid, status,refrowno)values('"+docval+"',now(),'"+docno+"','"+cmbinfo+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,'"+refrowno+"') ";
			 val= stmt.executeUpdate(upsql);
			 
			  upsql="update  my_prfqd  set clstatus=1 where rdocno='"+docno+"' and  rowno='"+refrowno+"' ";
		       val= stmt.executeUpdate(upsql);
			 
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','RFQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 int aaa= stmt.executeUpdate(upsql);
			 
	   }
	  
		 				
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
