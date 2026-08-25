package com.controlcentre.masters.vehiclemaster.securitypass;

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

public class ClsSecurityPassDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public int insert(Date sqldate, String name,  String description, String mode, HttpSession session, String formdetailcode,Date sdate,Date edate,String qty) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{call vehPassAuthDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(8, java.sql.Types.INTEGER);
			stmt.setString(1, name);
			stmt.setString(2, description);
			stmt.setDate(3, sqldate);
			stmt.setString(4, session.getAttribute("USERID").toString());
			stmt.setString(5, session.getAttribute("BRANCHID").toString());
			stmt.setString(6, mode);
			stmt.setString(7, formdetailcode);
			stmt.setDate(9, sdate);
			stmt.setDate(10, edate);
			stmt.setString(11, qty);
			stmt.executeQuery();
			docno=stmt.getInt("docNo");
			if(docno>0){
				conn.commit();
				return docno;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public boolean edit(int docno, Date sqldate, String name,  String description, String mode, HttpSession session, String formdetailcode,Date sdate,Date edate,String qty) throws SQLException{
		// TODO Auto-generated method stub
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{call vehPassAuthDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(8, docno);
			stmt.setString(1, name);
			stmt.setString(2, description);
			stmt.setDate(3, sqldate);
			stmt.setString(4, session.getAttribute("USERID").toString());
			stmt.setString(5, session.getAttribute("BRANCHID").toString());
			stmt.setString(6, mode);
			stmt.setString(7, formdetailcode);
			stmt.setDate(9, sdate);
			stmt.setDate(10, edate);
			stmt.setString(11, qty);
			int val =stmt.executeUpdate();
			if(val>0){
				conn.commit();
				return true;
			}
			else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno, String mode, HttpSession session, String formdetailcode) throws SQLException{
		// TODO Auto-generated method stub

		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{call vehPassAuthDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(8, docno);
			stmt.setString(1, null);
			stmt.setString(2, null);
			stmt.setDate(3, null);
			stmt.setString(4, session.getAttribute("USERID").toString());
			stmt.setString(5, session.getAttribute("BRANCHID").toString());
			stmt.setString(6, mode);
			stmt.setString(7, formdetailcode);
			stmt.setDate(9, null);
			stmt.setDate(10, null);
			stmt.setString(11, null);
			int val =stmt.executeUpdate();
			if(val>0){
				conn.commit();
				return true;
			}
			else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray searchDetails() throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String srchqry="select DOC_NO,DATE,NAME,DESCRIPTION,STARTDATE,ENDDATE,QTY from gl_vehpassauth where status=3;";
			
			ResultSet rs=stmt.executeQuery(srchqry);
			RESULTDATA=objcommon.convertToJSON(rs);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
		
		return RESULTDATA;
	}
}
