package com.controlcentre.settings.companysettings.currency;
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
public class ClsCurrencyDAO {
	ClsConnection ClsConnection=new ClsConnection();

ClsCurrencyBean currencyBean=new ClsCurrencyBean();
public int insert(String txtcode,String txtcodename,String txtcountry,String txtdecimal,String txtfraction,HttpSession session,String mode,String formdetailcode) throws SQLException {
Connection conn=null;
	try{
	int aaa;
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
//	System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
//	System.out.println(cmbbranchcurr);
	
	CallableStatement stmtCurrency = conn.prepareCall("{call currencyDML(?,?,?,?,?,?,?,?,?,?)}");
	stmtCurrency.registerOutParameter(8, java.sql.Types.INTEGER);
	stmtCurrency.setString(1, txtcode);
	stmtCurrency.setString(2, txtcodename);
	stmtCurrency.setString(3, txtcountry);
	stmtCurrency.setString(4, txtfraction);
	stmtCurrency.setString(5, txtdecimal);
	stmtCurrency.setString(7,session.getAttribute("BRANCHID").toString());
	stmtCurrency.setString(6,session.getAttribute("USERID").toString());
	stmtCurrency.setString(9,mode);
	stmtCurrency.setString(10,formdetailcode);
	stmtCurrency.executeQuery();
	aaa=stmtCurrency.getInt("docNo");
//	System.out.println("no====="+aaa);
	currencyBean.setDocno(aaa);

	if (aaa > 0) {
		conn.commit();

		stmtCurrency.close();
		conn.close();
//		System.out.println("Success"+currencyBean.getDocno());
		
		return aaa;
	}

	stmtCurrency.close();
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
public boolean edit(String txtcode,Date currdate,String txtcodename,String txtcountry,String txtdecimal,String txtfraction,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtCurrency = conn.prepareCall("{call currencyDML(?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtCurrency.setInt(8,docno);
			//stmtBranch.setString(1,);
			stmtCurrency.setString(1, txtcode);
			stmtCurrency.setString(2, txtcodename);
			stmtCurrency.setString(3, txtcountry);
			stmtCurrency.setString(4, txtfraction);
			stmtCurrency.setString(5, txtdecimal);
			stmtCurrency.setString(7,session.getAttribute("BRANCHID").toString());
			stmtCurrency.setString(6,session.getAttribute("USERID").toString());
			stmtCurrency.setString(9,mode);
			stmtCurrency.setString(10,formdetailcode);

			
//			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
//			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtCurrency.executeUpdate();

				
//			System.out.println("inside DAO1");
			if (aa>0) {
				conn.commit();
				stmtCurrency.close();
				conn.close();
//				System.out.println("Success");
				return true;
			}
			stmtCurrency.close();
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
public int delete(String txtcode,Date currdate,String txtcodename,String txtcountry,String txtdecimal,String txtfraction,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select tr_no from my_jvtran where curid="+docno;
		String testsql2="select doc_no from my_comp where curid="+docno;
		String testsql3="select doc_no from my_brch where curid="+docno;
		String testsql4="select doc_no from my_locm where curid="+docno;
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			return -1;
		}
		ResultSet rstest2=stmtTest.executeQuery(testsql2);
		if(rstest2.next()){
			return -1;
		}
		ResultSet rstest3=stmtTest.executeQuery(testsql3);
		if(rstest3.next()){
			return -1;
		}
		ResultSet rstest4=stmtTest.executeQuery(testsql4);
		if(rstest4.next()){
			return -1;
		}
		
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtCurrency = conn.prepareCall("{call currencyDML(?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtCurrency.setInt(8,docno);
		//stmtBranch.setString(1,);
		stmtCurrency.setString(1, txtcode);
		stmtCurrency.setString(2, txtcodename);
		stmtCurrency.setString(3, txtcountry);
		stmtCurrency.setString(4, txtfraction);
		stmtCurrency.setString(5, txtdecimal);
		stmtCurrency.setString(7,session.getAttribute("BRANCHID").toString());
		stmtCurrency.setString(6,session.getAttribute("USERID").toString());
		stmtCurrency.setString(9,mode);
		stmtCurrency.setString(10,formdetailcode);

		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtCurrency.executeUpdate();

		
		if (aa>0) {
			conn.commit();
			stmtCurrency.close();
			stmtTest.close();
			conn.close();
//			System.out.println("Success");
			return aa;
		}
		stmtCurrency.close();
		stmtTest.close();
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
public  List<ClsCurrencyBean> list() throws SQLException {
    List<ClsCurrencyBean> listBean = new ArrayList<ClsCurrencyBean>();
    Connection conn=null;
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCurrency = conn.createStatement ();
        	
			ResultSet resultSet = stmtCurrency.executeQuery ("select code,c_name,decimals,fraction,country,doc_no from my_curr where status<>7");

			while (resultSet.next()) {
				
				ClsCurrencyBean bean = new ClsCurrencyBean();
            	bean.setDocno(resultSet.getInt("doc_no"));
				bean.setTxtcode(resultSet.getString("code"));
				bean.setTxtcodename(resultSet.getString("c_name"));
				bean.setTxtdecimal(resultSet.getString("decimals"));
				bean.setTxtfraction(resultSet.getString("fraction"));
				bean.setTxtcountry(resultSet.getString("country"));
				
				listBean.add(bean);
//            	System.out.println(listBean);
			}
	stmtCurrency.close();
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
