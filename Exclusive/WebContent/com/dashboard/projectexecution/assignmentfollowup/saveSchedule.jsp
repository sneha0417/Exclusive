<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String groupid =request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null?"0":request.getParameter("grpmemberid").toString();
 String grpempid =request.getParameter("grpempid")==null?"0":request.getParameter("grpempid").toString();
 String assignid =request.getParameter("assignid")==null || request.getParameter("assignid").trim().equalsIgnoreCase("")?"0":request.getParameter("assignid").toString();
 String statusid =request.getParameter("statusid")==null || request.getParameter("statusid").trim().equalsIgnoreCase("")?"0":request.getParameter("statusid").toString();
 String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
 String srno =request.getParameter("srno")==null?"0":request.getParameter("srno").toString();
 String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();
 String process=request.getParameter("process")==null?"":request.getParameter("process").toString();
 String processname=request.getParameter("processname")==null?"":request.getParameter("processname").toString();
 String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
 
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		java.sql.Date sqlDate=null;
		
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
	
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		
		String sql=null;
		int val=0,docNo=0;
		
        sql="select coalesce(max(doc_no)+1,1) doc_no from cm_bafu";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
  
        if(processname.equalsIgnoreCase("Follow-Up")){
        	
		 /*Follow-Up */
	     sql="insert into cm_bafu(doc_no, date, rtrno, rdocno, fdate, remarks, bibpid, brhid, userid) values("+docNo+", now(), '"+trno+"', '"+srno+"', '"+sqlDate+"', '"+desc+"', '"+process+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql);
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BAFU',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 int data= stmt.executeUpdate(sql);
		 
        }
        
        else if(processname.equalsIgnoreCase("Drop")){
	    
        /*Drop*/
        sql="update cm_bafu set status=7 where rtrno="+trno+" and rdocno='"+srno+"'";
    	val= stmt.executeUpdate(sql);
    	sql="insert into cm_bafu(doc_no, date, rtrno, rdocno, fdate, remarks, bibpid, status, brhid, userid) values("+docNo+", now(), '"+trno+"', '"+srno+"', '"+sqlDate+"', '"+desc+"', '"+process+"', 7, '"+branchid+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql);
    	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BCPF',now(),'"+session.getAttribute("USERID").toString()+"','D')";
    	int data= stmt.executeUpdate(sql);
    	
        }
		
		response.getWriter().write(val+"###"+dtype);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  