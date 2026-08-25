package com.dashboard.accounts.intercompanytransactions;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInterCompanyTransactions  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray interCompanyTransactionsGridLoading(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		
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
					sql+=" and brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }

		        if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and if(dramount<0,(dramount*-1),dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
		        }
		        
		        sql = "select doc_no,date,ref_detail,compbranch,atype,account,accountname,costgroup costtype,costcode,if(dramount>0,round(dramount,2),round(0.00,2)) debit,if(dramount<0,round(dramount*id,2),round(0.00,2)) credit,"
		        	+ "if(ldramount<0,round(ldramount*id,2),round(ldramount,2)) baseamount,description from intercompany.intercompany_view where status=3 and dtype='"+dtype+"'"+sql+" order by dtype,doc_no,date";
		       
		        
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
	
	public JSONArray interCompanyTransactionsExcelExport(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		
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
					sql+=" and brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }

		        if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and if(dramount<0,(dramount*-1),dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
		        }
		        
		        sql = "select doc_no 'Doc No',date 'Date',ref_detail 'Ref No',compbranch 'Branch',atype 'Type',account 'Account',accountname 'Account Name',costgroup 'Costtype',costcode 'Cost Code',if(dramount>0,round(dramount,2),round(0.00,2)) 'Debit',if(dramount<0,round(dramount*id,2),round(0.00,2)) 'Credit',"
		        	+ "if(ldramount<0,round(ldramount*id,2),round(ldramount,2)) 'Baseamount',description 'Description' from intercompany.intercompany_view where status=3 and dtype='"+dtype+"'"+sql;
		       
		        
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
