package com.dashboard.analysis.salesinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesInvoiceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getClientCategory() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select doc_no,cat_name clientcatname from my_clcatm where status=3 and dtype='CRM'";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
public JSONArray getClient(String branch,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {
        
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
        		
        		try {
					conn=ClsConnection.getMyConnection();
        		
	   	 
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	 dob.trim();
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='%"+mob+"%'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	  
			
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String clsql= "select distinct a.cldocno,coalesce(d.nation,'') nation,d.dob,coalesce(d.dlno,'') dlno,trim(a.RefName) RefName,"+
					" coalesce(a.per_mob,'')per_mob,coalesce(trim(a.address),'') address,a.codeno,a.acno,m.doc_no,coalesce(trim(m.sal_name),'') sal_name "+
					" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where 1=1 and a.dtype='CRM' and a.status=3"+sqltest;
//					System.out.println("rental"+clsql);
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
        		finally{
        			conn.close();
        		}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    
    }



	public JSONArray getSalesAgent() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select  doc_no,sal_name from my_salm where status=3";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getRentalAgent() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select doc_no,sal_name from my_salesman where sal_type='RLA' and status=3";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray getBrand() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select doc_no,brand_name brand from gl_vehbrand where status=3";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray getModel() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select model.doc_no,model.vtype model from gl_vehmodel model  where model.status=3 ";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray getGroup() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select doc_no,gname from gl_vehgroup where status=3";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getYom() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select doc_no,yom from gl_yom";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray getFleet() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
//			System.out.println("Here");
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select veh.doc_no,veh.fleet_no,veh.flname,veh.reg_no,plate.code_name plate from gl_vehmaster veh left join gl_vehplate plate on veh.pltid=plate.doc_no where statu=3";
//             	System.out.println(strSql);
				ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getSalesInvoices_Dates(String branch,String fromdate,String todate,String grpby1,String hidclientcat,
			String hidclient,String hidsalesman,String hidrentalagent,String hidbrand,String hidmodel,String hidgroup,String hidyom,String temp) throws SQLException {
//		System.out.println("Inside");
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Statement stmtsales=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			String sqlselect="";
			String sqlgroup="";
			String sqlcommon="";
			String sqlgroupdet="";
			int i=0;
			if(grpby1.equalsIgnoreCase("")){
				sqlgroup=" group by ac.cldocno";
				sqlselect="coalesce(ac.cldocno,0) refno,coalesce(ac.refname,'NA') description,(sum(a.amount))*-1 amount";

			}
			else{
				sqlgroup="group by";
				if(grpby1.equalsIgnoreCase("clientcat")){
					sqlgroupdet=" cat.doc_no";
					sqlselect="coalesce(cat.doc_no,0) refno,coalesce(cat.cat_name,'NA') description,(sum(a.amount))*-1 amount";
				}
				else if(grpby1.equalsIgnoreCase("client")){
					sqlgroupdet=" ac.cldocno";
					sqlselect="coalesce(ac.cldocno,0) refno,coalesce(ac.refname,'NA') description,(sum(a.amount))*-1 amount";
				}
				else if(grpby1.equalsIgnoreCase("salesman")){
					sqlgroupdet=" sal.doc_no";
					sqlselect=" coalesce(sal.doc_no,0) refno,coalesce(sal.sal_name,'NA') description,(sum(a.amount))*-1 amount";
				}
				/*else if(grpby1.equalsIgnoreCase("rentalagent")){
					sqlgroupdet=" rarla.doc_no";
					sqlselect="coalesce(rarla.doc_no,0) refno,coalesce(rarla.sal_name,'NA') description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}*/
				else if(grpby1.equalsIgnoreCase("brand")){
					sqlgroupdet=" veh.brdid";
					sqlselect=" coalesce(veh.brdid,0) refno,coalesce(brd.brand_name,'NA') description,(sum(a.amount))*-1 amount";
				}
				else if(grpby1.equalsIgnoreCase("model")){
					sqlgroupdet=" veh.vmodid";
					sqlselect=" coalesce(veh.vmodid,0) refno,coalesce(model.vtype,'NA') description,(sum(a.amount))*-1 amount";
				}
				else if(grpby1.equalsIgnoreCase("group")){
					sqlgroupdet=" veh.vgrpid";
					sqlselect=" coalesce(veh.vgrpid,0) refno,coalesce(grp.gname,'NA') description,(sum(a.amount))*-1 amount";
				}
				else if(grpby1.equalsIgnoreCase("yom")){
					sqlgroupdet=" veh.yom";
					sqlselect=" coalesce(veh.yom,0) refno,coalesce(yom.yom,0) description,(sum(a.amount))*-1 amount";
				}
				else{
					
				}
			
				sqlgroup+=sqlgroupdet;
			}
		
			
			
			if(sqlfromdate!=null){
				sqlcommon+=" and j.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqlcommon+=" and j.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqlcommon+=" and j.brhid="+branch+"";
			}
			
			if(!hidclientcat.equalsIgnoreCase("")){
				sqltest+=" and cat.doc_no in ("+hidclientcat+")";
			}
			if(!hidclient.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno in ("+hidclient+")";
			}
			if(!hidsalesman.equalsIgnoreCase("")){
				sqltest+=" and sal.doc_no in ("+hidsalesman+")";
			}
			if(!hidrentalagent.equalsIgnoreCase("")){
				sqltest+=" and rarla.doc_no in ("+hidrentalagent+")";
			}
			if(!hidbrand.equalsIgnoreCase("")){
				sqltest+=" and veh.brdid in ("+hidbrand+")";
			}
			if(!hidmodel.equalsIgnoreCase("")){
				sqltest+=" and veh.vmodid in ("+hidmodel+")";
			}
			if(!hidgroup.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid in ("+hidgroup+")";
			}
			if(!hidyom.equalsIgnoreCase("")){
				sqltest+=" and veh.yom in ("+hidyom+")";
			}
			
			
				/*String strSql="select "+sqlselect+" from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where h.den=110 and j.status=3 "+sqltest+" "+sqlgroup;*/
			
			/*	String strSql="select "+sqlselect+" from ("+
						" select c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left  join my_head h on"+
						" c.acno=h.doc_no where h.den=110 and j.status=3  "+sqltest+")a"+
						" inner join my_jvtran jv on (a.tr_no=jv.tr_no and jv.cldocno<>0) left join my_acbook ac on"+
						" ( jv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on ac.catid=cat.doc_no left join "+
						" gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
						" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no "+sqlgroup;*/
			
				String strSql=" select "+sqlselect+" from ( select c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no from my_costtran c "+
							" inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3 "+sqlcommon+")a"+
							" left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO')"+
							" and a.tr_no=cno.tr_no) left join my_head cnohead on (cno.acno=cnohead.doc_no and cnohead.dtype='CRM')"+
							" left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cnohead.cldocno=ac.cldocno) and ac.dtype='CRM') left join my_clcatm"+
							" cat on ac.catid=cat.doc_no left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+" group by refno";
//				System.out.println("Check Query:"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray analysisGrid(String branch,String fromdate,String todate, String cmbfrequency,String noOfDays,String check,String grpby1,String hidbrand,String hidmodel,String hidgroup,String hidyom,String hidclientcat,String hidclient,String hidsalesman,String hidrentalagent) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtBalance = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			     
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     analysiscolumnarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			     analysiscolumnarray.add("Ref No::refno::center::center:: ::10%:: :: :: ");
			     analysiscolumnarray.add("Description::description::left::left:: ::25%:: ::headClass:: ");
			     		     
			     String xsql="",xsqls="";
			     String sql = "",sql1 = "",sql2="",sql3="";
			     String dayDiff="",monthDiff="";
			     if(cmbfrequency.equalsIgnoreCase("1")){
			    		String sqls = "select count(*) branchcount from my_brch where status<>7";
			    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("branchcount");
						} 
			     }
			     else if(cmbfrequency.equalsIgnoreCase("2")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
						
			     }else if(cmbfrequency.equalsIgnoreCase("3")){
			    	 
			    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							monthDiff=rs1.getString("monthdiff");
						} 
						
						String sqls1 = "select ("+monthDiff+"/3) monthdifference";
						ResultSet rs2 = stmtBalance.executeQuery(sqls1);
						
						while(rs2.next()) {
							txtfrequency=rs2.getInt("monthdifference");
						} 
			    	    
						xsqls= "3 Month";
						
			     }else if(cmbfrequency.equalsIgnoreCase("4")){

			    	 	String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";
			    	 	ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("yeardiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			     }
			     else if(cmbfrequency.equalsIgnoreCase("5")){
			    	 String sqls="select count(*) catcount from my_clcatm where status=3";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("catcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("6")){
			    	 String sqls="select count(*) salescount from my_salm where status=3";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("salescount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("7")){
			    	 String sqls="select count(*) rentalcount from my_salesman where sal_type='RLA'";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("rentalcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("8")){
			    	 String sqls="select count(*) brandcount from gl_vehbrand where status=3";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("brandcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("9")){
			    	 String sqls="select count(*) modelcount from gl_vehmodel where status=3";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("modelcount");
			    	 }

			     }
			     else if(cmbfrequency.equalsIgnoreCase("10")){
			    	 String sqls="select count(*) groupcount from gl_vehgroup where status=3";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("groupcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("11")){
			    	 String sqls="select count(*) yomcount from gl_yom";
			    	 ResultSet rs1=stmtBalance.executeQuery(sqls);
			    	 while(rs1.next()){
			    		//System.out.println("Inside yomcount");
			    		 txtfrequency=rs1.getInt("yomcount");
			    	 }
			     }
			     else{
			    	 txtfrequency=0;
			     }
			     	ArrayList<String> temparray=new ArrayList<>();
			     	if(cmbfrequency.equalsIgnoreCase("1")){
			     		String brname="";
			     		for(int i=0,y=0;i<=txtfrequency;i++){
			     			xsql="select branchname,doc_no from my_brch where doc_no="+i;
			     			ResultSet rsbr=stmtBalance.executeQuery(xsql);
			     			while(rsbr.next()){
			     				brname=rsbr.getString("branchname");
			     				
			     				sql3+=" if(j.brhid="+rsbr.getInt("doc_no")+",amount,'') amount"+y+",";
			     				temparray.add(" and j.brhid="+rsbr.getInt("doc_no"));
			     				amountLength=amountLength+1;
			     				  analysiscolumnarray.add(""+brname+"::amount"+y+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     					y++;
			     			}
			     		}
			     	}
			     	
			     	else if(cmbfrequency.equalsIgnoreCase("2")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						  // xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%d-%m-%Y'),' To ',DATE_FORMAT(LAST_DAY('"+analysisDate+"'),'%d-%m-%Y')) analysisDates";
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,concat(MONTHNAME('"+analysisDate+"'),' ',date_format('"+analysisDate+"','%y')) analysisDates";
						   
						  // System.out.println(xsql);
						   ResultSet rs = stmtBalance.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if (j.date between '"+sqlFromDate+"' and '"+analysisDate+"',amount,'') amount"+i+",";
								 temparray.add(" and j.date between '"+sqlFromDate+"' and '"+analysisDate+"'");
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						     }
						}else{
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "MONTHNAME(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate"+
								   ",concat(MONTHNAME(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ))),' ',date_format(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )),'%y')) stranalysisToDate";
					//System.out.println("Month xsql:"+xsql);
													   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("stranalysisToDate");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=rs.getString("stranalysisToDate");
								      }
								     
									     sql3+=" if (j.date between '"+analysisFromDate+"' and '"+analysisToDate+"',amount,'') amount"+i+",";
									     temparray.add(" and j.date between '"+analysisFromDate+"' and '"+analysisToDate+"'");
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
			     
			     	else if(cmbfrequency.equalsIgnoreCase("3")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%d-%m-%Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month)),'%d-%m-%Y')) analysisDates";
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     sql3+=" if (j.date between '"+sqlFromDate+"' and '"+analysisDate+"',amount,'') amount"+i+",";
									 temparray.add(" and j.date between '"+sqlFromDate+"' and '"+analysisDate+"'");
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%d-%m-%Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate";
								   
								   ResultSet rs = stmtBalance.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }
									     
										     sql3+=" if (j.date between '"+analysisFromDate+"' and '"+analysisToDate+"',amount,'') amount"+i+",";
											 
										     temparray.add(" j.date between '"+analysisFromDate+"' and '"+analysisToDate+"'");
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
			     	
			     	else if(cmbfrequency.equalsIgnoreCase("4")){
			     		
			     		analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   String sqls = "SELECT YEAR('"+analysisDate+"') year";
							   ResultSet rs1 = stmtBalance.executeQuery(sqls);
							   
							   int year=0;
							   while(rs1.next()){
								    year=rs1.getInt("year");
							   }
							   
							   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
							   ResultSet rss = stmtBalance.executeQuery(sqls1);
							   
							   int noOfMonths=0;
							   while(rss.next()){
								     noOfMonths=rss.getInt("noofmonths");
							   }
							   
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,YEAR('"+analysisDate+"') analysisDates";
//							  System.out.println("year xsql: "+xsql);
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     sql3+=" if (j.date between '"+sqlFromDate+"' and '"+analysisDate+"',amount,'') amount"+i+",";
									 
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,YEAR(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate,YEAR(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month ))) stranalysisToDate";
								   
								   ResultSet rs = stmtBalance.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=rs.getString("stranalysisToDate");
									      }
									     
										     sql3+=" if (j.date between '"+analysisFromDate+"' and '"+analysisToDate+"',amount,'') amount"+i+",";
											 
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("5")){
			     		ArrayList<String> clientcatarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,cat_name from my_clcatm where status=3";
			     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
			     			while(rs2.next()){
			     				clientcatarray.add(rs2.getString("doc_no")+"::"+rs2.getString("cat_name"));
			     			}
			     			for(int i=0;i<clientcatarray.size();i++){
			     				sql3+=" if (cat.doc_no="+clientcatarray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
			     				amountLength=amountLength+1;
			     				analysiscolumnarray.add(""+clientcatarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("6")){
			     		ArrayList<String> salesmanarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,sal_name from my_salm where status=3";
			     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
			     			while(rs2.next()){
			     				salesmanarray.add(rs2.getString("doc_no")+"::"+rs2.getString("sal_name"));
			     			}
			     			for(int i=0;i<salesmanarray.size();i++){
			     				sql3+=" if (sal.doc_no="+salesmanarray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
			     				amountLength=amountLength+1;
			     				analysiscolumnarray.add(""+salesmanarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("7")){
			     		ArrayList<String> rentalagentarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,sal_name from my_salesman where status=3 and sal_type='RLA'";
			     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
			     			while(rs2.next()){
			     				rentalagentarray.add(rs2.getString("doc_no")+"::"+rs2.getString("sal_name"));
			     			}
			     			for(int i=0;i<rentalagentarray.size();i++){
			     				sql3+=" if (rarla.doc_no="+rentalagentarray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
			     				amountLength=amountLength+1;
			     				analysiscolumnarray.add(""+rentalagentarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("8")){
			     		ArrayList<String> brandarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,brand_name from gl_vehbrand where status=3";
			     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
			     			while(rs2.next()){
			     				brandarray.add(rs2.getString("doc_no")+"::"+rs2.getString("brand_name"));
			     			}
			     			for(int i=0;i<brandarray.size();i++){
			     				sql3+=" if (brd.doc_no="+brandarray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
			     				amountLength=amountLength+1;
			     				analysiscolumnarray.add(""+brandarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("9")){
			     		ArrayList<String> modelarray=new ArrayList<>();
			     			
			     			String sqlss="select doc_no,vtype from gl_vehmodel where status=3";
			     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
			     			while(rs2.next()){
			     				modelarray.add(rs2.getString("doc_no")+"::"+rs2.getString("vtype"));
			     			}
			     			for(int i=0;i<modelarray.size();i++){
			     				sql3+=" if (model.doc_no="+modelarray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
			     				amountLength=amountLength+1;
			     				analysiscolumnarray.add(""+modelarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("10")){
			     		ArrayList<String> grouparray=new ArrayList<>();
		     			
		     			String sqlss="select doc_no,gname from gl_vehgroup where status=3";
		     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
		     			while(rs2.next()){
		     				grouparray.add(rs2.getString("doc_no")+"::"+rs2.getString("gname"));
		     			}
		     			for(int i=0;i<grouparray.size();i++){
		     				sql3+=" if (grp.doc_no="+grouparray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
		     				amountLength=amountLength+1;
		     				analysiscolumnarray.add(""+grouparray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
		     			}
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("11")){
			     		ArrayList<String> grouparray=new ArrayList<>();
		     			
		     			String sqlss="select doc_no,yom from gl_yom";
		     			ResultSet rs2=stmtBalance.executeQuery(sqlss);
		     			while(rs2.next()){
		     				grouparray.add(rs2.getString("doc_no")+"::"+rs2.getString("yom"));
		     			}
		     			for(int i=0;i<grouparray.size();i++){
		     				sql3+=" if (yom.doc_no="+grouparray.get(i).split("::")[0]+",(sum(a.amount))*-1,'') amount"+i+",";
		     				amountLength=amountLength+1;
		     				analysiscolumnarray.add(""+grouparray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
		     			}
			     	}
			     	
			     	
			     	
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and j.brhid in ("+branch+")";
			}
		     
		  /*   sql = "select @i:=@i+1 id,k.date,k.description,if(k.dr!=0,round(k.dr,2),'') dramount,"+sql3+""
		     		+ "k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac from ("
		     		+ "select 0 date,"+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,if(gtype='X',@xwrk,0) netAmt "
		     		+ "from gc_agrpd where gtype in('D','X') and gp_id<=17 "
		     		+ "UNION ALL "
		     		+ "Select t.date,"+sql1+"0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD' description,0 dr,sum(ldramount)*-1 netAmt from "
		     		+ "my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type in (4,5)  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "select m.date,"+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,"
		     		+ "gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',"
		     		+ "' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,"
		     		+ "dr*if(grpLevel=1,1,-1),dr*drsign) dr,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt from ("
		     		+ "select a.date,a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,"
		     		+ "a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ("
		     		+ "select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		     		+ "length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,("
		     		+ "SELECT 139 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+"' and h.gr_type>=4  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "Select 140 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 and "
		     		+ "t.trtype!=1  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "SELECT acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "
		     		+ ""+sql2+"  group by t.acno) t  where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,"
		     		+ "(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where k.dr!=0 order by gp_id,den,groupno,ordno";
		     */
		   String sqltest="";
		   String sqlcommon="";
		     if(sqlFromDate!=null){
					sqlcommon+=" and j.date>='"+sqlFromDate+"'";
				}
				if(sqlToDate!=null){
					sqlcommon+=" and j.date<='"+sqlToDate+"'";
				}
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA")){
					sqlcommon+=" and j.brhid="+branch+"";
				}
				if(!hidclientcat.equalsIgnoreCase("")){
					sqltest+=" and cat.doc_no in ("+hidclientcat+")";
				}
				if(!hidclient.equalsIgnoreCase("")){
					sqltest+=" and ac.cldocno in ("+hidclient+")";
				}
				if(!hidsalesman.equalsIgnoreCase("")){
					sqltest+=" and sal.doc_no in ("+hidsalesman+")";
				}
				if(!hidrentalagent.equalsIgnoreCase("")){
					sqltest+=" and rarla.doc_no in ("+hidrentalagent+")";
				}
				if(!hidbrand.equalsIgnoreCase("")){
					sqltest+=" and veh.brdid in ("+hidbrand+")";
				}
				if(!hidmodel.equalsIgnoreCase("")){
					sqltest+=" and veh.vmodid in ("+hidmodel+")";
				}
				if(!hidgroup.equalsIgnoreCase("")){
					sqltest+=" and veh.vgrpid in ("+hidgroup+")";
				}
				if(!hidyom.equalsIgnoreCase("")){
					sqltest+=" and veh.yom in ("+hidyom+")";
				}
				String sqlgroup="";
				String sqlselect="";
				String sqlgroupdet="";
				if(grpby1.equalsIgnoreCase("")){
					sqlgroup=" group by ac.cldocno";
					sqlselect="ac.cldocno refno,ac.refname description";

				}
				else{
					sqlgroup="group by";
					if(grpby1.equalsIgnoreCase("clientcat")){
						sqlgroupdet=" cat.doc_no";
						sqlselect="cat.doc_no refno,cat.cat_name description";
					}
					else if(grpby1.equalsIgnoreCase("client")){
						sqlgroupdet=" ac.cldocno";
						sqlselect="ac.cldocno refno,ac.refname description";
					}
					else if(grpby1.equalsIgnoreCase("salesman")){
						sqlgroupdet=" sal.doc_no";
						sqlselect=" sal.doc_no refno,sal.sal_name description";
					}
					else if(grpby1.equalsIgnoreCase("rentalagent")){
						sqlgroupdet=" rarla.doc_no";
						sqlselect="rarla.doc_no refno,rarla.sal_name description";
					}
					else if(grpby1.equalsIgnoreCase("brand")){
						sqlgroupdet=" veh.brdid";
						sqlselect=" veh.brdid refno,brd.brand_name description";
					}
					else if(grpby1.equalsIgnoreCase("model")){
						sqlgroupdet=" veh.vmodid";
						sqlselect=" veh.vmodid refno,model.vtype description";
					}
					else if(grpby1.equalsIgnoreCase("group")){
						sqlgroupdet=" veh.vgrpid";
						sqlselect=" veh.vgrpid refno,grp.gname description";
					}
					else if(grpby1.equalsIgnoreCase("yom")){
						sqlgroupdet=" veh.yom";
						sqlselect=" veh.yom refno,yom.yom description";
					}
					else{
						
					}
					
					
				
					sqlgroup+=sqlgroupdet;
				}
				String sumsql="";
				if(cmbfrequency.equalsIgnoreCase("2") || cmbfrequency.equalsIgnoreCase("3") || cmbfrequency.equalsIgnoreCase("4")){
					for(int i=0;i<=txtfrequency;i++){
				    	 sumsql+="(sum(amount"+i+"))*-1 amount"+i+",";
				     }		
				}
				else{
//					System.out.println("Yom freq:"+txtfrequency);
					for(int i=0;i<txtfrequency;i++){
				    	 sumsql+="(sum(amount"+i+"))*-1 amount"+i+",";
				     }		
				}
		     
		     
				/* sql="select "+sumsql+",@i:=@i+1 id,refno,description from  (select "+sql3+" "+sqlselect+" from my_costtran cost left join gl_invm inv on"+
						" cost.tr_no=inv.tr_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on"+
						" ac.catid=cat.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_ragmt ragmt"+
						" on (inv.ratype='RAG' and inv.rano=ragmt.doc_no) left join gl_lagmt lagmt on (inv.ratype='LAG' and inv.rano=lagmt.doc_no) "+
						" left join my_salesman rarla on (ragmt.raid=rarla.doc_no"+
						" and rarla.sal_type='RLA') left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+") f"+sqlgroup+",(SELECT @i:= 0) as i"; 
*/
		     /*sql="select "+sumsql+"@i:=@i+1 id,refno,description,0.0 amount from ("+
		    		 " select "+sql3+" "+sqlselect+"  from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where h.den=110 and j.status=3 "+sqltest+" ) bb,(SELECT @i:= 0) as i group by refno";*/
				/*
				sql="select "+sumsql+"refno,description,amount,id from (select "+sql3+""+sqlselect+",@i:=@i+1 id,0.0 amount from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no,(select @i:=0) as i where h.den=110 and j.status=3 "+sqltest+")a group by refno";*/
				
				if(cmbfrequency.equalsIgnoreCase("1") || cmbfrequency.equalsIgnoreCase("2")  || cmbfrequency.equalsIgnoreCase("3")  || cmbfrequency.equalsIgnoreCase("4")){
					sql=" select "+sumsql+""+sqlselect+",a.amount,@i:=@i+1 id from ( select (select @i:=0) as i,"+sql3+"c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no from my_costtran c "+
							" inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3 "+sqlcommon+")a"+
							" left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO')"+
							" and a.tr_no=cno.tr_no) left join my_head cnohead on (cno.acno=cnohead.doc_no and cnohead.dtype='CRM')"+
							" left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cnohead.cldocno=ac.cldocno) and ac.dtype='CRM') left join my_clcatm"+
							" cat on ac.catid=cat.doc_no left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+" group by refno order by id";					
				}
				else{
					sql=" select "+sqlselect+",a.amount,"+sql3+"@i:=@i+1 id from ( select (select @i:=0) as i,c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no from my_costtran c "+
							" inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3 "+sqlcommon+")a"+
							" left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO')"+
							" and a.tr_no=cno.tr_no) left join my_head cnohead on (cno.acno=cnohead.doc_no and cnohead.dtype='CRM')"+
							" left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cnohead.cldocno=ac.cldocno) and ac.dtype='CRM') left join my_clcatm"+
							" cat on ac.catid=cat.doc_no left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+" group by refno order by id";					
				}

//				System.out.println("check sql: "+sql);
			 ArrayList<String> amtarray=new ArrayList<>();
			
			 
			 
				 ResultSet resultSet = stmtBalance.executeQuery(sql);

				 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="",netamount="";
	/*		 
			 for(int i=0;i<temparray.size();i++){
				 System.out.println("For i"+i);
				 String amtsql="select @i:=@i+1 id,f.* from  (select sum(if(amount<0,amount*-1,amount)) amount from my_costtran cost left join gl_invm inv on"+
							" cost.tr_no=inv.tr_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on"+
							" ac.catid=cat.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_ragmt ragmt"+
							" on (inv.ratype='RAG' and inv.rano=ragmt.doc_no) left join gl_lagmt lagmt on (inv.ratype='LAG' and inv.rano=lagmt.doc_no) "+
							" left join my_salesman rarla on (ragmt.raid=rarla.doc_no"+
							" and rarla.sal_type='RLA') left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+temparray.get(i)+" "+sqlgroup+") f,(SELECT @i:= 0) as i"; 
				// System.out.println("Amtsql: "+amtsql);
				 Statement stmtamt=conn.createStatement();
				 ResultSet rsamt=stmtamt.executeQuery(amtsql);
				 while(rsamt.next()){
					 amtarray.add(rsamt.getString("amount"));
				 }
				 System.out.println("Check temp:"+temparray.get(i));
				 System.out.println(amtarray);
				 
			 }*/
			// System.out.println("Amountlength: "+amountLength);
			// System.out.println("Temparray size:"+temparray.size());
			// System.out.println("Amtarray size:"+amtarray.size());
							while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();

					
					
					
					
				     
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("refno"));
					temp.add(resultSet.getString("description"));
					temp.add(resultSet.getString("amount"));
					//System.out.println(amtarray);
					for (int l = 0; l < amountLength; l++) {
						temp.add(resultSet.getString("amount"+l+""));
						//temp.add(amtarray.get(l)+"l");
					}
					
					analysisrowarray.add(temp);
				}
				
			 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
			// System.out.println("analysisarray = "+analysisarray);
			 }
			 
			 stmtBalance.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[8]);
			}
			/*if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregatesrenderer","rendererstring");
			}*/
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("refno",analysisRowArray.get(1));
			obj.put("description",analysisRowArray.get(2));
			obj.put("amount",analysisRowArray.get(3));
			for (int j = 4,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}

	
	public JSONArray getChart(String grpby1,String fromdate,String todate,String branch,String id) throws Exception {
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			  String sqltest="";
			  java.sql.Date sqlFromDate=null,sqlToDate=null;
			  if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				  sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
			  }
			  if(!todate.equalsIgnoreCase("") && todate!=null){
				  sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
			  }
			     if(sqlFromDate!=null){
						sqltest+=" and inv.date>='"+sqlFromDate+"'";
					}
					if(sqlToDate!=null){
						sqltest+=" and inv.date<='"+sqlToDate+"'";
					}
					if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA")){
						sqltest+=" and inv.brhid="+branch+"";
					}
					/*if(!hidclientcat.equalsIgnoreCase("")){
						sqltest+=" and cat.doc_no in ("+hidclientcat+")";
					}
					if(!hidclient.equalsIgnoreCase("")){
						sqltest+=" and ac.cldocno in ("+hidclient+")";
					}
					if(!hidsalesman.equalsIgnoreCase("")){
						sqltest+=" and sal.doc_no in ("+hidsalesman+")";
					}
					if(!hidrentalagent.equalsIgnoreCase("")){
						sqltest+=" and rarla.doc_no in ("+hidrentalagent+")";
					}
					if(!hidbrand.equalsIgnoreCase("")){
						sqltest+=" and veh.brdid in ("+hidbrand+")";
					}
					if(!hidmodel.equalsIgnoreCase("")){
						sqltest+=" and veh.vmodid in ("+hidmodel+")";
					}
					if(!hidgroup.equalsIgnoreCase("")){
						sqltest+=" and veh.vgrpid in ("+hidgroup+")";
					}
					if(!hidyom.equalsIgnoreCase("")){
						sqltest+=" and veh.yom in ("+hidyom+")";
					}*/
					String sqlgroup="";
					String sqlselect="";
					String sqlgroupdet="";
					if(grpby1.equalsIgnoreCase("")){
						sqlgroup=" group by ac.cldocno";
						sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,ac.refname description,ac.cldocno refno";

					}
					else{
						sqlgroup="group by";
						if(grpby1.equalsIgnoreCase("clientcat")){
							sqlgroupdet=" cat.doc_no";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,cat.cat_name description,cat.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("client")){
							sqlgroupdet=" ac.cldocno";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,ac.refname description,ac.cldocno refno";
						}
						else if(grpby1.equalsIgnoreCase("salesman")){
							sqlgroupdet=" sal.doc_no";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,sal.sal_name description,sal.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("rentalagent")){
							sqlgroupdet=" rarla.doc_no";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,rarla.sal_name description,sal.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("brand")){
							sqlgroupdet=" veh.brdid";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,brd.brand_name description,brd.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("model")){
							sqlgroupdet=" veh.vmodid";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,model.vtype description,model.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("group")){
							sqlgroupdet=" veh.vgrpid";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,grp.gname description,grp.doc_no refno";
						}
						else if(grpby1.equalsIgnoreCase("yom")){
							sqlgroupdet=" veh.yom";
							sqlselect=" round(if(cost.amount<0,cost.amount*-1,cost.amount),2) amount,yom.yom description,yom.doc_no refno";
						}
						else{
							
						}
						
						
					
						sqlgroup+=sqlgroupdet;
					}
					
				String sql="select sum(amount) amount,description,refno from  ("+
				" select "+sqlselect+" from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where h.den=110 and j.status=3 "+sqltest+") f group by refno";
//				System.out.println("chart sql: "+sql);
				Statement stmt=conn.createStatement();
				ResultSet rs=stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(rs);
			    stmt.close();
			    conn.close();
			     
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
		}
}
