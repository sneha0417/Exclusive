package com.dashboard.accounts.currentageingstatementmonthly;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCurrentAgeingStatementMonthlyDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray currentAgeingStatementMonthlyGridLoading(String branch,String sqlUpToDate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
	       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCurrentAgeingStatementMonthly = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				String sql = "", sql1="",select="";
				
				if(atype.equalsIgnoreCase("AR")){
				    
				    select = "select ag.category,ag.name,ag.account, ag.acno, ag.brhid, ag.doc_no, ag.date,CONVERT(if(sum(ag.u6<0),round((sum(ag.u6)),2),''),CHAR(50)) 'unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))=0,'',"
				    	   + "(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))),CHAR(50)) 'totaloutstanding',CONVERT(if(sum(ag.currentmonth)>0,round((sum(ag.currentmonth)),2),''),CHAR(50)) 'currentmonth',"
				    	   + "CONVERT(if(sum(ag.previousmonth1)>0,round((sum(ag.previousmonth1)),2),''),CHAR(50)) 'previousmonth1',CONVERT(if(sum(ag.previousmonth2)>0,round((sum(ag.previousmonth2)),2),''),CHAR(50)) 'previousmonth2',"
				    	   + "CONVERT(if(sum(ag.previousmonth3)>0,round((sum(ag.previousmonth3)),2),''),CHAR(50)) 'previousmonth3',CONVERT(if(sum(ag.previousmonth4)>0,round((sum(ag.previousmonth4)),2),''),CHAR(50)) 'previousmonth4',"
				    	   + "CONVERT(if(sum(ag.previousmonth5)>0,round((sum(ag.previousmonth5)),2),''),CHAR(50)) 'previousmonth5',CONVERT(if(sum(ag.previousmonth6)>0,round((sum(ag.previousmonth6)),2),''),CHAR(50)) 'previousmonth6',"
				    	   + "CONVERT(if(sum(ag.previousmonth7)>0,round((sum(ag.previousmonth7)),2),''),CHAR(50)) 'previousmonth7',CONVERT(if(sum(ag.previousmonth8)>0,round((sum(ag.previousmonth8)),2),''),CHAR(50)) 'previousmonth8',"
				    	   + "CONVERT(if(sum(ag.previousmonth9)>0,round((sum(ag.previousmonth9)),2),''),CHAR(50)) 'previousmonth9',CONVERT(if(sum(ag.previousmonth10)>0,round((sum(ag.previousmonth10)),2),''),CHAR(50)) 'previousmonth10',"
				    	   + "CONVERT(if(sum(ag.nextmonth)>0,round((sum(ag.nextmonth)),2),''),CHAR(50)) 'nextmonth',ag.sal_name from ( "
				    	   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7,round(if((MONTH('"+sqlUpToDate+"')=MONTH(a.date) and  YEAR('"+sqlUpToDate+"')=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) currentmonth,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth1,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth2,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth3,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth4,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth5,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth6,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth7,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth8,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth9,"
				    	   + "round(if(LAST_DAY(DATE_SUB('"+sqlUpToDate+"',INTERVAL 10 MONTH))>=a.date and a.bal>0 ,round((a.bal),2),0),2) previousmonth10,round(if(LAST_DAY('"+sqlUpToDate+"')<a.date and a.bal>0 ,round((a.bal),2),0),2) nextmonth,s.sal_name,cat.category from ("
				    	   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal>0,d.bal,0) t7 from ";
				
				}   
				else if(atype.equalsIgnoreCase("AP")){
					
					select = "select ag.category,ag.name,ag.account, ag.acno, ag.brhid, ag.doc_no, ag.date,CONVERT(if(sum(ag.u6>0),round((sum(ag.u6)),2),''),CHAR(50)) 'unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))=0,''," 
							   + "(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))),CHAR(50)) 'totaloutstanding',CONVERT(if(sum(ag.currentmonth)<0,round((sum(ag.currentmonth)*-1),2),''),CHAR(50)) 'currentmonth',"
					    	   + "CONVERT(if(sum(ag.previousmonth1)<0,round((sum(ag.previousmonth1)*-1),2),''),CHAR(50)) 'previousmonth1',CONVERT(if(sum(ag.previousmonth2)<0,round((sum(ag.previousmonth2)*-1),2),''),CHAR(50)) 'previousmonth2',"
					    	   + "CONVERT(if(sum(ag.previousmonth3)<0,round((sum(ag.previousmonth3)*-1),2),''),CHAR(50)) 'previousmonth3',CONVERT(if(sum(ag.previousmonth4)<0,round((sum(ag.previousmonth4)*-1),2),''),CHAR(50)) 'previousmonth4',"
					    	   + "CONVERT(if(sum(ag.previousmonth5)<0,round((sum(ag.previousmonth5)*-1),2),''),CHAR(50)) 'previousmonth5',CONVERT(if(sum(ag.previousmonth6)<0,round((sum(ag.previousmonth6)*-1),2),''),CHAR(50)) 'previousmonth6',"
					    	   + "CONVERT(if(sum(ag.previousmonth7)<0,round((sum(ag.previousmonth7)*-1),2),''),CHAR(50)) 'previousmonth7',CONVERT(if(sum(ag.previousmonth8)<0,round((sum(ag.previousmonth8)*-1),2),''),CHAR(50)) 'previousmonth8',"
					    	   + "CONVERT(if(sum(ag.previousmonth9)<0,round((sum(ag.previousmonth9)*-1),2),''),CHAR(50)) 'previousmonth9',CONVERT(if(sum(ag.previousmonth10)<0,round((sum(ag.previousmonth10)*-1),2),''),CHAR(50)) 'previousmonth10',"
					    	   + "CONVERT(if(sum(ag.nextmonth)<0,round((sum(ag.nextmonth)*-1),2),''),CHAR(50)) 'nextmonth',ag.sal_name from ( "
					    	   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7,round(if((MONTH('"+sqlUpToDate+"')=MONTH(a.date) and  YEAR('"+sqlUpToDate+"')=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) currentmonth,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth1,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth2,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth3,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth4,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth5,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth6,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth7,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth8,"
					    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth9,"
					    	   + "round(if(LAST_DAY(DATE_SUB('"+sqlUpToDate+"',INTERVAL 10 MONTH))>=a.date and a.bal<0 ,round((a.bal),2),0),2) previousmonth10,round(if(LAST_DAY('"+sqlUpToDate+"')<a.date and a.bal<0 ,round((a.bal),2),0),2) nextmonth,s.sal_name,cat.category from ("
					    	   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal<0,d.bal,0) t7 from ";
				
				}      
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql1+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql1+=" and bk.catid="+category+"";
	    		}
				
			   sql =  select+"  ( "  
				   + "select j.acno,j.brhid,h.account,h.description name,sum(dramount-coalesce(out_amount,0)) bal, j.tranid,j.doc_no,coalesce(j.duedate,j.date) date from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='"+atype+"' "
				   + " "+sql+" group by j.tranid having bal<>0) d ) a left join my_acbook bk on (a.acno=bk.acno and bk.status=3) left join my_clcatm cat on bk.catid = cat.doc_no left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+") ag group by ag.acno";
			    System.out.println("ar sql===="+sql);
			    /*coalesce(j.duedate,j.date)<='"+sqlUpToDate+"'*/
				ResultSet resultSet = stmtCurrentAgeingStatementMonthly.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				   
				}     
				
				stmtCurrentAgeingStatementMonthly.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	  
	public JSONArray currentAgeingStatementMonthlyExcelExport(String branch,String sqlUpToDate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
	       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCurrentAgeingStatementMonthly = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				String currentmonth="",previousmonth1="",previousmonth2="",previousmonth3="",previousmonth4="",previousmonth5="",previousmonth6="",previousmonth7="",previousmonth8="",previousmonth9="";
				
				String sqlMonths = "select DATE_FORMAT('"+sqlUpToDate+"', '%b-%y') currentmonth,DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH), '%b-%y') previousmonth1,"
						  + "DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH), '%b-%y') previousmonth2,DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH), '%b-%y') previousmonth3,"
						  + "DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH), '%b-%y') previousmonth4,DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH), '%b-%y') previousmonth5," 
					      + "DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH), '%b-%y') previousmonth6,DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH), '%b-%y') previousmonth7,"
					      + "DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH), '%b-%y') previousmonth8,DATE_FORMAT(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH), '%b-%y') previousmonth9";
				
				ResultSet rs = stmtCurrentAgeingStatementMonthly.executeQuery(sqlMonths);
				
				while(rs.next()) {
					currentmonth=rs.getString("currentmonth");
					previousmonth1=rs.getString("previousmonth1");
					previousmonth2=rs.getString("previousmonth2");
					previousmonth3=rs.getString("previousmonth3");
					previousmonth4=rs.getString("previousmonth4");
					previousmonth5=rs.getString("previousmonth5");
					previousmonth6=rs.getString("previousmonth6");
					previousmonth7=rs.getString("previousmonth7");
					previousmonth8=rs.getString("previousmonth8");
					previousmonth9=rs.getString("previousmonth9");
				} 
				
				String sql = "", sql1="",select="";
				
				if(atype.equalsIgnoreCase("AR")){
				    
				    select = "select ag.sal_name 'Salesman',ag.account 'Account',ag.name 'Account Name',ag.category,CONVERT(if(sum(ag.previousmonth10)>0,round((sum(ag.previousmonth10)),2),''),CHAR(50)) 'Previous Months',"
				    	   + "CONVERT(if(sum(ag.previousmonth9)>0,round((sum(ag.previousmonth9)),2),''),CHAR(50)) '"+previousmonth9+"',CONVERT(if(sum(ag.previousmonth8)>0,round((sum(ag.previousmonth8)),2),''),CHAR(50)) '"+previousmonth8+"',"
				    	   + "CONVERT(if(sum(ag.previousmonth7)>0,round((sum(ag.previousmonth7)),2),''),CHAR(50)) '"+previousmonth7+"',CONVERT(if(sum(ag.previousmonth6)>0,round((sum(ag.previousmonth6)),2),''),CHAR(50)) '"+previousmonth6+"',"
				    	   + "CONVERT(if(sum(ag.previousmonth5)>0,round((sum(ag.previousmonth5)),2),''),CHAR(50)) '"+previousmonth5+"',CONVERT(if(sum(ag.previousmonth4)>0,round((sum(ag.previousmonth4)),2),''),CHAR(50)) '"+previousmonth4+"',"
				    	   + "CONVERT(if(sum(ag.previousmonth3)>0,round((sum(ag.previousmonth3)),2),''),CHAR(50)) '"+previousmonth3+"',CONVERT(if(sum(ag.previousmonth2)>0,round((sum(ag.previousmonth2)),2),''),CHAR(50)) '"+previousmonth2+"',"
				    	   + "CONVERT(if(sum(ag.previousmonth1)>0,round((sum(ag.previousmonth1)),2),''),CHAR(50)) '"+previousmonth1+"',CONVERT(if(sum(ag.currentmonth)>0,round((sum(ag.currentmonth)),2),''),CHAR(50)) '"+currentmonth+"',"
				    	   + "CONVERT(if(sum(ag.nextmonth)>0,round((sum(ag.nextmonth)),2),''),CHAR(50)) 'Next Months',CONVERT(if(sum(ag.u6<0),round((sum(ag.u6)),2),''),CHAR(50)) 'Unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-"
				    	   + "(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))=0,'',(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))-(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))),CHAR(50)) 'Grand Total' from ( "
				    	   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7,round(if((MONTH('"+sqlUpToDate+"')=MONTH(a.date) and  YEAR('"+sqlUpToDate+"')=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) currentmonth,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth1,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth2,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth3,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth4,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth5,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth6,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth7,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth8,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=YEAR(a.date)) and a.bal>0 ,round((a.bal),2),0),2) previousmonth9,"
				    	   + "round(if(LAST_DAY(DATE_SUB('"+sqlUpToDate+"',INTERVAL 10 MONTH))>=a.date and a.bal>0 ,round((a.bal),2),0),2) previousmonth10,round(if(LAST_DAY('"+sqlUpToDate+"')<a.date and a.bal>0 ,round((a.bal),2),0),2) nextmonth,s.sal_name,cat.category from ("
				    	   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal>0,d.bal,0) t7 from ";
				
				}
				else if(atype.equalsIgnoreCase("AP")){
					
					select = "select ag.sal_name 'Salesman',ag.account 'Account',ag.name 'Account Name',ag.category,CONVERT(if(sum(ag.previousmonth10)<0,round((sum(ag.previousmonth10)*-1),2),''),CHAR(50)) 'Previous Months',"
						   + "CONVERT(if(sum(ag.previousmonth9)<0,round((sum(ag.previousmonth9)*-1),2),''),CHAR(50)) '"+previousmonth9+"',CONVERT(if(sum(ag.previousmonth8)<0,round((sum(ag.previousmonth8)*-1),2),''),CHAR(50)) '"+previousmonth8+"',"
						   + "CONVERT(if(sum(ag.previousmonth7)<0,round((sum(ag.previousmonth7)*-1),2),''),CHAR(50)) '"+previousmonth7+"',CONVERT(if(sum(ag.previousmonth6)<0,round((sum(ag.previousmonth6)*-1),2),''),CHAR(50)) '"+previousmonth6+"',"
						   + "CONVERT(if(sum(ag.previousmonth5)<0,round((sum(ag.previousmonth5)*-1),2),''),CHAR(50)) '"+previousmonth5+"',CONVERT(if(sum(ag.previousmonth4)<0,round((sum(ag.previousmonth4)*-1),2),''),CHAR(50)) '"+previousmonth4+"',"
						   + "CONVERT(if(sum(ag.previousmonth3)<0,round((sum(ag.previousmonth3)*-1),2),''),CHAR(50)) '"+previousmonth3+"',CONVERT(if(sum(ag.previousmonth2)<0,round((sum(ag.previousmonth2)*-1),2),''),CHAR(50)) '"+previousmonth2+"',"
						   + "CONVERT(if(sum(ag.previousmonth1)<0,round((sum(ag.previousmonth1)*-1),2),''),CHAR(50)) '"+previousmonth1+"',CONVERT(if(sum(ag.currentmonth)<0,round((sum(ag.currentmonth)),2),''),CHAR(50)) '"+currentmonth+"',"
						   + "CONVERT(if(sum(ag.nextmonth)<0,round((sum(ag.nextmonth)*-1),2),''),CHAR(50)) 'Next Months',CONVERT(if(sum(ag.u6>0),round((sum(ag.u6)),2),''),CHAR(50)) 'Unapplied',CONVERT(if((if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-"
						   + "(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))=0,'',(if(sum(ag.t7+ag.u6)<0,round((sum(ag.t7+ag.u6)*-1),2),0))-(if(sum(ag.t7+ag.u6)>0,round((sum(ag.t7+ag.u6)),2),0))),CHAR(50)) 'Grand Total' from ( "
				    	   + "select a.name,a.account, a.acno, a.brhid, a.doc_no, a.date, a.bal, a.u6, a.t7,round(if((MONTH('"+sqlUpToDate+"')=MONTH(a.date) and  YEAR('"+sqlUpToDate+"')=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) currentmonth,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 1 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth1,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 2 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth2,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 3 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth3,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 4 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth4,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 5 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth5,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 6 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth6,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 7 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth7,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 8 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth8,"
				    	   + "round(if((MONTH(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=MONTH(a.date) and  YEAR(DATE_SUB('"+sqlUpToDate+"',INTERVAL 9 MONTH))=YEAR(a.date)) and a.bal<0 ,round((a.bal),2),0),2) previousmonth9,"
				    	   + "round(if(LAST_DAY(DATE_SUB('"+sqlUpToDate+"',INTERVAL 10 MONTH))>=a.date and a.bal<0 ,round((a.bal),2),0),2) previousmonth10,round(if(LAST_DAY('"+sqlUpToDate+"')<a.date and a.bal<0 ,round((a.bal),2),0),2) nextmonth,s.sal_name,cat.category from ("
				    	   + "select d.name,d.account,d.acno,d.brhid,d.doc_no,d.date,d.bal,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) u6,if(d.bal<0,d.bal,0) t7 from ";
					
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql1+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql1+=" and bk.catid="+category+"";
	    		}
				
			   sql =  select+"  ( "  
				   + "select j.acno,j.brhid,h.account,h.description name,sum(dramount-coalesce(out_amount,0)) bal, j.tranid,j.doc_no,coalesce(j.duedate,j.date) date from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='"+atype+"' "
				   		+ " "+sql+" group by j.tranid having bal<>0) d ) a left join my_acbook bk on (a.acno=bk.acno and bk.status=3) left join my_clcatm cat on bk.catid = cat.doc_no left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+") ag group by ag.acno";
                System.out.println("excelsql===="+sql);
				ResultSet resultSet = stmtCurrentAgeingStatementMonthly.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);  
				
				}
				      
				stmtCurrentAgeingStatementMonthly.close();
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
		        Statement stmtCurrentAgeingStatementMonthly = conn.createStatement();
			
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
	            
				sql = "select a.per_mob,a.mail1 email,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtCurrentAgeingStatementMonthly.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtCurrentAgeingStatementMonthly.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsCurrentAgeingStatementMonthlyBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String sqlUpToDate) throws SQLException {
		
		ClsCurrentAgeingStatementMonthlyBean bean = new ClsCurrentAgeingStatementMonthlyBean();

		Connection conn = null;
		
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtCurrentAgeingStatementMonthly = conn.createStatement();
		
		java.sql.Date sqlDate=null;
		// sqlDate=ClsCommon.changeStringtoSqlDate(sqlUpToDate);
		
		String headersql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%M  %Y ')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name "
				+ "location,b.branchname,b.pbno,b.stcno,b.cstno from my_acbook bk inner join my_jvtran j on bk.acno=j.acno inner join my_brch b on j.brhid=b.doc_no inner join "
				+ "my_comp c on bk.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by "
				+ "brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where j.acno="+acno+" group by j.acno";
				
				ResultSet resultSetHead = stmtCurrentAgeingStatementMonthly.executeQuery(headersql);
				
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
		
		ResultSet resultSet = stmtCurrentAgeingStatementMonthly.executeQuery(sql);
		
		while(resultSet.next()){
						
			bean.setLblaccountno(resultSet.getString("account"));
			bean.setLblaccountname(resultSet.getString("description"));
			bean.setLblaccountaddress(resultSet.getString("customeraddress"));
			bean.setLblaccountemail(resultSet.getString("customeremail"));
			bean.setLblaccountmobileno(resultSet.getString("customermobile"));
			bean.setLblaccountphone(resultSet.getString("customertel"));
			bean.setLblaccountfax(resultSet.getString("customerfax"));
		}
		
		stmtCurrentAgeingStatementMonthly.close();
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
