package com.controlcentre.masters.vehiclemaster.project;

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

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProjectDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsProjectBean projectBean = new ClsProjectBean();
	
	
	public int insert(String formdetailcode, Date projectsDate, int txtcldocno,String txtprojectname, HttpSession session, String mode) throws SQLException {
		Connection conn=null;
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			Statement stmtPRJ1=conn.createStatement ();
			String Sql="select project_name from gl_project where status<>7 and project_name='"+txtprojectname+"' and cldocno="+txtcldocno;
			ResultSet resultSet = stmtPRJ1.executeQuery (Sql);
			if(resultSet.next()){
				return -1;
			}
			
			CallableStatement stmtPRJ = conn.prepareCall("{CALL vehProjectDML(?,?,?,?,?,?,?,?)}");
			
			stmtPRJ.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtPRJ.setDate(1,projectsDate);
			stmtPRJ.setInt(2,txtcldocno);
			stmtPRJ.setString(3,txtprojectname);
			stmtPRJ.setString(4,formdetailcode);
			stmtPRJ.setString(5,branch);
			stmtPRJ.setString(6,userid);
			stmtPRJ.setString(8,mode);
			int datas=stmtPRJ.executeUpdate();
			if(datas<=0){
				stmtPRJ.close();
				conn.close();
				return 0;
			}
			int docno=stmtPRJ.getInt("docNo");
			projectBean.setTxtprojectdocno(docno);
			if (docno > 0) {
					conn.commit();
					stmtPRJ.close();
					conn.close();
					return docno;
				 }
			stmtPRJ.close();
			conn.close();
	 }catch(Exception e){	
		 e.printStackTrace();   
		 conn.close();
		 	
		 	return 0;
	 }
		finally{
			conn.close();
		}
		return 0;
	}

	public boolean edit(int txtprojectdocno, String formdetailcode,Date projectsDate, int txtcldocno, String txtprojectname,HttpSession session, String mode) throws SQLException {
	Connection conn=null;
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtPRJ = conn.prepareCall("{CALL vehProjectDML(?,?,?,?,?,?,?,?)}");
			
			stmtPRJ.setInt(7,txtprojectdocno);
			stmtPRJ.setDate(1,projectsDate);
			stmtPRJ.setInt(2,txtcldocno);
			stmtPRJ.setString(3,txtprojectname);
			stmtPRJ.setString(4,formdetailcode);
			stmtPRJ.setString(5,branch);
			stmtPRJ.setString(6,userid);
			stmtPRJ.setString(8,mode);
			int datas=stmtPRJ.executeUpdate();
			if(datas<=0){
				stmtPRJ.close();
				conn.close();
				return false;
			}
			int docno=stmtPRJ.getInt("docNo");
			projectBean.setTxtprojectdocno(docno);
			if (docno > 0) {
					conn.commit();
					stmtPRJ.close();
					conn.close();
					return true;
				 }
			stmtPRJ.close();
			conn.close();
	 }catch(Exception e){	
		 e.printStackTrace();   
		 conn.close();
		 	
		 	return false;
	 }
		finally{
			conn.close();
		}
	 return false;
	}
	
	public int delete(int txtprojectdocno, String formdetailcode,Date projectsDate, int txtcldocno, String txtprojectname,HttpSession session, String mode) throws SQLException {
	Connection conn=null;
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtPRJ = conn.prepareCall("{CALL vehProjectDML(?,?,?,?,?,?,?,?)}");
			
			stmtPRJ.setInt(7,txtprojectdocno);
			stmtPRJ.setDate(1,projectsDate);
			stmtPRJ.setInt(2,txtcldocno);
			stmtPRJ.setString(3,txtprojectname);
			stmtPRJ.setString(4,formdetailcode);
			stmtPRJ.setString(5,branch);
			stmtPRJ.setString(6,userid);
			stmtPRJ.setString(8,mode);
			int datas=stmtPRJ.executeUpdate();
			if(datas<=0){
				stmtPRJ.close();
				conn.close();
				return 0;
			}
			int docno=txtprojectdocno;
			projectBean.setTxtprojectdocno(docno);
			if (docno > 0) {
					conn.commit();
					stmtPRJ.close();
					conn.close();
					return 1;
				 }
			stmtPRJ.close();
			conn.close();
	 }catch(Exception e){	
		 e.printStackTrace();   
		 conn.close();
		 	
		 	return 0;
	 }
		finally{
			conn.close();
		}
	 return 0;
	}
	
	public  JSONArray clientDetailsSearch() throws SQLException {
	    List<ClsProjectBean> clientDetailsSearchBean = new ArrayList<ClsProjectBean>();
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn=null;
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtORE = conn.createStatement ();
	        	
				ResultSet resultSet = stmtORE.executeQuery ("select t.account,c.refname,c.cldocno from my_acbook c left join  my_head t on t.doc_no=c.acno where "
						+ "t.atype='AR' and c.status=3");
	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtORE.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
	    return RESULTDATA;
	}
	
	public  JSONArray projectDetailsLoading() throws SQLException {
	    List<ClsProjectBean> projectDetailsLoadingBean = new ArrayList<ClsProjectBean>();
	    JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtORE = conn.createStatement ();
	        	
				ResultSet resultSet = stmtORE.executeQuery ("select p.doc_no,p.project_name,p.date,c.refname from gl_project p left join  my_acbook c on p.cldocno=c.cldocno and c.dtype='CRM' where p.status<>7");
	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtORE.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
	    return RESULTDATA;
	}

}
