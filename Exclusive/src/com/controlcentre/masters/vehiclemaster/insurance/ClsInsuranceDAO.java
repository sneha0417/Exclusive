package com.controlcentre.masters.vehiclemaster.insurance;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceBean;
import com.connection.ClsConnection;
public class ClsInsuranceDAO {
	ClsConnection ClsConnection=new ClsConnection();

ClsInsuranceBean insuranceBean=new ClsInsuranceBean();
public int insert( String insurcompany, Date sqlStartDate,int accno,HttpSession session,String mode,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		int aaa;
		
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select inname from gl_vehin where status<>7 and inname='"+insurcompany+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtInsurance = conn.prepareCall("{call vehInsuranceDML(?,?,?,?,?,?,?,?)}");
		stmtInsurance.registerOutParameter(6, java.sql.Types.INTEGER);
		stmtInsurance.setString(1,insurcompany);
		stmtInsurance.setDate(2,sqlStartDate);
		stmtInsurance.setInt(3, accno);
		stmtInsurance.setString(5,session.getAttribute("BRANCHID").toString());
		stmtInsurance.setString(4,session.getAttribute("USERID").toString());
		stmtInsurance.setString(7,mode);
		stmtInsurance.setString(8,formdetailcode);
		stmtInsurance.executeQuery();
		aaa=stmtInsurance.getInt("docNo");
		
//		System.out.println("no====="+aaa);
		insuranceBean.setDocno(aaa);
		
		if (aaa > 0) {
			
//			System.out.println("Success"+insuranceBean.getDocno());
			conn.commit();
			stmtTest.close();
			stmtInsurance.close();
			conn.close();
			return aaa;
		}
		stmtTest.close();
		stmtInsurance.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();	
	conn.close();
	}
	return 0;
}


public  List<ClsInsuranceBean> list() throws SQLException {
    List<ClsInsuranceBean> listBean = new ArrayList<ClsInsuranceBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtInsurance = conn.createStatement ();
        	
			ResultSet resultSet = stmtInsurance.executeQuery ("select m1.inname,m1.doc_no,m1.acc_no,m1.date,m2.description from gl_vehin m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7");

			while (resultSet.next()) {
				
				ClsInsuranceBean bean = new ClsInsuranceBean();
            	bean.setDocno(resultSet.getInt("doc_no"));
				bean.setInsurcompany(resultSet.getString("inname"));
				bean.setInsurdate(resultSet.getDate("date"));
				bean.setTxtaccname(resultSet.getString("description"));
				bean.setTxtaccno(resultSet.getInt("acc_no"));
            	listBean.add(bean);
//            	System.out.println(listBean);
			}
			stmtInsurance.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public int edit(String insurcompany, Date sqlStartDate,int accno,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		Statement stmtTest=conn.createStatement ();
		String testSql="select inname from gl_vehin where status<>7 and inname='"+insurcompany+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtInsurance = conn.prepareCall("{call vehInsuranceDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtInsurance.setInt(6, docno);
		stmtInsurance.setString(1,insurcompany);
		stmtInsurance.setDate(2,sqlStartDate);
		stmtInsurance.setInt(3, accno);
		stmtInsurance.setString(5,session.getAttribute("BRANCHID").toString());
		stmtInsurance.setString(4,session.getAttribute("USERID").toString());
		stmtInsurance.setString(7,mode);
		stmtInsurance.setString(8,formdetailcode);
		
//		System.out.println("before date");
		//stmtDealer.setDate(2,(Date)modeldate);
//		System.out.println("after date");
//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

		int aa = stmtInsurance.executeUpdate();
		
//		System.out.println("inside DAO1");
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtTest.close();
			stmtInsurance.close();
			conn.close();
			return aa;
		}
		stmtTest.close();
		stmtInsurance.close();
		conn.close();
	}catch(Exception e){
	e.printStackTrace();	
	conn.close();
	}
	
	
	return 0;
}


public int delete(String insurcompany, Date sqlStartDate,int accno,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		Statement stmtTest=conn.createStatement ();

		String testsql3="select m.doc_no from gl_vehin b inner join gl_vehmaster m on m.ins_comp=b.doc_no where b.inname='"+insurcompany+"'";
		ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
		if(resultSet3.next()){
			stmtTest.close();
			conn.close();
		
			return -2;
		}
		CallableStatement stmtInsurance = conn.prepareCall("{call vehInsuranceDML(?,?,?,?,?,?,?,?)}");

		stmtInsurance.setInt(6, docno);
		stmtInsurance.setString(1,insurcompany);
		stmtInsurance.setDate(2,sqlStartDate);
		stmtInsurance.setInt(3, accno);
		stmtInsurance.setString(5,session.getAttribute("BRANCHID").toString());
		stmtInsurance.setString(4,session.getAttribute("USERID").toString());
		stmtInsurance.setString(7,mode);
		stmtInsurance.setString(8,formdetailcode);
		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtInsurance.executeUpdate();
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtTest.close();
			stmtInsurance.close();
			conn.close();
			return aa;
		}
		stmtTest.close();
		stmtInsurance.close();
		conn.close();
	}catch(Exception e){
	e.printStackTrace();	
	conn.close();
	}
	
	
	return 0;
}

}
