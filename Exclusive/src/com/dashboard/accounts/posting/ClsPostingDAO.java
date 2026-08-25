package com.dashboard.accounts.posting;

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
import com.finance.interbranchtransactions.ibjournalvouchers.ClsIbJournalVouchersDAO;
import com.finance.transactions.contratrans.ClsContraTransDAO;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsPostingDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public int insert(int chckib,String txtibbranch,String mainbranch,String type,Date postedDate,double txtdrtotal,String txtchequedescription,String txtselectedrno, int txtdocno, String[] tranarray,ArrayList<String> postingarray, ArrayList<String> ibpostingarray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 Connection conn  = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
		        
		        int docno = 0,docNo=0;
		        int trno = 0;
		        String posttype="";
				
		        if(chckib==0 && type.equalsIgnoreCase("1")){
		        	ArrayList<String> blankarray = new ArrayList<String>();
		        	ArrayList<String> blankarray1 = new ArrayList<String>();
		        	ArrayList<String> blankarray2 = new ArrayList<String>();
		        	ArrayList<String> cashpaymentarray = new ArrayList<String>();
			        
		        	String[] fromtocontratrans=postingarray.get(0).split("::");
		        	String[] tocontratrans=postingarray.get(1).split("::");
		        	
		        	/*Inserting into my_contratrans,my_cashbm,my_cashbd and my_jvtran*/
					    
			        	ClsContraTransDAO cot = new ClsContraTransDAO();
			        	
			        	int fromdocno = (Integer.parseInt((fromtocontratrans[0].trim().equalsIgnoreCase("undefined") || fromtocontratrans[0].trim().equalsIgnoreCase("NaN") || fromtocontratrans[0].trim().isEmpty()?"0":fromtocontratrans[0].trim().toString())));
			        	String fromcurrency = ((fromtocontratrans[2].trim().equalsIgnoreCase("undefined") || fromtocontratrans[2].trim().equalsIgnoreCase("NaN") || fromtocontratrans[2].trim().isEmpty()?0:fromtocontratrans[2].trim()).toString());
			        	Double fromrate = ((fromtocontratrans[3].equalsIgnoreCase("undefined") || fromtocontratrans[3].equalsIgnoreCase("NaN") || fromtocontratrans[3].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[3])));
			        	Double fromamount = ((fromtocontratrans[4].equalsIgnoreCase("undefined") || fromtocontratrans[4].equalsIgnoreCase("NaN") || fromtocontratrans[4].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[4])));
			        	Double frombaseamount = ((fromtocontratrans[5].equalsIgnoreCase("undefined") || fromtocontratrans[5].equalsIgnoreCase("NaN") || fromtocontratrans[5].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[5])));
			        	String fromdescription = ((fromtocontratrans[1].trim().equalsIgnoreCase("undefined") || fromtocontratrans[1].trim().equalsIgnoreCase("NaN") || fromtocontratrans[1].trim().isEmpty()?"":fromtocontratrans[1].trim()).toString());
						
			        	int todocno = (Integer.parseInt((tocontratrans[0].trim().equalsIgnoreCase("undefined") || tocontratrans[0].trim().equalsIgnoreCase("NaN") || tocontratrans[0].trim().isEmpty()?"0":tocontratrans[0].trim().toString())));
			        	String tocurrency = ((tocontratrans[2].trim().equalsIgnoreCase("undefined") || tocontratrans[2].trim().equalsIgnoreCase("NaN") || tocontratrans[2].trim().isEmpty()?0:tocontratrans[2].trim()).toString());
			        	Double torate = ((tocontratrans[3].equalsIgnoreCase("undefined") || tocontratrans[3].equalsIgnoreCase("NaN") || tocontratrans[3].isEmpty()?0.0:Double.parseDouble(tocontratrans[3])));
			        	Double toamount = ((tocontratrans[4].equalsIgnoreCase("undefined") || tocontratrans[4].equalsIgnoreCase("NaN") || tocontratrans[4].isEmpty()?0.0:Double.parseDouble(tocontratrans[4])));
			        	Double tobaseamount = ((tocontratrans[5].equalsIgnoreCase("undefined") || tocontratrans[5].equalsIgnoreCase("NaN") || tocontratrans[5].isEmpty()?0.0:Double.parseDouble(tocontratrans[5])));
			        	String todescription = ((tocontratrans[1].trim().equalsIgnoreCase("undefined") || tocontratrans[1].trim().equalsIgnoreCase("NaN") || tocontratrans[1].trim().isEmpty()?"":tocontratrans[1].trim()).toString());
						
			        	cashpaymentarray.add(fromdocno+"::"+fromcurrency+"::"+fromrate+"::false::"+fromamount+"::"+fromdescription+"::"+frombaseamount+"::0:: 0:: 0");
			        	cashpaymentarray.add(todocno+"::"+tocurrency+"::"+torate+"::true::"+toamount+"::"+todescription+"::"+tobaseamount+"::0:: 0:: 0");
			        	
						posttype="COT";
						
					    docno=cot.insert(postedDate, "COT", "BPO", "CASH", fromdocno, fromcurrency, fromrate, 0, 0, "0",postedDate, fromamount, frombaseamount, 
					    		"Posted as COT on"+postedDate, 0, null, "BANK", todocno, tocurrency, torate,toamount, tobaseamount, cashpaymentarray, blankarray, blankarray1, 
					    		blankarray2, session, request, mode);
					    trno=Integer.parseInt(request.getAttribute("tranno").toString());
					
					    double dramount=0.0;
					     
					    String sql="select dramount from my_contratrans where tr_no="+trno+"";
					    ResultSet resultSet = stmtBPO.executeQuery(sql);
						  
					    while (resultSet.next()) {
					        dramount=resultSet.getDouble("dramount");
					    }
					       
					    if(dramount<0){
						     String sql1="update my_contratrans c,my_contratrans c1 set c.dramount=(c1.dramount)*-1,c.lamount=(c1.lamount)*-1 where c.tr_no="+trno+"";
							 int data1= stmtBPO.executeUpdate(sql1);
							 if(data1<=0){
								    stmtBPO.close();
									conn.close();
									return 0;
								}
					    }
					/*Inserting my_contratrans,my_cashbm,my_cashbd and my_jvtran Ends*/
					
			    }
		        
		        else if(chckib==1 && type.equalsIgnoreCase("1")){
		        	ArrayList<String> blankarray = new ArrayList<String>();
		        	ArrayList<String> blankarray1 = new ArrayList<String>();
		        	ArrayList<String> blankarray2 = new ArrayList<String>();
		        	ArrayList<String> ibcashpaymentarray = new ArrayList<String>();
			        
		        	String[] fromtocontratrans=postingarray.get(0).split("::");
		        	String[] tocontratrans=postingarray.get(1).split("::");
		        	
		        	/*Inserting into my_contratrans,my_cashbm,my_cashbd and my_jvtran*/
					    
			        	ClsContraTransDAO cot = new ClsContraTransDAO();
			        	
			        	int fromdocno = (Integer.parseInt((fromtocontratrans[0].trim().equalsIgnoreCase("undefined") || fromtocontratrans[0].trim().equalsIgnoreCase("NaN") || fromtocontratrans[0].trim().isEmpty()?"0":fromtocontratrans[0].trim().toString())));
			        	String fromcurrency = ((fromtocontratrans[2].trim().equalsIgnoreCase("undefined") || fromtocontratrans[2].trim().equalsIgnoreCase("NaN") || fromtocontratrans[2].trim().isEmpty()?0:fromtocontratrans[2].trim()).toString());
			        	Double fromrate = ((fromtocontratrans[3].equalsIgnoreCase("undefined") || fromtocontratrans[3].equalsIgnoreCase("NaN") || fromtocontratrans[3].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[3])));
			        	Double fromamount = ((fromtocontratrans[4].equalsIgnoreCase("undefined") || fromtocontratrans[4].equalsIgnoreCase("NaN") || fromtocontratrans[4].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[4])));
			        	Double frombaseamount = ((fromtocontratrans[5].equalsIgnoreCase("undefined") || fromtocontratrans[5].equalsIgnoreCase("NaN") || fromtocontratrans[5].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[5])));
			        	String fromdescription = ((fromtocontratrans[1].trim().equalsIgnoreCase("undefined") || fromtocontratrans[1].trim().equalsIgnoreCase("NaN") || fromtocontratrans[1].trim().isEmpty()?"":fromtocontratrans[1].trim()).toString());
						
			        	int todocno = (Integer.parseInt((tocontratrans[0].trim().equalsIgnoreCase("undefined") || tocontratrans[0].trim().equalsIgnoreCase("NaN") || tocontratrans[0].trim().isEmpty()?"0":tocontratrans[0].trim().toString())));
			        	String tocurrency = ((tocontratrans[2].trim().equalsIgnoreCase("undefined") || tocontratrans[2].trim().equalsIgnoreCase("NaN") || tocontratrans[2].trim().isEmpty()?0:tocontratrans[2].trim()).toString());
			        	Double torate = ((tocontratrans[3].equalsIgnoreCase("undefined") || tocontratrans[3].equalsIgnoreCase("NaN") || tocontratrans[3].isEmpty()?0.0:Double.parseDouble(tocontratrans[3])));
			        	Double toamount = ((tocontratrans[4].equalsIgnoreCase("undefined") || tocontratrans[4].equalsIgnoreCase("NaN") || tocontratrans[4].isEmpty()?0.0:Double.parseDouble(tocontratrans[4])));
			        	Double tobaseamount = ((tocontratrans[5].equalsIgnoreCase("undefined") || tocontratrans[5].equalsIgnoreCase("NaN") || tocontratrans[5].isEmpty()?0.0:Double.parseDouble(tocontratrans[5])));
			        	String todescription = ((tocontratrans[1].trim().equalsIgnoreCase("undefined") || tocontratrans[1].trim().equalsIgnoreCase("NaN") || tocontratrans[1].trim().isEmpty()?"":tocontratrans[1].trim()).toString());
						
			        	ibcashpaymentarray.add(fromdocno+"::"+fromcurrency+"::"+fromrate+"::false::"+fromamount+"::"+fromdescription+"::"+frombaseamount+"::0:: 0:: 0:: "+mainbranch+":: "+mainbranch);
			        	ibcashpaymentarray.add(todocno+"::"+tocurrency+"::"+torate+"::true::"+toamount+"::"+todescription+"::"+tobaseamount+"::0:: 0:: 0:: "+txtibbranch+":: "+mainbranch);
			        	
						posttype="COT";
						
					    docno=cot.insert(postedDate, "COT", "BPO", "CASH", fromdocno, fromcurrency, fromrate, 0, 0, "0",postedDate, fromamount, frombaseamount, 
					    		"Posted as COT on"+postedDate, 1, txtibbranch, "BANK", todocno, tocurrency, torate,toamount, tobaseamount, blankarray, ibcashpaymentarray, blankarray1, 
					    		blankarray2, session, request, mode);
					    trno=Integer.parseInt(request.getAttribute("tranno").toString());
					    
						double dramount=0.0;
					     
					    String sql="select dramount from my_contratrans where tr_no="+trno+"";
					    ResultSet resultSet = stmtBPO.executeQuery(sql);
						  
					    while (resultSet.next()) {
					        dramount=resultSet.getDouble("dramount");
					    }
					       
					    if(dramount<0){
						     String sql1="update my_contratrans c,my_contratrans c1 set c.dramount=(c1.dramount)*-1,c.lamount=(c1.lamount)*-1 where c.tr_no="+trno+"";
							 int data1= stmtBPO.executeUpdate(sql1);
							 if(data1<=0){
								    stmtBPO.close();
									conn.close();
									return 0;
								}
					    }
					/*Inserting my_contratrans,my_cashbm,my_cashbd and my_jvtran Ends*/
					
			    }
		        
		        else if(chckib==0 && (type.equalsIgnoreCase("2") || type.equalsIgnoreCase("4"))){
				
		        /*Inserting into my_jvma and my_jvtran*/
				    
		        	ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
				    posttype="JVT";
					docno=jvt.insert(postedDate,"JVT".concat("-8"), "BP0", "Card is posted as JVT on "+postedDate ,txtdrtotal, txtdrtotal, postingarray, session, request);
				    trno=Integer.parseInt(request.getAttribute("tranno").toString());
				
				/*Inserting my_jvma and my_jvtran Ends*/
				
		        }
		        
		        else if(chckib==1 && (type.equalsIgnoreCase("2") || type.equalsIgnoreCase("4"))){
			        /*Inserting into my_jvma and my_jvtran*/
		        	    
			        	ClsIbJournalVouchersDAO ijv = new ClsIbJournalVouchersDAO();
					    posttype="IJV";
						docno=ijv.insert(postedDate, "IJV".concat("-8"), "BPO", "Card is posted as IJV on "+postedDate, txtdrtotal, txtdrtotal, ibpostingarray, session, request, mode);
					    trno=Integer.parseInt(request.getAttribute("tranno").toString());
					
					/*Inserting my_jvma and my_jvtran Ends*/
					
			        }
		        
		        else if(chckib==0 && type.equalsIgnoreCase("3")){
		        	ArrayList<String> blankarray = new ArrayList<String>();
		        	ArrayList<String> blankarray1 = new ArrayList<String>();
		        	ArrayList<String> blankarray2 = new ArrayList<String>();
		        	ArrayList<String> bankpaymentarray = new ArrayList<String>();
			        
		        	String[] fromtocontratrans=postingarray.get(0).split("::");
		        	String[] tocontratrans=postingarray.get(1).split("::");
		        	
		        	/*Inserting into my_contratrans,my_chqbm,my_chqbd and my_jvtran*/
					    
			        	ClsContraTransDAO cot = new ClsContraTransDAO();
			        	
			        	int fromdocno = (Integer.parseInt((fromtocontratrans[0].trim().equalsIgnoreCase("undefined") || fromtocontratrans[0].trim().equalsIgnoreCase("NaN") || fromtocontratrans[0].trim().isEmpty()?"0":fromtocontratrans[0].trim().toString())));
			        	String fromcurrency = ((fromtocontratrans[2].trim().equalsIgnoreCase("undefined") || fromtocontratrans[2].trim().equalsIgnoreCase("NaN") || fromtocontratrans[2].trim().isEmpty()?0:fromtocontratrans[2].trim()).toString());
			        	Double fromrate = ((fromtocontratrans[3].equalsIgnoreCase("undefined") || fromtocontratrans[3].equalsIgnoreCase("NaN") || fromtocontratrans[3].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[3])));
			        	Double fromamount = ((fromtocontratrans[4].equalsIgnoreCase("undefined") || fromtocontratrans[4].equalsIgnoreCase("NaN") || fromtocontratrans[4].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[4])));
			        	Double frombaseamount = ((fromtocontratrans[5].equalsIgnoreCase("undefined") || fromtocontratrans[5].equalsIgnoreCase("NaN") || fromtocontratrans[5].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[5])));
						
			        	int todocno = (Integer.parseInt((tocontratrans[0].trim().equalsIgnoreCase("undefined") || tocontratrans[0].trim().equalsIgnoreCase("NaN") || tocontratrans[0].trim().isEmpty()?"0":tocontratrans[0].trim().toString())));
			        	String tocurrency = ((tocontratrans[2].trim().equalsIgnoreCase("undefined") || tocontratrans[2].trim().equalsIgnoreCase("NaN") || tocontratrans[2].trim().isEmpty()?0:tocontratrans[2].trim()).toString());
			        	Double torate = ((tocontratrans[3].equalsIgnoreCase("undefined") || tocontratrans[3].equalsIgnoreCase("NaN") || tocontratrans[3].isEmpty()?0.0:Double.parseDouble(tocontratrans[3])));
			        	Double toamount = ((tocontratrans[4].equalsIgnoreCase("undefined") || tocontratrans[4].equalsIgnoreCase("NaN") || tocontratrans[4].isEmpty()?0.0:Double.parseDouble(tocontratrans[4])));
			        	Double tobaseamount = ((tocontratrans[5].equalsIgnoreCase("undefined") || tocontratrans[5].equalsIgnoreCase("NaN") || tocontratrans[5].isEmpty()?0.0:Double.parseDouble(tocontratrans[5])));
						
			        	bankpaymentarray.add(fromdocno+"::"+fromcurrency+"::"+fromrate+"::false::"+fromamount+"::"+txtchequedescription+"::"+frombaseamount+"::0:: 0:: 0:: 0:: 0");
			        	bankpaymentarray.add(todocno+"::"+tocurrency+"::"+torate+"::true::"+toamount+"::"+txtchequedescription+"::"+tobaseamount+"::0:: 0:: 0:: 0:: 0");
			        	
						posttype="COT";
						
					    docno=cot.insert(postedDate, "COT", "BPO", "BANK", fromdocno, fromcurrency, fromrate, 0, 0, "0",postedDate, fromamount, frombaseamount, 
					    		"Posted as COT on"+postedDate, 0, null, "BANK", todocno, tocurrency, torate,toamount, tobaseamount, blankarray, blankarray1, bankpaymentarray, 
					    		blankarray2, session, request, mode);
					    trno=Integer.parseInt(request.getAttribute("tranno").toString());
					    
						double dramount=0.0;
					     
					    String sql="select dramount from my_contratrans where tr_no="+trno+"";
					    ResultSet resultSet = stmtBPO.executeQuery(sql);
						  
					    while (resultSet.next()) {
					        dramount=resultSet.getDouble("dramount");
					    }
					       
					    if(dramount<0){
						     String sql1="update my_contratrans c,my_contratrans c1 set c.dramount=(c1.dramount)*-1,c.lamount=(c1.lamount)*-1 where c.tr_no="+trno+"";
							 int data1= stmtBPO.executeUpdate(sql1);
							 if(data1<=0){
								    stmtBPO.close();
									conn.close();
									return 0;
								}
					    }
					/*Inserting my_contratrans,my_chqbm,my_chqbd and my_jvtran Ends*/
					
			    }
		        
		        else if(chckib==1 && type.equalsIgnoreCase("3")){
		        	ArrayList<String> blankarray = new ArrayList<String>();
		        	ArrayList<String> blankarray1 = new ArrayList<String>();
		        	ArrayList<String> blankarray2 = new ArrayList<String>();
		        	ArrayList<String> ibbankpaymentarray = new ArrayList<String>();
			        
		        	String[] fromtocontratrans=postingarray.get(0).split("::");
		        	String[] tocontratrans=postingarray.get(1).split("::");
		        	
		        	/*Inserting into my_contratrans,my_chqbm,my_chqbd and my_jvtran*/
					    
			        	ClsContraTransDAO cot = new ClsContraTransDAO();
			        	
			        	int fromdocno = (Integer.parseInt((fromtocontratrans[0].trim().equalsIgnoreCase("undefined") || fromtocontratrans[0].trim().equalsIgnoreCase("NaN") || fromtocontratrans[0].trim().isEmpty()?"0":fromtocontratrans[0].trim().toString())));
			        	String fromcurrency = ((fromtocontratrans[2].trim().equalsIgnoreCase("undefined") || fromtocontratrans[2].trim().equalsIgnoreCase("NaN") || fromtocontratrans[2].trim().isEmpty()?0:fromtocontratrans[2].trim()).toString());
			        	Double fromrate = ((fromtocontratrans[3].equalsIgnoreCase("undefined") || fromtocontratrans[3].equalsIgnoreCase("NaN") || fromtocontratrans[3].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[3])));
			        	Double fromamount = ((fromtocontratrans[4].equalsIgnoreCase("undefined") || fromtocontratrans[4].equalsIgnoreCase("NaN") || fromtocontratrans[4].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[4])));
			        	Double frombaseamount = ((fromtocontratrans[5].equalsIgnoreCase("undefined") || fromtocontratrans[5].equalsIgnoreCase("NaN") || fromtocontratrans[5].isEmpty()?0.0:Double.parseDouble(fromtocontratrans[5])));
			        	
			        	int todocno = (Integer.parseInt((tocontratrans[0].trim().equalsIgnoreCase("undefined") || tocontratrans[0].trim().equalsIgnoreCase("NaN") || tocontratrans[0].trim().isEmpty()?"0":tocontratrans[0].trim().toString())));
			        	String tocurrency = ((tocontratrans[2].trim().equalsIgnoreCase("undefined") || tocontratrans[2].trim().equalsIgnoreCase("NaN") || tocontratrans[2].trim().isEmpty()?0:tocontratrans[2].trim()).toString());
			        	Double torate = ((tocontratrans[3].equalsIgnoreCase("undefined") || tocontratrans[3].equalsIgnoreCase("NaN") || tocontratrans[3].isEmpty()?0.0:Double.parseDouble(tocontratrans[3])));
			        	Double toamount = ((tocontratrans[4].equalsIgnoreCase("undefined") || tocontratrans[4].equalsIgnoreCase("NaN") || tocontratrans[4].isEmpty()?0.0:Double.parseDouble(tocontratrans[4])));
			        	Double tobaseamount = ((tocontratrans[5].equalsIgnoreCase("undefined") || tocontratrans[5].equalsIgnoreCase("NaN") || tocontratrans[5].isEmpty()?0.0:Double.parseDouble(tocontratrans[5])));
			        	
			        	ibbankpaymentarray.add(fromdocno+"::"+fromcurrency+"::"+fromrate+"::false::"+fromamount+"::"+txtchequedescription+"::"+frombaseamount+"::0:: 0:: 0:: "+mainbranch+":: "+mainbranch+":: 0:: 0");
			        	ibbankpaymentarray.add(todocno+"::"+tocurrency+"::"+torate+"::true::"+toamount+"::"+txtchequedescription+"::"+tobaseamount+"::0:: 0:: 0:: "+txtibbranch+":: "+mainbranch+":: 0:: 0");
			        	
						posttype="COT";
						
					    docno=cot.insert(postedDate, "COT", "BPO", "BANK", fromdocno, fromcurrency, fromrate, 0, 0, "0",postedDate, fromamount, frombaseamount, 
					    		"Posted as COT on"+postedDate, 1, txtibbranch, "BANK", todocno, tocurrency, torate,toamount, tobaseamount, blankarray, blankarray1, blankarray2, 
					    		ibbankpaymentarray, session, request, mode);
					    trno=Integer.parseInt(request.getAttribute("tranno").toString());
					
					    double dramount=0.0;
					     
					    String sql="select dramount from my_contratrans where tr_no="+trno+"";
					    ResultSet resultSet = stmtBPO.executeQuery(sql);
						  
					    while (resultSet.next()) {
					        dramount=resultSet.getDouble("dramount");
					    }
					       
					    if(dramount<0){
						     String sql1="update my_contratrans c,my_contratrans c1 set c.dramount=(c1.dramount)*-1,c.lamount=(c1.lamount)*-1 where c.tr_no="+trno+"";
							 int data1= stmtBPO.executeUpdate(sql1);
							 if(data1<=0){
								    stmtBPO.close();
									conn.close();
									return 0;
								}
					    }
					/*Inserting my_contratrans,my_chqbm,my_chqbd and my_jvtran Ends*/
					
			    }
				
				/*Deleting account of value zero*/
				String sql3=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				int datas1 = stmtBPO.executeUpdate(sql3);
				/*Deleting account of value zero ends*/
				
				/*Deleting dramount and ldramount of value zero*/
			    String sql4=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
			    int datas2 = stmtBPO.executeUpdate(sql4);
			    /*Deleting dramount and ldramount of value zero ends*/
		        
		       /*Updating gl_rentreceipt/gl_rentrefund*/
				for (int i = 0; i < tranarray.length; i++) {
					String tranno=tranarray[i];	
					
					if(!(tranno.equalsIgnoreCase(""))){
						 String sql1="";
						 if(type.equalsIgnoreCase("4")){
							 sql1="update gl_rentrefund set refundno="+docno+",posttype='"+posttype+"',posttrno="+trno+" where tr_no="+tranno+"";
						 }else{
							 sql1="update gl_rentreceipt set jvno="+docno+",posttype='"+posttype+"',posttrno="+trno+" where tr_no="+tranno+"";
						 }
							 int data= stmtBPO.executeUpdate(sql1);
							 if(data<=0){
							    stmtBPO.close();
								conn.close();
								return 0;
							}
						}
				}
				/*Updating gl_rentreceipt/gl_rentrefund Ends*/
				
			    String sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bpo";
		        ResultSet resultSet = stmtBPO.executeQuery(sql);
		  
		        while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
		        }
				
		        if(txtibbranch.trim().equalsIgnoreCase("")){
		        	txtibbranch="0";
		        }
		        
		        /*Inserting gl_bpo*/
			     String sql2="insert into gl_bpo(doc_no, date, tr_no, type, postedtype, postedno, brhid, ib, ibbrhid, bank_acno, receiptno, userid) values("+docNo+", '"+postedDate+"', '"+trno+"', '"+type+"', '"+posttype+"', "+docno+", '"+branch+"', '"+chckib+"', '"+txtibbranch+"', "+txtdocno+", '"+txtselectedrno+"', '"+userid+"')";
			     int data1= stmtBPO.executeUpdate(sql2);
				 if(data1<=0){
					    stmtBPO.close();
						conn.close();
						return 0;
					}
				 /*Inserting gl_bpo Ends*/
				 
				if(docno>0){
					
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BPO',now(),'"+userid+"','A')";
					 int datas= stmtBPO.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBPO.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBPO.close();
					conn.close();
					return docno;
				}
			stmtBPO.close();
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
	
	public JSONArray postingGridLoading(String branch,String fromdate,String todate,String paytype,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
	           
		       java.sql.Date sqlFromDate = null;
		       java.sql.Date sqlToDate = null;
		        
		        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		        	 sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		        	 sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        int method=0;
		        String sqlsss="select method from gl_config where field_nme='cardno'";
		        ResultSet rs = stmtBPO.executeQuery(sqlsss);
		        if(rs.next()){
		        	method=rs.getInt("method");	     
		        }
		        
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sql="";
		       
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        	if(!((branch.equalsIgnoreCase("")))){
		        	  sql+=" and r.brhid="+branch+"";
		        	}
	    		}
		        
		        if(paytype.equalsIgnoreCase("3")){
		        	
	        	sql="select r.srno,'RRV#' type,r.date,Convert(concat(r.dtype,' - ',r.rdocno),CHAR(100)) documentno,r.tr_no,r.brhid,r.dtype,r.rdocno,r.acno,r.refno,"
	        	   + "r.refdate,a.acno clacno,r.cldocno,a.refname,r.paydesc,if(r.cardtype='0','',if(r.cardtype='1','VISA','MASTER')) cardtype,if(r.payas=1,'On Account',"
	        	   + "if(r.payas=2,'Advance','Security')) paidas,round(r.netamt,2) netamt from gl_rentreceipt r left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' "
	        	   + "left join my_chqdet c on r.tr_no=c.tr_no where r.status=3 and r.jvno=0 and r.paytype="+paytype+" and r.date>='"+sqlFromDate+"' and  r.date<='"+sqlToDate+"' "
	        	   + "and c.pdc=0 "+sql+" order by r.date asc";
		        	
		        }else if(paytype.equalsIgnoreCase("4")){
		        	
	        	sql="select r.srno,'RRP#' type,r.date,Convert(concat(r.dtype,' - ',r.rdocno),CHAR(100)) documentno,r.tr_no,r.brhid,r.dtype,r.rdocno,r.acno,"
	        	  + "if(r.cardtype='0','',cd.mode) cardtype,if(r.chequeno=0,'  ',lpad(substr(r.chequeno,-4),16,'X')) chequeno,Convert(if(r.chequeno='0','',"
	        	  + "r.chequedate),CHAR(50)) chequedate,Convert(if(r.rtype is null,'',concat(r.rtype,' - ',r.aggno)),CHAR(100)) agreement,a.acno clacno,r.cldocno,a.refname,"
	        	  + "r.refunddesc,if(r.paidas=1,'Security','On Account') paidas,if(r.paidas=1,round(r.netamt,2),round(r.onaccountamt,2)) netamt from gl_rentrefund r left join my_acbook a on r.cldocno=a.cldocno "
	        	  + "and a.dtype='CRM' left join my_cardm cd on r.cardtype=cd.doc_no and cd.id=1 and cd.dtype='card' where r.status=3 and r.cardtype!=0 and r.refundno=0 and "
	        	  + "r.date>='"+sqlFromDate+"' and  r.date<='"+sqlToDate+"' "+sql+" order by r.date asc";
		        	
		        }else{
		        	if(method==0){
		        		sql="select r.srno,'RRV#' type,r.date,Convert(concat(r.dtype,' - ',r.rdocno),CHAR(100)) documentno,r.tr_no,r.brhid,r.dtype,r.rdocno,r.acno,"
		    	        		+ "if(r.paytype=2,lpad(substr(r.refno,-4),16,'X'),r.refno) refno,r.refdate,a.acno clacno,r.cldocno,a.refname,r.paydesc,if(r.cardtype='0','',cd.mode) cardtype,"
		    	        		+ "if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) paidas,round(r.netamt,2) netamt from gl_rentreceipt r left join my_acbook a on "
		    	        		+ "r.cldocno=a.cldocno and a.dtype='CRM' left join my_cardm cd on r.cardtype=cd.doc_no and cd.id=1 and cd.dtype='card' where r.status=3 and r.jvno=0 "
		    	        		+ "and r.paytype="+paytype+" and r.date>='"+sqlFromDate+"' and  r.date<='"+sqlToDate+"' "+sql+" order by r.date asc";
		        	}else{
		        		sql="select r.srno,'RRV#' type,r.date,Convert(concat(r.dtype,' - ',r.rdocno),CHAR(100)) documentno,r.tr_no,r.brhid,r.dtype,r.rdocno,r.acno,"
				        		+ " r.refno,r.refdate,a.acno clacno,r.cldocno,a.refname,r.paydesc,if(r.cardtype='0','',cd.mode) cardtype,"
				        		+ "if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) paidas,round(r.netamt,2) netamt from gl_rentreceipt r left join my_acbook a on "
				        		+ "r.cldocno=a.cldocno and a.dtype='CRM' left join my_cardm cd on r.cardtype=cd.doc_no and cd.id=1 and cd.dtype='card' where r.status=3 and r.jvno=0 "
				        		+ "and r.paytype="+paytype+" and r.date>='"+sqlFromDate+"' and  r.date<='"+sqlToDate+"'"+sql+" order by r.date asc";
		        	}
	        	
		        }
               System.out.println("grid loading---->>>"+sql);
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
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
	  
	public  JSONArray refundJournalDetailGridLoading(String branch,String trno,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sql="";
		       
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        	if(!((branch.equalsIgnoreCase("")))){
		        	  sql+=" and j.brhid="+branch+"";
		        	}
	    		}
		        

		       sql = "select j.acno docno,if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,round(j.ldramount*j.id,2) "
		       		+ "baseamount,j.description,j.curId currencyid,round(j.rate,2) rate,j.ref_row sr_no,h.account accounts,h.description accountname1,h.atype type,"
		       		+ "h.gr_type grtype,cr.type currencytype from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where "
		       		+ "j.tr_no="+trno+""+sql+"";
		       
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
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
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
	
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
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		        
		        date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
		           }
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 and t.den=305"+sqltest;
		        
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	          stmtBPO.close();
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

	public JSONArray branchlist(HttpSession session,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBPO = conn.createStatement();

				String company = session.getAttribute("COMPANYID").toString();
				
				String sql="select branchname,doc_no from my_brch where cmpid="+company;
				
				ResultSet resultSet = stmtBPO.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBPO.close();
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
	
	public JSONArray cardCommGridLoading(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBPO = conn.createStatement();

				String sql="select mode,round(commission,2) commission from my_cardm where dtype='card' and id=1";
				
				ResultSet resultSet = stmtBPO.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBPO.close();
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
	
}
