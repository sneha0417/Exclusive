package com.controlcentre.settings.companysettings.province;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProvinceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(Date date,int txtprovincecode, String txtprovincename,HttpSession session, String mode, int docno, String formdetailcode) throws SQLException {
		
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int aaa;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtProvince = conn.prepareCall("{call provinceDML(?,?,?,?,?,?,?,?)}");
			stmtProvince.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtProvince.setDate(1, date);
			stmtProvince.setInt(2,txtprovincecode );
			stmtProvince.setString(3, txtprovincename);
			stmtProvince.setString(4,mode );
			stmtProvince.setString(6,formdetailcode );
			stmtProvince.setString(7,session.getAttribute("BRANCHID").toString());
			stmtProvince.setString(8,session.getAttribute("USERID").toString());
			
			
			stmtProvince.executeQuery();
			aaa=stmtProvince.getInt("docNo");
			if (aaa > 0) {
				conn.commit();
				stmtProvince.close();
				conn.close();		
//				System.out.println("Success"+locationBean.getDocno());
				return aaa;
			}
			stmtProvince.close();
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

	public boolean edit(Date date,int txtprovincecode, String txtprovincename,HttpSession session, String mode, int docno, String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		
		
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtProvince = conn.prepareCall("{call provinceDML(?,?,?,?,?,?,?,?)}");
			stmtProvince.setInt(5, docno);
			stmtProvince.setDate(1, date);
			stmtProvince.setInt(2,txtprovincecode );
			stmtProvince.setString(3, txtprovincename);
			stmtProvince.setString(4,mode );
			stmtProvince.setString(6,formdetailcode );
			stmtProvince.setString(7,session.getAttribute("BRANCHID").toString());
			stmtProvince.setString(8,session.getAttribute("USERID").toString());
			
			int aa = stmtProvince.executeUpdate();

//			System.out.println("inside DAO1");
			if (aa>0) {
				conn.commit();

				stmtProvince.close();
				conn.close();	
//				System.out.println("Success");
				return true;
			}

			stmtProvince.close();
			conn.close();	
		}catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
			//System.out.println("+++++++++++++++++++++");
		}		
		return false;	
	}

	public int delete(Date date,int txtprovincecode, String txtprovincename,HttpSession session, String mode, int docno, String formdetailcode)throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtProvince = conn.prepareCall("{call provinceDML(?,?,?,?,?,?,?,?)}");
			stmtProvince.setInt(5, docno);
			stmtProvince.setDate(1, date);
			stmtProvince.setInt(2, txtprovincecode);
			stmtProvince.setString(3,txtprovincename );
			stmtProvince.setString(4, mode);
			stmtProvince.setString(6,formdetailcode );
			stmtProvince.setString(7,session.getAttribute("BRANCHID").toString());
			stmtProvince.setString(8,session.getAttribute("USERID").toString());
			
			
			int val = stmtProvince.executeUpdate();
			
			if (val>0) {
				conn.commit();
				//stmtTest.close();
				stmtProvince.close();
				
				conn.close();
//				System.out.println("Success");
				return val;
			}

			//stmtTest.close();
			stmtProvince.close();
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
	public JSONArray provincelist() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	    Connection conn=null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtProvince = conn.createStatement ();
				ResultSet resultSet = stmtProvince.executeQuery("select doc_no,code,name,date from my_province where status=3");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtProvince.close();
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


	

	
			
			
			
				
		