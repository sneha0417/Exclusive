package com.dashboard.projectexecution.serviceclose;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;


public class ServiceCloseDAO {


	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String cldocno,String contracttype,String refno,String contractno,String frmdate,String todate,int id,String branchid) throws SQLException
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

		String sql11="";

		if(!(cldocno.equals("0") || cldocno.equals("") || cldocno.equals("undefined"))){
			sql11+=" and m.cldocno in ("+cldocno+")";
		}
		if(!(contracttype.equals("0") || contracttype.equals("") || contracttype.equals("undefined"))){
			sql11=sql11+" and m.dtype='"+contracttype+"' ";
		}

		if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
			sql11=sql11+" and m.refdocno='"+contractno+"' ";
		}

		if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
			java.sql.Date tdate=com.changeStringtoSqlDate(todate);
			sql11=sql11+" and m.date<='"+tdate+"' "; 
		}

		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			java.sql.Date fdate=com.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and m.date>='"+fdate+"' "; 
		}
		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid="+branchid+" ";
		}

		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			if(id>0){
				String sql= ("select count(*) as count,if(m.status=5,'COMPLETED',if(m.status=3,'ENTERED',if(m.status=4,'ASSIGNED','SERVICE REPORT'))) as statuss,status "
						+ "from cm_servplan m inner join (select * from (select tr_no,dtype from cm_srvcontrm where status=3 union all select tr_no,dtype from cm_cuscallm where status=3) as a) as b"
						+ " on(m.doc_no=b.tr_no and m.dtype=b.dtype) where 1=1 "+sql11+" group by status "
								+ "union all select count(*) as count,'ALL' as statuss,9 status from cm_servplan m "
								+ "inner join (select * from (select tr_no,dtype from cm_srvcontrm where status=3 union all "
								+ "select tr_no,dtype from cm_cuscallm where status=3) as a) as b on(m.doc_no=b.tr_no and m.dtype=b.dtype) "
								+ "where 1=1 "+sql11+" ");

//				System.out.println("===serCountgrid===="+sql);

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=com.convertToJSON(resultSet);
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



	public JSONArray serSchedulegrid(HttpSession session,String date,String branchid,String clientid,String dtype) throws SQLException
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


		String brcid=branchid.toString();


		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11="and m.cldocno in ("+clientid+")";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11="and m.date<='"+todate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11="and m.brhid in ("+branchid+")";
		}



		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select count(*) as count,dtype from  cm_srvcontrm m where and status=3 "+sql11+" group by dtype " );
			//			System.out.println("------branchid---"+branchid+"-----serCountgrid-------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
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


	public JSONArray assignfrm(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select grpcode,doc_no  from cm_serteamm where status=3";


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



	public JSONArray assignteam(HttpSession session,int assignid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";


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


	public JSONArray assignmode(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname assign,codeno,doc_no docno from my_groupvals where grptype='assignmode' and status=3";

			//			System.out.println("===getassign===="+sql);

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


	public JSONArray serviceCloseGridLoad(HttpSession session,String dtype,String frmdate,String todate,String contractno,String clientid,int id,String status,String branch) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and p.dtype='"+dtype+"'";
			}

			if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
				sql11=sql11+" and p.refdocno='"+contractno+"'";
			}
			if(!( status.equals("") || status.equals("undefined") || (status.equals("9")))){
			
				sql11=sql11+" and p.status='"+status+"'";
			
			}

			if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(todate);
				sql11=sql11+" and p.date<='"+tdate+"'"; 
			}

			if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(frmdate);
				sql11=sql11+" and p.date>='"+fdate+"'"; 
			}
			if(!(branch.equals("0") || branch.equals("") || branch.equals("undefined")|| branch.equals("a"))){
				sql11=sql11+" and p.brhid="+branch+" ";
			}
			//System.out.println("==sql11===="+sql11);
			if(id>0){

				sql="select x.tr_no as doctrno,p.dtype,p.refdocno,p.tr_no,s.site,a.groupname,"
						+ "ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,p.plannedon pldte,"
						+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,convert(x.contracttrno,char(50)) contracttrno,"
						+ " p.siteid,x.contractdetails,s.areaid,ser.groupname as sertype,coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,"
						+ " coalesce(em.name,'') as emp,md.empid,coalesce(gr.groupname,'') asgnmode,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as pldate,"
						+ "CASE WHEN p.status=3 then 'ENTERED' WHEN p.status=4 then 'ASSIGNED' WHEN p.status=5 then 'SERVICE REPORT' "
						+ " WHEN p.status=6 then 'CLOSED' END as stat from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " m.refno contractdetails from cm_srvcontrm m where m.status=3   union all SELECT tr_no,"
						+ " dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails FROM cm_cuscallm c "
						+ " where c.status=3 ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on (a.doc_no=s.areaid  and a.grptype='area')left join my_acbook ac "
						+ "on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md "
						+ "on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr "
						+ "on(gr.doc_no=p.asgnmode and gr.grptype='assignmode')  where 1=1 "+sql11+"  order by p.plannedon ";

			//	System.out.println("==serviceCloseGridLoad=="+sql);

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

	public JSONArray ExcelserviceCloseGridLoad(HttpSession session,String dtype,String frmdate,String todate,String contractno,String clientid,int id,String status,String branch) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and p.cldocno in ("+clientid+")";
			}
			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and p.dtype='"+dtype+"'";
			}

			if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
				sql11=sql11+" and p.refdocno='"+contractno+"'";
			}
			if(!( status.equals("") || status.equals("undefined") || (status.equals("9")))){
			
				sql11=sql11+" and p.status='"+status+"'";
			
			}

			if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
				java.sql.Date tdate=com.changeStringtoSqlDate(todate);
				sql11=sql11+" and p.date<='"+tdate+"'"; 
			}

			if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
				java.sql.Date fdate=com.changeStringtoSqlDate(frmdate);
				sql11=sql11+" and p.date>='"+fdate+"'"; 
			}
			if(!(branch.equals("0") || branch.equals("") || branch.equals("undefined")|| branch.equals("a"))){
				sql11=sql11+" and p.brhid="+branch+" ";
			}
			//System.out.println("==sql11===="+sql11);
			if(id>0){

				sql="select priorno PRIORITY,p.dtype 'DTYPE',p.refdocno 'DOC NO',ac.refname 'CLIENT NAME',p.tr_no 'SCH.NO',"
						+ " a.groupname 'AREA',s.site 'SITE NAME',ser.groupname as 'SERVICE TYPE',coalesce(grpcode,'') as 'ASSIGN.GROUP',coalesce(em.name,'') as 'EMPLOYEE',"
						+ " coalesce(gr.groupname,'') 'ASSIGN.MODE',"
						+ "CASE WHEN p.status=3 then 'ENTERED' WHEN p.status=4 then 'ASSIGNED' WHEN p.status=5 then 'SERVICE REPORT' "
						+ " WHEN p.status=6 then 'CLOSED' END as 'STATUS',DATE_FORMAT(p.plannedon,'%d-%m-%Y') as 'PLANNED DATE' "
						+ " from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " m.refno contractdetails from cm_srvcontrm m where m.status=3   union all SELECT tr_no,"
						+ " dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails FROM cm_cuscallm c "
						+ " where c.status=3 ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid  and a.grptype='area')left join my_acbook ac "
						+ "on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md "
						+ "on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr "
						+ "on(gr.doc_no=p.asgnmode and gr.grptype='assignmode')  where 1=1 "+sql11+" order by p.plannedon  ";

			//	System.out.println("==excelllserviceCloseGridLoad=="+sql);

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

			String clssql= ("select * from (select tr_no,doc_no,refno,dtype,cldocno,convert(concat(dtype,'-',doc_no),char(50)) as contr from cm_srvcontrm where status<>7 and iser=1 "
					+ ") as a where 1=1 "+sql11+" order by doc_no");

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


}
