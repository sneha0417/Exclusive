package com.dashboard.accounts.costpandl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCostPAndLDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray costPAndLGridLoading(String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",casestatement="",joins="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(costtype.equalsIgnoreCase("0")) && !(costtype.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.costtype='"+costtype+"'";
		        }
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.jobid='"+costcode+"'";
		        }
        		
        		if(costtype.equalsIgnoreCase("3") || costtype.equalsIgnoreCase("4") || costtype.equalsIgnoreCase("5")) {
        			casestatement=" WHEN e.costtype in (3,4) THEN CONCAT('Branch :',src.brhid,' - Doc No. :',src.doc_no)  WHEN e.costtype=5 THEN CONCAT('Branch :',cal.brhid,' - Doc No. :',cal.doc_no) ";
        			joins=" left join cm_srvcontrm src on e.costcode=src.doc_no and e.costtype in (3,4) left join cm_cuscallm cal on e.costcode=cal.doc_no and e.costtype=5";
        		}
        		
        		
			/*	sql = "select e.costtype,CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname) ELSE e.costcode END AS 'costcode',"  
					+ "Convert(if(e.income=0,'',e.income),char(50)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(50)) expenditure,Convert(if(e.netamount=0,'',e.netamount),char(50)) netamount,UPPER(u.costgroup) costgroup from ( select a.costtype,"
					+ "a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)-sum(a.expenditure)),2) netamount,a.gr_type from (select t.costtype,t.costcode,t.acno,t.tr_no, t.ldramount income,"
					+ "0 expenditure,h.gr_type from my_costtran c left join my_jvtran t on c.tranid=t.tranid left join my_head h on h.doc_no=t.acno and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and "
					+ "t.costtype!=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'"+sql1+" UNION ALL select t.costtype,t.costcode,t.acno,t.tr_no, 0 income,t.ldramount expenditure,h.gr_type from my_costtran c left join "
					+ "my_jvtran t on c.tranid=t.tranid left join my_head h on h.doc_no=t.acno and h.gr_type=4 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and t.costtype!=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' "
					+ "and t.date>='"+sqlFromDate+"'"+sql1+") a group by a.costcode UNION ALL select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)-sum(d.expenditure)),2) "
					+ "netamount,d.gr_type from ( select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.ldramount,0) income,if(h.gr_type=4,t.ldramount,0) expenditure,h.gr_type from my_costtran c left join my_jvtran t on c.tranid=t.tranid left join "
					+ "my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and t.costtype=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'"+sql1+") d "
					+ "group by d.costcode) e left join my_costunit u on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6";
 */
        		
        		/**
        		 * account wise query
        		 * select acno,h.description,sum(income),sum(expenditure),e.costtype,CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname) WHEN e.costtype='UNALLOCATED' THEN 'UNALLOCATED' ELSE e.costcode END AS 'costcode',Convert(if(e.income=0,'',e.income),char(50)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(50)) expenditure,Convert(if(e.netamount=0,'',e.netamount),char(50)) netamount,UPPER(u.costgroup) costgroup from (select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)-sum(a.expenditure)),2) netamount,a.gr_type from (select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from  my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno  and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1  and c.jobid!=0 and t.date<='2016-01-31' and t.date>='2016-01-01'   UNION ALL  select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran  c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4  where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0  and t.date<='2016-01-31' and t.date>='2016-01-01'  ) a group by a.costcode,a.acno UNION ALL  select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income, round(sum(d.expenditure),2) expenditure,round((sum(d.income)-sum(d.expenditure)),2) netamount,d.gr_type  from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,  if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t  on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5)  where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype=1 and c.jobid!=0  and t.date<='2016-01-31' and t.date>='2016-01-01'  ) d group by d.costcode,d.acno ) e left join my_costunit u  on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join  gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6  left join my_head h on h.doc_no=acno group by acno;
        		 */
        		
        		sql=" select e.costtype,CONVERT(CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname)"+casestatement+" ELSE e.costcode END,CHAR(1000)) AS 'costcode',"
        				+ "Convert(if(e.income=0,'',e.income*-1),char(100)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(100)) expenditure,Convert(if(e.netamount=0,'',e.netamount*-1),char(100)) netamount,coalesce(UPPER(u.costgroup),'UNALLOCATED') costgroup from ( "
        				+ "select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)+sum(a.expenditure)),2) netamount,a.gr_type from "
        				+ "(select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno "
        				+ " and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+"  UNION ALL "
        				+ " select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4 "
        				+ " where h.gr_type is not null and t.status=3 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) a group by a.costcode UNION ALL "
        				+ " select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type "
        				+ " from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t "
        				+ " on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.yrid=0 and c.costtype=1 and c.jobid!=0 "
        				+ " and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) d UNION ALL select * from (select 'UNALLOCATED' costtype, 'UNALLOCATED'  costcode,d.acno,d.tr_no,round(sum(d.income),2) income, "
        				+ " round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type  from (select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.dramount-COALESCE(C.AMOUNT,0),0) income,  "
        				+ " if(h.gr_type=4,t.dramount-COALESCE(C.AMOUNT,0),0) expenditure,h.gr_type from my_jvtran t inner join my_head h on h.doc_no=t.acno  left join (select sum(amount) amount ,tranid,jobid costcode,costtype from my_costtran  group by tranid) c on c.tranid=t.tranid  "
        				+ "   where h.gr_type in (4,5) and t.status=3 and t.yrid=0 and t.date between '"+sqlFromDate+"' and  '"+sqlToDate+"'  )d ) d group by d.costcode) e left join my_costunit u "
        				+ " on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6"+joins+"";
				System.out.println("costpnl====== "+sql);
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
	
	public JSONArray costPAndLExcelExport(String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",casestatement="",joins="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(costtype.equalsIgnoreCase("0")) && !(costtype.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.costtype='"+costtype+"'";
		        }
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.jobid='"+costcode+"'";
		        }
        		
        		if(costtype.equalsIgnoreCase("3") || costtype.equalsIgnoreCase("4") || costtype.equalsIgnoreCase("5")) {
        			casestatement=" WHEN e.costtype in (3,4) THEN CONCAT('Branch :',src.brhid,' - Doc No. :',src.doc_no)  WHEN e.costtype=5 THEN CONCAT('Branch :',cal.brhid,' - Doc No. :',cal.doc_no) ";
        			joins=" left join cm_srvcontrm src on e.costcode=src.tr_no and e.costtype in (3,4) left join cm_cuscallm cal on e.costcode=cal.tr_no and e.costtype=5";
        		}
        		
        		sql=" select coalesce(UPPER(u.costgroup),'UNALLOCATED') 'Costtype',CONVERT(CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname)"+casestatement+" ELSE e.costcode END,CHAR(1000)) AS 'Costcode',"
        				+ "Convert(if(e.income=0,'',e.income*-1),char(100)) 'Income',Convert(if(e.expenditure=0,'',e.expenditure),char(100)) 'Expenditure',Convert(if(e.netamount=0,'',e.netamount*-1),char(100)) 'Netamount' from ( "
        				+ "select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)+sum(a.expenditure)),2) netamount,a.gr_type from "
        				+ "(select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno "
        				+ " and h.gr_type=5 where h.gr_type is not null and t.status=3 and  t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+"  UNION ALL "
        				+ " select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4 "
        				+ " where h.gr_type is not null and t.status=3 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) a group by a.costcode UNION ALL "
        				+ " select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type "
        				+ " from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t "
        				+ " on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.yrid=0 and c.costtype=1 and c.jobid!=0 "
        				+ " and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) d UNION ALL select * from (select 'UNALLOCATED' costtype, 'UNALLOCATED'  costcode,d.acno,d.tr_no,round(sum(d.income),2) income, "
        				+ " round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type  from (select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.dramount-COALESCE(C.AMOUNT,0),0) income,  "
        				+ " if(h.gr_type=4,t.dramount-COALESCE(C.AMOUNT,0),0) expenditure,h.gr_type from my_jvtran t  left join (select sum(amount) amount ,tranid,jobid costcode,costtype from my_costtran  group by tranid) c on c.tranid=t.tranid left join "
        				+ " my_head h on h.doc_no=t.acno   where h.gr_type in (4,5) and t.status=3 and t.yrid=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'  )d ) d group by d.costcode) e left join my_costunit u "
        				+ " on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6"+joins+"";
				
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
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'"+sql1+"";
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
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'"+sql1+"";
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
	        		
	        		String sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1"+sql1+"";
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
