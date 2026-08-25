package com.controlcentre.masters.relatedmaster.pricecategory;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;



import net.sf.json.JSONArray;

public class ClsPriceCategoryDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsPriceCategoryBean checkinBean = new ClsPriceCategoryBean();
	Connection conn;
	
	public int insert( String catid,HttpSession session,String mode,String formdetailcode) throws SQLException {
		try{
			//System.out.println("DAO");
			//System.out.println(mode);
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtServiceType = conn.prepareCall("{call pricecategoryDML(?,?,?,?,?,?)}");

			stmtServiceType.registerOutParameter(3, java.sql.Types.INTEGER);
			stmtServiceType.setString(1,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(2,session.getAttribute("USERID").toString());
			stmtServiceType.setString(4,mode);
			stmtServiceType.setString(5, formdetailcode);
			stmtServiceType.setString(6,catid);
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

	public int edit( String catid,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	
		//System.out.println("mode====="+mode);
		//System.out.println("docno====="+docno);
		//System.out.println("catid====="+catid);
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call pricecategoryDML(?,?,?,?,?,?)}");

			stmtServiceType.setInt(3, docno);
			stmtServiceType.setString(1,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(2,session.getAttribute("USERID").toString());
			stmtServiceType.setString(4,"E");
			stmtServiceType.setString(5, formdetailcode);
			stmtServiceType.setString(6,catid);
			stmtServiceType.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtServiceType.getInt("docNo");
			//System.out.println("documentNo====="+documentNo);
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


	public boolean delete( String catid,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call pricecategoryDML(?,?,?,?,?,?)}");

			stmtServiceType.setInt(3, docno);
			stmtServiceType.setString(1,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(2,session.getAttribute("USERID").toString());
			stmtServiceType.setString(4,"D");
			stmtServiceType.setString(5, formdetailcode);
			stmtServiceType.setString(6,catid);
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
	public  JSONArray getPriceCategory() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select p.doc_no,p.name category from  tr_pricecategory p where p.status=3";
            	//System.out.println("nation=="+sqldata);
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
