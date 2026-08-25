package com.dashboard.audit.servicereport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsServiceReport {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();
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

	public JSONArray serviceScheduleGridLoad(HttpSession session,String clientid,String branchid,String fromdates,String todates) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
		if(todates.equalsIgnoreCase("0")){
			return RESULTDATA1;
		}
		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			fromdate=com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate=null;
			todate=com.changeStringtoSqlDate(todates);
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql1="";



//			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
//				sql11+=" and x.cldocno in ("+clientid+")";
//			}
//			//			System.out.println("===priority===="+priority);
//			if(priority>0){
//				//	System.out.println("inside");
//				sql11=sql11+" and p.priorno=1";
//			}
//			if(chkfromdate.equalsIgnoreCase("1")){
//				if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
//					
//					sql11=sql11+" and p.date between '"+fromdate+"' and '"+todate+"' "; 
//				}
//			}
//			
//			else
//				{
//				
//		if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
//				
//				sql11=sql11+" and p.date<='"+todate+"' "; 
//			}
//			
//
//			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
//				sql11=sql11+" and x.brhid in ("+branchid+")";
//			}
//
//			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
//				sql11=sql11+" and x.dtype='"+dtype+"'";
//			}
//			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
//				sql11=sql11+" and p.empgroupid in ("+grp+")";
//			}
//			
//			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
//				sql11=sql11+" and p.empid in ("+emp+")";
//			}
//			
//			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
//				sql11=sql11+" and s.areaid in ("+area+")";
//			}
//			if(id>0){
//				
//				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
//				ResultSet resultSet12=stmt.executeQuery(sql12);
//				   
//			    while(resultSet12.next()){
//			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
//			    } 
//			    cm_srvactiond
				/*sql="select sm.description,sm.tr_no srvdetmtrno,x.profomadate,x.profomarecievedate,x.tr_no as doctrno,me.menu_name as name,me.func path,p.dtype,p.refdocno,p.tr_no,p.sr_no,"
						+ " s.site,a.groupname,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
						+ "p.plannedon pldte,priorno priority,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),"
						+ " concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid ,"
						+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
						+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch  "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join cm_srvdetm sm on p.tr_no=sm.schrefdocno "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='0'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status=4 and sm.audit=0 and sm.date between '"+fromdate+"' and '"+todate+"' group by p.tr_no order by p.plannedon";
*/
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql1=sql1+" and ac.cldocno ="+clientid+"";
			}
			
			sql="select sr.description,'Service Report' sport ,sr.tr_no srvdetmtrno,x.tr_no as doctrno,sr.schrefdocno srtrno,me.menu_name as name,me.func path,p.dtype,p.refdocno,'view' contr,p.tr_no,s.site,a.groupname,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
					+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
					+ "p.plannedon pldte,priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,apprdate,"
					+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid ,"
					+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
					+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,if(x.dtype='AMC',ser.groupname,'')) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch  "
					+ "from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
					+ "m.refno contractdetails from cm_srvcontrm m where "
					+ "m.status=3 and m.jbaction in (4)  and m.pstatus!=1 union all "
					+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails "
					+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (3,0) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
					+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid)"
					+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
					+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
					+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
					+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='CREG' ) e "
					+ " on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
					+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
					+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join (select description,audit,max(tr_no) tr_no,schrefdocno,wrkper,date from cm_srvdetm where 1=1 group by schrefdocno) sr on(p.tr_no=sr.schrefdocno) left join my_menu me on(me.doc_type=p.dtype)"
					+ " where sr.wrkper=100 and sr.audit=0 and sr.date between '"+fromdate+"' and '"+todate+"'"+sql1+" order by p.plannedon";

				System.out.println("==strsql=="+sql);
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
	
public JSONArray serviceScheduleGridLoadExcel(HttpSession session,String clientid,String branchid,String fromdates,String todates) throws SQLException{
	JSONArray RESULTDATA1=new JSONArray();
	if(todates.equalsIgnoreCase("0")){
		return RESULTDATA1;
	}
	Connection conn=null;
	try {
		java.sql.Date fromdate=null;
		fromdate=com.changeStringtoSqlDate(fromdates);
		java.sql.Date todate=null;
		todate=com.changeStringtoSqlDate(todates);
		conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="",sql1="";
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql1=sql1+" and ac.cldocno ="+clientid+"";
		}

		sql=" select p.dtype as 'DTYPE',p.refdocno as 'Docno',p.tr_no as 'SCH.NO',p.sr_no as 'SRNO',s.site as 'Site',if(x.dtype='CREG',gvd.groupname,if(x.dtype='AMC',ser.groupname,'')) as 'Service Type',"
				+ " gv.groupname as 'COMPLAINT',coalesce(grpcode,'') as 'Assign Group',coalesce(em.name,'') as 'EMPLOYEE',coalesce(gr.groupname,'') as 'ASSIGN.MODE',"
				+ " a.groupname as 'AREA',ac.refname as 'CLIENT NAME',concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) as 'PLANNED DATE',"
				+ " apprdate as 'APPR.DATE','' as 'Proforma Date', '' as 'Proforma Recieve Date',DATE_FORMAT(x.validupto,'%d-%m-%Y') as 'END DATE',"
				+ "sr.description as 'Description' from (select tr_no,dtype,brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
				+ "m.refno contractdetails from cm_srvcontrm m where m.status=3 and m.jbaction in (4)  and m.pstatus!=1 union all "
				+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,c.refno contractdetails "
				+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (3,0) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
				+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid)"
				+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
				+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
				+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='CREG' ) e "
				+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
				+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
				+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join (select description,audit,max(tr_no) tr_no,schrefdocno,wrkper,date from cm_srvdetm where 1=1 group by schrefdocno) sr on(p.tr_no=sr.schrefdocno) left join my_menu me on(me.doc_type=p.dtype)"
				+ " where sr.wrkper=100 and sr.audit=0 and sr.date between '"+fromdate+"' and '"+todate+"'"+sql1+" order by p.plannedon";

				System.out.println("sql ="+sql);
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToEXCEL(resultSet1);
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
