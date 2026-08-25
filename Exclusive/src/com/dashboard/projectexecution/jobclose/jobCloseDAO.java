package com.dashboard.projectexecution.jobclose;

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

public class jobCloseDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cm=new ClsCommon();

	public  JSONArray loadGridData(String fromdate,String todate,String barchval,String rds,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
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
//System.out.println(rds);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			String sqldata="";
			if(rds.equalsIgnoreCase("TC")){
				sqldata="select cm.doc_no,cm.dtype,ac.refname client,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
						+ "cm.validupto edate,round(cm.contractval,2) cval,cs.site,round(cm.legalchrg,2) lfee,cm.tr_no from cm_srvcontrm cm "
						+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
						+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.jbaction!=2 "+sqltest+" group by cs.tr_no";
			}
			 if(rds.equalsIgnoreCase("CL")){
				 sqldata="select cm.doc_no,bl.rdtype dtype,bl.cldate,ac.refname client,coalesce(mc.cperson,' ') cperson, ac.per_mob mobno,"
				 		+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,cs.site,round(cm.legalchrg,2) lfee,cm.tr_no "
				 		+ "from gl_bjcl bl left join cm_srvcontrm cm on cm.tr_no=bl.rtrno left join my_crmcontact mc on cm.cpersonid=mc.row_no"
				 		+ " left join my_acbook ac on cm.cldocno=ac.cldocno  and ac.dtype='crm'  left join cm_srvcsited cs on cs.tr_no=cm.tr_no"
				 		+ " where bl.cldate between '"+sqlfromdate+"'  and '"+sqltodate+"'  "+sqltest+" group by cs.tr_no";
				}
		
		
//		System.out.println("sqldata===="+sqldata);
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
	
	public  JSONArray loadGridExcelExport(String fromdate,String todate,String barchval,String rds,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}

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
//System.out.println(rds);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			String sqldata="";
			if(rds.equalsIgnoreCase("TC")){
				
				sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',ac.per_mob 'Mobile No',"
						+ "cm.validfrom 'Start Date',cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value',cs.site 'Site',round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
						+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
						+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.jbaction!=2 "+sqltest+" group by cs.tr_no";
			}
			 if(rds.equalsIgnoreCase("CL")){
				 
				 sqldata="select cm.doc_no 'Doc No',bl.rdtype 'Doc Type',bl.cldate 'Closed Date',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',"
						+ "ac.per_mob 'Mobile No',cm.validfrom 'Start Date', cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value',cs.site 'Site',"
						+ "round(cm.legalchrg,2) 'Legal Fees' from gl_bjcl bl left join cm_srvcontrm cm on cm.tr_no=bl.rtrno left join my_crmcontact mc on "
						+ "cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno  and ac.dtype='crm'  left join cm_srvcsited cs on cs.tr_no=cm.tr_no"
				 		+ " where bl.cldate between '"+sqlfromdate+"'  and '"+sqltodate+"'  "+sqltest+" group by cs.tr_no";
				}
		
		
				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cm.convertToEXCEL(resultSet);

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
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String process,String barchval) throws SQLException {

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
//System.out.println(rds);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			if(process.equalsIgnoreCase("Close")){
				sqltest+=" and cm.jbaction!=2 ";
			}
			 if(process.equalsIgnoreCase("Hold")){
					sqltest+=" and cm.jbaction in(0,4) ";
				}
			 if(process.equalsIgnoreCase("Release")){
					sqltest+=" and cm.jbaction=1 ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',ac.per_mob 'Mobile No',cm.validfrom 'Start Date',"
				+ "cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value', cs.site 'Site',round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" group by cs.tr_no";
		
		//System.out.println(sqldata);
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
	
	

}