package com.procurement.purchase.purchaseinvoice;

import java.sql.CallableStatement;


import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;











import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsVatInsert;
import com.connection.ClsConnection;

 
public class ClspurchaseinvoiceDAO 


{
	
	
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
			String rrefno, double prddiscount, ArrayList<String> exparray,  
			double exptotal, Date invdate, String invno, int locationid, double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype,int itermtype,int costtrno,double descgridhid,double descgridtax) throws SQLException  {
	/*System.out.println("in...dao");
	System.out.println("producttotal====="+productTotal);
	System.out.println("descpercentage======"+descPercentage);
	System.out.println("descountval======="+descountVal);
	System.out.println("roundof======="+roundOf);
	System.out.println("nettotaldown======="+netTotaldown);F
	System.out.println("servnettotal======="+servnettotal);
	System.out.println("ordervalue======="+orderValue);*/
	System.out.println("reftype======="+reftype);
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpuchase= conn.prepareCall("{call tr_PurchaseinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchase.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtpuchase.registerOutParameter(24, java.sql.Types.INTEGER);
 
			stmtpuchase.setDate(1,masterdate);
			stmtpuchase.setDate(2,deldate);
			stmtpuchase.setString(3,refno);
			stmtpuchase.setInt(4,vendocno);
		   	stmtpuchase.setInt(5,cmbcurr);
			stmtpuchase.setDouble(6,currate);
			stmtpuchase.setString(7,delterms); 
			stmtpuchase.setString(8,payterms);
			stmtpuchase.setString(9,purdesc);
			stmtpuchase.setDouble(10,productTotal);
			stmtpuchase.setDouble(11,descPercentage);
			stmtpuchase.setDouble(12,descountVal);
			stmtpuchase.setDouble(13,roundOf);
			stmtpuchase.setDouble(14,netTotaldown); 
			stmtpuchase.setDouble(15,descgridhid);
			stmtpuchase.setDouble(16,orderValue);
			stmtpuchase.setString(17,session.getAttribute("USERID").toString());
			stmtpuchase.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(19,session.getAttribute("COMPANYID").toString());
			
			
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(21,formdetailcode);
			stmtpuchase.setString(22,mode);
			stmtpuchase.setInt(23,chkdiscount);
			stmtpuchase.setString(25,reftype);
			stmtpuchase.setString(26,rrefno);
			stmtpuchase.setDouble(27,prddiscount);
			
			stmtpuchase.setDouble(28,exptotal);
			
			stmtpuchase.setDate(29,invdate);
			
			stmtpuchase.setString(30,invno);
			stmtpuchase.setInt(31,locationid);
			 
			
			int val=stmtpuchase.executeUpdate();
			System.out.println("dmlval====="+val);
			docno=stmtpuchase.getInt("docNo");
			System.out.println("docNo====="+docno);
			int vocno=stmtpuchase.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_srvm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}


			
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
				String upcostsql="update my_srvm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			
			
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
				String sqlssss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+vendocno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlssss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					taxmethod=0;
				}
				
			 
			 int stacno=0;
			 int stacno1=0;
			 int tax1acno=0;
			 int tax2acno=0;
			 int tax3acno=0;
			 
				int multimethod=0;
				 Statement stmtqty=conn.createStatement();
				 String chkw="select method  from gl_prdconfig where field_nme='multiqty'";
				 // System.out.println("======chkw========="+chkw);
				 ResultSet rsszs=stmtqty.executeQuery(chkw); 
				 double updtax=0;
				updtax=stval+descgridtax;
				 if(rsszs.next())
				 {
					 
					  
					 multimethod=rsszs.getInt("method");
					 
				 }
			  if(taxmethod>0)
			  {
				  
				  netTotaldown=netTotaldown-stval;
				  
				  String sqltax1= " update my_srvm set totaltax='"+updtax+"',tax1='0',tax2='0',tax3='0',"
				  		+ "nettotaltax='"+updtax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
				  
				//  System.out.println("======sqltax1========="+sqltax1);
				  
				  stmt1.executeUpdate(sqltax1);
			
			  int prvdocno=0;
				 
				  Statement pv=conn.createStatement();
					
					String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
					
				//	System.out.println("=======dd========"+dd);
					
					
					ResultSet rs13=pv.executeQuery(dd); 
					if(rs13.next())
					{

						prvdocno=rs13.getInt("prvdocno");
					}
				//	System.out.println("======prvdocno========"+prvdocno);

					 
				 
				  
				  	Statement ssss10=conn.createStatement();
			  
	/*				 String sql10="  select acno,value from gl_taxmaster where doc_no=(select max(doc_no) tdocno from gl_taxmaster where  "
					 		+ "  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'  )  "
					 				+ "  and status=3 and type=1 and provid='"+prvdocno+"'  " ;
					 */
					 
					 String sql10="  select acno,value from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'   "
						 				+ "  and status=3 and type=1 and provid='"+prvdocno+"' and  if(1="+cmbbilltype+",per,cstper)>0  " ;
					 
					 
					 
					// System.out.println("====sql10========"+sql10);
					 
					 
					 int mm=0;
				
					 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
					 while(rstaxxx101.next())
					 {
						 if(mm==0)
						 {
						 stacno=rstaxxx101.getInt("acno");
						 }

						 if(mm==1)
						 {
							 stacno1=rstaxxx101.getInt("acno");
						 } 
						 mm=mm+1;
												 	
					 	
					 }

				  
				  	Statement ssss=conn.createStatement();
			  
					 String sql100=" select s.acno,s.value "
							 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
							 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
							 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
				//System.out.println("=====sql======"+sql100);
					 ResultSet rstaxxx=ssss.executeQuery(sql100); 
					 if(rstaxxx.next())
					 {
						 String typeoftax="0";
						 tax1acno=rstaxxx.getInt("acno");
						 typeoftax=rstaxxx.getString("value");
						 
						 String sqltax11= " update my_srvm set typeoftax='"+typeoftax+"'    where doc_no='"+docno+"' ";
							  
						// System.out.println("======sqltax11========="+sqltax11);
							  
						 stmt1.executeUpdate(sqltax11);						 	
					 	
					 }

					  	Statement ssss1=conn.createStatement();
				  
						 String sql166=" select s.acno"
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  " ;
					
						 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
						 if(rstaxxx1.next())
						 {
							 
							 tax2acno=rstaxxx1.getInt("acno");
													 	
						 	
						 }
			  
							Statement ssss3=conn.createStatement();
							  
							 String sql311=" select s.acno "
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
							 if(rstaxxx3.next())
							 {
								 
								 tax3acno=rstaxxx3.getInt("acno");
														 	
							 	
							 }
				  
			  
			  
			  }
			 
			  
			  
				int bachmethod=0;
				 Statement stmtw=conn.createStatement();
				 String batchs="select method  from gl_prdconfig where field_nme='batch_no'";
				 ResultSet rz=stmtw.executeQuery(batchs); 
				 if(rz.next())
				 {
				 	
					 bachmethod=rz.getInt("method");
				 }

					int expmethod=0;
					 Statement stmtd=conn.createStatement();
					 String expdatesql="select method  from gl_prdconfig where field_nme='exp_date'";
					 ResultSet exprs=stmtd.executeQuery(expdatesql); 
					 if(exprs.next())
					 {
					 	
						 expmethod=exprs.getInt("method");
					 }

						netTotaldown=netTotaldown-roundOf;
		
			
			String rownochk="0"; 
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     System.out.println("chkqty====="+chkqty);
				     double expenxetotal=0;
				     double resultexptotal=0;
				     double totalpriceallqty=0;
				     
				     double costprice=0;
				     
				     if(chkqty>0){
			    	
				    	// netTotaldown servnettotal exptotal
				    	 
				    	 //chkqty,
				    	 String psrnos=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
				    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
							 
				         double fr=1;
					     String slss=" select fr from my_unit where psrno="+psrnos+" and unit='"+unitids+"' ";
					     
					    // System.out.println("====slss==="+slss);
					     ResultSet rv1=stmtpuchase.executeQuery(slss);
					     if(rv1.next())
					     {
					    	 fr=rv1.getDouble("fr"); 
					     }
			    	 
				    	 
				    	 
				    	 String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				    	 
				    	 double gridnettotal=Double.parseDouble(gridnettotals);
				    	 gridnettotal=ClsCommon.Round(gridnettotal, 2);
				    	System.out.println("--gridnettotal---"+gridnettotal);
				    	 expenxetotal=servnettotal+exptotal;
				    	 expenxetotal=ClsCommon.Round(expenxetotal, 2);
				    	 if(expenxetotal>0)
				    	 {
						 System.out.println("--expenxetotal---"+expenxetotal);
						 System.out.println("--netTotaldown---"+netTotaldown);
				    	 resultexptotal=(expenxetotal/netTotaldown)*gridnettotal;
				    	 resultexptotal=ClsCommon.Round(resultexptotal, 2);
				    	 System.out.println("--resultexptotal---"+resultexptotal);
				    	 totalpriceallqty=gridnettotal+resultexptotal;
				    	 totalpriceallqty=ClsCommon.Round(totalpriceallqty, 2);
				         System.out.println("--totalpriceallqty---"+totalpriceallqty);
				    	 costprice=totalpriceallqty/chkqty;  
				    	 /*costprice=ClsCommon.Round(costprice, 2);*/
				       System.out.println("--costprice-87654--"+costprice);  
				    	 }
				    	 else
				    	 {
				    		 
				    		 costprice=gridnettotal/chkqty;
					    	 /*costprice=ClsCommon.Round(costprice, 2);*/
					   System.out.println("--costprice-else--"+costprice);  
				    		 
				    	 }
				    	 
				    	 
				    	 
				    	   if(reftype.equalsIgnoreCase("GRN")||reftype.equalsIgnoreCase("PO"))
					         {	 
				    	
				    		   
				    		 if(reftype.equalsIgnoreCase("GRN"))
				    		 {
				  
/*				    			 
				   			  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
									   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
									   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc
									   +" :: "+rows[i].orderdiscper+" :: "+rows[i].orderamount+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"); 
				    			                                                                         17                    18                   19
				    		   */
				    		   
			    	 
						             String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
								       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
								       +"'"+mastertr_no+"','"+docno+"',"
								       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
								       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("") || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
								       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")  || detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
								       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")  || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+" )";
//				                    System.out.println("-----insql-"+insql);
								     int resultSet2 = stmtpuchase.executeUpdate(insql);
//								     System.out.println("-----srvd0-"+resultSet2);
								     if(resultSet2<=0)
										{
											conn.close();
											return 0;
											
										}
								     
								     
								     
								     
								 }
				    		 
				    		 else if(reftype.equalsIgnoreCase("PO"))
				    		 {
							    			 
							  			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
							 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
											    	 
											    	 
												     double paidqty=Double.parseDouble(paidqtyd);
												     
												     double focqty=Double.parseDouble(foc);
												 
												 
												     double opqty=paidqty+focqty; 
												 
												     
												     focqty=0;
												     
												     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date,fr,unitid)values"
												    		 + "("+(i+1)+","
												             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
														     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
														     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
												               + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
														     +"'"+opqty*fr+"','"+focqty*fr+"',"
												             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice/fr+",'"+docno+"',1,'"+masterdate+"',"+fr+","+unitids+")";
 
												     
												    // System.out.println("--sql2-----"+sql2);
												     int resultSet10 = stmtpuchase.executeUpdate(sql2);
//												     System.out.println("-----prddin-"+resultSet10);
												     if(resultSet10<=0)
														{
															conn.close();
															return 0;
															
														}
										     	
										     int stockid=0;	
										    
									         Statement selstmt=conn.createStatement();
									     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
									     
									  
									     
									     ResultSet selrss=selstmt.executeQuery(sqlssel);
									     
									     if(selrss.next())
									     {
									    	 stockid=selrss.getInt("stockid") ;
									    	 
									    	 
									    	 
									 	 
									     }
									      
						     
								     
								     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
										       + "'"+stockid+"',"
										       +"'"+mastertr_no+"','"+docno+"',"
										       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  ||  detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
										       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")  ||  detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
										       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("") ||  detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ,"
										       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")  || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+")";         
								     
								     
								     //   System.out.println("-----insql-"+insql);
										     int resultSet2 = stmtpuchase.executeUpdate(insql);
//										     System.out.println("-----rvd-"+resultSet2);
										     if(resultSet2<=0)
												{
													conn.close();
													return 0;
													
												}
				    			 
				     } // noushad
				     
				    // rrefno
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     
				 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
			    	  
			    	   
				     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
				    
					 
				    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
				    	 

					     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					     
					     
					     String amounts=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
				     
				  
						  if(reftype.equalsIgnoreCase("GRN"))
						  {		   

					    
				    		 
					 	   double balqty=0;
							 
				             int tr_no=0;
							double remqty=0;
							double out_qty=0;
								double qty=0;
								
								double grnout=0;
								
								
								double grnsaveqty=0; 
								double prddinsaveqty=0;
								
								
	
								
				    	 Statement stmt=conn.createStatement();
				    	 
		/*		    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
									+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
											+ "group by dd.stockid,dd.psrno,dd.prdid having sum(d.qty-d.out_qty)>0 order by dd.date";
	 */
				    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty)/dd.fr qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/dd.fr balstkqty,sum(dd.out_qty)/dd.fr out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
									+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"'  and dd.unitid="+unitids+" and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
											+ "group by dd.stockid,dd.psrno,dd.prdid having sum(d.qty-d.out_qty)>0 order by dd.date";
//				         System.out.println("---1111111111strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balstkqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								//stockid=rs.getInt("stockid");
								qty=rs.getDouble("qty");
								grnout=rs.getDouble("grnout");
						//	System.out.println("---masterqty-----"+masterqty);	
							
						//	System.out.println("---grnout-----"+grnout);	
						//	System.out.println("---out_qty-----"+out_qty);	

								//System.out.println("---masterqty-----"+masterqty);	

							//	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							//	System.out.println("---qty-----"+qty);

				 

						 
								grnsaveqty=masterqty+grnout;
								
								String sqls="update my_grnd set out_qty="+grnsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
								

							//	System.out.println("--1---sqls---"+sqls);


								stmtpuchase.executeUpdate(sqls);
								
								
                              //	String prdinsqls="update my_prddin set cost_price="+costprice+",invno='"+docno+"',pstatus=1,unit_price='"+amounts+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
								
                              	String prdinsqls="update my_prddin set cost_price="+costprice+",invno='"+docno+"',pstatus=1,unit_price='"+Double.parseDouble(amounts)+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
								System.out.println("prddin update===================="+prdinsqls);
	

							//	System.out.println("--1---prdinsqls---"+prdinsqls);


								stmtpuchase.executeUpdate(prdinsqls); 
								
								
							/*	prddinsaveqty=masterqty+out_qty;
								
                              	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
								

								System.out.println("--1---prdinsqls---"+prdinsqls);

cost_price
								stmtpuchase.executeUpdate(prdinsqls);*/
								
								
				/*					
								String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+prddoutqty+"','"+docno+"','"+prdid+"')";
								
								stmtpuchase.executeUpdate(insertsql);
								
								System.out.println("--1---insertsql---"+insertsql);*/
								
								
								break;


							}

							


				    		
				 
			  }

			   else  if(reftype.equalsIgnoreCase("PO"))
	         {
		    	 
	 
			 /*    String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
			     
			     */
			     
			  //   double masterqty=Double.parseDouble(rqty); 
		   		 
				   
					String amount=""+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"";
					  
					   
					   
					String discper=""+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"";
					   
				   
				   
		    	   double balqty=0;
					int rowno=0;
		             int tr_no=0;
					double remqty=0;
					double out_qty=0;
						double qty=0;
						int unitid=0;
						int spec=0;
		    	 Statement stmt=conn.createStatement();
		
		    	 
	/*	    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where   d.clstatus=0 and\r\n" + 
		    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+" and d.rowno not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.rowno having "
		    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";*/
		    	 
		    	 
		    	 String strSql="select d.qty ,d.foc,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno,sum((d.foc-d.foc_out)) balfoc,d.foc_out   from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where   d.clstatus=0 and\r\n" + 
			    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"'  and d.unitid="+unitids+" and d.specno="+specno+" and m.brhid="+session.getAttribute("BRANCHID")+" and d.rowno not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.rowno having "
			    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
		    	 
                   //   System.out.println("-----strSql---"+strSql);
		    	 
		 
		    		ResultSet rs = stmt.executeQuery(strSql);
		     
		    
		    		while(rs.next()) {
		    			 
		    			
						balqty=rs.getDouble("balqty");
						tr_no=rs.getInt("tr_no");
						out_qty=rs.getDouble("out_qty");

						rowno=rs.getInt("rowno");
						qty=rs.getDouble("qty");
						unitid=rs.getInt("unitid");
						spec=rs.getInt("specno");

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

							
							String sqls="update my_ordd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and    rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+spec+"  ";
							

						// System.out.println("--1---sqls---"+sqls);


							stmtpuchase.executeUpdate(sqls);
							  break ;


						}
						else if(masterqty>balqty)
						{



							if(qty>=(masterqty+out_qty))

							{
								balqty=masterqty+out_qty;	
								remqty=qty-out_qty;

								 //	System.out.println("---remqty-1---"+remqty);
							}
							else
							{
								
								
								remqty=masterqty-balqty;
								balqty=qty;
								
							//	System.out.println("---masterqty--"+masterqty);
								
								//System.out.println("---balqty--"+balqty);
								
								
								//System.out.println("---remqty--2--"+remqty);
							}


							String sqls="update my_ordd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+spec+" ";	
							//System.out.println("-2----sqls---"+sqls);

							stmtpuchase.executeUpdate(sqls);	

						 



						} //else if

		    		 
		    			
		    	  		}  // while
		    	 
		     		     
		     
		    	   }
				     
				     
				    	 }
				     
 			     else if(reftype.equalsIgnoreCase("DIR"))
				     {
				    	 

	 
 			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
				    	 
				    	 
					     double paidqty=Double.parseDouble(paidqtyd);
					     
					     double focqty=Double.parseDouble(foc);
					 
					 
					     double opqty=paidqty+focqty; 
					     
					     
					     if(multimethod>0)
				    	 {
					    	 
					    	 opqty=chkqty; 
					    	 
					    	 
					    	 
				    	 }
					     /*                          0                1                       2                       3
						  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
								  
								  
								              4                        5                       6                      7                    8
								   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
								                     9                       10                     11                   12                       13                 14
								   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc)*/

					     focqty=0;
					     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date,fr,unitid)values"
					    		 + "("+(i+1)+","
					             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
							     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
					               + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
							     +"'"+opqty*fr+"','"+focqty*fr+"',"
					             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice/fr+",'"+docno+"',1,'"+masterdate+"',"+fr+","+unitids+")";
					     
					    // System.out.println("--sql2-----"+sql2);
					     int resultSet10 = stmtpuchase.executeUpdate(sql2);
					     System.out.println("--prddin-----"+resultSet10);
					     if(resultSet10<=0)
							{
								
					    	   conn.close();
								return 0;
								
							}
					     	
					     int stockid=0;	
					    
				         Statement selstmt=conn.createStatement();
				     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
				     
				  
				     
				     ResultSet selrss=selstmt.executeQuery(sqlssel);
				     
				     if(selrss.next())
				     {
				    	 stockid=selrss.getInt("stockid") ;
				    	 
				    	 
				    	 
				 	 
				     }
				      	 
				    	 
				     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
						       + "'"+stockid+"',"
						       +"'"+mastertr_no+"','"+docno+"',"
							   + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  ||  detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
							   + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("") ||  detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
							   + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")  ||  detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ," 
							   + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")  || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+")";         
							    
							        System.out.println("-----insql-"+insql);
						     int resultSet2 = stmtpuchase.executeUpdate(insql);
						     System.out.println("-----srvd-"+resultSet2);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
									
								}
						  	 
				    	 
			
				    	 
				    	 
				    	 
				     }
				      
				     
					
	 
				     
				 
			     }	   
				     
				     if(bachmethod>0 || expmethod>0)
				     {
				     
				     	int   updatestockid=0;
				       Statement selstmt1=conn.createStatement();
					     String sqlssel1="select stockid from  my_srvd where rdocno='"+docno+"' group by stockid";
					     
					  
					     
					     ResultSet selrss1=selstmt1.executeQuery(sqlssel1);
					     
					     while(selrss1.next()) 
					     {
					    	 updatestockid=selrss1.getInt("stockid") ;
					    	 if(bachmethod>0)
					    	 {
					    		 String ssqlss="update my_prddin set  batch_no='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" ";
					    		 stmtpuchase.executeUpdate(ssqlss);
					    		 
					    		 String ssqlss2="update my_srvd set  BATCHNO='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
					    		 stmtpuchase.executeUpdate(ssqlss2);
					    	 }
					    	 
					    	 if(expmethod>0) 
					    	 { 
					    		
					    		 String ssqlss1="update my_prddin set  exp_date='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" ";
					    		 stmtpuchase.executeUpdate(ssqlss1); 
					    		 
					    		 String ssqlss3="update my_srvd set  bExpiry='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
					    		 stmtpuchase.executeUpdate(ssqlss3);
					    		 
					    		 
					    	 }
					    	 
					    	 
					 	 
					     } 
				     
				     }
				    
				     
				     
				     
				     
				     
				     
				     
				     
				     
				     
			 }
			     
			     
			     
			     
			     
		 
			     
			     
			     
				     
				     }
			
 
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
		     String sql1="INSERT INTO my_srvser(srno,qty,desc1,unitprice,total,discount,nettotal,srvtaxper,srvtaxamount,brhid,rdocno,tr_no)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
				       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"','"+mastertr_no+"')";
			//  System.out.println("===sql1==="+sql1);
				     int resultSet2 = stmtpuchase.executeUpdate(sql1);
				     System.out.println("===srvser==="+resultSet2);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			

