package com.project.setup.employeemaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeMasterDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	 ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();

	 public int insert(Date employeeMasterDate, String formdetailcode, String txtemployeeid, String txtemployeename, int txtempaccdocno, HttpSession session,HttpServletRequest request, String mode) throws SQLException {
			
		 		Connection conn = null;

		 		try{
		 			conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtEMPS = conn.createStatement();
					
		 			String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					
					CallableStatement stmtEMP = conn.prepareCall("{CALL employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtEMP.registerOutParameter(11, java.sql.Types.INTEGER);
					stmtEMP.setDate(1,employeeMasterDate);
					stmtEMP.setString(2,txtemployeeid);
					stmtEMP.setString(3,txtemployeename);
					stmtEMP.setInt(4,txtempaccdocno);
					stmtEMP.setString(5,"1");
					
					stmtEMP.setString(6,formdetailcode);
					stmtEMP.setString(7,currency);
					stmtEMP.setString(8,company);
					stmtEMP.setString(9,branch);
					stmtEMP.setString(10,userid);
					stmtEMP.setString(12,mode);
					stmtEMP.executeQuery();
					docno=stmtEMP.getInt("docNo");
					
					employeemasterbean.setTxtempmasterdocno(docno);
					if (docno > 0) {
						conn.commit();
						stmtEMP.close();
						stmtEMPS.close();
						conn.close();
						return docno;
				}
					stmtEMP.close();
					conn.close();
					return docno;
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		}

	 public int edit(int txtempmasterdocno, String formdetailcode, Date employeeMasterDate, String txtemployeeid, String txtemployeename, int txtempaccdocno, HttpSession session, String mode) throws SQLException {
		 
		 	Connection conn = null;
		 	
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String currency=session.getAttribute("CURRENCYID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			CallableStatement stmtEMP = conn.prepareCall("{CALL employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				
				stmtEMP.setDate(1,employeeMasterDate);
				stmtEMP.setString(2,txtemployeeid);
				stmtEMP.setString(3,txtemployeename);
				stmtEMP.setInt(4,txtempaccdocno);
				stmtEMP.setString(5,"1");
				stmtEMP.setString(6,formdetailcode);
				stmtEMP.setString(7,currency);
				stmtEMP.setString(8,company);
				stmtEMP.setString(9,branch);
				stmtEMP.setString(10,userid);
				stmtEMP.setInt(11, txtempmasterdocno);
				stmtEMP.setString(12,mode);
				stmtEMP.executeQuery();
				//MSystem.out.println(txtempmasterdocno+"======"+stmtEMP);
				int docno=stmtEMP.getInt("docNo");
				
				employeemasterbean.setTxtempmasterdocno(docno);
				if (docno > 0) {
					
					conn.commit();
					stmtEMP.close();
					conn.close();
					return 1;
				}	
				stmtEMP.close();
				conn.close();
				return 1;
		 }catch(Exception e){
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		}

		public int delete(int txtempmasterdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String currency=session.getAttribute("CURRENCYID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
	 		CallableStatement stmtEMP = conn.prepareCall("{CALL HR_employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtEMP.setInt(42,txtempmasterdocno);
			stmtEMP.setDate(1,null);
			stmtEMP.setString(2,null);
			stmtEMP.setString(3,null);
			stmtEMP.setInt(4,0);
			stmtEMP.setString(5,"0");
			stmtEMP.setDate(6,null);
			stmtEMP.setString(7,"0");
			stmtEMP.setString(8,"0");
			stmtEMP.setString(9,"0");
			stmtEMP.setDouble(10,0.00);
			stmtEMP.setString(11, null);
			stmtEMP.setString(12,null);
			
			stmtEMP.setString(13,null);
			stmtEMP.setString(14,null);
			stmtEMP.setString(15,null);
			stmtEMP.setString(16,null);
			stmtEMP.setString(17,null);
			stmtEMP.setString(18,null);
			
			stmtEMP.setString(19,null);
			stmtEMP.setInt(20,0);
			stmtEMP.setString(21,null);
			stmtEMP.setString(22,null);
			stmtEMP.setString(23,null);
			stmtEMP.setDate(24,null);
			stmtEMP.setString(25,null);
			stmtEMP.setString(26,null);
			stmtEMP.setString(27,null);
			stmtEMP.setString(28,null);
			stmtEMP.setString(29,null);
			stmtEMP.setString(30,null);
			stmtEMP.setString(31,null);
			stmtEMP.setString(32,"0");
			stmtEMP.setString(33,"0");
			stmtEMP.setString(34,null);
			stmtEMP.setString(35,null);
			stmtEMP.setString(36,null);

			stmtEMP.setString(37,formdetailcode);
			stmtEMP.setString(38,currency);
			stmtEMP.setString(39,company);
			stmtEMP.setString(40,branch);
			stmtEMP.setString(41,userid);
			stmtEMP.setString(43,mode);
			stmtEMP.executeQuery();
			int docno=stmtEMP.getInt("docNo");
			employeemasterbean.setTxtempmasterdocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtEMP.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtEMP.close();
				conn.close();
				return docno;
			}
			stmtEMP.close();
			conn.close();
			return 0;
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
  }
     
		public  ClsEmployeeMasterBean getViewDetails(int docNo) throws SQLException {
			
			ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();
			
			Connection conn = null;
			
			try {
			
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtEMP = conn.createStatement();

				String sql= ("select m.date, m.codeNo, m.name, m.acno, if(m.active=1,'ACTIVE','TERMINATED') empstatus,h.account from hr_empm m left join my_head h on m.acno=h.doc_no "
						+ "where m.doc_no="+docNo+"");
				
				ResultSet resultSet = stmtEMP.executeQuery(sql);
							
				while (resultSet.next()) {
					
					employeemasterbean.setEmployeeDate(resultSet.getDate("date").toString());
					employeemasterbean.setTxtemployeeid(resultSet.getString("codeNo"));
					employeemasterbean.setTxtemployeename(resultSet.getString("name"));
					employeemasterbean.setTxtempaccount(resultSet.getString("account"));
					employeemasterbean.setTxtempaccdocno(resultSet.getInt("acno"));
					employeemasterbean.setLblemployeestatus(resultSet.getString("empstatus"));
					
			        }
				stmtEMP.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return employeemasterbean;
		}
 
    public  JSONArray employeeMainSearch(HttpSession session,String empname,String empid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        String sqltest="";
        
        if(!(empname.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.name like '%"+empname+"%'";
        }
        
        if(!(empid.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
        }
        
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtEMP = conn.createStatement();
       
	       ResultSet resultSet = stmtEMP.executeQuery("select m.name,m.codeno emp_id,m.doc_no from hr_empm m where m.dtype='EMP'" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtEMP.close();
	       conn.close();
     }catch(Exception e){
    	 conn.close();
    	 e.printStackTrace();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }

}
