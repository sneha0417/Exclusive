package com.dashboard.accounts.accountsstatementperiod;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.accounts.accountsstatement.ClsAccountsStatementBean;
import com.dashboard.accounts.ageingstatement.ClsAgeingStatementBean;

public class ClsAccountsStatementPeriodDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray accountDetails(String fromdate,String todate,String fromacno,String toacno,String id) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
	    try {
	    	    String sqltest = "";
				if(!(fromacno.equalsIgnoreCase("")) && !(toacno.equalsIgnoreCase(""))){
					sqltest+=" and m.acno between '"+fromacno+"' and '"+toacno+"'";   
				}
				/*if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
	            if(sqlFromDate!=null && sqlToDate!=null){
	            	sqltest+=" and a.date between '"+sqlFromDate+"' and '"+sqlToDate+"'";
	            }*/     
				conn = ClsConnection.getMyConnection();
				Statement stmt= conn.createStatement();    
	        	
				String sql = "select o.primary_owner ,o.doc_no,h.description name,o.mobile mobno,o.email mail,m.acno from  rl_propertryowner o left join rl_propertymaster m on o.doc_no=m.owid left join my_head h on m.acno=h.doc_no where h.atype='AP' and o.status<>7 "+sqltest+" order by m.acno";
				System.out.println("sql--->>>"+sql);
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet1);   
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
	public  ClsAccountsStatementPeriodBean getPrint(Connection conn,HttpServletRequest request,int acno,String branch,String fromdate,String todate) throws SQLException {
		ClsAccountsStatementPeriodBean bean = new ClsAccountsStatementPeriodBean();
		
		//Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		//conn = ClsConnection.getMyConnection();
		Statement stmtAccountStatement = conn.createStatement();
		String sql="";String mainbranch="";
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
        	mainbranch=branch;        	
		}else{
			mainbranch="1";
		}
		
		sql="select b.branchname,'Statement of Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
				+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
				+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";
		
		ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			bean.setLblcomptel2(resultSet.getString("tel2"));
			bean.setLblcompwebsite(resultSet.getString("web"));
			bean.setLblcompemail(resultSet.getString("email"));
			
		}
		
		String sqls="select j.acno,coalesce(t.account,'') account,coalesce(t.description,'') description,coalesce(a.period,0) minperiod,coalesce(a.period2,0) maxperiod,coalesce(a.credit,0) creditlimit,coalesce(a.address,'') customeraddress,coalesce(a.mail1,'') customeremail,"
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax from my_jvtran j left join my_head t on j.acno=t.doc_no left join my_acbook a on a.acno=t.doc_no where "
				+ "j.acno="+acno+" group by acno";
		
		ResultSet resultSets = stmtAccountStatement.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setAccountno(resultSets.getString("account"));
			bean.setAccountname(resultSets.getString("description"));
			bean.setAccountaddress(resultSets.getString("customeraddress"));
			bean.setAccountemail(resultSets.getString("customeremail"));
			bean.setAccountmobile(resultSets.getString("customermobile"));
			bean.setAccountphone(resultSets.getString("customertel"));
			bean.setAccountfax(resultSets.getString("customerfax"));
			bean.setCreditperiodmin(resultSets.getString("minperiod"));
			bean.setCreditperiodmax(resultSets.getString("maxperiod"));
			bean.setCreditlimit(resultSets.getString("creditlimit"));
		}
		
		stmtAccountStatement.close();
		//conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		//conn.close();
	}
	return bean;
  }
	public  ClsAccountsStatementPeriodBean getPrint(Connection conn,HttpServletRequest request,String atype,int acno,String branch,String uptodate,int level1from,int level1to,int level2from,
			int level2to,int level3from,int level3to,int level4from,int level4to,int level5from) throws SQLException {
			
		ClsAccountsStatementPeriodBean bean = new ClsAccountsStatementPeriodBean();

		//Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
        
	try {
		//conn = ClsConnection.getMyConnection();
		Statement stmtAgeingStatement = conn.createStatement();
		
		if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
		
		String headersql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name "
				+ "location,b.branchname,b.pbno,b.stcno,b.cstno from my_acbook bk inner join my_jvtran j on bk.acno=j.acno inner join my_brch b on j.brhid=b.doc_no inner join "
				+ "my_comp c on bk.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by "
				+ "brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where j.acno="+acno+" group by j.acno";
				
//		       System.out.println("compname---"+headersql);
				ResultSet resultSetHead = stmtAgeingStatement.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcompname(resultSetHead.getString("company"));
//					System.out.println("======="+bean.getLblcompname());
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
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax,cd.code from my_jvtran j left join my_head t on j.acno=t.doc_no left join my_acbook a on a.acno=t.doc_no left join my_curr cd on cd.doc_no=j.curId where "
				+ "j.acno="+acno+" group by acno";
//		System.out.println("detailss"+sql);
		ResultSet resultSet = stmtAgeingStatement.executeQuery(sql);
		
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
			bean.setLblcurrencycode(resultSet.getString("code"));   
		}    
		
		stmtAgeingStatement.close();      
		//conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		//conn.close();
	}
	return bean;
  }
}
