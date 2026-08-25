<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String date=request.getParameter("date");
		
		java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
        
		String sql = "select method from gl_config where field_nme='HRMonthlyPayrollDate'";
		ResultSet rs = stmt.executeQuery(sql);
		
		String method="";
		while(rs.next()) {
			method=rs.getString("method");
		}
		
		if(method.equalsIgnoreCase("0")){
			
			String strSql = "select value from gl_config where field_nme='HRMonthlyPayrollDate'";
			ResultSet rs1 = stmt.executeQuery(strSql);
			
			int value=0,diff=0;
			while(rs1.next()) {
				value=rs1.getInt("value");
			}
			
			String strSql1 = "select (DAY(LAST_DAY('"+sqlDate+"'))-("+value+")) diff";
			ResultSet rs2 = stmt.executeQuery(strSql1);
			
			while(rs2.next()) {
				diff=rs2.getInt("diff");
			}
			
			if(diff<0){
				
				String strSql2 = "SELECT LAST_DAY('"+sqlDate+"') payrolldate";
				ResultSet rs3 = stmt.executeQuery(strSql2);
				
				while(rs3.next()) {
					sqlDate=rs3.getDate("payrolldate");
				}
				
			} else {
				
				String strSql2 = "SELECT CONCAT(SUBSTR('"+sqlDate+"',1,8),"+value+") payrolldate";
				ResultSet rs3 = stmt.executeQuery(strSql2);
				
				while(rs3.next()) {
					sqlDate=rs3.getDate("payrolldate");
				}
			}
			
		} else {
			String strSql = "SELECT LAST_DAY('"+sqlDate+"') payrolldate";
			ResultSet rs1 = stmt.executeQuery(strSql);
			
			while(rs1.next()) {
				sqlDate=rs1.getDate("payrolldate");
			}
		}
		
		response.getWriter().print(sqlDate);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  