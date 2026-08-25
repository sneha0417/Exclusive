package com.sales.InventoryTransfer.goodsissuenotereturn;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
 

public class ClsGoodsissuenotereturnDAO {     

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	  Connection conn=null;
public int insert(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno, String reftype, int refdocno) throws SQLException {
	 

	
	
	try{
		int docno;
	
	    conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtgir= conn.prepareCall("{call tr_goodsissuenoteretunDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtgir.registerOutParameter(15, java.sql.Types.INTEGER);
		stmtgir.registerOutParameter(16, java.sql.Types.INTEGER);

		stmtgir.setDate(1,masterdate);
		stmtgir.setString(2,refno);
		stmtgir.setString(3,purdesc);
		stmtgir.setDouble(4,productTotal);
	  	 
		stmtgir.setString(5,session.getAttribute("USERID").toString());
		stmtgir.setString(6,session.getAttribute("BRANCHID").toString());
		stmtgir.setString(7,session.getAttribute("COMPANYID").toString());
		
		
	//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
		stmtgir.setString(8,formdetailcode);
		stmtgir.setString(9,mode);
 
		
		stmtgir.setInt(10,txtlocationid);
		
 
		stmtgir.setInt(11,siteid);
		stmtgir.setInt(12,type);
		stmtgir.setInt(13,itemtype);
		stmtgir.setInt(14,itemdocno);
		stmtgir.setInt(17,cldocno);
		
		stmtgir.setString(18,reftype);
		
		stmtgir.setInt(19,refdocno);
		
		
		stmtgir.executeQuery();
		docno=stmtgir.getInt("docNo");
 
		int vocno=stmtgir.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		 Statement stmt1=conn.createStatement();
		 
		 Statement stmt=conn.createStatement();
		 
		 
			String sqlss11="select doc_no from cm_srvcontrm where tr_no="+itemdocno+" ";
			ResultSet selrs1=stmt1.executeQuery(sqlss11);
			
			if(selrs1.next())
			{
				itemdocno=selrs1.getInt("doc_no");
				
			}
		 
			
			
		 
		 
			int mastertr_no=0;
			String sqlss="select tr_no from my_girm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			int prodet=0;
			int prodout=0;
			int mm=0;
			
			for(int i=0;i< masterarray.size();i++){

				String[] prod=((String) masterarray.get(i)).split("::");
				System.out.println("prod[0]===="+prod[0]);
				
				if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")||(prod[0].equalsIgnoreCase("null"))))){


					if(vocno>0)
					{


						String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						String specno=""+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"";
											 
						String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
						double masterqty=Double.parseDouble(rqty);

						String stkid=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
						//int stockid=Integer.parseInt(stkid);

						String cost_prices=""+(prod[8].equalsIgnoreCase("undefined") || prod[8].equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"";
						
						  String unitidss=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
						    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						     
					    	 
					         
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
						     
						 //    System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
						
						 if(reftype.equalsIgnoreCase("DIR"))
					      {		
							 
							 double cost_pricess=Double.parseDouble(cost_prices);
							 
							 double totalcostpricesaves=cost_pricess*masterqty;
								String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row,fr)VALUES"
										+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
										+ "'"+0+"',"
										+ "'"+0+"',"
										+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+masterqty+"',"
										+ ""+cost_pricess+","
										+ ""+totalcostpricesaves+","
							 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
										+ "'"+txtlocationid+"','"+0+"',"+fr+")";
							int	prodets = stmt.executeUpdate (sql);
							if(prodets<0)
							{
								conn.close();
								return 0;
							}
								
					      }
						 
						 else
						 {
						
							 
							 
									String rdocno=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[11].isEmpty()?0:prod[11].trim())+"";
									
							 
						/*	 
							 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
									   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"
									   +rows[i].cost_price+" ::"+rows[i].savecost_price+"::"+rows[i].stkid+"::"+rows[i].rdocno+"::"+rows[i].detdocno);
						
						*/
									
									String sqlssss="select  * from my_gisd   where rdocno="+rdocno+" and stockid>0 ";
									 ResultSet rsss=stmt.executeQuery(sqlssss);
									 if(rsss.next())
									 {
										 
										 mm=1;
									 }
										
									 
										String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row,fr)VALUES"
												+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
												+ "'0',"
												+ "'0',"
												+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+masterqty+"',"
												+ "'0',"
												+ "'0',"
									 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
												+ "'"+txtlocationid+"','"+rdocno+"',"+fr+")";
	
										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										
										
										double   out_qty=0;
										
										
										int stockidss=0;
										
										String delsqls1="select out_qty,stockid from  my_gisd   where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+"  ";
										ResultSet rssss=stmt.executeQuery(delsqls1);
										if(rssss.first())
										{
											out_qty=rssss.getDouble("out_qty");
											stockidss=rssss.getInt("stockid");
										}
										//System.out.println("--out_qtys---"+out_qty);
										//System.out.println("--rqty---"+rqty);
										if(stockidss==0)
										{
										out_qty=out_qty+masterqty;
										String delsqls="update my_gisd set out_qty="+out_qty+" where rdocno="+rdocno+" and prdid="+prdid+"  and  unitid="+unitidss+"  ";
										//System.out.println("--1---sqls---"+delsqls);

										stmt.executeUpdate(delsqls);
										}
							
									     double remqty=0;
											double saveqty=0;
											double delnqty=0;
											double balstkqty=0;
											int psrno=0;
											int stockid=0;
											int refstockid=0;
											double remstkqty=0.0;
											double outstkqty=0.0;
											double stkqty=0.0;
											double inqty=0.0;
											double detqty=0.0;
											double prdinqty=0.0;
											double del_qty=0.0;
											double unitprice=0.0;
											double costprice=0.0,prdout=0;
											
											
											double outsave=0.0;
											
										 
											int docnoss=0;
											Statement stmtstk=conn.createStatement();

											Statement stmtstk1=conn.createStatement();
											
											
											//System.out.println("=masterqty=== ="+masterqty);

										//	System.out.println("=fr=== ="+fr);
											double masterqty1=masterqty*fr;
											//System.out.println("=masterqty1=== ="+masterqty1);
											
											String stkSql=" select o.qty-coalesce(o.out_qty,0) qty ,o.stockid,o.doc_no    from my_prddout o  "
													+ " 	where   o.rdocno in("+rdocno+")    and  "
															+ " o.psrno='"+prdid+"' and o.specid='"+specno+"'   and  o.qty>coalesce(o.out_qty,0)     group by o.doc_no ";
										
									 
										
											

											//System.out.println("=stkSql=inside==================== insert="+stkSql);

											ResultSet rsstk = stmtstk.executeQuery(stkSql);

											while(rsstk.next()) {
												 
												docnoss=rsstk.getInt("doc_no");
											 
												stockid=rsstk.getInt("stockid");
												del_qty=rsstk.getDouble("qty");
												 
												
											/*	 if(docnoset.equalsIgnoreCase("0"))
												 {
													 docnoset="0,";
												 }
												 else
												 {
													 docnoset=docnoss+","; 
												 }*/
													
												
													
												/* 	 if(docnoset.endsWith(","))
														{
											    		 docnoset = docnoset.substring(0,docnoset.length() - 1);
														}*/
												 	 
												 	 
												 	// System.out.println("==========docnoset========"+docnoset);
												 	 
												 	 
													
												 String stkSql11="select i.unit_price,i.cost_price from  my_prddin i where  i.stockid="+stockid+" " ;
												 
												 ResultSet rsstk1 = stmtstk1.executeQuery(stkSql11);

													if(rsstk1.next()) {
														unitprice=rsstk1.getDouble("unit_price");
														costprice=rsstk1.getDouble("cost_price");
														
													}
												 
													 String stkSql111="select out_qty from  my_prddout  where  doc_no="+docnoss+" " ;
													 
													 ResultSet rsstk11 = stmtstk1.executeQuery(stkSql111);

														if(rsstk11.next()) {
															prdout=rsstk11.getDouble("out_qty");
															 
															
														}
													 
													
													
													
												 
													if(remqty>0)
													{

														masterqty1=remqty;
													}

													
													//System.out.println("=masterqty1======== ="+masterqty1);
													//System.out.println("=del_qty======== ="+del_qty);
													

													if(masterqty1<=del_qty)
													{
														 


														String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
																+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"
																+ "'"+stockid+"',"
																+ ""+unitprice+","
																+ ""+costprice+","
																+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+masterqty1+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+txtlocationid+"','"+masterdate+"',"+unitidss+","+fr+","+docnoss+")";

													//	System.out.println("prodinsql-1-->>>>Sql"+prodinsql);
														prodout = stmt.executeUpdate (prodinsql);
														
														
													 
												
														 
														outsave=prdout+masterqty1;
														
														String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
													//	System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
														prodout = stmt.executeUpdate (prodinsql1);

														if(mm==1)
														{
														
														String prodinsql11="update   my_gisd set out_qty=out_qty+"+masterqty1+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
													//	System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
														prodout = stmt.executeUpdate (prodinsql11);
														
														}
													

														masterqty1=0;
													 //	docnoset=docnoset+docnoss+",";
														break;


													}
													else if(masterqty1>del_qty)
													{



														 
															remqty=masterqty1-del_qty;
														 
															
															
															String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
																	+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"
																	+ "'"+stockid+"',"
																	+ ""+unitprice+","
																	+ ""+costprice+","
																	+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
																	+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																	+ "'"+del_qty+"',"
																	+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																	+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+txtlocationid+"','"+masterdate+"',"+unitidss+","+fr+","+docnoss+")";

															System.out.println("prodinsql--2->>>>Sql"+prodinsql);
															prodout = stmt.executeUpdate (prodinsql);
															
															
														 
															outsave=prdout+del_qty;
															
															String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
														//	System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
															prodout = stmt.executeUpdate (prodinsql1);

															 
															if(mm==1)
															{
															String prodinsql11="update   my_gisd set out_qty=out_qty+"+del_qty+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
														//	System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
															prodout = stmt.executeUpdate (prodinsql11);
															}
															
														}
													
													
													
												 
													 
												 //	 System.out.println("==========docnoss========"+docnoss);
												 	 
													 

										
												 	if(masterqty1==0)
													{
														
														break;
													}
											    	 }
											    	  
	
/*							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							int refstockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double unitprice=0.0;
							double costprice=0.0;
							double tmp_qty=0.0;
							double outqtys=0.0;
							double prdinqty=0.0;
						
							
							double NtWtKG=0.0;
							double KGPrice=0.0;
							double total=0.0;
							double discper=0.0;
							double discount=0.0;
							double netotal=0.0;
							double costpricesave=0;
							double totalcostpricesave=0;
							masterqty1=masterqty;
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
			
									Statement stmtstk=conn.createStatement();
			
			
									String stkSql="select d.rdocno,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_gism m "
											+ " left join  my_gisd d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
											+ "where d.rdocno in("+refdocno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+txtlocationid+"'  "
											+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date,i.stockid";
									

									double masterqty1=masterqty*fr;
									//System.out.println("=masterqty1=== ="+masterqty1);
									
									String stkSql=" select o.qty-coalesce(o.out_qty,0) qty ,o.stockid,o.doc_no    from my_prddout o  "
											+ " 	where   o.rdocno in("+rdocno+")    and  "
													+ " o.psrno='"+prdid+"' and o.specid='"+specno+"'   and  o.qty>coalesce(o.out_qty,0)     group by o.doc_no ";
									System.out.println("=stkSql=inside insert="+stkSql);
			
									ResultSet rsstk = stmtstk.executeQuery(stkSql);
			
									while(rsstk.next()) {
			
			
										balstkqty=rsstk.getDouble("balstkqty");
										psrno=rsstk.getInt("psrno");
										outstkqty=rsstk.getDouble("out_qty");
										stockid=rsstk.getInt("stockid");
										stkqty=rsstk.getDouble("stkqty");
										prdinqty=rsstk.getDouble("qty");
										unitprice=rsstk.getDouble("unit_price");
										costprice=rsstk.getDouble("cost_price");
									 
										
										
										System.out.println("---masterqty-----"+masterqty);	
										System.out.println("---balstkqty-----"+balstkqty);	
										System.out.println("---out_qty-----"+outstkqty);	
										System.out.println("---stkqty-----"+stkqty);
										System.out.println("---qty-----"+qty);
			
			 
										
										String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date) Values"
												+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"
												+ "'"+stockid+"',"
												+ ""+unitprice+","
												+ ""+costprice+","
												+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+masterqty+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+txtlocationid+"','"+masterdate+"')";
			
										System.out.println("prodinsql--1->>>>Sql"+prodinsql);
										prodout = stmt.executeUpdate (prodinsql);
										Statement stmtstk1=conn.createStatement();
										String nstkSql="select stockid from  my_prddin where  refstockid="+stkid+" and tr_no="+mastertr_no+" and psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"";
			
										System.out.println("=nstkSql="+nstkSql);
			
										ResultSet rsnstk = stmtstk1.executeQuery(nstkSql);
			
										if(rsnstk.next()) {
											refstockid=rsnstk.getInt("stockid");
										}
			
										costpricesave=costprice;
			
						  
											if(masterqty<=balstkqty)
											{
												break;
											}	
											
											
			
			
									}
						 
			
									System.out.println("=====reftype===="+reftype);
									
						      if(reftype.equalsIgnoreCase("GIS"))
						      {
			
										double balqty=0;
										int docnos=0;
										int rdocno=0;
										double remqty=0;
										double out_qty=0;
										double qtys=0;
										int invstk=0;
										double secqty=0;
										Statement stmt12=conn.createStatement();
			
										String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_gism m  left join "
												+ "my_gisd d on m.doc_no=d.rdocno where d.rdocno in ("+refdocno+") and d.stockid="+stkid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+txtlocationid+"'  and d.prdid='"+prdid+"' group by d.rowno having  sum(d.qty-d.out_qty)>0 "
												+ "order by m.date,d.rowno";
			
										System.out.println("---strSql-----"+strSql);
										ResultSet rs = stmt12.executeQuery(strSql);
			
			
										while(rs.next()) {
			
			
											balqty=rs.getDouble("balqty");
											rdocno=rs.getInt("rdocno");
											out_qty=rs.getDouble("out_qty");
			
											docnos=rs.getInt("doc_no");
											qtys=rs.getDouble("qty");
											invstk=rs.getInt("stockid");
			
											System.out.println("---masterqty-----"+masterqty);	
											System.out.println("---balqty-----"+balqty);	
											System.out.println("---out_qty-----"+out_qty);	
											System.out.println("---qtys-----"+qtys);
			
			
											if(remqty>0)
											{
			
												masterqty1=remqty;
											}
			
			
											if(masterqty1<=balqty)
											{
												
												
									              totalcostpricesave=costprice*masterqty1;
						 					String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row)VALUES"
														+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
														+ "'"+refstockid+"',"
														+ "'"+stockid+"',"
														+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+masterqty1+"',"
														+ ""+costprice+","
														+ ""+totalcostpricesave+","
											 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
														+ "'"+txtlocationid+"','"+docnos+"')";
								
												
												
			 
			
												System.out.println("branchper--1->>>>Sql"+sql);
												prodet = stmt.executeUpdate (sql);
												
												
												masterqty1=masterqty1+out_qty;
			
			
												String sqls="update my_gisd set out_qty="+masterqty1+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+"";
			
												System.out.println("--1---sqls---"+sqls);
			
			
												stmt.executeUpdate(sqls);
												break;
			
			
											}
											else if(masterqty1>balqty)
											{
												secqty=balqty;
			
			
												if(qtys>=(masterqty1+out_qty))
			
												{
													balqty=masterqty1+out_qty;	
													remqty=qtys-out_qty;
			
													//	System.out.println("---remqty-1---"+remqty);
												}
												else
												{
													remqty=masterqty1-balqty;
													balqty=qtys;
			
													//System.out.println("---remqty--2--"+remqty);
												}
			
			
												String sqls="update my_gisd set out_qty="+balqty+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+"";	
												System.out.println("-2----sqls---"+sqls);
												
												
												
												stmt.executeUpdate(sqls);	
												
												   totalcostpricesave=costprice*secqty;
												String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId, qty,cost_price,totalcost_price,UNITID,locid,ref_row)VALUES"
														+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
														+ "'"+refstockid+"',"
														+ "'"+stockid+"',"
														+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+secqty+"',"
														+ ""+costprice+","
														+ ""+totalcostpricesave+","
											 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
														+ "'"+txtlocationid+"','"+docnos+"')";
								
			 
			
												System.out.println("branchper--2->>>>Sql"+sql);
												prodet = stmt.executeUpdate (sql);
												//remqty=masterqty-qtys;
			
			
			
											}
			
										}  
			
									}
			
						*/
						 
						 
						 }//else
								
					}// voc
			
					}// pro
			
					}// for

 
			
