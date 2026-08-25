package com.dashboard.leadmanagement.leadmngmntfollwup;
 
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

public class ClsLeadMngmntFollwUpDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String barchval,String chkfollowup,String followupdate,String fromdate,String todate,String salesmanid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
        java.sql.Date sqlFollowUpDate = null;
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        System.out.println("barchval="+barchval+"followupdate="+followupdate+"fromdate=-"+fromdate+"todate"+todate);
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			if((!(salesmanid.equalsIgnoreCase("0")))&&(!(salesmanid.equalsIgnoreCase("a")))){
				sqltest+= " and m.sal_id="+salesmanid+" ";
			}
			if(chkfollowup.equalsIgnoreCase("1")){
						if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
								sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
						}
						if(!(sqlFollowUpDate==null)){
							sqltest+=" and bv.fdate<='"+sqlFollowUpDate+"' ";
						}
						
			}			
			else{
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
					if((!(sqlfromdate==null))&&(!(sqltodate==null))){
						sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
					}
			}	
				
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and m.brhid="+barchval;
			}
		
			String sqldata="select m.brhid brhid,m.userid userid,bv.fdate,s.sal_name salesman,m.tr_no,m.DOC_NO,m.name,m.mob mob_no,m.tel tel_no,m.email,m.DATE,m.description desc1 "
					+ ",if(m.priorstatus=1,'Cold',if(m.priorstatus=2,'Warm','Hot')) leadstatus,'VIEW' view,me.menu_name as menuname,"
					+ "me.func path,m.dtype from cm_prosclientm m left join my_salm s on m.sal_id=s.doc_no "
					+ "left join (select max(doc_no) doc_no,trdocno from gl_blmf where status=3 group by trdocno) sub on(sub.trdocno=m.tr_no) "
					+ " left join gl_blmf bv on sub.doc_no = bv.doc_no left join my_menu me on(me.doc_type=m.dtype) "
					+ " where m.status=3 and m.clientacid=0 "+sqltest+"  order by bv.fdate DESC ";
			System.out.println("=amcf==="+sqldata+"end");
					
		
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
	
	
public JSONArray salesmanDetailsSearch() throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtcalledby = conn.createStatement();
	
		     //   if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		        sql="select  coalesce(sal_name,'') salname,coalesce(mob_no,'') mob,doc_no from my_salm where status=3 ";
		        System.out.println("salesman sql===="+sql);
		       ResultSet resultSet = stmtcalledby.executeQuery(sql);
		       RESULTDATA=cmn.convertToJSON(resultSet);
	           
		       stmtcalledby.close();
		       conn.close();
		     //  }
		       stmtcalledby.close();
		     conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	  }
	
	public  JSONArray loadSubGridData(String trdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();   
		 	
		
				
			String sqldata = "select m.date detdate,u.user_id user,m.fdate fdate,remarks remk from "
					+ " gl_blmf m left join  my_user u on u.doc_no=m.userid where m.trdocno="+trdocno+" and m.status=3;";
		
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
	
	 
	 public  JSONArray loadGridExcel(String barchval,String chkfollowup,String followupdate,String fromdate,String todate,String salesmanid) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			String sqltest="";
	        java.sql.Date sqlFollowUpDate = null;
	        java.sql.Date sqlfromdate = null;
	        java.sql.Date sqltodate = null;
	        System.out.println("barchval="+barchval+"followupdate="+followupdate+"fromdate=-"+fromdate+"todate"+todate);
			try {

				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				if((!(salesmanid.equalsIgnoreCase("0")))&&(!(salesmanid.equalsIgnoreCase("a")))){
					sqltest+= " and m.sal_id="+salesmanid+" ";
				}
				if(chkfollowup.equalsIgnoreCase("1")){
							if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
									sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
							}
							if(!(sqlFollowUpDate==null)){
								sqltest+=" and bv.fdate<='"+sqlFollowUpDate+"' ";
							}
							
				}			
				else{
						if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
							sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
						}
						if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
							sqltodate = cmn.changeStringtoSqlDate(todate);
						}
						if((!(sqlfromdate==null))&&(!(sqltodate==null))){
							sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
						}
				}	
					
				if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
	        	{
					sqltest+="";
	        	}
				else
				{
					sqltest+=" and m.brhid="+barchval;
				}
			/*String sqldata="select m.brhid brhid,m.userid userid,b.fdate,s.sal_name salesman,m.tr_no,m.DOC_NO,m.name,m.mob mob_no,m.email,m.DATE,m.description desc1 "
					+ "from cm_prosclientm m left join my_salm s on m.sal_id=s.doc_no left join gl_blmf b on b.trdocno=m.tr_no "
					+ "where 1=1 " +sqltest;
			System.out.println("=amcf==="+sqldata);*/
				String sqldata="select m.DOC_NO 'DOC NO',m.name NAME,m.mob 'MOB NO',m.email 'E-mail',m.DATE,m.description 'DESCRIPTION',s.sal_name 'SALES MAN',bv.fdate 'FOLLOW UP DATE' "
						+ "from cm_prosclientm m left join my_salm s on m.sal_id=s.doc_no left join (select max(doc_no) doc_no,trdocno from gl_blmf where status=3 group by trdocno) sub on(sub.trdocno=m.tr_no) "
						+ " left join gl_blmf bv on sub.doc_no = bv.doc_no "
						+ " where 1=1 "+sqltest+"  order by bv.fdate DESC ";
				System.out.println("=amcfexcel==="+sqldata);
						/*+ " left join (select max(doc_no) doc_no,rdocno from gl_barf where status=3 group by rdocno) sub on(sub.rdocno=cm.tr_no) "
						+ " left join gl_barf bv on sub.doc_no = bv.doc_no "
						+ " where renstatus=0 and  cm.validupto <= '"+sqlUpToDate+"' "+sqltest+" "+sql2+" order by bv.fdate DESC ";
				*/
				/*String sqldata="select cm.doc_no,cm.dtype,ac.refname client,coalesce(cm.cperson,' ') cperson,cm.ref_type refdtype,cm.refno,"
						+ "cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,"
						+ " round(cm.legalchrg,2) lfee,cm.brhid brch,cm.tr_no,cm.cldocno from cm_srvcontrm cm "
						+ " left join my_acbook ac on cm.cldocno=ac.cldocno"
						+ " where renstatus=0 and  cm.validupto <= '"+sqlUpToDate+"' "+sqltest+" LIMIT 1000 ";
				
				*/
			
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
	 
	 
}