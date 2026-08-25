package com.procurement.purchase.costcodesearch;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsCostCodeSearchDAO {
	ClsConnection ClsConnection=new ClsConnection();
	   ClsCommon ClsCommon=new ClsCommon();
	public JSONArray costunitsearch(HttpSession session,String typedocno,String docno,String refnames,String search) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	          
	          Connection conn = null; 
	         
	        try {
	           conn = ClsConnection.getMyConnection();
	        
	           Statement stmtmain = conn.createStatement();
	   
	           if(search.equalsIgnoreCase("yes")) {
	            
	            String sql="";
	            
	            if(typedocno.equalsIgnoreCase("1")) {
	             
	             sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "
	                + "my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
	            
	            } else {
	             
	              String costgroup="";String sqltest="",sqlcode9="";
	              Statement stmt=conn.createStatement();
	              
	              String sqls="select costtype,costgroup from my_costunit where costtype='"+typedocno+"' ";

	              ResultSet rs=stmt.executeQuery(sqls);
	              
	              if(rs.next()) {
	               costgroup=rs.getString("costgroup");
	              }
	              
	             if(!(refnames.equalsIgnoreCase("0")) && !(refnames.equalsIgnoreCase(""))){
	               sqltest=sqltest+" and customer like '%"+refnames+"%'";
	               sqlcode9=sqlcode9+" and ac.refname like '%"+refnames+"%'";
	          }
	             
	             if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
	                 sqltest=sqltest+" and m.doc_no='"+docno+"'";
	                 sqlcode9=sqlcode9+" and m.doc_no like '%"+docno+"%'";
	             }
	             
	             if(typedocno.equalsIgnoreCase("3") || typedocno.equalsIgnoreCase("4")) {
	              
	              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_srvcontrm m left join "
	               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.tr_no=m.tr_no where m.status=3  and m.dtype='"+costgroup+"'  "+sqltest+"";
	              
	             }
	             
	             if(typedocno.equalsIgnoreCase("5")) {
	              
	              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.contracttype,' ',m.contractno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_cuscallm m left join "
	               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.rowno=m.siteid where  m.status in(3)  "+sqltest+"";
	              }
	             
	             if(typedocno.equalsIgnoreCase("9")) {
		              
		              sql = "SELECT * FROM (select M.voc_no doc_no,M.doc_no tr_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) prjname,ac.refname customer,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3) and g.processstatus<6 "+sqlcode9+") M WHERE 1=1  ";
		         
	             }
	              
	              stmt.close();
	             
	            }
	            
	            
	           // System.out.println("SQL ="+sql);
	           ResultSet resultSet = stmtmain.executeQuery(sql);
	           RESULTDATA=ClsCommon.convertToJSON(resultSet);
	              
	           stmtmain.close();
	           conn.close();
	           }
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




public JSONArray fleetSearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement(); 


		String sql="select fleet_no fleetno ,flname fleetname,reg_no regno from gl_vehmaster where cost=0 ";
 
  
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}


	
}
