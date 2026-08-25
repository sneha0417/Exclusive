package com.dashboard.projectexecution.projectwisereport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsProjectwiseReport {
	
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();
	
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
	
	


	public JSONArray projectwiseGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,String cstatus,String frmdate,int check) throws SQLException
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
//      System.out.println("===clientid==="+clientid);
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11=sql11+" and m.date<='"+todate+"'"; 
		}
		
		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			java.sql.Date fdate=com.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and m.date>='"+fdate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}
		if(!(cstatus.equals("0") || cstatus.equals("") || cstatus.equals("undefined"))){
			sql11=sql11+" and m.jbaction="+cstatus+"";
		}
if(check==1){


		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			

			
			/*String sql=" select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,round(sum(jv.dramount),2) invoiced,"
					+ "round(sum(jv.out_amount),2) as collected,round((sum(jv.dramount)-sum(jv.out_amount)),2) as balance,"
					+ "(round(contractval,2)-round(sum(pd.amount),2)) as blinvamt,'' site from cm_srvcontrm m "
					+ "left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no)left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM') "
					+ "where  pd.invtrno>0 and pd.invamt>0  "+sql11+" group by m.tr_no,dtype having balance>0"
					+ " union all "
					+ "select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,round(sum(jv.dramount),2) invoiced,"
					+ "round(jv.out_amount,2) as collected,round((sum(jv.dramount)-sum(jv.out_amount)),2) as balance, "
					+ "(round(contractval+sum(sv.taxamt),2)-round(sum(dramount),2)) as blinvamt,sd.site from cm_srvcontrm m "
					+ "left join ( select serinv,invtrno,doc_no,siteid from cm_servplan "
					+ "where invtrno>0 and serinv=1 group by invtrno) pd on(m.tr_no=pd.doc_no) left join my_servm sv on sv.tr_no=pd.invtrno "
					+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM')"
					+ " left join cm_srvcsited sd on pd.siteid=sd.rowno "
					+ "where  pd.invtrno>0 and pd.serinv=1  "+sql11+" group by m.tr_no,dtype having balance>0";*/
			
			///site added/////
	/*		
			String sql=" select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,round(sum(jv.dramount),2) invoiced,"
					+ "round(sum(jv.out_amount),2) as collected,round((sum(jv.dramount)-sum(jv.out_amount)),2) as balance,"
					+ "(round(contractval,2)-round(sum(pd.amount),2)) as blinvamt,sd.site from cm_srvcontrm m "
					+ "left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no)left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM') "
					+ "left join ( select GROUP_CONCAT(site) site,tr_no from cm_srvcsited group by tr_no order by sr_no) sd on sd.tr_no=m.tr_no "
					+ "where  pd.invtrno>0 and pd.invamt>0  "+sql11+" group by m.tr_no,dtype having balance>0"
					+ " union all "
					+ "select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,round(sum(jv.dramount),2) invoiced,"
					+ "round(jv.out_amount,2) as collected,round((sum(jv.dramount)-sum(jv.out_amount)),2) as balance, "
					+ "(round(contractval+sum(sv.taxamt),2)-round(sum(dramount),2)) as blinvamt,sd.site from cm_srvcontrm m "
					+ "left join ( select serinv,invtrno,doc_no,siteid from cm_servplan "
					+ "where invtrno>0 and serinv=1 group by invtrno) pd on(m.tr_no=pd.doc_no) left join my_servm sv on sv.tr_no=pd.invtrno "
					+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM')"
					+ " left join cm_srvcsited sd on pd.siteid=sd.rowno "
					+ "where  pd.invtrno>0 and pd.serinv=1  "+sql11+" group by m.tr_no,dtype having balance>0";
			*/
			String sql=" select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,"
					+ " round(sum(pd.amount),2) invoiced,if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)) as collected,if((round(sum(pd.amount),2)-if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)))<0, round(sum(pd.amount),2) , (round(sum(pd.amount),2)-if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)))) balance,(round(contractval,2)-round(sum(pd.amount),2))as blinvamt, "
					+ "GROUP_CONCAT(sd.site) site from cm_srvcontrm m "
					+ "left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no)left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM') "
					+ "left join cm_srvcsited sd on sd.tr_no=m.tr_no "
					+ "where  pd.invtrno>0 and pd.invamt>0  "+sql11+" group by m.tr_no,dtype having balance>0"
					+ " union all "
					+ "select m.dtype dtype,m.doc_no docno,m.tr_no trno,ac.refname as client,DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') edate, if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',"
					+ "if(m.jbaction=4,'STARTED','ENTERED')))) as status,round(contractval,2) as cntrval,round(sum(jv.dramount),2) invoiced,"
					+ "round(jv.out_amount,2) as collected,round((sum(jv.dramount)-sum(jv.out_amount)),2) as balance, "
					+ "(round(contractval+sum(sv.taxamt),2)-round(sum(dramount),2)) as blinvamt,sd.site from cm_srvcontrm m "
					+ "left join ( select serinv,invtrno,doc_no,siteid from cm_servplan "
					+ "where invtrno>0 and serinv=1 group by invtrno) pd on(m.tr_no=pd.doc_no) left join my_servm sv on sv.tr_no=pd.invtrno "
					+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM')"
					+ " left join cm_srvcsited sd on pd.siteid=sd.rowno "
					+ "where  pd.invtrno>0 and pd.serinv=1  "+sql11+" group by m.tr_no,dtype having balance>0";
		
			//System.out.println("==projectwiseGridLoad==="+sql);
			 
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
}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	public JSONArray projectwiseExcelLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,String cstatus,String frmdate,int check) throws SQLException
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
//      System.out.println("===clientid==="+clientid);
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11=sql11+" and m.date<='"+todate+"'"; 
		}
		
		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			java.sql.Date fdate=com.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and m.date>='"+fdate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}
		if(!(cstatus.equals("0") || cstatus.equals("") || cstatus.equals("undefined"))){
			sql11=sql11+" and m.jbaction="+cstatus+"";
		}
