package com.dashboard.audit.vatreportnew;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsVatReportNewDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVatInputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		
		JSONArray data=new JSONArray();
		 
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			 String sqls1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
				 
				 
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				 
			} 
			 
		String sqlsu1="";
		
		String sqlsss="select * from my_menu where menu_name='Veh. Purchase' and gate='E'";
		ResultSet rsss=stmt.executeQuery(sqlsss)		;
		if(rsss.first())
		{
	 sqlsu1 = " union all select br.branchname,date_format(m.date,'%d-%m-%Y') date,Ac.refname Vendor,ac.trnnumber,jv.dtype doctype,convert(m.voc_no,char(25)) vocno,"
			+ " convert(m.purno,char(25)) vendorinvno,date_format(m.purdate,'%d-%m-%Y') vendorinvdate,round((jv.dramount),2)*-1 "+
				" Totalamount,round((if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
				" vat5perpurchase,0 vat0perpurchase, round((coalesce(jv1.dramount,0)),2) vatpaid,'VAT' type,convert('',char(100)) exempted from gl_vpurm m inner join my_jvtran jv on "+
				" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND')"+
				" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
				" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where jv.status=3 and "+
				" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no  ";
		}
		
		String sqlssss="select * from my_menu where menu_name='Maintenance Update' and gate='E'";
		ResultSet rs1=stmt.executeQuery(sqlssss);
		if(rs1.first())
		{
	 sqlsu1=sqlsu1+ " union all select  br.branchname,date_format(m.postdate,'%d-%m-%Y') date,Ac.refname Vendor,ac.trnnumber,jv.dtype doctype,convert(m.voc_no,char(25)) vocno, convert(m.invno,char(25)) vndinvno,"
	 		+ " date_format(m.invdate,'%d-%m-%Y') vendorinvdate,round(sum(jv.dramount),2)*-1 "+
		" Totalamount, round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2) *-1 - round(sum(coalesce(jv1.dramount,0)),2) "+
		" vat5perpurchase,0 vat0perpurchase, round(sum(coalesce(jv1.dramount,0)),2) vatpaid,'VAT' type,convert('',char(100)) exempted from gl_vmcostm m inner join gl_garrage g on "+
		" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0 and jv.status=3) left join my_acbook ac on "+
		" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.postdate between "+
		" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
		" m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno ";
		
		}	
			
			
			strsql="   select * from ( select B.branchname,date_format(m.date,'%d-%m-%Y') date,A.refname Vendor,convert(A.trnnumber,char(100)) trnno,m.dtype doctype,convert(m.voc_no,char(100)) docno , "
 					+ " convert(invno,char(100)) vendorinvno,date_format(m.invdate,'%d-%m-%Y') vendorinvdate,  round(m.totalamount,2) Totalamount,"
 					+ " convert(if(m.total1=0,'',round(m.total1,2)),char(100)) vat5perpurchase,"
 					+ " convert(if(m.total2=0,'',round(m.total2,2)),char(100)) vat0perpurchase, "
 					+ " 	  convert(if(m.tax1=0,'',round(m.tax1,2)),char(100)) vatpaid,if(m.billtype=2,'RCM','VAT') type,"
 					+ "convert(if(m.total3=0,'',round(m.total3,2)),char(100)) exempted from"
 					+ "  (select m.invdate, m.iotype, m.tr_no, m.acno,m. date, m.billtype, m.dtype, m.voc_no, m.brhid, m.invno, "
					+ "  m.totalamount, m.total1, m.total2, m.tax1,m.total3  from my_taxtran m where m.status=3 and "
					+ " m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" and m.iotype=1 ) m "
					+ "left join my_acbook a on  a.acno=m.acno   left join my_brch b on b.doc_no=m.brhid "
					+ " "+sqlsu1+"  "
					/*+ " union all select branchname,date_format(postdate,'%d-%m-%Y') date,refname Vendor,convert(trnnumber,char(100)) trnno, dtype doctype, "
					+ " convert(voc_no,char(25)) docno,convert(invno,char(100)) vendorinvno,date_format(invdate,'%d-%m-%Y') vendorinvdate,round(totalvalue,2) Totalamount ,"
					+ "  convert(if(vatcollected>0,round(totalvalue-vatcollected,2),0),char(100)) vat5perpurchase,convert(if(vatcollected=0,round(totalvalue,2),0),char(100)) vat0perpurchase, convert(vatcollected,char(100))  vatpaid,'VAT' type,convert('',char(100)) exempted "
					+ "  from ( select m.invdate,m.invno,m.postdate,br.branchname,ac.refname,ac.trnnumber,jv.dtype,"
					+ " m.voc_no,m.doc_no,round(sum(jv.dramount),2)*-1 "+
						" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
						" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
						" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0 and jv.status=3) left join my_acbook ac on "+
						" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.postdate between "+
						" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
						" m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno  ) a */
						+ ") s order by doctype,docno  ";
// System.out.println("====="+strsql);
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
	
	 
	public JSONArray getVatOutputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
//			 System.out.println("==== "+branch);
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
				 
			}
//			System.out.println("==== "+branch);
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				 
			} 
			 
			
			
			strsql=" select B.branchname,date_format(m.date,'%d-%m-%Y') date,A.refname customer_name,convert(A.trnnumber,char(100)) trnno,m.dtype doctype,convert(m.voc_no,char(100)) docno , "
 					+ " convert(invno,char(100)) invno,  round(m.totalamount,2) total_invoicevalue,convert(if(m.total1=0,'',round(m.total1,2)),char(100)) vat5persales,"
 					+ " convert(if(m.total2=0,'',round(m.total2,2)),char(100)) vat0persales, "
 					+ " 	  convert(if(m.tax1=0,'',round(m.tax1,2)),char(100)) vatcollected,if(m.billtype=2,'RCM','VAT') type,convert(if(m.total3=0,'',round(m.total3,2)),char(100)) exempted from"
 					+ "  (select  m.iotype, m.tr_no, m.acno,m. date, m.billtype, m.dtype, m.voc_no, m.brhid, m.invno, "
					+ "  m.totalamount, m.total1, m.total2, m.tax1,m.total3  from my_taxtran m where m.status=3 and "
					+ " m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" and m.iotype=2 ) m "
					+ "left join my_acbook a on  a.acno=m.acno   left join my_brch b on b.doc_no=m.brhid order by m.dtype,m.voc_no";
			
			
			 
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
