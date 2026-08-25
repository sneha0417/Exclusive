package com.procurement.purchase.purchaseorder;

import java.sql.CallableStatement;
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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
 

public class ClspurchaseorderDAO {

	
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn;
	public int insert(Date masterdate, Date deldate, String refno, int vendocno,
			int cmbcurr, double currate, String delterms, String payterms,
			String purdesc, double productTotal, double descPercentage,
			double descountVal, double roundOf, double netTotaldown,
			double servnettotal, double orderValue, int chkdiscount,
			HttpSession session, String mode,  
			String formdetailcode, HttpServletRequest request, ArrayList <String> descarray, ArrayList <String> masterarray, String reftype,
			String rrefno, double prddiscount, ArrayList<String> termsarray , ArrayList<String> shiparray,int shipdocno,
			 double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype,int itermtype,int costtrno) throws SQLException  {
		 
		
		try{
			
			
			 
			
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtpurorder.registerOutParameter(24, java.sql.Types.INTEGER);
 
			stmtpurorder.setDate(1,masterdate);
			stmtpurorder.setDate(2,deldate);
			stmtpurorder.setString(3,refno);
			stmtpurorder.setInt(4,vendocno);
		   	stmtpurorder.setInt(5,cmbcurr);
			stmtpurorder.setDouble(6,currate);
			stmtpurorder.setString(7,delterms); 
			stmtpurorder.setString(8,payterms);
			stmtpurorder.setString(9,purdesc);
			stmtpurorder.setDouble(10,productTotal);
			stmtpurorder.setDouble(11,descPercentage);
			stmtpurorder.setDouble(12,descountVal);
			stmtpurorder.setDouble(13,roundOf);
			stmtpurorder.setDouble(14,netTotaldown);
			stmtpurorder.setDouble(15,servnettotal);
			stmtpurorder.setDouble(16,orderValue);
			stmtpurorder.setString(17,session.getAttribute("USERID").toString());
			stmtpurorder.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(19,session.getAttribute("COMPANYID").toString());
			
			
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(21,formdetailcode);
			stmtpurorder.setString(22,mode);
			stmtpurorder.setInt(23,chkdiscount);
			stmtpurorder.setString(25,reftype);
			stmtpurorder.setString(26,rrefno);
			stmtpurorder.setDouble(27,prddiscount);
			 
			
			stmtpurorder.executeQuery();
			docno=stmtpurorder.getInt("docNo");
	 
			int vocno=stmtpurorder.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			int cosrcodemethod=0;			
			Statement coststmt=conn.createStatement();
			String chks="select method  from gl_prdconfig where field_nme='costcenter'";
			ResultSet rss1=coststmt.executeQuery(chks); 
			if(rss1.next())
			{
				
				cosrcodemethod=rss1.getInt("method");
			}
			
			if(cosrcodemethod>0)
			{
				String upcostsql="update my_ordm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			
			
			
			 Statement stmt1=conn.createStatement();

			int taxmethod=0;
			 Statement stmttax=conn.createStatement();
			 String chk="select method  from gl_prdconfig where field_nme='tax'";
			 ResultSet rssz=stmttax.executeQuery(chk); 
			 if(rssz.next())
			 {
			 	
				 taxmethod=rssz.getInt("method");
			 }
			 
			 
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+vendocno+"' ";
			   
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					taxmethod=0;
				}

			 int stacno=0;
			 int tax1acno=0;
			 int tax2acno=0;
			 int tax3acno=0;
			 
			 
			  if(taxmethod>0)
			  {
				  String sqltax1= " update my_ordm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
				  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
				  
				  System.out.println("======sqltax1========="+sqltax1);
				  
				  stmt1.executeUpdate(sqltax1);
			  }
			
			
			
			
			String rownochk="0";    
			
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     
				     if(chkqty>0){
			    	
						 
				    	 
				         String unitidss=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
						    String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
						     
					    	 
					         
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
						     
						     System.out.println("====slss==="+slss);
						     ResultSet rv1=stmtpurorder.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
				    	 
		     String sql="INSERT INTO my_ordd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,taxper,taxamount,nettaxamount,taxdocno,prddesc,tr_no,rdocno,fr)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
				       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
				       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
				       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
				       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
				       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
				       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
				       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
				       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
				       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
				         + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"',"
				       + "'"+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"',"
				       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
				       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
				          + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
				       +"'"+docno+"','"+docno+"',"+fr+")";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				  
				     
				    // rrefno
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     String  unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
					    
				     String  specnos=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
					    
				     
				     if(reftype.equalsIgnoreCase("PR"))
			         {
				    	 
				    	 
				    		 
				    		 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
							int unitid=0;
							int specno=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				  /*  	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty  from my_reqm m  left join  my_reqd d on m.tr_no=d.tr_no where \r\n" + 
				    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
				    	 */
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno  from my_reqm m  left join  my_reqd d on m.tr_no=d.tr_no where \r\n" + 
					    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and d.unitid="+unitids+" and d.specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
	 
			             System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");
								
								unitid=rs.getInt("unitid");
								specno=rs.getInt("specno");
								//System.out.println("---masterqty-----"+masterqty);	

							//	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							//	System.out.println("---qty-----"+qty);


								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_reqd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and unitid="+unitid+" and specno="+specno+"  ";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											//System.out.println("---remqty-1---"+remqty);
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
										//System.out.println("---masterqty--"+masterqty);
										
										//System.out.println("---balqty--"+balqty);
										
										
										//System.out.println("---remqty--2--"+remqty);
									}


									String sqls="update my_reqd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and unitid="+unitid+" and specno="+specno+"  ";
									//System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 


				    		
 
				    	 
 
				     
				     
				    	 }
				     
				     
	 	     
				     else if(reftype.equalsIgnoreCase("SOR"))
			         {
				    	 
				    	 
							String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
						    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 	 
					 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
							int unitid=0;
							int specno=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				  /*  	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.doc_no rowno,d.rdocno tr_no,d.out_qty  from my_sorderm m  left join  my_sorderd d on m.doc_no=d.rdocno where \r\n" + 
			out_qty	    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.doc_no not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.doc_no having  sum((d.qty-d.out_qty)>0) order by m.date,d.doc_no ";
				    	 */
				      	 
				     	 String strSql="select d.qty ,sum((d.qty-d.p_qty)) balqty,d.doc_no rowno,d.rdocno tr_no,d.p_qty out_qty,d.unitid,d.specno    from my_sorderm m  left join  my_sorderd d on m.doc_no=d.rdocno where \r\n" + 
					    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.doc_no not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"' and d.unitid="+unitids+" and d.specno="+specnos+"  group by d.doc_no having  sum((d.qty-d.p_qty)>0) order by m.date,d.doc_no ";
					    	 
	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");
								
								unitid=rs.getInt("unitid");
								specno=rs.getInt("specno");
								//System.out.println("---masterqty-----"+masterqty);	

							//	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							//	System.out.println("---qty-----"+qty);

								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_sorderd set p_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  doc_no="+rowno+"  and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";
									

								 	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											//System.out.println("---remqty-1---"+remqty);
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
										//System.out.println("---masterqty--"+masterqty);
										
										//System.out.println("---balqty--"+balqty);
										
										
										//System.out.println("---remqty--2--"+remqty);
									}


									String sqls="update my_sorderd set p_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  doc_no="+rowno+" and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";	
								 System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 

			         } 
					
					 
				     else if(reftype.equalsIgnoreCase("RFQ"))
			         {
				    	 
				    	 
					/*		String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
						    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 	 */
				    		 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
							int unitid=0;
							int specno=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.rdocno tr_no,d.out_qty,d.unitid,d.specno  from my_prfqm m  left join  my_prfqd d on m.doc_no=d.rdocno where \r\n" + 
					    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and d.unitid="+unitids+" and d.specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.rowno not in("+rownochk+")  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
					    	 
		 	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");
								unitid=rs.getInt("unitid");
								specno=rs.getInt("specno");
					 
								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_prfqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
									

								 	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

										 
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
									
									}


									String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";	
								 System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

							



								}


							} 

			         } 
					 
				     /*else if(reftype.equalsIgnoreCase("RFQ"))
			         {
				    	 
				    	 
							String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
						    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 	 
				    		 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.rdocno tr_no,d.out_qty  from my_prfqm m  left join  my_prfqd d on m.doc_no=d.rdocno where \r\n" + 
				    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.rowno not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
				    	 
	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");

					 
								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_prfqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and clstatus=0";
									

								 	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

										 
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
									
									}


									String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0";	
								 System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

							



								}


							} 

			         }
					 
				     */
				     
				      
				     
				 
			     }	   
			 }
			     
			     
			     
			      
				     
				     }
			
 
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO my_ordser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			

 

		 

			/*for(int i=0;i< termsarray.size();i++){


				String[] terms=((String) termsarray.get(i)).split("::");

		 

				if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




					String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+formdetailcode+"')";


				//	System.out.println("termsdet--->>>>Sql"+termsql);
				int	termsdet = stmtpurorder.executeUpdate (termsql);
					
					 if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}

				}
			}
*/			
			
			
			 

				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+docno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formdetailcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmtpurorder.executeUpdate (shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_ordm set shipdetid='"+shipdocno+"' where doc_no='"+docno+"' ";
				
				stmtpurorder.executeUpdate (updatesql);
				
			
	 
			if (docno > 0) {
				 conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
		
  

	
	
	





	public int update(int masterdoc_no, Date masterdate, Date deldate,
			String refno, int vendocno, int cmbcurr, double currate,
			String delterms, String payterms, String purdesc,
			double productTotal, double descPercentage, double descountVal,
			double roundOf, double netTotaldown, double servnettotal,
			double orderValue, int chkdiscount, HttpSession session,
			String mode, String formdetailcode, HttpServletRequest request,
			ArrayList<String> descarray, ArrayList<String> masterarray,  String reftype,
			String rrefno, double prddiscount, ArrayList<String> termsarray, String updatadata, ArrayList<String> shiparray, int shipdocno,
			 double stval, double tax1, double tax2, double tax3, double nettax, 
				int cmbbilltype,int itermtype,int costtrno) throws SQLException {
	 
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.setInt(20,masterdoc_no);
			stmtpurorder.setInt(24, 0);
 
			stmtpurorder.setDate(1,masterdate);
			stmtpurorder.setDate(2,deldate);
			stmtpurorder.setString(3,refno);
			stmtpurorder.setInt(4,vendocno);
		   	stmtpurorder.setInt(5,cmbcurr);
			stmtpurorder.setDouble(6,currate);
			stmtpurorder.setString(7,delterms); 
			stmtpurorder.setString(8,payterms);
			stmtpurorder.setString(9,purdesc);
			stmtpurorder.setDouble(10,productTotal);
			stmtpurorder.setDouble(11,descPercentage);
			stmtpurorder.setDouble(12,descountVal);
			stmtpurorder.setDouble(13,roundOf);
			stmtpurorder.setDouble(14,netTotaldown);
			stmtpurorder.setDouble(15,servnettotal);
			stmtpurorder.setDouble(16,orderValue);
			stmtpurorder.setString(17,session.getAttribute("USERID").toString());
			stmtpurorder.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(21,formdetailcode);
			stmtpurorder.setString(22,mode);
			stmtpurorder.setInt(23,chkdiscount);
			stmtpurorder.setString(25,reftype);
			stmtpurorder.setString(26,rrefno);
			stmtpurorder.setDouble(27,prddiscount);
		  
			
		    int res=stmtpurorder.executeUpdate();
			docno=stmtpurorder.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			
			int cosrcodemethod=0;			
			Statement coststmt=conn.createStatement();
			String chks="select method  from gl_prdconfig where field_nme='costcenter'";
			ResultSet rss1=coststmt.executeQuery(chks); 
			if(rss1.next())
			{
				
				cosrcodemethod=rss1.getInt("method");
			}
			
			if(cosrcodemethod>0)
			{
				String upcostsql="update my_ordm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			

			System.out.println("-updatadata--"+updatadata);
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{
			
			 
				
				
				 Statement stmt1=conn.createStatement();

				int taxmethod=0;
				 Statement stmttax=conn.createStatement();
				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }
				 
					int temptax=0;
					Statement stmt3111 = conn.createStatement (); 
					String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+vendocno+"' ";
				//  System.out.println("===sqlss======"+sqlss);
					ResultSet rsss=stmt3111.executeQuery(sqlss);
				    if(rsss.next())
				    {
				    	temptax=rsss.getInt("tax");
				    	
				    }
					if(temptax!=1)
					{
						taxmethod=0;
					}
				 int stacno=0;
				 int tax1acno=0;
				 int tax2acno=0;
				 int tax3acno=0;
				 
				 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_ordm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
					  
					  System.out.println("======sqltax1========="+sqltax1);
					  
					  stmt1.executeUpdate(sqltax1);
				  }
				
				
				
				
			
			
						String delsqls="delete from my_ordd where tr_no='"+masterdoc_no+"' ";
						stmtpurorder.executeUpdate(delsqls);
						
						String delsqlss="delete from my_ordser where tr_no='"+masterdoc_no+"' ";
						stmtpurorder.executeUpdate(delsqlss);
						
						
				//		String deltermssql="delete from my_trterms where rdocno='"+masterdoc_no+"' and  dtype='"+formdetailcode+"' ";
					//	stmtpurorder.executeUpdate(deltermssql);
						String deltermssqls="delete from my_deldetaild where rdocno='"+masterdoc_no+"' and  dtype='"+formdetailcode+"'  ";
						stmtpurorder.executeUpdate(deltermssqls);
			
					  	int	updateid=0;
						String rownochk="0";    
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     if(chkqty>0){
					         	String unitidss=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
										    String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
									         
										     double fr=1;
										     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
										     
										  //   System.out.println("====slss==="+slss);
										     ResultSet rv1=stmtpurorder.executeQuery(slss);
										     if(rv1.next())
										     {
										    	 fr=rv1.getDouble("fr"); 
										     }
								    	 
			    	 
			    	 
						     String sql="INSERT INTO my_ordd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,taxper,taxamount,nettaxamount,taxdocno,prddesc,tr_no,rdocno,fr)VALUES"
								       + " ("+(i+1)+","
								       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
								       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
								       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
								       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
								       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
								       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
								       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
								       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
								       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
								       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
				             	       + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"',"
				                       + "'"+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"',"
				                       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
				                       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
				                        + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
				                       +"'"+docno+"','"+docno+"',"+fr+")";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
				     
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
					  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     String  unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
					    
				     String  specnos=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
					    
				     if(reftype.equalsIgnoreCase("PR"))
			         {
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
				  
				    /*		 
				    		 if(pridforchk!=updateid)
				    		 {
				    		 */
				 			String sqlsw="update  my_reqd set out_qty=0 where tr_no in ("+rrefno+") and prdid="+pridforchk+" and unitid="+unitids+" and specno="+specnos+" and unitid="+unitids+" and specno="+specnos+" ";
		  
		    			//  System.out.println("-----"+sqls);
		    			   	
		    				stmtpurorder.executeUpdate(sqlsw);
		    				
		    			/*	updateid=pridforchk;
				    		 
				    		 }*/
		    				
				    		 
				   		 

					    	    double balqty=0;
								int rowno=0;
								int tr_no=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;
								int unitid=0;
								int specno=0;
					    	 Statement stmt=conn.createStatement();
					    	 
					    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno  from my_reqm m  left join  my_reqd d on m.tr_no=d.tr_no where \r\n" + 
					    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"'and d.unitid="+unitids+" and d.specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
					    	 
					    	 System.out.println("---strSql-----"+strSql);
					    		ResultSet rs = stmt.executeQuery(strSql);
					    		
					    		
					    		while(rs.next()) {


									balqty=rs.getDouble("balqty");
									tr_no=rs.getInt("tr_no");
									out_qty=rs.getDouble("out_qty");

									rowno=rs.getInt("rowno");
									qty=rs.getDouble("qty");
									
									unitid=rs.getInt("unitid");
									specno=rs.getInt("specno");

									//System.out.println("---masterqty-----"+masterqty);	

									//System.out.println("---balqty-----"+balqty);	

									//System.out.println("---out_qty-----"+out_qty);	
									//System.out.println("---qty-----"+qty);


									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										
										
										String sqls="update my_reqd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and unitid="+unitid+" and specno="+specno+"  ";
										

										//System.out.println("--1---sqls---"+sqls);


										stmtpurorder.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qty>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qty-out_qty;

												//System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											
											
											remqty=masterqty-balqty;
											balqty=qty;
											
										//	System.out.println("---masterqty--"+masterqty);
											
											//System.out.println("---balqty--"+balqty);
											
											
											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_reqd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and unitid="+unitid+" and specno="+specno+"  ";
										//System.out.println("-2----sqls---"+sqls);

										stmtpurorder.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								} 
				     
				    	     
				   				     
			     
				     
				     }
				     
				     
				     
				     
				     else if(reftype.equalsIgnoreCase("SOR"))
			         {
				    	 
				    	 Statement stmt2=conn.createStatement();
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
							String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
							    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 
			    		 
			 			 String sqls5="update  my_sorderd set p_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+"  and amount='"+amount+"' and disper='"+discper+"' and clstatus=0 and doc_no not in("+rownochk+") and unitid="+unitids+" and specno="+specnos+" ";
	  
	    			     System.out.println("-----"+sqls5);
	    			   	
			 			stmt2.executeUpdate(sqls5);
						
				    	 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
							int unitid=0;
							int specno=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				   /* 	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.doc_no rowno,d.rdocno tr_no,d.out_qty  from my_sorderm m  left join  my_sorderd d on m.doc_no=d.rdocno where \r\n" + 
				    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.doc_no not in("+rownochk+") group by d.doc_no   order by m.date,d.doc_no ";
				    	 */
				      	 String strSql="select d.qty ,sum((d.qty-d.p_qty)) balqty,d.doc_no rowno,d.rdocno tr_no,d.p_qty out_qty,d.unitid,d.specno  from my_sorderm m  left join  my_sorderd d on m.doc_no=d.rdocno where \r\n" + 
					    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"'  and d.unitid="+unitids+" and d.specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.doc_no not in("+rownochk+") group by d.doc_no   order by m.date,d.doc_no ";
					    	 
		 
				    	 
				    	 
				    	 
				    	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");
								unitid=rs.getInt("unitid");
								specno=rs.getInt("specno");

								//System.out.println("---masterqty-----"+masterqty);	

							   //	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							  //	System.out.println("---qty-----"+qty);

								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_sorderd set p_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  doc_no="+rowno+"  and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											 
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
									 
									}


									String sqls="update my_sorderd set p_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  doc_no="+rowno+" and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";	
									//System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 
 
				    	 
			         }
				     
				     
				     
				     
				     else if(reftype.equalsIgnoreCase("RFQ"))
			         {
				    	 
				    	 Statement stmt2=conn.createStatement();
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
				/*			String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
							    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 */
			    		 
			 			 String sqls5="update  my_prfqd set out_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+"  and clstatus=0 and rowno not in("+rownochk+") and unitid="+unitids+" and specno="+specnos+" ";
	  
	    			     System.out.println("-----"+sqls5);
	    			   	
			 			stmt2.executeUpdate(sqls5);
						
				    	 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
							int unitid=0;
							int specno=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.rdocno tr_no,d.out_qty,d.unitid,d.specno  from my_prfqm m  left join  my_prfqd d on m.doc_no=d.rdocno where \r\n" + 
					    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"'  and unitid="+unitids+" and specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.rowno not in("+rownochk+") group by d.rowno   order by m.date,d.rowno ";
					    	 
	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");

								unitid=rs.getInt("unitid");
								specno=rs.getInt("specno");


								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_prfqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											 
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
									 
									}


									String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";	
									//System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 
 
				    	 
			         } 
				     
				     
				     
				     
				     
				     
				  /*   
				     else if(reftype.equalsIgnoreCase("RFQ"))
			         {
				    	 
				    	 Statement stmt2=conn.createStatement();
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
							String amount=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")|| detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
							    
							String discper=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")|| detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    
							   System.out.println("-amount---"+amount);
							   System.out.println("-discper---"+discper);
			    		 
			    		 
			 			 String sqls5="update  my_prfqd set out_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+"  and amount='"+amount+"' and disper='"+discper+"' and clstatus=0 and rowno not in("+rownochk+") ";
	  
	    			     System.out.println("-----"+sqls5);
	    			   	
			 			stmt2.executeUpdate(sqls5);
						
				    	 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.rdocno tr_no,d.out_qty  from my_prfqm m  left join  my_prfqd d on m.doc_no=d.rdocno where \r\n" + 
				    	 		"d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.clstatus=0 and d.rowno not in("+rownochk+") group by d.rowno   order by m.date,d.rowno ";
				    	 
	 
			               System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");

								//System.out.println("---masterqty-----"+masterqty);	

							   //	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							  //	System.out.println("---qty-----"+qty);

								rownochk=rownochk+","+rowno;
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_prfqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"  and clstatus=0";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpurorder.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											 
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
									 
									}


									String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0";	
									//System.out.println("-2----sqls---"+sqls);

									stmtpurorder.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 
 
				    	 
			         } 
				     
				     
				     
				     
				     */
				     
				     
				     
				     
				     
				     
				     
				     
				     
				     
				     
				     
				     }
					     
			      }
			      
			      }
			
 
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO my_ordser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			
			for(int i=0;i< termsarray.size();i++){


				String[] terms=((String) termsarray.get(i)).split("::");

 

				/*if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




					String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+formdetailcode+"')";


				//	System.out.println("termsdet--->>>>Sql"+termsql);
				int	termsdet = stmtpurorder.executeUpdate (termsql);
					
					 if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}

				}*/
			}
			
			
			
			 

				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+docno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formdetailcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmtpurorder.executeUpdate (shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_ordm set shipdetid='"+shipdocno+"' where doc_no='"+docno+"' ";
				
				stmtpurorder.executeUpdate (updatesql);
				
			}
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }




	public int delete(int masterdoc_no, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request) throws SQLException {
		 
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			 
			 CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.setInt(20,masterdoc_no);
			stmtpurorder.setInt(24, 0);
 
			stmtpurorder.setDate(1,null);
			stmtpurorder.setDate(2,null);
			stmtpurorder.setString(3,null);
			stmtpurorder.setInt(4,0);
		   	stmtpurorder.setInt(5,0);
			stmtpurorder.setDouble(6,0);
			stmtpurorder.setString(7,null); 
			stmtpurorder.setString(8,null);
			stmtpurorder.setString(9,null);
			stmtpurorder.setDouble(10,0);
			stmtpurorder.setDouble(11,0);
			stmtpurorder.setDouble(12,0);
			stmtpurorder.setDouble(13,0);
			stmtpurorder.setDouble(14,0);
			stmtpurorder.setDouble(15,0);
			stmtpurorder.setDouble(16,0);
			stmtpurorder.setString(17,session.getAttribute("USERID").toString());
			stmtpurorder.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(21,formdetailcode);
			stmtpurorder.setString(22,mode);
			stmtpurorder.setInt(23,0);
			stmtpurorder.setString(25,"0");
			stmtpurorder.setString(26,"0");
			stmtpurorder.setDouble(27,0);
		    int res=stmtpurorder.executeUpdate();
			docno=stmtpurorder.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if (res > 0) {
			 
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	}




	public   JSONArray reloadsearchProduct(HttpSession session,String cmbbilltype,String dates,String docno) throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	  
	 	 
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
		    String brcid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;

		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
	     	
			/*	int method=0;
				
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				*/
/*			    int method1=0;
				String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
					{
								
					method1=rs1.getInt("method");
					}


				String sqlstest="";
							
			    if(method1>0)
				{
				  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
			
			    
			    */
							int acno=0;
				
				String sqlss111="select acno from my_ordsrvtemp where doc_no='"+docno+"' limit 1 ";
				
				ResultSet rss=stmtVeh.executeQuery(sqlss111);
				
				
				if(rss.first())
				{
					acno=rss.getInt("acno");
				}
				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					tax=0;
				}
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					
					java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
			     	}
				
					
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
				/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				} 
		 
		 
				String sql="select  "+fsql+" tm.qty,bd.brandname, "
						+ "  at.mspecno as specid, m.part_no productid,m.productname,m.productname proname,m.doc_no,u.unit,m.munit unitdocno,m.psrno,m.psrno prodoc,m.psrno proid "
						+ " from my_ordsrvtemp tm     inner  join my_main m  on m.psrno=tm.psrno and tm.doc_no="+docno+" left join  "
						+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "     left join  my_brand bd on m.brandid=bd.doc_no      "+joinsql+"   "
						+ "   where tm.doc_no='"+docno+"'     "	;
					 
					ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();	
					
 
	 
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	 return RESULTDATA;
	}
	
	
	




 
	
	

	public   JSONArray searchProduct(HttpSession session,String acno,String cmbbilltype,String dates,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String category, String subcategory) throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	  
	 	if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
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
		    String brcid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;

		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
	     	
				int method=0;
           String condtn="";
				
				if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
					condtn ="  and m.part_no like '%"+prdname+"%' ";
				}
				
				if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
					condtn +="  and bd.brandname like '%"+brandname+"%' ";
				}
				
				gridprdname=gridprdname.replaceAll("@","%");
				if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
					condtn +="  and m.productname like '%"+gridprdname+"%' ";
				}
				
				if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
					condtn +="  and u.unit like '%"+gridunit+"%' ";
				}
				
				if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
					condtn +="  and c.category like '%"+category+"%' ";
				}
				
				if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
					condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
				}
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
			    int method1=0;
				String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
					{
								
					method1=rs1.getInt("method");
					}


				String sqlstest="";
							
			    if(method1>0)
				{
				  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
			
			    
			    

				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					tax=0;
				}
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					
					java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
			     	}
				
					
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
				/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				int superseding=0;
				String chk11="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs11=stmtVeh.executeQuery(chk11); 
				if(rs11.next())
				{
					
					superseding=rs11.getInt("method");
				}
					
				if(superseding==1)
				{
					String sql=" select s.part_no,m.* from (  select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
							+ "   left join my_desc de on(de.psrno=m.doc_no)  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
							+ "   where m.status=3 "+condtn+" and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
						    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

					System.out.println("-----sql-ASD--"+sql);
		 
					ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();
				}
				
				else
				{    // left join my_desc de on(de.psrno=m.doc_no) and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'
					String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
							+ "      left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
							+ "   where m.status=3 "+condtn+"  "	;
					System.out.println("-----sql-ASD--"+sql);
		 
					ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();	
					
				}
		
				
		/*	String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
					+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
					+ "   where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;*/
	 
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	 return RESULTDATA;
	}
	
	
	
	

	public   JSONArray searchreqProduct(String reqmasterdocno,HttpSession session,String dtype,String accdocno,String cmbbilltype,String  dates,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String category, String subcategory) throws SQLException { 

	 	 JSONArray RESULTDATA=new JSONArray();
	 	 
	 	if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
	 	
	 	System.out.println("ididiididii"+id);
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
		    String brchid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;

		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
	     	String sql="";
				java.sql.Date estdate=null;
				String sqltest="";
				
				if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
					estdate=ClsCommon.changeStringtoSqlDate(date);
					
				}
				
				String condtn="";
				
				if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
					condtn ="  and m.part_no like '%"+prdname+"%' ";
				}
				
				if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
					condtn +="  and bd.brandname like '%"+brandname+"%' ";
				}
				
				gridprdname=gridprdname.replaceAll("@","%");
				if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
					condtn +="  and m.productname like '%"+gridprdname+"%' ";
				}
				
				if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
					condtn +="  and u.unit like '%"+gridunit+"%' ";
				}
				
				if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
					condtn +="  and c.category like '%"+category+"%' ";
				}
				
				if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
					condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
				}
				 
