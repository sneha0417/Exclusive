package com.dashboard.analysis.amcexpirystatus;


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

public class amcExpiryStatusDAO {
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
				
		System.out.println(rds);
			if(rds.equalsIgnoreCase("UF")){
				sqltest+=" and cm.renstatus=0 ";
			}
			 if(rds.equalsIgnoreCase("RE")){
					sqltest+=" and  cm.renstatus=2 ";
				}
			 if(rds.equalsIgnoreCase("DE")){
					sqltest+=" and  cm.renstatus=1 ";
				}
				
		String sqldata="select sm.sal_name salman,cm.doc_no,cm.dtype,ac.refname client,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
				+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, round(cm.legalchrg,2) lfee,cm.renno amcno,sd.site,sd.siteadd from cm_srvcontrm cm "
				+ " left join cm_srvcsited sd on cm.tr_no=sd.tr_no left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno left join my_salm sm on ac.sal_id=sm.doc_no  where cm.dtype='AMC' and cm.validupto between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" ";
		
	//	System.out.println(sqldata);
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
			
			
			String sqldata="select count(*) val,'Under Follow-Up' stat,'UF' rds from cm_srvcontrm where dtype='AMC' and renstatus=0 "
					+ "and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+" "
					+ "union select count(*) val,'Renewed' stat,'RE' rds from cm_srvcontrm where dtype='AMC' and renstatus=2 "
					+ "and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
					+ "select count(*) val,'Declined' stat,'DE' rds from cm_srvcontrm where dtype='AMC' and renstatus=1 and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+"  ";
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
		String sqltest="",sqlquery="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
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
				
			if(rds.equalsIgnoreCase("UF")){
				sqltest+=" and cm.renstatus=0 ";
			}
			 if(rds.equalsIgnoreCase("RE")){
				 sqlquery=" ,cm.renno 'AMC No' ";
					sqltest+=" and  cm.renstatus=2 ";
				}
			 if(rds.equalsIgnoreCase("DE")){
					sqltest+=" and  cm.renstatus=1 ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type' "+sqlquery+" ,ac.refname 'Client',sm.sal_name 'Salesman',coalesce(mc.cperson,' ') 'Contact Person',sd.site 'Site' ,cm.ref_type 'Ref DType',cm.refno 'Ref No',"
				+ "cm.validfrom 'Start Date',cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value', round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
				+ " left join cm_srvcsited sd on cm.tr_no=sd.tr_no left join my_crmcontact mc on cm.cpersonid=mc.row_no "
				+ " left join my_acbook ac on cm.cldocno=ac.cldocno left join my_salm sm on ac.sal_id=sm.doc_no  where cm.validupto between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" ";
		
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