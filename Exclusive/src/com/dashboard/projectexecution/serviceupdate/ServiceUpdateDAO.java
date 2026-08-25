package com.dashboard.projectexecution.serviceupdate;

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


public class ServiceUpdateDAO {

	
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String date,String branchid,String clientid,int id, int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		java.sql.Date fromdate=null;
		if(!(fromdates.equalsIgnoreCase("undefined"))&&!(fromdates.equalsIgnoreCase(""))&&!(fromdates.equalsIgnoreCase("0")))
		{
		fromdate=com.changeStringtoSqlDate(fromdates);
		}
		java.sql.Date todate=null;
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
		todate=com.changeStringtoSqlDate(date);
		}
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


		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and a.cldocno in ("+clientid+")";
		}
		if(priority>0){
			//			System.out.println("inside");
			sql11=sql11+" and a.priorno=1";
		}
	
		if(chkfromdate.equalsIgnoreCase("1")){
			if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
				
				sql11=sql11+" and a.date between '"+fromdate+"' and '"+todate+"' "; 
			}
		}
		
		else
			{
			
	if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
			
			sql11=sql11+" and a.date<='"+todate+"' "; 
		}
		
		
		

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and a.brhid in ("+branchid+")";
		}
		
		if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
			sql11=sql11+" and a.empgroupid in ("+grp+")";
		}
		
		if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
			sql11=sql11+" and a.empid in ("+emp+")";
		}
		
		if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
			sql11=sql11+" and ara.doc_no in ("+area+")";
			//sql11=sql11+"";
		}
		
	
		


		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){


	
				String sql= "select count(*) count,dtype from (select p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.siteid from cm_servplan p "
						+ "left join cm_srvcontrm m on m.tr_no=p.doc_no and m.dtype=p.dtype where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 and p.status in (4) "
						+ "union all select p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.siteid from cm_servplan p left join cm_srvdetm dm on dm.schrefdocno=p.tr_no where  dm.confirm=0 "
						+ "union all select p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.siteid from cm_servplan p "
						+ "left join cm_cuscallm c on c.tr_no=p.doc_no and p.dtype=c.dtype "
						+ "where c.status=3 and c.clstatus in (0,4) and p.status=4) a "
						+ "left join cm_srvcsited s on( a.siteid=s.rowno ) left join my_groupvals ara on(ara.doc_no=s.areaid and ara.grptype='area') "
						+ "where 1=1 "+sql11+"  group by dtype";
				System.out.println("===sqlassign count===="+sql);

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


	public JSONArray serviceScheduleGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			if(!(fromdates.equalsIgnoreCase("undefined"))&&!(fromdates.equalsIgnoreCase(""))&&!(fromdates.equalsIgnoreCase("0")))
			{
			fromdate=com.changeStringtoSqlDate(fromdates);
			}
			java.sql.Date todate=null;
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
			{
			todate=com.changeStringtoSqlDate(date);
			}
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",esql="";



			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and a.cldocno in ("+clientid+")";
			}
			//			System.out.println("===priority===="+priority);
			if(priority>0){
				//	System.out.println("inside");
				sql11=sql11+" and a.priorno=1";
			}
			if(chkfromdate.equalsIgnoreCase("1")){
				if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
					
					sql11=sql11+" and a.date between '"+fromdate+"' and '"+todate+"' "; 
				}
			}
			
			else
				{
				
		if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
				
				sql11=sql11+" and a.date<='"+todate+"' "; 
			}
			

			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and a.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and a.dtype='"+dtype+"'";
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql11=sql11+" and a.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql11=sql11+" and a.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and ara.doc_no in ("+area+")";
				//sql11=sql11+" ";
			}
			

			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="select a.priorno priority,a.dtype,a.refdocno,a.tr_no,s.site,coalesce(m.grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,"
						+ "coalesce(em.name,'') as emp,md.empid,coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,ser.groupname as sertype,"
						+ "ser.doc_no as serdocno ,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "concat(CAST(DATE_FORMAT(a.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(a.pltime as CHAR(50))) pldate,a.plannedon pldte,"
						+ "DATE_FORMAT(a.validupto,'%d-%m-%Y') as validupto,a.siteid,me.func path,a.reftrno as doctrno,me.menu_name as name,"
						+ "a.refdocno doc_no,a.brhid branch,'VIEW' view,cast(a.srtrno as char) srtrno,cast(a.srdocno as char) srdocno,a.workper,"
						+ "coalesce(ara.groupname,'') groupname,gv.groupname compl,e.apprdate,a.sr_no srno "
						+ "from (select p.tr_no,p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,"
						+ "p.servid,p.reftrno,p.plannedon,p.pltime,m.validupto,'0' srtrno,'0' srdocno,p.workper,p.sr_no from cm_servplan p "
						+ "left join cm_srvcontrm m on m.tr_no=p.doc_no and m.dtype=p.dtype "
						+ "where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 and p.status in (4) "
						+ "union all select p.tr_no,p.dtype,p.date,"
						+ "p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,p.servid,p.reftrno,p.plannedon,p.pltime,"
						+ "m.validupto,dm.tr_no srtrno,dm.doc_no srdocno,p.workper,p.sr_no from cm_servplan p left join cm_srvcontrm m on m.tr_no=p.doc_no and m.dtype=p.dtype "
						+ "left join cm_srvdetm dm on dm.schrefdocno=p.tr_no where  dm.confirm=0  "
						+ "union all "
						+ "select p.tr_no,p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,p.servid,"
						+ "p.reftrno,p.plannedon,p.pltime,'' validupto,'0' srtrno,'0' srdocno,p.workper,p.sr_no from cm_servplan p "
						+ "left join cm_cuscallm c on c.tr_no=p.doc_no and p.dtype=c.dtype where c.status=3 and c.clstatus in (0,4) and p.status=4) a "
						+ "left join cm_serteamm m on(a.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and a.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=a.asgnmode and gr.grptype='assignmode') "
						+ "left join cm_srvcsited s on( a.siteid=s.rowno ) left join my_groupvals ara on(ara.doc_no=s.areaid and ara.grptype='area') left join my_groupvals ser on(a.servid=ser.doc_no and ser.grptype='service') "
						+ "left join my_acbook ac on ac.cldocno=a.cldocno and ac.dtype='CRM' left join my_menu me on(me.doc_type=a.dtype) "
						+ " left join cm_cuscalld cd on a.reftrno=cd.tr_no and a.dtype='CREG' left join my_groupvals gv on cd.cmplId=gv.doc_no and gv.grptype='complaints' "
						+ " left join (select max(apprdate) apprdate,coalesce(doc_no,0) doc_no,coalesce(brhid,0) brhid,coalesce(dtype,'') dtype from my_exdet where dtype='AMC' ) e on(e.doc_no=a.refdocno and e.dtype=a.dtype and e.brhid=a.brhid) "
						+ "where 1=1 "+sql11+" group by a.tr_no order by a.plannedon";

				System.out.println("==Service Update Grid=="+sql);

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

	
	public JSONArray serviceScheduleGridLoadExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			if(!(fromdates.equalsIgnoreCase("undefined"))&&!(fromdates.equalsIgnoreCase(""))&&!(fromdates.equalsIgnoreCase("0")))
			{
			fromdate=com.changeStringtoSqlDate(fromdates);
			}
			java.sql.Date todate=null;
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
			{
			todate=com.changeStringtoSqlDate(date);
			}
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",esql="";
			
			String comp="";



			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			//			System.out.println("===priority===="+priority);
			if(priority>0){
				//	System.out.println("inside");
				sql11=sql11+" and p.priorno=1";
			}

			if(chkfromdate.equalsIgnoreCase("1")){
				if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
					
					sql11=sql11+" and p.date between '"+fromdate+"' and '"+todate+"' "; 
				}
			}
			
			else
				{
				
		if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
				
				sql11=sql11+" and p.date<='"+todate+"' "; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and x.dtype='"+dtype+"'";
				if(dtype.equalsIgnoreCase("CREG"))
				{
					comp=comp+" ,gv.groupname complaint ";
				}
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql11=sql11+" and p.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql11=sql11+" and p.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and s.areaid in ("+area+")";
			}
			

			//System.out.println("==sql11===="+sql11);
			if(id>0){


				sql="select p.dtype as DocType,p.refdocno ContractNo,p.tr_no ScheduleNo,s.site,if(s.siteadd='0','',s.siteadd) 'site address',"
						+ "coalesce(cont.cperson,'') 'Contact Person',coalesce(cont.tel,cont.mob,'') 'Mobile Number',a.groupname Area,ac.refname Clientname,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) planneddate,"
						+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,apprdate,x.contractdetails,if(x.dtype='CREG',gvd.groupname,ser.groupname) as 'Service Type', coalesce(grpcode,'') as 'ASSIGN GROUP',coalesce(em.name,'') as 'EMPLOYEE' "+comp+" "
						+ " from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ "m.refno contractdetails from cm_srvcontrm m where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid)"
						+ " left join my_crmcontact cont on cont.row_no=s.contactid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"' ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype) where p.status=4 "+sql11+" group by p.tr_no order by p.plannedon ";

System.out.println("==serviceScheduleGridLoadExcel==="+sql);
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
	
		
	
	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


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

	
}
