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
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String employeeId=request.getParameter("employee");
		String cellcolumn=request.getParameter("cellcolumn");
		String attendance=request.getParameter("cellvalue");
		String oldattendance=request.getParameter("cellvalue");
		String totaldays=request.getParameter("totdays");
		String leave1total=request.getParameter("leave1total");
		String leave2total=request.getParameter("leave2total");
		String leave3total=request.getParameter("leave3total");
		String leave4total=request.getParameter("leave4total");
		String leave5total=request.getParameter("leave5total");
		String leave6total=request.getParameter("leave6total");
		String emptotalleavesarray=request.getParameter("emptotalleavesarray");
		String emptotalleavesgridlength=request.getParameter("emptotalleavesgridlength");
		String overtimevalue=request.getParameter("overtimevalue");
		String holidayovertimevalue=request.getParameter("holidayovertimevalue");
		String category=request.getParameter("category");
		String department=request.getParameter("department");
		String markall=request.getParameter("markall");
		String funtype=request.getParameter("funtype");
		String days=cellcolumn.substring(4);
		
		String sql=null;
		int val=0,overtime=0,holidayovertime=0;
		ArrayList<String> weeklyoffarray=new ArrayList<String>();
		
		if(funtype.equalsIgnoreCase("1")){
		
			/*Marking Attendance*/
     	 	
			if(markall.equalsIgnoreCase("1")){
			
					String sql1="";
					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.pay_catid='"+category+"'";
			        }
					
					if(!(department.equalsIgnoreCase("0")) && !(department.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.dept_id='"+department+"'";
			        }
				
					sql="UPDATE hr_timesheet t,hr_empm m SET t."+cellcolumn+"="+attendance+",t.tot_leave1="+leave1total+",t.tot_leave2="+leave2total+",t.tot_leave3="+leave3total+",t.tot_leave4="+leave4total+",t.tot_leave5="+leave5total+",t.tot_leave6="+leave6total+",t.tot_ot="+overtimevalue+",t.tot_hot="+holidayovertimevalue+" WHERE t.empid=m.doc_no and t.payroll_processed=0 and t.year="+year+" and t.month="+month+""+sql1+"";
					val= stmt.executeUpdate(sql);
     	 			
			} else {
			
					sql="UPDATE hr_timesheet SET "+cellcolumn+"="+attendance+",tot_leave1="+leave1total+",tot_leave2="+leave2total+",tot_leave3="+leave3total+",tot_leave4="+leave4total+",tot_leave5="+leave5total+",tot_leave6="+leave6total+",tot_ot="+overtimevalue+",tot_hot="+holidayovertimevalue+" WHERE payroll_processed=0 and empId="+employeeId+" and year="+year+" and month="+month+"";
					val= stmt.executeUpdate(sql);
     	 	}
			
     	 	/*Marking Attendance Ends*/

		} else if(funtype.equalsIgnoreCase("2")){
			
			/*Deleting Attendance*/
			
			String sql2=null,weekoff="",checkweekoff="0",attendance1="",checking="0";
    	    String[] weekoffs=null;
    	    
    	    String sql1 = "select woff from hr_paycode where status=3";
    	    ResultSet resultSet1 = stmt.executeQuery(sql1);
    	    
    	    while(resultSet1.next()){
    	    	weekoff=resultSet1.getString("woff");
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
    	    	ResultSet resultSet3 = stmt.executeQuery(sql2);
	    	    
	    	    while(resultSet3.next()){
	    	    	weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
	    	    }
    	    }else if(checkweekoff.equalsIgnoreCase("1")){
    	    	
    	    	for(int k=0;k<(weekoff.length()-1);k++){
    	    	
    	    	sql2="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
	    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
	    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";
	    	    	ResultSet resultSet3 = stmt.executeQuery(sql2);
		    	    
		    	    while(resultSet3.next()){
		    	    	weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
		    	    }
		    	    
    	    	}
    	    }
    	    
    	    	attendance="1";
    	    	for(int j=0;j<weeklyoffarray.size();j++){
    	    		if(Integer.parseInt(days)==(Integer.parseInt(weeklyoffarray.get(j)))) {
    	    			attendance="2";
    	    		}
    	    	}
    	    	
    	    		if(oldattendance.equalsIgnoreCase("T")){leave1total=String.valueOf(Integer.parseInt(leave1total)-1);} 
                	if(oldattendance.equalsIgnoreCase("S")){leave2total=String.valueOf(Integer.parseInt(leave2total)-1);}
                	if(oldattendance.equalsIgnoreCase("C")){leave3total=String.valueOf(Integer.parseInt(leave3total)-1);} 
                	if(oldattendance.equalsIgnoreCase("A")){leave4total=String.valueOf(Integer.parseInt(leave4total)-1);}
                	if(oldattendance.equalsIgnoreCase("M")){leave5total=String.valueOf(Integer.parseInt(leave5total)-1);}
                	if(oldattendance.equalsIgnoreCase("U")){leave6total=String.valueOf(Integer.parseInt(leave6total)-1);}
                	if(oldattendance.equalsIgnoreCase("T2")){leave1total=String.valueOf(Integer.parseInt(leave1total)-(0.5));} 
                	if(oldattendance.equalsIgnoreCase("S2")){leave2total=String.valueOf(Integer.parseInt(leave2total)-(0.5));}
                	if(oldattendance.equalsIgnoreCase("C2")){leave3total=String.valueOf(Integer.parseInt(leave3total)-(0.5));}
                	if(oldattendance.equalsIgnoreCase("A2")){leave4total=String.valueOf(Integer.parseInt(leave4total)-(0.5));} 
                	if(oldattendance.equalsIgnoreCase("M2")){leave5total=String.valueOf(Integer.parseInt(leave5total)-(0.5));}
                	if(oldattendance.equalsIgnoreCase("U2")){leave6total=String.valueOf(Integer.parseInt(leave6total)-(0.5));} 
                	
                	if(oldattendance.trim().contains(":")){
                		for(int j=0;j<weeklyoffarray.size();j++){
            	    		if(Integer.parseInt(days)==(Integer.parseInt(weeklyoffarray.get(j)))) {
            	    			checking="1";
            	    		}
            	    		
            	    		if(checking.equalsIgnoreCase("1")){
            	    			String[] hourMin = oldattendance.split(":");
            	    		    int hour = Integer.parseInt(hourMin[0]);
            	    		    int mins = Integer.parseInt(hourMin[1]);
            	    		    int hoursInMins = hour * 60;
            	    		    holidayovertime=hoursInMins + mins;
            	    		    holidayovertimevalue=String.valueOf(Integer.parseInt(holidayovertimevalue)-(holidayovertime));
            	    		    break;
            	    		}
            	    	}
                		
                		if(checking.equalsIgnoreCase("0")){
                			String[] hourMin = oldattendance.split(":");
        	    		    int hour = Integer.parseInt(hourMin[0]);
        	    		    int mins = Integer.parseInt(hourMin[1]);
        	    		    int hoursInMins = hour * 60;
        	    		    overtime=hoursInMins + mins;
        	    		    overtimevalue=String.valueOf(Integer.parseInt(overtimevalue)-(overtime));
        	    		}
                		
                	}
               
			if(markall.equalsIgnoreCase("1")){
            			
					String sql3="";
	    					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
						sql3=sql3+" and m.pay_catid='"+category+"'";
					}
					
					if(!(department.equalsIgnoreCase("0")) && !(department.equalsIgnoreCase(""))){
						sql3=sql3+" and m.dept_id='"+department+"'";
					}
				
					sql="UPDATE hr_timesheet t,hr_empm m SET t."+cellcolumn+"="+attendance+",t.tot_leave1="+leave1total+",t.tot_leave2="+leave2total+",t.tot_leave3="+leave3total+",t.tot_leave4="+leave4total+",t.tot_leave5="+leave5total+",t.tot_leave6="+leave6total+",t.tot_ot="+overtimevalue+",t.tot_hot="+holidayovertimevalue+" WHERE t.empid=m.doc_no and t.payroll_processed=0 and t.year="+year+" and t.month="+month+""+sql3+"";
					val= stmt.executeUpdate(sql);
             	 			
        	} else {
			
					 sql="UPDATE hr_timesheet SET "+cellcolumn+"="+attendance+",tot_leave1="+leave1total+",tot_leave2="+leave2total+",tot_leave3="+leave3total+",tot_leave4="+leave4total+",tot_leave5="+leave5total+",tot_leave6="+leave6total+",tot_ot="+overtimevalue+",tot_hot="+holidayovertimevalue+" WHERE payroll_processed=0 and empId="+employeeId+" and year="+year+" and month="+month+"";
					 val= stmt.executeUpdate(sql);	
			
			}
			
			/*Deleting Attendance Ends*/
			
		}  else if(funtype.equalsIgnoreCase("3")){
			
			/*Saving Total Leaves*/
			
			if(markall.equalsIgnoreCase("1")){
				
				for(int j=0;j<Integer.parseInt(emptotalleavesgridlength);j++){
					
					String[] totalleavesarray=emptotalleavesarray.split(",");
					String [] emptotleavesarray = totalleavesarray[j].split("::"); 

					sql="UPDATE hr_timesheet SET tot_leave1="+emptotleavesarray[1]+",tot_leave2="+emptotleavesarray[2]+",tot_leave3="+emptotleavesarray[3]+",tot_leave4="+emptotleavesarray[4]+",tot_leave5="+emptotleavesarray[5]+",tot_leave6="+emptotleavesarray[6]+" WHERE payroll_processed=0 and empId="+emptotleavesarray[0]+" and year="+year+" and month="+month+"";
					val= stmt.executeUpdate(sql);
					
				}
				
			} else {
				
				sql="UPDATE hr_timesheet SET tot_leave1="+leave1total+",tot_leave2="+leave2total+",tot_leave3="+leave3total+",tot_leave4="+leave4total+",tot_leave5="+leave5total+",tot_leave6="+leave6total+" WHERE payroll_processed=0 and empId="+employeeId+" and year="+year+" and month="+month+"";
				val= stmt.executeUpdate(sql);
				
			}
			
			/*Saving Total Leaves Ends*/
			
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
