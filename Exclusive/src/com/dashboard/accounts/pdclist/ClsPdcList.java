package com.dashboard.accounts.pdclist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPdcList {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray pdcListGridLoading(String branch,String reporttype,String fromDate,String toDate,String cmbcriteria,String code,String cmbacctype,String txtaccid,String unclrPosted,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtPDC = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(check.equalsIgnoreCase("1")){

				String selacno,xsql = "",sqls="",sql1 = "",sql2 = "",sql3="",sql4="",sql5="",sql6="";
				
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
			        
				if(!(cmbcriteria.equalsIgnoreCase("2"))){
			        if(!(sqlFromDate==null)){
			        	sql1+=" and d.chqdt>='"+sqlFromDate+"'";
			        	sql2+=" and m.chqdt>='"+sqlFromDate+"'";
				    }
			    }
		    
		        if(!(sqlToDate==null)){
		        	sql1+=" and d.chqdt<='"+sqlToDate+"'";
		        	sql2+=" and m.chqdt<='"+sqlToDate+"'";
			    }
		        
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				     sql3=" and m.brhid='"+branch+"'";
				}
		        
		        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
		        {selacno=txtaccid;
		            if(cmbacctype.equalsIgnoreCase("Bank")){
		            	xsql+=" and de.acno='"+txtaccid+"'";sql4+=" and d1.acno='"+txtaccid+"'";
		            }else {
		            	xsql+=" and d.opsacno='"+txtaccid+"'";sql4+=" and d.acno='"+txtaccid+"'";
		            }
	            }
		        
		        if(reporttype.equalsIgnoreCase("rdall")) {
		        	
		        	if(unclrPosted.equalsIgnoreCase("1")) {
		        		sql6+=" and m.bpvno!=0";
		        	} else {
		        		sql6+=" and m.bpvno=0";
		        	}
		        	
		        	
			        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FPP")) {
			        	
				        sqls =  " union all (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
				        		+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
				        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m left join my_unclrchqbd d  on "
				        		+ "(d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqbd d2 on "
				        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2 ) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 "
				        		+ "on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+")";
		    		}
			        
			        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FRO")) {
			        	
				        sqls =  " union all (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
				        		+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
				        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  "
				        		+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqreceiptd d2  on "
				        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2 ) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno "
				        		+ "left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+")";
		    		}		
		        }	
		        
		        if(reporttype.equalsIgnoreCase("rduncleared")){
		        	
		        	if(unclrPosted.equalsIgnoreCase("1")) {
		        		sql6+=" and m.bpvno!=0";
		        	} else {
		        		sql6+=" and m.bpvno=0";
		        	}
		        	
		        	if(code.equalsIgnoreCase("FPP")) {
		        		
		        		sql5 =  "select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
		        				+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
				        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m left join my_unclrchqbd d  on "
		        				+ "(d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqbd d2 on "
				        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join "
		        				+ "my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+"";
		        		
		        		System.out.println("grid loading qry--------"+sql5);
		        		
						ResultSet resultSet1 = stmtPDC.executeQuery(sql5);
						RESULTDATA=ClsCommon.convertToJSON(resultSet1);
						
		    		} else if(code.equalsIgnoreCase("FRO")) {
		    			
			        	sql5 =  " select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"  
			        			+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
				        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  "
			        			+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqreceiptd d2 on "
				        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 "
			        			+ "on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+"";
			        	
			        	System.out.println("grid loading qry--------"+sql5);
			        	
						ResultSet resultSet1 = stmtPDC.executeQuery(sql5);
						RESULTDATA=ClsCommon.convertToJSON(resultSet1);
						
		    		}		
		        }

		        if(reporttype.equalsIgnoreCase("rdall") || reporttype.equalsIgnoreCase("rdpdc")){
		        
				/*All*/
			    if(reporttype.equalsIgnoreCase("rdpdc") && cmbcriteria.equalsIgnoreCase("1")){ xsql+=" and d.PDC=1"; }
				
		        /*PDC to be posted*/
		        if(cmbcriteria.equalsIgnoreCase("2")){ xsql+=" and d.status='E' and d.PDC=1"; }
				
		        /*Posted PDC*/
				else if(cmbcriteria.equalsIgnoreCase("3")){ xsql+=" and d.status='P' and d.PDC=1"; }

		        /*Returned PDC*/
	    		else if(cmbcriteria.equalsIgnoreCase("4")){ xsql+=" and d.status='R' "; }

		        /*Dishonoured PDC*/
	    		else if(cmbcriteria.equalsIgnoreCase("5")){ xsql+=" and d.status='D' and d.PDC=1"; }
		        
				if (code.trim().equalsIgnoreCase("FPP")){ xsql+=" and m.dtype in ('BPV','IBP','OPP')";}else{ xsql+=" and  m.dtype in ('BRV','IBR','OPR')"; }
				
				xsql = "select * from ((select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.opsacno is null,de1.acno,if(d.opsacno=0,de1.acno,d.opsacno)) acno,"  
						+ "if(h.atype is null,h2.atype,h.atype) atype,if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
						+ "de.amount*de.dr amount,de.acno bankacno,d.brhid,d.chqno,d.chqdt,b1.branchname from my_chqbm m inner join my_chqbd de on m.tr_no=de.tr_no and de.gridid<=1  "
						+ "left join my_chqbd de1 on m.tr_no=de1.tr_no and de1.sr_no=2 inner join my_brch b1 on de.brhid=b1.doc_no inner join my_curr c on de.curId=c.doc_no inner join "
						+ "(select account,description,doc_no from my_head where den='305') h1 on de.acno=h1.doc_no inner join my_chqdet d on de.rowno=d.rowno left join my_head h on d.opsacno=h.doc_no "
						+ "left join my_head h2 on de1.acno=h2.doc_no where m.status=3"+sql3+""+sql1+""+xsql+")"+sqls+") as a order by a.chqdt";
				
				
				System.out.println("grid loading qry--------"+xsql);
				//System.out.println("===== "+xsql);
				ResultSet resultSet = stmtPDC.executeQuery(xsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
		        }
			}
				
			stmtPDC.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray pdcListGroupGridLoading(String branch,String reporttype,String fromDate,String toDate,String cmbcriteria,String group,String code,String cmbacctype,String txtaccid,String unclrPosted,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtPDC = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(check.equalsIgnoreCase("3")){

				String selacno,description="",descriptions="",xsql = "",sqls="",sql1 = "",sql2 = "",sql3="",sql4="",sql5="",sql6="",sql7="";
				
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
			        
				if(!(cmbcriteria.equalsIgnoreCase("2"))){
			        if(!(sqlFromDate==null)){
			        	sql1+=" and d.chqdt>='"+sqlFromDate+"'";
			        	sql2+=" and m.chqdt>='"+sqlFromDate+"'";
				    }
			    }
		    
		        if(!(sqlToDate==null)){
		        	sql1+=" and d.chqdt<='"+sqlToDate+"'";
		        	sql2+=" and m.chqdt<='"+sqlToDate+"'";
			    }
		        
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				     sql3=" m.brhid='"+branch+"'";
				}
		        
		        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
		        {selacno=txtaccid;
		            if(cmbacctype.equalsIgnoreCase("Bank")){
		            	xsql+=" and de.acno='"+txtaccid+"'";sql4+=" and d1.acno='"+txtaccid+"'";
		            }else {
		            	xsql+=" and d.opsacno='"+txtaccid+"'";sql4+=" and d.acno='"+txtaccid+"'";
		            }
	            }
		        
		        if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
		        	if(!(reporttype.equalsIgnoreCase("rduncleared"))){
		        		if(group.equalsIgnoreCase("date")){
		        			descriptions+=",DATE_FORMAT(a.chqdt,'%d-%m-%Y') descriptions";
			        		sql6+=" group by a.chqdt";
			        	}else if(group.equalsIgnoreCase("month")){
			        		descriptions+=",MONTHNAME(a.chqdt) descriptions";
			        		sql6+=" group by month(a.chqdt)";
			        	}else if(group.equalsIgnoreCase("bank")){
			        		description+=",CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) descriptions";
			        		sql6+=" group by a.bankacno";
			        	}
		        	}else if(reporttype.equalsIgnoreCase("rduncleared")){
		        		if(group.equalsIgnoreCase("date")){
		        			descriptions+=",DATE_FORMAT(m.chqdt,'%d-%m-%Y') descriptions";
			        		sql6+=" group by m.chqdt";
			        	}else if(group.equalsIgnoreCase("month")){
			        		descriptions+=",MONTHNAME(m.chqdt) descriptions";
			        		sql6+=" group by month(m.chqdt)";
			        	}else if(group.equalsIgnoreCase("bank")){
			        		description+=",CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) descriptions";
			        		sql6+=" group by d1.acno";
			        	}
		        	}
		        	
		        }
		        
		        if(reporttype.equalsIgnoreCase("rdall")){
		        	
		        	if(unclrPosted.equalsIgnoreCase("1")) {
		        		sql7+=" and m.bpvno!=0";
		        	} else {
		        		sql7+=" and m.bpvno=0";
		        	}
		        	
			        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FPP")) {
			        	
				        sqls =  " union all (select d1.amount*d1.dr amounts,d1.acno bankacno,m.chqdt"+description+" from my_unclrchqbm m left join my_unclrchqbd d  "
				        		+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0) left join my_unclrchqbd d2 "
				        		+ "on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join "
				        		+ " my_head h2 on h2.doc_no=d2.acno left join  my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+")";
		    		}
			        
			        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FRO")) {
			        	
				        sqls =  " union all (select d1.amount*d1.dr amounts,d1.acno bankacno,m.chqdt"+description+" from my_unclrchqreceiptm m left join "
				        		+ "my_unclrchqreceiptd d  on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no "
				        		+ "and d1.sr_no=0 ) left join my_unclrchqreceiptd d2  on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) "
				        		+ "left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno left join my_brch b1 "
				        		+ "on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+")";
		    		}		
		        }	
		        
		        if(reporttype.equalsIgnoreCase("rduncleared")){
		        	
		        	if(unclrPosted.equalsIgnoreCase("1")) {
		        		sql7+=" and m.bpvno!=0";
		        	} else {
		        		sql7+=" and m.bpvno=0";
		        	}
		        	
		        	if(code.equalsIgnoreCase("FPP")) {
		        		
		        		sql5 =  "select sum(d1.amount*d1.dr) amount,d1.acno bankacno,m.chqdt"+description+""+descriptions+" from my_unclrchqbm m left join my_unclrchqbd d  on "
		        				+ "(d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0) left join my_unclrchqbd d2 on (d2.rdocno=m.doc_no and d2.sr_no=2) "
		        				+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where "
		        				+ "m.status=3"+sql3+""+sql2+""+sql4+""+sql7+""+sql6+"";
		        		
						ResultSet resultSet1 = stmtPDC.executeQuery(sql5);
						RESULTDATA=ClsCommon.convertToJSON(resultSet1);
						
		    		} else if(code.equalsIgnoreCase("FRO")) {
		    			
			        	sql5 =  " select sum(d1.amount*d1.dr) amount,d1.acno bankacno,m.chqdt"+description+""+descriptions+" from my_unclrchqreceiptm m left join my_unclrchqreceiptd d "
			        			+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0) left join my_unclrchqreceiptd d2  on (d2.rdocno=m.doc_no and d2.sr_no=2)"
			        			+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"
			        			+ ""+sql3+""+sql2+""+sql4+""+sql7+""+sql6+"";
			        	
						ResultSet resultSet1 = stmtPDC.executeQuery(sql5);
						RESULTDATA=ClsCommon.convertToJSON(resultSet1);
						
		    		}		
		        }

		        if(reporttype.equalsIgnoreCase("rdall") || reporttype.equalsIgnoreCase("rdpdc")){
		        
				/*All*/
			    if(reporttype.equalsIgnoreCase("rdpdc") && cmbcriteria.equalsIgnoreCase("1")){ xsql+=" and d.PDC=1"; }
				
		        /*PDC to be posted*/
		        if(cmbcriteria.equalsIgnoreCase("2")){ xsql+=" and d.status='E' and d.PDC=1"; }
				
		        /*Posted PDC*/
				else if(cmbcriteria.equalsIgnoreCase("3")){ xsql+=" and d.status='P' and d.PDC=1"; }

		        /*Returned PDC*/
	    		else if(cmbcriteria.equalsIgnoreCase("4")){ xsql+=" and d.status='R' "; }

		        /*Dishonoured PDC*/
	    		else if(cmbcriteria.equalsIgnoreCase("5")){ xsql+=" and d.status='D' and d.PDC=1"; }
		        
				if (code.trim().equalsIgnoreCase("FPP")){ xsql+=" and m.dtype in ('BPV','IBP','OPP')";}else{ xsql+=" and  m.dtype in ('BRV','IBR','OPR')"; }
				
				xsql = "select a.*,sum(amounts) amount"+descriptions+" from ((select de.amount*de.dr amounts,de.acno bankacno,d.chqdt"+description+" from my_chqbm m inner join "
						+ "my_chqbd de on m.tr_no=de.tr_no and de.gridid<=1  inner join my_brch b1 on de.brhid=b1.doc_no inner join my_curr c on de.curId=c.doc_no inner join "
						+ "(select account,description,doc_no from my_head where den='305') h1 on de.acno=h1.doc_no inner join my_chqdet d on de.rowno=d.rowno inner join "
						+ "my_head h on d.opsacno=h.doc_no left join my_chqbd de1 on m.tr_no=de1.tr_no and de1.sr_no=2 left join my_head h2 on de1.acno=h2.doc_no where m.status=3"+sql3+""+sql1+""+xsql+")"+sqls+") as a "+sql6+"";
				
				ResultSet resultSet = stmtPDC.executeQuery(xsql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }
			}
			stmtPDC.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray pdcListDistributionpGridLoading(String branch,String reporttype,String fromDate,String toDate,String cmbcriteria,String cmbdistribution,String group,String code,String cmbacctype,String txtaccid,String unclrPosted,String check) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtPDC = conn.createStatement();
			
			 if(check.equalsIgnoreCase("2")){
				 
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			     
			     fromDate.trim();
		         if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		         }
		        
		         toDate.trim();
		         if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		         }

		         String xsql="",sql="";
		         
		         ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     analysiscolumnarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			     analysiscolumnarray.add("Description::description::left::left:: ::25%:: :: :: ");
			     
			     if(cmbdistribution.equalsIgnoreCase("monthwise")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtPDC.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
			     }
			     
			     if(cmbdistribution.equalsIgnoreCase("monthwise")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate, MONTHNAME('"+analysisDate+"') analysisDates";
							   ResultSet rs = stmtPDC.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
									     sql+=" if (a.chqdt between '"+analysisFromDate+"' and '"+analysisToDate+"',if(sum(a.amount)<0,sum(a.amount)*-1,sum(a.amount)),'') amount"+i+",";
								     }else{
								    	 sql+=" if (a.chqdt between '"+sqlFromDate+"' and '"+analysisDate+"',if(a.amount<0,a.amount*-1,a.amount),'') amount"+i+",";
								     }
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							     }
							}else{
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
								   		+ "MONTHNAME(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate"+
									   ",MONTHNAME(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ))) stranalysisToDate";
		     					   
							   ResultSet rs = stmtPDC.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=rs.getString("stranalysisToDate");
									      }
									     
									     if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
										     sql+=" if (a.chqdt between '"+analysisFromDate+"' and '"+analysisToDate+"',if(sum(a.amount)<0,sum(a.amount)*-1,sum(a.amount)),'') amount"+i+",";
									     }else{
									    	 sql+=" if (a.chqdt between '"+analysisFromDate+"' and '"+analysisToDate+"',if(a.amount<0,a.amount*-1,a.amount),'') amount"+i+",";
									     }
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						  }
				       }
			     
			     if(cmbdistribution.equalsIgnoreCase("bankwise")){
			    	 
			    	 String sqls="select count(*) bankcount from my_head where den='305'";
			    	 ResultSet rs1=stmtPDC.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("bankcount");
			    	 }
			     }
			     
			     if(cmbdistribution.equalsIgnoreCase("bankwise")){
			     		ArrayList<String> bankarray=new ArrayList<>();
			     		
			     		xsql="select doc_no,account,description from my_head where den='305'";
		     			ResultSet rs2=stmtPDC.executeQuery(xsql);
		     			while(rs2.next()){
		     				bankarray.add(rs2.getString("doc_no")+"::"+rs2.getString("account")+"::"+rs2.getString("description"));
		     			}
		     			
			     		for(int i=0;i<bankarray.size();i++){
			     		if(i==0){
			     			 if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
							     sql+=" if (a.bankacno="+bankarray.get(i).split("::")[0]+",if(sum(a.amount)<0,sum(a.amount)*-1,sum(a.amount)),'') amount"+i+",";
						     }else{
						    	 sql+=" if (a.bankacno="+bankarray.get(i).split("::")[0]+",if(a.amount<0,a.amount*-1,a.amount),'') amount"+i+",";
						     }
		     				amountLength=amountLength+1;
		     				analysiscolumnarray.add(""+bankarray.get(i).split("::")[1]+" - "+bankarray.get(i).split("::")[2]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						}else{
							if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
							     sql+=" if (a.bankacno="+bankarray.get(i).split("::")[0]+",if(sum(a.amount)<0,sum(a.amount)*-1,sum(a.amount)),'') amount"+i+",";
						    }else{
						    	sql+=" if (a.bankacno="+bankarray.get(i).split("::")[0]+",if(a.amount<0,a.amount*-1,a.amount),'') amount"+i+",";
						    }
		     				amountLength=amountLength+1;
		     				analysiscolumnarray.add(""+bankarray.get(i).split("::")[1]+" - "+bankarray.get(i).split("::")[2]+"::amount"+i+"::right::right:: ::20%::d2::yellowClass::['sum']");
						  }
			     	   }
			     	}
			     
			     String selacno,sqls="",sql1 = "",sql2 = "",sql3="",sql4="",sql5="",sql6="",sql7="";
			     
			     if(!(cmbcriteria.equalsIgnoreCase("2"))){
				        if(!(sqlFromDate==null)){
				        	sql1+=" and d.chqdt>='"+sqlFromDate+"'";
				        	sql2+=" and m.chqdt>='"+sqlFromDate+"'";
					    }
				    }
			    
			        if(!(sqlToDate==null)){
			        	sql1+=" and d.chqdt<='"+sqlToDate+"'";
			        	sql2+=" and m.chqdt<='"+sqlToDate+"'";
				    }
			        
			        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					     sql3=" m.brhid='"+branch+"'";
					}
			        
			        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
			        {selacno=txtaccid;
			            if(cmbacctype.equalsIgnoreCase("Bank")){
			            	sql6+=" and de.acno='"+txtaccid+"'";sql4+=" and d1.acno='"+txtaccid+"'";
			            }else {
			            	sql6+=" and d.opsacno='"+txtaccid+"'";sql4+=" and d.acno='"+txtaccid+"'";
			            }
		            }
			        
			        String sqlselect="",sqlgroup="",sqlgroupdet="";
				        	
					if(!(group.equalsIgnoreCase("0") || group.equalsIgnoreCase(""))){
						sqlgroup=" group by";
						
							if(group.equalsIgnoreCase("date")){
								sqlgroupdet=" a.chqdt order by id";
								sqlselect="DATE_FORMAT(a.chqdt,'%d-%m-%Y') description,"+sql+"";
							}else if(group.equalsIgnoreCase("month")){
								sqlgroupdet=" month(a.chqdt) order by id";
								sqlselect="MONTHNAME(a.chqdt) description,"+sql+"";
							}else if(group.equalsIgnoreCase("bank")){
								sqlgroupdet=" a.bankacno order by id";
								sqlselect="a.description,"+sql+"";
							}
						
						sqlgroup+=sqlgroupdet;
						sql=sqlselect;
						
					}
			        
					ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();    	
					
			        if(reporttype.equalsIgnoreCase("rdall")){
			        	
			        	if(unclrPosted.equalsIgnoreCase("1")) {
			        		sql7+=" and m.bpvno!=0";
			        	} else {
			        		sql7+=" and m.bpvno=0";
			        	}
			        	
				        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FPP")) {
				        	
					        sqls =  " union all (select d1.amount*d1.dr amount,d1.acno bankacno,m.chqdt,CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) description "
					        		+ "from my_unclrchqbm m left join my_unclrchqbd d  on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0) "
					        		+ "left join my_unclrchqbd d2  on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno "
					        		+ "left join my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+")";
			    		}
				        
				        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FRO")) {
				        	
					        sqls =  " union all (select d1.amount*d1.dr amount,d1.acno bankacno,m.chqdt,CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) description "
					        		+ "from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on "
					        		+ "(d1.rdocno=m.doc_no and d1.sr_no=0) left join my_unclrchqbd d2  on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) "
					        		+ "left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+")";
			    		}		
			        }	
			        
			        if(reporttype.equalsIgnoreCase("rduncleared")){
			        	
			        	if(unclrPosted.equalsIgnoreCase("1")) {
			        		sql7+=" and m.bpvno!=0";
			        	} else {
			        		sql7+=" and m.bpvno=0";
			        	}
			        	
			        	if(code.equalsIgnoreCase("FPP")) {
			        		
			        		sql5 =  "select @i:=@i+1 id,"+sql+"a.* from ( select d1.amount*d1.dr amount,d1.acno bankacno,m.chqdt,CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) description "
			        				+ "from my_unclrchqbm m left join my_unclrchqbd d  on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0) left join "
			        				+ "my_unclrchqbd d2 on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on "
			        				+ "h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+") a,(SELECT @i:= 0) as i"+sqlgroup+"";
			        		
			        	} else if(code.equalsIgnoreCase("FRO")) {
			        		
				        	sql5 =  " select @i:=@i+1 id,"+sql+"a.* from (select d1.amount*d1.dr amount,d1.acno bankacno,m.chqdt,CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) description "
				        			+ "from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0) "
				        			+ "left join my_unclrchqbd d2 on (d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on "
				        			+ "h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql7+") a,(SELECT @i:= 0) as i"+sqlgroup+"";
				        	
			    		}	
			        	
			        	ResultSet resultSet1 = stmtPDC.executeQuery(sql5);
						
			        	while(resultSet1.next()){
							ArrayList<String> temp=new ArrayList<String>();
							
							temp.add(resultSet1.getString("id"));
							temp.add(resultSet1.getString("description"));

							for (int l = 0; l < amountLength; l++) {
								temp.add(resultSet1.getString("amount"+l+""));
							}

							analysisrowarray.add(temp);
						}
					 
					 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
					 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);

					 JSONArray analysisarray=new JSONArray();
					 analysisarray.addAll(COLUMNDATA);
					 analysisarray.addAll(ROWDATA);
					 RESULTDATA=analysisarray;
			        }

			        if(reporttype.equalsIgnoreCase("rdall") || reporttype.equalsIgnoreCase("rdpdc")){
			        
					/*All*/
					if(reporttype.equalsIgnoreCase("rdpdc") && cmbcriteria.equalsIgnoreCase("1")){ xsql+=" and d.PDC=1"; }
				
			        /*PDC to be posted*/
			        if(cmbcriteria.equalsIgnoreCase("2")){ sql6+=" and d.status='E' and d.PDC=1"; }
					
			        /*Posted PDC*/
					else if(cmbcriteria.equalsIgnoreCase("3")){ sql6+=" and d.status='P' and d.PDC=1"; }

			        /*Returned PDC*/
		    		else if(cmbcriteria.equalsIgnoreCase("4")){ sql6+=" and d.status='R' "; }

			        /*Dishonoured PDC*/
		    		else if(cmbcriteria.equalsIgnoreCase("5")){ sql6+=" and d.status='D' and d.PDC=1"; }
			        
					if (code.trim().equalsIgnoreCase("FPP")){ sql6+=" and m.dtype in ('BPV','IBP','OPP')";}else{ sql6+=" and  m.dtype in ('BRV','IBR','OPR')"; }
					
					sql6 = "select @i:=@i+1 id,"+sql+"a.* from ((select de.amount*de.dr amount,de.acno bankacno,d.chqdt,CONVERT(concat(h1.account,' - ',h1.description),CHAR(100)) description "
							+ "from my_chqbm m inner join my_chqbd de on m.tr_no=de.tr_no and de.gridid<=1  inner join my_brch b1 on de.brhid=b1.doc_no inner join my_curr c on de.curId=c.doc_no "
							+ "inner join (select account,description,doc_no from my_head where den='305') h1 on de.acno=h1.doc_no inner join my_chqdet d on de.rowno=d.rowno inner join my_head h on "
							+ "d.opsacno=h.doc_no left join my_chqbd de1 on m.tr_no=de1.tr_no and de1.sr_no=2 left join my_head h2 on de1.acno=h2.doc_no where m.status=3"+sql3+""+sql1+""+sql6+")"+sqls+") as a,(SELECT @i:= 0) as i"+sqlgroup+"";
					
					ResultSet resultSet2 = stmtPDC.executeQuery(sql6);
					
					 while(resultSet2.next()){
							ArrayList<String> temp=new ArrayList<String>();
							
							temp.add(resultSet2.getString("id"));
							temp.add(resultSet2.getString("description"));

							for (int l = 0; l < amountLength; l++) {
								temp.add(resultSet2.getString("amount"+l+""));
							}
							
							analysisrowarray.add(temp);
						}
					 
					 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
					 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);

					 JSONArray analysisarray=new JSONArray();
					 analysisarray.addAll(COLUMNDATA);
					 analysisarray.addAll(ROWDATA);
					 RESULTDATA=analysisarray;
			        }
		         
			}
			stmtPDC.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountsDetails(HttpSession session,String atype,String accountno,String accountname,String mobile,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtPDC = conn.createStatement();
	
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
	           
		        String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        
		        if(check.equalsIgnoreCase("1")){
		        	
	        	if(atype.equalsIgnoreCase("BANK")){
	        		sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
	                		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
	                		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'"+sqltest;
				}else{
			        sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
					    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
					    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+atype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
					    + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')"+sqltest;
				}
	        	
		       ResultSet resultSet = stmtPDC.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtPDC.close();
		       conn.close();
		       }
		      stmtPDC.close();
			  conn.close();   
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			 conn.close();
		 }
	       return RESULTDATA;
	  }
	
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[8]);
			}
			
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("description",analysisRowArray.get(1));
			for (int j = 2,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public     ClsPdcListBean getPrint(String branch,String reporttype,String fromDate,String toDate,String cmbcriteria,String code,String cmbacctype,String txtaccid,String unclrPosted,String check) throws SQLException {
		ClsPdcListBean bean = new ClsPdcListBean();
		  Connection conn = null;
		  String brch="";
		try {
			if(branch.equalsIgnoreCase("a")){
				brch="1";
			}else{
				brch=branch;
			}
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select b.branchname,c.company,c.address,c.tel,c.fax  from my_brch b"
					+" left join my_comp c on b.cmpid=c.doc_no where b.doc_no="+brch+"";
			
			System.out.println("company qry ---"+str);
			ResultSet rs=stmt.executeQuery(str);
			
			while(rs.next()){
				
				bean.setCompname(rs.getString("company"));
				bean.setCompadd(rs.getString("address"));
				bean.setTel(rs.getString("tel"));
				bean.setFax(rs.getString("fax"));
				bean.setBranch(rs.getString("branchname"));
				
				System.out.println(rs.getString("company"));
			}
			stmt.close();
			
			java.sql.Date sqlFromDate=null;
			java.sql.Date sqlToDate=null;
			String selacno,xsql = "",sqls="",sql1 = "",sql2 = "",sql3="",sql4="",sql5="",sql6="";
			
			fromDate.trim();
	        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
	        }
	        
	        toDate.trim();
	        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
	        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
	        }
		        
			if(!(cmbcriteria.equalsIgnoreCase("2"))){
		        if(!(sqlFromDate==null)){
		        	sql1+=" and d.chqdt>='"+sqlFromDate+"'";
		        	sql2+=" and m.chqdt>='"+sqlFromDate+"'";
			    }
		    }
	    
	        if(!(sqlToDate==null)){
	        	sql1+=" and d.chqdt<='"+sqlToDate+"'";
	        	sql2+=" and m.chqdt<='"+sqlToDate+"'";
		    }
	        
	        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			     sql3=" and m.brhid='"+branch+"'";
			}
	        
	        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
	        {selacno=txtaccid;
	            if(cmbacctype.equalsIgnoreCase("Bank")){
	            	xsql+=" and de.acno='"+txtaccid+"'";sql4+=" and d1.acno='"+txtaccid+"'";
	            }else {
	            	xsql+=" and d.opsacno='"+txtaccid+"'";sql4+=" and d.acno='"+txtaccid+"'";
	            }
            }
	        
	        if(reporttype.equalsIgnoreCase("rdall")) {
	        	
	        	if(unclrPosted.equalsIgnoreCase("1")) {
	        		sql6+=" and m.bpvno!=0";
	        	} else {
	        		sql6+=" and m.bpvno=0";
	        	}
	        	
	        	
		        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FPP")) {
		        	
			        sqls =  " union all (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
			        		+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
			        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m left join my_unclrchqbd d  on "
			        		+ "(d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqbd d2 on "
			        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2 ) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 "
			        		+ "on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+")";
	    		}
		        
		        if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2")) && code.equalsIgnoreCase("FRO")) {
		        	
			        sqls =  " union all (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
			        		+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
			        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  "
			        		+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqreceiptd d2  on "
			        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2 ) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 on h2.doc_no=d2.acno "
			        		+ "left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+")";
	    		}		
	        }	
	        
	        if(reporttype.equalsIgnoreCase("rduncleared")){
	        	
	        	if(unclrPosted.equalsIgnoreCase("1")) {
	        		sql6+=" and m.bpvno!=0";
	        	} else {
	        		sql6+=" and m.bpvno=0";
	        	}
	        	
	        	if(code.equalsIgnoreCase("FPP")) {
	        		
	        		sql5 =  "select @i:=@i+1 as srno,a.* from (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"
	        				+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
			        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m left join my_unclrchqbd d  on "
	        				+ "(d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqbd d2 on "
			        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join "
	        				+ "my_head h2 on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+") a,(select @i:=0) r";
	        		
	        		
	        		bean.setPdcqry(sql5);
					
	    		} else if(code.equalsIgnoreCase("FRO")) {
	    			
		        	sql5 =  "select @i:=@i+1 as srno,a.* from (select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.acno is null,d2.acno,d.acno) acno,if(h.atype is null,h2.atype,h.atype) atype,"  
		        			+ "if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
			        		+ "d1.amount*d1.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m left join my_unclrchqreceiptd d  "
		        			+ "on (d.rdocno=m.doc_no and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and d1.sr_no=0 ) left join my_unclrchqreceiptd d2 on "
			        		+ "(d2.rdocno=m.doc_no and d2.sr_no=2) left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_head h2 "
		        			+ "on h2.doc_no=d2.acno left join my_brch b1 on d1.brhid=b1.doc_no where m.status=3"+sql3+""+sql2+""+sql4+""+sql6+") a,(select @i:=0) r";
		        	
		        	
		        	bean.setPdcqry(sql5);
	    		}		
	        }

	        if(reporttype.equalsIgnoreCase("rdall") || reporttype.equalsIgnoreCase("rdpdc")){
	        
			//All
		    if(reporttype.equalsIgnoreCase("rdpdc") && cmbcriteria.equalsIgnoreCase("1")){ xsql+=" and d.PDC=1"; }
			
	       // PDC to be posted
	        if(cmbcriteria.equalsIgnoreCase("2")){ xsql+=" and d.status='E' and d.PDC=1"; }
			
	       // Posted PDC
			else if(cmbcriteria.equalsIgnoreCase("3")){ xsql+=" and d.status='P' and d.PDC=1"; }

	        //Returned PDC
    		else if(cmbcriteria.equalsIgnoreCase("4")){ xsql+=" and d.status='R' "; }

	        //Dishonoured PDC
    		else if(cmbcriteria.equalsIgnoreCase("5")){ xsql+=" and d.status='D' and d.PDC=1"; }
	        
			if (code.trim().equalsIgnoreCase("FPP")){ xsql+=" and m.dtype in ('BPV','IBP','OPP')";}else{ xsql+=" and  m.dtype in ('BRV','IBR','OPR')"; }
			
			xsql = "select @i:=@i+1 as srno,a.* from (select * from ((select m.dtype,m.doc_no,m.desc1 description,h1.account bank,h1.description bankname,if(d.opsacno is null,de1.acno,if(d.opsacno=0,de1.acno,d.opsacno)) acno,"  
					+ "if(h.atype is null,h2.atype,h.atype) atype,if(h.account is null,h2.account,h.account) account,if(h.description is null,h2.description,h.description) accountname,"
					+ "de.amount*de.dr amount,de.acno bankacno,d.brhid,d.chqno,d.chqdt,b1.branchname from my_chqbm m inner join my_chqbd de on m.tr_no=de.tr_no and de.gridid<=1  "
					+ "left join my_chqbd de1 on m.tr_no=de1.tr_no and de1.sr_no=2 inner join my_brch b1 on de.brhid=b1.doc_no inner join my_curr c on de.curId=c.doc_no inner join "
					+ "(select account,description,doc_no from my_head where den='305') h1 on de.acno=h1.doc_no inner join my_chqdet d on de.rowno=d.rowno left join my_head h on d.opsacno=h.doc_no "
					+ "left join my_head h2 on de1.acno=h2.doc_no where m.status=3"+sql3+""+sql1+""+xsql+")"+sqls+") as a order by a.chqdt) a,(select @i:=0) r";
			
			
			bean.setPdcqry(xsql);
			//System.out.println("===== "+xsql);
				
	        }
	        	conn.close();
			}catch(Exception e){
				conn.close();	
			}
		return bean;
	}
		
}
