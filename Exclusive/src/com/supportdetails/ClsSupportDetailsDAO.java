package com.supportdetails;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSupportDetailsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsSupportDetailsBean supportDetailsBean = new ClsSupportDetailsBean();
	
	public int insert(Date date, String formdetailcode, String issueTime, String cmbcompany, int txtuserid, String cmbissuecategory, String txtissuedescription, 
			int txtempid, String txtremarks, int txtsupportid, String cmbstatus, HttpSession session, String mode)  throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtESD = conn.prepareCall("{CALL GWSupportDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtESD.registerOutParameter(11, java.sql.Types.INTEGER);
				stmtESD.setDate(1,date);
				stmtESD.setString(2,issueTime);
				stmtESD.setString(3,cmbcompany);
				stmtESD.setInt(4,txtuserid);
				stmtESD.setString(5,cmbissuecategory);
				stmtESD.setString(6,txtissuedescription);
				stmtESD.setInt(7,txtempid);
				stmtESD.setString(8,txtremarks);
				stmtESD.setInt(9,txtsupportid);
				stmtESD.setString(10,cmbstatus);
				stmtESD.setString(12,mode);
				int datas=stmtESD.executeUpdate();
				if(datas<=0){
					stmtESD.close();
					conn.close();
					return 0;
				}
				int docno=stmtESD.getInt("docNo");
				
				supportDetailsBean.setTxtsupportdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtESD.close();
						conn.close();
						return docno;
				}
			stmtESD.close();
			conn.close();
		 }catch(Exception e){
			conn.close();
		 	e.printStackTrace();	
		 	return 0;
		 }finally{
				conn.close();
			}
		return 0;
	}

	public boolean edit(int txtsupportdetailsdocno, Date date, String formdetailcode, String issueTime, String cmbcompany, int txtuserid, String cmbissuecategory, 
			String txtissuedescription, int txtempid, String txtremarks, int txtsupportid, String cmbstatus, HttpSession session, String mode) throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtESD = conn.prepareCall("{CALL GWSupportDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtESD.setInt(11, txtsupportdetailsdocno);
				stmtESD.setDate(1,date);
				stmtESD.setString(2,issueTime);
				stmtESD.setString(3,cmbcompany);
				stmtESD.setInt(4,txtuserid);
				stmtESD.setString(5,cmbissuecategory);
				stmtESD.setString(6,txtissuedescription);
				stmtESD.setInt(7,txtempid);
				stmtESD.setString(8,txtremarks);
				stmtESD.setInt(9,txtsupportid);
				stmtESD.setString(10,cmbstatus);
				stmtESD.setString(12,mode);
				int datas=stmtESD.executeUpdate();
				if(datas<=0){
					stmtESD.close();
					conn.close();
					return false;
				}
				int docno=stmtESD.getInt("docNo");
				
				supportDetailsBean.setTxtsupportdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtESD.close();
						conn.close();
						return true;
				}
			stmtESD.close();
			conn.close();
		 }catch(Exception e){
			conn.close();
		 	e.printStackTrace();	
		 	return false;
		 }finally{
				conn.close();
			}
		return false;
	}

	public boolean delete(int txtsupportdetailsdocno, String formdetailcode,String mode,HttpSession session) throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtESD = conn.prepareCall("{CALL GWSupportDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtESD.setInt(11, txtsupportdetailsdocno);
				stmtESD.setDate(1,null);
				stmtESD.setString(2,null);
				stmtESD.setString(3,"0");
				stmtESD.setInt(4,0);
				stmtESD.setString(5,"0");
				stmtESD.setString(6,null);
				stmtESD.setInt(7,0);
				stmtESD.setString(8,null);
				stmtESD.setInt(9,0);
				stmtESD.setString(10,"0");
				stmtESD.setString(12,mode);
				int datas=stmtESD.executeUpdate();
				if(datas<=0){
					stmtESD.close();
					conn.close();
					return false;
				}
				int docno=stmtESD.getInt("docNo");
				
				supportDetailsBean.setTxtsupportdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtESD.close();
						conn.close();
						return true;
				}
			stmtESD.close();
			conn.close();
		 }catch(Exception e){
			conn.close();
		 	e.printStackTrace();	
		 	return false;
		 }finally{
				conn.close();
			}
		return false;
	}  

	
	public  JSONArray formNameLoading(String formType,String project) throws SQLException{
			
			JSONArray RESULTDATA=new JSONArray();
	    	
	   	    Connection conn = null;
	   	    
	  			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtESD = conn.createStatement();
					String sql="";
					
					if(formType.equalsIgnoreCase("1")){
					   sql="select doc_type,menu_name,mno as menu_id from my_menu"+project+" where mno not in (select pmenu from my_menu"+project+") and gate='E'";
					}else if(formType.equalsIgnoreCase("2")){
					   sql="select d.description as menu_name,m.description as doc_type,CONVERT(coalesce(d.doc_No,''),char(15)) as menu_id from gl_bibm"+project+" m "
					   		+ "inner join gl_bibd"+project+" d on(m.doc_no=d.rdocno) where m.status=1 and d.status=1 order by d.rdocno,d.srno";
					}
					
					ResultSet resultSet = stmtESD.executeQuery(sql) ;
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtESD.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
		}
	
	public  JSONArray UserNameLoading(String company) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
            	
				String sql= ("select concat(upper(user_name)) as user,doc_no from gw_userlist where status=3 and comp_id="+company);
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}

