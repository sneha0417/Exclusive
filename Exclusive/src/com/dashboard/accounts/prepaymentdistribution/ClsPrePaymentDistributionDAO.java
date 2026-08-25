package com.dashboard.accounts.prepaymentdistribution;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPrePaymentDistributionDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	public JSONArray prePaymentDistribustionGridLoading(HttpSession session,String docno,String fromDate,String toDate,String check) throws SQLException {
        
		
		 System.out.println("docno===="+docno);
	        
	        System.out.println("fromDate===="+fromDate);
	        
	        System.out.println("toDate===="+toDate);
	        
	        System.out.println("check===="+check);
		
		JSONArray RESULTDATA=new JSONArray();
        
       
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
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
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBPD = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			    
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
		        
		        String xsql = "";
				String joins="";String casestatement="";
						
				if(!(sqlFromDate==null)){
		        	xsql+=" and jv.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	xsql+=" and jv.date<='"+sqlToDate+"'";
			    }
		        
		        if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
		        	xsql+=" and jv.doc_no='"+docno+"'";
		        }
		       
		        joins=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement=commonDAO.getFinanceVocTablesCase(conn);	
					
				xsql = "select "+casestatement+"a.account,a.doc_no , a.accountname, a.description,a.date, a.trno, a.tranid, a.dtype, a.brhId, a.branch, a.acno, a.dramount, a.editbtn, CONVERT(a.postacno,CHAR(50)) postacno, a.paccount,"
						+ "a.paccountname,CONVERT(a.costtype,CHAR(50)) costtype, CONVERT(a.costcode,CHAR(50)) costcode, CONVERT(a.costgroup,CHAR(50)) costgroup, a.stdate, a.enddate, a.rowno from ( select he.account,he.description accountname,jv.description,jv.date,jv.tr_no trno,jv.tranid,"
						+ "jv.doc_no,jv.dtype,jv.brhId,b.branchname branch,jv.acno,abs(jv.dramount) dramount,jv.doc_no transno,jv.dtype transType,'EDIT' editbtn,coalesce(h.doc_no,'') postacno,"
						+ "coalesce(h.account,'') paccount,coalesce(h.description,'') paccountname,coalesce(pd.costtype,'') costtype,coalesce(pd.costcode,'') costcode,coalesce(co.costgroup,'') costgroup,"
						+ "pd.stdate,pd.enddate,coalesce(pd.rowno,0) rowno from my_jvtran jv inner join MY_BRCH b on jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no left join my_prepd d on jv.tr_no=d.jvtrno "
						+ "left join gl_bpd pd on pd.tranid=jv.tranid left join my_head h on pd.postacno = h.doc_no left join my_costunit co on pd.costtype=co.costtype where he.den=350 and jv.status=3 "
						+ "and jv.brhid="+branch+" and jv.prep=0 and jv.dramount>0 and d.jvtrno is null"+xsql+") a "+joins+"";
	    		
				
				System.out.println("grid loading ======="+xsql);
				
				ResultSet resultSet = stmtBPD.executeQuery(xsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		        		
				stmtBPD.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String currency,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmt = conn.createStatement();
			       	           
		        if(check.equalsIgnoreCase("1")){
		        	
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
		        	
			        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type,t.gr_type from my_head t left join my_curr c on t.curid=c.doc_no "
			  	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			  	        	  + "where coalesce(toDate,curdate())>=now() and frmDate<=now() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			  	        	  + "where t.atype='GL' "+sqltest;
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();		        
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
	    	 conn.close();
	     }
	       return RESULTDATA;
	  }
	
	public JSONArray documentDetailsSearch(HttpSession session,String fromDate,String toDate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
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
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBPD = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			    System.out.println("sqlFromDate=="+sqlFromDate);
			    
			    System.out.println("sqlToDate=="+sqlToDate);
				
				fromDate.trim();
		        if(!fromDate.equalsIgnoreCase("undefined") && !fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0"))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
			        
				String xsqltest = "";
				
				String xsql = "";
						
				if(sqlFromDate!=null){
		        	xsql+=" and jv.date>='"+sqlFromDate+"'";
			    }
		        
		        if(sqlToDate!=null){
		        	xsql+=" and jv.date<='"+sqlToDate+"'";
			    }
		       
		        System.out.println("xsql====="+xsql);
		        
		        String joins1="";String casestatement1="";
		        
		        
		        joins1=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement1=commonDAO.getFinanceVocTablesCase(conn);	
		        
		        
				xsqltest = "select "+casestatement1+" transtype,a.transno jvdocno from (select jv.doc_no transno , jv.dtype transtype ,jv.brhid from my_jvtran jv inner join my_head he on jv.acno = he.doc_no left join my_prepd d on jv.tr_no=d.jvtrno  where he.den=350 and jv.status=3 and jv.brhid="+branch+" and jv.prep=0 and jv.dramount>0 and d.jvtrno is null"+xsql+"  group by jv.dtype,jv.doc_no) a "+joins1+"";
	    		
				System.out.println("docno search query========"+xsqltest);
				
				ResultSet resultSet = stmtBPD.executeQuery(xsqltest);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		        		
				stmtBPD.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }

}
