package com.humanresource.setup.hrsetup.designation;

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

public class ClsDesignationDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String designation, String remarks, String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
		 
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
					
					String sqls="select * from hr_setdesig where desc1='"+designation+"' and status<>7";
					ResultSet resultSet1 = stmtDES1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}	
				
				CallableStatement stmtDES = conn.prepareCall("{CALL HR_designationDML(?,?,?,?,?,?,?,?)}");

				stmtDES.registerOutParameter(8, java.sql.Types.INTEGER);

			    // main
				stmtDES.setDate(1,formdate);
				stmtDES.setString(2,designation);
				stmtDES.setString(3,remarks);
				stmtDES.setString(4,mode);
				stmtDES.setString(5,session.getAttribute("USERID").toString().trim());
				stmtDES.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtDES.setString(7,fromcode);
				stmtDES.executeQuery();
				int	 docno=stmtDES.getInt("docNo");
					
				if(docno<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtDES.close();
					stmtDES1.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int Update(int docno, Date formdate, String designation, String remarks, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
		
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
					String sqls="select * from hr_setdesig where desc1='"+designation+"' and status<>7  and doc_no!="+docno;
					ResultSet resultSet1 = stmtDES1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}
				
				CallableStatement stmtDES = conn.prepareCall("{CALL HR_designationDML(?,?,?,?,?,?,?,?)}");

				stmtDES.setInt(8,docno);

			    // main
				stmtDES.setDate(1,formdate);
				stmtDES.setString(2,designation);
				stmtDES.setString(3,remarks);
				stmtDES.setString(4,mode);
				stmtDES.setString(5,session.getAttribute("USERID").toString().trim());
				stmtDES.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtDES.setString(7,formdetailcode);
				int result=	stmtDES.executeUpdate();
				docno=stmtDES.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
				
				if (docno > 0) {
					stmtDES.close();
					stmtDES1.close();
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
			
				CallableStatement stmtDES = conn.prepareCall("{CALL HR_designationDML(?,?,?,?,?,?,?,?)}");

				stmtDES.setInt(8,docno);

			      // main
				stmtDES.setDate(1,null);
				stmtDES.setString(2,null);
				stmtDES.setString(3,null);
				stmtDES.setString(4,mode);
                stmtDES.setString(5,session.getAttribute("USERID").toString().trim());
                stmtDES.setString(6,session.getAttribute("BRANCHID").toString().trim());
                stmtDES.setString(7,formdetailcode);
				int result=	stmtDES.executeUpdate();
				docno=stmtDES.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
				
				if (docno > 0) {
					stmtDES.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}
        
	public JSONArray searchDesignation() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select doc_no,desc1 designation ,remarks,date from hr_setdesig where status=3");
				
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
