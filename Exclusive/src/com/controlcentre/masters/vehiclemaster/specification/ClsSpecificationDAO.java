package com.controlcentre.masters.vehiclemaster.specification;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;
public class ClsSpecificationDAO {	
	ClsConnection ClsConnection=new ClsConnection();

	ClsSpecificationBean Bean = new ClsSpecificationBean();


	public int insert(String specname,String specdetails,String mode,HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehspec where status<>7 and name='"+specname+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtSpec = conn.prepareCall("{CALL vehSpecDML(?,?,?,?,?,?,?)}");
			stmtSpec.registerOutParameter(5,java.sql.Types.INTEGER);
			
			
			stmtSpec.setString(1,specname);
			stmtSpec.setString(2, specdetails);
			stmtSpec.setString(3, session.getAttribute("USERID").toString());
			stmtSpec.setString(4, session.getAttribute("BRANCHID").toString());
			stmtSpec.setString(6, mode);
			stmtSpec.setString(7, formdetailcode);
			int val = stmtSpec.executeUpdate();
			aaa=stmtSpec.getInt("docNo");
//			System.out.println(aaa);
	if (aaa > 0) {
				
//				System.out.println("Success"+Bean.getDocno());
				conn.commit();
				stmtTest.close();
				stmtSpec.close();
				conn.close();
				return aaa;
			}
	stmtTest.close();
	stmtSpec.close();
	conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	public int edit(String specname,String specdetails,String mode,HttpSession session,int docno,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehspec where status<>7 and name='"+specname+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtSpec = conn.prepareCall("{CALL vehSpecDML(?,?,?,?,?,?,?)}");
			stmtSpec.setInt(5,docno);
			stmtSpec.setString(1,specname);
			stmtSpec.setString(2, specdetails);
			stmtSpec.setString(3, session.getAttribute("USERID").toString());
			stmtSpec.setString(4, session.getAttribute("BRANCHID").toString());
			stmtSpec.setString(6, mode);
			stmtSpec.setString(7, formdetailcode);

			stmtSpec.executeUpdate();
			int aaa=stmtSpec.getInt("docNo");
//			System.out.println(aaa);
			Bean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtTest.close();
				stmtSpec.close();
				conn.close();
				return aaa;
			}

			stmtSpec.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		return 0;
	}


	public int delete(String specname,String specdetails,String mode,HttpSession session,int docno,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			//Statement stmtTest=conn.createStatement ();
		/*	String testsql2="select * from gl_vehbrand b inner join gl_vehmodel m on m.brandid=b.doc_no where b.brand='"+brand+"'";
			ResultSet resultSet2 = stmtTest.executeQuery (testsql2);
			if(resultSet2.next()){
				return -2;
			}
			String testsql3="select m.doc_no from gl_vehbrand b inner join gl_vehmaster m on m.brdid=b.doc_no where b.brand='"+brand+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				return -2;
			}*/
			CallableStatement stmtSpec = conn.prepareCall("{CALL vehSpecDML(?,?,?,?,?,?,?)}");
			stmtSpec.setInt(5,docno);
			stmtSpec.setString(1,specname);
			stmtSpec.setString(2, specdetails);
			stmtSpec.setString(3, session.getAttribute("USERID").toString());
			stmtSpec.setString(4, session.getAttribute("BRANCHID").toString());
			stmtSpec.setString(6, mode);
			stmtSpec.setString(7, formdetailcode);

			stmtSpec.executeUpdate();
			int aaa=stmtSpec.getInt("docNo");
			Bean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtSpec.close();
				//stmtTest.close();
				conn.close();
				return aaa;
			}
			//stmtTest.close();
			stmtSpec.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
}