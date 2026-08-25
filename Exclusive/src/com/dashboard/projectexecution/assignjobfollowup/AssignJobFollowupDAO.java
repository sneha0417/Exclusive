package com.dashboard.projectexecution.assignjobfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.dashboard.projectexecution.serviceScheduler.ServiceSchedulerBean;

import net.sf.json.JSONArray;


public class AssignJobFollowupDAO {

	AssignJobFollowupBean bean= new AssignJobFollowupBean();
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String date,String branchid,String clientid,int id, int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		if(date.equalsIgnoreCase("0")){
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
		java.sql.Date fromdate=null;
		fromdate=com.changeStringtoSqlDate(fromdates);
		java.sql.Date todate=null;
		todate=com.changeStringtoSqlDate(date);

		//String brcid=branchid.toString();


		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and x.cldocno in ("+clientid+")";
		}
		if(priority>0){
			//			System.out.println("inside");
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
		
		if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
			sql11=sql11+" and p.empgroupid in ("+grp+")";
		}
		
		if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
			sql11=sql11+" and p.empid in ("+emp+")";
		}
		
		if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
			sql11=sql11+" and d.areaid in ("+area+")";
		}
		
	



		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){

				String sql12=" select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) "
						+ " where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				System.out.println("sql12   "+sql12);
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
	
				String sql= ("select count(*) as count,p.dtype from cm_servplan p inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto "
						+ "from cm_srvcontrm m where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) "
						+ ") as x on(x.tr_no=p.doc_no  and x.dtype=p.dtype) left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on "
						+ "(md.rdocno=m.doc_no and p.empid=md.empid) where p.status=4 "+sql11+" group by p.dtype ");

				System.out.println("===sqlassign===="+sql);

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
		if(date.equalsIgnoreCase("0")){
			return RESULTDATA1;
		}
		
		if(id!=1){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			fromdate=com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate=null;
			todate=com.changeStringtoSqlDate(date);
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";



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
				
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
				   
				sql="select x.profomadate,x.profomarecievedate,x.tr_no as doctrno,me.menu_name as name,me.func path,p.dtype,'view' contr,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
						+ "p.plannedon pldte,priorno priority,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
						+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
						+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch,coalesce(cd.description,'') description  "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status=4 "+sql11+" group by p.tr_no order by p.plannedon";

		        System.out.println("==assignjobfollwupGrid=="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				
				/*while(resultSet1.next())
				{
					bean.setLblrefdocno(resultSet1.getString("refdocno"));
				}*/
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
if(date.equalsIgnoreCase("0")){
	return RESULTDATA1;
}
		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			fromdate=com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate=null;
			todate=com.changeStringtoSqlDate(date);
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

				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 

				sql="select p.dtype as DocType,p.refdocno ContractNo,p.tr_no ScheduleNo,p.sr_no SRNO,s.site,if(s.siteadd='0','',s.siteadd) 'site address',"
						+ "coalesce(cont.cperson,'') 'Contact Person',coalesce(cont.tel,cont.mob,'') 'Mobile Number',a.groupname Area,ac.refname Clientname,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) planneddate,"
						+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ " x.Profomadate,x.profomarecievedate,x.contractdetails,if(x.dtype='CREG',gvd.groupname,ser.groupname) as 'Service Type', coalesce(grpcode,'') as 'ASSIGN GROUP',coalesce(em.name,'') as 'EMPLOYEE',coalesce(cd.description,'') 'Description' "+comp+" "
						+ " from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno, DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,"
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ " left join my_crmcontact cont on cont.row_no=s.contactid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype) where p.status=4 "+sql11+" group by p.tr_no order by p.plannedon ";

// System.out.println("==serviceScheduleGridLoadExcel==="+sql);
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
	
	
	public AssignJobFollowupBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}


		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="";
		Connection conn = null;
		ArrayList list=null;
		ArrayList trlist=null;
		ArrayList sitelist=null;
		ArrayList serlist=null;
		ArrayList schlist=null;
		ArrayList paylist=null;
		try {
			list= new ArrayList();
			trlist= new ArrayList();
			sitelist= new ArrayList();
			serlist= new ArrayList();
			schlist= new ArrayList();
			paylist = new ArrayList();
			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

			String sqls="select tr_no,m.doc_no,DATE_FORMAT(m.date,'%d/%m/%Y') as date,round(netAmount,2) as netAmount,m.cldocno,validfrom,validupto,finstdate,noofinsts,m.ref_type,serinterval,trim(ac.address) address,"
					+ "per_mob,trim(mail1) mail1,"
					+ "serdueafter,fservdate,cpersonid,instdueafter,instduetype,serduetype,round(incentive,2) incentive,round(salincentive,2) as salincentive ,round(contractval,2) as contractval,m.ref_type"
					+ " reftype,ac.refname as name,ac.doc_no as clientid,c.cperson,islegal,round(taxper,2) as taxper,m.cpersonid,round(legalchrg,2) as legalchrg,refdocno,reftrno,sm.sal_name as salname,"
					+ "sm.doc_no as salid,cur.code as code,b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,cur.code,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate "
					+ " from  cm_srvcontrm m left join my_acbook ac "
					+ "on(ac.doc_no=m.cldocno) left join my_crmcontact c on(m.cpersonid=c.row_no) left join my_salm sm on(sm.doc_no=m.sal_id)"
					+ "left join my_curr cur on(cur.doc_no=ac.curid) "
					+ "left join my_brch b on(b.doc_no=m.brhid)  left join my_comp com on(com.doc_no=b.cmpid) where tr_no="+trno+" and m.brhid="+brhid+" and m.dtype='"+dtype+"'";

			    System.out.println("===inside getViewdetails===="+sqls);

			ResultSet resultSet = stmt.executeQuery(sqls);    

			while (resultSet.next()) {

				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setDocno(resultSet.getString("doc_no"));
				bean.setMasterdoc_no(resultSet.getInt("tr_no"));
				bean.setDate(resultSet.getString("date"));
				bean.setTxtclient(resultSet.getString("name"));
				bean.setTxtcontact(resultSet.getString("cperson"));
				bean.setCpersonid(resultSet.getInt("cpersonid"));
				bean.setStdate(resultSet.getString("validfrom"));
				bean.setEnddate(resultSet.getString("validupto"));
				bean.setCmbreftype(resultSet.getString("ref_type"));
				bean.setIslegaldoc(resultSet.getInt("islegal"));
				bean.setSalesincentive(resultSet.getString("salincentive"));
				bean.setIncentive(resultSet.getString("incentive"));
				bean.setTxtcntrval(resultSet.getString("contractval"));
				bean.setTxttaxper(resultSet.getString("taxper"));
				bean.setTemp1(resultSet.getString("legalchrg"));
				/*bean.setTemp2();*/
				bean.setInstallments(resultSet.getString("noofinsts"));
				bean.setPaydueafter(resultSet.getString("instdueafter"));
				bean.setCmbpaytype(resultSet.getString("instduetype"));
				bean.setFinsdate(resultSet.getString("finstdate"));

				bean.setSrvcinterval(resultSet.getString("serinterval"));
				bean.setSerdueafter(resultSet.getString("serdueafter"));
				bean.setCmbsrvctype(resultSet.getString("serduetype"));
				bean.setSerdate(resultSet.getString("fservdate"));

				bean.setRrefno(resultSet.getString("refdocno"));
				bean.setRefmasterdoc_no(resultSet.getInt("reftrno"));

				bean.setTxtclientdet(resultSet.getString("address"));
				bean.setTxtmob2(resultSet.getString("per_mob"));
				bean.setTxtemail(resultSet.getString("mail1"));
				bean.setTxtsalman(resultSet.getString("salname"));
				bean.setSalid(resultSet.getInt("salid"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				//bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));


			}



			String sql="select  groupname area,g.doc_no areaid,site,upper(site) site,upper(groupname) as area from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+trno+"";

			ResultSet rs2 = stmt.executeQuery(sql);
			String site="";
			int siteno=1;
			while(rs2.next()){
				site=siteno+"::"+rs2.getString("site")+"::"+rs2.getString("area");
				sitelist.add(site);
				siteno=siteno+1;
			}
			bean.setSitelist(sitelist);
			
			
			String sql3="select groupname stype,doc_no stypeid,coalesce(d.description,'   ') desc1, Equips item, qty,round(Amount,2) as amount,round(total,2) as total from "
					+ "cm_srvcontrd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') where tr_no="+trno+"";

//			System.out.println("===sitesql===="+sql3);

			ResultSet rs4 = stmt.executeQuery(sql3);
			String service="";
			int serno=1;
			while(rs4.next()){

				service=serno+"::"+rs4.getString("stype")+"::"+rs4.getString("desc1")+"::"+rs4.getString("item")+"::"+rs4.getString("qty")+"::"+rs4.getString("amount")+"::"+rs4.getString("total");

				serlist.add(service);
				serno=serno+1;
			}

			

			bean.setSerlist(serlist);
			
			
			
			String sql4="select count(*) as count,DATE_FORMAT(validfrom,'%d/%m/%Y') validfrom,DATE_FORMAT(validupto,'%d/%m/%Y') validupto from cm_srvcontrm m left join cm_servplan p on(m.tr_no=p.doc_no) where m.tr_no="+trno+"";

//			System.out.println("===sitesql===="+sql4);

			ResultSet rs5 = stmt.executeQuery(sql4);
			String scheduler="";
			int schno=1;
			while(rs5.next()){

				schlist.add("1"+"::"+"The maintenance servcies will be commence from"+"::"+rs5.getString("validfrom"));
				schlist.add("2"+"::"+"Valid till"+"::"+rs5.getString("validupto"));
				schlist.add("3"+"::"+"Number of quarterly visits during the contract period"+"::"+rs5.getString("count"));
				serno=serno+1;
			}

			

			bean.setSchlist(schlist);
			
			
			
			String sql5="select DATE_FORMAT(duedate,'%d/%m/%Y') duedate,round(amount,2) as amount,IF(description IS NULL or description = '', '     ', description) as description from cm_srvcontrpd  where tr_no="+trno+"";

//			System.out.println("===sitesql===="+sql5);

			ResultSet rs6 = stmt.executeQuery(sql5);
			String pay="";
			int payno=1;
			while(rs6.next()){

				pay=payno+"::"+rs6.getString("duedate")+"::"+rs6.getString("amount")+"::"+rs6.getString("description");

				paylist.add(pay);
				payno=payno+1;
			}

			

			bean.setPaylist(paylist);
			
			


			String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+msdocno+" and tr.status=3 order by tr.priorno";

//			System.out.println("==sql2===terms===="+sql2);
			
			ResultSet rs3 = stmt.executeQuery(sql2);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			while(rs3.next()){

				String temp="";
				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=trcount+")"+rs3.getString("conditions");
				temp=testing+"::"+cond;	

				trlist.add(temp);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);

			stmt.close();
			conn.close();
		}

		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;
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

	public  JSONArray loadSubGridData(String docno,String brhid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
				
			String sqldata = "select @id:=@id+1 srno,a.* from (select sm.grpcode empgroupid,he.name empid,gp.groupname asgnMode,sa.plannedon,sa.pltime,sa.description from cm_srvassign sa "
					+ "left join cm_serteamm sm on sm.doc_no=sa.empGroupId left join cm_serteamd sd on sd.empid =sa.empid "
					+ "left join hr_empm he on sd.empid=he.doc_no left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode' "
					+ "where sa.refdocno="+docno+" and sa.brhid="+brhid+" group by sa.tr_no order by sa.entrydate) a,(select @id:=0)r";
		
     		System.out.println("sqldata===="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

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
public  AssignJobFollowupBean getPrint(HttpServletRequest request,int docno,String dtype,String srno,String branch) throws SQLException {
		
	AssignJobFollowupBean bean = new AssignJobFollowupBean();
		 Connection conn = null;
			
	        java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			String mainbranch="";
			
			if(!(branch.equals("0") || branch.equals("") || branch.equals("undefined"))){
				mainbranch=mainbranch+" b.branch="+branch+"";
			}
			
				mainbranch="1";
			
			String headersql="select b.branchname,"
					+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
					+ "b.cmpid=c.doc_no where "+mainbranch+" group by brhid";
//			System.out.println(headersql);
					ResultSet resultSetHead = stmtVeh.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						/*bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblprintname1(resultSetHead.getString("vouchername1"));*/
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						}
		
					
		String sqldet="select sv.description desc1,d1.description,x.refNo,cnt.cperson,cnt.mob,x.brhid branch,me.menu_name as name,me.func path,'view' contr,concat(coalesce(s.siteadd,''),coalesce(s.site,'')) siteadd,p.dtype,p.refdocno,p.tr_no,coalesce(p.type,'') type,s.site,a.groupname,ac.refname,coalesce(sm.grpcode,'')asgngrp,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,"
						+ " priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,gv.groupname compl   "
						+ "from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.refNo from cm_srvcontrm m where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,'' refno FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid) "
						+ " left join my_crmcontact cnt on s.contactid=cnt.row_no "
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') left join cm_srvqotm d on x.TR_NO=d.CNTRTRNO left join cm_srvqotD D1 on d.TR_NO=D1.TR_NO and d.revision_no=d1.revision_no "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype) left join cm_serteamm sm on (p.empgroupid=sm.doc_no) left join cm_srvcontrpd sv on x.tr_no=sv.tr_no where p.status=4 and p.tr_no="+srno+" group by p.tr_no order by p.plannedon ";			
        
		ResultSet resultSetdet = stmtVeh.executeQuery(sqldet);
		System.out.println("sqlqueyyyyyyyy"+sqldet);
		while(resultSetdet.next()){
			bean.setLblclname(resultSetdet.getString("refname"));
			bean.setLblsite(resultSetdet.getString("siteadd"));
			bean.setLblcntprsn(resultSetdet.getString("cperson"));
			bean.setLblcontact(resultSetdet.getString("mob"));
			bean.setLblamc(resultSetdet.getString("dtype"));
			bean.setLbldocnno(resultSetdet.getString("refdocno"));
			bean.setLbljobdat(resultSetdet.getString("pldate"));
			bean.setLblstype(resultSetdet.getString("type"));
			bean.setLblschno(resultSetdet.getString("tr_no"));
			bean.setLblassngrp(resultSetdet.getString("asgngrp"));
			bean.setLblclientlpo(resultSetdet.getString("refNo"));
			bean.setDescription(resultSetdet.getString("description"));
			bean.setPaydescription(resultSetdet.getString("desc1"));
				}		
					
			String sql = "";
			
			sql="select coalesce(S.site,' ') site,coalesce(equips,' ') equips,coalesce(v.groupname,' ') groupname, coalesce(d1.qty,' ') qty,coalesce(d1.description,' ') description from cm_srvcontrm m"
					+ " left join cm_srvqotm d on m.TR_NO=d.CNTRTRNO left join cm_srvqotD D1 on D.TR_NO=D1.TR_NO and d.revision_no=d1.revision_no"
					+ " left join cm_servsited S on D.TR_NO=S.TR_NO AND D1.SITESRNO=S.ROWNO"
					+ " left join my_groupvals v on v.doc_no=d1.servid and grptype='service'  where m.dtype='"+dtype+"' and m.doc_no="+docno+" ";
			
			 
		System.out.println("griddd"+sql);
			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printschedulerarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("site")+"::"+resultSet1.getString("equips")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("qty")+"::"+resultSet1.getString("groupname");
				printschedulerarray.add(temp1);
			}
			request.setAttribute("printschedulerarray", printschedulerarray);
					
			String sqllll="";
			
			sqllll="select @i:=@i+1 as srno,a.* from(select description from cm_srvcontrm m left join cm_srvcontrd d on m.tr_no=d.tr_no "
                    + " where m.doc_no="+docno+" and m.dtype='amc' and description !='')a,(select @i:=0) r ";
			 
		System.out.println("griddd2"+sqllll);
			ResultSet resultSet2 = stmtVeh.executeQuery(sqllll);
			
			ArrayList<String> amcgrid= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet2.getString("description")+"::"+resultSet2.getString("srno");
				amcgrid.add(temp1);
			}
			request.setAttribute("amcgrid", amcgrid);
					
			
			
			
			
			sql="select d.description,d.qty,g.groupName from cm_srvcontrm m left join cm_srvcontrd d on m.tr_no=d.tr_no left join my_groupvals g on d.servId=g.doc_no and grptype='service' "
					+ "where m.doc_no="+docno+" and m.dtype='sjob' and d.description !='' ";
			 
			System.out.println("schedulearrr"+sql);
			ResultSet ResultSet = stmtVeh.executeQuery(sql);
			
			ArrayList<String> schedulerarray= new ArrayList<String>();
			
			while(ResultSet.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=ResultSet.getString("description")+"::"+ResultSet.getString("groupName")+"::"+ResultSet.getString("qty");
				schedulerarray.add(temp1);
			}
			request.setAttribute("schedulerarray", schedulerarray);
					
			stmtVeh.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
	
}
