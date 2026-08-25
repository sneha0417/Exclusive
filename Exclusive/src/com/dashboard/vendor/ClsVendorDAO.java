package com.dashboard.vendor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVendorDAO  {
	
	public static JSONArray vendorList() throws SQLException {
		ClsConnection ClsConnection= new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		Connection conn = null;
        JSONArray RESULTDATA=new JSONArray();
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement();
			    
			    ResultSet resultSet = stmtCRM.executeQuery ("SELECT category,refname,per_mob,sal_name,concat(address,'  ',address2) as address, "
			    		+ "mail1 FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='vnd' left join my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' where cl.dtype='crm' ");
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
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
