package com.dashboard.fixedasset.fixedassetregister;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFixedAssetRegister  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray fixedAsssetGridLoading(String branch,String fromdate,String todate,String assetNo,String group,String reportType,String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBFAR = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			        
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			     }
			     
			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			     }
			     String sql="";
			     String strSql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and d.brhid="+branch+"";
		    	 }
			     
			     if(!((assetNo.equalsIgnoreCase("")) || (assetNo.equalsIgnoreCase("0")))){
			    	   sql=sql+"  and d.asset_no='"+assetNo+"'";
		         }
	             
			     if(!((group.equalsIgnoreCase("")) || (group.equalsIgnoreCase("0")))){
			    	 	sql=sql+" and d.assetgpid='"+group+"'";
	             }
			     
			     if(reportType.equalsIgnoreCase("2")){
			    	 strSql+=" having round(SUM(d.asset_del),2)!=0 or round(SUM(d.depr_del),2)!=0 ";
			    	// strSql+=" having if(sum(d.asset_del)>0,round(sum(d.asset_del),2),0)!=0  or if(sum(d.depr_del)<0,round(sum(d.depr_del)*-1,2),0)!=0";
			     }else if(reportType.equalsIgnoreCase("3")){
			    	strSql+=" having round(SUM(d.asset_add),2)!=0 ";
					//strSql+=" having round(SUM(d.asset_add),2)!=0 or round(SUM(d.depr_add),2)!=0 ";
			    	// strSql+=" having if(sum(d.asset_add)>0,round(sum(d.asset_add),2),0)!=0  or if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),0)!=0";
			     }
			     
			     /*sql = "select d.asset_no,d.date,CONVERT(if(sum(d.asset_opn)>0,round(sum(d.asset_opn),2),''),CHAR(100)) assetopn,CONVERT(if(sum(d.asset_add)>0,round(sum(d.asset_add),2),''),CHAR(100)) assetadd,CONVERT(if(sum(d.asset_del)>0,"
			     		+ "round(sum(d.asset_del),2),''),CHAR(100)) assetdel,CONVERT(if(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)>0,(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)),''),"
			     		+ "CHAR(100)) assettotal,CONVERT(if(sum(d.depr_opn)<0,round(sum(d.depr_opn)*-1,2),''),CHAR(100)) depropn,CONVERT(if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),''),CHAR(100)) depradd,CONVERT(if(sum(d.depr_del)<0,"
			     		+ "round(sum(d.depr_del)*-1,2),''),CHAR(100)) deprdel,CONVERT(if(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2)<0,(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2))*-1,''),CHAR(100)) "
			     		+ "deprtotal,((round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2))+(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2))) nettotal,(round(sum(d.asset_opn),2)+round(sum(d.depr_opn),2)) prevyear,"
			     		+ "d.assetid,d.assetname,d.assetgp,d.purdate,((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) age,d.brhid,d.assetgpid from ("
			     		+ "select a.asset_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a "
			     		+ "left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,a.dramount asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno and a.ttype='ASI' UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join "
			     		+ "my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,a.dramount depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno and a.ttype='ASI')d where d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+"";*/
				
				/*sql = "select d.asset_no,d.date,CONVERT(if(sum(d.asset_opn)>0,round(sum(d.asset_opn),2),''),CHAR(100)) assetopn,CONVERT(if(sum(d.asset_add)>0,round(sum(d.asset_add),2),''),CHAR(100)) assetadd,CONVERT(if(sum(d.asset_del)>0,"
			     		+ "round(sum(d.asset_del),2),''),CHAR(100)) assetdel,CONVERT(if(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)>0,(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)),''),"
			     		+ "CHAR(100)) assettotal,CONVERT(if(sum(d.depr_opn)<0,round(sum(d.depr_opn)*-1,2),''),CHAR(100)) depropn,CONVERT(if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),''),CHAR(100)) depradd,CONVERT(if(sum(d.depr_del)<0,"
			     		+ "round(sum(d.depr_del)*-1,2),''),CHAR(100)) deprdel,CONVERT(if(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2)<0,(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2))*-1,''),CHAR(100)) "
			     		+ "deprtotal,((round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2))+(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2))) nettotal,(round(sum(d.asset_opn),2)+round(sum(d.depr_opn),2)) prevyear,"
			     		+ "d.assetid,d.assetname,d.assetgp,d.purdate,d.deprper,((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) age,d.brhid,d.assetgpid from ("
			     		+ "select a.asset_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a "
			     		+ "left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,a.dramount asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno and a.ttype='ASI' UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join "
			     		+ "my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,a.dramount depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno and a.ttype='ASI')d where d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+"";*/
				
				 sql = "SELECT m.asset_no,m.assetname,m.assetid,m.age,m.deprper,m.purdate,m.brhid,m.assetgp,m.date,m.assetgpid,\r\n" + 
			     		"CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)) assetopn,\r\n" + 
			     		"CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)) assetadd,\r\n" + 
			     		"CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)) assetdel,\r\n" + 
			     		"CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)) assettotal,\r\n" + 
			     		"CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)) depropn,\r\n" + 
			     		"CONVERT(if(m.depr_add=0,'',if(m.depr_add<0,m.depr_add*-1,m.depr_add)),CHAR(100)) depradd,\r\n" + 
			     		"CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)) deprdel,\r\n" + 
			     		"CONVERT(if(m.deprtotal=0,'',if(m.deprtotal<0,m.deprtotal*-1,m.deprtotal)),CHAR(100)) deprtotal,\r\n" + 
			     		"CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)) nettotal,\r\n" + 
			     		"CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)) prevyear FROM (\r\n" + 
			     		"SELECT l.asset_no,l.assetid,l.assetname,l.assetgp,l.age,l.purdate,l.asset_opn,l.asset_add,l.asset_del,\r\n" + 
			     		"(l.asset_opn+l.asset_add+l.asset_del) assettotal,l.depr_opn,l.depr_add,l.depr_del,(l.depr_opn+l.depr_add+l.depr_del)  deprtotal,\r\n" + 
			     		"((l.asset_opn+l.asset_add+l.asset_del)+(l.depr_opn+l.depr_add+l.depr_del)) nettotal,(l.asset_opn+l.depr_opn) prevyear,\r\n" + 
			     		"l.deprper,l.brhid,l.date,l.assetgpid FROM (\r\n" + 
			     		"select d.asset_no,d.date,round(SUM(d.asset_opn),2) asset_opn,round(SUM(d.asset_add),2) asset_add,round(SUM(d.asset_del),2)\r\n" + 
			     		"asset_del,round(SUM(d.depr_opn),2) depr_opn,round(SUM(d.depr_add),2) depr_add,round(SUM(d.depr_del),2) depr_del,\r\n" + 
			     		"d.assetid,d.assetname,d.assetgp,d.purdate,((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) age,d.deprper,d.brhid,d.assetgpid from (\r\n" + 
			     		"select a.asset_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'') asset_add,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') asset_del,0.00 depr_opn,\r\n" + 
			     		"0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from\r\n" + 
			     		"my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno\r\n" + 
			     		"UNION ALL\r\n" + 
			     		"select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') depr_add,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'')  depr_del,\r\n" + 
			     		"v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a\r\n" + 
			     		"left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno\r\n" + 
			     		") d\r\n" + 
			     		"left join my_fasaled sd on sd.assetid=d.asset_no left join my_fasalem sm on sm.doc_no=sd.rdocno where coalesce(sm.date,\r\n" + 
			     		"'"+sqlFromDate+"')>='"+sqlFromDate+"' and d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+" ) l ) m";
			     
				ResultSet resultSet = stmtBFAR.executeQuery(sql);
				System.out.println("grid load"+sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
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
	
	
	public JSONArray fixedDetailedAsssetGridLoading(String branch,String fromdate,String todate,String assetNo) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBFAR = conn.createStatement();
				
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			        
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			     }
			     
			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			     }
			     
			     String sql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and d.brhid="+branch+"";
		    	 }
			     
			     sql = "select a.asset_no,a.date,CONVERT(if(a.dramount>0,a.dramount,''),CHAR(100)) debit,CONVERT(if(a.dramount<0,a.dramount*-1,''),\r\n" + 
							"CHAR(100)) credit,a.ttype,a.acno,v.assetid,v.assetname,t.description,(select round(coalesce(sum(dramount),0),2) from\r\n" + 
							"my_fatran where asset_no="+assetNo+" and date<='"+sqlToDate+"') bookvalue from my_fatran a left join my_fixm v on a.asset_no=v.sr_no\r\n" + 
							"left join my_head t on a.acno=t.doc_no where a.asset_no="+assetNo+" and a.date<='"+sqlToDate+"'"+sql+"";
			    
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
	
	public JSONArray fixedAsssetExcelExport(String branch,String fromdate,String todate,String assetNo,String group,String reportType,String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
	    	conn=ClsConnection.getMyConnection();
			Statement stmtBFAR = conn.createStatement();
			
			if(check.equalsIgnoreCase("1")){
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     String sql="";
		     String strSql="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and d.brhid="+branch+"";
	    	 }
		     
		     if(!((assetNo.equalsIgnoreCase("")) || (assetNo.equalsIgnoreCase("0")))){
		    	   sql=sql+"  and d.asset_no='"+assetNo+"'";
	         }
           
		     if(!((group.equalsIgnoreCase("")) || (group.equalsIgnoreCase("0")))){
		    	 	sql=sql+" and d.assetgp='"+group+"'";
             }
		     
		     if(reportType.equalsIgnoreCase("2")){
		    	 strSql+=" having round(SUM(d.asset_del),2)!=0 or round(SUM(d.depr_del),2)!=0 ";
		    	 //strSql+=" having if(sum(d.asset_del)>0,round(sum(d.asset_del),2),0)!=0  or if(sum(d.depr_del)<0,round(sum(d.depr_del)*-1,2),0)!=0";
		     }else if(reportType.equalsIgnoreCase("3")){
			     strSql+=" having round(SUM(d.asset_add),2)!=0 ";
		    	 //strSql+=" having round(SUM(d.asset_add),2)!=0 or round(SUM(d.depr_add),2)!=0 ";
		    	 // strSql+=" having if(sum(d.asset_add)>0,round(sum(d.asset_add),2),0)!=0  or if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),0)!=0";
		     }
		     
		       /*sql = "select d.assetid 'ASSET ID',d.assetname 'ASSET NAME',d.assetgp 'GROUP NAME',((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) 'AGE(M)',d.purdate 'PUR. DATE',CONVERT(if(sum(d.asset_opn)>0,"
		     		    + "round(sum(d.asset_opn),2),''),CHAR(100)) 'ASSET(OPN)',CONVERT(if(sum(d.asset_add)>0,round(sum(d.asset_add),2),''),CHAR(100)) 'ASSET(ADDITION)',CONVERT(if(sum(d.asset_del)>0,round(sum(d.asset_del),2),''),"
		     		    + "CHAR(100)) 'ASSET(DELETION)',CONVERT(if(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)>0,(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)),''),"
		     		    + "CHAR(100)) 'ASSET TOTAL',CONVERT(if(sum(d.depr_opn)<0,round(sum(d.depr_opn)*-1,2),''),CHAR(100)) 'DEPR.(OPN)',CONVERT(if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),''),CHAR(100)) 'DEPR.(ADDITION)',"
		     		    + "CONVERT(if(sum(d.depr_del)<0,round(sum(d.depr_del)*-1,2),''),CHAR(100)) 'DEPR.(DELETION)',CONVERT(if(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2)<0,(round(sum(d.depr_opn),2)+"
		     		    + "round(sum(d.depr_add),2)+round(sum(d.depr_del),2))*-1,''),CHAR(100)) 'DEPR. TOTAL',((round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2))+(round(sum(d.depr_opn),2)+round(sum(d.depr_add),"
		     		    + "2)+round(sum(d.depr_del),2))) 'NET TOTAL',(round(sum(d.asset_opn),2)+round(sum(d.depr_opn),2)) 'PREVIOUS YEAR' from ("
			     		+ "select a.asset_no,a.date,if(a.date<='"+sqlFromDate+"',a.dramount,0.00) asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp from my_fatran a "
			     		+ "left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,a.dramount asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<='"+sqlFromDate+"',a.dramount,0.00) depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp from my_fatran a left join "
			     		+ "my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,a.dramount depr_del,v.assetid,v.assetname,v.purdate,a.brhid,g.grp_name assetgp from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno)d where d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+"";*/
			
			/*sql = "select d.assetid 'ASSET ID',d.assetname 'ASSET NAME',d.assetgp 'GROUP NAME',((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) 'AGE(M)',d.deprper 'Depr(%)',d.purdate 'PUR. DATE',CONVERT(if(sum(d.asset_opn)>0,"
		     		    + "round(sum(d.asset_opn),2),''),CHAR(100)) 'ASSET(OPN)',CONVERT(if(sum(d.asset_add)>0,round(sum(d.asset_add),2),''),CHAR(100)) 'ASSET(ADDITION)',CONVERT(if(sum(d.asset_del)>0,round(sum(d.asset_del),2),''),"
		     		    + "CHAR(100)) 'ASSET(DELETION)',CONVERT(if(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)>0,(round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2)),''),"
		     		    + "CHAR(100)) 'ASSET TOTAL',CONVERT(if(sum(d.depr_opn)<0,round(sum(d.depr_opn)*-1,2),''),CHAR(100)) 'DEPR.(OPN)',CONVERT(if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),''),CHAR(100)) 'DEPR.(ADDITION)',"
		     		    + "CONVERT(if(sum(d.depr_del)<0,round(sum(d.depr_del)*-1,2),''),CHAR(100)) 'DEPR.(DELETION)',CONVERT(if(round(sum(d.depr_opn),2)+round(sum(d.depr_add),2)+round(sum(d.depr_del),2)<0,(round(sum(d.depr_opn),2)+"
		     		    + "round(sum(d.depr_add),2)+round(sum(d.depr_del),2))*-1,''),CHAR(100)) 'DEPR. TOTAL',((round(sum(d.asset_opn),2)+round(sum(d.asset_add),2)+round(sum(d.asset_del),2))+(round(sum(d.depr_opn),2)+round(sum(d.depr_add),"
		     		    + "2)+round(sum(d.depr_del),2))) 'NET TOTAL',(round(sum(d.asset_opn),2)+round(sum(d.depr_opn),2)) 'PREVIOUS YEAR' from ("
			     		+ "select a.asset_no,a.date,if(a.date<='"+sqlFromDate+"',a.dramount,0.00) asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp from my_fatran a "
			     		+ "left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,a.dramount asset_del,0.00 depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.fixastacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<='"+sqlFromDate+"',a.dramount,0.00) depr_opn,0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp from my_fatran a left join "
			     		+ "my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,'') depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp "
			     		+ "from my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno UNION ALL "
			     		+ "select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,0.00 depr_opn,0.00 depr_add,a.dramount depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp from my_fatran a left join my_fixm v on a.asset_no=v.sr_no "
			     		+ "left join my_fagrp g on v.assetgp=g.doc_no left join my_head h on h.doc_no=v.accdepacno)d where d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+"";*/
		    
			 sql = "SELECT m.assetid 'ASSET ID',m.assetname 'ASSET NAME',m.assetgp 'GROUP NAME',TRUNCATE(m.age,0) 'AGE(M)',m.deprper 'Depr(%)',m.purdate 'PUR. DATE',\r\n" + 
			     		"CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)) 'ASSET(OPN)',\r\n" + 
			     		"CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)) 'ASSET(ADDITION)',\r\n" + 
			     		"CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)) 'ASSET(DELETION)',\r\n" + 
			     		"CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)) 'ASSET TOTAL',\r\n" + 
			     		"CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)) 'DEPR.(OPN)',\r\n" + 
			     		"CONVERT(if(m.depr_add=0,'',if(m.depr_add<0,m.depr_add*-1,m.depr_add)),CHAR(100)) 'DEPR.(ADDITION)',\r\n" + 
			     		"CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)) 'DEPR.(DELETION)',\r\n" + 
			     		"CONVERT(if(m.deprtotal=0,'',if(m.deprtotal<0,m.deprtotal*-1,m.deprtotal)),CHAR(100)) 'DEPR. TOTAL',\r\n" + 
			     		"CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)) 'NET TOTAL',\r\n" + 
			     		"CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)) 'PREVIOUS YEAR' FROM (\r\n" + 
			     		"SELECT l.asset_no,l.assetid,l.assetname,l.assetgp,l.age,l.purdate,l.asset_opn,l.asset_add,l.asset_del,\r\n" + 
			     		"(l.asset_opn+l.asset_add+l.asset_del) assettotal,l.depr_opn,l.depr_add,l.depr_del,(l.depr_opn+l.depr_add+l.depr_del)  deprtotal,\r\n" + 
			     		"((l.asset_opn+l.asset_add+l.asset_del)+(l.depr_opn+l.depr_add+l.depr_del)) nettotal,(l.asset_opn+l.depr_opn) prevyear,\r\n" + 
			     		"l.deprper,l.brhid,l.date,l.assetgpid FROM (\r\n" + 
			     		"select d.asset_no,d.date,round(SUM(d.asset_opn),2) asset_opn,round(SUM(d.asset_add),2) asset_add,round(SUM(d.asset_del),2)\r\n" + 
			     		"asset_del,round(SUM(d.depr_opn),2) depr_opn,round(SUM(d.depr_add),2) depr_add,round(SUM(d.depr_del),2) depr_del,\r\n" + 
			     		"d.assetid,d.assetname,d.assetgp,d.purdate,round(((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12),2) age,d.deprper,d.brhid,d.assetgpid from (\r\n" + 
			     		"select a.asset_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'') asset_add,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') asset_del,0.00 depr_opn,\r\n" + 
			     		"0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from\r\n" + 
			     		"my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno\r\n" + 
			     		"UNION ALL\r\n" + 
			     		"select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') depr_add,\r\n" + 
			     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'')  depr_del,\r\n" + 
			     		"v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a\r\n" + 
			     		"left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno\r\n" + 
			     		") d\r\n" + 
			     		"left join my_fasaled sd on sd.assetid=d.asset_no left join my_fasalem sm on sm.doc_no=sd.rdocno where coalesce(sm.date,\r\n" + 
			     		"'"+sqlFromDate+"')>='"+sqlFromDate+"' and d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+" ) l ) m";
		    
			ResultSet resultSet = stmtBFAR.executeQuery(sql);
			
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			
			}
			
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
	
	
	public JSONArray assetdetails(String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("check"))){
        	return RESULTDATA;
        }
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
	
	 public JSONArray groupdetails(String check) throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     if(!(check.equalsIgnoreCase("check"))){
	    	 return RESULTDATA;
	     }
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

}
