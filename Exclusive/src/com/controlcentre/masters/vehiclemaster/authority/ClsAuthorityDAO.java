package com.controlcentre.masters.vehiclemaster.authority;
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
public class ClsAuthorityDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsAuthorityBean authorityBean = new ClsAuthorityBean();
	public int insert(String auth, String authname,
			java.sql.Date authdate, HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select authid from gl_vehauth where status<>7 and authid='"+auth+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
//			System.out.println("branchid:"+session.getAttribute("BRANCHID"));
//			System.out.println("userid:"+session.getAttribute("USERID"));
			CallableStatement stmtAuth = conn.prepareCall("{call vehAuthorityDML(?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtAuth.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtAuth.setString(1,auth);
			stmtAuth.setString(2,authname);
			stmtAuth.setString(3,authdate.toString());
			stmtAuth.setString(5,session.getAttribute("BRANCHID").toString());
			stmtAuth.setString(4,session.getAttribute("USERID").toString());
			
			stmtAuth.setString(7,mode);
			stmtAuth.setString(8, formdetailcode);
			stmtAuth.executeQuery();
			aaa=stmtAuth.getInt("docNo");
//			System.out.println("no====="+aaa);
			authorityBean.setDocno(aaa);
			if (aaa > 0) {
				
			//	System.out.println("Sucess"+authorityBean.getDocno());
				conn.commit();
				stmtAuth.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}
			conn.commit();
			stmtAuth.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	


public  List<ClsAuthorityBean> list() throws SQLException {
    List<ClsAuthorityBean> listBean = new ArrayList<ClsAuthorityBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtAuth = conn.createStatement ();
        	
			ResultSet resultSet = stmtAuth.executeQuery ("select authid,authname,doc_no,date from gl_vehauth where status<>7");

			while (resultSet.next()) {
				
				ClsAuthorityBean bean = new ClsAuthorityBean();
            	bean.setDocno(resultSet.getInt("DOC_NO"));
				bean.setAuthname(resultSet.getString("authname"));
				bean.setAuthdate(resultSet.getDate("date"));
				bean.setAuth(resultSet.getString("authid"));
            	listBean.add(bean);
         	//System.out.println(listBean);
			}

			stmtAuth.close();
			conn.close();
	}
	
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public int edit(int docno, Date authDate, String auth,String authname,HttpSession session,String mode,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{

		
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select authid from gl_vehauth where status<>7 and authid='"+auth+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtAuth = conn.prepareCall("{call vehAuthorityDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("after stm inside edit");
		stmtAuth.setInt(6,docno);

		stmtAuth.setString(1,auth);
		stmtAuth.setString(2,authname);
		stmtAuth.setDate(3,authDate);
		stmtAuth.setString(5,session.getAttribute("BRANCHID").toString());
		stmtAuth.setString(4,session.getAttribute("USERID").toString());
		
		stmtAuth.setString(7,mode);
		stmtAuth.setString(8, formdetailcode);
//		System.out.println("after date");
		int aa = stmtAuth.executeUpdate();
//		System.out.println("inside DAO1");
		if (aa>0) {
//			System.out.println("Sucess");
			conn.commit();
			stmtAuth.close();
			stmtTest.close();
			conn.close();
			return aa;
		}
		stmtAuth.close();
		stmtTest.close();

		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return 0;
}


public int delete(int docno, Date authDate, String auth,String authname,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		
		Statement stmtTest=conn.createStatement ();
		String testsql2="select * from gl_vehauth b inner join gl_vehplate m on m.authid=b.doc_no where b.authid='"+auth+"'";
//		System.out.println(testsql2);
		ResultSet resultSet2 = stmtTest.executeQuery (testsql2);
		if(resultSet2.next()){
			stmtTest.close();
			conn.close();
			return -2;
		}
		String testsql3="select m.doc_no from gl_vehauth b inner join gl_vehmaster m on m.authid=b.doc_no where b.authid='"+auth+"'";
//		System.out.println(testsql3);
		ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
		if(resultSet3.next()){
			stmtTest.close();
			conn.close();
			return -2;
		}
		CallableStatement stmtAuth = conn.prepareCall("{call vehAuthorityDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("after stm inside edit");
		stmtAuth.setInt(6,docno);

		stmtAuth.setString(1,auth);
		stmtAuth.setString(2,authname);
		stmtAuth.setDate(3,authDate);
		stmtAuth.setString(5,session.getAttribute("BRANCHID").toString());
		stmtAuth.setString(4,session.getAttribute("USERID").toString());
		stmtAuth.setString(8, formdetailcode);
		stmtAuth.setString(7,mode);
		int aa = stmtAuth.executeUpdate();
		if (aa>0) {
//			System.out.println("Sucess");
			conn.commit();
			stmtAuth.close();
			stmtTest.close();
			conn.close();
			return aa;
		}

		stmtAuth.close();
		stmtTest.close();

		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return 0;
}

}
