package com.procurement.purchase.purchaserequestforquote;

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
 

public class ClspurchaserequestforquoteDAO {

	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn;
	public int insert(Date masterdate,   String refno, int vendocno,
			int cmbcurr, double currate, String delterms, String payterms,
			String purdesc, double productTotal, double descPercentage,
			double descountVal, double roundOf, double netTotaldown,
			double servnettotal, double orderValue, int chkdiscount,
			HttpSession session, String mode,  
			String formdetailcode, HttpServletRequest request, ArrayList <String> descarray, ArrayList <String> masterarray, String reftype,
			String rrefno, double prddiscount, ArrayList<String> termsarray, String rvocno, ArrayList<String> shiparray,int shipdocno) throws SQLException  {
		 
	
		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurrfq= conn.prepareCall("{call tr_PurchaserequestforquoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurrfq.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtpurrfq.registerOutParameter(24, java.sql.Types.INTEGER);
 
			stmtpurrfq.setDate(1,masterdate);
			stmtpurrfq.setDate(2,null);
			stmtpurrfq.setString(3,refno);
			stmtpurrfq.setInt(4,vendocno);
		   	stmtpurrfq.setInt(5,cmbcurr);
			stmtpurrfq.setDouble(6,currate);
			stmtpurrfq.setString(7,rvocno); 
			stmtpurrfq.setString(8,null);
			stmtpurrfq.setString(9,purdesc);
			stmtpurrfq.setDouble(10,0);
			stmtpurrfq.setDouble(11,0);
			stmtpurrfq.setDouble(12,0);
			stmtpurrfq.setDouble(13,0);
			stmtpurrfq.setDouble(14,0);
			stmtpurrfq.setDouble(15,0);
			stmtpurrfq.setDouble(16,0);
			stmtpurrfq.setString(17,session.getAttribute("USERID").toString());
			stmtpurrfq.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(19,session.getAttribute("COMPANYID").toString());
			
			
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(21,formdetailcode);
			stmtpurrfq.setString(22,mode);
			stmtpurrfq.setInt(23,0);
			stmtpurrfq.setString(25,reftype);
			stmtpurrfq.setString(26,rrefno);
			stmtpurrfq.setDouble(27,0);
			 
			
			stmtpurrfq.executeQuery();
			docno=stmtpurrfq.getInt("docNo");
	 
			int vocno=stmtpurrfq.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			
			
			
			
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
			    	 
			    	 
				     double chkqty=Double.parseDouble(qtychk);
			    	
				     
				     if(chkqty>0){
			    	
			    	 
		     String sql="INSERT INTO my_prfqd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,tr_no,rdocno)VALUES"
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
				       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurrfq.executeUpdate(sql);
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
				     
		/*		     if(reftype.equalsIgnoreCase("CEQ"))
			         {
				    	 
				    	 
				    		 
				    		 
				   		 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum(d.qty-d.out_qty) balqty,d.docno rowno,d.rdocno tr_no,d.out_qty  from my_cusenqm m  left join  my_cusenqd d on m.doc_no=d.rdocno where \r\n" + 
				    	 		" d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.docno having  sum((d.qty-d.out_qty)>0) order by m.date,d.docno ";
				    	 
	 
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


								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  docno="+rowno+"";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpurrfq.executeUpdate(sqls);
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
										
								 
									}


									String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  docno="+rowno+"";	
									//System.out.println("-2----sqls---"+sqls);

									stmtpurrfq.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 

 
				    	 }*/
					
				     if(reftype.equalsIgnoreCase("PR"))
			         {
				     	 
				    	   double balqty=0;
							int rowno=0;
							int tr_no=0;
							double remqty=0;
							double out_qty=0;
							double qty=0;
				    	 Statement stmt=conn.createStatement();
				    	 
				    	 String strSql="select d.qty ,sum(d.qty-d.out_qty) balqty,d.rowno,d.rdocno tr_no,d.out_qty  from my_reqm m  left join  my_reqd d on m.doc_no=d.rdocno where \r\n" + 
				    	 		" d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
				    	 
	 
			                 System.out.println("---strSql-----"+strSql);
				    		ResultSet rs = stmt.executeQuery(strSql);
				    		
				    		
				    		while(rs.next()) {


								balqty=rs.getDouble("balqty");
								tr_no=rs.getInt("tr_no");
								out_qty=rs.getDouble("out_qty");

								rowno=rs.getInt("rowno");
								qty=rs.getDouble("qty");

				 
								if(remqty>0)
								{

									masterqty=remqty;
								}


								if(masterqty<=balqty)
								{
									masterqty=masterqty+out_qty;

									
									String sqls="update my_reqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"";
									

							 	    System.out.println("--1---sqls---"+sqls);


									stmtpurrfq.executeUpdate(sqls);
									break;


								}
								else if(masterqty>balqty)
								{



									if(qty>=(masterqty+out_qty))

									{
										balqty=masterqty+out_qty;	
										remqty=qty-out_qty;

											 System.out.println("---asdasdas--"+remqty);
									}
									else
									{
										
										
										remqty=masterqty-balqty;
										balqty=qty;
										
								 
									}
									System.out.println("---remqty--"+remqty);

									String sqls="update my_reqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"";	
								 System.out.println("-2----sqls---"+sqls);

									stmtpurrfq.executeUpdate(sqls);	

									//remqty=masterqty-qty;



								}


							} 

 
				    	 }
				     
				 
			     }	   
			 }
			     
			     
			     
			     
			     
		 
			     
			     
			     
				     
				     }
			
 
 

 

		 

