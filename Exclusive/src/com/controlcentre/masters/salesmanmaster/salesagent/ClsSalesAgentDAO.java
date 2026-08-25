package com.controlcentre.masters.salesmanmaster.salesagent;

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

public class ClsSalesAgentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	ClsSalesAgentBean salesagentBean=new ClsSalesAgentBean();
	Connection conn;

	public int insert( String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mobile,String mail,String formdetailcode, String activestatus) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtSalesAgent = conn.prepareCall("{call salesAgentDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtSalesAgent.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtSalesAgent.setString(1,code);
			stmtSalesAgent.setString(2,name);
			stmtSalesAgent.setDate(3, sqlStartDate);
			stmtSalesAgent.setString(4, txtaccno);
			stmtSalesAgent.setString(5,formdetailcode);
			stmtSalesAgent.setString(6,session.getAttribute("USERID").toString());
			stmtSalesAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtSalesAgent.setString(9,mode);
			stmtSalesAgent.setString(10, mobile);
			stmtSalesAgent.setString(11, mail);
			stmtSalesAgent.setString(12, activestatus);
			stmtSalesAgent.executeQuery();
			
			docno=stmtSalesAgent.getInt("docNo");
			salesagentBean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtSalesAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtSalesAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtSalesAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtSalesAgent.close();
				conn.close();
				return docno;
			}
			stmtSalesAgent.close();
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
	
	public int edit(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode, String activestatus) throws SQLException {
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtSalesAgent = conn.prepareCall("{call salesAgentDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSalesAgent.setInt(8, docno);
			stmtSalesAgent.setString(1,code);
			stmtSalesAgent.setString(2,name);
			stmtSalesAgent.setDate(3, sqlStartDate);
			stmtSalesAgent.setString(4, txtaccno);
			stmtSalesAgent.setString(5,formdetailcode);
			stmtSalesAgent.setString(6,session.getAttribute("USERID").toString());
			stmtSalesAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtSalesAgent.setString(9,mode);
			stmtSalesAgent.setString(10, mobile);
			stmtSalesAgent.setString(11, mail);
			stmtSalesAgent.setString(12, activestatus);
			stmtSalesAgent.executeUpdate();
			
			int documentNo=stmtSalesAgent.getInt("docNo");
			if (documentNo>0) {
				conn.commit();
				stmtSalesAgent.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtSalesAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtSalesAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtSalesAgent.close();
				conn.close();
				return documentNo;
			}
			stmtSalesAgent.close();
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
	
	
	public boolean delete(String code, String name,Date sqlStartDate,int txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode, String activestatus) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtSalesAgent = conn.prepareCall("{call salesAgentDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSalesAgent.setInt(8, docno);
			stmtSalesAgent.setString(1,code);
			stmtSalesAgent.setString(2,name);
			stmtSalesAgent.setDate(3, sqlStartDate);
			stmtSalesAgent.setInt(4, txtaccno);
			stmtSalesAgent.setString(5,formdetailcode);
			stmtSalesAgent.setString(6,session.getAttribute("USERID").toString());
			stmtSalesAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtSalesAgent.setString(9,mode);
			stmtSalesAgent.setString(10, mobile);
			stmtSalesAgent.setString(11, mail);
			stmtSalesAgent.setString(12, activestatus);
	        stmtSalesAgent.executeUpdate();
			
	        int documentNo=stmtSalesAgent.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtSalesAgent.close();
				return true;
			}	
			stmtSalesAgent.close();
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
	
	public  List<ClsSalesAgentBean> list() throws SQLException {
	    List<ClsSalesAgentBean> listBean = new ArrayList<ClsSalesAgentBean>();
	   
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description,if(m1.activestatus='A','Active','Inactive') active,m1.activestatus hidactive "+
						" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='SLA'");
	
				while (resultSet.next()) {
					
					ClsSalesAgentBean bean = new ClsSalesAgentBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setSalesagentdate(resultSet.getDate("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setMail(resultSet.getString("mail"));
					bean.setHidacno(resultSet.getString("acdoc"));
					bean.setCmbactivestatus(resultSet.getString("active"));
					bean.setHidactivestatus(resultSet.getString("hidactive"));
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
            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description,if(sal.activestatus='A','Active','Inactive') active,sal.activestatus hidactive from my_salesman "+
            			" sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='SLA'";
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
