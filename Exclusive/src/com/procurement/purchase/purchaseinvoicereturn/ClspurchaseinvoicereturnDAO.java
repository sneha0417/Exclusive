package com.procurement.purchase.purchaseinvoicereturn;

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
 
import com.common.ClsVatInsert;
 
public class ClspurchaseinvoicereturnDAO 


{
	
	

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	

	Connection conn;
	public int insert(Date masterdate, Date deldate, String refno, int vendocno, 
			int cmbcurr, double currate, String delterms, String payterms,
			String purdesc, double nettotal,  
			HttpSession session, String mode,  
			String formdetailcode, HttpServletRequest request, ArrayList <String> masterarray, String reftype,
			String rrefno, int locationid, double producttotal, double prddiscount, double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype) throws SQLException  {
		 
	 
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpuchasereturn= conn.prepareCall("{call tr_PurchaseinvoicereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchasereturn.registerOutParameter(19, java.sql.Types.INTEGER);
			stmtpuchasereturn.registerOutParameter(20, java.sql.Types.INTEGER);
 
			stmtpuchasereturn.setDate(1,masterdate);
			stmtpuchasereturn.setDate(2,deldate);
			stmtpuchasereturn.setString(3,refno);
			stmtpuchasereturn.setInt(4,vendocno);
		   	stmtpuchasereturn.setInt(5,cmbcurr);
			stmtpuchasereturn.setDouble(6,currate);
			stmtpuchasereturn.setString(7,delterms); 
			stmtpuchasereturn.setString(8,payterms);
			stmtpuchasereturn.setString(9,purdesc);
			stmtpuchasereturn.setDouble(10,nettotal);
  
			stmtpuchasereturn.setString(11,session.getAttribute("USERID").toString());
			stmtpuchasereturn.setString(12,session.getAttribute("BRANCHID").toString());
			stmtpuchasereturn.setString(13,session.getAttribute("COMPANYID").toString());
			
	 
			stmtpuchasereturn.setString(14,formdetailcode);
			stmtpuchasereturn.setString(15,mode);
 
			stmtpuchasereturn.setString(16,reftype);
			stmtpuchasereturn.setString(17,rrefno);
			 
			stmtpuchasereturn.setInt(18,locationid);
			 
			
			stmtpuchasereturn.setDouble(21,producttotal);
			stmtpuchasereturn.setDouble(22,prddiscount);
			  
			
			stmtpuchasereturn.executeQuery();
			docno=stmtpuchasereturn.getInt("docNo");
	 
			int vocno=stmtpuchasereturn.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			int mastertr_no=0;
			
			String passjv="";
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_srrm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
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
		/*	 int tax1acno=0;
			 int tax2acno=0;
			 int tax3acno=0;*/
			 
			 
			  if(taxmethod>0)
			  {
				  String sqltax1= " update my_srrm set totaltax='"+stval+"',tax1='0',tax2='0',tax3='0',"
				  		+ "nettotaltax='"+stval+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
				  
				  System.out.println("======sqltax1========="+sqltax1);
				  
				  stmt1.executeUpdate(sqltax1);
			
			  int prvdocno=0;
				 
				  Statement pv=conn.createStatement();
					
					String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
					
					System.out.println("=======dd========"+dd);
					
					
					ResultSet rs13=pv.executeQuery(dd); 
					if(rs13.next())
					{

						prvdocno=rs13.getInt("prvdocno");
					}
					System.out.println("======prvdocno========"+prvdocno);

					 
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

		  
				 
				 
			  
			  }
			 
			 
			
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     
		 
				     
				     if(chkqty>0){
			    	
				    	 
/*				    	 
						  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
								   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
								   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid
								   +" :: "+rows[i].oldqty+" :: "+rows[i].foc+" :: "+rows[i].oldfoc
								   +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"); */
				    	 String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				    	 
				    	 double gridnettotal=Double.parseDouble(gridnettotals);
				    	 
				    	 
				    	// System.out.println("--gridnettotal---"+gridnettotal);
				    	 
				    	 String psrnos=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
				    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
							 
				         double fr=1;
					     String slss=" select fr from my_unit where psrno="+psrnos+" and unit='"+unitids+"' ";
					     
					     System.out.println("====slss==="+slss);
					     ResultSet rv1=stmtpuchasereturn.executeQuery(slss);
					     if(rv1.next())
					     {
					    	 fr=rv1.getDouble("fr"); 
					     }
			    	 
				    	 
					     String insql="INSERT INTO my_srrd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,fr)VALUES"
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
							       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
							       +"'"+mastertr_no+"','"+docno+"' ,"
							       	+ "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")  || detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
								       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
								       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")  || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"+fr+")";
		           //  System.out.println("----"+insql);
                      
				     int resultSet2 = stmtpuchasereturn.executeUpdate(insql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				  
		               
				    // System.out.println("-reftype-----"+reftype);	 	
				    	 
				    	 
				    	 
				    	   if(reftype.equalsIgnoreCase("PIV"))
					         {	 
				    	
				    		   //System.out.println("--nouffffffffffff-----");	 	   
				 
				     passjv="passjv";
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
				     
				 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
			    	  
			    	   
				     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
				    
					 
				    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
				    	 

					   //  String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					     
				     
				  
					     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    
					     String  foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")|| detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";
					     double focqty=Double.parseDouble(foc);
				 
			     double paidqty=Double.parseDouble(paidqtyd);
					     
					     
					     System.out.println("--masterqty-----"+masterqty);
					     
					   //  System.out.println("--focqty-----"+focqty);
					     double totalordoutqty=paidqty+focqty; 
					  //  System.out.println("--totalordoutqty-----"+totalordoutqty);	 

					    
				    		 
					 	   double balqty=0;
							 
					 	  double foc_out=0;
							double remqty=0;
							double out_qty=0;
								double qty=0;
								
								double grnout=0;
								 double foc_outqty=0;
								
								double grnsaveqty=0; 
								double prddinsaveqty=0;
								int unitid=0;
								int spec=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				/*    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
									+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
									+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
	 */
				    	 
				    	int rownos=0; 
				    	
				    	String mastersql="select rowno from my_srvd where stockid="+stockid+" and psrno="+psrno+" ";
				    	ResultSet masterrs=stmt.executeQuery(mastersql);
				    	if(masterrs.first())
				    	{
				    		rownos=masterrs.getInt("rowno");
				    	}
				    	
				    			
				    	 
				    	 
				    	 String strSql="select  dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty)/sum(dd.fr) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/sum(dd.fr) balstkqty,sum(dd.out_qty)/sum(dd.fr) out_qty,date,sum(d.out_qty)  grnout,dd.unitid,dd.specno from my_prddin dd "
									+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"'    and dd.unitid="+unitids+" and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
									+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
	 
				          System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balstkqty");
								foc_out=rs.getInt("foc_out");
								out_qty=rs.getDouble("out_qty");

								//stockid=rs.getInt("stockid");
								qty=rs.getDouble("qty");
								grnout=rs.getDouble("grnout");
								unitid=rs.getInt("unitid");
								spec=rs.getInt("specno");
							
						//	System.out.println("---masterqty-----"+masterqty);	
							
							//System.out.println("---grnout-----"+grnout);	
							//System.out.println("---out_qty-----"+out_qty);	

								//System.out.println("---masterqty-----"+masterqty);	

							//	System.out.println("---balqty-----"+balqty);	

								//System.out.println("---out_qty-----"+out_qty);	
							//	System.out.println("---qty-----"+qty);



							if(masterqty<=balqty)
							{
								
								grnsaveqty=masterqty+grnout;
								foc_outqty=foc_out+focqty;
								String sqls="update my_srvd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
								
								

							 System.out.println("-main1---sqls---"+sqls);


								stmtpuchasereturn.executeUpdate(sqls);
								
								prddinsaveqty=(masterqty+focqty)+out_qty;
								String prdinsqls="update my_prddin set out_qty="+prddinsaveqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
                              //	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+",foc_out='"+foc_outqty+"' where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
								

								 System.out.println("--main1---prdinsqls---"+prdinsqls);

								stmtpuchasereturn.executeUpdate(prdinsqls);
								
		
									
								//String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,foc,date,brhid,locid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty+"','"+docno+"','"+prdid+"','"+focqty+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"')";
								String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
								stmtpuchasereturn.executeUpdate(insertsql);
								
							 	System.out.println("--main1--insertsql---"+insertsql);
								
								
 
								masterqty=0;
								
								break;


							}
							

							else if(masterqty>balqty)
							{
								masterqty=masterqty-balqty;
								grnsaveqty=balqty+grnout;
								foc_outqty=foc_out+focqty;
								String sqls="update my_srvd set out_qty=out_qty+"+balqty+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
								
								

								 System.out.println("--main2---sqls---"+sqls);


								stmtpuchasereturn.executeUpdate(sqls);
								
								prddinsaveqty=(masterqty+focqty)+out_qty;
								String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
                              //	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+",foc_out='"+foc_outqty+"' where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
								

								 System.out.println("--main2--prdinsqls---"+prdinsqls);

								stmtpuchasereturn.executeUpdate(prdinsqls);
								
		
									
								//String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,foc,date,brhid,locid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty+"','"+docno+"','"+prdid+"','"+focqty+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"')";
								String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+balqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
								stmtpuchasereturn.executeUpdate(insertsql);
								
							 	System.out.println("--main2--insertsql---"+insertsql);
								
								
 
								
							 


							}
							
							if(masterqty<=0)
							{
								break;
							}
							
							
							

							} 
				    		
				    		
				    		
				    		System.out.println("===masterqty==1===="+masterqty);
				    		
				    		
				    		if(masterqty>0)
				    			
				    		{
				    			
				    			int tempsykid=0;
				    			double qtyb=0;
					    		String sql="select  unitid,specno, i.op_qty-(i.out_qty+i.rsv_qty+i.del_qty) balqty,Stockid  from my_prddin i "
					    				+ " where   i.refstockid="+stockid+"  and i.psrno='"+psrno+"' and i.specno='"+specno+"'   "
					    								+ " and i.unitid="+unitids+" and i.prdid='"+prdid+"' and i.brhid="+session.getAttribute("BRANCHID").toString()+" "
					    										+ " and (i.op_qty-(i.rsv_qty+i.out_qty+i.del_qty))>0 group by i.stockid  ";
					    		
					    		System.out.println("===sub==main1====sql========"+sql);
					    		ResultSet rs1 = stmt.executeQuery(sql);
					    		
					    		  double balqty1=0;
					    		 
					    		while(rs1.next()) {
					    			 
					    			balqty1=rs1.getDouble("balqty");
					    			tempsykid=rs1.getInt("Stockid");
					    			unitid=rs1.getInt("unitid");
									spec=rs1.getInt("specno");
					    			if(qtyb>0)
					    			{
					    				masterqty=qtyb;
					    			}
					    			
					    			
					    			
									if(masterqty<=balqty1)
									{
										
										 
										
										
										
										String sqls="update my_srvd set out_qty=out_qty+"+masterqty+"  where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
										
										

										 System.out.println("-===sub==main1====sql=-"+sqls);


										stmtpuchasereturn.executeUpdate(sqls);
										
									 
										String prdinsqls="update my_prddin set out_qty=out_qty+"+masterqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
										

										 System.out.println("-===sub==main1====sql=--"+prdinsqls);

										stmtpuchasereturn.executeUpdate(prdinsqls);
										
				
											
										String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+masterqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
										stmtpuchasereturn.executeUpdate(insertsql);
										
									 	System.out.println("--===sub==main1====sql="+insertsql);
										
										
		 
										
										masterqty=0;
										break;


									}
									
									
									

									else if(masterqty>balqty1)
									{
										
										qtyb=masterqty-balqty1;
										masterqty=masterqty-balqty1;
										 
										String sqls="update my_srvd set out_qty=out_qty+"+balqty1+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
										
										

										 System.out.println("-===sub==main2====sql=---"+sqls);


										stmtpuchasereturn.executeUpdate(sqls);
										
										 
										String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty1*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
										

										 System.out.println("--==sub==main2====sql=-"+prdinsqls);

										stmtpuchasereturn.executeUpdate(prdinsqls);
										
				
											
										String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+balqty1*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
										stmtpuchasereturn.executeUpdate(insertsql);
										
									 	System.out.println("-==sub==main2====sql=--"+insertsql);
										
										
		 
										
									 


									}
									
									
					    			 	
									
									
									if(masterqty<=0)
									{
										break;
									}
									
					    			
					    			
					    		}
				    			
				    			
				    		}
				    		
				    		
				    		
				    		
				    		
				    		
				    		System.out.println("===masterqty==2===="+masterqty);
				    		
				    		
				    		if(masterqty>0)
				    			
				    		{
				    			
				    			int tempsykid=0;
				    			double qtyb=0;
					    		String sql="select  unitid,specno, i.op_qty-(i.out_qty+i.rsv_qty+i.del_qty) balqty,Stockid  from my_prddin i "
					    				+ " where      i.psrno='"+psrno+"' and i.specno='"+specno+"'   "
					    								+ " and i.unitid="+unitids+" and i.prdid='"+prdid+"' and i.brhid="+session.getAttribute("BRANCHID").toString()+" "
					    										+ " and  (i.op_qty-(i.rsv_qty+i.out_qty+i.del_qty))>0 group by i.stockid    order by i.date  ";
					    		
                                    System.out.println("==========sql====="+sql);
					    		ResultSet rs1 = stmt.executeQuery(sql);
					    		
					    		  double balqty1=0;
					    		 
					    		while(rs1.next()) {
					    			 
					    			balqty1=rs1.getDouble("balqty");
					    			tempsykid=rs1.getInt("Stockid");
					    			unitid=rs1.getInt("unitid");
									spec=rs1.getInt("specno");
					    			if(qtyb>0)
					    			{
					    				masterqty=qtyb;
					    			}
					    			
					    			
					    			
									if(masterqty<=balqty1)
									{
										
										 
										
										
										
										String sqls="update my_srvd set out_qty=out_qty+"+masterqty+"  where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
										
										

									 	System.out.println("-==sub sub==main1====sql=--"+sqls);


										stmtpuchasereturn.executeUpdate(sqls);
										
									 
										String prdinsqls="update my_prddin set out_qty=out_qty+"+masterqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
										

									 	System.out.println("-==sub sub==main1====prdinsqls=--"+prdinsqls);

										stmtpuchasereturn.executeUpdate(prdinsqls);
										
				
											
										String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+masterqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
										stmtpuchasereturn.executeUpdate(insertsql);
										
									 	System.out.println("-==sub sub==main1====insertsql=--"+insertsql);
										
										
		 
										
										masterqty=0;
										break;


									}
									
									
									

									else if(masterqty>balqty1)
									{
										
										qtyb=masterqty-balqty1;
										masterqty=masterqty-balqty1;
										 
										String sqls="update my_srvd set out_qty=out_qty+"+balqty1+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
										
										

										 System.out.println("--=sub sub==main2==---"+sqls);


										stmtpuchasereturn.executeUpdate(sqls);
										
										 
										String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty1*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
										

										 System.out.println("--=sub sub==main2=--"+prdinsqls);

										stmtpuchasereturn.executeUpdate(prdinsqls);
										
				
											
										String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+balqty1*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
										stmtpuchasereturn.executeUpdate(insertsql);
										
									    System.out.println("--=sub sub==main2=---"+insertsql);
										
										
		 
										
									 


									}
									
									
									if(masterqty<=0)
									{
										break;
									}	
									
					    			 	
					    			
					    			
					    			
					    		}
				    			
				    			
				    		}
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		
				    		


				    		
				     

					         }
				     }
			     }
				     
				     
				    	 }
	 
			
			 
			
		  
