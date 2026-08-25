package com.controlcentre.masters.floormaster.floor;

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

	public class ClsFloorDAO {
	    ClsFloorBean floorBean=new ClsFloorBean();
	    
		Connection conn = null;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String formdetailcode,Date floorMasterDate, String txtfloorcode, String txtfloorname, HttpSession session, String mode) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				Statement stmtFLR1 = conn.createStatement();
				
				String branch = session.getAttribute("BRANCHID").toString();
				String userid = session.getAttribute("USERID").toString();
				int docno;
				
			   String sqls="select * from my_floor where code='"+txtfloorcode+"' and status<>7";
			   ResultSet resultSet1 = stmtFLR1.executeQuery(sqls);
			   
			   while (resultSet1.next()) {
			        return -1;
			    }
				   
				CallableStatement stmtFLR = conn.prepareCall("{CALL floorMasterDML(?,?,?,?,?,?,?,?)}");
				
				stmtFLR.registerOutParameter(7, java.sql.Types.INTEGER);
				stmtFLR.setDate(1,floorMasterDate);
				stmtFLR.setString(2,txtfloorcode);
				stmtFLR.setString(3,txtfloorname);
				stmtFLR.setString(4,formdetailcode);
				stmtFLR.setString(5,branch);
				stmtFLR.setString(6,userid);
				stmtFLR.setString(8,mode);
				stmtFLR.executeQuery();
				docno=stmtFLR.getInt("docNo");
				
				floorBean.setTxtfloordocno(docno);
				if (docno > 0) {
					stmtFLR.close();
					conn.close();
					return docno;
				}
			 stmtFLR.close();
			 conn.close();
			}catch(Exception e){	
			   e.printStackTrace();
			   conn.close();
			}finally{
				conn.close();
			}
			return 0;
		}

		public int edit(int txtfloordocno, String formdetailcode, Date floorMasterDate, String txtfloorcode, String txtfloorname, HttpSession session, String mode) throws SQLException {
			try{
			     conn=ClsConnection.getMyConnection();
			     Statement stmtFLR1 = conn.createStatement();
			    
			     String branch = session.getAttribute("BRANCHID").toString();
				 String userid = session.getAttribute("USERID").toString();
					
			     String sql="select * from my_floor where code='"+txtfloorcode+"' and status<>7 and doc_no!="+txtfloordocno+"";
			     ResultSet resultSet1 = stmtFLR1.executeQuery(sql);
			   
			     while (resultSet1.next()) {
			        return -1;
			     }
				   
				CallableStatement stmtFLR = conn.prepareCall("{CALL floorMasterDML(?,?,?,?,?,?,?,?)}");
				
				stmtFLR.setInt(7, txtfloordocno);
				stmtFLR.setDate(1,floorMasterDate);
				stmtFLR.setString(2,txtfloorcode);
				stmtFLR.setString(3,txtfloorname);
				stmtFLR.setString(4,formdetailcode);
				stmtFLR.setString(5,branch);
				stmtFLR.setString(6,userid);
				stmtFLR.setString(8,mode);
				stmtFLR.executeQuery();
				int docno=stmtFLR.getInt("docNo");
				
				floorBean.setTxtfloordocno(docno);
				if (docno > 0) {
					stmtFLR.close();
					conn.close();
					return 1;
			    }
			stmtFLR.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return 0;
		}

		public int delete(int txtfloordocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				
				String branch = session.getAttribute("BRANCHID").toString();
				String userid = session.getAttribute("USERID").toString();
				
				CallableStatement stmtFLR = conn.prepareCall("{CALL floorMasterDML(?,?,?,?,?,?,?,?)}");

				stmtFLR.setInt(7, txtfloordocno);
				stmtFLR.setDate(1,null);
				stmtFLR.setString(2,null);
				stmtFLR.setString(3,null);
				stmtFLR.setString(4,formdetailcode);
				stmtFLR.setString(5,branch);
				stmtFLR.setString(6,userid);
				stmtFLR.setString(8,mode);
				stmtFLR.executeQuery();
				int docno=stmtFLR.getInt("docNo");
				
				floorBean.setTxtfloordocno(docno);
				if (docno > 0) {
					stmtFLR.close();
					conn.close();
					return 1;
				}
			  stmtFLR.close();
			  conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return 0;
		}
		
		public   JSONArray flrMainSearch(String code,String name) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	           
		     try {
			       conn = ClsConnection.getMyConnection();
			       Statement stmtFLR = conn.createStatement();
			       
			       String sqltest="";
			        
			       if(!(code.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and code like '%"+code+"%'";
			       }
			       
			       if(!(name.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and name like '%"+name+"%'";
			       }
			        
			       ResultSet resultSet = stmtFLR.executeQuery("select doc_no,date,code,name from my_floor where status<>7" +sqltest);
			
			       RESULTDATA=ClsCommon.convertToJSON(resultSet);
			       
			       stmtFLR.close();
			       conn.close();
		     }catch(Exception e){
		    	 e.printStackTrace();
		    	 conn.close();
		     }finally{
		 		conn.close();
		 	}
	       return RESULTDATA;
	   }

}
