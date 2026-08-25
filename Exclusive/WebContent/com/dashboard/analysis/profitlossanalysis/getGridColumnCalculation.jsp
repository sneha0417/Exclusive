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
		
		String dayDiff="0",monthDiff="0";
		int difference=0,columns=0;
		
		java.sql.Date sqlFromDate=null;
		java.sql.Date sqlToDate=null;
		
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String frequencytype=request.getParameter("frequencytype");
		String noofdays=request.getParameter("noofdays");
		
	    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	    	sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
	    
	    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	    	sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
		}
	    
	    if(frequencytype.equalsIgnoreCase("1")){
			String sql = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
			ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				dayDiff=rs1.getString("daydiff");
			} 
			
			String sql1 = "select ("+dayDiff+"/"+noofdays+") daydifference";
			ResultSet rs2 = stmt.executeQuery(sql1);
			
			while(rs2.next()) {
				difference=rs2.getInt("daydifference");
			} 
	    }else if(frequencytype.equalsIgnoreCase("2")){
			String sql = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				difference=rs1.getInt("monthdiff");
			} 
	    }else if(frequencytype.equalsIgnoreCase("3")){
	    	String sql = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
	    	ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				monthDiff=rs1.getString("monthdiff");
			} 
			
			String sql1 = "select ("+monthDiff+"/3) monthdifference";
			ResultSet rs2 = stmt.executeQuery(sql1);
			
			while(rs2.next()) {
				difference=rs2.getInt("monthdifference");
			} 
			
	    }else if(frequencytype.equalsIgnoreCase("4")){
	    	String sql = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";
	    	ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				difference=rs1.getInt("yeardiff");
			} 
	    }
	    else if(frequencytype.equalsIgnoreCase("5")){
	    	String sql = "select count(*) branchcount from my_brch where status=3";
	    	ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				difference=rs1.getInt("branchcount");
			} 
	    }
	    
	    if(difference>30){
				columns = 1;
		}
		
		response.getWriter().write(frequencytype+"***"+difference+"***"+columns);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  