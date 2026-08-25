package com.humanresource.setup.hrsetup.document;

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

public class ClsDocumentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String Desc, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
		 
		Connection conn=null;

		try{
			
					conn=ClsConnection.getMyConnection();
					Statement stmtDOC1 = conn.createStatement();
					
					String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
					ResultSet rs = stmtDOC1.executeQuery(strSql);
					
					String method="";
					while(rs.next()) {
						method=rs.getString("method");
					} 
				    
					if(method.equalsIgnoreCase("1")){
						
						String sqls="select * from hr_setdoc where desc1='"+Desc+"' and status<>7";
						ResultSet resultSet1 = stmtDOC1.executeQuery(sqls);
						   
						while (resultSet1.next()) {
						      return -1;
						}
					}	
					
					CallableStatement stmtDOC = conn.prepareCall("{CALL HR_documentDML(?,?,?,?,?,?,?,?)}");

					stmtDOC.registerOutParameter(8, java.sql.Types.INTEGER);
					// main
					stmtDOC.setDate(1,formdate);
					stmtDOC.setString(2,Desc);
					stmtDOC.setString(3,remarks);
	                stmtDOC.setString(4,mode);
					stmtDOC.setString(5,session.getAttribute("USERID").toString().trim());
					stmtDOC.setString(6,session.getAttribute("BRANCHID").toString().trim());
					stmtDOC.setString(7,fromcode);
					stmtDOC.executeQuery();
					int	 docno=stmtDOC.getInt("docNo");
					
					if(docno<=0) {
						conn.close();
						return 0;
					}
					
					if (docno > 0) {
						stmtDOC.close();
						stmtDOC1.close();
						conn.close();
						return docno;
					}		
					
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}

	public int Update(int docno, Date formdate, String Desc, String remarks, String mode, String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtDOC1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtDOC1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					String sqls="select * from hr_setdoc where desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
					ResultSet resultSet1 = stmtDOC1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}
				
				CallableStatement stmtDOC = conn.prepareCall("{CALL HR_documentDML(?,?,?,?,?,?,?,?)}");

				stmtDOC.setInt(8,docno);
				// main
				stmtDOC.setDate(1,formdate);
				stmtDOC.setString(2,Desc);
				stmtDOC.setString(3,remarks);
                stmtDOC.setString(4,mode);
				stmtDOC.setString(5,session.getAttribute("USERID").toString().trim());
				stmtDOC.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtDOC.setString(7,formdetailcode);
				int result=	stmtDOC.executeUpdate();
			    docno=stmtDOC.getInt("docNo");
					
			    if(result<=0) {
			    	conn.close();
			    	return 0;
			    }	     
					
			if (docno > 0) {
				stmtDOC.close();
				stmtDOC1.close();
				conn.close();
	            return docno;
			}		
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
	   return 0;
	}

	public int delete(int docno, String mode, String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;

		try{
			
					conn=ClsConnection.getMyConnection();
			
					CallableStatement stmtDOC = conn.prepareCall("{CALL HR_documentDML(?,?,?,?,?,?,?,?)}");
					          
					stmtDOC.setInt(8,docno);
					// main
					stmtDOC.setDate(1,null);
					stmtDOC.setString(2,null);
					stmtDOC.setString(3,null);
	                stmtDOC.setString(4,mode);
					stmtDOC.setString(5,session.getAttribute("USERID").toString().trim());
					stmtDOC.setString(6,session.getAttribute("BRANCHID").toString().trim());
					stmtDOC.setString(7,formdetailcode);
					
					int result=	stmtDOC.executeUpdate();
					docno=stmtDOC.getInt("docNo");
					
					if(result<=0) {
						conn.close();
						return 0;
					}	     
					
					if (docno > 0) {
						stmtDOC.close();
						conn.close();
						return docno;
					}		
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	
    public JSONArray searchDocument() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

    	Connection conn=null;
  
		try {
				  conn = ClsConnection.getMyConnection();
				  Statement stmtDOC = conn.createStatement();
            	
				  String  sql=("select doc_no,desc1 document ,remarks,date from hr_setdoc where status=3");
				
				  ResultSet resultSet = stmtDOC.executeQuery(sql);
				  RESULTDATA=ClsCommon.convertToJSON(resultSet);
				  
				stmtDOC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
}
