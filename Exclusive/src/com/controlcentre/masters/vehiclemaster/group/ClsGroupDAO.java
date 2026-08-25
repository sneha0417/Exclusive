package com.controlcentre.masters.vehiclemaster.group;
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

import com.controlcentre.masters.vehiclemaster.group.ClsGroupBean;
import com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceBean;
import com.connection.ClsConnection;
public class ClsGroupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsGroupBean groupBean=new ClsGroupBean();
	public int insert( String group, Date sqlStartDate,String utype, int level,String name,HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select gid from gl_vehgroup where status<>7 and gid='"+group+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtGroup = conn.prepareCall("{call vehGroupDML(?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtGroup.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtGroup.setString(1,group);
			stmtGroup.setString(2,name);
			stmtGroup.setString(3, utype);
			stmtGroup.setInt(4, level);
			stmtGroup.setDate(5, sqlStartDate);
			stmtGroup.setString(7,session.getAttribute("BRANCHID").toString());
			stmtGroup.setString(6,session.getAttribute("USERID").toString());
			stmtGroup.setString(9,mode);
			stmtGroup.setString(10,formdetailcode);
			stmtGroup.executeQuery();
			aaa=stmtGroup.getInt("docNo");
			
//			System.out.println("no====="+aaa);
			groupBean.setDocno(aaa);
			
			if (aaa > 0) {
				
//				System.out.println("Success"+groupBean.getDocno());
				conn.commit();
stmtTest.close();
				stmtGroup.close();
				conn.close();
				return aaa;
			}
			stmtTest.close();
			stmtGroup.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}


	public  List<ClsGroupBean> list() throws SQLException {
	    List<ClsGroupBean> listBean = new ArrayList<ClsGroupBean>();
	    Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtGroup = conn.createStatement ();
	        	
				ResultSet resultSet = stmtGroup.executeQuery ("select gid,gname,doc_no,date,utype,level from gl_vehgroup where status<>7");

				while (resultSet.next()) {
					
					ClsGroupBean bean = new ClsGroupBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setGroup(resultSet.getString("gid"));
					bean.setGroupdate(resultSet.getDate("date"));
					bean.setName(resultSet.getString("gname"));
					bean.setUtype(resultSet.getString("utype"));
					bean.setLevel(resultSet.getInt("level"));
	            	listBean.add(bean);
//	            	System.out.println(listBean);
				}
				stmtGroup.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//System.out.println("nitin===="+listBean);
	    return listBean;
	}

	public int edit(String group, Date sqlStartDate,String utype, int level,String name,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select gid from gl_vehgroup where status<>7 and gid='"+group+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtGroup = conn.prepareCall("{call vehGroupDML(?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtGroup.setString(1,group);
			stmtGroup.setString(2,name);
			stmtGroup.setString(3, utype);
			stmtGroup.setInt(4, level);
			stmtGroup.setDate(5, sqlStartDate);
			stmtGroup.setString(7,session.getAttribute("BRANCHID").toString());
			stmtGroup.setString(6,session.getAttribute("USERID").toString());
			stmtGroup.setString(9,mode);
			stmtGroup.setString(10,formdetailcode);
			stmtGroup.setInt(8, docno);
			
			
//			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
//			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtGroup.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtGroup.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtGroup.close();
			conn.close();
	}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		
		
		return 0;
	}


	public int delete(String group, Date sqlStartDate,String utype, int level,String name,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();

//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			String testsql3="select m.doc_no from gl_vehgroup b inner join gl_vehmaster m on m.vgrpid=b.doc_no where b.gid='"+group+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtGroup = conn.prepareCall("{call vehGroupDML(?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtGroup.setString(1,group);
			stmtGroup.setString(2,name);
			stmtGroup.setString(3, utype);
			stmtGroup.setInt(4, level);
			stmtGroup.setDate(5, sqlStartDate);
			stmtGroup.setString(7,session.getAttribute("BRANCHID").toString());
			stmtGroup.setString(6,session.getAttribute("USERID").toString());
			stmtGroup.setString(9,mode);
			stmtGroup.setInt(8, docno);
			stmtGroup.setString(10,formdetailcode);
			//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//			System.out.println("after stm inside delete");
			//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
			//stmtDealer.setInt(1,docno);
			int aa = stmtGroup.executeUpdate();
			
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtGroup.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtGroup.close();
			conn.close();
	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}

	}
