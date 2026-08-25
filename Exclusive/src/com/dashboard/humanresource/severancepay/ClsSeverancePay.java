package com.dashboard.humanresource.severancepay;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSeverancePay  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray severancePayGridLoading(String branch, String uptodate,String empId,String reportType,String check) throws SQLException {
	    
		JSONArray RESULTDATA=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBTSP = conn.createStatement();
				
			     java.sql.Date sqlUpToDate = null;
			        
			     if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
			              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
			     }
			     String sql="";
			     String strSql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and brhid="+branch+"";
		    	 }
			     
			     if(!(sqlUpToDate==null)){
			        	sql+=" and date<='"+sqlUpToDate+"'";
				 }
			     
			     if(!(reportType.equalsIgnoreCase(""))){
		            	if(reportType.equalsIgnoreCase("1")) {
		            		strSql=strSql+" and m.active=1 and m.status=3";
		            	} else if(reportType.equalsIgnoreCase("0")) {
		            		strSql=strSql+" and m.active=0 and m.status=7";
		            	}
		            }
			     
			     if(!((empId.equalsIgnoreCase("")) || (empId.equalsIgnoreCase("0")))){
			    	   sql=sql+"  and empid='"+empId+"'";
		         }
	             
				 sql = "select b.*,(b.terminalbenefitsbalance+b.leavesalarybalance+travelsbalance) nettotal from ( "
						 + "select a.empid employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin dateofjoin,round(sum(a.terminalbenefitstotal),2) terminalbenefitstotal,"
						 + "round(sum(a.terminalbenefitsgiven),2) terminalbenefitsgiven,round(sum(a.terminalbenefitstotal)-sum(a.terminalbenefitsgiven),2) terminalbenefitsbalance,"  
				 		 + "round(sum(a.leavesalarytotal),2) leavesalarytotal,round(sum(a.leavesalarygiven),2) leavesalarygiven,round(sum(a.leavesalarytotal)-sum(a.leavesalarygiven),2) leavesalarybalance," 
				 		 + "round(sum(a.travelstotal),2) travelstotal,round(sum(a.travelsgiven),2) travelsgiven,round(sum(a.travelstotal)-sum(a.travelsgiven),2) travelsbalance from ( " 
				 	     + "select empid,if(terminalbenefits_tobeposted>0,terminalbenefits_tobeposted,0) terminalbenefitstotal,if(terminalbenefits_tobeposted<0,terminalbenefits_tobeposted*-1,0) terminalbenefitsgiven," 
				 		 + "if(leavesalary_tobeposted>0,leavesalary_tobeposted,0) leavesalarytotal,if(leavesalary_tobeposted<0,leavesalary_tobeposted*-1,0) leavesalarygiven,"  
				 		 + "if(travels_tobeposted>0,travels_tobeposted,0) travelstotal,if(travels_tobeposted<0,travels_tobeposted*-1,0) travelsgiven,dtype from hr_emptran where 1=1"+sql+") a " 
				 		 + "left join hr_empm m on a.empid=m.doc_no where 1=1"+strSql+" group by a.empid) b order by b.employeedocno";

				ResultSet resultSet = stmtBTSP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBTSP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	
	public JSONArray severanceDetailedPayGridLoading(String branch,String uptodate,String empId) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBTSP = conn.createStatement();
				
			     java.sql.Date sqlUpToDate = null;
			        
			     if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
			              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
			     }
			     String sql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and brhid="+branch+"";
		    	 }
					
				sql = "select a.empid employeedocno,m.codeno employeeid,m.name employeename,a.date,CONVERT(if(coalesce(a.terminalbenefits_tobeposted,0)>0,round((coalesce(a.terminalbenefits_tobeposted,0)),2),''),CHAR(100)) terminalbenefitsdebit,"
				    + "CONVERT(if(coalesce(a.terminalbenefits_tobeposted,0)<0,round((coalesce(a.terminalbenefits_tobeposted,0)*-1),2),''),CHAR(100)) terminalbenefitscredit,"
					+ "CONVERT(if(coalesce(a.leavesalary_tobeposted,0)>0,round((coalesce(a.leavesalary_tobeposted,0)),2),''),CHAR(100)) leavesalarydebit,"
					+ "CONVERT(if(coalesce(a.leavesalary_tobeposted,0)<0,round((coalesce(a.leavesalary_tobeposted,0)*-1),2),''),CHAR(100)) leavesalarycredit,"
					+ "CONVERT(if(coalesce(a.travels_tobeposted,0)>0,round((coalesce(a.travels_tobeposted,0)),2),''),CHAR(100)) travelsdebit,"
					+ "CONVERT(if(coalesce(a.travels_tobeposted,0)<0,round((coalesce(a.travels_tobeposted,0)*-1),2),''),CHAR(100)) travelscredit,"
					+ "CASE WHEN a.dtype='OPN' THEN 'OPENING BALANCE' WHEN a.dtype='TEB' THEN 'TERMINAL BENEFITS' WHEN a.dtype='LTD' THEN 'LEAVE/TRAVEL DISBURSEMENT' WHEN a.dtype='HTRE' "
					+ "THEN 'TERMINATION' ELSE '' END AS description from hr_emptran a left join hr_empm m on a.empid=m.doc_no where a.date<='"+sqlUpToDate+"' and a.empid="+empId+"";
			     
				ResultSet resultSet = stmtBTSP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBTSP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray severancePayExcelExport(String branch, String uptodate,String empId,String reportType,String check) throws SQLException {
	    
		JSONArray RESULTDATA=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBTSP = conn.createStatement();
				
			     java.sql.Date sqlUpToDate = null;
			        
			     if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
			              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
			     }
			     String sql="";
			     String strSql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and brhid="+branch+"";
		    	 }
			     
			     if(!(sqlUpToDate==null)){
			        	sql+=" and date<='"+sqlUpToDate+"'";
				 }
			     
			     if(!(reportType.equalsIgnoreCase(""))){
		            	if(reportType.equalsIgnoreCase("1")) {
		            		strSql=strSql+" and m.active=1 and m.status=3";
		            	} else if(reportType.equalsIgnoreCase("0")) {
		            		strSql=strSql+" and m.active=0 and m.status=7";
		            	}
		            }
			     
			     if(!((empId.equalsIgnoreCase("")) || (empId.equalsIgnoreCase("0")))){
			    	   sql=sql+"  and empid='"+empId+"'";
		         }
					
			     sql = "select b.employeeid 'Emp. ID',b.employeename 'Emp. Name',b.dateofjoin 'Date of Join',b.terminalbenefitstotal 'Terminal Benefits Total',b.terminalbenefitsgiven 'Terminal Benefits Paid',"
			    		 + "b.terminalbenefitsbalance 'Terminal Benefits Balance',b.leavesalarytotal 'Leave Salary Total',b.leavesalarygiven 'Leave Salary Paid',b.leavesalarybalance 'Leave Salary Balance',"
			    		 + "b.travelstotal 'Travels Total',b.travelsgiven 'Travels Paid',b.travelsbalance 'Travels Balance',(b.terminalbenefitsbalance+b.leavesalarybalance+travelsbalance) 'Net Total' from ("
			    		 + "select a.empid employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin dateofjoin,round(sum(a.terminalbenefitstotal),2) terminalbenefitstotal,"
						 + "round(sum(a.terminalbenefitsgiven),2) terminalbenefitsgiven,round(sum(a.terminalbenefitstotal)-sum(a.terminalbenefitsgiven),2) terminalbenefitsbalance,"  
				 		 + "round(sum(a.leavesalarytotal),2) leavesalarytotal,round(sum(a.leavesalarygiven),2) leavesalarygiven,round(sum(a.leavesalarytotal)-sum(a.leavesalarygiven),2) leavesalarybalance," 
				 		 + "round(sum(a.travelstotal),2) travelstotal,round(sum(a.travelsgiven),2) travelsgiven,round(sum(a.travelstotal)-sum(a.travelsgiven),2) travelsbalance from ( " 
				 	     + "select empid,if(terminalbenefits_tobeposted>0,terminalbenefits_tobeposted,0) terminalbenefitstotal,if(terminalbenefits_tobeposted<0,terminalbenefits_tobeposted*-1,0) terminalbenefitsgiven," 
				 		 + "if(leavesalary_tobeposted>0,leavesalary_tobeposted,0) leavesalarytotal,if(leavesalary_tobeposted<0,leavesalary_tobeposted*-1,0) leavesalarygiven,"  
				 		 + "if(travels_tobeposted>0,travels_tobeposted,0) travelstotal,if(travels_tobeposted<0,travels_tobeposted*-1,0) travelsgiven,dtype from hr_emptran where 1=1"+sql+") a " 
				 		 + "left join hr_empm m on a.empid=m.doc_no where 1=1"+strSql+" group by a.empid) b order by b.employeedocno";

				ResultSet resultSet = stmtBTSP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtBTSP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact, String partyStatus) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBTSP = conn.createStatement();
			
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
	            if(!(partyStatus.equalsIgnoreCase(""))){
	            	if(partyStatus.equalsIgnoreCase("1")) {
	            		sql=sql+" and active=1 and status=3";
	            	} else if(partyStatus.equalsIgnoreCase("0")) {
	            		sql=sql+" and active=0 and status=7";
	            	}
	            }
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where 1=1"+sql;
				
				ResultSet resultSet1 = stmtBTSP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBTSP.close();
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
