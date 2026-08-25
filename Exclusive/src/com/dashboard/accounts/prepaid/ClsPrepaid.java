package com.dashboard.accounts.prepaid;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPrepaid  {
	
	ClsConnection connDAO=new ClsConnection();

	ClsCommon commonDAO=new ClsCommon();

	
	public JSONArray prePaidGridLoading(String branch, String chkfromdate, String fromdate, String uptodate, String reporttype, String account,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlUpToDate=null;
				
				fromdate.trim();
		        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
		        }
		        
				uptodate.trim();
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
		        {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }
		        
		        if(!(reporttype.equalsIgnoreCase("0")) && !(reporttype.equalsIgnoreCase(""))){
		        	
				String sql = "",sql1="",sql2="",sql3="";
				String joins="";String casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    			sql1+=" and jv.brhid="+branch+"";
	    		}

				if(chkfromdate.equalsIgnoreCase("1")){
					if(!(sqlFromDate==null)){
			        	sql2+=" and d.date>='"+sqlFromDate+"'";
			        	sql3+=" and jv.date>='"+sqlFromDate+"'";
					}
				}
				
				if(!(account.equalsIgnoreCase("0")) && !(account.equalsIgnoreCase(""))){
					sql+=" and he.doc_no="+account+"";
					sql1+=" and he.doc_no="+account+"";
	            }
				
				joins=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement=commonDAO.getFinanceVocTablesCase(conn);
		        
				if(reporttype.equalsIgnoreCase("detail")){
	    			
	    			sql = "select a.date, a.desc1, a.aa, a.postacno, a.account, a.accountname, a.acno, a.paccount, a.paccountname, "+casestatement+"a.branch, a.description,a.transtype, a.posteddate, a.dramount, a.postamount, a.pendamount from ("
	    					+ "select m.date,m.desc1,m.tranid aa,m.postacno,he.account,he.description accountname,he.doc_no acno,pe.account paccount,pe.description paccountname,jv.doc_no transNo,b.branchname branch,jv.description,"  
	    					+ "jv.dtype transtype,d.date posteddate,coalesce(d.amount,0) dramount,abs(m.amount) postamount,(select m.amount-postamount) pendamount,m.brhid from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join "
	    					+ "my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no where jv.status=3 and jv.date<='"+sqlUpToDate+"'"+sql2+""+sql+" ) a"+joins+"";
	    			
	    			    			
				} else {
					
					sql = "select a.date, a.desc1, a.aa, a.postacno, a.account, a.accountname, a.acno, a.paccount, a.paccountname, "+casestatement+"a.branch, a.description, a.transtype,a.postamount, a.dramount, a.pendamount, a.fromDate, a.toDate, a.postedtilldate, a.tobeposted from ( "
							+ "select jv.date,m.desc1,m.tranid aa,m.postacno,he.account,he.description accountname,he.doc_no acno,pe.account paccount,pe.description paccountname,jv.doc_no transNo,b.branchname branch,jv.description,"  
	    					+ "jv.dtype transtype,(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) postamount,abs(m.amount) dramount,(select m.amount-postamount) pendamount,"
	    					+ "(select min(d.date) from my_prepd d where d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) fromDate,(select max(d.date) from my_prepd d where d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) toDate,"
	    					+ "(select max(d.date) from my_prepd d where posted!=0 and d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) postedtilldate,'1' tobeposted,m.brhid from my_prepm m inner join my_prepd d on m.tranId=d.tranId "
	    					+ "inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no where jv.status=3 and jv.date<='"+sqlUpToDate+"'"+sql2+""+sql+" "
	    					+ "group by d.tranId UNION ALL "
	    					+ "select jv.date,jv.description desc1,jv.tranid aa,0 postacno,he.account,he.description accountname,jv.acno,'' paccount,'' paccountname,jv.doc_no transNo,b.branchname branch,jv.description,jv.dtype transtype,0 postamount,jv.dramount,"  
	    					+ "jv.dramount pendamount,null fromDate, null toDate,null postedtilldate,'2' tobeposted,jv.brhid from my_jvtran jv inner join MY_BRCH b on jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no left join my_prepd d on jv.tr_no=d.jvtrno where he.den=350 and jv.status=3 and jv.prep=0 and "
	    					+ "d.jvtrno is null and jv.dramount>0 and jv.date<='"+sqlUpToDate+"'"+sql3+""+sql1+" ) a"+joins+"";
	    		
				}
				System.out.println("===== "+sql);
				ResultSet resultSet = stmtPREP.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		        }			
				stmtPREP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray prePaidExcelExport(String branch, String chkfromdate, String fromdate, String uptodate, String reporttype, String account,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
				java.sql.Date sqlUpToDate=null;
				java.sql.Date sqlFromDate=null;
				
				fromdate.trim();
		        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
		        }
		        
				uptodate.trim();
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
		        {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }

		        if(!(reporttype.equalsIgnoreCase("0")) && !(reporttype.equalsIgnoreCase(""))){
		        	
				String sql = "",sql1 = "",sql2="",sql3="";
				String joins="";String casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    			sql1+=" and jv.brhid="+branch+"";
	    		}
				
				if(chkfromdate.equalsIgnoreCase("1")){
					if(!(sqlFromDate==null)){
			        	sql2+=" and d.date>='"+sqlFromDate+"'";
			        	sql3+=" and jv.date>='"+sqlFromDate+"'";
					}
				}

				if(!(account.equalsIgnoreCase("0")) && !(account.equalsIgnoreCase(""))){
					sql+=" and he.doc_no="+account+"";
					sql1+=" and he.doc_no="+account+"";
	            }
				
				joins=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement=commonDAO.getFinanceVocTablesCase(conn);
		        
				if(reporttype.equalsIgnoreCase("detail")){
	    			
					sql = "select a.branch 'Branch', a.transtype 'Dtype', "+casestatement+"a.account 'Account', a.accountname 'Account Name', a.paccount 'Post Account',a.paccountname 'Post Account Name', a.date 'Date', a.posteddate 'Posted Date', a.description 'Description', a.dramount 'Amount' from ( "
	    					+ "select m.date,m.desc1,m.tranid aa,m.postacno,he.account,he.description accountname,he.doc_no acno,pe.account paccount,pe.description paccountname,jv.doc_no transNo,b.branchname branch,jv.description,"  
	    					+ "jv.dtype transtype,d.date posteddate,coalesce(d.amount,0) dramount,abs(m.amount) postamount,(select m.amount-postamount) pendamount,m.brhid from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join "
	    					+ "my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no where jv.status=3 and jv.date<='"+sqlUpToDate+"'"+sql2+""+sql+" ) a"+joins+"";
	    			    			
				} else {
										
					sql = "select a.branch 'Branch',a.transtype 'Dtype',"+casestatement+"a.account 'Account', a.accountname 'Account Name', a.paccount 'PostAccount No.',a.paccountname 'Post Account Name',a.date 'Date', a.fromDate 'From Date', a.toDate 'To Date', a.postedtilldate 'Posted Till',"
							+ "a.description 'Description', a.dramount 'Amount', a.postamount 'Posted', a.pendamount 'Balance' from ( "
							+ "select jv.date,m.desc1,m.tranid aa,m.postacno,he.account,he.description accountname,he.doc_no acno,pe.account paccount,pe.description paccountname,jv.doc_no transNo,b.branchname branch,jv.description,"  
	    					+ "jv.dtype transtype,(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and jv.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) postamount,abs(m.amount) dramount,(select m.amount-postamount) pendamount,"
	    					+ "(select min(d.date) from my_prepd d where d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) fromDate,(select max(d.date) from my_prepd d where d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) toDate,"
	    					+ "(select max(d.date) from my_prepd d where posted!=0 and d.date<='"+sqlUpToDate+"'"+sql2+" and d.tranid=aa) postedtilldate,'1' tobeposted,m.brhid from my_prepm m inner join my_prepd d on m.tranId=d.tranId "
	    					+ "inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no where jv.status=3 and jv.date<='"+sqlUpToDate+"'"+sql2+""+sql+" "
	    					+ "group by d.tranId UNION ALL "
	    					+ "select jv.date,jv.description desc1,jv.tranid aa,0 postacno,he.account,he.description accountname,jv.acno,'' paccount,'' paccountname,jv.doc_no transNo,b.branchname branch,jv.description,jv.dtype transtype,0 postamount,jv.dramount,"  
	    					+ "jv.dramount pendamount,null fromDate, null toDate,null postedtilldate,'2' tobeposted,jv.brhid from my_jvtran jv inner join MY_BRCH b on jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no left join my_prepd d on jv.tr_no=d.jvtrno where he.den=350 and jv.prep=0 and jv.status=3 and "
	    					+ "d.jvtrno is null and jv.dramount>0 and jv.date<='"+sqlUpToDate+"'"+sql3+""+sql1+" ) a"+joins+"";
	    			
				}
				
				ResultSet resultSet = stmtPREP.executeQuery(sql);
				RESULTDATA=commonDAO.convertToEXCEL(resultSet);
		        }			
				stmtPREP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountsDetails(String accountno,String accountname,String check) throws SQLException {
        
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
		        	
			        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type,t.gr_type from my_head t left join my_curr c on t.curid=c.doc_no "
			  	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			  	        	  + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			  	        	  + "where t.atype='GL' and t.den=350 "+sqltest;
		        
			        
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
		
}