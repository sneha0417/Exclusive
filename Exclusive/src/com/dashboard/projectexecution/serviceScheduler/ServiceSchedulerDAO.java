package com.dashboard.projectexecution.serviceScheduler;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.client.clientfollowuplog.ClsClientFollowupLogBean;

import net.sf.json.JSONArray;

public class ServiceSchedulerDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String date,String branchid,String clientid,int id, int priority,String site,String area) throws SQLException
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


		String sql11="";
		
		String sqljob="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and x.cldocno in ("+clientid+")";
		}
		/*if(!(site.equals("0") || site.equals("") || site.equals("undefined"))){
			sql11=sql11+" and d.site='"+site+"'";
		}*/
		if(!(site.equals("0") || site.equals("") || site.equals("undefined"))){
			sql11=sql11+" and (st.site='"+site+"'or  st1.site='"+site+"')";
		}
		if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
			sql11=sql11+" and (st.areaid='"+area+"' or st1.areaid='"+area+"') ";
		}
		if(priority>0){
//			System.out.println("inside");
			sql11=sql11+" and p.priorno=1";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11=sql11+" and p.date<='"+todate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and x.brhid in ("+branchid+")";
		}



		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){
		
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				
				//System.out.println("==sql12=="+sql12);
				
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
			    
				/*String sql= ("select count(*) as count,p.dtype from cm_servplan p left join cm_srvcontrm m on(m.tr_no=p.reftrno) "
						+ "where  m.status=3 and m.jbaction in (0,4) and "
						+ "m.jbaction not in (2) and m.pstatus!=1 and p.status=3   "+sql11+" group by p.dtype ");*/
				/*
				String sql= ("select count(*) as count,p.dtype from cm_servplan p inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto "
						+ "from cm_srvcontrm m where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) "
						+ ") as x on(x.tr_no=p.doc_no and x.dtype=p.dtype) left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on "
						+ "(md.rdocno=m.doc_no and p.empid=md.empid) where p.status=3 "+sql11+" group by p.dtype ");
				*/
				
			    
			    
			    String jobtypeid="0";
			    
			    String sqljobtye="select jobtype from cm_sjobuserlink where userid='"+session.getAttribute("USERID").toString().trim()+"'";
			    
			  //  System.out.println("===serCountgrid===="+sqljobtye);
			    
			    ResultSet resultSet13=stmt.executeQuery(sqljobtye);
			    
			    while(resultSet13.next()){
			    	
			   	jobtypeid=resultSet13.getString("jobtype");
			    } 
			    
			    
			//    System.out.println("jobtypeid======="+jobtypeid);
			    
			    
			    if(jobtypeid.equalsIgnoreCase("0")){
			    	
			    	sqljob+=" ";
			    }
			    else{
			    	
			    	
			    	sqljob+=" and x.sjobtype in ("+jobtypeid+") ";
			    	
			    }
			    
			    
				String sql= ("select count(*) as count,p.dtype from cm_servplan p inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto,sjobtype "
						+ "from cm_srvcontrm m where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto,'' sjobtype FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) "
						+ ") as x on(x.tr_no=p.doc_no and x.dtype=p.dtype) left join cm_srvcsited st on st.rowno=p.siteid left join cm_servsited st1 on st1.rowno=p.siteid left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on "
						+ "(md.rdocno=m.doc_no and p.empid=md.empid) where p.status=3 "+sql11+" "+sqljob+"   group by p.dtype ");
				
			//     System.out.println("===serCountgrid===="+sql);

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
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
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
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11=sql11+" and m.date<='"+todate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
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


	public JSONArray serviceScheduleGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String site,String area) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",esql="",sqljob="";

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=" and x.cldocno in ("+clientid+")";
			}
			/*if(!(site.equals("0") || site.equals("") || site.equals("undefined"))){
				sql11=sql11+" and s.site='"+site+"'";
			}*/
			if(!(site.equals("0") || site.equals("") || site.equals("undefined"))){
				sql11=sql11+" and (s.site='"+site+"' or st1.site='"+site+"')";
			}
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and (s.areaid='"+area+"' or st1.areaid='"+area+"') ";
			}
