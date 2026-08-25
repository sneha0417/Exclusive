package com.controlcentre.masters.maintenancemaster.maintenance;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

  public class ClsMaintenanceDAO {
	  ClsConnection ClsConnection=new ClsConnection();

	  ClsCommon ClsCommon=new ClsCommon();


	  public int insert(String maintenancetype, String desc, Date sqlStartDate,HttpSession session, String mode, String formdetailcode) throws SQLException {
	
	  Connection conn = null;
	
	   try{
			conn=ClsConnection.getMyConnection();
			int doc;
			
			CallableStatement stmtsave = conn.prepareCall("{call maintenanceDML(?,?,?,?,?,?,?,?)}");
			
			stmtsave.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtsave.setString(1,maintenancetype);
			stmtsave.setString(2,desc);
			stmtsave.setDate(3,sqlStartDate);
			stmtsave.setString(4,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,mode);
			stmtsave.setString(7,formdetailcode);
			stmtsave.executeQuery();
			doc=stmtsave.getInt("docval");
			
			if (doc > 0) {
				stmtsave.close();
				conn.close();
				return doc;
			}
			stmtsave.close();
			conn.close();
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			return 0;
		}finally{
			conn.close();
		}
		return 0;
    }


	public boolean edit(String maintenancetype, String desc, Date sqlStartDate,HttpSession session, String mode, String formdetailcode, int docno) throws SQLException {
		
		Connection conn = null;
		
		try{
			
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtsave = conn.prepareCall("{call maintenanceDML(?,?,?,?,?,?,?,?)}");
			
			stmtsave.setString(1,maintenancetype);
			stmtsave.setString(2,desc);
			stmtsave.setDate(3,sqlStartDate);
			stmtsave.setString(4,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,mode);
			stmtsave.setString(7,formdetailcode);
			stmtsave.setInt(8,docno);

			int data = stmtsave.executeUpdate();
			
			if (data>0) {
				stmtsave.close();
				conn.close();
				return true;
			}
			stmtsave.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public boolean delete(HttpSession session, String mode, String formdetailcode, int docno) throws SQLException{
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtsave = conn.prepareCall("{call maintenanceDML(?,?,?,?,?,?,?,?)}");
			
			stmtsave.setString(1,null);
			stmtsave.setString(2,null);
			stmtsave.setDate(3,null);
			stmtsave.setString(4,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,mode);
			stmtsave.setString(7,formdetailcode);
			stmtsave.setInt(8,docno);
			
			int data = stmtsave.executeUpdate();
		
			if (data>0) {
				stmtsave.close();
				conn.close();	
				return true;
			}
			stmtsave.close();
			conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public  JSONArray mainserch() throws SQLException {
	
	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
	   
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement();
	        	
				String resql=("select docno, mtype, name,date from gl_vrepm where status=3 ");
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtrelode.close();
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

