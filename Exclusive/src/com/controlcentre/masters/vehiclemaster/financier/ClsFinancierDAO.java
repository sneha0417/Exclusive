package com.controlcentre.masters.vehiclemaster.financier;
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
public class ClsFinancierDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsFinancierBean financierBean = new ClsFinancierBean();
	public int insert(String finid, String finname, Date sqlStartDate,int txtaccno,HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select fid from gl_vehfin where status<>7 and fid='"+finid+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtFinancier = conn.prepareCall("{call vehfinancierDML(?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtFinancier.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtFinancier.setString(1,finid);
			stmtFinancier.setString(2,finname);
			stmtFinancier.setDate(3,sqlStartDate);
			stmtFinancier.setInt(4, txtaccno);
			stmtFinancier.setString(5,session.getAttribute("BRANCHID").toString());
			stmtFinancier.setString(6,session.getAttribute("USERID").toString());
			stmtFinancier.setString(8,mode);
			stmtFinancier.setString(9,formdetailcode);
			stmtFinancier.executeQuery();
			aaa=stmtFinancier.getInt("docNo");
//			System.out.println("no====="+aaa);
			financierBean.setDocno(aaa);
			if (aaa > 0) {
				
//				System.out.println("Success"+financierBean.getDocno());
				conn.commit();
				stmtTest.close();
				stmtFinancier.close();
				conn.close();
				return aaa;
			}
			stmtTest.close();

			stmtFinancier.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	

    public  List<ClsFinancierBean> list() throws SQLException {
        List<ClsFinancierBean> listBean = new ArrayList<ClsFinancierBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				conn.setAutoCommit(false);
				Statement stmtFinancier = conn.createStatement ();
            	
				ResultSet resultSet = stmtFinancier.executeQuery ("select m1.fid,m1.fname,m1.doc_no,m1.acc_no,m1.date,m2.description from gl_vehfin m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7");

				while (resultSet.next()) {
					
					ClsFinancierBean bean = new ClsFinancierBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setFinid(resultSet.getString("fid"));
					bean.setFinname(resultSet.getString("fname"));
					bean.setFindate(resultSet.getDate("date"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
	            	listBean.add(bean);
//	            	System.out.println(listBean);
				}
				stmtFinancier.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }

	public int edit(String finid,String finname,int docno,Date findate,int accno,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
//			System.out.println(conn);
			Statement stmtTest=conn.createStatement ();
			String testSql="select fid from gl_vehfin where status<>7 and fid='"+finid+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtFinancier = conn.prepareCall("{call vehFinancierDML(?,?,?,?,?,?,?,?,?)}");
//			System.out.println("after stm inside edit");
			//System.out.println("BRAND ID"+brandid);
			stmtFinancier.setString(1,finid);
			stmtFinancier.setString(2, finname);
			stmtFinancier.setDate(3,(Date)findate);
			stmtFinancier.setInt(4, accno);
			stmtFinancier.setString(5, session.getAttribute("BRANCHID").toString());
			stmtFinancier.setString(6, session.getAttribute("USERID").toString());
			stmtFinancier.setInt(7, docno);
			stmtFinancier.setString(8, mode);
			stmtFinancier.setString(9,formdetailcode);

//			System.out.println("before date");
			//stmtFinancier.setDate(2,(Date)modeldate);
//			System.out.println("after date");
//	System.out.println(brandid+":"+docno+":"+model+":"+modeldate);
	
			int aa = stmtFinancier.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtFinancier.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtFinancier.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}


	public int delete(String finid,String finname,int docno,Date findate,int accno,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
//			System.out.println(conn);
			Statement stmtTest=conn.createStatement ();

			String testsql3="select m.doc_no from gl_vehfin b inner join gl_vehmaster m on m.finid=b.doc_no where b.fname='"+finname+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtFinancier = conn.prepareCall("{call vehFinancierDML(?,?,?,?,?,?,?,?,?)}");
//			System.out.println("out delete");
			stmtFinancier.setString(1,finid);
			stmtFinancier.setString(2,finname);
			stmtFinancier.setDate(3,(Date)findate);
			stmtFinancier.setInt(4, accno);
			stmtFinancier.setString(5, session.getAttribute("BRANCHID").toString());
			stmtFinancier.setString(6, session.getAttribute("USERID").toString());
			stmtFinancier.setInt(7, docno);
			stmtFinancier.setString(8, mode);
			stmtFinancier.setString(9,formdetailcode);

			//PreparedStatement stmtFinancier = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//			System.out.println("after stm inside delete");
			//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
			//stmtFinancier.setInt(1,docno);
			int aa = stmtFinancier.executeUpdate();
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtFinancier.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtFinancier.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
		public  JSONArray acclist() throws SQLException {
	        List<ClsFinancierBean> listBean = new ArrayList<ClsFinancierBean>();
	        Connection conn = ClsConnection.getMyConnection();
	        JSONArray RESULTDATA=new JSONArray();
			try {
					
					Statement stmtFin = conn.createStatement ();
	            	
					ResultSet resultSet = stmtFin.executeQuery ("select description,doc_no from my_head where atype='GL'");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtFin.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
	    
	    
	    
	   
	}

