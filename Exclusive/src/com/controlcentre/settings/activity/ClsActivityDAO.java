package com.controlcentre.settings.activity;

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


public class ClsActivityDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com= new ClsCommon();
	Connection conn=conobj.getMyConnection();
	
	ClsActivityBean activityBean=new ClsActivityBean();
	public int insert(ClsActivityBean bean,HttpSession session){
		int aaa;
		try{
			CallableStatement stmtactivity = conn.prepareCall("{CALL EActivityDML(?,?,?,?,?,?,?)}");
			stmtactivity.registerOutParameter(6,java.sql.Types.INTEGER);
			stmtactivity.setString(1,bean.getActivity().toUpperCase());	
			stmtactivity.setString(2,bean.getActivity_code().toUpperCase());
			stmtactivity.setDate(3,(Date) bean.getDate_acti());
			stmtactivity.setString(4,session.getAttribute("BRANCHID").toString());
			stmtactivity.setString(5,session.getAttribute("USERID").toString());
			stmtactivity.setString(7,bean.getMode());
			
			int val = stmtactivity.executeUpdate();
			aaa=stmtactivity.getInt("docNo");
			
			System.out.println(aaa);
			activityBean.setDocno(aaa);
			stmtactivity.close();
			conn.close();
			return aaa;
			
		}catch(Exception e){	
			e.printStackTrace();	
			}
		return 0;
	}
	
	public boolean edit(ClsActivityBean bean,HttpSession session){
		try{
			int aaa;
			CallableStatement stmtactivity = conn.prepareCall("{CALL EActivityDML(?,?,?,?,?,?,?)}");
			stmtactivity.setString(1,bean.getActivity());	
			stmtactivity.setString(2,bean.getActivity_code());
			stmtactivity.setDate(3,(Date) bean.getDate_acti());
			stmtactivity.setString(4,session.getAttribute("BRANCHID").toString());
			stmtactivity.setString(5,session.getAttribute("USERID").toString());
			stmtactivity.setInt(6,bean.getDocno());
			stmtactivity.setString(7,bean.getMode());
			stmtactivity.executeUpdate();
			System.out.println("test for CallableStatement edit "+stmtactivity);
			aaa=stmtactivity.getInt("docNo");
			System.out.println(aaa);
			activityBean.setDocno(aaa);
			stmtactivity.close();
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
	
	public boolean delete(ClsActivityBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtactivity = conn.prepareCall("{CALL EActivityDML(?,?,?,?,?,?,?)}");
			stmtactivity.setString(1,bean.getActivity());	
			stmtactivity.setString(2,bean.getActivity_code());
			stmtactivity.setDate(3,(Date) bean.getDate_acti());
			stmtactivity.setString(4,session.getAttribute("BRANCHID").toString());
			stmtactivity.setString(5,session.getAttribute("USERID").toString());
			stmtactivity.setInt(6,bean.getDocno());
			stmtactivity.setString(7,bean.getMode());
			stmtactivity.executeUpdate();
			System.out.println("test for CallableStatement edit "+stmtactivity);
			aaa=stmtactivity.getInt("docNo");
			System.out.println(aaa);
			activityBean.setDocno(aaa);
			stmtactivity.close();
           conn.close();
			
			
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}	
			
		 }catch(Exception e){
				
			}
		return false;
	 }
	public  JSONArray searchDetails() throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
	        List<ClsActivityBean> listBean = new ArrayList<ClsActivityBean>();
			try {
				 
					Connection conn = conobj.getMyConnection();
				Statement stmtactivity =conn.createStatement();            	
					ResultSet resultSet = stmtactivity.executeQuery ("select ay_name,ay_code,date,doc_no from my_activity where status<>7");
					RESULTDATA=com.convertToJSON(resultSet);
					System.out.println("---------------  "+RESULTDATA);
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
//	//System.out.println("nitin===="+listBean);
	        return RESULTDATA;
	    }
}