/*			String sqls="select m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,(select coalesce(sum(qty),0) from  my_reqd  \"\r\n" + 
					"					+ \" where tr_no in (\"+reqmasterdocno+\") and prdid=rd.prdid)-\\r\\n\" + \r\n" + 
					"					\"				((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (\"+reqmasterdocno+\") and prdid=rd.prdid)) qty,"
					+ "(select coalesce(sum(qty),0) from  my_reqd  "
					+ " where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
					"				((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qutval,\r\n" + 
					"					  ((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) pqty,\r\n" + 
					"				(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) saveqty\r\n" + 
					"				  from my_reqm m1 left join my_reqd rd on rd.tr_no=m1.tr_no  left join my_ordd d on m1.tr_no=d.tr_no\r\n" + 
					"								  left join\r\n" + 
					"				my_main m  on rd.prdid=m.doc_no left join my_unitm u on m.munit=u.doc_no\r\n" + 
		 
					"				          where rd.tr_no in ("+reqmasterdocno+") group by rd.prdid ";	 */
				
			    int method1=0;
				String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
				{
					
					method1=rs1.getInt("method");
				}
				
				
                  int method=0;
				
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
				if(reqmasterdocno.equalsIgnoreCase(""))
				{
					reqmasterdocno="0"; 
				}
				String sqlstest="";
				if(method1>0)
				{
				  sqlstest=" left join  my_acbook ac on ac.acno='"+accdocno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
				
				
		
				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+accdocno+"' ";
			//  System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					tax=0;
				}
				
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					
					 java.sql.Date masterdate = null;
						if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
				     	{
							masterdate=ClsCommon.changeStringtoSqlDate(dates);
				     		
				     	}
				     	else{
				     
				     	}
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
		/*			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				int mulqty=0;
				Statement stmt31 = conn.createStatement (); 
			 
				String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
				ResultSet rss31=stmt31.executeQuery(chk311); 
				if(rss31.next())
				{

					mulqty=rss31.getInt("method");
				}
				
				String joinsqls="";
				String joinsqls1="";
				if(mulqty>0)
				{
					joinsqls=",rd.unitid,rd.specno ";
					joinsqls1=" and unitid=rd.unitid and specno=rd.specno ";
					
				}
				
				
				if(dtype.equalsIgnoreCase("PR"))
				{ 
 
				String sqls="select  "+fsql+"   "+method+" method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,rd.unitid munit,m.psrno,\r\n" + 
						"(select coalesce(sum(qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+")-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+")) qty,\r\n" + 
						"(select coalesce(sum(qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+")-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+")) qutval,\r\n" + 
						" ((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+")) pqty,\r\n" + 
						"(select coalesce(sum(qty)-sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid "+joinsqls1+") saveqty\r\n" + 
						"  from my_reqm m1 left join my_reqd rd on rd.tr_no=m1.tr_no   left join \r\n" + 
						" my_main m  on rd.prdid=m.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
						+ " left join my_unitm u on rd.unitid=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) \r\n" + 
				 		" "+sqlstest+"  "+joinsql+"   where m1.status=3 "+condtn+" and  m1.brhid='"+brchid+"' and rd.tr_no in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 group by rd.prdid"+joinsqls+" order by  rd.prdid ";
				System.out.println("--sqls--"+sqls);
 
			     ResultSet resultSet = stmtVeh.executeQuery (sqls);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
				 
				}
				
				else if(dtype.equalsIgnoreCase("SOR"))  // my_sorderm my_sorderd
				{
					
			/*		String sqls="select   "+method+" method ,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0)) qty,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0)) qutval,\r\n" + 
							"	  ((select coalesce(sum(out_qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0)) pqty,\r\n" + 
							"(select coalesce(sum(qty)-sum(out_qty),0) from  my_sorderd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid and clstatus=0) saveqty\r\n" + 
							"  d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal,((qty-out_qty)*d.amount) total  "
							+ " from my_sorderm m1 left join my_sorderd rd on rd.rdocno=m1.doc_no   \r\n" + 
							"				  left join \r\n" + 
							"my_main m  on rd.prdid=m.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) \r\n" + 
							"\r\n" + 
							"        where rd.clstatus=0 and m1.status=3 and  m1.brhid='"+brchid+"' and rd.rdocno in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 group by rd.prdid   ";
					*/
				//	
					 
		/*			String sqls=" select   0 method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno, " + 
					" coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0)  qty, coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval, " + 
					" coalesce(sum(rd.out_qty),0) pqty,	coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) saveqty, " + 
					"  rd.amount unitprice,(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100 discount,rd.disper discper, " + 
					"  ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal, " + 
with outqty					"  (sum(rd.qty-rd.out_qty)*rd.amount) total   from my_sorderm m1 left join my_sorderd rd on rd.rdocno=m1.doc_no "  + 
					"   left join 	my_main m  on rd.prdid=m.doc_no  left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+sqlstest+" " + 
                    "	where rd.clstatus=0 and m1.status=3 and  m1.brhid='"+brchid+"' and rd.rdocno in  ("+reqmasterdocno+") group by rd.psrno,rd.amount,rd.disper having sum(rd.qty-rd.out_qty)>0  order by rd.prdid,rd.doc_no   ";
					
					*/
					 
					String sqls=" select  "+fsql+"  0 method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.p_qty,m.part_no,m.productname,m.doc_no,u.unit,rd.unitid munit,m.psrno, " + 
					" coalesce(sum(rd.qty),0)-coalesce(sum(rd.p_qty),0)  qty, coalesce(sum(rd.qty),0)-coalesce(sum(rd.p_qty),0) qutval, " + 
					" coalesce(sum(rd.p_qty),0) pqty,	coalesce(sum(rd.qty),0)-coalesce(sum(rd.p_qty),0) saveqty, " + 
					"  rd.amount unitprice,(sum(rd.qty-rd.p_qty)*rd.amount*rd.disper)/100 discount,rd.disper discper, " + 
					"  ((sum(rd.qty-rd.p_qty)*rd.amount)-(sum(rd.qty-rd.p_qty)*rd.amount*rd.disper)/100) nettotal, " + 
					"  (sum(rd.qty-rd.p_qty)*rd.amount) total   from my_sorderm m1 left join my_sorderd rd on rd.rdocno=m1.doc_no "  + 
					"   left join 	my_main m  on rd.prdid=m.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " left join my_unitm u on rd.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+sqlstest+"  "+joinsql+"  " + 
                    "	where rd.clstatus=0 and m1.status=3 "+condtn+" and  m1.brhid='"+brchid+"' and rd.rdocno in  ("+reqmasterdocno+") group by rd.psrno"+joinsqls+",rd.amount,rd.disper having sum(rd.qty-rd.p_qty)>0  order by rd.prdid,rd.doc_no   ";
					
					
					
					
					
					System.out.println("--sqls-1-"+sqls);
					ResultSet resultSet = stmtVeh.executeQuery (sqls);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh.close();
					
				}
				
				
				
				else if(dtype.equalsIgnoreCase("RFQ"))  // my_sorderm my_sorderd
				{
					
 
/*					String sqls=" select    "+fsql+" 0 method ,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno, " + 
					" coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0)  qty, coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval, " + 
					" coalesce(sum(rd.out_qty),0) pqty,	coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) saveqty, " + 
					"  rd.amount unitprice,(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100 discount,rd.disper discper, " + 
					"  ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal, " + 
					"  (sum(rd.qty-rd.out_qty)*rd.amount) total   from my_prfqm m1 left join my_prfqd rd on rd.rdocno=m1.doc_no "  + 
					"   left join 	my_main m  on rd.prdid=m.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) " + 
                    "	where rd.clstatus=0 and m1.status=3 and  m1.brhid='"+brchid+"' and rd.rdocno in  ("+reqmasterdocno+") group by rd.psrno,rd.amount,rd.disper having sum(rd.qty-rd.out_qty)>0  order by rd.prdid,rd.doc_no   ";
					
					*/

					String sqls=" select   "+fsql+"  0 method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,rd.unitid munit,m.psrno, " + 
					" coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0)  qty, coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval, " + 
					" coalesce(sum(rd.out_qty),0) pqty,	coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) saveqty, " + 
					"  rd.amount unitprice,(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100 discount,rd.disper discper, " + 
					"  ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal, " + 
					"  (sum(rd.qty-rd.out_qty)*rd.amount) total   from my_prfqm m1 left join my_prfqd rd on rd.rdocno=m1.doc_no "  + 
					"   left join 	my_main m  on rd.prdid=m.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " left join my_unitm u on rd.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+sqlstest+"  "+joinsql+"  " + 
                    "	where rd.clstatus=0 and m1.status=3 "+condtn+" and  m1.brhid='"+brchid+"' and rd.rdocno in  ("+reqmasterdocno+") group by rd.psrno"+joinsqls+" having sum(rd.qty-rd.out_qty)>0  order by rd.prdid,rd.rowno   ";
					
					
					
					System.out.println("--sqls-1-"+sqls);
					ResultSet resultSet = stmtVeh.executeQuery (sqls);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh.close();
					
				}
				
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	 return RESULTDATA;
	}
	
	
	
	
	
	
	
	
	public   JSONArray maingridreload(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	    /*    	String pySql=(" select m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, u.unit, d.unitid unitdocno,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_ordd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where tr_no='"+nidoc+"' ");*/
				
				
/*				

select m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,
u.unit, d.unitid unitdocno,
if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_reqd  where tr_no in (m1.rrefno) and prdid=d.prdid)-(select coalesce(sum(qty),0) from  my_ordd  where tr_no in (m1.rrefno) and prdid=d.prdid)+d.qty)) qutval,
  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (m1.rrefno) and prdid=d.prdid)) pqty,
  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (m1.rrefno) and prdid=d.prdid)) saveqty,

d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no
 left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.tr_no=1;
				*/
				
				String sqltest="0";
				System.out.println("--reqdocno----"+reqdocno);
				
				if(reftype.equalsIgnoreCase("PR") || reftype.equalsIgnoreCase("SOR") || reftype.equalsIgnoreCase("RFQ"))
				
							
				{  
					
					sqltest=reqdocno; 
				}
				
				System.out.println("--sqltest----"+sqltest);
				int mulqty=0;
				Statement stmt31 = conn.createStatement (); 
			 
				String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
				ResultSet rss31=stmt31.executeQuery(chk311); 
				if(rss31.next())
				{

					mulqty=rss31.getInt("method");
				}
				
				String joinsqls="";
				
				String sorjoinsqls="";
				if(mulqty>0)
				{
					joinsqls=" and unitid=d.unitid and specno=d.specno  ";
					sorjoinsqls=" and aa.unitid=d.unitid and aa.specno=d.specno  ";
					
				}
				
				if(reftype.equalsIgnoreCase("PR") || reftype.equalsIgnoreCase("DIR"))
								
				{
 
				String pySql="select d.prddesc,0 foc,bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
						" u.unit, d.unitid unitdocno,\r\n" + 
						" if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_reqd  where tr_no in ("+sqltest+") and prdid=d.prdid "+joinsqls+")-\r\n" + 
						" (select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+sqltest+") and prdid=d.prdid "+joinsqls+")+d.qty)) qutval,\r\n" + 
						" if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+sqltest+") and prdid=d.prdid "+joinsqls+")-d.qty) pqty,\r\n" + 
						" if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+sqltest+") and prdid=d.prdid "+joinsqls+")) saveqty,\r\n" + 
 						" d.qty,d.amount unitprice,d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno  from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no\r\n" + 
						" left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.tr_no='"+doc+"'  order by d.prdid ";	
