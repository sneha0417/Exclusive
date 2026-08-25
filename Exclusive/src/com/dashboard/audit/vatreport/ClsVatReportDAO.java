package com.dashboard.audit.vatreport;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsVatReportDAO {

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
				sqls1= " and jv.brhid="+branch+" ";
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			} 
			
 			strsql=" select B.branchname,date_format(m.date,'%d-%m-%Y') date,A.refname Vendor,convert(A.trnnumber,char(100)) trnno,m.dtype doctype,convert(docno,char(100)) docno , "
 					+ " convert(invno,char(100)) vendorinvno,  round(totalvalue,2) Totalamount,convert(if(vatapplied=0,'',round(vatapplied,2)),char(100)) vat5perpurchase,convert(if(vatnotapplied=0,'',round(vatnotapplied,2)),char(100)) vat0perpurchase, "
 					+ " convert(if(vatcollected=0,'',round(vatcollected,2)),char(100)) vatpaid from ( select a.brhid,a.date,a.cldocno,a.dtype,a.vocno docno,coalesce(a.vndinvno,'') invno, "
 					+ " a.totalvalue,  (a.vatapplied) vatapplied,a.vatnotapplied vatnotapplied, "
 					+ "    a.vatcollected  from (select ac.cldocno,m.brhid,convert(m.invno,char(25)) vndinvno,m.date ,m.dtype, "
 					+ "        convert(m.voc_no,char(25)) vocno,m.doc_no,	  sum(d.nettotal+d.taxamount)  totalvalue, "
 					+ "        aa.app vatapplied,bb.notapp  vatnotapplied,   if(sum(d.taxamount)>0,sum(d.taxamount),0) vatcollected from my_srvpurm m "
 					+ "   left join (select   sum(nettotal) app,rdocno from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no "
 					+ "   left join (select   sum(nettotal) notapp,rdocno from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no "
					+ "    left join my_srvpurd d on d.rdocno=m.doc_no   left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND')"
 					+ " left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0) "
 					+ " left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 "
 					+ " and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+"    group by m.tr_no) a "
 					+"  union all "+
 					" select jv.brhid,jv.date,ac.acno cldocno,jv.dtype,convert(jv.doc_no,char(25)) vocno,'' invno, "
 					+ " round(sum(c.amt+(coalesce(taxjv.dramount,0)*-1)),2) totalvalue, round((if( coalesce(taxjv.dramount,0)!=0.00,c.amt,0)),2) vatapplied,  round((if( coalesce(taxjv.dramount,0)=0.00,c.amt,0)),2) vatnotapplied, round(coalesce(taxjv.dramount * -1 ,0),2)  vatcollected "+
 					" from my_cnot jv inner join (select sum(amount*-1) amt,tr_no from my_cnotd c "
 					+ " where c.acno not in (select acno from gl_taxmaster where type=1 and per>0 and status=3) group by tr_no) c on jv.tr_no=c.tr_no left join"+
 					" gl_taxmaster tax on (jv.date between tax.fromdate and tax.todate  and tax.type=1 and tax.per>0)  left join (select coalesce(dramount,0) dramount,tr_no,acno"+
 					" from my_jvtran where status=3 and dtype='DNO' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno)"+
 					" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_taxmaster where type=1  and per>0 and status=3)) left join my_acbook ac on"+
 					" ac.acno=jv.acno left join my_brch b on b.doc_no=jv.brhid where jv.status=3 and jv.dtype='DNO' and  jv.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+
 					" "+sqls1+"  group by jv.tr_no "
 							+ "union all "
 					+ " select m.brhid,m.date,m.cldocno,m.dtype,m.voc_no docno ,m.refinvno invno,totalvalue,vatapplied,vatnotapplied, vatcollected "
 					+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
 					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
 					+ " on d2.rdocno=m.doc_no "
 					+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
 					+ " on d3.rdocno=m.doc_no  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+"  group by m.doc_no "
 					+ " union all   select m.brhid,m.date,m.cldocno,m.dtype,m.voc_no docno, inv.refinvno invno,totalvalue*-1,vatapplied*-1,vatnotapplied*-1, vatcollected*-1 vatcollected "
 					+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
 					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
 					+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
 					+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno "
 					+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+"  group by m.doc_no "
 					+ " union all select m.brhid,m.date,h.cldocno,m.dtype,convert(m.doc_no,char(25)) vocno,m.refno,"  
  					+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal))  totalvalue,"
  			        + " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,"
  					+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied,"  
  			        + " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d " + "on m.tr_no=d.tr_no "
  			        + " left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.dtype='TCN'  and h.atype='AP' and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"  group by m.tr_no " 
  						+ "  union all select m.brhid,m.date,h.cldocno,m.dtype,convert(m.doc_no,char(25)) vocno,convert(m.refno,char(150)) invno,"
  						+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)*-1) totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied,sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied, sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d on" 
  						+ " m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
  						+ " left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.dtype='TDN' and h.atype='AP' "
  						+ " and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"  group by m.tr_no "
 					
 					+ ") m  left join my_acbook a on   if(m.dtype='DNO',a.acno=m.cldocno,a.cldocno=m.cldocno and a.dtype='VND')   left join my_brch b on b.doc_no=m.brhid";
	 	    System.out.println("input "+strsql);     
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
			
			  strsql=" select  B.branchname,date_format(m.date,'%d-%m-%Y') date,A.refname customer_name,convert(A.trnnumber,char(100))  trnno,m.dtype doctype,"
			  		+ " convert(docno,char(100)) docno ,convert(invno,char(100)) invno,"
			  		+ " round(totalvalue,2) total_invoicevalue,convert(if(vatapplied=0,'',round(vatapplied,2)),char(100))  vat5persales,convert(if(vatnotapplied=0,'',round(vatnotapplied,2)),char(100)) vat0persales,"
					+ " convert(if(vatcollected=0,'',round(vatcollected,2)),char(100)) vatcollected from (select m.brhid,m.date,m.cldocno,m.dtype,m.voc_no docno ,m.voc_no invno,coalesce(d1.totalvalue,0)+coalesce(d11.totalvalue,0) "
					+ "   totalvalue  ,coalesce(d2.vatapplied,0)+coalesce(d12.vatapplied,0) vatapplied,"
					+ "   coalesce(d3.vatnotapplied,0)+coalesce(d13.vatnotapplied,0) vatnotapplied, "
					+ " coalesce(d1.vatcollected,0)+coalesce(d11.vatcollected,0) vatcollected  from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue,  "
					+ " sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1  on d1.rdocno=m.doc_no "
					+ " left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2  on d2.rdocno=m.doc_no "
					+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 	on d3.rdocno=m.doc_no  "
					+ " left join (select coalesce(sum(nettotal),0)   totalvalue, coalesce(sum(srvtaxamount),0) vatcollected ,rdocno from  "
					+ " my_invdser group by rdocno) d11  on d11.rdocno=m.doc_no "
					+ "left join (select sum(nettotal-srvtaxamount) vatapplied,rdocno from my_invdser  where srvtaxamount>0 group by rdocno) d12  on d12.rdocno=m.doc_no "
					+ "left join (select sum(nettotal)   vatnotapplied,rdocno from my_invdser where srvtaxamount=0 group by rdocno) d13  on d13.rdocno=m.doc_no "
					+ "	where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" group by m.doc_no"
					//+ " union all select m.brhid,m.date,h.cldocno,m.dtype,convert(m.doc_no,char(25)) vocno,convert(m.refno,char(25)) invno,sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)*-1)  totalvalue, sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied, sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d on m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TCN' and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"'   group by m.tr_no "
					+ " union all select m.brhid,m.date,h.cldocno,m.dtype,convert(m.doc_no,char(25)) vocno,m.refno,"
					+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)*-1)  totalvalue,"
			        + " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied,"
					+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,"
			        + " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d " + "on m.tr_no=d.tr_no "
			        + " left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TCN'  and h.atype='AR' and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"  group by m.tr_no "
			        + "  union all"
						+ " select  m.brhid,m.date,h.cldocno,m.dtype,convert(m.doc_no,char(25)) vocno,convert(m.refno,char(150)) invno,"
						+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)) totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied, sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d on" 
						+ " m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
						+ " left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TDN' and h.atype='AR' "
						+ " and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"  group by m.tr_no "  
					
					+ " union all select m.brhid,m.date,m.cldocno,m.dtype,m.voc_no docno, inv.voc_no invno,totalvalue*-1,vatapplied*-1,vatnotapplied*-1, vatcollected*-1 vatcollected  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" "
					+ " group by m.doc_no union all select  m.brhid,m.date,m.cldocno,M.DTYPE,M.DOC_NO docno,M.DOC_NO INVNO,ROUND(ATOTAL+TAXAMT,2) AMOUNT, "
					+ " IF(TAXAMT>0,ROUND(ATOTAL,2),0) VATAPPLIED, IF(TAXAMT=0,ROUND(ATOTAL,2),0) VATNOTAPPLIED,TAXAMT VATCOLLECTED from my_servm M  "
					+ " WHERE M.STATUS=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" union all select m.brhid,m.date,m.cldocno,m.dtype,m.doc_no docno,"
					+ "m.rdocno invno,ROUND(ATOTAL+TAXAMT,2)*-1 AMOUNT,  IF(TAXAMT>0,ROUND(ATOTAL,2),0)*-1 VATAPPLIED, IF(TAXAMT=0,ROUND(ATOTAL,2),0)*-1 VATNOTAPPLIED,TAXAMT*-1 VATCOLLECTED "
					+ "from my_servretm m WHERE M.STATUS=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+" "
					+ " union all select brhid,a.date,a.cldocno,a.dtype,a.vocno,coalesce(a.vndinvno,'') INVNO,sum(a.totalvalue) totalvalue,"
					+ "  sum(vatapplied) vatapplied,sum(vatnotapplied) vatnotapplied, sum(a.vatcollected) vatcollected  from  "
					+ "(select m.tr_no,ac.cldocno,m.brhid,convert(m.voc_no,char(25)) vndinvno,m.date ,'SRS' dtype, "
					+ " convert(m.voc_no,char(25)) vocno, m.doc_no, round((d.nettaxamount),2) totalvalue,"
					+ "round(if((coalesce(d.tax,0))>0,(d.nettotal),0),2) vatapplied,round(if((coalesce(d.tax,0))=0,(d.nettotal),0),2) vatnotapplied,"
					+ " round((coalesce(d.tax,0)),2) vatcollected from my_srvsalem m inner join my_srvsaled d on ( d.rdocno=m.doc_no ) "
					+ " left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM') "
					+ "  where m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+"     ) a group by tr_no ) m "
					+ " left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join my_brch b on b.doc_no=m.brhid "
					+ " union all select B.branchname,date_format(pr.date,'%d-%m-%Y') date,h.description customer_name,convert(Ac.trnnumber,char(100))  trnno,pr.dtype doctype, convert(vocno,char(100)) docno ,convert(invno,char(100)) invno, round(totalvalue,2) total_invoicevalue,convert(if(vatapplied=0,'',round(vatapplied,2)),char(100))  vat5persales,convert(if(vatnotapplied=0,'',round(vatnotapplied,2)),char(100)) vat0persales, convert(if(vatcollected=0,'',round(vatcollected,2)),char(100)) vatcollected from (select brhid,a.date,a.cldocno,a.dtype,a.vocno,coalesce(a.vndinvno,'') INVNO,sum(a.totalvalue) totalvalue,  sum(vatapplied) vatapplied,sum(vatnotapplied) vatnotapplied, sum(a.vatcollected) vatcollected  from  (select m.tr_no,ac.doc_no cldocno,m.brhid,convert(m.voc_no,char(25)) vndinvno,m.date , m.dtype,  convert(m.voc_no,char(25)) vocno, m.doc_no, round((d.nettaxamount),2) totalvalue,round(if((coalesce(d.tax,0))>0,(d.nettotal),0),2) vatapplied,round(if((coalesce(d.tax,0))=0,(d.nettotal),0),2) vatnotapplied, round((coalesce(d.tax,0)),2) vatcollected from rl_prinvm m inner join rl_prinvd d on ( d.rdocno=m.doc_no )  left join my_head ac on (m.acno=ac.doc_no)   "
					+ " where m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest+"       ) a group by tr_no ) pr left join my_brch b on b.doc_no=pr.brhid  left join my_head h on (pr.cldocno=h.doc_no)   left join my_acbook ac on (pr.cldocno=ac.acno) ";
 
		 //System.out.println("output "+strsql);
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
