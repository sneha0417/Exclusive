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
		
		String proname=request.getParameter("proname").trim();
		String bibid=request.getParameter("bibid").trim();
		String date=request.getParameter("date");
		String branchid=request.getParameter("branchid");
		String docno=request.getParameter("docno");
		String rdtype=request.getParameter("rdtype");
		String remarks=request.getParameter("remarks");
		
		
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    
		String sql="",sql1="",sqlsub="";
		String temp="";
		int val=0;
		 /*Submit */
	 if(proname.equalsIgnoreCase("Dropped"))
		{
  


			sql="update gl_bpif set status=7 where bibpid="+bibid+" and rdocno="+docno+" ";
	    	int dat= stmt.executeUpdate(sql);
			 sql1="insert into gl_biblog( doc_no, brhId, dtype, edate, userId, userNo, activity,  ENTRY) values(  "+docno+", "+branchid+",'BPIF',now(),  "+session.getAttribute("USERID").toString()+", 0, 1 ,'A')";
			 val= stmt.executeUpdate(sql1);
	    	 sql="insert into gl_bpif( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
			 val= stmt.executeUpdate(sql);
	    	if(val>0)
			 {
				 temp="1";
			 }
		}
	 if(proname.equalsIgnoreCase("Follow-Up"))
		{
		 sql1="insert into gl_biblog( doc_no, brhId, dtype, edate, userId, userNo, activity,  ENTRY) values(  "+docno+", "+branchid+",'BPIF',now(),  "+session.getAttribute("USERID").toString()+", 0, 1 ,'A')";
			 val= stmt.executeUpdate(sql1);
		sql="insert into gl_bpif( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+")";
		 val= stmt.executeUpdate(sql);
		 if(val>0)
		 {
			 temp="1";
		 }
		}
	 if(proname.equalsIgnoreCase("Pyt Received"))
		{
		 sqlsub="update cm_srvcontrm set pstatus=2  where tr_no="+docno+" ";
			int data= stmt.executeUpdate(sqlsub);

		 sql1="insert into gl_biblog( doc_no, brhId, dtype, edate, userId, userNo, activity,  ENTRY) values(  "+docno+", "+branchid+",'BPIF',now(),  "+session.getAttribute("USERID").toString()+", 0, 1 ,'A')";
			 val= stmt.executeUpdate(sql1);

		sql="insert into gl_bpif( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
		 val= stmt.executeUpdate(sql);
		 if(val>0)
		 {
			 temp="1";
		 }
		}

		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
