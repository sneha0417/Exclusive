package com.dashboard.accounts.chequeupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsChequeAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsChequeUpdateDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray chequeUpdateGridLoading(String branch,String fromdate,String todate,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
		        if(check.equalsIgnoreCase("1")){
		        	
				    String sql = "",sql1 = "",sql2 = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and m.brhid="+branch+"";
		    		}
					
					if(!(sqlFromDate==null)){
			        	sql1+=" and d.chqdt>='"+sqlFromDate+"'";
			        	sql2+=" and m.chqdt>='"+sqlFromDate+"'";
				    }
			        
			        if(!(sqlToDate==null)){
			        	sql1+=" and d.chqdt<='"+sqlToDate+"'";
			        	sql2+=" and m.chqdt<='"+sqlToDate+"'";
				    }
				    
				    sql = "select * from ((select d.tr_no,CONVERT(d.brhid,CHAR(50)) brhid,d.chqno,d.chqdt,if(d.pdc=0,false,true) pdc,m.date,m.doc_no,m.dtype,chqname,de.acno bankacno,CONVERT(h.account,CHAR(100)) account,"
				    	+ "h.description from my_chqdet d left join my_chqbm m on d.tr_no=m.tr_no left join my_chqbd de on de.tr_no=m.tr_no and sr_no=0 left join my_head h on h.doc_no=d.opsacno "
				    	+ "where d.status='E' and m.dtype IN ('BPV','IBP','COT') and m.status=3"+sql+""+sql1+") union all "
				    	+ "(select 0 tr_no,CONVERT(m.brhid,CHAR(50)) brhid,m.chqno,m.chqdt,if(m.pdc=0,false,true) pdc,m.date,m.doc_no,m.dtype,chqname,d1.acno bankacno,CONVERT(h.account,CHAR(100)) account,"
				    	+ "h.description from my_unclrchqbm m left join my_unclrchqbd d  on (d.rdocno=m.doc_no and m.brhid=d.brhid and m.bpvno=0 and d.sr_no=1) left join my_unclrchqbd d1  on "
				    	+ "(d1.rdocno=m.doc_no and m.brhid=d1.brhid and m.bpvno=0 and d1.sr_no=0 ) left join my_head h on (h.doc_no=d.acno) where m.status=3"+sql+""+sql2+")) as aa";
				 //   System.out.println("==== "+sql);
				    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }
		        
			    stmtChqUpdate.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray multiChequeGridLoading(String branch,String fromdate,String todate,String account,String chqno,String chqdate,String unclrchq,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        java.sql.Date sqlChequeDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        if(!(chqdate.equalsIgnoreCase("undefined")) && !(chqdate.equalsIgnoreCase("")) && !(chqdate.equalsIgnoreCase("0"))){
		        	  sqlChequeDate = ClsCommon.changeStringtoSqlDate(chqdate);
		        }
		        
		        if(check.equalsIgnoreCase("2")){
		        	
				    String sql = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and m.brhid="+branch+"";
		    		}
				    
				    if(unclrchq.equalsIgnoreCase("0")) {
				    	
				    	if(!(sqlFromDate==null)){
				        	sql+=" and d.chqdt>='"+sqlFromDate+"'";
					    }
				        
				        if(!(sqlToDate==null)){
				        	sql+=" and d.chqdt<='"+sqlToDate+"'";
					    }
				        
				        if(!(sqlChequeDate==null)){
				        	sql+=" and d.chqdt='"+sqlChequeDate+"'";
				        } 
	
				        if(!(chqno.equalsIgnoreCase("0")) && !(chqno.equalsIgnoreCase(""))){
				        	sql+=" and d.chqno like '%"+chqno+"%'";
				        }
				        
				    	sql = "select d.tr_no,d.brhid,d.chqno,d.chqdt,if(d.pdc=0,false,true) pdc,m.date,m.doc_no,m.dtype,chqname,de.acno bankacno," 
				    		+ "CONVERT(h.account,CHAR(100)) account,h.description from my_chqdet d left join my_chqbm m on d.tr_no=m.tr_no left join my_chqbd de "  
				    		+"on de.tr_no=m.tr_no and sr_no=0 left join my_head h on h.doc_no=d.opsacno where d.status='E' and m.dtype IN ('BPV','IBP','COT') "  
				    		+ "and m.status=3 and de.acno="+account+""+sql+"";
				    }
				    
				    else if(unclrchq.equalsIgnoreCase("1")) {
				    	
				    	if(!(sqlFromDate==null)){
				        	sql+=" and m.chqdt>='"+sqlFromDate+"'";
					    }
				        
				        if(!(sqlToDate==null)){
				        	sql+=" and m.chqdt<='"+sqlToDate+"'";
					    }
				        
				        if(!(sqlChequeDate==null)){
				        	sql+=" and m.chqdt='"+sqlChequeDate+"'";
				        } 
	
				        if(!(chqno.equalsIgnoreCase("0")) && !(chqno.equalsIgnoreCase(""))){
				        	sql+=" and m.chqno like '%"+chqno+"%'";
				        }
				    	
				    	sql = "select 0 tr_no,m.brhid,m.chqno,m.chqdt,if(m.pdc=0,false,true) pdc,m.date,m.doc_no,m.dtype,chqname,d1.acno bankacno,"
				    		+ "CONVERT(h.account,CHAR(100)) account,h.description from my_unclrchqbm m left join my_unclrchqbd d  on (d.rdocno=m.doc_no "
				    		+ "and m.brhid=d.brhid and m.bpvno=0 and d.sr_no=1) left join my_unclrchqbd d1  on (d1.rdocno=m.doc_no and m.brhid=d1.brhid and m.bpvno=0 and d1.sr_no=0 ) left join my_head h "
				    		+ "on (h.doc_no=d.acno) where m.status=3 and d1.acno="+account+""+sql+"";
				    }
				    
				    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        
		        }
		        
			    stmtChqUpdate.close();
			    conn.close();
		  }catch(Exception e){
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
		       Statement stmtChqUpdate = conn.createStatement();

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
		        
		       ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtChqUpdate.close();
		       conn.close();
		       }
	          stmtChqUpdate.close();
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
	
	public  ClsChequeUpdateBean getChequePrint(int docno,String dtype,int branch) throws SQLException {
		 ClsChequeUpdateBean bean = new ClsChequeUpdateBean();
		 Connection conn = null;
			
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtChqUpdate = conn.createStatement();
			String amountwordslength="",sqls="";
			int accountno=0;
			
			if(!(dtype.equalsIgnoreCase("UCP"))){
				sqls="select d.acno from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='"+dtype+"' and m.brhid="+branch+" and "
						+ "m.doc_no="+docno+"";
			}else{
				sqls="select d.acno from my_unclrchqbm m left join my_unclrchqbd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) where d.sr_no=0 and m.dtype='"+dtype+"' and m.brhid="+branch+" and "
						+ "m.doc_no="+docno+"";
			}
			
			ResultSet resultSets = stmtChqUpdate.executeQuery(sqls);
			
			while(resultSets.next()){
				accountno=resultSets.getInt("acno");
			}
			
			/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
			
			String sql="select dbprintpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
			
			ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			
			while(resultSet.next()){

				bean.setPrinturl(resultSet.getString("dbprintpath"));
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
	
			String sql1="";
			
			if(!(dtype.equalsIgnoreCase("UCP"))){
				
				 sql1="select c.chqno,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
					+ "t.description Else m.chqname END as 'description',(select round(if(d.amount<0,d.amount*-1,d.amount),2) amount from my_chqbm m "  
					+ "left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='"+dtype+"' and m.brhid="+branch+" and m.doc_no="+docno+") amount "
					+ "from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no "  
					+ "where m.dtype='"+dtype+"' and m.status=3 and m.brhid="+branch+" and m.doc_no="+docno+" group by m.tr_no";
			
			}else{
			
			    sql1="select m.chqno,DATE_FORMAT(m.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN t.description "
			    		+ "Else m.chqname END as 'description',round(if(d.amount<0,d.amount*-1,d.amount),2) amount from my_unclrchqbm m left join my_unclrchqbd d "
			    		+ "on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head t on d.acno=t.doc_no and d.sr_no=1 where m.dtype='"+dtype+"' and m.status=3 and m.brhid="+branch+" and "
			    		+ "m.doc_no="+docno+" group by m.doc_no";
			}
			
				ResultSet resultSet1 = stmtChqUpdate.executeQuery(sql1);
				
				while(resultSet1.next()){

					/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
					   1 character = 8 pixel ## 1 pixel = 0.125 character */
					
					bean.setLblchequedate(resultSet1.getString("chqdt"));
					bean.setLblpaidto(resultSet1.getString("description"));
					bean.setLblamount(resultSet1.getString("amount"));
					
					ClsAmountToWords c = new ClsAmountToWords();
					
					double chequelength = Double.parseDouble(amountwordslength)*0.125;
					
					String amountwords = c.convertAmountToWords(resultSet1.getString("amount"));
					
					if(amountwords.length()>chequelength){
						
						String breakedstring = ClsCommon.addLinebreaks(amountwords, chequelength);
						
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
				stmtChqUpdate.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
	public  ClsChequeUpdateBean getPrint(String accountno,String docno,String dtype,String branch) throws SQLException {
		 ClsChequeUpdateBean bean = new ClsChequeUpdateBean();
		 Connection conn = null;
		 HttpServletRequest request=ServletActionContext.getRequest();
		 ArrayList<ClsChequeUpdateAction> cheques = new ArrayList();
		 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtChqUpdate = conn.createStatement();
			String amountwordslength="";
			
			/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
			
			String sql="select dbmultiprintpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
			
			ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			
			while(resultSet.next()){

				bean.setPrinturl(resultSet.getString("dbmultiprintpath"));
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
	
			String sql1="";
			
			if(!(dtype.contains("UCP"))){
				
				 sql1="select c.chqno,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
					+ "t.description Else m.chqname END as 'description',format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount,round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords "
					+ "from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no "  
					+ "where m.dtype in ('"+dtype+"') and d.sr_no=0 and m.status=3 and m.brhid="+branch+" and m.doc_no in ("+docno+") group by m.tr_no";
			
			}else{
			
			    sql1="select m.chqno,DATE_FORMAT(m.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN t.description "
			    		+ "Else m.chqname END as 'description',format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount,round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords from my_unclrchqbm m left join my_unclrchqbd d "
			    		+ "on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head t on d.acno=t.doc_no and d.sr_no=1 where m.dtype in ('"+dtype+"') and m.status=3 and m.brhid="+branch+" and "
			    		+ "m.doc_no in ("+docno+") group by m.doc_no";
			}
			
				ResultSet resultSet1 = stmtChqUpdate.executeQuery(sql1);
				int i=1;
				String multichqprintsql = "";
				while(resultSet1.next()){

					/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
					   1 character = 8 pixel ## 1 pixel = 0.125 character */
					
					ClsChequeAmountToWords c = new ClsChequeAmountToWords();
					
					double chequelength = Double.parseDouble(amountwordslength)*0.125;
					
					/*Multi Cheque Jasper SQL*/
					String amountwords = c.convertChequeAmountToWords(resultSet1.getString("amountinwords"));
					if(i==1) {
						multichqprintsql += "select "+i+" as chqno,'"+resultSet1.getString("chqdt")+"' as chqdate,'"+resultSet1.getString("description")+"' as payto,'"+amountwords+"' as amountinwords,'#"+resultSet1.getString("amount")+"#' as amount";
					} else {
						multichqprintsql += " union all select "+i+" as chqno,'"+resultSet1.getString("chqdt")+"' as chqdate,'"+resultSet1.getString("description")+"' as payto,'"+amountwords+"' as amountinwords,'#"+resultSet1.getString("amount")+"#' as amount";
					}
					
					i++;
					/*Multi Cheque Jasper SQL Ends*/
					
					if(amountwords.length()>chequelength){
						
						String breakedstring = ClsCommon.addLinebreaks(amountwords, chequelength);
						
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
					
					cheques.add(new ClsChequeUpdateAction(bean.getLblpageheight(),bean.getLblpagewidth(),bean.getLblpagesheight(),bean.getLblpageswidth(),
							bean.getLbldatex(),bean.getLbldatey(),bean.getLblpaytovertical(),bean.getLblpaytohorizontal(),bean.getLblpaytolength(),
							bean.getLblaccountpayingx(),bean.getLblaccountpayingy(),bean.getLblamtwordsvertical(),bean.getLblamtwordshorizontal(),
							bean.getLblamtwordslength(),bean.getLblamountx(),bean.getLblamounty(),bean.getLblamtwords1vertical(),bean.getLblamtwords1horizontal(),
							bean.getLblamtwords1length(),resultSet1.getString("chqdt"),resultSet1.getString("description"),
							bean.getLblamountwords(),bean.getLblamountwords1(),resultSet1.getString("amount")));
					
				    }

					request.setAttribute("multichequeprintingsql", multichqprintsql);
					request.setAttribute("multichequeprintingcount", i);
					
				    request.setAttribute("TRIAL", cheques);
				
				stmtChqUpdate.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
}