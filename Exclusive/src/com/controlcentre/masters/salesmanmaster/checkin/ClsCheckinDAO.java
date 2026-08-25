package com.controlcentre.masters.salesmanmaster.checkin;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCheckinDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsCheckinBean checkinBean = new ClsCheckinBean();
	Connection conn;
	
	public int insert( String code,String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mobile,String mail,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtCheckin = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtCheckin.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtCheckin.setString(1,code);
			stmtCheckin.setString(2,name);
			stmtCheckin.setDate(3, sqlStartDate);
			stmtCheckin.setString(4, txtaccno);
			stmtCheckin.setString(5,formdetailcode);
			stmtCheckin.setString(6,session.getAttribute("USERID").toString());
			stmtCheckin.setString(7,session.getAttribute("BRANCHID").toString());
			stmtCheckin.setString(9,mode);
			stmtCheckin.setString(10, mobile);
			stmtCheckin.setString(11, mail);
			stmtCheckin.executeUpdate();

			docno=stmtCheckin.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtCheckin.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtCheckin.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtCheckin.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtCheckin.close();
				conn.close();
				return docno;
			}
			stmtCheckin.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	return 0;
  }

	public int edit(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtCheckin = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCheckin.setInt(8, docno);
			stmtCheckin.setString(1,code);
			stmtCheckin.setString(2,name);
			stmtCheckin.setDate(3, sqlStartDate);
			stmtCheckin.setString(4, txtaccno);
			stmtCheckin.setString(5,formdetailcode);
			stmtCheckin.setString(6,session.getAttribute("USERID").toString());
			stmtCheckin.setString(7,session.getAttribute("BRANCHID").toString());
			stmtCheckin.setString(9,"E");
			stmtCheckin.setString(10, mobile);
			stmtCheckin.setString(11, mail);
			stmtCheckin.executeUpdate();
			
			int documentNo=stmtCheckin.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtCheckin.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtCheckin.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtCheckin.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtCheckin.close();
				conn.close();
				return documentNo;
			}
		 stmtCheckin.close();
		 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
			 return 0;
		}finally{
			conn.close();
		}
		return 0;
	}

	public boolean delete(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtCheckin = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtCheckin.setInt(8, docno);
			stmtCheckin.setString(1,code);
			stmtCheckin.setString(2,name);
			stmtCheckin.setDate(3, sqlStartDate);
			stmtCheckin.setString(4, txtaccno);
			stmtCheckin.setString(5,formdetailcode);
			stmtCheckin.setString(6,session.getAttribute("USERID").toString());
			stmtCheckin.setString(7,session.getAttribute("BRANCHID").toString());
			stmtCheckin.setString(9,"D");
			stmtCheckin.setString(10, mobile);
			stmtCheckin.setString(11, mail);
			stmtCheckin.executeUpdate();

			int documentNo=stmtCheckin.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtCheckin.close();
				return true;
			}	
		  stmtCheckin.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}

	public  List<ClsCheckinBean> list() throws SQLException {
	    List<ClsCheckinBean> listBean = new ArrayList<ClsCheckinBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description "+
				" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='CHK'");

				while (resultSet.next()) {
					
					ClsCheckinBean bean = new ClsCheckinBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setCheckindate(resultSet.getString("date"));
					bean.setTxtaccno(resultSet.getString("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setMail(resultSet.getString("mail"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setHidacno(resultSet.getString("acdoc"));
					listBean.add(bean);
				}
				stmtSalesAgent.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	
	
	
	
	public  JSONArray searchDetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description"+
            			" from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='CHK'";
            	
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
   }
