package com.search;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountSearch {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	public   JSONArray accsearch_gl() throws SQLException {   
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				ResultSet resultSet = stmt.executeQuery("select description,doc_no from my_head where atype='GL' and m_s=0");

				RESULTDATA=com.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accsearch_hr(String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				if(check.equalsIgnoreCase("1")){
					
				String sql="";
				
				if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sql=sql+" and account like '%"+accountno+"%'";
		        }
				
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sql=sql+" and description like '%"+accountname+"%'";
		        }
					
				ResultSet resultSet = stmt.executeQuery ("select doc_no,account,description,curid from my_head where atype='HR' and m_s=0 " 
						+ "and doc_no NOT IN (select acno from hr_empm where status=3)"+sql+"");

				RESULTDATA=com.convertToJSON(resultSet);
				}
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public   JSONArray accsearch_ap() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select description,doc_no,account acno from my_head where atype='AP' and m_s=0");
				RESULTDATA=com.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	public   JSONArray accemployee() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select doc_no,description,account acno from my_head where m_s=0 and den=301");
				RESULTDATA=com.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	public   JSONArray nonPoolAccSearch() throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				ResultSet resultSet = stmt.executeQuery ("select m1.description,m1.doc_no,m2.address,m2.com_mob,m2.per_mob from my_head m1 left"+
				" join my_acbook m2 on m1.doc_no=m2.acno where m1.atype='AP'");

				RESULTDATA=com.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public   JSONArray accountsDetails(HttpSession session,String dtype,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = conobj.getMyConnection();
		       Statement stmt = conn.createStatement();
	
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
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           String den= "";
	           
	            if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("PC")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BRCN") || dtype.equalsIgnoreCase("UCP")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("RRP")){
					den="305";
				}
	            else if(dtype.equalsIgnoreCase("UCR")){
					den="305";
				}
				
	           java.sql.Date sqlDate=null;
		       
	           if(check.equalsIgnoreCase("1")){
	        	   
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = com.changeStringtoSqlDate(date);
	           }
	            
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        	
		        /*sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
            		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
            		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='"+den+"'"+sqltest;*/
		        	
	        	sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	        	  + "where t.atype='GL' and t.m_s=0 and t.den='"+den+"'"+sqltest;
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=com.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public   JSONArray clientAccountsDetails(HttpSession session,String dtype,String atype,String accountno,String accountname,String mobile,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = conobj.getMyConnection();
		       Statement stmt = conn.createStatement();
	
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
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = com.changeStringtoSqlDate(date);
	           }

	            String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        
		        	/*if(a1.com_mob='',a1.tel,a1.com_mob) mobile*/
		        /*sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,c.type,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
				    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
				    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+atype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
				    + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')"+sqltest;*/
		        
		        if(atype.equalsIgnoreCase("HR") || atype.equalsIgnoreCase("GL")){
	        	
			        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
		        
		        }else{
		        
			        sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
		        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
		        		+ "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
		        
		        }
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=com.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			  conn.close();
			}
	       return RESULTDATA;
	  }
    
}
