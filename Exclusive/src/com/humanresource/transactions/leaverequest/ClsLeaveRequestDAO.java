package com.humanresource.transactions.leaverequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaveRequestDAO {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	ClsLeaveRequestBean leaveRequestBean = new ClsLeaveRequestBean();
	
	public int insert(String formdetailcode, Date leavesRequestDate, String cmbempdesignation, String cmbempdepartment, String cmbpayrollcategory, int txtemployeedocno, Date leavesStartDate, Date leavesEndDate, String hidchckhalfday,
			Date halfDayDate, double txtnoofdays, String cmbleavetype, String txtdescription, HttpSession session, String mode) throws SQLException {
		Connection conn = null;
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtLRQ = null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			int docno=0;
			
			stmtLRQ = conn.prepareCall("{CALL HR_leaveRequestmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtLRQ.registerOutParameter(16, java.sql.Types.INTEGER);
			
			stmtLRQ.setDate(1,leavesRequestDate);
			stmtLRQ.setString(2,cmbempdesignation);
			stmtLRQ.setString(3,cmbempdepartment);
			stmtLRQ.setString(4,cmbpayrollcategory);
			stmtLRQ.setInt(5,txtemployeedocno);
			stmtLRQ.setDate(6,leavesStartDate);
			stmtLRQ.setDate(7,leavesEndDate);
			stmtLRQ.setString(8,hidchckhalfday);
			stmtLRQ.setDate(9,halfDayDate);
			stmtLRQ.setDouble(10,txtnoofdays);
			stmtLRQ.setString(11,cmbleavetype);
			stmtLRQ.setString(12,txtdescription);
			stmtLRQ.setString(13,formdetailcode);
			stmtLRQ.setString(14,branch);
			stmtLRQ.setString(15,userid);
			stmtLRQ.setString(17,mode);
			int data=stmtLRQ.executeUpdate();
			if(data<=0){
				stmtLRQ.close();
				conn.close();
				return 0;
			}

			docno=stmtLRQ.getInt("docNo");
			leaveRequestBean.setTxtleaverequestdocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtLRQ.close();
				conn.close();
				return docno;
		      }
				
			stmtLRQ.close();
			conn.close();
	 } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
		 conn.close();
	 }
		return 0;
	}
	
	public boolean edit(int txtleaverequestdocno, String formdetailcode, Date leavesRequestDate, String cmbempdesignation, String cmbempdepartment, String cmbpayrollcategory, int txtemployeedocno, Date leavesStartDate, Date leavesEndDate,
			String hidchckhalfday, Date halfDayDate, double txtnoofdays, String cmbleavetype, String txtdescription, HttpSession session, String mode) throws SQLException {
		Connection conn = null;
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtLRQ = null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			int docno=txtleaverequestdocno;
			 
			stmtLRQ = conn.prepareCall("{CALL HR_leaveRequestmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtLRQ.setInt(16,docno);
			
			stmtLRQ.setDate(1,leavesRequestDate);
			stmtLRQ.setString(2,cmbempdesignation);
			stmtLRQ.setString(3,cmbempdepartment);
			stmtLRQ.setString(4,cmbpayrollcategory);
			stmtLRQ.setInt(5,txtemployeedocno);
			stmtLRQ.setDate(6,leavesStartDate);
			stmtLRQ.setDate(7,leavesEndDate);
			stmtLRQ.setString(8,hidchckhalfday);
			stmtLRQ.setDate(9,halfDayDate);
			stmtLRQ.setDouble(10,txtnoofdays);
			stmtLRQ.setString(11,cmbleavetype);
			stmtLRQ.setString(12,txtdescription);
			stmtLRQ.setString(13,formdetailcode);
			stmtLRQ.setString(14,branch);
			stmtLRQ.setString(15,userid);
			stmtLRQ.setString(17,mode);
			int data=stmtLRQ.executeUpdate();
			if(data<=0){
				stmtLRQ.close();
				conn.close();
				return false;
			}

			docno=stmtLRQ.getInt("docNo");
			leaveRequestBean.setTxtleaverequestdocno(docno);
			if (data > 0) {

				conn.commit();
				stmtLRQ.close();
				conn.close();
				return true;
		      }
				
			stmtLRQ.close();
			conn.close();
	 } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 } finally{
		 conn.close();
	 }
		return false;
	}

	public boolean delete(int txtleaverequestdocno, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtLRQ = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				 /*Status change in hr_leaverequest*/
				 String sql=("update hr_leaverequest set STATUS=7 where doc_no="+txtleaverequestdocno+"");
				 int data = stmtLRQ.executeUpdate(sql);
				/*Status change in hr_leaverequest Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtleaverequestdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtLRQ.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				 int docno=txtleaverequestdocno;
				 leaveRequestBean.setTxtleaverequestdocno(docno);
				 
				if (docno > 0) {
					conn.commit();
					stmtLRQ.close();
				    conn.close();
					return true;
				}	
				stmtLRQ.close();
			    conn.close();
		 } catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 } finally{
			 conn.close();
		 }
		return false;
	 }
	
	public ClsLeaveRequestBean getViewDetails(int docNo) throws SQLException {
		ClsLeaveRequestBean leaveRequestBean = new ClsLeaveRequestBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtLRQ = conn.createStatement();

			String sql= ("select r.date,r.desc_id,r.dept_id,r.pay_catid,r.empid,r.fromdate,r.todate,r.halfday,r.halfdaydate,r.leavetype,r.description,r.noofdays,m.codeno,m.name from hr_leaverequest r "
					+ "left join hr_empm m on r.empid=m.doc_no and m.active=1 where r.status<>7 and r.doc_no="+docNo);
           
			ResultSet resultSet = stmtLRQ.executeQuery(sql);
						
			while (resultSet.next()) {
				leaveRequestBean.setTxtleaverequestdocno(docNo);
				leaveRequestBean.setLeaveRequestDate(resultSet.getDate("date").toString());
				leaveRequestBean.setHidcmbempdesignation(resultSet.getString("desc_id"));
				leaveRequestBean.setHidcmbempdepartment(resultSet.getString("dept_id"));
				leaveRequestBean.setHidcmbpayrollcategory(resultSet.getString("pay_catid"));
				leaveRequestBean.setTxtemployeeid(resultSet.getString("codeno"));
				leaveRequestBean.setTxtemployeename(resultSet.getString("name"));
				leaveRequestBean.setTxtemployeedocno(resultSet.getInt("empid"));
				leaveRequestBean.setFromDate(resultSet.getDate("fromdate")==null?"":resultSet.getDate("fromdate").toString());
				leaveRequestBean.setToDate(resultSet.getDate("todate")==null?"":resultSet.getDate("todate").toString());
				leaveRequestBean.setChckhalfday(resultSet.getString("halfday"));
				leaveRequestBean.setHalfDayDate(resultSet.getDate("halfdaydate")==null?"":resultSet.getDate("halfdaydate").toString());
				leaveRequestBean.setTxtnoofdays(resultSet.getDouble("noofdays"));
				leaveRequestBean.setHidcmbleavetype(resultSet.getString("leavetype"));
				leaveRequestBean.setTxtdescription(resultSet.getString("description"));
		        }
			stmtLRQ.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	  return leaveRequestBean;
	}
	
	public JSONArray lrqMainSearch(String docNo,String date,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
	        conn = connDAO.getMyConnection();
	        Statement stmtLRQ = conn.createStatement();
	       
	        if(check.equalsIgnoreCase("1")) {

	        java.sql.Date sqlDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
	        	sqlDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and r.doc_no like '%"+docNo+"%'";
	        }
	        if(!(sqlDate==null)){
	        	sqltest=sqltest+" and r.date='"+sqlDate+"'";
		    } 
	        
	       ResultSet resultSet = stmtLRQ.executeQuery("select r.doc_no,r.date,r.noofdays days,r.empid,m.codeno,m.name,l.desc1 leavetype from hr_leaverequest r left join hr_empm m on r.empid=m.doc_no and m.active=1 "
	    		   + "left join hr_setleave l on r.leavetype=l.doc_no where r.status<>7" +sqltest);
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	        
	       }
	       stmtLRQ.close();
	       conn.close();
     } catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     } finally{
 		conn.close();
 	}
       return RESULTDATA;
   }

	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String designation,String department,String category) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtLRQ = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase(""))){
	                sql=sql+" and codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase(""))){
	             sql=sql+" and name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and pmmob like '%"+contact+"%'";
	            }
	            if(!(designation.equalsIgnoreCase("0")) && !(designation.equalsIgnoreCase(""))){
	            	sql=sql+" and desc_id='"+designation+"'";
	            }
	            if(!(department.equalsIgnoreCase("0")) && !(department.equalsIgnoreCase(""))){
	            	sql=sql+" and dept_id='"+department+"'";
	            }
	            if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
	            	sql=sql+" and pay_catid='"+category+"'";
	            }
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob,desc_id,dept_id,pay_catid from hr_empm where active=1 and status=3"+sql;
				
				ResultSet resultSet = stmtLRQ.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtLRQ.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
}
