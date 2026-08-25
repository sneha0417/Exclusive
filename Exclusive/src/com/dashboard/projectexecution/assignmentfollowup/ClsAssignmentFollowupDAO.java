package com.dashboard.projectexecution.assignmentfollowup;

import java.sql.Connection;
import java.sql.DriverManager;
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


public class ClsAssignmentFollowupDAO {

	ClsAssignmentFollowupBean bean= new ClsAssignmentFollowupBean();
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String date,String branchid,String clientid,int id, int priority,String grp,String emp,String mem,String area,String chkfromdate) throws SQLException
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
		java.sql.Date todate=null;
		todate=com.changeStringtoSqlDate(date);

		//String brcid=branchid.toString();


		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and x.cldocno in ("+clientid+")";
		}
		if(priority>0){
			sql11=sql11+" and p.priorno=1";
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
			Class.forName("com.mysql.jdbc.Driver");  
			conn=DriverManager.getConnection("jdbc:mysql://gate-way.dyndns.org:3306/gwsupport","root","gateway");  
			stmt=conn.createStatement();  
			
			if(id>0){

				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
	
				String sql= ("select count(*) as count,coalesce(a.description,'') status,a.doc_no from cm_servplan p inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto "
						+ "from cm_srvcontrm m where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) "
						+ ") as x on(x.tr_no=p.doc_no  and x.dtype=p.dtype) left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on "
						+ "(md.rdocno=m.doc_no and p.empid=md.empid) left join cm_assignstatus a on p.assignstatus=a.doc_no "
						+ "where p.status in (3,4) and a.doc_no!=8 and x.cldocno=2  "+sql11+" group by p.assignstatus "
					    + "union all select count(*) as count,'ALL' as status,0 doc_no from cm_servplan p "
					    + "inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto from cm_srvcontrm m where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 "
					    + "union all SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x on(x.tr_no=p.doc_no  "
					    + "and x.dtype=p.dtype) left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on (md.rdocno=m.doc_no and p.empid=md.empid) "
					    + "left join cm_assignstatus a on p.assignstatus=a.doc_no where p.status in(3,4) and a.doc_no!=8 and x.cldocno=2 "+sql11+"");
					
				System.out.println("SQL ="+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
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
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
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



	public JSONArray assignteam(int assignid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";



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


	public JSONArray getassignstatus() throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no,description 'assignstatus' from cm_assignstatus where status=3";


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


	public JSONArray serviceScheduleGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates,String assignstatus) throws SQLException{


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
			Class.forName("com.mysql.jdbc.Driver");  
			conn=DriverManager.getConnection("jdbc:mysql://gate-way.dyndns.org:3306/gwsupport","root","gateway");  
			Statement stmt = conn.createStatement();

			String sql="",sql11="";
           
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			if(priority>0){
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
			
			if(!(assignstatus.equals("0") || assignstatus.equals("") || assignstatus.equals("undefined"))){
				sql11=sql11+" and p.assignstatus="+assignstatus+"";
			}

			if(id>0){
				
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
				   
				    sql="select x.profomadate,x.profomarecievedate,x.calledby,x.tr_no as doctrno,me.menu_name as name,coalesce(u.user_name,'') as enuser,me.func path,p.dtype,p.assignstatus,coalesce(ast.description,'') status,'view' contr,'VIEW' view,'ATTACH' attach,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "coalesce(concat(CAST(DATE_FORMAT(p.plannedon,'%d.%m.%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))),CAST(DATE_FORMAT(p.entrydate,'%d.%m.%Y %k:%i') as CHAR(50))) pldate,"
						+ "p.plannedon pldte,priorno priority,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
						+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
						+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch,coalesce(cd.description,'') description  "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate,'' calledby from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate,c.calledby "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and ast.doc_no!=8 and x.cldocno=2 "+sql11+" group by p.tr_no order by p.plannedon";

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

	
	public JSONArray serviceScheduleGridLoadExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates,String assignstatus) throws SQLException{


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
			Class.forName("com.mysql.jdbc.Driver");  
			conn=DriverManager.getConnection("jdbc:mysql://gate-way.dyndns.org:3306/gwsupport","root","gateway");  
			Statement stmt = conn.createStatement();

			String sql="",sql11="";
			
			String comp="";



			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			if(priority>0){
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
			if(!(assignstatus.equals("0") || assignstatus.equals("") || assignstatus.equals("undefined"))){
				sql11=sql11+" and p.assignstatus="+assignstatus+"";
			}

			if(id>0){

				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
            sql="select p.refdocno 'CREG NO',coalesce(concat(CAST(DATE_FORMAT(p.plannedon,'%d.%m.%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))),CAST(DATE_FORMAT(p.entrydate,'%d.%m.%Y %k:%i') as CHAR(50))) 'DATE',coalesce(u.user_name,'') 'ENTERED USER',coalesce(ast.description,'') 'STATUS',coalesce(if(x.dtype='CREG',"
			    		+ "gvd.groupname,ser.groupname),'') 'SERVICE TYPE',coalesce(gv.groupname,'') 'COMPLAINT',coalesce(cd.description,'') 'DESCRIPTION',coalesce(grpcode,'')'ASSIGN GROUP',coalesce(em.name,'') 'EMPLOYEE',coalesce(x.calledby,'') 'CALLED BY' "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate,'' calledby from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate,c.calledby "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype)"
						+ "left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and ast.doc_no!=8 and x.cldocno=2 "+sql11+" group by p.tr_no order by p.plannedon";
	    
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
	
	
	public ClsAssignmentFollowupBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}


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


			ResultSet rs5 = stmt.executeQuery(sql4);
			while(rs5.next()){

				schlist.add("1"+"::"+"The maintenance servcies will be commence from"+"::"+rs5.getString("validfrom"));
				schlist.add("2"+"::"+"Valid till"+"::"+rs5.getString("validupto"));
				schlist.add("3"+"::"+"Number of quarterly visits during the contract period"+"::"+rs5.getString("count"));
				serno=serno+1;
			}

			

			bean.setSchlist(schlist);
			
			
			
			String sql5="select DATE_FORMAT(duedate,'%d/%m/%Y') duedate,round(amount,2) as amount,IF(description IS NULL or description = '', '     ', description) as description from cm_srvcontrpd  where tr_no="+trno+"";


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
			
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from cm_bafu m inner join my_user u on u.doc_no=m.userid where m.rtrno="+docno+" "
					+ "and m.status=3 group by m.doc_no order by m.fdate desc";
		
     		    //System.out.println("sqldata====*******"+sqldata);
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
public  ClsAssignmentFollowupBean getPrint(HttpServletRequest request,int docno,String dtype,String srno,String branch) throws SQLException {
		
	ClsAssignmentFollowupBean bean = new ClsAssignmentFollowupBean();
		 Connection conn = null;
			
	       
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
		
					
		String sqldet="select cnt.cperson,cnt.mob,x.brhid branch,me.menu_name as name,me.func path,'view' contr,concat(coalesce(s.siteadd,''),coalesce(s.site,'')) siteadd,p.dtype,p.refdocno,p.tr_no,coalesce(p.type,'') type,s.site,a.groupname,ac.refname,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,"
						+ " priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,gv.groupname compl   "
						+ "from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no from cm_srvcontrm m where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid) "
						+ " left join my_crmcontact cnt on s.contactid=cnt.row_no "
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and p.tr_no="+srno+" group by p.tr_no order by p.plannedon ";			
        
		ResultSet resultSetdet = stmtVeh.executeQuery(sqldet);
		
		while(resultSetdet.next()){
			bean.setLblclname(resultSetdet.getString("refname"));
			bean.setLblsite(resultSetdet.getString("siteadd"));
			bean.setLblcntprsn(resultSetdet.getString("cperson"));
			bean.setLblcontact(resultSetdet.getString("mob"));
			bean.setLblamc(resultSetdet.getString("dtype"));
			bean.setLbldocnno(resultSetdet.getString("refdocno"));
			bean.setLbljobdat(resultSetdet.getString("pldate"));
			bean.setLblstype(resultSetdet.getString("type"));
				}		
					
			String sql = "";
			
			sql="select coalesce(S.site,' ') site,coalesce(equips,' ') equips,coalesce(v.groupname,' ') groupname, coalesce(d1.qty,' ') qty,coalesce(d1.description,' ') description from cm_srvcontrm m"
					+ " left join cm_srvqotm d on m.TR_NO=d.CNTRTRNO left join cm_srvqotD D1 on D.TR_NO=D1.TR_NO and d.revision_no=d1.revision_no"
					+ " left join cm_servsited S on D.TR_NO=S.TR_NO AND D1.SITESRNO=S.ROWNO"
					+ " left join my_groupvals v on v.doc_no=d1.servid and grptype='service' where m.dtype='"+dtype+"' and m.doc_no="+docno+" ";
			
			 
			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printschedulerarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("site")+"::"+resultSet1.getString("equips")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("qty")+"::"+resultSet1.getString("groupname");
				printschedulerarray.add(temp1);
			}
			request.setAttribute("printschedulerarray", printschedulerarray);
					
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
