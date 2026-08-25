package com.dashboard.projectexecution.serviceCompletion;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceCompletionDAO {

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


	public JSONArray invCountgrid(HttpSession session,String date,String branchid,String clientid,int id,int isradio) throws SQLException
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
		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and c.cldocno in ("+clientid+") ";
		}
		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			todate=common.changeStringtoSqlDate(date);
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			/*java.sql.Date todate=common.changeStringtoSqlDate(date);*/
			//sql11=sql11+" and x.dates<='"+todate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and c.brhid in ("+branchid+") ";
		}



		Connection conn =null;
		Statement stmt =null;

		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){

				String sql="";

				String havin="";

				if(isradio==1){
					/*sql="select count,dtype,type from (select count(*) count,dtype,dtype type,date,cldocno from cm_srvcontrm m where jbaction!=3 and status!=7 and date<='"+todate+"' "+sql11+" group by dtype "
							+ "union all select count(*) count,dtype,dtype type,date,cldocno from cm_cuscallm m where clstatus!=3 and status!=7 and date<='"+todate+"'  "+sql11+" group by dtype) as a "
							+ " group by dtype";*/
					/*havin=" having workper<100";*/
					
					havin=" and (x.completedschedule-x.totalschedule)!=0";
				}
				if(isradio==2){
					/*sql="select count,dtype,type from (select count(*) count,dtype,dtype type,date,cldocno from cm_srvcontrm m where jbaction!=3 and status!=7 and date<='"+todate+"' "+sql11+" group by dtype "
							+ "union all select count(*) count,dtype,dtype type,date,cldocno from cm_cuscallm m where clstatus!=3 and status!=7 and date<='"+todate+"'  "+sql11+" group by dtype) as a "
							+ " group by dtype";*/
					/*havin="having  workper=100";*/
					
					havin=" and (x.completedschedule-x.totalschedule)=0 and coalesce(y.pendinginvoice,0)=0";
				}

				/*sql="select count(*) count ,dtype,dtype as type from (select c.tr_no,c.dtype,x.workper from (select tr_no,dtype,cldocno,brhid from cm_srvcontrm m where jbaction!=3 and status!=7 union all"
						+ " select tr_no,dtype,cldocno,brhid from cm_cuscallm m where clstatus!=3 and status!=7) as c inner join "
						+ "(select per/cnt as workper,d.doc_no,d.dtype from "
						+ "(select count(*) cnt,doc_no,dtype from cm_servplan  group by dtype,doc_no) d inner join "
						+ " (select sum(workper) per,doc_no,dtype from cm_servplan group by dtype,doc_no) e on(d.doc_no=e.doc_no and d.dtype=e.dtype)) as x "
						+ "on(x.doc_no=c.tr_no and x.dtype=c.dtype) where 1=1 "+sql11+" "+havin+") as f group by dtype  ";*/

				sql = "select count(*) count ,dtype,dtype as type from (select c.tr_no,c.dtype,x.completedschedule,x.totalschedule,y.pendinginvoice from (select tr_no,dtype,cldocno,brhid from cm_srvcontrm m "
						+ "where jbaction!=3 and status!=7 union all select tr_no,dtype,cldocno,brhid from cm_cuscallm m where clstatus!=3 and status!=7) as c left join (select sum(b.completedschedule) completedschedule,"
						+ "sum(b.totalschedule) totalschedule,doc_no,dtype from (select if(status=5,1,0) completedschedule,1 totalschedule,doc_no,dtype from cm_servplan) b group by b.doc_no,b.dtype) as x on "
						+ "(x.doc_no=c.tr_no and x.dtype=c.dtype) left join (select sum(c.pendinginvoice) pendinginvoice,sum(c.totalinvoices) totalinvoices,c.tr_no from (select if(invtrno=0,amount,0) pendinginvoice,"
						+ "amount totalinvoices,tr_no from cm_srvcontrpd) c group by c.tr_no) y on (y.tr_no=c.tr_no) where 1=1 "+sql11+" "+havin+") as f group by dtype";
				
			//	System.out.println("===sinvCountgrid===="+sql);

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


	public JSONArray serviceScheudleGridLoad(HttpSession session,String tr_no,String brhid,String dtype) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			//String brhid=session.getAttribute("BRANCHID").toString();

			sql="select plannedOn pldate, plTime pltime,s.site,s.siteadd,p.priorno as priority,coalesce(grpcode,'') as asgngrp,coalesce(e.name,'') as emp, "
					+ "coalesce(gr.groupname,'') asgnmode,coalesce(p.remarks,'') desc1,coalesce(gs.groupname,'') as service,p.servid as serviceid,"
					+ "coalesce(if(p.invtrno=0,0,p.servamt),0.0) as amt,DAYname(date_format(plannedOn,'%Y-%m-%d')) as days,workper,coalesce(if(p.invtrno=0,0,sem.doc_no),0) as invno from  cm_servplan p "
					+ "left join cm_srvcsited s on(p.siteid=s.rowno) left join cm_serteamm m on(p.empgroupid=m.doc_no) "
					+ "left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm e on(md.empid=e.doc_no) "
					+ "left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') left join my_servm sem on(p.invtrno=sem.tr_no) "
					+ "where p.doc_no='"+tr_no+"' and p.dtype='"+dtype+"' and p.brhid="+brhid+"";

				//	System.out.println("===ContractAnalysis===serviceplan="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=common.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public JSONArray payGridLoad(HttpSession session,String doc_no,String branchval) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			//String brhid=session.getAttribute("BRANCHID").toString();

			sql="select dueDate, p.amount,  p.description desc1, DueAfSer dueser, runtotal,terms,termsid,if(terms='SERVICE',dueafser,0) service,coalesce(sem.doc_no,0) as invno,sem.date as invdate "
					+ "from cm_srvcontrpd p left join my_servm sem on(p.invtrno=sem.tr_no) where p.tr_no="+doc_no+"";

	//	System.out.println("===payGridLoad====***********"+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=common.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public  JSONArray loadContractData(String uptodate,String branchid,String clientid,int id,String type,int isradio) throws SQLException {

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
				sql11=sql11+" and a.cldocno="+clientid+" ";
			}

			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
			{
				sqluptodate=common.changeStringtoSqlDate(uptodate);

			}
			else{

			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and a.brhid in ("+branchid+") ";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){


				String havin="";

				if(isradio==1){

					//havin="having workper<100";
					
					havin=" and (x.completedschedule-x.totalschedule)!=0";
				}
				if(isradio==2){
					/*havin="having workper=100";*/
					
					havin=" and (x.completedschedule-x.totalschedule)=0 and coalesce(y.pendinginvoice,0)=0";
				}

				/*String sqldata="select x.workper,a.date,tr_no,ac.refname client,a.doc_no doc_no,a.refno,a.status,a.date,a.dtype rdtype,validfrom sdate,validupto edate,cval,lfee,a.brhid brch,iserv,a.cldocno from (select tr_no,m.doc_no,m.refno,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status,"
						+ "m.date,m.dtype,convert(validfrom,char(30)) validfrom ,convert(validupto,char(30)) validupto ,round(contractval,2) as cval,round(coalesce(legalchrg,0.0),2) as lfee,cldocno,m.brhid,iser iserv from cm_srvcontrm m where jbaction!=3 and m.status!=7 "
						+ "union all select tr_no,m.doc_no,m.refno,if(m.clstatus=1,'HOLD',if(m.clstatus=2,'CLOSED',if(m.clstatus=3,'COMPLETED',if(m.clstatus=4,'STARTED','ENTERED')))) as status, "
						+ "m.date,m.dtype,convert(m.date,char(30)) validfrom,''validupto,0.00 as amount,0.00 as lfee,cldocno,m.brhid,0 iserv from cm_cuscallm m where clstatus!=3 and m.status!=7) as a "
						+ "inner join (select per/cnt workper,d.doc_no,d.dtype from (select count(*) cnt,doc_no,dtype from cm_servplan  group by dtype,doc_no) d inner join "
						+ "(select sum(workper) per,doc_no,dtype from cm_servplan group by dtype,doc_no) e  on(d.doc_no=e.doc_no and d.dtype=e.dtype)) as x on(x.doc_no=a.tr_no and x.dtype=a.dtype)"
						+ "left join my_acbook ac on(ac.cldocno=a.cldocno and ac.dtype='CRM') "
						+ " where a.date<='"+sqluptodate+"' and a.dtype='"+type+"' "+havin+" "+sql11+" order by rdtype,doc_no,status";*/
				
				String sqldata="select a.date,a.tr_no,ac.refname client,a.doc_no doc_no,a.refno,a.status,a.date,a.dtype rdtype,validfrom sdate,validupto edate,cval,lfee,a.brhid brch,iserv,a.cldocno,a.approvalstatus,x.completedschedule,x.totalschedule,"
						+ "round(coalesce(y.pendinginvoice,0),2) pendinginvoice,round(coalesce(y.totalinvoices,0),2) totalinvoices from (select tr_no,m.doc_no,m.refno,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status,"
						+ "m.date,m.dtype,convert(validfrom,char(30)) validfrom ,convert(validupto,char(30)) validupto ,round(contractval,2) as cval,round(coalesce(legalchrg,0.0),2) as lfee,cldocno,m.brhid,iser iserv,if(m.status=3,'APPROVED','NOT APPROVED') approvalstatus from cm_srvcontrm m where jbaction!=3 and m.status!=7 "
						+ "union all select tr_no,m.doc_no,m.refno,if(m.clstatus=1,'HOLD',if(m.clstatus=2,'CLOSED',if(m.clstatus=3,'COMPLETED',if(m.clstatus=4,'STARTED','ENTERED')))) as status, "
						+ "m.date,m.dtype,convert(m.date,char(30)) validfrom,''validupto,0.00 as amount,0.00 as lfee,cldocno,m.brhid,0 iserv,if(m.status=3,'APPROVED','NOT APPROVED') approvalstatus from cm_cuscallm m where clstatus!=3 and m.status!=7) as a "
						+ "left join (select sum(b.completedschedule) completedschedule,sum(b.totalschedule) totalschedule,doc_no,dtype from (select if(status=5,1,0) completedschedule,1 totalschedule,doc_no,dtype from cm_servplan) b "
						+ "group by b.doc_no,b.dtype) as x on (x.doc_no=a.tr_no and x.dtype=a.dtype) left join ( select sum(c.pendinginvoice) pendinginvoice,sum(c.totalinvoices) totalinvoices,c.tr_no from ("
						+ "select if(invtrno=0,amount,0) pendinginvoice,amount totalinvoices,tr_no from cm_srvcontrpd) c group by c.tr_no) y on (y.tr_no=a.tr_no) left join my_acbook ac on(ac.cldocno=a.cldocno and ac.dtype='CRM') "
						+ " where a.date<='"+sqluptodate+"' and a.dtype='"+type+"' "+havin+" "+sql11+" order by rdtype,doc_no,status";


				//System.out.println("==loadGridData===*********"+sqldata);

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





}
