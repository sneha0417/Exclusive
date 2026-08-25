package com.dashboard.project.projectstatus;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class projectstatusDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String dtype,String clientid,String asgngrpid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
//System.out.println(dtype);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			if(dtype.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(dtype.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
			if(rds.equalsIgnoreCase("AE")){
				sqltest+=" and cm.status <3 and cm.jbaction=0  ";
			}
			 if(rds.equalsIgnoreCase("AA")){
					sqltest+=" and cm.status=3 and cm.jbaction=0 and cm.pstatus!=1 ";
				}
			 if(rds.equalsIgnoreCase("AP")){
					sqltest+=" and cm.status=3 and cm.jbaction=0 and cm.pstatus=1 and cm.pinvno!=0 ";
				}
				 if(rds.equalsIgnoreCase("AW")){
						sqltest+=" and cm.jbaction=4 and cm.status=3 ";
					}
				 if(rds.equalsIgnoreCase("AJ")){
						sqltest+=" and cm.status=3 and cm.jbaction=1 ";
					}
				
		if(rds.equalsIgnoreCase("CO")){
						sqltest+=" and cm.jbaction=3 and cm.status<>7 ";
					}
				 if(rds.equalsIgnoreCase("CL")){
						sqltest+=" and cm.jbaction=2 and cm.status<>7 ";
					}
				 if(rds.equalsIgnoreCase("DL")){
						sqltest+=" and cm.status in (6,7) ";
					}
		

 
				 if(!clientid.equalsIgnoreCase("0"))
		        	{
						sqltest+=" and cm.cldocno="+clientid+ " ";
		        	}
			     	if(!asgngrpid.equalsIgnoreCase("0"))
		        	{
						sqltest+=" and p.empGroupid="+asgngrpid+" ";
		        	}
				 
				
				 
				 String sqldata="select cm.doc_no,cm.dtype,ac.refname client,cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, "
				 		+ "concat(cs.site,if(aa<=1,'',aa+'')) site,csp.bb schedule, coalesce(agn.cc,0) assign,coalesce(com.dd,0)  complete,coalesce(cls.cl,0)  closed,cm.date from "
				 		+ "cm_srvcontrm cm left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='CRM' left join (select doc_no,count(*) bb from cm_servplan group by doc_no) csp "
				 		+ "on cm.tr_no=csp.doc_no left join (select doc_no,count(*) cc,dtype from cm_servplan where status=4 group by doc_no) agn on cm.tr_no=agn.doc_no and cm.dtype=agn.dtype "
				 		+ "left join (select doc_no,count(*) dd,dtype from cm_servplan where status=5 group by doc_no) com on cm.tr_no=com.doc_no and cm.dtype=com.dtype "
				 		+ "left join (select doc_no,count(*) cl,dtype from cm_servplan where status=6 group by doc_no) cls on cm.tr_no=cls.doc_no and cm.dtype=cls.dtype "
				 		+ "left join (select count(*) aa,site,tr_no from  cm_srvcsited  group by tr_no) cs on cs.tr_no=cm.tr_no "
				 		
						
						+ "  left join cm_servplan p on cm.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no  "
	
