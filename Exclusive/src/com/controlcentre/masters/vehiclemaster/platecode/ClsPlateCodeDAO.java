package com.controlcentre.masters.vehiclemaster.platecode;

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
import com.common.ClsCommon;
import net.sf.json.JSONArray;

public class ClsPlateCodeDAO {
	ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
	ClsPlateCodeBean brandBean = new ClsPlateCodeBean();
	
	public int insert(String plateCode, String platename,
			java.sql.Date date_plateCode, String authName, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select code_no from gl_vehplate where status<>7 and code_no='"+plateCode+"' AND AUTH_ID="+authName;
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtPlate = conn.prepareCall("{CALL vehPlateCodeDML1(?,?,?,?,?,?,?,?,?)}");
			stmtPlate.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtPlate.setString(1,plateCode);
			stmtPlate.setString(2,platename);
			stmtPlate.setDate(3,date_plateCode);
			stmtPlate.setString(4,authName);
			stmtPlate.setString(5,session.getAttribute("BRANCHID").toString());
			stmtPlate.setString(6,session.getAttribute("USERID").toString());
			stmtPlate.setString(8,"A");
			stmtPlate.setString(9,formdetailcode);
			stmtPlate.executeQuery();
			aaa=stmtPlate.getInt("docNo");
//			System.out.println("no====="+aaa);
			brandBean.setDocno(aaa);
			if (aaa > 0) {
				
//				System.out.println("Sucess"+brandBean.getDocno());
				conn.commit();
				stmtPlate.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}
			stmtPlate.close();
			stmtTest.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();
		conn.close();
		}
		return 0;
	}
	
	public int edit(int docno, Date sqlStartDate, String plateCode,
			String platename, String authName,
			HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
		
		conn.setAutoCommit(false);
//		System.out.println(conn);
		Statement stmtTest=conn.createStatement ();
		String testSql="select code_no from gl_vehplate where status<>7 and code_no='"+plateCode+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtPlate = conn.prepareCall("{CALL vehPlateCodeDML1(?,?,?,?,?,?,?,?,?)}");
		stmtPlate.setString(1,plateCode);
		stmtPlate.setString(2,platename);
		stmtPlate.setDate(3,sqlStartDate);
		stmtPlate.setString(4,authName);
		stmtPlate.setString(5,session.getAttribute("BRANCHID").toString());
		stmtPlate.setString(6,session.getAttribute("USERID").toString());
		stmtPlate.setInt(7, docno);
		stmtPlate.setString(8,"E");
		stmtPlate.setString(9,formdetailcode);
		stmtPlate.executeQuery();
		int aaa=stmtPlate.getInt("docNo");
//		System.out.println("no====="+aaa);
		brandBean.setDocno(aaa);
		if (aaa > 0) {
			
//			System.out.println("Sucess"+brandBean.getDocno());
			conn.commit();
			stmtPlate.close();
			stmtTest.close();
			conn.close();
			return aaa;
		}		

		stmtPlate.close();
		stmtTest.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		return 0;
	}

	public int delete(int docno, HttpSession session,String platecode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
//			System.out.println(conn);
			Statement stmtTest=conn.createStatement ();

			String testsql3="select m.doc_no from gl_vehplate b inner join gl_vehmaster m on m.pltid=b.doc_no where b.code_no='"+platecode+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtPlate = conn.prepareCall("{CALL vehPlateCodeDML1(?,?,?,?,?,?,?,?,?)}");
			stmtPlate.setString(1,null);
			stmtPlate.setString(2,null);
			stmtPlate.setDate(3,null);
			stmtPlate.setString(4,null);
			stmtPlate.setString(5,session.getAttribute("BRANCHID").toString());
			stmtPlate.setString(6,session.getAttribute("USERID").toString());
			stmtPlate.setInt(7, docno);
			stmtPlate.setString(8,"D");
			stmtPlate.setString(9,formdetailcode);

			stmtPlate.executeQuery();
			int aaa=stmtPlate.getInt("docNo");
//			System.out.println("no====="+aaa);
			brandBean.setDocno(aaa);
			if (aaa > 0) {
				
//				System.out.println("Sucess"+brandBean.getDocno());
				conn.commit();
				stmtPlate.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}		
			stmtPlate.close();
			stmtTest.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}

	
    public  List<ClsPlateCodeBean> list() throws SQLException {
        List<ClsPlateCodeBean> listBean = new ArrayList<ClsPlateCodeBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtPlate = conn.createStatement ();
				ResultSet resultSet = stmtPlate.executeQuery ("select p.doc_no,code_no,code_name,a.authname,p.authid,p.date from gl_vehplate p inner join gl_vehauth a on(a.doc_no=p.authid) where p.status<>7");
				while (resultSet.next()) {
					
					ClsPlateCodeBean bean = new ClsPlateCodeBean();
	            	bean.setPlateCode(resultSet.getString("code_no"));
	            	bean.setPlatename(resultSet.getString("code_name"));
	            	bean.setAuthName(resultSet.getString("authname"));
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setAuthId(resultSet.getString("authid"));
	            	bean.setDate_plateCode(resultSet.getDate("date"));
	            	listBean.add(bean);
				}

				stmtPlate.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }


  public JSONArray naliasdetails(String itemno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			String sqlalias="select nalias code,doc_no from gl_webcat where itemno='"+itemno+"' ";
		//	String trfsql="select DATE_FORMAT((coalesce(autodate,date)),'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT((coalesce(autodate,date)),'%d.%m.%Y') hiddate from gl_traffic where DATE_FORMAT((coalesce(autodate,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(autodate,date)),'%Y-%m-%d')>='"+sdate+"' group by coalesce(autodate,date)";
				resultSet= stmt.executeQuery (sqlalias);
		//		System.out.println(trfsql);
		
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}



}
