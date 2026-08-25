package com.dashboard.projectexecution.invoiceProcessing;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;



public class ClsInvoiceProcessingDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();


	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=common.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

public  JSONArray loadContractExcel(String uptodate,String branchid,String clientid,int id,int type,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="",sqlcl="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement();
			java.sql.Date sqluptodate = null;


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and clientid="+clientid+"";
			//	sqlcl=" and cm.cldocno in ("+clientid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and dtype='"+dtype+"' ";
		
			}

			
			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
			{
				sqluptodate=common.changeStringtoSqlDate(uptodate);

			}
			else{

			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and a.brch in ("+branchid+") ";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){	

				
			/** 
			 * 17-09-2017 AFTER SERVICE INVOICE CONDITION CORRECTED	
			 */
				
				/*String sqldata="select * from (select ac.refName 'Name',cm.dtype ,cm.doc_no ,cm.refno 'RefNo',cm.validFrom 'Start Date',"
						+ "cm.validUpto 'End Date', if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) duedate,"
						+ "round(cm.netamount,2) 'Contract Amount', round(if(cm.islegal=1 ,legalchrg,0),2) 'Legal Amount', round(sum(a.amount),2) 'Due Amount',"
						+ "round(coalesce(ser.netamount,0.0),2) 'Other',cm.tr_no,cm.cldocNo clientid,cm.brhid brch from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m "
						+ " on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno "
						+ " where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5"
						+ " union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and duedate<='"+sqluptodate+"' ) as a "
						+ " left join cm_srvcsited sdd on sdd.tr_no=a.tr_no left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(ss.total) as netamount,sv.costid doc_no from cm_srvdetm sv "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select ac.refName 'Name',concat('Service','-',pd.dtype) dtype,cm.doc_no ,cm.refno 'RefNo',"
						+ " cm.validFrom 'Start Date',cm.validUpto 'End Date',  pd.date duedate, round(cm.netamount,2) 'Contract Amount',"
						+ " round(if(cm.islegal=1 ,legalchrg,0),2) 'Legal Amount', round(sum(servamt),2) 'Due Amount',"
						+ "coalesce(round(ser.netamount,2),0) 'Other',cm.tr_no,cm.cldocNo clientid,cm.brhid brch from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no "
						+ "left join (select sum(ss.total) as netamount,sch.doc_no from cm_servplan sch  "
						+ "left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=cm.tr_no)"
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no order by duedate,tr_no,doc_no";*/
				
				String sqldata="select * from (select ac.refName 'Name',si.sitess site,cm.dtype ,cm.doc_no ,cm.refno 'RefNo',cm.validFrom 'Start Date',"
						+ "cm.validUpto 'End Date', if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) duedate,"
						+ "round(cm.netamount,2) 'Contract Amount', round(if(cm.islegal=1 ,legalchrg,0),2) 'Legal Amount', round(sum(a.amount),2) 'Due Amount',"
						+ "round(coalesce(ser.netamount,0.0),2) 'Other',cm.tr_no,cm.cldocNo clientid,cm.brhid brch from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m "
						+ " on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno "
						+ " where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and s.dtype in('sjob','amc') "
						+ " union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and duedate<='"+sqluptodate+"' ) as a "
						+ " left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on (si.tr_no=cm.tr_no) left join (select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type) ser  on(ser.doc_no=a.tr_no and ser.ref_type='"+dtype+"') "
						+ "left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select ac.refName 'Name',si.sitess site,concat('Service','-',pd.dtype) dtype,cm.doc_no ,cm.refno 'RefNo',"
						+ " cm.validFrom 'Start Date',cm.validUpto 'End Date',  pd.date duedate, round(cm.netamount,2) 'Contract Amount',"
						+ " round(if(cm.islegal=1 ,legalchrg,0),2) 'Legal Amount', round(sum(servamt),2) 'Due Amount',"
						+ "coalesce(round(ser.netamount,2),0) 'Other',cm.tr_no,cm.cldocNo clientid,cm.brhid brch from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on (si.tr_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no "
						+ "left join (select sum(ss.total) as netamount,sch.doc_no,sv.ref_type from cm_servplan sch  "
						+ "left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type) ser  on(ser.doc_no=cm.tr_no  and ser.ref_type='"+dtype+"')"
						+ "left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) and pd.date<='"+sqluptodate+"' group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no  having duedate<='"+sqluptodate+"'  order by duedate,tr_no,doc_no";
				
			
				System.out.println("==loadContractexcel==="+sqldata);

				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToEXCEL(resultSet);

			}


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

	public JSONArray invCountgrid(HttpSession session,String date,String branchid,String clientid,int id) throws SQLException
	{

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


		//String brcid=branchid.toString();

		java.sql.Date todate=null;
		String sql11="",sqlcl="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
		//	sql11=sql11+" and clientid="+clientid+"";
		//	sqlcl=" and cm.cldocno in ("+clientid+")";
			sql11=" and a.clientid in ("+clientid+") ";
		}

		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
			todate=common.changeStringtoSqlDate(date);

		}
		else{

		}
		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and a.brch in ("+branchid+") ";
		}
		else{
			sql11=sql11 +" ";
		}



		Connection conn =null;
		Statement stmt =null;

		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){
				
				String sql="select count(*) count,dtype,1 as type from (select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 and sr_no=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,cm.inctax,sr_no,ac.nontax from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno,pd.sr_no "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd  "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ " union all "
						+ "select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd "
						+ " inner join cm_servplan spn on spn.doc_no=pd.tr_no and spn.sr_no=pd.serviceno where  pd.dueafser not in (98,99) "
						+ "and serviceno>0 and pd.invtrno=0 and spn.status=5 and spn.workper=100  and spn.dtype in('sjob','amc')  "
						+ ""
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd  "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and duedate<='"+todate+"'  ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						
						+ " left join (select sum(ss.total) as netamount,sv.costid doc_no from cm_srvdetm sv"
						+ " left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=a.tr_no ) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4) union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ss.total,2),0) tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1  and pd.sr_no=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,cm.inctax,pd.sr_no,ac.nontax from cm_servplan pd  "
						+ "left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join cm_srvdetm sv on pd.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and  ss.invtrno=0 and sv.wrkper=100 "
						+ "left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and "
						+ "pd.serinv=1  and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4)  and pd.date<='"+todate+"'  ) as a "
						+ " where 1=1 "+sql11+" and duedate<='"+todate+"'  order by duedate,tr_no,doc_no ) as xx group by dtype ";
				
				/*String sql="select count(*) count,dtype,1 as type from (select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(a.amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,sdd.site,ac.interserv from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno "
						+ " where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5"
						+ " union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1  ) as a "
						+ " left join cm_srvcsited sdd on sdd.tr_no=a.tr_no left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(ss.total) as netamount,sv.costid doc_no from cm_srvdetm sv "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ser.netamount,2),0) tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,sdd.site,ac.interserv from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no "
						+ "left join (select sum(ss.total) as netamount,sch.doc_no from cm_servplan sch  "
						+ "left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=cm.tr_no)"
						+ " left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ " and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no having duedate<='"+todate+"'   order by duedate,tr_no,doc_no ) as xx group by dtype  ";
				*/
			
				/* String sql= "SELECT count(*) count,dtype,1 as type FROM CM_SRVCONTRM cm inner join "
						+ "(SELECT doc_no as tr_no,date as duedate FROM CM_SERVPLAN where invtrno<=0 and serinv=1 and workper=100 group by doc_no union all "
						+ "SELECT tr_no,duedate FROM CM_Srvcontrpd where invtrno<=0 and invamt<=0 and terms!='PROFORMA INVOICE' group by tr_no) ab "
						+ "on ab.tr_no=cm.tr_no where 1=1 "+sql11+" and cm.jbaction in(0,4) and duedate<='"+todate+"' and cm.status=3 group by dtype  ";

				
				String sql="select count(*) as count,dtype,duedate,tr_no,doc_no,clientid, brch,type from 
				(select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as type from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
						+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
						+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as type from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no having duedate<='"+todate+"'  order by duedate,tr_no,doc_no) as xx group by dtype";
		
				*/
				System.out.println("===serCountgrid===="+sql);

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=common.convertToJSON(resultSet);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}


	public  JSONArray loadGridData(String uptodate,String branchid,String clientid,int id,int type,int trno,int docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and clientid="+clientid+"";
			}

			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
			{
				sqluptodate=common.changeStringtoSqlDate(uptodate);

			}
			else{

			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and a.brch in ("+branchid+")";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){	

				/*String sqldata="select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.doc_no doc_no,cm.refno as refno,  "
						+ "cm.date date,if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval,round(coalesce(sv.netamount,0.0),2) tobeinvamt, "
						+ "round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid from "
						+ "(select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) "
						+ "where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where pd.dueafser=99 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where  pd.dueafser not in (98,99) and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join cm_servplan sch "
						+ "on ( a.tr_no=sch.doc_no and workper=100) left join cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') "
						+ "where  cm.status=3 "+sql11+" and jbaction not in(1) having duedate<='"+sqluptodate+"' order by duedate,cm.tr_no,cm.doc_no ";*/
///other chargesss///////
			
			/*
			 * LEAGAL FEE CHANGE ADDED
			 */
				/*String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 and sr_no=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,cm.inctax,sr_no,'' site,'' siteadd from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno,pd.sr_no "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
						+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd "
						+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
						+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4) union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1  and pd.sr_no=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,cm.inctax,pd.sr_no,sd.site,sd.siteadd from cm_servplan pd left join cm_srvcsited sd on pd.siteid=sd.rowno left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and "
						+ "pd.serinv=1  and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) ) as a "
						+ " where 1=1 "+sql11+"  and tr_no="+trno+"  having duedate<='"+sqluptodate+"'   order by duedate,tr_no,doc_no";

*/				//and ptype="+type+"
				
				String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if((cm.islegal=1 and DUEAFSER=99 and legalno is not null) OR (CM.ISLEGAL=1 AND DUEAFSER!=99 AND SR_NO=1) ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,cm.inctax,sr_no,'' site,'' siteadd from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno,pd.sr_no "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
						+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno,pd.sr_no from  cm_srvcontrpd pd "
						+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 "
						+ "where sv.wrkper=100 group by sv.costid,sv.ref_type) ser  on(ser.doc_no=a.tr_no and ser.ref_type='"+type+"') "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4) union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1  ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,cm.inctax,pd.sr_no,sd.site,sd.siteadd from cm_servplan pd left join cm_srvcsited sd on pd.siteid=sd.rowno left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and "
						+ "pd.serinv=1  and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) ) as a "
						+ " where 1=1 "+sql11+"  and tr_no="+trno+"  having duedate<='"+sqluptodate+"'   order by duedate,tr_no,doc_no";
				
				System.out.println("==loadGridDatadd--->>>"+sqldata);

				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToJSON(resultSet);

			}


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
	
	
	public  JSONArray loadContractData(String uptodate,String branchid,String clientid,int id,int type,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="",sqlcl="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement();
			java.sql.Date sqluptodate = null;


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and clientid="+clientid+"";
				sqlcl=" and cm.cldocno in ("+clientid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and dtype='"+dtype+"' ";
		
			}

			
			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
			{
				sqluptodate=common.changeStringtoSqlDate(uptodate);

			}
			else{

			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and a.brch in ("+branchid+") ";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){	

				/*String sqldata="select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.doc_no doc_no,cm.refno as refno,  "
						+ "cm.date date,if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval,round(coalesce(sv.netamount,0.0),2) tobeinvamt, "
						+ "round(a.amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid from "
						+ "(select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) "
						+ "where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where pd.dueafser=99 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where  pd.dueafser not in (98,99)
 							and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join cm_servplan sch "
						+ "on ( a.tr_no=sch.doc_no and workper=100) left join cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') "
						+ "where  cm.status=3 "+sql11+" and jbaction not in(1) having duedate<='"+sqluptodate+"' order by duedate,cm.tr_no,cm.doc_no ";*/
///////other chrges//////
			/** 
			 * 17-09-2017 AFTER SERVICE INVOICE CONDITION CORRECTED	
			 */
				/*String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(a.amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,sdd.site,ac.interserv from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m "
						+ " on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno "
						+ " where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5"
						+ " union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and duedate<='"+sqluptodate+"'  ) as a "
						+ " left join cm_srvcsited sdd on sdd.tr_no=a.tr_no left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join ( select sum(ss.total) as netamount,sv.costid doc_no from cm_srvdetm sv "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid ) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ser.netamount,2),0) tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,sdd.site,ac.interserv from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no "
						+ "left join (select sum(ss.total) as netamount,sch.doc_no from cm_servplan sch  "
						+ "left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid) ser  on(ser.doc_no=cm.tr_no)"
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no   order by duedate,tr_no,doc_no";*/
				
				
				/*String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
						+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
						+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
						+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
						+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no having duedate<='"+sqluptodate+"'   order by duedate,tr_no,doc_no";

*/					//and ptype="+type+"
				
				String sqldata="select * from (select si.sitess,if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
						+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
						+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(a.amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
						+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
						+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,0 site,ac.interserv from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
						+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m "
						+ " on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 "
						+ "union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno "
						+ " where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and s.dtype in('sjob','amc') "
						+ " union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd "
						+ " inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and duedate<='"+sqluptodate+"'  ) as a "
						+ " left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join ( select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type  ) ser  on(ser.doc_no=a.tr_no and ser.ref_type='"+dtype+"') "
						+ "left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction in(0,4)  group by tr_no union all "
						+ "select si.sitess,3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
						+ "pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ser.netamount,2),0) tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,"
						+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
						+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
						+ "pd.tr_no as pdid,2 as ptype,sdd.site,ac.interserv from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no "
						+ "left join (select sum(ss.total) as netamount,sch.doc_no,sv.ref_type from cm_servplan sch  "
						+ "left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  "
						+ "left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid ,sv.ref_type ) ser  on(ser.doc_no=cm.tr_no and ser.ref_type='"+dtype+"')"
						+ "left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 "
						+ "and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4)  and pd.date<='"+sqluptodate+"' group by pd.doc_no ) as a "
						+ " where 1=1 "+sql11+" group by tr_no   having duedate<='"+sqluptodate+"'   order by duedate,tr_no,doc_no";
				
				System.out.println("==loadContractData==="+sqldata);      

				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToJSON(resultSet);

			}


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



	public ArrayList Insert (HttpSession session,HttpServletRequest request ,java.sql.Date date,String formcode,String mode,ArrayList invList) throws SQLException{



		ArrayList retList=new  ArrayList();


		Connection conn=null;
		CallableStatement stmt =null;
		int docNo=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,clacno=0,brch=0;
		String dtype="",refdtype="",otype="",client="";
		double contramt=0.0,legalfee=0.0,tobeinvamt=0.0,dueamt=0.0;

		java.sql.Date duedate,sdate,edate;
		try{

			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			for(int i=0;i< invList.size();i++){


				String[] surveydet=((String) invList.get(i)).split("::");
				if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
				{

					tr_no=(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:Integer.parseInt(surveydet[0].trim()));

					doc_no=(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:Integer.parseInt(surveydet[1].trim()));

					dtype=(String) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim().toString());

					duedate=(Date) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:common.changetstmptoSqlDate(surveydet[3].toString().trim()));

					contramt=(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:Double.parseDouble(surveydet[4].trim().toString()));

					tobeinvamt=(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:Double.parseDouble(surveydet[5].trim().toString()));

					dueamt=(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:Double.parseDouble(surveydet[6].trim().toString()));

					legalfee=(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?0:Double.parseDouble(surveydet[8].trim().toString()));

					client=(String) (surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?0:surveydet[9].trim().toString());

					clacno=(surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?0:Integer.parseInt(surveydet[10].trim()));

					sdate= (Date) (surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:common.changetstmptoSqlDate(surveydet[11].toString().trim()));

					edate= (Date) (surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:common.changetstmptoSqlDate(surveydet[12].toString().trim()));

					clientid=(surveydet[13].trim().equalsIgnoreCase("undefined") || surveydet[13].trim().equalsIgnoreCase("NaN")|| surveydet[13].trim().equalsIgnoreCase("")|| surveydet[13].isEmpty()?0:Integer.parseInt(surveydet[13].trim()));



					stmt = conn.prepareCall("{CALL Sr_pinvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmt.registerOutParameter(19, java.sql.Types.INTEGER);
					stmt.registerOutParameter(20, java.sql.Types.INTEGER);
					stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
					stmt.setDate(1,date);
					stmt.setInt(2,tr_no);
					stmt.setInt(3, doc_no);
					stmt.setString(4,dtype);
					stmt.setDate(5,duedate);
					stmt.setDouble(6,contramt);
					stmt.setDouble(7,tobeinvamt);
					stmt.setDouble(8,dueamt);
					stmt.setDouble(9,legalfee);
					stmt.setString(10,client);
					stmt.setInt(11,clacno);
					stmt.setDate(12,sdate);
					stmt.setDate(13,edate);
					stmt.setInt(14,clientid);
					stmt.setInt(15,brch);
					stmt.setString(16, session.getAttribute("USERID").toString());
					stmt.setString(17,formcode);
					stmt.setString(18,mode);
					int val = stmt.executeUpdate();
					docNo=stmt.getInt("docNo");
					vocno=stmt.getInt("vocNo");
					otype=stmt.getString("otype");

					request.setAttribute("docNo", docNo);

					retList.add(otype+":"+vocno);

				}

			}

			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}





		return retList;


	}




}