+ "where cm.date >= '"+sqlfromdate+"'  and cm.date <='"+sqltodate+"' "+sqltest+"  group by cm.tr_no order by cm.doc_no ";
					 
				 
		System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);
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
	
	
	public JSONArray getStatusCount(String fromdate,String todate,String rds,String barchval,String clientid,String asgngrpid) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and m.brhid="+barchval;
        	}
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and m.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and m.dtype='SJOB' ";
				}
			
			if(!clientid.equalsIgnoreCase("0"))
        	{
				sqltest+=" and m.cldocno="+clientid+ " ";
        	}
	     	if(!asgngrpid.equalsIgnoreCase("0"))
        	{
				sqltest+=" and p.empGroupid="+asgngrpid+" ";
        	}
	    	

			String sqldata="select count(*) val,'Entry' stat,'AE' rds from(select count(*)  from cm_srvcontrm m "

					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "
					+" where m.status<3 and m.jbaction=0 "
					+ "and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+"  group by m.tr_no)a "
					+ "union "
					+ " select count(*) val,'Approved' stat,'AA' rds from( select count(*) from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "
					+" where m.status=3 and m.jbaction=0 and m.pstatus!=1 "
					+ "and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a "
					+ " union "
					+ "select count(*) val,'Proforma For Payment' stat,'AP' rds from(select count(*)  from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "

					+ " where m.status=3 and m.jbaction=0 and m.pstatus=1 and m.pinvno!=0 and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a "
					+ " union "
					+ " select count(*) val,'Work Started' stat,'AW' rds from(select count(*)  from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "

					+ " where m.status=3 and m.jbaction=4 "
					+ "and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a "
					+ "union "
					+ " select count(*) val,'Job on Hold' stat,'AJ' rds from ( select count(*) from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "					
					+ "where m.status=3 and m.jbaction=1 and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a " 
					+" union "
					+ "select count(*) val,'Completed' stat,'CO' rds from (select count(*)  from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "
					+ "where  m.jbaction=3 and m.status<>7 and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a "
					+" union "
					+ "select count(*) val,'Closed' stat,'CL' rds from(select count(*)  from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "
					+ "where  m.jbaction=2 and m.status<>7 and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a "
					+" union "
					+ "select count(*) val,'Deleted' stat,'DL' rds from(select count(*) from cm_srvcontrm m "
					+" left join cm_servplan p on m.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no   "
					+ "where  m.status in (6,7) and m.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by m.tr_no)a ";
		System.out.println("=="+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);
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
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String dtype,String clientid,String asgngrpid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			if(dtype.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(dtype.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
			if(rds.equalsIgnoreCase("AE")){
				sqltest+=" and cm.status <3 and cm.jbaction=0  ";
			}
			 if(rds.equalsIgnoreCase("AA")){
					sqltest+=" and cm.status=3 and cm.jbaction=0 and cm.pstatus!=1";
				}
			 if(rds.equalsIgnoreCase("AP")){
					sqltest+=" and cm.status=3 and cm.jbaction=0 and cm.pstatus=1 and cm.pinvno!=0 ";
				}
				 if(rds.equalsIgnoreCase("AW")){
						sqltest+=" and cm.jbaction=4 and cm.status=3 ";
					}
				 if(rds.equalsIgnoreCase("AJ")){
						sqltest+=" and cm.status=3 and cm.jbaction=1 ";
					}
				
				 if(rds.equalsIgnoreCase("CO")){
						sqltest+=" and cm.jbaction=3 and cm.status<>7 ";
					}
				 if(rds.equalsIgnoreCase("CL")){
						sqltest+=" and cm.jbaction=2 and cm.status<>7 ";
					}
				 if(rds.equalsIgnoreCase("DL")){
						sqltest+=" and cm.status in (6,7) ";
					}
			 if(!clientid.equalsIgnoreCase("0"))
		        	{
						sqltest+=" and cm.cldocno="+clientid+ " ";
		        	}
			     	if(!asgngrpid.equalsIgnoreCase("0"))
		        	{
						sqltest+=" and p.empGroupid="+asgngrpid+" ";
		        	}

				 String sqldata="select cm.doc_no,cm.dtype,ac.refname client,cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, "
					 		+ "concat(cs.site,if(aa<=1,'',aa+'')) site,csp.bb schedule, coalesce(agn.cc,0) assign,coalesce(com.dd,0)  complete,coalesce(cls.cl,0)  closed,DATE_FORMAT(cm.date,'%d-%m-%Y') date from "
					 		+ "cm_srvcontrm cm left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='CRM' left join (select doc_no,count(*) bb from cm_servplan group by doc_no) csp "
					 		+ "on cm.tr_no=csp.doc_no left join (select doc_no,count(*) cc,dtype from cm_servplan where status=4 group by doc_no) agn on cm.tr_no=agn.doc_no and cm.dtype=agn.dtype "
					 		+ "left join (select doc_no,count(*) dd,dtype from cm_servplan where status=5 group by doc_no) com on cm.tr_no=com.doc_no and cm.dtype=com.dtype "
					 		+ " left join (select doc_no,count(*) cl,dtype from cm_servplan where status=6 group by doc_no) cls on cm.tr_no=cls.doc_no and cm.dtype=cls.dtype "
					 		+ "left join (select count(*) aa,site,tr_no from  cm_srvcsited  group by tr_no) cs on cs.tr_no=cm.tr_no "
					 		+ "  left join cm_servplan p on cm.tr_no=p.doc_no   left join cm_serteamm t on p.empGroupid=t.doc_no  "
					 		
							+ "where cm.date >= '"+sqlfromdate+"'  and cm.date <='"+sqltodate+"' "+sqltest+" group by cm.tr_no order by cm.doc_no ";
						 
	//	System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);
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
	public JSONArray searchAssignGroup(HttpSession session,int id,String grpname) throws SQLException {


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
		if(!(grpname.equalsIgnoreCase("undefined"))&&!(grpname.equalsIgnoreCase(""))&&!(grpname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and grpcode like '%"+grpname+"%'";
		}

		String brid=session.getAttribute("BRANCHID").toString();


		
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select doc_no doc_no ,grpcode grpname,description  from cm_serteamm where status=3 "+sqltest+";");

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=cm.convertToJSON(resultSet);
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
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
						+ " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=cm.convertToJSON(resultSet);
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

}