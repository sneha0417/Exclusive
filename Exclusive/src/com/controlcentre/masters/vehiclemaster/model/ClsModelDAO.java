package com.controlcentre.masters.vehiclemaster.model;

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
public class ClsModelDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsModelBean modelBean = new ClsModelBean();
	public int insert(String model, String brandid, Date sqlStartDate,
			HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select vtype from gl_vehmodel where status<>7 and vtype='"+model+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("brandid"+brandid);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtModel.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtModel.setString(1,model);
			stmtModel.setDate(2,sqlStartDate);
			stmtModel.setString(3, brandid);
//			System.out.println("brandid"+brandid);
			stmtModel.setString(4,session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5,session.getAttribute("USERID").toString());
			stmtModel.setString(7,mode);
			stmtModel.setString(8,formdetailcode);
			stmtModel.executeQuery();
			aaa=stmtModel.getInt("docNo");
//			System.out.println("no====="+aaa);
			modelBean.setDocno(aaa);
			if (aaa > 0) {
				
//				System.out.println("Success"+modelBean.getDocno());
				conn.commit();
				stmtTest.close();
				stmtModel.close();
				conn.close();
				return aaa;
			}
			stmtTest.close();
			stmtModel.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	

    public  List<ClsModelBean> list() throws SQLException {
        List<ClsModelBean> listBean = new ArrayList<ClsModelBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtBrand = conn.createStatement ();
            	
				ResultSet resultSet = stmtBrand.executeQuery ("select m1.vtype,m1.doc_no,m1.brandid,m1.date,m2.brand_name from gl_vehmodel m1 left join gl_vehbrand m2 on m1.brandid=m2.doc_no where m1.status<>7");

				while (resultSet.next()) {
					
					ClsModelBean bean = new ClsModelBean();
	            	bean.setDocno(resultSet.getInt("DOC_NO"));
					bean.setModel(resultSet.getString("vtype"));
					bean.setModeldate(resultSet.getDate("DATE"));
					bean.setBrand(resultSet.getString("brand_name"));
					bean.setBrandid(resultSet.getInt("brandid"));
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

	public int edit(String model,int docno,Date modeldate,String brandid,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
//			System.out.println(conn);
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select vtype from gl_vehmodel where status<>7 and vtype='"+model+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
			//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set brandid=?, date=?,model=? where doc_no=?");
			//System.out.println("update gl_vehmodel set brandid='"+brandid+"',date='"+modeldate+"',model='"+model+"' where doc_no='"+docno+"'");
			stmtModel.setInt(6, docno);
			stmtModel.setString(1,model);
			stmtModel.setDate(2,(Date)modeldate);
			stmtModel.setString(3, brandid);
			stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5, session.getAttribute("USERID").toString());
						stmtModel.setString(7, mode);
			stmtModel.setString(8,formdetailcode);

//			System.out.println("before date");
			//stmtModel.setDate(2,(Date)modeldate);
//			System.out.println("after date");
//	System.out.println(brandid+":"+docno+":"+model+":"+modeldate);
	
			int aa = stmtModel.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtModel.close();
				conn.close();
				return aa;
			}
			
			stmtTest.close();
			stmtModel.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}


	public int delete(String model,int docno,Date modeldate,String brandid,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
//			System.out.println(conn);
			Statement stmtTest=conn.createStatement ();

			String testsql3="select m.doc_no from gl_vehmodel b inner join gl_vehmaster m on m.vmodid=b.doc_no where b.vtype='"+model+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
			stmtModel.setString(1,model);
			stmtModel.setDate(2,(Date)modeldate);
			stmtModel.setString(3, brandid);
			stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5, session.getAttribute("USERID").toString());
			stmtModel.setInt(6, docno);
			stmtModel.setString(7, mode);
			stmtModel.setString(8,formdetailcode);

			//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//			System.out.println("after stm inside delete");
			//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
			//stmtModel.setInt(1,docno);
			int aa = stmtModel.executeUpdate();
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtModel.close();
				stmtTest.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtModel.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}
	}

