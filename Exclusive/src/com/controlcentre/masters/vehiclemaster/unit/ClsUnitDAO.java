package com.controlcentre.masters.vehiclemaster.unit;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;
public class ClsUnitDAO {
	ClsConnection ClsConnection=new ClsConnection();


ClsUnitBean unitBean=new ClsUnitBean();

public int insert(String unit, String unitdesc,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
	Connection conn=ClsConnection.getMyConnection();
	try{
		int aaa;
		
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select unit from my_unitm where status<>7 and unit='"+unit+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		//System.out.println("brandid"+brandid);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtUnit = conn.prepareCall("{call vehUnitDML(?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtUnit.registerOutParameter(5, java.sql.Types.INTEGER);
		stmtUnit.setString(1,unit);
		stmtUnit.setString(2,unitdesc);
		stmtUnit.setString(3,session.getAttribute("BRANCHID").toString());
		stmtUnit.setString(4,session.getAttribute("USERID").toString());
		stmtUnit.setString(6,mode);
		stmtUnit.setString(7, formdetailcode);
		stmtUnit.executeQuery();
		aaa=stmtUnit.getInt("docNo");
//		System.out.println("no====="+aaa);
		unitBean.setDocno(aaa);
		if (aaa > 0) {
			
//			System.out.println("Success"+unitBean.getDocno());
			conn.commit();
			stmtTest.close();
			stmtUnit.close();
			conn.close();
			return aaa;
		}
		
		stmtTest.close();
		stmtUnit.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();	
	conn.close();
	}
	return 0;
}


public  List<ClsUnitBean> list() throws SQLException {
    List<ClsUnitBean> listBean = new ArrayList<ClsUnitBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtUnit = conn.createStatement ();
        	
			ResultSet resultSet = stmtUnit.executeQuery ("select DOC_NO,unit,unit_desc from my_unitm where status<>7");

			while (resultSet.next()) {
				
				ClsUnitBean bean = new ClsUnitBean();
            	bean.setDocno(resultSet.getInt("DOC_NO"));
				bean.setUnit(resultSet.getString("unit"));
				bean.setUnitdesc(resultSet.getString("unit_desc"));
            	listBean.add(bean);
//            	System.out.println(listBean);
			}
			stmtUnit.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public int edit(String unit,int docno,String unitdesc,String mode, HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();
		String testSql="select unit from my_unitm where status<>7 and unit='"+unit+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtUnit = conn.prepareCall("{call vehUnitDML(?,?,?,?,?,?,?)}");
		//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set brandid=?, date=?,model=? where doc_no=?");
		//System.out.println("update gl_vehmodel set brandid='"+brandid+"',date='"+modeldate+"',model='"+model+"' where doc_no='"+docno+"'");
//		System.out.println("after stm inside edit");
		//System.out.println("BRAND ID"+brandid);
		stmtUnit.setString(1,unit);
		stmtUnit.setString(2,unitdesc);
		stmtUnit.setString(3, session.getAttribute("BRANCHID").toString());
		stmtUnit.setString(4, session.getAttribute("USERID").toString());
		stmtUnit.setInt(5, docno);
		stmtUnit.setString(6, mode);
		stmtUnit.setString(7, formdetailcode);
//		System.out.println("before date");
		//stmtModel.setDate(2,(Date)modeldate);
//		System.out.println("after date");
//System.out.println(unit+":"+docno+":"+unitdesc);

		int aa = stmtUnit.executeUpdate();
		
//		System.out.println("inside DAO1");
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtUnit.close();
			stmtTest.close();
			conn.close();
			return aa;
		}
		stmtUnit.close();
		stmtTest.close();
		conn.close();
			
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return 0;
}


public boolean delete(String unit,int docno,String unitdesc,String mode,HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		CallableStatement stmtUnit = conn.prepareCall("{call vehUnitDML(?,?,?,?,?,?,?)}");
		stmtUnit.setInt(5, docno);

		stmtUnit.setString(1,unit);
		stmtUnit.setString(2,unitdesc);
		
		stmtUnit.setString(3, session.getAttribute("BRANCHID").toString());
		stmtUnit.setString(4, session.getAttribute("USERID").toString());
		stmtUnit.setString(6, mode);
		stmtUnit.setString(7, formdetailcode);
		//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtModel.setInt(1,docno);
		int aa = stmtUnit.executeUpdate();
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtUnit.close();
			
			conn.close();
			return true;
		}
		stmtUnit.close();
		conn.close();	
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return false;
}
}
