package com.dashboard.project.proformainvfollowup;


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

public class proformaInvFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String uptodate,String barchval,String chkfollowup,String followupdate) throws SQLException {

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
			 java.sql.Date sqlFollowUpDate = null;
	     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
	     	{
	     		sqluptodate=cmn.changeStringtoSqlDate(uptodate);
	     		
	     	}
	     	if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
				sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
			}
			
			if(sqluptodate!=null){

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
				
				
		String sqldata="select cm.doc_no,pd.amount invval,pd.description,cm.dtype,ac.refname client,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
				+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, round(cm.legalchrg,2) lfee,cm.brhid brch,cm.tr_no,bv.fdate from cm_srvcontrm cm "
				+ " left join my_crmcontact mc on cm.cpersonid=mc.row_no "
				+ " left join cm_srvcontrpd pd on cm.tr_no=pd.tr_no "
				+ " left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='CRM'"
				+ " left join (select max(doc_no) doc_no,rdocno from gl_bpif where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
				+ " left join gl_bpif bv on sub.doc_no = bv.doc_no "
				+ "where cm.jbaction in (0,4) and cm.date<='"+sqluptodate+"' and pstatus= 1 and pinvno!=0 and pd.dueafser=98 "+sqltest+" "+sql2+" order by bv.fdate DESC ";
		
		//System.out.println("==kkp=="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	
	public  JSONArray loadSubGridData(String trno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bpif m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=203 and m.status=3 group by m.doc_no order by m.fdate desc";
		
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
	
	public  JSONArray loadGridExcel(String uptodate,String barchval,String chkfollowup,String followupdate) throws SQLException {

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
			 java.sql.Date sqlFollowUpDate = null;
	     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
	     	{
	     		sqluptodate=cmn.changeStringtoSqlDate(uptodate);
	     		
	     	}
	     	if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
				sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
			}
			
			if(sqluptodate!=null){

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
				
				
		String sqldata="select cm.doc_no,pd.amount invval,pd.description,cm.dtype,ac.refname client,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
				+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval, round(cm.legalchrg,2) lfee,cm.brhid brch,cm.tr_no,bv.fdate from cm_srvcontrm cm "
				+ " left join my_crmcontact mc on cm.cpersonid=mc.row_no "
				+ " left join cm_srvcontrpd pd on cm.tr_no=pd.tr_no "
				+ " left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' "
				+ " left join (select max(doc_no) doc_no,rdocno from gl_bpif where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
				+ " left join gl_bpif bv on sub.doc_no = bv.doc_no "
				+ "where cm.jbaction in (0,4) and  cm.date<='"+sqluptodate+"' and pstatus= 1 and pinvno!=0 and pd.dueafser=98 "+sqltest+" "+sql2+" order by bv.fdate DESC ";
		
		//System.out.println("==kkp=="+sqldata);
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