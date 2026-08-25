package com.dashboard.accounts.pdcpostingreverse;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPDCPostingReverseDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray pdcPostingReverseGridLoading(String branch,String code, String txtaccid,String cmbacctype,String fromDate,String toDate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBFPR = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))) {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))) {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
			        
				String xsql = "";
				
				if (code.trim().equalsIgnoreCase("FPP")) {
				    xsql+=" and m.dtype in ('BPV','IBP','COT','OPP')";
				} else {
			        xsql+=" and  m.dtype in ('BRV','IBR','OPR')";  
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					xsql+=" and m.brhID='"+branch+"'";
	    		}
				
			    if(!(sqlFromDate==null)){
			        xsql+=" and q.chqdt>='"+sqlFromDate+"'";
				}
		    
		        if(!(sqlToDate==null)){
		        	xsql+=" and q.chqdt<='"+sqlToDate+"'";
			    }
		        
		        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase(""))) {
		            if(cmbacctype.equalsIgnoreCase("Bank")) {
		            	xsql+=" and d.acno='"+txtaccid+"'";
		            } else { 
		            	xsql+=" and q.opsacno='"+txtaccid+"'";
		            }
	            }
					
				xsql = "select (@i:=@i+1) sr_no,m.dtype,q.tr_no,q.rowno,d.doc_no,d.date,d.description desc1,h1.account bank,h1.description bankname,"  
					 + "d.acno bankacno,q.opsacno acno,h2.atype,h2.account,h2.description accountname,q.pdcposttrno,d.curid,d.rate,"  
					 + "if(d.dramount<0,d.dramount*-1,d.dramount) tr_dr,if(d.dramount<0,(d.dramount*d.rate*-1),d.dramount*d.rate) lamount,"  
					 + "c.code curr,d.brhid,b1.branch,c.type currtype,q.chqdt,q.chqno,b1.branchname from my_chqdet q inner join my_jvtran d on "  
					 + "q.pdcposttrno=d.tr_no left join my_chqbm m on m.tr_no=q.tr_no inner join (select account,description,doc_no from my_head "  
					 + "where den='305') h1 on d.acno=h1.doc_no inner join (select account,description,doc_no,atype from my_head where den<>'305') h2 "  
					 + "on q.opsacno=h2.doc_no inner join my_brch b1 on d.brhid=b1.doc_no inner join my_curr c on d.curId=c.doc_no "
					 + "left join (select (@i:=0) x) a on x=0 WHERE m.docstat!=7 and d.status=3 and d.bankreconcile=0 and q.status='P' and q.PDC=1" + xsql;
		        
				ResultSet resultSet = stmtBFPR.executeQuery(xsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBFPR.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(HttpSession session,String type,String account,String partyname,String contact,String check) throws SQLException {
		
			JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null; 
	       
		     try {
			       conn = ClsConnection.getMyConnection();
			       Statement stmtBFPR = conn.createStatement();
		
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
					
					if(type.equalsIgnoreCase("AP")){
						code="VND";
					}
					else if(type.equalsIgnoreCase("AR")){
						code="CRM";
					}
			        
			        if(!(account.equalsIgnoreCase("0")) && !(account.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and t.account like '%"+account+"%'";
			        }
			        if(!(partyname.equalsIgnoreCase("0")) && !(partyname.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and t.description like '%"+partyname+"%'";
			        }
			        if(!(contact.equalsIgnoreCase("0")) && !(contact.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and a1.per_mob like '%"+contact+"%'";
			        }
			        
			        if(check.equalsIgnoreCase("1")){
			        	
		        	if(type.equalsIgnoreCase("BANK")){
		        		sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
		                		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
		                		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'"+sqltest;
					} else {
				        sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
						    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
						    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+type+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
						    + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')"+sqltest;
					}

		           ResultSet resultSet = stmtBFPR.executeQuery(sql);
			       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		           
			       stmtBFPR.close();
			       conn.close();
			       }
			      stmtBFPR.close();
				  conn.close();   
		     }catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     }finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
}
