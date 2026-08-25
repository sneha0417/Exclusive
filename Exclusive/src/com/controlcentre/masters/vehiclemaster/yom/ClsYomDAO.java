package com.controlcentre.masters.vehiclemaster.yom;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsYomDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

		ClsYomBean colorBean = new ClsYomBean();
		public int insert(String color,HttpSession session,String mode,String formdetailcode) throws SQLException {
			Connection conn=ClsConnection.getMyConnection();
			try{
				int aaa;
				
				conn.setAutoCommit(false);
				Statement stmtTest=conn.createStatement ();
				String testSql="select yom from gl_yom where  yom='"+color+"'";
				ResultSet resultSet1 = stmtTest.executeQuery (testSql);
				if(resultSet1.next()){
					stmtTest.close();
					conn.close();
					return -1;
				}
//				System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
//				System.out.println("branchid:"+session.getAttribute("BRANCHID"));
//				System.out.println("userid:"+session.getAttribute("USERID"));
				CallableStatement stmtColor = conn.prepareCall("{call vehYomDML(?,?,?,?,?,?)}");
//				System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//				CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
				stmtColor.registerOutParameter(4, java.sql.Types.INTEGER);
				stmtColor.setString(1,color);
				stmtColor.setString(3,session.getAttribute("BRANCHID").toString());
				stmtColor.setString(2,session.getAttribute("USERID").toString());
				
				stmtColor.setString(5,mode);
				stmtColor.setString(6,formdetailcode);
				stmtColor.executeQuery();
				aaa=stmtColor.getInt("docNo");
//				System.out.println("no====="+aaa);
				colorBean.setDocno(aaa);
				if (aaa > 0) {
					
			//		System.out.println("Sucess"+colorBean.getDocno());
					conn.commit();
					stmtColor.close();
					stmtTest.close();
					conn.close();
					return aaa;
				}
				stmtColor.close();
				stmtTest.close();

				conn.close();
			}catch(Exception e){	
			e.printStackTrace();	
			conn.close();
			}
			return 0;
		}
		


	public  List<ClsYomBean> list() throws SQLException {
	    List<ClsYomBean> listBean = new ArrayList<ClsYomBean>();
	    Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtColor = conn.createStatement ();
	        	
				ResultSet resultSet = stmtColor.executeQuery ("select doc_no,yom from gl_yom");

				while (resultSet.next()) {
					
					ClsYomBean bean = new ClsYomBean();
	            	bean.setDocno(resultSet.getInt("DOC_NO"));
					bean.setYom(resultSet.getString("yom"));
	            	listBean.add(bean);
	         	//System.out.println(listBean);
				}
				stmtColor.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//System.out.println("nitin===="+listBean);
	    return listBean;
	}

	public int edit(String color, int docno, String mode,HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try
	{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();
		String testSql="select yom from gl_yom where yom='"+color+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtColor = conn.prepareCall("{call vehYomDML(?,?,?,?,?,?)}");
		//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set brandid=?, date=?,model=? where doc_no=?");
		//System.out.println("update gl_vehmodel set brandid='"+brandid+"',date='"+modeldate+"',model='"+model+"' where doc_no='"+docno+"'");
//		System.out.println("after stm inside edit");
		//System.out.println("BRAND ID"+brandid);
		stmtColor.setString(1,color);
		stmtColor.setInt(4,docno);
		stmtColor.setString(3, session.getAttribute("BRANCHID").toString());
		stmtColor.setString(2, session.getAttribute("USERID").toString());
		
		stmtColor.setString(5, mode);
		stmtColor.setString(6,formdetailcode);
//		System.out.println("before date");
		//stmtModel.setDate(2,(Date)modeldate);
//		System.out.println("after date");


		int aa = stmtColor.executeUpdate();
		
//		System.out.println("inside DAO1");
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtColor.close();
			stmtTest.close();
			conn.close();
			return aa;
		}
		stmtTest.close();

		stmtColor.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}


	return 0;
	}


	public int delete(String color,int docno,String mode,HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();

		String testsql3="select m.doc_no from gl_yom c inner join gl_vehmaster m on m.yom=c.doc_no where c.yom='"+color+"'";
		ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
		if(resultSet3.next()){
			stmtTest.close();
			conn.close();
			
			
			return -2;
		}
		CallableStatement stmtColor = conn.prepareCall("{call vehYomDML(?,?,?,?,?,?)}");
		stmtColor.setInt(4, docno);
		stmtColor.setString(1,color);
		stmtColor.setString(3, session.getAttribute("BRANCHID").toString());
		stmtColor.setString(2, session.getAttribute("USERID").toString());
		stmtColor.setString(5, mode);
		stmtColor.setString(6,formdetailcode);
		//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtModel.setInt(1,docno);
		int aa = stmtColor.executeUpdate();
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtTest.close();

			stmtColor.close();
			conn.close();
			return aa;
		}
		stmtTest.close();

		stmtColor.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}


	return 0;
	}
	}


