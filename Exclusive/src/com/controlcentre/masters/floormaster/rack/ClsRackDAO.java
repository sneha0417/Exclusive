package com.controlcentre.masters.floormaster.rack;

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

public class ClsRackDAO {
	ClsRackBean rackBean=new ClsRackBean();
    
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(String formdetailcode,Date floorMasterDate, String txtfloorcode, String txtrackcode, String txtrackname, HttpSession session, String mode) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();
			Statement stmtRCK1 = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			int docno;
			
		   String sqls="select * from my_flrack where fl_id='"+txtfloorcode+"' and code='"+txtrackcode+"' and status<>7";
		   ResultSet resultSet1 = stmtRCK1.executeQuery(sqls);
		   
		   while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtRCK = conn.prepareCall("{CALL rackMasterDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtRCK.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtRCK.setDate(1,floorMasterDate);
			stmtRCK.setString(2,txtfloorcode);
			stmtRCK.setString(3,txtrackcode);
			stmtRCK.setString(4,txtrackname);
			stmtRCK.setString(5,formdetailcode);
			stmtRCK.setString(6,branch);
			stmtRCK.setString(7,userid);
			stmtRCK.setString(9,mode);
			stmtRCK.executeQuery();
			docno=stmtRCK.getInt("docNo");
			
			rackBean.setTxtrackdocno(docno);
			if (docno > 0) {
				stmtRCK.close();
				conn.close();
				return docno;
			}
		 stmtRCK.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}

	public int edit(int txtfloordocno, String formdetailcode, Date floorMasterDate, String txtfloorcode, String txtrackcode, String txtrackname, HttpSession session, String mode) throws SQLException {
		try{
		     conn=ClsConnection.getMyConnection();
		     Statement stmtRCK1 = conn.createStatement();
		    
		     String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
				
		     String sql="select * from my_flrack where fl_id='"+txtfloorcode+"' and code='"+txtrackcode+"' and status<>7 and doc_no!="+txtfloordocno+"";
		     ResultSet resultSet1 = stmtRCK1.executeQuery(sql);
		   
		     while (resultSet1.next()) {
		        return -1;
		     }
			   
		    CallableStatement stmtRCK = conn.prepareCall("{CALL rackMasterDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtRCK.setInt(8, txtfloordocno);
			stmtRCK.setDate(1,floorMasterDate);
			stmtRCK.setString(2,txtfloorcode);
			stmtRCK.setString(3,txtrackcode);
			stmtRCK.setString(4,txtrackname);
			stmtRCK.setString(5,formdetailcode);
			stmtRCK.setString(6,branch);
			stmtRCK.setString(7,userid);
			stmtRCK.setString(9,mode);
			stmtRCK.executeQuery();
			int docno=stmtRCK.getInt("docNo");
			
			rackBean.setTxtrackdocno(docno);
			if (docno > 0) {
				stmtRCK.close();
				conn.close();
				return 1;
		    }
		stmtRCK.close();
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
			
			CallableStatement stmtRCK = conn.prepareCall("{CALL rackMasterDML(?,?,?,?,?,?,?,?,?)}");

			stmtRCK.setInt(8, txtfloordocno);
			stmtRCK.setDate(1,null);
			stmtRCK.setString(2,null);
			stmtRCK.setString(3,null);
			stmtRCK.setString(4,null);
			stmtRCK.setString(5,formdetailcode);
			stmtRCK.setString(6,branch);
			stmtRCK.setString(7,userid);
			stmtRCK.setString(9,mode);
			stmtRCK.executeQuery();
			int docno=stmtRCK.getInt("docNo");
			
			rackBean.setTxtrackdocno(docno);
			if (docno > 0) {
				stmtRCK.close();
				conn.close();
				return 1;
			}
		  stmtRCK.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}
	
	public JSONArray floorDetailsSearch(String flname,String flcode,String check) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
		
    try {
		conn = ClsConnection.getMyConnection();
		Statement stmtRCK = conn.createStatement();
		String sql = "";
		
		if(!((flcode.equalsIgnoreCase("")) || (flcode.equalsIgnoreCase("0")))){
             sql=sql+" and code like '%"+flcode+"%'";
        }
		
		if(!((flname.equalsIgnoreCase("")) || (flname.equalsIgnoreCase("0")))){
            sql=sql+" and name like '%"+flname+"%'";
        }
        
		sql="select doc_no,code,name from my_floor where status=3"+sql+"";
		
		if(check.equalsIgnoreCase("1")){
			ResultSet resultSet = stmtRCK.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}else{
			stmtRCK.close();
			conn.close();
			return RESULTDATA;
		}
		
		stmtRCK.close();
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
	
	public   JSONArray racMainSearch(String code,String name) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtRCK = conn.createStatement();
		       
		       String sqltest="";
		        
		       if(!(code.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and r.code like '%"+code+"%'";
		       }
		       
		       if(!(name.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and r.name like '%"+name+"%'";
		       }
		        
		       ResultSet resultSet = stmtRCK.executeQuery("select r.doc_no,r.date,r.code,r.name,r.fl_id,f.name flname from my_flrack r left join my_floor f on "
		    		   + "r.fl_id=f.doc_no where r.status<>7" +sqltest);
		
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		       
		       stmtRCK.close();
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
