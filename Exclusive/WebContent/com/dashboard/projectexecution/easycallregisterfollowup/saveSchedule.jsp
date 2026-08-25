<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String groupid =request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null?"0":request.getParameter("grpmemberid").toString();
 String statusid =request.getParameter("statusid")==null || request.getParameter("statusid").trim().equalsIgnoreCase("")?"0":request.getParameter("statusid").toString();
 String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String brchid =request.getParameter("brchid")==null?"":request.getParameter("brchid").toString();
 String oldstatus =request.getParameter("oldstatus")==null?"":request.getParameter("oldstatus").toString();
 
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement ();
		
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		String datecount="";
		String strSql ="";
		
	    strSql = "update cm_cuscallm set empgroupid='"+groupid+"', empid='"+grpmemberid+"', statusid='"+statusid+"' where TR_NO='"+trno+"' ";
	    System.out.println("strSql==="+strSql);
	    String strSql1="update cm_cuscallm set clstatus=3 where doc_no='"+trno+"'";
	    int rs1 = stmt.executeUpdate(strSql1);
			 
		int rs = stmt.executeUpdate(strSql);
		
		if(rs>0){
			if(!statusid.equalsIgnoreCase(oldstatus)){
			 String sqlup="update cm_srvassign set closetime=now() where refdocno="+trno+" and statusid="+oldstatus;
			 System.out.println("sqlup==="+sqlup);
			 stmt.executeUpdate(sqlup);
			}
			
			 String sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, statusId, description,entrydate) values ('"+branchid+"','"+trno+"','"+groupid+"','"+grpmemberid+"','"+statusid+"','"+desc+"',now())";
			 System.out.println("sqlassign==="+sqlassign);
			 stmt.executeUpdate(sqlassign);
			
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','CREG',now(),'"+userid+"','E')";
			 int datas= stmt.executeUpdate(sqls);
			 if(datas<=0){
				 stmt.close();
				 conn.close();
			 }
			 else{
				 conn.commit();
			 }
		}
		
		response.getWriter().write(rs+"###"+dtype);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  