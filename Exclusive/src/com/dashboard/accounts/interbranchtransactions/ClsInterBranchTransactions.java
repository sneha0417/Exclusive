package com.dashboard.accounts.interbranchtransactions;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInterBranchTransactions  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray interBranchTransactionsGridLoading(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		
		JSONArray RESULTDATA=new JSONArray();
        
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBIB = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	sql+=" and j.acno='"+accdocno+"'";
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and j.doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }

		        if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and if(j.dramount<0,(j.dramount*j.id),j.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
		        }
		        
		        sql = "select j.doc_no,j.date,j.ref_detail,b.branchname compbranch,h.atype,h.account,h.description accountname,f.costgroup costtype,j.costcode,if(j.dramount>0,round(j.dramount,2),round(0.00,2)) debit,"
		        		+ "if(j.dramount<0,round(j.dramount*j.id,2),round(0.00,2)) credit,if(j.ldramount<0,round(j.ldramount*j.id,2),round(j.ldramount,2)) baseamount,j.description from my_jvtran j left join my_head h "
		        		+ "on j.acno=h.doc_no left join my_costunit f on j.costtype=f.costtype left join my_brch b on j.brhid=b.doc_no where j.status=3 and j.acno not in (select doc_no from my_intr) and j.dtype='"+dtype+"'"+sql+" order by j.dtype,j.doc_no,j.date";
		       
		        
		        if(chk.equalsIgnoreCase("1")){
		        	ResultSet resultSet = stmtBIB.executeQuery(sql);
		        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }
		        else{
		        	stmtBIB.close();
					conn.close();
					return RESULTDATA;
		        }
		        stmtBIB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray interBranchTransactionsExcelExport(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		
		JSONArray RESULTDATA=new JSONArray();
        
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBIB = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	sql+=" and j.acno='"+accdocno+"'";
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and j.doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }

		        if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and if(j.dramount<0,(j.dramount*j.id),j.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
		        }
		        
		        sql = "select j.doc_no 'Doc No',j.date 'Date',j.ref_detail 'Ref No',b.branchname 'Branch',h.atype 'Type',h.account 'Account',h.description 'Account Name',f.costgroup 'Costtype',j.costcode 'Cost Code',if(j.dramount>0,round(j.dramount,2),round(0.00,2)) 'Debit',"
		        		+ "if(j.dramount<0,round(j.dramount*j.id,2),round(0.00,2)) 'Credit',if(j.ldramount<0,round(j.ldramount*j.id,2),round(j.ldramount,2)) 'Baseamount',j.description 'Description' from my_jvtran j left join my_head h "
		        		+ "on j.acno=h.doc_no left join my_costunit f on j.costtype=f.costtype left join my_brch b on j.brhid=b.doc_no where j.status=3 and j.acno not in (select doc_no from my_intr) and j.dtype='"+dtype+"'"+sql+" order by j.dtype,j.doc_no,j.date";
		        
		        if(chk.equalsIgnoreCase("1")){
		        	ResultSet resultSet = stmtBIB.executeQuery(sql);
		        	RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		        }
		        else{
		        	stmtBIB.close();
					conn.close();
					return RESULTDATA;
		        }
		        stmtBIB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String condition="";
	    	    String sql1 = "";
	    	    String sql2 = "";
	    	    
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				else if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            if(!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))){
	                sql1=sql1+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtBIB1 = conn.createStatement();
	        	
				if(type.equalsIgnoreCase("AR") || type.equalsIgnoreCase("AP")){
					sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql1;
					
				}
				
				
				if(type.equalsIgnoreCase("GL") || type.equalsIgnoreCase("HR")){
				    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
		                sql2=sql2+" and t.account like '%"+account+"%'";
		            }
		            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
		             sql2=sql2+" and t.description like '%"+partyname+"%'";
		             }
					sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and t.m_s=0"+ sql2+" ";
					System.out.println(sql);
				}
				
				if(chk.equalsIgnoreCase("2")){
					ResultSet resultSet1 = stmtBIB1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtBIB1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtBIB1.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
