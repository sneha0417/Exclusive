package com.dashboard.fixedasset.fixedassetissuelist;


	
	import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import javax.servlet.http.HttpSession;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import net.sf.json.JSONArray;

	public class ClsFixedAssetIssueListDAO {
		
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
			           ClsCommon ClsCommon=new ClsCommon();
			           Statement stmtmain = conn.createStatement();
			           /*String sql="select description,account,doc_no from my_head where m_s=0 and atype='hr' ";*/
			           
			           String sql = "select m.name description,h.account,m.doc_no from hr_empm m left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1";

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
			           System.out.println("SQL amc sjob =");
			           String sql="";
			           String sqltest="";
			         /*  if(!refnames.equalsIgnoreCase("")&&!refnames.equalsIgnoreCase("null")){
			        	   sqltest+=" and ac.refname like '"+refnames+"' ";
			           }
			           if(!typedocno.equalsIgnoreCase("")&&!typedocno.equalsIgnoreCase("null")){
			        	   sqltest+=" and m.cldocno like '"+typedocno+"' ";
			           }*/
			           if(check.equalsIgnoreCase("1")) {
			        	   
			        	   
			               Statement stmt=conn.createStatement();
			               sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
			               		+ "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
			               		+ "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' "+sqltest+" ;";           
			              stmt.close();
			             
			           System.out.println("SQL amc sjob ="+sql);
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

		
		public JSONArray getAssetList(String issuedstatus,String fromdate,String todate,String grpno,String check,String empid) throws SQLException {
		    
		    
		    JSONArray RESULTDATA=new JSONArray();
		    
		   // System.out.println("========"+check);
		    
		    if(!(check.equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    Connection conn =null;
		    		
		    		try {
						conn=ClsConnection.getMyConnection();

						Statement stmtassetlist = conn.createStatement ();
		            	String sqltest="";
		            	java.sql.Date sqlFromDate = null;
					     java.sql.Date sqlToDate = null;
					        
					     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
					     }
					     
					     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
					     }
					     
					     if(!grpno.equalsIgnoreCase("")&&!grpno.equalsIgnoreCase("0")){
			            		sqltest=" and grp.doc_no="+grpno+"";
			            	}
					     
					     if(!empid.equalsIgnoreCase("")&&!empid.equalsIgnoreCase("0")){
			            		sqltest=" and bf.empid="+empid+"";
			            	}
					     if(!issuedstatus.equalsIgnoreCase("")&&!issuedstatus.equalsIgnoreCase("0")){
			            		sqltest=" and bf.issuedstatus="+issuedstatus+"";
			            	}
		            	
		            	
		            	String strassetlist="select m.assetid,m.assetname,coalesce(grp.grp_name,'') assetgrp,CASE WHEN bf.issuedstatus=1 THEN 'TRANSFER' WHEN bf.issuedstatus=2"
		            						+" THEN 'ISSUED' WHEN bf.issuedstatus=3 THEN 'RETURNED' ELSE '' END AS issuedstatus,coalesce(bf.issuedt,bf.returneddt) date,"
		            						+ "coalesce(h.name,'') empname,UPPER(bf.jobtype) jobtype,CONVERT(if(bf.jobno=0,'',bf.jobno),CHAR(100)) jobno,coalesce(b.branchname,'') assetloc  from gl_bfai bf left join my_fixm m on bf.asset_no=m.sr_no "
		            						+"left join my_fagrp grp on m.assetgp=grp.doc_no left join hr_empm h on bf.empid=h.doc_no "
		            						+"left join my_brch b on bf.trbrhid_to=b.doc_no where bf.status=3 and m.status=3 and coalesce(bf.issuedt,bf.returneddt)>='"+sqlFromDate+"'"
		            						+"and coalesce(bf.issuedt,bf.returneddt)<='"+sqlToDate+"'"+sqltest+"";
		            	
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
public JSONArray getAssetListExcel(String issuedstatus,String fromdate,String todate,String grpno,String check,String empid) throws SQLException {
		    
		    
		    JSONArray RESULTDATA=new JSONArray();
		    
		   // System.out.println("========"+check);
		    
		    if(!(check.equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    Connection conn =null;
		    		
		    		try {
						conn=ClsConnection.getMyConnection();

						Statement stmtassetlist = conn.createStatement ();
		            	String sqltest="";
		            	java.sql.Date sqlFromDate = null;
					     java.sql.Date sqlToDate = null;
					        
					     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
					     }
					     
					     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
					     }
					     
					     if(!grpno.equalsIgnoreCase("")&&!grpno.equalsIgnoreCase("0")){
			            		sqltest=" and grp.doc_no="+grpno+"";
			            	}
					     
					     if(!empid.equalsIgnoreCase("")&&!empid.equalsIgnoreCase("0")){
			            		sqltest=" and bf.empid="+empid+"";
			            	}
					     if(!issuedstatus.equalsIgnoreCase("")&&!issuedstatus.equalsIgnoreCase("0")){
			            		sqltest=" and bf.issuedstatus="+issuedstatus+"";
			            	}
		            	
		            	
		            	String strassetlist="select m.assetid 'Asset ID',m.assetname 'Asset Name',coalesce(grp.grp_name,'') 'Asset Group',CASE WHEN bf.issuedstatus=1 THEN 'TRANSFER' WHEN bf.issuedstatus=2"
		            						+" THEN 'ISSUED' WHEN bf.issuedstatus=3 THEN 'RETURNED' ELSE '' END AS 'Status',coalesce(bf.issuedt,bf.returneddt) 'Date',"
		            						+ "coalesce(h.name,'') 'Employee',UPPER(bf.jobtype) 'Job Type',CONVERT(if(bf.jobno=0,'',bf.jobno),CHAR(100)) 'Job no',coalesce(b.branchname,'') 'Asset Location' from gl_bfai bf left join my_fixm m on bf.asset_no=m.sr_no "
		            						+"left join my_fagrp grp on m.assetgp=grp.doc_no left join hr_empm h on bf.empid=h.doc_no "
		            						+"left join my_brch b on bf.trbrhid_to=b.doc_no where bf.status=3 and m.status=3 and coalesce(bf.issuedt,bf.returneddt)>='"+sqlFromDate+"'"
		            						+"and coalesce(bf.issuedt,bf.returneddt)<='"+sqlToDate+"'"+sqltest+"";
		            	
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

