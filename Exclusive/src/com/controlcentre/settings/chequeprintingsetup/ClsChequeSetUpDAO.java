package com.controlcentre.settings.chequeprintingsetup;

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

public class ClsChequeSetUpDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsChequeSetUpBean chqSetUpBean = new ClsChequeSetUpBean();
	
	public int insert(String formdetailcode, Date chqSetUpDate, int txtbankdocno, String txtbankid, String txtbankname, String txtpageheight,String txtpagewidth, String txtdate, 
			String txtdate1,String txtaccountpaying, String txtaccountpaying1, String txthorizontal,String txtvertical, String txtlength, String txtamtvertical,
			String txtamthorizontal, String txtamtlength, String txtamount,String txtamount1,String txtamt1vertical,String txtamt1horizontal, String txtamt1length,
			HttpSession session, String mode) throws SQLException {

		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCPS1 = conn.createStatement();
			
			int docno;
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			   
			String sqls="select * from my_chqsetup where bankdocno='"+txtbankdocno+"' and status<>7";
		    ResultSet resultSet1 = stmtCPS1.executeQuery(sqls);
		   
		    while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtCPS = conn.prepareCall("{CALL chqPrintingSetUpDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtCPS.registerOutParameter(25, java.sql.Types.INTEGER);
			
			stmtCPS.setDate(1,chqSetUpDate);
			stmtCPS.setInt(2,txtbankdocno);
			stmtCPS.setString(3,txtbankid);
			stmtCPS.setString(4,txtbankname);
			stmtCPS.setString(5,txtpageheight);
			stmtCPS.setString(6,txtpagewidth);
			stmtCPS.setString(7,txtvertical);
			stmtCPS.setString(8,txthorizontal);
			stmtCPS.setString(9,txtlength);
			stmtCPS.setString(10,txtdate);
			stmtCPS.setString(11,txtdate1);
			stmtCPS.setString(12,txtaccountpaying);
			stmtCPS.setString(13,txtaccountpaying1);
			stmtCPS.setString(14,txtamtvertical);
			stmtCPS.setString(15,txtamthorizontal);
			stmtCPS.setString(16,txtamtlength);
			stmtCPS.setString(17,txtamt1vertical);
			stmtCPS.setString(18,txtamt1horizontal);
			stmtCPS.setString(19,txtamt1length);
			stmtCPS.setString(20,txtamount);
			stmtCPS.setString(21,txtamount1);
			stmtCPS.setString(22,formdetailcode);
			stmtCPS.setString(23,branch);
			stmtCPS.setString(24,userid);
			stmtCPS.setString(26,mode);
			stmtCPS.executeQuery();
			docno=stmtCPS.getInt("docNo");
			
			chqSetUpBean.setTxtchqsetupdocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtCPS.close();
				conn.close();
				return docno;
			}
		  stmtCPS.close();
		  conn.close();
		}catch(Exception e){	
		   e.printStackTrace();	
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}

	public int edit(String formdetailcode, int txtchqsetupdocno,Date chqSetUpDate, int txtbankdocno, String txtbankid, String txtbankname,String txtpageheight, String txtpagewidth, 
			String txtdate,String txtdate1, String txtaccountpaying, String txtaccountpaying1,String txthorizontal, String txtvertical, String txtlength,
			String txtamtvertical, String txtamthorizontal,String txtamtlength, String txtamount, String txtamount1,String txtamt1vertical, String txtamt1horizontal,
			String txtamt1length, HttpSession session, String mode) throws SQLException {

		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			int docno=txtchqsetupdocno;
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			Statement stmtCPS1 = conn.createStatement();
			   
		    String sql="select * from my_chqsetup where bankdocno='"+txtbankdocno+"' and status<>7 and doc_no!="+txtchqsetupdocno+"";
		    ResultSet resultSet1 = stmtCPS1.executeQuery(sql);
		   
		    while (resultSet1.next()) {
		        return -1;
		    }

			   
			CallableStatement stmtCPS = conn.prepareCall("{CALL chqPrintingSetUpDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtCPS.setInt(25,docno);
			
			stmtCPS.setDate(1,chqSetUpDate);
			stmtCPS.setInt(2,txtbankdocno);
			stmtCPS.setString(3,txtbankid);
			stmtCPS.setString(4,txtbankname);
			stmtCPS.setString(5,txtpageheight);
			stmtCPS.setString(6,txtpagewidth);
			stmtCPS.setString(7,txtvertical);
			stmtCPS.setString(8,txthorizontal);
			stmtCPS.setString(9,txtlength);
			stmtCPS.setString(10,txtdate);
			stmtCPS.setString(11,txtdate1);
			stmtCPS.setString(12,txtaccountpaying);
			stmtCPS.setString(13,txtaccountpaying1);
			stmtCPS.setString(14,txtamtvertical);
			stmtCPS.setString(15,txtamthorizontal);
			stmtCPS.setString(16,txtamtlength);
			stmtCPS.setString(17,txtamt1vertical);
			stmtCPS.setString(18,txtamt1horizontal);
			stmtCPS.setString(19,txtamt1length);
			stmtCPS.setString(20,txtamount);
			stmtCPS.setString(21,txtamount1);
			stmtCPS.setString(22,formdetailcode);
			stmtCPS.setString(23,branch);
			stmtCPS.setString(24,userid);
			stmtCPS.setString(26,mode);
			stmtCPS.executeQuery();
			docno=stmtCPS.getInt("docNo");
			
			chqSetUpBean.setTxtchqsetupdocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtCPS.close();
				conn.close();
				return docno;
			}
		  stmtCPS.close();
		  conn.close();
		}catch(Exception e){	
		   e.printStackTrace();	
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}

	public boolean delete(int txtchqsetupdocno, String formdetailcode,HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			int docno=txtchqsetupdocno;
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			   
			CallableStatement stmtCPS = conn.prepareCall("{CALL chqPrintingSetUpDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtCPS.setInt(25,docno);
			
			stmtCPS.setDate(1,null);
			stmtCPS.setInt(2,0);
			stmtCPS.setInt(3,0);
			stmtCPS.setString(4,null);
			stmtCPS.setString(5,null);
			stmtCPS.setString(6,null);
			stmtCPS.setString(7,null);
			stmtCPS.setString(8,null);
			stmtCPS.setString(9,null);
			stmtCPS.setString(10,null);
			stmtCPS.setString(11,null);
			stmtCPS.setString(12,null);
			stmtCPS.setString(13,null);
			stmtCPS.setString(14,null);
			stmtCPS.setString(15,null);
			stmtCPS.setString(16,null);
			stmtCPS.setString(17,null);
			stmtCPS.setString(18,null);
			stmtCPS.setString(19,null);
			stmtCPS.setString(20,null);
			stmtCPS.setString(21,null);
			stmtCPS.setString(22,formdetailcode);
			stmtCPS.setString(23,branch);
			stmtCPS.setString(24,userid);
			stmtCPS.setString(26,mode);
			stmtCPS.executeQuery();
			docno=stmtCPS.getInt("docNo");
			
			chqSetUpBean.setTxtchqsetupdocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtCPS.close();
				conn.close();
				return true;
			}
		  stmtCPS.close();
		  conn.close();
		}catch(Exception e){	
		   e.printStackTrace();	
		   conn.close();
		}finally{
			conn.close();
		}
		return false;
	}
	
	public  ClsChequeSetUpBean getViewDetails(int docNo) throws SQLException {
		
		ClsChequeSetUpBean chqSetUpBean = new ClsChequeSetUpBean();
		
		Connection conn = null;
		
		try {
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCPS = conn.createStatement();

			String sql= ("select date,bankdocno,bankid,bankname,chqheight,chqwidth,paytover,paytohor,paytolen,chqdate_x,chqdate_y,accountpay_x,accountpay_y,amtver,amthor,amtlen,"
            		+ "amt1ver,amt1hor,amt1len,amount_x,amount_y from my_chqsetup where status<>7 and doc_no='"+docNo+"'");
            
			ResultSet resultSet = stmtCPS.executeQuery(sql);
						
			while (resultSet.next()) {
				chqSetUpBean.setJqxChqPrintSetUpDate(resultSet.getDate("date").toString());
				chqSetUpBean.setTxtchqsetupdocno(docNo);
				chqSetUpBean.setTxtbankdocno(resultSet.getInt("bankdocno"));
				chqSetUpBean.setTxtbankid(resultSet.getString("bankid"));
				chqSetUpBean.setTxtbankname(resultSet.getString("bankname"));
				chqSetUpBean.setTxtpageheight(resultSet.getString("chqheight"));
				chqSetUpBean.setTxtpagewidth(resultSet.getString("chqwidth"));
				chqSetUpBean.setTxtdate(resultSet.getString("chqdate_x"));
				chqSetUpBean.setTxtdate1(resultSet.getString("chqdate_y"));
				chqSetUpBean.setTxtaccountpaying(resultSet.getString("accountpay_x"));
				chqSetUpBean.setTxtaccountpaying1(resultSet.getString("accountpay_y"));
				chqSetUpBean.setTxtvertical(resultSet.getString("paytover"));
				chqSetUpBean.setTxthorizontal(resultSet.getString("paytohor"));
				chqSetUpBean.setTxtlength(resultSet.getString("paytolen"));
				chqSetUpBean.setTxtamtvertical(resultSet.getString("amtver"));
				chqSetUpBean.setTxtamthorizontal(resultSet.getString("amthor"));
				chqSetUpBean.setTxtamtlength(resultSet.getString("amtlen"));
				chqSetUpBean.setTxtamount(resultSet.getString("amount_x"));
				chqSetUpBean.setTxtamount1(resultSet.getString("amount_y"));
				chqSetUpBean.setTxtamt1vertical(resultSet.getString("amt1ver"));
				chqSetUpBean.setTxtamt1horizontal(resultSet.getString("amt1hor"));
				chqSetUpBean.setTxtamt1length(resultSet.getString("amt1len"));
		      }
		  stmtCPS.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return chqSetUpBean;
		}
	
	public  JSONArray bankDetails(HttpSession session) throws SQLException {
	      List<ClsChequeSetUpBean> bankDetailsBean = new ArrayList<ClsChequeSetUpBean>();
	      
		  JSONArray RESULTDATA=new JSONArray();
		  
		  Connection conn = null;
			
		  try {
					conn = ClsConnection.getMyConnection();
					Statement stmtCPS = conn.createStatement();
					
					String branch = session.getAttribute("BRANCHID").toString();
					String company = session.getAttribute("COMPANYID").toString();
					  
	          	    String sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
	          			+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
	          			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'";
					
	          	    ResultSet resultSet = stmtCPS.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtCPS.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	      return RESULTDATA;
	  }
	
	public  ClsChequeSetUpBean getPrint(int docno) throws SQLException {
		ClsChequeSetUpBean bean = new ClsChequeSetUpBean();
		
		Connection conn = null;
		
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtCPS = conn.createStatement();
		
		String sql="";
		
		sql="select round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status<>7 and doc_no='"+docno+"'";
		
		ResultSet resultSet = stmtCPS.executeQuery(sql);
		
		while(resultSet.next()){
			
			bean.setLblpagesheight(resultSet.getString("chqheightin"));
			bean.setLblpageswidth(resultSet.getString("chqwidthin"));
			bean.setLblpageheight(resultSet.getString("chqheight"));
			bean.setLblpagewidth(resultSet.getString("chqwidth"));
			bean.setLblpaytovertical(resultSet.getString("paytover"));
			bean.setLblpaytohorizontal(resultSet.getString("paytohor"));
			bean.setLblpaytolength(resultSet.getString("paytolen"));
			bean.setLbldatex(resultSet.getString("chqdate_x"));
			bean.setLbldatey(resultSet.getString("chqdate_y"));
			
			bean.setLblaccountpayingx(resultSet.getString("accountpay_x"));
			bean.setLblaccountpayingy(resultSet.getString("accountpay_y"));
			bean.setLblamtwordsvertical(resultSet.getString("amtver"));
			bean.setLblamtwordshorizontal(resultSet.getString("amthor"));
			bean.setLblamtwordslength(resultSet.getString("amtlen"));
			bean.setLblamountx(resultSet.getString("amount_x"));
			bean.setLblamounty(resultSet.getString("amount_y"));
			bean.setLblamtwords1vertical(resultSet.getString("amt1ver"));
			bean.setLblamtwords1horizontal(resultSet.getString("amt1hor"));
			bean.setLblamtwords1length(resultSet.getString("amt1len"));
		}
		
		stmtCPS.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
}
	
	 public  JSONArray cpsMainSearch(HttpSession session,String chqdate,String documentno,String bankid,String bankname) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	           
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
	             
	           String brid=session.getAttribute("BRANCHID").toString();
	       
	        java.sql.Date sqlChequeDate=null;
	       
	        
	        chqdate.trim();
	        if(!(chqdate.equalsIgnoreCase("undefined"))&&!(chqdate.equalsIgnoreCase(""))&&!(chqdate.equalsIgnoreCase("0")))
	        {
	        sqlChequeDate = ClsCommon.changeStringtoSqlDate(chqdate);
	        }
	        
	        
	        String sqltest="";
	        
	        if(!(sqlChequeDate==null)){
		         sqltest=sqltest+" and date='"+sqlChequeDate+"'";
		    } 
	        if(!(documentno.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and doc_no like '%"+documentno+"%'";
	        }
	        if(!(bankid.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and bankid like '%"+bankid+"%'";
	        }
	        if(!(bankname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and bankname like '%"+bankname+"%'";
	        }
	                 
	     try {

	    	  conn = ClsConnection.getMyConnection();
	    	  Statement stmtCPS = conn.createStatement();
	       
		       ResultSet resultSet = stmtCPS.executeQuery("select doc_no,date,bankid,bankname from my_chqsetup where status<>7 and brhid="+brid+"" +sqltest);
		
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		       
		       stmtCPS.close();
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