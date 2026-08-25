package com.cargo.transportmasters.mode;

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
import com.controlcentre.masters.salesmanmaster.staff.ClsStaffBean;

public class ClsModeDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsModeBean staffbean=new ClsModeBean();
	Connection conn;
	
	public int insert( int docno,Date ModeDate,String Modeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_modeDML(?,?,?,?,?,?,?)}");

			
			stmtMode.registerOutParameter(1, java.sql.Types.INTEGER);
			stmtMode.setDate(3,ModeDate);
			stmtMode.setString(2,Modeid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeQuery();
			 
			System.out.println("===dml=-=="+stmtMode.toString());

			docno=stmtMode.getInt("docNo");
			
			System.out.println("==docno=="+docno);
			
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return docno;
			}
			stmtMode.close();
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return 0;	
		}finally{
			conn.close();
		}
		return 0;
	   }
	
	
	public int edit( int docno,Date ModeDate,String Modeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_modeDML(?,?,?,?,?,?,?)}");

			
			stmtMode.setInt(1,docno);;
			stmtMode.setDate(3,ModeDate);
			stmtMode.setString(2,Modeid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeQuery();
			 
			System.out.println("===dml=-=="+stmtMode.toString());

			docno=stmtMode.getInt("docNo");
			
			System.out.println("==docno=="+docno);
			
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return docno;
			}
			stmtMode.close();
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return 0;	
		}finally{
			conn.close();
		}
		return 0;
	   }
	
	
	
	public boolean delete( int docno,Date ModeDate,String Modeid, String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			int docno;
			
			CallableStatement stmtMode = conn.prepareCall("{call cr_modeDML(?,?,?,?,?,?,?)}");

			
			stmtMode.setInt(1,docno);
			stmtMode.setDate(3,ModeDate);
			stmtMode.setString(2,Modeid);
			stmtMode.setString(4,session.getAttribute("USERID").toString());
			stmtMode.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMode.setString(6,mode); 
			stmtMode.setString(7, formdetailcode);

			 stmtMode.executeUpdate();
			 
			System.out.println("===dml=-=="+stmtMode.toString());

			docno=stmtMode.getInt("docNo");
			
			System.out.println("==docno=="+docno);
			
			if (docno > 0) {
				conn.commit();
				stmtMode.close();
				conn.close();
				return true;
			}
			stmtMode.close();
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return false;	
		}finally{
			conn.close();
		}
		return false;
	   }
	

	
	public  JSONArray getModeGrid() throws SQLException {
		System.out.println("getmodegrid");
        JSONArray RESULTDATA= new  JSONArray();
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT doc_no,date,modename FROM cr_mode where status=3";
				
				System.out.println("===dml=-=="+strsql.toString());

            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	
	//serach
	public  List<ClsModeBean> list() throws SQLException {
	    List<ClsModeBean> listBean = new ArrayList<ClsModeBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtmodesearch = conn.createStatement();
	        	
				ResultSet resultSet = stmtmodesearch.executeQuery ("select doc_no,date,modename  from cr_mode where status=3");
						
System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsModeBean bean = new ClsModeBean();
					
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setModedate(resultSet.getString("date"));
	            	bean.setModeid(resultSet.getString("modename"));
					
	            	listBean.add(bean);
				}
				stmtmodesearch.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}

	}
