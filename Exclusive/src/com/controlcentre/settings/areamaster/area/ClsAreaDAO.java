package com.controlcentre.settings.areamaster.area;

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


public class ClsAreaDAO {
	
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	Connection conn=conobj.getMyConnection();
	ClsAreaBean areabean= new ClsAreaBean();
	
	public int insert(ClsAreaBean bean,HttpSession session){
		int aaa;
		try{
			CallableStatement stmtarea = conn.prepareCall("{CALL EAreaDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtarea.registerOutParameter(8,java.sql.Types.INTEGER);
			stmtarea.setString(1,bean.getArea().toUpperCase());
			stmtarea.setInt(2,Integer.parseInt(bean.getRegion()));
			stmtarea.setInt(3,Integer.parseInt(bean.getCountry()));
			stmtarea.setInt(4,Integer.parseInt(bean.getCity()));
			stmtarea.setDate(5,(Date) bean.getDate_area());
			stmtarea.setString(6,session.getAttribute("BRANCHID").toString());
			stmtarea.setString(7,session.getAttribute("USERID").toString());
			stmtarea.setString(9,bean.getMode());
			
			System.out.println("test for CallableStatement "+stmtarea);
			int val = stmtarea.executeUpdate();
			aaa=stmtarea.getInt("docNo");
			
			System.out.println(aaa);
			areabean.setDocno(aaa);
			stmtarea.close();
			conn.close();
			
			
			
         return aaa;
			
		}catch(Exception e){	
			e.printStackTrace();	
			}
		return 0;
	}
		

	public boolean edit(ClsAreaBean bean,HttpSession session){
		int aaa;
		try{
			CallableStatement stmtarea = conn.prepareCall("{CALL EAreaDML(?,?,?,?,?,?,?,?,?)}");
			stmtarea.setString(1,bean.getArea());
			stmtarea.setInt(2,Integer.parseInt(bean.getRegion()));
			stmtarea.setInt(3,Integer.parseInt(bean.getCountry()));
			stmtarea.setInt(4,Integer.parseInt(bean.getCity()));
			stmtarea.setDate(5,(Date) bean.getDate_area());
			stmtarea.setString(6,session.getAttribute("BRANCHID").toString());
			stmtarea.setString(7,session.getAttribute("USERID").toString());
			stmtarea.setInt(8,bean.getDocno());
			stmtarea.setString(9,bean.getMode());
			stmtarea.executeUpdate();
			
             aaa=stmtarea.getInt("docNo");
			
			System.out.println(aaa);
			areabean.setDocno(aaa);
			stmtarea.close();
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
	public boolean delete(ClsAreaBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtarea = conn.prepareCall("{CALL EAreaDML(?,?,?,?,?,?,?,?,?)}");
			stmtarea.setString(1,bean.getArea());
			stmtarea.setInt(2,Integer.parseInt(bean.getRegion()));
			stmtarea.setInt(3,Integer.parseInt(bean.getCountry()));
			stmtarea.setInt(4,Integer.parseInt(bean.getCity()));
			stmtarea.setDate(5,(Date) bean.getDate_area());
			stmtarea.setString(6,session.getAttribute("BRANCHID").toString());
			stmtarea.setString(7,session.getAttribute("USERID").toString());
			stmtarea.setInt(8,bean.getDocno());
			stmtarea.setString(9,bean.getMode());
			stmtarea.executeUpdate();
			
			 aaa=stmtarea.getInt("docNo");
				
				System.out.println(aaa);
				areabean.setDocno(aaa);
				stmtarea.close();
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
	public  JSONArray searchDetails() throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
		 List<ClsAreaBean> listBean = new ArrayList<ClsAreaBean>();
			try {
				Connection conn = conobj.getMyConnection();
				Statement stmtArea =conn.createStatement(); 
				
				ResultSet resultSet = stmtArea.executeQuery ("select m1.area,m1.reg_id,m1.country_id cou1_id,m1.city_id,m1.doc_no,m1.DATE,d.reg_name region,"
						+ "c.country_name country,ci.city_name  from my_area m1"
						+ " left join my_aregion d on m1.reg_id=d.doc_no"
						+ " left join my_acountry c on m1.country_id=c.doc_no"
						+ " left join my_acity ci on m1.city_id=ci.doc_no "
						+ "where m1.status<>7");
				
				
//				ResultSet resultSet = stmtArea.executeQuery ("select Area,reg_id,country_id,city_id from my_area where status<>7");
				RESULTDATA=com.convertToJSON(resultSet);
				
		}
		catch(Exception e){
			e.printStackTrace();
		}
////System.out.println("nitin===="+listBean);
        return RESULTDATA;
    }	
			}
