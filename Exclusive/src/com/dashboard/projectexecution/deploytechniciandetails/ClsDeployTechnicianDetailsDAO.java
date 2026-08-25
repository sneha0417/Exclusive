package com.dashboard.projectexecution.deploytechniciandetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianBean;

public class ClsDeployTechnicianDetailsDAO {

	ClsConnection ClsConnection= new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray empSubGridLoading(String empid,String id) throws SQLException {
	       
		 JSONArray RESULTDATA=new JSONArray();
	  	  if(!(id.equalsIgnoreCase("1"))) {
	  		  return RESULTDATA;
	  	  }
	         Connection conn = null; 
	       
	      try { 
	    	  
	         conn = ClsConnection.getMyConnection();
	         ClsCommon ClsCommon=new ClsCommon();
	         Statement stmtmain = conn.createStatement();
	            String sql="",sql1="";
	          
	         if(!(empid.equals("0") || empid.equals("") || empid.equals("undefined"))){
	        	 sql1+=" and mm.empid ="+empid+" ";
				}
	     
	         sql="select p.date,p.dtype jobtype,p.refdocno jobno,s.site,ac.refname client,mm.intime frmtime,mm.outtime totime,mm.normAL hrs,"
	                 +" mm.COSTPERHOUR rate,mm.normAL*mm.COSTPERHOUR  val from cm_srvcontrm m left join cm_servplan p on(m.tr_no=p.doc_no and m.dtype=p.dtype)"
	                 +" left join cm_srvcsited s on p.siteid=s.rowno left join hr_timesheethrs mm on mm.costcode=p.refdocno"
	                 +" left join my_acbook ac on (m.cldocno=ac.doc_no and ac.dtype='CRM')"
	                 +" where p.status=4  "+sql1+" ";
		         
	        // System.out.println("*********emp2***********"+sql);
	         ResultSet resultSet = stmtmain.executeQuery(sql);  
	         RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            
	       stmtmain.close();
	       conn.close();                          
	      } catch(Exception e){
	        e.printStackTrace(); 
	        conn.close();
	      } finally{
	    conn.close();
	   }
	        return RESULTDATA;   
  }
	public JSONArray assignfrm(HttpSession session) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "";
			sql="select grpcode,doc_no  from cm_serteamm where status=3";
			//			System.out.println("===sql===="+sql);
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray empMainGridLoading(String sergroupid,String fromdate,String todate,String id) throws SQLException {
	       
		 JSONArray RESULTDATA=new JSONArray();
	  	  if(!(id.equalsIgnoreCase("1"))) {
	  		  return RESULTDATA;
	  	  }
	         Connection conn = null; 
	       
	      try { 
	    	  
	         conn = ClsConnection.getMyConnection();
	         ClsCommon ClsCommon=new ClsCommon();
	         Statement stmtmain = conn.createStatement();
	         java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
	         String sql="",sql1="";
	         String sqltest="";
	         
	         
	         if(!(sergroupid.equals("0") || sergroupid.equals("") || sergroupid.equals("undefined"))){
	        	 sqltest+=" and d.rdocno in ("+sergroupid+")";
				}
	      	if(!(sqlFromDate==null)){
	        	sql1+=" m.date>='"+sqlFromDate+"'";
		    }
			
			if(!(sqlToDate==null)){
	        	sql1+=" and m.date<='"+sqlToDate+"'";
		    }
	      	   
	      sql =" select m.codeno empid,m.doc_no,mm.grpcode steam,m.name,CONVERT(if(round(sum(ts.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(ts.normal)*60))=8,"
	        		+" SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,6))),CHAR(100)) tothr,"
	        		 +" sum(ts.normal) normalhrs,(round((sum(ts.normal)*ts.costperhour),2)/sum(ts.normal)) avgrate,"
	        		 +" round((sum(ts.normal)*ts.costperhour),2) totval from hr_timesheethrs ts left join hr_empm m on ts.empid=m.doc_no"
	        		 +" left join cm_serteamd d  on m.doc_no=d.empid left join cm_serteamm mm on mm.doc_no=d.rdocno where "+sql1+" "+sqltest+" "
	        		  +" group by ts.empid";
	        
	         //System.out.println("*********emp1***********"+sql);
	         ResultSet resultSet = stmtmain.executeQuery(sql);  
	         RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            
	       stmtmain.close();
	       conn.close();                          
	      } catch(Exception e){
	        e.printStackTrace(); 
	        conn.close();
	      } finally{
	    conn.close();
	   }
	        return RESULTDATA;   
   }
	
