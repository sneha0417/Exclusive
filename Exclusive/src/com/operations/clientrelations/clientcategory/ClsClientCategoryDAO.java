package com.operations.clientrelations.clientcategory;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientCategoryDAO {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsClientCategoryBean clientCategoryBean = new ClsClientCategoryBean();
	Connection conn = null;
	
	public int insert(String formdetailcode, String cmbtype, String txtcategory, String txtcategoryname, String cmbaccountgroup, int chckapproval, HttpSession session, String mode) throws SQLException {

		try{
			conn=connDAO.getMyConnection();
			Statement stmtCAT1 = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			int docno;
			
		   String sqls="select * from my_clcatm where category='"+txtcategory+"' and status<>7 and dtype='"+cmbtype+"'";
		   ResultSet resultSet1 = stmtCAT1.executeQuery(sqls);
		   
		   while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientCategoryDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCAT.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtCAT.setString(1,cmbtype);
			stmtCAT.setString(2,txtcategory);
			stmtCAT.setString(3,txtcategoryname);
			stmtCAT.setString(4,cmbaccountgroup);
			stmtCAT.setInt(5,chckapproval);
			stmtCAT.setString(6,formdetailcode);
			stmtCAT.setString(7,branch);
			stmtCAT.setString(8,userid);
			stmtCAT.setString(10,mode);
			stmtCAT.executeQuery();
			docno=stmtCAT.getInt("docNo");
			
			clientCategoryBean.setDoc_no(docno);
			if (docno > 0) {
				stmtCAT.close();
				conn.close();
				return docno;
			}
		 stmtCAT.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}
	
	public int edit(String formdetailcode,  String cmbtype, int hidtxtclientcategorydocno, String txtcategory, String txtcategoryname, String cmbaccountgroup, int chckapproval, HttpSession session, String mode) throws SQLException {
		try{
		     conn=connDAO.getMyConnection();
		     Statement stmtCAT1 = conn.createStatement();
		    
			 String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
			
		     String sql="select * from my_clcatm where category='"+txtcategory+"' and dtype='"+cmbtype+"' and status<>7 and doc_no!="+hidtxtclientcategorydocno;
		     ResultSet resultSet1 = stmtCAT1.executeQuery(sql);
		   
		     while (resultSet1.next()) {
		        return -1;
		     }
			   
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientCategoryDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCAT.setInt(9, hidtxtclientcategorydocno);
			stmtCAT.setString(1,cmbtype);
			stmtCAT.setString(2,txtcategory);
			stmtCAT.setString(3,txtcategoryname);
			stmtCAT.setString(4,cmbaccountgroup);
			stmtCAT.setInt(5,chckapproval);
			stmtCAT.setString(6,formdetailcode);
			stmtCAT.setString(7,branch);
			stmtCAT.setString(8,userid);
			stmtCAT.setString(10,mode);
			stmtCAT.executeQuery();
			int docno=stmtCAT.getInt("docNo");
			
			clientCategoryBean.setDoc_no(docno);
			if (docno > 0) {
				stmtCAT.close();
				conn.close();
				return 1;
		    }
		stmtCAT.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

	public boolean delete(int hidtxtclientcategorydocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientCategoryDML(?,?,?,?,?,?,?,?,?,?)}");

			stmtCAT.setInt(9, hidtxtclientcategorydocno);
			stmtCAT.setString(1,null);
			stmtCAT.setString(2,null);
			stmtCAT.setString(3,null);
			stmtCAT.setString(4,null);
			stmtCAT.setInt(5,0);
			stmtCAT.setString(6,formdetailcode);
			stmtCAT.setString(7,branch);
			stmtCAT.setString(8,userid);
			stmtCAT.setString(10,mode);
			stmtCAT.executeQuery();
			int docno=stmtCAT.getInt("docNo");
			
			clientCategoryBean.setDoc_no(docno);
			if (docno > 0) {
				stmtCAT.close();
				conn.close();
				return true;
			}
		  stmtCAT.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return false;
	}

	
   public List<ClsClientCategoryBean> list() throws SQLException {
        List<ClsClientCategoryBean> listBean = new ArrayList<ClsClientCategoryBean>();

        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
				ResultSet resultSet = stmtCAT.executeQuery ("SELECT doc_no,dtype,cat_name,category,acc_group,approval,if(dtype='CRM','CLIENT','VENDOR') dtypes FROM my_clcatm where status<>7");
				while (resultSet.next()) {
					
					ClsClientCategoryBean bean = new ClsClientCategoryBean();
					bean.setCmbtype(resultSet.getString("dtypes"));
					bean.setHidcmbtype(resultSet.getString("dtype"));
	            	bean.setCategory(resultSet.getString("category"));
	            	bean.setCat_name(resultSet.getString("cat_name"));
	            	bean.setDoc_no(resultSet.getInt("doc_no"));
	            	bean.setHidcmbaccountgroup(resultSet.getString("acc_group"));
	            	bean.setChckapproval(resultSet.getInt("approval"));
	            	listBean.add(bean);
				}
			stmtCAT.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return listBean;
    }
   
      public JSONArray category() throws SQLException {
       JSONArray RESULTDATA=new JSONArray();
       
       Connection conn = null;
		
       try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
           	    
				String sql="SELECT c.doc_no,c.dtype,concat(upper(c.cat_name)) cat_name,concat(upper(c.category)) category,c.acc_group,c.approval,if(c.dtype='CRM','CLIENT','VENDOR') dtypes,if(c.approval=0,false,true) approved,"
						+ "concat(upper(h.description)) description FROM my_clcatm c left join my_head h on c.acc_group=h.doc_no where c.status<>7";
           	    
				ResultSet resultSet = stmtCAT.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
			stmtCAT.close();
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
