package com.controlcentre.masters.relatedmaster.servicetype;

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

public class ClsServiceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsServiceBean checkinBean = new ClsServiceBean();
	Connection conn;
	
	public int insert( String name,HttpSession session,String mode,String formdetailcode,String type) throws SQLException {
		try{
			System.out.println("DAO");
			System.out.println(mode);
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtServiceType = conn.prepareCall("{call serviceDML(?,?,?,?,?,?,?)}");

			stmtServiceType.registerOutParameter(4, java.sql.Types.INTEGER);
			stmtServiceType.setString(1,name);		
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,mode);
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setString(7, type);
			stmtServiceType.executeUpdate();

			docno=stmtServiceType.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			stmtServiceType.close();
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

	public int edit( String name,HttpSession session,String mode,int docno,String formdetailcode,String type) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call serviceDML(?,?,?,?,?,?,?)}");

			stmtServiceType.setInt(4, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,"E");
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setString(7, type);
			stmtServiceType.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtServiceType.close();
				conn.close();
				return documentNo;
			}
			
			stmtServiceType.close();
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


	public boolean delete(String name,HttpSession session,String mode,int docno,String formdetailcode,String type) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call serviceDML(?,?,?,?,?,?,?)}");
		
			stmtServiceType.setInt(4, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,"D");
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setString(7, type);
			stmtServiceType.executeUpdate();

			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				return true;
			}	
			stmtServiceType.close();
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

	/*public  List<ClsServiceBean> list() throws SQLException {
	    List<ClsServiceBean> listBean = new ArrayList<ClsServiceBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.email,m2.description "+
				" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='CHK'");

				while (resultSet.next()) {
					
					ClsServiceBean bean = new ClsServiceBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.settechniciandate(resultSet.getString("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setEmail(resultSet.getString("email"));
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
	*/
	
	public  JSONArray getServiceGrid() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.taxtype,wt.doc_no,wt.name name from tr_servicetype wt  where wt.status=3;";
            	System.out.println("nidheesh"+sqldata);
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
	public  JSONArray getDriverGrid() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.doc_no,wt.code code,wt.name name,wt.date "
            			+ " from in_servicetype wt  where wt.status=3;";
            	System.out.println("nidheesh"+sqldata);
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
