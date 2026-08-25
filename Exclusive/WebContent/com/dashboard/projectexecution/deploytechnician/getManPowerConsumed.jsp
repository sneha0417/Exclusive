<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String costtype =request.getParameter("costtype")==null?"0":request.getParameter("costtype").toString().trim();
		String costcode = request.getParameter("costcode")==null?"0":request.getParameter("costcode").trim();
		 
		if(costtype.contains("AMC") || costtype.contains("amc")) {
			costtype="3";
		} else if(costtype.contains("SJOB") || costtype.contains("sjob")) {
			costtype="4";
		}
		
		String strSql = "select round(coalesce((sum(normal)*costperhour),0),2) totalvalue from hr_timesheethrs where status=3 and costtype='"+costtype+"' and costcode='"+costcode+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String totalvalue="0.00";
		while(rs.next()) {
			totalvalue=rs.getString("totalvalue");
		} 
		
		response.getWriter().write(totalvalue);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  