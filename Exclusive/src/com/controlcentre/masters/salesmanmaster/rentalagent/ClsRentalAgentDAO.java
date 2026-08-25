package com.controlcentre.masters.salesmanmaster.rentalagent;

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

public class ClsRentalAgentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsRentalAgentBean rentalagentBean=new ClsRentalAgentBean();
	Connection conn;
	
	public int insert( String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mail,String mobile,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.executeQuery();

			docno=stmtRentalAgent.getInt("docNo");
			rentalagentBean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			stmtRentalAgent.close();
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

	public int edit(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mail,String mobile,String formdetailcode) throws SQLException {
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.setInt(8, docno);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.executeUpdate();
			
			int documentNo=stmtRentalAgent.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtRentalAgent.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
		 stmtRentalAgent.close();
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

	public boolean delete(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mail,String mobile,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.setInt(8, docno);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.executeUpdate();
			
			int documentNo=stmtRentalAgent.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtRentalAgent.close();
				return true;
			}	
		  stmtRentalAgent.close();
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
	
	public  List<ClsRentalAgentBean> list() throws SQLException {
	    List<ClsRentalAgentBean> listBean = new ArrayList<ClsRentalAgentBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRentalAgent = conn.createStatement ();
	        	
				ResultSet resultSet = stmtRentalAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mail,m1.mobile,m2.description "+
						" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='RLA'");

				while (resultSet.next()) {
					
					ClsRentalAgentBean bean = new ClsRentalAgentBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setRentalagentdate(resultSet.getDate("date"));
					bean.setTxtaccno(resultSet.getString("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setMail(resultSet.getString("mail"));
					bean.setHidacno(resultSet.getString("acdoc"));
	            	listBean.add(bean);
				}
				stmtRentalAgent.close();
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
            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description "+
            			" from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='RLA'";
            	
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
