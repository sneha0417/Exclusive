package com.controlcentre.settings.companysettings.location;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONArray;
import com.common.ClsCommon;
import javax.servlet.http.HttpSession;

import com.controlcentre.settings.companysettings.branch.ClsBranchBean;
import com.controlcentre.settings.companysettings.location.ClsLocationBean;
import com.connection.ClsConnection;
public class ClsLocationDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

ClsLocationBean locationBean=new ClsLocationBean();
public int insert(String cmbbranchname,String txtloccode,String txtlocname,String txtaddress,String txtpbno,String txttel1,
		String txttel2,String txtfax1,String txtfax2,String txtemail1,String txtwebsite,HttpSession session,String mode,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		int aaa;
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtLocation = conn.prepareCall("{call vehLocationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtLocation.registerOutParameter(14, java.sql.Types.INTEGER);
stmtLocation.setString(1, cmbbranchname);
		
		stmtLocation.setString(2, txtloccode);
		stmtLocation.setString(3, txtlocname);
		stmtLocation.setString(4, txtaddress);
		stmtLocation.setString(5, txtpbno);
		stmtLocation.setString(6, txttel1);
		stmtLocation.setString(7, txttel2);
		stmtLocation.setString(8, txtfax1);
		stmtLocation.setString(9, txtfax2);
		stmtLocation.setString(10, txtemail1);
		stmtLocation.setString(11, txtwebsite);
		stmtLocation.setString(13,session.getAttribute("BRANCHID").toString());
		stmtLocation.setString(12,session.getAttribute("USERID").toString());
		stmtLocation.setString(15,mode);
		stmtLocation.setString(16,formdetailcode);
		stmtLocation.executeQuery();
		aaa=stmtLocation.getInt("docNo");
//		System.out.println("no====="+aaa);
		locationBean.setDocno(aaa);
		/*stmtLocation.close();
		conn.close();*/
	
		if (aaa > 0) {
			conn.commit();
			stmtLocation.close();
			conn.close();		
//			System.out.println("Success"+locationBean.getDocno());
			return aaa;
		}
		stmtLocation.close();
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
public boolean edit(String cmbbranchname,String txtloccode,String txtlocname,String txtaddress,String txtpbno,String txttel1,
		String txttel2,String txtfax1,String txtfax2,String txtemail1,String txtwebsite,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtLocation = conn.prepareCall("{call vehLocationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtLocation.setString(1, cmbbranchname);
			stmtLocation.setInt(14, docno);
			stmtLocation.setString(2, txtloccode);
			stmtLocation.setString(3, txtlocname);
			stmtLocation.setString(4, txtaddress);
			stmtLocation.setString(5, txtpbno);
			stmtLocation.setString(6, txttel1);
			stmtLocation.setString(7, txttel2);
			stmtLocation.setString(8, txtfax1);
			stmtLocation.setString(9, txtfax2);
			stmtLocation.setString(10, txtemail1);
			stmtLocation.setString(11, txtwebsite);
			stmtLocation.setString(13,session.getAttribute("BRANCHID").toString());
			stmtLocation.setString(12,session.getAttribute("USERID").toString());
			stmtLocation.setString(15,mode);
			stmtLocation.setString(16,formdetailcode);
			
			
//			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
//			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtLocation.executeUpdate();

//			System.out.println("inside DAO1");
			if (aa>0) {
				conn.commit();

				stmtLocation.close();
				conn.close();	
//				System.out.println("Success");
				return true;
			}

			stmtLocation.close();
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
public int delete(String cmbbranchname,String txtloccode,String txtlocname,String txtaddress,String txtpbno,String txttel1,
		String txttel2,String txtfax1,String txtfax2,String txtemail1,String txtwebsite,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement();
		String testsql="select doc_no from gl_vmove where olocid='"+docno+"' or ilocid='"+docno+"'";
		String testsql2="select doc_no from gl_vehreplace where rlocid='"+docno+"' or olocid='"+docno+"' or inloc='"+docno+"'";
		ResultSet rstest=stmtTest.executeQuery(testsql);
		
		if(rstest.next()){
			return -1;
		}
		ResultSet rstest2=stmtTest.executeQuery(testsql2);
		if(rstest2.next()){
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtLocation = conn.prepareCall("{call vehLocationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtLocation.setString(1, cmbbranchname);
		stmtLocation.setInt(14, docno);
		stmtLocation.setString(2, txtloccode);
		stmtLocation.setString(3, txtlocname);
		stmtLocation.setString(4, txtaddress);
		stmtLocation.setString(5, txtpbno);
		stmtLocation.setString(6, txttel1);
		stmtLocation.setString(7, txttel2);
		stmtLocation.setString(8, txtfax1);
		stmtLocation.setString(9, txtfax2);
		stmtLocation.setString(10, txtemail1);
		stmtLocation.setString(11, txtwebsite);
		stmtLocation.setString(13,session.getAttribute("BRANCHID").toString());
		stmtLocation.setString(12,session.getAttribute("USERID").toString());
		stmtLocation.setString(15,mode);
		stmtLocation.setString(16,formdetailcode);

//		System.out.println("after stm inside delete");
		
		int val = stmtLocation.executeUpdate();
		
		if (val>0) {
			conn.commit();
			stmtTest.close();
			stmtLocation.close();
			
			conn.close();
//			System.out.println("Success");
			return val;
		}

		stmtTest.close();
		stmtLocation.close();
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
public JSONArray list() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
    Connection conn=null;
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtLocation = conn.createStatement ();
			ResultSet resultSet = stmtLocation.executeQuery("select loc.loc,loc.loc_name,loc.address,loc.tel,loc.fax,loc.email,loc.brhid,loc.doc_no,loc.tel2,loc.fax2,"+
					" loc.web,loc.pbno,br.branchname from my_locm loc left join my_brch br on loc.brhid=br.doc_no where loc.status<>7");
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtLocation.close();
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
    return RESULTDATA;
}
}