	public JSONArray manPowerConsumedGridLoading(HttpSession session,String costtype,String costcode,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBDT = conn.createStatement();
	
				if(costtype.contains("AMC") || costtype.contains("amc")) {
					costtype="3";
				} else if(costtype.contains("SJOB") || costtype.contains("sjob")) {
					costtype="4";
				}
				
				String sql="select m.doc_no,m.codeno,m.name,CONVERT(if(round(sum(ts.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(ts.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,6))),CHAR(100)) utilizedhrs,"
						+ "sum(ts.normal) normalhrs,(round((sum(ts.normal)*ts.costperhour),2)/sum(ts.normal)) costperhour,round((sum(ts.normal)*ts.costperhour),2) totalvalue from hr_timesheethrs ts left join hr_empm m on ts.empid=m.doc_no where ts.costtype="+costtype+" and ts.costcode="+costcode+" group by ts.empid";
				
				ResultSet resultSet1 = stmtBDT.executeQuery(sql);
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}


	public JSONArray deployTechnicianDetailsGridLoading(HttpSession session,String costtype,String costcode,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBDT = conn.createStatement();
	
				if(costtype.contains("AMC") || costtype.contains("amc")) {
					costtype="3";
				} else if(costtype.contains("SJOB") || costtype.contains("sjob")) {
					costtype="4";
				}
				
				String sql="select d.date,m.codeno,m.name,d.intime,d.outtime,round(d.total,2) totalvalue from cm_deploytechd d left join hr_empm m on d.empid=m.doc_no where d.status=3 and d.date>=curdate() and d.costtype="+costtype+" and d.costcode="+costcode+"";
				//System.out.println("************job2********"+sql);
				ResultSet resultSet1 = stmtBDT.executeQuery(sql);
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}
	
