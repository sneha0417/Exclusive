package com.cargo.transportmasters.shipment;

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

import com.cargo.transportmasters.mode.ClsModeBean;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsShipmentDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsShipmentBean staffbean=new ClsShipmentBean();
	Connection conn;
	
	public int insert( int docno,Date shipmentDate,String shipmentid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_shipmentDML(?,?,?,?,?,?,?)}");

			
			stmtMode.registerOutParameter(1, java.sql.Types.INTEGER);
			stmtMode.setDate(3,shipmentDate);
			stmtMode.setString(2,shipmentid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeQuery();
			

			docno=stmtMode.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return docno;
			}
			stmtMode.close();
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
	
	
	
	public int edit( int docno,Date ModeDate,String Modeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_shipmentDML(?,?,?,?,?,?,?)}");

			
			stmtMode.setInt(1,docno);
			stmtMode.setDate(3,ModeDate);
			stmtMode.setString(2,Modeid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeQuery();
			 
			System.out.println("===dml=-=="+stmtMode.toString());

			docno=stmtMode.getInt("docNo");
			
			System.out.println("==docno=="+docno);
			
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return docno;
			}
			stmtMode.close();
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
	
	
	
	public boolean delete( int docno,Date ModeDate,String Modeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_shipmentDML(?,?,?,?,?,?,?)}");

			
			stmtMode.setInt(1,docno);
			stmtMode.setDate(3,ModeDate);
			stmtMode.setString(2,Modeid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeUpdate();
			 
			System.out.println("===dml=-=="+stmtMode.toString());

			docno=stmtMode.getInt("docNo");
			
			System.out.println("==docno=="+docno);
			
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return true;
			}
			stmtMode.close();
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
	


	
	
	
	public  JSONArray getShipmentGrid() throws SQLException {
		System.out.println("getShipmentGrid");
        JSONArray RESULTDATA= new  JSONArray();
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT doc_no,date,shipment FROM cr_shipment where status=3";

            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }



	public  List<ClsShipmentBean> list() throws SQLException {
	    List<ClsShipmentBean> listBean = new ArrayList<ClsShipmentBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtsearch = conn.createStatement();
	        	
				ResultSet resultSet = stmtsearch.executeQuery ("select doc_no,date,shipment  from cr_shipment where status=3");
						
              System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsShipmentBean bean = new ClsShipmentBean();
					
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setShipmentdate(resultSet.getString("date"));
	            	bean.setShipmentid(resultSet.getString("shipment"));
	            	
					
	            	listBean.add(bean);
				}
				stmtsearch.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}




	}
