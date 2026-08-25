package com.realestate.jobmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsJobMasterDAO {

	ClsConnection conobj = new ClsConnection();

	ClsConnection ClsConnection = new ClsConnection();
	ClsJobMasterBean temp = new ClsJobMasterBean();
	ClsCommon ClsCommon = new ClsCommon();
	ClsCommon com = new ClsCommon();
	Connection c = null;

	public int insert(Date masterdate,int docno,String jobdesc,HttpSession session, HttpServletRequest request, String mode)throws SQLException {
      
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();   
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL rl_JobMasterDML(?,?,?,?,?,?,?)}");     
	          
			if(mode.equalsIgnoreCase("A")){
				stmt.registerOutParameter(7,java.sql.Types.INTEGER);    
			}else{
				stmt.setInt(7,docno);
			}
			stmt.setDate(1,masterdate);
			stmt.setString(2,jobdesc);
			stmt.setString(3,mode);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,"JBM");              
				
			int val = stmt.executeUpdate();
			int doc=stmt.getInt("docNo");
             
			if(doc>0){
				stmt.close();
				conn.commit();
				conn.close();
				return doc;
			}

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return 0;
	}

	public JSONArray jobMainSearch(HttpSession session, String job,String docno, String datess,String id)   
			throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		String sqltest="";   
		int brhid=Integer.parseInt(session.getAttribute("BRANCHID").toString());  
		if(!(id.equalsIgnoreCase("1")))     
		{
			return RESULTDATA;
		}
		java.sql.Date sqlStartDate = null;
		if (!(datess.equalsIgnoreCase("undefined")) && !(datess.equalsIgnoreCase("")) && !(datess.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);   
		}
		if(brhid!=0){
			sqltest=" and brhid='"+brhid+"'";         
		}
		if(!job.equalsIgnoreCase("")){
			sqltest=" and job_desc like '%"+job+"%'";        
		}
		if(!docno.equalsIgnoreCase("") && !docno.equalsIgnoreCase("0")){
			sqltest=" and doc_no='"+docno+"'";       
		}
		if(sqlStartDate!=null){
			sqltest=" and created_date='"+sqlStartDate+"'";                   
		}
		Connection conn = null;
		
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = " select job_desc name,created_date date,doc_no from rl_jobmaster where status=3 "+sqltest+" group by doc_no";
 
			System.out.println("sql---------->>>"+sql);    
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}
}
