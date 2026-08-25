<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

String temp="";
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String docno=request.getParameter("docno");
		String dtype=request.getParameter("dtype");
		String process=request.getParameter("process").trim();
		String userid=session.getAttribute("USERID").toString();
		String trnos=request.getParameter("trnos");
		String brhid=request.getParameter("brhid").trim();
		
		String sql1="",sql2="",sqltest="";
		
		if(dtype.equalsIgnoreCase("CREG")){
			sql1="update cm_cuscallm set clstatus="+process+"  where tr_no="+trnos+" and doc_no="+docno+" and brhid="+brhid+" ";
		}
		else{
		sql1="update cm_srvcontrm set jbaction="+process+"  where tr_no="+trnos+" and doc_no="+docno+" and brhid="+brhid+"  ";
		}
		int val= stmt.executeUpdate(sql1);
	     
	     sql2="insert into gl_BJHC(rdocno,rdtype,userid,date,process) values ("+docno+",'"+dtype+"',"+userid+",now(),'3')";
	     int data= stmt.executeUpdate(sql2);
		if(data>0)
		{
			temp="1";
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
  
