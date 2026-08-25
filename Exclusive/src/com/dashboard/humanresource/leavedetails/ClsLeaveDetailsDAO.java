package com.dashboard.humanresource.leavedetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaveDetailsDAO  {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

	public JSONArray leaveDetailsGridLoading(String year, String month, String department, String category, String employee, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
		        	String sql = "",totleaves="0";
		        	
		        	String sqltot="select count(*) totleaves from hr_setleave where status=3";
		            ResultSet resultSettot = stmtRLDT.executeQuery(sqltot);
		            
		            while(resultSettot.next()){
		             totleaves=resultSettot.getString("totleaves");
		            }
		            
		    	    if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and m.pay_catid='"+category+"'";
		            }
		            if(!(department.equalsIgnoreCase(""))){
		            	sql=sql+" and m.dept_id='"+department+"'";
		            }
		            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
		                sql=sql+" and m.doc_no='"+employee+"'";
		            }
		            if(!(month.equalsIgnoreCase(""))){
		                sql=sql+" and t.month='"+month+"'";
		            }
		            
		            if(!(year.equalsIgnoreCase(""))){
		                sql=sql+" and t.year='"+year+"'";
		            }
		            
					sql = "select m.codeno employeeid,m.name employeename,ds.desc1 designation,dp.desc1 department,c.desc1 category,"
						 + "CONVERT(if(sum(t.tot_leave1)=0,' ',round(sum(t.tot_leave1),1)),CHAR(50)) leave1, "
						 + "CONVERT(if(sum(t.tot_leave2)=0,' ',round(sum(t.tot_leave2),1)),CHAR(50)) leave2, "
						 + "CONVERT(if(sum(t.tot_leave3)=0,' ',round(sum(t.tot_leave3),1)),CHAR(50)) leave3, "
						 + "CONVERT(if(sum(t.tot_leave4)=0,' ',round(sum(t.tot_leave4),1)),CHAR(50)) leave4, "
						 + "CONVERT(if(sum(t.tot_leave5)=0,' ',round(sum(t.tot_leave5),1)),CHAR(50)) leave5, "
						 + "CONVERT(if(sum(t.tot_leave6)=0,' ',round(sum(t.tot_leave6),1)),CHAR(50)) leave6, "
						 + "CONVERT(if(sum(t.tot_leave7)=0,' ',round(sum(t.tot_leave7),1)),CHAR(50)) leave7, "
						 + "CONVERT(if(sum(t.tot_leave8)=0,' ',round(sum(t.tot_leave8),1)),CHAR(50)) leave8, "
						 + "CONVERT(if(sum(t.tot_leave9)=0,' ',round(sum(t.tot_leave9),1)),CHAR(50)) leave9, "
						 + "CONVERT(if(sum(t.tot_leave10)=0,' ',round(sum(t.tot_leave10),1)),CHAR(50)) leave10, "
						 + "CONVERT(if((sum(t.tot_leave1)+sum(t.tot_leave2)+sum(t.tot_leave3)+sum(t.tot_leave4)+sum(t.tot_leave5)+sum(t.tot_leave6)+sum(t.tot_leave7)+ "
						 + "sum(t.tot_leave8)+sum(t.tot_leave9)+sum(t.tot_leave10))=0,' ',round((sum(t.tot_leave1)+sum(t.tot_leave2)+sum(t.tot_leave3)+sum(t.tot_leave4)+sum(t.tot_leave5)+sum(t.tot_leave6)+sum(t.tot_leave7)+ "
						 + "sum(t.tot_leave8)+sum(t.tot_leave9)+sum(t.tot_leave10)),1)),CHAR(50)) leavetotal from hr_timesheet t left join hr_empm m on t.empid=m.doc_no "
						 + "left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setdept dp on dp.doc_no=m.dept_id left join hr_setpaycat c on "
						 + "c.doc_no=m.pay_catid where 1=1"+sql+" group by t.empid";
				
						ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
						ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
						
						while(resultSet1.next()){
							ArrayList<String> temp=new ArrayList<String>();
							
							temp.add(resultSet1.getString("employeeid"));
							temp.add(resultSet1.getString("employeename"));
							temp.add(resultSet1.getString("designation"));
							temp.add(resultSet1.getString("department"));
							temp.add(resultSet1.getString("category"));
							temp.add(resultSet1.getString("leave1"));
							temp.add(resultSet1.getString("leave2"));
							temp.add(resultSet1.getString("leave3"));
							temp.add(resultSet1.getString("leave4"));
							temp.add(resultSet1.getString("leave5"));
							temp.add(resultSet1.getString("leave6"));
							temp.add(resultSet1.getString("leave7"));
							temp.add(resultSet1.getString("leave8"));
							temp.add(resultSet1.getString("leave9"));
							temp.add(resultSet1.getString("leave10"));
							temp.add(resultSet1.getString("leavetotal"));
							temp.add(totleaves);
							
							analysisrowarray.add(temp);
						}
						
						RESULTDATA1=convertRowArrayToJSON(analysisrowarray);
		        }
		        
				stmtRLDT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	public JSONArray leaveDetailsDetailedGridLoading(String year, String month, String department, String category, String leaveType, String employee, String check) throws SQLException {
		 JSONArray RESULTDATA1=new JSONArray();
	
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
		Connection conn=null;
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(category.equalsIgnoreCase(""))){
	                sql=sql+" and r.pay_catid='"+category+"'";
	            }
	            if(!(department.equalsIgnoreCase(""))){
	            	sql=sql+" and r.dept_id='"+department+"'";
	            }
	            if(!(leaveType.equalsIgnoreCase(""))){
	            	sql=sql+" and r.leavetype='"+leaveType+"'";
	            }
	            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
	                sql=sql+" and m.doc_no='"+employee+"'";
	            }
	            if(!(month.equalsIgnoreCase(""))){
	                sql=sql+" and MONTH(r.fromdate)='"+month+"'";
	            }
	            if(!(year.equalsIgnoreCase(""))){
	                sql=sql+" and YEAR(r.fromdate)='"+year+"'";
	            }
	            
				sql = "select m.codeno employeeid,m.name employeename,ds.desc1 designation,dp.desc1 department,c.desc1 category,r.fromdate, r.todate, if(r.halfday=1,true,false) halfday, r.halfdaydate,SUBSTRING_INDEX(l.desc1,' ',1) leaves, r.description,r.noofdays from "
						+ "hr_leaverequest  r left join hr_empm m on r.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=r.desc_id left join hr_setdept dp on dp.doc_no=r.dept_id left join hr_setpaycat c on c.doc_no=r.pay_catid left join hr_setleave l on l.doc_no=r.leavetype "
						+ "where m.status=3 and m.active=1 and r.status=3 and r.confirm=1"+sql;
				
				ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToJSON(resultSet1);
				
				stmtRLDT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray leaveDetailsExcelExport(String year, String month, String department, String category, String employee, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		        	String sql = "",sql1="";
		        	int totleaves=0;
		        	
		        	String sqltot="select count(*) totleaves from hr_setleave where status=3";
		            ResultSet resultSettot = stmtRLDT.executeQuery(sqltot);
		            
		            while(resultSettot.next()){
		             totleaves=resultSettot.getInt("totleaves");
		            }
		    	    
		            for(int i=1;i<=totleaves;i++)
					{
		            	String leavename="";
		            	String sql2="select UPPER(desc1) desc1 from hr_setleave where doc_no="+i+"";
		            	
		            	ResultSet resultSet1 = stmtRLDT.executeQuery(sql2);
						
						while(resultSet1.next()){
							leavename=resultSet1.getString("desc1");
						}
						
		            	sql1=sql1+"CONVERT(if(sum(t.tot_leave"+i+")=0,' ',round(sum(t.tot_leave"+i+"),1)),CHAR(50)) '"+leavename+"',";
					}
		            
		            if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and m.pay_catid='"+category+"'";
		            }
		            if(!(department.equalsIgnoreCase(""))){
		            	sql=sql+" and m.dept_id='"+department+"'";
		            }
		            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
		                sql=sql+" and m.doc_no='"+employee+"'";
		            }
		            if(!(month.equalsIgnoreCase(""))){
		                sql=sql+" and t.month='"+month+"'";
		            }
		            
		            if(!(year.equalsIgnoreCase(""))){
		                sql=sql+" and t.year='"+year+"'";
		            }
		            
					sql = "select m.codeno 'Emp. ID',m.name 'Employee Name',ds.desc1 'Designation',dp.desc1 'Department',c.desc1 'Category',"+sql1+""
						 + "CONVERT(if((sum(t.tot_leave1)+sum(t.tot_leave2)+sum(t.tot_leave3)+sum(t.tot_leave4)+sum(t.tot_leave5)+sum(t.tot_leave6)+sum(t.tot_leave7)+ "
						 + "sum(t.tot_leave8)+sum(t.tot_leave9)+sum(t.tot_leave10))=0,' ',round((sum(t.tot_leave1)+sum(t.tot_leave2)+sum(t.tot_leave3)+sum(t.tot_leave4)+sum(t.tot_leave5)+sum(t.tot_leave6)+sum(t.tot_leave7)+ "
						 + "sum(t.tot_leave8)+sum(t.tot_leave9)+sum(t.tot_leave10)),1)),CHAR(50)) 'Total' from hr_timesheet t left join hr_empm m on t.empid=m.doc_no "
						 + "left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setdept dp on dp.doc_no=m.dept_id left join hr_setpaycat c on "
						 + "c.doc_no=m.pay_catid where 1=1"+sql+" group by t.empid";
				
						ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
						RESULTDATA1=commonDAO.convertToEXCEL(resultSet1);
		        }
		        
				stmtRLDT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray leaveDetailsDetailedExcelExport(String year, String month, String department, String category, String leaveType, String employee, String check) throws SQLException {
		 JSONArray RESULTDATA1=new JSONArray();
	
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
		Connection conn=null;
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(category.equalsIgnoreCase(""))){
	                sql=sql+" and r.pay_catid='"+category+"'";
	            }
	            if(!(department.equalsIgnoreCase(""))){
	            	sql=sql+" and r.dept_id='"+department+"'";
	            }
	            if(!(leaveType.equalsIgnoreCase(""))){
	            	sql=sql+" and r.leavetype='"+leaveType+"'";
	            }
	            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
	                sql=sql+" and m.doc_no='"+employee+"'";
	            }
	            if(!(month.equalsIgnoreCase(""))){
	                sql=sql+" and MONTH(r.fromdate)='"+month+"'";
	            }
	            if(!(year.equalsIgnoreCase(""))){
	                sql=sql+" and YEAR(r.fromdate)='"+year+"'";
	            }
	            
				sql = "select m.codeno 'Emp. ID',m.name 'Employee Name',ds.desc1 'Designation',dp.desc1 'Department',c.desc1 'Category',r.fromdate 'From', r.todate 'To', if(r.halfday=1,'Yes','No') 'Half Day', r.halfdaydate 'Half Taken',SUBSTRING_INDEX(l.desc1,' ',1) 'Leave Type', r.description 'Description',r.noofdays 'No of Days' from "
						+ "hr_leaverequest  r left join hr_empm m on r.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=r.desc_id left join hr_setdept dp on dp.doc_no=r.dept_id left join hr_setpaycat c on c.doc_no=r.pay_catid left join hr_setleave l on l.doc_no=r.leavetype "
						+ "where m.status=3 and m.active=1 and r.status=3 and r.confirm=1"+sql;
				
				ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToEXCEL(resultSet1);
				
				stmtRLDT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String check) throws SQLException {
		 JSONArray RESULTDATA1=new JSONArray();
	
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
		Connection conn=null;
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
			
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
				
				ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToJSON(resultSet1);
				
				stmtRLDT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}


