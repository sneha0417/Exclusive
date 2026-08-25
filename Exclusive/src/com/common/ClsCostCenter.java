package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;

public class ClsCostCenter {
	ClsConnection ClsConnection=new ClsConnection();

	public  JSONArray costCodeSearch(String type) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	  
		try {
				Connection conn = ClsConnection.getMyConnection();
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
	        		
	        		String sql="select m.tr_no,m.doc_no code,a.refname name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
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
				/* Contract */
	        	else if(type.equalsIgnoreCase("8"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name from hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
				
				/* Job Card */
	        	else if(type.equalsIgnoreCase("9"))
	        	{
	        		String sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1";
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
	
	public  JSONArray costTypeSearch() throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
				ResultSet resultSet = stmtVehclr.executeQuery ("select costtype,costgroup from my_costunit where status=1;");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
}
