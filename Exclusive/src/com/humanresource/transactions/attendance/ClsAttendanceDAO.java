package com.humanresource.transactions.attendance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAttendanceDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

		public JSONArray attendanceGridLoading(HttpSession session,String totaldays,String year,String month,String day,String department,String category,String empid) throws SQLException {
		    
			Connection conn=null;
		    JSONArray RESULTDATA=new JSONArray();

		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtATTN = conn.createStatement();
			        Statement stmtATTN1 = conn.createStatement();
			        
			        ArrayList<String> employeearray=new ArrayList<>();
			        
			        Enumeration<String> Enumeration = session.getAttributeNames();
			           int a=0;
			           while(Enumeration.hasMoreElements()){
			            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
			             a=1;
			            }
			           }
			           if(a==0){
			         return RESULTDATA;
			            }
			             
			           String branchid=session.getAttribute("BRANCHID").toString();
			        
		    	    
		    	    
		    	    String sql3="select m.doc_no,m.codeno,t.year,t.month from hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and "  
		    	    		+ "t.month='"+month+"' where m.status=3 and (t.year is null or t.month is null) and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')";
		    	    ResultSet resultSet4 = stmtATTN1.executeQuery(sql3);
		    	    
		    	    while(resultSet4.next()){
		    	    	employeearray.add(resultSet4.getString("doc_no"));
		    	    }
		    	    
					String sql4="select DAY(LAST_DAY('"+year+"-"+month+"-"+day+"')) totaldays";
		    	    ResultSet resultSet5 = stmtATTN1.executeQuery(sql4);
		    	    
		    	    while(resultSet5.next()){
		    	    	totaldays = resultSet5.getString("totaldays");
		    	    }
					
		    	    String attendance="",attendance1="";
		    	    for(int e=0;e<employeearray.size();e++){
		    	    	
		    	    	ArrayList<String> weeklyoffarray=new ArrayList<>();
		    	    	String sql2="",weekoff="",checkweekoff="0";
			    	    String[] weekoffs=null;
		    	    	String sql1 = "select woff from hr_paycode where status=3 and catid=(select pay_catid from hr_empm where status=3 and active=1 and doc_no="+employeearray.get(e)+")";
			    	    ResultSet resultSet1 = stmtATTN1.executeQuery(sql1);
			    	    
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
			    	    	
			    	    	ResultSet resultSet3 = stmtATTN1.executeQuery(sql2);
				    	    
				    	    while(resultSet3.next()){
				    	    	weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
				    	    }
				    	    
			    	    } else if(checkweekoff.equalsIgnoreCase("1")){
			    	    	
			    	    	for(int k=0;k<(weekoff.length()-1);k++){
			    	    	
			    	    	sql2="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
				    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
				    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
				    	    		+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";

				    	    	ResultSet resultSet3 = stmtATTN1.executeQuery(sql2);
					    	    
					    	    while(resultSet3.next()){
					    	    	weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
					    	    }
					    	    
			    	    	}
			    	    }
		    	    	
						String sql5="INSERT INTO hr_timesheet(empId, year, month, totdays, brhid) VALUES("+employeearray.get(e)+", "+year+", "+month+", "+totaldays+", "+branchid+")";
						stmtATTN1.executeUpdate(sql5);
		    	    	
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
			    	        
			    	        String sqldtjoin="select coalesce(DAY(dtjoin),0) days from hr_empm where MONTH(dtjoin)='"+month+"' and YEAR(dtjoin)='"+year+"' and doc_no="+employeearray.get(e)+" and "+l+"<coalesce(DAY(dtjoin),0)";
				    	    ResultSet resultSetDtJoin = stmtATTN1.executeQuery(sqldtjoin);
					        int joinedMonth=0,joinedDays=0;
					    	while(resultSetDtJoin.next()){
					    	    joinedDays=resultSetDtJoin.getInt("days");
					    	    joinedMonth=1;
					    	}
					    	
					    	if(joinedMonth==1){
						    	for (int k = 1; k <= joinedDays; k++) {
						    		
						    		if(k==l){
//						    			String sql6="UPDATE hr_timesheet SET date"+l+"=999 WHERE payroll_processed=0 and empId="+employeearray.get(e)+" and year="+year+" and month="+month+"";
						    			String sql6="UPDATE hr_timesheet SET date"+l+"="+attendance+" WHERE payroll_processed=0 and empId="+employeearray.get(e)+" and year="+year+" and month="+month+"";
						    			stmtATTN1.executeUpdate(sql6);
						    		}
						    	}
					    	} else {
			    	        
					    		String sql6="UPDATE hr_timesheet SET date"+l+"="+attendance+" WHERE payroll_processed=0 and empId="+employeearray.get(e)+" and year="+year+" and month="+month+"";
					    		stmtATTN1.executeUpdate(sql6);
					    	}
					    	
			    	      }
		    	    
		    	    }
		    	    
		    	    String sql = "";
		    	    
		            if(!(department.equalsIgnoreCase(""))){
		             sql=sql+" and m.dept_id like '%"+department+"%'";
		            }
		            if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and m.pay_catid like '%"+category+"%'";
		            }
		            if(!(empid.equalsIgnoreCase(""))){
		                sql=sql+" and m.doc_no like '%"+empid+"%'";
		            }
		            
		            String sql7 = "select method from gl_config where field_nme='HRAttendanceLeaveEditEnable'";
		            ResultSet resultSet7 = stmtATTN1.executeQuery(sql7);
		            String method="";
					while(resultSet7.next()) {
						method=resultSet7.getString("method");
					}
					
					if(method.equalsIgnoreCase("1")) {
						
						/*Attendance Leave Edit Enable*/
						
						sql = "select m.doc_no employeedocno,m.codeno employeeid,UPPER(m.name) employeename,t.totdays days,t.payroll_processed,coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) date1,"  
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) date2,coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) date3,"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) date4,coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) date5,"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) date6,coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) date7,"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) date8,coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) date9,"  
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) date10,coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) date11,"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) date12,coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) date13,"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) date14,coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) date15," 
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) date16,coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) date17,"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) date18,coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) date19,"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) date20,coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) date21,"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) date22,coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) date23,"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) date24,coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) date25,"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) date26,coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) date27,"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) date28,coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) date29,"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) date30,coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) date31,"
								+ "t.tot_leave1 leave1total,t.tot_leave2 leave2total,t.tot_leave3 leave3total,t.tot_leave4 leave4total,t.tot_leave5 leave5total,t.tot_leave6 leave6total,"
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) totalovertimes,"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) totalholidayovertimes from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
								+ "left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 "
								+ "left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 " 
								+ "left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 "
								+ "left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on "
								+ "s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset "
								+ "s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join "
								+ "hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 "
								+ "left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 "
								+ "left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 "  
								+ "left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 "
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Enable Ends*/
						
					} else {
		            
						/*Attendance Leave Edit Disable */
						
						sql = "select m.doc_no employeedocno,m.codeno employeeid,UPPER(m.name) employeename,t.totdays days,t.payroll_processed,coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) date1," 
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) date2,coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) date3,"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) date4,coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) date5,"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) date6,coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) date7,"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) date8,coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) date9," 
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) date10,coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) date11,"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) date12,coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) date13,"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) date14,coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) date15,"  
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) date16,coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) date17,"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) date18,coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) date19,"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) date20,coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) date21,"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) date22,coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) date23,"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) date24,coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) date25,"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) date26,coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) date27,"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) date28,coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) date29,"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) date30,coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) date31,"
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) totalovertimes,"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) totalholidayovertimes from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
								+ "left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 "
								+ "left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 " 
								+ "left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 "
								+ "left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on "
								+ "s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset "
								+ "s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join "
								+ "hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 "
								+ "left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 "
								+ "left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 "  
								+ "left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 "
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Disable Ends*/
					}
					
					ResultSet resultSet = stmtATTN.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtATTN.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		    return RESULTDATA;
		}
		
		
		public JSONArray attendanceGridLoadingExcelExport(HttpSession session,String totaldays,String year,String month,String day,String department,String category,String empid) throws SQLException {
		    
			Connection conn=null;
		    JSONArray RESULTDATA=new JSONArray();

		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtATTN = conn.createStatement();
			        Statement stmtATTN1 = conn.createStatement();
			        
			        Enumeration<String> Enumeration = session.getAttributeNames();
			           int a=0;
			           while(Enumeration.hasMoreElements()){
			            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
			             a=1;
			            }
			           }
			           if(a==0){
			         return RESULTDATA;
			            }
			             
			        String branchid=session.getAttribute("BRANCHID").toString();
		    	    
			        String sql="",sql1="",leave1="",leave2="",leave3="",leave4="",leave5="",leave6="",leave7="",leave8="",leave9="",leave10="";

			        String sqls="select doc_no,desc1 from hr_setleave where status=3";
		    	    ResultSet resultSets = stmtATTN1.executeQuery(sqls);
		    	    
		    	    while(resultSets.next()){
		    	    	if(resultSets.getInt("doc_no")==1){
		    	    		leave1 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave1,0),1) '"+leave1+"',";
		    	    	} else if(resultSets.getInt("doc_no")==2){
		    	    		leave2 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave2,0),1) '"+leave2+"',";
		    	    	} else if(resultSets.getInt("doc_no")==3){
		    	    		leave3 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave3,0),1) '"+leave3+"',";
		    	    	} else if(resultSets.getInt("doc_no")==4){
		    	    		leave4 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave4,0),1) '"+leave4+"',";
		    	    	}else if(resultSets.getInt("doc_no")==5){
		    	    		leave5 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave5,0),1) '"+leave5+"',";
		    	    	}else if(resultSets.getInt("doc_no")==6){
		    	    		leave6 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave6,0),1) '"+leave6+"',";
		    	    	}else if(resultSets.getInt("doc_no")==7){
		    	    		leave7 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave7,0),1) '"+leave7+"',";
		    	    	}else if(resultSets.getInt("doc_no")==8){
		    	    		leave8 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave8,0),1) '"+leave8+"',";
		    	    	}else if(resultSets.getInt("doc_no")==9){
		    	    		leave9 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave9,0),1) '"+leave9+"',";
		    	    	}else if(resultSets.getInt("doc_no")==10){
		    	    		leave10 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave10,0),1) '"+leave10+"',";
		    	    	}
		    	    }
					
		            if(!(department.equalsIgnoreCase(""))){
		            	sql=sql+" and m.dept_id like '%"+department+"%'";
		            }
		            if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and m.pay_catid like '%"+category+"%'";
		            }
		            if(!(empid.equalsIgnoreCase(""))){
		                sql=sql+" and m.doc_no like '%"+empid+"%'";
		            }
		            
		            String sql7 = "select method from gl_config where field_nme='HRAttendanceLeaveEditEnable'";
		            ResultSet resultSet7 = stmtATTN1.executeQuery(sql7);
		            String method="";
					while(resultSet7.next()) {
						method=resultSet7.getString("method");
					}
					
					if(method.equalsIgnoreCase("1")) {
						
						/*Attendance Leave Edit Enable*/
						
						sql = "select m.codeno 'Emp. ID',UPPER(m.name) 'Emp. Name',t.totdays 'Days',coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) 'DAY 01',"  
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) 'DAY 02',coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) 'DAY 03',"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) 'DAY 04',coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) 'DAY 05',"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) 'DAY 06',coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) 'DAY 07',"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) 'DAY 08',coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) 'DAY 09',"  
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) 'DAY 10',coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) 'DAY 11',"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) 'DAY 12',coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) 'DAY 13',"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) 'DAY 14',coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) 'DAY 15'," 
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) 'DAY 16',coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) 'DAY 17',"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) 'DAY 18',coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) 'DAY 19',"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) 'DAY 20',coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) 'DAY 21',"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) 'DAY 22',coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) 'DAY 23',"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) 'DAY 24',coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) 'DAY 25',"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) 'DAY 26',coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) 'DAY 27',"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) 'DAY 28',coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) 'DAY 29',"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) 'DAY 30',coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) 'DAY 31',"+sql1+""
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) 'Over Time',"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) 'Holiday Over Time' from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
								+ "left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 "
								+ "left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 " 
								+ "left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 "
								+ "left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on "
								+ "s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset "
								+ "s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join "
								+ "hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 "
								+ "left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 "
								+ "left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 "  
								+ "left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 "
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Enable Ends*/
						
					} else {
		            
						/*Attendance Leave Edit Disable */
						
						sql = "select m.codeno 'Emp. ID',UPPER(m.name) 'Emp. Name',t.totdays 'Days',coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) 'DAY 01'," 
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) 'DAY 02',coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) 'DAY 03',"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) 'DAY 04',coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) 'DAY 05',"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) 'DAY 06',coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) 'DAY 07',"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) 'DAY 08',coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) 'DAY 09'," 
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) 'DAY 10',coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) 'DAY 11',"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) 'DAY 12',coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) 'DAY 13',"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) 'DAY 14',coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) 'DAY 15',"  
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) 'DAY 16',coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) 'DAY 17',"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) 'DAY 18',coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) 'DAY 19',"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) 'DAY 20',coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) 'DAY 21',"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) 'DAY 22',coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) 'DAY 23',"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) 'DAY 24',coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) 'DAY 25',"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) 'DAY 26',coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) 'DAY 27',"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) 'DAY 28',coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) 'DAY 29',"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) 'DAY 30',coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) 'DAY 31',"+sql1+""
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) 'Over Time',"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) 'Holiday Over Time' from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
								+ "left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 "
								+ "left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 " 
								+ "left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 "
								+ "left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on "
								+ "s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset "
								+ "s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join "
								+ "hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 "
								+ "left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 "
								+ "left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 "  
								+ "left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 "
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Disable Ends*/
					}
					System.out.println("===== "+sql);
					ResultSet resultSet = stmtATTN.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					
					stmtATTN.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		    return RESULTDATA;
		}
		
		public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
		    Connection conn=null;
		   
		    JSONArray RESULTDATA1=new JSONArray();
		
		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtATTN = conn.createStatement();
				
		    	    String sql = "";
					
		    	    if(!(empid.equalsIgnoreCase(""))){
		                sql=sql+" and codeno like '%"+empid+"%'";
		            }
		            if(!(employeename.equalsIgnoreCase(""))){
		             sql=sql+" and name like '%"+employeename+"%'";
		            }
		            if(!(contact.equalsIgnoreCase(""))){
		                sql=sql+" and pmmob like '%"+contact+"%'";
		            }
		            
					sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where active=1 and status=3"+sql;
					
					ResultSet resultSet1 = stmtATTN.executeQuery(sql);
					
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
					
					stmtATTN.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		    return RESULTDATA1;
		}

}
