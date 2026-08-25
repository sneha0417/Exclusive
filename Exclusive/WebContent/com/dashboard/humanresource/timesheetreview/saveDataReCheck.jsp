<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement();
		 Statement stmt1 = conn.createStatement();
		
		 String year=request.getParameter("year");
		 String month=request.getParameter("month");
	   	 String mode=request.getParameter("mode");
	
		 int val=0;
	
		 if(mode.equalsIgnoreCase("A")) {
			 
			 /*Add */
			 
			    ArrayList<String> weeklyoffarray=new ArrayList<String>();
		        ArrayList<String> employeearray=new ArrayList<String>();
		        
		             
	    	    String sql1="",weekoff="",checkweekoff="0";
	    	    String[] weekoffs=null;
	    	    
	    	    String sql = "select woff from hr_paycode where status=3 and timesheet=1";
	    	    ResultSet resultSet = stmt.executeQuery(sql);
	    	    
	    	    while(resultSet.next()){
	    	    	weekoff=resultSet.getString("woff");
	    	    }
	    	    
	    	    if(weekoff.trim().contains(",")){
	    	    	checkweekoff="1";
					weekoffs = weekoff.split(",");
				}
	    	    
	    	    if(checkweekoff.equalsIgnoreCase("0")){
	    	    	
	    	    	
	    	    	sql1="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
	    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
	    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";

	    	    	ResultSet resultSet1 = stmt.executeQuery(sql1);
		    	    
		    	    while(resultSet1.next()){
		    	    	weeklyoffarray.add(resultSet1.getString("holidaysofmonth"));
		    	    }
	    	    }else if(checkweekoff.equalsIgnoreCase("1")){
	    	    	
	    	    	for(int k=0;k<(weekoff.length()-1);k++){
	    	    	
	    	    	sql1="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
		    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
		    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
		    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";

	    	    	ResultSet resultSet1 = stmt.executeQuery(sql1);
			    	    
			    	    while(resultSet1.next()){
			    	    	weeklyoffarray.add(resultSet1.getString("holidaysofmonth"));
			    	    }
			    	    
	    	    	}
	    	    }
	    	    
	    	    String sql2="select m.doc_no,m.codeno,t.year,t.month from hr_empm m left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) left join hr_timesheet t on "
	    	    		+ "(m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"') where m.status=3 and c.timesheet=1 and (t.year is null or t.month is null) and "
	    	    		+ "m.dtjoin<=LAST_DAY('"+year+"-"+month+"-01')";

	    	    ResultSet resultSet2 = stmt.executeQuery(sql2);
	    	    
	    	    while(resultSet2.next()){
	    	    	employeearray.add(resultSet2.getString("doc_no"));
	    	    }
	    	    
				String sql3="select DAY(LAST_DAY('"+year+"-"+month+"-01')) totaldays";
	    	    ResultSet resultSet3 = stmt.executeQuery(sql3);
	    	    
	    	    String totaldays="0";
	    	    while(resultSet3.next()){
	    	    	totaldays = resultSet3.getString("totaldays");
	    	    }
				
	    	    String attendance="",attendance1="";
	    	    for(int e=0;e<employeearray.size();e++){
	    	    	
					   String sql4="INSERT INTO hr_timesheet(empId, year, month, totdays, brhid) VALUES("+employeearray.get(e)+", "+year+", "+month+", "+totaldays+", "+session.getAttribute("BRANCHID").toString()+")";
					   stmt.executeUpdate(sql4);
	    	    	
	    	    for (int l = 1; l <= Integer.parseInt(totaldays); l++) {
	    	    	attendance="1"; attendance1="1";
	    	    	
	    	    	for(int j=0;j<weeklyoffarray.size();j++){
	    	    		if(l==(Integer.parseInt(weeklyoffarray.get(j)))) {
	    	    			attendance="2";
	    	    		}
	    	    	}
	    	    
	    	        if(!(attendance1.equalsIgnoreCase("1") && attendance.equalsIgnoreCase("2"))){
	    	        	attendance=attendance1;
				    }
	    	        
	    	        String sql5="UPDATE hr_timesheet SET date"+l+"="+attendance+" WHERE payroll_processed=0 and empId="+employeearray.get(e)+" and year="+year+" and month="+month+"";
	    	        stmt.executeUpdate(sql5);
	    	        
	    	      }
	    	    
	    	    }
	    	    
	    	    String sql6="select b.rowno,b.date,b.empid from ( select a.empid,a.rowno,a.date,CASE WHEN DAY(a.date)=t.date1 THEN t.date1 WHEN DAY(a.date)=t.date2 THEN t.date2 WHEN DAY(a.date)=t.date3 THEN t.date3 "
	    	    		   + "WHEN DAY(a.date)=t.date4 THEN t.date4 WHEN DAY(a.date)=t.date5 THEN t.date5 WHEN DAY(a.date)=t.date6 THEN t.date6 WHEN DAY(a.date)=t.date7 THEN t.date7 WHEN DAY(a.date)=t.date8 "
	    	    		   + "THEN t.date8 WHEN DAY(a.date)=t.date9 THEN t.date9 WHEN DAY(a.date)=t.date10 THEN t.date10 WHEN DAY(a.date)=t.date11 THEN t.date11 WHEN DAY(a.date)=t.date12 THEN t.date12 "
	    	    		   + "WHEN DAY(a.date)=t.date13 THEN t.date13 WHEN DAY(a.date)=t.date14 THEN t.date14 WHEN DAY(a.date)=t.date15 THEN t.date15 WHEN DAY(a.date)=t.date16 THEN t.date16 WHEN DAY(a.date)=t.date17 THEN t.date17 "
	    	    		   + "WHEN DAY(a.date)=t.date18 THEN t.date18 WHEN DAY(a.date)=t.date19 THEN t.date19 WHEN DAY(a.date)=t.date20 THEN t.date20 WHEN DAY(a.date)=t.date21 THEN t.date21 WHEN DAY(a.date)=t.date22 THEN t.date22 "
	    	    		   + "WHEN DAY(a.date)=t.date23 THEN t.date23 WHEN DAY(a.date)=t.date24 THEN t.date24 WHEN DAY(a.date)=t.date25 THEN t.date25 WHEN DAY(a.date)=t.date26 THEN t.date26 WHEN DAY(a.date)=t.date27 THEN t.date27 "
	    	    		   + "WHEN DAY(a.date)=t.date28 THEN t.date28 WHEN DAY(a.date)=t.date29 THEN t.date29 WHEN DAY(a.date)=t.date30 THEN t.date30 WHEN DAY(a.date)=t.date31 THEN t.date31 ELSE 0 END AS result from "
	    	    		   + "hr_timesheet t left join (select rowno,status,date,empid from hr_timesheethrs where status=3 and YEAR(date)='"+year+"' and MONTH(date)='"+month+"' group by date,empid) a on "
	    	    		   + "(a.empid=t.empid and YEAR(a.date)=t.year and MONTH(a.date)=t.month) where a.status=3 and t.payroll_processed=0 and t.month='"+month+"' and t.year='"+year+"') b where b.result between 3 and 6";

	    	    ResultSet resultSet6 = stmt.executeQuery(sql6);
	    		  
	   	     while (resultSet6.next()) {
	   	    	  
	   	    	String sql7="UPDATE hr_timesheethrs SET status=7 WHERE rowno="+resultSet6.getInt("rowno")+"";
    	        stmt1.executeUpdate(sql7);
	   	     }
	   	     
	     	/*Add Ends*/
	     	
		 } 
		 
		 int docno=0;
		 String sql10="select coalesce(max(doc_no)+1,1) doc_no from hr_btsr";
	     ResultSet resultSet10 = stmt.executeQuery(sql10);
	  
	     while (resultSet10.next()) {
	    	  docno=resultSet10.getInt("doc_no");
	     }
	     
     	 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','BTSR',now(),'"+session.getAttribute("USERID").toString()+"','"+mode+"')";
	 	 val= stmt.executeUpdate(sqls);
		 				
		response.getWriter().print(val);

		stmt1.close();
	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