public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		  JSONArray jsonArray = new JSONArray();
		  
		  for (int i = 0; i < rowsAnalysisList.size(); i++) {
		   
		   JSONObject obj = new JSONObject();
		   ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
		   
		   obj.put("employeeid",analysisRowArray.get(0));
		   obj.put("employeename",analysisRowArray.get(1));
		   obj.put("designation",analysisRowArray.get(2));
		   obj.put("department",analysisRowArray.get(3));
		   obj.put("category",analysisRowArray.get(4));
		   obj.put("leave1",analysisRowArray.get(5));
		   obj.put("leave2",analysisRowArray.get(6));
		   obj.put("leave3",analysisRowArray.get(7));
		   obj.put("leave4",analysisRowArray.get(8));
		   obj.put("leave5",analysisRowArray.get(9));
		   obj.put("leave6",analysisRowArray.get(10));
		   obj.put("leave7",analysisRowArray.get(11));
		   obj.put("leave8",analysisRowArray.get(12));
		   obj.put("leave9",analysisRowArray.get(13));
		   obj.put("leave10",analysisRowArray.get(14));
		   obj.put("leavetotal",analysisRowArray.get(15));
		   obj.put("totleavesavailable",analysisRowArray.get(16));
		   
		   jsonArray.add(obj);
		  }
		  return jsonArray;
		  }
	
}
