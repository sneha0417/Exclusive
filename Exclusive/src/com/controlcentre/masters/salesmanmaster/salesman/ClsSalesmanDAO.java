package com.controlcentre.masters.salesmanmaster.salesman;

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

public class ClsSalesmanDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	Connection conn;
	
	public int insert(String salesmanid ,String salesmanname , String txtaccno , String commission ,String target ,String telephone  ,String mode, HttpSession session,String salesmanmail,Date salesmandate,String formdetailcode) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtSalesman = conn.prepareCall("{CALL salesManDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSalesman.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtSalesman.setString(1,salesmanid);
			stmtSalesman.setString(2,salesmanname);
			stmtSalesman.setString(3,txtaccno);
			stmtSalesman.setString(4,telephone);
			stmtSalesman.setString(5,session.getAttribute("USERID").toString());
			stmtSalesman.setString(6,session.getAttribute("BRANCHID").toString());
			stmtSalesman.setString(8,mode);
			stmtSalesman.setString(9, salesmanmail);
			stmtSalesman.setDate(10, salesmandate);
			stmtSalesman.setString(11, formdetailcode);
		    stmtSalesman.executeQuery();
		    
		    docno=stmtSalesman.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtSalesman.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtSalesman.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtSalesman.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtSalesman.close();
				conn.close();
				return docno;
			}
		  stmtSalesman.close();
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
	
	public int edit(String salesmanid , String salesmanname , String txtaccno , String commission ,String target ,String telephone  ,int docno , String mode , HttpSession session,String salesmanmail,Date salesmandate,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			   
			CallableStatement stmtSalesman = conn.prepareCall("{CALL salesManDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSalesman.setInt(7,docno);
			stmtSalesman.setString(1,salesmanid);
			stmtSalesman.setString(2,salesmanname);
			stmtSalesman.setString(3,txtaccno);
			stmtSalesman.setString(4,telephone);
			stmtSalesman.setString(5,session.getAttribute("USERID").toString());
			stmtSalesman.setString(6,session.getAttribute("BRANCHID").toString());
			stmtSalesman.setString(8,mode);
			stmtSalesman.setString(9, salesmanmail);
			stmtSalesman.setDate(10, salesmandate);
			stmtSalesman.setString(11, formdetailcode);
			stmtSalesman.executeUpdate();
			
			int docNo=stmtSalesman.getInt("docNo");
			if (docNo > 0) {
				conn.commit();
				stmtSalesman.close();
				conn.close();
				return docNo;
			}
			else if (docNo == -1){
				stmtSalesman.close();
				conn.close();
				return docNo;
			}
			else if (docNo == -2){
				stmtSalesman.close();
				conn.close();
				return docNo;
			}
			else if (docNo == -3){
				stmtSalesman.close();
				conn.close();
				return docNo;
			}
		   stmtSalesman.close();
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

	public boolean delete(int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtSalesman = conn.prepareCall("{CALL salesManDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtSalesman.setInt(7,docno);
			stmtSalesman.setString(1,null);
			stmtSalesman.setString(2,null);
			stmtSalesman.setString(3,null);
			stmtSalesman.setString(4,null);
			stmtSalesman.setString(5,session.getAttribute("USERID").toString());
			stmtSalesman.setString(6,session.getAttribute("BRANCHID").toString());
			stmtSalesman.setString(8,mode);
			stmtSalesman.setString(9, null);
			stmtSalesman.setDate(10, null);
			stmtSalesman.setString(11, formdetailcode);

			int docNo = stmtSalesman.executeUpdate();
			if (docNo > 0) {
				conn.commit();
				stmtSalesman.close();
				conn.close();
				return true;
			}
		   stmtSalesman.close();
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

	 public  JSONArray list() throws SQLException {
	        
		    JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;

	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
	            	
					ResultSet resultSet = stmtVeh.executeQuery ("Select a.SAL_ID, a.SAL_NAME,b.account acc_no,b.doc_no acdoc,  a.COMM,a.date,  a.TARGET, a.MOB_NO, a.DOC_NO,a.mail,b.description "+
							" from my_salm a left JOIN my_head b on a.acc_no=b.doc_no where status <> 7");
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 
	 public  JSONArray searchDetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String sqldata="select sal.doc_no,sal.sal_id code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mob_no mobile,sal.date,head.description "+
	            			" from my_salm sal left join my_head head on (sal.acc_no=head.doc_no) where status=3";
	            	
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
