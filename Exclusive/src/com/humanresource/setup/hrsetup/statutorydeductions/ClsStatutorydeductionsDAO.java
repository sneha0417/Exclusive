package com.humanresource.setup.hrsetup.statutorydeductions;

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

public class ClsStatutorydeductionsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(Date formdate, String Desc, String remarks, String mode, String fromcode, HttpSession session, HttpServletRequest request, int accdocno, int typval) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtSTD1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtSTD1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					
					String sqls="select * from hr_setdeduction where desc1='"+Desc+"' and status<>7";
					ResultSet resultSet1 = stmtSTD1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}	
				
				CallableStatement stmtSTD = conn.prepareCall("{CALL HR_statutorydeductionsDML(?,?,?,?,?,?,?,?,?,?)}");

				stmtSTD.registerOutParameter(8, java.sql.Types.INTEGER);

				// main
				stmtSTD.setDate(1,formdate);
				stmtSTD.setString(2,Desc);
				stmtSTD.setString(3,remarks);
                stmtSTD.setString(4,mode);
				stmtSTD.setString(5,session.getAttribute("USERID").toString().trim());
				stmtSTD.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtSTD.setString(7,fromcode);
				stmtSTD.setInt(9,accdocno);
				stmtSTD.setInt(10,typval);
				stmtSTD.executeQuery();
				int	 docno=stmtSTD.getInt("docNo");
					
				if(docno<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtSTD.close();
					stmtSTD1.close();
					conn.close();
					return docno;
				}		
					
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int Update(int docno, Date formdate, String Desc, String remarks, String mode, String formdetailcode, HttpSession session, HttpServletRequest request, int accdocno, int typval) throws SQLException {

		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtSTD1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtSTD1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					String sqls="select * from hr_setdeduction where desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
					ResultSet resultSet1 = stmtSTD1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}
				
				CallableStatement stmtSTD = conn.prepareCall("{CALL HR_statutorydeductionsDML(?,?,?,?,?,?,?,?,?,?)}");

	            stmtSTD.setInt(8,docno);
			    // main
				stmtSTD.setDate(1,formdate);
				stmtSTD.setString(2,Desc);
				stmtSTD.setString(3,remarks);
                stmtSTD.setString(4,mode);
				stmtSTD.setString(5,session.getAttribute("USERID").toString().trim());
				stmtSTD.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtSTD.setString(7,formdetailcode);
				stmtSTD.setInt(9,accdocno);
				stmtSTD.setInt(10,typval);
				int result=	stmtSTD.executeUpdate();
				docno=stmtSTD.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtSTD.close();
					stmtSTD1.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}

	public int delete(int docno, String mode, String formdetailcode,HttpSession session, HttpServletRequest request, int accdocno) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
			
				CallableStatement stmtSTD = conn.prepareCall("{CALL HR_statutorydeductionsDML(?,?,?,?,?,?,?,?,?,?)}");
				
				stmtSTD.setInt(8,docno);
			    // main
				stmtSTD.setDate(1,null);
				stmtSTD.setString(2,null);
				stmtSTD.setString(3,null);
                stmtSTD.setString(4,mode);
				stmtSTD.setString(5,session.getAttribute("USERID").toString().trim());
				stmtSTD.setString(6,session.getAttribute("BRANCHID").toString().trim());
				stmtSTD.setString(7,formdetailcode);
				stmtSTD.setInt(9,0);
				stmtSTD.setInt(10,0);
				int result=	stmtSTD.executeUpdate();
			    docno=stmtSTD.getInt("docNo");
					
			    if(result<=0) {
			    	conn.close();
			    	return 0;
			    }	     
					
			    if (docno > 0) {
			    	stmtSTD.close();
			    	conn.close();
			    	return docno;
			    }		
					
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	
    public	JSONArray searchstatu() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSTD  = conn.createStatement(); 
            	
				String sql=("select a.doc_no,a.desc1 satudeduction,a.remarks,a.date,a.acno accdocno,h.account acno,h.description accname,a.chktype from hr_setdeduction a left join my_head h on h.doc_no=a.acno  where a.status=3");
				
				ResultSet resultSet = stmtSTD.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtSTD.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
 
    public JSONArray accountsDetailsFrom(String accountno, String accountname,String chk) throws SQLException {
    	 JSONArray RESULTDATA=new JSONArray();

    	 Connection conn = null;
             
         try {
        	 
        	   conn = ClsConnection.getMyConnection();
 
        	   String sqltest="";
               
               if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                   sqltest=sqltest+" and account like '%"+accountno+"%'";
               }
               
               if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                sqltest=sqltest+" and description like '%"+accountname+"%'";
               }
               
        	   if(chk.equalsIgnoreCase("1")) {
        		   
        		   Statement stmtSTD = conn.createStatement();
        		   
        		   String sql="select doc_no,account,description from my_head where m_s=0 and atype='GL' "+sqltest+" "; 
 
        		   ResultSet resultSet = stmtSTD.executeQuery(sql);
        		   RESULTDATA=ClsCommon.convertToJSON(resultSet);

        		   stmtSTD.close();
        	   }
        	   conn.close();
           } catch(Exception e){
        	   e.printStackTrace();
        	   conn.close();
           }
         return RESULTDATA;
    	}
	
}