if(passjv.equalsIgnoreCase("passjv"))
{
			 
			
			String descs="Purchase Invoice Return"; 
			
			String refdetails="PIR"+""+vocno;
			
 
			 
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
	   
		   double	dramount=nettotal; 
		   
			 
		   double ldramount=0;
		   if(currencytype.equalsIgnoreCase("D"))
		   {
		   
           	
           	 ldramount=dramount/venrate ;  
		   }
		   
		   else
		   {
			    ldramount=dramount*venrate ;  
		   }
		   

		
		 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
		 
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
			 
				      double pricetottal=nettotal*-1;
				      double ldramounts=0 ;     
				      if(currencytype1.equalsIgnoreCase("D"))
				      {
				      
		                   ldramounts=pricetottal/venrate ;  
				      }
				      
				      else
				      {
				    	   ldramounts=pricetottal*venrate ;  
				      }
	     
		 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,3,0,0,0,'"+rates+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
	     
	     
		// System.out.println("---sql11----"+sql11) ; 
	 
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
		    	 
		    	 
		    	 String sqlsss="select sum(taxamount) taxamount  from my_srrd where rdocno= "+docno+" ";
					
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
					 System.out.println("-----2--dddd----"+dddd) ;
					ResultSet resultSet = stmt.executeQuery(dddd);

					while (resultSet.next()) {
						venrate=resultSet.getDouble("rate");
						taxcurrencytype1=resultSet.getString("type");
					}

					double	dramounts=nettax; 


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
					String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
*/
					
					String rdse="update   my_jvtran set  dramount=dramount+"+dramounts+",ldramount=ldramount+"+ldramountss+" where tr_no="+mastertr_no+" and acno="+venderaccount+"   ";
					 
					
					//	System.out.println("--sql1----"+sql1);
					int ss1111 = stmt.executeUpdate(rdse);

					if(ss1111<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					
					
					
					
					
					
					
					// total tax amount  int stacno=0;
					int divdval=1;
					if(stacno1>0)
					{
						divdval=2;
					}
					
					
					 
					
					System.out.println("=========================stacno===================================="+stacno);
					
					
					String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet t1sql1 = stmt.executeQuery(lll);
					if(t1sql1.next()) {

						vendorcur=t1sql1.getString("curid");	


					}

  
					String taxcurre="";
					String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--ppp----"+ppp) ;
					ResultSet r1 = stmt.executeQuery(ppp);

					while (r1.next()) {
						venrate=r1.getDouble("rate");
						taxcurre=r1.getString("type");
					}

					double	dramt=(stval/divdval)*-1; 


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
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

					//	System.out.println("--sql1----"+sql1);
					int aa = stmt.executeUpdate(sltax11);

					if(aa<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					
					
					
					
					// total tax amount  int stacno1=0;
					//stacno1
					
					
					 
					
					System.out.println("=========================stacno1===================================="+stacno1);
					
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
						System.out.println("-----2--ppp1----"+ppp1) ;
						ResultSet rs11 = stmt.executeQuery(ppp1);

						while (rs11.next()) {
						venrate=rs11.getDouble("rate");
						taxcurres1=rs11.getString("type");
							}

						double	dramts1=(stval/divdval)*-1; 


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
							+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

					//	System.out.println("--sql1----"+sql1);
						int aas1 = stmt.executeUpdate(sltax11s1);

						if(aas1<=0)
						{
							conn.close();
							return 0;

						}
					
					
					
					
					}
					
					
					
					
 
					
					
					
				}
				
				
				
			     
			     
			     
/*			     if(taxmethod>0)
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
						 System.out.println("-----2--dddd----"+dddd) ;
						ResultSet resultSet = stmt.executeQuery(dddd);

						while (resultSet.next()) {
							venrate=resultSet.getDouble("rate");
							taxcurrencytype1=resultSet.getString("type");
						}

						double	dramounts=nettax; 


						double ldramountss=0;
						if(taxcurrencytype1.equalsIgnoreCase("D"))
						{


							ldramountss=dramounts/venrate ;  
						}

						else
						{
							ldramountss=dramounts*venrate ;  
						}



						String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int ss1111 = stmt.executeUpdate(rdse);

						if(ss1111<=0)
						{
							conn.close();
							return 0;

						}
						
						
						
						
						
						
						
						
						
						
						// total tax amount  int stacno=0;
						System.out.println("=========================stacno===================================="+stacno);
						
						
						String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet t1sql1 = stmt.executeQuery(lll);
						if(t1sql1.next()) {

							vendorcur=t1sql1.getString("curid");	


						}

	  
						String taxcurre="";
						String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--ppp----"+ppp) ;
						ResultSet r1 = stmt.executeQuery(ppp);

						while (r1.next()) {
							venrate=r1.getDouble("rate");
							taxcurre=r1.getString("type");
						}

						double	dramt=stval*-1; 


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
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa = stmt.executeUpdate(sltax11);

						if(aa<=0)
						{
							conn.close();
							return 0;

						}
						
						
						
						// tax1acno tax 1

						
					 
						
						
		 
						
						
					 
						
						
						
					 
						
						
						
					}
					
					
					*/
					
					
		     
		     
		     
		     
		     
		     
		     

		     
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
				 System.out.println("--jvdramount----"+jvdramount) ;
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
							 System.out.println("---adjustsql----"+adjustsql) ;
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
										 		+ "values(curdate(),'"+refdetails+"',"+docno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'PIV','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
								     
								     
									// System.out.println("---sql11----"+sql11) ; 
								 
										 int result1 = stmt.executeUpdate(adjustsql11);

									     if(result1<=0)
											{
												conn.close();
												return 0;
												
											}
									     	      
					
					
					
				} 
				}//pass jv 
				
				
