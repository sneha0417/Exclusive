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
 String assignid =request.getParameter("assignid")==null?"0":request.getParameter("assignid").toString();
 String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
 String schtrno =request.getParameter("schtrno")==null?"0":request.getParameter("schtrno").toString();
 String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();
 String process =request.getParameter("process")==null?"":request.getParameter("process").toString();
 //System.out.println("schtrno=="+schtrno);
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		String sql1="",strdelSql="",strupSql="";
		int rs=0;
		if(!(brchid.equalsIgnoreCase("0") || brchid.equalsIgnoreCase("undefined") || brchid.equalsIgnoreCase("a") )){
			sql1=" and brhid="+brchid+"";
		}
		else{
			brchid="0";
		}
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		System.out.println("process=="+process);
		if(process.trim().equalsIgnoreCase("SUR")){
			 strupSql = "update gl_enqm set enqstatus=1 where doc_no="+trno+" and status=3 ";      
			 System.out.println("strupSql=="+strupSql); 
			 rs = stmt.executeUpdate(strupSql);
		}
		
		if(process.trim().equalsIgnoreCase("ASN")){
		if(!(schtrno.equalsIgnoreCase("0") || schtrno.equalsIgnoreCase("undefined") || schtrno.equalsIgnoreCase(null)|| schtrno.equalsIgnoreCase("") )){
			 strdelSql = "delete from gl_beqs where tr_no="+schtrno+" ";      
		//	 System.out.println("strdelSql=="+strdelSql);
			 int rs1 = stmt.executeUpdate(strdelSql);
		}
	
			 strupSql = "update gl_enqm set sh_empid="+grpempid+" where doc_no="+trno+" and status=3 ";      
				 
		 int rsup = stmt.executeUpdate(strupSql);

		if(rsup>0){ 
			
			 String sqlassign="insert into gl_beqs (brhid,rdocno, empGroupId, empId, asgnMode, plannedOn, plTime, description) values ('"+brchid+"','"+trno+"',"+groupid+","+grpempid+","+assignid+",'"+sdate+"','"+ptime+"','"+desc+"')";
			 stmt.executeUpdate(sqlassign);
			
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','BEQS',now(),'"+userid+"','E')";
			rs= stmt.executeUpdate(sqls);
			 if(rs<=0){
				 stmt.close();
				    conn.close();
				}
		}
	}	
		response.getWriter().write(rs+"###"+schtrno);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  