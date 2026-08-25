package com.dashboard.salik;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsSalikDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray regsearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     
        
     	Connection conn =null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();

				 String sql="select reg_no from gl_vehmaster where statu=3";

            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
		
        return RESULTDATA;
    }
	public JSONArray tagsearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     
        
     	Connection conn =null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();

				 String sql="select salik_tag from gl_vehmaster where statu=3";

            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
		
        return RESULTDATA;
    }
	
	
	
	public  JSONArray unallocation(String update,String tagno,String regno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
    	try {    
        java.sql.Date sqluptodate = null;
        
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     
    	
    	
    	String sqltest="";
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and tagno='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and regno='"+regno+"' ";
    	}
     	
       
	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();

				 String sql="select regno,tagno,salik_date,  salik_time,  fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=0 and status in (0,3) and sal_date<='"+sqluptodate+"' " +sqltest;
System.out.println("------------------"+sql);
            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray allocationlist(String update,String tagno,String regno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqluptodate = null;
        
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     
    	
    	
    	String sqltest="";
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and s.tagno='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and s.regno='"+regno+"' ";
    	}
    	
     	Connection conn =null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement();

				/* String sql="select regno,tagno,salik_date,fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=1 and sal_date<='"+sqluptodate+"' "+sqltest;*/
				 
				 
				 String sql="select  s.regno,s.tagno,s.salik_date,  s.salik_time,  s.fleetno,s.trans,round(s.AMOUNT,2) AMOUNT, "
				 		+ " if(s.reason is null,'',reason) reason, case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
				 		+ "s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',convert(coalesce(s.branch,''),char(30)) branch  "
				 		+ " from gl_salik s	 left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))   "
				 		+ " left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) where s.ISALLOCATED=1 "
				 		+ " and s.sal_date<='"+sqluptodate+"' "+sqltest;
				 
				//System.out.println("------sql---"+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				
            	stmtVeh.close();
 				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
	
	
	public JSONArray notInvoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			  	conn = ClsConnection.getMyConnection();
			    Statement stmtSailk = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.sal_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and a.cldocno='"+cldocno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		        if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
				
				
				sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
						" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
						" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
						" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
				//System.out.println("not invoiced salik query: "+sql);
				ResultSet resultSet = stmtSailk.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtSailk.close();
			    conn.close();
		
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray invoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSailk = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.sal_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and ac.cldocno like '%"+cldocno+"%'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		        if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no like '%"+agmtNo+"%'";
		           }
				
				sql = "select s.sr_no,case when s.rtype in ('RM','RA', 'RD','RW','RF') then r.voc_no when s.rtype in ('LA','LC')  then l.voc_no\r\n" + 
						"else s.ra_no end as 'rano',\r\n" + 
						"case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT'\r\n" + 
						"when s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',\r\n" + 
						"m.voc_no invno,\r\n" + 
						"coalesce(ac.refname,sa.sal_name) refname,\r\n" + 
						
						"s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,ac.refname\r\n" + 
						" from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')\r\n" + 
						" or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF')) left join gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC'))\r\n" + 
						
						" left join gl_status st on s.rtype=st.Status\r\n" + 
						"left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type\r\n" + 
						"left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type\r\n" + 
						"left join gl_invm m on s.inv_no=m.doc_no and s.inv_type='INV' left join my_jvtran j on s.inv_no=j.doc_no and s.inv_type='JVT' where s.inv_no!=0 and s.isallocated=1 "
					+ ""+sql+" group by s.sr_no";
				
			    ResultSet resultSet = stmtSailk.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtSailk.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray staffAllocatedGridLoading(String branch,String fromDate, String toDate, String type, String employee) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSailk = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and s.branch="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.sal_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(type.equalsIgnoreCase(""))){
		        	if(type.equalsIgnoreCase("STF")){
		        		sql+=" and s.emp_type='STF'";
		        	}
		        	else if(type.equalsIgnoreCase("DRV")){
		        		sql+=" and s.emp_type='DRV'";
		        	}
		         }
		        
		        if(!(employee.equalsIgnoreCase(""))){
		        	sql+=" and s.emp_id like '%"+employee+"%'";
		           }
				
				sql = "select s.doc_no,s.sr_no,s.emp_id,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,count(s.amount) amountcount,sum(s.amount) totalamount,st.st_desc,if(s.emp_type='STF','Staff','Driver') emp_type,"
				 + "m.sal_name,(select acno from gl_invmode where idno=8) salikacc,(select acno from my_account where codeno='EXPENSE ACCOUNT') expacc,(select branch from my_brch where mainbranch=1) mainbranch,"
				 + "convert(concat(' Fleet : ',coalesce(s.fleetno),'  ',coalesce(s.regno), ' * ','Salik Tag  : ',coalesce(s.tagno),' * ','Emp Name : ' ,coalesce(m.sal_name),' * ','Emp Type : ', coalesce(emp_type)),char(1000)) empinfo "
				 + "from gl_salik s left join my_salesman m on s.emp_id=m.doc_no  AND S.EMP_TYPE=M.SAL_TYPE left join gl_status st on st.status=s.rtype where s.emp_type in ('STF','DRV') and s.amount!=0 and s.inv_no=0 "+sql+" group by s.emp_id,s.fleetno";
				
				ResultSet resultSet = stmtSailk.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtSailk.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
		public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtSailk = conn.createStatement();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtSailk.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtSailk.close();
		    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
		public JSONArray clientDetails(String docNo,String partyname,String contact) throws SQLException {
		    Connection conn=null;
		   
		    JSONArray RESULTDATA1=new JSONArray();
		
		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtSailk = conn.createStatement();
				
		    	    String sql = "";
					
		    	    if(!(docNo.equalsIgnoreCase(""))){
		                sql=sql+" and cldocno like '%"+docNo+"%'";
		            }
		            if(!(partyname.equalsIgnoreCase(""))){
		             sql=sql+" and refname like '%"+partyname+"%'";
		            }
		            if(!(contact.equalsIgnoreCase(""))){
		                sql=sql+" and per_mob like '%"+contact+"%'";
		            }
		            
					sql = "select cldocno,refname,per_mob,acno,trim(address) address from my_acbook where status=3 and dtype='CRM'"+sql;
					
					ResultSet resultSet1 = stmtSailk.executeQuery(sql);
					
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
					
					stmtSailk.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		    return RESULTDATA1;
		}
		
		public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

		     JSONArray RESULTDATA=new JSONArray();
		     String sqltest="";
		     
		     if(rentaltype.equalsIgnoreCase("RAG")){
		        
		      if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("0")))){
		       sqltest+=" and r.brhid="+branch+"";
		      }
		         
		         if(!(sclname.equalsIgnoreCase(""))){
		          sqltest+=" and a.RefName like '%"+sclname+"%'";
		         }
		         if(!(smob.equalsIgnoreCase(""))){
		          sqltest+=" and a.per_mob like '%"+smob+"%'";
		         }
		         if(!(rno.equalsIgnoreCase(""))){
		          sqltest+=" and r.voc_no like '%"+rno+"%'";
		         }
		         if(!(flno.equalsIgnoreCase(""))){
		          sqltest+=" and r.fleet_no like '%"+flno+"%'";
		         }
		         if(!(sregno.equalsIgnoreCase(""))){
		          sqltest+=" and v.reg_no like '%"+sregno+"%'";
		         }
		    
		     }
		     
		     else if(rentaltype.equalsIgnoreCase("LAG")){
		      
		      if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("0")))){
		       sqltest+=" and l.brhid="+branch+"";
		      }
		         
		         if(!(sclname.equalsIgnoreCase(""))){
		          sqltest+=" and a.RefName like '%"+sclname+"%'";
		         }
		         if(!(smob.equalsIgnoreCase(""))){
		          sqltest+=" and a.per_mob like '%"+smob+"%'";
		         }
		         if(!(rno.equalsIgnoreCase(""))){
		          sqltest+=" and l.voc_no like '%"+rno+"%'";
		         }
		         if(!(flno.equalsIgnoreCase(""))){
		          sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
		         }
		         if(!(sregno.equalsIgnoreCase(""))){
		          sqltest+=" and v.reg_no like '%"+sregno+"%'";
		         }
		     }
		     
		     Connection conn=null;
		     
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSalik = conn.createStatement();
			    
			    if(rentaltype.equalsIgnoreCase("RAG")){
			    	
				    String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
				      + " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");
				    
				    ResultSet resultSet = stmtSalik.executeQuery(sql);
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtSalik.close();
				    conn.close();
			       }
			    else if(rentaltype.equalsIgnoreCase("LAG")){
			     
			     String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
			       + " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no"); 
			    
			     ResultSet resultSet = stmtSalik.executeQuery(sql);
			     RESULTDATA=ClsCommon.convertToJSON(resultSet);
			     
			     stmtSalik.close();
				     conn.close();
			       }
			    stmtSalik.close();
			    conn.close();
		  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
		  }finally{
			  conn.close();
		  }
	        return RESULTDATA;
	    }
		
		public JSONArray employeeSearch(String salesman, String smob, String salescode, String docno, String date, String led, String type) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
	    	
	    	java.sql.Date sqlDate=null;
	    	java.sql.Date sqlLicenceExpiryDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
	        }
	        
	        led.trim();
	        if(!(led.equalsIgnoreCase("undefined"))&&!(led.equalsIgnoreCase(""))&&!(led.equalsIgnoreCase("0")))
	        {
	        	sqlLicenceExpiryDate = ClsCommon.changeStringtoSqlDate(led);
	        }

	    	String sqltest="";
	    	
	    	if(!(type==null || type.equalsIgnoreCase(""))){
				if(type.equalsIgnoreCase("STF")){
					sqltest+=" and sal_type='STF'";
				}
				else if(type.equalsIgnoreCase("DRV")){
					sqltest+=" and sal_type='DRV'";
				}
        	}
		    
	    	if(!(salesman.equalsIgnoreCase(""))){
	    		sqltest+=" and sal_name like '%"+salesman+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest+=" and mobile like '%"+smob+"%'";
	    	}
	    	if(!(salescode.equalsIgnoreCase(""))){
	    		sqltest+=" and sal_code like '%"+salescode+"%'";
	    	}
	    	if(!(docno.equalsIgnoreCase(""))){
	    		sqltest+=" and doc_no like '%"+docno+"%'";
	    	}
	    	if(!(sqlDate==null)){
		         sqltest=sqltest+" and date ='"+sqlDate+"'";
		    } 
	    	if(!(sqlLicenceExpiryDate==null)){
		         sqltest=sqltest+" and lic_exp_dt ='"+sqlLicenceExpiryDate+"'";
		    } 
	    	 
	    	Connection conn=null;
	     
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtSailk = conn.createStatement();
					
					sqltest="select doc_no,date,sal_code,sal_name,mobile,lic_exp_dt from my_salesman where status<>7 "+sqltest+"";
					
					ResultSet resultSet = stmtSailk.executeQuery(sqltest);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtSailk.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	
		public  ClsSalikBean getPrint(HttpServletRequest request,String branch,String fromdate, String todate) throws SQLException {
			ClsSalikBean bean = new ClsSalikBean();
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        //System.out.println("Inside Print Salik");
	        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
	        
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
	        
	        Connection conn = null;
	        
		try {
			
			conn = ClsConnection.getMyConnection();
			Statement stmtSalik = conn.createStatement();
			String sql="",sql1="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sql1+=" and inv.brhid="+branch+"";
			}
			
			sql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname from gl_salik s left join gl_invm inv on inv.doc_no=s.inv_no inner join "
				+ "my_brch b on inv.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,"
				+ "lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1"+sql1+" group by inv.brhid";
			
			ResultSet resultSet = stmtSalik.executeQuery(sql);
			
			while(resultSet.next()){
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLbllocation(resultSet.getString("location"));
				bean.setLblbranch(resultSet.getString("branchname"));
			}
			
			if(!(sqlFromDate==null)){
	        	sql1+=" and s.sal_date>='"+sqlFromDate+"'";
		     }
	        
	        if(!(sqlToDate==null)){
	        	sql1+=" and s.sal_date<='"+sqlToDate+"'";
		     }
			
			sql1 = "select s.regno,s.tagno,s.fleetno,s.trans,DATE_FORMAT(s.salik_date,'%d-%m-%Y') salikdate,DATE_FORMAT(s.salik_date,'%H:%i') saliktime,s.ra_no,s.inv_no,s.amount,a.refname,"
					+ "(select sum(s.amount) from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF')) left join "
					+ "gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC')) where ((l.cldocno=a.doc_no or r.cldocno=a.doc_no) and a.dtype='CRM') and inv_no!=0 and isallocated=1 "+sql1+" group by (r.cldocno or l.cldocno)) total "
					+ "from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF')) left join gl_lagmt l on s.ra_no=l.doc_no "
					+ "and ((s.rtype='LA')or(s.rtype='LC')) left join my_acbook a on ((r.cldocno=a.cldocno or l.cldocno=a.cldocno) and a.dtype='CRM') left join gl_invm inv on inv.doc_no=s.inv_no where s.inv_no!=0 and s.isallocated=1 and s.amount!=0 "+sql1+"";
			//System.out.println("print salik: "+sql1);
			ResultSet resultSet1 = stmtSalik.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			String temps="",temps1="";
			String tempskey="";
			HashMap<String, ArrayList<String>> maps = new HashMap<String, ArrayList<String>>();
			
			while(resultSet1.next()){
				temps1=resultSet1.getString("refname")+"::"+resultSet1.getString("total");
				if(!(temps1.equalsIgnoreCase(tempskey))){
					printarray=new ArrayList<String>();
				}
				temps=resultSet1.getString("regno")+"::"+resultSet1.getString("tagno")+"::"+resultSet1.getString("fleetno")+"::"+resultSet1.getString("trans")+"::"+resultSet1.getString("salikdate")+"::"+resultSet1.getString("saliktime")+"::"+resultSet1.getString("ra_no")+"::"+resultSet1.getString("inv_no")+"::"+resultSet1.getString("amount");
				
			    printarray.add(temps);
			    
			    maps.put(temps1 , printarray );
			    tempskey=temps1;
			}
			request.setAttribute("printingarray", maps);
			
			stmtSalik.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
		
		public  ClsSalikBean getPrintToBeInvoiced(HttpServletRequest request,String branch,String fromdate, String todate,String agmtno,String rentaltype,String cldocno) throws SQLException {
			ClsSalikBean bean = new ClsSalikBean();
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	       // System.out.println("Before Convert: "+branch+"::"+fromdate+"::"+todate);
	        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
	        
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
	        //System.out.println("After Convert: "+branch+"::"+sqlFromDate+"::"+sqlToDate);
	        Connection conn = null;
	        
		try {
			
			conn = ClsConnection.getMyConnection();
			Statement stmtSalik = conn.createStatement();
			String sql="";
			
			sql="select c.company,c.address,c.tel,c.fax,b.branchname,l.loc_name location from my_brch b left join my_locm l on "
					+ "l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no where b.doc_no="+branch+" group by b.doc_no";
			
			ResultSet resultSet = stmtSalik.executeQuery(sql);
			
			while(resultSet.next()){
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLbllocation(resultSet.getString("location"));
				bean.setLblbranch(resultSet.getString("branchname"));
			}
			
			String sql1 = "";
			
			
			
			if(sqlFromDate!=null){
	        	sql1+=" and s.sal_date>='"+sqlFromDate+"'";
		     }
	        
	        if(sqlToDate!=null){
	        	sql1+=" and s.sal_date<='"+sqlToDate+"'";
		     }
	        if(!rentaltype.equalsIgnoreCase("0"))
	        {
	        	if(rentaltype.equalsIgnoreCase("RAG")){
	        		sql1+=" and s.rtype in ('RA','RW','RF','RD','RM')";
	        	}
	        	else if(rentaltype.equalsIgnoreCase("LAG")){
	        		sql1+=" and s.rtype in ('LA','LC')";
	        	}
	        }
	        
	        if(!(agmtno.trim().equalsIgnoreCase("0"))){
	        	if(rentaltype.equalsIgnoreCase("RAG")){
	        		sql1+=" and r.voc_no="+agmtno+"";
	        	}
	        	else if(rentaltype.equalsIgnoreCase("LAG")){
	        		sql1+=" and l.voc_no="+agmtno+"";
	        	}
	        }
			
	        if(!cldocno.equalsIgnoreCase("0")){
	        	sql1+=" and s.emp_id="+cldocno+" and s.emp_type='CRM'";
	        }
	        
	        sql1 = "select s.regno,s.tagno,s.fleetno,s.trans,DATE_FORMAT(s.salik_date,'%d-%m-%Y') salikdate,DATE_FORMAT(s.salik_date,'%H:%i') saliktime,s.ra_no,s.inv_no,s.amount,a.refname,"
	    			+ "(select sum(s.amount) from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or"
	    			+ "(s.rtype='RF')) left join gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC')) where ((l.cldocno=a.doc_no or r.cldocno=a.doc_no) and "
	    			+ "a.dtype='CRM') and inv_no=0 and isallocated=1 "+sql1+" group by (r.cldocno or l.cldocno)) total from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no "
	    			+ "and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF')) left join gl_lagmt l on s.ra_no=s.doc_no and ((s.rtype='LA')or(s.rtype='LC')) "
	    			+ "left join my_acbook a on ((r.cldocno=a.cldocno or l.cldocno=a.cldocno)and a.dtype='CRM') where inv_no=0 and isallocated=1 and s.amount!=0 and "
	    			+ "if(s.rtype in ('RA','RD','RW','RF','RM'),r.brhid,l.brhid)="+branch+" "+sql1+"";
	        
			/*sql1 = "select s.regno,s.tagno,s.fleetno,s.trans,DATE_FORMAT(s.salik_date,'%d-%m-%Y') salikdate,DATE_FORMAT(s.salik_date,'%H:%i') saliktime,s.ra_no,s.inv_no,s.amount,a.refname,"
					+ "(select sum(s.amount) from gl_salik s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF')) left join "
					+ "gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC')) where ((l.cldocno=a.doc_no or r.cldocno=a.doc_no) and a.dtype='CRM') and inv_no=0 and isallocated=1 "+sql1+" group by (r.cldocno or l.cldocno)) total "
					+ "from gl_salik s left join gl_ragmt r on (s.ra_no=r.doc_no and s.rtype in('RA','RD','RW','RF','RM')) left join gl_lagmt l on (s.ra_no=l.doc_no "
					+ "and s.rtype='LA','LC') left join my_acbook a on ((r.cldocno=a.cldocno or l.cldocno=a.cldocno)and a.dtype='CRM') where inv_no=0 and isallocated=1 and s.amount!=0 and "+
					" if(s.rtype in('RA','RD','RW','RF','RM'),r.brhid,l.brhid)="+branch+" "+sql1+"";
			*/
		//	System.out.println("Print Salik Query: "+sql1);
			ResultSet resultSet1 = stmtSalik.executeQuery(sql1);
			
			ArrayList<String> printtobeinvoicedarray= new ArrayList<String>();
			String temp="",temp1="";
			String tempkey="";
			HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
			
			while(resultSet1.next()){
				temp1=resultSet1.getString("refname")+"::"+resultSet1.getString("total");
				if(!(temp1.equalsIgnoreCase(tempkey))){
					printtobeinvoicedarray=new ArrayList<String>();
				}
				temp=resultSet1.getString("regno")+"::"+resultSet1.getString("tagno")+"::"+resultSet1.getString("fleetno")+"::"+resultSet1.getString("trans")+"::"+resultSet1.getString("salikdate")+"::"+resultSet1.getString("saliktime")+"::"+resultSet1.getString("ra_no")+"::"+resultSet1.getString("inv_no")+"::"+resultSet1.getString("amount");
				
				printtobeinvoicedarray.add(temp);
			    
			    map.put(temp1 , printtobeinvoicedarray );
			    tempkey=temp1;
			}
			request.setAttribute("printingtobeinvoicedarray", map);
			
			stmtSalik.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
		
		public ArrayList<String> generateInv(String branch, java.sql.Date sqlFromDate,  java.sql.Date sqlToDate,String cldocno, String rentaltype, String agmtno,HttpSession session) throws SQLException {
			// TODO Auto-generated method stub
			Connection conn=null;
			try{
				
				conn=ClsConnection.getMyConnection();
				Statement stmtacno=conn.createStatement();
				ClsManualInvoiceDAO invoicedao=new ClsManualInvoiceDAO();
				ArrayList<String> invoicedoc=new ArrayList<String>();
				String strtrafficacno="select (select acno from gl_invmode where idno=8)salikacno,(select acno from gl_invmode where idno=14)saliksrvcacno";
				ResultSet rsacno=stmtacno.executeQuery(strtrafficacno);
				int salikacno=0;
				int saliksrvcacno=0;
				while(rsacno.next()){
					salikacno=rsacno.getInt("salikacno");
					saliksrvcacno=rsacno.getInt("saliksrvcacno");
				}
				stmtacno.close();
				
				   
				    String sql = "";
				    
					
					if(!(sqlFromDate==null)){
			        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
				     }
			        
			        if(!(sqlToDate==null)){
			        	sql+=" and s.sal_date<='"+sqlToDate+"'";
				     }
			        
			        if(!(cldocno.equalsIgnoreCase(""))){
			        	sql+=" and a.cldocno='"+cldocno+"'";
			        }
			        
			        if(!(rentaltype.equalsIgnoreCase(""))){
			        	if(rentaltype.equalsIgnoreCase("RAG")){
			        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
			        	}
			        	else if(rentaltype.equalsIgnoreCase("LAG")){
			        		sql+=" and s.rtype IN ('LA', 'LC')";
			        	}
			         }
			        
			        if(!(agmtno.equalsIgnoreCase(""))){
			        	sql+=" and s.ra_no='"+agmtno+"'";
			           }
			        
			        
			        Statement stmtsalik=conn.createStatement();
			        
			        

					/*sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
							" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
							" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) inner join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
							" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+")";
					
					*/
					
			        String  strsalik="select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno, CURDATE() date,count(*) salikcount,"+
			        		" s.amount,sum(coalesce(s.amount,0))totalamt,s.rtype,a.acno,a.cldocno,s.ra_no from gl_salik s left join gl_ragmt ragmt "+
			        		" on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) "+
			        		" left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) "+
			        		" where inv_no=0 and isallocated=1 and s.sal_date>='"+sqlFromDate+"' and s.sal_date<='"+sqlToDate+"'"+
			        		" and s.ra_no<>0  "+sql+" and s.amount>0 and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") "+
			        		" group by s.rtype,s.ra_no order by s.rtype,s.ra_no";
			      //  System.out.println("salik Query: "+strsalik);
					ResultSet rssalik=stmtsalik.executeQuery(strsalik);
					
					int val=0;
					int clno=0;
					int clacno=0;
					java.sql.Date sqldate=null;
					while(rssalik.next()){
						ArrayList<String> calcarray=new ArrayList<>();
						calcarray=calculateSalik(conn, rssalik.getString("cldocno"), rssalik.getDouble("totalamt"), rssalik.getInt("salikcount"));
						sqldate=rssalik.getDate("date");
						ArrayList<String> invoicearray=new ArrayList<>();
						clno=rssalik.getInt("cldocno");
						clacno=rssalik.getInt("acno");
						String rtype=rssalik.getString("rtype");
						String note="";
						String agmttype="";
						if(rtype.equalsIgnoreCase("RM") || rtype.equalsIgnoreCase("RA") || rtype.equalsIgnoreCase("RD") || rtype.equalsIgnoreCase("RW") || rtype.equalsIgnoreCase("RF")){
							note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" Salik for Rental Aggreement No "+rssalik.getString("ra_no");
							agmttype="RAG";
						}
						else if(rtype.equalsIgnoreCase("LA") || rtype.equalsIgnoreCase("LC")){
							note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" Salik for Lease Aggreement No "+rssalik.getString("ra_no");
							agmttype="LAG";
						}
						invoicearray.add(8+"::"+salikacno+"::"+note+"::"+calcarray.get(1)+"::"+rssalik.getDouble("amount")+"::"+calcarray.get(0));
						invoicearray.add(14+"::"+saliksrvcacno+"::"+note+"::"+calcarray.get(1)+"::"+calcarray.get(3)+"::"+calcarray.get(2));
						
						String qty=ClsCommon.getMonthandDays(sqlToDate,sqlFromDate, conn);
					//	System.out.println(session.getAttribute("CURRENCYID"));
						conn.setAutoCommit(false);

						val=invoicedao.insert(conn, invoicearray, agmttype, sqlToDate, clno+"", rssalik.getInt("ra_no"), note, note, sqlFromDate,
									sqlToDate, branch, session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(),
									"A",clacno+"", "INS###8", "INS", qty);
					
						if(val>0){
							conn.commit();
							String strgetvoc="select voc_no from gl_invm where doc_no="+val;
							Statement stmtgetvoc=conn.createStatement();
							ResultSet rsgetvoc=stmtgetvoc.executeQuery(strgetvoc);
							while(rsgetvoc.next()){
								invoicedoc.add(rsgetvoc.getString("voc_no"));
							}
							Statement stmtlog=conn.createStatement();
							String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+val+",'"+branch+"',"+
									" 'BINS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
							int logval=stmtlog.executeUpdate(strlog);
							if(logval<=0){
								stmtacno.close();
								stmtsalik.close();
								return null;
							}
						}
						
						
					}
					if(invoicedoc.size()>0){
						
						stmtacno.close();
						stmtsalik.close();
						return invoicedoc;
					}
					else{
					
					stmtacno.close();
					stmtsalik.close();
					}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			
			return null;
		}
		
		
		
		public ArrayList calculateSalik(Connection conn,String clientid,double amt,int count) throws SQLException{
			ArrayList<String> calarray=new ArrayList<>();
			try{
			int srvcdefault=0;
			double salikrate=0.0,trafficrate=0.0;
			Statement stmt=conn.createStatement();
			
			int salikcount=0;
			double salamount=0.0;
			/*String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,COALESCE(amount,0.0) salamount from gl_salik where amount>0 and inv_no=0 and  ra_no='"+agmtno+"'"+sqltestsalik;
//			System.out.println(strsalik);
			ResultSet rssalik=stmt.executeQuery(strsalik);*/
			double salikamt=0.0;
			/*while(rssalik.next()){*/
				salikamt=amt;
				salikcount=count;
				salamount=1;
				
			/*}*/
			
			
			String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+clientid+"' and dtype='CRM' and status<>7";
			//System.out.println("Acbbok"+stracbook);
			ResultSet rsacbook=stmt.executeQuery(stracbook);
			while(rsacbook.next()){
				srvcdefault=rsacbook.getInt("ser_default");
				if(srvcdefault==0){
					salikrate=rsacbook.getDouble("per_salikrate");
					trafficrate=rsacbook.getDouble("per_trafficharge");
				}
			}
			if(srvcdefault==1){
				String saliksrv="select if(method=1,value,0) saliksrv from gl_config where field_nme='saliksrv'";
				ResultSet rssaliksrv=stmt.executeQuery(saliksrv);
				while(rssaliksrv.next()){
					salikrate=rssaliksrv.getDouble("saliksrv");
				}
			}
			double saliksrvcchg=salikcount*salikrate;
			double saliktemprate=0.0;
			if(salamount>0){
				saliktemprate=salikrate;
			}
			
			calarray.add(salikamt+"");
			calarray.add(salikcount+"");
			calarray.add(saliksrvcchg+"");
			calarray.add(salikrate+"");
			/*calarray.add(saliksrvcchg+"");
			calarray.add(salikcount+"");
			calarray.add(saliktemprate+"");
			calarray.add(salikamt+"");*/
			}
			catch(Exception e){
				e.printStackTrace();
			}
			return calarray;
}
}
