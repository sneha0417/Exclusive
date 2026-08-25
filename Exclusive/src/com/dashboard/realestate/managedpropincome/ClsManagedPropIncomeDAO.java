package com.dashboard.realestate.managedpropincome;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;

public class ClsManagedPropIncomeDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getManagedPropData(String branch, String fromdate, String todate, String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			int adminfeeacno=0,ejariacno=0,agentcommacno=0,propmgmtacno=0,maintexpacno=0,commacno=0;
			String strgetacno="select (select acno from rl_terms_contract where idno=6) adminfeeacno,(select acno from rl_terms_contract where idno=7) ejariacno,"+
			" (select head.doc_no from my_account ac left join my_head head on ac.acno=head.doc_no where ac.codeno='COMMISSION ACCOUNT') agentcommacno,"+
			" (select head.doc_no from my_account ac left join my_head head on ac.acno=head.doc_no where ac.codeno='PROPERTYMGMTFEE') propmgmtacno,"+
			" (select head.doc_no from my_account ac left join my_head head on ac.acno=head.doc_no where ac.codeno='MAINTENANCE EXPENSE') maintexpacno,"+
			" (select head.doc_no from my_account ac left join my_head head on ac.acno=head.doc_no where ac.codeno='COMEXP') commacno";
			ResultSet rsgetacno=stmt.executeQuery(strgetacno);
			while(rsgetacno.next()){
				adminfeeacno=rsgetacno.getInt("adminfeeacno");
				ejariacno=rsgetacno.getInt("ejariacno");
				agentcommacno=rsgetacno.getInt("agentcommacno");
				propmgmtacno=rsgetacno.getInt("propmgmtacno");
				maintexpacno=rsgetacno.getInt("maintexpacno");
				commacno=rsgetacno.getInt("commacno");
			}
			String strsql="select * from (select sum(adminfeejv.jvamt*adminfeejv.id) adminfeeamt,sum(ejarijv.jvamt*ejarijv.id) ejariamt,sum(commincome.jvamt*commincome.id) commincome,sum(propmgmtjv.jvamt*propmgmtjv.id) propmgmtamt,"+
			" sum(maintexpjv.jvamt*maintexpjv.id) maintexpamt,sum(agentcommexp.jvamt*agentcommexp.id) agentcommexp,m.accname propname, o.primary_owner ownername,m.unitno unitno,pt.code proptype,"+
			" ut.unittype unittype from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_propertytype pt on"+
			" pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join rl_tncm tm on tm.prtype=m.doc_no left join rl_prinvm"+
			" inv on inv.refno=tm.doc_no and inv.reftype='TNC'"+
			" left join (select sum(dramount) jvamt,tr_no,id from my_jvtran where acno="+adminfeeacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) adminfeejv on (adminfeejv.tr_no=inv.tr_no)"+
			" left join (select sum(dramount) jvamt,tr_no,id from my_jvtran where acno="+ejariacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) ejarijv on (ejarijv.tr_no=inv.tr_no)"+
			" left join (select sum(dramount) jvamt,tr_no,id from my_jvtran where acno="+agentcommacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) commincome on (inv.tr_no=commincome.tr_no)"+
			" left join (select sum(dramount) jvamt,tr_no,id from my_jvtran where acno="+propmgmtacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) propmgmtjv on (inv.tr_no=propmgmtjv.tr_no)"+
			" left join (select sum(dramount) jvamt,tr_no,mr.pdoc_no,j.id from my_jvtran j"+
			" left join re_mreqmgmt mm on ((mm.invdoc=j.doc_no and j.dtype='PRIV'))"+
			" left join re_mreq mr on mr.doc_no=mm.rdocno where acno="+maintexpacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) maintexpjv"+
			" on (maintexpjv.pdoc_no=m.doc_no)"+
			" left join (select sum(dramount) jvamt,tr_no,id from my_jvtran where acno="+commacno+" and date>='"+sqlfromdate+"' and date<='"+sqltodate+"' group by tr_no) agentcommexp on (inv.tr_no=agentcommexp.tr_no)"+
			" where m.status=3 and m.active=1 and mgprpty=1  group by m.doc_no) a where (a.adminfeeamt>0.0 or a.ejariamt>0.0 or a.commincome>0.0 or a.propmgmtamt>0.0 or a.maintexpamt>0.0 or a.agentcommexp>0.0)";
			System.out.println("Grid Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
}
