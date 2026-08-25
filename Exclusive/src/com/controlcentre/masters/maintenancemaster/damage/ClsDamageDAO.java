package com.controlcentre.masters.maintenancemaster.damage;

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

public class ClsDamageDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	ClsDamageBean damageBean=new ClsDamageBean();
	
	public int insert( String cmbtype,String name1,Date damagedate,double dmgcharge,HttpSession session,String mode,String formdetailcode) throws SQLException {
		
		Connection conn = null;
		
		try{
	
			conn=ClsConnection.getMyConnection();
			int docno;
			
			CallableStatement stmtDamage = conn.prepareCall("{call vehDamageDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtDamage.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtDamage.setString(1,cmbtype);
			stmtDamage.setString(2,name1);
			stmtDamage.setDouble(3, dmgcharge);
			stmtDamage.setDate(4, damagedate);
			stmtDamage.setString(6,session.getAttribute("BRANCHID").toString());
			stmtDamage.setString(5,session.getAttribute("USERID").toString());
			stmtDamage.setString(8,mode);
			stmtDamage.setString(9,formdetailcode);

			stmtDamage.executeQuery();
			docno=stmtDamage.getInt("docNo");
			damageBean.setDocno(docno);
			
			if (docno > 0) {
				stmtDamage.close();
				conn.close();
				return docno;
			}
			stmtDamage.close();
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

	public boolean edit(String cmbtype,String name1,Date damagedate,double dmgcharge,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtDamage = conn.prepareCall("{call vehDamageDML(?,?,?,?,?,?,?,?,?)}");

			stmtDamage.setInt(7,docno);
			stmtDamage.setString(1,cmbtype);
			stmtDamage.setString(2,name1);
			stmtDamage.setDouble(3, dmgcharge);
			stmtDamage.setDate(4, damagedate);
			stmtDamage.setString(5,session.getAttribute("USERID").toString());
			stmtDamage.setString(6,session.getAttribute("BRANCHID").toString());
			stmtDamage.setString(8,mode);
			stmtDamage.setString(9,formdetailcode);
			
			int data = stmtDamage.executeUpdate();
			
			if (data>0) {
				stmtDamage.close();
				conn.close();
				return true;
			}
			stmtDamage.close();
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


	public boolean delete(String cmbtype,String name1,Date damagedate,double dmgcharge,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
			CallableStatement stmtDamage = conn.prepareCall("{call vehDamageDML(?,?,?,?,?,?,?,?,?)}");

			stmtDamage.setInt(7,docno);
			stmtDamage.setString(1,cmbtype);
			stmtDamage.setString(2,name1);
			stmtDamage.setDouble(3, dmgcharge);
			stmtDamage.setDate(4, damagedate);
			stmtDamage.setString(5,session.getAttribute("USERID").toString());
			stmtDamage.setString(6,session.getAttribute("BRANCHID").toString());
			stmtDamage.setString(8,mode);
			stmtDamage.setString(9,formdetailcode);

			int data = stmtDamage.executeUpdate();
			
			if (data>0) {
				stmtDamage.close();
				conn.close();
				return true;
			}
			stmtDamage.close();
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
	
	
	public  JSONArray getDamage() throws SQLException {
	    List<ClsDamageBean> listbean = new ArrayList<ClsDamageBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtmovement = conn.createStatement();
	        	
				String strSql="select type,name,dmg_chg,doc_no,date from gl_damage where status<>7";
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

