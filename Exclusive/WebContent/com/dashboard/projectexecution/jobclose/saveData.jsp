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
		String closedate=request.getParameter("closedate");
		String userid=session.getAttribute("USERID").toString();
		String trnos=request.getParameter("trnos");
		String sql1="",sql2="",sqltest="";
		java.sql.Date sqlcloseDate=null;

	    if(!(closedate.equalsIgnoreCase("undefined"))&&!(closedate.equalsIgnoreCase(""))&&!(closedate.equalsIgnoreCase("0"))){
	    	sqlcloseDate=ClsCommon.changeStringtoSqlDate(closedate);
		}

		
		sql1="update cm_srvcontrm set jbaction=2  where tr_no="+trnos+" ";
		int val= stmt.executeUpdate(sql1);
	     
	     sql2="insert into gl_BJCL(rtrno,rdtype,userid,remarks,date,cldate) values ("+trnos+",'"+dtype+"',"+userid+",'"+remarks+"',now(),'"+sqlcloseDate+"')";
	//  System.out.println("sql2=="+sql2);
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
  
