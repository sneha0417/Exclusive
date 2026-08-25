package com.controlcentre.masters.vehiclemaster.leasecdw;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsLeaseCDWDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public int getActiveStatus() throws SQLException{
		int activestatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select method from gl_config where field_nme='Leasecdwmenu'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				activestatus=rs.getInt("method");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		System.out.println("CDW Active: "+activestatus);
		return activestatus;
	}

	public JSONArray getSearchData() throws SQLException{
		JSONArray searchdata=new JSONArray();
		System.out.println("Inside Search");
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,date,name,remarks,description,chkreplace,excesscdw from gl_vehleasecdw where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
			stmt.close();
			System.out.println("out Search");
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
		
	}
	public int insert(Date sqldate, String name, String hidchkreplace,
			String remarks, String description, String mode,
			HttpSession session, String brchName, String formdetailcode,String hidchkexscdw) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtcdw = conn.prepareCall("{call vehLeaseCDWDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtcdw.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtcdw.setString(1, name);
			stmtcdw.setString(2, description);
			stmtcdw.setString(3, remarks);
			stmtcdw.setDate(4, sqldate);
			stmtcdw.setString(5, hidchkreplace);
			stmtcdw.setString(6, session.getAttribute("USERID").toString());
			stmtcdw.setString(7, brchName);
			stmtcdw.setString(9, mode);
			stmtcdw.setString(10, formdetailcode);
			stmtcdw.setString(11, hidchkexscdw);
			stmtcdw.executeQuery();
			docno=stmtcdw.getInt("docNo");
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

	public boolean edit(int docno, Date sqldate, String name,
			String hidchkreplace, String remarks, String description,
			String mode, HttpSession session, String brchName, String formdetailcode,String hidchkexscdw) throws SQLException{
		// TODO Auto-generated method stub
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtcdw = conn.prepareCall("{call vehLeaseCDWDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtcdw.setInt(8, docno);
			stmtcdw.setString(1, name);
			stmtcdw.setString(2, description);
			stmtcdw.setString(3, remarks);
			stmtcdw.setDate(4, sqldate);
			stmtcdw.setString(5, hidchkreplace);
			stmtcdw.setString(6, session.getAttribute("USERID").toString());
			stmtcdw.setString(7, brchName);
			stmtcdw.setString(9, mode);
			stmtcdw.setString(10, formdetailcode);
			stmtcdw.setString(11, hidchkexscdw);
			int val=stmtcdw.executeUpdate();
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

	public boolean delete(int docno, Date sqldate, String name,
			String hidchkreplace, String remarks, String description,
			String mode, HttpSession session, String brchName, String formdetailcode,String hidchkexscdw) throws SQLException{
		// TODO Auto-generated method stub

		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtcdw = conn.prepareCall("{call vehLeaseCDWDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtcdw.setInt(8, docno);
			stmtcdw.setString(1, name);
			stmtcdw.setString(2, description);
			stmtcdw.setString(3, remarks);
			stmtcdw.setDate(4, sqldate);
			stmtcdw.setString(5, hidchkreplace);
			stmtcdw.setString(6, session.getAttribute("USERID").toString());
			stmtcdw.setString(7, brchName);
			stmtcdw.setString(9, mode);
			stmtcdw.setString(10, formdetailcode);
			stmtcdw.setString(11, hidchkexscdw);
			int val=stmtcdw.executeUpdate();
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
}
