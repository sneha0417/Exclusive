package com.dashboard.marketing.enquirylist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEnqiryListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray Searchclient(HttpSession session) throws SQLException {

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
	   	        
       
     	Connection conn = null;
        
		try {
	        String brch=session.getAttribute("BRANCHID").toString();
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			
            		String sql="select refname,cldocno from my_acbook where dtype='CRM' and brhid='"+brch+"' ";
          
            		ResultSet ress= stmtVeh1.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(ress);
            		stmtVeh1.close();
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray enquirylistsearch(String brnchval,String fromdate,String todate,String clientname,String srcno,String salid,String rds,String areaid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
       	if(!(clientname.equalsIgnoreCase(""))){
       		sqltest+=" and e.cldocno= "+clientname+" ";
       	}
       	if(!(srcno.equalsIgnoreCase(""))){
       		sqltest+=" and e.sourceid="+srcno+" ";
       	}
       	
    	if(!(salid.equalsIgnoreCase(""))){
       		sqltest+=" and ms.doc_no="+salid+" ";
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
       	if(rds.equalsIgnoreCase("EN")){
			sqltest+=" and e.enqstatus=0 ";
       		}
		 if(rds.equalsIgnoreCase("SU")){
				sqltest+=" and  e.enqstatus=1 ";
			}
		 if(rds.equalsIgnoreCase("ES")){
				sqltest+=" and e.enqstatus=2 ";
			}
		 if(rds.equalsIgnoreCase("QO")){
					sqltest+=" and  e.enqstatus=3 ";
				}
		 if(rds.equalsIgnoreCase("DE")){
					sqltest+=" and e.enqstatus=4 ";
				}
		
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
            		String sql="select e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,if(e.surveyed=1,'surveyed','not-surveyed') status,"
            				+ "	ce.txtname source from gl_enqm e  "
            				+ "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id"
            				+ "	 where e.status=3  and e.DATE>='"+sqlfromdate+"' and   e.DATE<='"+sqltodate+"'  "+sqltest+" ";
          System.out.println("--enquirylistsearch=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     			
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
	
	public JSONArray enquirylistExcel(String brnchval,String fromdate,String todate,String clientname,String srcno,String salid,String rds,String areaid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
       	if(!(clientname.equalsIgnoreCase(""))){
       		sqltest+=" and e.cldocno= "+clientname+" ";
       	}
        if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
       		sqltest+=" and ma.area_id="+areaid+" ";
       	}
       	
       	if(!(srcno.equalsIgnoreCase(""))){
       		sqltest+=" and e.sourceid="+srcno+" ";
       	}
       	
       	if(!(salid.equalsIgnoreCase(""))){
       		sqltest+=" and ms.doc_no="+salid+" ";
       	}
       	
       	if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+brnchval;
		}
    	if(rds.equalsIgnoreCase("EN")){
			sqltest+=" and enqstatus=0 ";
       		}
		 if(rds.equalsIgnoreCase("SU")){
				sqltest+=" and  enqstatus=1 ";
			}
		 if(rds.equalsIgnoreCase("ES")){
				sqltest+=" and enqstatus=2 ";
			}
		 if(rds.equalsIgnoreCase("QO")){
					sqltest+=" and  enqstatus=3 ";
				}
		 if(rds.equalsIgnoreCase("DE")){
					sqltest+=" and enqstatus=4 ";
				}
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
            		String sql="select if(e.enqtype=0,'General','Client') 'Type',e.date 'Date',e.voc_no 'Doc No', e.name 'Client',ms.sal_name 'Sales Man', e.mob 'Mobile',e.remarks 'Remarks',"
            				+ "	ce.txtname 'Source',if(e.surveyed=1,'surveyed','not-surveyed') Status from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no   "
            				+ "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id"
            				+ "	 where e.status=3  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" ";
          //  System.out.println("----"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     			
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
	
	 public JSONArray sourcedetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select doc_no docno,txtname source from cm_enqsource  order by doc_no";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 
	 public JSONArray salmdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select doc_no docno,sal_name salm from my_salm  order by doc_no";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public JSONArray getStatusCount(String fromdate,String todate,String barchval,String clientname,String srcno,String salid,String areaid) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
				Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			String sqltest="";
			try {

				//System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				java.sql.Date sdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date edate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		edate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
				if(!barchval.equalsIgnoreCase("a"))
	        	{
					sqltest+=" and e.brhid="+barchval;
	        	}
			 	if(!(clientname.equalsIgnoreCase(""))){
		       		sqltest+=" and e.cldocno= "+clientname+" ";
		       	}
		       	if(!(srcno.equalsIgnoreCase(""))){
		       		sqltest+=" and e.sourceid="+srcno+" ";
		       	}
		       	
		    	if(!(salid.equalsIgnoreCase(""))){
		       		sqltest+=" and ms.doc_no="+salid+" ";
		       	}
		    	
		    	if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
		       		sqltest+=" and ma.area_id="+areaid+" ";
		       	}
		       	
				/*String sqldata="select count(*) val,'Enquiry' stat,'EN' rds from gl_enqm where enqstatus=0 and status=3 and date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
						+ "select count(*) val,'Survey' stat,'SU' rds from gl_enqm where enqstatus=1  and status=3 and date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
						+ "select count(*) val,'Estimation' stat,'ES' rds from gl_enqm where enqstatus=2  and status=3 and date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
						+ "select count(*) val,'Quotation' stat,'QO' rds from gl_enqm where enqstatus=3  and status=3 and date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
						+ "select count(*) val,'Decline' stat,'DE' rds from gl_enqm where enqstatus=4  and status=3 and date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";*/
				
						String sqldata="select count(*) val,'Enquiry' stat,'EN' rds from gl_enqm e left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id where e.enqstatus=0 and e.status=3 and e.date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
								+ "select count(*) val,'Surveyed' stat,'SU' rds from gl_enqm e left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id where e.enqstatus=1  and e.status=3 and e.date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
								+ "select count(*) val,'Estimated' stat,'ES' rds from gl_enqm e left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id where e.enqstatus=2  and e.status=3 and e.date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
								+ "select count(*) val,'Quoted' stat,'QO' rds from gl_enqm e left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id where e.enqstatus=3  and e.status=3 and e.date between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
								+ "select count(*) val,'Decline' stat,'DE' rds from gl_enqm e left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm ms on ms.doc_no=ma.sal_id where e.enqstatus=4  and e.status=3 and e.date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";
				
				//	System.out.println("====m"+sqldata);
				resultSet = stmt.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
