package com.dashboard.projectexecution.invoicelist;

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



public class ClsInvoiceListDAO {

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


	public JSONArray invCountgrid(HttpSession session,String date,String branchid,String clientid,int id,String contract,String frmdate) throws SQLException
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

		java.sql.Date todate=null;
		java.sql.Date fmdate=null;
		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}
		
		if(!(contract.equals("0") || contract.equals("") || contract.equals("undefined"))){
			sql11=sql11+" and m.refdocno in ("+contract+")";
		}
		
		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			todate=common.changeStringtoSqlDate(date);
		}
		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			fmdate=common.changeStringtoSqlDate(frmdate);
		}


		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}



		Connection conn =null;
		Statement stmt =null;

		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){

				String sql="",sql2="";
				/*	String s1="0";
sql2="select m.pdrowno from my_servm m where m.status=3 and m.date<='"+todate+"' and m.date>='"+fmdate+"' and ref_type!='SINV' "+sql11+" ";
//System.out.println("===sqll=="+sql2);
ResultSet resultSet1 = stmt.executeQuery(sql2) ;
while(resultSet1.next())
{
s1=s1+","+resultSet1.getString("pdrowno");
}
//System.out.println("s1==="+s1);

sql="select m.ref_type dtype,count(*) as count from my_servm m inner join "
		+ "(select invtrno as tr_no from cm_servplan where serinv=1 and tr_no in("+s1+") "
		+ " union all select invtrno as tr_no from cm_srvcontrpd where rowno in("+s1+")) as x on(m.tr_no=x.tr_no)"
		+ " left join cm_srvcontrm cm on(cm.tr_no=m.costid) "
		+ " left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
		+ " where m.status=3 and m.date<='"+todate+"' and m.date>='"+fmdate+"' "+sql11+" group by m.ref_type "
		+ " union all select m.ref_type dtype,count(*) as count from my_servm m where m.ref_type='SINV' and m.status=3 "+sql11+" group by m.ref_type ";
*/
sql="select m.ref_type dtype,count(*) as count from my_servm m where m.status=3 and m.date<='"+todate+"' and m.date>='"+fmdate+"' "+sql11+" group by m.ref_type;";
				
System.out.println("===sinvCountgrid===="+sql);

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=common.convertToJSON(resultSet);
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



	public  JSONArray loadContractData(String todate,String branchid,String clientid,int id,String type,String contract,String fmdate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqltodate = null,sqlfmdate=null;
			String sqldata="";

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and m.cldocno="+clientid+"";
			}
			
			if(!(type.equals("0") || type.equals("") || type.equals("undefined"))){
				
				sql11=sql11+" and m.ref_type='"+type+"'";
			}
			
			if(!(contract.equals("0") || contract.equals("") || contract.equals("undefined"))){
				sql11=sql11+" and m.refdocno in ("+contract+")";
			}
			
			
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
			{
				sqltodate=common.changeStringtoSqlDate(todate);

			}
			else{

			}
			if(!(fmdate.equalsIgnoreCase("undefined"))&&!(fmdate.equalsIgnoreCase(""))&&!(fmdate.equalsIgnoreCase("0")))
			{
				sqlfmdate=common.changeStringtoSqlDate(fmdate);

			}
			
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and m.brhid in ("+branchid+")";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){

					/*sqldata="select m.doc_no,m.date,m.refno,m.ref_type as contrtype,cm.doc_no as contrNo,ac.refname as client,m.description as desc1,"
							+ "m.atotal as invamt, m.legalchrg as lfee,if(cm.inctax=1,m.netamount,(m.netamount+m.taxamt)) as total,site, round(m.taxamt,2) taxamt from my_servm m "
							+ "left join cm_srvcontrm cm  on(cm.tr_no=m.costid) left join (select f.siteid,f.invtrno,sd.site from cm_servplan f "
							+ "left join cm_srvcsited sd on f.siteid=sd.rowno where f.serinv=1 group by f.doc_no,f.invtrno)  as pd on m.tr_no=pd.invtrno "
							+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
							+ "where  m.date<='"+sqltodate+"' and m.date>='"+sqlfmdate+"' "+sql11+" ";*/
			
					/////added site in all contract////
					
				sqldata="select m.doc_no,m.date,m.refno,m.ref_type as contrtype,cm.doc_no as contrNo,ac.refname as client,m.description as desc1,"
						+ "round(m.atotal,2) as invamt, round(m.legalchrg,2) as lfee,round(if(cm.inctax=1,m.netamount,(m.netamount+m.taxamt)),2) as total,sdd.site, round(m.taxamt,2) taxamt from my_servm m "
						+ "left join cm_srvcontrm cm  on(cm.tr_no=m.costid) "
						+ "left join ( select GROUP_CONCAT(site) site,tr_no from cm_srvcsited group by tr_no order by sr_no) sdd on sdd.tr_no=cm.tr_no "
						+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
						+ "where m.status=3 and m.date<='"+sqltodate+"' and m.date>='"+sqlfmdate+"' "+sql11+" ";
					
				//System.out.println("==loadGridData==="+sqldata);

				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToJSON(resultSet);

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

	public  JSONArray loadContractDataExcel(String todate,String branchid,String clientid,int id,String type,String contract,String fmdate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqltodate = null,sqlfmdate=null;
			String sqldata="";

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and m.cldocno="+clientid+"";
			}
			
			if(!(type.equals("0") || type.equals("") || type.equals("undefined"))){
				
				sql11=sql11+" and m.ref_type='"+type+"'";
			}
			
			if(!(contract.equals("0") || contract.equals("") || contract.equals("undefined"))){
				sql11=sql11+" and m.refdocno in ("+contract+")";
			}
			
			
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
			{
				sqltodate=common.changeStringtoSqlDate(todate);

			}
			else{

			}
			if(!(fmdate.equalsIgnoreCase("undefined"))&&!(fmdate.equalsIgnoreCase(""))&&!(fmdate.equalsIgnoreCase("0")))
			{
				sqlfmdate=common.changeStringtoSqlDate(fmdate);

			}
			
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and m.brhid in ("+branchid+")";
			}
			else{
				sql11=sql11 +" ";
			}

			if(id>0){
				
					sqldata="select m.doc_no 'InvNo',m.date 'Date',m.refno 'RefNo',sdd.site 'Site',m.ref_type  'Contract Type',cm.doc_no 'Contract No',"
							+ "ac.refname 'Name',m.description 'Description', round(m.taxamt,2) 'Tax Amount',"
							+ "round(m.atotal,2) 'Amount', round(m.legalchrg,2) 'Legal Amount',round(if(cm.inctax=1,m.netamount,(m.netamount+m.taxamt)),2) 'Total Amount' from my_servm m "
							+ "left join cm_srvcontrm cm  on(cm.tr_no=m.costid) "
							+ "left join ( select GROUP_CONCAT(site) site,tr_no from cm_srvcsited group by tr_no order by sr_no) sdd on sdd.tr_no=cm.tr_no "
							+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
							+ "where m.status=3 and  m.date<='"+sqltodate+"' and m.date>='"+sqlfmdate+"' "+sql11+"  ;";
			
				//System.out.println("==loadGridDataExcel==="+sqldata);

				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToEXCEL(resultSet);

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

	
	public   JSONArray searchMaster(HttpSession session,String clnames,String contno,String invtype) throws SQLException {


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



		java.sql.Date sqlStartDate=null;


		//enqdate.trim();
		

		String sqltest="";
		
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no='"+contno+"'";
		}

		if(!(invtype.equalsIgnoreCase(""))){

			sqltest=sqltest+" and m.dtype='"+invtype+"'";
		}
		 

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select  m.doc_no contno,m.doc_no,ac.refname client,m.date,m.dtype contype,m.tr_no,m.cldocno,"
					+ "m.tr_no costid from cm_srvcontrm m  left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 and m.brhid="+brid+" " +sqltest+" order by m.doc_no");
			
			//System.out.println("===clssql====="+clssql);
			
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=common.convertToJSON(resultSet);
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