/*			                            0                1                    2   
			   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].descsrno+" :: "
			                       3                     4                      5                      6                       7                     
					   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].accountdono+" :: ");*/

			for(int i=0;i< exparray.size();i++){
		    	
			     String[] singleexparray=exparray.get(i).split("::");
			     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO my_srvexp(srno,qty,descdocno,unitprice,total,discount,nettotal,acno,brhid,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(singleexparray[1].trim().equalsIgnoreCase("undefined") || singleexparray[1].trim().equalsIgnoreCase("NaN")|| singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()?0:singleexparray[1].trim())+"',"
				       + "'"+(singleexparray[2].trim().equalsIgnoreCase("undefined") || singleexparray[2].trim().equalsIgnoreCase("NaN")|| singleexparray[2].trim().equalsIgnoreCase("")|| singleexparray[2].isEmpty()?0:singleexparray[2].trim())+"',"
				       + "'"+(singleexparray[3].trim().equalsIgnoreCase("undefined") || singleexparray[3].trim().equalsIgnoreCase("NaN")||singleexparray[3].trim().equalsIgnoreCase("")|| singleexparray[3].isEmpty()?0:singleexparray[3].trim())+"',"
				       + "'"+(singleexparray[4].trim().equalsIgnoreCase("undefined") || singleexparray[4].trim().equalsIgnoreCase("NaN")||singleexparray[4].trim().equalsIgnoreCase("")|| singleexparray[4].isEmpty()?0:singleexparray[4].trim())+"',"
				       + "'"+(singleexparray[5].trim().equalsIgnoreCase("undefined") || singleexparray[5].trim().equalsIgnoreCase("NaN")||singleexparray[5].trim().equalsIgnoreCase("")|| singleexparray[5].isEmpty()?0:singleexparray[5].trim())+"',"
				       + "'"+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"',"
				       + "'"+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+mastertr_no+"','"+docno+"')";
		    //System.out.println("==7777777777777777777777777777777777777777777=="+sql);
				     int resultSet2 = stmtpuchase.executeUpdate(sql);
				     System.out.println("==srvexp=="+resultSet2);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			
			double stkvalue=0;
		     String sqls="select sum(op_qty*cost_price) stkvalue from my_prddin where tr_no="+mastertr_no+" " ;
		 	ResultSet sfocs=stmtpuchase.executeQuery(sqls);
			
			if(sfocs.next())
			{
				stkvalue=sfocs.getDouble("stkvalue");
			 
				 
			}
			if(reftype.equalsIgnoreCase("GRN"))
			{
				
			     String sqls1="select sum(op_qty*cost_price) stkvalue from my_prddin where invno="+docno+" " ;
				 	ResultSet sfocs1=stmtpuchase.executeQuery(sqls1);
					
					if(sfocs1.next())
					{
						stkvalue=sfocs1.getDouble("stkvalue");
					 
						 
					}
			}
			
			
			
			// jv entry pass
			
						String invdates="";
			String sqldate="SELECT DATE_FORMAT('"+invdate+"', '%d-%m-%Y') dates";
			ResultSet rsssss=stmt1.executeQuery(sqldate);
			if(rsssss.first())
			{
				invdates=rsssss.getString("dates");
			}
			
			String descs=""+invno+""+" - DT :- "+invdates+" - "+purdesc; 
			
			String refdetails=invno;
			
 
			 
		  	Statement stmt = conn.createStatement(); 	 
		 
		  int	venderaccount=vendocno;
		 
	      
		 
		 String vendorcur="1"; 
		 double venrate=1;
		 
		 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
			//System.out.println("---1----sqls10----"+sqls10) ;
		   ResultSet tass11 = stmt.executeQuery (sqls10);
		   if(tass11.next()) {
		
			   vendorcur=tass11.getString("curid");	
			 
				
		        }
		 
		 
	     String currencytype="";
	     String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
	        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
	     //System.out.println("-----2--sqlss----"+sqlss) ;
	     ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);
	         
	      while (resultSet33.next()) {
	    	  venrate=resultSet33.getDouble("rate");
	    	 // System.out.println("venrate========"+venrate);
	     currencytype=resultSet33.getString("type");
	                      }
	   double dramnt=0;
	   double  updtaxs=0;
	   updtaxs=stval+descgridtax;
	   //System.out.println("nettotaldown sql1==============="+netTotaldown);
	  // System.out.println("servnettotal sql1==============="+servnettotal);
	   //System.out.println("updtax sql1==============="+updtaxs);
		   if(cmbbilltype==1)
		   {
		    	dramnt=(netTotaldown+roundOf+updtaxs+servnettotal)*-1;
		    	dramnt=ClsCommon.Round(dramnt, 2);  
		    	//System.out.println("dramnt============"+dramnt);
		   }
		   else
		   {
				dramnt=(netTotaldown+roundOf+servnettotal)*-1;
				dramnt=ClsCommon.Round(dramnt, 2);
				//System.out.println("dramnt============"+dramnt);
		   }
			 
		   double ldramnt=0;
		   if(currencytype.equalsIgnoreCase("D"))
		   {
		   
           	
           	 ldramnt=dramnt/venrate ;
           	ldramnt=ClsCommon.Round(ldramnt, 2);
           //	System.out.println("ldramnt============"+ldramnt);
		   }
		   
		   else
		   {
			    ldramnt=dramnt*venrate ; 
			    ldramnt=ClsCommon.Round(ldramnt, 2);
			   // System.out.println("ldramnt============"+ldramnt);
		   }
		   

		
		 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramnt+","+ldramnt+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
		 //  	System.out.println("--sql1----"+sql1);
		 int ss = stmt.executeUpdate(sql1);
		 System.out.println("--sql1----"+ss);
	     if(ss<=0)
			{
				conn.close();
				return 0;
				
			}
	     String expcurrid="1"; 
	     double exprate=1;
			for(int i=0;i< exparray.size();i++){
		    	
			     String[] singleexparray=exparray.get(i).split("::");
			     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
			     {
			    	 
			    String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
			    String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 
			    
			    String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
			   ResultSet rsexp = stmt.executeQuery (sqlsexp);
			   if(rsexp.next()) {
			
				   expcurrid=rsexp.getString("curid");	
				 
					
			        }
			 
			 
		     String expcurrencytype="";
		     String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
		        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
		     //System.out.println("-----2--sqlss----"+sqlss) ;
		     ResultSet rsexpx = stmt.executeQuery(sqlexpselect);
		         
		      while (rsexpx.next()) {
		    	  
		    	          exprate=rsexpx.getDouble("rate");
		    	          expcurrencytype=rsexpx.getString("type");
		                      
		                            }
		   
			   double	expdramount=Double.parseDouble(exptotaldramounts)*-1; 
			   expdramount=ClsCommon.Round(expdramount, 2);
				 
			   double expldramount=0;
			   if(expcurrencytype.equalsIgnoreCase("D"))
			   {
			   
	           	
				   expldramount=expdramount/exprate;  
				   expldramount=ClsCommon.Round(expldramount, 2);
			   }
			   
			   else
			   {
				   expldramount=expdramount*exprate;  
				   expldramount=ClsCommon.Round(expldramount, 2);
			   }
			   

			
			 String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,-1,3,0,0,0,'"+exprate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
		     
			  //	System.out.println("--sql2----"+sql1s);
			 int sss = stmt.executeUpdate(sql1s);
			 System.out.println("--sql2----"+sss);

		     if(sss<=0)
				{
					conn.close();
					return 0;
					
				}
		     
			    
			    
			     }
			     
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
			 
				      double pricetottal=stkvalue;
				    //  System.out.println("-----pricetotal----"+pricetottal) ;
				      pricetottal=ClsCommon.Round(pricetottal, 2);
				     // System.out.println("-----pricetotal----"+pricetottal) ;
				      double ldramounts=0 ;     
				      if(currencytype1.equalsIgnoreCase("D"))
				      {
				      
		                   ldramounts=pricetottal/venrate ; 
		                   ldramounts=ClsCommon.Round(ldramounts, 2);		                  
		                   //System.out.println("-----venrate----"+venrate) ;
		                   //System.out.println("-----ifldramounts----"+ldramounts) ;
				      }
				      
				      else
				      {
				    	   ldramounts=pricetottal*venrate ;
				    	   ldramounts=ClsCommon.Round(ldramounts, 2);
		                  // System.out.println("-----venrate----"+venrate) ;
		                  // System.out.println("-----elseldramounts----"+ldramounts) ;
				      }
	     // stock account
		 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
	     
		// System.out.println("---sql33----"+sql11) ; 
	 
			 int ss1 = stmt.executeUpdate(sql11);
			 System.out.println("--sql33----"+ss1);
		     if(ss1<=0)
				{
					conn.close();
					return 0;
					
				}
		     
		     
		     
		     
		    //tax 
		     
		     
		     
		     
		     
		     
		     
		     
		     if(taxmethod>0)
				{
					
					
		    	 double taxtotals=0;
		    	 
		    	 
		    	 String sqlsss="select sum(taxamount) taxamount  from my_srvd where rdocno= "+docno+" ";
					
		    	 ResultSet mrs= stmt.executeQuery (sqlsss);
		    	 if(mrs.next())
		    	 {
		    		 
		    		 taxtotals=mrs.getDouble("taxamount");
		    		 
		    	 }
		    		 
		    		 
		    	 nettax=taxtotals;
		    	 stval=taxtotals;
					
					//client part

					String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet tax1sql = stmt.executeQuery (ggg);
					if(tax1sql.next()) {

						vendorcur=tax1sql.getString("curid");	


					}

  
					String taxcurrencytype1="";
					String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					// System.out.println("-----2--dddd----"+dddd) ;
					ResultSet resultSet = stmt.executeQuery(dddd);

					while (resultSet.next()) {
						venrate=resultSet.getDouble("rate");
						taxcurrencytype1=resultSet.getString("type");
					}

					double	dramounts=nettax*-1; 


					double ldramountss=0;
					if(taxcurrencytype1.equalsIgnoreCase("D"))
					{


						ldramountss=dramounts/venrate ;  
					}

					else
					{
						ldramountss=dramounts*venrate ;  
					}



 /*
					
						String rdse="update   my_jvtran set  dramount=dramount+"+dramounts+",ldramount=ldramount+"+ldramountss+" where tr_no="+mastertr_no+" and acno="+venderaccount+"   ";
				 
					
					int ss1111 = stmt.executeUpdate(rdse);
		 

					if(ss1111<=0)
					{
						conn.close();
						return 0;

					}
					*/
					
					
					
					
					
					
					if(cmbbilltype==1)
					{
					
					
					// total tax amount  int stacno=0;
					int divdval=1;
					if(stacno1>0)
					{
						divdval=2;
					}
					
					
					 
					
					//System.out.println("=========================stacno===================================="+stacno);
					
					
					String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet t1sql1 = stmt.executeQuery(lll);
					if(t1sql1.next()) {

						vendorcur=t1sql1.getString("curid");	


					}

  
					String taxcurre="";
					String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//	 System.out.println("-----2--ppp----"+ppp) ;
					ResultSet r1 = stmt.executeQuery(ppp);

					while (r1.next()) {
						venrate=r1.getDouble("rate");
						taxcurre=r1.getString("type");
					}
					double	dramt=0;  
					dramt=(stval+descgridtax)/divdval; 
					dramt=ClsCommon.Round(dramt, 2);

					double ldramt=0;
					if(taxcurre.equalsIgnoreCase("D"))
					{


						ldramt=dramt/venrate;  
						ldramt=ClsCommon.Round(ldramt, 2);

					}

					else
					{
						ldramt=dramt*venrate;
						ldramt=ClsCommon.Round(ldramt, 2);
					}


					// tax entry
					String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

					//	System.out.println("--sql44----"+sltax11);
					int aa = stmt.executeUpdate(sltax11);
					System.out.println("--sql44----"+aa);
					if(aa<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					
					
					
					
					// total tax amount  int stacno1=0;
					//stacno1
					
					
					 
					
					//System.out.println("=========================stacno1===================================="+stacno1);
					
					if(stacno1>0)
					{
					
					
					
						String llls1="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno1+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet t1sql1s1 = stmt.executeQuery(llls1);
						if(t1sql1s1.next()) {

						vendorcur=t1sql1s1.getString("curid");	


						}

 
						String taxcurres1="";
						String ppp1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						//System.out.println("-----2--ppp1----"+ppp1) ;
						ResultSet rs11 = stmt.executeQuery(ppp1);

						while (rs11.next()) {
						venrate=rs11.getDouble("rate");
						taxcurres1=rs11.getString("type");
							}
						double	dramts1=0;
						dramts1=(stval+descgridtax)/divdval; 
						dramts1=ClsCommon.Round(dramts1, 2);


						double ldramts1=0;
						if(taxcurres1.equalsIgnoreCase("D"))
						{


						ldramts1=dramts1/venrate; 
						ldramts1=ClsCommon.Round(ldramts1, 2);
						}

						else
						{
						ldramts1=dramts1*venrate;  
						ldramts1=ClsCommon.Round(ldramts1, 2);
						}


						// tax 2
						String sltax11s1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//System.out.println("--sql5----"+sltax11s1);
						int aas1 = stmt.executeUpdate(sltax11s1);
						System.out.println("--sql5----"+aas1);

						if(aas1<=0)
						{
							conn.close();
							return 0;

						}
					
					
					
					
					}
					
					
					}
			      	 else if(cmbbilltype==2)
				    	 
			    	 {
			 
						int refaccno=0;
						int payaccno=0;
			      		 
			      		 
			      		Statement ssss10=conn.createStatement();		
						
				 
				 
						 String sqls111="select acno from gl_taxmaster where fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and type=1 and status=3   ";
				       //  System.out.println("====sqls111=== 1====="+sqls111);
				         ResultSet rstaxxx1011=ssss10.executeQuery(sqls111); 
				         if(rstaxxx1011.first())
				         {
				        	 refaccno=rstaxxx1011.getInt("acno");
				         }
	 
						 String sqls1111="select acno from gl_taxmaster where fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and type=2 and status=3   ";
				        // System.out.println("====sqls1111====2===="+sqls1111);
				         ResultSet rstaxxx10111=ssss10.executeQuery(sqls1111); 
				         if(rstaxxx10111.first())
				         {
				        	 payaccno=rstaxxx10111.getInt("acno");
				         }
	 
							 
							
							
						//	System.out.println("=========================stacno===================================="+stacno);
							
							
							String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+refaccno+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet t1sql1 = stmt.executeQuery(lll);
							if(t1sql1.next()) {

								vendorcur=t1sql1.getString("curid");	


							}

		  
							String taxcurre="";
							String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						//	 System.out.println("-----2--ppp----"+ppp) ;
							ResultSet r1 = stmt.executeQuery(ppp);

							while (r1.next()) {
								venrate=r1.getDouble("rate");
								taxcurre=r1.getString("type");
							}
							double	dramt=0;
							dramt=stval+descgridtax; 


							double ldramt=0;
							if(taxcurre.equalsIgnoreCase("D"))
							{


								ldramt=dramt/venrate;  
							}

							else
							{
								ldramt=dramt*venrate;  
							}


							// tax entry 3
							String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+refaccno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

								//System.out.println("--sql6----"+sltax11);
							int aa = stmt.executeUpdate(sltax11);
							System.out.println("--jventrysql6----"+aa);
							if(aa<=0)
							{
								conn.close();
								return 0;

							}
							
							// total tax amount  int stacno1=0;
							//stacno1
							
							
							 
							
					 
							if(payaccno>0)
							{
							
							
							
								String llls1="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+payaccno+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
								ResultSet t1sql1s1 = stmt.executeQuery(llls1);
								if(t1sql1s1.next()) {

								vendorcur=t1sql1s1.getString("curid");	


								}

		 
								String taxcurres1="";
								String ppp1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
								//System.out.println("-----2--ppp1----"+ppp1) ;
								ResultSet rs11 = stmt.executeQuery(ppp1);

								while (rs11.next()) {
								venrate=rs11.getDouble("rate");
								taxcurres1=rs11.getString("type");
									}
								double	dramts1=0;
								dramts1=(stval+descgridtax)*-1; 


								double ldramts1=0;
								if(taxcurres1.equalsIgnoreCase("D"))
								{


								ldramts1=dramts1/venrate;  
								}

								else
								{
								ldramts1=dramts1*venrate;  
								}


								// tax 4
								String sltax11s1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+payaccno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

								System.out.println("--sql7----"+sltax11s1);
								int aas1 = stmt.executeUpdate(sltax11s1);
								System.out.println("--jventrysql7----"+aas1);

								if(aas1<=0)
								{
									conn.close();
									return 0;

								}
							
							
							
							
							}
			    	 
			    	 }
						
					
					
					// tax1acno tax 1

					
				 
					
/*					
					if(tax1acno>0)
					{
						System.out.println("=========================tax1acno===================================="+tax1acno);
						String tsqls="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax1acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tsqlsa = stmt.executeQuery(tsqls);
						if(tsqlsa.next()) {

							vendorcur=tsqlsa.getString("curid");	


						}

	     
						String taxcur="";
						String sqlvenslect111 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenslect111----"+sqlvenslect111) ;
						ResultSet r11 = stmt.executeQuery(sqlvenslect111);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur=r11.getString("type");
						}

						double	dramt1=tax1; 


						double ldramt1=0;
						if(taxcur.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String sqlax111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax1acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(sqlax111);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					*/
					
				/*	
					if(tax2acno>0)
					{
						
						
						System.out.println("=========================tax2acno===================================="+tax2acno);
						
						
						String sqlstax10111="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax2acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql111 = stmt.executeQuery(sqlstax10111);
						if(tax1sql111.next()) {

							vendorcur=tax1sql111.getString("curid");	


						}

	     
						String taxcur1="";
						String gjjj = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--gjjj----"+gjjj) ;
						ResultSet r11 = stmt.executeQuery(gjjj);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur1=r11.getString("type");
						}

						double	dramt1=tax2; 


						double ldramt1=0;
						if(taxcur1.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String oops="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax2acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(oops);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					*/
					
					
				/*	
					if(tax3acno>0)
					{
						System.out.println("=========================tax3acno===================================="+tax3acno);
						String pyy="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax3acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql1111 = stmt.executeQuery(pyy);
						if(tax1sql1111.next()) {

							vendorcur=tax1sql1111.getString("curid");	


						}

	     
						String taxcur2="";
						String ttt = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenselect----"+ttt) ;
						ResultSet r111 = stmt.executeQuery(ttt);

						while (r111.next()) {
							venrate=r111.getDouble("rate");
							taxcur2=r111.getString("type");
						}

						double	dramt1=tax3; 


						double ldramt1=0;
						if(taxcur2.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String eee="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax3acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(eee);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					*/
					 
					
					
					
				}
				
				
				
				
				
			//======================	
		     
		     
		     String clsql=" select cldocno from my_head where dtype='VND' and doc_no='"+venderaccount+"'";
		     
		     //System.out.println("========clsql=========="+clsql);
		    ResultSet clrs= stmt.executeQuery(clsql);
		    
		    int vndcldocno=0;
		    if(clrs.next())
		    {
		    	vndcldocno=clrs.getInt("cldocno");
		    }
		     
		     
		     if(vndcldocno>0)
		     {
		    	 
		    	String sql1ss="update my_jvtran set cldocno='"+vndcldocno+"'  where acno='"+venderaccount+"' and tr_no='"+mastertr_no+"' and status=3  ";
		    	
		    	// System.out.println("========usql1ss1=========="+sql1ss);
		    	stmt.executeUpdate(sql1ss);
		    	
		     }
		     
		     
				double  rround=roundOf;
				if(rround>0 || rround<0)// less 0
				{
					int acnos3=0;
					String curris3="1";
					double rates3=1;

					String sql222="select  acno from my_account where codeno='ROUND OF ACCOUNT' ";
					ResultSet tass222 = stmt.executeQuery (sql222);
					if (tass222.next()) {
						acnos3=tass222.getInt("acno");		
					}

					String sqls33="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos3+"'";
					ResultSet tass33 = stmt.executeQuery (sqls33);
					if (tass33.next()) {
						curris3=tass33.getString("curid");	
					}
					
					String currencytype3="";
					String sqlveh3 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris3+"'";
					//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
					ResultSet resultSet3 = stmt.executeQuery(sqlveh3);
					while (resultSet3.next()) {
					double	rates2=resultSet3.getDouble("rate");
						currencytype3=resultSet3.getString("type");
					} 

					 
					double ldramounts3=0 ;     
					if(currencytype3.equalsIgnoreCase("D"))
					{
						ldramounts3=rround/venrate ;  
					}
					else
					{
						ldramounts3=rround*venrate ;  
					}
					
					int id1=1;
					if(ldramounts3>0)
					{
						id1=1;
					}
					else
					{
						id1=-1;
					}
					// round off
					String sql13="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos3+"','"+descs+"','"+curris3+"','"+rates3+"',"+rround+","+ldramounts3+",0,"+id1+",3,0,0,0,'"+rates3+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
					// System.out.println("---sql8----"+sql13) ; 
					int ss3 = stmt.executeUpdate(sql13);
					System.out.println("---jventry8----"+ss3) ;
					if(ss3<=0)
					{
						conn.close();
						return 0;
					}
				}

		     
		     
		    //=========================================================================== 
		     
		     
		     double jvdramount=0;
		     int id=0;
		     int adjustacno=0;
		     
		     String adjustcurrid="1";
		     
		     
		     double adjustcurrate=1;
		     
			 String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+mastertr_no+"'";
			  //  System.out.println("-----5--sqls3----"+sqls3) ;
			   ResultSet jvrs = stmt.executeQuery (jvselect);
				
				if (jvrs.next()) {
			
					jvdramount=jvrs.getDouble("dramount");	
					 
					
			              }
				// System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{
					
					
					if(jvdramount>0)
					{
						id=1;
							
						
					}
					
					else
					{
						
						id=-1;
					}
					
					
					
				     
					   String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					// System.out.println("-----4--sql2----"+sql2) ;

				       ResultSet adjaccount = stmt.executeQuery (sqls2);
						
						if (adjaccount.next()) {
					
							adjustacno=adjaccount.getInt("acno");		
							
					        }
						
						
					
						 String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
						   //System.out.println("-----5--sqls3----"+sqls3) ;
						   ResultSet exptass3 = stmt.executeQuery (expsqls3);
							
							if (exptass3.next()) {
						
								adjustcurrid=exptass3.getString("curid");	
								 
								
						              }
							String adjustcurrencytype1="";
							 String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
							// System.out.println("---adjustsql----"+adjustsql) ;
								     ResultSet resultadj = stmt.executeQuery(adjustsql);
								         
								      while (resultadj.next()) {
								    	  adjustcurrate=resultadj.getDouble("rate");
								    	  adjustcurrencytype1=resultadj.getString("type");
								                 } 
								      
								      
								      double adjustldramounts=0 ;     
								      if(adjustcurrencytype1.equalsIgnoreCase("D"))
								      {
								      
								    	  adjustldramounts=jvdramount/adjustcurrate ;  
								      }
								      
								      else
								      {
								    	  adjustldramounts=jvdramount*adjustcurrate ;  
								      }
					
					
								      
								      
								      // adjustment
								      String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
								     
								     
								//	 System.out.println("---sql9----"+adjustsql11) ; 
								 
										 int result1 = stmt.executeUpdate(adjustsql11);
										 System.out.println("---jventry9----"+result1) ;
									     if(result1<=0)
											{
												conn.close();
												return 0;
												
											}
									     	      
					
					
					
				}
				
				
				if(cosrcodemethod>0) 
				{
					
					String upcostsql1="update my_jvtran  set costtype='"+itermtype+"',costcode='"+costtrno+"' where tr_no="+mastertr_no+" ";
				//	System.out.println("usql2============"+upcostsql1);
					stmt.executeUpdate(upcostsql1);
					
					 
					
					if(itermtype>0)
					{

						 int TRANIDs=0;
						 int sno=0;
                         int accounts=0;
					     double finalamt=0;  
					     Statement sss=conn.createStatement();
					     Statement stmtg=conn.createStatement();
					
							String trsqlss="  select j.tranid,j.acno,j.tr_no,dramount nettotal from my_jvtran j inner join my_head h on j.acno=h.doc_no where gr_type in (4,5) and  j.tr_no="+mastertr_no+"     ";
					
							ResultSet tass111 = sss.executeQuery (trsqlss);
							
							while (tass111.next()) {
								sno=sno+1;
								TRANIDs=tass111.getInt("tranid");	
								accounts=tass111.getInt("acno");	
								finalamt=tass111.getDouble("nettotal");	
										if(accounts>0)
										{
										String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
												+ " "+itermtype+","+finalamt+","+costtrno+","+TRANIDs+","+mastertr_no+")";
												 
								  int costabsq=  stmtg.executeUpdate(ssql);
								  System.out.println("cstran==="+costabsq);
								  if(costabsq<=0)
									{
										conn.close();
										
										return 0;
										
									   }
										
								     }
							}
							
						
					}
					
					
				}
				
	     
 
		     
				ArrayList<String> arr=new ArrayList<String>(); 
				ClsVatInsert ClsVatInsert=new ClsVatInsert();
				Statement newStatement=conn.createStatement();
				String selectsqls="select sum(coalesce(a.nettaxamount,0)+coalesce(a.nettotal,0)+coalesce(a.exnet,0)) nettaxamount,sum(coalesce(a.totse,0)+coalesce(a.totma,0)) total1,sum(a.total2) total2,sum(a.total3) total3," 
						+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
						+"sum(a.total9) total9,sum(a.total10) total10,sum(coalesce(a.tax1,0)+coalesce(a.srvtaxamount,0)) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,"
						+ " sum(a.tax6) tax6, "
						+"sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
						+"from (select coalesce(ex.nettotal,0) exnet,sr.nettotal,sr.srvtaxamount,m.typeid,d.nettotal+coalesce(d.taxamount,0) nettaxamount,if(m.typeid=1 and d.taxamount>0,d.nettotal,0) totma,if(m.typeid=1 and sr.srvtaxper>0,(sr.nettotal-sr.srvtaxamount),0)totse, "
						+"if(m.typeid=2 or (m.typeid=1 and d.taxamount=0),d.nettotal,0) total2,if(m.typeid=3,d.nettotal,0) total3,"
						+"if(m.typeid=4,d.nettotal,0) total4,if (m.typeid=5,d.nettotal,0) total5, "
						+"if(m.typeid=6,d.nettotal,0) total6,if(m.typeid=7,d.nettotal,0) total7, "
						+"if(m.typeid=8,d.nettotal,0) total8,if(m.typeid=9,d.nettotal,0) total9, "
						+"if(m.typeid=10,d.nettotal,0) total10, "
						+"if(m.typeid=1,coalesce(d.taxamount,0),0) tax1,  if(m.typeid=2,coalesce(d.taxamount,0),0) tax2, "
						+"if(m.typeid=3,coalesce(d.taxamount,0),0) tax3,  if(m.typeid=4,coalesce(d.taxamount,0),0) tax4, "
						+"if(m.typeid=5,coalesce(d.taxamount,0),0) tax5,  if(m.typeid=6,coalesce(d.taxamount,0),0) tax6, "
						+"if(m.typeid=7,coalesce(d.taxamount,0),0) tax7,  if(m.typeid=8,coalesce(d.taxamount,0),0) tax8, "
						+"if(m.typeid=9,coalesce(d.taxamount,0),0) tax9,  if(m.typeid=10,coalesce(d.taxamount,0),0) tax10 "
						+" from my_srvd d left join my_main m on m.psrno=d.psrno left join my_srvser sr on d.tr_no=sr.tr_no left join my_srvexp ex on sr.tr_no=ex.tr_no where d.tr_no="+mastertr_no+" ) a " ;
			
				//System.out.println("===Abc===="+selectsqls);
				ResultSet rss101=newStatement.executeQuery(selectsqls);
				if(rss101.first())
					{
					arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
							rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
							rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
							rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
							rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
							rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
							rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
					}
				
					int result=ClsVatInsert.vatinsert(1,1,conn,mastertr_no,venderaccount,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),invno,cmbbilltype,arr,mode)	;
						System.out.println("vat============="+result);
					if(result==0)	
					        {
							 
							conn.close();
							return docno;
							}
				if(cmbbilltype==2)
					{
					int result1=ClsVatInsert.vatinsert(2,2,conn,mastertr_no,venderaccount,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),invno,cmbbilltype,arr,mode)	;
					System.out.println("vat2============="+result1);
					if(result1==0)	
							{
							 
							conn.close();
							return docno;
							}
					}
				
				
				
				Statement ss11=conn.createStatement();
				int vals=0;	
			String sqlsssss="select coalesce(i.cost_price,0) cs from my_srvd d left join my_prddin i on i.stockid=d.stockid where d.rdocno='"+docno+"' and  coalesce(i.cost_price,0)=0 ";
			System.out.println("culpretvals============="+sqlsssss);
			ResultSet rsss111=ss11.executeQuery(sqlsssss);
			if(rsss111.next()){   
				vals=1;
				System.out.println(rsss111.getInt("cs")+"================vals============="+vals);    
			}
			
			if(vals==1)
			{
				System.out.println("================culpretvals=============");
				conn.close();
				return 0;
			}
			
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpuchase.close();
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
			String rrefno, double prddiscount, ArrayList<String> exparray, String updatadata,double exptotal,Date invdate,String invno,
			int locationid, double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype,int itermtype,int costtrno,double descgridhid,double descgridtax) throws SQLException {
		/*System.out.println("in...dao");
		System.out.println("producttotal====="+productTotal);
		System.out.println("descpercentage======"+descPercentage);
		System.out.println("descountval======="+descountVal);
		System.out.println("roundof======="+roundOf);
		System.out.println("nettotaldown======="+netTotaldown);
		System.out.println("servnettotal======="+servnettotal);
		System.out.println("ordervalue======="+orderValue);
		System.out.println("stval======="+stval);*/
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpuchase= conn.prepareCall("{call tr_PurchaseinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchase.setInt(20,masterdoc_no);
			stmtpuchase.setInt(24, 0);
 
			stmtpuchase.setDate(1,masterdate);
			stmtpuchase.setDate(2,deldate);
			stmtpuchase.setString(3,refno);
			stmtpuchase.setInt(4,vendocno);
		   	stmtpuchase.setInt(5,cmbcurr);
			stmtpuchase.setDouble(6,currate);
			stmtpuchase.setString(7,delterms); 
			stmtpuchase.setString(8,payterms);
			stmtpuchase.setString(9,purdesc);
			stmtpuchase.setDouble(10,productTotal);
			stmtpuchase.setDouble(11,descPercentage);
			stmtpuchase.setDouble(12,descountVal);
			stmtpuchase.setDouble(13,roundOf);
			stmtpuchase.setDouble(14,netTotaldown);
			stmtpuchase.setDouble(15,descgridhid);
			stmtpuchase.setDouble(16,orderValue);
			stmtpuchase.setString(17,session.getAttribute("USERID").toString());
			stmtpuchase.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(21,formdetailcode);
			stmtpuchase.setString(22,mode);
			stmtpuchase.setInt(23,chkdiscount);
			stmtpuchase.setString(25,reftype);
			stmtpuchase.setString(26,rrefno);
			stmtpuchase.setDouble(27,prddiscount);
			stmtpuchase.setDouble(28,exptotal);
			
			stmtpuchase.setDate(29,invdate);
			stmtpuchase.setString(30,invno);
			stmtpuchase.setInt(31,locationid);
			 
			
		    int res=stmtpuchase.executeUpdate();
			docno=stmtpuchase.getInt("docNo");

			//System.out.println("====vocno========"+vocno);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			int mastertr_no=0;
			int vocno=0;	
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no,voc_no from my_srvm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				vocno=selrs.getInt("voc_no");
			}
			//System.out.println("-updatadata--"+updatadata);
			
			
			
			//tax
			
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
				String upcostsql="update my_srvm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			
			
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
				String sqlssss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+vendocno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlssss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					taxmethod=0;
				}
				
			 int stacno=0;
			 
			 int stacno1=0;
			 int tax1acno=0;
			 int tax2acno=0;
			 int tax3acno=0;
			 
			 
			  if(taxmethod>0)
			  {
				  
				  
				  
				  
				  
				  
				double  updtax=0;
				updtax=stval+descgridtax;
				  if(updatadata.equalsIgnoreCase("Editvalue")) // change
					{
					  
					netTotaldown=netTotaldown-stval; 
					
				  String sqltax1= " update my_srvm set totaltax='"+updtax+"',tax1='0',tax2='0',tax3='0',"
				  		+ "nettotaltax='"+updtax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
				  
				//  System.out.println("======sqltax1========="+sqltax1);
				  
				  stmt1.executeUpdate(sqltax1);
					}
			
			  int prvdocno=0;
				 
				  Statement pv=conn.createStatement();
					
					String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
					
				//	System.out.println("=======dd========"+dd);
					
					
					ResultSet rs13=pv.executeQuery(dd); 
					if(rs13.next())
					{

						prvdocno=rs13.getInt("prvdocno");
					}
				//	System.out.println("======prvdocno========"+prvdocno);

					 
				 
//				  
//				  	Statement ssss10=conn.createStatement();
//			  
//					 String sql10="  select acno,value from gl_taxmaster where doc_no=(select max(doc_no) tdocno from gl_taxmaster where  "
//					 		+ "  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'  )  and status=3 and type=1 and provid='"+prvdocno+"'  " ;
//				
//					 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
//					 if(rstaxxx101.next())
//					 {
//						 
//						 stacno=rstaxxx101.getInt("acno");
//						
//												 	
//					 	
//					 } 
					Statement ssss10=conn.createStatement();		
					
					 String sql10="  select acno,value from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'   "
				 				+ "  and status=3 and type=1 and provid='"+prvdocno+"' and  if(1="+cmbbilltype+",per,cstper)>0  " ;
			 
			 
			 
			// System.out.println("====sql10========"+sql10);
			 
			 
			 int mm=0;
		
			 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
			 while(rstaxxx101.next())
			 {
				 if(mm==0)
				 {
				 stacno=rstaxxx101.getInt("acno");
				 }

				 if(mm==1)
				 {
					 stacno1=rstaxxx101.getInt("acno");
				 } 
				 mm=mm+1;
										 	
			 	
			 }

				  
				  	Statement ssss=conn.createStatement();
			  
					 String sql100=" select s.acno,s.value "
							 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
							 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
							 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
				//System.out.println("=====sql======"+sql100);
					 ResultSet rstaxxx=ssss.executeQuery(sql100); 
					 if(rstaxxx.next())
					 {
						 String typeoftax="0";
						 tax1acno=rstaxxx.getInt("acno");
						 typeoftax=rstaxxx.getString("value");
						 
						 String sqltax11= " update my_srvm set typeoftax='"+typeoftax+"'    where doc_no='"+docno+"' ";
							  
						// System.out.println("======sqltax11========="+sqltax11);
							  
						 stmt1.executeUpdate(sqltax11);						 	
					 	
					 }

					  	Statement ssss1=conn.createStatement();
				  
						 String sql166=" select s.acno"
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  " ;
					
						 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
						 if(rstaxxx1.next())
						 {
							 
							 tax2acno=rstaxxx1.getInt("acno");
													 	
						 	
						 }
			  
							Statement ssss3=conn.createStatement();
							  
							 String sql311=" select s.acno "
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
							 if(rstaxxx3.next())
							 {
								 
								 tax3acno=rstaxxx3.getInt("acno");
														 	
							 	
							 }
				  
			  
			  
			  }
			 
			  
			  
			  
				  
			
			
			
			if(!(updatadata.equalsIgnoreCase("Editvalue")))
			{
				
				 if(reftype.equalsIgnoreCase("DIR"))
		         {		
			String upsqlss="update  my_prddin set date='"+masterdate+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' ";
			stmtpuchase.executeUpdate(upsqlss);
		         }
			}
			
			 
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{
			
				netTotaldown=netTotaldown-roundOf;
					
			
			
						String delsqls="delete from my_srvd where tr_no='"+mastertr_no+"' ";
						stmtpuchase.executeUpdate(delsqls);
						
						String delsqlss="delete from my_srvser where rdocno='"+docno+"' ";
						stmtpuchase.executeUpdate(delsqlss);
						
						
						String delexpsql="delete from my_srvexp where rdocno='"+docno+"' ";
						stmtpuchase.executeUpdate(delexpsql);
						
						String deljvsql="delete from my_jvtran where tr_no='"+mastertr_no+"' ";
						stmtpuchase.executeUpdate(deljvsql);
						
						
				    	 
 			    	   if(reftype.equalsIgnoreCase("DIR") || reftype.equalsIgnoreCase("PO"))
					         {	 
				    		   
				   			String deltermssql="delete from my_prddin where tr_no='"+mastertr_no+"' ";
							stmtpuchase.executeUpdate(deltermssql); 
				    		   
					         } 
 
						
			
					  	int	updateid=0;
					  	
						String rownochk="0"; 
						

						int bachmethod=0;
						 Statement stmtw=conn.createStatement();
						 String batchs="select method  from gl_prdconfig where field_nme='batch_no'";
						 ResultSet rz=stmtw.executeQuery(batchs); 
						 if(rz.next())
						 {
						 	
							 bachmethod=rz.getInt("method");
						 }

							int expmethod=0;
							 Statement stmtd=conn.createStatement();
							 String expdatesql="select method  from gl_prdconfig where field_nme='exp_date'";
							 ResultSet exprs=stmtd.executeQuery(expdatesql); 
							 if(exprs.next())
							 {
							 	
								 expmethod=exprs.getInt("method");
							 }

							  
				
						
						
						for(int i=0;i< masterarray.size();i++){
					    	
						     String[] detmasterarrays=masterarray.get(i).split("::");
						     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
						     {
						    	 
						    	 
						    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    	 
						    	 
							     double chkqty=Double.parseDouble(qtychk);
						    	
							     
							     double expenxetotal=0;
							     double resultexptotal=0;
							     double totalpriceallqty=0;
							     
							     double costprice=0;
							     
							     if(chkqty>0){
							    	 
							      	 String psrnos=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
							    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
										 
							         double fr=1;
								     String slss=" select fr from my_unit where psrno="+psrnos+" and unit='"+unitids+"' ";
								     
								     //System.out.println("====slss==="+slss);
								     ResultSet rv1=stmtpuchase.executeQuery(slss);
								     if(rv1.next())
								     {
								    	 fr=rv1.getDouble("fr"); 
								     }
						    	 
                        String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				    	 
				    	 double gridnettotal=Double.parseDouble(gridnettotals);
				    	 gridnettotal=ClsCommon.Round(gridnettotal, 2);
				    	 //System.out.println("--gridnettotal---"+gridnettotal);
				    	 expenxetotal=servnettotal+exptotal;
				    	 expenxetotal=ClsCommon.Round(expenxetotal, 2);
				    	 if(expenxetotal>0)
				    	 {
						 //System.out.println("--expenxetotal---"+expenxetotal);
				    	 resultexptotal=(expenxetotal/netTotaldown)*gridnettotal;
				    	 resultexptotal=ClsCommon.Round(resultexptotal, 2);
				    	  //System.out.println("--resultexptotal---"+resultexptotal);
				    	 totalpriceallqty=gridnettotal+resultexptotal;
				    	 totalpriceallqty=ClsCommon.Round(totalpriceallqty, 2);
				    	 //System.out.println("--totalpriceallqty---"+totalpriceallqty);
				    	 costprice=totalpriceallqty/chkqty;
				    	 /*costprice=ClsCommon.Round(costprice, 2);*/
						 //System.out.println("--costprice-87654--"+costprice);  
				    	 }
				    	 else
				    	 {
				    		 
				    		 costprice=gridnettotal/chkqty;
				    		 /*costprice=ClsCommon.Round(costprice, 2);*/
							 //System.out.println("--costprice-87634--"+costprice);  
				    		 
				    	 }
				    	 
				    	 
				    	   if(reftype.equalsIgnoreCase("GRN")||reftype.equalsIgnoreCase("PO"))
					         {	 
				    	
				    		   
							    		 if(reftype.equalsIgnoreCase("GRN"))
							    		 {
							   
				    	
				    
									             String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
											       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
											       +"'"+mastertr_no+"','"+docno+"',"
											       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
											       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("") || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
											       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")  || detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ,"
											       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")  || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+" )";
							                      //   System.out.println("-----insql-"+insql);
											     int resultSet2 = stmtpuchase.executeUpdate(insql);
											     if(resultSet2<=0)
													{
														conn.close();
														return 0;
														
													}
											        
				     
				    		                 } //Noushad
				     
				                     // rrefno
								    		 else if(reftype.equalsIgnoreCase("PO"))
								    		 {
								    			 
									  			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
									 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
													    	 
													    	 
														     double paidqty=Double.parseDouble(paidqtyd);
														     
														     double focqty=Double.parseDouble(foc);
														 
														 
														     double opqty=paidqty+focqty; 
														     /*                          0                1                       2                       3
															  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
																	  
																	  
																	              4                        5                       6                      7                    8
																	   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
																	                     9                       10                     11                   12                       13                 14
																	   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc)*/
														     focqty=0;
														     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date,fr,unitid)values"
														    		 + "("+(i+1)+","
														             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
																     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
																     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
														               + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
																     +"'"+opqty*fr+"','"+focqty*fr+"',"
														             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice+",'"+docno+"',1,'"+masterdate+"',"+fr+","+unitids+")";
														     
														    // System.out.println("--sql2-----"+sql2);
														     int resultSet10 = stmtpuchase.executeUpdate(sql2);
														     if(resultSet10<=0)
																{
																	conn.close();
																	return 0;
																	
																}
												     	
												     int stockid=0;	
												    
											         Statement selstmt=conn.createStatement();
											     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
											     
											  
											     
											     ResultSet selrss=selstmt.executeQuery(sqlssel);
											     
											     if(selrss.next())
											     {
											    	 stockid=selrss.getInt("stockid") ;
											    	 
											    	 
											    	 
											 	 
											     }
											      
								     
										     
										     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
												       + "'"+stockid+"',"
												       +"'"+mastertr_no+"','"+docno+"',"
												       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
												       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("") || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
												       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("") || detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ,"
												       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")  || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+" )";
								                      //   System.out.println("-----insql-"+insql);
												     int resultSet2 = stmtpuchase.executeUpdate(insql);
												     if(resultSet2<=0)
														{
															conn.close();
															return 0;
															
														}		 
								    			 
								    			 
								    		  }
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     String amounts=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
			     
			  
					   
				     
				 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
			    	  
			    	   
				     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
				    
					 
				    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
				    	 

					     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					     
					     String oldqtys=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
					     
					     if(reftype.equalsIgnoreCase("GRN"))
						  {	
				    	       double currqty=Double.parseDouble(prddoutqty); 
					   	          double oldqty=Double.parseDouble(oldqtys); 
					 	         double balqty=0;
							 
				             int tr_no=0;
						 	 double remqty=0;
							 double out_qty=0;
								double qty=0;
								
								double grnout=0;
								
								
								double grnsaveqty=0; 
								double prddinsaveqty=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				   /* 	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
									+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
											+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";*/
				    	 
				    	/* having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0*/
				    	 
				/*		 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
				       				+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"'  "
				       						+ "and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
									+ "group by dd.stockid,dd.psrno,dd.prdid  order by dd.date";
				    	 */
						 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty)/dd.fr qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/dd.fr balstkqty,sum(dd.out_qty)/dd.fr out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
				       				+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"'and dd.unitid="+unitids+" and dd.prdid='"+prdid+"'  "
				       						+ "and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
									+ "group by dd.stockid,dd.psrno,dd.prdid  order by dd.date";
				    	 
	 
				        // System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balstkqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								//stockid=rs.getInt("stockid");
								qty=rs.getDouble("qty");
								grnout=rs.getDouble("grnout");
						//	System.out.println("---masterqty-----"+masterqty);	
							
						//	System.out.println("---grnout-----"+grnout);	
							//System.out.println("---out_qty-----"+out_qty);	

								//System.out.println("---masterqty-----"+masterqty);	

							//	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							//	System.out.println("---qty-----"+qty);

					
							   grnsaveqty=(currqty+grnout)-oldqty;
 
								//grnsaveqty=masterqty+grnout;
								
								String sqls="update my_grnd set out_qty="+grnsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
								

								//System.out.println("--1---sqls---"+sqls);


								stmtpuchase.executeUpdate(sqls);
								
								
                            //  	String prdinsqls="update my_prddin set cost_price="+costprice+",invno='"+docno+"',pstatus=1,unit_price='"+amounts+"'  where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
						      	String prdinsqls="update my_prddin set cost_price="+costprice/fr+",invno='"+docno+"',pstatus=1,unit_price='"+Double.parseDouble(amounts)/fr+"'  where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";		

							//	System.out.println("--1---prdinsqls---"+prdinsqls);


								stmtpuchase.executeUpdate(prdinsqls); 
								
								
							 
								
								break;


							 

							} 


				    		
				     

 
				     
				     
				    	 }
					         
				    	   else  if(reftype.equalsIgnoreCase("PO"))
					         {
				    		   
				    		        //  String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
							    	 
				                    //    String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
								     
								     
								     
								    //    double masterqty=Double.parseDouble(rqty); 
							    		 
									 int pridforchk=Integer.parseInt(prdid);
							    	 
									String amount=""+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"";
									  
									   
									   
										String discper=""+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"";
										   
									   
								    	/*	 if(pridforchk!=updateid)
								    		 {*/
								    			// System.out.println("--pridforchk--"+pridforchk);
								 			String sqlsa="update  my_ordd set out_qty=0 where tr_no in ("+rrefno+") and prdid="+pridforchk+" and clstatus=0  and amount='"+amount+"' and disper='"+discper+"' and unitid="+unitids+" and specno="+specno+"  and  rowno not in("+rownochk+") ";
						  
						    		 	   //System.out.println("--1323123123---"+sqlsa);
						    			   	
								 			stmtpuchase.executeUpdate(sqlsa);
						    				
						    				updateid=pridforchk;
								    		 
								    		// }
							   		 
									   		 
									    	   double balqty=0;
												int rowno=0;
									             int tr_no=0;
												double remqty=0;
												double out_qty=0;
													double qty=0;
													int unitid=0;
													int spec=0;
									    	 Statement stmt=conn.createStatement();
									 /*   	 
									    	 String strSql="select d.qty saveqty,sum((d.qty-d.out_qty)) Qty,d.rowno,d.tr_no,d.out_qty  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where \r\n" + 
									    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
									    	 
									    	 */
									    	 
									    	 
									    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno   from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where \r\n" + 
									    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"'  and d.amount='"+amount+"' and d.disper='"+discper+"'   and d.clstatus=0 and m.brhid="+session.getAttribute("BRANCHID")+" and  d.rowno not in("+rownochk+") group by d.rowno having   "
									    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
									    	 
					                         //   System.out.println("---11--strSql---"+strSql);
									    	 
									 
									    		ResultSet rs = stmt.executeQuery(strSql);
									     
									    
									    		 while(rs.next()) {
									    			 
									    			
													balqty=rs.getDouble("balqty");
													tr_no=rs.getInt("tr_no");
													out_qty=rs.getDouble("out_qty");

													rowno=rs.getInt("rowno");
													qty=rs.getDouble("qty");
													
													unitid=rs.getInt("unitid");
													spec=rs.getInt("specno");
													
													rownochk=rownochk+","+rowno;
												//	 System.out.println("---masterqty-----"+masterqty);	

												//	 System.out.println("---balqty-----"+balqty);	

													//System.out.println("---out_qty-----"+out_qty);	
													//System.out.println("---qty-----"+qty);
									    			 
													if(remqty>0)
													{

														masterqty=remqty;
													}


													if(masterqty<=balqty)
													{
														masterqty=masterqty+out_qty;

														
														String sqls="update my_ordd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+spec+" ";
														

													 //	 System.out.println("--1---sqls---"+sqls);


														stmtpuchase.executeUpdate(sqls);
														break ;


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


														String sqls="update my_ordd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+spec+"  ";	
												     	//System.out.println("-2----sqls---"+sqls);

														stmtpuchase.executeUpdate(sqls);	

													 



													} //else if

									    		 
									    			
									    	  		}  // while
							    	 
							     
							    	 
						 
							     
							     
							     
							    	 
								 
				    		   
				    		   
					         }
					         }
				   else  if(reftype.equalsIgnoreCase("DIR"))
				     {
				    	 

	 
 			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
				    	 
				    	 
					     double paidqty=Double.parseDouble(paidqtyd);
					     
					     double focqty=Double.parseDouble(foc);
					 
					 
					     double opqty=paidqty+focqty; 
					     /*                          0                1                       2                       3
						  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
								  
								  
								              4                        5                       6                      7                    8
								   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
								                     9                       10                     11                   12                       13                 14
								   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc 
								                       15                         16
								   +" :: "+rows[i].orderdiscper+" :: "+rows[i].orderamount+" :: ")*/
					     
					   //  ,invno='"+docno+"',pstatus=1 
					     //  ,invno='"+docno+"',pstatus=1 
					     focqty=0;
					     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date,fr,unitid)values"
					    		 + "("+(i+1)+","
					             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
							     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
					             + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
							     +"'"+opqty*fr+"','"+focqty*fr+"',"
					             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice/fr+",'"+docno+"',1,'"+masterdate+"',"+fr+","+unitids+")";
					     
					   
					    // System.out.println("--sql2-----"+sql2);
					     int resultSet10 = stmtpuchase.executeUpdate(sql2);
					     if(resultSet10<=0)
							{
								conn.close();
								return 0;
								
							}
					     	
					     int stockid=0;	
					    
				         Statement selstmt=conn.createStatement();
				     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
				     
				  
				     
				     ResultSet selrss=selstmt.executeQuery(sqlssel);
				     
				     if(selrss.next())
				     {
				    	 stockid=selrss.getInt("stockid") ;
				     
				     }
				      	 
				    	 
				     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno,fr)VALUES"
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
						       + "'"+stockid+"',"
						       +"'"+mastertr_no+"','"+docno+"',"
							   + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
							   + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")  || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
							   + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")  || detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ,"
								       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("") || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"',"+fr+" )";
		                    // System.out.println("-----insql-"+insql);
						     int resultSet2 = stmtpuchase.executeUpdate(insql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
									
								}
						  	 
				    	 
			
				    	 
				    	 
				    	 
				     }
				      
				     
					
	 
				     
				 
			     }	   
							     
							     
							     
							     if(bachmethod>0 || expmethod>0)
							     {
							     
							     	int   updatestockid=0;
							       Statement selstmt1=conn.createStatement();
								     String sqlssel1="select stockid from  my_srvd where rdocno='"+docno+"' group by stockid";
								     
								  
								     
								     ResultSet selrss1=selstmt1.executeQuery(sqlssel1);
								     
								     while(selrss1.next()) 
								     {
								    	 updatestockid=selrss1.getInt("stockid") ;
								    	 if(bachmethod>0)
								    	 {
								    		 String ssqlss="update my_prddin set  batch_no='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" ";
								    		 stmtpuchase.executeUpdate(ssqlss);
								    		 
								    		 String ssqlss2="update my_srvd set  BATCHNO='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
								    		 stmtpuchase.executeUpdate(ssqlss2);
								    	 }
								    	 
								    	 if(expmethod>0) 
								    	 { 
								    		
								    		 String ssqlss1="update my_prddin set  exp_date='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" ";
								    		 stmtpuchase.executeUpdate(ssqlss1); 
								    		 
								    		 String ssqlss3="update my_srvd set  bExpiry='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
								    		 stmtpuchase.executeUpdate(ssqlss3);
								    		 
								    		 
								    	 }
								    	 
								    	 
								 	 
								     } 
							     
							     }
							    
							     
							     
							     
			 }
			     
			     
			     
			     
			     
		 
			     
			     
			     
				     
				     }
			
 
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
		     String sql1="INSERT INTO my_srvser(srno,qty,desc1,unitprice,total,discount,nettotal,srvtaxper,srvtaxamount,brhid,rdocno,tr_no)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
				       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"','"+mastertr_no+"')";
			//  System.out.println("===sql1==="+sql1);
				     int resultSet2 = stmtpuchase.executeUpdate(sql1);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			

 

			for(int i=0;i< exparray.size();i++){
		    	
			     String[] singleexparray=exparray.get(i).split("::");
			     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO my_srvexp(srno,qty,descdocno,unitprice,total,discount,nettotal,acno,brhid,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(singleexparray[1].trim().equalsIgnoreCase("undefined") || singleexparray[1].trim().equalsIgnoreCase("NaN")|| singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()?0:singleexparray[1].trim())+"',"
				       + "'"+(singleexparray[2].trim().equalsIgnoreCase("undefined") || singleexparray[2].trim().equalsIgnoreCase("NaN")|| singleexparray[2].trim().equalsIgnoreCase("")|| singleexparray[2].isEmpty()?0:singleexparray[2].trim())+"',"
				       + "'"+(singleexparray[3].trim().equalsIgnoreCase("undefined") || singleexparray[3].trim().equalsIgnoreCase("NaN")||singleexparray[3].trim().equalsIgnoreCase("")|| singleexparray[3].isEmpty()?0:singleexparray[3].trim())+"',"
				       + "'"+(singleexparray[4].trim().equalsIgnoreCase("undefined") || singleexparray[4].trim().equalsIgnoreCase("NaN")||singleexparray[4].trim().equalsIgnoreCase("")|| singleexparray[4].isEmpty()?0:singleexparray[4].trim())+"',"
				       + "'"+(singleexparray[5].trim().equalsIgnoreCase("undefined") || singleexparray[5].trim().equalsIgnoreCase("NaN")||singleexparray[5].trim().equalsIgnoreCase("")|| singleexparray[5].isEmpty()?0:singleexparray[5].trim())+"',"
				       + "'"+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"',"
				       + "'"+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+mastertr_no+"','"+docno+"')";
		//  System.out.println("===sql==="+sql);
				     int resultSet2 = stmtpuchase.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			double stkvalue=0;
			     String sqls="select sum(op_qty*cost_price) stkvalue from my_prddin where tr_no="+mastertr_no+" " ;
			 	ResultSet sfocs=stmtpuchase.executeQuery(sqls);
				
				if(sfocs.next())
				{
					stkvalue=sfocs.getDouble("stkvalue");
				 
					 
				}
				
				if(reftype.equalsIgnoreCase("GRN"))
				{
					
				     String sqls1="select sum(op_qty*cost_price) stkvalue from my_prddin where invno="+docno+" " ;
					 	ResultSet sfocs1=stmtpuchase.executeQuery(sqls1);
						
						if(sfocs1.next())
						{
							stkvalue=sfocs1.getDouble("stkvalue");
						 
							 
						}
				}
				
			// jv entry pass
			
					String invdates="";
			String sqldate="SELECT DATE_FORMAT('"+invdate+"', '%d-%m-%Y') dates";
			ResultSet rsssss=stmt1.executeQuery(sqldate);
			if(rsssss.first())
			{
				invdates=rsssss.getString("dates");
			}
			
			String descs=""+invno+""+" - DT :- "+invdates+" - "+purdesc; 
			
			String refdetails=invno;
			
 
			 
		  	Statement stmt = conn.createStatement(); 	 
		 
		  int	venderaccount=vendocno;
		 
	      
		 
		 String vendorcur="1"; 
		 double venrate=1;
		 
		 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
			//System.out.println("---1----sqls10----"+sqls10) ;
		   ResultSet tass11 = stmt.executeQuery (sqls10);
		   if(tass11.next()) {
		
			   vendorcur=tass11.getString("curid");	
			 
				
		        }
		 
		 
	     String currencytype="";
	     String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
	        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
	     //System.out.println("-----2--sqlss----"+sqlss) ;
	     ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);
	         
	      while (resultSet33.next()) {
	    	  venrate=resultSet33.getDouble("rate");
	     currencytype=resultSet33.getString("type");
	                      }
	      double	dramount=0;
	     
	   double   updtax=0;
	   updtax=stval+descgridtax;
		   if(cmbbilltype==1)
		   {
		    	dramount=(netTotaldown+roundOf+updtax+servnettotal)*-1;
		    	dramount=ClsCommon.Round(dramount, 2);
		   }
		   else
		   {
				dramount=(netTotaldown+roundOf+servnettotal)*-1;
				dramount=ClsCommon.Round(dramount, 2);
		   }
		   double ldramount=0;
		   if(currencytype.equalsIgnoreCase("D"))
		   {
		   
           	
           	ldramount=dramount/venrate ;  
           	ldramount=ClsCommon.Round(ldramount, 2);
		   }
		   
		   else
		   {
			    ldramount=dramount*venrate ; 
			    ldramount=ClsCommon.Round(ldramount, 2);
		   }
		   

		
		 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
		   	//System.out.println("--sql1111111111111111111111111111111110----"+sql1);
		 int ss = stmt.executeUpdate(sql1);

	     if(ss<=0)
			{
				conn.close();
				return 0;
				
			}
	     String expcurrid="1"; 
	     double exprate=1;
			for(int i=0;i< exparray.size();i++){
		    	
			     String[] singleexparray=exparray.get(i).split("::");
			     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
			     {
			    	 
			    String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
			    String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 
			    
			    String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
			   ResultSet rsexp = stmt.executeQuery (sqlsexp);
			   if(rsexp.next()) {
			
				   expcurrid=rsexp.getString("curid");	
				 
					
			        }
			 
			 
		     String expcurrencytype="";
		     String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
		        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
		     //System.out.println("-----2--sqlss----"+sqlss) ;
		     ResultSet rsexpx = stmt.executeQuery(sqlexpselect);
		         
		      while (rsexpx.next()) {
		    	  
		    	          exprate=rsexpx.getDouble("rate");
		    	          expcurrencytype=rsexpx.getString("type");
		                      
		                            }
		   
			   double	expdramount=Double.parseDouble(exptotaldramounts)*-1; 
			   expdramount=ClsCommon.Round(expdramount, 2);
				 
			   double expldramount=0;
			   if(expcurrencytype.equalsIgnoreCase("D"))
			   {
			   
	           	
				   expldramount=expdramount/exprate;
				   expldramount=ClsCommon.Round(expldramount, 2);
			   }
			   
			   else
			   {
				   expldramount=expdramount*exprate; 
				   expldramount=ClsCommon.Round(expldramount, 2);
			   }
			   

			
			 String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,-1,3,0,0,0,'"+exprate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
		     
			   	//System.out.println("--sql11----"+sql1s);
			 int sss = stmt.executeUpdate(sql1s);

		     if(sss<=0)
				{
					conn.close();
					return 0;
					
				}
		     
			    
			    
			     }
			     
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
			// System.out.println("-----6--sqlveh----"+sqlveh) ;
				     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
				         
				      while (resultSet44.next()) {
				    	  rates=resultSet44.getDouble("rate");
				    	 // System.out.println("rates======="+rates);
				      currencytype1=resultSet44.getString("type");
				                 } 
			 
				      double pricetottal=stkvalue;  
				      pricetottal=ClsCommon.Round(pricetottal, 2);
				      //System.out.println("pricetottal=============="+pricetottal);
				      double ldramounts=0 ;     
				      if(currencytype1.equalsIgnoreCase("D"))
				      {
				      
		                   ldramounts=pricetottal/venrate ;
		                   ldramounts=ClsCommon.Round(ldramounts, 2);
		   	           	//System.out.println("ifldramounts=============="+ldramounts);
				      }
				      
				      else
				      {
				    	   ldramounts=pricetottal*venrate ;
				    	   ldramounts=ClsCommon.Round(ldramounts, 2);
		   	           //	System.out.println("elseldramounts=============="+ldramounts);
				      }
	     
		 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
	     
		 //System.out.println("---sql112----"+sql11) ; 
	 
			 int ss1 = stmt.executeUpdate(sql11);

		     if(ss1<=0)
				{
					conn.close();
					return 0;
					
				}
		     
		     
		     
		     
		     
		     //tax 
		     
		     
		     
		     
		     
		     
		     
		     
		     
		     
		     if(taxmethod>0)
				{
					
		    	 double taxtotals=0;
		    	 
		    	 
		    	 String sqlsss="select sum(taxamount) taxamount  from my_srvd where rdocno= "+docno+" ";
					
		    	 ResultSet mrs= stmt.executeQuery (sqlsss);
		    	 if(mrs.next())
		    	 {
		    		 
		    		 taxtotals=mrs.getDouble("taxamount");
		    		 
		    	 }
		    		 
		    		 
		    	 nettax=taxtotals;
		    	 stval=taxtotals;
		    	 
		    	 
		      	 if(cmbbilltype==1)
			    	 
		    	 {
					
					//client part

					String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet tax1sql = stmt.executeQuery (ggg);
					if(tax1sql.next()) {

						vendorcur=tax1sql.getString("curid");	


					}

  
					String taxcurrencytype1="";
					String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//	 System.out.println("-----2--dddd----"+dddd) ;
					ResultSet resultSet = stmt.executeQuery(dddd);

					while (resultSet.next()) {
						venrate=resultSet.getDouble("rate");
						taxcurrencytype1=resultSet.getString("type");
					}

					double	dramounts=nettax*-1; 


					double ldramountss=0;
					if(taxcurrencytype1.equalsIgnoreCase("D"))
					{


						ldramountss=dramounts/venrate ;  
					}

					else
					{
						ldramountss=dramounts*venrate ;  
					}



		/*			String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
*/
					//	System.out.println("--sql1----"+sql1);
					

	/*				String rdse="update   my_jvtran set  dramount=dramount+"+dramounts+",ldramount=ldramount+"+ldramountss+" where tr_no="+mastertr_no+" and acno="+venderaccount+"   ";
				 
					
					int ss1111 = stmt.executeUpdate(rdse);

					if(ss1111<=0)
					{
						 conn.close();
						return 0;

					}
					
					*/
					
					
					
					
					
					
					
					
					// total tax amount  int stacno=0;
					
					int divdval=1;
					if(stacno1>0)
					{
						divdval=2;
					}
					
					
				//	System.out.println("=========================stacno===================================="+stacno);
					
					
					String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet t1sql1 = stmt.executeQuery(lll);
					if(t1sql1.next()) {

						vendorcur=t1sql1.getString("curid");	


					}

  
					String taxcurre="";
					String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//	 System.out.println("-----2--ppp----"+ppp) ;
					ResultSet r1 = stmt.executeQuery(ppp);

					while (r1.next()) {
						venrate=r1.getDouble("rate");
						taxcurre=r1.getString("type");
					}

					double	dramt=0;
					dramt=(stval+descgridtax)/divdval;
					//System.out.println("stval==========="+stval);
					//System.out.println("descgridtax==========="+descgridtax);
					//System.out.println("dramt==========="+dramt);
					dramt=ClsCommon.Round(dramt, 2);
					


					double ldramt=0;
					if(taxcurre.equalsIgnoreCase("D"))
					{


						ldramt=dramt/venrate;
						ldramt=ClsCommon.Round(ldramt, 2);
						
					}

					else
					{
						ldramt=dramt*venrate; 
						ldramt=ClsCommon.Round(ldramt, 2);
					}



					String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//System.out.println("--sql13----"+sltax11);
					int aa = stmt.executeUpdate(sltax11);

					if(aa<=0)
					{
						conn.close();
						return 0;

					}
					
					// total tax amount  int stacno1=0;
					//stacno1
					
					
					 
					
					//System.out.println("=========================stacno1===================================="+stacno1);
					
					if(stacno1>0)
					{
					
					
					
						String llls1="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno1+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet t1sql1s1 = stmt.executeQuery(llls1);
						if(t1sql1s1.next()) {

						vendorcur=t1sql1s1.getString("curid");	


						}

 
						String taxcurres1="";
						String ppp1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						//System.out.println("-----2--ppp1----"+ppp1) ;
						ResultSet rs11 = stmt.executeQuery(ppp1);

						while (rs11.next()) {
						venrate=rs11.getDouble("rate");
						taxcurres1=rs11.getString("type");
							}

						double	dramts1=0;
						dramts1=(stval+descgridtax)/divdval; 
						//System.out.println("dramt==========="+dramts1);

						double ldramts1=0;
						if(taxcurres1.equalsIgnoreCase("D"))
						{


						ldramts1=dramts1/venrate;  
						}

						else
						{
						ldramts1=dramts1*venrate;  
						}



						String sltax11s1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//System.out.println("--sql14----"+sltax11s1);
						int aas1 = stmt.executeUpdate(sltax11s1);

						if(aas1<=0)
						{
							conn.close();
							return 0;

						}
					
					
					
					
					}
					
				}
					
		      	 
		      	 else if(cmbbilltype==2)
			    	 
		    	 {
		 
					int refaccno=0;
					int payaccno=0;
		      		 
		      		 
		      		Statement ssss10=conn.createStatement();		
					
			 
			 
					 String sqls111="select acno from gl_taxmaster where fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and type=1 and status=3   ";
			       //  System.out.println("====sqls111=== 1====="+sqls111);
			         ResultSet rstaxxx1011=ssss10.executeQuery(sqls111); 
			         if(rstaxxx1011.first())
			         {
			        	 refaccno=rstaxxx1011.getInt("acno");
			         }
 
					 String sqls1111="select acno from gl_taxmaster where fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and type=2 and status=3   ";
			        // System.out.println("====sqls1111====2===="+sqls1111);
			         ResultSet rstaxxx10111=ssss10.executeQuery(sqls1111); 
			         if(rstaxxx10111.first())
			         {
			        	 payaccno=rstaxxx10111.getInt("acno");
			         }
 
						 
						
						
					//	System.out.println("=========================stacno===================================="+stacno);
						
						
						String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+refaccno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet t1sql1 = stmt.executeQuery(lll);
						if(t1sql1.next()) {

							vendorcur=t1sql1.getString("curid");	


						}

	  
						String taxcurre="";
						String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					//	 System.out.println("-----2--ppp----"+ppp) ;
						ResultSet r1 = stmt.executeQuery(ppp);

						while (r1.next()) {
							venrate=r1.getDouble("rate");
							taxcurre=r1.getString("type");
						}

						double	dramt=0;
						dramt=stval+descgridtax; 


						double ldramt=0;
						if(taxcurre.equalsIgnoreCase("D"))
						{


							ldramt=dramt/venrate;  
						}

						else
						{
							ldramt=dramt*venrate;  
						}



						String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+refaccno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

							//System.out.println("--sql15----"+sltax11);
						int aa = stmt.executeUpdate(sltax11);

						if(aa<=0)
						{
							conn.close();
							return 0;

						}
						
						// total tax amount  int stacno1=0;
						//stacno1
						
						
						 
						
				 
						if(payaccno>0)
						{
						
						
						
							String llls1="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+payaccno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet t1sql1s1 = stmt.executeQuery(llls1);
							if(t1sql1s1.next()) {

							vendorcur=t1sql1s1.getString("curid");	


							}

	 
							String taxcurres1="";
							String ppp1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						//	System.out.println("-----2--ppp1----"+ppp1) ;
							ResultSet rs11 = stmt.executeQuery(ppp1);

							while (rs11.next()) {
							venrate=rs11.getDouble("rate");
							taxcurres1=rs11.getString("type");
								}

							double	dramts1=0;
							dramts1=(stval+descgridtax)*-1; 


							double ldramts1=0;
							if(taxcurres1.equalsIgnoreCase("D"))
							{


							ldramts1=dramts1/venrate;  
							}

							else
							{
							ldramts1=dramts1*venrate;  
							}



							String sltax11s1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+payaccno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

							//System.out.println("--sql16----"+sltax11s1);
							int aas1 = stmt.executeUpdate(sltax11s1);

							if(aas1<=0)
							{
								conn.close();
								return 0;

							}
						
						
						
						
						}
		    	 
		    	 }
					
					// tax1acno tax 1

					
				 
					
					
				/*	if(tax1acno>0)
					{
						System.out.println("=========================tax1acno===================================="+tax1acno);
						String tsqls="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax1acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tsqlsa = stmt.executeQuery(tsqls);
						if(tsqlsa.next()) {

							vendorcur=tsqlsa.getString("curid");	


						}

	     
						String taxcur="";
						String sqlvenslect111 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenslect111----"+sqlvenslect111) ;
						ResultSet r11 = stmt.executeQuery(sqlvenslect111);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur=r11.getString("type");
						}

						double	dramt1=tax1; 


						double ldramt1=0;
						if(taxcur.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String sqlax111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax1acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(sqlax111);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					if(tax2acno>0)
					{
						
						
						System.out.println("=========================tax2acno===================================="+tax2acno);
						
						
						String sqlstax10111="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax2acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql111 = stmt.executeQuery(sqlstax10111);
						if(tax1sql111.next()) {

							vendorcur=tax1sql111.getString("curid");	


						}

	     
						String taxcur1="";
						String gjjj = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--gjjj----"+gjjj) ;
						ResultSet r11 = stmt.executeQuery(gjjj);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur1=r11.getString("type");
						}

						double	dramt1=tax2; 


						double ldramt1=0;
						if(taxcur1.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String oops="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax2acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(oops);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					
					if(tax3acno>0)
					{
						System.out.println("=========================tax3acno===================================="+tax3acno);
						String pyy="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax3acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql1111 = stmt.executeQuery(pyy);
						if(tax1sql1111.next()) {

							vendorcur=tax1sql1111.getString("curid");	


						}

	     
						String taxcur2="";
						String ttt = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenselect----"+ttt) ;
						ResultSet r111 = stmt.executeQuery(ttt);

						while (r111.next()) {
							venrate=r111.getDouble("rate");
							taxcur2=r111.getString("type");
						}

						double	dramt1=tax3; 


						double ldramt1=0;
						if(taxcur2.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String eee="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax3acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(eee);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					 
					*/
					
					
				}
				
				
				
			//================================	
				
				
		     
		     
		     String clsql=" select cldocno from my_head where dtype='VND' and doc_no='"+venderaccount+"' ";
		     
		 //    System.out.println("========clsql=========="+clsql);
		    ResultSet clrs= stmt.executeQuery(clsql);
		    
		    int vndcldocno=0;
		    if(clrs.next())
		    {
		    	vndcldocno=clrs.getInt("cldocno");
		    }
		     
		     
		     if(vndcldocno>0)
		     {
		    	 
		    	String sql1ss="update my_jvtran set cldocno='"+vndcldocno+"'  where acno='"+venderaccount+"' and tr_no='"+mastertr_no+"' and status=3  ";
		    	
		    	// System.out.println("========usql1ss3=========="+sql1ss);
		    	stmt.executeUpdate(sql1ss);
		    	
		     }
		     
		     
		     
		     
		     
		     
		     
		     
		     
				double  rround=roundOf;
				if(rround>0 || rround<0)// less 0
				{
					int acnos3=0;
					String curris3="1";
					double rates3=1;

					String sql222="select  acno from my_account where codeno='ROUND OF ACCOUNT' ";
					ResultSet tass222 = stmt.executeQuery (sql222);
					if (tass222.next()) {
						acnos3=tass222.getInt("acno");		
					}

					String sqls33="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos3+"'";
					ResultSet tass33 = stmt.executeQuery (sqls33);
					if (tass33.next()) {
						curris3=tass33.getString("curid");	
					}
					
					String currencytype3="";
					String sqlveh3 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris3+"'";
					//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
					ResultSet resultSet3 = stmt.executeQuery(sqlveh3);
					while (resultSet3.next()) {
					double	rates2=resultSet3.getDouble("rate");
						currencytype3=resultSet3.getString("type");
					} 

					 
					double ldramounts3=0 ;     
					if(currencytype3.equalsIgnoreCase("D"))
					{
						ldramounts3=rround/venrate ;  
					}
					else
					{
						ldramounts3=rround*venrate ;  
					}
					
					int id1=1;
					if(ldramounts3>0)
					{
						id1=1;
					}
					else
					{
						id1=-1;
					}

					String sql13="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos3+"','"+descs+"','"+curris3+"','"+rates3+"',"+rround+","+ldramounts3+",0,"+id1+",3,0,0,0,'"+rates3+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
					 //System.out.println("---sqlround17----"+sql13) ; 
					int ss3 = stmt.executeUpdate(sql13);
					if(ss3<=0)
					{
						conn.close();
						return 0;
					}
				}

		     
		     
		     
		     
		     
		     //======================================================================
		     
		     double jvdramount=0;
		     int id=0;
		     int adjustacno=0;
		     
		     String adjustcurrid="1";
		     
		     
		     double adjustcurrate=1;
		     
			 String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+mastertr_no+"'";
			   //System.out.println("-----5--sqls3----"+sqls3) ;
			   ResultSet jvrs = stmt.executeQuery (jvselect);
				
				if (jvrs.next()) {
			
					jvdramount=jvrs.getDouble("dramount");	
					 
					
			              }
			//	 System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{
					
					
					if(jvdramount>0)
					{
						id=1;
							
						
					}
					
					else
					{
						
						id=-1;
					}
					
					
					
				     
					   String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					   //System.out.println("-----4--sql2----"+sql2) ;

				       ResultSet adjaccount = stmt.executeQuery (sqls2);
						
						if (adjaccount.next()) {
					
							adjustacno=adjaccount.getInt("acno");		
							
					        }
						
						
					
						 String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
						   //System.out.println("-----5--sqls3----"+sqls3) ;
						   ResultSet exptass3 = stmt.executeQuery (expsqls3);
							
							if (exptass3.next()) {
						
								adjustcurrid=exptass3.getString("curid");	
								 
								
						              }
							String adjustcurrencytype1="";
							 String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
							// System.out.println("---adjustsql----"+adjustsql) ;
								     ResultSet resultadj = stmt.executeQuery(adjustsql);
								         
								      while (resultadj.next()) {
								    	  adjustcurrate=resultadj.getDouble("rate");
								    	  adjustcurrencytype1=resultadj.getString("type");
								                 } 
								      
								      
								      double adjustldramounts=0 ;     
								      if(adjustcurrencytype1.equalsIgnoreCase("D"))
								      {
								      
								    	  adjustldramounts=jvdramount/adjustcurrate ;  
								      }
								      
								      else
								      {
								    	  adjustldramounts=jvdramount*adjustcurrate ;  
								      }
					
					
								      
								      
								      
								      String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
								     
								     
									 //System.out.println("---sql118----"+adjustsql11) ; 
								 
										 int result1 = stmt.executeUpdate(adjustsql11);

									     if(result1<=0)
											{
												conn.close();
												return 0;
												
											}
									     	      
					
					
					
				}	
				
				if(cosrcodemethod>0) 
				{
					
					String upcostsql1="update my_jvtran  set costtype='"+itermtype+"',costcode='"+costtrno+"' where tr_no="+mastertr_no+" ";
					stmt.executeUpdate(upcostsql1);
					
					  Statement sss1=conn.createStatement();
					   String delsql2="Delete from my_costtran where tr_no="+mastertr_no+" ";
					   sss1.executeUpdate(delsql2);
					 
					
					
					if(itermtype>0)
					{

						 int TRANIDs=0;
						 int sno=0;
                         int accounts=0;
					     double finalamt=0;  
					     Statement sss=conn.createStatement();
					     Statement stmtg=conn.createStatement();
					
							String trsqlss="  select j.tranid,j.acno,j.tr_no,dramount nettotal from my_jvtran j inner join my_head h on j.acno=h.doc_no where gr_type in (4,5) and  j.tr_no="+mastertr_no+"     ";
					
							ResultSet tass111 = sss.executeQuery (trsqlss);
							
							while (tass111.next()) {
								sno=sno+1;
								TRANIDs=tass111.getInt("tranid");	
								accounts=tass111.getInt("acno");	
								finalamt=tass111.getDouble("nettotal");	
										if(accounts>0)
										{
										String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
												+ " "+itermtype+","+finalamt+","+costtrno+","+TRANIDs+","+mastertr_no+")";
												 
								  int costabsq=  stmtg.executeUpdate(ssql);
								  
								  if(costabsq<=0)
									{
										conn.close();
										return 0;
										
									   }
										
								     }
							}
							
						
					}
					
				}
				
			/*for(int i=0;i< masterarray.size();i++){
		    	 
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     if(chkqty>0){
			    	 
			    	 
			    	 
						     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno)VALUES"
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
								      + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
								       +"'"+mastertr_no+"','"+docno+"')";
				                         System.out.println("-----insql-"+insql);
								     int resultSet2 = stmtpuchase.executeUpdate(insql);
		  //   System.out.println("444444444"+sql);
				 
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
				     
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
					  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     if(reftype.equalsIgnoreCase("GRN"))
			         {

					    	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
					    	  
				    	   
					     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
					    
						 
					    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
					    	 

						     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
							 String oldqtys=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
						    	
						   	  double oldqty=Double.parseDouble(oldqtys);
						   	  
					            System.out.println("-----oldqty---"+oldqty);
					    	  double currqty=Double.parseDouble(prddoutqty); 
						     
					    	   double balqty=0;
								 
					             int tr_no=0;
								double remqty=0;
								double out_qty=0;
									double qty=0;
				                    double grnout=0;
														
									double grnsaveqty=0; 
									double prddinsaveqty=0;
									 Statement stmt=conn.createStatement();
									 
				 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
			       				+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"'  "
			       						+ "and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
								+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
								    	 
						 
								    	 
						 
				                            System.out.println("-----strSql---"+strSql);
								    	 
								 
								    		ResultSet rs = stmt.executeQuery(strSql);
						     
				    		while(rs.next()) {
				    			 
				    			
				    			
										balqty=rs.getDouble("balstkqty");
										tr_no=rs.getInt("tr_no");
										out_qty=rs.getDouble("out_qty");

										//stockid=rs.getInt("stockid");
										qty=rs.getDouble("qty");
										grnout=rs.getDouble("grnout");
									System.out.println("---masterqty-----"+masterqty);	
									
									System.out.println("---grnout-----"+grnout);	
									System.out.println("---out_qty-----"+out_qty);	
				    	 
					       grnsaveqty=(currqty+grnout)-oldqty;
							
							System.out.println("-grnsaveqty---"+grnsaveqty);
							
							
							
                    
							
							String sqls="update my_grnd set out_qty="+grnsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
							

							System.out.println("--1---sqls---"+sqls);


							stmtpuchase.executeUpdate(sqls);
							
							
							prddinsaveqty=(currqty+out_qty)-oldqty;
							
							System.out.println("-prddinsaveqty---"+prddinsaveqty);
							
							
                         	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
							

							System.out.println("--1---prdinsqls---"+prdinsqls);


							stmtpuchase.executeUpdate(prdinsqls);
							
								
							String insertsql="update my_prddout set qty='"+prddoutqty+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stockid='"+stockid+"'";
							
							
							stmtpuchase.executeUpdate(insertsql);
							break;
				    	     
				   				     
				    		}
				     
				     }}}}*/
			
 
			
 
			
			/*for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
		     String sql1="INSERT INTO my_srvser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno,tr_no)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"','"+mastertr_no+"')";
			  System.out.println("===sql1==="+sql1);
				     int resultSet2 = stmtpuchase.executeUpdate(sql1);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			
*/
 
/*
			for(int i=0;i< exparray.size();i++){
		    	
			     String[] singleexparray=exparray.get(i).split("::");
			     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO my_srvexp(srno,qty,descdocno,unitprice,total,discount,nettotal,brhid,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(singleexparray[1].trim().equalsIgnoreCase("undefined") || singleexparray[1].trim().equalsIgnoreCase("NaN")|| singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()?0:singleexparray[1].trim())+"',"
				       + "'"+(singleexparray[2].trim().equalsIgnoreCase("undefined") || singleexparray[2].trim().equalsIgnoreCase("NaN")|| singleexparray[2].trim().equalsIgnoreCase("")|| singleexparray[2].isEmpty()?0:singleexparray[2].trim())+"',"
				       + "'"+(singleexparray[3].trim().equalsIgnoreCase("undefined") || singleexparray[3].trim().equalsIgnoreCase("NaN")||singleexparray[3].trim().equalsIgnoreCase("")|| singleexparray[3].isEmpty()?0:singleexparray[3].trim())+"',"
				       + "'"+(singleexparray[4].trim().equalsIgnoreCase("undefined") || singleexparray[4].trim().equalsIgnoreCase("NaN")||singleexparray[4].trim().equalsIgnoreCase("")|| singleexparray[4].isEmpty()?0:singleexparray[4].trim())+"',"
				       + "'"+(singleexparray[5].trim().equalsIgnoreCase("undefined") || singleexparray[5].trim().equalsIgnoreCase("NaN")||singleexparray[5].trim().equalsIgnoreCase("")|| singleexparray[5].isEmpty()?0:singleexparray[5].trim())+"',"
				       + "'"+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+mastertr_no+"','"+docno+"')";
		  System.out.println("===sql==="+sql);
				     int resultSet2 = stmtpuchase.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }*/
				
				
				ArrayList<String> arr=new ArrayList<String>(); 
				ClsVatInsert ClsVatInsert=new ClsVatInsert();
				Statement newStatement=conn.createStatement();
				String selectsqls="select sum(coalesce(a.nettaxamount,0))+coalesce(sr.nettotal,0)+coalesce(ex.nettotal,0) nettaxamount, coalesce(if(sr.srvtaxper>0,(sr.nettotal-sr.srvtaxamount),0),0)+sum(coalesce(a.totma,0)) total1,sum(a.total2) total2,sum(a.total3) total3, sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, sum(a.total9) total9,sum(a.total10) total10,sum(coalesce(a.tax1,0))+coalesce(sr.srvtaxamount,0) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5, sum(a.tax6) tax6, sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 from (select  d.tr_no,m.typeid,d.nettotal+coalesce(d.taxamount,0) nettaxamount,if(m.typeid=1 and d.taxamount>0,d.nettotal,0) totma, if(m.typeid=2 or (m.typeid=1 and d.taxamount=0),d.nettotal,0) total2,if(m.typeid=3,d.nettotal,0) total3,if(m.typeid=4,d.nettotal,0) total4,if (m.typeid=5,d.nettotal,0) total5, if(m.typeid=6,d.nettotal,0) total6,if(m.typeid=7,d.nettotal,0) total7, if(m.typeid=8,d.nettotal,0) total8,if(m.typeid=9,d.nettotal,0) total9, if(m.typeid=10,d.nettotal,0) total10, if(m.typeid=1,coalesce(d.taxamount,0),0) tax1,  if(m.typeid=2,coalesce(d.taxamount,0),0) tax2, if(m.typeid=3,coalesce(d.taxamount,0),0) tax3,  if(m.typeid=4,coalesce(d.taxamount,0),0) tax4, if(m.typeid=5,coalesce(d.taxamount,0),0) tax5,  if(m.typeid=6,coalesce(d.taxamount,0),0) tax6, if(m.typeid=7,coalesce(d.taxamount,0),0) tax7,  if(m.typeid=8,coalesce(d.taxamount,0),0) tax8, if(m.typeid=9,coalesce(d.taxamount,0),0) tax9,  if(m.typeid=10,coalesce(d.taxamount,0),0) tax10  from my_srvd d left join my_main m on m.psrno=d.psrno "
						+ "where d.tr_no="+mastertr_no+" ) a left join my_srvser sr on a.tr_no=sr.tr_no left join my_srvexp ex on sr.tr_no=ex.tr_no " ;
			
				System.out.println("=ABC=="+selectsqls);
				ResultSet rss101=newStatement.executeQuery(selectsqls);
				if(rss101.first())
					{
					arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
							rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
							rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
							rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
							rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
							rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
							rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
					}
				
					int result=ClsVatInsert.vatinsert(1,1,conn,mastertr_no,venderaccount,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),invno,cmbbilltype,arr,mode)	;
						if(result==0)	
					        {
							 
							conn.close();
							return docno;
							}
				if(cmbbilltype==2)
					{
					int result1=ClsVatInsert.vatinsert(2,2,conn,mastertr_no,venderaccount,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),invno,cmbbilltype,arr,mode)	;
						if(result1==0)	
							{
							 
							conn.close();
							return docno;
							}
					}
				
			

			}
			
			Statement ss=conn.createStatement();
		double vals=0;	
	String sqlsssss="select coalesce(i.cost_price,0) cs from my_srvd d left join my_prddin i on i.stockid=d.stockid where d.rdocno='"+docno+"' and  coalesce(i.cost_price,0)=0 ";
	ResultSet rsss111=ss.executeQuery(sqlsssss);
			
	if(rsss111.first())
	{
		vals=1;
	}
	
	if(vals==1)
	{
		conn.close();
		return 0;
	}
	
	
			if (docno > 0) {
				
				 
				conn.commit();
				stmtpuchase.close();
				conn.close();
				return docno;
			}
		}   catch(Exception e){	
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
			 
			 CallableStatement stmtpuchase= conn.prepareCall("{call tr_PurchaseinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchase.setInt(20,masterdoc_no);
			stmtpuchase.setInt(24, 0);
 
			stmtpuchase.setDate(1,null);
			stmtpuchase.setDate(2,null);
			stmtpuchase.setString(3,null);
			stmtpuchase.setInt(4,0);
		   	stmtpuchase.setInt(5,0);
			stmtpuchase.setDouble(6,0);
			stmtpuchase.setString(7,null); 
			stmtpuchase.setString(8,null);
			stmtpuchase.setString(9,null);
			stmtpuchase.setDouble(10,0);
			stmtpuchase.setDouble(11,0);
			stmtpuchase.setDouble(12,0);
			stmtpuchase.setDouble(13,0);
			stmtpuchase.setDouble(14,0);
			stmtpuchase.setDouble(15,0);
			stmtpuchase.setDouble(16,0);
			stmtpuchase.setString(17,session.getAttribute("USERID").toString());
			stmtpuchase.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpuchase.setString(21,formdetailcode);
			stmtpuchase.setString(22,mode);
			stmtpuchase.setInt(23,0);
			stmtpuchase.setString(25,"0");
			stmtpuchase.setString(26,"0");
			stmtpuchase.setDouble(27,0);
			stmtpuchase.setDouble(28,0);
		    int res=stmtpuchase.executeUpdate();
			docno=stmtpuchase.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if (res > 0) {
			 
				stmtpuchase.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	}








 
	
	

	public   JSONArray searchProduct(HttpSession session,String dates,String cmbbilltype,String acno,String prdname,
			String brandname,String gridunit,String gridprdname,String category, String subcategory,String id) throws SQLException {

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
				
				int method=0;
				
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
				
				java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
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
						
				/*		
					joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
						
						
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'   and type=1  and if(1="+cmbbilltype+",per,cstper)>0 group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
					
					}
					
				}
				
				
				int superseding=0;
				String chk1="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
				{
					
					superseding=rs1.getInt("method");
				}
						
				if(superseding==1)
				{
					String sql=" select s.part_no,m.* from (  select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "   left join my_desc de on(de.psrno=m.doc_no)   "
							+joinsql+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
							+"    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ) "
						    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
					
//					System.out.println("-----main 1---"+sql);
		 
						ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();	
				}
				else
				{
					// left join my_desc de on(de.psrno=m.doc_no) and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'
					String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+joinsql+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
							+"    where m.status=3  "+condtn;
				
					
				//System.out.println("-----sql---"+sql);
		 
						ResultSet resultSet = stmtVeh.executeQuery (sql);
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
	
	
	
	

	public   JSONArray searchreqProduct(String reqmasterdocno,HttpSession session,String dtype,String dates,String cmbbilltype,String acno,
			String prdname,String brandname,String gridunit,String gridprdname,String category, String subcategory,String id) throws SQLException { 

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
		    String brhid=session.getAttribute("BRANCHID").toString();
		    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
	     	
				
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
//				System.out.println("---condn--"+condtn);
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
				
				 java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
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
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1  and if(1="+cmbbilltype+",per,cstper)>0 group by typeid  ) t1 on "
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
					joinsqls=",rd.unitid,rd.specno ";
					
				}
				
				
				if(dtype.equalsIgnoreCase("GRN"))
				{
				
				String sqls="select  "+fsql+" "+method+" method ,bd.brandname, d.stockid, at.mspecno as specid ,d.qty-d.out_qty,m.part_no,m.productname,m.doc_no,u.unit,d.unitid munit,m.psrno, "
						+ " sum(d.qty-d.out_qty)  qty,0 pqty,  sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,d.amount unitprice,d.amount*sum(d.qty-d.out_qty) total, "
						+ " d.amount*sum(d.qty-d.out_qty)* d.disper/100 discount, d.disper, (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) nettotal "
						+ " from my_grnm m1 left join my_grnd d on d.tr_no=m1.tr_no left join my_main m  on d.prdid=m.doc_no left join my_unitm u  "
						+ " on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "+joinsql
						+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
						+ " where  m1.status=3 and m1.brhid='"+brhid+"' "
						+ " and m1.doc_no in ("+reqmasterdocno+") "+condtn+" group by d.stockid having sum(d.qty-d.out_qty)>0";
				
			    ResultSet resultSet = stmtVeh.executeQuery (sqls);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				else if(dtype.equalsIgnoreCase("PO"))
				{
					
					String sqls="select "+fsql+" "+method+" method,bd.brandname,at.mspecno as specid ,rd.rowno,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,rd.unitid munit,m.psrno, "
							+ " coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qty,coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval, "
							+ " coalesce(sum(rd.out_qty),0) pqty, coalesce(sum(rd.qty-rd.out_qty),0) saveqty ,"
							+ "  rd.amount unitprice, "
							+ " (coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0))*rd.amount*rd.disper/100 discount,rd.disper , "
							+ " ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal, "
							+ " sum(rd.qty-rd.out_qty)*rd.amount total ,rd.disper orderdiscper,rd.amount orderamount "
							+ "  from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no  left join my_grnd d on m1.tr_no=d.tr_no  "
							+ " left join my_main m  on rd.prdid=m.doc_no left join my_unitm u on rd.unitid=u.doc_no left join my_prodattrib at  "
							+ "  on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  "+joinsql
							+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
							+"  where  rd.clstatus=0 and m1.brhid='"+brhid+"' and m1.status=3 and  rd.tr_no in ("+reqmasterdocno+")  "
						 	+ " and rd.qty-rd.out_qty>0 and rd.clstatus=0 "+condtn+" group by rd.prdid"+joinsqls+",rd.amount,rd.disper  order by rd.prdid,rd.rowno ";
					
					ResultSet resultSet = stmtVeh.executeQuery (sqls);
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
	
	
	
	
	
	
 
	
	public   JSONArray reloadserv(String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice unitprice1,qty qty1,total total1,discount discount1,srvtaxper,srvtaxamount,nettotal nettotal1 from my_srvser  where rdocno='"+doc+"' ");
	      //	System.out.println("========"+pySql);
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
	public   JSONArray searchProduct(HttpSession session,String dates,String cmbbilltype,String acno) throws SQLException {

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
	     	
				int method=0;
				
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
				
				java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
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
						
						
			/*		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'   and type=1  and if(1="+cmbbilltype+",per,per)>0 group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.per else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";	
					}
					
				}
				
				
				int joinchk=0;
				Statement stmt322 = conn.createStatement (); 
			 
				String chk31111="select method  from gl_prdconfig where field_nme='prdjoinchk' ";
				ResultSet rss3111=stmt322.executeQuery(chk31111); 
				if(rss3111.next())
				{

					joinchk=rss3111.getInt("method");
				}
				
				
			   	int superseding=0;
					String chk11="select method  from gl_prdconfig where field_nme='superseding'";
					ResultSet rs11=stmtVeh.executeQuery(chk11); 
					if(rs11.next())
					{
						
						superseding=rs11.getInt("method");
					}
					String sql001="";	
					String sql002="";	
					if(superseding==1)
					{
						
						sql001= " select s.part_no,m.* from (  ";
						sql002= "  ) "
							    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority ";
					 
					}
				   	
				
				
				String sqjoin1="";		
				String sqjoin2="";
				
				if(joinchk>0)
				{
					sqjoin1 = " left join my_desc de on(de.psrno=m.doc_no)";
					sqjoin2 =  " and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ";
				}
				
			String sql=""+sql001+" select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ "   "+sqjoin1+"   "+joinsql+"    where m.status=3 "+sqjoin2+" "+sql002+" ";
//		System.out.println("-----sql---"+sql); 

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
				


				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,aa.taxamount netamount,m.description desc1 from "
	        			+ " my_srvm m left join my_head h on h.doc_no=m.acno left join(select sum(taxamount+nettotal) taxamount,rdocno  from my_srvd  group by rdocno) aa  on aa.rdocno=m.doc_no   where m.status=3 and m.brhid='"+brcid+"' "+sqltest );
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








	public       ClspurchaseinvoiceBean getViewDetails(int masterdoc_no) throws SQLException {
	
		ClspurchaseinvoiceBean showBean = new ClspurchaseinvoiceBean();
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
		
		
		String sqls="select "+sq1+" m.billtype,m.totaltax,m.tax1,m.tax2,m.tax3,m.nettotaltax , m.exptotal,m.rdtype,if(m.rdtype='PO',m.rrefno,if(m.rdtype='GRN',m.rrefno,'')) rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,aa.taxamount+m.roundVal netAmount,m.supplExp,aa.taxamount+m.roundVal+m.supplExp+m.exptotal nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate,m.locid,m.refinvDate,m.refInvNo,l.loc_name   \r\n" + 
				" from my_srvm m  left join(select sum(taxamount+nettotal) taxamount,rdocno  from my_srvd   group by rdocno) aa  on aa.rdocno=m.doc_no  left join my_head h on h.doc_no=m.acno  "+jsq1+" left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+masterdoc_no+"' ";
		
		
		
		//System.out.println("----asdfghjjjhfdc------"+sqls);
		
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		String dtype="0";
		String reqdoc="0";
		while (resultSet.next()) {
		
			
			
			
			showBean.setDocno(resultSet.getInt("voc_no"));
			
			showBean.setSt(resultSet.getDouble("totaltax")); 
			showBean.setTaxontax1(resultSet.getDouble("tax1"));
			showBean.setTaxontax2(resultSet.getDouble("tax2"));
			showBean.setTaxontax3(resultSet.getDouble("tax3"));
			showBean.setTaxtotal(resultSet.getDouble("nettotaltax"));
			showBean.setCmbbilltype(resultSet.getInt("billtype"));
			
			
			
			showBean.setMasterdate(resultSet.getString("date"));
			showBean.setDeliverydate(resultSet.getString("deldate"));
			showBean.setDelterms(resultSet.getString("delterms"));
			showBean.setPayterms(resultSet.getString("payterms"));
			showBean.setPurdesc(resultSet.getString("description"));
			
			showBean.setReqmasterdocno(resultSet.getString("rrefno"));
			
			showBean.setInvdate(resultSet.getString("refinvDate"));
			showBean.setInvno(resultSet.getString("refInvNo"));
	        showBean.setTxtlocation(resultSet.getString("loc_name"));
			
			showBean.setTxtlocationid(resultSet.getInt("locid"));
		 
			
			
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
			showBean.setExpencenettotal(resultSet.getDouble("exptotal"));
			
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
		if(dtype.equalsIgnoreCase("GRN"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_grnm where doc_no in ("+reqdoc+")";
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
		
		
		else if(dtype.equalsIgnoreCase("PO"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_ordm where doc_no in ("+reqdoc+")";
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



	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String headacccode,String reftype) throws SQLException {

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
					
					
					
	  /*      	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk'   from my_reqm m    where m.status=3 and m.brhid='"+brcid+"'" );*/
	        	if(reftype.equalsIgnoreCase("GRN"))
	        	{
	        	
					String pySql=("select * from (select "+sq1+" sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk',m.deldate,m.delterms,m.payterms  "
							+ "  from my_grnm m  left join    	my_grnd d on d.tr_no=m.tr_no "+jsq1+"  "
							+ "	 where m.status=3 and m.acno="+headacccode+"  and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
					//System.out.println("========"+pySql);
					
					ResultSet resultSet = stmtmain.executeQuery(pySql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet); 
	        	}
	        	
	        	else if(reftype.equalsIgnoreCase("PO"))
	        	{
	        		
					String pySql=("select * from (select "+sq1+" sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk',m.deldate,m.delterms,m.payterms "
							+ "  from my_ordm m  left join    	my_ordd d on d.tr_no=m.tr_no  "+jsq1+" "
							+ "	 where m.status=3 and m.acno="+headacccode+" and d.clstatus=0 and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
	        	 
					
				 //	System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
	        	}
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

	public   JSONArray reqgridreload(String doc,String from,HttpSession session,String search,String dates,String cmbbilltype,String acno) throws SQLException {
		 
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
		 
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();      
				String pySql="";
				if(from.equalsIgnoreCase("pro"))  
				{
					
					java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
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
				//  System.out.println("===check======"+sqlss);
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
					String joinsqls1="";
					if(mulqty>0)
					{
					 
						joinsqls1=",d.unitid,d.specno ";
					}
						
					
					
					
				if(search.equalsIgnoreCase("GRN"))	
					
				{
					
			 pySql=("select  "+fsql+" bd.brandname,'pro' checktype ,d.stockid,at.mspecno specid,m.part_no productid,m.productname,"
			 		+ "m.part_no proid , "
						 		+ "  m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty, "
						 		+ " sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,d.amount unitprice,d.amount*sum(d.qty-d.out_qty)  "
						 		+ "  total,d.amount*sum(d.qty-d.out_qty)* d.disper/100 discount, d.disper discper, "
						 		+ " (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) nettotal from my_grnm mm  "
						 		+ " left join  my_grnd d on d.tr_no=mm.tr_no  left join my_main m on m.doc_no=d.prdId  "
						 		+ " left join my_unitm u on d.unitid=u.doc_no   left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						 		+ " "+joinsql+"  where  mm.doc_no in ("+doc+")    group by d.stockid having sum(d.qty-d.out_qty)>0");
					 
					// System.out.println("----pySql--GRN--"+pySql);
						 	
					 ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
				}
				else if(search.equalsIgnoreCase("PO"))	
					
				{
					
					 
					pySql="select   "+fsql+" bd.brandname,d.rowno refrowno, 'pro' checktype ,at.mspecno as specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n" + 
							"d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n" + 
							"sum(d.qty-d.out_qty) saveqty,d.amount orderamount,d.disper orderdiscper,\r\n" + 
							" d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, "
							+ " sum(d.qty-d.out_qty)*d.amount total from my_ordd d\r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no   "
							+ "  "+joinsql+"   where d.tr_no in ("+doc+") and  d.clstatus=0 group by d.prdid"+joinsqls1+",d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno ";
					 
				// System.out.println("----pySql--PO--"+pySql);
					 
						
						ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
					 
				}
				}
			/*	else
				{
	        	 pySql=("  select 'entry' checktype ,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty  qty,d.qty qutval,sum(d.qty) saveqty  from my_reqd d " + 
	        			"     left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no where d.tr_no in ("+doc+") ");
	        	
	        	
	        	
				System.out.println("----pySql----"+pySql);
				}
				
				*/
	
			 
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
		
	public   JSONArray reloadservs(String odocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice unitprice1,qty qty1,total total1,discount discount1,nettotal nettotal1 from my_ordser  where rdocno in ("+odocno+") ");
	 
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
	
	
	public   JSONArray maingridreload(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
				
				String sqltest="0";
				
				
				if(reftype.equalsIgnoreCase("GRN") || reftype.equalsIgnoreCase("PO"))
				
				
				
				{
					
					sqltest=reqdocno;
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
					joinsqls=",d.unitid,d.specno ";
					  joinsqls1=" and aa.unitid=d.unitid and  aa.specno=d.specno ";
					
				}
				
				if(reftype.equalsIgnoreCase("GRN") || reftype.equalsIgnoreCase("DIR") )
				{
				String pySql="select  din.batch_no,din.exp_date,bd.brandname,din.cost_price,d.foc,d.stockid,at.mspecno specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,  "
						+ " d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
						+ " 	u.unit, d.unitid unitdocno,d.qty,d.qty oldqty,(dd.qty-dd.out_qty)+d.qty qutval,dd.out_qty-d.qty pqty,d.qty saveqty, "
						+ " 	d.amount unitprice,d.total,d.discount,d.disper discper,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno from my_srvm m1  left join my_srvd d on m1.tr_no=d.tr_no  "
						+ " 	left join my_grnd dd on dd.stockid=d.stockid and dd.prdid=d.prdid and dd.specno=d.specno  "
						+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_prddin din   on din.stockid=d.stockid and din.prdid=d.prdid and din.specno=d.specno"
						+ "   where m1.doc_no='"+doc+"' group by d.stockid ";
				
				//System.out.println("=============maingridload=================="+pySql);
				
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else if(reftype.equalsIgnoreCase("PO"))
				{
					/*String pySql="select aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid, "
							+ "  m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
							+ " u.unit, d.unitid unitdocno,if(m1.rdtype='DIR',0,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty) qutval,  "
							+ " if(m1.rdtype='DIR',0,(sum(coalesce(aa.out_qty,0))-d.qty)) pqty,   if(m1.rdtype='DIR',0,sum(coalesce(aa.out_qty,0))) saveqty, "
							+ " d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid   from my_grnm m1  "
							+ " left join my_grnd d on m1.tr_no=d.tr_no   left join my_main m on m.doc_no=d.prdId  "
							+ "  left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ "  left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus from  my_ordd   where tr_no in ("+sqltest+") and  clstatus=0 ) aa "
							+ "  on aa.prdid=d.prdid and aa.amount=d.amount and aa.disper=d.disper  where m1.doc_no='"+doc+"'   and   if(m1.rdtype='DIR',0,aa.clstatus)=0 "
							+ "     group by d.prdid,aa.amount,aa.discount order by d.prdid,aa.rowno  ";
					
					*/// orderdiscper,orderamount BATCHNO,bExpiry 
					
					
					String pySql="select d.BATCHNO batch_no,bExpiry exp_date, bd.brandname,din.cost_price,aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid, "
							+ " m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
							+ " u.unit, d.unitid unitdocno,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty qutval, sum(coalesce(aa.out_qty,0))-d.qty pqty, "
							+ " sum(coalesce(aa.out_qty,0)) saveqty, d.qty,d.amount unitprice,d.total,d.discount,d.disper discper, "
							+ "  d.nettotal,d.prdid,aa.disper orderdiscper,aa.amount orderamount,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno "
							+ "    from my_srvm m1 left join my_srvd d on m1.tr_no=d.tr_no  left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no   left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no    "
							+ "  left join my_prddin din   on din.stockid=d.stockid and din.prdid=d.prdid and din.specno=d.specno "
							+ " left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno  from  my_ordd  "
							+ "  where tr_no in   ("+sqltest+")   and  clstatus=0 ) aa    on aa.prdid=d.prdid and aa.amount=d.amount  "
							+ "  and aa.disper=d.disper "+joinsqls1+" where  m1.doc_no='"+doc+"'      and   aa.clstatus=0     group by d.stockid"+joinsqls+";";
					
					
				//   System.out.println("gridcheck="+pySql);
					
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
				}
				
	 
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
	
	public   JSONArray calutationshowdata(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
				
			
				
				
		 
				
		 
				
				String pySql="select   (@cnt := @cnt + 1) AS sr_no,din.cost_price,din.cost_price*d.qty netcost_price,d.foc,d.stockid,at.mspecno specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,  "
						+ " d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
						+ " 	u.unit, d.unitid unitdocno,d.qty,d.qty oldqty,(dd.qty-dd.out_qty)+d.qty qutval,dd.out_qty-d.qty pqty,d.qty saveqty, "
						+ " 	d.amount unitprice,d.total,d.discount,d.disper discper,d.nettotal from my_srvm m1  left join my_srvd d on m1.tr_no=d.tr_no  "
						+ " 	left join my_grnd dd on dd.stockid=d.stockid and dd.prdid=d.prdid and dd.specno=d.specno  "
						+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_prddin din   on din.stockid=d.stockid "
						+ " and din.prdid=d.prdid and din.specno=d.specno ,(SELECT @cnt := 0) AS dummy"
						+ "   where m1.doc_no='"+doc+"' group by d.stockid ";
				
 
				
				
				
				
          //   System.out.println("---------pySql----"+pySql);
				
				
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
 
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
 
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

	
	
	
 
 
	
	
	public JSONArray payableaccount() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select h.Description accountname,h.account,p.acno headdocno,p.doc_no sr_no,p.desc1 from   my_purchexp p  "
					+ " left join  my_head h on p.acno=h.doc_no   where  p.status=3   order by p.doc_no ";
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
	
	


	
	
	
	
	public JSONArray expgridreload(String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();    //    descsrno  accountdono

			String sql="select h.Description accountname,h.account,p.acno accountdono,p.doc_no descsrno,p.desc1,s.qty qty2,s.unitprice unitprice2,s.total total2,s.discount discount2,s.nettotal nettotal2 from my_srvexp s "
					+ " left join my_purchexp p on p.doc_no=s.descdocno left join  my_head h on p.acno=h.doc_no where  s.rdocno='"+docno+"'";
		//System.out.println("===zxdfghjkl,mnbvcxcvkl;====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	 public     ClspurchaseinvoiceBean getPrint(int docno, HttpServletRequest request,String brhid) throws SQLException {
		 ClspurchaseinvoiceBean bean = new ClspurchaseinvoiceBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
 
				
/*				String resql=("select m.rdtype,if(m.rdtype='GRN',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct','Goods Receipt Note') type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper,m.refinvno,DATE_FORMAT(m.refinvdate,'%d.%m.%Y') AS refinvdate, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,round(m.exptotal,2) exptotal, l.loc_name, "
				+ " m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_srvm m left join my_head h on h.doc_no=m.acno left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");*/
				
			String resql="select coalesce(acc.tinno,'')cltinno,bh.tinno companytrno,format(round(sum(coalesce(d.total,0.0)),2),2) prdtotal,format(round(coalesce(s.srvtotal,0.0),2),2) srvtotal , "
					+" format(round(sum(coalesce(d.discount,0.0)),2)+coalesce(s.srcdiscount,0.0),2) prdsrvdiscount,format(round(sum(d.taxamount),2),2) taxamt, "
					+ "format(round(sum(coalesce(d.nettaxamount,0.0))+coalesce(s.srvnettotal,0.0),2),2) prdsrvnettot, round(sum(coalesce(d.nettaxamount,0.0))+coalesce(s.srvnettotal,0.0),2) wprdsrvnettot,"
					+ "coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob, l.loc_name,bh.tinno,"
					+" coalesce(acc.contactPerson,'') contactPerson,m.dtype,  m.rdtype,if(m.rdtype='PR',m.rrefno,'') rrefno,"
					+" case when m.rdtype='PO' then concat('Purchase Order - ',ord.voc_no) when m.rdtype='GRN'  then 'Goods Receipt Note'  else  'Direct' end as type,m.doc_no,m.voc_no,m.status,m.refno,"
					+" DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,acc.trnnumber,   h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,"
					+" m.disper, m.refinvno,DATE_FORMAT(m.refinvdate,'%d.%m.%Y') AS refinvdate, FORMAT(m.discount,2) discount,format(round(m.roundVal,2),2) roundVal,format(round(m.netAmount,2),2) netAmount,"
					+" round(m.nettotal,2) ordervalue2,format(round(m.nettotal,2),2) ordervalue,format(round(m.exptotal,2),2) exptotal,round(m.supplExp,2) supplExp,format(round(sum(d.nettotal),2),2) nettotal,  if(trim(m.delterms)!='',m.delterms,null)delterms,"
					+" if(trim(m.payterms)!='',m.payterms,null) payterms,  if(trim(m.description)!='',m.description,null)description,"
					+" DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate,  format(round(sum(d.taxamount),2),2) taxamt, round(sum(d.nettotal+coalesce(d.taxamount,0)),2) nettaxamount"
					+" from my_srvm m left join my_srvd d on m.tr_no=d.tr_no join my_head h on h.doc_no=m.acno left join my_ordm  ord on ord.doc_no=m.rrefno and m.rdtype='PO' "
					+" left join my_acbook acc on acc.cldocno=h.cldocno and acc.dtype='VND'  left join my_locm l on l.doc_no=m.locid "
					+ " left join (select rdocno,round(sum(coalesce(total,0.0)),2) srvtotal, "
					+ "	round(sum(coalesce(discount,0.0)),2) srcdiscount,round(sum(coalesce(nettotal,0.0)),2) srvnettotal "
					+ " from my_srvser where rdocno='"+docno+"') s on s.rdocno=m.doc_no "
					+" left join my_brch bh on bh.doc_no=m.brhid"
					+" where m.doc_no='"+docno+"'";
					
			//System.out.println("resql<<<<<"+resql);		
			
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){

				      bean.setCompanytrno(pintrs.getString("companytrno"));
			    	   bean.setTinno(pintrs.getString("cltinno"));
			    	  
					 bean.setAitsprdchrg(pintrs.getString("prdtotal"));
			    	   bean.setAitssrcchrg(pintrs.getString("srvtotal"));
			    	   bean.setAitsnetdiscount(pintrs.getString("prdsrvdiscount"));
			    	   bean.setAitstax(pintrs.getString("taxamt"));
			    	   bean.setAitsnettotal(pintrs.getString("prdsrvnettot"));
			    	   bean.setAitsnettotword(c.convertAmountToWords(pintrs.getString("wprdsrvnettot")));
			    	   


			    	    bean.setAttn(pintrs.getString("contactPerson"));
			    	    bean.setTel(pintrs.getString("per_mob"));
			    	    bean.setFax(pintrs.getString("fax1"));
			    	    bean.setEmail(pintrs.getString("mail1"));
			    	    bean.setWatermarks(pintrs.getString("status"));
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    bean.setLbltrnno(pintrs.getString("trnnumber"));
			    	    bean.setExpdeldate(pintrs.getString("deldate"));
			    	    bean.setLblinvno(pintrs.getString("refinvno"));
                        bean.setLblinvdate(pintrs.getString("refinvdate"));
			    	    bean.setLblloc(pintrs.getString("loc_name"));
			    	    bean.setLblbranchtrno(pintrs.getString("tinno"));
			      	    bean.setLbltotal(pintrs.getString("netAmount"));
						bean.setLbltotnetamnt(pintrs.getString("nettotal"));
						bean.setLblroundOf(pintrs.getString("roundVal"));
			      	    bean.setLbltax(pintrs.getString("taxamt"));
			      	    bean.setLblnetamount(pintrs.getString("nettaxamount"));
			      	    bean.setWordnetamount(c.convertAmountToWords(pintrs.getString("nettaxamount")));
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			            bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("ordervalue2")));
			    	    bean.setLblordervalue(pintrs.getString("ordervalue"));
			    	    bean.setLblnetTotaldown(pintrs.getString("netamount"));
			    	    bean.setLblexptotal(pintrs.getString("exptotal"));
			       }

				stmtprint.close();
				
Statement stmtinvoice11 = conn.createStatement ();
				
				String sql3 = " select u.user_name preparedby,date_format(ext0.apprdate,'%d-%m-%Y') preparedbydt,date_format(ext0.apprdate,'%H:%i:%s') preparedbyat,coalesce(u2.user_name, u1.user_name,'')  verifiedappr"
						+ " ,date_format(coalesce(ext1.apprdate,ext.apprdate),'%d-%m-%Y') verifybydt, date_format(coalesce(ext1.apprdate,ext.apprdate),'%H:%i:%s') verifybyat,coalesce(u3.user_name,'') approved ,"
						+ " date_format(ext2.apprdate,'%d-%m-%Y') approvedt, date_format(ext2.apprdate,'%H:%i:%s') approveat"
						+ " from my_srvm m"
						+ " left join my_exdet ext on (m.voc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprLEVEL=1)"
						+ " left join my_exdet ext0 on (m.voc_no=ext0.doc_no and m.dtype=ext0.dtype and ext0.apprLEVEL=0)"
						+ " left join my_exdet ext1 on (m.voc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprLEVEL=2)"
						+ " left join my_exdet ext2 on (m.voc_no=ext2.doc_no and m.dtype=ext2.dtype   and ext2.apprLEVEL=3)"
						+ " left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no"
						+ " left join my_user u2 on ext1.userid=u2.doc_no "
						+ " left join my_user u3 on ext2.userid=u3.doc_no   left join my_head h on h.doc_no=m.acno   where   m.doc_no="+docno+" ";
				//System.out.println("preparedby--"+sql3);
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
				    String  companysql="select coalesce(b.branchname,' ') branchname,c.company,c.address,c.tel,c.fax,coalesce(l.loc_name,' ') location from my_srvm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

			    //	System.out.println("company---"+companysql);
			        
			    	ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				       } 
				     stmt10.close();
				       
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper,"
				       		+ " round(d.taxamount,2) taxamt,round(d.taxper,2)taxper, round(d.nettotal+coalesce(d.taxamount,0),2) nettaxamount   from my_srvd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				   // System.out.println(">>>>>"+strSqldetail);  
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal")+"::"+rsdetail.getString("taxper")
						    +"::"+rsdetail.getString("taxamt")+"::"+rsdetail.getString("nettaxamount") ;
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
				       		+ " discount ,round(nettotal,2) nettotal,round(srvtaxper,2) srvtaxper,round(srvtaxamount,2) srvtaxamount from my_srvser     where rdocno='"+docno+"'";
					
			
					ResultSet rsdetail2=stmtgrid2.executeQuery(strSqldetail2);
					
					int rowcounts=1;
			
					while(rsdetail2.next()){

							 
							 
						temp2=rowcounts+"::"+rsdetail2.getString("description")+"::"+rsdetail2.getString("qty")+"::"+
							rsdetail2.getString("unitprice")+"::"+rsdetail2.getString("total")+"::"+rsdetail2.getString("discount")+"::"+
						    rsdetail2.getString("srvtaxper")+"::"+rsdetail2.getString("srvtaxamount")+"::"+rsdetail2.getString("nettotal");
							arr2.add(temp2);
							rowcounts++;
			
							bean.setSecarray(2);
							 
				          }
				             
					request.setAttribute("subdetails", arr2);
					stmtgrid2.close();
					 
					
					 
					 
				     ArrayList<String> arr3 =new ArrayList<String>();
				   	 Statement stmtgrid3 = conn.createStatement ();       
				     String temp3="";  
 	     		     
				     
				       String	strSqldetail3="select h.Description accountname,h.account,p.acno accountdono,p.doc_no descsrno,p.desc1,round(s.unitprice,2)  unitprice, "
				       		+ " round(s.qty,2) qty,round(s.total,2) total,round(s.discount,2)"
				       		+ " discount ,round(s.nettotal,2) nettotal from my_srvexp s left join my_purchexp p on p.doc_no=s.descdocno"
				       		+ "  left join  my_head h on p.acno=h.doc_no      where s.rdocno='"+docno+"'";
					
				    //   System.out.println("!!!!-"+strSqldetail3);
				       
					ResultSet rsdetail3=stmtgrid3.executeQuery(strSqldetail3);
					
					int rowcountss=1;
			
					while(rsdetail3.next()){

							 
							 
						temp3=rowcountss+"::"+rsdetail3.getString("desc1")+"::"+rsdetail3.getString("account")+"::"+
							rsdetail3.getString("accountname")+"::"+rsdetail3.getString("qty")+"::"+rsdetail3.getString("unitprice")+"::"+rsdetail3.getString("total")+"::"+rsdetail3.getString("discount")+"::"+
						    rsdetail3.getString("nettotal") ;
							arr3.add(temp3);
							rowcountss++;
			
							bean.setThirdarray(3);
						
				          }
				             
					request.setAttribute("subdetailsexp", arr3);
					stmtgrid3.close();
					    String termsquery="select distinct @s:=@s+1 as sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
			          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
			          		+ "where  tr.dtype='PIV' and tr.brhid='"+brhid+"' and tr.rdocno="+docno+" and tr.status=3 ) tr "
			          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
			          		+ "select '      *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
			          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
			          		+ "   tr.dtype='PIV' and tr.rdocno="+docno+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
			        	bean.setTermQry(termsquery);
			        	//System.out.println("!!======bean.getterms======"+termsquery);
			        	
			        	
			        	String productQuery="select @i:=@i+1 as srno,a.* from (Select round(d.taxper,2) taxper,round(d.taxamount,2)taxamount,round(d.nettaxamount,2) nettaxamount,d.specno specid ,m.part_no productid, "
					         		+ "m.productname, u.unit,round(d.qty,2) qty, round(d.amount,2) amount,round(d.total,2) total,"
					         		+ " round(d.discount,2) discount,round(d.nettotal,2) nettotal , "
					         		+ " round(d.disper,2) disper    from my_srvd d  left join my_main m on m.doc_no=d.prdId "
					         		+ "left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+docno+"') a,(select @i:=0) r;";
					    bean.setPrdQry(productQuery);
					    //System.out.println("!!=====bean.getprdqry======"+productQuery);	
					 
					        
					        Statement amout=conn.createStatement();
					String srvTablQry="select srno,desc1 description,round(unitprice,2) unitprice1,round(qty,2) qty1,round(total,2) total1, "
							+ "round(discount,2) discount1,round(nettotal,2) nettotal1,round(srvtaxper,2) srvtaxper,round(srvtaxamount,2) srvtaxamount from my_srvser where rdocno='"+docno+"';";
					
					bean.setSrvQyy(srvTablQry);
					//System.out.println("!!--srvqry--==="+srvTablQry);
					
					String nettotQry="select format(round(supplexp,2),2) subtotal,format(round(nettotal,2),2) nettotal   from my_srvm  where doc_no="+docno+";";
					ResultSet rsnettot=amout.executeQuery(nettotQry);
					//System.out.println("!!--nettotQry--==="+nettotQry);
					while(rsnettot.next()){
						bean.setSrvtotal(rsnettot.getString("subtotal"));
						bean.setNetAmountprint(rsnettot.getString("nettotal"));
						bean.setWordnetAmtPrint(c.convertAmountToWords(rsnettot.getString("nettotal").replace(",", "")));
					}
				//	System.out.println("subtotal="+bean.getSrvtotal()+"bean.setWordnetAmtPrint="+bean.getWordnetAmtPrint()+"bean.setWordnetAmtPrint="+bean.getWordnetAmtPrint());
				conn.close();



				
		}
		catch(Exception e){

			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
		
	
	}


	/* public     ClspurchaseinvoiceBean getPrint(int docno, HttpServletRequest request,String brhid) throws SQLException {
		 ClspurchaseinvoiceBean bean = new ClspurchaseinvoiceBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
 
				
				String resql=("select coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob, "
					+ " coalesce(acc.contactPerson,'') contactPerson,m.dtype, m.rdtype,if(m.rdtype='GRN',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct','Goods Receipt Note') type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper,m.refinvno,DATE_FORMAT(m.refinvdate,'%d.%m.%Y') AS refinvdate, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,round(m.exptotal,2) exptotal, l.loc_name, "
				+ " m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_srvm m left join my_head h on h.doc_no=m.acno left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");
				
				
				
				String resql="select coalesce(acc.mail1,'') mail1,  coalesce(acc.fax1,'') fax1,coalesce(acc.per_mob,'') per_mob, "
						+ " coalesce(acc.contactPerson,'') contactPerson,m.dtype,  m.rdtype,if(m.rdtype='PR',m.rrefno,'') rrefno, "
						+ "case when m.rdtype='PR' then 'Purchase Request' "
						+ "when m.rdtype='SOR'  then 'Sales Order'  when m.rdtype='RFQ' then 'Purchase Request For Quote'  else "
						+ " 'Direct' end as type,m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs, "
						+ "  h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, "
						+ " m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal, "
						+ "  m.prddiscount,if(trim(m.delterms)!='',m.delterms,null)delterms,if(trim(m.payterms)!='',m.payterms,null) payterms, "
						+ "  if(trim(m.description)!='',m.description,null)description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate "
						+ " from my_srvm m left join my_head h on h.doc_no=m.acno "
						+ "  left join my_acbook acc on acc.cldocno=h.cldocno and acc.dtype='VND'  where   m.doc_no='"+docno+"'";
						
				System.out.println("--resqlwwwww--"+resql); 
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	   
			    	   bean.setAttn(pintrs.getString("contactPerson"));
			    	    bean.setTel(pintrs.getString("per_mob"));
				    	   bean.setFax(pintrs.getString("fax1"));
1				    	   bean.setEmail(pintrs.getString("mail1"));
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    bean.setExpdeldate(pintrs.getString("deldate"));
			    	    
                        bean.setLblinvno(pintrs.getString("refinvno"));
                        bean.setLblinvdate(pintrs.getString("refinvdate"));
			    	    bean.setLblloc(pintrs.getString("loc_name"));
			        
			      	    bean.setLbltotal(pintrs.getString("netAmount"));
			      	  bean.setWordnetamount(c.convertAmountToWords(pintrs.getString("netAmount")));
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			    	    
			    	    bean.setLblsubtotalexp(pintrs.getString("exptotal"));
			    	    
			    	    
			            bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	     
			    	    
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    
			    	    
			    	    
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   
				    	   
				       } 
				     stmt10.close();
				       
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.
, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_srvd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") ;
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
				       		+ " discount ,round(nettotal,2) nettotal from my_srvser     where rdocno='"+docno+"'";
					
			
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
					 
					
					 
					 
				     ArrayList<String> arr3 =new ArrayList<String>();
				   	 Statement stmtgrid3 = conn.createStatement ();       
				     String temp3="";  
 	     		     
				     
				       String	strSqldetail3="select h.Description accountname,h.account,p.acno accountdono,p.doc_no descsrno,p.desc1,round(s.unitprice,2)  unitprice, "
				       		+ " round(s.qty,2) qty,round(s.total,2) total,round(s.discount,2)"
				       		+ " discount ,round(s.nettotal,2) nettotal from my_srvexp s left join my_purchexp p on p.doc_no=s.descdocno"
				       		+ "  left join  my_head h on p.acno=h.doc_no      where s.rdocno='"+docno+"'";
					
			
					ResultSet rsdetail3=stmtgrid3.executeQuery(strSqldetail3);
					
					int rowcountss=1;
			
					while(rsdetail3.next()){

							 
							 
						temp3=rowcountss+"::"+rsdetail3.getString("desc1")+"::"+rsdetail3.getString("account")+"::"+
							rsdetail3.getString("accountname")+"::"+rsdetail3.getString("qty")+"::"+rsdetail3.getString("unitprice")+"::"+rsdetail3.getString("total")+"::"+rsdetail3.getString("discount")+"::"+
						    rsdetail3.getString("nettotal") ;
							arr3.add(temp3);
							rowcountss++;
			
							bean.setThirdarray(3);
						
				          }
				             
					request.setAttribute("subdetailsexp", arr3);
					stmtgrid3.close();
					 	
					 String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
				          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
				          		+ "where  tr.dtype='PIV' and tr.brhid='"+brhid+"' and tr.rdocno="+docno+" and tr.status=3 ) tr "
				          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
				          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
				          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
				          		+ "   tr.dtype='PIV' and tr.rdocno="+docno+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
				        	bean.setTermQry(termsquery);
				        	System.out.println("=======bean.getterms======"+bean.getTermQry());
				        	 String productQuery="select @i:=@i+1 as srno,a.* from (Select d.specno specid ,m.part_no productid, "
						         		+ "m.productname, u.unit,round(d.qty,2) qty, round(d.amount,2) amount,round(d.total,2) total,"
						         		+ " round(d.discount,2) discount,round(d.nettotal,2) nettotal , "
						         		+ " round(d.disper,2) disper    from my_srvd d  left join my_main m on m.doc_no=d.prdId "
						         		+ "left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+docno+"') a,(select @i:=0) r;";
						        bean.setPrdQry(productQuery);
						        System.out.println("=======bean.getprdqry======"+bean.getPrdQry());	
						 Statement amout=conn.createStatement();
						String srvTablQry="select srno,desc1 description,round(unitprice,2) unitprice1,round(qty,2) qty1,round(total,2) total1, "
								+ "round(discount,2) discount1,round(nettotal,2) nettotal1 from my_srvser where rdocno='"+docno+"';";
					
						bean.setSrvQyy(srvTablQry);
						String nettotQry="select round(supplexp,2) subtotal,round(nettotal,2)nettotal   from my_srvm  where doc_no="+docno+";";
						ResultSet rsnettot=amout.executeQuery(nettotQry);
						while(rsnettot.next()){
							bean.setSrvtotal(rsnettot.getString("subtotal"));
							bean.setNetAmountprint(rsnettot.getString("nettotal"));
							bean.setWordnetAmtPrint(c.convertAmountToWords(rsnettot.getString("nettotal")));
						}
						System.out.println("subtotal="+bean.getSrvtotal()+"bean.setWordnetAmtPrint="+bean.getWordnetAmtPrint()+"bean.setWordnetAmtPrint="+bean.getWordnetAmtPrint());
					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 */
	
	
	public   JSONArray lastpurchaseSearch(HttpSession session,String psrno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt  = conn.createStatement ();  

			
			String pySql=("select  m.date,h.description,h.account,d.qty,d.amount unitprice,d.nettotal/d.qty netunitprice from my_srvm m "
        	+" left join my_head h on h.doc_no=m.acno left join my_srvd d on d.rdocno=m.doc_no where m.status<>7 and"
        	+ " d.psrno='"+psrno+"' and m.brhid='"+session.getAttribute("BRANCHID")+"' order by  m.date desc limit 5  ");
			// System.out.println("======pySql======="+pySql);
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
	
	public   JSONArray searchunit(String mode,String psrno) throws SQLException {
 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				 
				
				
        	String pySql=("   select u.unit doc_no,u.fr,m.unit from my_unit u left join my_unitm m on m.doc_no=u.unit where psrno='"+psrno+"';   "); 
 
	        	//System.out.println("=====pySql========"+pySql);
	        	
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
	
}
