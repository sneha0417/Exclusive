package com.dashboard.salik.salikdetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalikdetailsDAO

{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	public  JSONArray postingDetails(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
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
        
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
		
 
            		String sql="select count(*) VALUE,'Posted' status,'POS' relodestatus from gl_salik  " + 
            				"  where postdocno>0 and isallocated=1 and inv_no>0 and status in (1) and  DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";  
            		
            		
            	//	System.out.println("------------"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	public  JSONArray subDetails(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        
        
        
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
        
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced
		
            		String sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik where isallocated=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') aa union all  "
            				+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik where isallocated=1 and inv_no=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') union all "
            				+ " (select count(*) VALUE,'Invoiced' status,'AIN' relodestatus from gl_salik where isallocated=1 and inv_no>0 and status in (1) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') "
            						+ "union all \r\n" + 
            						" (select count(*) value,'Received' status ,'RES' relodestatus from gl_salik  s inner join gl_invm m on \r\n" + 
            						"        m.doc_no=s.inv_no    inner join (select sum(amount) amt,rdocno from gl_invd where chid in (8,14) \r\n" + 
            						"        group by rdocno) d on m.doc_no=d.rdocno    inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno \r\n" + 
            						"            where (j.dramount-j.out_amount)=0  	and s.isallocated=1 and s.inv_no>0 \r\n" + 
            						"       and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d')  between '"+sqlfromdate+"' and  '"+sqltodate+"')  ";
         //  System.out.println("=====sql===="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray masterdetails(String code,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
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
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced
		if(code.equalsIgnoreCase("UAL"))
		{
            		String sql="select s.regno,s.tagno,coalesce(s.fleetno,'') fleetno, salik_date ,salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no from gl_salik s "
            				+ " where s.isallocated=0 and s.status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
                 //   System.out.println("==1===sql===="+sql);
               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     	
		}
		
		else if(code.equalsIgnoreCase("ANI"))
		{
     				
/*     				String sql="select s.regno,s.tagno,s.fleetno, s.salik_date ,s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no from gl_salik s  "
     						+ " where isallocated=1 and inv_no=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";*/
			
			
				String sql=" select   case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
 						+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',  "
 						+ "	case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
 						+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',s.regno,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction, "
 						+ " s.source,convert(coalesce(s.amount,''),char(100)) amount "
 						+ " from gl_salik s   left join gl_ragmt ragmt on  (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
 						+ "	left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
 						+ " where s.isallocated=1 and s.inv_no=0 and s.status in (0,3) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
			
			
			
     	           // System.out.println("===2==sql===="+sql);
               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
		}
		
		else if(code.equalsIgnoreCase("AIN"))
		{
		/*	String sql="select s.regno,s.tagno,s.fleetno,  s.salik_date ,s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no from gl_salik s  "
					+ " where isallocated=1 and inv_no>0 and status in (1) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
			
			*/
			String sql="select  m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano', "
					+ "s.regno,   coalesce(ac.refname,sa.sal_name) refname,     s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount  "
					+ " from gl_salik s   left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=s.inv_no     left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type  "
					+ "  left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type     where s.isallocated=1 and s.inv_no>0 and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
		 
			 
			
             //System.out.println("===3=sql===="+sql);
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
		else if(code.equalsIgnoreCase("RES"))
		{
	 
			
			
			String sql="select  j.out_amount,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano' ,  "
					+ " s.regno,    coalesce(ac.refname,sa.sal_name) refname,     s.tagno,s.fleetno,  s.salik_date ,s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount  "
					+ " from gl_salik s   left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=s.inv_no  "
					+ "inner join (select sum(amount) amt,rdocno from gl_invd where chid in (8,14) group by rdocno) d on m.doc_no=d.rdocno \r\n"  
					+ " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno    left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type    "
					+ "    left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type     where (j.dramount-j.out_amount)=0 and s.isallocated=1 and s.inv_no>0 and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
		 //	System.out.println("-----asdasd-1-----"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
/*		else if(code.equalsIgnoreCase("POS")) // 
		{
			String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
					+ " where isallocated=1 and inv_no>0 and status in (1);";
			
			
			String sql="select   t.postdocno,m.voc_no invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno,  "
					+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,t.location, convert(coalesce(t.amount,''),char(100)) amount  "
					+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=t.inv_no  where t.postdocno>0 and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";
			////System.out.println("-----asdasd--sssssss----"+sql);
			 
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}		
            	*/
        conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
