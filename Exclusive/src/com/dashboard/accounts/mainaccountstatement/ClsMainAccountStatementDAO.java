package com.dashboard.accounts.mainaccountstatement;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMainAccountStatementDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray mainaccountStatementGridLoading(String branch,String fromdate,String todate,String acctype,String account,String includingZero,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(branch.equalsIgnoreCase("NA")){
        	return RESULTDATA;
        }
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement = conn.createStatement();
				String sql = "",sqlRemoveZero="",sql1="",sql2="";
		
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
				}
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
        
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
				
				if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql2+=" and trial.grpno='"+account+"'";
	            }
				
				if(!((includingZero.equalsIgnoreCase("")) || (includingZero.equalsIgnoreCase("1")))) {
	    			sqlRemoveZero+="  having ( ifnull(opndr,0)!=0 or ifnull(dr,0)!=0 or ifnull(curdr,0)!=0 )";
	    		} else if(includingZero.equalsIgnoreCase("1")){
	    			if(acctype.equalsIgnoreCase("AR")){
	    				sql1+=" where h.den=340";
	    			} else if(acctype.equalsIgnoreCase("AP")){
	    				sql1+=" where h.den=255";
	    			} else if(acctype.equalsIgnoreCase("HR")){
	    				sql1+=" where h.den=301";
	    			} else if(acctype.equalsIgnoreCase("GL")){
	    				sql1+=" where ((sublevel is not null and h.den in (340,255,301)) or (h.den not in (340,255,301)))";
	    			}
	    		}
				
				if(!(acctype.equalsIgnoreCase("0")) && !(acctype.equalsIgnoreCase(""))){
					sql+=" and h.atype='"+acctype+"'";
	            }
				
				sql = "select trial.acno account,trial.description account_name,CONVERT(if(trial.opnDr>0,round(trial.opnDr,2),''),CHAR(50)) opening_dr,CONVERT(if(trial.opnDr<0,round(trial.opnDr*-1,2),''),CHAR(50)) opening_cr,"
					+ "CONVERT(if(trial.transDr>0,round(trial.transDr,2),''),CHAR(50)) transactions_dr,CONVERT(if(trial.transCr<0,round(trial.transCr*-1,2),''),CHAR(50)) transactions_cr,CONVERT(if(trial.curDr>0,round(trial.curDr,2),''),CHAR(50)) netbalance_dr,"
					+ "CONVERT(if(trial.curDr<0,round(trial.curDr*-1,2),''),CHAR(50)) netbalance_cr,trial.accdocno account_docno,trial.den,trial.grpno,trial.gp_id,trial.groupsname from ( select h.grplevel colNo, h.alevel,(if(h.m_s>=0,ifnull(lopndramount,0),0)) opnDr ,"
					+ "(if(h.m_s>=0,ifnull(ldramount,0),0)) Dr,(if(h.m_s>=0,ifnull(transDrldramount,0),0)) transDr,(if(h.m_s>=0,ifnull(transCrldramount,0),0)) transCr,(if(h.m_s>=0,ifnull(curDr,0),0)) curDr, sublevel,(ifnull(ldramount,0)) dramount,h.account,h.description,"
					+ "h.doc_no accdocno,h.account acno,h.den,h.grpno,g.gp_id,h1.description groupsname from my_head h left join (select sum(lopndramount) lopndramount, sum(ldramount) ldramount, sum(transDrldramount) transDrldramount,sum(transCrldramount) transCrldramount,"
					+ "sum(curDr) curDr, sublevel, acno from ( select if(t.date< '"+sqlFromDate+"' or (t.date='"+sqlFromDate+"' and trtype=1 and t.dtype='OPN'),t.dramount*t.rate,0) lopndramount,if(t.date>= '"+sqlFromDate+"' and t.trtype!=1,t.dramount*t.rate,0) ldramount,"
					+ "if(t.date>= '"+sqlFromDate+"' and t.trtype!=1 and t.dramount>0,t.dramount*t.rate,0) transDrldramount,if(t.date>= '"+sqlFromDate+"' and t.trtype!=1 and t.dramount<0,t.dramount*t.rate,0) transCrldramount,if(!(t.date>= '"+sqlFromDate+"' and t.yrid=1),dramount*t.rate,0) curDr,"
					+ "h.alevel sublevel,t.acno from my_jvtran t inner join my_head h on t.acno=h.doc_no where T.STATUS=3 "+sql+" and t.date<= '"+sqlToDate+"') a group by a.acno ) t on h.doc_no=t.acno left join my_agrp p on h.den=p.fi_id left join gc_agrpd g on p.gp_pr=g.gp_id left join  "
					+ "my_head h1 on h1.doc_no=h.grpno"+sql1+" group by h.doc_no"+sqlRemoveZero+") trial where 1=1"+sql2+" order by gp_id,den,grpno";

				ArrayList<String> trialbalancearray= new ArrayList<String>();
				ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
				String grpno="",oldgrpno="",groupName="",netamountsOPNDR="0.00",netamountsOPNCR="0.00",netamountsTRDR="0.00",netamountsTRCR="0.00",netamountsNETDR="0.00",netamountsNETCR="0.00";
				double netamountOPNDR=0.00,netamountOPNCR=0.00,netamountTRDR=0.00,netamountTRCR=0.00,netamountNETDR=0.00,netamountNETCR=0.00;
				double netsamountOPNDR=0.00,netsamountOPNCR=0.00,netsamountTRDR=0.00,netsamountTRCR=0.00,netsamountNETDR=0.00,netsamountNETCR=0.00;
				int id=0;
				while(resultSet.next()){
					grpno=resultSet.getString("grpno");
					
					if(!(oldgrpno.equalsIgnoreCase(grpno))){
						
						if(id==1){
							if(netsamountOPNDR==0.00){netamountsOPNDR=String.valueOf("");}else {netsamountOPNDR=ClsCommon.Round(netsamountOPNDR, 2);netamountsOPNDR=String.valueOf(netsamountOPNDR);}
							if(netsamountOPNCR==0.00){netamountsOPNCR=String.valueOf("");}else {netsamountOPNCR=ClsCommon.Round(netsamountOPNCR, 2);netamountsOPNCR=String.valueOf(netsamountOPNCR);}
							if(netsamountTRDR==0.00){netamountsTRDR=String.valueOf("");}else {netsamountTRDR=ClsCommon.Round(netsamountTRDR, 2);netamountsTRDR=String.valueOf(netsamountTRDR);}
							if(netsamountTRCR==0.00){netamountsTRCR=String.valueOf("");}else {netsamountTRCR=ClsCommon.Round(netsamountTRCR, 2);netamountsTRCR=String.valueOf(netsamountTRCR);}
							if(netsamountNETDR==0.00){netamountsNETDR=String.valueOf("");}else {netsamountNETDR=ClsCommon.Round(netsamountNETDR, 2);netamountsNETDR=String.valueOf(netsamountNETDR);}
							if(netsamountNETCR==0.00){netamountsNETCR=String.valueOf("");}else {netsamountNETCR=ClsCommon.Round(netsamountNETCR, 2);netamountsNETCR=String.valueOf(netsamountNETCR);}
							
							trialbalancearray.add(oldgrpno+"::"+groupName+"::"+netamountsOPNDR+"::"+netamountsOPNCR+"::"+netamountsTRDR+"::"+netamountsTRCR+"::"+netamountsNETDR+"::"+netamountsNETCR+"::1");
							
							netamountsOPNDR="0.00";netamountsOPNCR="0.00";netamountsTRDR="0.00";netamountsTRCR="0.00";netamountsNETDR="0.00";netamountsNETCR="0.00";
							netamountOPNDR=0.00;netamountOPNCR=0.00;netamountTRDR=0.00;netamountTRCR=0.00;netamountNETDR=0.00;netamountNETCR=0.00;
							netsamountOPNDR=0.00;netsamountOPNCR=0.00;netsamountTRDR=0.00;netsamountTRCR=0.00;netsamountNETDR=0.00;netsamountNETCR=0.00;
							id=0;
						}
						
						trialbalancearray.add(resultSet.getString("account")+" :: "+resultSet.getString("account_name")+" :: "+resultSet.getString("opening_dr")+" :: "+resultSet.getString("opening_cr")+" :: "+resultSet.getString("transactions_dr")+" :: "+resultSet.getString("transactions_cr")+" :: "+resultSet.getString("netbalance_dr")+" :: "+resultSet.getString("netbalance_cr")+" :: "+resultSet.getString("account_docno"));

						netamountOPNDR=resultSet.getDouble("opening_dr");netamountOPNCR=resultSet.getDouble("opening_cr");netamountTRDR=resultSet.getDouble("transactions_dr");netamountTRCR=resultSet.getDouble("transactions_cr");netamountNETDR=resultSet.getDouble("netbalance_dr");netamountNETCR=resultSet.getDouble("netbalance_cr");
						netsamountOPNDR+=netamountOPNDR;netsamountOPNCR+=netamountOPNCR;netsamountTRDR+=netamountTRDR;netsamountTRCR+=netamountTRCR;netsamountNETDR+=netamountNETDR;netsamountNETCR+=netamountNETCR;
						groupName=resultSet.getString("groupsname");
						oldgrpno=grpno;
						id++;
					}else {
						trialbalancearray.add(resultSet.getString("account")+" :: "+resultSet.getString("account_name")+" :: "+resultSet.getString("opening_dr")+" :: "+resultSet.getString("opening_cr")+" :: "+resultSet.getString("transactions_dr")+" :: "+resultSet.getString("transactions_cr")+" :: "+resultSet.getString("netbalance_dr")+" :: "+resultSet.getString("netbalance_cr")+" :: "+resultSet.getString("account_docno"));
						netamountOPNDR=resultSet.getDouble("opening_dr");netamountOPNCR=resultSet.getDouble("opening_cr");netamountTRDR=resultSet.getDouble("transactions_dr");netamountTRCR=resultSet.getDouble("transactions_cr");netamountNETDR=resultSet.getDouble("netbalance_dr");netamountNETCR=resultSet.getDouble("netbalance_cr");
						netsamountOPNDR+=netamountOPNDR;netsamountOPNCR+=netamountOPNCR;netsamountTRDR+=netamountTRDR;netsamountTRCR+=netamountTRCR;netsamountNETDR+=netamountNETDR;netsamountNETCR+=netamountNETCR;
					}
				}
				
				if(netsamountOPNDR==0.00){netamountsOPNDR=String.valueOf("");}else {netsamountOPNDR=ClsCommon.Round(netsamountOPNDR, 2);netamountsOPNDR=String.valueOf(netsamountOPNDR);}
				if(netsamountOPNCR==0.00){netamountsOPNCR=String.valueOf("");}else {netsamountOPNCR=ClsCommon.Round(netsamountOPNCR, 2);netamountsOPNCR=String.valueOf(netsamountOPNCR);}
				if(netsamountTRDR==0.00){netamountsTRDR=String.valueOf("");}else {netsamountTRDR=ClsCommon.Round(netsamountTRDR, 2);netamountsTRDR=String.valueOf(netsamountTRDR);}
				if(netsamountTRCR==0.00){netamountsTRCR=String.valueOf("");}else {netsamountTRCR=ClsCommon.Round(netsamountTRCR, 2);netamountsTRCR=String.valueOf(netsamountTRCR);}
				if(netsamountNETDR==0.00){netamountsNETDR=String.valueOf("");}else {netsamountNETDR=ClsCommon.Round(netsamountNETDR, 2);netamountsNETDR=String.valueOf(netsamountNETDR);}
				if(netsamountNETCR==0.00){netamountsNETCR=String.valueOf("");}else {netsamountNETCR=ClsCommon.Round(netsamountNETCR, 2);netamountsNETCR=String.valueOf(netsamountNETCR);}
				
				trialbalancearray.add(oldgrpno+"::"+groupName+"::"+netamountsOPNDR+"::"+netamountsOPNCR+"::"+netamountsTRDR+"::"+netamountsTRCR+"::"+netamountsNETDR+"::"+netamountsNETCR+"::1");
				
				RESULTDATA=convertArrayToJSON(trialbalancearray);
				
				String sqltrunc="truncate gl_bmainaccountstatement";
				stmtMainAccountStatement.executeUpdate(sqltrunc);
				 
				 for (int i = 0, size = RESULTDATA.size(); i < size; i++) {
					 
				      JSONObject objectInArray = RESULTDATA.getJSONObject(i);

				      if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
				    	  
				    	  if(!(objectInArray.getString("account_docno").equalsIgnoreCase("1"))){
				    		  
					    	  String sqlTemp ="insert into gl_bmainaccountstatement (accountno, accountname, opening_dr, opening_cr, transaction_dr, transaction_cr, netbalance_dr, netbalance_cr) values( "
									    + "'"+objectInArray.getString("account")+"','"+objectInArray.getString("account_name")+"',"
										+ "'"+(objectInArray.getString("opening_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("opening_dr"))+"',"
										+ "'"+(objectInArray.getString("opening_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("opening_cr"))+"',"
										+ "'"+(objectInArray.getString("transactions_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("transactions_dr"))+"',"
										+ "'"+(objectInArray.getString("transactions_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("transactions_cr"))+"',"
										+ "'"+(objectInArray.getString("netbalance_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("netbalance_dr"))+"',"
										+ "'"+(objectInArray.getString("netbalance_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("netbalance_cr"))+"')";
							  stmtMainAccountStatement.executeUpdate(sqlTemp);
						  
				    	  }
				    	  
				      } else {
				      
						  String sqlTemp ="insert into gl_bmainaccountstatement (accountno, accountname, opening_dr, opening_cr, transaction_dr, transaction_cr, netbalance_dr, netbalance_cr) values( "
								    + "'"+objectInArray.getString("account")+"','"+objectInArray.getString("account_name")+"',"
									+ "'"+(objectInArray.getString("opening_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("opening_dr"))+"',"
									+ "'"+(objectInArray.getString("opening_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("opening_cr"))+"',"
									+ "'"+(objectInArray.getString("transactions_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("transactions_dr"))+"',"
									+ "'"+(objectInArray.getString("transactions_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("transactions_cr"))+"',"
									+ "'"+(objectInArray.getString("netbalance_dr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("netbalance_dr"))+"',"
									+ "'"+(objectInArray.getString("netbalance_cr").trim().equalsIgnoreCase("")?"0":objectInArray.getString("netbalance_cr"))+"')";
						  stmtMainAccountStatement.executeUpdate(sqlTemp);
				      }
				    }
				
				stmtMainAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountStatementDetail(String branch,String fromdate,String todate,String accdocno,String atype,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
            	
				if(atype.equalsIgnoreCase("GL")){
					
					if(accdocno.equalsIgnoreCase("255") || accdocno.equalsIgnoreCase("301") || accdocno.equalsIgnoreCase("340")){
					
						sql = "select a.*,"+casestatement+"b.branchname from (select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
							+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
							+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
							+ "t.tr_no,t.curId,sum(t.dramount) dramount,sum(t.ldramount) ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
							+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" group by t.tr_no union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
							+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
							+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
							+ "group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId where h.den="+accdocno+" order by acno,"
							+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"";
					
					}else if(!(accdocno.equalsIgnoreCase("255") || accdocno.equalsIgnoreCase("301") || accdocno.equalsIgnoreCase("340"))){
			
						sql = "select a.*,"+casestatement+"b.branchname from (select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
								+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
								+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
								+ "t.tr_no,t.curId,sum(t.dramount) dramount,sum(t.ldramount) ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
								+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+"  group by t.tr_no union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
								+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
								+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
								+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
								+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"";
				  }
				  }else {
					
						sql = "select a.*,"+casestatement+"b.branchname from (select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
								+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
								+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
								+ "t.tr_no,t.curId,sum(t.dramount) dramount,sum(t.ldramount) ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
								+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+"  group by t.tr_no union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
								+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
								+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
								+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
								+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"";
				  }
				
				ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtMainAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray accountStatementDetailGrid(String trno,String check) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA1;
	    }
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement1 = conn.createStatement();
	        	
				ResultSet resultSet1 = stmtMainAccountStatement1.executeQuery ("select jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(50)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(50)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(50)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(50)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 and jv.tr_no="+trno+"");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtMainAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray accountDetailsSearch(String type,String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement1 = conn.createStatement();
				
				sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.m_s=1 and t.atype='"+type+"'"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtMainAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				
				else{
					stmtMainAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtMainAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsMainAccountStatementBean getPrint(HttpServletRequest request,String acno,String type,String branch,String fromdate,String todate,String includingzero) throws SQLException {
		ClsMainAccountStatementBean bean = new ClsMainAccountStatementBean();
		
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtMainAccountStatement = conn.createStatement();
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
		
		sql="select b.branchname,'Statement of Main Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
				+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
				+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";
		
		ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
		
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
			
		}
		
		String sqls="";
		
		if(!((acno.equalsIgnoreCase("")) || (acno.equalsIgnoreCase("0")))){
			sqls="select if('"+type+"'='GL' and trim('"+acno+"')='','General Ledger',if('"+type+"'='AR' and trim('"+acno+"')='','Account Receivable',if('"+type+"'='AP' and trim('"+acno+"')='','Account Payable',if('"+type+"'='HR' and trim('"+acno+"')='','Human Resource',description)))) account from my_head where doc_no="+acno+"";
		} else {
			sqls="select if('"+type+"'='GL' and trim('"+acno+"')='','General Ledger',if('"+type+"'='AR' and trim('"+acno+"')='','Account Receivable',if('"+type+"'='AP' and trim('"+acno+"')='','Account Payable',if('"+type+"'='HR' and trim('"+acno+"')='','Human Resource','')))) account";
		}
		ResultSet resultSets = stmtMainAccountStatement.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setAccountno(resultSets.getString("account"));
		}
		
		stmtMainAccountStatement.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] trialBalanceArray=arrayList.get(i).split("::");
			
			obj.put("account",trialBalanceArray[0]);
			obj.put("account_name",trialBalanceArray[1]);
			obj.put("opening_dr",trialBalanceArray[2]);
			obj.put("opening_cr",trialBalanceArray[3]);
			obj.put("transactions_dr",trialBalanceArray[4]);
			obj.put("transactions_cr",trialBalanceArray[5]);
			obj.put("netbalance_dr",trialBalanceArray[6]);
			obj.put("netbalance_cr",trialBalanceArray[7]);
			obj.put("account_docno",trialBalanceArray[8]);
			
			jsonArray.add(obj);
		}
		return jsonArray;
		}
}
