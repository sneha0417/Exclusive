package com.procurement.purchase.goodsreceiptnotereturn;

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
 


public class ClsgoodsreceiptnotereturnDAO {

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	

	Connection conn;
	public int insert(Date masterdate, Date deldate, String refno, int vendocno,
			int cmbcurr, double currate, String delterms, String payterms,
			String purdesc, double productTotal, double descPercentage,
			double descountVal, double roundOf, double netTotaldown,
			double servnettotal, double orderValue, int chkdiscount,
			HttpSession session, String mode,  
			String formdetailcode, HttpServletRequest request, 
			ArrayList <String> masterarray, String reftype, String rrefno, double prddiscount, int locationid) throws SQLException  {
		 
	
		
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnotereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtgrn.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtgrn.registerOutParameter(24, java.sql.Types.INTEGER);
 
			stmtgrn.setDate(1,masterdate);
			stmtgrn.setDate(2,deldate);
			stmtgrn.setString(3,refno);
			stmtgrn.setInt(4,vendocno);
		   	stmtgrn.setInt(5,cmbcurr);
			stmtgrn.setDouble(6,currate);
			stmtgrn.setString(7,delterms); 
			stmtgrn.setString(8,payterms);
			stmtgrn.setString(9,purdesc);
			stmtgrn.setDouble(10,0);
			stmtgrn.setDouble(11,0);
			stmtgrn.setDouble(12,0);
			stmtgrn.setDouble(13,0);
			stmtgrn.setDouble(14,0);
			stmtgrn.setDouble(15,0);
			stmtgrn.setDouble(16,0);
			stmtgrn.setString(17,session.getAttribute("USERID").toString());
			stmtgrn.setString(18,session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(19,session.getAttribute("COMPANYID").toString());
			
			
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(21,formdetailcode);
			stmtgrn.setString(22,mode);
			stmtgrn.setInt(23,chkdiscount);
			stmtgrn.setString(25,reftype);
			stmtgrn.setString(26,rrefno);
			stmtgrn.setDouble(27,prddiscount);
			
			stmtgrn.setInt(28,locationid);
	 
			
			stmtgrn.executeQuery();
			docno=stmtgrn.getInt("docNo");
	 
			int vocno=stmtgrn.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_grrm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			
			for(int i=0;i< masterarray.size();i++){
		    	
				
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     
				     if(chkqty>0){
				    	 
				    	 
/*						 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
								   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "); */
				    	 
				    	 String specnos=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
					     String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
					     
					     
					     
					     String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
					     
					     
					     double fr=1;
					     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
					     
					   //  System.out.println("====slss==="+slss);
					     ResultSet rv1=stmtgrn.executeQuery(slss);
					     if(rv1.next())
					     {
					    	 fr=rv1.getDouble("fr"); 
					     }
					     
					     String sql="INSERT INTO my_grrd(sr_no,psrno,prdId,unitid,qty,specno,foc,stockid,tr_no,rdocno,fr)VALUES"
							       + " ("+(i+1)+","
							     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
							       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
							       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
							      + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
							      + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
							        + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
							      +"'"+mastertr_no+"','"+docno+"',"+fr+")";
					 	 
					     

//System.out.println("=====sql=="+sql);
					     
					     
			    	
/*			    	 
		     String sql="INSERT INTO my_grnd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,tr_no)VALUES"
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
                       +"'"+mastertr_no+"')";*/
		 
			 	     int resultSet2 = stmtgrn.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				  
				     
				    // rrefno
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				 
				     
				     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    
				     String  foc=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")|| detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				     
			 
				     double paidqty=Double.parseDouble(paidqtyd);
				     
				     double focqty=Double.parseDouble(foc);
				   //  System.out.println("--paidqty-----"+paidqty);
				     
				 //    System.out.println("--focqty-----"+focqty);
				     double totalordoutqty=paidqty+focqty;
				   //  System.out.println("--totalordoutqty-----"+totalordoutqty);	   
				     if(reftype.equalsIgnoreCase("GRN"))
			         {
				    	 
				    	 
				    	 
				    	 
				    	 
				    	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
				    	 
				    	 
			 
			//save qty
				    	 String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
										     
					     
					     double masterqty=Double.parseDouble(rqty); 
					     
					     
					     String specno=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
					    
					     
					     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					     
				   		 
				    	   double balqty=0;
						 
				             int tr_no=0;
							double remqty=0;
							double out_qty=0;
								double qty=0;
								
								double grnout=0;
								
								 double foc_out=0;
								 double foc_outqty=0;
								double grnsaveqty=0; 
								double prddinsaveqty=0;
								int unitid=0;
								int spec=0;
				    	 Statement stmt=conn.createStatement();
	 
				    	 
				    	String  stockid=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				    	 
				
						     
				    	
				    	 String strSql="select dd.tr_no,dd.psrno,d.unitid,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty)/sum(dd.fr) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/sum(dd.fr) balstkqty,sum(dd.out_qty)/sum(dd.fr) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
									+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.unitid="+unitids+" and dd.prdid='"+prdid+"' and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
											+ "group by dd.stockid,dd.psrno,dd.prdid having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0 order by dd.date";
				    	 
		 
                             System.out.println("-----strSql---"+strSql);
				    	 
				 
				    		ResultSet rs = stmt.executeQuery(strSql);
				     
				    
				    		while(rs.next()) {
				    			 
				    			
								balqty=rs.getDouble("balstkqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");
								foc_out=rs.getInt("foc_out");
								//stockid=rs.getInt("stockid");
								qty=rs.getDouble("qty");
								grnout=rs.getDouble("grnout");
								unitid=rs.getInt("unitid");
								spec=rs.getInt("specno");
							//System.out.println("---masterqty-----"+masterqty);	
							
							//System.out.println("---grnout-----"+grnout);	
							//System.out.println("---out_qty-----"+out_qty);	

						

								if(masterqty<=balqty)
								{
									
									grnsaveqty=masterqty+grnout;
									foc_outqty=foc_out+focqty;
									String sqls="update my_grnd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"  and unitid="+unitid+" and specno="+spec+"  ";
									

								 	System.out.println("--1---sqls---"+sqls);


									stmtgrn.executeUpdate(sqls);
									prddinsaveqty=(masterqty+focqty)+out_qty;
									
	                              	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty*fr+",foc_out='"+foc_outqty*fr+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									

								 	System.out.println("--1---prdinsqls---"+prdinsqls);


									stmtgrn.executeUpdate(prdinsqls);
									
			
										
									String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid,foc,date,brhid,locid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+totalordoutqty*fr+"','"+docno+"','"+prdid+"','"+focqty*fr+"','"+masterdate+"','"+session.getAttribute("BRANCHID").toString()+"','"+locationid+"')";
									
									stmtgrn.executeUpdate(insertsql);
									
									 System.out.println("--1---insertsql---"+insertsql);
									
									
									break;


								}
								/*else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											System.out.println("---remqty-1---"+remqty);
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
										System.out.println("---masterqty--"+masterqty);
										
										System.out.println("---balqty--"+balqty);
										
										
										System.out.println("---remqty--2--"+remqty);
									}


									String sqls="update my_grnd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
									System.out.println("-2----sqls---"+sqls);

									stmtgrn.executeUpdate(sqls);	

								 
									String prdinsqls="update my_prddin set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
									System.out.println("-2----prdinsqls---"+prdinsqls);

									stmtgrn.executeUpdate(prdinsqls);	

									
									String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+prddoutqty+"','"+docno+"','"+prdid+"')";
									
									stmtgrn.executeUpdate(insertsql);

								} //else if
*/
				    		 
				    			
				    	  		}  // while
				    	 
				     		     
				     
				    	   }
					
				     
				 
			            }	   
			            }
			     
			     
			     
			     
			     
		 
			     
			     
			     
				     
				     }//main for
			
 
			
 
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtgrn.close();
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
			  ArrayList<String> masterarray,  String reftype,
			String rrefno, double prddiscount, int locationid, String updatadata) throws SQLException {
	 
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnotereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtgrn.setInt(20,masterdoc_no);
			stmtgrn.setInt(24, 0);
 
			stmtgrn.setDate(1,masterdate);
			stmtgrn.setDate(2,deldate);
			stmtgrn.setString(3,refno);
			stmtgrn.setInt(4,vendocno);
		   	stmtgrn.setInt(5,cmbcurr);
			stmtgrn.setDouble(6,currate);
			stmtgrn.setString(7,delterms); 
			stmtgrn.setString(8,payterms);
			stmtgrn.setString(9,purdesc);
			stmtgrn.setDouble(10,0);
			stmtgrn.setDouble(11,0);
			stmtgrn.setDouble(12,0);
			stmtgrn.setDouble(13,0);
			stmtgrn.setDouble(14,0);
			stmtgrn.setDouble(15,0);
			stmtgrn.setDouble(16,0);
			stmtgrn.setString(17,session.getAttribute("USERID").toString());
			stmtgrn.setString(18,session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(21,formdetailcode);
			stmtgrn.setString(22,mode);
			stmtgrn.setInt(23,chkdiscount);
			stmtgrn.setString(25,reftype);
			stmtgrn.setString(26,rrefno);
			stmtgrn.setDouble(27,prddiscount);
			stmtgrn.setInt(28,locationid);
		 
			
		    int res=stmtgrn.executeUpdate();
			docno=stmtgrn.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			System.out.println("-updatadata--"+updatadata);
			
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_grrm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			
			
			
			if(!(updatadata.equalsIgnoreCase("Editvalue")))
			{	
				String sqlsss="update my_prddout set date='"+masterdate+"',brhid='"+session.getAttribute("BRANCHID").toString()+"',locid='"+locationid+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"'" ;
				stmtgrn.executeUpdate(sqlsss);
			}
			
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{	
			
				//System.out.println("-in--");
			
			
			
			
			
			
			String delsqls="delete from my_grrd where tr_no='"+mastertr_no+"' ";
			stmtgrn.executeUpdate(delsqls);
 
			
		
			   String stockstore="0";
	    	int	updateid=0;
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     if(chkqty>0){
			    	 
			    	 
					    	 String specnos=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
						     String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
						     
						     
						     
						     String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
						     
						     
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
						     
						    // System.out.println("====slss==="+slss);
						     ResultSet rv1=stmtgrn.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
						     
						   //  System.out.println("====fr==="+fr);
						     
						     
					    	 
					    	 
						     String sql="INSERT INTO my_grrd(sr_no,psrno,prdId,unitid,qty,specno,foc,stockid,tr_no,rdocno,fr)VALUES"
								       + " ("+(i+1)+","
								     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
								       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
								       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
								       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
								      + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
								      + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
								        + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
								      +"'"+mastertr_no+"','"+docno+"',"+fr+")";
						 	 
						     int resultSet10 = stmtgrn.executeUpdate(sql);
						     if(resultSet10<=0)
								{
									conn.close();
									return 0;
									
								}
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					    
				     String  foc=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")|| detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				     
				     
				     double paidqty=Double.parseDouble(paidqtyd);
				     
				     double focqty=Double.parseDouble(foc);
	 
				     double totalordoutqty=paidqty+focqty;
 
				     if(reftype.equalsIgnoreCase("GRN"))
			         {
				    	 
				    	 
				    	 
				    	 
				    	 
				    	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
				    	 
				    	 
			 
			//save qty
				    	 String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
										     
					     
					     double masterqty=Double.parseDouble(rqty); 
					     
					     
					     String specno=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
					    
					     
					     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					     
				   		 
				    	   double balqty=0;
						 
				             int tr_no=0;
							double remqty=0;
							double out_qty=0;
								double qty=0;
			                    double grnout=0;
			                    double foc_outqty=0;
			                	double foc_outval=0;
			                    
								double grnsaveqty=0; 
								double prddinsaveqty=0;
								int unitid=0;
								int spec=0;
				    	 Statement stmt=conn.createStatement();
	 
				    	 
				    	String  stockid=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				    	String oldqtys=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				    	String oldfocs=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
				    	
				    	  double oldfoc=Double.parseDouble(oldfocs); 
				    	
				    	  double oldqty=Double.parseDouble(oldqtys); 
				    	  double currqty=Double.parseDouble(prddoutqty); 
				    	  
				    	   	 String strSql="select dd.tr_no,dd.psrno,d.unitid,d.specno,sum(d.foc_out) foc_out,sum(dd.op_qty)/sum(dd.fr) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))/sum(dd.fr) balstkqty,sum(dd.out_qty)/sum(dd.fr) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
										+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"'and dd.unitid="+unitids+" and dd.prdid='"+prdid+"'  "
												+ " and dd.brhid="+session.getAttribute("BRANCHID").toString()+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid   order by dd.date";
					    	 
			 
		 
                             System.out.println("-----strSql---"+strSql);
				    	 
				 
				    		ResultSet rs = stmt.executeQuery(strSql);
				     
				    
				    		while(rs.next()) {
				    			 
				    			
				    			
										balqty=rs.getDouble("balstkqty");
										tr_no=rs.getInt("tr_no");
										out_qty=rs.getDouble("out_qty");

										//stockid=rs.getInt("stockid");
										qty=rs.getDouble("qty");
										grnout=rs.getDouble("grnout");
										
										foc_outval=rs.getDouble("foc_out");
										unitid=rs.getInt("unitid");
										spec=rs.getInt("specno");
										
									//System.out.println("---masterqty-----"+masterqty);	
									
									//System.out.println("---grnout-----"+grnout);	
									//System.out.println("---out_qty-----"+out_qty);	
				 
						 

						/*		if(masterqty<=balqty)
								{
									masterqty=masterqty;*/

									
									
									
									
					/*				String sqls="update my_grnd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									stmtgrn.executeUpdate(sqls);*/
									
								       grnsaveqty=(currqty+grnout)-oldqty;
									
									//System.out.println("-grnsaveqty---"+grnsaveqty);
									
									
								     foc_outqty=(focqty+foc_outval)-oldfoc;
                             
									
									String sqls="update my_grnd set out_qty="+grnsaveqty+",foc_out='"+foc_outqty+"'  where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"  and unitid="+unitid+" and specno="+spec+"  ";
									

									 System.out.println("--1---sqls---"+sqls);


									stmtgrn.executeUpdate(sqls);
									
									
									prddinsaveqty=(currqty+out_qty+focqty-oldfoc)-oldqty;
									
									//System.out.println("-prddinsaveqty---"+prddinsaveqty);
									
									
	                              	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty*fr+",foc_out='"+foc_outqty*fr+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									

									 System.out.println("--1---prdinsqls---"+prdinsqls);


									stmtgrn.executeUpdate(prdinsqls);
									
										
								 
									String insertsql="update my_prddout set qty='"+totalordoutqty*fr+"',foc='"+foc_outqty*fr+"',date='"+masterdate+"',brhid='"+session.getAttribute("BRANCHID").toString()+"',locid='"+locationid+"'  where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stockid='"+stockid+"'";
									
									 System.out.println("--1---insertsql---"+insertsql);
									stmtgrn.executeUpdate(insertsql);
									break;
									
								
									
								/*	


								}*/
								/*else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											System.out.println("---remqty-1---"+remqty);
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
										System.out.println("---masterqty--"+masterqty);
										
										System.out.println("---balqty--"+balqty);
										
										
										System.out.println("---remqty--2--"+remqty);
									}


									String sqls="update my_grnd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
									System.out.println("-2----sqls---"+sqls);

									stmtgrn.executeUpdate(sqls);	

								 
									String prdinsqls="update my_prddin set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
									System.out.println("-2----prdinsqls---"+prdinsqls);

									stmtgrn.executeUpdate(prdinsqls);	

									
									String insertsql="update my_prddout set qty='"+prddoutqty+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stkid='"+stockid+"'";
									
									
									stmtgrn.executeUpdate(insertsql);
									
									System.out.println("--1---insertsql---"+insertsql);

								} //else if
*/
				    		 
				    			
				    	  		}  // while
				    	  
				  /*   if(reftype.equalsIgnoreCase("GRN"))
			         {
				    	 
	                        String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
					     
					     
					     
					       double masterqty=Double.parseDouble(rqty); 
					     
				    	 
					    	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
					    	 
					    	 
				 
				//save qty
					    	 
						     String specno=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
						     
					     
						     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						     
					   		 
				    		 
						 int pridforchk=Integer.parseInt(prdid);
				    	 
				
					    		 
					    		 if(pridforchk!=updateid)
					    		 {
					    		 
					 			String sqls="update  my_ordd set out_qty=0 where tr_no in ("+rrefno+") and prdid="+pridforchk+" ";
			  
			    			  System.out.println("-----"+sqls);
			    			   	
			    			  stmtgrn.executeUpdate(sqls);
			    				
			    				updateid=pridforchk;
					    		 
					    		 }
				   		 


						  
						     
						     
						     
							   double balqty=0;
								int stockid=0;
					             int tr_no=0;
								double remqty=0;
								double out_qty=0;
									double qty=0;
						    	 
						    	 Statement stmt=conn.createStatement();
		 
						    	 
						 
						    	 
						    	 String strSql="select tr_no,stockid,psrno,specno,sum(op_qty) qty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,date from my_prddin "
											+ "where psrno='"+psrno+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and stockid not in("+stockstore+") "
													+ "group by stockid,psrno,prdid  order by date";
						    	 
						    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty  from my_grnm m  left join  my_grnd d on m.tr_no=d.tr_no where \r\n" + 
						    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
						    	 
		                             System.out.println("-----strSql---"+strSql);
						    	 
						 
						    		ResultSet rs = stmt.executeQuery(strSql);
						     int onetimeupdate=0;
						    
						    		while(rs.next()) {
						    			 
						    			balqty=rs.getDouble("balstkqty");
										tr_no=rs.getInt("tr_no");
										out_qty=rs.getDouble("out_qty");

										stockid=rs.getInt("stockid");
										qty=rs.getDouble("qty");
									
										
						    			if(onetimeupdate==0)
						    			{
		                                    String zerosqls="update my_grnd set out_qty=0 where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
											System.out.println("--1---zerosqls---"+zerosqls);
          									stmtgrn.executeUpdate(zerosqls);
								 
											
											
											
						    				
						    				
						    			}
						    			onetimeupdate=onetimeupdate+1;
						    			
								

								
						    			 
										if(remqty>0)
										{

											masterqty=remqty;
										}


										
										
										System.out.println("---masterqty-----"+masterqty);	

										System.out.println("---balqty-----"+balqty);	

										System.out.println("---out_qty-----"+out_qty);	
										System.out.println("---qty-----"+qty);
										System.out.println("---stockid-----"+stockid);
										
										System.out.println("---prddoutqty-----"+prddoutqty);
										
										
										if(masterqty<=qty)
										{
											//masterqty=masterqty+out_qty;
											
											stockstore=stockstore+","+stockid;
											
											System.out.println("---in master qty-----"+masterqty);	

											
											String sqls="update my_grnd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
											

											System.out.println("--1---sqls---"+sqls);


											stmtgrn.executeUpdate(sqls);
											
											
											String prdinsqls="update my_prddin set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
											

											System.out.println("--1---prdinsqls---"+prdinsqls);


											stmtgrn.executeUpdate(prdinsqls);
											
												
								 
											
											String insertsql="update my_prddout set qty='"+prddoutqty+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stkid='"+stockid+"'";
								
											
											stmtgrn.executeUpdate(insertsql);
											
											System.out.println("--1---insertsql---"+insertsql);
											
							 
                                           break;

										}
										
										
									 
										
										else if(masterqty>balqty)
										{



											if(qty>=(masterqty+out_qty))

											{
												balqty=masterqty+out_qty;	
												remqty=qty-out_qty;

													System.out.println("---remqty-1---"+remqty);
											}
											else
											{
												
												
												remqty=masterqty-balqty;
												balqty=qty;
												
											   
											}


											String sqls="update my_grnd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
											System.out.println("-2----sqls---"+sqls);

											stmtgrn.executeUpdate(sqls);	

										 
											String prdinsqls="update my_prddin set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";	
											System.out.println("-2----prdinsqls---"+prdinsqls);

											stmtgrn.executeUpdate(prdinsqls);	

											
											String insertsql="update my_prddout set qty='"+prddoutqty+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' and specid='"+specno+"' and psrno='"+psrno+"' and stkid='"+stockid+"'";
											
											stmtgrn.executeUpdate(insertsql);
											
											
											System.out.println("-----insertsql-----"+insertsql);

										} //else if

						    		 
						    			
						    	  		}  // while
						    	 */
				    	 
				     
				    	 
			 
				     
				     
				     
				    	 }
					
						     
			         }
				     
				    	     
				   				     
			     
				     
				     }}
			
			}
		 
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtgrn.close();
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
			 
				CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnotereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtgrn.setInt(20,masterdoc_no);
			stmtgrn.setInt(24, 0);
 
			stmtgrn.setDate(1,null);
			stmtgrn.setDate(2,null);
			stmtgrn.setString(3,null);
			stmtgrn.setInt(4,0);
		   	stmtgrn.setInt(5,0);
			stmtgrn.setDouble(6,0);
			stmtgrn.setString(7,null); 
			stmtgrn.setString(8,null);
			stmtgrn.setString(9,null);
			stmtgrn.setDouble(10,0);
			stmtgrn.setDouble(11,0);
			stmtgrn.setDouble(12,0);
			stmtgrn.setDouble(13,0);
			stmtgrn.setDouble(14,0);
			stmtgrn.setDouble(15,0);
			stmtgrn.setDouble(16,0);
			stmtgrn.setString(17,session.getAttribute("USERID").toString());
			stmtgrn.setString(18,session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtgrn.setString(21,formdetailcode);
			stmtgrn.setString(22,mode);
			stmtgrn.setInt(23,0);
			stmtgrn.setString(25,"0");
			stmtgrn.setString(26,"0");
			stmtgrn.setDouble(27,0);
			stmtgrn.setInt(28,0);
 
			
			
		    int res=stmtgrn.executeUpdate();
			docno=stmtgrn.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if (res > 0) {
			 
				stmtgrn.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	}








 
	
/*	

	public   JSONArray searchProduct() throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	   
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
				
				
				
				
			
			String fleetsql=("select "+method+" method,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join my_unitm u on m.munit=u.doc_no where m.status=3");
		// System.out.println("-----fleetsql---"+fleetsql);
			ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
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
	}*/
	
	
	
	

 
	
	
	
	
	
	
	public   JSONArray maingridreload(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
				String sqltest="0";
				
				
				if(reftype.equalsIgnoreCase("GRN"))
				
				
				
				{
					
					sqltest=reqdocno;
				}
				
 
				Statement stmt31 = conn.createStatement (); 
				 int mulqty=0;
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
					 joinsqls=",dd.unitid,dd.specno ";
					  joinsqls1=" and dd.unitid=d.unitid  ";
					
				}
				

		/*		String pySql="select d.stockid,dd.op_qty,dd.out_qty,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
						+ " u.unit, d.unitid unitdocno,	if(m1.rdtype='DIR',0,sum(((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty)+d.qty))) qutval, "
						+ "  if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty)-d.qty)) pqty,	  if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty))) saveqty,  "
						+ "d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_grrm m1  left join my_grrd d on m1.tr_no=d.tr_no "
						+ "  left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "  left join   my_prddin  dd on   dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid    where m1.doc_no='"+doc+"' group by  dd.stockid order by dd.date";
				*/
///*				String pySql="select  mainqty dd.dtype rdtype,if(dd.dtype='GRN',0,sum(dd.foc-dd.foc_out)+d.foc) maxfoc,dd.date,d.stockid,at.mspecno as specid, "
//						+ " m1.rrefno,m.part_no productid,m.productname,d.foc ,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
//						+ " u.unit, d.unitid unitdocno, 	if(m1.rdtype='DIR',0,sum(((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty+dd.foc-dd.foc_out)+d.qty))) qutval,  "
//						+ " if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)-d.qty)) pqty, "
//						+ "  if(m1.rdtype='DIR',0,sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out))) saveqty,  "
//						+ " if(m1.rdtype='DIR',0,sum(dd.op_qty-dd.foc)) mainqty,d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.disper discper, "
//						+ " d.total,d.discount,d.nettotal from my_srrm m1  left join my_srrd d on m1.tr_no=d.tr_no  left join my_main m on m.doc_no=d.prdId "
//						+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join   my_prddin  dd on   "
//						+ " dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid   where m1.doc_no='"+doc+"' group by  "
//						+ " dd.stockid,dd.prdid order by dd.date";*/

 
				String pySql="select bd.brandname,dd.date,d.stockid,dd.op_qty,dd.out_qty,if(dd.dtype='DIR',0,(sum(dd.foc-dd.foc_out)/sum(dd.fr))+d.foc) maxfoc, "
						+ " at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,  "
						+ "m.productname proname, "
						+ " u.unit, d.unitid unitdocno, 	if(m1.rdtype='DIR',0,(((sum((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty+dd.foc-dd.foc_out)))/sum(dd.fr))+d.qty)) qutval, "
						+ "  if(m1.rdtype='DIR',0,((sum(dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)/sum(dd.fr))-d.qty))  pqty,  "
						+ "  if(m1.rdtype='DIR',0,(sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out))/sum(dd.fr))) saveqty, "
						+ " if(m1.rdtype='DIR',0,(sum(dd.op_qty-dd.foc)/sum(dd.fr))) mainqty,"
						+ "	d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.total,d.discount,d.nettotal from my_grrm m1  left join my_grrd d on m1.tr_no=d.tr_no "
						+ "  left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "    left join   my_prddin  dd on   dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m1.brhid=dd.brhid "+joinsqls1+"  "
						+ "   where  m1.doc_no='"+doc+"' group by  dd.stockid"+joinsqls+" order by dd.date,d.rowno";
				
				//System.out.println("----pySql---"+pySql);
/*				
				String pySql="select m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
						"				u.unit, d.unitid unitdocno,\r\n" + 
						"				if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_reqd  where tr_no in (1,2) and prdid=d.prdid)-\r\n" + 
						"				(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (1,2) and prdid=d.prdid)+d.qty)) qutval,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (1,2) and prdid=d.prdid)-d.qty) pqty,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in (1,2) and prdid=d.prdid)) saveqty,\r\n" + 
 						"				d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no\r\n" + 
						"				 left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.tr_no='"+nidoc+"'";
				*/
				
				//System.out.println("--pySql----"+pySql);
				
				
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);
				
				
				
