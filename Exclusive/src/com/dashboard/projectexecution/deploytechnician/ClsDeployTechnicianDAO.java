package com.dashboard.projectexecution.deploytechnician;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDeployTechnicianDAO {

	ClsConnection ClsConnection= new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray deployTechnicianGridLoading(HttpSession session,String branch,String fromdate,String todate,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				conn = ClsConnection.getMyConnection();
				Statement stmtBDT = conn.createStatement();
	
				String sql="",sql1="";
				
				if(!(sqlFromDate==null)){
		        	sql1+=" and p.date>='"+sqlFromDate+"'";
			    }
				
				if(!(sqlToDate==null)){
		        	sql1+=" and p.date<='"+sqlToDate+"'";
			    }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and x.brhid in ("+branch+")";
	    		}
				
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmtBDT.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	//sql1=sql1+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
				   
				sql="select 'View' consumed,x.profomadate,x.profomarecievedate,x.tr_no as doctrno,p.dtype,p.refdocno,p.tr_no,p.sr_no,s.site,s.siteadd siteaddress,a.groupname,ac.refname,coalesce(ac.contactperson,'') contactperson,coalesce(ac.per_mob,ac.com_mob) mobileno,ac.doc_no docno2,ac.acno,ac.address claddress,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
						+ "p.plannedon pldte,priorno priority,concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) apprdate,"
						+ "convert(x.contracttrno,char(50)) contracttrno,round(x.budget,2) budget,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
						+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
						+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname complaint,x.brhid branch,coalesce(cd.description,'') description  "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate,coalesce(budget) budget from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate,0 budget "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') "
						+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no where (p.status=4 or (p.status=5 and workper!=100)) "+sql1+" group by p.tr_no order by p.plannedon";
				
		        System.out.println("==assignjobfollwupGrid=="+sql);

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
						+ "sum(ts.normal) normalhrs,(round((sum(ts.normal)*ts.costperhour),2)/sum(ts.normal)) costperhour,round((sum(ts.normal)*(ts.costperhour/60)),2) totalvalue from hr_timesheethrs ts left join hr_empm m on ts.empid=m.doc_no where ts.costtype="+costtype+" and ts.costcode="+costcode+" group by ts.empid";
				
				System.out.println("viewgrid=="+sql);
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
	
	public JSONArray manPowerAssignedOnDateGridLoading(HttpSession session,String date,String empdocno,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBDT = conn.createStatement();
	
				java.sql.Date sqlDate=null;
				
				if(!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))){
					sqlDate = ClsCommon.changeStringtoSqlDate(date);
		        }
				
				if(sqlDate!=null && (!(empdocno.equalsIgnoreCase("")) && !(empdocno.equalsIgnoreCase("0")))) {
					
					String sql="select d.date,m.codeno,m.name,d.intime,d.outtime,round(d.total,2) totalvalue from cm_deploytechd d left join hr_empm m on d.empid=m.doc_no where d.status=3 and d.date='"+sqlDate+"' and d.empid="+empdocno+"";
					
					ResultSet resultSet1 = stmtBDT.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
					
				}
				
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}
	
	public JSONArray employeeDetailsSearch(String empid,String empname,String check) throws SQLException {
	    
	    	JSONArray RESULTDATA=new JSONArray();
	          
	    	if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
	    	
	         Connection conn = null; 
	         
	        try {
	        	
	            conn = ClsConnection.getMyConnection();
	            Statement stmtBDT = conn.createStatement();
	            String sql1="";
	           
	            if(!(empid.equalsIgnoreCase("") || empid.equalsIgnoreCase("0"))){
	            	sql1+=" and m.codeno="+empid+"";
	            }
	            
	            if(!(empname.equalsIgnoreCase("") || empname.equalsIgnoreCase("0"))){
	            	sql1+=" and m.name like '%"+empname+"%'";
	            }
	            
	            String sql="select m.doc_no,m.codeno,m.name,m.costperhour from hr_empm m left join (select max(doc_no),catid,status,timesheet from hr_paycode where status=3 and timesheet=1 group by catid) c on (m.pay_catid=c.catid and c.timesheet=1) "
	            		+ "left join hr_setdept d on m.dept_id=d.doc_no where m.status=3 and m.active=1 and c.status=3 and c.timesheet=1 and d.deploytech=1 "+sql1+"";
	            
	            ResultSet resultSet = stmtBDT.executeQuery(sql);
	            RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	            stmtBDT.close();
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
	
	public  ClsDeployTechnicianBean getPrint(HttpServletRequest request,String date,String employeedocno,String jobno) throws SQLException {
			
		ClsDeployTechnicianBean bean = new ClsDeployTechnicianBean();

		Connection conn = null;
		
        java.sql.Date sqlDate = null;
        
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtBDT = conn.createStatement();
		
		if(!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))){
			sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		String headersql="select 'Deploy Technician' vouchername,(DATE_FORMAT('"+sqlDate+"','%D %M  %Y ')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_brch b left join my_comp c on c.doc_no=b.cmpid "
				 + "inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where b.cmpid=1 limit 1";
				
				ResultSet resultSetHead = stmtBDT.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
				}
		
		stmtBDT.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
	
}