if(check==1){
		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
 
			String sql=" select m.dtype 'CONTR.TYPE',m.doc_no 'CONTRACT NO', if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) STATUS,"
					+ "ac.refname 'CLIENT NAME',GROUP_CONCAT(sd.site) SITE,DATE_FORMAT(validfrom,'%d-%m-%Y') 'START DATE',"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') 'END DATE',"
					+ "round(contractval,2) contractval,round(sum(pd.amount),2) 'INVOICED AMOUNT',"
					+ "if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)) 'COLLECTED AMOUNT'"
					+ ",if((round(sum(pd.amount),2)-if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)))<0, round(sum(pd.amount),2) , (round(sum(pd.amount),2)-if(round(sum(jv.out_amount),2)>(round(sum(pd.amount),2)),round(sum(pd.amount),2),round(sum(jv.out_amount),2)))) balance,"
					+ "(round(contractval,2)-round(sum(pd.amount),2)) 'TO BE INVOICED' from cm_srvcontrm m "
					+ "left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no)left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM') "
					+ "left join cm_srvcsited sd on sd.tr_no=m.tr_no "
					+ "where  pd.invtrno>0 and pd.invamt>0  "+sql11+" group by m.tr_no,m.dtype having balance>0 "
					+ " union all "
					+ "select m.dtype 'CONTR.TYPE',m.doc_no 'CONTRACT NO',if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) STATUS,"
					+ "ac.refname 'CLIENT NAME',sd.site SITE,DATE_FORMAT(validfrom,'%d-%m-%Y') 'START DATE',"
					+ "DATE_FORMAT(validupto,'%d-%m-%Y') 'END DATE'," 
					+ "round(contractval,2) 'CONTRACT AMOUNT',round(sum(jv.dramount),2) 'INVOICED AMOUNT',"
					+ "round(jv.out_amount,2) 'COLLECTED AMOUNT',round((sum(jv.dramount)-sum(jv.out_amount)),2) balance, "
					+ "(round(contractval+sum(sv.taxamt),2)-round(sum(dramount),2)) 'TO BE INVOICED' from cm_srvcontrm m "
					+ "left join ( select serinv,invtrno,doc_no,siteid from cm_servplan "
					+ "where invtrno>0 and serinv=1 group by invtrno) pd on(m.tr_no=pd.doc_no) left join my_servm sv on sv.tr_no=pd.invtrno "
					+ "left join my_jvtran jv on(jv.cldocno=m.cldocno and pd.invtrno=jv.tr_no) "
					+ "left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM')"
					+ " left join cm_srvcsited sd on pd.siteid=sd.rowno "
					+ "where  pd.invtrno>0 and pd.serinv=1  "+sql11+" group by m.tr_no,m.dtype having balance>0";
		 
			//System.out.println("==projectwiseExcelLoad==="+sql); 
			
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToEXCEL(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
	
	
	

}
