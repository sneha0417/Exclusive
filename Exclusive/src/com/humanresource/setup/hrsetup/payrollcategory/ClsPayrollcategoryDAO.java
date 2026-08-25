package com.humanresource.setup.hrsetup.payrollcategory;

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

public class ClsPayrollcategoryDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String Desc, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request, int timesheet) throws SQLException {
		 
		Connection conn=null;

		try{
			
				 conn=ClsConnection.getMyConnection();
				 Statement stmtPCT1 = conn.createStatement();
					
				 String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				 ResultSet rs = stmtPCT1.executeQuery(strSql);
				
				 String method="";
				 while(rs.next()) {
					method=rs.getString("method");
				 } 
			    
				 if(method.equalsIgnoreCase("1")){
					
					String sqls="select * from hr_setpaycat where desc1='"+Desc+"' and status<>7";
					ResultSet resultSet1 = stmtPCT1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				 }	
					
				  CallableStatement stmtPCT = conn.prepareCall("{CALL HR_payrollcategoryDML(?,?,?,?,?,?,?,?,?)}");
					
				  stmtPCT.registerOutParameter(8, java.sql.Types.INTEGER);
				  // main
				  stmtPCT.setDate(1,formdate);
				  stmtPCT.setString(2,Desc);
				  stmtPCT.setString(3,remarks);
                  stmtPCT.setString(4,mode);
				  stmtPCT.setString(5,session.getAttribute("USERID").toString().trim());
				  stmtPCT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				  stmtPCT.setString(7,fromcode);
				  stmtPCT.setInt(9,timesheet);
				  stmtPCT.executeQuery();
				  int docno=stmtPCT.getInt("docNo");
					
				  if(docno<=0) {
					  conn.close();
					  return 0;
				  }	     
					
				  if (docno > 0) {
					  stmtPCT.close();
					  stmtPCT1.close();
					  conn.close();
					  return docno;
				  }		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int Update(int docno, Date formdate, String Desc,String remarks, String mode, String formdetailcode,HttpSession session, HttpServletRequest request, int timesheet) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtPCT1 = conn.createStatement();
					
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtPCT1.executeQuery(strSql);
					
				String method="";
				while(rs.next()) {
						method=rs.getString("method");
				} 
				    
				if(method.equalsIgnoreCase("1")){
						String sqls="select * from hr_setpaycat where desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
						ResultSet resultSet1 = stmtPCT1.executeQuery(sqls);
						   
						while (resultSet1.next()) {
						      return -1;
						}
				 }
					
				 CallableStatement stmtPCT = conn.prepareCall("{CALL HR_payrollcategoryDML(?,?,?,?,?,?,?,?,?)}");
					             
				 stmtPCT.setInt(8,docno);

			     // main
				 stmtPCT.setDate(1,formdate);
				 stmtPCT.setString(2,Desc);
				 stmtPCT.setString(3,remarks);
                 stmtPCT.setString(4,mode);
				 stmtPCT.setString(5,session.getAttribute("USERID").toString().trim());
				 stmtPCT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				 stmtPCT.setString(7,formdetailcode);
				 stmtPCT.setInt(9,timesheet);
				 int result=	stmtPCT.executeUpdate();
			     docno=stmtPCT.getInt("docNo");
					
			     if(result<=0) {
			    	 conn.close();
			    	 return 0;
			     }	     
				
			     if (docno > 0) {
			    	 stmtPCT.close();
			    	 stmtPCT1.close();
			    	 conn.close();
			    	 return docno;
			     }		
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
		    }
			return 0;
	}

	public int delete(int docno, String mode, String formdetailcode,HttpSession session, HttpServletRequest request ) throws SQLException {
 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
			
				CallableStatement stmtPCT = conn.prepareCall("{CALL HR_payrollcategoryDML(?,?,?,?,?,?,?,?,?)}");
				
				stmtPCT.setInt(8,docno);
				// main
				stmtPCT.setDate(1,null);
				stmtPCT.setString(2,null);
				stmtPCT.setString(3,null);
                stmtPCT.setString(4,mode);
				stmtPCT.setString(5,session.getAttribute("USERID").toString().trim());
				stmtPCT.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtPCT.setString(7,formdetailcode);
				stmtPCT.setInt(9,0);
				int result=	stmtPCT.executeUpdate();
				docno=stmtPCT.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtPCT.close();
					conn.close();
					return docno;
				}		
					
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	
    public JSONArray searchcategory() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtPCT = conn.createStatement();
            	
				String sql=("select doc_no,desc1 category ,remarks,date,timesheet from hr_setpaycat where status=3");
				
				ResultSet resultSet = stmtPCT.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtPCT.close();
				conn.close();
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
		}
        return RESULTDATA;
    }
}
