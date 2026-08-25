package com.controlcentre.settings.areamaster.city;

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





public class ClsCityDAO {
	
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	Connection conn=conobj.getMyConnection();
	ClsCityBean citybeen=new ClsCityBean();
	
	
	public int insert(ClsCityBean bean,HttpSession session){
		int aaa;
		try{
			CallableStatement stmtcity = conn.prepareCall("{CALL ECityDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtcity.registerOutParameter(8,java.sql.Types.INTEGER);
			stmtcity.setString(1,bean.getCity().toUpperCase());	
			stmtcity.setString(2,bean.getCity_code().toUpperCase());
			stmtcity.setInt(3,Integer.parseInt(bean.getRegion()));
			stmtcity.setInt(4,Integer.parseInt(bean.getCountry()));
			stmtcity.setDate(5,(Date) bean.getDate_city());
			stmtcity.setString(6,session.getAttribute("BRANCHID").toString());
			stmtcity.setString(7,session.getAttribute("USERID").toString());
			stmtcity.setString(9,bean.getMode());
			
			System.out.println("test for CallableStatement "+stmtcity);
			int val = stmtcity.executeUpdate();
			aaa=stmtcity.getInt("docNo");
			
			System.out.println(aaa);
			citybeen.setDocno(aaa);
			stmtcity.close();
			conn.close();
			return aaa;
			
		}catch(Exception e){	
			e.printStackTrace();	
			}
		return 0;
	}
	
	public boolean edit(ClsCityBean bean,HttpSession session){
		int aaa;
		try{
			CallableStatement stmtcity = conn.prepareCall("{CALL ECityDML(?,?,?,?,?,?,?,?,?)}");
			stmtcity.setString(1,bean.getCity().toUpperCase());	
			stmtcity.setString(2,bean.getCity_code().toUpperCase());
			stmtcity.setInt(3,Integer.parseInt(bean.getRegion()));
			stmtcity.setInt(4,Integer.parseInt(bean.getCountry()));
			stmtcity.setDate(5,(Date) bean.getDate_city());
			stmtcity.setString(6,session.getAttribute("BRANCHID").toString());
			stmtcity.setString(7,session.getAttribute("USERID").toString());
			stmtcity.setInt(8,bean.getDocno());
			stmtcity.setString(9,bean.getMode());
			stmtcity.executeUpdate();
			
			aaa=stmtcity.getInt("docNo");
			System.out.println(aaa);
			citybeen.setDocno(aaa);
			stmtcity.close();
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
	
	public boolean delete(ClsCityBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtcity = conn.prepareCall("{CALL ECityDML(?,?,?,?,?,?,?,?,?)}");
			stmtcity.setString(1,bean.getCity());	
			stmtcity.setString(2,bean.getCity_code());
			stmtcity.setInt(3,Integer.parseInt(bean.getRegion()));
			stmtcity.setInt(4,Integer.parseInt(bean.getCountry()));
			stmtcity.setDate(5,(Date) bean.getDate_city());
			stmtcity.setString(6,session.getAttribute("BRANCHID").toString());
			stmtcity.setString(7,session.getAttribute("USERID").toString());
			stmtcity.setInt(8,bean.getDocno());
			stmtcity.setString(9,bean.getMode());
			stmtcity.executeUpdate();
			
			aaa=stmtcity.getInt("docNo");
			System.out.println(aaa);
			citybeen.setDocno(aaa);
			stmtcity.close();
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
		 List<ClsCityBean> listBean = new ArrayList<ClsCityBean>();
			try {
				Connection conn = conobj.getMyConnection();
				Statement stmtCity =conn.createStatement();            	
					ResultSet resultSet = stmtCity.executeQuery ("select m.city_name,m.city_code,m.reg_id,m.country_id cou1_id,m.doc_no,m.DATE,d.reg_name region,"
							+ "c.country_name country from my_acity m left join my_aregion d on m.reg_id=d.doc_no left join my_acountry c on m.country_id=c.doc_no "
							+ "where m.status<>7");
			
					RESULTDATA=com.convertToJSON(resultSet);
					//System.out.println("---------------  "+RESULTDATA);
			}
			catch(Exception e){
				e.printStackTrace();
			}
//	//System.out.println("nitin===="+listBean);
	        return RESULTDATA;
	    }
}
