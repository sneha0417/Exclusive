package com.dashboard.procurment.floorlist;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFloorList  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray floorList(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFloorList = conn.createStatement();
            			
				if(check.equalsIgnoreCase("load")){
					
				String sql = "select f.code flcode,f.name flname,r.code rackcode,r.name rackname,b.code bincode,b.name binname from my_floor f "  
						+ "left join my_flrack r on f.doc_no=r.fl_id and r.status=3 left join my_flbin b on r.doc_no=b.rck_id and b.status=3 "  
						+ "where f.status=3 order by f.doc_no";
				
				ResultSet resultSet = stmtFloorList.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtFloorList.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray floorListExcelExport(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFloorList = conn.createStatement();
            			
				if(check.equalsIgnoreCase("load")){
					
				String sql = "select f.code 'Floor Code',f.name 'Floor Name',r.code 'Rack Code',r.name 'Rack Name',b.code 'Bin Code',b.name 'Bin Name' from my_floor f "  
						+ "left join my_flrack r on f.doc_no=r.fl_id and r.status=3 left join my_flbin b on r.doc_no=b.rck_id and b.status=3 "  
						+ "where f.status=3 order by f.doc_no";
				
				ResultSet resultSet = stmtFloorList.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtFloorList.close();
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
