package com.dashboard.humanresource.leaveremoval;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaveRemovalDAO  {
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

	public JSONArray leaveDetailsGridLoading(String rptType, String branchval, String fromdate, String todate, String department, String designation, String category, String employee, String check) throws SQLException {
		    Connection conn=null;
		   
		    JSONArray RESULTDATA1=new JSONArray();
		
		    try {
		    	    conn = connDAO.getMyConnection();
			        Statement stmtRLDT = conn.createStatement();
			        
			        if(check.equalsIgnoreCase("1")) {
			       
			        java.sql.Date sqlFromDate=null;
			        java.sql.Date sqlToDate=null;
			        
			        fromdate.trim();
			        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
			        }
			        
			        todate.trim();
			        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
			        	sqlToDate = commonDAO.changeStringtoSqlDate(todate);
			        }
			        
		    	    String sql = "";
		    	    
		    	    if(rptType.equalsIgnoreCase("2")) {
		    	    	sql=sql+" and r.confirm=0";
		    	    } else if(rptType.equalsIgnoreCase("3")) {
		    	    	sql=sql+" and r.confirm=1";
		    	    }
		    	    if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0"))){
		                sql=sql+" and r.pay_catid like '%"+category+"%'";
		            }
		    	    if(!(designation.equalsIgnoreCase("")) && !(designation.equalsIgnoreCase("0"))){
			             sql=sql+" and r.desc_id like '%"+designation+"%'";
			        }
		            if(!(department.equalsIgnoreCase("")) && !(department.equalsIgnoreCase("0"))){
		                sql=sql+" and r.dept_id like '%"+department+"%'";
		            }
		            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
		                sql=sql+" and r.empid='"+employee+"'";
		            }
		            if(!(sqlFromDate==null)){
		            	sql=sql+" and r.fromdate>='"+sqlFromDate+"'";
				    } 
		            if(!(sqlToDate==null)){
		            	sql=sql+" and r.fromdate<='"+sqlToDate+"'";
				    } 
		            
					sql = "select r.doc_no docno,r.fromdate fromdate,r.todate,if(halfday=0,'false','true') halfday,r.halfdaydate,r.noofdays,r.description,r.empid empdocno,if(r.confirm=0,'PENDING','APPROVED') reqstatus,"
						+ "l.desc1 leavetype,m.codeno empid,m.name empname from hr_leaverequest r left join hr_empm m on r.empid=m.doc_no and m.active=1 left join hr_setleave l on r.leavetype=l.doc_no where r.status=3"+sql;
					System.out.println("sql--->>>"+sql);
					ResultSet resultSet1 = stmtRLDT.executeQuery(sql);
					
					RESULTDATA1=commonDAO.convertToJSON(resultSet1);
			        
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
	
}
