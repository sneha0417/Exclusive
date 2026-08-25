package com.dashboard.accounts.journalvoucherlist;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersBean;

public class ClsJournalVoucherListDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
     
	
		public JSONArray jvGridLoad(String branch,String fromdate,String todate,String dtype,String chk,String jvType) throws SQLException {
        
		
		JSONArray RESULTDATA=new JSONArray();
               
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFinance = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC"))){
						sql+=" and d.brhId="+branch+"";
					}else {
						sql+=" and m.brhId="+branch+"";
					}
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
		    	if(!(jvType.equalsIgnoreCase("")) && dtype.equalsIgnoreCase("JVT")){   
					sql+=" and m.refid in ("+jvType+")"; 
				}   
		        
		        	sql = "SELECT m.tr_no,m.doc_no,m.date,m.description,if(d.dramount<0,(d.dramount*-1),d.dramount) amount,if(d.ldramount<0,(d.ldramount*-1),d.ldramount) localamount,t.description accountname,c.code currency,"
		        			+ "(select GROUP_CONCAT(h.description) from my_jvtran d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) reference FROM my_jvma m left join my_jvtran d on "
		        			+ "(m.tr_no=d.tr_no  and d.ref_row=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		       System.out.println("sql------->>>"+sql);   
		        if(chk.equalsIgnoreCase("1")){
		        	ResultSet resultSet = stmtFinance.executeQuery(sql);
		        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }   
		        else{     
		        	stmtFinance.close();
					conn.close();
					return RESULTDATA;
		        }
		        stmtFinance.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }

	public JSONArray jvExcelExportLoad(String branch,String fromdate,String todate,String dtype,String chk,String jvType) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
		Connection conn = null;          
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFinance = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC"))){
						sql+=" and d.brhId="+branch+"";
					}else {
						sql+=" and m.brhId="+branch+"";
					}
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
		        if(!(jvType.equalsIgnoreCase("")) && !(jvType.equalsIgnoreCase("undefined"))){
					sql+=" and m.refid in ("+jvType+")";
				}  
		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',t.description 'Account',m.description 'Remarks',(select GROUP_CONCAT(h.description) from my_jvtran d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) 'Reference',"
		        			+ "if(d.dramount<0,(d.dramount*-1),d.dramount) 'Amount',c.code 'Currency',if(d.ldramount<0,(d.ldramount*-1),d.ldramount) 'Local Amount' FROM my_jvma m left join my_jvtran d on "
		        			+ "(m.tr_no=d.tr_no  and d.ref_row=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        
		        
		        if(chk.equalsIgnoreCase("1")){
		        	ResultSet resultSet = stmtFinance.executeQuery(sql);
		        	RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		        }
		        else{
		        	stmtFinance.close();
					conn.close();
					return RESULTDATA;
		        }
		        stmtFinance.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }
	public ClsJournalVouchersListBean getPrint(HttpServletRequest request,String docNo,String branch,int header,String dtype) throws SQLException {
		ClsJournalVouchersListBean bean=new ClsJournalVouchersListBean();
		 Connection conn = null;               
		                 
		try {
			conn = ClsConnection.getMyConnection();   
			Statement stmtJVT = conn.createStatement();
			String sqltest="";
			if(!dtype.equalsIgnoreCase("")){
				sqltest+=" and m.dtype='"+dtype+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			  
			
			String headersql="select if(m.dtype='JVT','Journal Voucher','IB-Journal Voucher') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_jvma m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "
					+ " "+sqltest+" and m.doc_no="+docNo+"";
             //System.out.println("headersql----->>>"+headersql);   
				ResultSet resultSetHead = stmtJVT.executeQuery(headersql);
				
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
			
			/*String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.description,m.refNo,round(m.drtot,2) netAmount,u.user_name from my_jvma m left join "
				+ "my_user u on m.userid=u.doc_no where m.dtype='JVT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			System.out.println("header---->>>"+sqls);
			ResultSet resultSets = stmtJVT.executeQuery(sqls);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSets.next()){
				
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLblrefno(resultSets.getString("refNo"));
				bean.setLbldescription(resultSets.getString("description"));

				bean.setLblnetamount(resultSets.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("netAmount")));
				
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			   
			bean.setTxtheader(header);   
   
			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,j.description,c.code currency,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),'  ') credit, "
			  + "CONVERT(if(j.costtype=0,' ',coalesce(co.costgroup,' ')),CHAR(100)) costtype,CONVERT(if(j.costcode=0,' ',coalesce(j.costcode,' ')),CHAR(100)) costcode FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no "
			  + "left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_costunit co on j.costtype=co.costtype WHERE m.dtype='JVT' and m.brhid="+branch+" "
			  + "and m.doc_no="+docNo+" order by j.dramount desc";
			
			ResultSet resultSet1 = stmtJVT.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				
				if(ClsCommon.getPrintPath("JVT").contains("journalVoucherCostTypePrint.jsp")==true) {
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("costtype")+"::"+resultSet1.getString("costcode")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				} else {
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				}
				printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_jvma m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='JVT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			System.out.println("footer---->>>"+sql2);
			ResultSet resultSet2 = stmtJVT.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}*/
		
			stmtJVT.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}
}
