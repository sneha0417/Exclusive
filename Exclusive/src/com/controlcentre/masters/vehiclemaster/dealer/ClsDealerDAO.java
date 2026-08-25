package com.controlcentre.masters.vehiclemaster.dealer;
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

import com.controlcentre.masters.vehiclemaster.dealer.ClsDealerBean;
import com.controlcentre.masters.vehiclemaster.financier.ClsFinancierBean;
import com.connection.ClsConnection;
public class ClsDealerDAO {
	ClsConnection ClsConnection=new ClsConnection();


ClsDealerBean dealerBean=new ClsDealerBean();
public int insert( String dealername, Date sqlStartDate,int txtaccno,HttpSession session,String mode,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		int aaa;
		
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select name from my_vendorm where status<>7 and name='"+dealername+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtDealer = conn.prepareCall("{call vehVendorDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtDealer.registerOutParameter(6, java.sql.Types.INTEGER);
		stmtDealer.setString(1,dealername);
		stmtDealer.setDate(3,sqlStartDate);
		stmtDealer.setInt(2, txtaccno);
		stmtDealer.setString(5,session.getAttribute("BRANCHID").toString());
		stmtDealer.setString(4,session.getAttribute("USERID").toString());
		stmtDealer.setString(7,mode);
		stmtDealer.setString(8,formdetailcode);
		stmtDealer.executeQuery();
		aaa=stmtDealer.getInt("docNo");
//		System.out.println("no====="+aaa);
		dealerBean.setDocno(aaa);
		if (aaa > 0) {
			
			//System.out.println("Success"+dealerBean.getDocno());
			conn.commit();
			stmtTest.close();

			stmtDealer.close();
			conn.close();
			return aaa;
		}
		stmtTest.close();

		stmtDealer.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
	return 0;
}


public  List<ClsDealerBean> list() throws SQLException {
    List<ClsDealerBean> listBean = new ArrayList<ClsDealerBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtDealer = conn.createStatement ();
        	
			ResultSet resultSet = stmtDealer.executeQuery ("select m1.name,m1.doc_no,m1.acc_no,m1.date,m2.description from my_vendorm m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7");

			while (resultSet.next()) {
				
				ClsDealerBean bean = new ClsDealerBean();
            	bean.setDocno(resultSet.getInt("doc_no"));
				bean.setDealername(resultSet.getString("name"));
				bean.setDealerdate(resultSet.getDate("date"));
				bean.setTxtaccno(resultSet.getInt("acc_no"));
				bean.setTxtaccname(resultSet.getString("description"));
            	listBean.add(bean);
//            	System.out.println(listBean);
			}

			stmtDealer.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}


public  List<ClsDealerBean> listacc() throws SQLException {
    List<ClsDealerBean> listBean = new ArrayList<ClsDealerBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtDealer = conn.createStatement ();
        	
			ResultSet resultSet = stmtDealer.executeQuery ("select description,doc_no from my_head where atype='GL'");

			while (resultSet.next()) {
				
				ClsDealerBean bean = new ClsDealerBean();
            	bean.setTxtaccno(resultSet.getInt("DOC_NO"));
				bean.setTxtaccname(resultSet.getString("description"));
            	listBean.add(bean);
            	//System.out.println(listBean);
			}

			stmtDealer.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public int edit(String dealername,int docno,Date dealerdate,int txtaccno,String mode, HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();
		String testSql="select name from my_vendorm where status<>7 and name='"+dealername+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtDealer = conn.prepareCall("{call vehVendorDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("after stm inside edit");
		//System.out.println("BRAND ID"+brandid);
		//stmtDealer.setString(3,dealerid);
		stmtDealer.setString(1, dealername);
		stmtDealer.setDate(3,(Date)dealerdate);
		stmtDealer.setInt(2, txtaccno);
		stmtDealer.setString(5, session.getAttribute("BRANCHID").toString());
		stmtDealer.setString(4, session.getAttribute("USERID").toString());
		stmtDealer.setInt(6, docno);
		stmtDealer.setString(7, mode);
		stmtDealer.setString(8,formdetailcode);
//		System.out.println("before date");
		//stmtDealer.setDate(2,(Date)modeldate);
//		System.out.println("after date");
//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

		int aa = stmtDealer.executeUpdate();
		
//		System.out.println("inside DAO1");
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtTest.close();
			stmtDealer.close();
			conn.close();
			return aa;
		}
		stmtTest.close();

		stmtDealer.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return 0;
}


public int delete(String dealername,int docno,Date dealerdate,int txtaccno,String mode, HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();

		String testsql3="select m.doc_no from my_vendorm b inner join gl_vehmaster m on m.dlrid=b.doc_no where b.name='"+dealername+"' and b.doc_no!='"+docno+"'";
		ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
		if(resultSet3.next()){
			stmtTest.close();
			conn.close();
			return -2;
		}
		CallableStatement stmtDealer = conn.prepareCall("{call vehVendorDML(?,?,?,?,?,?,?,?)}");
//		System.out.println("out delete");
		//stmtDealer.setString(3,dealerid);
		stmtDealer.setString(1,dealername);
		stmtDealer.setDate(3,(Date)dealerdate);
		stmtDealer.setInt(2, txtaccno);
		stmtDealer.setString(5, session.getAttribute("BRANCHID").toString());
		stmtDealer.setString(4, session.getAttribute("USERID").toString());
		stmtDealer.setInt(6, docno);
		stmtDealer.setString(7, mode);
		stmtDealer.setString(8,formdetailcode);
		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtDealer.executeUpdate();
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtDealer.close();
			conn.close();
			return aa;
		}
		stmtTest.close();

		stmtDealer.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return 0;
}
}