package com.dashboard.project.contractpaymentscheduleupdate;

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

public class ClsContractPaymentScheduleUpdateDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cm=new ClsCommon();
	
	public  JSONArray contractPaymentScheduleUpdateGridLoading(String branch,String fromdate,String todate,String contracttype,String contrctid,String clientid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

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

			if(branch.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+branch;
			}
			
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+=" and cm.tr_no="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(contracttype.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(contracttype.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select cm.tr_no,cm.doc_no,sm.sal_name,mm.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
				+ "cm.validupto edate,round(cm.contractval,2) cval, convert(group_concat(cs.site),char(200)) site,round(cm.legalchrg,2) lfee from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);

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
	
	
	public  JSONArray contractPaymentScheduleUpdateExcelExport(String branch,String fromdate,String todate,String contracttype,String contrctid,String clientid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		
		String sqltest="";
		
		try {

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
	    	
	    	

			if(branch.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+branch;
			}
			
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+=" and cm.tr_no="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(contracttype.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(contracttype.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select cm.doc_no,cm.dtype,ac.refname client,sm.sal_name 'Salesperson',cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
				+ "cm.validupto edate,round(cm.contractval,2) cval, convert(group_concat(cs.site),char(200)) site,round(cm.legalchrg,2) lfee from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);

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
	
	public JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {

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
		  System.out.println("contractno ="+contractno);
		  
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

		   String clssql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 and 1=1 "+sql11+" order by doc_no";
		   //System.out.println("clssql ="+clssql);
		   ResultSet resultSet = stmtenq1.executeQuery(clssql);

		   RESULTDATA=cm.convertToJSON(resultSet);
		   stmtenq1.close();
		   conn.close();
		  }
		  catch(Exception e){
		   conn.close();
		   e.printStackTrace();
		  }
		  return RESULTDATA;
		 }
	
	public JSONArray paymentGridFillLoading(HttpSession session,String date,String enddate,String txtinstnos,String txtamount,String gridload,String cmbfrequency,String txtdueafter) throws SQLException {


		JSONArray jsonArray = new JSONArray();


		if(!gridload.equalsIgnoreCase("1")){

			return jsonArray;
		}


		Connection conn = null; 

		try {


			java.sql.Date xdate=null;
			java.sql.Date fdate=null;
			java.sql.Date endsdate=null;

			double xtotal=0.0;
			double amount=0.0;
			int xsrno=0;

			date.trim();

			gridload=gridload.trim();


			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				xdate = cm.changeStringtoSqlDate(date);
				fdate = cm.changeStringtoSqlDate(date);
			}

			enddate.trim();
			if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
				endsdate = cm.changeStringtoSqlDate(enddate);
			}

			String xsql="";


			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();



			Double txtinstamt=Double.parseDouble(txtamount)/Integer.parseInt(txtinstnos);
			xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			do							
			{	
				++xsrno;

				if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;

				int sr_no= xsrno;							
				int actualNoOfInst=xsrno;

				amount=((xtotal+txtinstamt)>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):txtinstamt);
				xtotal+=amount;

				JSONObject obj = new JSONObject();
				obj.put("sr_no",String.valueOf(sr_no));
				/*&& !(xdate.after(endsdate)) && !(xdate.before(endsdate)*/
				if(!(xdate==null)){
					obj.put("duedate",xdate.toString());
					/*obj.put("amount",String.valueOf(amount));
					obj.put("runtotal",String.valueOf(xtotal));*/
				}
				obj.put("amount",String.valueOf(amount));
				obj.put("runtotal",String.valueOf(xtotal));
				/*obj.put("amount",String.valueOf(amount));
				obj.put("runtotal",String.valueOf(xtotal));*/

				jsonArray.add(obj);

				if(xtotal>=Double.parseDouble(txtamount)) break;

//				System.out.println("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");

				ResultSet rs = stmt.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");
				if(rs.next()) xdate=rs.getDate("fdate");

				rs.close();
			}while(true);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}
	
	public JSONArray paymentDetailsGridLoading(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select b.*,@i:=@i+amount runtotal from (select dueDate, amount,  description desc1, DueAfSer dueser, runtotal,terms,termsid,if(terms='SERVICE',dueafser,0) service,rowno,invtrno "
					+ "from cm_srvcontrpd where tr_no='"+doc_no+"') b,(select @i:=0) i";

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cm.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
}