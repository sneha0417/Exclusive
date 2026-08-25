package com.fixedassets.masters.groupmaster;

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

public class ClsFixedAssetGroupDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String code,String name,java.sql.Date gmdate,HttpSession session,String mode) throws SQLException{
		
		
		Connection conn=null;
		int  docno=0;
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtleaseagmt = conn.prepareCall("{CALL fixedgrpDML(?,?,?,?,?,?,?)}");
			
			stmtleaseagmt.registerOutParameter(6, java.sql.Types.INTEGER);
		     
		      stmtleaseagmt.setDate(1,gmdate);
		      stmtleaseagmt.setString(2,code);
		      stmtleaseagmt.setString(3,name);
		      stmtleaseagmt.setString(4,session.getAttribute("BRANCHID").toString().trim());
		      stmtleaseagmt.setString(5,session.getAttribute("USERID").toString().trim());
		      stmtleaseagmt.setString(7,mode);
		      stmtleaseagmt.executeQuery();
			    docno=stmtleaseagmt.getInt("docNo");
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
			
			CallableStatement stmtleaseagmt = conn.prepareCall("{CALL fixedgrpDML(?,?,?,?,?,?,?)}");
			
			stmtleaseagmt.setInt(6, docno);
		     
		      stmtleaseagmt.setDate(1,gmdate);
		      stmtleaseagmt.setString(2,code);
		      stmtleaseagmt.setString(3,name);
		      stmtleaseagmt.setString(4,session.getAttribute("BRANCHID").toString().trim());
		      stmtleaseagmt.setString(5,session.getAttribute("USERID").toString().trim());
		      stmtleaseagmt.setString(7,mode);
		      stmtleaseagmt.executeQuery();
			    docno=stmtleaseagmt.getInt("docNo");
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
		
		CallableStatement stmtleaseagmt = conn.prepareCall("{CALL fixedgrpDML(?,?,?,?,?,?,?)}");
		
		stmtleaseagmt.setInt(6, docno);
	     
	      stmtleaseagmt.setDate(1,gmdate);
	      stmtleaseagmt.setString(2,code);
	      stmtleaseagmt.setString(3,name);
	      stmtleaseagmt.setString(4,session.getAttribute("BRANCHID").toString().trim());
	      stmtleaseagmt.setString(5,session.getAttribute("USERID").toString().trim());
	      stmtleaseagmt.setString(7,mode);
	      stmtleaseagmt.executeQuery();
		    docno=stmtleaseagmt.getInt("docNo");
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




public  JSONArray grpgridLoad(HttpSession session) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
    
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
        	
			ResultSet resultSet = stmt.executeQuery ("select doc_no, grp_name, grp_code, date as grpdate from my_fagrp where status=3");

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
