package com.controlcentre.settings.companysettings.company;
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
public class ClsCompanyDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsCompanyBean companyBean=new ClsCompanyBean();
	public int insert(String txtcompid,String txtcompname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
			String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbcurr,HttpSession session,
			String mode,String formdetailcode,String cmbtimezone) throws SQLException {
	Connection conn=null; 
		try{
		int aaa;
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		Statement stmtTest=conn.createStatement ();
		String testSql="select comp_id from my_comp where status<>7 and comp_id='"+txtcompid+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			return -1;
		}
		CallableStatement stmtCompany = conn.prepareCall("{call vehCompDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtCompany.registerOutParameter(16, java.sql.Types.INTEGER);
		stmtCompany.setString(1,txtcompid);
		stmtCompany.setString(2,txtcompname);
		stmtCompany.setString(3, txtaddress);
		stmtCompany.setString(4, txtpbno);
		stmtCompany.setString(5, txttel1);
		stmtCompany.setString(6, txttel2);
		stmtCompany.setString(7, txtfax1);
		stmtCompany.setString(8, txtfax2);
		stmtCompany.setString(9, txtemail1);
		stmtCompany.setString(10, txtwebsite);
		stmtCompany.setDate(11, sqlAccdate1);
		stmtCompany.setDate(12, sqlAccdate2);
		stmtCompany.setString(13,cmbcurr);
		stmtCompany.setString(15,session.getAttribute("BRANCHID").toString());
		stmtCompany.setString(14,session.getAttribute("USERID").toString());
		stmtCompany.setString(17,mode);
		stmtCompany.setString(18,formdetailcode);
		stmtCompany.setString(19,cmbtimezone);
		stmtCompany.executeQuery();
		aaa=stmtCompany.getInt("docNo");
		
		System.out.println("no====="+aaa);
		companyBean.setDocno(aaa);
		/*stmtCompany.close();
		conn.close();*/
		
		if (aaa > 0) {
			conn.commit();
			stmtCompany.close();
			stmtTest.close();
			conn.close();
			System.out.println("Success"+companyBean.getDocno());
			return aaa;
		}
		stmtCompany.close();
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
public int edit(String txtcompid,String txtcompname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbcurr,HttpSession session,String mode,
		int docno,String formdetailcode,String cmbtimezone) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			//System.out.println("Date Check:"+sqlAccdate1+"/////"+sqlAccdate2);
			//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			Statement stmtTest=conn.createStatement ();
			String testSql="select comp_id from my_comp where status<>7 and comp_id='"+txtcompid+"' and doc_no!='"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			CallableStatement stmtCompany = conn.prepareCall("{call vehCompDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtCompany.setInt(16,docno);
			stmtCompany.setString(1,txtcompid);
			stmtCompany.setString(2,txtcompname);
			stmtCompany.setString(3, txtaddress);
			stmtCompany.setString(4, txtpbno);
			stmtCompany.setString(5, txttel1);
			stmtCompany.setString(6, txttel2);
			stmtCompany.setString(7, txtfax1);
			stmtCompany.setString(8, txtfax2);
			stmtCompany.setString(9, txtemail1);
			stmtCompany.setString(10, txtwebsite);
			stmtCompany.setDate(11, sqlAccdate1);
			stmtCompany.setDate(12, sqlAccdate2);
			stmtCompany.setString(13,cmbcurr);
			stmtCompany.setString(15,session.getAttribute("BRANCHID").toString());
			stmtCompany.setString(14,session.getAttribute("USERID").toString());
			stmtCompany.setString(17,mode);
			stmtCompany.setString(18,formdetailcode);
			stmtCompany.setString(19,cmbtimezone);
			
			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtCompany.executeUpdate();
			
			System.out.println("inside DAO1");
			if (aa>0) {
				System.out.println("Success");
				conn.commit();
				stmtCompany.close();
				stmtTest.close();
				conn.close();
				return aa;
			}
			stmtCompany.close();
			stmtTest.close();
			conn.close();
			/*stmtDamage.close();
			conn.close();*/	
		}catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}
		
		
		return 0;
	}
public int delete(String txtcompid,String txtcompname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbcurr,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select cmpid from my_brch where cmpid='"+docno+"' and status<>7";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			return -1;
		}
		
		//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtCompany = conn.prepareCall("{call vehCompDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtCompany.setInt(16,docno);
		stmtCompany.setString(1,txtcompid);
		stmtCompany.setString(2,txtcompname);
		stmtCompany.setString(3, txtaddress);
		stmtCompany.setString(4, txtpbno);
		stmtCompany.setString(5, txttel1);
		stmtCompany.setString(6, txttel2);
		stmtCompany.setString(7, txtfax1);
		stmtCompany.setString(8, txtfax2);
		stmtCompany.setString(9, txtemail1);
		stmtCompany.setString(10, txtwebsite);
		stmtCompany.setDate(11, sqlAccdate1);
		stmtCompany.setDate(12, sqlAccdate2);
		stmtCompany.setString(13,cmbcurr);
		stmtCompany.setString(15,session.getAttribute("BRANCHID").toString());
		stmtCompany.setString(14,session.getAttribute("USERID").toString());
		stmtCompany.setString(17,mode);
		stmtCompany.setString(18,formdetailcode);
		stmtCompany.setString(19,"0");
		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtCompany.executeUpdate();
		if (aa>0) {
			conn.commit();
			stmtCompany.close();
			stmtTest.close();
			conn.close();
			
			System.out.println("Success");
			return aa;
		}
		stmtCompany.close();
		stmtTest.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	
	
	return -1;
}
public JSONArray getSearchData() throws SQLException {
Connection conn=null;
JSONArray RESULTDATA=new JSONArray();
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCompany = conn.createStatement ();
        	
			ResultSet resultSet = stmtCompany.executeQuery ("select timezoneid,comp_id,company,address,tel,fax,accyear_f,accyear_t,email,doc_no,curid,tel2,fax2,web,pbno from my_comp where status<>7");
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtCompany.close();

	}
	
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return RESULTDATA;
}
}
