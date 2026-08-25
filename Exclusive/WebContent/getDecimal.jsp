<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmtsys = conn.createStatement();
		
		String sessionid = session.getAttribute("COMPANYID")==null?"0":session.getAttribute("COMPANYID").toString();
		
		String amtdec="",curdec="";
		
		String strSys = "select cvalue,codeno from my_system where comp_id='"+sessionid+"'";
		ResultSet rsSys = stmtsys.executeQuery (strSys);
		
		while(rsSys.next ()) {
			session.setAttribute(rsSys.getString("codeno").toUpperCase().trim(), rsSys.getString("cvalue").trim());
			if(rsSys.getString("codeno").equalsIgnoreCase("amtdec")){
				amtdec=rsSys.getString("cvalue").trim();
			}
			if(rsSys.getString("codeno").equalsIgnoreCase("curdec")){
				curdec=rsSys.getString("cvalue").trim();
			}
		}
		
		response.getWriter().write(amtdec+"####"+curdec);
		
		stmtsys.close();
		conn.close ();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
