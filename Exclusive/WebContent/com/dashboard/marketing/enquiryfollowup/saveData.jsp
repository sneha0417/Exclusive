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

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		 if(proname.equalsIgnoreCase("Follow-Up"))
		{
			 sql="insert into gl_benq( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+")";
			 val= stmt.executeUpdate(sql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		 
		 if(proname.equalsIgnoreCase("Dropped"))
			{
				sql="update gl_benq set status=7 where bibpid="+bibid+" and rdocno="+docno+" ";
		    	int dat= stmt.executeUpdate(sql);
		    	 sql="insert into gl_benq( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
				 val= stmt.executeUpdate(sql);
		    	if(val>0)
				 {
					 temp="1";
				 }
			}
		if(proname.equalsIgnoreCase("Assigned"))
		{
			sqlsub="update gl_enqm set enqstatus=1  where doc_no="+docno+" ";
			int data= stmt.executeUpdate(sqlsub);
			 sql="insert into gl_benq( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
			 val= stmt.executeUpdate(sql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		if(proname.equalsIgnoreCase("Declined"))
		{
			sqlsub="update gl_enqm set enqstatus=4  where doc_no="+docno+" ";
			int data= stmt.executeUpdate(sqlsub);
			sql1="update gl_benq set status=7 where bibpid="+bibid+" and rdocno="+docno+" ";
	    	int dat= stmt.executeUpdate(sql1);
			 sql="insert into gl_benq( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
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
