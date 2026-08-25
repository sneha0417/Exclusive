package com.dashboard.accounts.clusteraccountstatement;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClusterAccountStatement  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clusterDetailedAccountStatementGrid(String branch,String fromdate,String todate,String cluster,String clusteraccount,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtCLM = conn.createStatement();
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1="",sql2="",joins="",casestatement="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and t.brhId="+branch+"";
			}
		     
		    if(!((clusteraccount.equalsIgnoreCase("")) || (clusteraccount.equalsIgnoreCase("0")))){
	                sql2=sql2+" and t.acno="+clusteraccount+"";
	        } else {
	        	    sql2=" and t.acno in (select acno from my_setclusterd where rdocno="+cluster+")";
	        }
		     
		    joins=ClsCommon.getFinanceVocTablesJoins(conn);
			casestatement=ClsCommon.getFinanceVocTablesCase(conn);
			
		    /* sql = "select a.*,"+casestatement+"b.branchname,coalesce(round(@i:=@i+ldramount,2),0) netamount from (select t.brhid,if(transno=0,'',transno) transno,transtype,date(t.trdate) trdate,if(t.tr_des=0,'',t.tr_des) description,if(t.ref_detail=0,'',t.ref_detail) ref_detail,"
		     	+ "t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(100)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(100)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(100)) debit,"
		    	+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(100)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des,t.acno,2 srno,"
				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1"+sql+""+sql2+" union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
				+ ""+sql2+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+",(select @i:=0) as i where 1=1"+sql1+"";
			*/
		     sql="select a1.*,coalesce(round(@i:=@i+ldramount,2),0) netamount from (\r\n" + 
		     		"select a.brhid,"+casestatement+"b.branchname,transtype,date(a.trdate) trdate,if(a.tr_des=0,'',a.tr_des) description,if(a.ref_detail=0,'',a.ref_detail) ref_detail,"
		     				+ "a.tr_no,a.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(100)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(100)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(100)) debit,"
		     				+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(100)) credit,round((a.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des,t.acno,2 srno,"
		     				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+""+sql2+" union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
		     				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"'))  "+sql+"  "
		     				+ "and t.acno in (select acno from my_setclusterd where rdocno=1) group by t.acno,t.curId )a on h.doc_no=a.acno left join my_curr c on c.doc_no=a.curId left join my_brch b on b.doc_no=a.brhid   "+joins+"  order by acno,trdate,transNo,a.curId,transType) a1 ,(select @i:=0) as i where 1=1"+sql1+"";
		     
		     System.out.println("gridload==="+sql);
			 ResultSet resultSet = stmtCLM.executeQuery(sql);
			 
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
					    	
					    	accountstatementarray.add(id+"::"+parentid+"::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: :: ");
					    	
					    	debittotals="0.00";credittotals="0.00";netamounts="0.00";
					    	id++;
					    }
					    debittotal=0.00;credittotal=0.00;netamount=0.00;
					    
					    accountstatementarray.add(id+"::"+parentid+"::null:: :: ::"+resultSet.getString("accountname")+":: :: :: :: :: "+accountno+":: "+resultSet.getString("accountname")+":: ");
					    
						oldaccountno=accountno;
						parentid=id+"";
						id++;
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=ClsCommon.Round((debittotal-credittotal),2);
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						
					}else{
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=ClsCommon.Round((debittotal-credittotal),2);
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						
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
				
				accountstatementarray.add(id+"::null::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: :: ");
				
			 RESULTDATA=convertArrayToJSON(accountstatementarray);
			 
			 stmtCLM.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	public JSONArray accountDetailsGridLoading(String branch,String fromdate,String todate,String clusterdocno,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!(check.equalsIgnoreCase("1")))
		{
			return RESULTDATA;
		}
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCLM = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				/*if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			    }*/
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			    }
		        
			    sql = "select d.acno doc_no,h.account,h.description,coalesce(round(sum(j.dramount),2),0) netbalance from my_setclusterd d left join my_jvtran j on "
			    		+ "d.acno=j.acno left join my_head h on h.doc_no=d.acno where j.status=3 and d.rdocno="+clusterdocno+" "+sql+" group by d.acno";
			    
			    System.out.println("net balance grid=="+sql);
			    
			    ResultSet resultSet = stmtCLM.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCLM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray clusterDetailsSearch(HttpSession session,String docno,String date,String clustername,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtCLM = conn.createStatement();
    	   
    	   if(check.equalsIgnoreCase("1")){
        	    java.sql.Date sqlDate=null;
        	   
    	        date.trim();
    	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
    	        {
    	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
    	        }
    	        
    	        String sqltest="";

    	        if(!(docno.equalsIgnoreCase(""))){
    	        	sqltest=sqltest+" and doc_no like '%"+docno+"%'";
    	        }
    	        if(!(sqlDate==null)){
    	        	sqltest=sqltest+" and date='"+sqlDate+"'";
    	        } 
    	        if(!(clustername.equalsIgnoreCase(""))){
    	            sqltest=sqltest+" and desc1 like '%"+clustername+"%'";
    	        }
    	        
	       ResultSet resultSet = stmtCLM.executeQuery("select doc_no, date, desc1 name, remarks description from my_setclusterm where status=3"+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
    	   
    	   }
	       stmtCLM.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
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