			String vendorcur="1"; 
			double venrate=1;
			
	 int accounts=0;
	 
	 
	 double  finalamt=0;
		String refdetails="GIR"+""+vocno;
		
		int trno=mastertr_no;
	 
	 
		
		String s="select sum(costval) totalcost_price,tr_no from  (select op_qty*cost_price costval ,tr_no from my_prddin where  tr_no="+trno+" and dtype='GIR'  ) a group by a.tr_no ";
		
		System.out.println("-----4--s----"+s) ;

			ResultSet tass30 = stmt.executeQuery (s);

			if (tass30.next()) {

				finalamt=tass30.getDouble("totalcost_price");		
				 ;
			}
		 
	 
	 
				
			String sql29="select acno from my_issuetype where doc_no='"+type+"' ";
		System.out.println("-----4--sql2----"+sql29) ;

			ResultSet tass19 = stmt.executeQuery (sql29);

			if (tass19.next()) {

				accounts=tass19.getInt("acno");		

			}
		 
			

			String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
			//System.out.println("---1----sqls10----"+sqls10) ;
			ResultSet tass11 = stmt.executeQuery (sqls10);
			if(tass11.next()) {

				vendorcur=tass11.getString("curid");	


			}


			String currencytype="";
			String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
			 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
			ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

			while (resultSet33.next()) {
				venrate=resultSet33.getDouble("rate");
				currencytype=resultSet33.getString("type");
			}

