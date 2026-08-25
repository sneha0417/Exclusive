<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String deprDate="0";
		String dateDiff="0";
		java.sql.Date sqlDate=null;
		String dates="",dated="",deprDates="",deprDated="",lastDeprDates="";
		int days=0,dateCheck=0,noofdays=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
	    
		String sql = "select DATEDIFF(LAST_DAY('"+sqlDate+"'),'"+sqlDate+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		}

		String sqls = "select DATE_FORMAT(min(date),'%d-%m-%Y') deprdates from (select coalesce(v.depr_date,v.purdate) date from my_fixm v left join "  +" my_fatran g on v.sr_no=g.asset_no where v.status=3 and v.brhid='"+branch+"' group by v.sr_no having sum(round(g.dramount,2))>0 order by depr_date) a";
		
		ResultSet rs2 = stmt.executeQuery(sqls);
		
		while(rs2.next()) {
			deprDates=rs2.getString("deprdates");
		}
		
		if(dateDiff.equalsIgnoreCase("0")){

    		/* String strSql = "select v.sr_no asset_no,min(coalesce(v.depr_date,v.purdate)) deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(coalesce(v.depr_date,v.purdate))) " 
    				+ "deprDiff,(((DATEDIFF(last_day('"+sqlDate+"'),min(coalesce(v.depr_date,v.purdate)))) - (DATEDIFF(DATE_SUB(last_day('"+sqlDate+"'), INTERVAL 1 MONTH),"
    				+ "min(coalesce(v.depr_date,v.purdate))))) + (DATEDIFF(DATE_SUB(last_day('"+sqlDate+"'), INTERVAL 1 MONTH),min(coalesce(v.depr_date,v.purdate))))) "
    				+ "dateDiff,min(coalesce(DATE_FORMAT(v.depr_date,'%d-%m-%Y'),DATE_FORMAT(v.purdate,'%d-%m-%Y'))) deprdates,DAY(LAST_DAY('"+sqlDate+"')) noofdays from my_fixm v left join my_fatran g on "
    				+ "v.sr_no=g.asset_no where v.status=3 and v.brhid='"+branch+"' group by v.sr_no having sum(g.dramount)>0 order by depr_date ";
    		 */
    		 
    		 String strSql = "select v.sr_no asset_no,min(coalesce(v.depr_date,v.purdate)) deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(coalesce(v.depr_date,v.purdate))) " 
     				+ "deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),min(coalesce(v.depr_date,v.purdate))))  "
     				+ "dateDiff,min(coalesce(DATE_FORMAT(v.depr_date,'%d-%m-%Y'),DATE_FORMAT(v.purdate,'%d-%m-%Y'))) deprdates,DAY(LAST_DAY('"+sqlDate+"')) noofdays from my_fixm v left join my_fatran g on "
     				+ "v.sr_no=g.asset_no where v.status=3 and v.brhid='"+branch+"' group by v.sr_no having sum(round(g.dramount,2))>0 order by depr_date ";
     		
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				deprDated=rs.getString("deprDiff");
				dates=rs.getString("deprdate");
				dateCheck=rs.getInt("dateDiff");
				noofdays=rs.getInt("noofdays");
				
				// pending last month
				if(dateCheck > noofdays ){
					deprDate="0";
					dateDiff="0";
					break;					
				}
			
				// loading grid inside one month
				if(dateCheck>0 && dateCheck<=noofdays){
					deprDate="1";
					dateDiff="0";
					break;
				}
				
				// condition for already done
				if(dateCheck<=0 && !(deprDate=="1") && !(dateDiff=="0")){
					deprDate="2";
					dateDiff="0";
				}
			}  
		} else{
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
  