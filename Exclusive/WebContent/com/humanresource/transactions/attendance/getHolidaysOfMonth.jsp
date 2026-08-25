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
			
			String sql = "",sql2="",weekoff="",weeklyoff="",checkweekoff="0";
    	    String[] weekoffs=null;
    	    
    	    String sql1 = "select woff from hr_paycode where status=3";
    	    ResultSet rs = stmt.executeQuery(sql1);
    	    
    	    while(rs.next()){
    	    	weekoff=rs.getString("woff");
    	    }
    	    
    	    if(weekoff.trim().contains(",")){
    	    	checkweekoff="1";
				weekoffs = weekoff.split(",");
			}
    	    
    	    if(checkweekoff.equalsIgnoreCase("0")){
    	    	
    	    	sql2="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";
    	    	ResultSet rs1 = stmt.executeQuery(sql2);
	    	    
	    	    while(rs1.next()){
	    	    	weeklyoff+=rs1.getString("holidaysofmonth")+",";
	    	    }
	    	    
    	    } else if(checkweekoff.equalsIgnoreCase("1")){
    	    	
    	    	for(int k=0;k<(weekoff.length()-1);k++){
    	    	
    	    	sql2="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
	    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
	    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";
	    	    	ResultSet rs2 = stmt.executeQuery(sql2);
		    	    
		    	    while(rs2.next()){
		    	    	weeklyoff+=rs2.getString("holidaysofmonth")+",";
		    	    }
		    	    
    	    	}
    	    }
		    	    
		 	response.getWriter().write(weeklyoff);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
%>