package com.fixedassets.masters.locationmaster;

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
import com.mysql.jdbc.PreparedStatement;

public class ClsFixedAssetLocationDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String code,String name,java.sql.Date gmdate,HttpSession session,String mode) throws SQLException{
		
		
		Connection conn=null;
		int  docno=0;
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtfa = conn.prepareCall("{CALL fixedlocDML(?,?,?,?,?,?,?)}");
			
			stmtfa.registerOutParameter(6, java.sql.Types.INTEGER);
		     
		      stmtfa.setDate(1,gmdate);
		      stmtfa.setString(2,code);
		      stmtfa.setString(3,name);
		      stmtfa.setString(4,session.getAttribute("BRANCHID").toString().trim());
		      stmtfa.setString(5,session.getAttribute("USERID").toString().trim());
		      stmtfa.setString(7,mode);
		      stmtfa.executeQuery();
			    docno=stmtfa.getInt("docNo");
			    conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return docno;	
	}
	
public int edit(String code,String name,java.sql.Date gmdate,HttpSession session,String mode,int docno) throws SQLException{
		
		
		Connection conn=null;
		
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtfa = conn.prepareCall("{CALL fixedlocDML(?,?,?,?,?,?,?)}");
			
			stmtfa.setInt(6, docno);
		     
		      stmtfa.setDate(1,gmdate);
		      stmtfa.setString(2,code);
		      stmtfa.setString(3,name);
		      stmtfa.setString(4,session.getAttribute("BRANCHID").toString().trim());
		      stmtfa.setString(5,session.getAttribute("USERID").toString().trim());
		      stmtfa.setString(7,mode);
		      stmtfa.executeQuery();
			    docno=stmtfa.getInt("docNo");
			    conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return docno;	
	}



public int delete(String code,String name,java.sql.Date gmdate,HttpSession session,String mode,int docno) throws SQLException{
	
	
	Connection conn=null;
	
	
	try{
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
		CallableStatement stmtfa = conn.prepareCall("{CALL fixedlocDML(?,?,?,?,?,?,?)}");
		
		stmtfa.setInt(6, docno);
	     
	      stmtfa.setDate(1,gmdate);
	      stmtfa.setString(2,code);
	      stmtfa.setString(3,name);
	      stmtfa.setString(4,session.getAttribute("BRANCHID").toString().trim());
	      stmtfa.setString(5,session.getAttribute("USERID").toString().trim());
	      stmtfa.setString(7,mode);
	      stmtfa.executeQuery();
		    docno=stmtfa.getInt("docNo");
		    conn.commit();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
	return docno;	
}




public  JSONArray locgridLoad(HttpSession session) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
    
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
        	
			ResultSet resultSet = stmt.executeQuery ("select doc_no, loc_name, loc_code, date as locdate from my_faloc where status=3");

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
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
