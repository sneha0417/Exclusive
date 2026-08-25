package com.dashboard.analysis.salesincentive;


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

public class ClsSalesIncentive {


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

	public  JSONArray SalesgentSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String salsql="select doc_no,sal_name from my_salm where  status<>7 ";

			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=common.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray salesIncentiveGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,String radval,String salid,String frmdate) throws SQLException
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


		if(!(clientid.trim().equalsIgnoreCase("0") || clientid.trim().equalsIgnoreCase("") || clientid.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.cldocno="+clientid+"";
		}
		if(!(salid.trim().equalsIgnoreCase("0") || salid.trim().equalsIgnoreCase("") || salid.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.sal_id="+salid+"";
		}
		if(!(date.equalsIgnoreCase("0") || date.equalsIgnoreCase("") || date.equalsIgnoreCase("undefined"))){
			java.sql.Date todate=common.changeStringtoSqlDate(date);
			sql11=sql11+" and m.validupto<='"+todate+"'"; 
		}
		
		if(!(frmdate.equalsIgnoreCase("0") || frmdate.equalsIgnoreCase("") || frmdate.equalsIgnoreCase("undefined"))){
			java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and m.validupto>='"+fmdate+"'"; 
		}

		if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}
		if(!(dtype.equalsIgnoreCase("0") || dtype.equalsIgnoreCase("") || dtype.equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}




		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			String sql="";
			if(radval.equalsIgnoreCase("1")){

				sql="select  m.dtype,m.doc_no docno,ac.refname as client, "
						+ "if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status, "
						+ "DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,DATE_FORMAT(validupto,'%d-%m-%Y') as edate,round(m.contractval,2) as cntramt,round(sum(pd.invamt),2) as invamt,sum(round((m.salincentive)/cnt,2)) as salincamt, "
						+ "sm.sal_name as salname,round(m.salincentive,2) as cntrincamt,round(sum(jv.dramount),2) damt,round(sum(jv.out_amount),2) oamt,sd.site,sd.siteadd from cm_srvcontrm m "
						+ "inner join cm_srvcontrpd pd on(pd.tr_no=m.tr_no ) left join my_acbook ac on(ac.cldocno=m.cldocno) left join my_salm sm on(sm.doc_no=m.sal_id) "
						+ "left join (select count(*) as cnt,tr_no from cm_srvcontrpd group by tr_no) as p on(p.tr_no=m.tr_no) "
						+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) left join cm_srvcsited sd on m.tr_no=sd.tr_no where jbaction=3  and pd.invamt>0 and pd.invtrno>0 "
						+ " "+sql11+" group by m.tr_no having damt=oamt";

			}
			if(radval.equalsIgnoreCase("2")){

				sql="select  sum(round((m.salincentive)/cnt,2)) as salincamt,sm.sal_name as salname,round(sum(jv.dramount),2) damt,round(sum(jv.out_amount),2) oamt,round(sum(pd.invamt),2) as invamt,sd.site from cm_srvcontrm m "
						+ "inner join cm_srvcontrpd pd on(pd.tr_no=m.tr_no ) left join my_acbook ac on(ac.cldocno=m.cldocno) "
						+ "left join my_salm sm on(sm.doc_no=m.sal_id) left join (select count(*) as cnt,tr_no from cm_srvcontrpd group by tr_no) as p on(p.tr_no=m.tr_no) "
						+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) left join cm_srvcsited sd on m.tr_no=sd.tr_no "
						+ "where  jbaction=3  and pd.invamt>0 and pd.invtrno>0 "+sql11+" group by m.sal_id having damt=oamt";

			}

			System.out.println("==salesIncentiveGridLoad==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=common.convertToJSON(resultSet);
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

}
