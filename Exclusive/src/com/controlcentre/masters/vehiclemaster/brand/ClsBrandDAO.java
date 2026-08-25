package com.controlcentre.masters.vehiclemaster.brand;

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

import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

public class ClsBrandDAO {
	ClsConnection ClsConnection=new ClsConnection();




	ClsBrandBean brandBean = new ClsBrandBean();
	public int insert(Date date_brand, String brand,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select brand_name from gl_vehbrand where status<>7 and brand_name='"+brand+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtBrand = conn.prepareCall("{CALL vehBrandDML(?,?,?,?,?,?,?,?)}");
			stmtBrand.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtBrand.setString(1,brand);
			stmtBrand.setString(2,brand);
			stmtBrand.setDate(3,date_brand);
			stmtBrand.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBrand.setString(5,session.getAttribute("USERID").toString());
			stmtBrand.setString(7,mode);
			stmtBrand.setString(8, formdetailcode);
			int val = stmtBrand.executeUpdate();
			aaa=stmtBrand.getInt("docNo");
//			System.out.println(aaa);
			brandBean.setDocno(aaa);
			
			if (val > 0) {
//				System.out.println("Sucess"+brandBean.getDocno());
				conn.commit();
				stmtBrand.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}
			stmtBrand.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}

	public int edit(int docno, Date date_brand, String brand, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select brand_name from gl_vehbrand where status<>7 and brand_name='"+brand+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
		
			CallableStatement stmtBrand = conn.prepareCall("{CALL vehBrandDML(?,?,?,?,?,?,?,?)}");
			stmtBrand.setString(1,brand);
			stmtBrand.setString(2,brand);
			stmtBrand.setDate(3,date_brand);
			stmtBrand.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBrand.setString(5,session.getAttribute("USERID").toString());
			stmtBrand.setInt(6, docno);
			stmtBrand.setString(7,"E");
			stmtBrand.setString(8, formdetailcode);
			stmtBrand.executeUpdate();
			int aaa=stmtBrand.getInt("docNo");
//			System.out.println(aaa);
			brandBean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtTest.close();

				stmtBrand.close();
				conn.close();
				return aaa;
			}

			stmtBrand.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}


	public int delete(int docno, HttpSession session,String brand,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testsql2="select * from gl_vehbrand b inner join gl_vehmodel m on m.brandid=b.doc_no where b.brand='"+brand+"'";
			ResultSet resultSet2 = stmtTest.executeQuery (testsql2);
			if(resultSet2.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			String testsql3="select m.doc_no from gl_vehbrand b inner join gl_vehmaster m on m.brdid=b.doc_no where b.brand='"+brand+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtBrand = conn.prepareCall("{CALL vehBrandDML(?,?,?,?,?,?,?,?)}");
			stmtBrand.setString(1,null);
			stmtBrand.setString(2,null);
			stmtBrand.setDate(3,null);
			stmtBrand.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBrand.setString(5,session.getAttribute("USERID").toString());
			stmtBrand.setInt(6, docno);
			stmtBrand.setString(7,"D");
			stmtBrand.setString(8, formdetailcode);
			stmtBrand.executeUpdate();
			int aaa=stmtBrand.getInt("docNo");
			brandBean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtBrand.close();
				stmtTest.close();

				conn.close();
				return aaa;
			}
			stmtTest.close();

			stmtBrand.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}


    public  List<ClsBrandBean> list() throws SQLException {
        List<ClsBrandBean> listBean = new ArrayList<ClsBrandBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				
				Statement stmtBrand = conn.createStatement ();
            	
				ResultSet resultSet = stmtBrand.executeQuery ("select BRAND_NAME, DOC_NO,DATE from gl_vehbrand where status<>7");

				while (resultSet.next()) {
					
					ClsBrandBean bean = new ClsBrandBean();
	            	bean.setDocno(resultSet.getInt("DOC_NO"));
					bean.setBrand(resultSet.getString("BRAND_NAME"));
					bean.setDate_brand(resultSet.getDate("DATE"));
	            	listBean.add(bean);
//	            	System.out.println(listBean);
				}

				stmtBrand.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }




}
