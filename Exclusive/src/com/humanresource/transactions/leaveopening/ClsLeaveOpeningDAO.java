package com.humanresource.transactions.leaveopening;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaveOpeningDAO {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	ClsLeaveOpeningBean leaveOpeningBean = new ClsLeaveOpeningBean();
	
	public int insert(String formdetailcode, Date leaveOpenDate, ArrayList<String> leaveopeningarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		Connection conn = null;
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtLOP = conn.createStatement();
			CallableStatement stmtLOP1 = null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			int docno=0;
			
			String sql = "select coalesce((max(doc_no)+1),1) as docNo from hr_setopeningleave";
			ResultSet resultSet = stmtLOP.executeQuery(sql);
		    
			 while (resultSet.next()) {
				 docno=resultSet.getInt("docNo");
			 }
			
			for(int i=0;i< leaveopeningarray.size();i++){
				int data = 0;
				String[] leaveopening=leaveopeningarray.get(i).toString().split("::");
				
				if(!leaveopening[0].equalsIgnoreCase("undefined") && !leaveopening[0].equalsIgnoreCase("NaN")){
					
					stmtLOP1 = conn.prepareCall("{CALL HR_leaveOpeningmDML(?,?,?,?,?,?,?,?,?)}");
					
					stmtLOP1.setDate(1,leaveOpenDate);
					stmtLOP1.setInt(2,(leaveopening[0].trim().equalsIgnoreCase("undefined") || leaveopening[0].trim().equalsIgnoreCase("NaN") || leaveopening[0].trim().equalsIgnoreCase("") || leaveopening[0].trim().isEmpty()?0:Integer.parseInt(leaveopening[0].trim())));
					stmtLOP1.setInt(3,(leaveopening[1].trim().equalsIgnoreCase("undefined") || leaveopening[1].trim().equalsIgnoreCase("NaN") || leaveopening[1].trim().equalsIgnoreCase("") || leaveopening[1].trim().isEmpty()?0:Integer.parseInt(leaveopening[1].trim())));
					stmtLOP1.setDouble(4,(leaveopening[2].trim().equalsIgnoreCase("undefined") || leaveopening[2].trim().equalsIgnoreCase("NaN") || leaveopening[2].trim().equalsIgnoreCase("") || leaveopening[2].trim().isEmpty()?0:Double.parseDouble(leaveopening[2].trim())));
					stmtLOP1.setString(5,formdetailcode);
					stmtLOP1.setString(6,branch);
					stmtLOP1.setString(7,userid);
					stmtLOP1.setInt(8,docno);
					stmtLOP1.setString(9,mode);
					data=stmtLOP1.executeUpdate();
				 }
					if(data<=0){
						stmtLOP1.close();
						conn.close();
						return 0;
					}
				}

			docno=stmtLOP1.getInt("docNo");
			leaveOpeningBean.setTxtleaveopeningdocno(docno);
			if (docno > 0) {
				
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
				 int datas = stmtLOP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				conn.commit();
				stmtLOP.close();
				conn.close();
				return docno;
		      }
				
			stmtLOP.close();
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
	
	public boolean edit(int txtleaveopeningdocno, String formdetailcode, Date leaveOpenDate, ArrayList<String> leaveopeningarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		Connection conn = null;
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtLOP = conn.createStatement();
			CallableStatement stmtLOP1 = null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			int docno=txtleaveopeningdocno;
			 
			String sql=("DELETE FROM hr_setopeningleave WHERE doc_no="+docno);
			stmtLOP.executeUpdate(sql);
			
			for(int i=0;i< leaveopeningarray.size();i++){
				int data = 0;
				String[] leaveopening=leaveopeningarray.get(i).toString().split("::");
				
				if(!leaveopening[0].equalsIgnoreCase("undefined") && !leaveopening[0].equalsIgnoreCase("NaN")){
					
					stmtLOP1 = conn.prepareCall("{CALL HR_leaveOpeningmDML(?,?,?,?,?,?,?,?,?)}");
					
					stmtLOP1.setDate(1,leaveOpenDate);
					stmtLOP1.setInt(2,(leaveopening[0].trim().equalsIgnoreCase("undefined") || leaveopening[0].trim().equalsIgnoreCase("NaN") || leaveopening[0].trim().equalsIgnoreCase("") || leaveopening[0].trim().isEmpty()?0:Integer.parseInt(leaveopening[0].trim())));
					stmtLOP1.setInt(3,(leaveopening[1].trim().equalsIgnoreCase("undefined") || leaveopening[1].trim().equalsIgnoreCase("NaN") || leaveopening[1].trim().equalsIgnoreCase("") || leaveopening[1].trim().isEmpty()?0:Integer.parseInt(leaveopening[1].trim())));
					stmtLOP1.setDouble(4,(leaveopening[2].trim().equalsIgnoreCase("undefined") || leaveopening[2].trim().equalsIgnoreCase("NaN") || leaveopening[2].trim().equalsIgnoreCase("") || leaveopening[2].trim().isEmpty()?0:Double.parseDouble(leaveopening[2].trim())));
					stmtLOP1.setString(5,formdetailcode);
					stmtLOP1.setString(6,branch);
					stmtLOP1.setString(7,userid);
					stmtLOP1.setInt(8,docno);
					stmtLOP1.setString(9,mode);
					data=stmtLOP1.executeUpdate();
				 }
					if(data<=0){
						stmtLOP1.close();
						conn.close();
						return false;
					}
				}

			docno=stmtLOP1.getInt("docNo");
			leaveOpeningBean.setTxtleaveopeningdocno(docno);
			if (docno > 0) {
				
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				 int datas = stmtLOP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				conn.commit();
				stmtLOP.close();
				conn.close();
				return true;
		      }
				
			stmtLOP.close();
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

	public boolean delete(int txtleaveopeningdocno, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtLOP = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				 /*Status change in hr_setopeningleave*/
				 String sql=("update hr_setopeningleave set STATUS=7 where doc_no="+txtleaveopeningdocno+"");
				 int data = stmtLOP.executeUpdate(sql);
				/*Status change in hr_setopeningleave Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtleaveopeningdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtLOP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				 int docno=txtleaveopeningdocno;
				 leaveOpeningBean.setTxtleaveopeningdocno(docno);
				 
				if (docno > 0) {
					conn.commit();
					stmtLOP.close();
				    conn.close();
					return true;
				}	
				stmtLOP.close();
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
	
	public JSONArray lopMainSearch(String docNo,String date,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
	        conn = connDAO.getMyConnection();
	        Statement stmtLOP = conn.createStatement();
	       
	        if(check.equalsIgnoreCase("1")) {

	        java.sql.Date sqlDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
	        	sqlDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
	        }
	        if(!(sqlDate==null)){
	        	sqltest=sqltest+" and date='"+sqlDate+"'";
		    } 
	        
	       ResultSet resultSet = stmtLOP.executeQuery("select distinct doc_no,date from hr_setopeningleave where status<>7" +sqltest);
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	        
	       }
	       stmtLOP.close();
	       conn.close();
     } catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     } finally{
 		conn.close();
 	}
       return RESULTDATA;
   }

	public JSONArray leaveOpeningGridReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtLOP = conn.createStatement();
			
				String sql ="select o.empid employeedocno, o.leaveid, o.opnleaves,m.codeno employeeid,m.name employeename,l.desc1 'leave' from hr_setopeningleave o "
						+ "left join hr_empm m on o.empid=m.doc_no left join hr_setleave l on o.leaveid=l.doc_no where o.status=3 and o.doc_no="+docNo+"";
				ResultSet resultSet = stmtLOP.executeQuery(sql);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtLOP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtLOP = conn.createStatement();
			
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
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where active=1 and status=3"+sql;
				
				ResultSet resultSet = stmtLOP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtLOP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}

	public JSONArray leaveDetailsSearch() throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtLOP = conn.createStatement();
			
	    	    String sql = "select doc_no leaveid,desc1 leavename FROM hr_setleave where status=3";
				
				ResultSet resultSet = stmtLOP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtLOP.close();
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
