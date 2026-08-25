<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String monthCloseDate="0";String monthCloseDates="0";
		String monthClose="0";
		java.sql.Date sqlDate=null;
		int days=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
		
		String sql = "select coalesce(mclose,ACCYEAR_F) mclose,coalesce(DATE_FORMAT(mclose,'%d-%m-%Y'),DATE_FORMAT(ACCYEAR_F,'%d-%m-%Y')) mclosedate from my_brch where status<>7 and doc_no='"+branch+"'";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			monthCloseDate=rs.getString("mclose");
			monthCloseDates=rs.getString("mclosedate");
		} 
		
		String strSql = "select DATEDIFF('"+sqlDate+"','"+monthCloseDate+"') days";
		ResultSet rs1 = stmt.executeQuery(strSql);
		
		while(rs1.next()) {
			days=rs1.getInt("days");
		} 
		
		if(days<=0){
			monthClose="1";
		}
		
		response.getWriter().write(monthCloseDate+"***"+monthClose+"***"+monthCloseDates);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  