ArrayList<String> arr=new ArrayList<String>(); 
ClsVatInsert ClsVatInsert=new ClsVatInsert();
Statement newStatement=conn.createStatement();
String selectsqls="select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3," 
		+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
		+"sum(a.total9) total9,sum(a.total10) total10,sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,"
		+ " sum(a.tax6) tax6, "
		+"sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
		+"from (select m.typeid,d.nettotal+coalesce(d.taxamount,0) nettaxamount,if(d.taxamount>0,d.nettotal,0) total1, "
		+"if(m.typeid=2 or (m.typeid=1 and d.taxamount=0),d.nettotal,0) total2,if(m.typeid=3,d.nettotal,0) total3,"
		+"if(m.typeid=4,d.nettotal,0) total4,if(m.typeid=5,d.nettotal,0) total5, "
		+"if(m.typeid=6,d.nettotal,0) total6,if(m.typeid=7,d.nettotal,0) total7, "
		+"if(m.typeid=8,d.nettotal,0) total8,if(m.typeid=9,d.nettotal,0) total9, "
		+"if(m.typeid=10,d.nettotal,0) total10, "
		+"if(m.typeid=1,coalesce(d.taxamount,0),0) tax1,  if(m.typeid=2,coalesce(d.taxamount,0),0) tax2, "
		+"if(m.typeid=3,coalesce(d.taxamount,0),0) tax3,  if(m.typeid=4,coalesce(d.taxamount,0),0) tax4, "
		+"if(m.typeid=5,coalesce(d.taxamount,0),0) tax5,  if(m.typeid=6,coalesce(d.taxamount,0),0) tax6, "
		+"if(m.typeid=7,coalesce(d.taxamount,0),0) tax7,  if(m.typeid=8,coalesce(d.taxamount,0),0) tax8, "
		+"if(m.typeid=9,coalesce(d.taxamount,0),0) tax9,  if(m.typeid=10,coalesce(d.taxamount,0),0) tax10 "
		+" from my_srrd d left join my_main m on m.psrno=d.psrno where tr_no="+mastertr_no+" ) a " ;





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

	int result=ClsVatInsert.vatinsert(1,1,conn,mastertr_no,vendocno,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,cmbbilltype,arr,mode)	;
		if(result==0)	
	        {
			 
			conn.close();
			return docno;
			}
