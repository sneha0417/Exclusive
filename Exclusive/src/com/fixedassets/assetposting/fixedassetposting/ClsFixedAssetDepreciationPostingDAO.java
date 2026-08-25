package com.fixedassets.assetposting.fixedassetposting;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFixedAssetDepreciationPostingDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	ClsFixedAssetDepreciationPostingBean fixedAssetDepreciationPostingBean = new ClsFixedAssetDepreciationPostingBean();
	
	public int insert(String formdetailcode, String branch,Date depreciationDate, double txtdeprtotal, ArrayList<String> vehicledetailsarray, ArrayList<String> journalvouchersarray, 
			HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtFADP = conn.prepareCall("{CALL assetDepreciationmDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtFADP.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtFADP.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtFADP.setDate(1,depreciationDate);
			stmtFADP.setDouble(2,txtdeprtotal);
			stmtFADP.setString(3,formdetailcode);
			stmtFADP.setString(4,company);
			stmtFADP.setString(5,branch);
			stmtFADP.setString(6,userid);
			stmtFADP.setString(9,mode);
			int datas=stmtFADP.executeUpdate();
			if(datas<=0){
				stmtFADP.close();
				conn.close();
				return 0;
			}
			int docno=stmtFADP.getInt("docNo");
			int trno=stmtFADP.getInt("itranNo");
			request.setAttribute("tranno", trno);
			fixedAssetDepreciationPostingBean.setTxtjvno(docno);
			if (docno > 0) {
				/*Insertion to my_fatran,my_jvtran*/
				int insertData=insertion(conn, docno, branch, trno, formdetailcode, depreciationDate, vehicledetailsarray, journalvouchersarray, session,mode);
				if(insertData<=0){
					stmtFADP.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_fatran,my_jvtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtFADP.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					conn.commit();
					stmtFADP.close();
					conn.close();
					return docno;
				 }else{
				     System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				     stmtFADP.close();
					 return 0;
				 }
			}
			
			stmtFADP.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
			conn.close();
		}
		return 0;
	}

	
	public  JSONArray assetDetailsProcessing(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
		        }
				
				String sql = "select m.assetid,m.assetname,g.grp_name assetgp,m.purdate,round(m.totpurval,2) prch_cost,round(m.deprper,2)depr,m.depacno,m.accdepacno,"
						+ "coalesce(m.depr_date,m.purdate) deprdate,sum(round(f.dramount,2)) bookvalue,Convert(coalesce(m.depr_date,m.purdate),CHAR(100)) frmdate,"
						+ "f.asset_no,h.description depaccount,h1.description accdepaccount from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_fagrp g "
						+ "on m.assetgp=g.doc_no left join my_head h on m.depacno=h.doc_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and "
						+ "coalesce(m.depr_date,m.purdate)<'"+sqlDeprDate+"' group by f.asset_no having sum(round(f.dramount,2))>0";
			    
				ResultSet resultSet = stmtFADP.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray assetDetailsCalculating(String branch,String day,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
		        }
				
				String sql = "select f.asset_no,m.assetid,m.assetname,g.grp_name assetgp,m.purdate,round(m.totpurval,2) prch_cost,round(m.deprper,2)depr,m.depacno,"
						+ "m.accdepacno,coalesce(m.depr_date,m.purdate) deprdate,sum(round(f.dramount,2)) bookvalue,Convert(coalesce(m.depr_date,m.purdate),CHAR(100)) frmdate,"
						+ "h.description depaccount,h1.description accdepaccount,round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2) depramt,if(round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2)<"
						+ "sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2),sum(round(f.dramount,2))) depr_amt from my_fixm m left join my_fatran f on m.sr_no=f.asset_no "
						+ "left join my_fagrp g on m.assetgp=g.doc_no left join my_head h on m.depacno=h.doc_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and "
						+ "coalesce(m.depr_date,m.purdate)<'"+sqlDeprDate+"' group by f.asset_no having sum(round(f.dramount,2))>0";
				
				ResultSet resultSet = stmtFADP.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray assetDetailsReloading(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
				
				String sql = "select f.asset_no,m.assetid,m.assetname,g.grp_name assetgp,m.purdate,round(m.totpurval,2) prch_cost,round(f.depr,2)depr,m.depacno,"
						+ "m.accdepacno,coalesce(m.depr_date,m.purdate) deprdate,round(f.book_value,2) bookvalue,f.frmDate frmdate,if(f.dramount<0,(round(f.dramount,2))*-1,"
						+ "round(f.dramount,2)) depr_amt from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_fagrp g on m.assetgp=g.doc_no where "
						+ "f.doc_no="+docno+" and f.tr_no="+trno+"";
		        
				ResultSet resultSet = stmtFADP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }

	public  JSONArray accountDetailsGridLoading(String branch,String day,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
				
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
		        }
		        
		         /*String sql = "select a.asset_no,if(a.depacno=0,a.accdepacno,a.depacno) acno,if(a.depacno=0,a.accdepaccno,a.depaccno) accountno,if(a.depaccount='',a.accdepaccount,a.depaccount) codeno,CONVERT(if(a.debit=0,'',a.debit),CHAR(50)) debit,"
						+ "CONVERT(if(a.credit=0,'',a.credit),CHAR(50)) credit from (select f.asset_no,m.depacno,0 accdepacno,h.account depaccno,0 accdepaccno,h.description depaccount,'' accdepaccount,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*"+day+",2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*"+day+",2),sum(round(f.dramount,2))) debit,"
						+ "0.00 credit from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h on m.depacno=h.doc_no where m.brhid="+branch+" and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.depacno having sum(f.dramount)>0 union all select f.asset_no,0 depacno,m.accdepacno,0 depaccno,h1.account accdepaccno,'' depaccount,h1.description accdepaccount,0.00 debit,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*"+day+",2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*"+day+",2),sum(round(f.dramount,2))) credit "
						+ "from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.accdepacno having sum(f.dramount)>0) as a order by a.asset_no";*/
						
				/*String sql = "select a.asset_no,if(a.depacno=0,a.accdepacno,a.depacno) acno,if(a.depacno=0,a.accdepaccno,a.depaccno) accountno,if(a.depaccount='',a.accdepaccount,a.depaccount) codeno,CONVERT(if(sum(a.debit)=0,'',sum(a.debit)),CHAR(50)) debit,"
		        		+ "CONVERT(if(sum(a.credit)=0,'',sum(a.credit)),CHAR(50)) credit from (select f.asset_no,m.depacno,0 accdepacno,h.account depaccno,0 accdepaccno,h.description depaccount,'' accdepaccount,"
						+ "round(((m.totpurval * m.deprper/100)/365)*"+day+",2) debit,"
						+ "0.00 credit from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h on m.depacno=h.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.depacno having sum(f.dramount)>0 union all select f.asset_no,0 depacno,m.accdepacno,0 depaccno,h1.account accdepaccno,'' depaccount,h1.description accdepaccount,0.00 debit,"
						+ "round(((m.totpurval * m.deprper/100)/365)*"+day+",2) credit "
						+ "from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.accdepacno having sum(f.dramount)>0) as a group by acno order by a.asset_no";*/
						
				/*String sql = "select a.asset_no,if(a.depacno=0,a.accdepacno,a.depacno) acno,if(a.depacno=0,a.accdepaccno,a.depaccno) accountno,if(a.depaccount='',a.accdepaccount,a.depaccount) codeno,CONVERT(if(sum(a.debit)=0,'',sum(a.debit)),CHAR(50)) debit,"
		        		+ "CONVERT(if(sum(a.credit)=0,'',sum(a.credit)),CHAR(50)) credit from (select f.asset_no,m.depacno,0 accdepacno,h.account depaccno,0 accdepaccno,h.description depaccount,'' accdepaccount,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*"+day+",2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*"+day+",2),sum(round(f.dramount,2))) debit,"
						+ "0.00 credit from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h on m.depacno=h.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.depacno having sum(f.dramount)>0 union all select f.asset_no,0 depacno,m.accdepacno,0 depaccno,h1.account accdepaccno,'' depaccount,h1.description accdepaccount,0.00 debit,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*"+day+",2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*"+day+",2),sum(round(f.dramount,2))) credit "
						+ "from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.accdepacno having sum(f.dramount)>0) as a group by acno order by a.asset_no";*/	

				String sql = "select a.asset_no,if(a.depacno=0,a.accdepacno,a.depacno) acno,if(a.depacno=0,a.accdepaccno,a.depaccno) accountno,if(a.depaccount='',a.accdepaccount,a.depaccount) codeno,CONVERT(if(sum(a.debit)=0,'',sum(a.debit)),CHAR(50)) debit,"
		        		+ "CONVERT(if(sum(a.credit)=0,'',sum(a.credit)),CHAR(50)) credit from (select f.asset_no,m.depacno,0 accdepacno,h.account depaccno,0 accdepaccno,h.description depaccount,'' accdepaccount,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2),sum(round(f.dramount,2))) debit,"
						+ "0.00 credit from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h on m.depacno=h.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.depacno having sum(round(f.dramount,2))>0 union all select f.asset_no,0 depacno,m.accdepacno,0 depaccno,h1.account accdepaccno,'' depaccount,h1.description accdepaccount,0.00 debit,"
						+ "if(round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2),sum(round(f.dramount,2))) credit "
						+ "from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and m.status=3 and coalesce(m.depr_date,m.purdate)<"
						+ "'"+sqlDeprDate+"' group by m.sr_no,m.accdepacno having sum(round(f.dramount,2))>0) as a group by acno order by a.asset_no";
		        
				ResultSet resultSet = stmtFADP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray accountDetailsGridReloading(String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
            	
				String sql = "select j.acno,if(j.dramount>0,0,j.dramount*j.id) debit ,if(j.dramount<0,0,j.dramount*j.id) credit,t.account accountno,t.description codeno from my_jvtran j "
						+ "left join my_head t on j.acno=t.doc_no WHERE j.dtype='FADP' and j.tr_no="+trno+"";
            	
				ResultSet resultSet = stmtFADP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray assetDetailsProcessingExcelExport(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
		        }
				
				String sql = "select m.assetid 'Asset Id',m.assetname 'Asset Name',g.grp_name 'Group',m.purdate 'Purchase Date',round(m.totpurval,2) 'Purchase Price',round(m.deprper,2) 'Depr%',"
						+ "sum(round(f.dramount,2)) 'Book Value' from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_fagrp g on m.assetgp=g.doc_no left join my_head h on "
						+ "m.depacno=h.doc_no left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and coalesce(m.depr_date,m.purdate)<'"+sqlDeprDate+"' group by f.asset_no having sum(f.dramount)>0";
			    
				ResultSet resultSet = stmtFADP.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray assetDetailsCalculatingExcelExport(String branch,String day,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
		        }
				
				String sql = "select m.assetid 'Asset Id',m.assetname 'Asset Name',g.grp_name 'Group',m.purdate 'Purchase Date',round(m.totpurval,2) 'Purchase Price',round(m.deprper,2) 'Depr%',"
						+ "sum(round(f.dramount,2)) 'Book Value',if(round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2)<sum(round(f.dramount,2)),round(((m.totpurval * m.deprper/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(m.depr_date,m.purdate))),2),"
						+ "sum(round(f.dramount,2))) 'Depriciation' from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_fagrp g on m.assetgp=g.doc_no left join my_head h on m.depacno=h.doc_no "
						+ "left join my_head h1 on m.accdepacno=h1.doc_no where m.brhid="+branch+" and coalesce(m.depr_date,m.purdate)<'"+sqlDeprDate+"' group by f.asset_no having sum(f.dramount)>0";
				
				ResultSet resultSet = stmtFADP.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray assetDetailsReloadingExcelExport(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFADP = conn.createStatement();
				
				String sql = "select m.assetid 'Asset Id',m.assetname 'Asset Name',g.grp_name 'Group',m.purdate 'Purchase Date',round(m.totpurval,2) 'Purchase Price',round(f.depr,2) 'Depr%',"
						+ "round(f.book_value,2) 'Book Value',if(f.dramount<0,(round(f.dramount,2))*-1,round(f.dramount,2)) 'Depriciation' from my_fixm m left join my_fatran f on m.sr_no=f.asset_no "
						+"left join my_fagrp g on m.assetgp=g.doc_no where f.doc_no="+docno+" and f.tr_no="+trno+"";
		        
				ResultSet resultSet = stmtFADP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtFADP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public  JSONArray fadpMainSearch(String branch,String partyname,String docNo,String date,String amount) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        java.sql.Date sqlDepriciationDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlDepriciationDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and a.doc_no like '%"+docNo+"%'";
        }
        if(!(partyname.equalsIgnoreCase(""))){
         sqltest=sqltest+" and u.user_name like '%"+partyname+"%'";
        }
        if(!(amount.equalsIgnoreCase(""))){
         sqltest=sqltest+" and a.total like '%"+amount+"%'";
        }
        if(!(sqlDepriciationDate==null)){
	         sqltest=sqltest+" and a.date='"+sqlDepriciationDate+"'";
	        } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtFADP = conn.createStatement();
	       
	       ResultSet resultSet = stmtFADP.executeQuery("select a.date,a.doc_no,a.total,a.tr_no,u.user_name from gl_assetdepr a left join my_user u on a.userid=u.doc_no where a.brhid='"+branch+"' and a.status=3" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtFADP.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
   
   public ClsFixedAssetDepreciationPostingBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsFixedAssetDepreciationPostingBean bean = new ClsFixedAssetDepreciationPostingBean();
		 Connection conn = null;
		 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtFADP = conn.createStatement();
			
			int trno=0;
			
			String headersql="select if(m.dtype='FADP','Fixed Asset Dep. Posting','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from gl_assetdepr m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='FADP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtFADP.executeQuery(headersql);
			
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}

			ClsAmountToWords c = new ClsAmountToWords();
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,round(m.total,2) deprtotal,m.tr_no,u.user_name from gl_assetdepr m left join my_user u on "
					+ "m.userid=u.doc_no where m.dtype='FADP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtFADP.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldepreciationtotal(resultSets.getString("deprtotal"));
				bean.setLbldebittotal(resultSets.getString("deprtotal"));
				bean.setLblcredittotal(resultSets.getString("deprtotal"));
				bean.setLblnetamount(resultSets.getString("deprtotal"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("deprtotal")));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select j.acno,if(j.dramount>0,round(j.dramount*j.id,2),'  ') debit ,if(j.dramount<0,round(j.dramount*j.id,2),'  ') credit,t.account,t.description codeno "
					+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='FADP' and j.tr_no="+trno+"";
				
			ResultSet resultSet1 = stmtFADP.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
		
			sql2 = "select m.assetid,m.assetname,g.grp_name assetgp,DATE_FORMAT(m.purdate ,'%d-%m-%Y') purdate,round(m.totpurval,2) prch_cost,round(f.depr,2)depr,f.frmDate frmdate,round(f.book_value,2) bookvalue,"
					+ "if(f.dramount<0,(round(f.dramount,2))*-1,round(f.dramount,2)) depr_amt from my_fixm m left join my_fatran f on m.sr_no=f.asset_no left join my_fagrp g on m.assetgp=g.doc_no where "
					+ "f.doc_no="+docNo+" and f.tr_no="+trno+"";
			
			ResultSet resultSet2 = stmtFADP.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("assetid")+"::"+resultSet2.getString("assetname")+"::"+resultSet2.getString("assetgp")+"::"+resultSet2.getString("purdate")+"::"+resultSet2.getString("prch_cost")+"::"+resultSet2.getString("bookvalue")+"::"+resultSet2.getString("depr")+"::"+resultSet2.getString("depr_amt");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from gl_assetdepr m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='FADP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtFADP.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtFADP.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	
	public int insertion(Connection conn,int docno,String branch,int trno,String formdetailcode,Date depreciationDate, ArrayList<String> vehicledetailsarray,ArrayList<String> journalvouchersarray,
			 HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtFADP;
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Asset Details Grid and Details Saving*/
				for(int i=0;i< vehicledetailsarray.size();i++){
					String[] vehicledetail=vehicledetailsarray.get(i).split("::");
					if(!vehicledetail[0].trim().equalsIgnoreCase("undefined") && !vehicledetail[0].trim().equalsIgnoreCase("NaN")){
					 
					stmtFADP = conn.prepareCall("{CALL assetDepreciationdDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_fatran*/
					stmtFADP.setInt(10,trno); 
					stmtFADP.setInt(11,docno);
					stmtFADP.registerOutParameter(12, java.sql.Types.INTEGER);
					
					stmtFADP.setDate(1,depreciationDate); //Date
					stmtFADP.setString(2,(vehicledetail[6].trim().equalsIgnoreCase("undefined") || vehicledetail[6].trim().equalsIgnoreCase("NaN") || vehicledetail[6].trim().isEmpty()?0:vehicledetail[6].trim()).toString());  //dep. doc_no of my_head
					stmtFADP.setString(3,(vehicledetail[0].trim().equalsIgnoreCase("undefined") || vehicledetail[0].trim().equalsIgnoreCase("NaN") || vehicledetail[0].trim().isEmpty()?0:vehicledetail[0].trim()).toString()); //asset_no
					stmtFADP.setString(4,(vehicledetail[1].trim().equalsIgnoreCase("undefined") || vehicledetail[1].trim().equalsIgnoreCase("NaN") || vehicledetail[1].trim().isEmpty()?0:vehicledetail[1].trim()).toString()); //depr_amount
					stmtFADP.setString(5,(vehicledetail[2].trim().equalsIgnoreCase("undefined") || vehicledetail[2].trim().equalsIgnoreCase("NaN") || vehicledetail[2].trim().isEmpty()?0:vehicledetail[2].trim()).toString()); //From Date
					stmtFADP.setString(6,(vehicledetail[3].trim().equalsIgnoreCase("undefined") || vehicledetail[3].trim().equalsIgnoreCase("NaN") || vehicledetail[3].trim().isEmpty()?0:vehicledetail[3].trim()).toString()); //depr_perc
					stmtFADP.setString(7,(vehicledetail[4].trim().equalsIgnoreCase("undefined") || vehicledetail[4].trim().equalsIgnoreCase("NaN") || vehicledetail[4].trim().isEmpty()?0:vehicledetail[4].trim()).toString()); //book_value
					
					stmtFADP.setString(8,formdetailcode);
					stmtFADP.setString(9,branch);
					stmtFADP.setString(13,mode);
					int detail=stmtFADP.executeUpdate();
					if(detail<=0){
							stmtFADP.close();
							conn.close();
							return 0;
						}
     				  }
				    }
				    /*Asset Details Grid and Details Saving Ends*/
				
					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journal=journalvouchersarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtFADP = conn.prepareCall("{CALL assetDeprJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtFADP.setInt(10,docno);
					stmtFADP.setInt(11,trno);
					stmtFADP.setDate(1,depreciationDate); //Date
					stmtFADP.setString(2,"FADP - "+docno);
					stmtFADP.setInt(3,(i+1)); //SR_No
					stmtFADP.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtFADP.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtFADP.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtFADP.setString(7,formdetailcode);
					stmtFADP.setString(8,branch);
					stmtFADP.setString(9,userid);
					stmtFADP.setString(12,mode);
					stmtFADP.execute();
						if(stmtFADP.getInt("docNo")<=0){
							stmtFADP.close();
							conn.close();
							return 0;
						}
						/*my_jvtran Grid Saving Ends*/
						stmtFADP.close();
					 }
				}	
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}
