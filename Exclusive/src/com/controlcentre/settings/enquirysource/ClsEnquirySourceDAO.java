package com.controlcentre.settings.enquirysource;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.settings.servicetype.ClsServiceTypeBean;

public class ClsEnquirySourceDAO {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	public int insert(java.sql.Date date,String txtname,String txtadd,String mobile,String email,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
		
		//name,mobile,email,address,descrption,dates
		
		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_enqSourceDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(11,java.sql.Types.INTEGER);
			stmt.setDate  (1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setString(3,mobile);
			stmt.setString(4,email);
			stmt.setString(5,txtadd);
			stmt.setString(6,desc1);
			stmt.setString(7,session.getAttribute("BRANCHID").toString());
			stmt.setString(8,session.getAttribute("USERID").toString());
			stmt.setString(9,mode);
			stmt.setString(10,formcode);

			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return aaa;
	}
	
	
public int edit(int docno,java.sql.Date date,String txtname,String txtadd,String mobile,String email,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
		

		
		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_enqSourceDML(?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmt.setDate  (1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setString(3,mobile);
			stmt.setString(4,email);
			stmt.setString(5,txtadd);
			stmt.setString(6,desc1);
			stmt.setString(7,session.getAttribute("BRANCHID").toString());
			stmt.setString(8,session.getAttribute("USERID").toString());
			stmt.setString(9,mode);
			stmt.setString(10,formcode);
			stmt.setInt(11,docno);
			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return aaa;
	}

public int delete(int docno,java.sql.Date date,String txtname,String txtadd,String mobile,String email,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
	

	
	Connection conn =null;
	int aaa=0;
	int resultSetd=0;
	try{
		conn = conobj.getMyConnection();
		CallableStatement stmt = conn.prepareCall("{CALL Sr_enqSourceDML(?,?,?,?,?,?,?,?,?,?,?)}");
	
		stmt.setDate  (1,date);
		stmt.setString(2,txtname.toUpperCase());	
		stmt.setString(3,mobile);
		stmt.setString(4,email);
		stmt.setString(5,txtadd);
		stmt.setString(6,desc1);
		stmt.setString(7,session.getAttribute("BRANCHID").toString());
		stmt.setString(8,session.getAttribute("USERID").toString());
		stmt.setString(9,mode);
		stmt.setString(10,formcode);
		stmt.setInt(11,docno);
		int val = stmt.executeUpdate();
		aaa=stmt.getInt("docNo");

		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
	return aaa;
}

	
	public JSONArray descLoad(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			System.out.println("select  doc_no, txtname name, txtmobile mobile, txtemail email, txtaddress address, txtdesc description, date from cm_enqsource where status=3 ");

			ResultSet resultSet = stmt.executeQuery("select  doc_no, txtname name, txtmobile mobile, txtemail email, txtaddress address, txtdesc description, date from cm_enqsource where status=3");


			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
}