	public JSONArray jobGridLoading(String jobno,String fromdate,String todate,String id) throws SQLException {
		
  	  JSONArray RESULTDATA=new JSONArray();
  	  if(!(id.equalsIgnoreCase("1"))) {
  		  return RESULTDATA;
  	  }
         Connection conn = null; 
       
      try { 
    	  
         conn = ClsConnection.getMyConnection();
         ClsCommon ClsCommon=new ClsCommon();
         Statement stmtmain = conn.createStatement();
   
         java.sql.Date sqlFromDate=null;
			java.sql.Date sqlToDate=null;
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
         String sql="",sql1="";
         String sqltest="";
         
         if(!(jobno.equals("0") || jobno.equals("") || jobno.equals("undefined"))){
        	 sqltest+=" and p.refdocno in ("+jobno+")";
			}
     	if(!(sqlFromDate==null)){
        	sql1+=" p.date>='"+sqlFromDate+"'";
	    }
		
		if(!(sqlToDate==null)){
        	sql1+=" and p.date<='"+sqlToDate+"'";
	    }
      	   
      /*   sql = "select p.dtype,p.refdocno doc_no,s.site sname,ac.refname clname,coalesce(ac.contactperson,'') cperson,"
         		+ "coalesce(ac.per_mob,ac.com_mob) mob,d.consumed,d.budget,d.balance from cm_servplan p "
         		+ "left join cm_srvcsited s on p.siteid=s.rowno left join cm_deploytechm d on d.doc_no=p.tr_no "
         		+ "left join my_acbook ac on (p.cldocno=ac.doc_no and ac.dtype='CRM') "
         		+ "where p.status=4 and "+sql1+" "+sqltest+" ";
         */
  	   
 		sql ="select d.consumed cnsmd,d.budget bdgt,d.balance,'View' consumed,x.profomadate,x.profomarecievedate,x.tr_no as doctrno,p.dtype,p.refdocno,p.tr_no,p.sr_no,"
		+" s.site sname,s.siteadd siteaddress,a.groupname,ac.refname clname,coalesce(ac.contactperson,'') cperson,coalesce(ac.per_mob,ac.com_mob) mob,"
		+" ac.doc_no docno2,ac.acno,ac.address claddress,concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
		+" p.plannedon pldte,priorno priority,concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) apprdate,"
		+" convert(x.contracttrno,char(50)) contracttrno,round(x.budget,2) budget,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
		+" coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,coalesce(gr.groupname,'') asgnmode,"
	    +" gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname complaint,x.brhid branch,"
		+"coalesce(cd.description,'') description  from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
		+" DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, m.refno contractdetails,ff.date profomarecievedate,coalesce(budget) budget from cm_srvcontrm m "
		+" left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all SELECT tr_no,dtype,"
		+" brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate,"
		+" 0 budget FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
		+" left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area') "
		+" left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join cm_serteamm m on(p.empgroupid=m.doc_no) "
		+" left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) "
		+" left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')"  
		+" left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no  left join cm_deploytechm d on d.costcode=p.refdocno"
		+" left join my_groupvals gvd on cd.servid=gvd.doc_no where "+sql1+" "+sqltest+" and p.status=4  group by p.tr_no order by p.plannedon";
		
		
         //System.out.println("**********jobGrid*********"+sql);
         ResultSet resultSet = stmtmain.executeQuery(sql);
         RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
       stmtmain.close();
       conn.close();
      } catch(Exception e){
        e.printStackTrace(); 
        conn.close();
      } finally{
    conn.close();
   }
        return RESULTDATA;
   }   
	public JSONArray jobExcelLoading(String jobno,String fromdate,String todate,String id) throws SQLException {
		
	  	  JSONArray RESULTDATA=new JSONArray();
	  	  if(!(id.equalsIgnoreCase("1"))) {
	  		  return RESULTDATA;
	  	  }
	         Connection conn = null; 
	       
	      try { 
	    	  
	         conn = ClsConnection.getMyConnection();
	         ClsCommon ClsCommon=new ClsCommon();
	         Statement stmtmain = conn.createStatement();
	   
	         java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
	         String sql="",sql1="";
	         String sqltest="";
	         
	         if(!(jobno.equals("0") || jobno.equals("") || jobno.equals("undefined"))){
	        	 sqltest+=" and p.refdocno in ("+jobno+")";
				}
	     	if(!(sqlFromDate==null)){
	        	sql1+=" p.date>='"+sqlFromDate+"'";
		    }
			
			if(!(sqlToDate==null)){
	        	sql1+=" and p.date<='"+sqlToDate+"'";
		    }
	  	   
			sql ="select p.refdocno DOCNO,p.dtype DTYPE,ac.refname CLIENT,s.site SITE,"
                    +" coalesce(ac.contactperson,'') 'CONTACT PERSON',coalesce(ac.per_mob,ac.com_mob) 'MOBILE',d.consumed CONSUMED,d.budget BUDGET,d.balance BALANCE"
                    +" from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
                    +" DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, m.refno contractdetails,ff.date profomarecievedate,coalesce(budget) budget"
                    +" from cm_srvcontrm m  left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where m.status=3 and m.jbaction in (0,4)"
                    +" and m.pstatus!=1 union all SELECT tr_no,dtype, brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,"
                    +" '' profomadate,c.refno contractdetails,null profomarecievedate, 0 budget FROM cm_cuscallm c where c.status=3 and"
                    +" c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype)"
                    +" left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')  "
                    + " left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join cm_serteamm m on(p.empgroupid=m.doc_no)  left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no)  left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no  left join cm_deploytechm d on d.costcode=p.refdocno left join my_groupvals gvd on cd.servid=gvd.doc_no where  p.date>='2018-01-01' and p.date<='2018-07-03'  and p.status=4  group by p.tr_no order by p.plannedon";
	         //System.out.println("**********jobGrid*********"+sql);
	         ResultSet resultSet = stmtmain.executeQuery(sql);
	     	RESULTDATA=ClsCommon.convertToEXCEL(resultSet);  
	       stmtmain.close();
	       conn.close();
	      } catch(Exception e){
	        e.printStackTrace(); 
	        conn.close();
	      } finally{
	    conn.close();
	   }
	        return RESULTDATA;
	   }   
	
