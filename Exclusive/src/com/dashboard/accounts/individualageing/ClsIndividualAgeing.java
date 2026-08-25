package com.dashboard.accounts.individualageing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.accounts.individualageing.ClsIndividualAgeingBean;

public class ClsIndividualAgeing  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray individualAgeing(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtIndividualAgeing = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="",joins="",casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";
					
				sql = "select a.name,a.contact,coalesce(sm.sal_name,'') salname,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'ADVANCE',"
						+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance<0,"
						+ "round((balance),2),0)<0,round((if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance>0,balance,0)>0,round((if(balance>0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
						+ "a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.age,a.description from ("
						+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
						+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
						+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
						+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0 union all "
						+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
						+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
						+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
						+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 "
						+ "group by j.tranid having balance<>0) a left join my_salm sm on sm.doc_no=a.sal_id "+joins+" order by acno,date";

				} else if(atype.equalsIgnoreCase("AP")){
					condition=" and bk.dtype='VND'";
					
					sql = "select a.name,a.contact,coalesce(sm.sal_name,'') salname,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'ADVANCE',"  
							+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance>0,"
							+ "round((balance),2),0)>0,round((if(balance>0,round((balance),2),0)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance<0,balance,0)<0,round((if(balance<0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
							+ "a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.age,a.description from ("
							+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+ coalesce(o.amount,0)"
							+ " balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0 union all "
							+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)- coalesce(o.amount,0)"
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
							+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
							+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 "
							+ "group by j.tranid having balance<>0) a left join my_salm sm on sm.doc_no=a.sal_id "+joins+" order by acno,date";
					
				}
				System.out.println("ia load==== "+sql);
				ResultSet resultSet = stmtIndividualAgeing.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtIndividualAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray individualAgeingSummary(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
		        if(!(sqlUpToDate==null)){
		        	sql+="	 and j.date<='"+sqlUpToDate+"'";
			        }
				
				 if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";

					sql = "select ag.name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',coalesce(sm.sal_name,'') 'SALES_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,"
						+ "round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,"
						+ "round((balance),2),0))>0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance<0,"
						+ "round((balance),2),0)<0),round((sum(if(balance<0,round((balance),2),0)*-1)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(sum(if(balance>0,balance,0))>0,"
						+ "round((sum(if(balance>0,balance,0))),2),''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,"
						+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,"
						+ "sum(dramount) - coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j "
						+ "inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no "
						+ "left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
						+ "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" "
						+ "and j.id>0 group by j.tranid having balance<>0 union all select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,"
						+ "if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) balance, j.tranid,"
						+ "j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
						+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join "
						+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
						+ "j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0) ag left join my_salm sm on sm.doc_no=ag.sal_id group by acno";
				
		        } else if(atype.equalsIgnoreCase("AP")){
		        	condition=" and bk.dtype='VND'";
		        	
		        	sql = "select ag.name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',coalesce(sm.sal_name,'') 'SALES_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))>0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance>0,round((balance),2),0)>0),round((sum(if(balance>0,round((balance),2),0))),2),''),CHAR(50)) "
		        			+ "'UNAPPLIED',CONVERT(if(sum(if(balance<0,balance,0))<0,round((sum(if(balance<0,balance,0))),2)*-1,''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,"
		        			+ "h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" and j.id<0 group by j.tranid having balance<>0 union all select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,"
							+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
							+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,"
							+ "sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' "
							+ "and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0) ag left join my_salm sm on sm.doc_no=ag.sal_id group by acno";
					
				}
				
				ResultSet resultSet = stmtDayBook.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				//System.out.println("ageing summary--->"+sql);
				}
				
				stmtDayBook.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray individualAgeingSummaryEXCEL(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
		        if(!(sqlUpToDate==null)){
		        	sql+="	 and j.date<='"+sqlUpToDate+"'";
			        }
				
				 if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";

					sql = "select ag.name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',coalesce(sm.sal_name,'') 'SALES_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,"
						+ "round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,"
						+ "round((balance),2),0))>0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance<0,"
						+ "round((balance),2),0)<0),round((sum(if(balance<0,round((balance),2),0)*-1)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(sum(if(balance>0,balance,0))>0,"
						+ "round((sum(if(balance>0,balance,0))),2),''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,"
						+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,"
						+ "sum(dramount) - coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j "
						+ "inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no "
						+ "left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
						+ "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" "
						+ "and j.id>0 group by j.tranid having balance<>0 union all select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,"
						+ "if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) balance, j.tranid,"
						+ "j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
						+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join "
						+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
						+ "j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0) ag left join my_salm sm on sm.doc_no=ag.sal_id group by acno";
				
		        } else if(atype.equalsIgnoreCase("AP")){
		        	condition=" and bk.dtype='VND'";
		        	
		        	sql = "select ag.name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',coalesce(sm.sal_name,'') 'SALES_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))>0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance>0,round((balance),2),0)>0),round((sum(if(balance>0,round((balance),2),0))),2),''),CHAR(50)) "
		        			+ "'UNAPPLIED',CONVERT(if(sum(if(balance<0,balance,0))<0,round((sum(if(balance<0,balance,0))),2)*-1,''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,"
		        			+ "h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" and j.id<0 group by j.tranid having balance<>0 union all select bk.sal_id,j.date,j.dtype,j.doc_no,j.acno,h.description name,"
							+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
							+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,"
							+ "sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' "
							+ "and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0) ag left join my_salm sm on sm.doc_no=ag.sal_id group by acno";
					
				}
				
				ResultSet resultSet = stmtDayBook.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtDayBook.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtIndividualAgeing1 = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtIndividualAgeing1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtIndividualAgeing1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	
	public ClsIndividualAgeingBean getPrint(String branch,String uptodate,String atype,String accdocno, String check) throws SQLException {
		 //System.out.println("Inside DAo 1");
		ClsIndividualAgeingBean bean = new ClsIndividualAgeingBean();
		  Connection conn = null;
		  java.sql.Date sqlUpToDate = null;
		  //System.out.println("Inside DAo 2"+check);
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtIndividualAgeing = conn.createStatement();
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		           }
				
					
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="",joins="",casestatement="",printqry= "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				//System.out.println("Inside DAo 3");
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);				
				//System.out.println("iab 1 ");

				if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";
					/*sql = "select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,"
							+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,"
							+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,"
							+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,"
							+ "CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,"
							+ "if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,"
							+ " if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
							+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,"
							+ "bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,"
							+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join "
							+ "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "
							+ " and bk.dtype='CRM' where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno";*/
				    
					printqry = "select @i:=@i+1 as srno,b.* from(select a.name,a.contact,coalesce(sm.sal_name,'') salname,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'ADVANCE',"
						+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance<0,"
						+ "round((balance),2),0)<0,round((if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance>0,balance,0)>0,round((if(balance>0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
						+ "a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.age,a.description from ("
						+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
						+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
						+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
						+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0 union all "
						+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
						+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
						+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
						+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 "
						+ "group by j.tranid having balance<>0) a left join my_salm sm on sm.doc_no=a.sal_id "+joins+" order by acno,date) b,(select @i:=0) r";
				
				//	System.out.println("iab 2---> "+printqry);
				}
				
				else if(atype.equalsIgnoreCase("AP")){
					condition=" and bk.dtype='VND'";
					/*sql="select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) advance,\r\n" + 
							  "CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) unapplied,\r\n" + 
							  "CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) balance,\r\n" + 
							  "CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) netamount,\r\n" + 
							  "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) level1,CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) level2,\r\n" + 
							  "CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) level4,\r\n" + 
							  "CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) level5 from\r\n" + 
							  "(select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,\r\n" + 
							  "d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,\r\n" + 
							  "if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between  "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							  "if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,\r\n" + 
							  "format(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from (\r\n" + 
							  "select j.acno,j.brhid,h.description name,\r\n" + 
							  "bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,\r\n" + 
							  "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join\r\n" + 
							  "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no\r\n" + 
							  "inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  and bk.dtype='VND' where\r\n" + 
							  "j.status=3 and h.atype='AP' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+"  group by tranid having bal<>0) d) ag group by acno";*/
							  
					printqry = "select @i:=@i+1 as srno,b.* from(select a.name,a.contact,coalesce(sm.sal_name,'') salname,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'ADVANCE',"  
							+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance>0,"
							+ "round((balance),2),0)>0,round((if(balance>0,round((balance),2),0)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance<0,balance,0)<0,round((if(balance<0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
							+ "a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.age,a.description from ("
							+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0 union all "
							+ "select bk.sal_id,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
							+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
							+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 "
							+ "group by j.tranid having balance<>0) a left join my_salm sm on sm.doc_no=a.sal_id "+joins+" order by acno,date) b,(select @i:=0) r";
					   
					//System.out.println("iab 3---> "+printqry);
				  }
				
				
				//System.out.println("iab 4 ");
				bean.setPqry(printqry);
				
				String compqry="select c.company,c.address,c.tel,c.fax,b.branchname from my_brch b   left join my_comp c on b.doc_no=c.comp_id where c.comp_id=1";
				//System.out.println("compqry-->"+compqry);
				Statement stmt=conn.createStatement();
				ResultSet rs=stmt.executeQuery(compqry);
				while(rs.next()){
					bean.setLblcompname(rs.getString("company"));
					//System.out.println("getprint compname--->"+rs.getString("company"));
					bean.setLblcompfax(rs.getString("fax"));
					bean.setLblcompaddress(rs.getString("address"));
					bean.setLblcomptel(rs.getString("tel"));
					bean.setLblbranch(rs.getString("branchname"));
					
				}
				
				
				stmtIndividualAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	
	}
	
}
