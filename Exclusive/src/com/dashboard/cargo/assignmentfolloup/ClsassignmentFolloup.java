package com.dashboard.cargo.assignmentfolloup;


	
	import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
import com.connection.ClsConnection;

	public class ClsassignmentFolloup  { 
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();

		public JSONArray gridDataLoad(String branch,String fromdate,String todate) throws SQLException {
			   JSONArray RESULTDATA=new JSONArray();
			   
			   
			   
			   Connection conn = null;
			         
			  try {
			   conn = ClsConnection.getMyConnection();
			   Statement stmtCRM = conn.createStatement();
			   
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
			    
			      java.sql.Date  sqlDate = null; 
			      String sqltest="";
			      
			      System.out.println("branch"+branch);
			      
			    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    		sqltest+=" and m.brhid='"+branch+"'";
			 		}
			         String sql="select s.name cur_status,sb.sname cur_substatus,d.typeid,cc.doc_no adocno,m.brhid,em.voc_no enqno,d.doc_no,sc.doc_no jobno ,m.cldocno,ac.refname client,sc.refno,sl.sal_name salesman,"
			         		+ " m.remarks desc1,ed.pol,ed.pod,d.qty,sv.srvtype ,'ATTACH' attach,"
			           + " ed.modeid,ed.smodeid,ed.shipid,md.modename mode,sm.submode smode,sp.shipment "
			           + " from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' "
			           + "left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno 	left join cr_joblist l on l.enqdocno=ed.doc_no left join cr_srvtype sv on d.typeid=sv.doc_no "
			           + " left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_salm sl on ac.sal_id=sl.doc_no"
			           + " left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.modeid left join cr_shipment sp on sp.doc_no=ed.shipid"
			           + "  left join cm_srvcontrm sc on sc.tr_no=l.jobno left join cr_assignment cc on cc.rdocno=d.doc_no and l.jobno=cc.jobno "
			           +" left join cr_cstatus s on s.doc_no=cc.cur_status left join cr_cstatusd sb on sb.doc_no=cc.cur_substatus "
			           + "where cc.doc_no is not null and cc.pstatus=0 and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"'    and l.jobno>0  "+sqltest+" group by l.jobno,d.typeid ";
			         System.out.println("  sql"+sql);

			         
			         
			         
			         
				     /* 	String sql="	select l.jobno jobtrno,sc.doc_no jobno, m.brhid,em.voc_no enqno,d.doc_no,m.cldocno,ac.refname client,d.billing, av.refname vendor,sc.refno, "
				      			+ "sl.sal_name salesman,m.remarks desc1,ed.pol,ed.pod,d.qty, ed.modeid,ed.smodeid,ed.shipid,md.modename mode,sm.submode "
				      			+ "	smode,sp.shipment,sv.srvtype  from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno "
				      			+ "	left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ'  left join cr_enqd ed on em.doc_no=ed.rdocno "
				      			+ "	left join cr_joblist l on l.enqdocno=ed.doc_no "
				      			+ "left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' "
				      			+ "	left join my_acbook av on d.vndid=av.cldocno and av.dtype='VND' "
				      			+ "left join my_salesman sl on ac.sal_id=sl.doc_no left join cr_mode md on md.doc_no=ed.modeid "
				      			+ "	 left join cr_smode sm on sm.doc_no=ed.modeid  left join cr_srvtype sv on d.typeid=sv.doc_no "
				      			+ "  left join cr_shipment sp on sp.doc_no=ed.shipid left join cm_srvcontrm sc on sc.tr_no=l.jobno"
				      			+ " left join cr_assignment cc on cc.rdocno=d.doc_no and l.jobno=cc.jobno  "
				      			+ "	  where cc.doc_no is null    group by l.jobno,d.typeid";
			         */
			         
	  // System.out.println("--enqrysql--"+sql);
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
	   
	            String sql="select doc_no,name from cr_cstatus where status=3";
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
		public JSONArray substatusdetails(String txtsdocno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
	        	conn = ClsConnection.getMyConnection();
	        	Statement stmtBFAR = conn.createStatement();
	   
	            String sql="SELECT sname name,doc_no FROM cr_cstatusd c where  rdocno="+txtsdocno+" and status=3 ;";
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