			double	dramount=finalamt*-1; 


			double ldramount=0;
			if(currencytype.equalsIgnoreCase("D"))
			{


				ldramount=dramount/venrate ;  
			}

			else
			{
				ldramount=dramount*venrate ;  
			}



			String sql1="";
		/*	if(itemtype==1 || itemtype==6)
			{
*/
				  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,6,0,0,0,'"+venrate+"','GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";
         	
/*			}
			else
			{
				  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,6,0,0,0,'"+venrate+"',0,0,'GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
         	
			}
				*/
			
			
			//	System.out.println("--sql1----"+sql1);
			int ss = stmt.executeUpdate(sql1);

			if(ss<=0)
			{
				conn.close();
				return 0;

			}
			
			int acnos=0;
			String curris="1";
			double rates=1;



			String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
			//System.out.println("-----4--sql2----"+sql2) ;

			ResultSet tass1 = stmt.executeQuery (sql2);

			if (tass1.next()) {

				acnos=tass1.getInt("acno");		

			}



			String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
			//System.out.println("-----5--sqls3----"+sqls3) ;
			ResultSet tass3 = stmt.executeQuery (sqls3);

			if (tass3.next()) {

				curris=tass3.getString("curid");	


			}
			String currencytype1="";
			String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
			//System.out.println("-----6--sqlveh----"+sqlveh) ;
			ResultSet resultSet44 = stmt.executeQuery(sqlveh);

			while (resultSet44.next()) {
				rates=resultSet44.getDouble("rate");
				currencytype1=resultSet44.getString("type");
			} 

			double pricetottal=finalamt;
			double ldramounts=0 ;     
			if(currencytype1.equalsIgnoreCase("D"))
			{

				ldramounts=pricetottal/venrate ;  
			}

			else
			{
				ldramounts=pricetottal*venrate ;  
			}

			String sql11="";
		/*	if(itemtype==1 || itemtype==6)
			{*/

			  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
					+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,6,0,0,0,'"+rates+"','GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";

/*			}
			else
			{

				  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,6,0,0,0,'"+rates+"',0,0,'GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
	
			}*/
			// System.out.println("---sql11----"+sql11) ; 

			int ss1 = stmt.executeUpdate(sql11);

			if(ss1<=0)
			{
				conn.close();
				return 0;

			}
			
			
			
			if(itemtype>0)
			{

				 int TRANIDs=0;
				 int sno=1;
				  
			Statement sss=conn.createStatement();
					String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+mastertr_no+" and acno="+accounts+" ";
			
					ResultSet tass111 = sss.executeQuery (trsqlss);
					
					if (tass111.next()) {
				
						TRANIDs=tass111.getInt("TRANID");	
					
					
						
				     }
					
					String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
							+ " "+itemtype+","+finalamt*-1+","+itemdocno+","+TRANIDs+","+mastertr_no+")";
							 
			  int costabsq=  stmtgir.executeUpdate(ssql);
			  
			  if(costabsq<=0)
				{
					conn.close();
					return 0;
					
				}
			}
			
			
			if(docno>0)
			{
				conn.commit();
				stmtgir.close();
				conn.close();
				return docno;
				
			}
	 
			
			}
/*		for(int i=0;i< masterarray.size();i++){

			String[] prod=((String) masterarray.get(i)).split("::");
			System.out.println("prod[0]===="+prod[0]);
			if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


				double balstkqty=0;
	 
				int psrno=0;
				int stockid=0;
				double remstkqty=0;
				double outstkqty=0;
				double stkqty=0;
				double qty=0;
				double detqty=0;
				double unitprice=0.0;
				double tmp_qty=0.0;
				double outqtys=0.0;
				double refqty=0.0;
				 
				String loc="";
				 
				
				int locids=0;	 
					
					
		
 
		String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
		String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
		String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
		String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
		double masterqty=Double.parseDouble(rqty);
		Statement stmtstk=conn.createStatement();
		
		String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum(op_qty-out_qty+rsv_qty+del_qty) balstkqty,sum(out_qty+rsv_qty+del_qty) out_qty, "
				+ " out_qty as qty,out_qty qtys,date from my_prddin "
				+ "where psrno='"+prdid+"' and specno='"+specno+"'  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"  "
				+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-out_qty+rsv_qty+del_qty))>0 order by date,stockid";

		 
		ResultSet rsstk = stmtstk.executeQuery(stkSql);

		while(rsstk.next()) {

		
			balstkqty=rsstk.getDouble("balstkqty");
			psrno=rsstk.getInt("psrno");
			outstkqty=rsstk.getDouble("out_qty");
			stockid=rsstk.getInt("stockid");
			stkqty=rsstk.getDouble("stkqty");
			qty=rsstk.getDouble("qty");
			outqtys=rsstk.getDouble("qtys");
			locids=rsstk.getInt("locid");
			 
			
			
			refqty=masterqty;
			System.out.println("---masterqty-----"+masterqty);	
			System.out.println("---balstkqty-----"+balstkqty);	
			System.out.println("---out_qty-----"+outstkqty);	
			System.out.println("---stkqty-----"+stkqty);
			System.out.println("---qty-----"+qty);

			String queryappnd="";
	 

			if(remstkqty>0)
			{

				masterqty=remstkqty;
			}

			 
			if(masterqty<=balstkqty)
			{
				detqty=masterqty;

			 
				
				
				System.out.println("-----queryappnd-----"+queryappnd);
				

				masterqty=masterqty+outqtys;

				
				
				String sqls="update my_prddin set out_qty="+masterqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"   ";
				System.out.println("--1---sqls---"+sqls);
				stmt.executeUpdate(sqls);



			}
			else if(masterqty>balstkqty)
			{



				if(stkqty>=(masterqty+outstkqty))

				{
					balstkqty=masterqty+outqtys;	
					remstkqty=stkqty-outstkqty;

					System.out.println("---balstkqty-1---"+balstkqty);
				}
				else
				{
					remstkqty=masterqty-balstkqty;
					balstkqty=stkqty-outstkqty+outqtys;

					System.out.println("---masterqty-2---"+masterqty);
					System.out.println("---outstkqty-2---"+outstkqty);
					System.out.println("---stkqty-2---"+stkqty);
					System.out.println("---remstkqty-2---"+remstkqty);
					System.out.println("---balstkqty--2--"+balstkqty);
				}
				detqty=stkqty-outstkqty;

		  
					
				}
				
				
				
				String sqls="update my_prddin set out_qty="+balstkqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
				System.out.println("-2----sqls---"+sqls);

				stmt.executeUpdate(sqls);	

				//remstkqty=masterqty-stkqty;



			}



 

 
 

			String prodoutsql="";

	 
				
				
				 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid) Values"
						+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"+docno+","
						+ "'"+stockid+"',"
						+ "'"+masterdate+"',"
						+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+detqty+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"')";

				
			 
			

			System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
			 stmt.executeUpdate (prodoutsql);

	 	if(masterqty<=balstkqty1)
			{
				break;
			} 
 

		}




		}*/

	
	
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	
	return 0;
}


 
 
	
	
public   JSONArray locationsearch(HttpSession session) throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no,brhid from my_locm where status=3 and brhid="+session.getAttribute("BRANCHID").toString()+"" );
 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				


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









public JSONArray costunitsearch(HttpSession session,String typedocno,String docno,String refnames,String search) throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
          
          Connection conn = null; 
         
        try {
           conn = ClsConnection.getMyConnection();
           ClsCommon ClsCommon=new ClsCommon();
           Statement stmtmain = conn.createStatement();
   
           if(search.equalsIgnoreCase("yes")) {
            
            String sql="";
            
            if(typedocno.equalsIgnoreCase("1")) {
             
             sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "
                + "my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
            
            } else {
             
              String costgroup="";String sqltest="";
              Statement stmt=conn.createStatement();
              
              String sqls="select costtype,costgroup from my_costunit where costtype='"+typedocno+"' ";

              ResultSet rs=stmt.executeQuery(sqls);
              
              if(rs.next()) {
               costgroup=rs.getString("costgroup");
              }
              
             if(!(refnames.equalsIgnoreCase("0")) && !(refnames.equalsIgnoreCase(""))){
               sqltest=sqltest+" and ac.refname like '%"+refnames+"%'";
          }
             
             if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
                 sqltest=sqltest+" and m.doc_no='"+docno+"'";
             }
             
             if(typedocno.equalsIgnoreCase("3") || typedocno.equalsIgnoreCase("4")) {
              
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_srvcontrm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.tr_no=m.tr_no where m.status=3 and m.JBAction in (0,4) and m.dtype='"+costgroup+"'"+sqltest+"";
              
             }
             
             if(typedocno.equalsIgnoreCase("5")) {
              
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.contracttype,' ',m.contractno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_cuscallm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.rowno=m.siteid where  m.status in(3) and m.clstatus in(0)"+sqltest+"";
              }
              
              stmt.close();
             
            }
            
           System.out.println("SQL ="+sql);
           ResultSet resultSet = stmtmain.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
              
           stmtmain.close();
           conn.close();
           }
         stmtmain.close();
         conn.close();
        } catch(Exception e){
          e.printStackTrace();
          conn.close();
        } finally{
      conn.close();
     }
          return RESULTDATA;
     }




