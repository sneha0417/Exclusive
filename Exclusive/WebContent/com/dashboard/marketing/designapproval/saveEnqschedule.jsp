<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
 String description =request.getParameter("description")==null?"":request.getParameter("description").toString();
 String process =request.getParameter("process")==null?"":request.getParameter("process").toString();
 String docno =request.getParameter("docno")==null?"":request.getParameter("docno").toString();
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();
 try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
		   sdate=ClsCommon.changeStringtoSqlDate(date);
		}		
		String sql1="",strdelSql="",strupSql="";
		int rs=0;
		
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		System.out.println("process=="+process);

		String sqlss="insert into gl_enqaprfup( rdocno, brhid,userid,description,date,fdate,type) values ("+docno+","+branchid+",'"+userid+"','"+description+"',now(),'"+sdate+"',"+(process.equalsIgnoreCase("FUP")?1:(process.equalsIgnoreCase("DHO")?2:0))+") ";
		System.out.println("--sqlss--"+sqlss);
		int aa1=stmt.executeUpdate(sqlss);
		if(aa1>0){
			strupSql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchid+"','DHOR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			System.out.println("--sqlss--"+strupSql);
			rs= stmt.executeUpdate(strupSql);
		}
		if(process.trim().equalsIgnoreCase("DHO")){
			strupSql = "update gl_enqm set designstat=2 where doc_no="+docno+" and status=3 ";      
			rs = stmt.executeUpdate(strupSql);
		}	
		response.getWriter().write(rs+"###");
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  