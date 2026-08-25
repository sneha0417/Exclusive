package com.controlcentre.masters.vehiclemaster.vehtype;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityBean;

import net.sf.json.JSONArray;

public class ClsVehTypeDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getVehTypeData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select name,doc_no,date from gl_vehtype where status<>7";
			ResultSet rs=stmt.executeQuery(str);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public int insert(String name,java.sql.Date date, HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			int aaa=0;
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select * from gl_vehtype where status<>7 and name='"+name+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
			stmtAuth.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtAuth.setString(1,name);
			stmtAuth.setString(2,date.toString());
			stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
			stmtAuth.setString(4,session.getAttribute("USERID").toString());
			stmtAuth.setString(6,mode);
			stmtAuth.setString(7, formdetailcode);
			stmtAuth.executeQuery();
			aaa=stmtAuth.getInt("docNo");
			if (aaa > 0) {
				conn.commit();
				return aaa;
			}
		}
		catch(Exception e){	
			e.printStackTrace();	
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}
	
	public int edit(int docno, java.sql.Date date,String name,HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select * from gl_vehtype where status<>7 and name='"+name+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
			stmtAuth.setInt(5,docno);
			stmtAuth.setString(1,name);
			stmtAuth.setDate(2,date);
			stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
			stmtAuth.setString(4,session.getAttribute("USERID").toString());
			stmtAuth.setString(6,mode);
			stmtAuth.setString(7, formdetailcode);
			int aa = stmtAuth.executeUpdate();
			if (aa>0) {
				conn.commit();
				return aa;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}


public int delete(int docno, java.sql.Date date, String name,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);		
		Statement stmtTest=conn.createStatement ();
		String testsql2="select * from gl_vehtype b inner join gl_vehmodel m on m.vehtypeid=b.doc_no where b.name='"+name+"'";
		ResultSet resultSet2 = stmtTest.executeQuery (testsql2);
		if(resultSet2.next()){
			return -2;
		}
		CallableStatement stmtAuth = conn.prepareCall("{call vehTypeDML(?,?,?,?,?,?,?)}");
		stmtAuth.setInt(5,docno);
		stmtAuth.setString(1,name);
		stmtAuth.setDate(2,date);
		stmtAuth.setString(3,session.getAttribute("BRANCHID").toString());
		stmtAuth.setString(4,session.getAttribute("USERID").toString());
		stmtAuth.setString(6,mode);
		stmtAuth.setString(7, formdetailcode);
		int aa = stmtAuth.executeUpdate();
		if (aa>0) {
			conn.commit();
			return aa;
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	return 0;
}

}
