package com.dashboard.accounts.profitlosssymbol;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProfitLossSymbol  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray profitLossGrid(String branch,String fromdate,String todate,String level1,String level2, String level3, String level4, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1 = "",sql2="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			}
		     
		     if(level1.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
		    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
		    	 	+ "0 subac,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
		    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
		    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
		    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
		    	 	+ "sum(ldramount) dr, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h "
		    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
		    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
		    	 	+ "k.subchildamt!=0) and  ordno=5 order by gp_id,den,groupno,ordno";
		     
		     }else if(level2.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
		    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
		    	 	+ "0 subac,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
		    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
		    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
		    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
		    	 	+ "sum(ldramount) dr, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h "
		    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
		    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
		    	 	+ "k.subchildamt!=0) and  ordno in (5,3) order by gp_id,den,groupno,ordno";
		     
		     }else if(level3.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
				    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
				    	 	+ "0 subac,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
				    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
				    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
				    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
				    	 	+ "sum(ldramount) dr, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
				    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h "
				    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
				    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
				    	 	+ "k.subchildamt!=0) and  ordno in (5,3,4) order by gp_id,den,groupno,ordno";
		     
		     }else{
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
				    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
				    	 	+ "0 subac,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
				    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
				    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
				    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
				    	 	+ "sum(ldramount) dr, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
				    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h "
				    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
				    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
				    	 	+ "k.subchildamt!=0) order by gp_id,den,groupno,ordno";
		     
		     }

		     ResultSet resultSet = stmtProfitLoss.executeQuery(sql);
			 
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamt="",directcostamt="",grossprofit="",
					 otherincomeamt="",indirectexpensesamt="",netprofit="0.00";
             int a=0,b=0;
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamt=resultSet.getString("netamt");
							}
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}
						
							if(resultSet.getInt("gp_id")>=22 && a==0){
								if(parentid==null){
									
									grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))+(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
									temp="0::GROSS PROFIT:: ::"+grossprofit+" :: :: :: null:: 5:: :: 0";
									balancearray.add(temp);
									a=1;
								}
							}
							
							if(resultSet.getInt("gp_id")>=23 && b==0){
								if(parentid==null){
								    netprofit=String.valueOf(((grossprofit.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofit))+(otherincomeamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamt)))+(indirectexpensesamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamt)));
								    b=1;
								}
							}
							
						 childid=masterid;
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("grpamt")+"::"+resultSet.getString("netamt")+"::"+resultSet.getString("childamt")+"::"+resultSet.getString("subchildamt")+"::"+parentid+"::"+resultSet.getString("ordno")+"::"+resultSet.getString("groupno")+"::"+resultSet.getString("subac");
					balancearray.add(temp);
				}

				balancearray.add("999::NET PROFIT/LOSS:: ::"+netprofit+" :: :: :: null:: 5:: :: 0");
				
				RESULTDATA=convertArrayToJSON(balancearray);
				
			   }
			 
			 stmtProfitLoss.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	public JSONArray profitLossExcelExport(String branch,String fromdate,String todate,String level1,String level2, String level3, String level4, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1 = "",sql2="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			}
		     
		     if(level1.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
		    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 "
		    		+ "then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
		    	 	+ "0 subac,gp_desc description,0 account,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
		    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
		    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,accountno,@xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
		    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
		    	 	+ "sum(ldramount) dr, a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h "
		    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
		    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
		    	 	+ "k.subchildamt!=0) and  ordno=5 order by gp_id,den,groupno,ordno";
		     
		     }else if(level2.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
		    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then "
		    		+ "'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
		    	 	+ "0 subac,gp_desc description,0 account,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
		    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
		    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,accountno,@xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
		    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
		    	 	+ "sum(ldramount) dr, a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h "
		    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
		    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
		    	 	+ "k.subchildamt!=0) and  ordno in (5,3) order by gp_id,den,groupno,ordno";
		     
		     }else if(level3.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
				    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then "
		    			    + "'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
				    	 	+ "0 subac,gp_desc description,0 account,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
				    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
				    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,accountno,@xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
				    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
				    	 	+ "sum(ldramount) dr, a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
				    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h "
				    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
				    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
				    	 	+ "k.subchildamt!=0) and  ordno in (5,3,4) order by gp_id,den,groupno,ordno";
		     
		     }else{
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,"
				    	 	+ "CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 "
		    			    + "then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
				    	 	+ "0 subac,gp_desc description,0 account,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
				    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
				    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,accountno,@xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
				    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
				    	 	+ "sum(ldramount) dr, a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
				    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h "
				    	 	+ "where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
				    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
				    	 	+ "k.subchildamt!=0) order by gp_id,den,groupno,ordno";
		     
		     }

		     ResultSet resultSet = stmtProfitLoss.executeQuery(sql);
			 
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamt="",directcostamt="",grossprofit="",
					 otherincomeamt="",indirectexpensesamt="",netprofit="0.00";
            int a=0,b=0;
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamt=resultSet.getString("netamt");
							}
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}
						
							if(resultSet.getInt("gp_id")>=22 && a==0){
								if(parentid==null){
									grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))+(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
									temp="0::GROSS PROFIT:: ::"+grossprofit+" :: :: :: null:: 5:: :: 0";
									balancearray.add(temp);
									a=1;
								}
							}
							
							if(resultSet.getInt("gp_id")>=23 && b==0){
								if(parentid==null){
								    netprofit=String.valueOf(((grossprofit.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofit))+(otherincomeamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamt)))+(indirectexpensesamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamt)));
								    b=1;
								}
							}
							
						 childid=masterid;
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("subchildamt")+"::"+resultSet.getString("grpamt")+"::"+resultSet.getString("childamt")+"::"+resultSet.getString("netamt")+"::"+resultSet.getString("code");
					
					balancearray.add(temp);
				}

				balancearray.add("999::NET PROFIT/LOSS:: :: :: ::"+netprofit+"::Group II");
				
				RESULTDATA=convertArrayToExcel(balancearray);
				
			   }
			 
			 stmtProfitLoss.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	
	public JSONArray accountStatementDetail(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBalance1 = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				String sql = "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            	
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
				}
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				sql = "select a.*,if(a.transType='ÍNV',m.voc_no,a.transno) transno  from (select transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" union all select date( '"+sqlFromDate+"' ) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join gl_invm m on m.dtype=a.transType and a.transno=m.doc_no";
				
				ResultSet resultSet = stmtBalance1.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtBalance1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray accountStatementDetailGrid(String trno) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBalance1 = conn.createStatement();
	        	
				ResultSet resultSet1 = stmtBalance1.executeQuery ("select jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 and jv.tr_no="+trno+"");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBalance1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			for (int i = 0; i < arrayList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] balanceSheetArray=arrayList.get(i).split("::");
				
				obj.put("id",balanceSheetArray[0]);
				obj.put("description",balanceSheetArray[1]);
				obj.put("grpamt",balanceSheetArray[2]);
				obj.put("netamt",balanceSheetArray[3]);
				obj.put("childamt",balanceSheetArray[4]);
				obj.put("subchildamt",balanceSheetArray[5]);
				obj.put("parentid",balanceSheetArray[6]);
				obj.put("ordno",balanceSheetArray[7]);
				obj.put("groupno",balanceSheetArray[8]);
				obj.put("subac",balanceSheetArray[9]);
				
				jsonArray.add(obj);
			}
			return jsonArray;
			}
	
	public  JSONArray convertArrayToExcel(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] balanceSheetArray=arrayList.get(i).split("::");
			
			obj.put("No.",balanceSheetArray[0]);
			obj.put("Description",balanceSheetArray[1]);
			obj.put("Detail",balanceSheetArray[2]);
			obj.put("Main",balanceSheetArray[3]);
			obj.put("Group I",balanceSheetArray[4]);
			obj.put("Group II",balanceSheetArray[5]);
			obj.put("Code",balanceSheetArray[6]);
			
			jsonArray.add(obj);
						
		}
		return jsonArray;
		}
	
     }
