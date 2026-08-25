package com.dashboard.accounts.detailedaccountstatement;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDetailedAccountStatement  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray detailedAccountStatementGrid(String branch,String fromdate,String todate,String accounttype,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtDetailedAccountStatement = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1="",joins="",casestatement="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and t.brhId="+branch+"";
			}
		     
		    if(!((accounttype.equalsIgnoreCase("")) || (accounttype.equalsIgnoreCase("0")))){
		    	sql1+=" and a.atype='"+accounttype+"'";
	        }
		     
		    joins=ClsCommon.getFinanceVocTablesJoins(conn);
			casestatement=ClsCommon.getFinanceVocTablesCase(conn);
			
		     sql = "select a.*,"+casestatement+"b.branchname,coalesce(round(@i:=@i+ldramount,2),0) netamount from (select t.brhid,if(transno=0,'',transno) transno,transtype,date(t.trdate) trdate,t.tr_des description,if(t.ref_detail=0,'',t.ref_detail) ref_detail,"
		     	+ "t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
				+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
				+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
				+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
				+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
				+ "group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
				+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+",(select @i:=0) as i where 1=1"+sql1+"";
			
			 ResultSet resultSet = stmtDetailedAccountStatement.executeQuery(sql);
			 
			 ArrayList<String> accountstatementarray= new ArrayList<String>();
			 String accountno="",oldaccountno="",parentid="",debittotals="0.00",credittotals="0.00",netamounts="0.00";
			 int id=1;
			 double debittotal=0.00,credittotal=0.00,netamount=0.00;
			 
				while(resultSet.next()){
					accountno=resultSet.getString("account");
					
					if(!(oldaccountno.equalsIgnoreCase(accountno))){
					    parentid=null;
					    
					    if(id!=1){
					    	
					    	if(debittotal==0.00){
					    		debittotals=String.valueOf("");
					    	}else {
					    		debittotal=Math.round(debittotal*100.00)/100.00;
					    		debittotals=String.valueOf(debittotal);
					    	}
					    	
					    	if(credittotal==0.00){
					    		credittotals=String.valueOf("");
					    	}else {
					    		credittotal=Math.round(credittotal*100.00)/100.00;
					    		credittotals=String.valueOf(credittotal);
					    	}
					    	
					    	if(netamount==0.00){
					    		netamounts=String.valueOf("");
					    	}else {
					    		netamount=Math.round((debittotal-credittotal)*100.00)/100.00;
					    		netamounts=String.valueOf(netamount);
					    	}
					    	
					    	accountstatementarray.add(id+"::"+parentid+"::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: :: ");
					    	
					    	debittotals="0.00";credittotals="0.00";netamounts="0.00";
					    	id++;
					    }
					    debittotal=0.00;credittotal=0.00;netamount=0.00;
					    
					    accountstatementarray.add(id+"::"+parentid+"::null:: :: ::"+resultSet.getString("accountname")+":: :: :: :: :: "+accountno+":: "+resultSet.getString("accountname")+":: ");
					    
						oldaccountno=accountno;
						parentid=id+"";
						id++;
						
						debittotal=(Math.round(debittotal*100.00)/100.00)+resultSet.getDouble("debit");
						credittotal=(Math.round(credittotal*100.00)/100.00)+resultSet.getDouble("credit");
						netamount=Math.round((debittotal-credittotal)*100.00)/100.00;
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						
					}else{
						
						debittotal=(Math.round(debittotal*100.00)/100.00)+resultSet.getDouble("debit");
						credittotal=(Math.round(credittotal*100.00)/100.00)+resultSet.getDouble("credit");
						netamount=Math.round((debittotal-credittotal)*100.00)/100.00;
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						
					}

					id++;
				}
				
				if(debittotal==0.00){
		    		debittotals=String.valueOf("");
		    	}else {
		    		debittotal=Math.round(debittotal*100.00)/100.00;
		    		debittotals=String.valueOf(debittotal);
		    	}
		    	
		    	if(credittotal==0.00){
		    		credittotals=String.valueOf("");
		    	}else {
		    		credittotal=Math.round(credittotal*100.00)/100.00;
		    		credittotals=String.valueOf(credittotal);
		    	}
		    	
		    	if(netamount==0.00){
		    		netamounts=String.valueOf("");
		    	}else {
		    		netamount=Math.round((debittotal-credittotal)*100.00)/100.00;
		    		netamounts=String.valueOf(netamount);
		    	}
				
				accountstatementarray.add(id+"::null::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: :: ");
				
			 RESULTDATA=convertArrayToJSON(accountstatementarray);
			 
			 }
			 
			 stmtDetailedAccountStatement.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	/*public  JSONArray detailedAccountStatementExcelExport(String branch,String fromdate,String todate,String accounttype,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtDetailedAccountStatement = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and t.brhId="+branch+"";
			}
		     
		    if(!((accounttype.equalsIgnoreCase("")) || (accounttype.equalsIgnoreCase("0")))){
		    	sql1+=" and a.atype='"+accounttype+"'";
	        }
		     
		     sql = "select a.*,if(a.transType in ('ÍNV','INS','INT'),m.voc_no,a.transno) transno,coalesce(round(@i:=@i+ldramount,2),0) netamount from (select if(transno=0,'',transno) transno,transtype,date(t.trdate) trdate,if(t.tr_des=0,'',t.tr_des) description,if(t.ref_detail=0,'',t.ref_detail) ref_detail,"
		     	+ "t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
				+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
				+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
				+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" union all select date( '"+sqlFromDate+"' ) trdate,"
				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
				+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
				+ "group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
				+ "trdate,transNo,t.curId,transType) a left join gl_invm m on m.dtype=a.transType and a.transno=m.doc_no,(select @i:=0) as i where 1=1"+sql1+"";
			
		     System.out.println("SQL Detailed = "+sql);
			 ResultSet resultSet = stmtDetailedAccountStatement.executeQuery(sql);
			 
			 ArrayList<String> accountstatementarray= new ArrayList<String>();
			 String accountno="",oldaccountno="",parentid="",debittotals="0.00",credittotals="0.00",netamounts="0.00";
			 int id=1;
			 double debittotal=0.00,credittotal=0.00,netamount=0.00;
			 
				while(resultSet.next()){
					String temp="";
					
					accountno=resultSet.getString("account");
					
					if(!(oldaccountno.equalsIgnoreCase(accountno))){
					    parentid=null;
					    
					    if(id!=1){
					    	
					    	if(debittotal==0.00){
					    		debittotals=String.valueOf("");
					    	}else {
					    		debittotal=ClsCommon.Round(debittotal, 2);
					    		debittotals=String.valueOf(debittotal);
					    	}
					    	
					    	if(credittotal==0.00){
					    		credittotals=String.valueOf("");
					    	}else {
					    		credittotal=ClsCommon.Round(credittotal, 2);
					    		credittotals=String.valueOf(credittotal);
					    	}
					    	
					    	if(netamount==0.00){
					    		netamounts=String.valueOf("");
					    	}else {
					    		netamount=ClsCommon.Round((debittotal-credittotal), 2);
					    		netamounts=String.valueOf(netamount);
					    	}
					    	
					    	accountstatementarray.add(id+"::"+parentid+"::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: ");
					    	
					    	debittotals="0.00";credittotals="0.00";netamounts="0.00";
					    	id++;
					    }
					    debittotal=0.00;credittotal=0.00;netamount=0.00;
					    
					    accountstatementarray.add(id+"::"+parentid+"::null:: :: ::"+resultSet.getString("accountname")+":: :: :: :: :: "+accountno+":: "+resultSet.getString("accountname"));
					    
						oldaccountno=accountno;
						parentid=id+"";
						id++;
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=netamount+resultSet.getDouble("netamount");
						netamount=debittotal-credittotal;
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname"));
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=netamount+resultSet.getDouble("netamount");
						netamount=debittotal+credittotal;
						
						
					}else{
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						//netamount=netamount+resultSet.getDouble("netamount");
						netamount=debittotal-credittotal;
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname"));
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						//netamount=netamount+resultSet.getDouble("netamount");
						netamount=debittotal+credittotal;
					}

					id++;
				}
				
				if(debittotal==0.00){
		    		debittotals=String.valueOf("");
		    	}else {
		    		debittotal=ClsCommon.Round(debittotal, 2);
		    		debittotals=String.valueOf(debittotal);
		    	}
		    	
		    	if(credittotal==0.00){
		    		credittotals=String.valueOf("");
		    	}else {
		    		credittotal=ClsCommon.Round(credittotal, 2);
		    		credittotals=String.valueOf(credittotal);
		    	}
		    	
		    	if(netamount==0.00){
		    		netamounts=String.valueOf("");
		    	}else {
		    		netamount=ClsCommon.Round((debittotal-credittotal), 2);
		    		netamounts=String.valueOf(netamount);
		    	}
				
				accountstatementarray.add(id+"::null::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: ");
				
			 RESULTDATA=ClsCommon.convertToEXCEL(accountstatementarray);
			 
			 }
			 
			 stmtDetailedAccountStatement.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }*/
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			for (int i = 0; i < arrayList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] balanceSheetArray=arrayList.get(i).split("::");
				
				obj.put("id",balanceSheetArray[0]);
				obj.put("parentid",balanceSheetArray[1]);
				obj.put("trdate",balanceSheetArray[2]);
				obj.put("transtype",balanceSheetArray[3]);
				obj.put("transno",balanceSheetArray[4]);
				obj.put("description",balanceSheetArray[5]);
				obj.put("ref_detail",balanceSheetArray[6]);
				obj.put("debit",balanceSheetArray[7]);
				obj.put("credit",balanceSheetArray[8]);
				obj.put("netamount",balanceSheetArray[9]);
				obj.put("accountno",balanceSheetArray[10]);
				obj.put("accountname",balanceSheetArray[11]);
				obj.put("branchname",balanceSheetArray[12]);
				
				jsonArray.add(obj);
			}
			return jsonArray;
			}
     }
