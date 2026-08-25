package com.dashboard.projectexecution.serviceInvoiceDetails;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsServiceInvoiceDetails {
	
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	
	public JSONArray serviceType(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray serviceSite(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select  distinct site  from cm_srvcsited";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	


	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {


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






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
	public   JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {


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

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();
		String sql11="";


		java.sql.Date sqlStartDate=null;

		/*select count(*) as count,if(m.status=1,'HOLD',if(m.status=2,'CLOSED',if(m.status=3,'COMPLETED',if(m.status=4,'STARTED','ENTERED')))) as statuss,status from cm_servplan m group by status;*/

		//enqdate.trim();


		String sqltest="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11+=" and a.cldocno in ("+clientid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
			sql11=sql11+" and a.dtype='"+dtype+"'";
		}

		if(!(refno.equals("0") || refno.equals("") || refno.equals("undefined"))){
			sql11=sql11+" and a.refno like '%"+refno+"%'";
		}

		if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
			sql11=sql11+" and a.doc_no='"+contractno+"'";
		}

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select * from (select tr_no,doc_no,refno,dtype,cldocno from cm_srvcontrm where status<>7 "
					+ "union all select tr_no,doc_no,refno,dtype,cldocno from cm_cuscallm where status<>7) as a where 1=1 "+sql11+" order by doc_no");

			//System.out.println("===clssql====="+clssql);

			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	public JSONArray serviceStatus(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select * from (select 3 as doc_no,'ENTERED' as stat union all select 4 as doc_no,'ASSIGNED' as stat "
					+ "union all select 5 as doc_no,'SERVICE REPORT' as stat union all select 6 as doc_no,'CLOSED' as stat) as a";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray serviceInvoiceDetailGridLoad(HttpSession session,String sertypeid,String siteid,String statusid,String contractid,String clientid,String branchid,String fromDate,String toDate,int id) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";

             System.out.println("==contractid====="+contractid);

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(sertypeid.equals("0") || sertypeid.equals("") || sertypeid.equals("undefined"))){
				sql11=sql11+" and p.servid in("+sertypeid+")";
			}

			if(!(siteid.equals("0") || siteid.equals("") || siteid.equals("undefined"))){
				sql11=sql11+" and s.site in('"+siteid+"')";
			}
			if(!( statusid.equals("") || statusid.equals("undefined") || statusid.equals("0"))){
				sql11=sql11+" and p.status in ('"+statusid+"')";
			}

			if(!(toDate.equals("0") || toDate.equals("") || toDate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(toDate);
				sql11=sql11+" and sm.date<='"+tdate+"'"; 
			}

			if(!(fromDate.equals("0") || fromDate.equals("") || fromDate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(fromDate);
				sql11=sql11+" and sm.date>='"+fdate+"'"; 
			}
			if(!(contractid.equals("0") || contractid.equals("") || contractid.equals("undefined"))){
				sql11=sql11+" and sm.costid in ('"+contractid+"')"; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid="+branchid+" ";
			}
			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="select if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT'))) as statuss,DATE_FORMAT(sm.date,'%d-%m-%Y') as invdate,x.tr_no as doctrno,p.dtype,p.refdocno,p.tr_no,s.site,a.groupname area,"
						+ "ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "DATE_FORMAT(p.plannedon,'%d-%m-%Y') as pldate,"
						+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,convert(x.contracttrno,char(50)) contracttrno,"
						+ "p.siteid,x.contractdetails,s.areaid,ser.groupname as sertype,coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,"
						+ "coalesce(em.name,'') as emp,md.empid,coalesce(gr.groupname,'') asgnmode,coalesce(sm.doc_no,0) as invno,"
						+ "coalesce((sm.atotal+legalchrg+taxamt),0) invamt from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ "m.refno contractdetails from cm_srvcontrm m where m.status=3   union all SELECT tr_no,"
						+ "dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails FROM cm_cuscallm c "
						+ "where c.status=3 ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid)left join my_acbook ac "
						+ "on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md "
						+ "on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr  "
						+ "on(gr.doc_no=p.asgnmode and gr.grptype='assignmode')  inner join my_servm sm on(sm.tr_no=p.invtrno and sm.costid=x.tr_no)  where 1=1 "+sql11+"   ";

				System.out.println("==serviceCloseGridLoad=="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToJSON(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}

	public JSONArray ExcelserviceInvoiceDetailGridLoad(HttpSession session,String sertypeid,String siteid,String statusid,String contractid,String clientid,String branchid,String fromDate,String toDate,int id) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";

             System.out.println("==contractid====="+contractid);

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(sertypeid.equals("0") || sertypeid.equals("") || sertypeid.equals("undefined"))){
				sql11=sql11+" and p.servid in("+sertypeid+")";
			}

			if(!(siteid.equals("0") || siteid.equals("") || siteid.equals("undefined"))){
				sql11=sql11+" and s.site in('"+siteid+"')";
			}
			if(!( statusid.equals("") || statusid.equals("undefined") || statusid.equals("0"))){
				sql11=sql11+" and p.status in ('"+statusid+"')";
			}

			if(!(toDate.equals("0") || toDate.equals("") || toDate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(toDate);
				sql11=sql11+" and sm.date<='"+tdate+"'"; 
			}

			if(!(fromDate.equals("0") || fromDate.equals("") || fromDate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(fromDate);
				sql11=sql11+" and sm.date>='"+fdate+"'"; 
			}
			if(!(contractid.equals("0") || contractid.equals("") || contractid.equals("undefined"))){
				sql11=sql11+" and sm.costid in ('"+contractid+"')"; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid="+branchid+" ";
			}
			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="select p.dtype 'DTYPE',p.refdocno 'DOC NO',ac.refname 'CLIENT NAME',p.tr_no 'SCH.NO',"
						+ "if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT'))) as 'STATUS',"
						+ "DATE_FORMAT(p.plannedon,'%d-%m-%Y') as 'PLANNED DATE',DATE_FORMAT(sm.date,'%d-%m-%Y') as 'INVOICE DATE',"
						+ " a.groupname 'AREA',s.site 'SITE NAME',ser.groupname as 'SERVICE TYPE',coalesce(sm.doc_no,0) as 'INV NO',"
					
						+ "coalesce((sm.atotal+legalchrg+taxamt),0) 'INV AMT' from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ "m.refno contractdetails from cm_srvcontrm m where m.status=3   union all SELECT tr_no,"
						+ "dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails FROM cm_cuscallm c "
						+ "where c.status=3 ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid)left join my_acbook ac "
						+ "on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md "
						+ "on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr  "
						+ "on(gr.doc_no=p.asgnmode and gr.grptype='assignmode')  inner join my_servm sm on(sm.tr_no=p.invtrno and sm.costid=x.tr_no)  where 1=1 "+sql11+"   ";

				System.out.println("==EXCELserviceCloseGridLoad=="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToEXCEL(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}

	
	
	public JSONArray serviceInvoiceSummaryGridLoad(HttpSession session,String sertypeid,String siteid,String statusid,String contractid,String clientid,String branchid,String fromDate,String toDate,int id,String grpby) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",sqlgrp="",sqlslct="";

			
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(sertypeid.equals("0") || sertypeid.equals("") || sertypeid.equals("undefined"))){
				sql11=sql11+" and p.servid in("+sertypeid+")";
			}

			if(!(siteid.equals("0") || siteid.equals("") || siteid.equals("undefined"))){
				sql11=sql11+" and sd.site in('"+siteid+"')";
			}
			if(!( statusid.equals("") || statusid.equals("undefined") || statusid.equals("0"))){
				sql11=sql11+" and p.status in ('"+statusid+"')";
			}

			if(!(toDate.equals("0") || toDate.equals("") || toDate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(toDate);
				sql11=sql11+" and m.date<='"+tdate+"'"; 
			}

			if(!(fromDate.equals("0") || fromDate.equals("") || fromDate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(fromDate);
				sql11=sql11+" and m.date>='"+fdate+"'"; 
			}
			if(!(contractid.equals("0") || contractid.equals("") || contractid.equals("undefined"))){
				sql11=sql11+" and m.costid in ('"+contractid+"')"; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and m.brhid="+branchid+" ";
			}
			if(grpby.equalsIgnoreCase("site"))
			{
				sqlgrp="group by sd.site ";
				sqlslct=",sd.site as desc1";
			}
			else if(grpby.equalsIgnoreCase("service"))
			{
				sqlgrp="group by p.servid ";
				sqlslct=",ser.groupname as desc1";
			}
			else if(grpby.equalsIgnoreCase("status"))
			{
				sqlgrp="group by p.status  ";
				sqlslct=",if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT')))  as desc1";
			}
			else{
				
				sqlslct=",concat(sd.site,'-',ser.groupname,'-',if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT')))) as desc1 ";
				sqlgrp="group by sd.site,p.servid,p.status  ";
				
			}
			

			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="select coalesce(sum(atotal+m.legalchrg),0) total,coalesce(sum(m.legalchrg),0) leglchrg,coalesce(sum(taxamt),0) taxamt,m.cldocno,p.siteid,p.servid,p.status "+sqlslct+" from my_servm m "
						+ "left join cm_servplan p on(m.tr_no=p.invtrno) left join my_acbook ac on(ac.doc_no=m.cldocno) "
						+ "left join cm_srvcsited sd on(sd.rowno=p.siteid) left join my_groupvals ser on(ser.doc_no=p.servid) "
						+ "left join cm_srvcontrm cm on(cm.tr_no=m.costid) where p.serinv=1  "+sql11+" "+sqlgrp+"   ";

				System.out.println("==serviceSummaryGridLoad=="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToJSON(resultSet1);
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}

	public JSONArray ExcelserviceInvoiceSummaryGridLoad(HttpSession session,String sertypeid,String siteid,String statusid,String contractid,String clientid,String branchid,String fromDate,String toDate,int id,String grpby) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",sqlgrp="",sqlslct="";

			
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(sertypeid.equals("0") || sertypeid.equals("") || sertypeid.equals("undefined"))){
				sql11=sql11+" and p.servid in("+sertypeid+")";
			}

			if(!(siteid.equals("0") || siteid.equals("") || siteid.equals("undefined"))){
				sql11=sql11+" and sd.site in('"+siteid+"')";
			}
			if(!( statusid.equals("") || statusid.equals("undefined") || statusid.equals("0"))){
				sql11=sql11+" and p.status in ('"+statusid+"')";
			}

			if(!(toDate.equals("0") || toDate.equals("") || toDate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(toDate);
				sql11=sql11+" and m.date<='"+tdate+"'"; 
			}

			if(!(fromDate.equals("0") || fromDate.equals("") || fromDate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(fromDate);
				sql11=sql11+" and m.date>='"+fdate+"'"; 
			}
			if(!(contractid.equals("0") || contractid.equals("") || contractid.equals("undefined"))){
				sql11=sql11+" and m.costid in ('"+contractid+"')"; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and m.brhid="+branchid+" ";
			}
			if(grpby.equalsIgnoreCase("site"))
			{
				sqlgrp="group by sd.site ";
				sqlslct="sd.site as DESCRIPTION ,";
			}
			else if(grpby.equalsIgnoreCase("service"))
			{
				sqlgrp="group by p.servid ";
				sqlslct="ser.groupname as DESCRIPTION, ";
			}
			else if(grpby.equalsIgnoreCase("status"))
			{
				sqlgrp="group by p.status  ";
				sqlslct="if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT')))  as DESCRIPTION, ";
			}
			else{
				
				sqlslct="concat(sd.site,'-',ser.groupname,'-',if(p.status=6,'CLOSED',if(p.status=3,'ENTERED',if(p.status=4,'ASSIGNED','SERVICE REPORT')))) as DESCRIPTION, ";
				sqlgrp="group by sd.site,p.servid,p.status  ";
				
			}
			

			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="SELECT (@id:=@id+1) as 'Sl No',a.* from (select "+sqlslct+" coalesce(sum(atotal+m.legalchrg),0) 'NET AMOUNT',coalesce(sum(m.legalchrg),0) 'LEGAL CHARGE',coalesce(sum(taxamt),0) 'TAX AMOUNT'  from my_servm m "
						+ "left join cm_servplan p on(m.tr_no=p.invtrno) left join my_acbook ac on(ac.doc_no=m.cldocno) "
						+ "left join cm_srvcsited sd on(sd.rowno=p.siteid) left join my_groupvals ser on(ser.doc_no=p.servid) "
						+ "left join cm_srvcontrm cm on(cm.tr_no=m.costid) where p.serinv=1  "+sql11+" "+sqlgrp+" ) a,(select @id:=0) r  ";

				System.out.println("==ExcelserviceSummaryGridLoad=="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToEXCEL(resultSet1);
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}
	
}
