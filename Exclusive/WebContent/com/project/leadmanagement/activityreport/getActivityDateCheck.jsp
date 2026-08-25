<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String date=request.getParameter("date")==null || request.getParameter("date").trim().equalsIgnoreCase("")?"0":request.getParameter("date");
		int val=0;
		
		java.sql.Date sqlDate = null;
		
     	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
     	{
     		sqlDate=ClsCommon.changeStringtoSqlDate(date);
     		
     	}
     	
		String method="0",methodvalue="0";
		
		String sqlConfig="select method,round(coalesce(value,0),0) value from gl_config where field_nme='srvcActivityDateRestriction'";
	    ResultSet resultSetConfig = stmt.executeQuery(sqlConfig);
	   
	    while (resultSetConfig.next()) {
	        method=resultSetConfig.getString("method");
	        methodvalue=resultSetConfig.getString("value");
	    }
	    
	    if(method.equalsIgnoreCase("1")) {
	    	
		    String sqls="select DATEDIFF(now(), '"+sqlDate+"') activitydatecheck";
		    ResultSet resultSet1 = stmt.executeQuery(sqls);
		   
		    while (resultSet1.next()) {
		    	if((resultSet1.getInt("activitydatecheck")<0) || (resultSet1.getInt("activitydatecheck")>Integer.parseInt(methodvalue))) {
		    		val= -1;
		    	}
		    }
	    } 
	    
		response.getWriter().print(val);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  