package com.dashboard.audit.documentcontrolregister;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDocmntCntrlRegDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray docmntContrlRegGrid(String brnchval,String id,String chk_val) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		java.sql.Date sqlfromdate = null;
		String sqltest="";
		

		java.sql.Date sqltodate = null;
		if(chk_val.equalsIgnoreCase("1")){//new docment
			
		}
		if(chk_val.equalsIgnoreCase("2")){//expired doc
			sqltest+=" and curdate() >= d.exp_date ";
		}
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			if(id.equalsIgnoreCase("1")) {
				
			String sql="select d.doc_no, d.docname name, d.descr 'desc', d.issue_date, d.exp_date, d.note ,'ATTACH' as attach from gl_docmntcntrlreg d where status<>7 "+sqltest;
			//System.out.println("--docmntContrlRegGrid--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			stmtVeh.close();

			conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray docmntContrlRegGridexcel(String brnchval,String id,String chk_val) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		java.sql.Date sqlfromdate = null;
		String sqltest="";
		

		java.sql.Date sqltodate = null;
		if(chk_val.equalsIgnoreCase("1")){//new docment
			
		}
		if(chk_val.equalsIgnoreCase("2")){//expired doc
			sqltest+=" and curdate() >= d.exp_date ";
		}
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			if(id.equalsIgnoreCase("1")) {
				
			String sql="select d.doc_no Doc_no, d.docname Document_name, d.descr Description, d.issue_date Issue_Date, d.exp_date Expiry_Date, d.note Note from gl_docmntcntrlreg d where status<>7  "+sqltest;
			System.out.println("--docmntContrlRegGrid--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			}
			stmtVeh.close();

			conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


}
