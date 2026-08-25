package com.dashboard.accounts.balancesheet;

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

public class ClsBalanceSheetDAOWITHYRID  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray balanceSheetGrid(String branch,String fromdate,String todate,String level1,String level2, String level3, String level4, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtBalance = conn.createStatement();
			
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
		     
		    /*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			}*/
		     
		     if(level1.equalsIgnoreCase("1")){
		    	 		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		     
		     }else if(level2.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,3,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		     
		     }else if(level3.equalsIgnoreCase("1")){

		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,3,4,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		    	 
		     }else if(level4.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno";
		     
		     }
//			System.out.println("Balance Sheet Grid======"+sql);
			 ResultSet resultSet = stmtBalance.executeQuery(sql);
			 
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="0",netamount="";
             int a=0,b=0;
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					netamount=resultSet.getString("netamt");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}else if(masterid.equalsIgnoreCase("0")){
							parentid=masterparentid;
						}  
						
						childid=masterid;
					}
					
					orderno=resultSet.getString("ordno");
					
					if(resultSet.getString("gp_id").equalsIgnoreCase("14")){
						parentid=null;
						orderno="5";
					}
					
					if(resultSet.getInt("gp_id")>=19 && a==0 && resultSet.getString("description").contains("PROFIT FOR THE PERIOD")){
						profityearamt=resultSet.getString("netamt");
						orderno="3";
						a=1;
					}
					
					if(resultSet.getInt("gp_id")>=20 && b==0){
						String netamt=resultSet.getString("netamt");
/**
 * 
 * Profit for the Year should be added  so added resultSet.getString("description").contains("PROFIT FOR THE PERIOD")
 * 
 * */
						
						netamount=String.valueOf(Double.parseDouble(netamt)+Double.parseDouble(profityearamt));
		
						
						b=1;
					}
					
					if(netamount.equalsIgnoreCase("0.00")){
						netamount="";
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("grpamt")+"::"+netamount+"::"+resultSet.getString("childamt")+"::"+resultSet.getString("subchildamt")+"::"+parentid+"::"+orderno+"::"+resultSet.getString("groupno")+"::"+resultSet.getString("subac")+"::"+resultSet.getString("gp_id");
					
					balancearray.add(temp);
				}
				
			 RESULTDATA=convertArrayToJSON(balancearray);
			 
			 	String sqlConfig="select method from gl_config where field_nme='balanceSheetPrint'";
				ResultSet resultSetConfig = stmtBalance.executeQuery(sqlConfig);
				String valueOfConfig="";
				while(resultSetConfig.next()){
					valueOfConfig=resultSetConfig.getString("method");
				}
				
				if(valueOfConfig.equalsIgnoreCase("1")){
					
					String sqls="Truncate balancesheet";
					int data= stmtBalance.executeUpdate(sqls);
					 
					 for (int i = 0, size = RESULTDATA.size(); i < size; i++) {
					       JSONObject objectInArray = RESULTDATA.getJSONObject(i);

					       if(objectInArray.getString("ordno").trim().equalsIgnoreCase("5") || objectInArray.getString("ordno").trim().equalsIgnoreCase("3") || objectInArray.getString("ordno").trim().equalsIgnoreCase("1")) {
					    	   
								String sql3 ="insert into balancesheet (description, group1, group2, ordno, gp_id) values('"+objectInArray.getString("description")+"',"
										+ "'"+(objectInArray.getString("childamt").trim().equalsIgnoreCase("")?"-":objectInArray.getString("childamt"))+"',"
										+ "'"+(objectInArray.getString("netamt").trim().equalsIgnoreCase("")?"-":objectInArray.getString("netamt"))+"',"
										+ "'"+(objectInArray.getString("ordno").trim().equalsIgnoreCase("")?"0":objectInArray.getString("ordno"))+"',"
										+ "'"+(objectInArray.getString("gp_id").trim().equalsIgnoreCase("")?"0":objectInArray.getString("gp_id"))+"')";
								int data1= stmtBalance.executeUpdate(sql3);
							
					       }
					    }
					 
				}
				
			 }
			 
			 stmtBalance.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	
	public JSONArray balanceSheetExcelExport(String branch,String fromdate,String todate,String level1,String level2, String level3, String level4, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtBalance = conn.createStatement();
			
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
		     
		    /*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			}*/
		     
		    if(level1.equalsIgnoreCase("1")){
		    	 		    	 
		    	sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,"
				    	  + "0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,0 account,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,139 account,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,140 account,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		     
		     }else if(level2.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,"
				    	  + "if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,0 account,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,139 account,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,140 account,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,3,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		     
		     }else if(level3.equalsIgnoreCase("1")){

		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,"
				    	  + "0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,0 account,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,139 account,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,140 account,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,3,4,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		    	 
		     }else if(level4.equalsIgnoreCase("1")){
		    	 
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,"
				    	  + "0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,0 account,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,139 account,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,140 account,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno";
		     
		     }
		     
//		     System.out.println("Excel Export--->"+sql);
			 ResultSet resultSet = stmtBalance.executeQuery(sql);
			 
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="",netamount="";
            int a=0,b=0;
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					netamount=resultSet.getString("netamt");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}else if(masterid.equalsIgnoreCase("0")){
							parentid=masterparentid;
						}  
						
						childid=masterid;
					}
					
					orderno=resultSet.getString("ordno");
					
					if(resultSet.getString("gp_id").equalsIgnoreCase("14")){
						parentid=null;
						orderno="5";
					}
					
					if(resultSet.getInt("gp_id")>=19 && a==0  && resultSet.getString("description").contains("PROFIT FOR THE PERIOD")){
						profityearamt=resultSet.getString("netamt");
						orderno="3";
						a=1;
					}
					
					if(resultSet.getInt("gp_id")>=20 && b==0){
						String netamt=resultSet.getString("netamt");
						netamount=String.valueOf(Double.parseDouble(netamt)+Double.parseDouble(profityearamt));
						/**
						 * TOTAL EQUITY WAS GETTING DOUBLED IN PROGRESS SO COMMENTED BELOW LINE
						 * */
												
						// netamount=String.valueOf(Double.parseDouble(netamt)+Double.parseDouble(profityearamt));
						b=1;
					}
					
					if(netamount.equalsIgnoreCase("0.00")){
						netamount="";
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("subchildamt")+"::"+resultSet.getString("grpamt")+"::"+resultSet.getString("childamt")+"::"+netamount+"::"+resultSet.getString("code");
					
					balancearray.add(temp);
				}
				
			 RESULTDATA=convertArrayToExcel(balancearray);
			 
			 }
			 
			 stmtBalance.close();
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
				
				String sql = "",joins="",casestatement="";
				
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
        		
				/*sql = "select "+casestatement+"a.* from (select brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType,t.brhid from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" union all select date( '"+sqlFromDate+"' ) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType,0 brhid "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a"+joins+"";*/
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and t.yrid=0 and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
						
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
	
	public JSONArray accountStatementDetailGrid(String trno,String check) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA1;
	    }
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
	
