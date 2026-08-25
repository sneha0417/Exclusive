package com.gwinternal.operations.changesdone;

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

public class ClsChangesDoneDAO {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsChangesDoneBean changesDoneBean = new ClsChangesDoneBean();
	Connection conn = null;
	
	public int insert(String formdetailcode, Date changesDoneDates, String cmbproject, String txtchangedformname, String txtchangedformpath, String txtchangedformquery, String txtchangedformfiles, String txtchangedformdescription,
			HttpSession session, String mode) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			int docno;
			   
			CallableStatement stmtCHNG = conn.prepareCall("{CALL GWChangesDoneDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCHNG.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtCHNG.setDate(1,changesDoneDates);
			stmtCHNG.setString(2,cmbproject);
			stmtCHNG.setString(3,txtchangedformname);
			stmtCHNG.setString(4,txtchangedformpath);
			stmtCHNG.setString(5,txtchangedformquery);
			stmtCHNG.setString(6,txtchangedformfiles);
			stmtCHNG.setString(7,txtchangedformdescription);
			stmtCHNG.setString(8,formdetailcode);
			stmtCHNG.setString(9,branch);
			stmtCHNG.setString(10,userid);
			stmtCHNG.setString(12,mode);
			stmtCHNG.executeQuery();
			docno=stmtCHNG.getInt("docNo");
			
			changesDoneBean.setTxtchangesdonedocno(docno);
			if (docno > 0) {
				stmtCHNG.close();
				conn.close();
				return docno;
			}
		 stmtCHNG.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}
	
	public int edit(String formdetailcode, Date changesDoneDates, int txtchangesdonedocno, String cmbproject, String txtchangedformname, String txtchangedformpath, String txtchangedformquery, String txtchangedformfiles, String txtchangedformdescription, 
			HttpSession session, String mode) throws SQLException {
		
		try{
		     conn=connDAO.getMyConnection();
		    
			 String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
			
			 CallableStatement stmtCHNG = conn.prepareCall("{CALL GWChangesDoneDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
			 stmtCHNG.setInt(11, txtchangesdonedocno);
			 stmtCHNG.setDate(1,changesDoneDates);
			 stmtCHNG.setString(2,cmbproject);
			 stmtCHNG.setString(3,txtchangedformname);
			 stmtCHNG.setString(4,txtchangedformpath);
			 stmtCHNG.setString(5,txtchangedformquery);
			 stmtCHNG.setString(6,txtchangedformfiles);
			 stmtCHNG.setString(7,txtchangedformdescription);
			 stmtCHNG.setString(8,formdetailcode);
			 stmtCHNG.setString(9,branch);
			 stmtCHNG.setString(10,userid);
			 stmtCHNG.setString(12,mode);
			 stmtCHNG.executeQuery();
			 int docno=stmtCHNG.getInt("docNo");
			
			changesDoneBean.setTxtchangesdonedocno(docno);
			if (docno > 0) {
				stmtCHNG.close();
				conn.close();
				return 1;
		    }
		stmtCHNG.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

	public boolean delete(int txtchangesdonedocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		
		try{
			
			conn=connDAO.getMyConnection();
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			CallableStatement stmtCHNG = conn.prepareCall("{CALL GWChangesDoneDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCHNG.setInt(11, txtchangesdonedocno);
			stmtCHNG.setDate(1,null);
			stmtCHNG.setString(2,null);
			stmtCHNG.setString(3,null);
			stmtCHNG.setString(4,null);
			stmtCHNG.setString(5,null);
			stmtCHNG.setString(6,null);
			stmtCHNG.setString(7,null);
			stmtCHNG.setString(8,formdetailcode);
			stmtCHNG.setString(9,branch);
			stmtCHNG.setString(10,userid);
			stmtCHNG.setString(12,mode);
			stmtCHNG.executeQuery();
			int docno=stmtCHNG.getInt("docNo");
			
			changesDoneBean.setTxtchangesdonedocno(docno);
			if (docno > 0) {
				stmtCHNG.close();
				conn.close();
				return true;
			}
		  stmtCHNG.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return false;
	}
	
	public ClsChangesDoneBean getViewDetails(int docNo) throws SQLException {
		
		   ClsChangesDoneBean changesDoneBean = new ClsChangesDoneBean();
			
			Connection conn = null;
			
			try {
			
				conn = connDAO.getMyConnection();
				Statement stmtCHNG = conn.createStatement();

				String sql= ("SELECT m.date, m.projectid, m.form_name, m.files_tobecopied, m.file_path, m.query_file, m.description FROM gw_changesdone m WHERE m.status=3 and m.DOC_NO="+docNo);
	           
				ResultSet resultSet = stmtCHNG.executeQuery(sql);
							
				while (resultSet.next()) {
					changesDoneBean.setChangesDoneDate(resultSet.getDate("date").toString());
					changesDoneBean.setHidcmbproject(resultSet.getString("projectid"));
					changesDoneBean.setTxtchangesdonedocno(docNo);
					changesDoneBean.setTxtchangedformname(resultSet.getString("form_name"));
					changesDoneBean.setTxtchangedformpath(resultSet.getString("file_path"));
					changesDoneBean.setTxtchangedformquery(resultSet.getString("query_file"));
					changesDoneBean.setTxtchangedformfiles(resultSet.getString("files_tobecopied"));
					changesDoneBean.setTxtchangedformdescription(resultSet.getString("description"));
			        }
				stmtCHNG.close();
				conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		 return changesDoneBean;
		}

	public JSONArray chngMainSearch(HttpSession session,String docNo,String date,String forms,String projects,String description,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
           
        Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
           String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlChangedDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtCHNG = conn.createStatement();
	       
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlChangedDate = commonDAO.changeStringtoSqlDate(date);
	        }
	        
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(sqlChangedDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlChangedDate+"'";
		    } 
	        if(!(forms.equalsIgnoreCase("")) && !(forms.equalsIgnoreCase("0"))){
	         sqltest=sqltest+" and m.form_name like '%"+forms+"%'";
	        }
	        if(!(projects.equalsIgnoreCase("")) && !(projects.equalsIgnoreCase("0"))){
		         sqltest=sqltest+" and p.name like '%"+projects+"%'";
		    }
	        if(!(description.equalsIgnoreCase("")) && !(description.equalsIgnoreCase("0"))){
		         sqltest=sqltest+" and m.description like '%"+description+"%'";
		    }
	         
	       ResultSet resultSet = stmtCHNG.executeQuery("select m.doc_no, m.date, p.name projects,m.form_name, m.description,e.user_name employee from gw_changesdone m left join gw_projects p on (m.projectid=p.doc_no and p.status=1) "  
	       		+ "left join my_user e on e.doc_no=m.userid where m.status<>7" +sqltest);

	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtCHNG.close();
	       conn.close();
     }
     catch(Exception e){
    	 	e.printStackTrace();
    	 	conn.close();
     }
       return RESULTDATA;
   }

}