public JSONArray prdGridReloads(HttpSession session,String docno,String locaid) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

 
		
		String sql="";
 
 
 
 	sql=" select d.rowno detdocno,bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
				+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(qty-out_qty) qutval,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
			    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
			    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
				+ " (sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis, "
				+ " ((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
				+ "  from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") and   ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.rdocno,d.prdid,d.unitid,d.specno "
				+ "  having sum(d.qty-d.out_qty)>0  order by d.rdocno,d.prdid ";
	 
		
 
 
		
 
/*		sql="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, qty,qty as oldqty,outqty,"
				+ " qutval,0 size,part_no,productid as proid,productid,"
				+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
				+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qty as qutval, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
				+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select bd.brandname,i.stockid as stkid,"
				+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,ii.inblqty as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
				+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
				+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)"
				+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
				+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and i.locid=d.locid)  "
				+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
				+ "	   from my_prddin where 1=1 group by psrno,locid) ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=i.locid) "
				+ " where m.status=3 and d.rdocno in("+docno+")   group by i.prdid,i.prdid"
				+ "  order by  i.prdid,i.date ) as a ) as b ; ";
		*/
	//System.out.println("-------sql------"+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}



public JSONArray prdGridReloads(HttpSession session,String docno,String locaid,String reftype,String refno) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		// System.out.println("----refno-asdasd---"+refno);
		String sqltet="0";
		if(reftype.equalsIgnoreCase("GIS"))
		{
			sqltet=refno;
		}
		
		String sql=""; 
 
 
		if(reftype.equalsIgnoreCase("GIS"))
		{
		
		sql=" select  detdocno,rdocno ,brandname,refstockid refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,psrno,totqty, qty,qty as oldqty,outqty, "
				 + " inblqty+qty as qutval ,0 size,part_no,productid as proid,productid,  productname as proname,productname,  "
				 + " unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal  from(select detdocno,ref_row rdocno,brandname,refstockid, inblqty  "
				 + " inblqty,stkid,specid,psrno as doc_no,psrno,qtys as totqty, qty,qtys,outqty,  0 size,  "
				 + " part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  "
				 + " dis, netotal from ( select  0 detdocno, d.ref_row ,bd.brandname,dd.inblqty,i.refstockid, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no  "
				 + "  psrno,sum(d.qty) as qty,  sum(i.op_qty) as qtys,dd.out_qty as outqty,m.part_no,m.part_no productid,m.productname,  "
				 + "  u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper,  "
				 + "    d.discount dis,d.nettotal netotal from my_girm ma left join my_gird d on(ma.doc_no=d.rdocno)  "
				 + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)  "
				 + "    left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  left join  my_brand bd on m.brandid=bd.doc_no 	left join my_prddin i  "
				 + "  on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and ma.locid=i.locid)  "
				 + "   left join(select sum(s.qty-s.out_qty) inblqty,sum(s.out_qty) out_qty,s.stockid,s.psrno,s.prdid,s.specno,s.unitid,s.rdocno from my_gisd s"
				 + "   where s.rdocno in("+sqltet+") group by s.rdocno,s.psrno,s.unitid,s.specno)  "
		         + "   dd on  (dd.psrno=d.psrno and dd.prdid=d.prdid and  dd.specno=d.specno  and d.refstockid=dd.stockid and  d.unitid=dd.unitid and dd.rdocno=d.ref_row)  "
		         + "  where m.status=3 and  d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
	         		+ " and ma.locid="+locaid+"  group by d.ref_row,d.psrno,d.unitid,d.specno order by d.ref_row,d.psrno,d.unitid,d.specno ) as a ) as b  ";
		
		
	/*	sql=" select detdocno,rdocno ,brandname,refstockid refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,psrno,totqty, qty,qty as oldqty,outqty, "
				 + " inblqty+qty as balqty ,0 size,part_no,productid as proid,productid,  productname as proname,productname,  "
		 + " unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal  from(select detdocno,ref_row rdocno,brandname,refstockid, inblqty  "
		 + " inblqty,stkid,specid,psrno as doc_no,psrno,qtys as totqty, qty,qtys,outqty,  0 size,  "
		 + " part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  "
		  + " dis, netotal from ( select  d.detdocno detdocno, d.ref_row ,bd.brandname,coalesce(dd.inblqty,0) inblqty,i.refstockid, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no  "
		 + "  psrno,sum(d.qty) as qty,coalesce(dd.oldqty,0) as qtys,coalesce(dd.delbalqty,0)   outqty,m.part_no,m.part_no productid,m.productname,  "
		   + "  u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper,  "
		   + "    d.discount dis,d.nettotal netotal from my_invr ma left join my_inrd d on(ma.doc_no=d.rdocno)  "
		    + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)  "
		    + "    left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  left join  my_brand bd on m.brandid=bd.doc_no 	left join my_prddin i  "
		       + "  on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and ma.locid=i.locid)  "
		       + "    left join(select sum(s.qty-s.out_qty) inblqty,sum(s.out_qty) out_qty,sum(qty-out_qty)  delbalqty,sum(qty) oldqty,s.stockid,"
		       + "s.psrno,s.prdid,s.specno,s.unitid,s.rdocno "
		       + "  from my_invd s  where s.rdocno in("+enqdoc+") group by s.rdocno,s.psrno,s.unitid,s.specno)  "
		           + "    dd on  (dd.psrno=d.psrno and dd.prdid=d.prdid and      dd.specno=d.specno and  d.unitid=dd.unitid and dd.rdocno=d.ref_row)  "
	         + "     	where m.status=3 and  d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
	         		+ " and ma.locid="+locaid+"  group by d.ref_row,d.psrno,d.unitid,d.specno  order by d.ref_row,d.psrno,d.unitid,d.specno) as a ) as b  ";
		
		
 
		*/
		
		}
		else
		{
			
 
			
					sql=" select cost_price,brandname,refstockid refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, "
					+ " qty,qty as oldqty,outqty,  inblqty as qutval ,0 size,part_no,productid as proid,productid, "
					+ " productname as proname,productname,   unit,unitdocno, totwtkg,  kgprice, unitprice, total, "
					+ " discper,  dis, netotal  from(select cost_price,brandname,refstockid, inblqty   inblqty, "
					+ " stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty, "
					+ " 0 size,   part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, "
					+ " total, discper,   dis, netotal from ( select bd.brandname,i.inblqty/d.fr inblqty,0 refstockid, "
					+ " 0  stkid,d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty, "
					+ " 0 qtys,0  outqty,m.part_no,m.part_no productid,m.productname, "
			        + " u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, "
			        + " d.discount dis,d.nettotal netotal,d.cost_price from my_girm ma left join my_gird d on(ma.doc_no=d.rdocno) "
			        + " left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
			        + " left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
			        + "  left join  my_brand bd on m.brandid=bd.doc_no "
			        + "  left join (select psrno,prdid,specno,brhid,locid,sum(op_qty-(out_qty+del_qty+rsv_qty)) inblqty "
			        + "    from  my_prddin  group by prdid "
			        + "  having sum(op_qty-(out_qty+del_qty+rsv_qty)>0)) i "
			        + "     on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and "
			        + "    ma.brhid=i.brhid  and ma.locid=i.locid) "
                    + "    where m.status=3 and  d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
                    + " and ma.locid="+locaid+" group by d.prdid  order by d.prdid) as a ) as b "; 
		}
 
 
 
 System.out.println("----asdsad---sql------"+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}


 