public  ClsBalanceSheetBean getPrintTForm(HttpServletRequest request,String branch,String todate) throws SQLException {
		
		ClsBalanceSheetBean bean = new ClsBalanceSheetBean();

		Connection conn = null;
		java.sql.Date sqlToDate = null;
		
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtBalance = conn.createStatement();
		
		if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
         }
		
		if((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA"))){
			branch="1";
		}
		
		String headersql="select 'T-Form' vouchername,CONCAT('T-Form as on ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,"
				+ "b.pbno,b.stcno,b.cstno from my_brch b inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from "
				+ "my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where b.doc_no='"+branch+"'";
				
				ResultSet resultSetHead = stmtBalance.executeQuery(headersql);
				
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
				
		stmtBalance.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
	
	public  ClsBalanceSheetBean getPrint(HttpServletRequest request,String branch,String fromdate,String todate) throws SQLException {
		
		ClsBalanceSheetBean bean = new ClsBalanceSheetBean();

		Connection conn = null;
		java.sql.Date sqlToDate = null;
		java.sql.Date sqlFromDate = null;
		
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtBalance = conn.createStatement();
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
         }
		
		if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
         }
		
		if((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA"))){
			branch="1";
		}
		
		String headersql="select 'Balance Sheet' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
				+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_brch b inner join my_comp c on b.cmpid=c.doc_no "
				+ "inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) "
				+ "where b.doc_no='"+branch+"'";
//		System.out.println("Print query--->"+headersql);		
				ResultSet resultSetHead = stmtBalance.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblmainprintname(resultSetHead.getString("vouchername"));
					bean.setLblmainprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
				}
				
		stmtBalance.close();
		conn.close();
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
				obj.put("gp_id",balanceSheetArray[10]);
				
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
