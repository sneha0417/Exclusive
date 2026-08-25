package com.humanresource.setup.hrsetup.agent;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String agent, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtAGT1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtAGT1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					
					String sqls="select * from hr_setagent where desc1='"+agent+"' and status<>7";
					ResultSet resultSet1 = stmtAGT1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}	
				
				CallableStatement stmtAGT = conn.prepareCall("{CALL HR_agentDML(?,?,?,?,?,?,?,?)}");

				stmtAGT.registerOutParameter(8, java.sql.Types.INTEGER);
				// main
				stmtAGT.setDate(1,formdate);
				stmtAGT.setString(2,agent);
				stmtAGT.setString(3,remarks);
                stmtAGT.setString(4,mode);
				stmtAGT.setString(5,session.getAttribute("USERID").toString().trim());
				stmtAGT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtAGT.setString(7,fromcode);
				stmtAGT.executeQuery();
				int	 docno=stmtAGT.getInt("docNo");
					
				if(docno<=0){
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtAGT.close();
					stmtAGT1.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}
	
	public int Update(int docno, Date formdate, String agent,String remarks, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtAGT1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtAGT1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					String sqls="select * from hr_setagent where desc1='"+agent+"' and status<>7  and doc_no!="+docno;
					ResultSet resultSet1 = stmtAGT1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}
				
				CallableStatement stmtAGT = conn.prepareCall("{CALL HR_agentDML(?,?,?,?,?,?,?,?)}");

	            stmtAGT.setInt(8,docno);
			     // main
				stmtAGT.setDate(1,formdate);
				stmtAGT.setString(2,agent);
				stmtAGT.setString(3,remarks);
                stmtAGT.setString(4,mode);
				stmtAGT.setString(5,session.getAttribute("USERID").toString().trim());
				stmtAGT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtAGT.setString(7,formdetailcode);
				int result=	stmtAGT.executeUpdate();
				docno=stmtAGT.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtAGT.close();
					stmtAGT1.close();
					conn.close();
		            return docno;
				}		
					
			} catch (Exception e) {
				conn.close();
				e.printStackTrace();
			}
		return 0;
	}

	public int delete(int docno, String mode, String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
			
				CallableStatement stmtAGT = conn.prepareCall("{CALL HR_agentDML(?,?,?,?,?,?,?,?)}");

	            stmtAGT.setInt(8,docno);

			      // main
				stmtAGT.setDate(1,null);
				stmtAGT.setString(2,null);
				stmtAGT.setString(3,null);
                stmtAGT.setString(4,mode);
				stmtAGT.setString(5,session.getAttribute("USERID").toString().trim());
				stmtAGT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtAGT.setString(7,formdetailcode);
					
				int result=	stmtAGT.executeUpdate();
				docno=stmtAGT.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
				
				if (docno > 0) {
					stmtAGT.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}
        
	public JSONArray searchAgent() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAGT = conn.createStatement ();
            	
				String  sql=("select doc_no,desc1 agent ,remarks,date from hr_setagent where status=3");
				
				ResultSet resultSet = stmtAGT.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtAGT.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
}
