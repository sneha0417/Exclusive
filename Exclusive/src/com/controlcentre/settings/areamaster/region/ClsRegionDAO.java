package com.controlcentre.settings.areamaster.region;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;


public class ClsRegionDAO {
	
	ClsConnection conobj=new ClsConnection();
	
	Connection conn=conobj.getMyConnection();
	ClsRegionBean regionBean = new ClsRegionBean();
	
	public int insert(ClsRegionBean bean,HttpSession session){
		
		
		try{
			int aaa;
			System.out.println("ClsRegionBean");
			CallableStatement stmtregion = conn.prepareCall("{CALL ERegionDML(?,?,?,?,?,?)}");
		stmtregion.registerOutParameter(5,java.sql.Types.INTEGER);
//			stmtregion.setInt(5, 1);
			stmtregion.setString(1,bean.getRegion().toUpperCase());	
			stmtregion.setDate(2,(Date) bean.getDate_reg());
			stmtregion.setString(3,session.getAttribute("BRANCHID").toString());
			stmtregion.setString(4,session.getAttribute("USERID").toString());
			stmtregion.setString(6,bean.getMode());
			System.out.println("test for CallableStatement "+stmtregion);
			int val = stmtregion.executeUpdate();
			aaa=stmtregion.getInt("docNo");
			System.out.println(aaa);
			regionBean.setDocno(aaa);
			stmtregion.close();
			conn.close();
			if (val > 0) {
				System.out.println("Sucess"+regionBean.getDocno());
				return aaa;
			}
		
		}catch(Exception e){	
			e.printStackTrace();	
			}
		
		return 0;
	}
	
	public boolean edit(ClsRegionBean bean,HttpSession session){
		try{
			int aaa;
			CallableStatement stmtregion = conn.prepareCall("{CALL ERegionDML(?,?,?,?,?,?)}");
			
//			stmtregion.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtregion.setString(1,bean.getRegion().toUpperCase());	
			stmtregion.setDate(2,(Date) bean.getDate_reg());
			stmtregion.setString(3,session.getAttribute("BRANCHID").toString());
			stmtregion.setString(4,session.getAttribute("USERID").toString());	
			stmtregion.setInt(5,bean.getDocno());
			stmtregion.setString(6,bean.getMode());
			stmtregion.executeUpdate();
			System.out.println("test for CallableStatement edit "+stmtregion);
			aaa=stmtregion.getInt("docNo");
			System.out.println(aaa);
			regionBean.setDocno(aaa);
			stmtregion.close();
			conn.close();
			
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){	
			e.printStackTrace();	
			}
		
		return false;
	}
	public boolean delete(ClsRegionBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtregion = conn.prepareCall("{CALL ERegionDML(?,?,?,?,?,?)}");
			stmtregion.setString(1,null);
			stmtregion.setDate(2,null);
			stmtregion.setString(3,session.getAttribute("BRANCHID").toString());
			stmtregion.setString(4,session.getAttribute("USERID").toString());
			stmtregion.setInt(5,bean.getDocno());
			stmtregion.setString(6,bean.getMode());
			stmtregion.executeUpdate();
			aaa=stmtregion.getInt("docNo");
			regionBean.setDocno(aaa);
			stmtregion.close();
			conn.close();
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}	
		
		
          }catch(Exception e){
			
		}
		return false;
	 }

	
	 public  List<ClsRegionBean> list() throws SQLException {
	        List<ClsRegionBean> listBean = new ArrayList<ClsRegionBean>();
			try {
					Connection conn = conobj.getMyConnection();
				Statement stmtRegion =conn.createStatement();            	
					ResultSet resultSet = stmtRegion.executeQuery ("select REG_NAME, DOC_NO,DATE from my_aregion where status<>7");

					while (resultSet.next()) {
						
						ClsRegionBean bean = new ClsRegionBean();
		            	bean.setDocno(resultSet.getInt("DOC_NO"));
						bean.setRegion(resultSet.getString("REG_NAME"));
						bean.setDate_reg(resultSet.getDate("DATE"));
		            	listBean.add(bean);
//		            	System.out.println(listBean);
					}
			}
			catch(Exception e){
				e.printStackTrace();
			}
//	//System.out.println("nitin===="+listBean);
	        return listBean;
	    }
	 
	 
}