public  JSONArray empNameLoading() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
            	
				String sql= ("select name,doc_no from gw_employee where status=1 and project=1");
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}

	public  JSONArray supportNameLoading() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		
		    Connection conn = null;
		    
				try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
	        	
				String sql= ("select name,doc_no from gw_employee where status=1 and project=0");
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public  JSONArray esdMainSearch(String docNo,String date,String issuedstatus,String companyname,String issuedtime,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
       
        java.sql.Date sqlIssueDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlIssueDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase("") || docNo.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and s.doc_no like '%"+docNo+"%'";
        }
        if(!(issuedstatus.equalsIgnoreCase("") || issuedstatus.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and s.issue_status='"+issuedstatus+"'";
        }
        if(!(companyname.equalsIgnoreCase("") || companyname.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and s.company='"+companyname+"'";
        }
        if(!(issuedtime==null || issuedtime.equalsIgnoreCase("undefined"))){
	         sqltest=sqltest+" and s.time='"+issuedtime+"'";
	    } 
        if(!(sqlIssueDate==null)){
	         sqltest=sqltest+" and s.date='"+sqlIssueDate+"'";
	    } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtESD = conn.createStatement();
	       
	       if(check.equalsIgnoreCase("1")){
	    	   
		       ResultSet resultSet = stmtESD.executeQuery("select s.doc_no,s.date,s.time,concat(upper(c.comp_code)) company,ic.type issue_category,"
		       		+ "if(s.issue_status='1','OPEN',if(s.issue_status='2','PENDING','CLOSED')) issue_status from gw_supportdetails s left join gw_complist c "
		       		+ "on s.company=c.doc_no left join gw_issuecategory ic on s.issue_category=ic.doc_no where s.status=3" +sqltest);
		
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       }
	       
	       stmtESD.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsSupportDetailsBean getViewDetails(int docNo) throws SQLException {
		
		ClsSupportDetailsBean supportDetailsBean = new ClsSupportDetailsBean();
		
		Connection conn = null;
		
		try {
		
			conn = ClsConnection.getMyConnection();
			Statement stmtESD = conn.createStatement();
		
			ResultSet resultSet = stmtESD.executeQuery ("select s.date,s.time,s.company,s.comp_userid,s.issue_category,s.issue_description,s.action_taken,s.remarks,"
					+ "s.issue_status,if(close_supportid is null,s.open_supportId,s.close_supportId) supportid,concat(upper(c.comp_code)) companycode,"
					+ "concat(upper(u.user_name)) as user,e.name actionname,if(close_supportid is null,e1.name,e2.name) supportname from gw_supportdetails s left join "
					+ "gw_complist c on s.company=c.doc_no left join gw_userlist u on s.comp_userid=u.doc_no left join gw_employee e on s.action_taken=e.doc_no left join "
					+ "gw_employee e1 on s.open_supportid=e1.doc_no left join gw_employee e2 on s.close_supportid=e2.doc_no where s.status=3 and s.doc_no="+docNo+"");
	
			while (resultSet.next()) {
				
				supportDetailsBean.setTxtsupportdetailsdocno(docNo);
				supportDetailsBean.setIssueDate(resultSet.getDate("date").toString());
				supportDetailsBean.setIssueTime(resultSet.getString("time"));
				supportDetailsBean.setHidcmbcompany(resultSet.getString("company"));
				supportDetailsBean.setTxtuserid(resultSet.getInt("comp_userid"));
				supportDetailsBean.setTxtusername(resultSet.getString("user"));
				supportDetailsBean.setHidcmbissuecategory(resultSet.getString("issue_category"));
				supportDetailsBean.setTxtissuedescription(resultSet.getString("issue_description"));
				supportDetailsBean.setTxtempid(resultSet.getInt("action_taken"));
				supportDetailsBean.setTxtempname(resultSet.getString("actionname"));
				supportDetailsBean.setTxtremarks(resultSet.getString("remarks"));
				supportDetailsBean.setTxtsupportid(resultSet.getInt("supportid"));
				supportDetailsBean.setTxtsupportname(resultSet.getString("supportname"));
				supportDetailsBean.setHidcmbstatus(resultSet.getString("issue_status"));
				
		    }
		  stmtESD.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return supportDetailsBean;
		}
	 
}
