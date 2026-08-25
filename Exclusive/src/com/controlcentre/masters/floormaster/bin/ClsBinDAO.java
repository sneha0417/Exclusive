package com.controlcentre.masters.floormaster.bin;

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

public class ClsBinDAO {
	ClsBinBean binBean=new ClsBinBean();
    
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public int insert(String formdetailcode,Date binMasterDate, String txtfloorcode, String txtrackcode, String txtbincode, String txtbinname, HttpSession session, String mode) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();
			Statement stmtBIN1 = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			int docno;
			
		   String sqls="select * from my_flbin where fl_id='"+txtfloorcode+"' and rck_id='"+txtrackcode+"' and code='"+txtbincode+"' and status<>7";
		   ResultSet resultSet1 = stmtBIN1.executeQuery(sqls);
		   
		   while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtBIN = conn.prepareCall("{CALL binMasterDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtBIN.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtBIN.setDate(1,binMasterDate);
			stmtBIN.setString(2,txtfloorcode);
			stmtBIN.setString(3,txtrackcode);
			stmtBIN.setString(4,txtbincode);
			stmtBIN.setString(5,txtbinname);
			stmtBIN.setString(6,formdetailcode);
			stmtBIN.setString(7,branch);
			stmtBIN.setString(8,userid);
			stmtBIN.setString(10,mode);
			stmtBIN.executeQuery();
			docno=stmtBIN.getInt("docNo");
			
			binBean.setTxtbindocno(docno);
			if (docno > 0) {
				stmtBIN.close();
				conn.close();
				return docno;
			}
		 stmtBIN.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}

	public int edit(int txtbindocno, String formdetailcode, Date binMasterDate, String txtfloorcode, String txtrackcode, String txtbincode, String txtbinname, HttpSession session, String mode) throws SQLException {
		try{
		     conn=ClsConnection.getMyConnection();
		     Statement stmtBIN1 = conn.createStatement();
		    
		     String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
				
		     String sql="select * from my_flbin where fl_id='"+txtfloorcode+"' and rck_id='"+txtrackcode+"' and code='"+txtbincode+"' and status<>7 and doc_no!="+txtbindocno+"";
		     ResultSet resultSet1 = stmtBIN1.executeQuery(sql);
		   
		     while (resultSet1.next()) {
		        return -1;
		     }
			   
		    CallableStatement stmtBIN = conn.prepareCall("{CALL binMasterDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtBIN.setInt(9, txtbindocno);
			stmtBIN.setDate(1,binMasterDate);
			stmtBIN.setString(2,txtfloorcode);
			stmtBIN.setString(3,txtrackcode);
			stmtBIN.setString(4,txtbincode);
			stmtBIN.setString(5,txtbinname);
			stmtBIN.setString(6,formdetailcode);
			stmtBIN.setString(7,branch);
			stmtBIN.setString(8,userid);
			stmtBIN.setString(10,mode);
			stmtBIN.executeQuery();
			int docno=stmtBIN.getInt("docNo");
			binBean.setTxtbindocno(docno);
			if (docno > 0) {
				stmtBIN.close();
				conn.close();
				return 1;
		    }
		stmtBIN.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

	public int delete(int txtbindocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			CallableStatement stmtBIN = conn.prepareCall("{CALL binMasterDML(?,?,?,?,?,?,?,?,?,?)}");

			stmtBIN.setInt(9,txtbindocno);
			stmtBIN.setDate(1,null);
			stmtBIN.setString(2,null);
			stmtBIN.setString(3,null);
			stmtBIN.setString(4,null);
			stmtBIN.setString(5,null);
			stmtBIN.setString(6,formdetailcode);
			stmtBIN.setString(7,branch);
			stmtBIN.setString(8,userid);
			stmtBIN.setString(10,mode);
			stmtBIN.executeQuery();
			int docno=stmtBIN.getInt("docNo");
			
			binBean.setTxtbindocno(docno);
			if (docno > 0) {
				stmtBIN.close();
				conn.close();
				return 1;
			}
		  stmtBIN.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}

public JSONArray rackDetailsSearch(String rackname,String rackcode,String check) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
		
    try {
		conn = ClsConnection.getMyConnection();
		Statement stmtBIN = conn.createStatement();
		String sql = "";
		
		if(!((rackcode.equalsIgnoreCase("")) || (rackcode.equalsIgnoreCase("0")))){
             sql=sql+" and r.code like '%"+rackcode+"%'";
        }
		
		if(!((rackname.equalsIgnoreCase("")) || (rackname.equalsIgnoreCase("0")))){
            sql=sql+" and r.name like '%"+rackname+"%'";
        }
        
		sql="select r.doc_no,r.date,r.code,r.name,r.fl_id,f.name flname from my_flrack r left join my_floor f on r.fl_id=f.doc_no where r.status=3"+sql+"";
		
		if(check.equalsIgnoreCase("1")){
			ResultSet resultSet = stmtBIN.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}else{
			stmtBIN.close();
			conn.close();
			return RESULTDATA;
		}
		
		stmtBIN.close();
		conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
    return RESULTDATA;
   }
	
public   JSONArray binMainSearch(String code,String name) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
       
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtBIN = conn.createStatement();
	       
	       String sqltest="";
	        
	       if(!(code.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and b.code like '%"+code+"%'";
	       }
	       
	       if(!(name.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and b.name like '%"+name+"%'";
	       }
	        
	       ResultSet resultSet = stmtBIN.executeQuery("select b.doc_no,b.date,b.code,b.name,b.fl_id,b.rck_id,f.name flname,r.name rckname from my_flbin b "  
	       		+ "left join my_floor f on b.fl_id=f.doc_no left join my_flrack r on b.rck_id=r.doc_no where b.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtBIN.close();
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
