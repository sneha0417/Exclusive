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
		String remarks=request.getParameter("remarks");
		String process=request.getParameter("process").trim();
		String userid=session.getAttribute("USERID").toString();
		String trnos=request.getParameter("trnos");
		String bibid=request.getParameter("bibid").trim();
		
		String sql1="",sql2="",sqltest="";
		if(process.equalsIgnoreCase("Close")){
			sqltest=" jbaction=2 ";
		}
		 if(process.equalsIgnoreCase("Hold")){
				sqltest=" jbaction=1 ";
			}
		 if(process.equalsIgnoreCase("Release")){
				sqltest=" jbaction=0 ";
			}
		
		sql1="update cm_srvcontrm set "+sqltest+"  where tr_no="+trnos+" ";
		int val= stmt.executeUpdate(sql1);
	     
	     sql2="insert into gl_BJHC(rdocno,rdtype,userid,remarks,date,process) values ("+docno+",'"+dtype+"',"+userid+",'"+remarks+"',now(),'"+bibid+"')";
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
  
