package com.dashboard.marketing.enquiryScheduler;

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
import com.dashboard.marketing.leadfollowuplog.ClsLeadFollowupLogBean;

import net.sf.json.JSONArray;

public class ClsenquirySchedulerDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray enquirySchedulerdata(String uptodate,String branch,String clientid,String area) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqluptodate = null;
     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
     	{
     		sqluptodate=com.changeStringtoSqlDate(uptodate);
     		
     	}
     	else{
     
     	}

       
       	if(!(clientid.equalsIgnoreCase(""))){
       		sqltest+=" and e.cldocno= "+clientid+" ";
       	}
       	if(!(area.equalsIgnoreCase(""))){
       		sqltest+=" and e.sourceid="+area+" ";
       	}
       	
    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
            		String sql="select qs.site,e.voc_no,e.brhid, e.doc_no,bq.tr_no schtrno, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,"
            				+ "	ce.txtname source,m.grpcode groups,em.name grpmem,gr.groupname asgmeth,bq.plannedon,bq.pltime,bq.description,bq.empgroupid, bq.empid,"
            				+ " bq.asgnMode,md.doc_no as teampid,'VIEW' as view,mu.func path  from gl_enqm e  left join (select rowno,group_concat(site) site,rdocno from gl_enqsited group by rdocno) qs on qs.rdocno=e.doc_no "
            				+ "  left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) "
            				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=bq.asgnmode and gr.grptype='assignmode') left join  cm_enqsource ce on ce.doc_no=e.sourceid "
            				+ "left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id left join my_menu mu on mu.doc_type='enq' "
            				+ "	 where e.status=3 and e.enqstatus=0 and e.DATE<='"+sqluptodate+"'  "+sqltest+" group by e.doc_no ";
          //System.out.println("--enqscheduler=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToJSON(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

		public JSONArray enquirySchedulerExcel(String uptodate,String branch,String clientid,String area) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqluptodate = null;
     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
     	{
     		sqluptodate=com.changeStringtoSqlDate(uptodate);
     		
     	}
     	else{
     
     	}

       
       	if(!(clientid.equalsIgnoreCase(""))){
       		sqltest+=" and e.cldocno= "+clientid+" ";
       	}
       	if(!(area.equalsIgnoreCase(""))){
       		sqltest+=" and e.sourceid="+area+" ";
       	}
       	
    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
            		String sql="select  if(e.enqtype=0,'General','Client') 'Type',e.date 'Date',e.voc_no 'Doc No',   e.name 'Client',qs.site,ms.sal_name 'Salesman', e.mob 'MOB',e.remarks 'Remarks',"
            				+ "	ce.txtname 'Source',m.grpcode 'Assign Group',em.name 'Group Member',gr.groupname 'Assign Method',bq.plannedon 'Planned Date',bq.pltime 'Planned Time',bq.description 'Description' "
            				+ "   from gl_enqm e  left join (select rowno,group_concat(site) site,rdocno from gl_enqsited group by rdocno) qs on qs.rdocno=e.doc_no "
            				+ "  left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) "
            				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=bq.asgnmode and gr.grptype='assignmode') left join  cm_enqsource ce on ce.doc_no=e.sourceid "
            				+ "left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id left join my_menu mu on mu.doc_type='enq' "
            				+ "	 where e.status=3 and e.enqstatus=0 and e.DATE<='"+sqluptodate+"'  "+sqltest+" group by e.doc_no ";
          //System.out.println("--enqscheduler=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToEXCEL(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray siteGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select a.rdocno,eq.sr_no,eq.rowno, (SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
					+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,grp.groupname area,eq.remarks, eq.areaid, "
					+ "eq.surv_id surid  from gl_enqsited eq  left  join (select eq.rdocno,eq.surv_id,eq.sr_no   "
					+ "from gl_enqsited eq where eq.rdocno="+docno+") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
					+ "left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' where eq.rdocno="+docno+"";


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

	public  ClsenquirySchedulerBean getPrint(HttpServletRequest request,int docno) throws SQLException {
		ClsenquirySchedulerBean bean = new ClsenquirySchedulerBean();
		 Connection conn = null;
			
	        java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			String mainbranch="";
			/*
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
			*/
			
				mainbranch="1";
			
			String headersql="select b.branchname,'Inspection Form' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
					+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
					+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";

					ResultSet resultSetHead = stmtVeh.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblprintname1(resultSetHead.getString("vouchername1"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						}
		
					
		String sqldet="select concat(d.site,' , ',g.groupname) site,m.remarks,m.contrmode,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') as date,m.name,m.com_add1,m.cperson,m.telno "
				+ " from gl_enqm m left join gl_enqsited d on d.rdocno=m.doc_no "
				+ " left join my_groupvals g on g.doc_no=d.areaid and g.grptype='area' where m.doc_no="+docno+"";				
				System.out.println("locationnn"+sqldet);	
		ResultSet resultSetdet = stmtVeh.executeQuery(sqldet);
		
		while(resultSetdet.next()){
			bean.setLbldocno(resultSetdet.getString("doc_no"));
			bean.setLbldate(resultSetdet.getString("date"));
			bean.setLblcusname(resultSetdet.getString("name"));
			bean.setLbladdrs(resultSetdet.getString("com_add1"));
			bean.setLblconper(resultSetdet.getString("cperson"));
			bean.setLblservice(resultSetdet.getString("contrmode"));
			bean.setLblconnum(resultSetdet.getString("telno"));	
			bean.setLbllocn(resultSetdet.getString("site"));
			bean.setLblremarks(resultSetdet.getString("remarks"));
			
				}		
					
			String sql = "";
			
			sql="select description,coalesce(if(doc_no>0,' ',' ')) as doc_no from cm_proptyped where  doc_no=1 ";

			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printclientarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("description")+"::"+resultSet1.getString("doc_no");
				printclientarray.add(temp1);
			}
			request.setAttribute("printclientarray", printclientarray);
			
           String sqlloc = "";
			
           sqlloc="select concat(d.site,' , ',g.groupname) site  from gl_enqm m left join gl_enqsited d on d.rdocno=m.doc_no  left join my_groupvals g on g.doc_no=d.areaid and g.grptype='area' where m.doc_no="+docno+"";

			ResultSet resultSetloc = stmtVeh.executeQuery(sqlloc);
			
			ArrayList<String> printlocationarray= new ArrayList<String>();
			
			while(resultSetloc.next()){
				bean.setFirstarray(1);
				String temploc="";
				temploc=resultSetloc.getString("site");
				printlocationarray.add(temploc);
			}
			request.setAttribute("printlocationarray", printlocationarray);
         
			String sql1 = "";
			
			sql1="select description,coalesce(if(doc_no>0,' ',' ')) as doc_no from cm_proptyped where  doc_no=2 ";
          System.out.println(sql1);
			ResultSet resultSet2 = stmtVeh.executeQuery(sql1);
			
			ArrayList<String> printclientarray1= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecondarray(1);
				String temp1="";
				temp1=resultSet2.getString("description")+"::"+resultSet2.getString("doc_no");
				printclientarray1.add(temp1);
			}
			request.setAttribute("printclientarray1", printclientarray1);
					
			
			 String sql2 = "";
				
			 sql2="select description,coalesce(if(doc_no>0,' ',' ')) as doc_no from cm_proptyped where  doc_no=3 ";
	          System.out.println(sql2);
				ResultSet resultSet3 = stmtVeh.executeQuery(sql2);
				
				ArrayList<String> printclientarray2= new ArrayList<String>();
				
				while(resultSet3.next()){
					bean.setSecondarray(1);
					String temp1="";
					temp1=resultSet3.getString("description")+"::"+resultSet3.getString("doc_no");
					printclientarray2.add(temp1);
				}
				request.setAttribute("printclientarray2", printclientarray2);
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
