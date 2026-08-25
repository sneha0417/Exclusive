package com.dashboard.accounts.bankledger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBankLedgerDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray bankLedgerGridLoading(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBankLedger = conn.createStatement();
				String sql = "",sql1="";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    			sql1+=" and brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select a.*,"+casestatement+"q.chqno,q.chqdt,b.branchname from (select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join ( select 0 brhid,DATE_SUB('"+sqlFromDate+"',INTERVAL 1 DAY) trdate,'OPN' ref_detail,'OPENING BALANCE' tr_des,t.acno,0 srno,0 tr_no, 1 curId, sum(t.dramount) dramount,"
						+ "sum(t.ldramount) ldramount, 1 rate,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and t.yrid=0 and t.date<'"+sqlFromDate+"' and t.acno="+accdocno+""+sql+" UNION ALL select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount*-1 dramount,t.ldramount*-1 ldramount,"
						+ "t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where t.tr_no in (select tr_no from my_jvtran where status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and acno="+accdocno+" and yrid=0"+sql1+") and t.acno not in (select "+accdocno+" doc_no UNION ALL select doc_no from my_intr)) t "
						+ "on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by trdate,acno,transNo,t.curId,transType) a left join my_chqdet q on q.tr_no=a.tr_no left join my_brch b on b.doc_no=a.brhid"+joins+"";
 
				System.out.println("SQL ="+sql);
				
				ResultSet resultSet = stmtBankLedger.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBankLedger.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray bankLedgerGridExcelExport(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBankLedger = conn.createStatement();
				String sql = "",sql1="";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    			sql1+=" and brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select a.trdate 'Date',a.transtype 'Type',"+casestatement+"a.account 'Account No.',a.accountname 'Account',b.branchname 'Branch',q.chqno 'Cheque No',q.chqdt 'Cheque Date',a.description 'Description',a.currency 'Currency',a.rate 'Rate',a.dr 'Debit',a.cr 'Credit',"
					+ "a.debit 'Base Debit',a.credit 'Base Credit' from (select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
					+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
					+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select 0 brhid,DATE_SUB('"+sqlFromDate+"',INTERVAL 1 DAY) trdate,'OPN' ref_detail,'OPENING BALANCE' tr_des,acno,0 srno,0 tr_no, 1 curId, sum(t.dramount) dramount,"  
					+ "sum(t.ldramount) ldramount, 1 rate,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and t.yrid=0 and t.date<'"+sqlFromDate+"' and t.acno="+accdocno+""+sql+" UNION ALL select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount*-1 dramount,"
					+ "t.ldramount*-1 ldramount,t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where t.tr_no in (select tr_no from my_jvtran where status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and acno="+accdocno+" and yrid=0"+sql1+") "
					+ "and t.acno not in (select "+accdocno+" doc_no UNION ALL select doc_no from my_intr)) t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by trdate,acno,transNo,t.curId,transType) a left join my_chqdet q on q.tr_no=a.tr_no left join my_brch b on b.doc_no=a.brhid"+joins+"";
				
				ResultSet resultSet = stmtBankLedger.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtBankLedger.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	               sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtBankLedger1 = conn.createStatement();
	        	
					sql = "select t.doc_no,t.account,t.description,c.code currency from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='GL' and t.m_s=0 and t.den=305"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtBankLedger1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtBankLedger1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtBankLedger1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsBankLedgerBean getPrint(HttpServletRequest request,int acno,String branch,String fromdate,String todate) throws SQLException {
		ClsBankLedgerBean bean = new ClsBankLedgerBean();
		
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtBankLedger = conn.createStatement();
		String sql="";String mainbranch="";
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
        	mainbranch=branch;        	
		}else{
			mainbranch="1";
		}
		
		sql="select b.branchname,'Bank Ledger' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
				+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
				+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";
		
		ResultSet resultSet = stmtBankLedger.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			bean.setLblcomptel2(resultSet.getString("tel2"));
			bean.setLblcompwebsite(resultSet.getString("web"));
			bean.setLblcompemail(resultSet.getString("email"));
			
		}
		
		String sqls="select j.acno,t.account,t.description from my_jvtran j left join my_head t on j.acno=t.doc_no where j.acno="+acno+" group by acno";
		ResultSet resultSets = stmtBankLedger.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setAccountno(resultSets.getString("account"));
			bean.setAccountname(resultSets.getString("description"));
		}
		
		stmtBankLedger.close();
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
