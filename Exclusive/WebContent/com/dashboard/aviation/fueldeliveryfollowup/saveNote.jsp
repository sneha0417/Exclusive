<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String status =request.getParameter("process")==null?"0":request.getParameter("process").toString();
 String delno=request.getParameter("delnoteno")==null?"0":request.getParameter("delnoteno").toString();
 String row_no =request.getParameter("row_no")==null?"0":request.getParameter("row_no").toString();
 String doc_no =request.getParameter("doc_no")==null?"0":request.getParameter("doc_no").toString();
 String qty =request.getParameter("qty")==null?"0":request.getParameter("qty").toString();
 String desc =request.getParameter("desc")==null?"0":request.getParameter("desc").toString();		 
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		 int rs=0;
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		if(status.equalsIgnoreCase("1")){
			 strSql = "update av_fueld set delstat='1', delnoteno='"+delno+"', qty='"+qty+"' where row_no='"+row_no+"' ";
		    rs = stmt.executeUpdate(strSql);
		}
		else if(status.equalsIgnoreCase("2")){
			 strSql = "update av_fueld set cancelstatus='"+status+"', remarks='"+desc+"' where row_no='"+row_no+"'";
		    rs = stmt.executeUpdate(strSql);	
		}
			 
		     if(rs>0){
		     String sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+doc_no+"','"+branchid+"','BFD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		     int data= stmt.executeUpdate(sql);
		     String sqls="insert into av_dndet (datetime, rdocno, fdate, remarks, status, brhid, userid) values (now(),'"+row_no+"','"+sdate+"','"+desc+"','"+status+"','"+branchid+"','"+userid+"')";
			 int datas= stmt.executeUpdate(sqls);
			 if(datas<=0){
				 stmt.close();
				    conn.close();
				}
		}
	
		//System.out.println("rs ="+rs);
		response.getWriter().write(rs+"###1");

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  