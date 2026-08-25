package com.cargo.transportmasters.servicetype;

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
import com.controlcentre.masters.salesmanmaster.staff.ClsStaffBean;

public class ClsServiceTypeDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsServiceTypeBean servicebean=new ClsServiceTypeBean();
	Connection conn;
	
	public int insert( int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?)}");
			System.out.println("cmbmode"+cmbmode);

			stmtService.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtService.setString(1,servicetype);
			stmtService.setDate(2, sqlServiceDate);
			stmtService.setString(3,cmbmode);
			stmtService.setString(4,cmbsubmode);
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setString(7,cmbshipment);
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.executeQuery();
			System.out.println("cmbmode"+cmbmode);
			
			
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
		        return docno;
			}
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
	
	public int edit( int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?)}");


			stmtService.setInt(10, docno);
			stmtService.setString(1,servicetype);
			stmtService.setDate(2, sqlServiceDate);
			stmtService.setString(3, cmbmode);
			stmtService.setString(4,cmbsubmode);
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setString(7,cmbshipment);
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.executeQuery();
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
		        return docno;
			}
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
	public boolean delete(int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?)}");


			stmtService.setInt(10, docno);
			stmtService.setString(1,null);
			stmtService.setDate(2, null);
			stmtService.setString(3, null);
			stmtService.setString(4,null);
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setString(7,null);
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.executeQuery();
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
				return true;
			}
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
	
	public  JSONArray getServiceTypeGrid(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT m.doc_no,m.modeid,m.smodeid,m.shipid,m.srvtype,m.date,mo.modename,sm.submode,shm.shipment FROM cr_srvtype m "
						+ "left join cr_mode mo on mo.doc_no=m.modeid left join cr_smode sm on sm.doc_no=m.smodeid left join cr_shipment shm on "
						+ "shm.doc_no=m.shipid where m.status=3";
                              
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
	
	public  List<ClsServiceTypeBean> list() throws SQLException {
	    List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtService = conn.createStatement();
	        	
				ResultSet resultSet = stmtService.executeQuery ("SELECT m.doc_no,m.modeid,m.smodeid,m.shipid,m.srvtype,m.date,mo.modename,sm.submode,shm.shipment FROM cr_srvtype m left join cr_mode mo on mo.doc_no=m.modeid left join cr_smode sm on sm.doc_no=m.smodeid left join cr_shipment shm on shm.doc_no=m.shipid where m.status=3");
                System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsServiceTypeBean bean = new ClsServiceTypeBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setServicedate(resultSet.getString("date"));
	            	bean.setModeid(resultSet.getInt("modeid"));
	            	bean.setCmbmode(resultSet.getString("modename"));
	            	bean.setSmodeid(resultSet.getInt("smodeid"));
	            	bean.setCmbsubmode(resultSet.getString("submode"));
	            	bean.setShipid(resultSet.getInt("shipid"));
	            	bean.setCmbshipment(resultSet.getString("shipment"));
	            	bean.setServtype(resultSet.getString("srvtype"));
	            	listBean.add(bean);
				}
				stmtService.close();
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
