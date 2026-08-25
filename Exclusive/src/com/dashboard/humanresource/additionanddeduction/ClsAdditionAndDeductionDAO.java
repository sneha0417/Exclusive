package com.dashboard.humanresource.additionanddeduction;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAdditionAndDeductionDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray additionAndDeductionGridLoading(String year,String month,String acno,String empId,String check) throws SQLException {
		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		} 
		
		Connection conn=null;
	  
	    try {
	           conn = ClsConnection.getMyConnection();
	           Statement stmtALW = conn.createStatement();
	    
	           String sql = "";
	   
	           if(!(month.equalsIgnoreCase(""))){
	                sql=sql+" and m.month='"+month+"'";
	            }
	           if(!(acno.equalsIgnoreCase("")) && !(acno.equalsIgnoreCase("0"))){
	                sql=sql+" and d.acno='"+acno+"'";
	            }
	            if(!(empId.equalsIgnoreCase("")) && !(empId.equalsIgnoreCase("0"))){
	                sql=sql+" and d.empid='"+empId+"'";
	            }
	            
	           sql = "select e.codeno empid,e.name empname,CONVERT(if(sum(d.addition)=0,' ',round(sum(d.addition),2)),CHAR(100)) addition, "
	           		+ "CONVERT(if(sum(d.deduction)=0,' ',round(sum(d.deduction),2)),CHAR(100)) deduction, d.remarks,d.atype,d.acno,h.account, "
	           		+ "h.description accountname from hr_adddedm m left join hr_adddedd d on m.doc_no=d.rdocno left join hr_empm e on e.doc_no=d.empid "
	           		+ "and e.dtype='EMP' left join my_head h on d.acno=h.doc_no where m.status=3 and e.status=3 and m.year="+year+""+sql+" "
	           		+ "group by d.empid";
	          
	           ResultSet resultSet1 = stmtALW.executeQuery(sql);
	           RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
	     
	     stmtALW.close();
	     conn.close();
	   } catch(Exception e){
	      e.printStackTrace();
	      conn.close();
	   } finally{
	     conn.close();
	   }
	      return RESULTDATA1;
	  }
	  
		public JSONArray additionAndDeductionExcelExport(String year,String month,String acno,String empId,String check) throws SQLException {
			JSONArray RESULTDATA1=new JSONArray();
			
			if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA1;
			}
			
			Connection conn=null;
		  
		    try {
		           conn = ClsConnection.getMyConnection();
		           Statement stmt = conn.createStatement();
		    
		           String sql = "";
		   
		           if(!(month.equalsIgnoreCase(""))){
		                sql=sql+" and m.month='"+month+"'";
		            }
		           if(!(acno.equalsIgnoreCase("")) && !(acno.equalsIgnoreCase("0"))){
		                sql=sql+" and d.acno='"+acno+"'";
		            }
		            if(!(empId.equalsIgnoreCase("")) && !(empId.equalsIgnoreCase("0"))){
		                sql=sql+" and d.empid='"+empId+"'";
		            }
		            
		           sql = "select e.codeno 'Emp. ID',e.name 'Emp. Name',d.atype 'Type',h.account 'Account',h.description 'Account Name' ,"
		           		    + "CONVERT(if(sum(d.addition)=0,' ',round(sum(d.addition),2)),CHAR(100)) 'Addition', "
			           		+ "CONVERT(if(sum(d.deduction)=0,' ',round(sum(d.deduction),2)),CHAR(100)) 'Deduction', d.remarks 'Remarks' "
			           		+ "from hr_adddedm m left join hr_adddedd d on m.doc_no=d.rdocno left join hr_empm e on e.doc_no=d.empid "
			           		+ "and e.dtype='EMP' left join my_head h on d.acno=h.doc_no where m.status=3 and e.status=3 and m.year="+year+""+sql+" "
			           		+ "group by d.empid";
		           
		           ResultSet resultSet1 = stmt.executeQuery(sql);
		           RESULTDATA1=ClsCommon.convertToEXCEL(resultSet1);
		     
		     stmt.close();
		     conn.close();
		   } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
		   } finally{
		     conn.close();
		   }
		      return RESULTDATA1;
		  }
	
	public JSONArray accountDetailsSearch(String accountno,String accountname,String atype,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtALW = conn.createStatement();
            	
				if(check.equalsIgnoreCase("1")){
					
					String sql="";
					
					if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
			            sql=sql+" and account like '%"+accountno+"%'";
			        }
					
			        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
			         sql=sql+" and description like '%"+accountname+"%'";
			        }
						
			        sql = "select doc_no,account,description,gr_type grtype from my_head where m_s=0 and atype='"+atype+"'"+sql+"";
			       
			        ResultSet resultSet = stmtALW.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
				}
				
				stmtALW.close();
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
		 JSONArray RESULTDATA1=new JSONArray();
	
	  		Connection conn=null;
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
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
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
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
