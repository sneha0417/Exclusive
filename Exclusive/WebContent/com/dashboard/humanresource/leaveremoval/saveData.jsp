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
	 	conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	Statement stmt1 = conn.createStatement();
		
		String documentno=request.getParameter("selecteddocs");
		String selectedempid=request.getParameter("selectedempid");
		String branchid=request.getParameter("branchid").equalsIgnoreCase("a")?"1":request.getParameter("branchid");
		int docno=0;
		String weekoff="",checkweekoff="0",totaldays="";
		ArrayList<String> weeklyoffarray=new ArrayList<String>();
		if(!(documentno.equalsIgnoreCase(""))){                    
				int empid=0,halfday=0;
				String description="",leavetype="";
				java.sql.Date sqlFromDate=null,sqlToDate=null,sqlHalfDayDate=null;  
				
				String sql="select empid, fromdate, todate, halfday, halfdaydate, leavetype,description from hr_leaverequest where status=3 and confirm=1 and doc_no="+documentno+"";
				//System.out.println("sql--->>>"+sql);             
				ResultSet resultSet = stmt.executeQuery(sql);
				  
		        while (resultSet.next()) {
		        	empid=resultSet.getInt("empid");
		        	sqlFromDate=resultSet.getDate("fromdate");
		        	sqlToDate=resultSet.getDate("todate");
		        	halfday=resultSet.getInt("halfday");
		        	sqlHalfDayDate=resultSet.getDate("halfdaydate");
		        	leavetype=resultSet.getString("leavetype");
		        	description=resultSet.getString("description");
		        }
				
		        ArrayList<String> requestedarray=new ArrayList<String>();
		        
		        /*Selecting Requested Dates*/
		        String sql1="select DATE_FORMAT(requested_date,'%d.%m.%Y') requested_date from "
		        		+ " (select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) requested_date from "
		        		+ "	(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,"
		        		+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,"
		        		+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,"
		        		+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,"
		        		+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v"
		        		+ " where requested_date between '"+sqlFromDate+"' and '"+sqlToDate+"'";
		        ResultSet resultSet1=stmt.executeQuery(sql1);

		        while(resultSet1.next()){
				  	requestedarray.add(resultSet1.getString("requested_date"));
			    }
		        /*Selecting Requested Dates Ends*/
		        
			    if(requestedarray.size()>0){
			    
			    for(int j=0;j<requestedarray.size();j++){
			    	int day=0,attendancedate=0,alreadyAttendance=0,validat=0;
			    	String dayofday="0",month="0",year="0";
			    	double totleave1=0.00,totleave2=0.00,totleave3=0.00,totleave4=0.00,totleave5=0.00,totleave6=0.00;
			    	java.sql.Date sqlRequestedDate=ClsCommon.changeStringtoSqlDate(requestedarray.get(j));
			    	
			    	String sql2="select DAY('"+sqlRequestedDate+"') days,DATE_FORMAT('"+sqlRequestedDate+"','%d') dayofday,DATE_FORMAT('"+sqlRequestedDate+"','%m') months,YEAR('"+sqlRequestedDate+"') years";
			    	ResultSet resultSet2=stmt.executeQuery(sql2);

			        while(resultSet2.next()){
			        	day=resultSet2.getInt("days");
			        	dayofday=resultSet2.getString("dayofday");
			        	month=resultSet2.getString("months");
			        	year=resultSet2.getString("years");
				    }
			        
			        /*Selecting Requested Dates info from timesheet*/
			        String sql3="select date"+day+" attendancedate,tot_leave1,tot_leave2,tot_leave3,tot_leave4,tot_leave5,tot_leave6 from hr_timesheet where payroll_processed=0 and empid="+empid+" and year=Year('"+sqlRequestedDate+"') and month=MONTH('"+sqlRequestedDate+"')";
			        System.out.println("sql3--->>>"+sql3);  
			        ResultSet resultSet3=stmt.executeQuery(sql3);
			        
			        while(resultSet3.next()){
			        	attendancedate=resultSet3.getInt("attendancedate");
			        	totleave1=resultSet3.getDouble("tot_leave1");
			        	totleave2=resultSet3.getDouble("tot_leave2");
			        	totleave3=resultSet3.getDouble("tot_leave3");
			        	totleave4=resultSet3.getDouble("tot_leave4");
			        	totleave5=resultSet3.getDouble("tot_leave5");
			        	totleave6=resultSet3.getDouble("tot_leave6");
			        	alreadyAttendance=1;
				    }
			        /*Selecting Requested Dates info from timesheet Ends*/
			        
			        	/*Inserting into timesheet*/
			        	String sql5="";String department="";String category="";
			        	 weekoff="";checkweekoff="0";totaldays="";
			    	    String[] weekoffs=null;   
			    	    weeklyoffarray=new ArrayList<String>();
				        
			    	    String sql4 = "select woff from hr_paycode where status=3";
			    	    ResultSet resultSet4 = stmt.executeQuery(sql4);
			    	    
			    	    while(resultSet4.next()){
			    	    	weekoff=resultSet4.getString("woff");
			    	    }
			    	    
			    	    if(weekoff.trim().contains(",")){
			    	    	checkweekoff="1";
							weekoffs = weekoff.split(",");
						}   
			    	    
			    	    if(checkweekoff.equalsIgnoreCase("0")){
			    	    	
			    	    	sql5="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
			    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
			    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
			    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";
			    	    	ResultSet resultSet5 = stmt.executeQuery(sql5);
				    	    
				    	    while(resultSet5.next()){
				    	    	weeklyoffarray.add(resultSet5.getString("holidaysofmonth"));
				    	    }
			    	    } else if(checkweekoff.equalsIgnoreCase("1")){
			    	    	
			    	    	for(int k=0;k<(weekoff.length()-1);k++){
			    	    	
			    	    	sql5="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
				    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
				    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
				    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";
			    	    	    ResultSet resultSet5 = stmt.executeQuery(sql5);
					    	    
					    	    while(resultSet5.next()){
					    	    	weeklyoffarray.add(resultSet5.getString("holidaysofmonth"));
					    	    }
					    	    
			    	    	}
			    	    }
			    	    
			    	    String sql6="select DAY(LAST_DAY('"+year+"-"+month+"-"+dayofday+"')) totaldays";
			    	    ResultSet resultSet6 = stmt.executeQuery(sql6);
			    	    
			    	    while(resultSet6.next()){
			    	    	totaldays = resultSet6.getString("totaldays");
			    	    }
			    	    
			    	    String attendance="",attendance1="";
			    	    //System.out.println(weeklyoffarray+"<<<--->>>"+totaldays);        	
					 /*    String sql7="INSERT INTO hr_timesheet(empId, year, month, totdays, brhid) VALUES("+empid+", "+year+", "+month+", "+totaldays+", "+branchid+")";
					    int data = stmt.executeUpdate(sql7);
						if(data<=0){
							stmt.close();
							conn.close();
							response.getWriter().print(0);
							return;
						} */    
						
			    	  /*   for (int l = 1; l <= Integer.parseInt(totaldays); l++) {
			    	    	attendance="1"; attendance1="1";
			    	    	
			    	    	for(int z=0;z<weeklyoffarray.size();z++){
			    	    		if(l==(Integer.parseInt(weeklyoffarray.get(z)))) {
			    	    			attendance="2";
			    	    		}
			    	    	}
			    	    
			    	        if(!(attendance1.equalsIgnoreCase("1") && attendance.equalsIgnoreCase("2"))){
			    	        	attendance=attendance1;
						    }
			    	        
			    	        String sql8="UPDATE hr_timesheet SET date"+l+"="+attendance+" WHERE payroll_processed=0 and empId="+empid+" and year="+year+" and month="+month+"";
			    	        int data1 = stmt.executeUpdate(sql8);
							if(data1<=0){
								stmt.close();
								conn.close();
								response.getWriter().print(0);
								return;
							}
							*/
							 /*Date of Joining checking*/
			    	      /*   String sqldj="";
			    	        if(l<10){
			    	        	sqldj="select dtjoin from hr_empm where status=3 and active=1 and dtjoin='"+year+"-"+month+"-0"+l+"' and doc_no="+empid+"";
			    	        } else {
			    	        	sqldj="select dtjoin from hr_empm where status=3 and active=1 and dtjoin='"+year+"-"+month+"-"+l+"' and doc_no="+empid+"";
			    	        }
			    	        ResultSet resultSetdj = stmt.executeQuery(sqldj);
				    	    
			    	        while(resultSetdj.next()){
			    	        	String joiningdate = resultSetdj.getString("dtjoin");
			    	        	
			    	        	for (int dj = 1; dj < l; dj++) {
			    	        		
			    	        		String sqldj1="UPDATE hr_timesheet SET date"+dj+"=0 WHERE payroll_processed=0 and empId="+empid+" and year="+year+" and month="+month+"";
			    	        		int datadj1 =stmt1.executeUpdate(sqldj1);
			    	        		if(datadj1<=0){
										stmt1.close();
										conn.close();
										response.getWriter().print(0);
										return;
									}
					    	        
			    	        	}
			    	        	
			    	        	
			    	        } */
			    	        /*Date of Joining checking Ends*/
							   
			    	      /* } */      
			       
			        /*Inserting into timesheet Ends*/
			        
			        int marknewattendance=0;String sqltotalsub="",sqltotaladd="";
			        String sql9="select refno from hr_timesheetset where reftype='L' and doc_no="+leavetype+"";
			        ResultSet resultSet7 = stmt.executeQuery(sql9);
			        while (resultSet7.next()) {
			        	marknewattendance=resultSet7.getInt("refno");
			        }
			        
			        if(halfday==1 && (sqlHalfDayDate.compareTo(sqlRequestedDate)==0)) {
			        	marknewattendance=Integer.parseInt(marknewattendance+"2");
			        }
			       
			        if(attendancedate!=1 && attendancedate!=2) {
			        	if(attendancedate==3 && totleave1!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave1=(tot_leave1-1)";
			        	} else if(attendancedate==4 && totleave2!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave2=(tot_leave2-1)";
			        	} else if(attendancedate==5 && totleave3!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave3=(tot_leave3-1)";
			        	} else if(attendancedate==6 && totleave4!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave4=(tot_leave4-1)";
			        	} else if(attendancedate==7 && totleave5!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave5=(tot_leave5-1)";
			        	} else if(attendancedate==8 && totleave6!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave6=(tot_leave6-1)";
			        	} else if(attendancedate==32 && totleave1!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave1=(tot_leave1-0.5)";
			        	} else if(attendancedate==42 && totleave2!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave2=(tot_leave2-0.5)";
			        	} else if(attendancedate==52 && totleave3!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave3=(tot_leave3-0.5)";
			        	} else if(attendancedate==62 && totleave4!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave4=(tot_leave4-0.5)";
			        	} else if(attendancedate==72 && totleave5!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave5=(tot_leave5-0.5)";
			        	} else if(attendancedate==82 && totleave6!=0) {
			        		sqltotalsub=sqltotalsub+",tot_leave6=(tot_leave6-0.5)";
			        	}
			        }
			        //System.out.println("day--->>>"+day); 
				    for(int z=0;z<weeklyoffarray.size();z++){
			    	    		if(day==(Integer.parseInt(weeklyoffarray.get(z)))) {
			    	    			validat=1;   
			    	    		}    
			    	}
			        if(validat==1){    
			        	marknewattendance=2;
			        }else{    
			        	marknewattendance=1;        
			        }
			        //System.out.println("validat--->>>"+validat);  
			        String sql10="UPDATE hr_timesheet SET date"+day+"="+marknewattendance+""+sqltotalsub+" WHERE payroll_processed=0 and empId="+empid+" and year=Year('"+sqlRequestedDate+"') and month=MONTH('"+sqlRequestedDate+"')";
			        //System.out.println("sql10--->>>"+sql10);     
			        int data2 = stmt.executeUpdate(sql10);
					if(data2<=0){
						stmt.close();
						conn.close();
						response.getWriter().print(0);
						return;
					}
			        
			    }
			   
			   /*Updating hr_leaverequest*/  
			   String sql11="UPDATE hr_leaverequest SET status=5 where status=3 and doc_no="+documentno+"";            
			   int data3 = stmt.executeUpdate(sql11);
			   if(data3<=0){
					stmt.close();
					conn.close();
					response.getWriter().print(0);
					return;
			   }
			   /*Updating hr_leaverequest Ends*/
			}
		  }
		
		String sql12="select coalesce(max(doc_no)+1,1) doc_no from hr_blrl";
	    ResultSet resultSet12 = stmt.executeQuery(sql12);
			  
		while (resultSet12.next()) {
			 docno=resultSet12.getInt("doc_no");
		}
			        
	    String sql13="insert into hr_blrl(doc_no, date, req_docno, req_empid, brhid, userid) values('"+docno+"', now(), '"+documentno+"', '"+selectedempid+"', '"+branchid+"', '"+session.getAttribute("USERID").toString()+"')";
	    int data4 = stmt.executeUpdate(sql13);
		if(data4<=0){
			stmt.close();
			conn.close();
			response.getWriter().print(0);
			return;
		}
			        
		String sql14="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchid+"','BLRL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		int data5 = stmt.executeUpdate(sql14);
		if(data5<=0){
			stmt.close();
			conn.close();
			response.getWriter().print(0);  
			return;
		}
				 
		conn.commit();
		
		response.getWriter().print(docno);

	 	stmt.close();
	 	stmt1.close();
	 	conn.close();
	} catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
   } finally{
	   conn.close();
   }
	%>