		/*		String pySql="	select m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
						"				u.unit, d.unitid unitdocno,\r\n" + 
						"				if(m1.rdtype='DIR',0,((select sum(qty) from  my_reqd h where tr_no in (m1.rrefno) and prdid=d.prdid)-(select sum(qty) from  my_ordd  where tr_no in (m1.rrefno) and prdid=d.prdid)+d.qty)) qutval,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select sum(out_qty) from  my_reqd  where tr_no in (rrefno) and prdid=d.prdid)) pqty,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select sum(out_qty) from  my_reqd  where tr_no in (rrefno) and prdid=d.prdid)) saveqty,\r\n" + 
						"				d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_ordm m1  left join my_ordd d on m1.tr_no=d.tr_no\r\n" + 
						"				 left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.tr_no='"+nidoc+"' ";
				
			
	     	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);*/

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
	
	public   JSONArray reloadserv(String nidoc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice,qty,total,discount,nettotal from my_ordser  where tr_no='"+nidoc+"' ");
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
				
				

				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.nettotal netamount, m.refno,m.description desc1 from my_grrm m "
	        			+ " left join my_head h on h.doc_no=m.acno   where m.status=3 and m.brhid='"+brcid+"' "+sqltest );
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










	public     ClsgoodsreceiptnotereturnBean   getViewDetails(int masterdoc_no) throws SQLException {
	
		ClsgoodsreceiptnotereturnBean showBean = new ClsgoodsreceiptnotereturnBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		
		String sqls="select m.refinvDate, m.refInvNo,m.rdtype,if(m.rdtype='GRN',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs, "
				+ "	h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper,  "
				+ "	 m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate,l.loc_name,m.locid "
				+ "		from my_grrm m left join my_head h on h.doc_no=m.acno  left join my_locm l on l.doc_no=m.locid where  m.doc_no='"+masterdoc_no+"'";
		
		
		//System.out.println("---sqls-----"+sqls);
		ResultSet resultSet = stmt.executeQuery(sqls);
		String dtype="0";
		String reqdoc="0";
		while (resultSet.next()) {
		
			showBean.setDocno(resultSet.getInt("voc_no"));
			showBean.setInvdate(resultSet.getString("refinvDate"));
			showBean.setInvno(resultSet.getString("refInvNo"));
			
		
			showBean.setMasterdate(resultSet.getString("date"));
			showBean.setDeliverydate(resultSet.getString("deldate"));
			showBean.setDelterms(resultSet.getString("delterms"));
			showBean.setPayterms(resultSet.getString("payterms"));
			showBean.setPurdesc(resultSet.getString("description"));
			
			showBean.setRefmasterdoc_no(resultSet.getString("rrefno"));
		 
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
		
		
		
		
		
		
		
		stmt.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		return showBean;
	}


	
	
	public   JSONArray locationsearch() throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no from my_locm where status<>7;" );
 
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



	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String headacccode) throws SQLException {

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
    	
    	//  System.out.println( "======headacccode==="+headacccode);
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
	        	
				  	
					String pySql=("select * from (select sum(dd.op_qty-(dd.out_qty+dd.del_qty)) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
							+ "  from my_grnm m  left join    	my_grnd d on d.tr_no=m.tr_no  "
							+ "  left join my_prddin dd on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid "
							+ "	 where m.status=3  and m.acno="+headacccode+" and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
					
 
					
					
					System.out.println("pySql ===== "+pySql);
					
					
					
 
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

	public   JSONArray reqgridreload(HttpSession session, String doc,String from) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();      
				String pySql="";
				if(from.equalsIgnoreCase("pro"))
				{
					
				
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
						 joinsqls=",d.psrno,d.unitid,d.specno ";
						  joinsqls1=" and dd.unitid=d.unitid  ";
						
					}
						
					
 
/*		with out foc			
					pySql="select 'pro' checktype,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid , "
							+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty))  qty,  "
							+ " sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty)) qutval,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty))  "
							+ " saveqty  from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no  "
							+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
							+ "  left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ "  where  mm.doc_no in ("+doc+")     group by d.stockid  having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty))>0 ";*/
					
					//pqty mainqty maxfoc    foc
					pySql="select bd.brandname,'pro' checktype,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,sum(d.qty) mainqty,sum(dd.foc-dd.foc_out) maxfoc,"
							+ " sum(dd.foc-dd.foc_out)/sum(dd.fr) foc,sum(d.out_qty) pqty, "
							+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr)  qty,  "
							+ " sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr) qutval,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr)  "
							+ " saveqty  from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no  "
							+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "+joinsqls1+" "
							+ "  left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "  where  mm.doc_no in ("+doc+")     group by d.stockid"+joinsqls+"  having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0 ";
					
/*					pySql="select 'pro' pqty checktype,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid , "
							+ " mm.rdtype,if(mm.rdtype='GRN',0,dd.foc-dd.foc_out) foc,if(mm.rdtype='GRN',0,dd.foc-dd.foc_out) maxfoc,  "
							+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.out_qty) pqty,sum(d.qty) mainqty, "
							+ "sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))  qty, "
							+ " sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) qutval,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) saveqty  "
							+ " ,d.amount unitprice,d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))  total, "
							+ "d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))* d.disper/100 discount, "
							+ "	d.disper discper,(d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)))-(d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))*d.disper/100) nettotal "
							+ "	  from  my_srvm  mm left join my_srvd d  on mm.tr_no=d.tr_no  left join my_prddin dd on dd.stockid=d.stockid   "
							+ " and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno left join my_main m on m.doc_no=d.prdId  "
							+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)    "
							+ "		 where  mm.doc_no in ("+doc+")     group by d.stockid  having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0";*/
					
					
					//System.out.println("----pySql----"+pySql);
					/*
					 pySql=("select 'pro' checktype ,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n" + 
					 		"d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n" + 
					 		"sum(d.qty-d.out_qty) saveqty,\r\n" + 
					 		"sum(amount) unitprice,sum(d.qty-d.out_qty)*sum(amount)  total ,sum(discount) discount,\r\n" + 
					 		"(sum(d.qty-d.out_qty)*sum(amount))-sum(discount) nettotal from my_ordd d\r\n" + 
					 		"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  where d.tr_no in ("+doc+")  group by d.prdId   ");
					*/
					//System.out.println("----pySql----"+pySql);
					 
						
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
	

	
	

	public   JSONArray searchProduct(HttpSession session) throws SQLException {

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
				
				
				
			String fleetsql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno  "
					+ " from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)     where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ";
			
	/*		String fleetsql=("select "+method+" method,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join "
					+ " my_unitm u on m.munit=u.doc_no where m.status=3");*/
		// System.out.println("-----fleetsql---"+fleetsql);
			ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
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
	

	public   JSONArray searchorderProduct(String reqmasterdocno,HttpSession session) throws SQLException { 

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
				
				if(reqmasterdocno.equalsIgnoreCase("")) 
				{
					reqmasterdocno="0"; 
				}
				
	        
/*				
				String sqls="select  "+method+" method ,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno, "
						+ "  u.unit,m.munit, "
						+ "  sum(d.qty-d.out_qty)  mainqty,sum(dd.op_qty-(dd.out_qty+dd.del_qty+dd.rsv_qty))  qty,  "
						+ " sum(dd.op_qty-(dd.out_qty+dd.del_qty+dd.rsv_qty)) qutval,sum(dd.out_qty+dd.del_qty+dd.rsv_qty) pqty,   sum(dd.op_qty-(dd.out_qty+dd.del_qty+dd.rsv_qty)) saveqty  "
						+ "  from  my_grnm  mm left join  my_grnd d on mm.tr_no=d.tr_no	left join my_prddin dd  "
						+ "	 on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid "
						+ "  and mm.brhid=dd.brhid 	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  "
						+ "left join my_prodattrib at    on(at.mpsrno=m.doc_no)   where mm.status=3 and mm.brhid='"+brcid+"' and  mm.doc_no in ("+reqmasterdocno+")  "
						+ "  group by d.stockid,d.prdId having sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty)))>0  order by dd.date,d.rowno";*/
				
				
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
					  joinsqls1=" and dd.unitid=d.unitid  ";
					
				}
				
				String sqls="select  "+method+" method,bd.brandname,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,d.unitid munit,m.psrno, "
						+ "   sum(d.qty)/sum(dd.fr) mainqty,sum(dd.foc-dd.foc_out)/sum(dd.fr) foc,sum(dd.foc-dd.foc_out)/sum(dd.fr) maxfoc,"
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr)  qty,  "
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr) qutval,sum(d.out_qty)  pqty, "
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr) saveqty  "
						+ "  from  my_grnm  mm left join  my_grnd d on mm.tr_no=d.tr_no	left join my_prddin dd  "
						+ "	 on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid "+joinsqls1+" "
						+ "  and mm.brhid=dd.brhid 	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "  left join my_prodattrib at    on(at.mpsrno=m.doc_no)   where mm.status=3 and mm.brhid='"+brcid+"' and  mm.doc_no in ("+reqmasterdocno+")  "
						+ "  group by d.stockid,d.prdId"+joinsqls+" having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0  order by dd.date,d.rowno";
				
				
				
				
				/*String sqls="select  "+method+" method,bd.brandname,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno, "
						+ "  u.unit,m.munit, sum(d.qty) mainqty,sum(dd.foc-dd.foc_out) foc,sum(dd.foc-dd.foc_out) maxfoc,"
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))  qty,  "
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) qutval,sum(d.out_qty)  pqty, "
						+ "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) saveqty  "
						+ "  from  my_grnm  mm left join  my_grnd d on mm.tr_no=d.tr_no	left join my_prddin dd  "
						+ "	 on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid "
						+ "  and mm.brhid=dd.brhid 	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "  left join my_prodattrib at    on(at.mpsrno=m.doc_no)   where mm.status=3 and mm.brhid='"+brcid+"' and  mm.doc_no in ("+reqmasterdocno+")  "
						+ "  group by d.stockid,d.prdId having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0  order by dd.date,d.rowno";*/
				
				
		/*		String sqls="select   "+method+" method ,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,mm.rdtype,"
						+ " u.unit,m.munit,if(mm.rdtype='GRN',0,dd.foc-dd.foc_out) foc,if(mm.rdtype='GRN',0,dd.foc-dd.foc_out) maxfoc, "
						+ " sum(d.out_qty) pqty,sum(d.qty) mainqty,sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))  qty, "
						+ "	sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) qutval, "
						+ " sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)) saveqty, "
						+ "  d.amount unitprice,d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))  total,  "
						+ "d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))* d.disper/100 discount, "
						+ "	d.disper ,(d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)))-(d.amount*sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))*d.disper/100) nettotal  "
						+ " from  my_srvm  mm left join  my_srvd d on mm.tr_no=d.tr_no	left join my_prddin dd on  "
						+ "  dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid   and mm.brhid=dd.brhid        "
						+ "	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no 	left join my_prodattrib at    "
						+ "  on(at.mpsrno=m.doc_no)   where mm.status=3 and mm.brhid='"+brhid+"' and  mm.doc_no in ("+reqmasterdocno+")  group by d.stockid,d.prdId  "
						+ " having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0  order by dd.date"; */
 
				
				
				// System.out.println("------sqls---"+sqls);
 
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
	
	
	
	
	 public     ClsgoodsreceiptnotereturnBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsgoodsreceiptnotereturnBean bean = new ClsgoodsreceiptnotereturnBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

			 
				 
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select m.rdtype,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.delterms,m.payterms,m.description,"
						+ " DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate ,m.refinvno,DATE_FORMAT(m.refinvdate,'%d.%m.%Y') AS refinvdate ,l.loc_name \r\n" + 
				" from my_grrm m left join my_head h on h.doc_no=m.acno  left join my_locm l on l.doc_no=m.locid    where   m.doc_no='"+docno+"' ");
				
				
				//System.out.println("--resql--"+resql); l.loc_name     left join my_locm l on l.doc_no=m.locid 
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
		 
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    bean.setExpdeldate(pintrs.getString("deldate"));
			    	    
                        
 
			    	    
			    	    bean.setLblloc(pintrs.getString("loc_name"));
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_grrm r  "
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
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty"
				       		+ "   from my_grrd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty");
							arr.add(temp);
							rowcount++;
			
						 
						
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
