package com.dashboard.realestate.summarystatement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsSummaryStatementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray loadsummaryGrid(String ownid,String id,String todate) throws SQLException {                   
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		 java.sql.Date sqlToDate = null;
		try {
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			 }
			 //String strsql="select accname,mrfacno,acno,round(pcredit,2) pcredit,round(pdebit,2) pdebit,round(mcredit,2) mcredit,round(mdebit,2) mdebit,round((pcredit+pdebit+mcredit+mdebit),2) nettotal from(select  m.accname,coalesce(m.mrf_acno,0) mrfacno,coalesce(m.acno,0) acno,if(coalesce(jp1.credit,0)<0,coalesce(jp1.credit,0)*-1,0) pcredit,coalesce(jp2.debit,0) pdebit,if(coalesce(jm1.credit,0)<0,coalesce(jm1.credit,0)*-1,0) mcredit,coalesce(jm2.debit,0) mdebit from rl_propertymaster m left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jp1 on jp1.acno=m.acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jp2 on jp2.acno=m.acno left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jm1 on jm1.acno=m.mrf_acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jm2 on jm2.acno=m.mrf_acno  where m.owid='"+ownid+"')a"; 
			 String strsql="select a.accname,a.acno,a.mrfacno,round(if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0)),2) pcredit,round(if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0)),2) pdebit,round(if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0)),2) mcredit,round(if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0)),2) mdebit,round((if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0))-if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0))+if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0))-if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0))),2) nettotal from (select  m.accname,m.mrf_acno mrfacno,m.acno,if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) pcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) pdebit,m.doc_no   from rl_propertymaster m left join my_jvtran j on j.acno=m.acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.acno) a left join (select  if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) mcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) mdebit,m.doc_no from rl_propertymaster m left join my_jvtran j on j.acno=m.mrf_acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.mrf_acno) b on a.doc_no=b.doc_no";
			 //System.out.println("strsql---->>>"+strsql);            
			 ResultSet resultSet = stmt.executeQuery(strsql);            
			 RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray summaryASData(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
				//System.out.println("============"+sql);
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