public   JSONArray mainsearch(HttpSession session,String docnoss,String types,String datess,String aa,String prjdocnos) throws SQLException {

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
      	if((!(types.equalsIgnoreCase(""))) && (!(types.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and t.type like '%"+types+"%'  ";
      	}
       
        String sqlsss2="";
      	if((!(prjdocnos.equalsIgnoreCase(""))) && (!(prjdocnos.equalsIgnoreCase("NA")))){
      		sqlsss2= " and a.costdocno like '%"+prjdocnos+"%'  ";
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
			
			

			
/*        	String pySql=("select m.doc_no,m.voc_no,m.date,t.type,m.description desc1 from my_gism m left join my_issuetype t on t.doc_no=m.issuetype "
        			+ " where m.status=3   and m.brhid='"+brcid+"' "+sqltest );
        	
        	*/
        	String pySql="select * from ( select u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
        			+ "m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
        			+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
        			+ " from my_girm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
        			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
        			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
        			+ " where m.status=3 and m.brhid='"+brcid+"' "+sqltest+" ) a where 1=1 "+sqlsss2+" "; 
        	
        	
     //  System.out.println("========"+pySql);
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



public   JSONArray subrefmainsearch(HttpSession session,String docnoss,String types,String datess,String aa) throws SQLException {

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
      	if((!(types.equalsIgnoreCase(""))) && (!(types.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and t.type like '%"+types+"%'  ";
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
			
			

			
/*        	String pySql=("select m.doc_no,m.voc_no,m.date,t.type,m.description desc1 from my_gism m left join my_issuetype t on t.doc_no=m.issuetype "
        			+ " where m.status=3   and m.brhid='"+brcid+"' "+sqltest );
        	
        	*/ 
        	String pySql=" select m.costdocno costtr_no, u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
        			+ " m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
        			+ " case when m.costtype=6 then m.costdocno when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
        			+ " case when m.costtype=6 then mm.flname   when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
        			+ " from my_gism m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
        			+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
        			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
        			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' left join my_gisd d on d.rdocno=m.doc_no "
        			+ " where m.status=3 and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no having sum(d.qty-d.out_qty)>0" ;
        	
        	
    System.out.println("========"+pySql);
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



public   ClsGoodsissuenotereturnBean   getViewDetails(int masterdoc_no) throws SQLException {
	
	ClsGoodsissuenotereturnBean showBean = new ClsGoodsissuenotereturnBean();
	Connection conn=null;
	try { conn = ClsConnection.getMyConnection();
	Statement stmt  = conn.createStatement ();
 

	String sqls=" select m.rdtype,m.rrefno reqdocno,rq.voc_no rrefno,m.costdocno costtr_no,m.description,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			+ " case when m.costtype=6 then m.costdocno when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
 	+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
	+ " case when m.costtype=6 then mm.flname   when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
	+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
	+ " from my_girm m left join my_locm l on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
    + " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
	+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
	+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
	+ " left join  my_gism rq on rq.doc_no=m.rrefno "
	+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in (3,4,5) "
	+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in (3,4,5) and a.dtype='CRM' "
	+ " where m.status=3 and  m.doc_no='"+masterdoc_no+"' ";

	
	ResultSet resultSet = stmt.executeQuery(sqls);    
 
	while (resultSet.next()) {
	
		showBean.setDocno(resultSet.getInt("voc_no"));
			
		showBean.setMasterdate(resultSet.getString("date"));
	 
		showBean.setPurdesc(resultSet.getString("description"));
		 
	 
		showBean.setTxtlocation(resultSet.getString("loc_name"));
		
		showBean.setTxtlocationid(resultSet.getInt("locid"));
	 
 	
		showBean.setRefno(resultSet.getString("refno"));
		 
			 
		showBean.setType(resultSet.getInt("issuetype"));
		showBean.setItemtype(resultSet.getInt("costtype"));
	 	
		showBean.setItemname(resultSet.getString("prjname"));
	 	
		showBean.setItemdocno(resultSet.getInt("costdocno"));
	    
		   
		showBean.setCldocno(resultSet.getInt("cldocno"));
	    
		showBean.setClientname(resultSet.getString("refname"));
	    
		showBean.setSite(resultSet.getString("site"));
		    
		showBean.setSiteid(resultSet.getInt("siteid"));
	    
	    
	 
		showBean.setCosttr_no(resultSet.getInt("costtr_no"));

		
		showBean.setReftype(resultSet.getString("rdtype"));
		showBean.setRrefno(resultSet.getInt("rrefno"));
		showBean.setRefmasterdoc_no(resultSet.getInt("reqdocno"));
		
		
		 
	
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






public int update(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno,int docno, String updatadata, String reftype, int refdocno,int vocno) throws SQLException {
 
	
	
	
	
	try{
	// System.out.println("========sql====="+sql);
		Connection conn=null;
		
	//	System.out.println("====formdetailcode======"+formdetailcode);
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtgir= conn.prepareCall("{call tr_goodsissuenoteretunDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtgir.setInt(15, docno);
		stmtgir.setInt(16, vocno);

		stmtgir.setDate(1,masterdate);
		stmtgir.setString(2,refno);
		stmtgir.setString(3,purdesc);
		stmtgir.setDouble(4,productTotal);
	  	 
		stmtgir.setString(5,session.getAttribute("USERID").toString());
		stmtgir.setString(6,session.getAttribute("BRANCHID").toString());
		stmtgir.setString(7,session.getAttribute("COMPANYID").toString());
		
		
	//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
		stmtgir.setString(8,formdetailcode);
		stmtgir.setString(9,mode);
 
		
		stmtgir.setInt(10,txtlocationid);
		
 
		stmtgir.setInt(11,siteid);
		stmtgir.setInt(12,type);
		stmtgir.setInt(13,itemtype);
		stmtgir.setInt(14,itemdocno);
		stmtgir.setInt(17,cldocno);
		
		stmtgir.setString(18,reftype);
		
		stmtgir.setInt(19,refdocno);
		
		
		int aaa=stmtgir.executeUpdate();
		docno=stmtgir.getInt("docNo");
 
		  vocno=stmtgir.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		// System.out.println("====docno======"+docno);
	
		if(aaa<=0)
		{
			conn.close();
			return 0;
			
		}
		 Statement stmt1=conn.createStatement();
		 
		 Statement stmt=conn.createStatement();
		 
		 System.out.println("====updatadata======"+updatadata);
		if(updatadata.equalsIgnoreCase("Editvalue"))
		{	
				
		
			String sqlss11="select doc_no from cm_srvcontrm where tr_no="+itemdocno+" ";
			ResultSet selrs1=stmt1.executeQuery(sqlss11);
			
			if(selrs1.next())
			{
				itemdocno=selrs1.getInt("doc_no");
				
			}
		 
			
			
				int mastertr_no=0;
				String sqlss1="select tr_no from my_girm where doc_no='"+docno+"' ";
				ResultSet selrs=stmt1.executeQuery(sqlss1);
				
				if(selrs.next())
				{
					mastertr_no=selrs.getInt("tr_no");
					
				}
				int prodet=0;
				int prodout=0;
				int mm=0;
				for(int i=0;i< masterarray.size();i++){

					String[] prod=((String) masterarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")||(prod[0].equalsIgnoreCase("null"))))){


						
						
						if(i==0)
						{
							
							 if(reftype.equalsIgnoreCase("GIS"))
						      {		
								 
								 
								 
									if(i==0)
									{
			        int counts=0;							
			        String tempstk="0";	
			        
			        int stkids=0;
			        
			        String tempstkids="0";
			      
			        int ref_row=0,unitid=0,refstockid=0;	
					double prdqty=0;

					double saveqty=0;
					int tmptrno=0;
					
					int prdidss=0;
					
					double delnqtys=0;
					
					
				//	----------------------
					
					double poutqty=0;
					
					double poutqtys=0;
					
					
					double savepoutqtys=0;
					
					int   pdocnos=0;


		/*			
					-- select ref_row,qty from my_delrd where rdocno=1;


					select out_qty   from my_deld where doc_no=17;
					*/
					
					int kk=0;
					Statement stmnt1112=conn.createStatement();
					  Statement stmnt1111=conn.createStatement();	
					  
					  Statement st33=conn.createStatement();	
					  Statement st34=conn.createStatement();	
					  
				 
					  String sql21="select * from my_prddin  where tr_no='"+mastertr_no+"' and dtype='GIR' and outdocno>0  ";
					  ResultSet rtk1111= stmnt1111.executeQuery(sql21);
				    	
				    	
				    	if(rtk1111.next())
				    	{
				    		
				    		kk=1;
				    	}
					
					
					
					
				  	
				    Statement stmnt=conn.createStatement();		
				    Statement stmnt1=conn.createStatement();
				    Statement stmnt3=conn.createStatement();
				    
				    Statement stmnt4=conn.createStatement();
				    String sql2="select ref_row,qty qty,prdid,tr_no,unitid,stockid, qty*fr outqty from my_gird   where rdocno='"+docno+"'  ";
				    	 System.out.println("-----sql2-----"+sql2);
				    	ResultSet rsstk111 = stmnt1.executeQuery(sql2);
				    	
				    	
				    	while(rsstk111.next())
				    	{
				    		ref_row=rsstk111.getInt("ref_row");
				    		delnqtys=rsstk111.getDouble("qty");
				    		prdidss=rsstk111.getInt("prdid");
				    		tmptrno=rsstk111.getInt("tr_no");
				    		unitid=rsstk111.getInt("unitid");
				    		
				    		refstockid=rsstk111.getInt("stockid");
				    		
				    		
				    		poutqty=rsstk111.getDouble("outqty");
				    		double	remqty=0;
				    		 
						
				    	if(kk==0)	
				    	{
				    	String sqlss="select doc_no, out_qty from my_prddout where rdocno='"+ref_row+"' and prdid="+prdidss+" and out_qty!=0 ";
				    	
				       System.out.println("========sqlss===="+sqlss);
				    	
				    	ResultSet rssss=stmnt4.executeQuery(sqlss);
				    	
				    	loop:while (rssss.next())
				    		
				    	{
				    		
				    		poutqtys=rssss.getDouble("out_qty");
				    		
				    		pdocnos=rssss.getInt("doc_no");
				    		
				    	
				    		if(remqty>0)
							{

				    			poutqty=remqty;
							}
			
				    		
				    	 	System.out.println("========poutqtys out===="+poutqtys);
				    		
				    	 System.out.println("========poutqty ret===="+poutqty);
				    		
				    		
				    		if(poutqty<=poutqtys)
				    		{
				    			 
				    			
				    			savepoutqtys=poutqtys-poutqty;
						    	
						    	if(savepoutqtys<0){
						    		savepoutqtys=0;
						    	
						    	}
				    			
						     	
						      	String sql31="update my_prddout set out_qty="+savepoutqtys+" where doc_no='"+pdocnos+"'  ";
						      	
						      	 
						      	
						    	   System.out.println("-----sql31---1--"+sql31);
						    	 stmnt3.executeUpdate(sql31);
						    	 
				    			break loop;
				    			
				    		}
				    		
				    		else if(poutqty>poutqtys)
				    		{
				    			remqty=poutqty-poutqtys;
				    			
				    			
		                           savepoutqtys=0;
						    	
		                        	String sql31="update my_prddout set out_qty="+savepoutqtys+" where doc_no='"+pdocnos+"'  ";
		    				      	
		   				      	 
		    				      	
		    				    	   System.out.println("-----sql31- 2----"+sql31);
		    				    	 stmnt3.executeUpdate(sql31);
				    			
				    			
				    			
				    			
				    		}
				    		
				    		
				    		
				    		
				    		
				    		
				    	}  //loop
				    		
				    		
				    	}

				    		
				    		
				  
				    		
				    	String sql3=" select out_qty   from my_gisd where rdocno='"+ref_row+"' and prdid="+prdidss+"  and unitid="+unitid+"  and stockid="+refstockid+"  ";
				    	 
				    	 System.out.println("-----sql3-----"+sql3);
				    	ResultSet rsstk1111 = stmnt.executeQuery(sql3);
				    	
				    	
				    	if(rsstk1111.next())
				    	{
				    		prdqty=rsstk1111.getDouble("out_qty");
					    	saveqty=prdqty-delnqtys;
					    	
					    	if(saveqty<0){
					    	saveqty=0;
					    	
					    	}
					    	
					      	String sql31="update my_gisd set out_qty="+saveqty+" where rdocno='"+ref_row+"'and prdid="+prdidss+"  and unitid="+unitid+" and stockid="+refstockid+"  ";
					      	
					      	 
					      	
					    	  System.out.println("-----sql31-----"+sql31);
					    	 stmnt3.executeUpdate(sql31);
					    	 
					    	 
					    	 
					    	 
				    		
				    	}
				    	}//wh
				    	
				    	
				    	
				    	if(kk==1)
				    	{
				    		
				    		int outdocno=0;
				    		double op_qty=0;
				    		double savedata=0;
				    	 	String sql31111=" select op_qty,outdocno   from my_prddin where tr_no="+mastertr_no+"  ";
					    	 
					    	 System.out.println("-----sql31111-----"+sql31111);
					    	ResultSet rsstk11111 = stmnt1112.executeQuery(sql31111);
					    	
					    	
					    	while(rsstk11111.next())
					    	{
					    		
					    		op_qty=0;
					    		outdocno=0;
					    		op_qty=rsstk11111.getDouble("op_qty");
					    		outdocno=rsstk11111.getInt("outdocno");
						    	
						     String selecsql="select out_qty from my_prddout where doc_no='"+outdocno+"' ";
						     
						     ResultSet rd1=st33.executeQuery(selecsql); 
						     
						     if(rd1.next())
						     {
						    	 savedata=rd1.getDouble("out_qty")-op_qty;
						    	 
						    	 if(savedata<=0)
						    	 {
						    		 savedata=0;
						    	 }
						    	 
						    	 String sql3121="update my_prddout set out_qty="+savedata+" where doc_no='"+outdocno+"'  ";
						    	 
						    	 System.out.println("-----sql3121-----"+sql3121);
					    		 st34.executeUpdate(sql3121);
					    	 
						    	 
						    		
						     }
						     
						   
					    		
					    	}	
				    		
				    		
				    		
				    	}

				    	 
				    	
									 
				    	
						    	 	  
				 
						    	 	  
								}
								 
								 
								 
								 
						/*			 int counts=0;							
								        String tempstk="0";	
								        
								        int stkids=0;
								        
								        String tempstkids="0";
								      
								        int ref_row=0;	
										double prdqty=0;
		
										double saveqty=0;
										int tmptrno=0;
										
										int prdidss=0;
										
										double delnqtys=0;

			 
							  	
							    Statement stmnt=conn.createStatement();		
							    Statement stmnt1=conn.createStatement();
							    Statement stmnt3=conn.createStatement();
							    	String sql2="select ref_row,qty,prdid,tr_no from my_gird where rdocno='"+docno+"'";
							    	System.out.println("-----sql2-----"+sql2);
							    	ResultSet rsstk111 = stmnt1.executeQuery(sql2);
							    	
							    	
							    	while(rsstk111.next())
							    	{
							    		ref_row=rsstk111.getInt("ref_row");
							    		delnqtys=rsstk111.getDouble("qty");
							    		prdidss=rsstk111.getInt("prdid");
							    		tmptrno=rsstk111.getInt("tr_no");
							    	
							  
							    		
							    	String sql3=" select out_qty   from my_gisd where rowno='"+ref_row+"'";
							    	 System.out.println("-----sql3-----"+sql3);
							    	ResultSet rsstk1111 = stmnt.executeQuery(sql3);
							    	
							    	
							    	if(rsstk1111.next())
							    	{
							    		prdqty=rsstk1111.getDouble("out_qty");
								    	saveqty=prdqty-delnqtys;
								    	
								    	if(saveqty<0){
								    	saveqty=0;
								    	
								    	}
								    	
								      	String sql31="update my_gisd set out_qty="+saveqty+" where rowno='"+ref_row+"'";
								    	 System.out.println("-----sql31-----"+sql31);
								    	 stmnt3.executeUpdate(sql31);
								    	 
								    	 
								    	 
							    	} 
							    		
							    	}
							    	
							    	
							    	*/
							    	
							    	
							    	
							    	}

							    	 
							    	
												 
										/*	    String dql31="delete from my_gird where rdocno='"+docno+"'";
									    	 	  stmt.executeUpdate(dql31);
									    		    String dql311="delete from my_jvtran where tr_no='"+mastertr_no+"'";
										    	 	  stmt.executeUpdate(dql311);
									    	 	  */
							 String dql31="delete from my_gird where rdocno='"+docno+"'";
				    	 	  stmt.executeUpdate(dql31);
				    		    String dql311="delete from my_jvtran where tr_no='"+mastertr_no+"'";
					    	 	  stmt.executeUpdate(dql311);
					    	 	  
					    	   	 	 String dql3111="delete from my_prddin where tr_no='"+mastertr_no+"'   and dtype='"+formdetailcode+"' ";
						    	 	  stmt.executeUpdate(dql3111); 
									    	 	  
						}
											
											
							
							
				 
						
						
						
						
					//	System.out.println("=====innnnnnnnnnnnnnnn==out=="+vocno);
						
						
						if(vocno>0)
						{
							//System.out.println("=====innnnnnnnnnnnnnnn===="+vocno);

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"";
												 
							String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							String stkid=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
 
							String cost_prices=""+(prod[8].equalsIgnoreCase("undefined") || prod[8].equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"";
							
							   String unitidss=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							     
						         
							     double fr=1;
							     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
							     
							    // System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
							if(reftype.equalsIgnoreCase("DIR"))
						      {		
								 
								 double cost_pricess=Double.parseDouble(cost_prices);
								 
								 double totalcostpricesaves=cost_pricess*masterqty;
									String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row,fr)VALUES"
											+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
											+ "'"+0+"',"
											+ "'"+0+"',"
											+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+masterqty+"',"
											+ ""+cost_pricess+","
											+ ""+totalcostpricesaves+","
								 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
											+ "'"+txtlocationid+"','"+0+"',"+fr+")";
								int	prodets = stmt.executeUpdate (sql);
								if(prodets<0)
								{
									conn.close();
									return 0;
								}
									
						      }
							 else
							 {
								 
								
								     String rdocno=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[11].isEmpty()?0:prod[11].trim())+"";
											
										  // System.out.println("====detdocno==="+detdocno);
										
										String sqlssss="select  * from my_gisd   where rdocno="+rdocno+" and stockid>0 ";
										
										 ResultSet rsss=stmt.executeQuery(sqlssss);
										 if(rsss.next())
										 {
											 
											 mm=1;
										 }
										 

											String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row,fr)VALUES"
													+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
													+ "'0',"
													+ "'0',"
													+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
													+ "'"+masterqty+"',"
													+ "'0',"
													+ "'0',"
										 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
													+ "'"+txtlocationid+"','"+rdocno+"',"+fr+")";
		
											System.out.println("branchper--1->>>>Sql"+sql);
											prodet = stmt.executeUpdate (sql);
											
											double   out_qty=0;
											
											
											int stockidss=0;
											
											String delsqls1="select out_qty,stockid from  my_gisd   where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+"  ";
											ResultSet rssss=stmt.executeQuery(delsqls1);
											if(rssss.first())
											{
												out_qty=rssss.getDouble("out_qty");
												stockidss=rssss.getInt("stockid");
											}
											//System.out.println("--out_qtys---"+out_qty);
											//System.out.println("--rqty---"+rqty);
											if(stockidss==0)
											{
											out_qty=out_qty+masterqty;
											String delsqls="update my_gisd set out_qty="+out_qty+" where rdocno="+rdocno+" and prdid="+prdid+"  and  unitid="+unitidss+"  ";
											//System.out.println("--1---sqls---"+delsqls);

											stmt.executeUpdate(delsqls);
											}
											  double remqty=0;
												double saveqty=0;
												double delnqty=0;
												double balstkqty=0;
												int psrno=0;
												int stockid=0;
												int refstockid=0;
												double remstkqty=0.0;
												double outstkqty=0.0;
												double stkqty=0.0;
												double inqty=0.0;
												double detqty=0.0;
												double prdinqty=0.0;
												double del_qty=0.0;
												double unitprice=0.0;
												double costprice=0.0,prdout=0;
												
												
												double outsave=0.0;
												
											 
												int docnoss=0;
												Statement stmtstk=conn.createStatement();

												Statement stmtstk1=conn.createStatement();
												
												
												//System.out.println("=masterqty=== ="+masterqty);

											//	System.out.println("=fr=== ="+fr);
												double masterqty1=masterqty*fr;
												//System.out.println("=masterqty1=== ="+masterqty1);
												
												String stkSql=" select o.qty-coalesce(o.out_qty,0) qty ,o.stockid,o.doc_no    from my_prddout o  "
														+ " 	where   o.rdocno in("+rdocno+")    and  "
																+ " o.psrno='"+prdid+"' and o.specid='"+specno+"'   and  o.qty>coalesce(o.out_qty,0)     group by o.doc_no ";
											
										 
											
												

												//System.out.println("=stkSql=inside==================== insert="+stkSql);

												ResultSet rsstk = stmtstk.executeQuery(stkSql);

												while(rsstk.next()) {
													 
													docnoss=rsstk.getInt("doc_no");
												 
													stockid=rsstk.getInt("stockid");
													del_qty=rsstk.getDouble("qty");
													 
													
												/*	 if(docnoset.equalsIgnoreCase("0"))
													 {
														 docnoset="0,";
													 }
													 else
													 {
														 docnoset=docnoss+","; 
													 }*/
														
													
														
													/* 	 if(docnoset.endsWith(","))
															{
												    		 docnoset = docnoset.substring(0,docnoset.length() - 1);
															}*/
													 	 
													 	 
													 	// System.out.println("==========docnoset========"+docnoset);
													 	 
													 	 
														
													 String stkSql11="select i.unit_price,i.cost_price from  my_prddin i where  i.stockid="+stockid+" " ;
													 
													 ResultSet rsstk1 = stmtstk1.executeQuery(stkSql11);

														if(rsstk1.next()) {
															unitprice=rsstk1.getDouble("unit_price");
															costprice=rsstk1.getDouble("cost_price");
															
														}
													 
														 String stkSql111="select out_qty from  my_prddout  where  doc_no="+docnoss+" " ;
														 
														 ResultSet rsstk11 = stmtstk1.executeQuery(stkSql111);

															if(rsstk11.next()) {
																prdout=rsstk11.getDouble("out_qty");
																 
																
															}
														 
														
														
														
													 
														if(remqty>0)
														{

															masterqty1=remqty;
														}

														
														//System.out.println("=masterqty1======== ="+masterqty1);
														//System.out.println("=del_qty======== ="+del_qty);
														

														if(masterqty1<=del_qty)
														{
															 


															String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
																	+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"
																	+ "'"+stockid+"',"
																	+ ""+unitprice+","
																	+ ""+costprice+","
																	+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
																	+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																	+ "'"+masterqty1+"',"
																	+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																	+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+txtlocationid+"','"+masterdate+"',"+unitidss+","+fr+","+docnoss+")";

													 	System.out.println("prodinsql-1-->>>>Sql"+prodinsql);
															prodout = stmt.executeUpdate (prodinsql);
															
															
														 
													
															 
															outsave=prdout+masterqty1;
															
															String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
														//	System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
															prodout = stmt.executeUpdate (prodinsql1);

															if(mm==1)
															{
															
															String prodinsql11="update   my_gisd set out_qty=out_qty+"+masterqty1+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
														//	System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
															prodout = stmt.executeUpdate (prodinsql11);
															
															}
														

															masterqty1=0;
														 //	docnoset=docnoset+docnoss+",";
															break;


														}
														else if(masterqty1>del_qty)
														{



															 
																remqty=masterqty1-del_qty;
															 
																
																
																String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
																		+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"
																		+ "'"+stockid+"',"
																		+ ""+unitprice+","
																		+ ""+costprice+","
																		+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
																		+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																		+ "'"+del_qty+"',"
																		+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																		+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+txtlocationid+"','"+masterdate+"',"+unitidss+","+fr+","+docnoss+")";

																System.out.println("prodinsql--2->>>>Sql"+prodinsql);
																prodout = stmt.executeUpdate (prodinsql);
																
																
															 
																outsave=prdout+del_qty;
																
																String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
															//	System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
																prodout = stmt.executeUpdate (prodinsql1);

																 
																if(mm==1)
																{
																String prodinsql11="update   my_gisd set out_qty=out_qty+"+del_qty+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
															//	System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
																prodout = stmt.executeUpdate (prodinsql11);
																}
																
															}
														
														
														
													 
														 
													 //	 System.out.println("==========docnoss========"+docnoss);
													 	 
														 

											
													 	if(masterqty1==0)
														{
															
															break;
														}
												    	 }
												    	  
								 
						/*			int oldStockid=0;
									Statement stmtstk1=conn.createStatement();
									String stkid1="select refstockid from my_prddin where stockid='"+stkid+"'  ";
									ResultSet rsstk1 = stmtstk1.executeQuery(stkid1);
									
									if(rsstk1.next())
									{
										
										oldStockid=rsstk1.getInt("refstockid");
									}

							double masterqty1=0;

							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							int refstockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double unitprice=0.0;
							double costprice=0.0;
							double tmp_qty=0.0;
							double outqtys=0.0;
							double prdinqty=0.0;
							double totalcostpricesave=0;
							
							
							double NtWtKG=0.0;
							double KGPrice=0.0;
							double total=0.0;
							double discper=0.0;
							double discount=0.0;
							double netotal=0.0;
							
							masterqty1=masterqty;
					
							Statement stmtstk=conn.createStatement();


							String stkSql="select d.rdocno,d.rowno doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_gism m "
									+ " left join  my_gisd d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+refdocno+") and d.stockid="+oldStockid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+txtlocationid+"' "
									+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date,i.stockid";
							
 
							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {


								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								prdinqty=rsstk.getDouble("qty");
								unitprice=rsstk.getDouble("unit_price");
								costprice=rsstk.getDouble("cost_price");
							 
								
								
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);

								String queryappnd="";

						

						 

					 
								String prodinsql="update my_prddin set date='"+masterdate+"',op_qty="+masterqty+" where stockid="+stkid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"' and "
										+ "prdid='"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"' and "
												+ "brhid='"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"' and locid='"+txtlocationid+"'";
					 


								System.out.println("prodinsql--->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);
									if(masterqty<=balstkqty)
									{
										break;
									}	
									
									


							}
				 


							if(reftype.equalsIgnoreCase("GIS"))
							{

								double balqty=0;
								int docnos=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;
								int invstk=0;
								double secqty=0;
								Statement stmt122=conn.createStatement();

								String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no ,d.rdocno,d.out_qty out_qty,d.prdid  from my_gism m  left join "
										+ "my_gisd d on m.doc_no=d.rdocno where d.rdocno in ("+refdocno+") and d.stockid="+oldStockid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+txtlocationid+"'"
												+ " and d.prdid='"+prdid+"' group by d.rowno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.rowno";

								System.out.println("---strSql--1---"+strSql);
								ResultSet rs = stmt122.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docnos=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");
									invstk=rs.getInt("stockid");

									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{

							              totalcostpricesave=costprice*masterqty1;
							              
							              
							      		String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,ref_row)VALUES"
												+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
												+ "'"+stkid+"',"
												+ "'"+oldStockid+"',"
												+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+masterqty1+"',"
												+ ""+costprice+","
												+ ""+totalcostpricesave+","
									 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
												+ "'"+txtlocationid+"','"+docnos+"')";
							              
										String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,ref_row)VALUES"
												+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
												+ "'"+stkid+"',"
												+ "'"+oldStockid+"',"
												+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+masterqty1+"',"
												+ "'"+NtWtKG+"',"
												+ "'"+KGPrice+"',"
												+ "'"+unitprice+"',"
												+ "'"+total+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+discount+"',"
												+ "'"+netotal+"','"+docno+"')";

										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										
										
										masterqty1=masterqty1+out_qty;


										String sqls="update my_gisd set out_qty="+masterqty1+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{
										secqty=balqty;


										if(qtys>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_gisd set out_qty="+balqty+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										

							        
										
							              
										   totalcostpricesave=costprice*secqty;
											String sql="insert into my_gird(TR_NO, SR_NO,rdocno,stockid,refstockid,SpecNo, psrno, prdId, qty,cost_price,totalcost_price,UNITID,locid,ref_row)VALUES"
													+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
													+ "'"+stkid+"',"
													+ "'"+oldStockid+"',"
													+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
													+ "'"+secqty+"',"
													+ ""+costprice+","
													+ ""+totalcostpricesave+","
										 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
													+ "'"+txtlocationid+"','"+docnos+"' ";
	 

										System.out.println("branchper--2->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										//remqty=masterqty-qtys;



									}

								}  

							}

							 */
							 
							 
							 }
						}

					}

				}
	 
				
				String vendorcur="1"; 
				double venrate=1;
				
		 int accounts=0;
		 double  finalamt=0;
			String refdetails="GIR"+""+vocno;
			
			int trno=mastertr_no;
			String s="select sum(costval) totalcost_price,tr_no from  (select op_qty*cost_price costval ,tr_no from my_prddin where  tr_no="+trno+" and dtype='GIR'  ) a group by a.tr_no ";
			
			System.out.println("-----4--s----"+s) ;
	 

				ResultSet tass30 = stmt.executeQuery (s);

				if (tass30.next()) {

					finalamt=tass30.getDouble("totalcost_price");		
					 
				}
			 
		 
		 
					
				String sql29="select acno from my_issuetype where doc_no='"+type+"' ";
			System.out.println("-----4--sql2----"+sql29) ;

				ResultSet tass19 = stmt.executeQuery (sql29);

				if (tass19.next()) {

					accounts=tass19.getInt("acno");		

				}
			 
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=finalamt*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="";
			/*	if(itemtype==1 || itemtype==6)
				{*/

					  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,6,0,0,0,'"+venrate+"','GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";
	         	
			/*	}
				else
				{
					  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,6,0,0,0,'"+venrate+"',0,0,'GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
	         	
				}*/
					
				
				
				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=finalamt;
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="";
			/*	if(itemtype==1 || itemtype==6)
				{*/

				  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,6,0,0,0,'"+rates+"','GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";

		/*		}
				else
				{

					  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,6,0,0,0,'"+rates+"',0,0,'GIR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
		
				}*/
				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}
				
				
				
				if(itemtype>0)
				{

					 int TRANIDs=0;
					 int sno=1;
					  
				            Statement sss=conn.createStatement();
						String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+mastertr_no+" and acno="+accounts+" ";
				
						ResultSet tass111 = sss.executeQuery (trsqlss);
						
						if (tass111.next()) {
					
							TRANIDs=tass111.getInt("TRANID");	
						
						
							
					     }
						String sqlssss="delete from my_costtran where tr_no='"+mastertr_no+"'";
						System.out.println("---sqlssss--"+sqlssss);
						 stmtgir.executeUpdate(sqlssss);
						String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
								+ " "+itemtype+","+finalamt*-1+","+itemdocno+","+TRANIDs+","+mastertr_no+")";
								 
				  int costabsq=  stmtgir.executeUpdate(ssql);
				  
				  if(costabsq<=0)
					{
						conn.close();
						return 0;
						
					}
				}
		}
				
				if(docno>0)
				{
				  conn.commit();
					stmtgir.close();
					conn.close();
					return docno;
					
				}
		 
				
		
	}
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	
	return 0;
}



public   JSONArray searchProduct(HttpSession session,String locid,String refmasterdoc_no,String reftype,
		String prdname,String brandname,String id,String gridunit,String gridprdname,String category, String subcategory) throws SQLException {

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
			
			String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
			ResultSet rs=stmtVeh.executeQuery(chk); 
			if(rs.next())
			{
				
				method=rs.getInt("method");
			}
	String condtn="";
			
			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn +="  and m.part_no like '%"+prdname+"%' ";
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
			
			
			if(reftype.equalsIgnoreCase("DIR"))
			{
			
			
			String	sql="select   bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
					+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qutval,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
					+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty))*i.cost_price savecost_price,i.cost_price from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
					+ "  left join my_catm c on c.doc_no=m.catid "
					   + "left join my_scatm sc on m.scatid=sc.doc_no  inner join my_prddin i "
					+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno  and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )   "
					+ "where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+locid+"' "+condtn+" "
					+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
			
		//	System.out.println("---sql----"+sql);
			ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			}
			else
			{
				 
				String 	sql=" select  d.rowno detdocno, d.rdocno,bd.brandname,d.stockid,d.specno as specid,d.psrno as doc_no,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
							+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(qty-out_qty) qutval,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
						    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
						    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
							+ " (sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis, "
							+ " ((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
							+ "  from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)   left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no where m.status=3 and d.rdocno in("+refmasterdoc_no+")  "+condtn+" and   ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locid+"' group by d.rdocno,d.prdid,d.unitid,d.specno "
							+ "  having sum(d.qty-d.out_qty)>0    order by d.rdocno,d.prdid ";
				System.out.println("---sql-- 222222222222222222222--"+sql);
				ResultSet resultSet = stmtVeh.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
 


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


public     ClsGoodsissuenotereturnBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsGoodsissuenotereturnBean bean = new ClsGoodsissuenotereturnBean();
	  Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			 Statement stmt10 = conn.createStatement ();
			
			   String  girsql=" select concat(costgroup,'-',costdocno) projname,contactperson,cont_no,refname ,doc_no,loc_name ,DATE_FORMAT(date,'%d/%m/%Y') as date from( "
			   		+ "select  iss.costgroup,a.contactperson,a.per_mob cont_no,m.description,m.refno,m.doc_no,m.voc_no,m.date, "
			   		+ "m.issuetype,m.locid,l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			   		+ " case when m.costtype=6 then m.costdocno "
			   		+ "when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no  when m.costtype in(5) then cs.doc_no  end as "
			   		+ "'costdocno' ,  case when m.costtype=6 then mm.flname   when m.costtype=1 then c.description when m.costtype in(3,4) "
			   		+ "then convert(concat(co.ref_type,' ',co.refdocno),char(100))   when m.costtype in (5) then "
			   		+ "convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname'  from my_girm m left join my_locm l "
			   		+ "on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1  left join cm_srvcontrm co on "
			   		+ "co.tr_no=m.costdocno and m.costtype in(3,4)  left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5  left join "
			   		+ "gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6  left join  my_gism rq on rq.doc_no=m.rrefno  left join "
			   		+ "cm_srvcsited s on s.rowno=m.siteid and m.costtype in (3,4,5)  left join "
			   		+ "my_acbook a on a.cldocno=m.cldocno and m.costtype in (3,4,5) and a.dtype='CRM' "
			   		+ "left join my_costunit iss on iss.costtype=m.costtype  where m.status=3 and  m.doc_no='"+docno+"') a   ;"; 
			   System.out.println("girsql"+girsql);

		         ResultSet resultsetprint = stmt10.executeQuery(girsql); 
			       
			       while(resultsetprint.next()){
			    	   bean.setClient_name(resultsetprint.getString("refname"));
			    	   bean.setProject_name(resultsetprint.getString("projname"));
			    	   bean.setContactperson(resultsetprint.getString("contactperson"));
			    	   bean.setContact_no(resultsetprint.getString("cont_no"));

			    	   bean.setLocname(resultsetprint.getString("loc_name"));
			    	   bean.setPdate(resultsetprint.getString("date"));
			       } 
			       
			       
			       
			       
			       conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}



}
