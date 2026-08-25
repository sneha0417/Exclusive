package com.dashboard.project.projectlist;

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

public class projectlistDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String zoneid) throws SQLException {

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
			
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+=" and cm.tr_no="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(!(zoneid.equalsIgnoreCase("")) && !(zoneid.equalsIgnoreCase("0"))){
	       		sqltest+=" and mm.doc_no="+zoneid+" ";
	       	}
			
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select case when cm.jbaction='0' then 'Open' when cm.jbaction='1' then 'Hold'  when   cm.jbaction='2' then 'Closed' when   cm.jbaction='3' then 'Completed' when  cm.jbaction='4' then 'Started' else '' end as Status,"
				+ "cm.doc_no,sm.sal_name,mm.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
				+ "cm.validupto edate,round(cm.contractval,2) cval, convert(group_concat(cs.site),char(200)) site,round(cm.legalchrg,2) lfee from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		 
		//System.out.println("******++******"+sqldata);
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
	
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String zoneid) throws SQLException {

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
			
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+=" and cm.tr_no="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(!(zoneid.equalsIgnoreCase("")) && !(zoneid.equalsIgnoreCase("0"))){
	       		sqltest+=" and mm.doc_no="+zoneid+" ";
	       	}
			
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname Client,mm.grpcode 'Assign Group',case when cm.jbaction='0' then 'Open' when cm.jbaction='1' then 'Hold'  when   cm.jbaction='2' then 'Closed' when   cm.jbaction='3' then 'Completed' when  cm.jbaction='4' then 'Started' else '' end as Status,"
				+ "coalesce(mc.cperson,' ') 'Contact Person',sm.sal_name 'Sales Person',cm.ref_type refert,cm.refdocno referno,ac.per_mob 'Mobile No',cm.validfrom 'Start Date',"
				+ "cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value',round(cm.legalchrg,2) 'Legal Fees', convert(group_concat(cs.site),char(200)) Site from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		
		//System.out.println("************"+sqldata);
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

	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.cldocno doc_no,t.account,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ " where a.dtype='crm' and a.status<>7  "+sql;
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=cm.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray zoneDetails(String partyname) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				
	            if(!(partyname.equalsIgnoreCase("") || (partyname.equalsIgnoreCase("0")))){
	             sql=sql+" where  mm.grpcode like '%"+partyname+"%'";
	            }
	           
	            
				sql = "select grpcode,doc_no  from cm_serteamm where status=3 "
						+ "   "+sql;
				System.out.println(sql);
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=cm.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	public   JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {

		System.out.println("thdjdtyjyt"+contractno);
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
		  String sql11="";


		  java.sql.Date sqlStartDate=null;

		  /*select count(*) as count,if(m.status=1,'HOLD',if(m.status=2,'CLOSED',if(m.status=3,'COMPLETED',if(m.status=4,'STARTED','ENTERED')))) as statuss,status from cm_servplan m group by status;*/

		  //enqdate.trim();


		  String sqltest="";

		  
		  if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined") || dtype.equals("ALL"))){
		   sql11=sql11+" and cm.dtype='"+dtype+"'";
		  }

		  
		  if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
		   sql11=sql11+" and cm.doc_no='"+contractno+"'";
		  }
		  

		  Connection conn = null;

		  try {
		   conn = ClsConnection.getMyConnection();
		   Statement stmtenq1 = conn.createStatement ();

		   String clssql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 "
		     + " and 1=1 "+sql11+" order by doc_no";

		   System.out.println("===clssql====="+clssql);

		   ResultSet resultSet = stmtenq1.executeQuery(clssql);

		   RESULTDATA=cm.convertToJSON(resultSet);
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