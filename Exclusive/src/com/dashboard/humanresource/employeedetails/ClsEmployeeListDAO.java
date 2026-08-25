package com.dashboard.humanresource.employeedetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeListDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
  public JSONArray employeeListGridLoading(String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;  
	
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtCRM = conn.createStatement ();
	    
		    if(check.equalsIgnoreCase("load")){
		    
		    ResultSet resultSet = stmtCRM.executeQuery ("select m.codeNo empid,m.name,des.desc1 designation,dep.desc1 department,cat.desc1 category,"
		    		+ " m.dtjoin,m.pmaddr address,if(m.active=1,'ACTIVE','TERMINATED') status,m.pmmob mobile,m.pmemail email,m.dob,m.gender from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no "
		    		+ " left join hr_setpaycat cat on m.pay_catid=cat.doc_no" );
		    
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    }
		    stmtCRM.close();
		    conn.close();
	  }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
  
  public JSONArray employeeListExcelExport(String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;  
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
		    
			    if(check.equalsIgnoreCase("load")){
				    
				    ResultSet resultSet = stmtCRM.executeQuery ("select m.codeNo 'EMP ID',m.name 'NAME',des.desc1 'DESIGNATION',dep.desc1 'DEPARTMENT',cat.desc1 'CATEGORY',"
				    		+ "m.dtjoin 'DATE OF JOIN',m.pmaddr 'ADDRESS',m.pmmob 'MOBILE',m.pmemail 'EMAIL ID',m.dob 'DOB',m.gender 'GENDER',if(m.active=1,'ACTIVE','TERMINATED') 'STATUS' from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no "
				    		+ "left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no");
				    
				    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    }
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
}
