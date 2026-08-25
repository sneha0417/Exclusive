package com.dashboard.project.legalcontract;


import java.sql.Connection;
import java.sql.Date;
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

public class legalContractDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}

			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
				
			if(rds.equalsIgnoreCase("SU")){
				//sqltest+=" and (legalno is not null or legalno!='') ";
				sqltest+=" and	(legalno is not null and trim(legalno)!='')  ";
			}
			 if(rds.equalsIgnoreCase("NO")){
					sqltest+=" and  (legalno is null or legalno='') ";
				}
				
		String sqldata="select cm.doc_no,e.apprdate,group_concat(cms.site, ' ') site,m.grpcode,if((legalno is not null and trim(legalno)!=''), 'Submitted', 'Not Submitted') status,cm.dtype,ac.refname client,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
				+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, round(cm.legalchrg,2) lfee from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join cm_srvcsited cms on cms.tr_no=cm.tr_no left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') "
				+ "left join cm_serteamm m on(cms.srvteamno=m.doc_no) left join "
				+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet group by doc_no,dtype ) e "
				+ " on(e.doc_no=cm.doc_no and e.dtype=cm.dtype and e.brhid=cm.brhid)  where cm.status=3  and cm.jbaction in (0,4) and cm.islegal=1 and cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" group by cm.doc_no";
		
		//System.out.println(sqldata);
		
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	
	public JSONArray getStatusCount(String fromdate,String todate,String barchval) throws SQLException {
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
	     		sdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and brhid="+barchval;
        	}
			
			
			String sqldata="select count(*) val,'Submitted' stat,'SU' rds from cm_srvcontrm where status=3 and islegal=1 and (legalno is not null and trim(legalno)!='') "
					+ "and date between '"+sdate+"' and '"+edate+"' "+sqltest+" "
					+ "union select count(*) val,'Not Submitted' stat,'NO' rds from cm_srvcontrm where status=3 and islegal=1 and (legalno is null or legalno='') "
					+ "and date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
					+ "select count(*) val,'All' stat,'AL' rds from cm_srvcontrm where status=3 and islegal=1 and date between '"+sdate+"' and '"+edate+"' "+sqltest+"  ";
	//	System.out.println("====m"+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}

			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
				
			if(rds.equalsIgnoreCase("SU")){
				//sqltest+=" and (legalno is not null or legalno!='') ";
				sqltest+=" and	(legalno is not null and trim(legalno)!='')  ";
			}
			 if(rds.equalsIgnoreCase("NO")){
					sqltest+=" and  (legalno is null or legalno='') ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',DATE_FORMAT(e.apprdate ,'%d-%m-%Y %H:%m') 'Appr Date',group_concat(cms.site, ' ') Site,m.grpcode 'Service Team',if((legalno is not null and trim(legalno)!=''), 'Submitted', 'Not Submitted') Status,cm.dtype 'Doc Type',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',cm.ref_type 'Ref Doc Type',cm.refdocno 'Ref No',"
				+ "cm.validfrom 'Start Date',cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value', round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join cm_srvcsited cms on cms.tr_no=cm.tr_no left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') "
				+ " left join cm_serteamm m on(cms.srvteamno=m.doc_no) left join (select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet group by doc_no,dtype ) e "
				+ " on(e.doc_no=cm.doc_no and e.dtype=cm.dtype and e.brhid=cm.brhid) "
				+ " where cm.status=3  and cm.jbaction in (0,4) and islegal=1 and cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" group by cm.doc_no ";
		
	//	System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);
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
	

}