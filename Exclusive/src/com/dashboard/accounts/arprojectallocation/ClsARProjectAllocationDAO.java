package com.dashboard.accounts.arprojectallocation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsARProjectAllocationDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String condition="";
	    	    String sql1 = "";
	    	    
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
				Statement stmtAccountStatement1 = conn.createStatement();
	        	
				if(type.equalsIgnoreCase("AR") || type.equalsIgnoreCase("AP")){
					sql = "select a.per_mob,a.mail1 email,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql1;
				}
				
				if(type.equalsIgnoreCase("GL") || type.equalsIgnoreCase("HR")){
					sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and t.m_s=0"+sql1;
				}
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray arProjectAllocationGridLoading(String branch,String accdocno,String fromdate,String todate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				
				
				 java.sql.Date sqlFromDate = null;
			       java.sql.Date sqlToDate = null;
			       
			       
			    /*   
			       if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			        	 sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
			        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			        	 sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			    */    
				
				if(!fromdate.equalsIgnoreCase("")){
					sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!fromdate.equalsIgnoreCase("")){
					sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sql = "",sqltest="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sqltest+=" and j.brhId="+branch+"";
	    		}
				
				if(!((accdocno.equalsIgnoreCase("")) || (accdocno.equalsIgnoreCase("0")))){
					sqltest+=" and j.acno ='"+accdocno+"'";
		        }
				if(sqlFromDate!=null){
					sqltest+=" and j.date>='"+sqlFromDate+"'";
				}
				if(sqlToDate!=null){
					sqltest+=" and j.date<='"+sqlToDate+"'";
				}
				String joins="",casestatement="";
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select "+casestatement+"a.account,a.accountname,a.acno,a.doc_no,a.transtype,a.date,a.debit,a.credit,a.savebtn,a.removebtn,a.tranid,convert(if(a.jobno=0,'',a.jobno),char(10)) jobno,a.jobname from (select c.description jobname,j.rdocno jobno,h.account,h.description accountname,j.acno,j.doc_no,"
						+ "j.doc_no transno,j.dtype transtype,j.date,j.brhid,j.tranid,round(if(j.ldramount>0,j.ldramount*j.id,0),2) debit,round(if(j.ldramount<0,j.ldramount*j.id,0),2) credit,'SAVE' savebtn,'Remove' removebtn "
						+ "from my_jvtran j left join my_head h on (j.acno=h.doc_no and h.atype='AR')  left join my_ccentre c on c.doc_no=j.rdocno where j.status=3 and h.atype='AR' "+sqltest+") a"+joins+"";
                
				
				
				System.out.println("grid load==="+sql);
				
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costcodeSearchLoading(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				
				String sql = "select costcode code,doc_no doc_no,description name from my_ccentre where m_s=0";
				
				System.out.println("cost code search query==="+sql);

				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
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
