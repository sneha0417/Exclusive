package com.cargo.transportmasters.submode;

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

import com.cargo.transportmasters.shipment.ClsShipmentBean;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSubModeDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsSubModeBean staffbean=new ClsSubModeBean();
	Connection conn;
	
	public int insert( int docno,Date submodeDate,String cmbmode,String submodeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_submodeDML(?,?,?,?,?,?,?,?)}");

			
			stmtMode.registerOutParameter(1, java.sql.Types.INTEGER);
			stmtMode.setDate(2,submodeDate);
			stmtMode.setString(3,cmbmode);
			stmtMode.setString(4,submodeid);
			stmtMode.setString(5,session.getAttribute("USERID").toString());
			stmtMode.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(7,mode); 
			stmtMode.setString(8, formdetailcode);

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
	
	
	public boolean delete( int docno,Date submodeDate,String cmbmode,String submodeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_submodeDML(?,?,?,?,?,?,?,?)}");

			
			stmtMode.setInt(1,docno);
			stmtMode.setDate(2,submodeDate);
			stmtMode.setString(3,cmbmode);
			stmtMode.setString(4,submodeid);
			stmtMode.setString(5,session.getAttribute("USERID").toString());
			stmtMode.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(7,mode); 
			stmtMode.setString(8, formdetailcode);

			 stmtMode.executeQuery();
			

			docno=stmtMode.getInt("docNo");
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
	
	
	public int edit( int docno,Date submodeDate,String cmbmode,String submodeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_submodeDML(?,?,?,?,?,?,?,?)}");

			
			
			stmtMode.setInt(1,docno);
			stmtMode.setDate(2,submodeDate);
			stmtMode.setString(3,cmbmode);
			stmtMode.setString(4,submodeid);
			stmtMode.setString(5,session.getAttribute("USERID").toString());
			stmtMode.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(7,mode); 
			stmtMode.setString(8, formdetailcode);

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
	
	



	
	
	public  JSONArray getSubModeGrid() throws SQLException {
		System.out.println("getSubmodegrid");
        JSONArray RESULTDATA= new  JSONArray();
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT s.doc_no,s.modeid,s.submode,s.date,m.modename FROM cr_smode s left join cr_mode m on m.doc_no=s.modeid where s.status=3";
							
			   
				System.out.println("===dml=-=="+strsql.toString());
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


	public  List<ClsSubModeBean> list() throws SQLException {
	    List<ClsSubModeBean> listBean = new ArrayList<ClsSubModeBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtsearch = conn.createStatement();
	        	
				ResultSet resultSet = stmtsearch.executeQuery ("SELECT s.doc_no,s.modeid,s.submode,s.date,m.modename FROM cr_smode s left join cr_mode m on m.doc_no=s.modeid where s.status=3");
						
              System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsSubModeBean bean = new ClsSubModeBean();
					
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setSubmodedate(resultSet.getString("date"));
	            	bean.setSubmodeid(resultSet.getString("submode"));
	            	bean.setCmbmode(resultSet.getString("modename"));
	            	bean.setModeid(resultSet.getInt("modeid"));
	            	
	            	
					
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
