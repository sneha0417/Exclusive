package com.dashboard.marketing.surveyschedulerlist;

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
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClssurveyschedulerlistDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cm=new ClsCommon();
	
	public  JSONArray loadGridData(String fromdate, String todate,String salesmanid,String clientid,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
	
			java.sql.Date sqlfromdate = null;
	        java.sql.Date sqltodate = null;
	        
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	        	sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     	}
	        
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     	}

	  	    if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	  	         sqltest+=" and e.cldocno="+clientid+" ";
	  	    }
	  	        
	  	    if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0")) {
	  	    	sqltest+="";
	  	    } else {
	  	    	sqltest+=" and e.brhid="+barchval;
	  	    }
	  	    
	  	    if(!(salesmanid.equalsIgnoreCase("undefined"))&&!(salesmanid.equalsIgnoreCase(""))&&!(salesmanid.equalsIgnoreCase("0"))&&!(salesmanid.equalsIgnoreCase("a"))) {
	  	        	 sqltest+=" and  ms.doc_no="+salesmanid+" ";
	  	    } else {
	  	     
	  	    }
				
	  	    String sqldata="select e.voc_no,e.brhid, e.doc_no,bq.tr_no schtrno, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,"
            
     				+ "	ce.txtname source,m.grpcode groups,em.name grpmem,gr.groupname asgmeth,bq.plannedon,bq.pltime,bq.description,bq.empgroupid, bq.empid,"
            		
     				+ " bq.asgnMode,md.doc_no as teampid,'VIEW' as view,mu.func path  from gl_enqm e  "
            		
     				+ "  left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) "
            		
     				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=bq.asgnmode and gr.grptype='assignmode') left join  cm_enqsource ce on ce.doc_no=e.sourceid "
            		
     				+ "left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id left join my_menu mu on mu.doc_type='enq' "
            		
     				+ "	 where e.status=3 and e.enqstatus=0 and e.DATE>='"+sqlfromdate+"' and e.DATE<='"+sqltodate+"'  "+sqltest+" group by e.doc_no ";
		
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);

		} catch(Exception e){
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public  JSONArray loadGridExcel(String fromdate, String todate,String salesmanid,String clientid,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
	
			java.sql.Date sqlfromdate = null;
	        java.sql.Date sqltodate = null;
	        
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	        	sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     	}
	        
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     	}

	  	    if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	  	         sqltest+=" and e.cldocno="+clientid+" ";
	  	    }
	  	        
	  	    if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0")) {
	  	    	sqltest+="";
	  	    } else {
	  	    	sqltest+=" and e.brhid="+barchval;
	  	    }
	  	    
	  	    if(!(salesmanid.equalsIgnoreCase("undefined"))&&!(salesmanid.equalsIgnoreCase(""))&&!(salesmanid.equalsIgnoreCase("0"))&&!(salesmanid.equalsIgnoreCase("a"))) {
	  	        	 sqltest+=" and  ms.doc_no="+salesmanid+" ";
	  	    } else {
	  	     
	  	    }
				
	  	    String sqldata="select e.doc_no 'Doc No', e.date 'Date', e.name 'Client',m.grpcode 'Assign group', em.name 'Group member',gr.groupname 'Assign method',bq.plannedon 'Planned date',"
	  	    		
	  	    		+ "bq.pltime 'Planned time',bq.description ' Description', e.mob 'Mobile no ', e.remarks 'Remarks',ce.txtname 'Source',ms.sal_name 'Salesman' from gl_enqm e  "
            		
     				+ "left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) "
            		
     				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=bq.asgnmode and gr.grptype='assignmode') left join  cm_enqsource ce on ce.doc_no=e.sourceid "
            		
     				+ "left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id left join my_menu mu on mu.doc_type='enq' "
            		
     				+ "where e.status=3 and e.enqstatus=0 and e.DATE>='"+sqlfromdate+"' and e.DATE<='"+sqltodate+"'  "+sqltest+" group by e.doc_no ";
		
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);

		} catch(Exception e){
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
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
			conn =  ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

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