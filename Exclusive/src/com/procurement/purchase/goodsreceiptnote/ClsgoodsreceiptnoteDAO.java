package com.procurement.purchase.goodsreceiptnote;

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
 
 
 

public class ClsgoodsreceiptnoteDAO {

	
	
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
			ArrayList <String> masterarray, String reftype, String rrefno, double prddiscount, int locationid, Date invdate, String invno,int itermtype,int costtrno) throws SQLException  {
		 
	
		
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtgrn.setDate(29,invdate);
			
			stmtgrn.setString(30,invno);
			
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
				String upcostsql="update my_grnm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			
			
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_grnm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			
		
			String rownochk="0"; 
			
			for(int i=0;i< masterarray.size();i++){
		    	
				
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     
				     if(chkqty>0){
				    	 
				    	 
/*						 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
								   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "); */
				    	 
			
				  
				     
				    // rrefno
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
				  
				  //   String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    
				     String  foc=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")|| detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				     
				     
				     String amount=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				 	//discount disper 
				     
			/*	     String discount=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     String disper=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     */
				     String specnos=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
				     String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
				     
				     
				     
				     String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
				     
				     
				     double fr=1;
				     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
				     
				     System.out.println("====slss==="+slss);
				     ResultSet rv1=stmtgrn.executeQuery(slss);
				     if(rv1.next())
				     {
				    	 fr=rv1.getDouble("fr"); 
				     }
				     
				     System.out.println("====fr==="+fr);
				     
				     double paidqty=Double.parseDouble(paidqtyd);
				     
				     double focqty=Double.parseDouble(foc);
				 
				 
				     double opqty=paidqty+focqty;
			 
				     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,date,fr,unitid)values"
				    		 + "("+(i+1)+","
				             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						     + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
				               + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
				               +"'"+opqty*fr+"','"+focqty+"',"
				             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"','"+masterdate+"',"+fr+","+unitids+")";
				     
				    // System.out.println("--sql2-----"+sql2);
				     int resultSet10 = stmtgrn.executeUpdate(sql2);
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
			     
				     
				     String sql="INSERT INTO my_grnd(sr_no,psrno,prdId,unitid,qty,specno,foc,amount,disper,tr_no,stockid,rdocno,fr)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
						       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
						       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
						       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
						       + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
						       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
						       +"'"+mastertr_no+"','"+stockid+"','"+docno+"',"+fr+")";

	 
		 	     int resultSet2 = stmtgrn.executeUpdate(sql);
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
					}
				     
				     
				    
		
			     
		
			    

				     
				     
				     if(reftype.equalsIgnoreCase("PO"))
			         {
				    	 
			 
					     String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
					     
					     
					     
					     double masterqty=Double.parseDouble(rqty); 
				   		 
				    	   double balqty=0;
							int rowno=0;
				             int tr_no=0;
							double remqty=0;
							double out_qty=0;
								double qty=0;
								int unitid=0;
								int specno=0;
				    	 Statement stmt=conn.createStatement();
				
				    	 
				    	 
				    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where   d.clstatus=0 and\r\n" + 
				    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and d.unitid="+unitids+" and d.specno="+specnos+" and m.brhid="+session.getAttribute("BRANCHID")+" and d.rowno not in("+rownochk+") group by d.rowno having "
				    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
				    	 
                            // System.out.println("-----strSql---"+strSql);
				    	 
				 
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

									
									String sqls="update my_ordd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtgrn.executeUpdate(sqls);
									break;


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


									String sqls="update my_ordd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
								//	System.out.println("-2----sqls---"+sqls);

									stmtgrn.executeUpdate(sqls);	

								 



								} //else if

				    		 
				    			
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
			String rrefno, double prddiscount, int locationid, Date invdate, String invno, String updatadata,int itermtype,int costtrno) throws SQLException {
	 
		
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtgrn.setDate(29,invdate);
			stmtgrn.setString(30,invno);
			
		    int res=stmtgrn.executeUpdate();
			docno=stmtgrn.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			
			//System.out.println("-updatadata--"+updatadata);
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
				String upcostsql="update my_grnm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
				coststmt.executeUpdate(upcostsql);
				
				
				
			}
				
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			
			String sqlss="select tr_no from my_grnm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			
			
			System.out.println("-updatadata--"+updatadata);
			if(!(updatadata.equalsIgnoreCase("Editvalue")))
			{
			String upsqlss="update  my_prddin set date='"+masterdate+"' where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' ";
			stmtgrn.executeUpdate(upsqlss);
			
			}
			
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{
			
			//	System.out.println("-In--");
					
				
			
			
			
			
			String delsqls="delete from my_grnd where tr_no='"+mastertr_no+"' ";
			stmtgrn.executeUpdate(delsqls);
 
			
			String delsqlss="delete from my_prddin where tr_no='"+mastertr_no+"' and dtype='"+formdetailcode+"' ";
			stmtgrn.executeUpdate(delsqlss);
			
	    	int	updateid=0;
			String rownochk="0"; 
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     if(chkqty>0){
			    	 
			    	 

					    	 
					
				     
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     String  paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")|| detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
					    
				     String  foc=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")|| detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
				     	
				     
				     double paidqty=Double.parseDouble(paidqtyd);
				     
				     double focqty=Double.parseDouble(foc);
				   //  System.out.println("--paidqty-----"+paidqty);
				     
				    // System.out.println("--focqty-----"+focqty);
				     double opqty=paidqty+focqty;
				     //System.out.println("--opqty-----"+opqty);
				     String specnos=""+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")|| detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"";
				     String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
				     
				     
				     
				     String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
				     
				     
				     double fr=1;
				     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
				     
				     System.out.println("====slss==="+slss);
				     ResultSet rv1=stmtgrn.executeQuery(slss);
				     if(rv1.next())
				     {
				    	 fr=rv1.getDouble("fr"); 
				     }
				     
				     System.out.println("====fr==="+fr);
				     
				     
				     

				     
				     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,date,fr,unitid)values"
				    		 + "("+(i+1)+","
				             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						     + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
				               + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
				               +"'"+opqty*fr+"','"+focqty+"',"
				             +"'"+locationid+"','"+session.getAttribute("BRANCHID").toString()+"','"+mastertr_no+"','"+formdetailcode+"','"+masterdate+"',"+fr+","+unitids+")";
				     
				 
				     int resultSet10 = stmtgrn.executeUpdate(sql2);
				     if(resultSet10<=0)
						{
							conn.close();
							return 0;
							
						}
				     int stockid=0;	
					    
			         Statement selstmt=conn.createStatement();
			     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin ";
			     
			  //   System.out.println("-----sqlssel-"+sqlssel);
			     
			     ResultSet selrss=selstmt.executeQuery(sqlssel);
			     
			     if(selrss.next())
			     {
			    	 stockid=selrss.getInt("stockid") ;
			    	 
			    	 
			    	 
			 	 
			     }	
				     
			     String sql="INSERT INTO my_grnd(sr_no,psrno,prdId,unitid,qty,specno,foc,amount,disper,tr_no,stockid,rdocno,fr)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
					       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
					       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
					       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
					       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
					       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
					       + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
					       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
					       +"'"+mastertr_no+"','"+stockid+"','"+docno+"',"+fr+")";
				     
				     
		     int resultSet2 = stmtgrn.executeUpdate(sql);
		     if(resultSet2<=0)
				{
					conn.close();
					return 0;
					
				}
				     
		/*		     int stockid=0;	
				     int updaterow=0;
			         Statement selstmt=conn.createStatement();
			     String sqlssel="select stockid,rowno from my_prddin where tr_no='"+mastertr_no+"' and prdid='"+prdid+"' ";
			     
			     
			     ResultSet selrss=selstmt.executeQuery(sqlssel);
			     
			     while(selrss.next())
			     {
			    	 stockid=selrss.getInt("stockid") ;
			    	 updaterow=selrss.getInt("rowno") ;
			    	 
			    	 
			 	    String updatesql="update  my_grnd set stockid='"+stockid+"' where tr_no='"+mastertr_no+"' and prdid='"+prdid+"' and rowno='"+updaterow+"' ";
				    System.out.println("----updatesql---"+updatesql);
				    stmtgrn.executeUpdate(updatesql);
			     }
			     
			     */
	/*		     
			    String updatesql="update  my_grnd set stockid='"+stockid+"' where tr_no='"+mastertr_no+"' and prdid='"+prdid+"' ";
			     
			    stmtgrn.executeUpdate(updatesql);*/
			    
			    
				     
				     
				     
				     
				     
				     
				     
				     
				     
/*				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
					  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);*/
				     
				     if(reftype.equalsIgnoreCase("PO"))
			         {
				    	 
	                        String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
					     
					     
					     
					     double masterqty=Double.parseDouble(rqty); 
				    		 
						 int pridforchk=Integer.parseInt(prdid);
				    	 
						String amount=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
						  
						   
						   
							String discper=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
							   
						   
					    	/*	 if(pridforchk!=updateid)
					    		 {*/
					    			// System.out.println("--pridforchk--"+pridforchk);
					 			String sqlsa="update  my_ordd set out_qty=0 where tr_no in ("+rrefno+") and prdid="+pridforchk+" and clstatus=0  and amount='"+amount+"' and disper='"+discper+"'  and unitid="+unitids+" and specno="+specnos+" ";
			  
			    			//  System.out.println("-----"+sqlsa);
			    			   	
			    			  stmtgrn.executeUpdate(sqlsa);
			    				
			    				updateid=pridforchk;
					    		 
					    		// }
				   		 
						   		 
						    	   double balqty=0;
									int rowno=0;
						             int tr_no=0;
									double remqty=0;
									double out_qty=0;
										double qty=0;
										int unitid=0;
										int specno=0;
						    	 Statement stmt=conn.createStatement();
						 /*   	 
						    	 String strSql="select d.qty saveqty,sum((d.qty-d.out_qty)) Qty,d.rowno,d.tr_no,d.out_qty  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where \r\n" + 
						    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
						    	 
						    	 */
						    	 
						    	 
						    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty,d.unitid,d.specno  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where \r\n" + 
						    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and d.unitid="+unitids+" and d.specno="+specnos+" and d.amount='"+amount+"' and d.disper='"+discper+"'  and d.clstatus=0 and m.brhid="+session.getAttribute("BRANCHID")+" and  d.rowno not in("+rownochk+") group by d.rowno having   "
						    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
						    	 
		                             //System.out.println("---11--strSql---"+strSql);
						    	 
						 
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

											
											String sqls="update my_ordd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
											

											//System.out.println("--1---sqls---"+sqls);


											stmtgrn.executeUpdate(sqls);
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


											String sqls="update my_ordd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";	
											//System.out.println("-2----sqls---"+sqls);

											stmtgrn.executeUpdate(sqls);	

										 



										} //else if

						    		 
						    			
						    	  		}  // while
				    	 
				     
				    	 
			 
				     
				     
				     
				    	 }
					
						     
			         }
				     
				    	     
				   				     
			     
				     
				     }}
			
			}
		 
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtgrn.close();//
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
			 
				CallableStatement stmtgrn= conn.prepareCall("{call tr_goodsreceiptnoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtgrn.setDate(29,null);
			stmtgrn.setString(30,"0");
			
			
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
				
				
				if(reftype.equalsIgnoreCase("PO"))
				
				
				
				{
					
					sqltest=reqdocno;
				}
				
 
				
	/*			String pySql="	select at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
						"				u.unit, d.unitid unitdocno,\r\n" + 
						"				if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+sqltest+") and prdid=d.prdid)-\r\n" + 
						"				(select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+sqltest+") and prdid=d.prdid)+d.qty)) qutval,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+sqltest+") and prdid=d.prdid)-d.qty) pqty,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+sqltest+") and prdid=d.prdid)) saveqty,\r\n" + 
						"				d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_grnm m1  left join my_grnd d on m1.tr_no=d.tr_no\r\n" + 
						"				 left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where m1.doc_no='"+doc+"'";
				 */
/*				String pySql=" select aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid, "
						+ "  m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
						+ "  u.unit, d.unitid unitdocno,if(m1.rdtype='DIR',0,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty) qutval, "
						+ " if(m1.rdtype='DIR',0,(sum(coalesce(aa.out_qty,0))-d.qty)) pqty,   if(m1.rdtype='DIR',0,sum(coalesce(aa.out_qty,0))) saveqty,  "
						+ " d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid   from my_grnm m1  left join my_grnd d on m1.tr_no=d.tr_no  "
						+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ " left join (select  prdid,amount,qty,out_qty,rowno  from  my_ordd   where tr_no in ("+sqltest+") ) aa  "
						+ " on aa.prdid=d.prdid and aa.amount=d.amount  where m1.doc_no='"+doc+"'  "
						+ " group by d.prdid,aa.amount order by d.prdid  ";*/
				
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
				
				String pySql="select bd.brandname,aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid, "
						+ "  m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
						+ " u.unit, d.unitid unitdocno,if(m1.rdtype='DIR',0,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty) qutval,  "
						+ " if(m1.rdtype='DIR',0,(sum(coalesce(aa.out_qty,0))-d.qty)) pqty,   if(m1.rdtype='DIR',0,sum(coalesce(aa.out_qty,0))) saveqty, "
						+ " d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid   from my_grnm m1  "
						+ " left join my_grnd d on m1.tr_no=d.tr_no   left join my_main m on m.doc_no=d.prdId  "
						+ "  left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno from  my_ordd   where tr_no in ("+sqltest+") and  clstatus=0 ) aa "
						+ "  on aa.prdid=d.prdid and aa.amount=d.amount and aa.disper=d.disper "+joinsqls1+"  where m1.doc_no='"+doc+"'     "
						+ "     group by d.prdid"+joinsqls+",aa.amount,aa.discount order by d.prdid,aa.rowno  ";
				
				
			//	System.out.println("----ssssssssss--pySql-----"+pySql);
				
			/*	
				my_ordd  where tr_no in (1,2)

			 ) aa on aa.prdid=d.prdid and aa.amount=d.amount  where m1.doc_no='1'
			 group by d.prdid,aa.amount  order by d.prdid   ;*/
				
 
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
	
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa,String refnoss,String descriptions) throws SQLException {

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
				
				

				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.nettotal netamount, m.refno,m.description desc1 from my_grnm m "
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










	public     ClsgoodsreceiptnoteBean   getViewDetails(int masterdoc_no) throws SQLException {
	
		ClsgoodsreceiptnoteBean showBean = new ClsgoodsreceiptnoteBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		
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
			
		
		Statement stmt  = conn.createStatement ();
		
		String sqls="select "+sq1+" m.refinvDate, m.refInvNo,m.rdtype,if(m.rdtype='PO',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs, "
				+ "	h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper,  "
				+ "	 m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate,l.loc_name,m.locid "
				+ "		from my_grnm m left join my_head h on h.doc_no=m.acno "+jsq1+"  left join my_locm l on l.doc_no=m.locid where  m.doc_no='"+masterdoc_no+"'";
		
		
		
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
		if(dtype.equalsIgnoreCase("PO"))
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
	        	
				  	
					String pySql=("select * from (select "+sq1+" sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk',m.deldate,m.delterms,m.payterms  "
							+ "  from my_ordm m  left join    	my_ordd d on d.tr_no=m.tr_no "+jsq1+"  "
							+ "	 where m.status=3 and m.acno="+headacccode+" and d.clstatus=0 and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
/*	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' ,sum((d.qty-d.out_qty)) Qty  from my_ordm m  left join "
	        			+ "   	my_ordd d on d.tr_no=m.tr_no   where m.status=3 and m.acno="+headacccode+" and m.brhid='"+brcid+"' "+sqltest+" group by m.tr_no having  sum(d.qty-d.out_qty)>0");*/
	        	
	        	 //System.out.println("========"+pySql);
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

	public   JSONArray reqgridreload(String doc,String from) throws SQLException {
		 
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
						joinsqls=",d.unitid,d.specno ";
						  
						
					}
					
					
					
					pySql="select bd.brandname,d.rowno refrowno, 'pro' checktype ,at.mspecno as specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n" + 
							"d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n" + 
							"sum(d.qty-d.out_qty) saveqty,\r\n" + 
							"d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper from my_ordd d\r\n" + 
							"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "    where d.tr_no in ("+doc+") and  d.clstatus=0 group by d.prdid"+joinsqls+",d.amount,d.discount having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno ";
					
					
				 
					/*
					 pySql=("select 'pro' checktype ,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n" + 
					 		"d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n" + 
					 		"sum(d.qty-d.out_qty) saveqty,\r\n" + 
					 		"sum(amount) unitprice,sum(d.qty-d.out_qty)*sum(amount)  total ,sum(discount) discount,\r\n" + 
					 		"(sum(d.qty-d.out_qty)*sum(amount))-sum(discount) nettotal from my_ordd d\r\n" + 
					 		"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  where d.tr_no in ("+doc+")  group by d.prdId   ");
					*/
				//	System.out.println("----pySql----"+pySql);
					 
						
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
				
				int superseding=0;
				String chk1="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
				{
					
					superseding=rs1.getInt("method");
				}
						
				if(superseding==1)
				{
					String fleetsql="select s.part_no,m.* from( select  "+method+" method,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
								    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
								 
					  System.out.println("----main1---"+fleetsql);
		 
					ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();	
				}
				
				else
				{
				
			/*String fleetsql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ";
			*/
			String fleetsql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " where m.status=3  ";
			
			// System.out.println("-----fleetsql---"+fleetsql);
 
			ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
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
					  
					
				}
				
				
/*				String sqls="select   "+method+" method ,at.mspecno as specid   ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,\r\n" + 
					 	"(select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qty,\r\n" + 
						"(select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qutval,\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) pqty,\r\n" + 
						"(select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) saveqty \r\n" + 
    					"  from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no  left join my_grnd d on m1.tr_no=d.tr_no \r\n" + 
						"  left join my_main m  on rd.prdid=m.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) " + 
						"  where rd.tr_no in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 group by rd.prdid   ";*/
				
			
				
	 
				
				String sqls="select  "+method+" method,bd.brandname,at.mspecno as specid   ,rd.rowno,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,rd.unitid munit,m.psrno, "
						+ " coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qty,coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval, "
						+ " coalesce(sum(rd.out_qty),0) pqty, coalesce(sum(rd.qty-rd.out_qty),0) saveqty ,rd.amount unitprice, "
						+ " (coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0))*rd.amount*rd.disper/100 discount,rd.disper  "
						+ "  from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no  "
						+ " left join my_main m  on rd.prdid=m.doc_no left join my_unitm u on rd.unitid=u.doc_no left join my_prodattrib at  "
						+ "  on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  where  rd.clstatus=0 and m1.brhid='"+brcid+"' and m1.status=3 and  rd.tr_no in ("+reqmasterdocno+")  "
								+ " and rd.qty-rd.out_qty>0 group by rd.prdid"+joinsqls+",rd.amount,rd.discount  order by rd.prdid,rd.rowno ";
				
				
				System.out.println("---sqls----"+sqls);
				
				
				
				
/*				this comment for old data with grn price*/
				
/*				String sqls="select   "+method+" method ,at.mspecno as specid   ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,\r\n" + 
						"(select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) totprqty, \r\n" + 
						"(select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qty,\r\n" + 
						"(select coalesce(sum(qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qutval,\r\n" + 
						"((select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) pqty,\r\n" + 
						"(select coalesce(sum(out_qty),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) saveqty ,\r\n" + 
						"(select coalesce(sum(amount),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) unitprice, \r\n" +  
						"(select coalesce(sum(discount),0) from  my_ordd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) discount  \r\n" + 
						"  from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no  left join my_grnd d on m1.tr_no=d.tr_no \r\n" + 
						"  left join\r\n" + 
						"my_main m  on rd.prdid=m.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) " + 
						"\r\n" + 
						"  where rd.tr_no in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 group by rd.prdid   ";*/
				
				
			//	System.out.println("------sqls---"+sqls);
 
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
	
	
	 public     ClsgoodsreceiptnoteBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsgoodsreceiptnoteBean bean = new ClsgoodsreceiptnoteBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

	 
				 
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select m.rdtype,if(m.rdtype='PO',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct','Purchase Order') type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.delterms,m.payterms,m.description,"
						+ " DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate ,m.refinvno,DATE_FORMAT(m.refinvdate,'%d.%m.%Y') AS refinvdate ,l.loc_name \r\n" + 
				" from my_grnm m left join my_head h on h.doc_no=m.acno  left join my_locm l on l.doc_no=m.locid    where   m.doc_no='"+docno+"' ");
				
				
				//System.out.println("--resql--"+resql); l.loc_name     left join my_locm l on l.doc_no=m.locid 
				
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
			    	    
                        
			    	    
                        bean.setLblinvno(pintrs.getString("refinvno"));
                        bean.setLblinvdate(pintrs.getString("refinvdate"));
			    	    
			    	    bean.setLblloc(pintrs.getString("loc_name"));
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_grnm r  "
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
				       		+ "   from my_grnd d "
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
