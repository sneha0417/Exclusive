package com.dashboard.project.servicereportlist;

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

public class serviceReportListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	
	
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String assgrpid) throws SQLException {

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
	       		sqltest+=" and cm.costid="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(!(assgrpid.equalsIgnoreCase("")) && !(assgrpid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.doc_no="+assgrpid+" ";
	       	}
			
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.ref_type='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.ref_type='SJOB' ";
				}
				
		String sqldata="select spr.description,d.part_no productid,d.productname,u.unit,spr.qty,spr.costprice,spr.total,if (spr.chg=1,'yes','no') invoiced,cm.doc_no,'View' as view,cm.cldocno,ac.refname costomer,cm.ref_type contrtype,cn.doc_no contrno,sit.siteadd,cm.schrefdocno schno,cm.wrkper,cm.chkrect,cm.rect,m.grpcode,em.name from cm_srvdetm cm left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm'"
				+ " left join cm_srvcsited sit on cm.siteid=sit.rowno left join cm_srvcontrm cn on cm.costid=cn.tr_no left join cm_servplan p on cn.tr_no=p.doc_no and p.tr_no=cm.schrefdocno"
				+ " left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid)"
				+ " left join hr_empm em on(md.empid=em.doc_no) left join cm_srvspares spr on (cm.tr_no=spr.tr_no and cm.dtype='SRVE') left join my_main d on spr.prdId=d.doc_no  left join my_unitm u on spr.UNITID=u.doc_no "
				+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+"  ";
		
		System.out.println("************"+sqldata);
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
	
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String assgrpid) throws SQLException {

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
	       		sqltest+=" and cm.costid="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(!(assgrpid.equalsIgnoreCase("")) && !(assgrpid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.doc_no="+assgrpid+" ";
	       	}
			
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.ref_type='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.ref_type='SJOB' ";
				}
				
		String sqldata="select cm.doc_no 'Doc No',cm.cldocno 'Code',ac.refname 'Customer',cm.ref_type 'Contract Type',cn.doc_no 'Contract No',sit.siteadd 'Site Area',cm.schrefdocno 'Schedule No',cm.wrkper 'Complete %',cm.chkrect 'Rectification',cm.rect 'Rectification Description',m.grpcode 'Assign Group',em.name 'Assign Member',spr.description 'Description',d.part_no 'Product',d.productname 'Product Name',u.unit 'Unit',spr.qty 'Quantity',spr.costprice 'Amount',spr.total 'Total',if (spr.chg=1,'yes','no') 'Invoiced' from cm_srvdetm cm left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm'"
				+ " left join cm_srvcsited sit on cm.siteid=sit.rowno left join cm_srvcontrm cn on cm.costid=cn.tr_no left join cm_servplan p on cn.tr_no=p.doc_no and p.tr_no=cm.schrefdocno"
				+ " left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid)"
				+ " left join hr_empm em on(md.empid=em.doc_no) left join cm_srvspares spr on (cm.tr_no=spr.tr_no and cm.dtype='SRVE') left join my_main d on spr.prdId=d.doc_no  left join my_unitm u on spr.UNITID=u.doc_no "
				+ " where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+"  ";
		
		System.out.println("************"+sqldata);
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
	
	public JSONArray assignfrm(HttpSession session,String docno,String group,String id) throws SQLException{
		 
		System.out.println(docno);
				JSONArray RESULTDATA1=new JSONArray();

				Connection conn=null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement();

					String sql = "";
					String sql11 = "";
					if(!(docno.equals("0") || docno.equals("") || docno.equals("undefined"))){
						sql11=sql11+" and m.doc_no like '%"+docno+"%'";
					}
					
					if(!(group.equals("0") || group.equals("") || group.equals("undefined"))){
						sql11=sql11+" and m.grpcode like '%"+group+"%'";
					}
					System.out.println(sql11);
					sql="select grpcode,doc_no  from cm_serteamm m where status=3 "+sql11+" ";


								System.out.println("===sql===="+sql);

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
	public   JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {


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

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11+=" and a.cldocno in ("+clientid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
			sql11=sql11+" and a.dtype='"+dtype+"'";
		}

		if(!(refno.equals("0") || refno.equals("") || refno.equals("undefined"))){
			sql11=sql11+" and a.refno like '%"+refno+"%'";
		}

		if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
			sql11=sql11+" and a.doc_no='"+contractno+"'";
		}

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select * from (select tr_no,doc_no,refno,dtype,cldocno,convert(concat(dtype,'-',doc_no),char(50)) as contr from cm_srvcontrm where status<>7 and iser=1 "
					+ ") as a where 1=1 "+sql11+" order by doc_no");

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