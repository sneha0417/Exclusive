package com.dashboard.analysis.accountanalysis;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountAnalysis  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray analysisGrid(String branch,String fromdate,String todate, String cmbfrequency,String noOfDays,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtAccountAnalysis = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			     
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		         }else if(fromdate.equalsIgnoreCase("0")){
		        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
					   ResultSet rs = stmtAccountAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlFromDate=rs.getDate("today");
					   }
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }else if(todate.equalsIgnoreCase("0")){
		        	   String sqldate= "select CURDATE() today";
					   ResultSet rs = stmtAccountAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlToDate=rs.getDate("today");
					   }
		         }
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     
			     analysiscolumnarray.add("Id::id::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Parent Id::parentid::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Ord No::ordno::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Group No::groupno::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Group Id::gp_id::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Account::subac::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Description::description::left::left:: ::25%:: ::headClass");
			     analysiscolumnarray.add("Total::total::right::right:: ::10%::d2::violetClass");
			     		     
			     String xsql="",xsqls="";
			     String sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="";
			     String dayDiff="",monthDiff="";

			     if(cmbfrequency.equalsIgnoreCase("1") || cmbfrequency.equalsIgnoreCase("0")){
			    	 if(cmbfrequency.equalsIgnoreCase("0")){
			    		 String sqls = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
			    		 ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
			 			
			 			while(rs1.next()) {
			 				dayDiff=rs1.getString("daydiff");
			 			} 
			 			
			 			String sqls1 = "select ("+dayDiff+"/"+noOfDays+") daydifference";
			 			ResultSet rs2 = stmtAccountAnalysis.executeQuery(sqls1);
			 			
			 			while(rs2.next()) {
			 				txtfrequency=rs2.getInt("daydifference");
			 			} 
			 			 
			    		 xsqls= "1 Day";
			    	 }else{
			    		 String sqls = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
			    		 ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
			 			
			 			while(rs1.next()) {
			 				dayDiff=rs1.getString("daydiff");
			 			} 
			 			
			 			String sqls1 = "select ("+dayDiff+"/"+noOfDays+") daydifference";
			 			ResultSet rs2 = stmtAccountAnalysis.executeQuery(sqls1);
			 			
			 			while(rs2.next()) {
			 				txtfrequency=rs2.getInt("daydifference");
			 			} 

			    		 xsqls=Integer.parseInt(noOfDays) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");	
			    		 
			    	 }
					
			     }else if(cmbfrequency.equalsIgnoreCase("2")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
						
			     }else if(cmbfrequency.equalsIgnoreCase("3")){
			    	 
			    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
						
						while(rs1.next()) {
							monthDiff=rs1.getString("monthdiff");
						} 
						
						String sqls1 = "select ("+monthDiff+"/3) monthdifference";
						ResultSet rs2 = stmtAccountAnalysis.executeQuery(sqls1);
						
						while(rs2.next()) {
							txtfrequency=rs2.getInt("monthdifference");
						} 
			    	    
						xsqls= "3 Month";
						
			     }else{

			    	 	/*String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";*/
						String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
			    	 	ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("yeardiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			     }
			     
			     	if(cmbfrequency.equalsIgnoreCase("1") || cmbfrequency.equalsIgnoreCase("0")){
						analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+") analysisDate,DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+"),'%d-%m-%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y') analysingDate";
						   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
									
							     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
							    	   analysisDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
							     
							     /*sql3+=" if (k.date<='"+analysisDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
							     
							     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
								 
							     sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
							     
							     sql9+="sum(ldramount)*-1 amount"+i+",";
							     
							     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
							     
							     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
							     
							     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
							     
							     sql8+="if(t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
							     
						     }

						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
			     	}
			     
			     	else if(cmbfrequency.equalsIgnoreCase("2")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql="Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
						   
						   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
								 
							     sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
							     
							     sql9+="sum(ldramount)*-1 amount"+i+",";
							     
							     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
							     
							     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
							     
							     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
							     
							     sql8+="if(t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
						     }
						}else{
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
									 + "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   
							   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
									     /*sql3+=" if (k.date between '"+analysisFromDate+"' and '"+analysisToDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
								     
								     	 sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
										 
								     	sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
								     	
								     	sql9+="sum(ldramount)*-1 amount"+i+",";
								     	
								     	 sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
								     	
								     	 sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
								     	
								     	 sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
								     	
								     	 sql8+="if(t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
								     	
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
			     
			     	else if(cmbfrequency.equalsIgnoreCase("3")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
							   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     /*sql3+=" if (k.date between '"+sqlFromDate+"' and '"+analysisDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
								     
								     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
									 
								     sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
								     
								     sql9+="sum(ldramount)*-1 amount"+i+",";
								     
								     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
								     
								     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
								     
								     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
								     
								     sql8+="if(t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
								     
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
								   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
								   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
								   
								   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }
									     
										     /*sql3+=" if (k.date between '"+analysisFromDate+"' and '"+analysisToDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
									     
									         sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
											 
									         sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
									         
									         sql9+="sum(ldramount)*-1 amount"+i+",";
									         
									         sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
									         
									         sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
									         
									         sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
									         
									         sql8+="if(t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
									         
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
			     	
			     	else{
			     		
			     		analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   String sqls = "SELECT YEAR('"+analysisDate+"') year";
							   ResultSet rs1 = stmtAccountAnalysis.executeQuery(sqls);
							   
							   int year=0;
							   while(rs1.next()){
								    year=rs1.getInt("year");
							   }
							   
							   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
							   ResultSet rss = stmtAccountAnalysis.executeQuery(sqls1);
							   
							   int noOfMonths=0;
							   while(rss.next()){
								     noOfMonths=rss.getInt("noofmonths");
							   }
							   
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
							   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     /*sql3+=" if (k.date between '"+sqlFromDate+"' and '"+analysisDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
								     
								     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
									 
								     sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
								     
								     sql9+="sum(ldramount)*-1 amount"+i+",";
								     
								     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
								     
								     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
								     
								     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
								     
								     sql8+="if(t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
								     
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
								   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
								   
								   ResultSet rs = stmtAccountAnalysis.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }
									     
										     /*sql3+=" if (k.date between '"+analysisFromDate+"' and '"+analysisToDate+"',if(k.dr!=0,round(k.dr,2),''),'') amount"+i+",";*/
									     
									           sql3+="if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
											 
									           sql4+="if(gtype='X',@xwrk,0) amount"+i+",";
									           
									           sql9+="sum(ldramount)*-1 amount"+i+",";
									           
									           sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,1,-1),amount"+i+"*drsign) amount"+i+",";
									           
									           sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
									           
									           sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
									           
									           sql8+="if(t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
									           
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
			     	}
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			}
		     
		     /*sql = "select @i:=@i+1 id,k.date,k.description,if(k.dr!=0,round(k.dr,2),'') dramount,"+sql3+""
		     		+ "k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac from ("
		     		+ "select 0 date,"+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,if(gtype='X',@xwrk,0) netAmt "
		     		+ "from gc_agrpd where gtype in('D','X') and gp_id<=17 "
		     		+ "UNION ALL "
		     		+ "Select t.date,"+sql1+"0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD' description,0 dr,sum(ldramount)*-1 netAmt from "
		     		+ "my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type in (4,5)  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "select m.date,"+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,"
		     		+ "gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',"
		     		+ "' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,"
		     		+ "dr*if(grpLevel=1,1,-1),dr*drsign) dr,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt from ("
		     		+ "select a.date,a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,"
		     		+ "a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ("
		     		+ "select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		     		+ "length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,("
		     		+ "SELECT 139 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+"' and h.gr_type>=4  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "Select 140 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 and "
		     		+ "t.trtype!=1  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "SELECT acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "
		     		+ ""+sql2+"  group by t.acno) t  where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,"
		     		+ "(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where k.dr!=0 order by gp_id,den,groupno,ordno";*/
		     
		     sql = "select @i:=@i+1 id,k.date,k.description,if(k.dr!=0,round(k.dr,2),'') dramount,"+sql3+"k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,"
		    		+ "k.groupno,k.subac from ( " 
		     		+ "select "+sql1+""+sql4+"0 date,if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr from gc_agrpd where gtype in('D','X') "
		     		+ "and gp_id<=17 UNION ALL " 
		     		+ "Select "+sql1+""+sql9+"t.date,0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD' description,sum(ldramount)*-1 dr from "
		     		+ "my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type in (4,5)"+sql2+" UNION ALL "  
		     		+ "select "+sql1+""+sql5+"m.date,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,"  
		     		+ "if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,"
		     		+ "if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,"  
		     		+ "if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr from ("  
		     		+ "select a.date,a.doc_no subac,m.*,sum(ldramount) dr,"+sql6+"@xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null,ldramount,0)) ldr,"  
		     		+ "a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "  
		     		+ "select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,"
		     		+ "concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id "
		     		+ "and g.gtype='D' and gp_id<=17) m,my_head a,( "  
		     		+ "select x.acno,x.date,"+sql7+"round(sum(x.ldramount),2) ldramount from ("  
		     		+ "SELECT t.date,139 acno,"+sql8+"coalesce(round(ldramount,2),0) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+"'"  
		     		+ "and h.gr_type>=4"+sql2+"  UNION ALL "  
		     		+ "Select t.date,140 acno,"+sql8+"coalesce(round(ldramount,2),0) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and "  
		     		+ "t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type>=4 and t.trtype!=1"+sql2+"  UNION ALL "  
		     		+ "SELECT t.date,acno,"+sql8+"coalesce(round(ldramount,2),0) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type<4 and "  
		     		+ "t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1)"+sql2+") x group by x.acno) t  where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
		     		+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup ) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno ) k,"
		     		+ "(SELECT @i:= 0) as i where k.dr!=0 order by gp_id,den,groupno,ordno";
		     
			 ResultSet resultSet = stmtAccountAnalysis.executeQuery(sql);
			 
			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="",netamount="";
			 int a=0,b=0;
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();

					masterid=resultSet.getString("parentid");
					netamount=resultSet.getString("dramount");
					
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
					
					if(resultSet.getInt("gp_id")>=19 && a==0){
						profityearamt=resultSet.getString("dramount");
						orderno="3";
						a=1;
					}
					
					if(resultSet.getInt("gp_id")>=20 && b==0){
						String netamt=resultSet.getString("dramount");
						netamount=String.valueOf(Double.parseDouble(netamt==""?"0":netamount)+Double.parseDouble(profityearamt==""?"0":profityearamt));
						b=1;
					}
					
					if(netamount.equalsIgnoreCase("0.00")){
						netamount="";
					}
					
					temp.add(resultSet.getString("id"));
					temp.add(parentid);
					temp.add(orderno);
					temp.add(resultSet.getString("groupno"));
					temp.add(resultSet.getString("gp_id"));
					temp.add(resultSet.getString("subac"));
					temp.add(resultSet.getString("description"));
					temp.add(netamount);
					
					for (int l = 0; l < amountLength; l++) {
						String amounts="";
						if(resultSet.getInt("gp_id")>=20 && b==1){
							amounts=netamount;
						}else{
							amounts=resultSet.getString("amount"+l+"");
						}
						temp.add(amounts);
					}
					
					analysisrowarray.add(temp);
				}
				
			 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
			 
			 }
			 
			 stmtAccountAnalysis.close();
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
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
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
	
	public JSONArray accountStatementDetailGrid(String trno) throws SQLException {
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

	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("parentid",analysisRowArray.get(1));
			obj.put("ordno",analysisRowArray.get(2));
			obj.put("groupno",analysisRowArray.get(3));
			obj.put("gp_id",analysisRowArray.get(4));
			obj.put("subac",analysisRowArray.get(5));
			obj.put("description",analysisRowArray.get(6));
			obj.put("total",analysisRowArray.get(7));
			
			for (int j = 8,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
     }