//			System.out.println("===priority===="+priority);
			if(priority>0){
				System.out.println("inside");
				sql11=sql11+" and p.priorno=1";
			}

			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
				java.sql.Date todate=com.changeStringtoSqlDate(date);
				sql11=sql11+" and p.date<='"+todate+"'"; 
			}

			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and x.dtype='"+dtype+"'";
			}

//System.out.println("==sql11===="+sql11);
			if(id>0){


				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
			    
				/*sql="select p.dtype,p.refdocno,p.tr_no,s.site,a.groupname,ac.refname,concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,p.plannedon pldte,priorno priority,DATE_FORMAT(m.validupto,'%d-%m-%Y') as validupto from  cm_srvcontrm m left join cm_servplan p on(m.tr_no=p.reftrno) "
						+ "left join cm_srvcsited s on(s.tr_no=m.tr_no and p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid) left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where  m.status=3 and m.jbaction in (0,4) and  m.jbaction not in (2) and m.pstatus!=1 and p.status=3   "
						+ " "+sql11+" group by p.tr_no ";

*concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate
*/
			/*sql="select x.tr_no as doctrno,me.menu_name as name,me.func path,'view' contr,p.dtype,p.refdocno,p.tr_no,s.site,a.groupname,ac.refname,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,"
						+ "p.plannedon pldte,priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,dates,ser.groupname as sertype,gv.groupname compl,x.brhid branch   "
						+ "from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no from cm_srvcontrm m where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid) "
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"' ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')"
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status=3 "+sql11+" order by p.plannedon ";
				*/
				
				
			/*	sql="select x.profomadate,x.profomarecievedate,x.brhid branch,x.tr_no as doctrno,me.menu_name as name,me.func path,'view' contr,p.dtype,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,"
						+ "p.plannedon pldte,priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,gv.groupname compl,coalesce(tm.grpcode,'') asngroup,p.EMPGROUPID grpid,coalesce(cd.description,'') description   "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,ff.date profomarecievedate,m.doc_no from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,'' profomadate,null profomarecievedate,c.doc_no FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on (md.rdocno=m.doc_no and p.empid=md.empid) left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area') "
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype)  LEFT JOIN cm_serteamm tm on p.EMPGROUPID=tm.doc_no where p.status=3 "+sql11+" group by p.tr_no order by p.plannedon ";
				*/
				
			    
			    
			    
			    
			    
			    
			    
			    String jobtypeid="0";
			    
			    String sqljobtye="select jobtype from cm_sjobuserlink where userid='"+session.getAttribute("USERID").toString().trim()+"'";
			    
			 //   System.out.println("===serCountgrid===="+sqljobtye);
			    
			    ResultSet resultSet13=stmt.executeQuery(sqljobtye);
			    
			    while(resultSet13.next()){
			    	
			   	jobtypeid=resultSet13.getString("jobtype");
			    } 
			    
			    
			//    System.out.println("jobtypeid======="+jobtypeid);
			    
			    
			    
			    if(jobtypeid.equalsIgnoreCase("0")){
			    	
			    	sqljob+=" ";
			    }
			    else{
			    	
			    	
			    	sqljob+=" and x.sjobtype in("+jobtypeid+") ";
			    	
			    }
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    sql="select x.profomadate,x.profomarecievedate,x.brhid branch,x.tr_no as doctrno,me.menu_name as name,me.func path,'view' contr,p.dtype,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,"
						+ "p.plannedon pldte,priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,gv.groupname compl,coalesce(tm.grpcode,'') asngroup,p.EMPGROUPID grpid,coalesce(cd.description,'') description   "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,ff.date profomarecievedate,m.doc_no,sjobtype from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,'' profomadate,null profomarecievedate,c.doc_no,'' sjobtype FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on (md.rdocno=m.doc_no and p.empid=md.empid) left join cm_srvcsited s on( p.siteid=s.rowno ) left join cm_servsited st1 on st1.rowno=p.siteid left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area') "
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype)  LEFT JOIN cm_serteamm tm on p.EMPGROUPID=tm.doc_no where p.status=3 "+sql11+" "+sqljob+"  group by p.tr_no order by p.plannedon ";
				
			//	System.out.println("==serviceScheduleGridLoad=="+sql);

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
	
	
	
	public JSONArray serviceScheduleGridExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String site,String area) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",esql="",sqljob="";
			String comp="";

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=" and x.cldocno in ("+clientid+")";
			}
			if(!(site.equals("0") || site.equals("") || site.equals("undefined"))){
				sql11=sql11+" and s.site='"+site+"'";
			}
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and s.areaid='"+area+"'";
			}
			if(priority>0){
				System.out.println("inside");
				sql11=sql11+" and p.priorno=1";
			}

			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
				java.sql.Date todate=com.changeStringtoSqlDate(date);
				sql11=sql11+" and p.date<='"+todate+"'"; 
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

			if(id>0){

				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 

				/*sql="select p.dtype,p.refdocno,p.tr_no,s.site,a.groupname,ac.refname,concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,p.plannedon pldte,priorno priority,DATE_FORMAT(m.validupto,'%d-%m-%Y') as validupto from  cm_srvcontrm m left join cm_servplan p on(m.tr_no=p.reftrno) "
						+ "left join cm_srvcsited s on(s.tr_no=m.tr_no and p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid) left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where  m.status=3 and m.jbaction in (0,4) and  m.jbaction not in (2) and m.pstatus!=1 and p.status=3   "
						+ " "+sql11+" group by p.tr_no ";
*/
			    
			    
			    
			    
			    String jobtypeid="0";
			    
			    String sqljobtye="select jobtype from cm_sjobuserlink where userid='"+session.getAttribute("USERID").toString().trim()+"'";
			    
			//    System.out.println("===serCountgrid===="+sqljobtye);
			    
			    ResultSet resultSet13=stmt.executeQuery(sqljobtye);
			    
			    while(resultSet13.next()){
			    	
			   	jobtypeid=resultSet13.getString("jobtype");
			    } 
			    
			    
			//    System.out.println("jobtypeid======="+jobtypeid);
			    
			    
			    
			    if(jobtypeid.equalsIgnoreCase("0")){
			    	
			    	sqljob+=" ";
			    }
			    else{
			    	
			    	
			    	sqljob+=" and x.sjobtype in ('"+jobtypeid+"') ";
			    	
			    }
			    
				sql="select p.dtype,p.refdocno ContractNo,p.tr_no scheduleNo,p.sr_no Srno,s.site,if(s.siteadd='0','',s.siteadd) 'site address',coalesce(cont.cperson,'') 'Contact Person',coalesce(cont.tel,cont.mob,'') 'Mobile Number',a.groupname Area,ac.refname,coalesce(tm.grpcode,'') 'Assign group',concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
						+ "p.plannedon plannedDate,priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,apprdate,x.Profomadate,x.profomarecievedate,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as 'Service Type',coalesce(cd.description,'') 'Description' "+comp+" "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,ff.date profomarecievedate,m.doc_no,sjobtype from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,'' profomadate,null profomarecievedate,c.doc_no,'' sjobtype FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area') "
						+ "left join my_crmcontact cont on cont.row_no=s.contactid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)  "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')"
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype)"
						+ "  LEFT JOIN cm_serteamm tm on p.EMPGROUPID=tm.doc_no where p.status=3 "+sql11+" "+sqljob+"  group by p.tr_no order by p.plannedon ";
				
				//System.out.println("==excelserviceScheduleGridLoad=="+sql);

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
	public  ServiceSchedulerBean getPrint(HttpServletRequest request,int docno,String dtype,String srno,String branch) throws SQLException {
		
		ServiceSchedulerBean bean = new ServiceSchedulerBean();
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
			//System.out.println(headersql);
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
							+ " left join my_menu me on(me.doc_type=p.dtype) left join cm_serteamm sm on (p.empgroupid=sm.doc_no) left join cm_srvcontrpd sv on x.tr_no=sv.tr_no where p.status=3 and p.tr_no="+srno+" group by p.tr_no order by p.plannedon ";	
	//System.out.println("sqldet"+sqldet);
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
			bean.setLblclientlpo(resultSetdet.getString("refNo"));
			bean.setLblassngrp(resultSetdet.getString("asgngrp"));
			bean.setLblschno(resultSetdet.getString("tr_no"));
			bean.setDescription(resultSetdet.getString("description"));
			bean.setPaydescription(resultSetdet.getString("desc1"));
				}		
					
			String sql = "";
			
			if(dtype=="CREG")
			{
					
					sql="select coalesce(S.site,' ') site,coalesce(equips,' ') equips,coalesce(v.groupname,' ') groupname, coalesce(d1.qty,' ') qty,coalesce(d1.description,' ') description from cm_srvcontrm m"
					+ " left join cm_srvqotm d on m.TR_NO=d.CNTRTRNO left join cm_srvqotD D1 on D.TR_NO=D1.TR_NO and d.revision_no=d1.revision_no"
					+ " left join cm_servsited S on D.TR_NO=S.TR_NO AND D1.SITESRNO=S.ROWNO"
					+ " left join my_groupvals v on v.doc_no=d1.servid and grptype='service' where m.dtype=(select contracttype from cm_cuscallm where dtype='"+dtype+"' and doc_no='"+docno+"') and m.tr_no=(select contractno from cm_cuscallm where dtype='"+dtype+"' and doc_no='"+docno+"') ";
			}
			else{
					sql="select coalesce(S.site,' ') site,coalesce(equips,' ') equips,coalesce(v.groupname,' ') groupname, coalesce(d1.qty,' ') qty,coalesce(d1.description,' ') description from cm_srvcontrm m"
					+ " left join cm_srvqotm d on m.TR_NO=d.CNTRTRNO left join cm_srvqotD D1 on D.TR_NO=D1.TR_NO and d.revision_no=d1.revision_no"
					+ " left join cm_servsited S on D.TR_NO=S.TR_NO AND D1.SITESRNO=S.ROWNO"
					+ " left join my_groupvals v on v.doc_no=d1.servid and grptype='service' where m.dtype='"+dtype+"' and m.doc_no="+docno+" ";
			}	
					
			 
		//	System.out.println("service scheduler+++"+sql);
			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printschedulerarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("site")+":: "+resultSet1.getString("equips")+":: "+resultSet1.getString("description")+":: "+resultSet1.getString("qty")+":: "+resultSet1.getString("groupname");
				printschedulerarray.add(temp1);
			}
			request.setAttribute("printschedulerarray", printschedulerarray);
			
             String sqllll="";
			
			sqllll="select @i:=@i+1 as srno,a.* from(select distinct description,p.sr_no from cm_srvcontrm m left join cm_srvcontrd d on m.tr_no=d.tr_no "
                    + " left join cm_servplan p on (m.tr_no=p.doc_no and m.dtype=p.dtype) where m.doc_no="+docno+" and m.dtype='amc' and description !='')a,(select @i:=0) r ";
			 
	//	System.out.println("griddd2"+sqllll);
			ResultSet resultSet2 = stmtVeh.executeQuery(sqllll);
			
			ArrayList<String> amcgrid= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet2.getString("description")+"::"+resultSet2.getString("sr_no");
				amcgrid.add(temp1);
			}
			request.setAttribute("amcgrid", amcgrid);
					
			
			
			
			
			sql="select distinct d.description,d.qty,g.groupName from cm_srvcontrm m left join cm_srvcontrd d on m.tr_no=d.tr_no left join my_groupvals g on d.servId=g.doc_no and grptype='service' "
					+ "where m.doc_no="+docno+" and m.dtype='sjob' and d.description !='' ";
			 
//			System.out.println(sql);
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
