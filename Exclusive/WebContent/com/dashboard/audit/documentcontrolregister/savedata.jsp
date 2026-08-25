
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
	String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid").trim();
	String userid = request.getParameter("userid")==null?"0":request.getParameter("userid").trim();
	String doc_name=request.getParameter("doc_name");
	String desc=request.getParameter("desc");
	String note=request.getParameter("note");
	String expfromdates=request.getParameter("expfromdates")==null?"0":request.getParameter("expfromdates").trim();
	String exptodates=request.getParameter("exptodates")==null?"0":request.getParameter("exptodates").trim();
	String oprn= request.getParameter("op")==null?"0":request.getParameter("op").trim();
	String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
	String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
	

	
//String aa=session.getAttribute("BRANCHID").toString();
//System.out.println("---------"+aa);



	 Connection conn=null;

	 try{
		 
java.sql.Date sqlexpfromdate=null;
java.sql.Date sqlexptodate=null;
java.sql.Date sqldate=null;

if(!(expfromdates.equalsIgnoreCase("undefined"))&&!(expfromdates.equalsIgnoreCase(""))&&!(expfromdates.equalsIgnoreCase("0")))
	{
	sqlexpfromdate=ClsCommon.changeStringtoSqlDate(expfromdates);
		
	}
	else{

	}
if(!(exptodates.equalsIgnoreCase("undefined"))&&!(exptodates.equalsIgnoreCase(""))&&!(exptodates.equalsIgnoreCase("0")))
{
sqlexptodate=ClsCommon.changeStringtoSqlDate(exptodates);
	
}
else{

}
System.out.println("date="+date);
if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
{
sqldate=ClsCommon.changeStringtoSqlDate(date);
	
}
else{

}
	
	 int val=0;
	
	System.out.println("oprn="+oprn);
	String maxdocno=""; 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmt1 = conn.createStatement();
	if(oprn.equalsIgnoreCase("1")){
			
			String insql="insert into gl_docmntcntrlreg( date, docname, descr, issue_date, exp_date, note, status, userid,brhid) values (now(),'"+doc_name+"','"+desc+"','"+sqlexpfromdate+"','"+sqlexptodate+"','"+note+"',3,"+userid+",1);";
			val= stmt.executeUpdate(insql);
			
			String getdocno="select max(doc_no)  docNo from gl_docmntcntrlreg;"	;
			ResultSet result = stmt1.executeQuery(getdocno); 
    		while(result.next()){
    	 		maxdocno=result.getString("docNo");
    		}
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+maxdocno+"','1','BDCR',now(),'"+userid+"','A')";
			stmt.executeUpdate(datalog);
	}
	
	if(oprn.equalsIgnoreCase("2")){
		String insql="update gl_docmntcntrlreg set exp_date='"+sqldate+"' where doc_no="+docno+"";
		val= stmt.executeUpdate(insql);
		
		String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BDCR',now(),'"+userid+"','E')";
		stmt.executeUpdate(datalog);
		
		}
	if(oprn.equalsIgnoreCase("3")){
		String insql="update gl_docmntcntrlreg set docname='"+doc_name+"', descr='"+desc+"', issue_date='"+sqlexpfromdate+"', exp_date='"+sqlexptodate+"', note='"+note+"' where doc_no="+docno+"";
		 System.out.println("insql="+insql);
		val= stmt.executeUpdate(insql);
		
		String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BDCR',now(),'"+userid+"','E')";
		stmt.executeUpdate(datalog);
		}
	if(oprn.equalsIgnoreCase("4")){
		String delsql="update gl_docmntcntrlreg set status=7 where doc_no="+docno+"";   
		System.out.println("delsql="+delsql);
		val= stmt.executeUpdate(delsql);
		
		String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BDCR',now(),'"+userid+"','D')";    
		stmt.executeUpdate(datalog);
		}
    response.getWriter().print(val);
    System.out.println("val="+val);
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
