package com.dashboard.fixedasset.fixedassetissue;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;







import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsFixedAssetIssueDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray assetdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtBFAR = conn.createStatement();
   
            String sql="select sr_no asset_no,assetname from my_fixm where status=3";
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
	public JSONArray branchdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtBFAR = conn.createStatement();
   
            String sql="select doc_no,branchname from my_brch where status=3";
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
	
	 public JSONArray groupdetails() throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     Connection conn = null;
	       
	     try {
	    	 conn = ClsConnection.getMyConnection();
	    	 Statement stmtBFAR = conn.createStatement();
	   
	    	 String sql="select grp_name gname,doc_no from my_fagrp where status=3";
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

	 public JSONArray accountSearch() throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		          
		          Connection conn = null; 
		         
		        try {
		           conn = ClsConnection.getMyConnection();
		           Statement stmtmain = conn.createStatement();
		           
		           /*String sql="select description,account,doc_no from my_head where m_s=0 and atype='hr' ";*/
		           String sql="select m.name description,h.account,m.doc_no from hr_empm m left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1";
		           
		           ResultSet resultSet = stmtmain.executeQuery(sql);
		           RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          
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

	 public JSONArray amcSjobSearch(HttpSession session,String typedocno,String refnames,String check,String dtype) throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		          
		          Connection conn = null; 
		         
		        try {
		           conn = ClsConnection.getMyConnection();
		           ClsCommon ClsCommon=new ClsCommon();
		           Statement stmtmain = conn.createStatement();
		           
		           String sql="";
		           String sqltest="";
		         /*  if(!refnames.equalsIgnoreCase("")&&!refnames.equalsIgnoreCase("null")){
		        	   sqltest+=" and ac.refname like '"+refnames+"' ";
		           }
		           if(!typedocno.equalsIgnoreCase("")&&!typedocno.equalsIgnoreCase("null")){
		        	   sqltest+=" and m.cldocno like '"+typedocno+"' ";
		           }*/
		           if(check.equalsIgnoreCase("1")) {
		        	   
		        	   
		               sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
		               		+ "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
		               		+ "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' "+sqltest+" ;";           
		             
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

	
	public JSONArray getAssetList(String issue_stat,String grpno) throws SQLException {
	    
	    
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    		
	    		try {
					conn=ClsConnection.getMyConnection();

					Statement stmtassetlist = conn.createStatement ();
	            	String sqltest="";
	            	if(!grpno.equalsIgnoreCase("")&&!grpno.equalsIgnoreCase("0")){
	            		sqltest=" and grp.doc_no="+grpno+"";
	            	}
	            	
	        String strassetlist="select coalesce(trb.branchname,coalesce(loc.loc_name,ret.frombranch)) transferbranchfrom,ret.tobranch transferbranchto,ret.issuedretdate,ret.issuedescription,ret.jobnos jobno,ret.jobno type_no,ret.type type1,if(ret.type='amc','AMC','SJOB') type ,ret.name,asset.issue_status,asset.issuedt,asset.sr_no srno,coalesce(asset.trbrhid,asset.loc) assetbrhid,"
	            			+ "asset.doc_no,asset.assetid,asset.assetname,coalesce(grp.grp_name,'') assetgrp, coalesce(trb.branchname,loc.loc_name) assetloc, coalesce(ac.refname,'') supplier,"
	            			+ "asset.purefno prefno,asset.purdate pdate, asset.totpurval totalpval,coalesce(fix.description,'') fixedassetac,coalesce(accdep.description,'') accdeprac,"
	            			+ "coalesce(dep.description,'') deprac,convert(concat(' Asset ID : ',coalesce(asset.assetid), ' * ','Asset Name  : ',coalesce(asset.assetname),' * ','Asset Group : ' ,"
	            			+ "coalesce(grp.grp_name,''),' * ','Location : ', coalesce(loc.loc_name,'')),char(1000)) assetinfo from my_fixm asset left join my_fagrp grp on asset.assetgp=grp.doc_no left join my_faloc loc  on asset.loc=loc.doc_no  "
	            			+ "left join my_acbook ac on (asset.supacno=ac.acno and ac.dtype='VND') left join my_head fix on asset.fixastacno=fix.doc_no left join my_head accdep on "
	            			+ "asset.accdepacno=accdep.doc_no left join  my_head dep on  asset.depacno=dep.doc_no  left join(select max(doc_no)mdocno,asset_no,trbrhid_to from gl_bfai group by asset_no) dc "
	            			+ "on dc.asset_no=asset.sr_no  left join (select fa.doc_no fadoc,fa.jobtype,fa.jobno,trbf.branchname frombranch,trbt.branchname tobranch,if(issuedstatus=2,coalesce(fa.issuedt,fa.returneddt),null) issuedretdate,fa.description issuedescription,"
	            			+ "m.doc_no,m.issue_status,m.issuedt,coalesce(e.name,ac.refname) name ,fa.jobtype type,cm.doc_no jobnos from my_fixm m left join gl_bfai fa on m.sr_no=fa.asset_no  left join hr_empm e on e.doc_no=fa.empid "
	            			+ "left join cm_srvcontrm cm on cm.tr_no=fa.jobno and cm.dtype=fa.jobtype left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='CRM' left join my_brch trbf on trbf.doc_no=fa.trbrhid_from "
	            			+ "left join my_brch trbt on trbt.doc_no=fa.trbrhid_to where fa.jobtype in('SJOB','AMC'))  ret on ret.doc_no=asset.doc_no  and ret.fadoc=dc.mdocno left join my_brch trb on trb.doc_no=asset.trbrhid where asset.status=3 "
	            			+ "and asset.issue_status in ("+issue_stat+") "+sqltest; 
	            	
	      	        ResultSet resultSet = stmtassetlist.executeQuery(strassetlist);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtassetlist.close();
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
	
	public JSONArray getAssetListExcel(String issue_stat,String grpno,String issuestatus) throws SQLException {
	    
	    
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    		
	    		try {
					conn=ClsConnection.getMyConnection();

					Statement stmtassetlist = conn.createStatement ();
	            	String sqltest="",conditionalcolumns="";
	            	if(!grpno.equalsIgnoreCase("")&&!grpno.equalsIgnoreCase("0")){
	            		sqltest=" and grp.doc_no="+grpno+"";
	            	}
	            	
	            	if(!issuestatus.equalsIgnoreCase("")&&!issuestatus.equalsIgnoreCase("0")){
	            		if(issuestatus.equalsIgnoreCase("tfr")){
	            			conditionalcolumns=",if(ret.type='amc','AMC','SJOB') 'Job Type',ret.jobnos 'Job No',ret.name 'Issued To',asset.issuedt 'Issued On',coalesce(trb.branchname,coalesce(loc.loc_name,ret.frombranch)) 'Transfered From',ret.tobranch 'Transfered To',ret.issuedescription 'Description' ";
	            		} else if(issuestatus.equalsIgnoreCase("ret")){
	            			conditionalcolumns=",if(ret.type='amc','AMC','SJOB') 'Job Type',ret.jobnos 'Job No',ret.name 'Issued To',asset.issuedt 'Issued On',ret.issuedretdate 'Returned On',ret.issuedescription 'Description' ";
	            		}
	            	}
	            	
	        String strassetlist="select asset.assetid 'Asset Id',asset.assetname 'Asset Name',coalesce(grp.grp_name,'') 'Asset Group', coalesce(trb.branchname,loc.loc_name) 'Asset Location', coalesce(ac.refname,'') 'Supplier'"+conditionalcolumns+" "
	            			+ "from my_fixm asset left join my_fagrp grp on asset.assetgp=grp.doc_no left join my_faloc loc  on asset.loc=loc.doc_no  "
	            			+ "left join my_acbook ac on (asset.supacno=ac.acno and ac.dtype='VND') left join my_head fix on asset.fixastacno=fix.doc_no left join my_head accdep on "
	            			+ "asset.accdepacno=accdep.doc_no left join  my_head dep on  asset.depacno=dep.doc_no  left join (select max(doc_no)mdocno,asset_no,trbrhid_to from gl_bfai group by asset_no) dc "
	            			+ "on dc.asset_no=asset.sr_no  left join (select fa.doc_no fadoc,fa.jobtype,fa.jobno,trbf.branchname frombranch,trbt.branchname tobranch,if(issuedstatus=2,coalesce(fa.issuedt,fa.returneddt),null) issuedretdate,fa.description issuedescription,"
	            			+ "m.doc_no,m.issue_status,m.issuedt,coalesce(e.name,ac.refname) name ,fa.jobtype type,cm.doc_no jobnos from my_fixm m left join gl_bfai fa on m.sr_no=fa.asset_no left join hr_empm e on e.doc_no=fa.empid "
	            			+ "left join cm_srvcontrm cm on cm.tr_no=fa.jobno and cm.dtype=fa.jobtype left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='CRM' left join my_brch trbf on trbf.doc_no=fa.trbrhid_from "
	            			+ "left join my_brch trbt on trbt.doc_no=fa.trbrhid_to where fa.jobtype in('SJOB','AMC'))  ret on ret.doc_no=asset.doc_no  and ret.fadoc=dc.mdocno left join my_brch trb on trb.doc_no=asset.trbrhid where asset.status=3 "
	            			+ "and asset.issue_status in ("+issue_stat+") "+sqltest; 
	            	
	      	        ResultSet resultSet = stmtassetlist.executeQuery(strassetlist);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtassetlist.close();
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
