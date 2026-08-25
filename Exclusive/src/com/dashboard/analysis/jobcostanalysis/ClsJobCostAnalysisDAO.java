package com.dashboard.analysis.jobcostanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobCostAnalysisDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray jobCostAnalysisGridLoading(String branch,String fromdate,String todate,String contracttype,String contract,String cldocno,String salesmandocno,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sqlFromDate = null;
			java.sql.Date sqlToDate = null;
			
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}

	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	
	     	String sqltest="";
	     	
	     	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	     		sqltest+=" and m.brhid="+branch+"";
    		}
	     	
	     	if(!(sqlFromDate==null)){
	     		sqltest+=" and m.date>='"+sqlFromDate+"'";
			}
	     	
	     	if(!(sqlToDate==null)){
	     		sqltest+=" and m.date<='"+sqlToDate+"'";
			}
	     	
	     	if(!(contracttype.equalsIgnoreCase("0")) && !(contracttype.equalsIgnoreCase(""))){
	     		sqltest+=" and m.dtype='"+contracttype+"'";
            }
	     	
	     	if(!(contract.equalsIgnoreCase("0")) && !(contract.equalsIgnoreCase(""))){
	     		sqltest+=" and m.tr_no="+contract+"";
            }
	     	
	     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
	     		sqltest+=" and m.cldocno="+cldocno+"";
            }
	     	
	     	if(!(salesmandocno.equalsIgnoreCase("0")) && !(salesmandocno.equalsIgnoreCase(""))){
	     		sqltest+=" and m.sal_id="+salesmandocno+"";
            }

			/*String sqldata="select m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' "
					+ "WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,"
					+ "coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(est.nettotal,0),2) estimatecost,round((coalesce(m.contractval,0)-coalesce(est.nettotal,0)),2) estimateprofit,"
					+ "round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ec.expenseamount,0),2) actualmaterialamount,round(coalesce(ec.materialexpenseamount,0),2) actualmaterialexpenseamount,coalesce(es.labourhrs,0) labourhrs,"
					+ "coalesce(labourhrstime,'00:00') labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,round((coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualtotal,"
					+ "round(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualprofit,"
					+ "round((coalesce(m.contractval,0)-coalesce(est.nettotal,0))-(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0))),2) variationprofit,"
					+ "round(coalesce(((coalesce(m.contractval,0)-coalesce(est.nettotal,0))/(coalesce(m.contractval,0)-coalesce(est.nettotal,0))-(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0))))*100,0),2) variationprofitperc "
					+ "from cm_srvcontrm m inner join cm_srvqotm sq on sq.tr_no=m.reftrno and sq.status=3 left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 "
					+ "left join cm_srvdetm sr on sr.tr_no=sq.refdocno and sq.ref_type='SRVE' left join cm_prjestm est on ((eq.doc_no=est.refdocno and est.ref_type ='ENQ') or (sr.doc_no=est.refdocno and est.ref_type ='SRVE')) "
					+ "and est.status=3 left join (select co.costtype,co.jobid,sum(co.amount) incomeamount,h.description from cm_srvcontrm m left join my_costtran co on (co.jobid=m.doc_no and co.costtype in (3,4)) left join my_head h on (h.doc_no=co.acno) "
					+ "where m.status=3 and h.gr_type=5 group by co.jobid,co.costtype) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype left join (select ea.costtype,ea.jobid,sum(ea.amount) expenseamount,sum(ea.materialamount) materialexpenseamount from ("
					+ "select co.costtype,co.jobid,if(it.acno is null,co.amount,0) amount,if(it.acno is not null,co.amount,0) materialamount from cm_srvcontrm m left join my_costtran co on (co.jobid=m.doc_no and co.costtype in (3,4)) left join my_head h on "
					+ "(h.doc_no=co.acno) left join my_issuetype it on (it.acno=co.acno) where m.status=3 and h.gr_type=4) ea group by ea.jobid,ea.costtype) ec on ec.jobid=m.doc_no and ec.costtype=m.costtype left join ("
					+ "select ts.doc_no,ts.costtype,ts.costid,sum(ts.labourhrs) labourhrs,CONVERT(if(round((sum(ts.labourhrs))*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((sum(ts.labourhrs))*60))=8,SUBSTRING(SEC_TO_TIME((sum(ts.labourhrs))*60),1,5),SUBSTRING(SEC_TO_TIME((sum(ts.labourhrs))*60),1,6))),CHAR(100)) labourhrstime,"
					+ "sum(ts.labourvalue) labourvalue from (select m.doc_no,m.costtype,m.costid,coalesce(pc.whrs,'00:00') labourhrs,round(coalesce((if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))*e.costperhour),0),2) labourvalue "
					+ "from cm_srvcontrm m inner join hr_timesheethrs ts on (ts.costcode=m.doc_no and ts.costtype=m.costtype) left join hr_empm e on e.doc_no=ts.empid left join hr_paycode pc on e.pay_catid=pc.catid where m.status=3) ts group by ts.costtype,ts.costid) es "
					+ "on es.doc_no=m.doc_no and es.costtype=m.costtype left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3"+sqltest+"";*/
			
		/*	String sqldata="select ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' "
					+ "WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(est.nettotal,0),2) estimatecost,round((coalesce(m.contractval,0)-coalesce(est.nettotal,0)),2) estimateprofit,"
					+ "round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ec.expenseamount,0),2) actualmaterialamount,round(coalesce(ec.materialexpenseamount,0),2) actualmaterialexpenseamount,coalesce(es.labourhrs,0) labourhrs,coalesce(labourhrstime,'00:00') labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,"
					+ "round((coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualtotal,round(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualprofit,"
					+ "round((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)-coalesce(est.nettotal,0)),2) variationprofit,round(coalesce(((coalesce(m.contractval,0)-coalesce(est.nettotal,0))/((coalesce(ic.incomeamount,0)-"
					+ "(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)-coalesce(est.nettotal,0))))*100,0),2) variationprofitperc from cm_srvcontrm m inner join cm_srvqotm sq on sq.tr_no=m.reftrno and sq.status=3 "
					+ "left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sr on sr.tr_no=sq.refdocno and sq.ref_type='SRVE' left join cm_prjestm est on ((eq.doc_no=est.refdocno and est.ref_type ='ENQ') or (sr.doc_no=est.refdocno and est.ref_type ='SRVE')) and est.status=3 "
					+ "left join (select co.costtype,co.jobid,sum(co.amount*-1) incomeamount,h.description from my_costtran co left join my_head h on (h.doc_no=co.acno) where h.gr_type=5 and co.costtype in (3,4) group by co.jobid,co.costtype) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype left join "
					+ "(select ea.costtype,ea.jobid,sum(ea.amount) expenseamount,sum(ea.materialamount) materialexpenseamount from (select co.costtype,co.jobid,if(it.acno is null,co.amount,0) amount,if(it.acno is not null,co.amount,0) materialamount from my_costtran co  left join my_head h on (h.doc_no=co.acno) "
					+ "left join my_issuetype it on (it.acno=co.acno) where h.gr_type=4 and co.costtype in (3,4)) ea group by ea.jobid,ea.costtype) ec on ec.jobid=m.doc_no and ec.costtype=m.costtype left join (select ts.costtype,ts.costcode,sum(ts.labourhrs) labourhrs,"
					+ "CONVERT(if(round((sum(ts.labourhrs))*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((sum(ts.labourhrs))*60))=8,SUBSTRING(SEC_TO_TIME((sum(ts.labourhrs))*60),1,5),SUBSTRING(SEC_TO_TIME((sum(ts.labourhrs))*60),1,6))),CHAR(100)) labourhrstime,sum(ts.labourvalue) labourvalue from "
					+ "(select ts.costtype,ts.costcode,coalesce(pc.whrs,'00:00') labourhrs, round(coalesce((if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))*e.costperhour),0),2) labourvalue from  "
					+ "hr_timesheethrs ts  left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no "
					+ "where ts.costtype in (3,4)) ts group by ts.costtype,ts.costcode) es on es.costcode=m.doc_no and es.costtype=m.costtype left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ "left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3"+sqltest+"";*/
			
	    	String sqldata="select ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' "
					+ "WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(est.nettotal,0),2) estimatecost,round((coalesce(m.contractval,0)-coalesce(est.nettotal,0)),2) estimateprofit,"
					+ "round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ec.expenseamount,0),2) actualmaterialamount,round(coalesce(ec.materialexpenseamount,0),2) actualmaterialexpenseamount,coalesce(es.labourhrs,0) labourhrs,coalesce(labourhrstime,'00:00') labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,"
					+ "round((coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualtotal,round(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualprofit,"
					+ "round((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)-coalesce(est.nettotal,0)),2) variationprofit,round(coalesce(((coalesce(m.contractval,0)-coalesce(est.nettotal,0))/((coalesce(ic.incomeamount,0)-"
					+ "(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)-coalesce(est.nettotal,0))))*100,0),2) variationprofitperc from cm_srvcontrm m left join cm_srvqotm sq on sq.tr_no=m.reftrno and sq.status=3 "
					+ "left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sr on sr.tr_no=sq.refdocno and sq.ref_type='SRVE' left join cm_prjestm est on ((eq.doc_no=est.refdocno and est.ref_type ='ENQ') or (sr.doc_no=est.refdocno and est.ref_type ='SRVE')) and est.status=3 "
					+ "left join (select co.costtype,co.jobid,sum(co.amount*-1) incomeamount,h.description from my_costtran co left join my_head h on (h.doc_no=co.acno) where co.status=3 and  h.gr_type=5 and co.costtype in (3,4) group by co.jobid,co.costtype) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype left join "
					+ "(select ea.costtype,ea.jobid,sum(ea.amount) expenseamount,sum(ea.materialamount) materialexpenseamount from (select co.costtype,co.jobid,if(it.acno is null,co.amount,0) amount,if(it.acno is not null,co.amount,0) materialamount from my_costtran co  left join my_head h on (h.doc_no=co.acno) "
					+ "left join my_issuetype it on (it.acno=co.acno) where co.status=3 and h.gr_type=4 and co.costtype in (3,4)) ea group by ea.jobid,ea.costtype) ec on ec.jobid=m.doc_no and ec.costtype=m.costtype left join (select ts.costtype,ts.costcode,sum(ts.labourhrs) labourhrs,"
					+ "CONVERT(concat(Floor(sum(ts.labourhrs)/60),':',(sum(ts.labourhrs)-(Floor(sum(ts.labourhrs)/60)*60))),CHAR(100)) labourhrstime,sum(ts.labourvalue) labourvalue from "
					+ "(select ts.costtype,ts.costcode,coalesce(normal,'0') labourhrs, round((SUBSTRING_INDEX(normalhrs,':',1) * ts.costperhour) + ((SUBSTRING_INDEX(normalhrs,':',-1)/60)*  ts.costperhour),2) labourvalue from  "
					+ "hr_timesheethrs ts  left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no "
					+ "where ts.costtype in (3,4)) ts group by ts.costtype,ts.costcode) es on es.costcode=m.doc_no and es.costtype=m.costtype left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ "left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3"+sqltest+"";
	    	
	    	
		System.out.println("sqldata  "+sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray contractDetailsSearch(HttpSession session,String dtype,String contractno,String check) throws SQLException {

		  JSONArray RESULTDATA=new JSONArray();
		  
		  if(!(check.equalsIgnoreCase("1"))){
			  return RESULTDATA;
		  }
		  
		  Enumeration<String> Enumeration = session.getAttributeNames();
		  int a=0;
		  while(Enumeration.hasMoreElements()){
		   if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		    a=1;
		   }
		  }
		  if(a==0){
		   return RESULTDATA;
		  }

		  String brhid=session.getAttribute("BRANCHID").toString();

		  Connection conn = null;

		  try {
			   conn = ClsConnection.getMyConnection();
			   Statement stmt = conn.createStatement ();
	
			   String sql11="";


			   if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined") || dtype.equals("ALL"))){
				  sql11=sql11+" and cm.dtype='"+dtype+"'";
			   }
			  
			   if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
				  sql11=sql11+" and cm.doc_no='"+contractno+"'";
			   }
				  
			   String sql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 and 1=1 "+sql11+" order by doc_no";
			   ResultSet resultSet = stmt.executeQuery(sql);
	
			   RESULTDATA=ClsCommon.convertToJSON(resultSet);
			   
			   stmt.close();
			   conn.close();
		  } catch(Exception e){
			  conn.close();
			  e.printStackTrace();
		  }
		  return RESULTDATA;
		 }
	
	public JSONArray clientDetailsSearch(HttpSession session,String clname,String mob,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		String brid=session.getAttribute("BRANCHID").toString();

		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			if(id>0){
				String sql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
				ResultSet resultSet = stmt.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
				stmt.close();
				conn.close();
			}
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}
	
	public JSONArray salesManDetailsSearch(HttpSession session,String slname,String mob,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		String brid=session.getAttribute("BRANCHID").toString();

		String sqltest="";

		if(!(slname.equalsIgnoreCase("undefined"))&&!(slname.equalsIgnoreCase(""))&&!(slname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and sal_name like '%"+slname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and mob_no like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			if(id>0){
				String sql= ("select sal_name,mob_no,doc_no from my_salm where status=3 " +sqltest);
				ResultSet resultSet = stmt.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
				stmt.close();
				conn.close();
			}
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}
}