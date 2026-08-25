package com.controlcentre.masters.maintenancemaster.preventive;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPreventiveDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsPreventiveBean preventiveBean=new ClsPreventiveBean();

	public int insert( String maintenanceid,String maintenancetype,Date prevdate,double lbrchg,HttpSession session,String mode,String formdetailcode) throws SQLException {
	 
		Connection conn = null;
	 
		try{
			conn = ClsConnection.getMyConnection();
			int docno;
			
			CallableStatement stmtPreventive = conn.prepareCall("{call vehPreventiveDML(?,?,?,?,?,?,?,?,?)}");

			stmtPreventive.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtPreventive.setString(1,maintenanceid);
			stmtPreventive.setString(2,maintenancetype);
			stmtPreventive.setDouble(3, lbrchg);
			stmtPreventive.setDate(4, prevdate);
			stmtPreventive.setString(5,session.getAttribute("USERID").toString());
			stmtPreventive.setString(6,session.getAttribute("BRANCHID").toString());
			stmtPreventive.setString(7,mode);
			stmtPreventive.setString(9,formdetailcode);
			stmtPreventive.executeQuery();
			docno=stmtPreventive.getInt("docNo");
			
			preventiveBean.setDocno(docno);
			
			if (docno > 0) {
				stmtPreventive.close();
				conn.close();
				return docno;
			}
			stmtPreventive.close();
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
	
	public boolean edit(String maintenanceid,String maintenancetype,Date prevdate,double lbrchg,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();

			CallableStatement stmtPreventive = conn.prepareCall("{call vehPreventiveDML(?,?,?,?,?,?,?,?,?)}");

			stmtPreventive.setInt(8,docno);
			stmtPreventive.setString(1,maintenanceid);
			stmtPreventive.setString(2,maintenancetype);
			stmtPreventive.setDouble(3, lbrchg);
			stmtPreventive.setDate(4, prevdate);
			stmtPreventive.setString(6,session.getAttribute("BRANCHID").toString());
			stmtPreventive.setString(5,session.getAttribute("USERID").toString());
			stmtPreventive.setString(7,mode);
			stmtPreventive.setString(9,formdetailcode);
	
			int data = stmtPreventive.executeUpdate();
			
			if (data>0) {
				stmtPreventive.close();
				conn.close();
				return true;
			}
			stmtPreventive.close();
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
	
	public boolean delete(String maintenanceid,String maintenancetype,Date prevdate,double lbrchg,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		
		Connection conn= null;
		
		try{
			conn=ClsConnection.getMyConnection();

			CallableStatement stmtPreventive = conn.prepareCall("{call vehPreventiveDML(?,?,?,?,?,?,?,?,?)}");

			stmtPreventive.setInt(8,docno);
			stmtPreventive.setString(1,maintenanceid);
			stmtPreventive.setString(2,maintenancetype);
			stmtPreventive.setDouble(3, lbrchg);
			stmtPreventive.setDate(4, prevdate);
			stmtPreventive.setString(6,session.getAttribute("BRANCHID").toString());
			stmtPreventive.setString(5,session.getAttribute("USERID").toString());
			stmtPreventive.setString(7,mode);
			stmtPreventive.setString(9,formdetailcode);
	
			int data = stmtPreventive.executeUpdate();
			
			if (data>0) {
				stmtPreventive.close();
				conn.close();	
				return true;
			}
			stmtPreventive.close();
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

	public  JSONArray getPreventive() throws SQLException {
	    List<ClsPreventiveBean> listbean = new ArrayList<ClsPreventiveBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtmovement = conn.createStatement();
	        	
				String strSql="select doc_no,id,name,l_chg,date from gl_prmaster where status<>7";
				
				ResultSet resultSet = stmtmovement.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtmovement.close();
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

