package com.cargo.transportmasters.terms;

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

import com.cargo.transportmasters.servicetype.ClsServiceTypeBean;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTermsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsTermsBean termsbean=new ClsTermsBean();
	Connection conn;
	
	public int insert( int docno,Date sqlTermsDate,String code,String name,String cmbmode,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtTerms = conn.prepareCall("{call cr_termsDML(?,?,?,?,?,?,?,?,?)}");


			stmtTerms.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtTerms.setString(1,code);
			stmtTerms.setDate(2, sqlTermsDate);
			stmtTerms.setString(3, cmbmode);
			stmtTerms.setString(4, name);
			stmtTerms.setString(5,session.getAttribute("USERID").toString());
			stmtTerms.setString(6,session.getAttribute("BRANCHID").toString());
			stmtTerms.setString(7, mode);
			stmtTerms.setString(8, formdetailcode);
			stmtTerms.executeQuery();
			
            System.out.println("cmbmode"+cmbmode);
			
			
			docno=stmtTerms.getInt("docNo");
			termsbean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtTerms.close();
		        return docno;
			}
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
	
	public int edit(int docno,Date sqlTermsDate,String code,String name,String cmbmode,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtTerms = conn.prepareCall("{call cr_termsDML(?,?,?,?,?,?,?,?,?)}");


			stmtTerms.setInt(9, docno);
			stmtTerms.setString(1,code);
			stmtTerms.setDate(2, sqlTermsDate);
			stmtTerms.setString(3, cmbmode);
			stmtTerms.setString(4, name);
			stmtTerms.setString(5,session.getAttribute("USERID").toString());
			stmtTerms.setString(6,session.getAttribute("BRANCHID").toString());
			stmtTerms.setString(7, mode);
			stmtTerms.setString(8, formdetailcode);
			stmtTerms.executeQuery();
			
            System.out.println("cmbmode"+cmbmode);
			
			
			docno=stmtTerms.getInt("docNo");
			termsbean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtTerms.close();
		        return docno;
			}
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
	public boolean delete(int docno,Date sqlTermsDate,String code,String name,String cmbmode,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtTerms = conn.prepareCall("{call cr_termsDML(?,?,?,?,?,?,?,?,?)}");


			stmtTerms.setInt(9, docno);
			stmtTerms.setString(1,null);
			stmtTerms.setDate(2, null);
			stmtTerms.setString(3, null);
			stmtTerms.setString(4, null);
			stmtTerms.setString(5,session.getAttribute("USERID").toString());
			stmtTerms.setString(6,session.getAttribute("BRANCHID").toString());
			stmtTerms.setString(7, mode);
			stmtTerms.setString(8, formdetailcode);
			System.out.println("stmtTerms ="+stmtTerms);
			stmtTerms.executeUpdate();
			
            System.out.println("cmbmode"+cmbmode);
			
			
			docno=stmtTerms.getInt("docNo");
			termsbean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtTerms.close();
				return true;
			}
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
	
	public  JSONArray getTermsGrid(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	        
				String strsql="SELECT m.doc_no,m.modeid,m.tcode,m.terms,m.date,mo.modename FROM cr_terms m "
                        + "left join cr_mode mo on mo.doc_no=m.modeid where m.status=3";
				System.out.println(strsql);
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
	
	public  List<ClsTermsBean> list() throws SQLException {
	    List<ClsTermsBean> listBean = new ArrayList<ClsTermsBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtTerms = conn.createStatement();
	        	
				ResultSet resultSet = stmtTerms.executeQuery ("SELECT m.doc_no,m.modeid,m.tcode,m.terms,m.date,mo.modename FROM cr_terms m left join cr_mode mo on mo.doc_no=m.modeid where m.status=3");
                System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsTermsBean bean = new ClsTermsBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setServicedate(resultSet.getString("date"));
	            	bean.setModeid(resultSet.getInt("modeid"));
	            	bean.setCmbmode(resultSet.getString("modename"));
	            	bean.setCode(resultSet.getString("tcode"));
	            	bean.setName(resultSet.getString("terms"));
	            	listBean.add(bean);
				}
				stmtTerms.close();
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
