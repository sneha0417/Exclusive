package com.dashboard.pricemanagement.reorderlevel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;


import com.common.*;

import com.connection.*;
public class ClsreorderLevelDAO {

	
	ClsConnection ClsConnection=new ClsConnection();
	
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray research(HttpSession session,String Brand) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		 
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql=" ";
String msg="";

String i="1";
String doctype="PO";
			String sqls="select msg from  gl_emailmsg;";
			ResultSet rs=stmt.executeQuery(sqls);
			
			if(rs.next())
			{
				msg=rs.getString("msg").replaceAll("docnos", Brand).replaceAll("branchval", i).replaceAll("doctypes", doctype);
			}
			
		 
			
		System.out.println("====msg===="+msg);
		
		 
		Statement stmt1 = conn.createStatement();
		
		ResultSet rss=stmt1.executeQuery(msg);
		
		if(rss.next())
		{
			System.out.println("=============IN=========");
		}
			
			 


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	
	public JSONArray message(String branch,String formdetailcode,String userid,String doc_no) throws SQLException{

		String msg="";	
		String sqlmessage="";
		Connection conn = null;



		JSONArray RESULTDATA=new JSONArray();

		 if(branch.equalsIgnoreCase("NA"))
		 {
			 return RESULTDATA;
		 }
		
		
		try{


			ClsConnection ClsConnection=new ClsConnection();  

			conn=ClsConnection.getMyConnection();
			
			
			ResultSet rs= conn.createStatement(
					ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
							"select msg from  gl_emailmsg ");
			Statement stmt=conn.createStatement();
		/*	String sqls="select msg from  gl_emailmsg;";
			ResultSet rs=stmt.executeQuery(sqls);
			*/
			 

			if(rs.next())
			{

				sqlmessage = rs.getString("msg").replaceAll("branch", branch).replaceAll("documentno", doc_no).replaceAll("documenttype", formdetailcode).replaceAll("userno", userid);
				
			}

			System.out.println("===sqlmessage===="+sqlmessage);
			
			ResultSet rsset=conn.createStatement().executeQuery(sqlmessage);

			while(rsset.next()) {
				System.out.println("===IN====");
				msg =rsset.getString("msg");
				
				
				

			}

			System.out.println("===msg===="+msg);
			

		}catch(SQLException e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}


		 
		return RESULTDATA;
	}
	
	
	
	
}
