package com.finance.posting.unclearedchequeprocessing;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.bankpayment.ClsBankPaymentDAO;
import com.finance.transactions.bankreceipt.ClsBankReceiptDAO;

public class ClsUnclearedChequeProcessingDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsUnclearedChequeProcessingBean unclrChqPostingBean = new ClsUnclearedChequeProcessingBean();
	
	  public int insert(String formdetailcode, Date unclearedChequeProcessingDate, int gridDocno, String txtgriddtype, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, 
				 int chckpdc, double txtdrtotal,ArrayList<String> bankpaymentarray, HttpSession session,HttpServletRequest request, String mode) throws SQLException {
		  
		  Connection conn  = null;
		  
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtUCPP = conn.createStatement();
			
	        int docno = 0;
	        int trno = 0;
	        
	        String[] bankpaymentsarray1=bankpaymentarray.get(1).split("::");
	        String[] bankpaymentsarray2=null;
	        
	        if(bankpaymentarray.size()>2){
	        	bankpaymentsarray2=bankpaymentarray.get(2).split("::");
	        }
	        
	        int toaccount = (bankpaymentsarray1[0].trim().equalsIgnoreCase("undefined") || bankpaymentsarray1[0].trim().equalsIgnoreCase("NaN") || bankpaymentsarray1[0].trim().equalsIgnoreCase("0") || bankpaymentsarray1[0].trim().isEmpty()?Integer.parseInt(bankpaymentsarray2[0].trim()):Integer.parseInt(bankpaymentsarray1[0].trim()));
	        
	        /*Payment*/
	        if(txtgriddtype.equalsIgnoreCase("UCP")){
	        	
			/*Inserting into my_chqbm,my_chqbd,my_chqdet and my_jvtran*/
			  ArrayList<String> blankarray= new ArrayList<String>();
			  
			   ClsBankPaymentDAO bpv = new ClsBankPaymentDAO();
				
			    docno=bpv.insert(conn,unclearedChequeProcessingDate, "BPV", formdetailcode+"-"+gridDocno, txtfromrate, chequeDate, txtchequeno, txtchequename, chckpdc, "Cheque No. "+txtchequeno+" is posted as BPV on "+unclearedChequeProcessingDate, txtdrtotal, toaccount, 0, bankpaymentarray, blankarray, session, request, mode);
				trno=Integer.parseInt(request.getAttribute("tranno").toString());

	        }
	        
	        /*Receipt*/
	        else if(txtgriddtype.equalsIgnoreCase("UCR")){
	        	
			/*Inserting into my_chqbm,my_chqbd,my_chqdet and my_jvtran*/
			  ArrayList<String> blankarray= new ArrayList<String>();
			  
			   ClsBankReceiptDAO brv = new ClsBankReceiptDAO();
				
			    docno=brv.insert(conn,unclearedChequeProcessingDate, "BRV", formdetailcode+"-"+gridDocno, txtfromrate, chequeDate, txtchequeno, txtchequename, chckpdc, "Cheque No. "+txtchequeno+" is posted as BRV on "+unclearedChequeProcessingDate, txtdrtotal, toaccount, 0, bankpaymentarray, blankarray, session, request, mode);
				trno=Integer.parseInt(request.getAttribute("tranno").toString());

	        }
	        
			if(docno>0){
				
				Statement stmtUCPP1 = conn.createStatement();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String refNo="",referenceNo="",referenceId="";
				int fleetNo=0,tranid=0,accNo=0;
				double totPer=0.00,dramount=0.00;
				
				if(txtgriddtype.equalsIgnoreCase("UCP")){
				
				/*Updating my_unclrchqbm*/
                String sql=("update my_unclrchqbm set bpvno="+docno+" where brhid="+branch+" and doc_no="+gridDocno+"");
                int data = stmtUCPP1.executeUpdate(sql);
                if(data<=0){
					stmtUCPP1.close();
					conn.close();
					return 0;
				}
				/*Updating my_unclrchqbm Ends*/
                
                /*Inserting to my_costtran*/
                String sql1="select refno from my_unclrchqbm where brhid="+branch+" and doc_no="+gridDocno+"";
                ResultSet resultSet = stmtUCPP1.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					refNo=resultSet.getString("refno");
				 }
				 
				 if(refNo.contains("-")){
					String[] parts = refNo.split("-");
					referenceNo = parts[0]; 
					referenceId = parts[1];
				 }
				 
				 if(referenceNo.equalsIgnoreCase("VPU")){
					 ArrayList<String> costarray= new ArrayList<String>();
					 ArrayList<String> jvarray= new ArrayList<String>();
				     
					 String sql2=("delete from my_costtran where tr_no="+trno+"");
					 int data2 = stmtUCPP1.executeUpdate(sql2);
					 
					 String sql3="select fleet_no,totper from gl_vpurd d left join gl_vpurdetd det on d.rdocno=det.rdocno where det.bpvno="+gridDocno+"";
					 ResultSet resultSet1 = stmtUCPP1.executeQuery(sql3);
					    
					 while (resultSet1.next()) {
						fleetNo=resultSet1.getInt("fleet_no");
						totPer=resultSet1.getDouble("totper");
						
						costarray.add(""+fleetNo+"::"+totPer+"");
					 }
					 
					 String sql4="select j.acno,j.dramount,j.tranid from my_jvtran j left join my_head h on j.acno=h.doc_no where h.gr_type in (4,5) and j.tr_no="+trno+"";
					 ResultSet resultSet2 = stmtUCPP1.executeQuery(sql4);
					    
					 while (resultSet2.next()) {
						 accNo=resultSet2.getInt("acno");
						 dramount=resultSet2.getDouble("dramount");
						 tranid=resultSet2.getInt("tranid");
						 
						 jvarray.add(""+accNo+"::"+dramount+"::"+tranid+"");
					 }
					 
					 int k=0;
					 for(int i=0;i< jvarray.size();i++){
						String[] bankpayment=jvarray.get(i).split("::");
						
						for(int j=0;j< costarray.size();j++){
							String[] vehpurchase=costarray.get(j).split("::");
							
							Double amount = ((bankpayment[1].equalsIgnoreCase("undefined") || bankpayment[1].equalsIgnoreCase("NaN") || bankpayment[1].isEmpty()?0.0:Double.parseDouble(bankpayment[1]))*((vehpurchase[1].equalsIgnoreCase("undefined") || vehpurchase[1].equalsIgnoreCase("NaN") || vehpurchase[1].isEmpty()?0.0:Double.parseDouble(vehpurchase[1]))/100));
							
							String sql5="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(bankpayment[0].trim().equalsIgnoreCase("undefined") || bankpayment[0].trim().equalsIgnoreCase("NaN") || bankpayment[0].trim().isEmpty()?0:bankpayment[0].trim())+","
							 		+ "6,"+amount+","+(k+1)+","+(vehpurchase[0].trim().equalsIgnoreCase("undefined") || vehpurchase[0].trim().equalsIgnoreCase("NaN") || vehpurchase[0].trim().isEmpty()?0:vehpurchase[0].trim())+","
							 	    + ""+(bankpayment[2].trim().equalsIgnoreCase("undefined") || bankpayment[2].trim().equalsIgnoreCase("NaN") || bankpayment[2].trim().isEmpty()?0:bankpayment[2].trim())+","+trno+")";

							int data3 = stmtUCPP1.executeUpdate(sql5);
							 if(data3<=0){
								    stmtUCPP1.close();
									conn.close();
									return 0;
							}
							k++; 
						 }
					 }
					 
					String sql6="update my_jvtran set costtype=7,costcode=9999 where tranid="+tranid+"";
					int data4 = stmtUCPP1.executeUpdate(sql6);
					 if(data4<=0){
						    stmtUCPP1.close();
							conn.close();
							return 0;
					}
				 }
                /*Inserting to my_costtran Ends*/
			    }
				
				/*Receipt*/
				else if(txtgriddtype.equalsIgnoreCase("UCR")){
				
				/*Updating my_unclrchqreceiptm*/
                String sql=("update my_unclrchqreceiptm set bpvno="+docno+" where brhid="+branch+" and doc_no="+gridDocno+"");
                int data = stmtUCPP1.executeUpdate(sql);
                if(data<=0){
					stmtUCPP1.close();
					conn.close();
					return 0;
				}
				/*Updating my_unclrchqreceiptm Ends*/
				}
				/*Receipt Update*/
				
				stmtUCPP1.close();
				
				conn.commit();
				stmtUCPP.close();
				conn.close();
				return docno;
			}
		stmtUCPP.close();
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
	
	public JSONArray unclearedChequePaymentGridReloading(HttpSession session,String fromDate,String toDate,String type,String check) throws SQLException {
        
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
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtUCPP = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				if(check.equalsIgnoreCase("1")) {
					
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
			        
            	
		        if(type.equalsIgnoreCase("UCP")) {
		        	
		        	String xsql = "";
		        	
		        	if(!(sqlFromDate==null)){
			        	xsql+=" and m.chqdt>='"+sqlFromDate+"'";
				        }
			        
			        if(!(sqlToDate==null)){
			        	xsql+=" and m.chqdt<='"+sqlToDate+"'";
				        }
				
					xsql = "select detm.dealno dealno,m.dtype,d.rowno,m.doc_no,m.date,0 pdc,m.chqname,m.desc1,t.account bank,coalesce(t.description,'') bankname,if(t1.doc_no is null,t2.doc_no,t1.doc_no) acno,"
							+ "if(t1.doc_no is null,t2.account,t1.account) account,if(t1.doc_no is null,t2.description,t1.description) accountname,if(t1.doc_no is null,t2.atype,t1.atype) atype,"
							+ "d.sr_no,d.curId,d.rate,if(d.amount<0,d.amount*-1,d.amount) tr_dr,if(d.lamount<0,d.lamount*-1,d.lamount) lamount,m.brhId,c.code curr,m.chqdt,m.chqno,b.branchname "
							+ "from my_unclrchqbm m left join my_unclrchqbd d on (m.doc_no=d.rdocno and d.brhid="+branch+" and d.sr_no=0) left join my_unclrchqbd d2 on (m.doc_no=d2.rdocno and "
							+ "d2.brhid="+branch+" and d2.sr_no=1) left join my_unclrchqbd d3 on (m.doc_no=d3.rdocno and d3.brhid="+branch+" and d3.sr_no=2) left join my_curr c on (d.curid=c.doc_no) "
							+ "left join my_brch b on (m.brhid=b.doc_no) left join  my_head t on (d.acno=t.doc_no ) left join my_head t1 on (d2.acno=t1.doc_no) left join my_head t2 on (d3.acno=t2.doc_no) left join gl_vpurdetd detd on detd.bpvno=m.doc_no left join gl_vpurdetm detm on detm.rdocno=detd.rdocno "
							+ "where m.status=3 and m.bpvno=0 and m.brhid="+branch+""+xsql+"";
					
					System.out.println("payment grid loading=="+xsql);
					
					
					 ResultSet resultSet = stmtUCPP.executeQuery(xsql);
					 RESULTDATA=commonDAO.convertToJSON(resultSet);
				
		        } else if(type.equalsIgnoreCase("UCR")){
		        	
			        	String xsql = "";
			        	
			        	if(!(sqlFromDate==null)){
				        	xsql+=" and m.chqdt>='"+sqlFromDate+"'";
					        }
				        
				        if(!(sqlToDate==null)){
				        	xsql+=" and m.chqdt<='"+sqlToDate+"'";
					        }
				        
			        	xsql = "select m.dtype,d.rowno,m.doc_no,m.date,0 pdc,m.chqname,m.desc1,t.account bank,coalesce(t.description,'') bankname,if(t1.doc_no is null,t2.doc_no,t1.doc_no) acno,"  
			        		+ "if(t1.doc_no is null,t2.account,t1.account) account,if(t1.doc_no is null,t2.description,t1.description) accountname,if(t1.doc_no is null,t2.atype,t1.atype) atype,"
			        		+ "d.sr_no,d.curId,d.rate,if(d.amount<0,d.amount*-1,d.amount) tr_dr,if(d.lamount<0,d.lamount*-1,d.lamount) lamount,m.brhId,c.code curr,m.chqdt,m.chqno,b.branchname from "  
							+ "my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and d.brhid="+branch+" and d.sr_no=0) left join my_unclrchqreceiptd d2 on (m.doc_no=d2.rdocno and "
							+ "d2.brhid="+branch+" and d2.sr_no=1) left join my_unclrchqreceiptd d3 on (m.doc_no=d3.rdocno and d3.brhid="+branch+" and d3.sr_no=2) left join my_curr c on (d.curid=c.doc_no) "
							+ "left join my_brch b on (m.brhid=b.doc_no) left join  my_head t on (d.acno=t.doc_no ) left join my_head t1 on (d2.acno=t1.doc_no) left join my_head t2 on (d3.acno=t2.doc_no) "
							+ "where m.status=3 and m.bpvno=0 and m.brhid="+branch+""+xsql+"";
			        	
			        	
			        	System.out.println("receipt grid loading====="+xsql);
			        	
						ResultSet resultSet = stmtUCPP.executeQuery(xsql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
		         }
				}
				
				stmtUCPP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray bankPaymentGridReloading(HttpSession session,String docNo,String dtype,String postingDate,String check) throws SQLException {
	      
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
	      String branch = session.getAttribute("BRANCHID").toString();
	      
			try {
					conn = connDAO.getMyConnection();
					Statement stmtUCPP = conn.createStatement();
				
					if(check.equalsIgnoreCase("1")){
						
						if(dtype.equalsIgnoreCase("UCP")){
							
							String sql = "";
							
							sql = "SELECT m.date,m.RefNo,m.pdc,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,"
								+ "c.type currencytype,d.curId currencyid,d.rate rate,if(d.dr>0,true,false) dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,"
								+ "CONVERT(CONCAT('UCP - ',m.doc_no,' of Cheque No. ',m.chqno,' Dated ',DATE_FORMAT(m.chqdt,'%d.%m.%Y'),' is POSTED as BPV on "+postingDate+"'),CHAR(100)) description,"
								+ "d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_unclrchqbm m left join my_unclrchqbd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) "
								+ "left join my_costunit f on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE "
								+ "m.brhId='"+branch+"' and m.doc_no="+docNo+"";
							
							ResultSet resultSet = stmtUCPP.executeQuery(sql);
							RESULTDATA=commonDAO.convertToJSON(resultSet);
							
						} else if(dtype.equalsIgnoreCase("UCR")){
							
							String sql = "";
							
							sql = "SELECT m.date,m.RefNo,m.pdc,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,"
								+ "c.type currencytype,d.curId currencyid,d.rate rate,if(d.dr>0,true,false) dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,"
								+ "CONVERT(CONCAT('UCR - ',m.doc_no,' of Cheque No. ',m.chqno,' Dated ',DATE_FORMAT(m.chqdt,'%d.%m.%Y'),' is POSTED as BRV on "+postingDate+"'),CHAR(100)) description,"
								+ "d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) left join my_costunit f on "
								+ "d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.brhId='"+branch+"' and m.doc_no="+docNo+"";
							
							ResultSet resultSet = stmtUCPP.executeQuery(sql);
							RESULTDATA=commonDAO.convertToJSON(resultSet);
						}
					
					}
					
					stmtUCPP.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return RESULTDATA;
	  }
}	
