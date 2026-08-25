package com.dashboard.accounts.costledger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCostLedgerDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray costLedgerGridLoading(String rpttype, String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",sql2="",sql3="",sql4="",joins="",casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhid="+branch+"";
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(sqlToDate==null)){
					sql=sql+" and t.date<='"+sqlToDate+"'";
		        } 
            		
				if(rpttype.equalsIgnoreCase("2")) {
					
					sql4 = ", a.debit, a.credit";
					
				} else {
					
					if(!(sqlFromDate==null)){
						sql=sql+" and t.date>='"+sqlFromDate+"'";
				    } 
					
					sql2 = " union all select 1 id,t.brhid,date('"+sqlFromDate+"') trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId,sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and "
						 + "((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) and t.costtype="+costtype+" and t.costcode="+costcode+""+sql1+" group by t.costcode,t.curId";
						
					sql3 = "group by a.acno,a.id order by a.id,a.acno";

					sql4 = ", sum(a.debit) debits, sum(a.credit) credits";
					
				}

				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select a.brhid,"+casestatement+"a.transtype,a.trdate, a.description, a.ref_detail, a.tr_no, a.currency"+sql4+", a.rate, if(a.id=1,'0',a.account) account, if(a.id=1,'Opening Bal.',a.accountname) accountname,a.acno, b.branchname from ( "
					+ "select t.id,t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,"
					+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.doc_no acno from my_head h inner join ( select 2 id,t.brhid,"
					+ "t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.ldramount, t.rate, t.doc_no transNo,t.dtype transType from my_costtran c left join my_jvtran t on c.tranid=t.tranid "
					+ "where  t.status=3 and t.trtype!=1 and t.costtype="+costtype+" and t.costcode="+costcode+" and t.yrid=0"+sql+""+sql2+") t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,"
					+ "transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+""+sql3+"";
				
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtAccountStatement.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costLedgerGridLoadingExcel(String rpttype, String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",sql2="",sql3="",sql4="",joins="",casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhid="+branch+"";
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(sqlToDate==null)){
					sql=sql+" and t.date<='"+sqlToDate+"'";
		        } 
            		
				if(rpttype.equalsIgnoreCase("2")) {
					
					sql4 = ", a.debit 'Debit', a.credit 'Credit'";
					
				} else {
					
					if(!(sqlFromDate==null)){
						sql=sql+" and t.date>='"+sqlFromDate+"'";
				    } 
					
					sql2 = " union all select 1 id,t.brhid,date('"+sqlFromDate+"') trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId,sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and "
						 + "((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) and t.costtype="+costtype+" and t.costcode="+costcode+""+sql1+" group by t.costcode,t.curId";
						
					sql3 = "group by a.acno,a.id order by a.id,a.acno";

					sql4 = ", sum(a.debit) debits, sum(a.credit) credits";
					
				}

				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select  a.trdate 'Date',"+casestatement+"a.transtype 'Type', b.branchname 'Branch',a.description 'Description',if(a.id=1,'0',a.account) 'Account',if(a.id=1,'Opening Bal.',a.accountname) 'Account Name', a.currency 'Currency',a.rate 'Rate' "+sql4+" from ( "
					+ "select t.id,t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,"
					+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.doc_no acno from my_head h inner join ( select 2 id,t.brhid,"
					+ "t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.ldramount, t.rate, t.doc_no transNo,t.dtype transType from my_costtran c left join my_jvtran t on c.tranid=t.tranid "
					+ "where  t.status=3 and t.trtype!=1 and t.costtype="+costtype+" and t.costcode="+costcode+" and t.yrid=0"+sql+""+sql2+") t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,"
					+ "transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+""+sql3+"";
				//System.out.println("Excelgrid=========="+sql);
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtAccountStatement.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }

	public JSONArray costCodeDetailsSearch(String type, String costcode, String regno, String costcodename, String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCostLedger = conn.createStatement ();
			
				if(check.equalsIgnoreCase("1")) {
					
				/* Cost Center */
	        	if(type.equalsIgnoreCase("1")) {
	        		
	        		String sql1="";
	        		
	        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and c1.costcode like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and c1.description like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
	        	
					/* AMC & SJOB */
	        	} else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4")) {
	        		
	        		String dtype="",sql1="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
			        }
	        		
	        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
			            sql1=sql1+" and d.site like '%"+regno+"%'";
			        }
	        		
	        		String sql="select m.doc_no ,m.doc_no code,a.refname name,d.site from cm_srvcontrm m left join (select group_concat(d.site) site,d.tr_no from cm_srvcontrm m left join cm_srvcsited d on m.tr_no=d.tr_no group by d.tr_no) d on m.tr_no=d.tr_no left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'"+sql1+"";
	        		
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
		        
				/* Call Register */
		        } else if(type.equalsIgnoreCase("5")) {
		        	
		        	String sql1="";
		        	
		        	if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
			        }
	        		
	        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
			            sql1=sql1+" and cs.site like '%"+regno+"%'";
			        }
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname,cs.site name from cm_cuscallm m left join cm_srvcsited cs on cs.rowno=m.siteid left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'"+sql1+"";
	        		System.out.println("+++++++++++++++++++++"+sql);
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
			        	
			    /* Fleet */
	        	} else if(type.equalsIgnoreCase("6")) {
	        		
	        		String sql1="";
	        		
	        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and fleet_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
			            sql1=sql1+" and reg_no like '%"+regno+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and flname like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select fleet_no doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
	        	
				/* IJCE */
	        	}  else if(type.equalsIgnoreCase("7")) {
	        		
	        		String sql1="";
		        	
		        	if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from is_jobmaster m left join my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
					
				/* Contract */
	        	} else if(type.equalsIgnoreCase("8")) {
	        		
	        		String sql1="";
		        	
		        	if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and cl.name like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name from hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
					
				/* Job Card */
	        	} else if(type.equalsIgnoreCase("9")) {
	        		
	        		String sql1="";
		        	
		        	if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.name like '%"+costcodename+"%'";
			        }
	        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
			            sql1=sql1+" and m.regno like '%"+regno+"%'";
			        }
	        		
	        		String sql="SELECT * FROM (select g.regno,M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1"+sql1+"";
	        		//System.out.println("9thsql======="+sql);
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
	        	}
			}
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
