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
 
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
	
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		String datecount="";
		String strSql ="";
		
		String sql1="";
		if(!(clientid.equalsIgnoreCase("0") || clientid.equalsIgnoreCase("undefined") || clientid.equalsIgnoreCase("") )){
			sql1=" and cldocno="+clientid+"";
		}
		if(!(brchid.equalsIgnoreCase("0") || brchid.equalsIgnoreCase("undefined") || brchid.equalsIgnoreCase("a") )){
			sql1=" and brhid="+brchid+"";
		}
		else{
			brchid="0";
		}
		
		if(statusid.trim().equalsIgnoreCase("8")){
			
			 strSql = "update cm_servplan set empGroupId='"+groupid+"', empId='"+grpempid+"', asgnMode='"+assignid+"' ,assignstatus='"+statusid+"',remarks='"+desc+"',plannedon='"+sdate+"',date='"+sdate+"',pltime='"+ptime+"',status='5',workper='100' where TR_NO='"+srno+"' and refdocno='"+trno+"' and dTYPE='"+dtype+"' and status in(3,4) "+sql1+"";
			 
			 String strSql1="update cm_cuscallm set clstatus=3 where doc_no='"+trno+"'";
			 int rs1 = stmt.executeUpdate(strSql1);
			 
		} else if(statusid.trim().equalsIgnoreCase("1")){
			
			 strSql = "update cm_servplan set empGroupId='"+groupid+"', empId='"+grpempid+"', asgnMode='"+assignid+"' ,assignstatus='"+statusid+"',remarks='"+desc+"',plannedon='"+sdate+"',date='"+sdate+"',pltime='"+ptime+"' where TR_NO='"+srno+"' and refdocno='"+trno+"' and dTYPE='"+dtype+"' and status in(3,4) "+sql1+"";      
		
		} else {
			
			 strSql = "update cm_servplan set empGroupId='"+groupid+"', empId='"+grpempid+"', asgnMode='"+assignid+"' ,assignstatus='"+statusid+"',remarks='"+desc+"' where TR_NO='"+srno+"' and refdocno='"+trno+"' and dTYPE='"+dtype+"' and status in(3,4) "+sql1+"";      
		
		}
			 
		int rs = stmt.executeUpdate(strSql);
		
		
		if(rs>0){
			
			 String sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, asgnMode, asgnstatusid, plannedOn, plTime, description) values ('"+branchid+"','"+trno+"','"+groupid+"','"+grpempid+"','"+assignid+"','"+statusid+"','"+sdate+"','"+ptime+"','"+desc+"')";
			 stmt.executeUpdate(sqlassign);
			
			
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','SRCH',now(),'"+userid+"','E')";
			 int datas= stmt.executeUpdate(sqls);
			 if(datas<=0){
				 stmt.close();
				 conn.close();
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
  