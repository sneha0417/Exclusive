package com.aviation.taxmaster;

	import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.PreparedStatement;
	public class ClsTaxMasterDAO {
		ClsCommon ClsCommon=new ClsCommon();
		ClsConnection ClsConnection=new ClsConnection();

	public JSONArray prdtaxLoad(HttpSession session) throws SQLException {
	       
	        
	        JSONArray RESULTDATA=new JSONArray();
			
	        Connection conn = null;
	        
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement();
	            	
					String sql="select tax,desc1,DOC_NO,DATE from av_taxm where status=3 ";
					
	            	ResultSet resultSet = stmt.executeQuery(sql);
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
		
		
		public int insert(Date date_tax, String tax,String taxdesc,String mode, HttpSession session,String formdetailcode) throws SQLException {
			Connection conn=ClsConnection.getMyConnection();
			try{
				int aaa;
				
				
				conn.setAutoCommit(false);
				Statement stmtTest=conn.createStatement ();
				String testSql="select tax,desc1 from av_taxm where status<>7 and desc1='"+taxdesc+"' and tax='"+tax+"'";
				System.out.println("testsqlsave,,,,,,llll"+testSql);
				
				ResultSet resultSet1 = stmtTest.executeQuery (testSql);
				if(resultSet1.next()){
					stmtTest.close();
					conn.close();
					return -1;
				}
				CallableStatement stmttax = conn.prepareCall("{CALL taxMasterDML(?,?,?,?,?,?,?)}");
				stmttax.registerOutParameter(5, java.sql.Types.INTEGER);
				stmttax.setString(1,tax);
				stmttax.setString(2,taxdesc);
				stmttax.setDate(3,date_tax);
				stmttax.setString(4,session.getAttribute("BRANCHID").toString());
				//stmttax.setString(5,session.getAttribute("USERID").toString());
				stmttax.setString(6,mode);
				stmttax.setString(7, formdetailcode);
				int val = stmttax.executeUpdate();
				aaa=stmttax.getInt("docNo");
//				System.out.println(aaa);
				
				if (val > 0) {
//					System.out.println("Sucess"+taxBean.getDocno());
					conn.commit();
					stmttax.close();
					stmtTest.close();
					conn.close();
					return aaa;
				}
				stmttax.close();
				stmtTest.close();

				conn.close();
			}catch(Exception e){	
			e.printStackTrace();	
			conn.close();
			}
			return 0;
		}

		public int edit(int docno, java.sql.Date sqlStartDate, String tax,String taxdesc, HttpSession session,String formdetailcode) throws SQLException {
			Connection conn=ClsConnection.getMyConnection();
			try{
				
				conn.setAutoCommit(false);
				Statement stmtTest=conn.createStatement ();
				String testSql="select tax,desc1 from av_taxm where status<>7 and desc1='"+taxdesc+"'and tax='"+tax+"' and doc_no<>'"+docno+"'";
				System.out.println("testsql,,,,,,llll"+testSql);
				ResultSet resultSet1 = stmtTest.executeQuery (testSql);
				if(resultSet1.next()){
					stmtTest.close();
					conn.close();
					return -1;
				}
			
				CallableStatement stmttax = conn.prepareCall("{CALL taxMasterDML(?,?,?,?,?,?,?)}");
				stmttax.setString(1,tax);
				stmttax.setString(2,taxdesc);
				stmttax.setDate(3,sqlStartDate);
				stmttax.setString(4,session.getAttribute("BRANCHID").toString());
				//stmttax.setString(5,session.getAttribute("USERID").toString());
				stmttax.setInt(5, docno);
				stmttax.setString(6,"E");
				stmttax.setString(7, formdetailcode);
				stmttax.executeUpdate();
				int aaa=stmttax.getInt("docNo");
//				System.out.println(aaa);
				
				if (aaa > 0) {
//					System.out.println("Sucess");
					conn.commit();
					

					stmttax.close();
					conn.close();
					return aaa;
				}

				stmttax.close();
				

				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return 0;
		}


		public int delete(int docno, HttpSession session,String tax,String formdetailcode) throws SQLException {
			Connection conn=ClsConnection.getMyConnection();
			try{
				
				conn.setAutoCommit(false);
				CallableStatement stmttax = conn.prepareCall("{CALL taxMasterDML(?,?,?,?,?,?,?)}");
				stmttax.setString(1,null);
				stmttax.setString(2,null);
				stmttax.setDate(3,null);
				stmttax.setString(4,session.getAttribute("BRANCHID").toString());
				//stmttax.setString(5,session.getAttribute("USERID").toString());
				stmttax.setInt(5, docno);
				stmttax.setString(6,"D");
				stmttax.setString(7, formdetailcode);
				stmttax.executeUpdate();
				int aaa=stmttax.getInt("docNo");
				
				if (aaa > 0) {
//					System.out.println("Sucess");
					conn.commit();
					stmttax.close();
					

					conn.close();
					return aaa;
				}

				stmttax.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return 0;
		}

		

	}

