package com.finance.nipurchase.suppliers;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVendorDetailsDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsVendorDetailsBean vendorDetailsBean = new ClsVendorDetailsBean();

	public int insert(Date vendorDate, String formdetailcode, String txtvendorname,String cmbcurrency, String cmbcategory, String cmbtype, String txtregisteredtrnno,
			String cmbaccgroup, String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, String txtaddress, String txtaddress1, 
			String txttel, String txtmob, String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno, HttpSession session, 
			HttpServletRequest request) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 System.out.println("IN...VND");
				CallableStatement stmtVND = conn.prepareCall("{CALL vendorDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtVND.registerOutParameter(25, java.sql.Types.INTEGER);
				stmtVND.registerOutParameter(26, java.sql.Types.INTEGER);
				stmtVND.setDate(1,vendorDate);
				stmtVND.setString(2,txtvendorname);
				stmtVND.setString(3,cmbcurrency);
				stmtVND.setString(4,cmbcategory);
				stmtVND.setString(5,cmbtype);
				stmtVND.setString(6,txtregisteredtrnno);
				
				stmtVND.setString(7,cmbaccgroup);
				stmtVND.setInt(8,txtcredit_period_min);
				stmtVND.setInt(9,txtcredit_period_max);
				stmtVND.setInt(10,txtcredit_limit);

				stmtVND.setString(11,txtaddress);
				stmtVND.setString(12,txtaddress1);
				stmtVND.setString(13,txttel);
				stmtVND.setString(14,txtmob);
				stmtVND.setString(15,txtoffice);
				stmtVND.setString(16,txtfax);
				stmtVND.setString(17,txtemail);
				stmtVND.setString(18,txtcontact);
				stmtVND.setString(19,txtextno);
				
				stmtVND.setString(20,formdetailcode);
				stmtVND.setString(21,currency);
				stmtVND.setString(22,branch);
				stmtVND.setString(23,company);
				stmtVND.setString(24,userid);
				stmtVND.setString(27,"A");
				int val=stmtVND.executeUpdate();
				System.out.println("val------------>>>"+val);
				int docno=stmtVND.getInt("docNo");
				int accountno=stmtVND.getInt("documentNo");
				request.setAttribute("acno", accountno);
				
				vendorDetailsBean.setTxtvendordocno(docno);
				if (docno>0 && accountno>0) {
					
					conn.commit();
					stmtVND.close();
					conn.close();
					return docno;
				}
				
				stmtVND.close();
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

	public int edit(int txtvendordocno, String formdetailcode, Date vendorDate,String txtvendorname, String cmbcurrency, String cmbcategory, String cmbtype, 
			String txtregisteredtrnno, String cmbaccgroup, String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, 
			String txtaddress, String txtaddress1, String txttel, String txtmob, String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno,
			HttpSession session) throws SQLException {
		
			Connection conn = null;
		
		    try{
		    		conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
				
			    	String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
				
					CallableStatement stmtVND = conn.prepareCall("{CALL vendorDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");		

					stmtVND.setInt(25,txtvendordocno);
					stmtVND.setString(26,txtaccount);
					stmtVND.setDate(1,vendorDate);
					stmtVND.setString(2,txtvendorname);
					stmtVND.setString(3,cmbcurrency);
					stmtVND.setString(4,cmbcategory);
					stmtVND.setString(5,cmbtype);
					stmtVND.setString(6,txtregisteredtrnno);
					
					stmtVND.setString(7,cmbaccgroup);
					stmtVND.setInt(8,txtcredit_period_min);
					stmtVND.setInt(9,txtcredit_period_max);
					stmtVND.setInt(10,txtcredit_limit);

					stmtVND.setString(11,txtaddress);
					stmtVND.setString(12,txtaddress1);
					stmtVND.setString(13,txttel);
					stmtVND.setString(14,txtmob);
					stmtVND.setString(15,txtoffice);
					stmtVND.setString(16,txtfax);
					stmtVND.setString(17,txtemail);
					stmtVND.setString(18,txtcontact);
					stmtVND.setString(19,txtextno);
					
					stmtVND.setString(20,formdetailcode);
					stmtVND.setString(21,currency);
					stmtVND.setString(22,branch);
					stmtVND.setString(23,company);
					stmtVND.setString(24,userid);
					stmtVND.setString(27,"E");
					stmtVND.executeQuery();
					int docno=stmtVND.getInt("docNo");
					int accountno=stmtVND.getInt("documentNo");
					
					vendorDetailsBean.setTxtvendordocno(docno);
					if (docno > 0 && accountno > 0) {
						
						conn.commit();
						stmtVND.close();
						conn.close();
						return 1;
					}
					stmtVND.close();
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

	public int delete(int txtvendordocno, String txtaccount, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
 			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String currency=session.getAttribute("CURRENCYID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
		    
			CallableStatement stmtVND = conn.prepareCall("{CALL vendorDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");		
			
			stmtVND.setInt(25,txtvendordocno);
			stmtVND.setString(26,txtaccount);
			stmtVND.setDate(1,null);
			stmtVND.setString(2,null);
			stmtVND.setString(3,null);
			stmtVND.setString(4,null);
			stmtVND.setString(5,"0");
			stmtVND.setString(6,null);
			
			stmtVND.setString(7,null);
			stmtVND.setInt(8,0);
			stmtVND.setInt(9,0);
			stmtVND.setInt(10,0);

			stmtVND.setString(11,null);
			stmtVND.setString(12,null);
			stmtVND.setString(13,null);
			stmtVND.setString(14,null);
			stmtVND.setString(15,null);
			stmtVND.setString(16,null);
			stmtVND.setString(17,null);
			stmtVND.setString(18,null);
			stmtVND.setString(19,null);
			
			stmtVND.setString(20,formdetailcode);
			stmtVND.setString(21,currency);
			stmtVND.setString(22,branch);
			stmtVND.setString(23,company);
			stmtVND.setString(24,userid);
			stmtVND.setString(27,"D");
			stmtVND.executeQuery();
			int docno=stmtVND.getInt("docNo");
			int accountno=stmtVND.getInt("documentNo");
			
			vendorDetailsBean.setTxtvendordocno(docno);
			if (docno > 0 && accountno > 0) {
				
				conn.commit();
				stmtVND.close();
				conn.close();
				return 1;
			}	
			
			if (docno == -1){
				stmtVND.close();
				conn.close();
				return docno;
			}
			stmtVND.close();
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

	public ClsVendorDetailsBean getViewDetails(int docNo) throws SQLException {
		ClsVendorDetailsBean vendorDetailsBean = new ClsVendorDetailsBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtVND = conn.createStatement();

			ResultSet resultSet = stmtVND.executeQuery ("select date,codeno,RefName,curId,catid,type,trnnumber,acc_group,acno,period,period2,credit,address,address2,per_tel,"
								+ "per_mob,com_mob,fax1,mail1,contactPerson,EXT_NO,dtype, DOC_NO,STATUS from my_acbook where dtype='VND' and status<>7 and doc_no="+docNo);

			while (resultSet.next()) {
				vendorDetailsBean.setTxtvendordocno(docNo);
				vendorDetailsBean.setJqxVendorDate(resultSet.getDate("date").toString());
				vendorDetailsBean.setTxtcode(resultSet.getInt("codeno"));
				vendorDetailsBean.setTxtvendorname(resultSet.getString("RefName"));
				vendorDetailsBean.setHidcmbcurrency(resultSet.getString("curId"));
				vendorDetailsBean.setHidcmbcategory(resultSet.getString("catid"));
				vendorDetailsBean.setHidcmbtype(resultSet.getString("type"));
				vendorDetailsBean.setTxtregisteredtrnno(resultSet.getString("trnnumber"));
				
				vendorDetailsBean.setHidcmbaccgroup(resultSet.getString("acc_group"));
				vendorDetailsBean.setTxtaccount(resultSet.getString("acno"));
				vendorDetailsBean.setTxtcredit_period_min(resultSet.getInt("period"));
				vendorDetailsBean.setTxtcredit_period_max(resultSet.getInt("period2"));
				vendorDetailsBean.setTxtcredit_limit(resultSet.getInt("credit"));
				vendorDetailsBean.setTxtaddress(resultSet.getString("address"));
				vendorDetailsBean.setTxtaddress1(resultSet.getString("address2"));
				vendorDetailsBean.setTxttel(resultSet.getString("per_tel"));
				vendorDetailsBean.setTxtmob(resultSet.getString("per_mob"));
				vendorDetailsBean.setTxtoffice(resultSet.getString("com_mob"));
				vendorDetailsBean.setTxtfax(resultSet.getString("fax1"));
				vendorDetailsBean.setTxtemail(resultSet.getString("mail1"));
				vendorDetailsBean.setTxtcontact(resultSet.getString("contactPerson"));
				vendorDetailsBean.setTxtextno(resultSet.getString("EXT_NO"));
	
			    }
			stmtVND.close();
			conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return vendorDetailsBean;
			}
	
	 public JSONArray vndMainSearch(String vndname,String vndaccno,String vndmob,String vndtel) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = connDAO.getMyConnection();
					Statement stmtVND = conn.createStatement();
	            	String sqltest="";
			        
			        if(!(vndname.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and refname like '%"+vndname+"%'";
			        }
			        if(!(vndaccno.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and acno like '%"+vndaccno+"%'";
			        }
			        if(!(vndtel.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and per_tel like '%"+vndtel+"%'";
			        }
			        if(!(vndmob.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and per_mob like '%"+vndmob+"%'";
			        }
					
					ResultSet resultSet = stmtVND.executeQuery("select refname,acno,per_tel,per_mob,doc_no from my_acbook where dtype='VND' and status<>7"+sqltest);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtVND.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
	        return RESULTDATA;
	    }
	 
	 public JSONArray vendorList() throws SQLException {
			Connection conn = null;
	        JSONArray RESULTDATA=new JSONArray();
	        
	  try {
		    conn = connDAO.getMyConnection();
		    Statement stmtVND = conn.createStatement();
		    
		    ResultSet resultSet = stmtVND.executeQuery ("SELECT category,cl.doc_no,cl.codeno,refname,per_mob,sal_name,concat(address,'  ',address2) as address, "
		    		+ "mail1,vt.desc1 type,trnnumber,cl.acno account,h.description accountgroup,cl.period creditperiodmin,cl.period2 creditperiodmax,cl.credit creditlimit "
		    		+ "FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='VND' left join my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' "
		    		+ "left join my_vndtax vt on vt.doc_no=cl.type left join my_head h on h.doc_no=cl.acc_group where cl.dtype='VND' ");
		                
		    RESULTDATA=commonDAO.convertToJSON(resultSet);
		    
		    stmtVND.close();
		    conn.close();
	  }catch(Exception e){
	     e.printStackTrace();
		 conn.close();
	  }finally{
			 conn.close();
		 }
	  return RESULTDATA;
	 }
	 public JSONArray vendorExcelExport() throws SQLException {
			Connection conn = null;
	        JSONArray RESULTDATA=new JSONArray();
	        //System.out.println("excel data");
	  try {
		    conn = connDAO.getMyConnection();
		    Statement stmtVND = conn.createStatement();
		    
		    /*System.out.println("SELECT category Category,refname Name,per_mob Mobile,sal_name Salesman,concat(address,'  ',address2) as Address, "
		    		+ "mail1 Email FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='VND' left join my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' where cl.dtype='VND' ");*/
		    
		    ResultSet resultSet = stmtVND.executeQuery ("SELECT category Category,cl.doc_no 'Doc No',cl.codeno 'Code',refname 'Name',per_mob 'Mobile',sal_name 'Salesman',concat(address,'  ',address2) as 'Address', "
		    		+ "mail1 'Email',vt.desc1 'Type',trnnumber 'TRN No',cl.acno 'Account',h.description 'Account Group',cl.period 'Credit Period Min',cl.period2 'Credit Period Max',cl.credit 'Credit Limit' "
		    		+ "FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='VND' left join my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' "
		    		+ "left join my_vndtax vt on vt.doc_no=cl.type left join my_head h on h.doc_no=cl.acc_group where cl.dtype='VND' ");
		                
		    RESULTDATA=commonDAO.convertToEXCEL(resultSet);
		    
		    stmtVND.close();
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
