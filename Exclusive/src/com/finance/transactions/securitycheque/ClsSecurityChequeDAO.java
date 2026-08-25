package com.finance.transactions.securitycheque;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsChequeAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSecurityChequeDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsSecurityChequeBean securityChqBean = new ClsSecurityChequeBean();
	
	public int insert(Date securityChequeDate, String formdetailcode,String cmbtotype, int txttodocno, int txtfromdocno,String txtchequeno, Date validUpToDate, 
			String hidchckchqdate, Date chequeDate, String hidchckamount, double txtamount, String txtremarks, String txtchequename, HttpSession session, String mode) throws SQLException {
		  	
		  	Connection conn = null;
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			if(hidchckchqdate.equalsIgnoreCase("") || hidchckchqdate.equalsIgnoreCase("0")){
				hidchckchqdate="0";
				chequeDate=null;
			}
			
			if(hidchckamount.equalsIgnoreCase("")){
				hidchckamount="0";
			}
			
			CallableStatement stmtSEC = conn.prepareCall("{CALL securitychqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSEC.registerOutParameter(17, java.sql.Types.INTEGER);
			
			stmtSEC.setDate(1,securityChequeDate);
			stmtSEC.setString(2,cmbtotype);
			stmtSEC.setInt(3,txttodocno);
			stmtSEC.setInt(4,txtfromdocno);
			stmtSEC.setString(5,txtchequeno);
			stmtSEC.setDate(6,validUpToDate);
			stmtSEC.setString(7,hidchckchqdate);
			stmtSEC.setDate(8,chequeDate);
			stmtSEC.setString(9,hidchckamount);
			stmtSEC.setDouble(10,txtamount);
			stmtSEC.setString(11,txtremarks);
			stmtSEC.setString(12,txtchequename);
			
			stmtSEC.setString(13,formdetailcode);
			stmtSEC.setString(14,company);
			stmtSEC.setString(15,branch);
			stmtSEC.setString(16,userid);
			stmtSEC.setString(18,mode);
			int datas=stmtSEC.executeUpdate();
			if(datas<=0){
				stmtSEC.close();
				conn.close();
				return 0;
			}
			int docno=stmtSEC.getInt("docNo");
			securityChqBean.setTxtsecuritychequedocno(docno);
			if (docno > 0) {
					conn.commit();
					stmtSEC.close();
					conn.close();
					return docno;
			}
			
			stmtSEC.close();
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
			
	
	public boolean edit(int txtsecuritychequedocno, Date securityChequeDate, String formdetailcode, String cmbtotype, int txttodocno, int txtfromdocno, String txtchequeno, 
			Date validUpToDate, String hidchckchqdate, Date chequeDate, String hidchckamount, double txtamount, String txtremarks, String txtchequename, HttpSession session, String mode) throws SQLException {
		
		 	Connection conn = null;
		 	
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				if(hidchckchqdate.equalsIgnoreCase("") || hidchckchqdate.equalsIgnoreCase("0")){
					hidchckchqdate="0";
					chequeDate=null;
				}
				
				if(hidchckamount.equalsIgnoreCase("")){
					hidchckamount="0";
				}
				
				CallableStatement stmtSEC = conn.prepareCall("{CALL securitychqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtSEC.setInt(17,txtsecuritychequedocno);
				
				stmtSEC.setDate(1,securityChequeDate);
				stmtSEC.setString(2,cmbtotype);
				stmtSEC.setInt(3,txttodocno);
				stmtSEC.setInt(4,txtfromdocno);
				stmtSEC.setString(5,txtchequeno);
				stmtSEC.setDate(6,validUpToDate);
				stmtSEC.setString(7,hidchckchqdate);
				stmtSEC.setDate(8,chequeDate);
				stmtSEC.setString(9,hidchckamount);
				stmtSEC.setDouble(10,txtamount);
			    stmtSEC.setString(11,txtremarks);	
			    stmtSEC.setString(12,txtchequename);
				
				stmtSEC.setString(13,formdetailcode);
				stmtSEC.setString(14,company);
				stmtSEC.setString(15,branch);
				stmtSEC.setString(16,userid);
				stmtSEC.setString(18,mode);
				int datas=stmtSEC.executeUpdate();
				if(datas<=0){
					stmtSEC.close();
					conn.close();
					return false;
				}
				int docno=stmtSEC.getInt("docNo");
				securityChqBean.setTxtsecuritychequedocno(docno);
				if (docno > 0) {
						conn.commit();
						stmtSEC.close();
						conn.close();
						return true;
				}
				stmtSEC.close();
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

	public boolean delete(int txtsecuritychequedocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		 
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtSEC = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				 /*Status change in my_secchq*/
				 String sql=("update my_secchq set status=7 where brhid="+branch+" and doc_no="+txtsecuritychequedocno+"");
				 int data = stmtSEC.executeUpdate(sql);
				/*Status change in my_secchq Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtsecuritychequedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtSEC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				int docno=txtsecuritychequedocno;
				securityChqBean.setTxtsecuritychequedocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtSEC.close();
				    conn.close();
					return true;
				}	
				stmtSEC.close();
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
	
	public JSONArray secMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check) throws SQLException {

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
       
        java.sql.Date sqlBankDate=null;
        java.sql.Date sqlChequeDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtSEC = conn.createStatement();

	       date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlBankDate = commonDAO.changeStringtoSqlDate(date);
	        }
	        
	        chequeDt.trim();
	        if(!(chequeDt.equalsIgnoreCase("undefined"))&&!(chequeDt.equalsIgnoreCase(""))&&!(chequeDt.equalsIgnoreCase("0")))
	        {
	        sqlChequeDate = commonDAO.changeStringtoSqlDate(chequeDt);
	        }
	        
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.amount like '%"+amount+"%'";
	        }
	        if(!(chequeNo.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.chqno like '%"+chequeNo+"%'";
	        }
	        if(!(sqlBankDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlBankDate+"'";
		        } 
	         if(!(sqlChequeDate==null)){
	         sqltest=sqltest+" and m.chqdt='"+sqlChequeDate+"'";
	        }
	         
	       ResultSet resultSet = stmtSEC.executeQuery("select m.date,m.doc_no,m.amount,h.description,m.chqno,m.chqdt from my_secchq m left join my_head h on m.acno_to=h.doc_no "
	       		+ "where m.brhid='"+branch+"' and m.status<>7" +sqltest);

	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtSEC.close();
	       conn.close();
     } catch(Exception e){
    	 	e.printStackTrace();
    	 	conn.close();
     }
       return RESULTDATA;
   }
	
	  public ClsSecurityChequeBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsSecurityChequeBean securityChqBean = new ClsSecurityChequeBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtSEC = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtSEC.executeQuery ("select m.date,m.atype,m.acno_to,m.acno_from,m.chqname,m.chqno,m.valid_upto,m.chkchqdt,m.chqdt,m.chkamt,m.amount,m.remarks,"
				+ "h.account acno,h.description accountname,h1.account bankacno,h1.description bankname from my_secchq m left join my_head h on m.acno_to=h.doc_no "
				+ "left join my_head h1 on m.acno_from=h1.doc_no left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.status<>7 and m.doc_no="+docNo+"");

			while (resultSet.next()) {
					securityChqBean.setTxtsecuritychequedocno(docNo);
					securityChqBean.setJqxSecurityChequeDate(resultSet.getDate("date").toString());
					
					securityChqBean.setHidcmbtotype(resultSet.getString("atype"));
					securityChqBean.setTxttodocno(resultSet.getInt("acno_to"));
					securityChqBean.setTxttoaccid(resultSet.getString("acno"));
					securityChqBean.setTxttoaccname(resultSet.getString("accountname"));
					securityChqBean.setTxtfromdocno(resultSet.getInt("acno_from"));
					securityChqBean.setTxtfromaccid(resultSet.getString("bankacno"));
					securityChqBean.setTxtfromaccname(resultSet.getString("bankname"));
					
					securityChqBean.setTxtchequename(resultSet.getString("chqname"));
					securityChqBean.setTxtchequeno(resultSet.getString("chqno"));
					securityChqBean.setJqxValidUpTo(resultSet.getString("valid_upto").toString());
					securityChqBean.setHidchckchqdate(resultSet.getString("chkchqdt"));
					securityChqBean.setJqxChequeDate(resultSet.getString("chqdt"));
					securityChqBean.setHidchckamount(resultSet.getString("chkamt"));
					securityChqBean.setTxtamount(resultSet.getDouble("amount"));
					securityChqBean.setTxtremarks(resultSet.getString("remarks"));
					
					securityChqBean.setMaindate(resultSet.getDate("date").toString());
				
		    }
		  stmtSEC.close();
		  conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return securityChqBean;
		}
		
	public ClsSecurityChequeBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
	    	 ClsSecurityChequeBean bean = new ClsSecurityChequeBean();
			 Connection conn = null;
			 
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCOT = conn.createStatement();
				
				String headersql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_secchq m inner join my_brch b on m.brhid=b.doc_no "
						+ "inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) "
						+ "as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtCOT.executeQuery(headersql);
					
					while(resultSetHead.next()){
						
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						bean.setLblcstno(resultSetHead.getString("cstno"));
						bean.setLblpan(resultSetHead.getString("pbno"));
						bean.setLblservicetax(resultSetHead.getString("stcno"));
						
					}
					
				ClsAmountToWords c = new ClsAmountToWords();
				
				String sqls="select s.doc_no,DATE_FORMAT(s.date ,'%d-%m-%Y') date,coalesce(s.chqno,' ') chqno,if(s.chkchqdt=0,' ',coalesce(DATE_FORMAT(s.chqdt ,'%d-%m-%Y'),' ')) chqdt,\r\n" + 
						"if(s.chqno=' ',' ',coalesce(DATE_FORMAT(s.valid_upto,'%d-%m-%Y'),' ')) validupto,s.remarks,s.chkamt,round(s.amount,2) amount,h.description paidto,\r\n" + 
						"h1.description receivedfrom,u.user_name from my_secchq s left join my_head h on s.acno_to=h.doc_no left join my_head h1 on s.acno_from=h1.doc_no\r\n" + 
						"left join my_user u on s.userid=u.doc_no where s.status=3 and s.brhid="+branch+" and s.doc_no="+docNo+"";
				
				ResultSet resultSets = stmtCOT.executeQuery(sqls);
				
				String chckAmount="";
				
				while(resultSets.next()){
					
					chckAmount=resultSets.getString("chkamt");
					
					bean.setLblvoucherno(resultSets.getString("doc_no"));
					bean.setLbldate(resultSets.getString("date"));
					bean.setLbldescription(resultSets.getString("remarks"));
					
					bean.setLblchqno(resultSets.getString("chqno"));
					bean.setLblchqdate(resultSets.getString("chqdt"));
					
					bean.setLblpaidtoname(resultSets.getString("paidto"));
					bean.setLblreceivedname(resultSets.getString("receivedfrom"));
					bean.setLblvalidupto(resultSets.getString("validupto"));
					
					if(chckAmount.equalsIgnoreCase("1")){
						bean.setLblnetamount(resultSets.getString("amount"));
						bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("amount")));
					}else{
						bean.setLblnetamount(" ");
						bean.setLblnetamountwords(" ");
					}
					
					bean.setLblpreparedby(resultSets.getString("user_name"));
					
				}
				
				bean.setTxtheader(header);
				
				String sql = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_secchq m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='SEC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				ResultSet resultSet = stmtCOT.executeQuery(sql);
				
				while(resultSet.next()){
					bean.setLblpreparedon(resultSet.getString("preparedon"));
					bean.setLblpreparedat(resultSet.getString("preparedat"));
				}
			
				stmtCOT.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return bean;
		}
	 
	public ClsSecurityChequeBean getChequePrint(int docno,int branch) throws SQLException {
		     ClsSecurityChequeBean bean = new ClsSecurityChequeBean();
			 Connection conn = null;
				
			try {
				conn = connDAO.getMyConnection();
				Statement stmtSEC = conn.createStatement();
				String amountwordslength="";
				int accountno=0;
				
				String sqls="select acno_from acno from my_secchq where brhid="+branch+" and doc_no="+docno+"";
				
				ResultSet resultSets = stmtSEC.executeQuery(sqls);
				
				while(resultSets.next()){
					accountno=resultSets.getInt("acno");
				}
				
				/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
				
				String sql="select printpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
				
				ResultSet resultSet = stmtSEC.executeQuery(sql);
				
				while(resultSet.next()){
                    
					bean.setPrinturl(resultSet.getString("printpath"));
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
					
					amountwordslength=resultSet.getString("amtlen");
				}
			
				String sql1="select if(chkchqdt=1,DATE_FORMAT(s.chqdt,'%d-%m-%Y'),DATE_FORMAT(s.valid_upto,'%d-%m-%Y')) chqdt,CASE WHEN s.chqname is null THEN "
					+ "t.description WHEN s.chqname='' THEN t.description Else s.chqname END as 'description',round(s.amount,2) amount from my_secchq s left join my_head t on "
					+ "s.acno_to=t.doc_no where s.brhid="+branch+" and s.doc_no="+docno+"";
				
					ResultSet resultSet1 = stmtSEC.executeQuery(sql1);
					
					while(resultSet1.next()){
						/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
						   1 character = 8 pixel ## 1 pixel = 0.125 character */
						
						//bean.setLblchequedate(resultSet1.getString("chqdt"));
						bean.setLblpaidto(resultSet1.getString("description"));
						bean.setLblamount(resultSet1.getString("amount"));
						
						ClsChequeAmountToWords c = new ClsChequeAmountToWords();
						double chequelength = Double.parseDouble(amountwordslength)*0.125;
						String amountwords = c.convertChequeAmountToWords(resultSet1.getString("amount"));
						if(amountwords.length()>chequelength){
							
							String breakedstring = commonDAO.addLinebreaks(amountwords, chequelength);
							
							if(breakedstring.contains("::")){
								String[] breakedstringarray = breakedstring.split("::");
							
								String amountinwords1 = breakedstringarray[0]; 
								String amountinwords2 = breakedstringarray[1];
							
								bean.setLblamountwords(amountinwords1);
								bean.setLblamountwords1(amountinwords2);
							}else{
								bean.setLblamountwords(breakedstring);
							}
						}else{
							bean.setLblamountwords(amountwords);
						}
					}
					
					stmtSEC.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return bean;
		}

}
