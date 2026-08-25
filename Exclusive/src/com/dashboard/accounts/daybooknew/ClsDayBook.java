package com.dashboard.accounts.daybooknew;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDayBook  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray dayBook(String branch,String fromdate,String todate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(fromdate.equalsIgnoreCase("0")){      
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }      
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			        }
		        joins=ClsCommon.getFinanceVocTablesJoins(conn);
		        casestatement=ClsCommon.getFinanceVocTablesCase(conn);  
				/*sql = "select j.doc_no,j.dtype,j.date,j.ref_detail ref,j.description,j.tr_no,"+casestatement+"round((csh.totalamount),2) total from my_jvtran j left join my_cashbm csh on(j.tr_no=csh.tr_no)"+joins+" "
						+ "where j.status=3 "+sql+" group by tr_no";*/
		        sql="select transno doc_no,transType dtype,a.brhid,a.date,a.ref,a.description,a.tr_no,"+casestatement+"total from"
		        		+ " ( select j.doc_no transno,j.dtype transType,j.date,j.ref_detail ref,j.description,j.brhid,j.tr_no,"
		        		+ " round((csh.totalamount),2) total from my_jvtran j left join my_cashbm csh on(j.tr_no=csh.tr_no) where j.status=3  "+sql+" group by tr_no) a "+joins+"";
		        
				//System.out.println("sql---->>>"+sql);               
				ResultSet resultSet = stmtDayBook.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
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
	public JSONArray dayBookExcel(String branch,String fromdate,String todate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			        }
		        joins=ClsCommon.getFinanceVocTablesJoins(conn);
		        casestatement=ClsCommon.getFinanceVocTablesCase(conn);  
				 sql="select date,dtype as 'Doc Type',transno as 'Doc no',ref,description as 'Remarks',total from("
		        		+ " select "+casestatement+"transType dtype,a.brhid,a.date,a.ref,a.description,a.tr_no,total from"
		        		+ " ( select j.doc_no transno,j.dtype transType,j.date,j.ref_detail ref,j.description,j.brhid,j.tr_no,"
		        		+ " round((csh.totalamount),2) total from my_jvtran j left join my_cashbm csh on(j.tr_no=csh.tr_no) where j.status=3  "+sql+" group by tr_no) a "+joins+")aa";
				 /*sql = "select j.doc_no,j.dtype,j.date,j.ref_detail ref,j.description,j.tr_no,"+casestatement+"round((csh.totalamount),2) total from my_jvtran j left join my_cashbm csh on(j.tr_no=csh.tr_no)"+joins+" "
					+ "where j.status=3 "+sql+" group by tr_no";*/             
	       
				//System.out.println("sql--Excel-1->>>"+sql);
				ResultSet resultSet = stmtDayBook.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);  
				
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
	
	public  JSONArray dayBookGrid(String branch,String fromdate,String todate) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA1;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
	    try {
			String sql="";	
	    	conn = ClsConnection.getMyConnection();
				Statement stmtDayBook1 = conn.createStatement();
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and jv.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and jv.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and jv.date<='"+sqlToDate+"'";  
			        }
		        String sqls="  select t.doc_no acno,b.BRANCHNAME brchname,jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate,jv.description "
						+ "from my_jvtran jv left join my_brch b on b.doc_no=jv.brhid left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 "+sql+"";
		        //System.out.println("sqls---2->>>"+sqls);        
		        ResultSet resultSet1 = stmtDayBook1.executeQuery(sqls);
			
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtDayBook1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;    
	}
	public  JSONArray dayBookExcel(String branch,String fromdate,String todate) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA1;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
	    try {
			String sql="";	
	    	conn = ClsConnection.getMyConnection();
				Statement stmtDayBook1 = conn.createStatement();
				String joins="";String casestatement="";
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and jv.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and jv.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and jv.date<='"+sqlToDate+"'";
			        }  
		        /*String sqls="select t.description account,c.code currency,round((c.c_rate),2) rate,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) 'Dr. base currency',CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) 'Cr. base currency',jv.description "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 "+sql+"";
			*/	   
		         joins=ClsCommon.getFinanceVocTablesJoins(conn);
                 casestatement=ClsCommon.getFinanceVocTablesCase(conn);
               /*  user added query*/  
                 ///String sqls="select transno as 'Doc no',dtype as 'Doc Type',case when dtype='INT' then 'Traffic Fine invoice' when dtype='INS' then 'Salik Fine invoice' when dtypedesc!='' then dtypedesc  end 'Dtype Discptn',date,BRANCHNAME,user,ref,acno,account,currency,rate,dr,cr,drbase 'Dr. base currency',crbase 'Cr. base currency',description from(select "+casestatement+"transType dtype,a.account,a.acno,a.user,a.BRANCHNAME,a.ref,a.currency,a.rate,a.dr,a.cr,a.drbase,a.crbase,a.description,a.date,a.dtypedesc from(select if(mm.menu_name!='',mm.menu_name,bd.description) dtypedesc,jv.tr_no,jv.brhid,jv.doc_no transno,jv.dtype transType,jv.date,t.description account,t.doc_no acno,jv.ref_detail ref,u.user_name user,b.BRANCHNAME,c.code currency,round((c.c_rate),2) rate,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drbase,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crbase,jv.description from my_jvtran jv left join datalog dd on dd.dtype=jv.dtype and dd.doc_no=jv.doc_no and dd.entry='A' left join my_user u on u.doc_no=dd.userid left join my_brch b on b.doc_no=jv.brhid left join my_menu mm on mm.doc_type=jv.dtype left join gl_bibd bd on bd.dtype=jv.dtype left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 "+sql+") a "+joins+")aa";
                String sqls="select transno as 'Doc no',dtype as 'Doc Type',case when dtype='INT' then 'Traffic Fine invoice' when dtype='INS' then 'Salik Fine invoice' when dtypedesc!='' then dtypedesc  end 'Dtype Discptn',date,BRANCHNAME,ref,acno,account,currency,rate,dr,cr,drbase 'Dr. base currency',crbase 'Cr. base currency',description from(select "+casestatement+"transType dtype,a.account,a.acno,a.BRANCHNAME,a.ref,a.currency,a.rate,a.dr,a.cr,a.drbase,a.crbase,a.description,a.date,a.dtypedesc from(select if(mm.menu_name!='',mm.menu_name,bd.description) dtypedesc,jv.tr_no,jv.brhid,jv.doc_no transno,jv.dtype transType,jv.date,t.description account,t.doc_no acno,jv.ref_detail ref,b.BRANCHNAME,c.code currency,round((c.c_rate),2) rate,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drbase,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crbase,jv.description from my_jvtran jv  left join my_brch b on b.doc_no=jv.brhid left join my_menu mm on mm.doc_type=jv.dtype left join gl_bibd bd on bd.dtype=jv.dtype left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 "+sql+") a "+joins+")aa";
                System.out.println("sqls---Excel--2->>>"+sqls);            
		        ResultSet resultSet1 = stmtDayBook1.executeQuery(sqls);
			    
				RESULTDATA1=ClsCommon.convertToEXCEL(resultSet1);
				
				stmtDayBook1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
