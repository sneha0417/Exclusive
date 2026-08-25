package com.humanresource.setup.hrsetup.department;

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

public class ClsDepartmentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String Desc, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtDEP1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtDEP1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					
					String sqls="select * from hr_setdept where desc1='"+Desc+"' and status<>7";
					ResultSet resultSet1 = stmtDEP1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}	
				
				CallableStatement stmtDEP = conn.prepareCall("{CALL HR_departmentDML(?,?,?,?,?,?,?,?)}");

				stmtDEP.registerOutParameter(8, java.sql.Types.INTEGER);
				// main
				stmtDEP.setDate(1,formdate);
				stmtDEP.setString(2,Desc);
				stmtDEP.setString(3,remarks);
                stmtDEP.setString(4,mode);
				stmtDEP.setString(5,session.getAttribute("USERID").toString().trim());
				stmtDEP.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtDEP.setString(7,fromcode);
				stmtDEP.executeQuery();
				int	 docno=stmtDEP.getInt("docNo");
					
				if(docno<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtDEP.close();
					stmtDEP1.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int Update(int docno, Date formdate, String Desc, String remarks, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
					conn=ClsConnection.getMyConnection();
					Statement stmtDES1 = conn.createStatement();
					
					String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
					ResultSet rs = stmtDES1.executeQuery(strSql);
					
					String method="";
					while(rs.next()) {
						method=rs.getString("method");
					} 
				    
					if(method.equalsIgnoreCase("1")){
						String sqls="select * from hr_setdept where desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
						ResultSet resultSet1 = stmtDES1.executeQuery(sqls);
						   
						while (resultSet1.next()) {
						      return -1;
						}
					}
					
					CallableStatement stmtDEP = conn.prepareCall("{CALL HR_departmentDML(?,?,?,?,?,?,?,?)}");

					stmtDEP.setInt(8,docno);

				    // main
					stmtDEP.setDate(1,formdate);
					stmtDEP.setString(2,Desc);
					stmtDEP.setString(3,remarks);
	                stmtDEP.setString(4,mode);
					stmtDEP.setString(5,session.getAttribute("USERID").toString().trim());
					stmtDEP.setString(6,session.getAttribute("BRANCHID").toString().trim());
					stmtDEP.setString(7,formdetailcode);
					
					int result=	stmtDEP.executeUpdate();
					docno=stmtDEP.getInt("docNo");
					
					if(result<=0) {
						conn.close();
						return 0;
					}	     
					
					if (docno > 0) {
						stmtDEP.close();
						conn.close();
						return docno;
					}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int delete(int docno, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			
					conn=ClsConnection.getMyConnection();
			
					CallableStatement stmtDEP = conn.prepareCall("{CALL HR_departmentDML(?,?,?,?,?,?,?,?)}");
					
					stmtDEP.setInt(8,docno);

				    // main
					stmtDEP.setDate(1,null);
					stmtDEP.setString(2,null);
					stmtDEP.setString(3,null);
	                stmtDEP.setString(4,mode);
					stmtDEP.setString(5,session.getAttribute("USERID").toString().trim());
					stmtDEP.setString(6,session.getAttribute("BRANCHID").toString().trim());
					stmtDEP.setString(7,formdetailcode);
					
					int result=	stmtDEP.executeUpdate();
					docno=stmtDEP.getInt("docNo");
					
					if(result<=0) {
						conn.close();
						return 0;
					}	     
					
					if (docno > 0) {
						stmtDEP.close();
						conn.close();
						return docno;
					}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
	return 0;
	}
        
    public JSONArray searchDepartment() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDEP = conn.createStatement ();
            	
				String  sql=("select doc_no,desc1 department,remarks,date from hr_setdept where status=3");
				
				ResultSet resultSet = stmtDEP.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDEP.close();
				conn.close();
		   } catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
}
