package com.controlcentre.masters.maintenancemaster.garage;

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
import com.controlcentre.masters.maintenancemaster.damage.ClsDamageBean;

public class ClsGarageDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsGarageBean garageBean=new ClsGarageBean();


	public int insert( String garagecode,String garagename,Date garagedate,int txtaccno,String type,String location,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
		Connection conn = null;
		
		try{
			int docno;
			conn=ClsConnection.getMyConnection();

			CallableStatement stmtGarage = conn.prepareCall("{call garageDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtGarage.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtGarage.setString(1,garagecode);
			stmtGarage.setString(2,garagename);
			stmtGarage.setString(3, location);
			stmtGarage.setDate(4, garagedate);
			stmtGarage.setInt(5, txtaccno);
			stmtGarage.setString(6, type);
			
			stmtGarage.setString(7,session.getAttribute("USERID").toString());
			stmtGarage.setString(8,session.getAttribute("BRANCHID").toString());
			stmtGarage.setString(10,mode);
			stmtGarage.setString(11,formdetailcode);
			stmtGarage.executeQuery();

			docno=stmtGarage.getInt("docNo");
			garageBean.setDocno(docno);
			
			if (docno > 0) {
				stmtGarage.close();
				conn.close();
				return docno;
			}
			stmtGarage.close();
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
	
  public boolean edit( String garagecode,String garagename,Date garagedate,int txtaccno,String type,String location,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	
	Connection conn = null;
	
	try{
		conn=ClsConnection.getMyConnection();
		
		CallableStatement stmtGarage = conn.prepareCall("{call garageDML(?,?,?,?,?,?,?,?,?,?,?)}");

		stmtGarage.setInt(9,docno);
		stmtGarage.setString(1,garagecode);
		stmtGarage.setString(2,garagename);
		stmtGarage.setString(3, location);
		stmtGarage.setDate(4, garagedate);
		stmtGarage.setInt(5, txtaccno);
		stmtGarage.setString(6, type);

		stmtGarage.setString(7,session.getAttribute("USERID").toString());
		stmtGarage.setString(8,session.getAttribute("BRANCHID").toString());
		stmtGarage.setString(10,mode);
		stmtGarage.setString(11,formdetailcode);
		
		int data = stmtGarage.executeUpdate();
		
		if (data>0) {
			stmtGarage.close();
			conn.close();
			return true;
		}
		stmtGarage.close();
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

  public boolean delete(String garagecode,String garagename,Date garagedate,int txtaccno,String type,String location,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	
	  Connection conn = null;
	  
	    try{
			conn=ClsConnection.getMyConnection();
	
			CallableStatement stmtGarage = conn.prepareCall("{call garageDML(?,?,?,?,?,?,?,?,?,?,?)}");
	
			stmtGarage.setInt(9,docno);
			stmtGarage.setString(1,garagecode);
			stmtGarage.setString(2,garagename);
			stmtGarage.setString(3, location);
			stmtGarage.setDate(4, garagedate);
			stmtGarage.setInt(5, txtaccno);
			stmtGarage.setString(6, type);
			
			stmtGarage.setString(7,session.getAttribute("USERID").toString());
			stmtGarage.setString(8,session.getAttribute("BRANCHID").toString());
			stmtGarage.setString(10,mode);
			stmtGarage.setString(11,formdetailcode);
	
			int data = stmtGarage.executeUpdate();
			stmtGarage.close();
			conn.close();
			
			if (data>0) {
				stmtGarage.close();
				conn.close();
				return true;
			}
			
			stmtGarage.close();
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

	public  JSONArray getGarage() throws SQLException {
	    List<ClsDamageBean> listbean = new ArrayList<ClsDamageBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtmovement = conn.createStatement();
				
	        	String strSql="select m1.doc_no,m1.code,m1.name,m1.branch,m1.location,m1.date,m1.acc_no,m1.type,m2.description from gl_garrage m1 left join"+
	        				  " my_head m2 on m1.acc_no=m2.doc_no where status<>7 order by m1.doc_no asc";
	        	
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

