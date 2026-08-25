package com.controlcentre.masters.maintenancemaster.complaint;

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

	public class ClsComplaintDAO {
		ClsConnection ClsConnection=new ClsConnection();	
		ClsCommon ClsCommon=new ClsCommon();
	public int insert( String complaint, Date sqlStartDate, HttpSession session, String mode, String formdetailcode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			int doc;
		    
			CallableStatement stmtsave = conn.prepareCall("{call complaintDML(?,?,?,?,?,?,?)}");
			
			stmtsave.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtsave.setString(1,complaint);
			stmtsave.setDate(2,sqlStartDate);
			stmtsave.setString(3,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(4,session.getAttribute("USERID").toString());
			stmtsave.setString(5,mode);
			stmtsave.setString(6,formdetailcode);
			stmtsave.executeQuery();
			
			doc=stmtsave.getInt("docNo");
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
	
	
	public boolean edit(String complaint, Date sqlStartDate,HttpSession session, String mode, String formdetailcode, int docno) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtsave = conn.prepareCall("{call complaintDML(?,?,?,?,?,?,?)}");
			
			stmtsave.setString(1,complaint);
			stmtsave.setDate(2,sqlStartDate);
			stmtsave.setString(3,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(4,session.getAttribute("USERID").toString());
			stmtsave.setString(5,mode);
			stmtsave.setString(6,formdetailcode);
			stmtsave.setInt(7,docno);
		
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
	
	public boolean delete(HttpSession session, String mode, String formdetailcode, int docno) throws SQLException {
		
		Connection conn=null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtsave = conn.prepareCall("{call complaintDML(?,?,?,?,?,?,?)}");
			
			stmtsave.setString(1,null);
			stmtsave.setDate(2,null);
			stmtsave.setString(3,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(4,session.getAttribute("USERID").toString());
			stmtsave.setString(5,mode);
			stmtsave.setString(6,formdetailcode);
			stmtsave.setInt(7,docno);
			
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
	        	
			//	String resql=("select docno, mtype, name, DATE_FORMAT(date,'%d.%m.%Y') date from gl_vrepm where status=3 ");
				
				String resql=("select doc_no,compname, date from gl_complaint where status=3 ");
				
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
	
