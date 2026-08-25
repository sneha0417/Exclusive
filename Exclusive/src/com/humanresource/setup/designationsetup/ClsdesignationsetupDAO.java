package com.humanresource.setup.designationsetup;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.*;

import com.common.*;
public class ClsdesignationsetupDAO {

 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public int insert1(Date formdate, String grade,   HttpSession session, HttpServletRequest request,String mode ,int docno) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection(); 
 
				
				CallableStatement stmt = conn.prepareCall("{CALL HR_gradeDML(?,?,?,?,?,?,?)}");

				if(mode.equalsIgnoreCase("A"))
				{
					stmt.registerOutParameter(7, java.sql.Types.INTEGER);
				}
				
				else
				{
					stmt.setInt(7, docno);
				}
				
				// main
				stmt.setDate(1,formdate);
				stmt.setString(2,grade);
			 
                stmt.setString(3,mode);
				stmt.setString(4,session.getAttribute("USERID").toString().trim());
				stmt.setString(5,session.getAttribute("BRANCHID").toString().trim());
				stmt.setString(6,"GRD");
				stmt.executeQuery();
				docno=stmt.getInt("docNo");
					
				if(docno<=0){
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmt.close();
				 
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int insert2(Date masterdate, String qualification,
			HttpSession session, HttpServletRequest request, String mode,
			int docno) throws SQLException {
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection(); 
 
				
				CallableStatement stmt = conn.prepareCall("{CALL HR_qualificationDML(?,?,?,?,?,?,?)}");

				if(mode.equalsIgnoreCase("A"))
				{
					stmt.registerOutParameter(7, java.sql.Types.INTEGER);
				}
				
				else
				{
					stmt.setInt(7, docno);
				}
				
				// main
				stmt.setDate(1,masterdate);
				stmt.setString(2,qualification);
			 
                stmt.setString(3,mode);
				stmt.setString(4,session.getAttribute("USERID").toString().trim());
				stmt.setString(5,session.getAttribute("BRANCHID").toString().trim());
				stmt.setString(6,"QLF");
				stmt.executeQuery();
				docno=stmt.getInt("docNo");
					
				if(docno<=0){
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmt.close();
				 
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	
	public JSONArray search1() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select doc_no,desc1 grade,date from hr_designgrade where status=3");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray search2() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select doc_no,desc1 qualification ,date from hr_designqual where status=3");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	
}
