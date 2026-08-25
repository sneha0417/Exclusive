package com.dashboard.audit.applieddelete;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAppliedDeleteDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

		
	public JSONArray appliedGridLoading(String branch,String atype,String accountno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMAD = conn.createStatement();
				
				String xsql = "";
				String condition = "";
				String joins="";String casestatement="";
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AP")){
						condition=" and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AR")){
						condition=" and t1.dramount < 0";
					}
				}
		        
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					xsql+=" and t1.brhId="+branch+"";
	    		}
				
		        xsql = "select a.*,"+casestatement+"'0' dummy from (Select t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t1.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transtype,t1.curid currency,t1.rate,t1.description,"
		        		+ "if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- "
		        		+ "if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),' * ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),' * ','Doc Type : ' ,"
		        		+ "coalesce(t1.dtype),' * ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),' * ','Applied : ', coalesce(if(t1.out_amount<0,"
		        		+ "round((t1.out_amount*-1),2),round(t1.out_amount,2))),"
		        		+ "' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from "
		        		+ "my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no where t1.status=3 and t1.acno="+accountno+""+condition+" and out_amount != 0 "
		        		+ ""+xsql+" group by t1.tranid) a"+joins+"";
		   
				ResultSet resultSet = stmtMAD.executeQuery(xsql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtMAD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray applyInvoiceDeleteGridLoading(String trno,String accountno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMAD = conn.createStatement();
				String joins="";String casestatement="";
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				String sql="select a.*,"+casestatement+"'0' dummy from (select t.doc_no transno,t.dtype transtype,t.description description,t.date date,(t.dramount-t.out_amount+d.amount) tramt,"
						+ "d.amount applying,(t.dramount-t.out_amount) balance,t.out_amount,t.tranid,t.acno,t.curId currency from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid left join gl_invm m on m.dtype=t.dtype and t.doc_no=m.doc_no where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' "
						+ "and acno='"+accountno+"')) a"+joins+"";
            	
				ResultSet resultSet = stmtMAD.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtMAD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
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
				Statement stmtMAD = conn.createStatement();
					
				sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
					+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtMAD.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtMAD.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtMAD.close();
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