//				 System.out.println("==== po grid ==  "+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				else if(reftype.equalsIgnoreCase("SOR"))
	               {
					
					/*String pySql="select bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
							"	u.unit, d.unitid unitdocno,coalesce(aa.qtyvals,0)+d.qty qutval, coalesce(aa.out_qty,0)-d.qty pqty, coalesce(aa.out_qty,0) saveqty,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal,d.amount unitprice1, "
							+ " d.disper disper1 from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no \r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
							+ " left join (select sum(qty) qty,sum(out_qty) out_qty, sum(qty)-sum(out_qty) qtyvals, psrno,rdocno,specno,prdid,amount,disper from my_sorderd where rdocno in ("+sqltest+") "
					        + " and clstatus=0 group by  psrno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper    where d.tr_no='"+doc+"'";	
					*/
					
					String pySql="select d.prddesc,0 foc,bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
							"	u.unit, d.unitid unitdocno,coalesce(aa.qtyvals,0)+d.qty qutval, coalesce(aa.out_qty,0)-d.qty pqty, coalesce(aa.out_qty,0) saveqty,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal,d.amount unitprice1, "
							+ " d.disper disper1 ,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no \r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
							+ " left join (select sum(qty) qty,sum(p_qty) out_qty, sum(qty)-sum(p_qty) qtyvals, psrno,rdocno,specno,prdid,amount,disper,unitid from my_sorderd where rdocno in ("+sqltest+") "
					        + " and clstatus=0 group by  psrno,unitid,specno,amount,disper) aa on aa.psrno=d.psrno "+sorjoinsqls+"  and  aa.amount=d.amount and aa.disper=d.disper    where d.tr_no='"+doc+"'";	
					
					
					
//					System.out.println("--pySql----"+pySql);
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
	               }
				else if(reftype.equalsIgnoreCase("RFQ"))
					
	               {
					
/*					String pySql="select d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
							"	u.unit, d.unitid unitdocno,coalesce(aa.qtyvals,0)+d.qty qutval, coalesce(aa.out_qty,0)-d.qty pqty, coalesce(aa.out_qty,0) saveqty,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal,d.amount unitprice1, "
							+ " d.disper disper1 from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no \r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
							+ " left join (select sum(qty) qty,sum(out_qty) out_qty, sum(qty)-sum(out_qty) qtyvals, psrno,rdocno,specno,prdid,amount,disper from my_prfqd where rdocno in ("+sqltest+") "
					        + " and clstatus=0 group by  psrno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper    where d.tr_no='"+doc+"'";	
					
					*/
					
					
					String pySql="select d.prddesc,0 foc,bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
							"	u.unit, d.unitid unitdocno,coalesce(aa.qtyvals,0)+d.qty qutval, coalesce(aa.out_qty,0)-d.qty pqty, coalesce(aa.out_qty,0) saveqty,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal,d.amount unitprice1, "
							+ " d.disper disper1,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno  from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no \r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
							+ " left join (select sum(qty) qty,sum(out_qty) out_qty, sum(qty)-sum(out_qty) qtyvals, psrno,rdocno,specno,prdid,amount,disper,unitid from my_prfqd where rdocno in ("+sqltest+") "
					        + " and clstatus=0 group by  psrno,unitid,specno) aa on aa.psrno=d.psrno  "+sorjoinsqls+"   where d.tr_no='"+doc+"'";	
					
					System.out.println("--pySql----"+pySql);
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
	               }
				
				
				//System.out.println("--pySql----"+pySql);
 
				
				
				
				
			 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray reloadserv(String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice unitprice1,qty qty1,total total1,discount discount1,nettotal nettotal1 from my_ordser  where tr_no='"+doc+"' ");
	      	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
		public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa,String descriptions,String refnoss) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
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
	    String brcid=session.getAttribute("BRANCHID").toString();
	    
	    
	    
	    java.sql.Date  sqlStartDate = null;
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
	      	}
	      	
	      	
	  	    
	  		String sqltest="";
	  	    
	  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
	      	}
	      	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
	      	}
	      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
	      	}
	      
	      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.description like '%"+descriptions+"%'";
	      	}
	      
	     	if((!(refnoss.equalsIgnoreCase(""))) && (!(refnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.rrefno like '%"+refnoss+"%'";
	      	}
	      
	      	
	      	
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{	
			
				Statement stmtmain = conn.createStatement ();
				
				
/*			  	String pySql=("select m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,"
			  			+ "m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_head h on h.doc_no=m.acno where m.status<>7 and m.brhid='"+brcid+"' "+sqltest );*/
				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.nettotal netamount,m.description desc1 from my_ordm m "
	        			+ " left join my_head h on h.doc_no=m.acno   where m.status<>7 and m.brhid='"+brcid+"' "+sqltest );
	     //   System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			}
			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}







	public     ClspurchaseorderBean getViewDetails(int doc_no,HttpSession session) throws SQLException {
	
		ClspurchaseorderBean showBean = new ClspurchaseorderBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		

    	        int cosrcodemethod=0;			
				Statement coststmt=conn.createStatement();
				String chk="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rs=coststmt.executeQuery(chk); 
				if(rs.next())
				{
					
					cosrcodemethod=rs.getInt("method");
				}
				String sq1="";
				String jsq1="";
		
				if(cosrcodemethod>0)
				{
				  sq1=  " m.costtype,m.costcode costtr_no,case when m.costtype=6 then m.costcode  when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
					   + " when m.costtype in(5) then cs.doc_no  end as 'costcode' ,case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
					   + "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' , ";
				jsq1= "  left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
						+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
						+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
						+ " left join gl_vehmaster mm on mm.fleet_no=m.costcode and m.costtype=6 " ;
					  
				}
				
		
 		String sqls="select  "+sq1+" m.doc_no,m.billtype,m.totaltax,m.tax1,m.tax2,m.tax3,m.nettotaltax ,m.shipdetid, sh.clname, sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
				+ " m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate   \r\n" + 
				" from my_ordm m "+jsq1+" left join my_head h on h.doc_no=m.acno left join my_shipdetails sh on sh.doc_no=m.shipdetid  where   m.voc_no='"+doc_no+"' and  m.brhid="+session.getAttribute("BRANCHID").toString()+"  ";

	 
		
		
 
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		String dtype="0";
		String reqdoc="0";
		while (resultSet.next()) {
		
			showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
			
			showBean.setDocno(resultSet.getInt("voc_no"));
			
			showBean.setSt(resultSet.getDouble("totaltax")); 
			showBean.setTaxontax1(resultSet.getDouble("tax1"));
			showBean.setTaxontax2(resultSet.getDouble("tax2"));
			showBean.setTaxontax3(resultSet.getDouble("tax3"));
			showBean.setTaxtotal(resultSet.getDouble("nettotaltax"));
			showBean.setCmbbilltype(resultSet.getInt("billtype"));
			
			
			
		
			showBean.setNipurchaseorderdate(resultSet.getString("date"));
			showBean.setDeliverydate(resultSet.getString("deldate"));
			showBean.setDelterms(resultSet.getString("delterms"));
			showBean.setPayterms(resultSet.getString("payterms"));
			showBean.setPurdesc(resultSet.getString("description"));
			
			showBean.setReqmasterdocno(resultSet.getString("rrefno"));
		 
			
			
			showBean.setReftype(resultSet.getString("rdtype"));
		//	showBean.setReqmasterdocno(resultSet.getString("rrefno"));
			
			dtype=resultSet.getString("rdtype");
			reqdoc=resultSet.getString("rrefno");
			
			showBean.setCurrate(resultSet.getDouble("rate"));
			showBean.setRefno(resultSet.getString("refno"));
			showBean.setCmbcurrval(resultSet.getInt("curId"));
			showBean.setAccdocno(resultSet.getInt("acno"));
			showBean.setPuraccid(resultSet.getInt("account")); 
			showBean.setPuraccname(resultSet.getString("descs"));
		//duwn
			showBean.setProductTotal(resultSet.getDouble("amount"));
			showBean.setChkdiscountval(resultSet.getInt("disstatus"));
			showBean.setDescPercentage(resultSet.getDouble("disper"));
			
			showBean.setPrddiscount(resultSet.getDouble("prddiscount"));
			
		 
			showBean.setDescountVal(resultSet.getDouble("discount"));
			showBean.setRoundOf(resultSet.getDouble("roundVal"));
			showBean.setNetTotaldown(resultSet.getDouble("netAmount"));
			showBean.setNettotal(resultSet.getDouble("supplExp"));
			showBean.setOrderValue(resultSet.getDouble("nettotal"));
			
			
 
			
			showBean.setShipdocno(resultSet.getInt("shipdetid"));
			showBean.setShipto(resultSet.getString("clname"));
			showBean.setShipaddress(resultSet.getString("claddress"));
			showBean.setContactperson(resultSet.getString("contactperson"));
			showBean.setShiptelephone(resultSet.getString("tel"));
			
			
			showBean.setShipmob(resultSet.getString("mob"));
			showBean.setShipemail(resultSet.getString("email"));
			showBean.setShipfax(resultSet.getString("fax"));

			if(cosrcodemethod>0)
			{
			showBean.setItemtype (resultSet.getInt("costtype"));
			
			showBean.setCosttr_no(resultSet.getInt("costtr_no"));

			showBean.setItemname(resultSet.getString("prjname"));
			
			showBean.setItemdocno(resultSet.getInt("costcode"));
			}
		
		}
		int i=0;
		String reqvoc="";
		if(dtype.equalsIgnoreCase("PR"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_reqm where tr_no in ("+reqdoc+")";
			//System.out.println("==sqlss==="+sqlss);
			
			ResultSet resultSet1= stmt1.executeQuery(sqlss);
			
			
			while (resultSet1.next()) {
				
				if(i==0)
				{
					reqvoc=resultSet1.getString("voc_no")+",";	
				}
				else
				{
					reqvoc=reqvoc+resultSet1.getString("voc_no")+",";
				}
				
				
				i++;
				
				
				
			}
			
			if(reqvoc.endsWith(","))
			{
				reqvoc = reqvoc.substring(0,reqvoc.length() - 1);
			}
			
			showBean.setRrefno(reqvoc);
			
		}
		
		else if(dtype.equalsIgnoreCase("SOR"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_sorderm where doc_no in ("+reqdoc+")";
			//System.out.println("==sqlss==="+sqlss);
			
			ResultSet resultSet1= stmt1.executeQuery(sqlss);
			
			
			while (resultSet1.next()) {
				
				if(i==0)
				{
					reqvoc=resultSet1.getString("voc_no")+",";	
				}
				else
				{
					reqvoc=reqvoc+resultSet1.getString("voc_no")+",";
				}
				
				
				i++;
				
				
				
			}
			
			if(reqvoc.endsWith(","))
			{
				reqvoc = reqvoc.substring(0,reqvoc.length() - 1);
			}
			
			showBean.setRrefno(reqvoc);
			
		}
		
		else if(dtype.equalsIgnoreCase("RFQ"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_prfqm where doc_no in ("+reqdoc+")";
			//System.out.println("==sqlss==="+sqlss);
			
			ResultSet resultSet1= stmt1.executeQuery(sqlss);
			
			
			while (resultSet1.next()) {
				
				if(i==0)
				{
					reqvoc=resultSet1.getString("voc_no")+",";	
				}
				else
				{
					reqvoc=reqvoc+resultSet1.getString("voc_no")+",";
				}
				
				
				i++;
				
				
				
			}
			
			if(reqvoc.endsWith(","))
			{
				reqvoc = reqvoc.substring(0,reqvoc.length() - 1);
			}
			
			showBean.setRrefno(reqvoc);
			
		}
		 
		
		
		stmt.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		return showBean;
	}



	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String cmbreftype,String acno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
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
        String brcid = session.getAttribute("BRANCHID").toString(); 
	 
    	String sqltest="";
    	
    	  
	    java.sql.Date  sqlStartDate = null;
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
	      	}
        
  	    
  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
      	}
      	if((!(refnosss.equalsIgnoreCase(""))) && (!(refnosss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.refno like '%"+refnosss+"%'  ";
      	}
       
       	
      	if(!(sqlStartDate==null)){
      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
      	}
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtmain = conn.createStatement ();
				if(aa.equalsIgnoreCase("yes"))
				{
				
						/*  	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk'   from my_reqm m    where m.status=3 and m.brhid='"+brcid+"'" );*/
					//acno
					
					
				    int method1=0;
					String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
					ResultSet rs1=stmtmain.executeQuery(chk1); 
					if(rs1.next())
						{
									
						method1=rs1.getInt("method");
						}


					String sqlstest1="";
								
				    if(method1>0)
					{
				    	sqlstest1=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m1.brandid=br.brandid ";
					}
						
					
					
					if(cmbreftype.equalsIgnoreCase("PR"))
					
					{
				    			int cosrcodemethod=0;			
								Statement coststmt=conn.createStatement();
								String chk="select method  from gl_prdconfig where field_nme='costcenter'";
								ResultSet rs=coststmt.executeQuery(chk); 
								if(rs.next())
								{
									cosrcodemethod=rs.getInt("method");
								}
								String sq1="";
								String jsq1="";
						
								if(cosrcodemethod>0) 
								{
								  sq1=  " m.costtype,m.costcode costtr_no,case when m.costtype=6 then m.costcode  when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
									   + " when m.costtype in(5) then cs.doc_no  end as 'costcode' ,case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
									   + "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' , ";
								  jsq1=  "  left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
										+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
										+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
										+ " left join gl_vehmaster mm on mm.fleet_no=m.costcode and m.costtype=6 " ;
									  
								}
								
			 
						
						
						
					String pySql=("select * from (select "+sq1+" sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
							+ "  from my_reqm m  left join    	my_reqd d on d.tr_no=m.tr_no "+jsq1+" left join my_main m1 on m1.doc_no=d.prdId  "+sqlstest1+" "
							+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"   group by m.doc_no) as a  having  qty>0");
					
					System.out.println("===pySql===="+pySql);
					ResultSet resultSet = stmtmain.executeQuery(pySql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet); 
					}
					else if(cmbreftype.equalsIgnoreCase("SOR"))
					{
			/*			String pySql=("select * from (select sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
	with out qyt							+ "  from my_sorderm m  left join    	my_sorderd d on d.rdocno=m.doc_no and d.clstatus=0  left join my_main m1 on m1.doc_no=d.prdId   "+sqlstest1+" "
								+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a  having  qty>0");*/
						String pySql=("select * from (select sum(d.qty-d.p_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
					+ "  from my_sorderm m  left join    	my_sorderd d on d.rdocno=m.doc_no and d.clstatus=0  left join my_main m1 on m1.doc_no=d.prdId   "+sqlstest1+" "
					+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a  having  qty>0");
						
						
						ResultSet resultSet = stmtmain.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						System.out.println("===pySql===="+pySql);
					}
					else if(cmbreftype.equalsIgnoreCase("RFQ"))
					{
						String pySql=("select * from (select sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
								+ "  from my_prfqm m  left join    	my_prfqd d on d.rdocno=m.doc_no and d.clstatus=0  left join my_main m1 on m1.doc_no=d.prdId "+sqlstest1+" "
								+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"  group by m.doc_no) as a  having  qty>0");
						ResultSet resultSet = stmtmain.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						System.out.println("===pySql===="+pySql);
					}
				 
					
					
			/*		
	        	String pySql=("select sum((d.qty-d.out_qty)>0),m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' ,sum((d.qty-d.out_qty)) Qty  from my_reqm m  left join "
	        			+ "   	my_reqd d on d.tr_no=m.tr_no   where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"  group by d.prdid having  sum(d.qty-d.out_qty)>0");
	        	*/
	        	//System.out.println("========"+pySql);
				 
				}
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}

	public   JSONArray reqgridreload(HttpSession session, String doc,String from,String cmbreftype,String accdocno,String dates,String cmbbilltype) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();      
				String pySql="";
				if(from.equalsIgnoreCase("pro"))  
				{
					
					
				    int method1=0;
					String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
					ResultSet rs1=stmt.executeQuery(chk1); 
					if(rs1.next())
						{
									
						method1=rs1.getInt("method");
						}

					
					String sqlstest="";
					
				    if(method1>0)
					{
					  sqlstest=" left join  my_acbook ac on ac.acno='"+accdocno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
					}
		
				
					
					

					int tax=0;
					Statement stmt3 = conn.createStatement (); 
				 
					String chk31="select method  from gl_prdconfig where field_nme='tax' ";
					ResultSet rss3=stmt3.executeQuery(chk31); 
					if(rss3.next())
					{

						tax=rss3.getInt("method");
					}
					
					int temptax=0;
					Statement stmt3111 = conn.createStatement (); 
					String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+accdocno+"' ";
				//  System.out.println("===sqlss======"+sqlss);
					ResultSet rsss=stmt3111.executeQuery(sqlss);
				    if(rsss.next())
				    {
				    	temptax=rsss.getInt("tax");
				    	
				    }
					if(temptax!=1)
					{
						tax=0;
					}
					
					String joinsql="";
					
					String fsql="";
					
					String outfsql="";
					
					
					if(tax>0)
					{
						
					    java.sql.Date masterdate = null;
						if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
				     	{
							masterdate=ClsCommon.changeStringtoSqlDate(dates);
				     		
				     	}
				     	else{
				     
				     	}
						
						if(Integer.parseInt(cmbbilltype)>0)
						{
							
							
							
							Statement pv=conn.createStatement();
							int prvdocno=0;
							String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
							ResultSet rs13=pv.executeQuery(dd); 
							if(rs13.next())
							{

								prvdocno=rs13.getInt("prvdocno");
							}
							
							
					/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
						
						outfsql=outfsql+ " taxper , ";*/
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
						
						
						
						}
						
					}
					
					int mulqty=0;
					Statement stmt31 = conn.createStatement (); 
				 
					String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
					ResultSet rss31=stmt31.executeQuery(chk311); 
					if(rss31.next())
					{

						mulqty=rss31.getInt("method");
					}
					
					String joinsqls="";
					if(mulqty>0)
					{
						joinsqls=",d.unitid,d.specno ";
						
					}
					

					
					
					if(cmbreftype.equalsIgnoreCase("PR")) 
					{
					
					 pySql=("select "+fsql+" bd.brandname,'pro' checktype,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty  from my_reqd d " + 
		        			"left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
		        			+ " left join  my_brand bd on m.brandid=bd.doc_no  "+sqlstest+"    "+joinsql+"   where d.tr_no in ("+doc+")  group by d.prdId"+joinsqls+"  having sum(d.qty-d.out_qty)>0  ");
					
				//	System.out.println("----pySql----"+pySql);
					 	ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}
					else if(cmbreftype.equalsIgnoreCase("SOR")) 
					{
					/*	 pySql=("select bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,"
						 		+ " d.amount unitprice,d.amount unitprice1,d.disper disper1,(sum(d.qty-d.out_qty)*d.amount) total,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, "
						 		+ " d.amount unitprice1,d.disper disper1 from my_sorderd d " + 
				        			"left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  "+sqlstest+"  where d.rdocno in ("+doc+") and d.clstatus=0 group by d.prdId,d.amount,d.disper  having sum(d.qty-d.out_qty)>0  ");
							*/
						 pySql=("select  "+fsql+" bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.p_qty)  qty,sum(d.qty-d.p_qty) qutval,sum(d.qty-d.p_qty) saveqty,"
							 		+ " d.amount unitprice,d.amount unitprice1,d.disper disper1,(sum(d.qty-d.p_qty)*d.amount) total,(sum(d.qty-d.p_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.p_qty)*d.amount)-(sum(d.qty-d.p_qty)*d.amount*d.disper)/100) nettotal, "
							 		+ " d.amount unitprice1,d.disper disper1 from my_sorderd d " + 
					        			"left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					        			+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no"
					        			+ "  "+sqlstest+"   "+joinsql+"   where d.rdocno in ("+doc+") and d.clstatus=0 group by d.prdId"+joinsqls+",d.amount,d.disper  having sum(d.qty-d.p_qty)>0  ");
								
						 
						 
						 	System.out.println("---SOR---"+pySql);
							 
								
								ResultSet resultSet = stmt.executeQuery(pySql);

								RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}
					
					else 
					{
						
						
					/*	 pySql=("select bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,"
							 		+ " d.amount unitprice,d.amount unitprice1,d.disper disper1,(sum(d.qty-d.out_qty)*d.amount) total,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, "
							 		+ " d.amount unitprice1,d.disper disper1 from my_prfqd d " + 
					        			"left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  where d.rdocno in ("+doc+") and d.clstatus=0 group by d.prdId,d.amount,d.disper  having sum(d.qty-d.out_qty)>0  ");*/
					
						
						
						 pySql=("select   "+fsql+" bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,"
							 		+ " d.amount unitprice,d.amount unitprice1,d.disper disper1,(sum(d.qty-d.out_qty)*d.amount) total,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, "
							 		+ " d.amount unitprice1,d.disper disper1 from my_prfqd d " + 
					        			"left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					        			+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join"
					        			+ "  my_brand bd on m.brandid=bd.doc_no "+sqlstest+"  "+joinsql+"   where d.rdocno in ("+doc+") and d.clstatus=0 group by d.prdId"+joinsqls+"  having sum(d.qty-d.out_qty)>0  ");
						
						
							//	System.out.println("----pySql----"+pySql);
								 
									
									ResultSet resultSet = stmt.executeQuery(pySql);

									RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						
					}
					
					 
					
				}
		 
	
			 
				stmt.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}	
 

	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
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
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
  // System.out.println("sql===="+sql);
    
            /* String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
            	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
            	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
            	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";*/
             
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	
	
	
	
	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"' and status=3 ";
			// System.out.println("-----sql---"+sql);

			ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	public   JSONArray deldetailsSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 


			String sql="select doc_no,desc1 from  my_deldetailm where status=3; ";
			// System.out.println("-----sql---"+sql);

			ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public   JSONArray reloadshipSearch(HttpSession session,String masterdocno,String formcode) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 


			String sql="select   refdocno doc_nos, desc1, refno, date from  my_deldetaild where status=3 and rdocno='"+masterdocno+"' and dtype='"+formcode+"' ";
		  System.out.println("-----sql---"+sql);

			ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m   "
					+ "inner join my_termsd d on(m.voc_no=d.rdocno and d.status=3) where m.status=3 and d.dtype='"+dtype+"' order by terms";
			//System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
 
	
	
	
	public JSONArray termsGridreLoad(String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,t.dtype,m.termsheader  terms, t.conditions from my_trterms t "
					+ "left join MY_termsm m on m.voc_no=t.termsid and t.dtype='PO'  where t.dtype='PO' and t.rdocno='"+docno+"'";
		//	System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}




	public JSONArray shipsearchFrom(String clname,String mob) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();  

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();     
			String sqltest="";

			if(!(clname.equalsIgnoreCase(""))){
				sqltest=sqltest+" and if(m.type=0,m.clname,ac.refname) like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.mob like '%"+mob+"%'";
			}

	 
			String sql=" select m.doc_no,m.type,m.cldocno,if(m.type=0,m.clname,ac.refname) clname, m.claddress,m.contactperson, m.tel, "
					+ " m.mob, m.email, m.fax from my_shipdetails m  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'  "
					+ " where  m.status=3 and m.type=0  " +sqltest;
			
			
			//System.out.println("-----sql-------"+sql);
 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}





 public     ClspurchaseorderBean getPrint(int docno, HttpServletRequest request,String brhid,String ddtype) throws SQLException {
		 ClspurchaseorderBean bean = new ClspurchaseorderBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
                                 Statement stmtprintp = conn.createStatement();
				 String resqll=("select concat('TRN NO',' : ',b.tinno) companytrno, m.voc_no,m.date,m.pono,m.status,u.user_name preparedby,acc.address,acc.com_mob,acc.fax1,acc.trnnumber,coalesce(u1.user_name, u.user_name)  verifiedappr,m.disstatus,coalesce(u2.user_name,'') approved,coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob,coalesce(acc.contactPerson,'') contactPerson,m.dtype,m.shipdetid, sh.clname, sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
							+ " m.rdtype,if(m.rdtype='PR',m.rrefno,'') rrefno,case when m.rdtype='PR' then 'Purchase Request'  when m.rdtype='SOR' "
							+ " then 'Sales Order'  when m.rdtype='RFQ' then 'Purchase Request For Quote'  else   'Direct' end as type,m.doc_no,m.refno,"
							+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
							" m.discount,m.roundVal,round(m.netAmount-coalesce(a.total,0),2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal-coalesce(a.total,0),2) nettotal,"
							+ " m.prddiscount,if(trim(m.delterms)!='',m.delterms,null)delterms,if(trim(m.payterms)!='',m.payterms,null) payterms,if(trim(m.description)!='',m.description,null)description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
							" from my_ordm m  left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) "
							+ "left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprstatus=3)"
							+ " left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join my_user u2 on ext1.userid=u2.doc_no  "
							+ " left join my_head h on h.doc_no=m.acno  left join my_shipdetails sh on sh.doc_no=m.shipdetid left join my_acbook acc on acc.cldocno=h.cldocno and acc.dtype='VND'   "
							+ " left join (select coalesce(sum(nettotal),0)  total,coalesce(rdocno,0) rdocno from   my_ordd where clstatus=1 and rdocno='"+docno+"') a on a.rdocno=m.doc_no "
							+ " left join my_brch b on m.brhid=b.doc_no "
							
							+ "	where   m.doc_no='"+docno+"' ");
					
					
					System.out.println("--resqllllll--"+resqll);
					
					ResultSet pintrs1 = stmtprintp.executeQuery(resqll);
					
			 
				       while(pintrs1.next()){
				    	   
				    	    bean.setCompanytrno(pintrs1.getString("companytrno"));
				    	   bean.setLblpono(pintrs1.getString("pono"));
				    	   bean.setLblcontact(pintrs1.getString("contactPerson"));
				    	   bean.setLbladdrs(pintrs1.getString("address"));
				    	   bean.setLblphoneno(pintrs1.getString("com_mob"));
				    	   bean.setLblfaxx(pintrs1.getString("fax1"));
				    	   bean.setLblemaill(pintrs1.getString("mail1"));
				    	   bean.setLblpodate(pintrs1.getString("date"));
				    	   bean.setLblclienttrno(pintrs1.getString("trnnumber"));
				    	   bean.setLblvocno(pintrs1.getString("voc_no")); 
				    	
				       }
					

					stmtprintp.close();
					
					
					ArrayList<String> arr233 =new ArrayList<String>();
					  Statement stmtprintprint = conn.createStatement();
						 String resqlll=("select distinct '' srno, termsheader terms,m.doc_no, 0 priorno from (select distinct termsid,dtype from my_trterms tr "+
							" where  tr.dtype='"+ddtype+"' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 ) tr "+
							" inner join my_termsm m on(tr.termsid=m.voc_no and m.dtype=tr.dtype) where  m.status=3 "+
							" union all select '*' srno,concat('   ',conditions) terms,m.doc_no,priorno from my_trterms tr "+
							" left join my_termsm m on(tr.termsid=m.voc_no and m.dtype=tr.dtype) where  tr.dtype='"+ddtype+"' "+
							" and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 and m.status=3  order by doc_no,priorno; ");
							
							
							System.out.println("--resqlllllldfgyhhgfrd--"+resqlll);
							
							ResultSet pintrs11 = stmtprintprint.executeQuery(resqlll);
							
					 
							while(pintrs11.next()){

								 
								 
					
									arr233.add(pintrs11.getString("srno")+"::"+pintrs11.getString("terms")+"::");
									
					
									
								
						          }
						             
							request.setAttribute("prnttermsdetails", arr233);
							
						       stmtprintprint.close();
					
					
					
					ArrayList<String> arr23 =new ArrayList<String>();
				   	 Statement stmtgrid23 = conn.createStatement ();       
				     String temp23="";  
				       String	strSqldetail23="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_ordd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' and d.clstatus=0  ";
					
			
					ResultSet rsdetail23=stmtgrid23.executeQuery(strSqldetail23);
					
					int rowcountss=1;
			
					while(rsdetail23.next()){

							 
							 
						temp23=rsdetail23.getString("qty")+"::"+
							rsdetail23.getString("unit")+"::"+rsdetail23.getString("productname")+"::"+rsdetail23.getString("amount")+"::"+
						    rsdetail23.getString("total") ;
							arr23.add(temp23);
							rowcountss++;
			
							bean.setSecarray(2);
						
				          }
				             
					request.setAttribute("prntdetails", arr23);
					stmtgrid23.close();

				Statement stmtprint = conn.createStatement();
	        	String dtype="";
	/*			String resql=("select coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob,coalesce(acc.contactPerson,'') contactPerson,m.dtype,m.shipdetid, sh.clname, sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
						+ " m.rdtype,if(m.rdtype='PR',m.rrefno,'') rrefno,case when m.rdtype='PR' then 'Purchase Request'  when m.rdtype='SOR' "
						+ " then 'Sales Order'  when m.rdtype='RFQ' then 'Purchase Request For Quote'  else   'Direct' end as type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
						" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,"
						+ " m.prddiscount,if(trim(m.delterms)!='',m.delterms,null)delterms,if(trim(m.payterms)!='',m.payterms,null) payterms,if(trim(m.description)!='',m.description,null)description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
						" from my_ordm m left join my_head h on h.doc_no=m.acno  left join my_shipdetails sh on sh.doc_no=m.shipdetid left join my_acbook acc on acc.cldocno=h.cldocno and acc.dtype='VND'  where   m.doc_no='"+docno+"' ");
				*/
	        	
	        	String resql=("select  coalesce(acc.tinno,'')tinno, m.status,u.user_name preparedby,acc.address,if(acc.com_mob='', acc.per_mob,acc.com_mob) com_mob,acc.fax1,coalesce(u1.user_name, u.user_name)  verifiedappr,m.disstatus,coalesce(u2.user_name,'') approved,coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob,coalesce(acc.contactPerson,'') contactPerson,m.dtype,m.shipdetid, sh.clname, sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
						+ " m.rdtype,if(m.rdtype='PR',m.rrefno,'') rrefno,case when m.rdtype='PR' then 'Purchase Request'  when m.rdtype='SOR' "
						+ " then 'Sales Order'  when m.rdtype='RFQ' then 'Purchase Request For Quote'  else   'Direct' end as type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
						" m.discount,m.roundVal,round(m.netAmount-coalesce(a.total,0),2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal-coalesce(a.total,0),2) nettotal,"
						+ " m.prddiscount,if(trim(m.delterms)!='',m.delterms,null)delterms,if(trim(m.payterms)!='',m.payterms,null) payterms,if(trim(m.description)!='',m.description,null)description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
						" from my_ordm m  left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) "
						+ "left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprstatus=3)"
						+ " left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join my_user u2 on ext1.userid=u2.doc_no  "
						+ " left join my_head h on h.doc_no=m.acno  left join my_shipdetails sh on sh.doc_no=m.shipdetid left join my_acbook acc on acc.cldocno=h.cldocno and acc.dtype='VND'   "
						+ " left join (select coalesce(sum(nettotal),0)  total,rdocno from   my_ordd where clstatus=1 and rdocno='"+docno+"') a on a.rdocno=m.doc_no	where   m.doc_no='"+docno+"' ");
				
				
		//	System.out.println("--resqllllll--"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	   
			    	   
			    	    bean.setTinno(pintrs.getString("tinno"));
			    	   bean.setAttn(pintrs.getString("contactPerson"));
			    	   bean.setTel(pintrs.getString("per_mob"));
			    	   bean.setFax(pintrs.getString("fax1"));
			    	   bean.setEmail(pintrs.getString("mail1"));
			    	bean.setSecndtarray(pintrs.getString("disstatus"));
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type")+" - "+pintrs.getString("rrefno"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    bean.setExpdeldate(pintrs.getString("deldate"));
			    	    bean.setLbladdress(pintrs.getString("address"));
			    	    
			    	   // bean.setLbltotal(pintrs.getString("netAmount"));
			    	    
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			    	    bean.setLblphone(pintrs.getString("com_mob"));
			    	    bean.setLblfax(pintrs.getString("fax1"));
			    	   
			    	    
			    	  //  bean.setWordnetamount(c.convertAmountToWords(pintrs.getString("netAmount")));
			    	  //  System.out.println("PURCHASE ORDER nttot"+bean.getLbltotal()+"word++++++++"+bean.getWordnetamount());
			    	    
			    	    /*bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    
			    	    */ 
			    	    bean.setLblshipto(pintrs.getString("clname"));
			    	    bean.setLblshipaddress(pintrs.getString("claddress"));
			    	    bean.setLblcontactperson(pintrs.getString("contactperson"));
			    	    bean.setLblshiptelephone(pintrs.getString("tel"));
						bean.setLblshipmob(pintrs.getString("mob"));
			    	    bean.setLblshipemail(pintrs.getString("email"));
			    	    bean.setLblshipfax(pintrs.getString("fax"));
			    	    dtype=pintrs.getString("dtype");

				    bean.setWatermarks(pintrs.getString("status"));
			       }
				

				stmtprint.close();
				
Statement stmtinvoice11 = conn.createStatement ();
				
				String sql3 = " select u.user_name preparedby,date_format(ext0.apprdate,'%d-%m-%Y') preparedbydt,date_format(ext0.apprdate,'%H:%i:%s') preparedbyat,coalesce(u2.user_name, u1.user_name)  verifiedappr"
						+ " ,date_format(coalesce(ext1.apprdate,ext.apprdate),'%d-%m-%Y') verifybydt, date_format(coalesce(ext1.apprdate,ext.apprdate),'%H:%i:%s') verifybyat,coalesce(u3.user_name,'') approved ,"
						+ " date_format(ext2.apprdate,'%d-%m-%Y') approvedt, date_format(ext2.apprdate,'%H:%i:%s') approveat"
						+ " from my_ordm m"
						+ " left join my_exdet ext on (m.voc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprLEVEL=1 AND EXT.APPRSTATUS=3 and ext.brhid="+brhid+")"
						+ " left join my_exdet ext0 on (m.voc_no=ext0.doc_no and m.dtype=ext0.dtype and ext0.apprLEVEL=0 and ext0.brhid="+brhid+")"
						+ " left join my_exdet ext1 on (m.voc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprLEVEL=2 AND EXT1.APPRSTATUS=3 and ext1.brhid="+brhid+")"
						+ " left join my_exdet ext2 on (m.voc_no=ext2.doc_no and m.dtype=ext2.dtype   and ext2.apprLEVEL=3 AND EXT2.APPRSTATUS=3 and ext2.brhid="+brhid+")"
						+ " left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no"
						+ " left join my_user u2 on ext1.userid=u2.doc_no "
						+ " left join my_user u3 on ext2.userid=u3.doc_no   left join my_head h on h.doc_no=m.acno   where   m.doc_no="+docno+" ";
				System.out.println("preparedby"+sql3);
				ResultSet resultSet3 = stmtinvoice11.executeQuery(sql3);
				
				while(resultSet3.next()){
					 bean.setLblpreparedby(resultSet3.getString("preparedby"));
					bean.setLblpreparedon(resultSet3.getString("preparedbydt"));
					bean.setLblpreparedat(resultSet3.getString("preparedbyat"));
					 bean.setLblverifiedon(resultSet3.getString("verifybydt"));
			    	   bean.setLblverifiedat(resultSet3.getString("verifybyat"));
			    	   bean.setLblapprovedon(resultSet3.getString("approvedt"));
			    	   bean.setLblapprovedat(resultSet3.getString("approveat"));
			    	   bean.setLblverifiedby(resultSet3.getString("verifiedappr"));
						bean.setLblapprovedby(resultSet3.getString("approved"));
				}
				stmtinvoice11.close();
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,b.tinno,c.company,c.address,c.tel,c.fax,l.loc_name location,c.email,c.web from my_ordm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+" ";

			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	   bean.setLblbranchtrno(resultsetcompany.getString("tinno"));
				    	  
						  bean.setLblcompemail(resultsetcompany.getString("email"));
				    	   bean.setLblcompweb(resultsetcompany.getString("web"));
				    	   
				    	   
				       } 
				     stmt10.close();
				       
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				     	String strsqltot="select round(sum(d.nettotal+coalesce(d.taxamount,0)),2)  total,round(sum(d.taxamount),2)  tax,round(sum(d.total),2)  totalamount from my_ordd d  left join my_ordm m on m.doc_no=d.rdocno     where d.rdocno='"+docno+"' group by d.rdocno   ";
				     	ResultSet total1=stmtgrid.executeQuery(strsqltot);
				     	while(total1.next()){
				     		bean.setLbltotal(total1.getString("total"));
				     		bean.setWordnetamount(c.convertAmountToWords(total1.getString("total")));
				     		 /* bean.setLblordervaluewords(c.convertAmountToWords(total1.getString("total")));
					    	    bean.setLblordervalue(total1.getString("total"));*/
					    	    
				     		
				     	 
				     		bean.setLblnettax(total1.getString("tax"));
				     		bean.setLblTotalAmounnt(total1.getString("totalamount"));
				     	}
						
						Statement servgrid = conn.createStatement ();
//				     	String strsrvtot="select coalesce((select round(sum(nettotal),2)  from my_ordser where rdocno='"+docno+"'  group by rdocno),0)+"
//				     					+"coalesce((select round(sum(nettotal+coalesce(taxamount,0)),2)   from my_ordd where rdocno='"+docno+"' group by rdocno),0) total;";
//						
				     	String strsrvtot="select coalesce((select round(sum(nettotal+coalesce(taxamount,0)-coalesce(discount,0)),2)from  my_ordd where rdocno='"+docno+"' group by rdocno),0)"
						        + "-(select round(discount,2) from  my_ordm where doc_no='"+docno+"')total;";
						
				     //	System.out.println("total........."+strsrvtot);
				     //	System.out.println(strsrvtot);
				     	ResultSet total2=stmtgrid.executeQuery(strsrvtot);
				     	while(total2.next()){
				   
				     		  	bean.setLblordervaluewords(c.convertAmountToWords(total2.getString("total")));
					    	    bean.setLblordervalue(total2.getString("total"));
				     	}
				     	
				     	
				     	
				     	
				       
				     	/*String taxbillforjrxml="select a.totalamount prdwithdis,a.totwthoutdisc, "
								+ "round(a.totdiscount,2) totdiscount,coalesce(a.srvtot,0.00) srvcharge,a.total prdwithtaxdis,a.tax taxamnt,"
								+ "(a.totalamount+a.srvtot+a.tax)-a.totdiscount as 'finlamntwithsrvchrg' from "
								+ " (select round(sum(coalesce(d.discount,0.00))+coalesce(s.srvdiscunt,0))totdiscount, "
								+ "s.srvdiscunt, coalesce(s.nettotal,0.00) srvtot, round(sum(d.nettaxamount),2)  total, "
								+ "coalesce(round(sum(d.taxamount),2),0.00)  tax,coalesce(round(sum(d.nettotal),2),0.00)  totalamount,round(sum(d.total),2) totwthoutdisc "
								+ "from my_ordd d left join (select rdocno,round(sum(coalesce(nettotal,0)),2) nettotal , "
								+ " round(sum(discount),2) srvdiscunt from my_ordser where rdocno='"+docno+"') s on "
								+ "(d.rdocno=s.rdocno) "
								+ "where d.rdocno='"+docno+"')a;" ;*/
				     	
				     	String taxbillforjrxml="select format(a.totwthoutdisc,2) totwthoutdisc, format(a.totdiscount,2) totdiscount,a.totalamount prdwithdis,format(a.tax,2) taxamnt,a.total prdwithtaxdis,"
				     			+ " coalesce(a.srvdiscunt,0.00)srvdiscunt,format(coalesce(a.srvtot,0.00),2) srvcharge, "
				     			+ " format(sum(a.total+a.srvtot)-coalesce(a.srvdiscunt,0),2) as 'finlamntwithsrvchrg',round((sum(a.total+a.srvtot)-coalesce(a.srvdiscunt,0)),2) 'wordsamount' "
				     			+ " from  (select (sum(coalesce(d.discount,0.00))+coalesce(s.srvdiscunt,0)) totdiscount, s.srvdiscunt, "
				     			+ " coalesce(s.nettotal,0.00) srvtot, sum(d.nettotal+coalesce(d.taxamount,0))  total, coalesce(round(sum(d.taxamount),2),0.00)  tax, "
				     			+ " coalesce(round(sum(d.nettotal),2),0.00)  totalamount,round(sum(d.total),2) totwthoutdisc from my_ordd d "
				     			+ " left join (select rdocno,round(sum(coalesce(nettotal,0))+sum(coalesce(discount,0)),2) nettotal ,  round(sum(discount),2) srvdiscunt from "
				     			+ " my_ordser where rdocno='"+docno+"') s on (d.rdocno=s.rdocno) where d.rdocno='"+docno+"' and d.clstatus=0)a;" ;
					//	System.out.println("taxbillforjrxml=="+taxbillforjrxml);
						Statement jrxmlstmnt=conn.createStatement();
						ResultSet jrxmltax=jrxmlstmnt.executeQuery(taxbillforjrxml);
						while(jrxmltax.next()){
							//bean.setJbillprdamnt(jrxmltax.getString("prdwodistax"));
							bean.setJbillprdamnt(jrxmltax.getString("totwthoutdisc"));
							bean.setJbilldiscount(jrxmltax.getString("totdiscount"));
							bean.setJsrvchrg(jrxmltax.getString("srvcharge"));
							bean.setLblnettotal(jrxmltax.getString("prdwithdis"));
							bean.setJbilltax(jrxmltax.getString("taxamnt"));
							bean.setJtotalbill(jrxmltax.getString("finlamntwithsrvchrg"));
							bean.setJfire7prdwithtaxdis(jrxmltax.getString("prdwithtaxdis"));
							bean.setJbillamntinwords(c.convertAmountToWords(jrxmltax.getString("wordsamount")));
						}
				     	



				     	String sqls="select  round(sum(nettotal+coalesce(taxamount,0)),2) total from  my_ordd where rdocno='"+docno+"' ";
						 
				     
				     	ResultSet tot=stmtgrid.executeQuery(sqls);
				     	while(tot.next()){
				   
				     		  	bean.setLblordervaluewords(c.convertAmountToWords(tot.getString("total")));
					    	    bean.setLblordervalue(tot.getString("total"));
				     	}
				     	
				     	
						
						
				     	String	strSqldetail="Select d.specno specid ,m.part_no productid,concat(m.productname,' ',if(coalesce(prddesc,'')='','',prddesc)) productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper,round(taxamount,2) taxamount,round(nettaxamount,2) nettaxamount"
				       		+ "    from my_ordd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' and d.clstatus=0  ";
					
				   //   System.out.println("Table11111111111"+strSqldetail);
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal")+"::"+rsdetail.getString("taxamount")+"::"+rsdetail.getString("nettaxamount") ;
							arr.add(temp);
							rowcount++;
			
							bean.setFirstarray(1);
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					
					
					
					
					
					   
				     ArrayList<String> arr2 =new ArrayList<String>();
				   	 Statement stmtgrid2 = conn.createStatement ();       
				     String temp2="";  
				       String	strSqldetail2="select srno,desc1 description,round(unitprice,2)  unitprice,round(qty,2) qty,round(total,2) total,round(discount,2)"
				       		+ " discount ,round(nettotal,2) nettotal from my_ordser     where rdocno='"+docno+"'";
					
			
					ResultSet rsdetail2=stmtgrid2.executeQuery(strSqldetail2);
					
					int rowcounts=1;
			
					while(rsdetail2.next()){

							 
							 
						temp2=rowcounts+"::"+rsdetail2.getString("description")+"::"+rsdetail2.getString("qty")+"::"+
							rsdetail2.getString("unitprice")+"::"+rsdetail2.getString("total")+"::"+rsdetail2.getString("discount")+"::"+
						    rsdetail2.getString("nettotal") ;
							arr2.add(temp2);
							rowcounts++;
			
							bean.setSecarray(2);
						
				          }
				             
					request.setAttribute("subdetails", arr2);
					stmtgrid2.close();
					 
					
					   
				     ArrayList<String> arr5=new ArrayList<String>();
				   	 Statement stmtgrid5 = conn.createStatement ();       
				     String temp5="";  
		 
					
						String strSqldetail5="select   refdocno doc_nos, desc1, refno,  DATE_FORMAT(date,'%d.%m.%Y') AS date from  my_deldetaild where status=3 and rdocno='"+docno+"' and dtype='"+dtype+"' ";	
				       
			
					ResultSet rsdetail5=stmtgrid5.executeQuery(strSqldetail5);
					
			 
			
					while(rsdetail5.next()){

							 
							 
				temp5=rsdetail5.getString("desc1")+"::"+rsdetail5.getString("refno")+"::"+rsdetail5.getString("date") ;
						arr5.add(temp5);
						 
			
							 
						
				          }
				             
					request.setAttribute("shipdetails", arr5);
					stmtgrid5.close();
					Statement stmtss=conn.createStatement();
					String sqlss="select voc_no from my_ordm where doc_no="+docno;
					ResultSet rsss=stmtss.executeQuery(sqlss);
					int vocno=docno;
					if(rsss.first()){
						vocno=rsss.getInt("voc_no");
					}
					 
					 String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
				          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
				          		+ "where  tr.dtype='PO' and tr.brhid='"+brhid+"' and tr.rdocno="+vocno+" and tr.status=3 ) tr "
				          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
				          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
				          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
				          		+ "   tr.dtype='PO' and tr.rdocno="+vocno+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
				        	
//					 System.out.println("=====termsquery========="+termsquery);
					 
					bean.setTermQry(termsquery);
					  String productQuery="select @i:=@i+1 as srno,a.* from (Select d.specno specid ,m.part_no productid, "
				         		+ "m.productname, u.unit,round(d.qty,2) qty, round(d.amount,2) amount,round(d.total,2) total,"
				         		+ " round(d.discount,2) discount,round(d.nettotal,2) nettotal , "
				         		+ " round(d.disper,2) disper,'5%' as 'taxper',round(taxamount,2) taxamount,round(nettaxamount,2) nettaxamount    from my_ordd d  left join my_main m on m.doc_no=d.prdId "
				         		+ "left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+docno+"' and d.clstatus=0) a,(select @i:=0) r;";
				      
					//  System.out.println("product qry==="+productQuery);
					  
					bean.setPrdQry(productQuery);
  	String srvQry=" select srno,desc1 description,round(unitprice,2) unitprice1,round(qty,2) qty1,round(total,2) total1, "
							+ "round(discount,2) discount1,round(nettotal,2) nettotal1 from my_ordser  where tr_no='"+docno+"'";
							
					bean.setSrvQyy(srvQry);
					Statement amout=conn.createStatement();
					 
						String nettotQry="select round(m.supplexp,2) subtotal,round(m.nettotal,2)nettotal,round(if(prddiscount>0,prddiscount,discount),2) discount   from my_ordm m  "
							+ " left join (select coalesce(sum(nettotal),0)  total,rdocno from   my_ordd where clstatus=1 group by rdocno) a on a.rdocno=m.doc_no where m.doc_no="+docno+";";
					//System.out.println("nettotQry"+nettotQry);
						ResultSet rsnettot=amout.executeQuery(nettotQry);
					while(rsnettot.next()){
						bean.setSrvtotal(rsnettot.getString("subtotal"));
						bean.setNetAmountprint(rsnettot.getString("nettotal"));
						bean.setWordnetAmtPrint(c.convertAmountToWords(rsnettot.getString("nettotal")));
						bean.setDiscount(rsnettot.getString("discount"));
						bean.setLbldiscountvalue(rsnettot.getString("discount"));
					}
			 
					
					//noushad   pls don't change this query. This is use in  purchaseorderprint3.jsp
					
				 
					Statement stmtgrid1=conn.createStatement();
				  	String sqls11="select  round(sum(total),2) total,round(sum(discount),2) discount,round(sum(nettotal),2) nettotal,round(sum(taxamount),2) taxamount, "
				  			+ "  round(sum(nettotal+coalesce(taxamount,0))+coalesce((select round(sum(coalesce(nettotal,0)),2)    from"
				  			+ " my_ordser where rdocno='"+docno+"'),0),2) netamount,round(coalesce((select round(sum(coalesce(nettotal,0)),2)  "
				  					+ "  from my_ordser where rdocno='"+docno+"' ),0),2) nettotalsrv from  my_ordd where rdocno='"+docno+"' ";
					 
				     System.out.println("===sqls11===="+sqls11);
			     	ResultSet tot11=stmtgrid1.executeQuery(sqls11);
			     	if(tot11.next()){
			     		
			     		
			     		bean.setLblamounttot(tot11.getString("total"));
			     		bean.setLbldiscval(tot11.getString("discount"));
			     		bean.setLblnetafterdisc(tot11.getString("nettotal"));
			     		bean.setLblnettaxprint3(tot11.getString("taxamount"));
			     		bean.setLblsrvamount(tot11.getString("nettotalsrv"));
			     		
			     		 
			     		bean.setLastvalue(tot11.getString("netamount"));
			     		bean.setLastvaluewords(c.convertAmountToWords(tot11.getString("netamount")));
			     		
			     		
			     	}
			   
			     		  	/*bean.setLblordervaluewords(c.convertAmountToWords(tot.getString("total")));
				    	    bean.setLblordervalue(tot.getString("total"));
			     	*/
			     	
		 			
					
					
					
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 
	
		
	public   JSONArray lastpurchaseSearch(HttpSession session,String psrno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt  = conn.createStatement ();  

			
			String pySql=("select  m.date,h.description,h.account,d.qty,d.amount unitprice,d.nettotal/d.qty netunitprice from my_srvm m "
        	+" left join my_head h on h.doc_no=m.acno left join my_srvd d on d.rdocno=m.doc_no where m.status<>7 and d.psrno='"+psrno+"' "
        			+ " and m.brhid='"+session.getAttribute("BRANCHID")+"' order by  m.date desc limit 5  ");
			//System.out.println("======pySql======="+pySql);
			ResultSet resultSet = stmt.executeQuery (pySql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
		
	public JSONArray brandSearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray subCategorySearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,subcategory from my_scatm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
}

