package com.dashboard.humanresource.leaveacceptance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaveAcceptanceDAO  {
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

	public JSONArray leaveAcceptanceGridLoading(String branchval, String uptodate, String department, String designation, String category, String employee, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtRLDT = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
		        java.sql.Date sqlUpToDate=null;
		        
		        uptodate.trim();
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }
		        
	    	    String sql = "";
				
	    	    if(!(category.equalsIgnoreCase(""))){
	                sql=sql+" and r.pay_catid like '%"+category+"%'";
	            }
	    	    if(!(designation.equalsIgnoreCase(""))){
		             sql=sql+" and r.desc_id like '%"+designation+"%'";
		        }
	            if(!(department.equalsIgnoreCase(""))){
	                sql=sql+" and r.dept_id like '%"+department+"%'";
	            }
	            if(!(employee.equalsIgnoreCase(""))){
	                sql=sql+" and r.empid='"+employee+"'";
	            }
	            if(!(sqlUpToDate==null)){
	            	sql=sql+" and r.fromdate<='"+sqlUpToDate+"'";
			    } 
	            
				sql = "select r.doc_no docno,r.fromdate fromdate,r.todate,if(halfday=0,'false','true') halfday,r.halfdaydate,r.noofdays,r.description,r.empid empdocno,l.desc1 leavetype,m.codeno empid,m.name empname "
					+ "from hr_leaverequest r left join hr_empm m on r.empid=m.doc_no and m.active=1 left join hr_setleave l on r.leavetype=l.doc_no where r.status=3 and r.confirm=0"+sql;
				
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
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
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
