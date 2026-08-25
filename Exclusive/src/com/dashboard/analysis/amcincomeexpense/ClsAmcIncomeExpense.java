package com.dashboard.analysis.amcincomeexpense;


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

public class ClsAmcIncomeExpense {
	
	
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
	
	public JSONArray countgrid(HttpSession session,String frmdate,String todate,String branchid,String clientid,int id,String radval,String reftype) throws SQLException
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
		int rdval=Integer.parseInt(radval);

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}
		if(!(reftype.equalsIgnoreCase("0") || reftype.equalsIgnoreCase("") || reftype.equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.dtype='"+reftype+"'";
		}

		if(rdval==0){
		
		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and m.validfrom>='"+fmdate+"'"; 
		}
		
		if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
			java.sql.Date tdate=common.changeStringtoSqlDate(todate);
			sql11=sql11+" and m.validupto<='"+tdate+"'"; 
		}
		
		}
		else if(rdval==1){
			java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
			java.sql.Date tdate=common.changeStringtoSqlDate(todate);
			sql11=sql11+" and m.validfrom>='"+fmdate+"'"; 
			sql11=sql11+" and m.validfrom<='"+tdate+"'"; 
			
		}
		
		else if(rdval==2){
			
			java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
			java.sql.Date tdate=common.changeStringtoSqlDate(todate);
			
			sql11=sql11+" and m.validupto>='"+fmdate+"'"; 
			sql11=sql11+" and m.validupto<='"+tdate+"'"; 
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
		

				String sql= ("select count(*) as count,dtype,status,concat(dtype,' ',status) as desc1,jbaction from "
						+ "(select doc_no,m.jbaction,dtype,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status "
						+ "from cm_srvcontrm m  left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no) where pd.invtrno>0 and pd.invamt>0 "
						+ " "+sql11+" group by m.tr_no,m.jbaction) as a group by dtype,status order by dtype,jbaction desc");
				
			System.out.println("===Countgrid===="+sql);

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
	
	
	public JSONArray incomeExpenseGridLoad(HttpSession session,String frmdate,String todate,String branchid,String clientid,int id,String radval,String dtype,String jbaction) throws SQLException
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
		int rdval=Integer.parseInt(radval);

		if(!(clientid.trim().equalsIgnoreCase("0") || clientid.trim().equalsIgnoreCase("") || clientid.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.cldocno='"+clientid+"'";
		}
		
		if(!(dtype.trim().equalsIgnoreCase("0") || dtype.trim().equalsIgnoreCase("") || dtype.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}
		
		if(!(jbaction.trim().equalsIgnoreCase("0") || jbaction.trim().equalsIgnoreCase("") || jbaction.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.jbaction='"+jbaction+"'";
		}
		
		if(rdval==0){
			
			if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
				java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
				sql11=sql11+" and m.validfrom>='"+fmdate+"'"; 
			}
			
			if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
				java.sql.Date tdate=common.changeStringtoSqlDate(todate);
				sql11=sql11+" and m.validupto<='"+tdate+"'"; 
			}
			
			}
			else if(rdval==1){
				java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
				java.sql.Date tdate=common.changeStringtoSqlDate(todate);
				sql11=sql11+" and m.validfrom>='"+fmdate+"'"; 
				sql11=sql11+" and m.validfrom<='"+tdate+"'"; 
				
			}
			
			else if(rdval==2){
				
				java.sql.Date fmdate=common.changeStringtoSqlDate(frmdate);
				java.sql.Date tdate=common.changeStringtoSqlDate(todate);
				
				sql11=sql11+" and m.validupto>='"+fmdate+"'"; 
				sql11=sql11+" and m.validupto<='"+tdate+"'"; 
			}
		
		if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}

		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			String sql="";
			

				sql="select (inc*-1) as inc,(exp*-1) as exp,m.dtype,m.doc_no docno,m.tr_no as trno,ac.refname as client, "
						+ "if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status, "
						+ "DATE_FORMAT(validfrom,'%d-%m-%Y') as sdate,DATE_FORMAT(validupto,'%d-%m-%Y') as edate,round(m.contractval,2) as cntramt,"
						+ "round(sum(pd.amount),2) as invamt from cm_srvcontrm m left join cm_srvcontrpd pd on(m.tr_no=pd.tr_no) "
						+ "inner join ( select jobid,sum(inc) as inc,sum(exp) as exp from ( "
						+ "(select jobid,sum(amount) as inc,0 as exp,acno from my_head h inner join my_costtran co on(h.doc_no=co.acno) where gr_type=4 group by jobid ) "
						+ "union all (select jobid,0 as inc,sum(amount) as exp,acno from my_head h  inner join my_costtran co on(h.doc_no=co.acno) "
						+ "where gr_type=5 group by jobid) ) as a  group by jobid) as b on(b.jobid=pd.tr_no) left join my_acbook ac "
						+ "on(ac.cldocno=m.cldocno and ac.dtype='CRM') where pd.invtrno>0 and pd.invamt>0 "+sql11+" group by m.tr_no";
								
		   System.out.println("==incomeExpenseGridLoad==="+sql);

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
