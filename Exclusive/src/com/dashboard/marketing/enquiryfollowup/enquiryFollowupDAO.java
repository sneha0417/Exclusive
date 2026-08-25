package com.dashboard.marketing.enquiryfollowup;


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
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class enquiryFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	 public JSONArray enquirylistsearch(String brnchval,String chkfollowup,String followupdate,String fromdate,String todate,String areaid,String salesmanid) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	 Connection conn = null;
	      
	  Statement stmtVeh =null;
	  ResultSet resultSet=null;
	      String sqltest="",sqlsalman="";
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
	  
	  if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
	         sqltest+=" and ma.area_id="+areaid+" ";
	        }
	     
	        
	        if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
	     {
	   sqltest+="";
	     }
	  else
	  {
	   sqltest+=" and e.brhid="+brnchval;
	  }
	        if(!(salesmanid.equalsIgnoreCase("undefined"))&&!(salesmanid.equalsIgnoreCase(""))&&!(salesmanid.equalsIgnoreCase("0"))&&!(salesmanid.equalsIgnoreCase("a")))
	      {
	         sqlsalman+=" and  ms.doc_no="+salesmanid+" ";
	       
	      }
	      else{
	     
	      }
	        
	              String sql="select e.voc_no,e.brhid brch, e.doc_no, e.date, e.remarks, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,"
	                + " ce.txtname source,e.enqstatus enqstat,bv.fdate,'VIEW' as view,e.com_add1 addr,e.telno,e.email,e.sourceid,"
	                + "e.sjobtype,e.contrmode,e.enqtype,e.cldocno,e.cpersonid,e.cperson,st.site "
	                + " from gl_enqm e    "
	                + "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id"
	                + " left join (select rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no"
	                + " left join (select max(doc_no) doc_no,rdocno from gl_benq where status=3 group by rdocno) sub on(sub.rdocno=e.doc_no) "
	                + " left join gl_benq bv on sub.doc_no = bv.doc_no  "
	                
	                + "  where e.status=3 and enqstatus=0  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  "+sql2+" "+sqlsalman+" order by bv.fdate DESC ";
	         
	              //System.out.println("--==enqfolwp--"+sql);
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
		 	
		
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_benq m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=87 and m.status=3 group by m.doc_no order by m.fdate desc";
		
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
	
	public JSONArray enquirylistExcel(String brnchval,String chkfollowup,String followupdate,String fromdate,String todate,String areaid,String salesmanid) throws SQLException {

		   JSONArray RESULTDATA=new JSONArray();
		         
		         
		       String sqltest="",sqlsalman="";
		         java.sql.Date sqlfromdate = null;
		         java.sql.Date sqlFollowUpDate = null;
		         Connection conn = null;
		       
		   Statement stmtVeh =null;
		   ResultSet resultSet=null;
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
		   
		   if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
		          sqltest+=" and ma.area_id="+areaid+" ";
		         }
		         
		         if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
		      {
		    sqltest+="";
		      }
		   else
		   {
		    sqltest+=" and e.brhid="+brnchval;
		   }
		       
		         if(!(salesmanid.equalsIgnoreCase("undefined"))&&!(salesmanid.equalsIgnoreCase(""))&&!(salesmanid.equalsIgnoreCase("0"))&&!(salesmanid.equalsIgnoreCase("a")))
		       {
		          sqlsalman+=" and  ms.doc_no="+salesmanid+" ";
		        
		       }
		       else{
		      
		       }
		   
		     
		    
		              String sql="select e.voc_no 'Doc No', e.date 'Date', e.remarks 'Remarks', e.name 'Client',ms.sal_name 'Salesman', e.mob 'Mobile', if(e.enqtype=0,'General','Client') 'Type',"
		                + " ce.txtname 'Source',st.site 'Site',bv.fdate 'Followu Date' from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no   "
		                + "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id "
		                + "left join (select rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no"
		                + " left join (select max(doc_no) doc_no,rdocno from gl_benq where status=3 group by rdocno) sub on(sub.rdocno=e.doc_no) "
		                + " left join gl_benq bv on sub.doc_no = bv.doc_no "
		                + "  where e.status=3 and enqstatus=0  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  "+sql2+" "+sqlsalman+"order by bv.fdate DESC ";
		       //   System.out.println("--==enqstat--"+sql);
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
	
	 public   JSONArray areaSearch(HttpSession session) throws SQLException
		{

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


			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				//String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
				System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=cmn.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				resultSet.close();
				stmt.close();
				conn.close();


			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}


}