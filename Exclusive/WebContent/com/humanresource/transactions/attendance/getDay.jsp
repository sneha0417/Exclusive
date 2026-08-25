<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		
		String strSql = "select year(curdate()) year,DATE_FORMAT(curdate(),'%m') month";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String currentmonth="";
		String currentyear="";
		while(rs.next()) {
			currentyear=rs.getString("year");	
			currentmonth=rs.getString("month");
	  	}
		
		String strSql1 = "";
				
		if((!(year.equalsIgnoreCase("")) && !(year.equalsIgnoreCase("0"))) && (!(month.equalsIgnoreCase("")) && !(month.equalsIgnoreCase("0")))){
			
			strSql1 = "select day(last_day('"+year+"-"+month+"-01')) days";
		
		}else{
			strSql1 = "select day(last_day('"+currentyear+"-"+currentmonth+"-01')) days";	
		}
		
		ResultSet rs1 = stmt.executeQuery(strSql1);
				
		String currentdays="";
		String currentdaysid="";
		String endcurrentdays="";
		while(rs1.next()) {
			endcurrentdays=rs1.getString("days");	
	  	}
		
		for(int i=01;i<=Integer.parseInt(endcurrentdays);i++){
			currentdays+=i+",";
			currentdaysid+=i+",";
		}
		
		currentdays=currentdays.substring(0, currentdays.length()>0?currentdays.length()-1:0);
		
		response.getWriter().write(currentdays+"####"+currentdaysid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
