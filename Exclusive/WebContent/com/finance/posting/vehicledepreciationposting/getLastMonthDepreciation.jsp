<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsCommon commonDAO = new ClsCommon();
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String deprDate="0";
		String dateDiff="0";
		java.sql.Date sqlDate=null;
		String dates="",dated="",deprDates="",deprDated="",lastDeprDates="";
		int days=0,dateCheck=0,noofdays=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=commonDAO.changeStringtoSqlDate(date);
		}
	    
		String sql = "select DATEDIFF(LAST_DAY('"+sqlDate+"'),'"+sqlDate+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		} 
		
		String sqls = "select DATE_FORMAT(min(date),'%d-%m-%Y') deprdates from (select v.depr_date date from gl_vehmaster v left join gc_assettran g on " 
				+ "v.fleet_no=g.fleet_no where v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and v.brhid='"+branch+"' group by v.fleet_no having "
		        + " sum(g.dramount)>0 order by depr_date) a";
		
		ResultSet rs2 = stmt.executeQuery(sqls);
		
		while(rs2.next()) {
			deprDates=rs2.getString("deprdates");
		}
		
		if(dateDiff.equalsIgnoreCase("0")){

		   String strSql = "select v.fleet_no,v.depr_date deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(v.depr_date)) deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),"
		    		 + "min(v.depr_date))) dateDiff,DAY(LAST_DAY('"+sqlDate+"')) noofdays from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no where "
		    		 + "v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and v.brhid='"+branch+"' group by v.fleet_no having sum(g.dramount)>0 order by depr_date";
		   // System.out.println("====== "+strSql);
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				deprDated=rs.getString("deprDiff");
				dates=rs.getString("deprdate");
				dateCheck=rs.getInt("dateDiff");
				noofdays=rs.getInt("noofdays");
				
				if(dateCheck>noofdays){
					deprDate="0";
					dateDiff="0";
					break;					
				}
				
				if(dateCheck>0 && dateCheck<=noofdays){
					deprDate="1";
					dateDiff="0";
					break;
				}
				
				if(dateCheck<=0 && !(deprDate=="1") && !(dateDiff=="0")){
					deprDate="2";
					dateDiff="0";
				}
			}	
		}else{
		        dateDiff="2";
	    }
		
		response.getWriter().write(deprDate+"***"+dateDiff+"***"+deprDates);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  