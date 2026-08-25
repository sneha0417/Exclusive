package com.dashboard.marketing.quotationfollowup;


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

public class quotationFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public JSONArray qotlistsearch(String brnchval,String fromdate,String todate,String chkfollowup,String followupdate,String salid) throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	        
	     Connection conn = null;
	         	
	    		Statement stmtVeh =null;
	    		ResultSet resultSet=null;
	         	String sqltest="";
	            java.sql.Date sqlfromdate = null;
	            java.sql.Date sqlFollowUpDate = null;
	           
	            try {
	            	 conn = ClsConnection.getMyConnection();
	    			 stmtVeh = conn.createStatement ();
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
	         	if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
	    			sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
	    		}
	    		
	    		if(sqlfromdate!=null && sqltodate!=null){

	    			String sql2 = "";
	    		
	    		if(chkfollowup.equalsIgnoreCase("1")){
	    			if(!(sqlFollowUpDate==null)){
	    	        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
	    			}
	    		}
	    		
	          
	           	
	           	if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
	        	{
	    			sqltest+="";
	        	}
	    		else
	    		{
	    			sqltest+=" and cm.brhid="+brnchval;
	    		}
	         	if(!(salid.equalsIgnoreCase("undefined")) && !(salid.equalsIgnoreCase("")) && !(salid.equalsIgnoreCase("0")))
		        	{
		        		sqltest+=" and cm.sal_id="+salid;
		        	}
	           	
	           	
	          
				
           		String sql="select cm.doc_no,me.menu_name as name,me.func path,cm.dtype,'View' as contr,cm.date,ac.refname client,mc.cperson,cm.refno,cm.ref_type refdtype,"
           				+ "round(cm.amount,2) amount,round(cm.discount,2) discount,round(cm.tax,2) tax,round(cm.netamount,2) netamt,cm.tr_no,cm.brhid brch,bv.fdate,sm.sal_name as salman  from cm_srvqotm cm "
           				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno AND AC.DTYPE='CRM' left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' "
           				+ " left join (select max(doc_no) doc_no,rdocno from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
           				+ " left join gl_bqot bv on sub.doc_no = bv.doc_no left join my_menu me on(me.doc_type=cm.dtype) left join my_salm sm on(sm.doc_no=cm.sal_id)"
           				+ "where cs.reftrno is null and cm.quotstatus=0 and cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+"  "+sql2+" order by bv.fdate DESC ";
        System.out.println("--==qotlistsearch--"+sql);
           		resultSet = stmtVeh.executeQuery(sql);
           		 RESULTDATA=cmn.convertToJSON(resultSet);
	    		}
	    		stmtVeh.close();
				conn.close();
    			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
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
		 	
		
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=88 and m.status=3 group by m.doc_no order by m.fdate desc";
		
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
	
	public JSONArray quotlistExcel(String brnchval,String fromdate,String todate,String chkfollowup,String followupdate,String salid) throws SQLException {


	     JSONArray RESULTDATA=new JSONArray();
	        
	     Connection conn = null;
	         	
	    		Statement stmtVeh =null;
	    		ResultSet resultSet=null;
	         	String sqltest="";
	            java.sql.Date sqlfromdate = null;
	            java.sql.Date sqlFollowUpDate = null;
	           
	            try {
	            	 conn = ClsConnection.getMyConnection();
	    			 stmtVeh = conn.createStatement ();
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
	         	if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
	    			sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
	    		}
	    		
	    		if(sqlfromdate!=null && sqltodate!=null){

	    			String sql2 = "";
	    		
	    		if(chkfollowup.equalsIgnoreCase("1")){
	    			if(!(sqlFollowUpDate==null)){
	    	        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
	    			}
	    		}
	    		
	          
	           	
	           	if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
	        	{
	    			sqltest+="";
	        	}
	    		else
	    		{
	    			sqltest+=" and cm.brhid="+brnchval;
	    		}
	           	
	           	if(!(salid.equalsIgnoreCase("undefined")) && !(salid.equalsIgnoreCase("")) && !(salid.equalsIgnoreCase("0")))
	        	{
	        		sqltest+=" and cm.sal_id="+salid;
	        	}
				
				
           		String sql="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',cm.date 'Date',ac.refname 'Client',mc.cperson 'Contact Person',cm.refno 'Ref No',cm.ref_type 'Ref Type',"
           				+ "round(cm.amount,2) 'Amount',round(cm.discount,2) 'Discount',round(cm.tax,2) 'Tax',round(cm.netamount,2) 'Net Amount',bv.fdate 'Followup Date',sm.sal_name as 'SalesMan'  from cm_srvqotm cm "
           				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' "
           				+ " left join (select  max(doc_no)doc_no,rdocno from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
           				+ " left join gl_bqot bv on sub.doc_no = bv.doc_no left join my_salm sm on(sm.doc_no=cm.sal_id) "
           				+ "where cs.reftrno is null and cm.quotstatus=0 and cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" "+sql2+" order by bv.fdate DESC ";
      //  System.out.println("--==enq--"+sql);
           		resultSet = stmtVeh.executeQuery(sql);
           		 RESULTDATA=cmn.convertToEXCEL(resultSet);
	    		}
	    		stmtVeh.close();
				conn.close();
    		
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }
	
	public JSONArray latestquotlistExcel(String brnchval,String fromdate,String todate,String chkfollowup,String followupdate,String salid) throws SQLException {


	     JSONArray RESULTDATA=new JSONArray();
	        
	     Connection conn = null;
	         	
	    		Statement stmtVeh =null;
	    		ResultSet resultSet=null;
	         	String sqltest="";
	            java.sql.Date sqlfromdate = null;
	            java.sql.Date sqlFollowUpDate = null;
	           
	            try {
	            	 conn = ClsConnection.getMyConnection();
	    			 stmtVeh = conn.createStatement ();
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
	         	if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
	    			sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
	    		}
	    		
	    		if(sqlfromdate!=null && sqltodate!=null){

	    			String sql2 = "";
	    		
	    		if(chkfollowup.equalsIgnoreCase("1")){
	    			if(!(sqlFollowUpDate==null)){
	    	        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
	    			}
	    		}
	    		
	          
	           	
	           	if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
	        	{
	    			sqltest+="";
	        	}
	    		else
	    		{
	    			sqltest+=" and cm.brhid="+brnchval;
	    		}
	           	
	           	if(!(salid.equalsIgnoreCase("undefined")) && !(salid.equalsIgnoreCase("")) && !(salid.equalsIgnoreCase("0")))
	        	{
	        		sqltest+=" and cm.sal_id="+salid;
	        	}
				
				
          		String sql="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',cm.date 'Date',ac.refname 'Client',mc.cperson 'Contact Person',cm.refno 'Ref No',cm.ref_type 'Ref Type',"
          				+ "round(cm.amount,2) 'Amount',round(cm.discount,2) 'Discount',round(cm.tax,2) 'Tax',round(cm.netamount,2) 'Net Amount',sub.date 'FDate',u.user_id 'User',sub.fdate 'Followup Date',sub.remarks 'Followup Remarks',sm.sal_name as 'SalesMan'  from cm_srvqotm cm "
          				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcontrm cs on cs.reftrno=cm.tr_no and cs.ref_type='SQOT' "
          				+ " left join gl_bqot sub on(sub.rdocno=cm.tr_no) "
          				+ "  left join my_salm sm on(sm.doc_no=cm.sal_id) " 
          				+ "  left join my_user u on u.doc_no=sub.userid "
          				+ "where cs.reftrno is null and cm.quotstatus=0 and cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" "+sql2+" order by sub.date DESC ";
       //System.out.println("--==enq--"+sql);
          		resultSet = stmtVeh.executeQuery(sql);
          		 RESULTDATA=cmn.convertToEXCEL(resultSet);
	    		}
	    		stmtVeh.close();
				conn.close();
   		
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
      return RESULTDATA;
  }
	
	public  JSONArray SalesgentSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String salsql="select doc_no,sal_name from my_salm where  status<>7 ";

			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=cmn.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


}