if(cmbbilltype==2)
	{
	int result1=ClsVatInsert.vatinsert(2,2,conn,mastertr_no,vendocno,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,cmbbilltype,arr,mode)	;
		if(result1==0)	
			{
			 
			conn.close();
			return docno;
			}
	}

		 
						Statement st0001=conn.createStatement();
		String sqlss1000=" update  my_prddout o left join my_prddin pin on o.stockid=pin.stockid  "
				+ " set o.cost_price=pin.cost_price     where o.dtype='PIR' and o.tr_no="+mastertr_no+" and coalesce(o.cost_price,0)=0 ";
		
		
		System.out.println("sqlss1000="+sqlss1000);
		st0001.executeUpdate(sqlss1000);
 
			if (docno > 0) {
			  conn.commit();
				stmtpuchasereturn.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
		
  

	
	
	



 

	
	public int update(int docno, Date masterdate, Date deldate,
			String refno, int vendocno, int cmbcurr, double currate,
			String delterms, String payterms, String purdesc,
			double nettotal, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request,
			ArrayList<String> masterarray, String reftype,
			String rrefno, int locationid, double producttotal,
			double prddiscount,String updatadata, double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype) throws SQLException {
	 
	 
	
		
		
		try{
			 
		//	System.out.println("---refno---"+refno); 
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpuchasereturn= conn.prepareCall("{call tr_PurchaseinvoicereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchasereturn.setInt(19, docno);
			stmtpuchasereturn.setInt(20, 0);
 
			stmtpuchasereturn.setDate(1,masterdate);
			stmtpuchasereturn.setDate(2,deldate);
			stmtpuchasereturn.setString(3,refno);
			stmtpuchasereturn.setInt(4,vendocno);
		   	stmtpuchasereturn.setInt(5,cmbcurr);
			stmtpuchasereturn.setDouble(6,currate);
			stmtpuchasereturn.setString(7,delterms); 
			stmtpuchasereturn.setString(8,payterms);
			stmtpuchasereturn.setString(9,purdesc);
			stmtpuchasereturn.setDouble(10,nettotal);
  
			stmtpuchasereturn.setString(11,session.getAttribute("USERID").toString());
			stmtpuchasereturn.setString(12,session.getAttribute("BRANCHID").toString());
			stmtpuchasereturn.setString(13,session.getAttribute("COMPANYID").toString());
			
	 
			stmtpuchasereturn.setString(14,formdetailcode);
			stmtpuchasereturn.setString(15,mode);
 
			stmtpuchasereturn.setString(16,reftype);
			stmtpuchasereturn.setString(17,rrefno);
			 
			stmtpuchasereturn.setInt(18,locationid);
			 
			
			stmtpuchasereturn.setDouble(21,producttotal);
			stmtpuchasereturn.setDouble(22,prddiscount);
			 
			  // System.out.println("====stmtpuchasereturn==="+stmtpuchasereturn);
		    int res=stmtpuchasereturn.executeUpdate();
		//	docno=stmtpuchasereturn.getInt("docNo");

			//
		    
		  //  System.out.println("====stmtpuchasereturn==="+stmtpuchasereturn);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			int mastertr_no=0;
			int vocno=0;	
	    	
			 Statement stmt1=conn.createStatement();
				String sqlss="select tr_no,voc_no from my_srrm where doc_no='"+docno+"' ";
				ResultSet selrs=stmt1.executeQuery(sqlss);
				
				if(selrs.next())
				{
					mastertr_no=selrs.getInt("tr_no");
					vocno=selrs.getInt("voc_no");
				}
				
				
				System.out.println("-updatadata--"+updatadata);	
				if(!(updatadata.equalsIgnoreCase("Editvalue")))
				{	
					String sqlsss="update my_prddout set date='"+masterdate+"',brhid='"+session.getAttribute("BRANCHID").toString()+"',locid='"+locationid+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"'" ;
					stmtpuchasereturn.executeUpdate(sqlsss);
				}
				
	 
		//	System.out.println("updatadata"+updatadata); 
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{
				
			
			
						String delsqls="delete from my_srrd where tr_no='"+mastertr_no+"' ";
						stmtpuchasereturn.executeUpdate(delsqls);
						
			 
				 
						
						int taxmethod=0;
						 Statement stmttax=conn.createStatement();
						 String chk="select method  from gl_prdconfig where field_nme='tax'";
						 ResultSet rssz=stmttax.executeQuery(chk); 
						 if(rssz.next())
						 {
						 	
							 taxmethod=rssz.getInt("method");
						 }

						 int stacno=0;
						/* int tax1acno=0;
						 int tax2acno=0;
						 int tax3acno=0;*/
						 int stacno1=0;
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
							
						 
						  if(taxmethod>0)
						  {
							  String sqltax1= " update my_srrm set totaltax='"+stval+"',tax1='0',tax2='0',tax3='0',"
								  		+ "nettotaltax='"+stval+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
							  
							  System.out.println("======sqltax1========="+sqltax1);
							  
							  stmt1.executeUpdate(sqltax1);
						
						  int prvdocno=0;
							 
							  Statement pv=conn.createStatement();
								
								String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
								
								System.out.println("=======dd========"+dd);
								
								
								ResultSet rs13=pv.executeQuery(dd); 
								if(rs13.next())
								{

									prvdocno=rs13.getInt("prvdocno");
								}
								System.out.println("======prvdocno========"+prvdocno);

								 
							 
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

							 
						  
						  
						  }
						 
						 
						
				  
						
			
					  	int	updateid=0;
					  	
						String passjv="";
						
						for(int i=0;i< masterarray.size();i++){
						  	 
							
							
							
					    	   if(reftype.equalsIgnoreCase("PIV"))
						         {
					    		   
					    		   double updateqty=0;
					    		   int updatestockid=0;
					    		   int updaterrowno=0;
					    		   int updatepsrno=0;
					    		   
					    		   if(i==0)
					    		   {
					    			 String sql="select qty,stockid,coalesce(rrowno,0) rrowno,psrno from my_prddout where tr_no="+mastertr_no+" and dtype='PIR' ";
					    			 
					    			 ResultSet ms=stmt1.executeQuery(sql);
					    			 
					    			 while(ms.next())
					    			 {
					    				 updateqty=ms.getDouble("qty");
					    				 updatestockid=ms.getInt("stockid");
					    				 updaterrowno=ms.getInt("rrowno");
					    				 updatepsrno=ms.getInt("psrno");
					    				 
					    				 String upsqls= "update my_prddin set out_qty=out_qty-"+updateqty+" where stockid="+updatestockid+"  and psrno="+updatepsrno+"  ";
					    				 stmt3111.executeUpdate(upsqls);
					    				 String upsqls1= "update my_prddin set out_qty=0 where stockid="+updatestockid+" and out_qty<0  and psrno="+updatepsrno+"  ";
					    				 stmt3111.executeUpdate(upsqls1);
					    				 
					    				 if(updaterrowno>0)
					    				 {
					    					 String upsqls2= "update my_srvd set out_qty=out_qty-"+updateqty+" where rowno="+updaterrowno+" and psrno="+updatepsrno+" ";
						    				 stmt3111.executeUpdate(upsqls2); 
						    				 String upsqls21= "update my_srvd set out_qty=0 where rowno="+updaterrowno+"  and out_qty<0  and psrno="+updatepsrno+" ";
						    				 stmt3111.executeUpdate(upsqls21);
					    					 
					    				 }
					    				 else
					    				 {
					    					 String upsqls2= "update my_srvd set out_qty=out_qty-"+updateqty+" where stockid="+updatestockid+" and psrno="+updatepsrno+" ";
						    				 stmt3111.executeUpdate(upsqls2); 
						    				 String upsqls21= "update my_srvd set out_qty=0 where stockid="+updatestockid+"  and out_qty<0  and psrno="+updatepsrno+" ";
						    				 stmt3111.executeUpdate(upsqls21);
					    				 }
					    				 
					    				 
					    			 }
					    			 
					    			   
					    			 
					    				String delsqls1="delete from my_prddout where tr_no='"+mastertr_no+"' and dtype='PIR'  ";
										stmtpuchasereturn.executeUpdate(delsqls1);
										
					    			 
					    			 
					    			   
					    		   }
					    		   
					    		   
					    		   
						         }
							
							
							
						     String[] detmasterarrays=masterarray.get(i).split("::");
						     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
						     {
						    	 
						    	 
						    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    	 
						    	 
							     double chkqty=Double.parseDouble(qtychk);
						    	
							     
					 
							     
							     if(chkqty>0){
						    	
							    	 
							    	 
							    	 
							    	 
							    	 
							    	 
							    	 
							    	 
	 
							    	 String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
							    	 
							    	 double gridnettotal=Double.parseDouble(gridnettotals);
							    	 
							    	 
							    	// System.out.println("--gridnettotal---"+gridnettotal);
							    	 
							    	 String psrnos=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
							    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
										 
							         double fr=1;
								     String slss=" select fr from my_unit where psrno="+psrnos+" and unit='"+unitids+"' ";
								     
								     System.out.println("====slss==="+slss);
								     ResultSet rv1=stmtpuchasereturn.executeQuery(slss);
								     if(rv1.next())
								     {
								    	 fr=rv1.getDouble("fr"); 
								     }
						    	 
							    	 
								     String insql="INSERT INTO my_srrd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,fr)VALUES"
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
										       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
										       +"'"+mastertr_no+"','"+docno+"' ,"
										       	+ "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")  || detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
											       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")  || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
											       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")  || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"+fr+")";
					           //  System.out.println("----"+insql);
			                      
							     int resultSet2 = stmtpuchasereturn.executeUpdate(insql);
							     if(resultSet2<=0)
									{
										conn.close();
										return 0;
										
									}
							  
					               
							    // System.out.println("-reftype-----"+reftype);	 	
							    	 
							    	 
							    	 
							    	   if(reftype.equalsIgnoreCase("PIV"))
								         {	 
							    	
							    		   //System.out.println("--nouffffffffffff-----");	 	   
							 
							     passjv="passjv";
							     
							     
							     
							                  
							     
							     
							     
							     
							     
							     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
							     
							  
							     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
							     
							     
							     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
							     
							     double masterqty=Double.parseDouble(rqty);
							     
							     
							 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
						    	  
						    	   
							     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
							    
								 
							    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
							    	 

								   //  String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
								     
							     
							  
								     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
									    
								     String  foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")|| detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";
								     double focqty=Double.parseDouble(foc);
							 
								     double paidqty=Double.parseDouble(paidqtyd);
								     
								     
								     System.out.println("--masterqty-----"+masterqty);
								     
								   //  System.out.println("--focqty-----"+focqty);
								     double totalordoutqty=paidqty+focqty; 
								  //  System.out.println("--totalordoutqty-----"+totalordoutqty);	 

								    
							    		 
								 	   double balqty=0;
										 
								 	  double foc_out=0;
										double remqty=0;
										double out_qty=0;
											double qty=0;
											
											double grnout=0;
											 double foc_outqty=0;
											
											double grnsaveqty=0; 
											double prddinsaveqty=0;
											int unitid=0;
											int spec=0;
							    	 Statement stmt=conn.createStatement();
							    	 
							/*    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
												+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
				 */
							    	 
							    	int rownos=0; 
							    	
							    	String mastersql="select rowno from my_srvd where stockid="+stockid+" and psrno="+psrno+" ";
							    	ResultSet masterrs=stmt.executeQuery(mastersql);
							    	if(masterrs.first())
							    	{
							    		rownos=masterrs.getInt("rowno");
							    	}
							    	
							    			
							    	 
							    	 
							    	 String strSql="select  dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty)/sum(dd.fr) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/sum(dd.fr) balstkqty,sum(dd.out_qty)/sum(dd.fr) out_qty,date,sum(d.out_qty)  grnout,dd.unitid,dd.specno from my_prddin dd "
												+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"'    and dd.unitid="+unitids+" and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
				 
							          System.out.println("---strSql-----"+strSql);
							    		ResultSet rs = stmt.executeQuery(strSql);
							    		
							    		
							    		while(rs.next()) {


											balqty=rs.getDouble("balstkqty");
											foc_out=rs.getInt("foc_out");
											out_qty=rs.getDouble("out_qty");

											//stockid=rs.getInt("stockid");
											qty=rs.getDouble("qty");
											grnout=rs.getDouble("grnout");
											unitid=rs.getInt("unitid");
											spec=rs.getInt("specno");
										
									//	System.out.println("---masterqty-----"+masterqty);	
										
										//System.out.println("---grnout-----"+grnout);	
										//System.out.println("---out_qty-----"+out_qty);	

											//System.out.println("---masterqty-----"+masterqty);	

										//	System.out.println("---balqty-----"+balqty);	

											//System.out.println("---out_qty-----"+out_qty);	
										//	System.out.println("---qty-----"+qty);



										if(masterqty<=balqty)
										{
											
											grnsaveqty=masterqty+grnout;
											foc_outqty=foc_out+focqty;
											String sqls="update my_srvd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
											
											

										 System.out.println("-main1---sqls---"+sqls);


											stmtpuchasereturn.executeUpdate(sqls);
											
											prddinsaveqty=(masterqty+focqty)+out_qty;
											String prdinsqls="update my_prddin set out_qty="+prddinsaveqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
			                              //	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+",foc_out='"+foc_outqty+"' where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
											

											 System.out.println("--main1---prdinsqls---"+prdinsqls);

											stmtpuchasereturn.executeUpdate(prdinsqls);
											
					
												
											//String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,foc,date,brhid,locid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty+"','"+docno+"','"+prdid+"','"+focqty+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"')";
											String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
											stmtpuchasereturn.executeUpdate(insertsql);
											
										 	System.out.println("--main1--insertsql---"+insertsql);
											
											
			 
											masterqty=0;
											
											break;


										}
										

										else if(masterqty>balqty)
										{
											masterqty=masterqty-balqty;
											grnsaveqty=balqty+grnout;
											foc_outqty=foc_out+focqty;
											String sqls="update my_srvd set out_qty=out_qty+"+balqty+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
											
											

											 System.out.println("--main2---sqls---"+sqls);


											stmtpuchasereturn.executeUpdate(sqls);
											
											prddinsaveqty=(masterqty+focqty)+out_qty;
											String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
			                              //	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+",foc_out='"+foc_outqty+"' where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
											

											 System.out.println("--main2--prdinsqls---"+prdinsqls);

											stmtpuchasereturn.executeUpdate(prdinsqls);
											
					
												
											//String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,foc,date,brhid,locid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty+"','"+docno+"','"+prdid+"','"+focqty+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"')";
											String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+balqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
											stmtpuchasereturn.executeUpdate(insertsql);
											
										 	System.out.println("--main2--insertsql---"+insertsql);
											
											
			 
											
										 


										}
										
										if(masterqty<=0)
										{
											break;
										}
										
										
										

										} 
							    		
							    		
							    		
							    		System.out.println("===masterqty==1===="+masterqty);
							    		
							    		
							    		if(masterqty>0)
							    			
							    		{
							    			
							    			int tempsykid=0;
							    			double qtyb=0;
								    		String sql="select  unitid,specno, i.op_qty-(i.out_qty+i.rsv_qty+i.del_qty) balqty,Stockid  from my_prddin i "
								    				+ " where   i.refstockid="+stockid+"  and i.psrno='"+psrno+"' and i.specno='"+specno+"'   "
								    								+ " and i.unitid="+unitids+" and i.prdid='"+prdid+"' and i.brhid="+session.getAttribute("BRANCHID").toString()+" "
								    										+ " and (i.op_qty-(i.rsv_qty+i.out_qty+i.del_qty))>0 group by i.stockid  ";
								    		
								    		System.out.println("===sub==main1====sql========"+sql);
								    		ResultSet rs1 = stmt.executeQuery(sql);
								    		
								    		  double balqty1=0;
								    		 
								    		while(rs1.next()) {
								    			 
								    			balqty1=rs1.getDouble("balqty");
								    			tempsykid=rs1.getInt("Stockid");
								    			unitid=rs1.getInt("unitid");
												spec=rs1.getInt("specno");
								    			if(qtyb>0)
								    			{
								    				masterqty=qtyb;
								    			}
								    			
								    			
								    			
												if(masterqty<=balqty1)
												{
													
													 
													
													
													
													String sqls="update my_srvd set out_qty=out_qty+"+masterqty+"  where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
													
													

													 System.out.println("-===sub==main1====sql=-"+sqls);


													stmtpuchasereturn.executeUpdate(sqls);
													
												 
													String prdinsqls="update my_prddin set out_qty=out_qty+"+masterqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
													

													 System.out.println("-===sub==main1====sql=--"+prdinsqls);

													stmtpuchasereturn.executeUpdate(prdinsqls);
													
							
														
													String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+masterqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
													stmtpuchasereturn.executeUpdate(insertsql);
													
												 	System.out.println("--===sub==main1====sql="+insertsql);
													
													
					 
													
													masterqty=0;
													break;


												}
												
												
												

												else if(masterqty>balqty1)
												{
													
													qtyb=masterqty-balqty1;
													masterqty=masterqty-balqty1;
													 
													String sqls="update my_srvd set out_qty=out_qty+"+balqty1+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
													
													

													 System.out.println("-===sub==main2====sql=---"+sqls);


													stmtpuchasereturn.executeUpdate(sqls);
													
													 
													String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty1*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
													

													 System.out.println("--==sub==main2====sql=-"+prdinsqls);

													stmtpuchasereturn.executeUpdate(prdinsqls);
													
							
														
													String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+balqty1*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
													stmtpuchasereturn.executeUpdate(insertsql);
													
												 	System.out.println("-==sub==main2====sql=--"+insertsql);
													
													
					 
													
												 


												}
												
												
								    			 	
												
												
												if(masterqty<=0)
												{
													break;
												}
												
								    			
								    			
								    		}
							    			
							    			
							    		}
							    		
							    		
							    		
							    		
							    		
							    		
							    		System.out.println("===masterqty==2===="+masterqty);
							    		
							    		
							    		if(masterqty>0)
							    			
							    		{
							    			
							    			int tempsykid=0;
							    			double qtyb=0;
								    		String sql="select  unitid,specno, i.op_qty-(i.out_qty+i.rsv_qty+i.del_qty) balqty,Stockid  from my_prddin i "
								    				+ " where      i.psrno='"+psrno+"' and i.specno='"+specno+"'   "
								    								+ " and i.unitid="+unitids+" and i.prdid='"+prdid+"' and i.brhid="+session.getAttribute("BRANCHID").toString()+" "
								    										+ " and  (i.op_qty-(i.rsv_qty+i.out_qty+i.del_qty))>0 group by i.stockid    order by i.date  ";
								    		
			                                    System.out.println("==========sql====="+sql);
								    		ResultSet rs1 = stmt.executeQuery(sql);
								    		
								    		  double balqty1=0;
								    		 
								    		while(rs1.next()) {
								    			 
								    			balqty1=rs1.getDouble("balqty");
								    			tempsykid=rs1.getInt("Stockid");
								    			unitid=rs1.getInt("unitid");
												spec=rs1.getInt("specno");
								    			if(qtyb>0)
								    			{
								    				masterqty=qtyb;
								    			}
								    			
								    			
								    			
												if(masterqty<=balqty1)
												{
													
													 
													
													
													
													String sqls="update my_srvd set out_qty=out_qty+"+masterqty+"  where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
													
													

												 	System.out.println("-==sub sub==main1====sql=--"+sqls);


													stmtpuchasereturn.executeUpdate(sqls);
													
												 
													String prdinsqls="update my_prddin set out_qty=out_qty+"+masterqty*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
													

												 	System.out.println("-==sub sub==main1====prdinsqls=--"+prdinsqls);

													stmtpuchasereturn.executeUpdate(prdinsqls);
													
							
														
													String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+masterqty*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
													stmtpuchasereturn.executeUpdate(insertsql);
													
												 	System.out.println("-==sub sub==main1====insertsql=--"+insertsql);
													
													
					 
													
													masterqty=0;
													break;


												}
												
												
												

												else if(masterqty>balqty1)
												{
													
													qtyb=masterqty-balqty1;
													masterqty=masterqty-balqty1;
													 
													String sqls="update my_srvd set out_qty=out_qty+"+balqty1+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
													
													

													 System.out.println("--=sub sub==main2==---"+sqls);


													stmtpuchasereturn.executeUpdate(sqls);
													
													 
													String prdinsqls="update my_prddin set out_qty=out_qty+"+balqty1*fr+" where   specno='"+specno+"' and  prdid="+prdid+" and  stockid="+tempsykid+" and unitid="+unitid+" ";
													

													 System.out.println("--=sub sub==main2=--"+prdinsqls);

													stmtpuchasereturn.executeUpdate(prdinsqls);
													
							
														
													String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,date,brhid,locid,rrowno)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+tempsykid+"','"+balqty1*fr+"','"+docno+"','"+prdid+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"',"+rownos+")";
													stmtpuchasereturn.executeUpdate(insertsql);
													
												    System.out.println("--=sub sub==main2=---"+insertsql);
													
													
					 
													
												 


												}
												
												
												if(masterqty<=0)
												{
													break;
												}	
												
								    			 	
								    			
								    			
								    			
								    		}
							    			
							    			
							    		}
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		
							    		


							    		
							     

								         }
							     }
						     }
							     
							     
							    	 }
				 
						
						
						
/*						for(int i=0;i< masterarray.size();i++){
					    	
						     String[] detmasterarrays=masterarray.get(i).split("::");
						     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
						     {
						    	 
						    	 
						    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    	 
						    	 
							     double chkqty=Double.parseDouble(qtychk);
						    	
							     
						 
							     
							     if(chkqty>0){
						    	
							    	 
							    	 String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
							    	 
							    	 double gridnettotal=Double.parseDouble(gridnettotals);
							    	 
							    	// System.out.println("--gridnettotal---"+gridnettotal);
							      	 
							      	 String psrnos=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
							    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
										 
							         double fr=1;
								     String slss=" select fr from my_unit where psrno="+psrnos+" and unit='"+unitids+"' ";
								     
								     System.out.println("====slss==="+slss);
								     ResultSet rv1=stmtpuchasereturn.executeQuery(slss);
								     if(rv1.next())
								     {
								    	 fr=rv1.getDouble("fr"); 
								     }
						    	 
								     String insql="INSERT INTO my_srrd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount)VALUES"
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
										       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
										       +"'"+mastertr_no+"','"+docno+"',"
							       	+ "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
								       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
								       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"')";
					             
			                      
							     int resultSet2 = stmtpuchasereturn.executeUpdate(insql);
							     if(resultSet2<=0)
									{
										conn.close();
										return 0;
										
									}
							  
					    		   
							    	 
							    	   if(reftype.equalsIgnoreCase("PIV"))
								         {	 
									    	 
									
							    	 
					             
					    		   
						    	 
							    		   passjv="passjv";
							     
							    // rrefno
							     
							     
							     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
							     
							  
							     
							     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
							     
							     double masterqty=Double.parseDouble(rqty);
							     
							     
					 
							                              0                 1                       2                     3
							     newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
							    		                 4                     5                    6                       7                      8
										   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
										                      9                       10                     11                   12                      13                  14                  15
										   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc+" :: "+rows[i].oldfoc+" :: "); 
								
							     
							     
							 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
						    	  
						    	   
							     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
							    
								 
							    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
							    	 

								     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
								     
							     
							  
								     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
									    
								     String  foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")|| detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";
								     double focqty=Double.parseDouble(foc);
								  	String oldqtys=""+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"";
							    	
								  	
							    	  double oldqty=Double.parseDouble(oldqtys); 
							    	  double currqty=Double.parseDouble(paidqtyd); 
							    	  
							    	  
							    	  String oldfocs=""+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")|| detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"";
							    	  double oldfoc=Double.parseDouble(oldfocs);
							    	     double paidqty=Double.parseDouble(paidqtyd);
									     
									     
									   //  System.out.println("--paidqty-----"+paidqty);
									     
									   //  System.out.println("--focqty-----"+focqty);
									     double totalordoutqty=paidqty+focqty; 
									  //  System.out.println("--totalordoutqty-----"+totalordoutqty);	

								    
							    		 
								 	   double balqty=0;
										 
								 	  double foc_out=0;
										double remqty=0;
										double out_qty=0;
											double qty=0;
											
											double grnout=0;
											 double foc_outqty=0;
											
											double grnsaveqty=0; 
											double prddinsaveqty=0;
											
											double foc_outval=0;
											int unitid=0;
											int spec=0;
											
							    	 Statement stmt=conn.createStatement();
							    	 
							    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout,sum(dd.foc_out) foc_out from my_prddin dd "
												+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid   order by dd.date";
							    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty)/sum(dd.fr) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/sum(dd.fr) balstkqty,sum(dd.out_qty)/sum(dd.fr) out_qty,date,sum(d.out_qty) grnout,sum(dd.foc_out)/sum(dd.fr) foc_out,dd.unitid,dd.specno from my_prddin dd "
												+ " left join my_srvd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.unitid="+unitids+"     and dd.specno='"+specno+"'  and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid   order by dd.date";
				 
							       //  System.out.println("---strSql-----"+strSql);
							    		ResultSet rs = stmt.executeQuery(strSql);
							    		
							    		
							    		while(rs.next()) {


											balqty=rs.getDouble("balstkqty");
											foc_out=rs.getInt("foc_out");
											out_qty=rs.getDouble("out_qty");

											//stockid=rs.getInt("stockid");
											qty=rs.getDouble("qty");
											grnout=rs.getDouble("grnout");
											
											foc_outval=rs.getDouble("foc_out");
											
											unitid=rs.getInt("unitid");
											spec=rs.getInt("specno");
											
										//System.out.println("---masterqty-----"+masterqty);	
										
									//	System.out.println("---grnout-----"+grnout);	
										//System.out.println("---out_qty-----"+out_qty);	
									//	System.out.println("---foc_outval-----"+foc_outval);	
						
										
										
									//	System.out.println("--currqty-----"+currqty);	 
									//	System.out.println("--oldqty-----"+oldqty);	 
				 
										
										       grnsaveqty=(currqty+grnout)-oldqty;
										       
										       
											//	System.out.println("--focqty-----"+focqty);	
												
												
											//	System.out.println("--foc_outval-----"+foc_outval);	
												
												
												//System.out.println("--oldfoc-----"+oldfoc);	
										       
										       
										       foc_outqty=(focqty+foc_outval)-oldfoc;
										//		System.out.println("-grnsaveqty---"+grnsaveqty);
												
												
												
			                             
												
												//String sqls="update my_srvd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"' where specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
												
										       String sqls="update my_srvd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"' where specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";
											//	System.out.println("--1---sqls---"+sqls);


												stmtpuchasereturn.executeUpdate(sqls);
												
												
												prddinsaveqty=(currqty+out_qty+focqty-oldfoc)-oldqty;
												
											//	System.out.println("-prddinsaveqty---"+prddinsaveqty);
												
												
				                              //	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+",foc_out='"+foc_outqty+"' where  specno='"+specno+"' and  prdid="+prdid+" and  stockid="+stockid+"";
												String prdinsqls="update my_prddin set out_qty="+prddinsaveqty*fr+",foc_out='"+foc_outqty+"' where  specno='"+spec+"' and  prdid="+prdid+" and  stockid="+stockid+" and unitid="+unitid+" ";

											//	System.out.println("--1---prdinsqls---"+prdinsqls);


												stmtpuchasereturn.executeUpdate(prdinsqls);
												
													
												//String insertsql="update my_prddout set qty='"+totalordoutqty+"',foc='"+foc_outqty+"',date='"+masterdate+"',brhid='"+session.getAttribute("BRANCHID").toString()+"',locid='"+locationid+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stockid='"+stockid+"'";
												String insertsql="update my_prddout set qty='"+totalordoutqty*fr+"',foc='"+foc_outqty+"',date='"+masterdate+"',brhid='"+session.getAttribute("BRANCHID").toString()+"',locid='"+locationid+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stockid='"+stockid+"'";
												//System.out.println("--1---insertsql---"+insertsql);
												stmtpuchasereturn.executeUpdate(insertsql);
												break;
											
											
											
											
											
											


										 

										} 


								         }
							     }
							     

						     }
	 
				     
						}*/ 
			if(passjv.equalsIgnoreCase("passjv"))
			{
				String delsqlss="delete from my_jvtran where tr_no='"+mastertr_no+"' ";
				stmtpuchasereturn.executeUpdate(delsqlss);	 
						
						String descs="Purchase Invoice Return"; 
						
						String refdetails="PIR"+""+vocno;
						
			 
						 
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
				   
					   double	dramount=nettotal; 
					   
						 
					   double ldramount=0;
					   if(currencytype.equalsIgnoreCase("D"))
					   {
					   
			           	
			           	 ldramount=dramount/venrate ;  
					   }
					   
					   else
					   {
						    ldramount=dramount*venrate ;  
					   }
					   

					
					 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
				     
					 
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
						 
							      double pricetottal=nettotal*-1;
							      double ldramounts=0 ;     
							      if(currencytype1.equalsIgnoreCase("D"))
							      {
							      
					                   ldramounts=pricetottal/venrate ;  
							      }
							      
							      else
							      {
							    	   ldramounts=pricetottal*venrate ;  
							      }
				     
					 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,3,0,0,0,'"+rates+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
				     
				     
					// System.out.println("---sql11----"+sql11) ; 
				 
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
					    	 
					    	 
					    	 String sqlsss="select sum(taxamount) taxamount  from my_srrd where rdocno= "+docno+" ";
								
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
								 System.out.println("-----2--dddd----"+dddd) ;
								ResultSet resultSet = stmt.executeQuery(dddd);

								while (resultSet.next()) {
									venrate=resultSet.getDouble("rate");
									taxcurrencytype1=resultSet.getString("type");
								}

								double	dramounts=nettax; 


								double ldramountss=0;
								if(taxcurrencytype1.equalsIgnoreCase("D"))
								{


									ldramountss=dramounts/venrate ;  
								}

								else
								{
									ldramountss=dramounts*venrate ;  
								}



						/*		String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";
*/
								//	System.out.println("--sql1----"+sql1);
								
								
								String rdse="update   my_jvtran set  dramount=dramount+"+dramounts+",ldramount=ldramount+"+ldramountss+" where tr_no="+mastertr_no+" and acno="+venderaccount+"   ";
								 
								
								
								int ss1111 = stmt.executeUpdate(rdse);

								if(ss1111<=0)
								{
									conn.close();
									return 0;

								}
								
								
								
								
								
								
								
								
								
								
								// total tax amount  int stacno=0;
								int divdval=1;
								if(stacno1>0)
								{
									divdval=2;
								}
								
								
								 
								
								System.out.println("=========================stacno===================================="+stacno);
								
								
								String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
								//System.out.println("---1----sqls10----"+sqls10) ;
								ResultSet t1sql1 = stmt.executeQuery(lll);
								if(t1sql1.next()) {

									vendorcur=t1sql1.getString("curid");	


								}

			  
								String taxcurre="";
								String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
										+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
								 System.out.println("-----2--ppp----"+ppp) ;
								ResultSet r1 = stmt.executeQuery(ppp);

								while (r1.next()) {
									venrate=r1.getDouble("rate");
									taxcurre=r1.getString("type");
								}

								double	dramt=(stval/divdval)*-1; 


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
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

								//	System.out.println("--sql1----"+sql1);
								int aa = stmt.executeUpdate(sltax11);

								if(aa<=0)
								{
									conn.close();
									return 0;

								}
								
								
								
								
								
								
								
								// total tax amount  int stacno1=0;
								//stacno1
								
								
								 
								
								System.out.println("=========================stacno1===================================="+stacno1);
								
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
									System.out.println("-----2--ppp1----"+ppp1) ;
									ResultSet rs11 = stmt.executeQuery(ppp1);

									while (rs11.next()) {
									venrate=rs11.getDouble("rate");
									taxcurres1=rs11.getString("type");
										}

									double	dramts1=(stval/divdval)*-1; 


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
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIR','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

								//	System.out.println("--sql1----"+sql1);
									int aas1 = stmt.executeUpdate(sltax11s1);

									if(aas1<=0)
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
			String selectsqls="select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3," 
					+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
					+"sum(a.total9) total9,sum(a.total10) total10,sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,"
					+ " sum(a.tax6) tax6, "
					+"sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
					+"from (select m.typeid,d.nettotal+coalesce(d.taxamount,0) nettaxamount,if(d.taxamount>0,d.nettotal,0) total1, "
					+"if(m.typeid=2 or (m.typeid=1 and d.taxamount=0),d.nettotal,0) total2,if(m.typeid=3,d.nettotal,0) total3,"
					+"if(m.typeid=4,d.nettotal,0) total4,if(m.typeid=5,d.nettotal,0) total5, "
					+"if(m.typeid=6,d.nettotal,0) total6,if(m.typeid=7,d.nettotal,0) total7, "
					+"if(m.typeid=8,d.nettotal,0) total8,if(m.typeid=9,d.nettotal,0) total9, "
					+"if(m.typeid=10,d.nettotal,0) total10, "
					+"if(m.typeid=1,coalesce(d.taxamount,0),0) tax1,  if(m.typeid=2,coalesce(d.taxamount,0),0) tax2, "
					+"if(m.typeid=3,coalesce(d.taxamount,0),0) tax3,  if(m.typeid=4,coalesce(d.taxamount,0),0) tax4, "
					+"if(m.typeid=5,coalesce(d.taxamount,0),0) tax5,  if(m.typeid=6,coalesce(d.taxamount,0),0) tax6, "
					+"if(m.typeid=7,coalesce(d.taxamount,0),0) tax7,  if(m.typeid=8,coalesce(d.taxamount,0),0) tax8, "
					+"if(m.typeid=9,coalesce(d.taxamount,0),0) tax9,  if(m.typeid=10,coalesce(d.taxamount,0),0) tax10 "
					+" from my_srrd d left join my_main m on m.psrno=d.psrno where tr_no="+mastertr_no+" ) a " ;





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

				int result=ClsVatInsert.vatinsert(1,1,conn,mastertr_no,vendocno,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,cmbbilltype,arr,mode)	;
					if(result==0)	
				        {
						 
						conn.close();
						return docno;
						}
			if(cmbbilltype==2)
				{
				int result1=ClsVatInsert.vatinsert(2,2,conn,mastertr_no,vendocno,vocno,masterdate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,cmbbilltype,arr,mode)	;
					if(result1==0)	
						{
						 
						conn.close();
						return docno;
						}
				}

		//	System.out.println("sssssss"+docno);
				Statement st0001=conn.createStatement();
		String sqlss1000=" update  my_prddout o left join my_prddin pin on o.stockid=pin.stockid "
				+ "  set o.cost_price=pin.cost_price     where o.dtype='PIR' and o.tr_no="+mastertr_no+" and coalesce(o.cost_price,0)=0 ";
		//System.out.println("sqlss1000="+sqlss1000);
		
		st0001.executeUpdate(sqlss1000);
			if (docno > 0) {
				conn.commit();
				stmtpuchasereturn.close();
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
			 
			 CallableStatement stmtpuchasereturn= conn.prepareCall("{call tr_PurchaseinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpuchasereturn.setInt(20,masterdoc_no);
			stmtpuchasereturn.setInt(24, 0);
 
			stmtpuchasereturn.setDate(1,null);
			stmtpuchasereturn.setDate(2,null);
			stmtpuchasereturn.setString(3,null);
			stmtpuchasereturn.setInt(4,0);
		   	stmtpuchasereturn.setInt(5,0);
			stmtpuchasereturn.setDouble(6,0);
			stmtpuchasereturn.setString(7,null); 
			stmtpuchasereturn.setString(8,null);
			stmtpuchasereturn.setString(9,null);
			stmtpuchasereturn.setDouble(10,0);
			stmtpuchasereturn.setDouble(11,0);
			stmtpuchasereturn.setDouble(12,0);
			stmtpuchasereturn.setDouble(13,0);
			stmtpuchasereturn.setDouble(14,0);
			stmtpuchasereturn.setDouble(15,0);
			stmtpuchasereturn.setDouble(16,0);
			stmtpuchasereturn.setString(17,session.getAttribute("USERID").toString());
			stmtpuchasereturn.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpuchasereturn.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpuchasereturn.setString(21,formdetailcode);
			stmtpuchasereturn.setString(22,mode);
			stmtpuchasereturn.setInt(23,0);
			stmtpuchasereturn.setString(25,"0");
			stmtpuchasereturn.setString(26,"0");
			stmtpuchasereturn.setDouble(27,0);
			stmtpuchasereturn.setDouble(28,0);
		    int res=stmtpuchasereturn.executeUpdate();
			docno=stmtpuchasereturn.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if (res > 0) {
			 
				stmtpuchasereturn.close();
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
						
						
			/*		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'   and type=1  and if(1="+cmbbilltype+",per,cstper)>0 group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
						
						
					}
					
				}
				
				
			String ssql="select  "+fsql+"  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)  "+joinsql+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
					+"   where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "+condtn;
			
			System.out.println("---ssql---"+ssql);
			ResultSet resultSet = stmtVeh.executeQuery (ssql);
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
	
	
	
	

	public   JSONArray searchreqProduct(String reqmasterdocno,HttpSession session,String dates,String cmbbilltype,String acno,String prdname,
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
						
						
			/*		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'   and type=1  and if(1="+cmbbilltype+",per,cstper)>0 group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
					
					
					}
					
				}
				
				
				if(reqmasterdocno.equalsIgnoreCase(""))
				{
					reqmasterdocno="0"; 
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
					 joinsqls1=" and dd.unitid=d.unitid and  dd.specno=d.specno ";
				}
				
				
	 
				
				String sqls="select  "+fsql+"  "+method+" method ,bd.brandname,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,d.unitid munit,m.psrno,dd.dtype rdtype,"
						+ " if(mm.rdtype='GRN',0,d.foc-d.foc_out) maxfoc, "
						+ " sum(d.out_qty) pqty,sum(d.qty) mainqty,sum(d.qty)-sum(d.out_qty)  qty, "
						+ "	sum(d.qty)-sum(d.out_qty) qutval, "
						+ " sum(d.qty)-sum(d.out_qty) saveqty,"
						+ "  d.amount unitprice,d.amount*(sum(d.qty)-sum(d.out_qty))  total,  "
						+ " d.amount*(sum(d.qty)-sum(d.out_qty))* d.disper/100 discount, "
						+ "	d.disper ,(d.amount*(sum(d.qty)-sum(d.out_qty)))-(d.amount*(sum(d.qty)-sum(d.out_qty))*d.disper/100) nettotal  "
						+ " from  my_srvm  mm left join  my_srvd d on mm.tr_no=d.tr_no	left join my_prddin dd on  "
						+ "  dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid   and mm.brhid=dd.brhid    "+joinsqls1+"    "
						+ "	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no 	left join my_prodattrib at    "
						+ "  on(at.mpsrno=m.doc_no)  "+joinsql+ " left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
						+"   where mm.status=3 and mm.brhid='"+brhid+"' and  mm.doc_no in ("+reqmasterdocno+") "+condtn+"  group by d.stockid,d.prdId"+joinsqls+"  "
						+ " having sum(d.qty)-(sum(d.out_qty))>0  order by dd.date";
 
				
//				System.out.println("sql---"+sqls);
				
				
			ResultSet resultSet = stmtVeh.executeQuery (sqls);
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
	
	
	
	
 
	
/*	public   JSONArray reloadserv(String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice,qty,total,discount,nettotal from my_srvser  where rdocno='"+doc+"' ");
	      	System.out.println("========"+pySql);
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
	}*/
	
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa) throws SQLException {

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
	      
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{	
			
				Statement stmtmain = conn.createStatement ();  
				


				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.nettotal netamount,m.description desc1 from "
	        			+ " my_srrm m left join my_head h on h.doc_no=m.acno   where m.status=3 and m.brhid='"+brcid+"' "+sqltest );
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










	public       ClspurchaseinvoicereturnBean getViewDetails(int masterdoc_no) throws SQLException {
	
		ClspurchaseinvoicereturnBean showBean = new ClspurchaseinvoicereturnBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();   
		Statement stmt  = conn.createStatement ();
		
		String sqls="select coalesce(m.billtype,1) billtype,m.exptotal,m.rdtype,if(m.rdtype='PIV',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate,m.locid,m.refinvDate,m.refInvNo,l.loc_name   \r\n" + 
				" from my_srrm m left join my_head h on h.doc_no=m.acno  left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+masterdoc_no+"' ";
		
		
		
	//	System.out.println("----asdfghjjjhfdc------"+sqls);
		
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		String dtype="0";
		String reqdoc="0";
		while (resultSet.next()) {
		
			showBean.setDocno(resultSet.getInt("voc_no"));
			showBean.setBilltype(resultSet.getInt("billtype"));
			showBean.setMasterdate(resultSet.getString("date"));
			showBean.setDeliverydate(resultSet.getString("deldate"));
			showBean.setDelterms(resultSet.getString("delterms"));
			showBean.setPayterms(resultSet.getString("payterms"));
			showBean.setPurdesc(resultSet.getString("description"));
			
			showBean.setReqmasterdocno(resultSet.getString("rrefno"));
			
 
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
			showBean.setPrddiscount(resultSet.getDouble("prddiscount"));
		    showBean.setNetTotaldown(resultSet.getDouble("netAmount"));

		
		}
		int i=0;
		String reqvoc="";
		if(dtype.equalsIgnoreCase("PIV"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_srvm where doc_no in ("+reqdoc+")";
		//	System.out.println("==sqlss==="+sqlss);
			
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



	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String headacccode,String cmbbilltype) throws SQLException {

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
				
	  /*      	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk'   from my_reqm m    where m.status=3 and m.brhid='"+brcid+"'" );*/
	        	
	        	
/*					String pySql=("select * from (select sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
							+ "  from my_srvm m  left join    	my_srvd d on d.tr_no=m.tr_no  "
							+ "	 where m.status=3 and m.acno="+headacccode+" and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");*/
				//	System.out.println("====sssssssssssssssssssssssssssss===="+pySql);
					
					String pySql=(" select * from (select sum(d.qty-d.out_qty) qty,sum(ii.op_qty)-sum(ii.out_qty-ii.rsv_qty-ii.del_qty) bel_qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
							+ "  from my_srvm m  left join      my_srvd d on d.tr_no=m.tr_no "
							+ " left join   my_prddin  ii on  (ii.psrno=d.psrno and ii.specno=d.specno and ii.prdid=d.prdid and ii.brhid=m.brhid and ii.stockid=d.stockid  ) "
							+ " 	 where  m.status=3 and if(m.billtype=0,1,m.billtype)="+cmbbilltype+" and m.acno="+headacccode+" and m.brhid='"+brcid+"' "+sqltest+"  group by m.doc_no) as a having qty>0 ") ;
					
			 
					
			 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
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

	public   JSONArray reqgridreload(String doc,String from,HttpSession session,String dates,String cmbbilltype,String acno) throws SQLException {
		 
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
					
					
					String joinsql="";
					
					String fsql="";
					
					String outfsql="";
					
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
					 
						joinsqls1=",d.unitid,d.specno ";
					}
					
					
					
					
					
 
/*					 
					pySql="select 'pro' checktype,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,if(mm.rdtype='GRN',0,dd.foc-dd.foc_out) foc, "
							+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out) )  qty, "
							+ " sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) qutval,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) saveqty  "
							+ "  from  my_srvm  mm left join my_srvd d  on mm.tr_no=d.tr_no  left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid  "
							+ " and d.psrno=dd.psrno and  d.specno=dd.specno  left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) where  mm.doc_no  in ("+doc+")   "
							+ " group by d.stockid  having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0  ";
					
					*/
					pySql="select "+fsql+" bd.brandname,'pro' checktype,if(mm.rdtype='GRN',0,d.foc-d.foc_out) maxfoc,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,dd.dtype rdtype,  "
							+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.out_qty) pqty,sum(d.qty) mainqty, "
							+ " sum(d.qty)-sum(d.out_qty)  qty, "
							+ " sum(d.qty)-sum(d.out_qty) qutval,sum(d.qty)-sum(d.out_qty)  saveqty,d.amount unitprice,d.amount*(sum(d.qty)-sum(d.out_qty))   total, "
							+ "d.amount*(sum(d.qty)-sum(d.out_qty))*d.disper/100 discount, "
							+ "	d.disper discper,(d.amount*(sum(d.qty)-sum(d.out_qty)))-(d.amount*(sum(d.qty)-sum(d.out_qty))*d.disper/100) nettotal "
							+ "	  from  my_srvm  mm left join my_srvd d  on mm.tr_no=d.tr_no  left join my_prddin dd on dd.stockid=d.stockid   "
							+ " and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no   "
							+ "		"+joinsql+"   where  mm.doc_no in ("+doc+")     group by d.stockid"+joinsqls1+"   having sum(d.qty)-(sum(d.out_qty))>0  ";
					
					 
					 
					// System.out.println("----pySql----"+pySql);
					 
						
						ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
					 
					
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
	
	public   JSONArray maingridreload(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
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
					  joinsqls1=" and dd.unitid=d.unitid and  dd.specno=d.specno ";
					
				}
 
/*				
				String pySql="select dd.date,d.stockid,dd.op_qty,dd.out_qty,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname, "
						+ " d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, u.unit, d.unitid unitdocno, 	 "
						+ "if(m1.rdtype='DIR',0,sum(((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty+dd.foc-dd.foc_out)+d.qty))) qutval,  "
						+ "  if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)-d.qty)) pqty,  "
						+ " if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out))) saveqty,  "
						+ "	d.qty,d.qty oldqty,d.amount unitprice,d.total,d.discount,d.nettotal from my_srrm m1  left join my_srrd d on m1.tr_no=d.tr_no "
						+ "  left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "  left join   my_prddin  dd on   dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid  "
						+ "  where  m1.doc_no='"+doc+"' group by  dd.stockid,dd.prdid order by dd.date";
				*/
				
	 
/*				
				String pySql="select bd.brandname,dd.dtype rdtype,if(dd.dtype='GRN',0,sum(dd.foc-dd.foc_out)+d.foc) maxfoc,dd.date,d.stockid,at.mspecno as specid, "
						+ " m1.rrefno,m.part_no productid,m.productname,d.foc ,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
						+ " u.unit, d.unitid unitdocno, 	if(m1.rdtype='DIR',0,sum(((((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty+dd.foc-dd.foc_out))/dd.fr)+d.qty))) qutval, "
						+ " if(m1.rdtype='DIR',0,sum(((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)/dd.fr)-d.qty)) pqty, "
						+ " if(m1.rdtype='DIR',0,(sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)/dd.fr))) saveqty, "
						+ " if(m1.rdtype='DIR',0,(sum(dd.op_qty-dd.foc)/dd.fr)) mainqty,d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.disper discper, "
						+ " d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount from my_srrm m1  left join my_srrd d on m1.tr_no=d.tr_no  left join my_main m on m.doc_no=d.prdId "
						+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no   left join   my_prddin  dd on   "
						+ " dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid "+joinsqls1+"   where m1.doc_no='"+doc+"' group by  "
						+ " d.stockid,d.prdid"+joinsqls+" order by dd.date";*/
				
				 
				String pySql="select bd.brandname,dd.dtype rdtype,if(dd.dtype='GRN',0,sum(dd.foc-dd.foc_out)+d.foc) maxfoc,dd.date,d.stockid,at.mspecno as specid, "
						+ " m1.rrefno,m.part_no productid,m.productname,d.foc ,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
						+ " u.unit, d.unitid unitdocno, 	if(m1.rdtype='DIR',0,(pd.qty-pd.out_qty)+d.qty) qutval, "
						+ " if(m1.rdtype='DIR',0,sum(((dd.out_qty+dd.del_qty+dd.rsv_qty-dd.foc_out)/dd.fr)-d.qty)) pqty, "
						+ " if(m1.rdtype='DIR',0,(sum((dd.out_qty+dd.del_qty+dd.rsv_qty-dd.foc_out)/dd.fr))) saveqty, "
						+ " if(m1.rdtype='DIR',0,(sum(dd.op_qty-dd.foc)/dd.fr)) mainqty,d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.disper discper, "
						+ " d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount from my_srrm m1  left join my_srrd d on m1.tr_no=d.tr_no"
						+ "  left join my_main m on m.doc_no=d.prdId left join my_srvd pd on pd.stockid=d.stockid "
						+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no   left join   my_prddin  dd on   "
						+ " dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid "+joinsqls1+"   where m1.doc_no='"+doc+"' group by  "
						+ " d.rowno,d.prdid"+joinsqls+" order by dd.date";

				
            System.out.println("---------pySql----"+pySql);
				
				
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
				
 
				
				
				
				
     //        System.out.println("---------pySql----"+pySql);
				
				
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

			String sql="select h.Description accountname,h.account,p.acno accountdono,p.doc_no descsrno,p.desc1,s.qty,s.unitprice,s.total,s.discount,s.nettotal from my_srvexp s "
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






	public     ClspurchaseinvoicereturnBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClspurchaseinvoicereturnBean bean = new ClspurchaseinvoicereturnBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();

				
				String resql=("select ac.trnnumber,m.rdtype,if(m.rdtype='GRN',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct','Goods Receipt Note') type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper , \r\n" + 
				" m.discount,m.roundVal,round(m.netTotal+nettotaltax,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,round(m.exptotal,2) exptotal, l.loc_name, "
				+ " m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_srrm m left join my_head h on h.doc_no=m.acno left join my_acbook ac on h.doc_no=ac.acno and ac.dtype='VND' left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");
				
				
				
				System.out.println("--resql-"+resql);
				

				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
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
			    	    bean.setLblloc(pintrs.getString("loc_name"));
			    	    bean.setTrnnumber(pintrs.getString("trnnumber"));
			        
			    	    bean.setLbltotal(pintrs.getString("netAmount"));
					    bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("netAmount")));
			    		  		/* bean.setLblsubtotal(pintrs.getString("supplExp"));
			    	    
			    	    bean.setLblsubtotalexp(pintrs.getString("exptotal"));
			    	    
			    	    
			            bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	     
			    	    
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));*/
			    	    
			    	    
			    	    
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srrm r  "
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
	       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper,"
				       		+ "  round(d.taxper,2) taxper,round(d.taxamount,2) taxamount,round(d.nettotal+d.taxamount,2) nettaxamount  from my_srrd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      System.out.println("==strSqldetail=="+strSqldetail);
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") 
						    +"::"+rsdetail.getString("taxper")+"::"+rsdetail.getString("taxamount")+"::"+rsdetail.getString("nettaxamount");
							arr.add(temp);
							rowcount++;
			              // bean.setFirstarray(1);
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					

					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 


	

		

}
