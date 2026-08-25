package com.dashboard.cargo.propertystatuschange;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClspropertyStatusChange  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray propertyStatusChange(String branch,String fromdate,String todate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				String sql = "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			        }
            			
				sql="select j.doc_no,j.name prop_name,o.primary_owner  prop_owner,j.address,j.landmark,j.area,j.desc1 description from rl_propertymaster j"
						+" left join rl_propertryowner o on o.doc_no=j.owid where j.status=3 and j.active=1";
				ResultSet resultSet = stmtDayBook.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDayBook.close();
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