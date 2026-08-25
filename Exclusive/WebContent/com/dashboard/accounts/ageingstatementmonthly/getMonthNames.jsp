<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String sqlDate=request.getParameter("date");
		
		System.out.println("sqlDate ="+sqlDate);
		
		String strSql = "select DATE_FORMAT('"+sqlDate+"', '%b-%y') currentmonth,DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 1 MONTH), '%b-%y') previousmonth1,"
					  + "DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 2 MONTH), '%b-%y') previousmonth2,DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 3 MONTH), '%b-%y') previousmonth3,"
					  + "DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 4 MONTH), '%b-%y') previousmonth4,DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 5 MONTH), '%b-%y') previousmonth5," 
				      + "DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 6 MONTH), '%b-%y') previousmonth6,DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 7 MONTH), '%b-%y') previousmonth7,"
				      + "DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 8 MONTH), '%b-%y') previousmonth8,DATE_FORMAT(DATE_SUB('"+sqlDate+"',INTERVAL 9 MONTH), '%b-%y') previousmonth9;";
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String currentmonth="",previousmonth1="",previousmonth2="",previousmonth3="",previousmonth4="",previousmonth5="",previousmonth6="",previousmonth7="",previousmonth8="",previousmonth9="";
		while(rs.next()) {
			currentmonth=rs.getString("currentmonth");
			previousmonth1=rs.getString("previousmonth1");
			previousmonth2=rs.getString("previousmonth2");
			previousmonth3=rs.getString("previousmonth3");
			previousmonth4=rs.getString("previousmonth4");
			previousmonth5=rs.getString("previousmonth5");
			previousmonth6=rs.getString("previousmonth6");
			previousmonth7=rs.getString("previousmonth7");
			previousmonth8=rs.getString("previousmonth8");
			previousmonth9=rs.getString("previousmonth9");
				} 
		
		response.getWriter().write(currentmonth+"####"+previousmonth1+"####"+previousmonth2+"####"+previousmonth3+"####"+previousmonth4+"####"+previousmonth5+"####"+previousmonth6+"####"+previousmonth7+"####"+previousmonth8+"####"+previousmonth9);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  