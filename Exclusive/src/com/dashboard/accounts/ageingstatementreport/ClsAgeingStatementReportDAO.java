package com.dashboard.accounts.ageingstatementreport;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgeingStatementReportDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray ageingStatementReportGridLoading(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
         
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAgeingStatementReport = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				 }
				 
				String sql = "", sql1="", sql2="", sqld = "",sqld1 = "",select="" , dtype="";
				
				if(atype.equalsIgnoreCase("AR")){
					sqld=" and j.id < 0";
					sqld1=" and j.id > 0";
					dtype="CRM";
					
				    select = "select ag.name,ag.account, ag.acno, ag.brhid, ag.doc_no, ag.date, CONVERT(if(sum(ag.u6<0),round((sum(ag.u6)),2),''),CHAR(50)) 'unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))=0,''," 
				    	   + "(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))),CHAR(50)) 'totaloutstanding',CONVERT(if(sum(ag.advancepdc<0),round((sum(ag.advancepdc)),2),''),CHAR(50)) 'advancepdc',"
				    	   + "CONVERT(if(sum(ag.current)>0,round((sum(ag.current)),2),''),CHAR(50)) 'current',CONVERT(if(sum(ag.month1)>0,round((sum(ag.month1)),2),''),CHAR(50)) 'month1',CONVERT(if(sum(ag.month2)>0,round((sum(ag.month2)),2),''),CHAR(50)) 'month2',"
				    	   + "CONVERT(if(sum(ag.month3)>0,round((sum(ag.month3)),2),''),CHAR(50)) 'month3',CONVERT(if(sum(ag.month4)>0,round((sum(ag.month4)),2),''),CHAR(50)) 'month4',CONVERT(if(sum(ag.month5)>0,round((sum(ag.month5)),2),''),CHAR(50)) 'month5',"
				    	   + "CONVERT(if(sum(ag.month6)>0,round((sum(ag.month6)),2),''),CHAR(50)) 'month6',CONVERT(if(sum(ag.month7)>0,round((sum(ag.month7)),2),''),CHAR(50)) 'month7',CONVERT(if(sum(ag.month8)>0,round((sum(ag.month8)),2),''),CHAR(50)) 'month8',"
				    	   + "CONVERT(if(sum(ag.month9)>0,round((sum(ag.month9)),2),''),CHAR(50)) 'month9',CONVERT(if(sum(ag.month10)>0,round((sum(ag.month10)),2),''),CHAR(50)) 'month10',CONVERT(if(sum(ag.month11)>0,round((sum(ag.month11)),2),''),CHAR(50)) 'month11',"
				    	   + "CONVERT(if(sum(ag.month12)>0,round((sum(ag.month12)),2),''),CHAR(50)) 'month12',CONVERT(if(sum(ag.greatermonth12)>0,round((sum(ag.greatermonth12)),2),''),CHAR(50)) 'greatermonth12',ag.sal_name,ag.cat_name,ag.creditterms,ag.email from ( " 
						   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7, a.advancepdc,"
						   + "round(if('"+sqlUpToDate+"' >= a.date and '"+sqlUpToDate+"' < DATE_ADD(a.date, INTERVAL bk.credit DAY) and a.bal>0,round((a.bal),2),0),2) current," 
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD(a.date, INTERVAL bk.credit DAY) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and a.bal>0,round((a.bal),2),0),2) month1,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and a.bal>0,round((a.bal),2),0),2) month2,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and a.bal>0,round((a.bal),2),0),2) month3,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and a.bal>0,round((a.bal),2),0),2) month4,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and a.bal>0,round((a.bal),2),0),2) month5,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and a.bal>0,round((a.bal),2),0),2) month6,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and a.bal>0,round((a.bal),2),0),2) month7,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and a.bal>0,round((a.bal),2),0),2) month8,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and a.bal>0,round((a.bal),2),0),2) month9,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and a.bal>0,round((a.bal),2),0),2) month10,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and a.bal>0,round((a.bal),2),0),2) month11,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal>0,round((a.bal),2),0),2) month12,"
						   + "round(if('"+sqlUpToDate+"'> DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal>0,round((a.bal),2),0),2) greatermonth12,s.sal_name,ct.cat_name,bk.credit creditterms,bk.mail1 email from ("  
						   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal>0,d.bal,0) t7,coalesce(d.advancepdc,0) advancepdc from ";
					    
				}
				else if(atype.equalsIgnoreCase("AP")){
					sqld=" and j.id > 0";
					sqld1=" and j.id < 0";
					dtype="VND";
					
					select = "select ag.name,ag.account, ag.acno, ag.brhid, ag.doc_no, ag.date, CONVERT(if(sum(ag.u6>0),round((sum(ag.u6)),2),''),CHAR(50)) 'unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))=0,''," 
						   + "(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))),CHAR(50)) 'totaloutstanding',CONVERT(if(sum(ag.advancepdc<0),round((sum(ag.advancepdc)),2),''),CHAR(50)) 'advancepdc',"
						   + "CONVERT(if(sum(ag.current)<0,round((sum(ag.current)*-1),2),''),CHAR(50)) 'current',CONVERT(if(sum(ag.month1)<0,round((sum(ag.month1)*-1),2),''),CHAR(50)) 'month1',CONVERT(if(sum(ag.month2)<0,round((sum(ag.month2)*-1),2),''),CHAR(50)) 'month2',"
						   + "CONVERT(if(sum(ag.month3)<0,round((sum(ag.month3)*-1),2),''),CHAR(50)) 'month3',CONVERT(if(sum(ag.month4)<0,round((sum(ag.month4)*-1),2),''),CHAR(50)) 'month4',CONVERT(if(sum(ag.month5)<0,round((sum(ag.month5)*-1),2),''),CHAR(50)) 'month5',"
						   + "CONVERT(if(sum(ag.month6)<0,round((sum(ag.month6)*-1),2),''),CHAR(50)) 'month6',CONVERT(if(sum(ag.month7)<0,round((sum(ag.month7)*-1),2),''),CHAR(50)) 'month7',CONVERT(if(sum(ag.month8)<0,round((sum(ag.month8)*-1),2),''),CHAR(50)) 'month8',"
						   + "CONVERT(if(sum(ag.month9)<0,round((sum(ag.month9)*-1),2),''),CHAR(50)) 'month9',CONVERT(if(sum(ag.month10)<0,round((sum(ag.month10)*-1),2),''),CHAR(50)) 'month10',CONVERT(if(sum(ag.month11)<0,round((sum(ag.month11)*-1),2),''),CHAR(50)) 'month11',"
						   + "CONVERT(if(sum(ag.month12)<0,round((sum(ag.month12)*-1),2),''),CHAR(50)) 'month12',CONVERT(if(sum(ag.greatermonth12)<0,round((sum(ag.greatermonth12)*-1),2),''),CHAR(50)) 'greatermonth12',ag.sal_name,ag.cat_name,ag.creditterms,ag.email from ( " 
						   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7, a.advancepdc,"
						   + "round(if('"+sqlUpToDate+"' >= a.date and '"+sqlUpToDate+"' < DATE_ADD(a.date, INTERVAL bk.credit DAY) and a.bal<0,round((a.bal),2),0),2) current," 
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD(a.date, INTERVAL bk.credit DAY) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and a.bal<0,round((a.bal),2),0),2) month1,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and a.bal<0,round((a.bal),2),0),2) month2,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and a.bal<0,round((a.bal),2),0),2) month3,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and a.bal<0,round((a.bal),2),0),2) month4,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and a.bal<0,round((a.bal),2),0),2) month5,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and a.bal<0,round((a.bal),2),0),2) month6,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and a.bal<0,round((a.bal),2),0),2) month7,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and a.bal<0,round((a.bal),2),0),2) month8,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and a.bal<0,round((a.bal),2),0),2) month9,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and a.bal<0,round((a.bal),2),0),2) month10,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and a.bal<0,round((a.bal),2),0),2) month11,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal<0,round((a.bal),2),0),2) month12,"
						   + "round(if('"+sqlUpToDate+"'> DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal<0,round((a.bal),2),0),2) greatermonth12,s.sal_name,ct.cat_name,bk.credit creditterms,bk.mail1 email from ("
						   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal<0,d.bal,0) t7,coalesce(d.advancepdc,0) advancepdc from ";
					
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    			sql2+=" and m.brhid="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
					sql2+=" and d.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql1+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql1+=" and bk.catid="+category+"";
	    		}
				
			   sql =  select+"  ( "  
				   + "select j.acno,j.brhid,h.account,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid,j.doc_no,j.date,0 advancepdc from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "  
				   + "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld1+" group by j.tranid having bal<>0  union all select j.acno,j.brhid,h.account,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, "
				   + "j.tranid, j.doc_no,j.date,0 advancepdc from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 "
				   + "and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld+" group by j.tranid having bal<>0 union all select d.acno,m.brhid,h.account,h.description name,0 bal,0 tranid,m.doc_no,m.date,d.amount advancepdc from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno left join my_head h on "
				   + "d.acno=h.doc_no where m.status=3 and m.bpvno=0 and h.atype='"+atype+"'"+sql2+") d ) a left join my_acbook bk on (a.account=bk.acno and bk.status=3) left join my_salm s on bk.sal_id=s.doc_no left join my_clcatm ct on (bk.catid=ct.doc_no and ct.dtype='"+dtype+"') where 1=1"+sql1+") ag group by ag.acno";

				ResultSet resultSet = stmtAgeingStatementReport.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtAgeingStatementReport.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray ageingStatementReportExcelExport(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
	       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
         
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAgeingStatementReport = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				 }
				 
				String sql = "", sql1="", sql2="", sqld = "",sqld1 = "",select="" , dtype="";
				
				if(atype.equalsIgnoreCase("AR")){
					sqld=" and j.id < 0";
					sqld1=" and j.id > 0";
					dtype="CRM";
					
				    select = "select ag.account 'Account', ag.name 'Account Name', CONVERT(if((if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))=0,''," 
				    	   + "(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))),CHAR(50)) 'Total Outstanding',CONVERT(if(sum(ag.u6<0),round((sum(ag.u6)),2),''),CHAR(50)) 'Unapplied',"
				    	   + "CONVERT(if(sum(ag.current)>0,round((sum(ag.current)),2),''),CHAR(50)) 'Current',CONVERT(if(sum(ag.month1)>0,round((sum(ag.month1)),2),''),CHAR(50)) '1 Month',CONVERT(if(sum(ag.month2)>0,round((sum(ag.month2)),2),''),CHAR(50)) '2 Months',"
				    	   + "CONVERT(if(sum(ag.month3)>0,round((sum(ag.month3)),2),''),CHAR(50)) '3 Months',CONVERT(if(sum(ag.month4)>0,round((sum(ag.month4)),2),''),CHAR(50)) '4 Months',CONVERT(if(sum(ag.month5)>0,round((sum(ag.month5)),2),''),CHAR(50)) '5 Months',"
				    	   + "CONVERT(if(sum(ag.month6)>0,round((sum(ag.month6)),2),''),CHAR(50)) '6 Months',CONVERT(if(sum(ag.month7)>0,round((sum(ag.month7)),2),''),CHAR(50)) '7 Months',CONVERT(if(sum(ag.month8)>0,round((sum(ag.month8)),2),''),CHAR(50)) '8 Months',"
				    	   + "CONVERT(if(sum(ag.month9)>0,round((sum(ag.month9)),2),''),CHAR(50)) '9 Months',CONVERT(if(sum(ag.month10)>0,round((sum(ag.month10)),2),''),CHAR(50)) '10 Months',CONVERT(if(sum(ag.month11)>0,round((sum(ag.month11)),2),''),CHAR(50)) '11 Months',"
				    	   + "CONVERT(if(sum(ag.month12)>0,round((sum(ag.month12)),2),''),CHAR(50)) '12 Months',CONVERT(if(sum(ag.greatermonth12)>0,round((sum(ag.greatermonth12)),2),''),CHAR(50)) 'Greater Than 12 Months',CONVERT(if(sum(ag.advancepdc<0),round((sum(ag.advancepdc)),2),''),CHAR(50)) 'Advance PDC',"
				    	   + "ag.creditterms 'Credit Terms',ag.cat_name 'Category',ag.sal_name 'Sales Man' from ( " 
						   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7, a.advancepdc,"
						   + "round(if('"+sqlUpToDate+"' >= a.date and '"+sqlUpToDate+"' < DATE_ADD(a.date, INTERVAL bk.credit DAY) and a.bal>0,round((a.bal),2),0),2) current," 
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD(a.date, INTERVAL bk.credit DAY) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and a.bal>0,round((a.bal),2),0),2) month1,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and a.bal>0,round((a.bal),2),0),2) month2,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and a.bal>0,round((a.bal),2),0),2) month3,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and a.bal>0,round((a.bal),2),0),2) month4,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and a.bal>0,round((a.bal),2),0),2) month5,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and a.bal>0,round((a.bal),2),0),2) month6,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and a.bal>0,round((a.bal),2),0),2) month7,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and a.bal>0,round((a.bal),2),0),2) month8,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and a.bal>0,round((a.bal),2),0),2) month9,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and a.bal>0,round((a.bal),2),0),2) month10,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and a.bal>0,round((a.bal),2),0),2) month11,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal>0,round((a.bal),2),0),2) month12,"
						   + "round(if('"+sqlUpToDate+"'> DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal>0,round((a.bal),2),0),2) greatermonth12,s.sal_name,ct.cat_name,bk.credit creditterms from ("  
						   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal>0,d.bal,0) t7,coalesce(d.advancepdc,0) advancepdc from ";
					    
				}
				else if(atype.equalsIgnoreCase("AP")){
					sqld=" and j.id > 0";
					sqld1=" and j.id < 0";
					dtype="VND";
					
					select = "select ag.account, ag.name 'Account Name', CONVERT(if((if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))=0,''," 
						   + "(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))),CHAR(50)) 'Total Outstanding',CONVERT(if(sum(ag.u6>0),round((sum(ag.u6)),2),''),CHAR(50)) 'Unapplied',"
						   + "CONVERT(if(sum(ag.current)<0,round((sum(ag.current)*-1),2),''),CHAR(50)) 'Current',CONVERT(if(sum(ag.month1)<0,round((sum(ag.month1)*-1),2),''),CHAR(50)) '1 Month',CONVERT(if(sum(ag.month2)<0,round((sum(ag.month2)*-1),2),''),CHAR(50)) '2 Months',"
						   + "CONVERT(if(sum(ag.month3)<0,round((sum(ag.month3)*-1),2),''),CHAR(50)) '3 Months',CONVERT(if(sum(ag.month4)<0,round((sum(ag.month4)*-1),2),''),CHAR(50)) '4 Months',CONVERT(if(sum(ag.month5)<0,round((sum(ag.month5)*-1),2),''),CHAR(50)) '5 Months',"
						   + "CONVERT(if(sum(ag.month6)<0,round((sum(ag.month6)*-1),2),''),CHAR(50)) '6 Months',CONVERT(if(sum(ag.month7)<0,round((sum(ag.month7)*-1),2),''),CHAR(50)) '7 Months',CONVERT(if(sum(ag.month8)<0,round((sum(ag.month8)*-1),2),''),CHAR(50)) '8 Months',"
						   + "CONVERT(if(sum(ag.month9)<0,round((sum(ag.month9)*-1),2),''),CHAR(50)) '9 Months',CONVERT(if(sum(ag.month10)<0,round((sum(ag.month10)*-1),2),''),CHAR(50)) '10 Months',CONVERT(if(sum(ag.month11)<0,round((sum(ag.month11)*-1),2),''),CHAR(50)) '11 Months',"
						   + "CONVERT(if(sum(ag.month12)<0,round((sum(ag.month12)*-1),2),''),CHAR(50)) '12 Months',CONVERT(if(sum(ag.greatermonth12)<0,round((sum(ag.greatermonth12)*-1),2),''),CHAR(50)) 'Greater Than 12 Months',CONVERT(if(sum(ag.advancepdc<0),round((sum(ag.advancepdc)),2),''),CHAR(50)) 'Advance PDC',"
						   + "ag.creditterms 'Credit terms',ag.cat_name 'Category',ag.sal_name 'Sales Man' from ( " 
						   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7, a.advancepdc,"
						   + "round(if('"+sqlUpToDate+"' >= a.date and '"+sqlUpToDate+"' < DATE_ADD(a.date, INTERVAL bk.credit DAY) and a.bal<0,round((a.bal),2),0),2) current," 
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD(a.date, INTERVAL bk.credit DAY) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and a.bal<0,round((a.bal),2),0),2) month1,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 1 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and a.bal<0,round((a.bal),2),0),2) month2,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 2 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and a.bal<0,round((a.bal),2),0),2) month3,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 3 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and a.bal<0,round((a.bal),2),0),2) month4,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 4 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and a.bal<0,round((a.bal),2),0),2) month5,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 5 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and a.bal<0,round((a.bal),2),0),2) month6,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 6 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and a.bal<0,round((a.bal),2),0),2) month7,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 7 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and a.bal<0,round((a.bal),2),0),2) month8,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 8 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and a.bal<0,round((a.bal),2),0),2) month9,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 9 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and a.bal<0,round((a.bal),2),0),2) month10,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 10 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and a.bal<0,round((a.bal),2),0),2) month11,"
						   + "round(if('"+sqlUpToDate+"' >= DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 11 MONTH) and '"+sqlUpToDate+"' < DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal<0,round((a.bal),2),0),2) month12,"
						   + "round(if('"+sqlUpToDate+"'> DATE_ADD((DATE_ADD(a.date, INTERVAL bk.credit DAY)), INTERVAL 12 MONTH) and a.bal<0,round((a.bal),2),0),2) greatermonth12,s.sal_name,ct.cat_name,bk.credit creditterms from ("
						   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal<0,d.bal,0) t7,coalesce(d.advancepdc,0) advancepdc from ";
					
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    			sql2+=" and m.brhid="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
					sql2+=" and d.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql1+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql1+=" and bk.catid="+category+"";
	    		}
				
			   sql =  select+"  ( "  
				   + "select j.acno,j.brhid,h.account,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid,j.doc_no,j.date,0 advancepdc from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "  
				   + "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld1+" group by j.tranid having bal<>0  union all select j.acno,j.brhid,h.account,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, "
				   + "j.tranid, j.doc_no,j.date,0 advancepdc from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 "
				   + "and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld+" group by j.tranid having bal<>0 union all select d.acno,m.brhid,h.account,h.description name,0 bal,0 tranid,m.doc_no,m.date,d.amount advancepdc from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno left join my_head h on "
				   + "d.acno=h.doc_no where m.status=3 and m.bpvno=0 and h.atype='"+atype+"'"+sql2+") d ) a left join my_acbook bk on (a.account=bk.acno and bk.status=3) left join my_salm s on bk.sal_id=s.doc_no left join my_clcatm ct on (bk.catid=ct.doc_no and ct.dtype='"+dtype+"') where 1=1"+sql1+") ag group by ag.acno";

				ResultSet resultSet = stmtAgeingStatementReport.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtAgeingStatementReport.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtAgeingStatementReport1 = conn.createStatement();
			
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
				
				ResultSet resultSet1 = stmtAgeingStatementReport1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtAgeingStatementReport1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	public  ClsAgeingStatementReportBean getCusConfirmPrint(HttpServletRequest request,int acno) throws SQLException {
		
		ClsAgeingStatementReportBean bean = new ClsAgeingStatementReportBean();

		Connection conn = null;
		
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtAgeingStatementReport = conn.createStatement();
		String sql="select coalesce (refname,'')refname,coalesce(address,'')address, per_mob,fax1 fax,mail1 email   from my_acbook ac where acno="+acno+";";
				ResultSet resultSet = stmtAgeingStatementReport.executeQuery(sql);
				
				while(resultSet.next()){
					bean.setRefname(resultSet.getString("refname"));
					bean.setAddress(resultSet.getString("address"));
					bean.setPer_mob(resultSet.getString("per_mob"));
					bean.setFax(resultSet.getString("fax"));
					bean.setEmail(resultSet.getString("email"));
					
				}
				String datesql="select DATE_FORMAT(curdate(),'%d-%m-%Y' ) as date;";
				ResultSet dateresultSet = stmtAgeingStatementReport.executeQuery(datesql);
				while(dateresultSet.next()){
					bean.setCur_date(dateresultSet.getString("date"));
					
				}
				String amuntsql="select sum(round(dramount,2)) balance from my_jvtran where status=3 and yrid=0 and acno="+acno+";";
				ResultSet amuntresultSet = stmtAgeingStatementReport.executeQuery(amuntsql);
				while(amuntresultSet.next()){
					bean.setAed_amount(amuntresultSet.getString("balance"));
					
				}
				
			}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}finally{
					conn.close();
				}
				return bean;
			  }
	
	
	
	
	public  ClsAgeingStatementReportBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String uptodate) throws SQLException {
			
		ClsAgeingStatementReportBean bean = new ClsAgeingStatementReportBean();

		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
        
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtAgeingStatementReport = conn.createStatement();
		
		if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
		
		String headersql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name "
				+ "location,b.branchname,b.pbno,b.stcno,b.cstno from my_acbook bk inner join my_jvtran j on bk.acno=j.acno inner join my_brch b on j.brhid=b.doc_no inner join "
				+ "my_comp c on bk.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by "
				+ "brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where j.acno="+acno+" group by j.acno";
				
				ResultSet resultSetHead = stmtAgeingStatementReport.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
				}
				
		String sql="select j.acno,coalesce(t.account,'') account,coalesce(t.description,'') description,coalesce(a.period,0) minperiod,coalesce(a.period2,0) maxperiod,coalesce(a.credit,0) creditlimit,coalesce(a.address,'') customeraddress,coalesce(a.mail1,'') customeremail,"
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax from my_jvtran j left join my_head t on j.acno=t.doc_no left join my_acbook a on a.acno=t.doc_no where "
				+ "j.acno="+acno+" group by acno";
		
		ResultSet resultSet = stmtAgeingStatementReport.executeQuery(sql);
		
		while(resultSet.next()){
						
			bean.setLblaccountno(resultSet.getString("account"));
			bean.setLblaccountname(resultSet.getString("description"));
			bean.setLblaccountaddress(resultSet.getString("customeraddress"));
			bean.setLblaccountemail(resultSet.getString("customeremail"));
			bean.setLblaccountmobileno(resultSet.getString("customermobile"));
			bean.setLblaccountphone(resultSet.getString("customertel"));
			bean.setLblaccountfax(resultSet.getString("customerfax"));
			bean.setLblcreditperiodmin(resultSet.getString("minperiod"));
			bean.setLblcreditperiodmax(resultSet.getString("maxperiod"));
			bean.setLblcreditlimit(resultSet.getString("creditlimit"));
		}
		
		stmtAgeingStatementReport.close();
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