	public JSONArray empMainExcelLoading(String sergroupid,String fromdate,String todate,String id) throws SQLException {
	       
		 JSONArray RESULTDATA=new JSONArray();
	  	  if(!(id.equalsIgnoreCase("1"))) {
	  		  return RESULTDATA;
	  	  }
	         Connection conn = null; 
	       
	      try { 
	    	  
	         conn = ClsConnection.getMyConnection();
	         ClsCommon ClsCommon=new ClsCommon();
	         Statement stmtmain = conn.createStatement();
	         java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
	         String sql="",sql1="";
	         String sqltest="";
	         
	         
	         if(!(sergroupid.equals("0") || sergroupid.equals("") || sergroupid.equals("undefined"))){
	        	 sqltest+=" and d.rdocno in ("+sergroupid+")";
				}
	      	if(!(sqlFromDate==null)){
	        	sql1+=" m.date>='"+sqlFromDate+"'";
		    }
			
			if(!(sqlToDate==null)){
	        	sql1+=" and m.date<='"+sqlToDate+"'";
		    }
	      	   
			  sql =" select m.codeno 'Emp ID',mm.grpcode steam,m.name,CONVERT(if(round(sum(ts.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(ts.normal)*60))=8,"
		        		+" SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(ts.normal)*60),1,6))),CHAR(100)) 'Total Hrs',"
		        		 +"(round((sum(ts.normal)*ts.costperhour),2)/sum(ts.normal)) 'Avg Rate Per hr',"
		        		 +" round((sum(ts.normal)*ts.costperhour),2) 'Total Value' from hr_timesheethrs ts left join hr_empm m on ts.empid=m.doc_no"
		        		 +" left join cm_serteamd d  on m.doc_no=d.empid left join cm_serteamm mm on mm.doc_no=d.rdocno where "+sql1+" "+sqltest+" "
		        		  +" group by ts.empid";
	         //System.out.println("*********emp1Excel***********"+sql);
	         ResultSet resultSet = stmtmain.executeQuery(sql);  
	         RESULTDATA=ClsCommon.convertToEXCEL(resultSet); 
	            
	       stmtmain.close();
	       conn.close();                          
	      } catch(Exception e){
	        e.printStackTrace(); 
	        conn.close();
	      } finally{
	    conn.close();
	   }
	        return RESULTDATA;   
  }
	public JSONArray jobSearchGridLoading(HttpSession session,String typedocno,String refnames,String check,String dtype) throws SQLException {
	    
  	  JSONArray RESULTDATA=new JSONArray();
        
  	  if(!(check.equalsIgnoreCase("1"))) {
  		  return RESULTDATA;
  	  }
        Connection conn = null; 
       
      try {
         conn = ClsConnection.getMyConnection();
         ClsCommon ClsCommon=new ClsCommon();
         Statement stmtmain = conn.createStatement();

         String sql="";
         String sqltest="";
         
         if(!refnames.equalsIgnoreCase("") && !refnames.equalsIgnoreCase("0")){
      	   sqltest+=" and ac.refname like '%"+refnames+"%' ";
         }
         
         if(!typedocno.equalsIgnoreCase("") && !typedocno.equalsIgnoreCase("0")){
      	   sqltest+=" and m.doc_no like '%"+typedocno+"%' ";
         }
         
      	   
         sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
         		+ "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
         		+ "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' "+sqltest+" ;";           
            
         ResultSet resultSet = stmtmain.executeQuery(sql);
         RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
       stmtmain.close();
       conn.close();
      } catch(Exception e){
        e.printStackTrace();
        conn.close();
      } finally{
    conn.close();
   }
        return RESULTDATA;
   }


}