			for(int i=0;i< termsarray.size();i++){


				String[] terms=((String) termsarray.get(i)).split("::");

		 

				if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




					String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+formdetailcode+"')";


				//	System.out.println("termsdet--->>>>Sql"+termsql);
				int	termsdet = stmtpurrfq.executeUpdate (termsql);
					
					 if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}

				}
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
				int	retdoc = stmtpurrfq.executeUpdate (shipsql);
					
					 if(retdoc<=0)
						{
							conn.close();
							return 0;
							
						}

				}
			}
			
			
			String updatesql="update my_prfqm set shipdetid='"+shipdocno+"' where doc_no='"+docno+"' ";
			
			stmtpurrfq.executeUpdate (updatesql);
			
		
 
			
			
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
			 conn.commit();
				stmtpurrfq.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
		
  

	
	
	





	public int update(int masterdoc_no, Date masterdate, 
			String refno, int vendocno, int cmbcurr, double currate,
			String delterms, String payterms, String purdesc,
			double productTotal, double descPercentage, double descountVal,
			double roundOf, double netTotaldown, double servnettotal,
			double orderValue, int chkdiscount, HttpSession session,
			String mode, String formdetailcode, HttpServletRequest request,
			ArrayList<String> descarray, ArrayList<String> masterarray,  String reftype,
			String rrefno, double prddiscount, ArrayList<String> termsarray, String updatadata, String rvocno, ArrayList<String> shiparray,int shipdocno) throws SQLException {
	 
		
		
		try{
			int docno;
		
			
		//	System.out.println("-----masterdate--"+masterdate);
			
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurrfq= conn.prepareCall("{call tr_PurchaserequestforquoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurrfq.setInt(20,masterdoc_no);
			stmtpurrfq.setInt(24, 0);
 
			stmtpurrfq.setDate(1,masterdate);
			stmtpurrfq.setDate(2,null);
			stmtpurrfq.setString(3,refno);
			stmtpurrfq.setInt(4,vendocno);
		   	stmtpurrfq.setInt(5,cmbcurr);
			stmtpurrfq.setDouble(6,currate);
			stmtpurrfq.setString(7,rvocno); 
			stmtpurrfq.setString(8,null);
			stmtpurrfq.setString(9,purdesc);
			stmtpurrfq.setDouble(10,0);
			stmtpurrfq.setDouble(11,0);
			stmtpurrfq.setDouble(12,0);
			stmtpurrfq.setDouble(13,0);
			stmtpurrfq.setDouble(14,0);
			stmtpurrfq.setDouble(15,0);
			stmtpurrfq.setDouble(16,0);
			stmtpurrfq.setString(17,session.getAttribute("USERID").toString());
			stmtpurrfq.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(21,formdetailcode);
			stmtpurrfq.setString(22,mode);
			stmtpurrfq.setInt(23,0);
			stmtpurrfq.setString(25,reftype);
			stmtpurrfq.setString(26,rrefno);
			stmtpurrfq.setDouble(27,0);
		  
			
		    int res=stmtpurrfq.executeUpdate();
			docno=stmtpurrfq.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if(res<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			

			System.out.println("-updatadata--"+updatadata);
			if(updatadata.equalsIgnoreCase("Editvalue"))
			{
			
				System.out.println("-IN--");
			
			
						String delsqls="delete from my_prfqd where tr_no='"+masterdoc_no+"' ";
						stmtpurrfq.executeUpdate(delsqls);
			 
						String deltermssql="delete from my_trterms where rdocno='"+masterdoc_no+"' ";
						stmtpurrfq.executeUpdate(deltermssql);
						String deltermssqls="delete from my_deldetaild where rdocno='"+masterdoc_no+"' and  dtype='"+formdetailcode+"'  ";
						stmtpurrfq.executeUpdate(deltermssqls);
						
			
					  	int	updateid=0;
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     if(chkqty>0){
			    	 
			    	 
			    	 
						     String sql="INSERT INTO my_prfqd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,tr_no,rdocno)VALUES"
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
								       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurrfq.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
				     
				     
				     
				     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
				     
					  
				     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
				     
				     
				     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
				     
				     double masterqty=Double.parseDouble(rqty);
				     
/*				     if(reftype.equalsIgnoreCase("CEQ"))
			         {
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
				  
				    		 
				    		 if(pridforchk!=updateid)
				    		 {
				    		 
				 			String sqls="update  my_cusenqd set out_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+" ";
		  
		    			//  System.out.println("-----"+sqls);
		    			   	
		    				stmtpurrfq.executeUpdate(sqls);
		    				
		    				updateid=pridforchk;
				    		 
				    		 }
		    				
				    		 
				   		 

					    	    double balqty=0;
								int rowno=0;
								int tr_no=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;
					    	 Statement stmt=conn.createStatement();
					    	 
					    	 
					    	 String strSql="select d.qty ,sum(d.qty-d.out_qty) balqty,d.docno rowno,d.rdocno tr_no,d.out_qty  from my_cusenqm m  left join  my_cusenqd d on m.doc_no=d.rdocno where \r\n" + 
						    	 		" d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.docno having  sum((d.qty-d.out_qty)>0) order by m.date,d.docno ";
						    	 
		 
					// System.out.println("---strSql-----"+strSql);
					    		ResultSet rs = stmt.executeQuery(strSql);
					    		
					    		
					    		while(rs.next()) {


									balqty=rs.getDouble("balqty");
									tr_no=rs.getInt("tr_no");
									out_qty=rs.getDouble("out_qty");

									rowno=rs.getInt("rowno");
									qty=rs.getDouble("qty");

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


										
										
										String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  docno="+rowno+"";
										

										//System.out.println("--1---sqls---"+sqls);


										stmtpurrfq.executeUpdate(sqls);
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


										String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  docno="+rowno+"";	
										//System.out.println("-2----sqls---"+sqls);

										stmtpurrfq.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								} 
				     
				    	     
				   				     
			     
				     
				     }*/
				     if(reftype.equalsIgnoreCase("PR"))
			         {
				    	 
				    	 int pridforchk=Integer.parseInt(prdid);
				    	 
				  
				    		 
				    		 if(pridforchk!=updateid)
				    		 {
				    		 
				 			String sqls="update  my_reqd set out_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+" ";
		  
		    			//  System.out.println("-----"+sqls);
		    			   	
		    				stmtpurrfq.executeUpdate(sqls);
		    				
		    				updateid=pridforchk;
				    		 
				    		 }
		    				
				    		 
				   		 

					    	    double balqty=0;
								int rowno=0;
								int tr_no=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;
					    	 Statement stmt=conn.createStatement();
					    	 
					    	 
					    	 String strSql="select d.qty ,sum(d.qty-d.out_qty) balqty,d.rowno,d.rdocno tr_no,d.out_qty  from my_reqm m  left join  my_reqd d on m.doc_no=d.rdocno where \r\n" + 
						    	 		" d.rdocno in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID")+"  group by d.rowno having  sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
						    	 
		 
					// System.out.println("---strSql-----"+strSql);
					    		ResultSet rs = stmt.executeQuery(strSql);
					    		
					    		
					    		while(rs.next()) {


									balqty=rs.getDouble("balqty");
									tr_no=rs.getInt("tr_no");
									out_qty=rs.getDouble("out_qty");

									rowno=rs.getInt("rowno");
									qty=rs.getDouble("qty");
 

									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										
										
										String sqls="update my_reqd set out_qty="+masterqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"";
										

										//System.out.println("--1---sqls---"+sqls);


										stmtpurrfq.executeUpdate(sqls);
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
											
								 
										}


										String sqls="update my_reqd set out_qty="+balqty+" where rdocno="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+"";	
										//System.out.println("-2----sqls---"+sqls);

										stmtpurrfq.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								} 
				     
				    	     
				   				     
			     
				     
				     }
					     
					     
					     
					     }}}
			
 
	 
			
			for(int i=0;i< termsarray.size();i++){


				String[] terms=((String) termsarray.get(i)).split("::");

 

				if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




					String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+formdetailcode+"')";


				//	System.out.println("termsdet--->>>>Sql"+termsql);
				int	termsdet = stmtpurrfq.executeUpdate (termsql);
					
					 if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}

				}
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
				int	retdoc = stmtpurrfq.executeUpdate (shipsql);
					
					 if(retdoc<=0)
						{
							conn.close();
							return 0;
							
						}

				}
			}
			
			
			String updatesql="update my_prfqm set shipdetid='"+shipdocno+"' where doc_no='"+docno+"' ";
			
			stmtpurrfq.executeUpdate (updatesql);
			
			}
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurrfq.close();
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
			 
			 CallableStatement stmtpurrfq= conn.prepareCall("{call tr_PurchaserequestforquoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurrfq.setInt(20,masterdoc_no);
			stmtpurrfq.setInt(24, 0);
 
			stmtpurrfq.setDate(1,null);
			stmtpurrfq.setDate(2,null);
			stmtpurrfq.setString(3,null);
			stmtpurrfq.setInt(4,0);
		   	stmtpurrfq.setInt(5,0);
			stmtpurrfq.setDouble(6,0);
			stmtpurrfq.setString(7,null); 
			stmtpurrfq.setString(8,null);
			stmtpurrfq.setString(9,null);
			stmtpurrfq.setDouble(10,0);
			stmtpurrfq.setDouble(11,0);
			stmtpurrfq.setDouble(12,0);
			stmtpurrfq.setDouble(13,0);
			stmtpurrfq.setDouble(14,0);
			stmtpurrfq.setDouble(15,0);
			stmtpurrfq.setDouble(16,0);
			stmtpurrfq.setString(17,session.getAttribute("USERID").toString());
			stmtpurrfq.setString(18,session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(19,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurrfq.setString(21,formdetailcode);
			stmtpurrfq.setString(22,mode);
			stmtpurrfq.setInt(23,0);
			stmtpurrfq.setString(25,"0");
			stmtpurrfq.setString(26,"0");
			stmtpurrfq.setDouble(27,0);
		    int res=stmtpurrfq.executeUpdate();
			docno=stmtpurrfq.getInt("docNo");
	 
 
			//System.out.println("====vocno========"+vocno);
		
			if (res > 0) {
			 
				stmtpurrfq.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	}








 
	
	

	public   JSONArray searchProduct(HttpSession session,String acno,String id,
			String prdname,String brandname,String gridunit,String gridprdname,String category, String subcategory) throws SQLException {

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
		    if(!(id.equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    String brcid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;
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
					
				
				
			String sql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "   left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no "+sqlstest+"    "
							+ "  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "+condtn+" order by m.doc_no "	;
 
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
	
	
	
	

	public   JSONArray searchreqProduct(String reqmasterdocno,HttpSession session,String accdocno,String dtype,String id,
			String prdname,String brandname,String gridunit,String gridprdname,String category, String subcategory) throws SQLException { 

	 	 JSONArray RESULTDATA=new JSONArray();
	 	 Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(!(id.equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    if(a==0){
		  return RESULTDATA;
		     }
		    
		    
		    String brchid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;
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
				  sqlstest=" left join  my_acbook ac on ac.acno='"+accdocno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
				
			    if(dtype.equalsIgnoreCase("CEQ"))
			    {
					String sqls="select   "+method+" method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid)) qty,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid)) qutval,\r\n" + 
							"	  ((select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid)) pqty,\r\n" + 
							"(select coalesce(sum(qty)-sum(out_qty),0) from  my_cusenqd  where rdocno in ("+reqmasterdocno+") and prdid=rd.prdid) saveqty\r\n" + 
							"  from my_cusenqm m1 left join my_cusenqd rd on rd.rdocno=m1.doc_no \r\n" + 
							"				  left join\r\n" + 
							"my_main m  on rd.prdid=m.doc_no left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no"+sqlstest+" \r\n" + 
							"\r\n" + 
							"          where m1.status=3 and  m1.brhid='"+brchid+"' and rd.rdocno in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 "+condtn+" group by rd.prdid   ";
					
			 	System.out.println("--sqls--"+sqls);
	 
				ResultSet resultSet = stmtVeh.executeQuery (sqls);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);	
			    }
			    else
			    {
				
			    	String sqls="select   "+method+" method ,bd.brandname,  at.mspecno as specid ,rd.qty-rd.out_qty,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qty,\r\n" + 
							"(select coalesce(sum(qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)-\r\n" + 
							"((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) qutval,\r\n" + 
							" ((select coalesce(sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid)) pqty,\r\n" + 
							"(select coalesce(sum(qty)-sum(out_qty),0) from  my_reqd  where tr_no in ("+reqmasterdocno+") and prdid=rd.prdid) saveqty\r\n" + 
							"  from my_reqm m1 left join my_reqd rd on rd.tr_no=m1.tr_no   left join \r\n" + 
							" my_main m  on rd.prdid=m.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
							+ " left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) \r\n left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no" + 
					 		" "+sqlstest+" where m1.status=3 and  m1.brhid='"+brchid+"' and rd.tr_no in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0 "+condtn+" group by rd.prdid   ";
			     	System.out.println("--sqls--"+sqls);
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
	
	
	
	
	
	
	
	
	public   JSONArray maingridreload(String doc,String reftype,String reqdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
				
				String sqltest="0";
				
				
				if(reftype.equalsIgnoreCase("CEQ") || reftype.equalsIgnoreCase("PR"))
				 
				{
					
					sqltest=reqdocno; 
				}
				if(reftype.equalsIgnoreCase("CEQ"))
						{
				String pySql="select bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
						"				u.unit, d.unitid unitdocno,\r\n" + 
						"				if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_cusenqd  where rdocno in ("+sqltest+") and prdid=d.prdid)-\r\n" + 
						"				(select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+sqltest+") and prdid=d.prdid)+d.qty)) qutval,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+sqltest+") and prdid=d.prdid)-d.qty) pqty,\r\n" + 
						"				  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+sqltest+") and prdid=d.prdid)) saveqty,\r\n" + 
 						"				d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_prfqm m1  left join my_prfqd d on m1.tr_no=d.tr_no\r\n" + 
						"				 left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.rdocno='"+doc+"'";	
				
				// System.out.println("--pySql----"+pySql);
 
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						}
				
				
				else
				{
					String pySql="select bd.brandname,d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,\r\n" + 
							"  u.unit, d.unitid unitdocno,\r\n" + 
							"  if(m1.rdtype='DIR',0,((select coalesce(sum(qty),0) from  my_reqd  where rdocno in ("+sqltest+") and prdid=d.prdid)-\r\n" + 
							"  (select coalesce(sum(out_qty),0) from  my_reqd  where rdocno in ("+sqltest+") and prdid=d.prdid)+d.qty)) qutval,\r\n" + 
							"  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where rdocno in ("+sqltest+") and prdid=d.prdid)-d.qty) pqty,\r\n" + 
							"  if(m1.rdtype='DIR',0,(select coalesce(sum(out_qty),0) from  my_reqd  where rdocno in ("+sqltest+") and prdid=d.prdid)) saveqty,\r\n" + 
	 						"  d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_prfqm m1  left join my_prfqd d on m1.tr_no=d.tr_no\r\n" + 
							"  left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.rdocno='"+doc+"'";
					// System.out.println("--pySql----"+pySql);			
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
				
 
				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.description desc1 from my_prfqm m "
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










	public     ClspurchaserequestforquoteBean getViewDetails(int masterdoc_no) throws SQLException {
	
		ClspurchaserequestforquoteBean showBean = new ClspurchaserequestforquoteBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		
		String sqls="select m.shipdetid, sh.clname, sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
				+ "m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate   \r\n" + 
				" from my_prfqm m left join my_head h on h.doc_no=m.acno  left join my_shipdetails sh on sh.doc_no=m.shipdetid  where   m.doc_no='"+masterdoc_no+"' ";
		
		
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		String dtype="0";
		String reqdoc="0";
		while (resultSet.next()) {
		
			showBean.setDocno(resultSet.getInt("voc_no"));
		
			showBean.setDate(resultSet.getString("date"));
			//showBean.setDeliverydate(resultSet.getString("deldate"));
			//showBean.setDelterms(resultSet.getString("delterms"));
			//showBean.setPayterms(resultSet.getString("payterms"));
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
		//	showBean.setProductTotal(resultSet.getDouble("amount"));
		//	showBean.setChkdiscountval(resultSet.getInt("disstatus"));
		//	showBean.setDescPercentage(resultSet.getDouble("disper"));
			
		//	showBean.setPrddiscount(resultSet.getDouble("prddiscount"));
			
		 
			//showBean.setDescountVal(resultSet.getDouble("discount"));
			//showBean.setRoundOf(resultSet.getDouble("roundVal"));
			//showBean.setNetTotaldown(resultSet.getDouble("netAmount"));
			//showBean.setNettotal(resultSet.getDouble("supplExp"));
			//showBean.setOrderValue(resultSet.getDouble("nettotal"));
		
			showBean.setShipdocno(resultSet.getInt("shipdetid"));
			showBean.setShipto(resultSet.getString("clname"));
			showBean.setShipaddress(resultSet.getString("claddress"));
			showBean.setContactperson(resultSet.getString("contactperson"));
			showBean.setShiptelephone(resultSet.getString("tel"));
			
			
			showBean.setShipmob(resultSet.getString("mob"));
			showBean.setShipemail(resultSet.getString("email"));
			showBean.setShipfax(resultSet.getString("fax"));
		
		}
		int i=0;
		String reqvoc="";
		if(dtype.equalsIgnoreCase("CEQ"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_cusenqm where doc_no in ("+reqdoc+")";
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
		else if(dtype.equalsIgnoreCase("PR"))
		{
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_reqm where doc_no in ("+reqdoc+")";
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



	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String acno,String cmbreftype) throws SQLException {

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
				
 
					
				    int method1=0;
					String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
					ResultSet rs1=stmtmain.executeQuery(chk1); 
					if(rs1.next())
						{
									
						method1=rs1.getInt("method");
						}


					String sqlstest1="";
					if((!acno.equalsIgnoreCase("0")) && (!acno.equalsIgnoreCase("NA")) && (!acno.equalsIgnoreCase("null") && (!acno.equalsIgnoreCase(""))))
					{
				    if(method1>0)
					{
				    	sqlstest1=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m1.brandid=br.brandid ";
					}
						
					}
				   
				    
				    
				    if(cmbreftype.equalsIgnoreCase("CEQ"))
				    
				    {
				    
					String pySql=("select * from (select sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
							+ "  from my_cusenqm m  left join   my_cusenqd d on d.rdocno=m.doc_no left join my_main m1 on m1.doc_no=d.prdId  "+sqlstest1+" "
							+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
			  
					System.out.println("-------pySql----"+pySql);
					
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				
				    }
				    
				    else if(cmbreftype.equalsIgnoreCase("PR"))
				    {
				    	
				    	
				    	String pySql=("select * from (select sum(d.qty-d.out_qty) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk' "
								+ "  from my_reqm m  left join   my_reqd d on d.rdocno=m.doc_no left join my_main m1 on m1.doc_no=d.prdId  "+sqlstest1+" "
								+ "	 where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"    group by m.doc_no) as a  having  qty>0");
				    	System.out.println("-------pySql----"+pySql);
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

	public   JSONArray reqgridreload(HttpSession session,String doc,String from,String acno,String cmbreftype,String types) throws SQLException {
		 
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

                    System.out.println("---types----"+types);
					String sqlstest="";
				/*	if(!(types.equalsIgnoreCase("acc")))
					{*/
					
					if((!acno.equalsIgnoreCase("0")) && (!acno.equalsIgnoreCase("NA")) && (!acno.equalsIgnoreCase("null") && (!acno.equalsIgnoreCase(""))))
					{				
				    if(method1>0)
					{
					  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
					}
						
					}
					/*}*/
				    if(cmbreftype.equalsIgnoreCase("CEQ"))
				    {
				    
					
					 pySql=("select bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty  from  my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) " + 
			        			"left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+"      where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and d.rdocno in ("+doc+")  group by d.prdId  having sum(d.qty-d.out_qty)>0  ");
					 
				 	  System.out.println("======pySql==="+pySql);
 		                   ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    }
					 
				    
				    else if(cmbreftype.equalsIgnoreCase("PR"))
				    {
						 pySql=("select bd.brandname,'pro' checktype ,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty  from  my_reqm ma left join my_reqd d on(ma.doc_no=d.rdocno) " + 
				        			"left join my_main m on m.doc_no=d.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+"      where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and d.rdocno in ("+doc+")  group by d.prdId  having sum(d.qty-d.out_qty)>0  ");
						
						  System.out.println("======pySql==="+pySql);
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
	

	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk,String cmbreftype,String reqmasterdocno) throws SQLException {
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
          
   // System.out.println("===cmbreftype===="+cmbreftype);
    
    
  //  System.out.println("===reqmasterdocno===="+reqmasterdocno);
    
     
    
    if((!reqmasterdocno.equalsIgnoreCase("null")) && (!reqmasterdocno.equalsIgnoreCase("0"))  && (!reqmasterdocno.equalsIgnoreCase("")) && cmbreftype.equalsIgnoreCase("CEQ"))
    {
        /*String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
                + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
                + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
        */
        String  sql= " select  m.brandid,d.rdocno,d.prdid,a.cldocno,t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate, "
        		 + " if(a.per_mob=0,a.per_tel,a.per_mob) mobile from   my_cusenqd d left join my_main m on m.doc_no=d.prdId left join  my_acbook a on "
                 + " a.dtype='VND'  inner join my_vendorbrand br on a.cldocno=br.rdocno  and m.brandid=br.brandid "
                 + "  left join my_head t   on t.cldocno=a.cldocno and "
                 + " a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid "
                 + " inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
                 + "  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
                 + "  on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
                 + " where a.active=1 and t.m_s=0 and d.rdocno in ("+reqmasterdocno+") "+sqltest+" group by t.doc_no ";

        
        
        
   // System.out.println("========"+sql);
        ResultSet resultSet = stmtCPV.executeQuery(sql);
        RESULTDATA=ClsCommon.convertToJSON(resultSet);
    }
    else
    {
    
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    }
    
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


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"'";
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

	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m   "
					+ "inner join my_termsd d on(m.voc_no=d.rdocno and  d.status=3)  where m.status=3 and d.dtype='"+dtype+"' order by terms";
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
					+ "left join MY_termsm m on m.voc_no=t.termsid and t.dtype='RFQ'  where t.dtype='RFQ' and t.rdocno='"+docno+"'";
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			       
				

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}










	 public     ClspurchaserequestforquoteBean getPrint(int docno, HttpServletRequest request,String branch) throws SQLException {
		 ClspurchaserequestforquoteBean bean = new ClspurchaserequestforquoteBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select concat(coalesce(ac.per_tel,''),' , ',coalesce(ac.fax1,'')) telfax,ac.refname,ac.per_tel,ac.mail1,ac.fax1,ac.contactperson,ac.trnnumber, m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='PR','Purchase Request','Sales Enquiry')) type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description    \r\n" + 
				" from my_prfqm m left join my_head h on h.doc_no=m.acno left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='CRM')  where   m.doc_no='"+docno+"'");
				
				
				System.out.println("--resql--"+resql);
				
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
			            bean.setLblattn(pintrs.getString("contactperson"));
			            bean.setLblemail(pintrs.getString("mail1"));
			            bean.setLbltelno(pintrs.getString("telfax"));
			            bean.setLbltrnnumber(pintrs.getString("trnnumber"));
			            System.out.println("tel"+(pintrs.getString("mail1")));
			            
			            
			    	    
			    	     //bean.setLbltotal(pintrs.getString("netAmount"));
			    	   // bean.setLblsubtotal(pintrs.getString("supplExp"));
			            
			    	 //  bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	     
			    	    
			    	  //  bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    
			    	    
			    	  
			       }
				

				stmtprint.close();
				
			       
			     double total=0;
 
			     Statement stmtgrid3 = conn.createStatement ();      
			     String	strSqldetail1="select sum(nettotal) nettotal  from my_prfqd   where rdocno='"+docno+"'";
				 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
			 
					if(rsdetail1.next()){
						
						total=rsdetail1.getDouble("nettotal");
						bean.setLbltotal(total+"");
					 
						
						bean.setLblordervaluewords(c.convertAmountToWords(total+""));
			    	     
			    	    
				    	  bean.setLblordervalue(total+"");
						
					}
				
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location,b.tinno trnno from my_prfqm r  "
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
				    	   bean.setLblbranchtrno(resultsetcompany.getString("trnno"));
				    	   
				       } 
				     stmt10.close();
				       
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_prfqd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty");
							arr.add(temp);
							rowcount++;
			
							bean.setFirstarray(1);
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					
					ArrayList<String> arry=new ArrayList<String>();
					Statement statemntgrid = conn.createStatement();
					String tempt="";
					
					
					/*String sqlterms="select m.voc_no,t.dtype,m.termsheader  terms, t.conditions from my_trterms t "
							+ "left join MY_termsm m on m.voc_no=t.termsid and t.dtype='RFQ'  where t.dtype='RFQ' and t.rdocno='"+docno+"'";*/
					String sqlterms="SELECT * FROM (select distinct @s:=@s+1 sr_no,'' header,termsheader terms,m.doc_no from ("
							+" select distinct  tr.rdocno,termsid from my_trterms tr where  tr.dtype='RFQ' and tr.brhid="+branch+" and tr.status=3 and tr.rdocno="+docno+") tr"
							+" inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3"
							+" union all select '*' sr_no ,@J:=@J+1 header,conditions terms,m.doc_no from my_trterms tr left join my_termsm m"
							+" on(tr.termsid=m.voc_no),(SELECT @J:= 0) AS J where tr.dtype='RFQ'  and tr.brhid="+branch+" and tr.status=3 and m.status=3 and tr.rdocno="+docno+" order by doc_no)BB ORDER BY BB.DOC_NO";

					System.out.println("--resql--"+sqlterms);
					ResultSet rsdetails=statemntgrid.executeQuery(sqlterms);
					
					while(rsdetails.next()) 
					{
						tempt=rsdetails.getString("header")+"::"+rsdetails.getString("terms");
								arry.add(tempt);
								
						System.out.println("tempprint"+tempt);
					}
                     request.setAttribute("quoteprint", arry);
					
					
					
					/*					
					   
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
					 
					
					*/
					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
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

