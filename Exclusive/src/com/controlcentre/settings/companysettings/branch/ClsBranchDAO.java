package com.controlcentre.settings.companysettings.branch;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;
public class ClsBranchDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsBranchBean branchBean=new ClsBranchBean();
	public int insert(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
			String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
			String txtcstno,String txtstcno,HttpSession session,String mode,String formdetailcode) throws SQLException {
	Connection conn=null;
		try{
		int aaa;
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
	//	System.out.println(cmbbranchcurr);
		
		CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtBranch.registerOutParameter(21, java.sql.Types.INTEGER);
		//stmtBranch.setString(1,);
		int temp=0;
		stmtBranch.setString(1, compid);
		
		stmtBranch.setString(2, txtbranchid);
		stmtBranch.setString(3, txtbranchname);
		stmtBranch.setString(4, txtaddress);
		stmtBranch.setString(5, txtpbno);
		stmtBranch.setString(6, txttel1);
		stmtBranch.setString(7, txttel2);
		stmtBranch.setString(8, txtfax1);
		stmtBranch.setString(9, txtfax2);
		stmtBranch.setString(10, txtemail1);
		stmtBranch.setString(11, txtwebsite);
		stmtBranch.setString(12, txttinno);
		stmtBranch.setString(13, txtstcno);
		stmtBranch.setString(14,txtcstno);
		stmtBranch.setInt(15,temp);
		stmtBranch.setDate(16, sqlAccdate1);
		stmtBranch.setDate(17, sqlAccdate2);
		stmtBranch.setString(18, cmbbranchcurr);
//System.out.println(cmbbranchcurr);
		stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
//		System.out.println("BRANCHID"+session.getAttribute("BRANCHID").toString());
		stmtBranch.setString(19,session.getAttribute("USERID").toString());
		stmtBranch.setString(22,mode);
		stmtBranch.setString(23, formdetailcode);
		stmtBranch.executeQuery();
		aaa=stmtBranch.getInt("docNo");
//		System.out.println("no====="+aaa);
		branchBean.setDocno(aaa);
		

		if (aaa > 0) {
			conn.commit();

			stmtBranch.close();
			conn.close();
//			System.out.println("Success"+branchBean.getDocno());
			return aaa;
			
			
		}

		stmtBranch.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
		finally{
			conn.close();
		}
	
	return 0;
	
}
public boolean edit(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
		String txtcstno,String txtstcno,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtBranch.setInt(21,docno);
			//stmtBranch.setString(1,);
			int temp=0;
			stmtBranch.setString(1, compid);
			
			stmtBranch.setString(2, txtbranchid);
			stmtBranch.setString(3, txtbranchname);
			stmtBranch.setString(4, txtaddress);
			stmtBranch.setString(5, txtpbno);
			stmtBranch.setString(6, txttel1);
			stmtBranch.setString(7, txttel2);
			stmtBranch.setString(8, txtfax1);
			stmtBranch.setString(9, txtfax2);
			stmtBranch.setString(10, txtemail1);
			stmtBranch.setString(11, txtwebsite);
			stmtBranch.setString(12, txttinno);
			stmtBranch.setString(13, txtstcno);
			stmtBranch.setString(14,txtcstno);
			stmtBranch.setInt(15,temp);
			stmtBranch.setDate(16, sqlAccdate1);
			stmtBranch.setDate(17, sqlAccdate2);
			stmtBranch.setString(18, cmbbranchcurr);
	//System.out.println(cmbbranchcurr);
			stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
			stmtBranch.setString(19,session.getAttribute("USERID").toString());
			stmtBranch.setString(22,mode);
			stmtBranch.setString(23, formdetailcode);
			
//			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
//			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtBranch.executeUpdate();
			
//			System.out.println("inside DAO1");
			
			if (aa>0) {
				conn.commit();
				stmtBranch.close();
				conn.close();	
//				System.out.println("Success");
				return true;
			}
			stmtBranch.close();
			conn.close();	
		}catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
public int delete(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
		String txtcstno,String txtstcno,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select brhid from my_locm where brhid='"+docno+"' and status<>7";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtBranch.setInt(21,docno);
		//stmtBranch.setString(1,);
		int temp=0;
		stmtBranch.setString(1, compid);
		
		stmtBranch.setString(2, txtbranchid);
		stmtBranch.setString(3, txtbranchname);
		stmtBranch.setString(4, txtaddress);
		stmtBranch.setString(5, txtpbno);
		stmtBranch.setString(6, txttel1);
		stmtBranch.setString(7, txttel2);
		stmtBranch.setString(8, txtfax1);
		stmtBranch.setString(9, txtfax2);
		stmtBranch.setString(10, txtemail1);
		stmtBranch.setString(11, txtwebsite);
		stmtBranch.setString(12, txttinno);
		stmtBranch.setString(13, txtstcno);
		stmtBranch.setString(14,txtcstno);
		stmtBranch.setInt(15,temp);
		stmtBranch.setDate(16, sqlAccdate1);
		stmtBranch.setDate(17, sqlAccdate2);
		stmtBranch.setString(18, cmbbranchcurr);
//System.out.println(cmbbranchcurr);
		stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
		stmtBranch.setString(19,session.getAttribute("USERID").toString());
		stmtBranch.setString(22,mode);
		stmtBranch.setString(23, formdetailcode);
		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtBranch.executeUpdate();
	
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtBranch.close();
			conn.close();	
			return aa;
		}
		stmtBranch.close();
		conn.close();	
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	
	return 0;
}
public  List<ClsBranchBean> list() throws SQLException {
    List<ClsBranchBean> listBean = new ArrayList<ClsBranchBean>();
    Connection conn=null;
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtBranch = conn.createStatement ();
        	
			ResultSet resultSet = stmtBranch.executeQuery ("select branch, branchname, address, tel, fax, accyear_f, accyear_t, email, doc_no, curid, tel2, fax2, web, cmpid, pbno, stcno, cstno, tinno from my_brch where status<>7");

			while (resultSet.next()) {
				
				ClsBranchBean bean = new ClsBranchBean();
            	bean.setDocno(resultSet.getInt("doc_no"));
				bean.setTxtbranchid(resultSet.getString("branch"));
				bean.setTxtbranchname(resultSet.getString("branchname"));
				bean.setTxtaddress(resultSet.getString("address"));
				bean.setTxttel1(resultSet.getString("tel"));
				bean.setTxtfax1(resultSet.getString("fax"));
				bean.setBranchaccdate1(resultSet.getDate("accyear_f"));
				bean.setBranchaccdate2(resultSet.getDate("accyear_t"));
				bean.setTxtemail1(resultSet.getString("email"));
				bean.setCmbbranchcurr(resultSet.getString("curid"));
				bean.setTxttel2(resultSet.getString("tel2"));
				bean.setTxtfax2(resultSet.getString("fax2"));
				bean.setTxtwebsite(resultSet.getString("web"));
				bean.setCmbcompname(resultSet.getString("cmpid"));
				bean.setTxtpbno(resultSet.getString("pbno"));
				bean.setTxtcstno(resultSet.getString("cstno"));
				bean.setTxtstcno(resultSet.getString("stcno"));
				bean.setTxttinno(resultSet.getString("tinno"));
				listBean.add(bean);
//            	System.out.println(listBean);
				
			}
			stmtBranch.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
}
