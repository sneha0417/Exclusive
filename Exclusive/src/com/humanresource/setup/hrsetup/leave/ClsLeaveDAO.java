package com.humanresource.setup.hrsetup.leave;

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

public class ClsLeaveDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(Date formdate, String Desc, String abbreviation,String remarks, String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
		 
		Connection conn=null;

		try{
					conn=ClsConnection.getMyConnection();
					Statement stmtLEV1 = conn.createStatement();
					
					String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
					ResultSet rs = stmtLEV1.executeQuery(strSql);
					
					String method="";
					while(rs.next()) {
						method=rs.getString("method");
					} 
				    
					if(method.equalsIgnoreCase("1")){
						
						String sqls="select * from hr_setleave where desc1='"+Desc+"' and status<>7";
						ResultSet resultSet1 = stmtLEV1.executeQuery(sqls);
						   
						while (resultSet1.next()) {
						      return -1;
						}
					}	
					
					CallableStatement stmtLEV = conn.prepareCall("{CALL HR_leaveDML(?,?,?,?,?,?,?,?,?)}");

					stmtLEV.registerOutParameter(9, java.sql.Types.INTEGER);
				      // main
					stmtLEV.setDate(1,formdate);
					stmtLEV.setString(2,Desc);
					stmtLEV.setString(3,abbreviation);
					stmtLEV.setString(4,remarks);
	                stmtLEV.setString(5,mode);
					stmtLEV.setString(6,session.getAttribute("USERID").toString().trim());
					stmtLEV.setString(7,session.getAttribute("BRANCHID").toString().trim());
					stmtLEV.setString(8,fromcode);
					stmtLEV.executeQuery();
					int	 docno=stmtLEV.getInt("docNo");
					
					if(docno<=0) {
						conn.close();
						return 0;
					}	     
					
					if (docno > 0) {
						stmtLEV.close();
						stmtLEV1.close();
						conn.close();
						return docno;
				    }		
					
			} catch (Exception e) {
				conn.close();
				e.printStackTrace();
			}
			return 0;
	}

	public int Update(int docno, Date formdate, String Desc, String abbreviation, String remarks, String mode, String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			conn=ClsConnection.getMyConnection();
			Statement stmtLEV1 = conn.createStatement();
			
			String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
			ResultSet rs = stmtLEV1.executeQuery(strSql);
			
			String method="";
			while(rs.next()) {
				method=rs.getString("method");
			} 
		    
			if(method.equalsIgnoreCase("1")){
				String sqls="select * from hr_setleave where desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
				ResultSet resultSet1 = stmtLEV1.executeQuery(sqls);
				   
				while (resultSet1.next()) {
				      return -1;
				}
			}
			
			CallableStatement stmtLEV = conn.prepareCall("{CALL HR_leaveDML(?,?,?,?,?,?,?,?,?)}");

            stmtLEV.setInt(9,docno);
		      // main
			stmtLEV.setDate(1,formdate);
			stmtLEV.setString(2,Desc);
			stmtLEV.setString(3,abbreviation);
			stmtLEV.setString(4,remarks);
            stmtLEV.setString(5,mode);
			stmtLEV.setString(6,session.getAttribute("USERID").toString().trim());
			stmtLEV.setString(7,session.getAttribute("BRANCHID").toString().trim());
			stmtLEV.setString(8,formdetailcode);
			int result=	stmtLEV.executeUpdate();
			docno=stmtLEV.getInt("docNo");
					
			if(result<=0) {
				conn.close();
				return 0;
			}	     
					
			if (docno > 0) {
				stmtLEV.close();
				stmtLEV1.close();
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
			
					CallableStatement stmtLEV = conn.prepareCall("{CALL HR_leaveDML(?,?,?,?,?,?,?,?,?)}");
		            
					stmtLEV.setInt(9,docno);
				      // main
					stmtLEV.setDate(1,null);
					stmtLEV.setString(2,null);
					stmtLEV.setString(3,null);
					stmtLEV.setString(4,null);
	                stmtLEV.setString(5,mode);
					stmtLEV.setString(6,session.getAttribute("USERID").toString().trim());
					stmtLEV.setString(7,session.getAttribute("BRANCHID").toString().trim());
					stmtLEV.setString(8,formdetailcode);
					int result=	stmtLEV.executeUpdate();
					docno=stmtLEV.getInt("docNo");
					
					if(result<=0) {
						conn.close();
						return 0;
					}	     
							
					if (docno > 0) {
						stmtLEV.close();
						conn.close();
			            return docno;
				    }
					
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
	return 0;
	}
	
    public JSONArray searchLeave() throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtLEV = conn.createStatement ();
            	
				String  tarifsql=("select doc_no,desc1 leave1,remarks,date,coalesce(alpha,'') abbreviation from hr_setleave where status=3");
				
				ResultSet resultSet = stmtLEV.executeQuery (tarifsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtLEV.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

    public JSONArray leaveAbbrevationDetails() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtLEV = conn.createStatement ();
            	
				String  tarifsql=("select alpha,name from hr_timesheetset where reftype='L' and alpha NOT IN (select alpha from hr_setleave where status=3)");
				
				ResultSet resultSet = stmtLEV.executeQuery (tarifsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtLEV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
}
