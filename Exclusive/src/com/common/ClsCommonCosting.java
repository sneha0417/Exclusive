package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
  
@SuppressWarnings("serial")  
public class ClsCommonCosting extends ActionSupport {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
    
    public  JSONArray accountGridLoading(String branch,String dtype,String docno) throws SQLException {
    	Connection conn=null;
    	JSONArray RESULTDATA=new JSONArray();

        try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCost = conn.createStatement();
		       
		       String  sql="select j.acno docno,h.account,h.description accountname,h.gr_type,j.id,if(j.dramount<0,round(j.dramount*j.id,2),round(j.dramount,2)) amount,if(j.id<0,true,false) cr,j.tr_no trno,j.tranid from my_jvtran j left join my_head h on j.acno=h.doc_no where h.gr_type in (4,5) and  j.dtype='"+dtype+"' and j.brhid="+branch+" and j.doc_no="+docno+"";

		       ResultSet resultSet = stmtCost.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtCost.close();
		       conn.close();
		     } catch(Exception e){
					e.printStackTrace();
					conn.close();
			 } finally{
					conn.close();
			 }
           return RESULTDATA;
       }
    
    public  JSONArray costGridLoading(String tranid,String check) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    String sql = null;
	            
				conn = connDAO.getMyConnection();
				Statement stmtCost = conn.createStatement();
				
				if(!(tranid.equalsIgnoreCase("0"))){
					sql="select c.tr_no,c.costtype,c.jobid costcode,CASE WHEN c.costtype in (3,4) THEN sr.doc_no WHEN c.costtype=5 THEN cal.doc_no ELSE c.jobid END AS costcodes,if(c.amount<0,round(c.amount*-1,2),round(c.amount,2)) amount,f.costgroup "
							+ "from my_costtran c left join my_jvtran j on (c.tranid=j.tranid) left join my_costunit f on c.costtype=f.costtype left join cm_srvcontrm sr on c.jobid=sr.tr_no left join cm_cuscallm cal on c.jobid=cal.tr_no where c.tranid="+tranid+"";
				}
				
				if(check.equalsIgnoreCase("1")){
					ResultSet resultSet = stmtCost.executeQuery(sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
				}
				else{
					stmtCost.close();
					conn.close();
					return RESULTDATA;
				}
				stmtCost.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
  
    public  JSONArray costTypeSearch() throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
				ResultSet resultSet = stmtVehclr.executeQuery ("select costtype,costgroup from my_costunit where status=1");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
    
    public  JSONArray costCodeSearch(String type) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	  
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
			
				/* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* AMC & SJOB */
	        	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
	        	{
	        		String dtype="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		String sql="select m.tr_no doc_no,m.doc_no code,a.refname name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.tr_no doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Fleet */
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* IJCE */
	        	else if(type.equalsIgnoreCase("7"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from is_jobmaster m left join my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
}
