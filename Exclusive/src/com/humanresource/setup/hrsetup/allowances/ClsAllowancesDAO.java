package com.humanresource.setup.hrsetup.allowances;

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

public class ClsAllowancesDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date formdate, String Code, String Desc, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request, int accdocno) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtALC1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtALC1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					
					String sqls="select * from hr_setallowance where code='"+Code+"' and desc1='"+Desc+"' and status<>7";
					ResultSet resultSet1 = stmtALC1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}	
				
				CallableStatement stmtALC = conn.prepareCall("{CALL HR_allowancesDML(?,?,?,?,?,?,?,?,?,?)}");

				stmtALC.registerOutParameter(9, java.sql.Types.INTEGER);

			    // main
				stmtALC.setDate(1,formdate);
				stmtALC.setString(2,Code);
				stmtALC.setString(3,Desc);
				stmtALC.setString(4,remarks);
                stmtALC.setString(5,mode);
				stmtALC.setString(6,session.getAttribute("USERID").toString().trim());
				stmtALC.setString(7,session.getAttribute("BRANCHID").toString().trim());
				stmtALC.setString(8,fromcode);
				stmtALC.setInt(10,accdocno);
					
				stmtALC.executeQuery();
				int	 docno=stmtALC.getInt("docNo");
					
				if(docno<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtALC.close();
					stmtALC1.close();
					conn.close();
					return docno;
				}		
			} catch (Exception e) {
				conn.close();
				e.printStackTrace();
			}
			return 0;
		}

	public int Update(int docno, Date formdate, String Code, String Desc, String remarks, String mode, String formdetailcode, HttpSession session, HttpServletRequest request, 
			int accdocno) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmtALC1 = conn.createStatement();
				
				String strSql = "select method from gl_config where field_nme='HRMasterAlreadyExists'";
				ResultSet rs = stmtALC1.executeQuery(strSql);
				
				String method="";
				while(rs.next()) {
					method=rs.getString("method");
				} 
			    
				if(method.equalsIgnoreCase("1")){
					String sqls="select * from hr_setallowance where code='"+Code+"' and desc1='"+Desc+"' and status<>7  and doc_no!="+docno;
					ResultSet resultSet1 = stmtALC1.executeQuery(sqls);
					   
					while (resultSet1.next()) {
					      return -1;
					}
				}
				
				CallableStatement stmtALC = conn.prepareCall("{CALL HR_allowancesDML(?,?,?,?,?,?,?,?,?,?)}");

	            stmtALC.setInt(9,docno);

			    // main
				stmtALC.setDate(1,formdate);
				stmtALC.setString(2,Code);
				stmtALC.setString(3,Desc);
				stmtALC.setString(4,remarks);
                stmtALC.setString(5,mode);
				stmtALC.setString(6,session.getAttribute("USERID").toString().trim());
				stmtALC.setString(7,session.getAttribute("BRANCHID").toString().trim());
				stmtALC.setString(8,formdetailcode);
				stmtALC.setInt(10,accdocno);
					
				int result=	stmtALC.executeUpdate();
				docno=stmtALC.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
					
				if (docno > 0) {
					stmtALC.close();
					stmtALC1.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	 }

	public int delete(int docno, String mode, String formdetailcode, HttpSession session, HttpServletRequest request, int accdocno) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
			
				CallableStatement stmtALC = conn.prepareCall("{CALL HR_allowancesDML(?,?,?,?,?,?,?,?,?,?)}");
				
				stmtALC.setInt(9,docno);

			    // main
				stmtALC.setDate(1,null);
				stmtALC.setString(2,null);
				stmtALC.setString(3,null);
				stmtALC.setString(4,null);
                stmtALC.setString(5,mode);
				stmtALC.setString(6,session.getAttribute("USERID").toString().trim());
				stmtALC.setString(7,session.getAttribute("BRANCHID").toString().trim());
				stmtALC.setString(8,formdetailcode);
				stmtALC.setInt(10,0);
					
				int result=	stmtALC.executeUpdate();
				docno=stmtALC.getInt("docNo");
					
				if(result<=0) {
					conn.close();
					return 0;
				}	     
				
				if (docno > 0) {
					stmtALC.close();
					conn.close();
					return docno;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}
	
    public JSONArray searchAllowance() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtALC  = conn.createStatement (); 
            	
				String  sql=("select a.doc_no,a.code,a.desc1 allowance ,a.remarks,a.date,a.acno accdocno,h.account acno,h.description accname from hr_setallowance a "
						+ "left join my_head h on h.doc_no=a.acno  where a.status=3 and a.doc_no>0");
				
				ResultSet resultSet = stmtALC.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtALC.close();
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

    	String sqltest="";
              
                 
         if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
             sqltest=sqltest+" and account like '%"+accountno+"%'";
         }
         
         if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
          sqltest=sqltest+" and description like '%"+accountname+"%'";
         }
             
         try {
        	  
        	 conn = ClsConnection.getMyConnection();
        	 
        	 if(chk.equalsIgnoreCase("1")) {
        		 
        		 Statement stmtALC = conn.createStatement ();
        		 
        		 String sql="select doc_no,account,description,gr_type grtype from my_head where m_s=0 and atype='GL' "+sqltest+" "; 
 
        		 ResultSet resultSet = stmtALC.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);

        		 stmtALC.close();
        	 }
        	 conn.close();
         }	catch(Exception e){ 
        	 e.printStackTrace();
        	 conn.close();
         }
         return RESULTDATA;
    }
}
