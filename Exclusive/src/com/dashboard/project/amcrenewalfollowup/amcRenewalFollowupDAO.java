package com.dashboard.project.amcrenewalfollowup;


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

public class amcRenewalFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String uptodate,String chkfollowup,String followupdate,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		java.sql.Date sqlUpToDate = null;
        java.sql.Date sqlFollowUpDate = null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
				sqlUpToDate = cmn.changeStringtoSqlDate(uptodate);
			}
    
			if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
				sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
			}
			
			if(sqlUpToDate!=null){

				String sql2 = "";
			
			if(chkfollowup.equalsIgnoreCase("1")){
				if(!(sqlFollowUpDate==null)){
		        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
				}
			}
			
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
				
				
		String sqldata="select cm.doc_no,cm.dtype,cm.cpersonid,ac.refname client,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
				+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,"
				+ " round(cm.legalchrg,2) lfee,cm.brhid brch,cm.tr_no,cm.cldocno,bv.fdate,sd.site,sd.siteadd from cm_srvcontrm cm "
				+ " left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno AND AC.DTYPE='CRM'"
				+ " left join (select max(doc_no) doc_no,rdocno from gl_barf where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
				+ " left join gl_barf bv on sub.doc_no = bv.doc_no left join cm_srvcsited sd on cm.tr_no=sd.tr_no  "
				+ " where renstatus=0 and cm.dtype='AMC' and  cm.validupto <= '"+sqlUpToDate+"' "+sqltest+" "+sql2+" order by bv.fdate DESC ";
		
			
			/*String sqldata="select cm.doc_no,cm.dtype,ac.refname client,coalesce(cm.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
					+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,"
					+ " round(cm.legalchrg,2) lfee,cm.brhid brch,cm.tr_no,cm.cldocno from cm_srvcontrm cm "
					+ " left join my_acbook ac on cm.cldocno=ac.cldocno"
					+ " where renstatus=0 and  cm.validupto <= '"+sqlUpToDate+"' "+sqltest+" LIMIT 1000 ";
			
			*/
		System.out.println("=amcf==="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
				//	System.out.println("=====RESULTDATA"+RESULTDATA);
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
	
	public  JSONArray loadSubGridData(String trno,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		 	
		
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_barf m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=202 and m.status=3 group by m.doc_no order by m.fdate desc";
		
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
	
	 public JSONArray amcdetails(String doc,String cldoc) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select doc_no docno,refno,validfrom sdate,validupto edate from cm_srvcontrm where doc_no>"+doc+" and cldocno="+cldoc+" order by doc_no";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=cmn.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	 
	 public  JSONArray loadGridExcel(String uptodate,String chkfollowup,String followupdate,String barchval) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			String sqltest="";
			java.sql.Date sqlUpToDate = null;
	        java.sql.Date sqlFollowUpDate = null;
			try {

				//System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = cmn.changeStringtoSqlDate(uptodate);
				}
	    
				if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
					sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
				}
				
				if(sqlUpToDate!=null){

			    String sql2 = "";
				
				if(chkfollowup.equalsIgnoreCase("1")){
					if(!(sqlFollowUpDate==null)){
			        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
					}
				}
			

				if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
	        	{
					sqltest+="";
	        	}
				else
				{
					sqltest+=" and cm.brhid="+barchval;
				}
					
					
			String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',sd.site 'Site',cm.ref_type 'Ref DType',cm.refno 'Ref No',"
					+ " cm.validfrom 'Start Date',cm.validupto 'End Date',"
					+ "round(cm.contractval,2) 'Contract Value', round(cm.legalchrg,2) 'Legal Fees',bv.fdate 'Followup Date' from cm_srvcontrm cm "
					+ " left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno AND AC.DTYPE='CRM'"
					+ " left join (select max(doc_no) doc_no,rdocno from gl_barf where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
				+ " left join gl_barf bv on sub.doc_no = bv.doc_no left join cm_srvcsited sd on cm.tr_no=sd.tr_no where renstatus=0 and cm.dtype='AMC' and  cm.validupto<= '"+sqlUpToDate+"' "+sqltest+" "+sql2+" order by bv.fdate DESC ";
			
			/*	String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname 'Client',coalesce(cm.cperson,' ') 'Contact Person',cm.ref_type 'Ref DType',cm.refno 'Ref No',"
						+ " cm.validfrom 'Start Date',cm.validupto 'End Date',"
						+ "round(cm.contractval,2) 'Contract Value', round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
						+ " left join my_acbook ac on cm.cldocno=ac.cldocno "
						+ " where renstatus=0 and  cm.validupto<= '"+sqlUpToDate+"' "+sqltest+" LIMIT";*/
				
		//	System.out.println(sqldata);
					resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cmn.convertToEXCEL(resultSet);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);
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

}