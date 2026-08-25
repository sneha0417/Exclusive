package com.dashboard.audit.bankreconciliation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBankReconciliationDAO  {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

  public JSONArray bankReconciliationGridLoading(String branch, String fromdate, String todate, String acno, String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;  
	
	  try {
		    conn = connDAO.getMyConnection();
		    Statement stmtBRCN = conn.createStatement ();
	    
		    java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		    if(check.equalsIgnoreCase("1")) {
		    
		    	String sql ="",sql1="";
		    	
		    	if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = commonDAO.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    			sql1+=" and t.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and t.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and t.date<='"+sqlToDate+"'";
			    }
				
		        sql = "select t.date,t.dtype,t.doc_no,q.chqno,q.chqdt,@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) cr,@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) dr,"
		        		+ "if(t.bankreconcile>0,1,0) chk,t.clearedon c_date,t.description,t.ref_detail,t.tranid,(select max(tranid) from my_jvtran where doc_no=t.doc_no and dtype=t.dtype) maxtrid,"
		        		+ "(select acno from my_jvtran where doc_no=t.doc_no and dtype=t.dtype and tranid=maxtrid) ac,(select description from my_head where doc_no=ac) party from my_jvtran t "
		        		+ "inner join my_brch b on t.brhId=b.doc_no left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno"+sql1+" where "
						+ " t.status=3 and t.yrid=0 and t.acno="+acno+""+sql+"";
			
				ResultSet resultSet = stmtBRCN.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		    
		    }
		    
		    stmtBRCN.close();
		    conn.close();
	  } catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  } finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}	
  
  public JSONArray bankReconciliationExcelExport(String branch, String fromdate, String todate, String acno, String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;  
		
		  try {
			    conn = connDAO.getMyConnection();
			    Statement stmtBRCN = conn.createStatement ();
		    
			    java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
			    if(check.equalsIgnoreCase("1")) {
			    
			    	String sql ="",sql1="";
			    	
			    	if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
	                }
					
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqlToDate = commonDAO.changeStringtoSqlDate(todate);
					}
					
					if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and t.brhId="+branch+"";
		    			sql1+=" and t.brhId="+branch+"";
		    		}
					
					if(!(sqlFromDate==null)){
			        	sql+=" and t.date>='"+sqlFromDate+"'";
				    }
			        
			        if(!(sqlToDate==null)){
			        	sql+=" and t.date<='"+sqlToDate+"'";
				    }
					
				    sql = "select a.date 'Date',a.dtype 'Doc Type',a.doc_no 'Doc No.',a.chqno 'Cheque No.',a.chqdt 'Cheque Date',a.cr 'Receipts',a.dr 'Payments',if(a.chk=1,'Yes','No') 'Posted',"
				    		+ "a.c_date 'Posted Date',a.description 'Description',a.party 'Party Name',a.ref_detail 'Reference' from (select t.date,t.dtype,t.doc_no,q.chqno,q.chqdt,"
				    		+ "@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) cr,@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) dr,if(t.bankreconcile>0,1,0) chk,t.clearedon c_date,"
				    		+ "t.description,t.ref_detail,t.tranid,(select max(tranid) from my_jvtran where doc_no=t.doc_no and dtype=t.dtype) maxtrid,(select acno from my_jvtran where "
				    		+ "doc_no=t.doc_no and dtype=t.dtype and tranid=maxtrid) ac,(select description from my_head where doc_no=ac) party from my_jvtran t inner join my_brch b on "
				    		+ "t.brhId=b.doc_no left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno"+sql1+" where t.status=3 and t.yrid=0 "
				    		+ "and t.acno="+acno+""+sql+") a";
				    
					ResultSet resultSet = stmtBRCN.executeQuery(sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
			    
			    }
			    
			    stmtBRCN.close();
			    conn.close();
		  } catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
  
  public JSONArray accountDetails(String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    		conn = connDAO.getMyConnection();
	    		Statement stmtBRCN = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
				
				sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='GL' and t.m_s=0 and t.den=305"+sql1;
				
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtBRCN.executeQuery(sql);
					RESULTDATA1=commonDAO.convertToJSON(resultSet1);
				}
				else{
					stmtBRCN.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtBRCN.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
  
}
