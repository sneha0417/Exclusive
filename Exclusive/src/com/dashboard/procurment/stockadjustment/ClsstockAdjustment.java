package com.dashboard.procurment.stockadjustment;

	import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	public class ClsstockAdjustment  { 
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();

		public JSONArray gridDataLoad() throws SQLException {
			   JSONArray RESULTDATA=new JSONArray();
			         Connection conn = null;
			         
			  try {
			   conn = ClsConnection.getMyConnection();
			   Statement stmtCRM = conn.createStatement();
			   String sqltest="";
			      java.sql.Date  sqlDate = null;
			         
			         String sql="select em.doc_no enqno,d.doc_no,m.jobno,m.cldocno,ac.refname client,sc.refno,sl.sal_name salesman,m.remarks desc1,ed.pol,ed.pod,d.qty,"
			           + " ed.modeid,ed.smodeid,ed.shipid,md.modename mode,sm.submode smode,sp.shipment "
			           + " from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' left join cr_enqd ed on em.doc_no=ed.rdocno"
			           + " left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_salesman sl on ac.sal_id=sl.doc_no"
			           + " left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.modeid left join cr_shipment sp on sp.doc_no=ed.shipid"
			           + " left join cm_srvcontrm sc on sc.tr_no=m.jobno where m.jobno>0 and d.agtype>0 and d.pstatus=0 ";
			    System.out.println("--enqrysql--"+sql);
			         ResultSet resultSet = stmtCRM.executeQuery (sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    stmtCRM.close();
			    conn.close();
			      
			  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
			  }finally{
			   conn.close();
			  }
			        return RESULTDATA;
			    }
		
		
		
		public JSONArray assetdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
	        	conn = ClsConnection.getMyConnection();
	        	Statement stmtBFAR = conn.createStatement();
	   
	            String sql="select psrno,part_no productid,ProductName name  from my_main where status=3";
	            ResultSet resultSet = stmtBFAR.executeQuery(sql);
	            
	           RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	           stmtBFAR.close();
	           conn.close();
	       
	           }catch(Exception e){
	        	   e.printStackTrace();
	        	   conn.close();
	           }finally{
	   			conn.close();
	   		}
	        return RESULTDATA;
	    }
		
		
}

