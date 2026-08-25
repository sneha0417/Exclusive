package com.dashboard.audit.contractservicescheduleupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsContractServiceScheduleUpdateDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cm=new ClsCommon();
	
	public int insert(String docNo,String formcode, String serinter, String srvtype, String serdue, String servicestartdate,String editval,String editfillval,ArrayList<String> termarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		Connection conn = null;
		int val = 0;
		try{
		 	 conn = ClsConnection.getMyConnection();
			 Statement stmt=conn.createStatement();
		String sql=null,sql1=null;
		 int docno=0,clientid=0,vocno=0,serstatus=3;
		 ArrayList<String> serviceschedulerarray=new ArrayList<String>();
		 ArrayList<String> sitelistarray=new ArrayList<String>();
		
		 java.sql.Date serdate=null;
		System.out.println("servicestartdate========"+servicestartdate);
		 if(servicestartdate!=null &&!(servicestartdate.equalsIgnoreCase("undefined"))&&!(servicestartdate.equalsIgnoreCase(""))&&!(servicestartdate.equalsIgnoreCase("0"))){
			 serdate = cm.changeStringtoSqlDate(servicestartdate);
		 }
		 for(int i=0;i<termarray.size();i++){
				
			 String[] temp=termarray.get(i).split("::");
			 String pldate=temp[0];
			 String pltime=temp[1];
			 String priority=temp[2];
			 String trno=temp[3];
			 String workperc=temp[4];
			 String siteid=temp[5];
			
			 serviceschedulerarray.add(pldate+" :: "+pltime+" :: "+priority+" :: "+trno+" :: "+workperc+" :: "+siteid);
			
		 }
		
		 String selsqls="select cldocno,doc_no from cm_srvcontrm where tr_no="+docNo+"";
		 ResultSet resultdel = stmt.executeQuery(selsqls);
		 while(resultdel.next()){
			clientid=resultdel.getInt("cldocno");
			vocno=resultdel.getInt("doc_no");

		 }
			
		 String sitesql="select rowno, srvteamno from cm_srvcsited where tr_no="+docNo+"";
		 ResultSet resultsite = stmt.executeQuery(sitesql);
		 
		 while(resultsite.next()){
			 sitelistarray.add(resultsite.getString("rowno")+" :: "+resultsite.getString("srvteamno")+" :: ");
		 }
		 
		 String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bssu";
	        ResultSet resultSets = stmt.executeQuery(sqls);
	  
	        while (resultSets.next()) {
			   docno=resultSets.getInt("doc_no");
	        }
	        
	        if(serinter.trim().equalsIgnoreCase("")){
	        	serinter="0";
	        }
	        
	        if(serdue.trim().equalsIgnoreCase("")){
	        	serdue="0";
	        }
	        
	        if(serdate==null){
	        	
		        /*Inserting gl_bssu*/
			     String sql2="insert into gl_bssu(doc_no, date, tr_no, serinterval, serdueafter, fservDate, serduetype, userid) values("+docno+", now(), '"+docNo+"', '"+serinter+"', '"+serdue+"', null, '"+srvtype+"', '"+session.getAttribute("USERID").toString()+"')";
		         val= stmt.executeUpdate(sql2);
				 if(val<=0){
					    stmt.close();
						conn.close();
					}
				 /*Inserting gl_bssu Ends*/
	        } else {
	        	
	        	if(editval.equalsIgnoreCase("0") && editfillval.equalsIgnoreCase("1")){
			 		 String sqlContract="update cm_srvcontrm set serinterval='"+serinter+"', serdueafter='"+serdue+"', fservDate='"+serdate+"', serduetype='"+srvtype+"' where tr_no="+docNo+"";
			         val= stmt.executeUpdate(sqlContract);
					 if(val<=0){
						    stmt.close();
							conn.close();
						}
					 
					 String delContract="delete from cm_servplan where doc_no="+docNo+"";
				     int delval=stmt.executeUpdate (delContract);
			 	}
	        	
	        	/*Inserting gl_bssu*/
		   	     String sql2="insert into gl_bssu(doc_no, date, tr_no, serinterval, serdueafter, fservDate, serduetype, userid) values("+docno+", now(), '"+docNo+"', '"+serinter+"', '"+serdue+"', '"+serdate+"', '"+srvtype+"', '"+session.getAttribute("USERID").toString()+"')";
		         val= stmt.executeUpdate(sql2);
		   		 if(val<=0){
		   			    stmt.close();
		   				conn.close();
		   			}
		   		 /*Inserting gl_bssu Ends*/
	        }
		
		 for(int i=0;i<serviceschedulerarray.size();i++){
			 
			 String[] serviceschedule=((String) serviceschedulerarray.get(i)).split("::");
			 
			 String workpercentage=serviceschedule[4].trim().equalsIgnoreCase("undefined") || serviceschedule[4].trim().equalsIgnoreCase("NaN") || serviceschedule[4].trim().equalsIgnoreCase("") || serviceschedule[4].isEmpty()?"0":serviceschedule[4].trim();
			 String trno=serviceschedule[3].trim().equalsIgnoreCase("undefined") || serviceschedule[3].trim().equalsIgnoreCase("NaN") || serviceschedule[3].trim().equalsIgnoreCase("") || serviceschedule[3].isEmpty()?"0":serviceschedule[3].trim();
			 
			 if(Integer.parseInt(workpercentage)==0 && Integer.parseInt(trno)>0){
				 
					 if(!(serviceschedule[0].trim().equalsIgnoreCase("undefined")|| serviceschedule[0].trim().equalsIgnoreCase("NaN")||serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()))
						{	
							if(!(serviceschedule[3].trim().equalsIgnoreCase("undefined")|| serviceschedule[3].trim().equalsIgnoreCase("NaN")||serviceschedule[3].trim().equalsIgnoreCase("")|| serviceschedule[3].isEmpty()))
							{
								
								String sql1s="update cm_servplan set date='"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:cm.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ "plannedOn='"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:cm.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ "plTime='"+(serviceschedule[1].trim().equalsIgnoreCase("undefined") || serviceschedule[1].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[1].trim().equalsIgnoreCase("")|| serviceschedule[1].isEmpty()?0:serviceschedule[1].trim())+"',"
										+ "priorno='"+(serviceschedule[2].trim().equalsIgnoreCase("undefined") || serviceschedule[2].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[2].trim().equalsIgnoreCase("")|| serviceschedule[2].isEmpty()?0:serviceschedule[2].trim())+"' "
										+ "where doc_no="+(docNo)+" and tr_no="+trno+"";
								
								val = stmt.executeUpdate(sql1s);
								if(val<=0) {
									stmt.close();
									conn.close();
								}
							}
					
						}
				 
			 } else if(Integer.parseInt(workpercentage)==0 && Integer.parseInt(trno)==0){
				 
					for(int k=0;k<sitelistarray.size();k++){
					 
						 String[] sitelist=((String) sitelistarray.get(k)).split("::");
						
						 if(!(serviceschedule[0].trim().equalsIgnoreCase("undefined")|| serviceschedule[0].trim().equalsIgnoreCase("NaN")||serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()))
							{	
								
							 String sql1s="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno, refTrNo,doc_No,refdocno,siteid,status, cldocno,empGroupId) VALUES("
										+ " '"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:cm.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ " "+(i+1)+","
										+ " '"+(formcode)+"',"
										+ " "+(session.getAttribute("BRANCHID").toString())+","
										+ " '"+(formcode)+"',"
										+ " '"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:cm.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ " '"+(serviceschedule[1].trim().equalsIgnoreCase("undefined") || serviceschedule[1].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[1].trim().equalsIgnoreCase("")|| serviceschedule[1].isEmpty()?0:serviceschedule[1].trim())+"',"
										+ " '"+(serviceschedule[2].trim().equalsIgnoreCase("undefined") || serviceschedule[2].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[2].trim().equalsIgnoreCase("")|| serviceschedule[2].isEmpty()?0:serviceschedule[2].trim())+"',"
										+ " "+(docNo)+","
										+ " "+(docNo)+","
										+ " "+(vocno)+","
										+ " "+(sitelist[0].trim().equalsIgnoreCase("undefined") || sitelist[0].trim().equalsIgnoreCase("NaN")|| sitelist[0].trim().equalsIgnoreCase("")|| sitelist[0].isEmpty()?"0":sitelist[0].trim())+","
								        + " '"+serstatus+"',"
								        + " '"+clientid+"',"
								        + " "+(sitelist[1].trim().equalsIgnoreCase("undefined") || sitelist[1].trim().equalsIgnoreCase("NaN")|| sitelist[1].trim().equalsIgnoreCase("")|| sitelist[1].isEmpty()?"0":sitelist[1].trim())+")";
								
								val = stmt.executeUpdate(sql1s);
								if(val<=0) {
									stmt.close();
									conn.close();
								}	
							}
				 	}
				 
			 }
			 
		 }
		
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','BSSU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
		 val= stmt.executeUpdate(sql);
	     
	     //response.getWriter().print(val+"***"+docNo);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
		return val;
	}
	public  JSONArray contractServiceScheduleUpdateGridLoading(String branch,String fromdate,String todate,String contracttype,String contrctid,String clientid) throws SQLException {

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
		System.out.println("grid load======"+sqldata);
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
	
	
	public  JSONArray contractServiceScheduleUpdateExcelExport(String branch,String fromdate,String todate,String contracttype,String contrctid,String clientid) throws SQLException {

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
	
	public JSONArray serviceScheduleGridFillLoading(HttpSession session,String date,String enddate,String txtinstnos,String txtamount,String gridload,String cmbfrequency,String txtdueafter) throws SQLException {


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

				if(!(xdate==null) || !(endsdate.after(xdate))){
					obj.put("pldate",xdate.toString());
				}
				/*obj.put("amount",String.valueOf(amount));
					obj.put("runtotal",String.valueOf(xtotal));
				 */
				jsonArray.add(obj);

				if(xsrno>Integer.parseInt(txtinstnos)) break;

				//System.out.println("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");

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
	
	public JSONArray serviceScheudleGridLoading(HttpSession session,String doc_no,String dtype) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select plannedOn pldate, plTime pltime,s.site,p.priorno as priority,coalesce(grpcode,'') as asgngrp,coalesce(e.name,'') as emp,coalesce(gr.groupname,'') asgnmode,coalesce(p.remarks,'') desc1,"
					+ "coalesce(gs.groupname,'') as service,p.servid as serviceid,coalesce(p.servamt,0.0) as value,DAYname(date_format(plannedOn,'%Y-%m-%d')) as days,p.tr_no trno,p.workper from  cm_servplan p "
					+ "left join cm_srvcsited s on(p.siteid=s.rowno) left join cm_serteamm m on(p.empgroupid=m.doc_no) "
					+ "left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm e on(md.empid=e.doc_no) "
					+ "left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') "
					+ "where p.reftrno='"+doc_no+"' and p.dtype='"+dtype+"' and p.brhid="+brhid+"";
System.out.println("========"+sql );
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