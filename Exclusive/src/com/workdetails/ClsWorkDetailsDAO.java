package com.workdetails;

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

public class ClsWorkDetailsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsWorkDetailsBean workDetailsBean = new ClsWorkDetailsBean();
	
	public int insert(Date date, String formdetailcode, String cmbproject,String txtempname, String cmbcorrectiontype, String cmbformtype,String txtformname, 
			Date startDate, Date endDate,String txtdetail, HttpSession session, String mode) throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtEWD = conn.prepareCall("{CALL GWEmpWorkDetailsDML(?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtEWD.registerOutParameter(10, java.sql.Types.INTEGER);
				stmtEWD.setDate(1,date);
				stmtEWD.setString(2,cmbproject);
				stmtEWD.setString(3,txtempname);
				stmtEWD.setString(4,cmbcorrectiontype);
				stmtEWD.setString(5,cmbformtype);
				stmtEWD.setString(6,txtformname);
				stmtEWD.setDate(7,startDate);
				stmtEWD.setDate(8,endDate);
				stmtEWD.setString(9,txtdetail);
				stmtEWD.setString(11,mode);
				int datas=stmtEWD.executeUpdate();
				if(datas<=0){
					stmtEWD.close();
					conn.close();
					return 0;
				}
				int docno=stmtEWD.getInt("docNo");
				
				workDetailsBean.setTxtworkdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtEWD.close();
						conn.close();
						return docno;
				}
			stmtEWD.close();
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

	public boolean edit(int txtworkdetailsdocno, Date date,String formdetailcode, String cmbproject, String txtempname,String cmbcorrectiontype, String cmbformtype, 
			String txtformname,Date startDate, Date endDate, String txtdetail,HttpSession session, String mode) throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtEWD = conn.prepareCall("{CALL GWEmpWorkDetailsDML(?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtEWD.setInt(10, txtworkdetailsdocno);
				stmtEWD.setDate(1,date);
				stmtEWD.setString(2,cmbproject);
				stmtEWD.setString(3,txtempname);
				stmtEWD.setString(4,cmbcorrectiontype);
				stmtEWD.setString(5,cmbformtype);
				stmtEWD.setString(6,txtformname);
				stmtEWD.setDate(7,startDate);
				stmtEWD.setDate(8,endDate);
				stmtEWD.setString(9,txtdetail);
				stmtEWD.setString(11,mode);
				int datas=stmtEWD.executeUpdate();
				if(datas<=0){
					stmtEWD.close();
					conn.close();
					return false;
				}
				int docno=stmtEWD.getInt("docNo");
				
				workDetailsBean.setTxtworkdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtEWD.close();
						conn.close();
						return true;
				}
			stmtEWD.close();
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

	public boolean delete(int txtworkdetailsdocno, String formdetailcode,String mode,HttpSession session) throws SQLException {
		
		 Connection conn = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				CallableStatement stmtEWD = conn.prepareCall("{CALL GWEmpWorkDetailsDML(?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtEWD.setInt(10, txtworkdetailsdocno);
				stmtEWD.setDate(1,null);
				stmtEWD.setString(2,"0");
				stmtEWD.setString(3,null);
				stmtEWD.setString(4,"0");
				stmtEWD.setString(5,"0");
				stmtEWD.setString(6,null);
				stmtEWD.setDate(7,null);
				stmtEWD.setDate(8,null);
				stmtEWD.setString(9,null);
				stmtEWD.setString(11,mode);
				int datas=stmtEWD.executeUpdate();
				if(datas<=0){
					stmtEWD.close();
					conn.close();
					return false;
				}
				int docno=stmtEWD.getInt("docNo");
				
				workDetailsBean.setTxtworkdetailsdocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtEWD.close();
						conn.close();
						return true;
				}
			stmtEWD.close();
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
					Statement stmtEWD = conn.createStatement();
					String sql="";
					
					if(formType.equalsIgnoreCase("1")){
					   sql="select doc_type,menu_name,mno as menu_id from my_menu"+project+" where mno not in (select pmenu from my_menu"+project+") and gate='E'";
					}else if(formType.equalsIgnoreCase("2")){
					   sql="select d.description as menu_name,m.description as doc_type,CONVERT(coalesce(d.doc_No,''),char(15)) as menu_id from gl_bibm"+project+" m "
					   		+ "inner join gl_bibd"+project+" d on(m.doc_no=d.rdocno) where m.status=1 and d.status=1 order by d.rdocno,d.srno";
					}
					
					ResultSet resultSet = stmtEWD.executeQuery(sql) ;
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtEWD.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
		}
	
	public  JSONArray empNameLoading(String project) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEWD = conn.createStatement();
            	
				String sql= ("select name,doc_no from gw_employee where status=1 and project="+project+"");
				
				ResultSet resultSet = stmtEWD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEWD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public  JSONArray ewdMainSearch(String docNo,String date,String formname,String empname) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
       
        java.sql.Date sqlWorkDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlWorkDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
        }
        if(!(formname.equalsIgnoreCase(""))){
         sqltest=sqltest+" and form_name like '%"+formname+"%'";
        }
        if(!(empname.equalsIgnoreCase(""))){
         sqltest=sqltest+" and emp_name like '%"+empname+"%'";
        }
        if(!(sqlWorkDate==null)){
	         sqltest=sqltest+" and date='"+sqlWorkDate+"'";
	    } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtEWD = conn.createStatement();
	       
	       ResultSet resultSet = stmtEWD.executeQuery("select doc_no,date,form_name,emp_name,if(correction_type='1','New Form',if(correction_type='2','Modification',"
	       		+ "if(correction_type='3','Correction','checked'))) correction_type from gw_empworkdetails where status=3" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtEWD.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsWorkDetailsBean getViewDetails(int docNo) throws SQLException {
		
		ClsWorkDetailsBean workDetailsBean = new ClsWorkDetailsBean();
		
		Connection conn = null;
		
		try {
		
			conn = ClsConnection.getMyConnection();
			Statement stmtEWD = conn.createStatement();
		
			ResultSet resultSet = stmtEWD.executeQuery ("select date,correction_type,form_name,emp_name,detail,start_date,end_date,form_type,project from "
					+ "gw_empworkdetails where doc_no="+docNo+"");
	
			while (resultSet.next()) {
				workDetailsBean.setTxtworkdetailsdocno(docNo);
				workDetailsBean.setWorkDetailsDate(resultSet.getDate("date").toString());
				workDetailsBean.setHidcmbproject(resultSet.getString("project"));
				workDetailsBean.setTxtempname(resultSet.getString("emp_name"));
				workDetailsBean.setHidcmbcorrectiontype(resultSet.getString("correction_type"));
				workDetailsBean.setHidcmbformtype(resultSet.getString("form_type"));
				workDetailsBean.setTxtformname(resultSet.getString("form_name"));
				workDetailsBean.setStartDate(resultSet.getDate("start_date").toString());
				workDetailsBean.setEndDate(resultSet.getDate("end_date").toString());
				workDetailsBean.setTxtdetail(resultSet.getString("detail"));
				
		    }
		  stmtEWD.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return workDetailsBean;
		}
	 
}
