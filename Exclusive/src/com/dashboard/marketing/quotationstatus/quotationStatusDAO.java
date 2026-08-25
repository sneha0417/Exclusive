package com.dashboard.marketing.quotationstatus;


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

public class quotationStatusDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqlquery="";
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
				
			if(rds.equalsIgnoreCase("EN")){
			//	sqlquery+=" left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				sqltest+=" and cm.cntrtrno=0 and cm.quotstatus=0 ";
			}
			 if(rds.equalsIgnoreCase("AW")){
			//	 sqlquery+=" inner join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				 sqltest+=" and cm.cntrtrno!=0 and cm.quotstatus=0 ";
				}
				
			 if(rds.equalsIgnoreCase("DE")){
				// sqlquery+=" left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				 sqltest+=" and cm.quotstatus=1 ";
				}
		String sqldata="select si.site,cm.doc_no,cm.dtype,cm.date,ac.refname client,mc.cperson,cm.refno,if(cm.ref_type='DIR','DIR', "
				+ " convert(concat(cm.ref_type,' - ',if(cm.ref_type='ENQ',coalesce(eq.voc_no,''),coalesce(sv.doc_no,''))),char(100))) refdtype,s.sal_name, "
				+ " round(cm.amount,2) amount,round(cm.discount,2) discount,round(cm.tax,2) tax,round(cm.netamount,2) netamt  from cm_srvqotm cm "
				+ " left join (select tr_no,rowno,group_concat(site) site from cm_servsited group by tr_no) si on si.tr_no=cm.tr_no left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm'  "
				+ " left join my_salm s on cm.sal_id=s.doc_no left join gl_enqm eq on eq.doc_no=cm.refdocno and cm.ref_type='ENQ' "
				+ " left join my_srvdetm sv on sv.tr_no=cm.refdocno and cm.ref_type='SRVE'"  
				+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" ";
		
	//System.out.println("==qotk=="+sqldata);  
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
			//	System.out.println("=====RESULTDATA"+RESULTDATA);

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
		ResultSet resultSet=null,resultSetperc=null;
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
				sqltest+=" and cq.brhid="+barchval;
        	}
			int percount=0;	
			String sqlperc="select count(*) cnt from cm_srvqotm cq where cq.date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";
			resultSetperc = stmt.executeQuery (sqlperc);
			
			while(resultSetperc.next()){
				
				percount=resultSetperc.getInt("cnt");
			}
			String sqldata="select count(*) val,'Entered' stat,'EN' rds,round((count(*)/"+percount+")*100,2) perc from cm_srvqotm cq  "
					+ "where cntrtrno=0 and cq.date between '"+sdate+"' and '"+edate+"' and cq.quotstatus=0 "+sqltest+" union "
					+ "select count(*) val,'Awarded' stat,'AW' rds,round((count(*)/"+percount+")*100,2) perc from cm_srvqotm cq "
					+ "  where cntrtrno!=0 and cq.date between '"+sdate+"' and '"+edate+"' and cq.quotstatus=0 "+sqltest+" union "
					+ "select count(*) val,'Declined' stat,'DE' rds,round((count(*)/"+percount+")*100,2) perc from cm_srvqotm cq "
					+ " where cq.date between '"+sdate+"' and '"+edate+"' and cq.quotstatus=1 "+sqltest+" ";
			
		
		System.out.println("====qot status=="+sqldata);
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
				
			if(rds.equalsIgnoreCase("EN")){
			//	sqlquery+=" left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				sqltest+=" and cm.cntrtrno=0 and cm.quotstatus=0 ";
			}
			 if(rds.equalsIgnoreCase("AW")){
			//	 sqlquery+=" inner join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				 sqltest+=" and cm.cntrtrno!=0 and cm.quotstatus=0 ";
				}
				
			 if(rds.equalsIgnoreCase("DE")){
				// sqlquery+=" left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' ";
				 sqltest+=" and cm.quotstatus=1 ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',cm.date 'Date',ac.refname 'Client',si.site,mc.cperson 'Contact Person',cm.refno 'Ref No',if(cm.ref_type='DIR',cm.ref_type, "
				+ " convert(concat(cm.ref_type,' - ',if(cm.ref_type='ENQ',coalesce(eq.voc_no,''),coalesce(sv.doc_no,''))),char(100)))  'Ref Type',s.sal_name 'Salesman', "
				+ " round(cm.amount,2) 'Grand Total',cm.discount 'Discount',cm.tax 'Tax',round(cm.netamount,2) 'Net Amount' from cm_srvqotm cm left join (select tr_no,rowno,group_concat(site) site from cm_servsited group by tr_no) si on si.tr_no=cm.tr_no"
				+ " left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' "
				+ " left join gl_enqm eq on eq.doc_no=cm.refdocno and cm.ref_type='ENQ' left join my_salm s on cm.sal_id=s.doc_no "
				+ " left join my_srvdetm sv on sv.tr_no=cm.refdocno where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" ";
		
//	System.out.println("==k=="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);
			//	System.out.println("=====RESULTDATA"+RESULTDATA);

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