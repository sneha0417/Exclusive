package com.dashboard.audit.costupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsCostupdateDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getCosttran(String branch,String fromdate,String todate,String id) throws SQLException {
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}   
	    Connection  conn = null;
	    Statement stmtmanual =null;
		java.sql.Date sqlfromdate=null,sqltodate=null;
           try {
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			
			conn=ClsConnection.getMyConnection();
				stmtmanual = conn.createStatement ();
				/*strSql="select sum(a.jvamt)+sum(coalesce(b.costtranamt,0)) from (select h.description,h.doc_no,tranid,sum(dramount) jvamt,j.dtype from my_head h ,my_jvtran j where gr_type in (4,5) and"+
						" h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by j.tr_no) a inner join"+
						" (select sum(amount) costtranamt,tr_no,acno,tranid from my_costtran group  by tr_no) b on a.tranid=b.tranid where  b.costtranamt!=a.jvamt";*/
				/*strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt,coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from"+
						" (select h.description,j.acno,j.doc_no,j.tr_no,tranid,dramount jvamt,j.dtype from my_head h ,my_jvtran j where gr_type in (4,5) and"+
						" h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' ) a left join"+
						" (select sum(amount) costtranamt,acno,tranid from my_costtran group  by tranid ) b on a.tranid=b.tranid where  "+
						" coalesce(b.costtranamt,0)!=a.jvamt group by tr_no,acno";
*/
/*				strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt,"+
						" coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ("+
						" select h.description,j.acno,j.doc_no,j.tr_no, tranid,sum(if(dramount<0,dramount*-1,dramount)) jvamt,j.dtype from my_head h ,"+
						" my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by tr_no) a"+
						" left join (select sum(if(amount<0,amount*-1,amount)) costtranamt,acno,tr_no from my_costtran cost group  by tr_no ) b"+
						" on a.tr_no=b.tr_no where   round(coalesce(b.costtranamt,0),2)!=round(a.jvamt,2) group by tr_no";
*/				
				/*strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt, "
						+ "coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from "
						+ "( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,j.dtype from my_head h , my_jvtran j"
						+ " where gr_type in (4,5) and h.doc_no=j.acno and j.status=3 and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and (costcode!=0 or costcode is not null) ) a left join"
						+ " (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group  by tranid ) b on a.tranid=b.tranid "
						+ "where   round(coalesce(b.costtranamt,0),2)!=round(a.jvamt,2)";*/
				
				String sqlbranch="";
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and j.brhid="+branch;
				}
				strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt,"+
				" coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,"+
				" j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3 "+sqlbranch+" and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+
				" ) a left join (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group by tranid ) b on "+
				" a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)";
				// System.out.println("Load Sql://"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			stmtmanual.close();
			conn.close();
		}
		// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public JSONArray getCosttranExcel(String branch,String fromdate,String todate,String id) throws SQLException {
		  String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
		    Statement stmt =null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				
				conn=ClsConnection.getMyConnection();
					stmt = conn.createStatement ();
					/*strSql="select sum(a.jvamt)+sum(coalesce(b.costtranamt,0)) from (select h.description,h.doc_no,tranid,sum(dramount) jvamt,j.dtype from my_head h ,my_jvtran j where gr_type in (4,5) and"+
							" h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by j.tr_no) a inner join"+
							" (select sum(amount) costtranamt,tr_no,acno,tranid from my_costtran group  by tr_no) b on a.tranid=b.tranid where  b.costtranamt!=a.jvamt";*/
					/*strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt,coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from"+
							" (select h.description,j.acno,j.doc_no,j.tr_no,tranid,dramount jvamt,j.dtype from my_head h ,my_jvtran j where gr_type in (4,5) and"+
							" h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' ) a left join"+
							" (select sum(amount) costtranamt,acno,tranid from my_costtran group  by tranid ) b on a.tranid=b.tranid where  "+
							" coalesce(b.costtranamt,0)!=a.jvamt group by tr_no,acno";
	*/
	/*				strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt,"+
							" coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ("+
							" select h.description,j.acno,j.doc_no,j.tr_no, tranid,sum(if(dramount<0,dramount*-1,dramount)) jvamt,j.dtype from my_head h ,"+
							" my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by tr_no) a"+
							" left join (select sum(if(amount<0,amount*-1,amount)) costtranamt,acno,tr_no from my_costtran cost group  by tr_no ) b"+
							" on a.tr_no=b.tr_no where   round(coalesce(b.costtranamt,0),2)!=round(a.jvamt,2) group by tr_no";
	*/				
					/*strSql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt,coalesce(b.costtranamt,0) costtranamt, "
							+ "coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from "
							+ "( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,j.dtype from my_head h , my_jvtran j"
							+ " where gr_type in (4,5) and h.doc_no=j.acno and j.status=3 and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and (costcode!=0 or costcode is not null) ) a left join"
							+ " (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group  by tranid ) b on a.tranid=b.tranid "
							+ "where   round(coalesce(b.costtranamt,0),2)!=round(a.jvamt,2)";*/
					
					String sqlbranch="";
					if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
						sqlbranch+=" and j.brhid="+branch;
					}
					strSql="select j.acno 'AC NO',h.description 'ACCOUNT',j.doc_no 'DOC NO',a.dtype 'DOC TYPE',a.jvamt 'ACCOUNTED',"
					+ "coalesce(b.costtranamt,0) costtranamt 'COST ALLOCATED',coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference 'DIFFERENCE',a.tr_no 'TRNO' "
					+ "from ( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,"+
					" j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3 "+sqlbranch+" and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+
					" ) a left join (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group by tranid ) b on "+
					" a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)";
					 System.out.println("excel Load Sql://"+strSql);
					ResultSet resultSet = stmt.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					
					
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				stmt.close();
				conn.close();
			}
			// System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}


	public int InsertNew(String hidgridacno) throws SQLException{
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			System.out.println(hidgridacno);
			String gridacnoarray[]=hidgridacno.split(",");
			int acnoid=0,agmtno=0,cnoagmtno=0,invno=0,fleetno=0,srno=0,costentry=0,counter=0;
			String dtype="",agmttype="",cnoagmttype="";
			double cnoamount=0.0,temptimediff=0.0;;
			java.sql.Date fromdate=null,todate=null;
			ArrayList<String> costmovarray=new ArrayList<String>();
			ArrayList<String> tranarray=new ArrayList<String>();
			for(int i=0;i<gridacnoarray.length;i++){
				int acno=Integer.parseInt(gridacnoarray[i].split("::")[0]);
				int trno=Integer.parseInt(gridacnoarray[i].split("::")[1]);
				System.out.println(trno+"//////"+acno);
				acnoid=getIdno(acno,conn);
				ArrayList<String> costtypearray=new ArrayList<>();
				costtypearray=getAccountCostType(acno,conn);
				int gridcosttype=Integer.parseInt(costtypearray.get(0));
				int gridcostcode=Integer.parseInt(costtypearray.get(1));
				System.out.println("GridCostType: "+gridcosttype);
				System.out.println("GridCostCode: "+gridcostcode);
				Statement stmt=conn.createStatement();
				
				String strgetdtype="select dtype from my_jvtran where tr_no="+trno+" and acno="+acno;
				ResultSet rsdtype=stmt.executeQuery(strgetdtype);
				if(rsdtype.next()){
					dtype=rsdtype.getString("dtype");
				}
				String strgetinv="select doc_no from my_jvtran where dtype='INV' and tr_no="+trno+" and acno="+acno+" and status=3";
				ResultSet rsgetinv=stmt.executeQuery(strgetinv);
				while(rsgetinv.next()){
					invno=rsgetinv.getInt("doc_no");
				}
				if(acnoid==10){
					
					String strdamagefleet="select rfleet fleetno from gl_vinspm where invno="+invno+" and invtype='INV'";
					ResultSet rsdamagefleet=stmt.executeQuery(strdamagefleet);
					while(rsdamagefleet.next()){
						fleetno=rsdamagefleet.getInt("fleetno");
					}
				}
				else if(acnoid==14){
					String strsalikfleet="select fleetno from gl_salik where inv_no="+invno;
					ResultSet rssalikfleet=stmt.executeQuery(strsalikfleet);
					while(rssalikfleet.next()){
						fleetno=rssalikfleet.getInt("fleetno");
					}
				}
				else if(acnoid==15){
					String strsalikfleet="select fleetno from gl_traffic where inv_no="+invno;
					ResultSet rssalikfleet=stmt.executeQuery(strsalikfleet);
					while(rssalikfleet.next()){
						fleetno=rssalikfleet.getInt("fleetno");
					}
				}
				if(dtype.equalsIgnoreCase("CNO")){
					
					String strgetagmtno="select rdocno,rtype from my_jvtran where tr_no="+trno;
					String strgetamount="select dramount from my_jvtran jv inner join my_head head on (jv.acno =head.doc_no and head.gr_type in (4,5)) where jv.tr_no="+trno;
					ResultSet rsagmtno=stmt.executeQuery(strgetagmtno);
					while(rsagmtno.next()){
						cnoagmtno=rsagmtno.getInt("rdocno");
						cnoagmttype=rsagmtno.getString("rtype");
					}
					ResultSet rsgetamount=stmt.executeQuery(strgetamount);
					while(rsgetamount.next()){
						cnoamount=+rsgetamount.getDouble("dramount");
					}
				}
				if(dtype.equalsIgnoreCase("INV")||dtype.equalsIgnoreCase("INS")||dtype.equalsIgnoreCase("INT")|| dtype.equalsIgnoreCase("CNO")){
					String strgetdata="";
					if(dtype.equalsIgnoreCase("CNO")){
						strgetdata="select ratype,rano,fromdate,todate from gl_invm where tr_no=(select max(tr_no) from"+
								" (select tr_no,sum(invd.amount) amount from gl_invm inv inner join gl_invd invd on (inv.doc_no=invd.rdocno)where rano="+cnoagmtno+" and "+
								" ratype='"+cnoagmttype+"' and dtype='INV' group by inv.tr_no ) a where a.amount>="+cnoamount+")";
//						System.out.println(strgetdata);
					}
					else{
						strgetdata="select ratype,rano,fromdate,todate from gl_invm where tr_no="+trno;
					}
					ResultSet rsgetdata=stmt.executeQuery(strgetdata);
					while(rsgetdata.next()){
						agmttype=rsgetdata.getString("ratype");
						agmtno=rsgetdata.getInt("rano");
						fromdate=rsgetdata.getDate("fromdate");
						todate=rsgetdata.getDate("todate");
					}
					
				}
			
			
				String strdelete="delete from my_costtran where tr_no="+trno+" and acno="+acno;
				int deleteval=stmt.executeUpdate(strdelete);
				
				String strgettran="select tranid,acno,round(dramount,2) dramount,head.gr_type from my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in(4,5)) where jv.tr_no="+trno+" and jv.acno="+acno;
				ResultSet rsgettran=stmt.executeQuery(strgettran);
				while(rsgettran.next()){
					tranarray.add(rsgettran.getString("tranid")+"::"+rsgettran.getString("acno")+"::"+rsgettran.getString("dramount")+"::"+srno+1);
					System.out.println(rsgettran.getInt("gr_type")+"::"+rsgettran.getString("acno"));
				}
				if(deleteval>=0){
					
					if(gridcosttype==6){
						//getting details about number of fleets in which the cost is about to distribute 
						if(dtype.equalsIgnoreCase("INV") || dtype.equalsIgnoreCase("INS") || dtype.equalsIgnoreCase("INT") || dtype.equalsIgnoreCase("CNO")){
							if(acnoid==10){
								costmovarray=new ArrayList<>();
							}
							else if(acnoid==14){
								String strcostmov="select count(*) count,fleetno from gl_salik where inv_no="+invno+" group by fleetno";
								ResultSet rscostmov=stmt.executeQuery(strcostmov);
								counter=0;
								while(rscostmov.next()){
									temptimediff+=rscostmov.getDouble("count");
									costmovarray.add(rscostmov.getString("count")+""+"::"+rscostmov.getString("fleetno"));
									counter++;
								}
							}
							else if(acnoid==15){
								String strclient="select cldocno from gl_invm where doc_no="+invno;
								ResultSet rsclient=stmt.executeQuery(strclient);
								int cldocno=0;
								while(rsclient.next()){
									cldocno=rsclient.getInt("cldocno");
								}
								int srvcdefault=0;
								double trafficrate=0.0;
								String stracbook="select ser_default,per_trafficharge from my_acbook where cldocno='"+cldocno+"' and dtype='CRM' and status<>7";
								//System.out.println("Acbbok"+stracbook);
								ResultSet rsacbook=stmt.executeQuery(stracbook);
								while(rsacbook.next()){
									srvcdefault=rsacbook.getInt("ser_default");
									if(srvcdefault==0){
										trafficrate=rsacbook.getDouble("per_trafficharge");
									}
								}
								double traffic=0.0;
								int trafficmethod=0;
								double trafficapply=0.0;
								double trafficsrvc=0.0;
								double trafficsrvcper=0.0;
								double trafficpercalc=0.0;
								double finaltrafficsrvc=0.0,pertraffic=0.0;
								int trafficpermethod=0,trafficsrvmethod=0;
								double trafficamt=0.0,amttraffic=0.0;
								int trafficcount=0;
								if(srvcdefault==0){
									String strtraffic="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where inv_no="+invno;
//									System.out.println(strtraffic);
									ResultSet rstraffic=stmt.executeQuery(strtraffic);
									while(rstraffic.next()){
										trafficamt=rstraffic.getDouble("trafficamt");
										trafficcount=rstraffic.getInt("count");
									}	
								}
								
								if(srvcdefault==1){
									
									String strtrafficsrv="select method,value,field_nme from gl_config where field_nme in('trafficsrvapply','trafficsrvper','trafficsrv')";
									//String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
									ResultSet rstrafficsrvapply=stmt.executeQuery(strtrafficsrv);
									while(rstrafficsrvapply.next()){
										if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvapply")){
											trafficmethod=rstrafficsrvapply.getInt("method");
											trafficapply=rstrafficsrvapply.getDouble("value");	
										}
										if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvper")){
											trafficpermethod=rstrafficsrvapply.getInt("method");
											trafficsrvcper=rstrafficsrvapply.getDouble("value");
										}
										if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrv")){
											trafficsrvmethod=rstrafficsrvapply.getInt("method");
											trafficsrvc=rstrafficsrvapply.getDouble("value");
										}
										
									}		
									
									String strtrafficvalues="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count,fleetno  from gl_traffic where inv_no="+invno+" group by fleetno";
//									System.out.println(" Inside Srvc Default Traffic Query"+strtrafficvalues);
									ResultSet rstrafficvalues=stmt.executeQuery(strtrafficvalues);
									while(rstrafficvalues.next()){
										if(trafficrate>0.0)	{
											traffic=trafficrate*rstrafficvalues.getDouble("trafficamt");
											trafficcount=rstrafficvalues.getInt("count");
										}
										else {
												if(trafficpermethod==1){
													pertraffic=rstrafficvalues.getDouble("trafficamt")*(trafficsrvcper/100);
													trafficcount=rstrafficvalues.getInt("count");
												}
												else if(trafficpermethod==0){
													pertraffic=0;
													}
											
												if(trafficsrvmethod==1){
													amttraffic=trafficsrvc;
													trafficcount=rstrafficvalues.getInt("count");
												}
												else if(trafficsrvmethod==0){
													amttraffic=0;
												}
												if(trafficmethod==1){traffic=pertraffic;	}
												if(trafficmethod==0){traffic=amttraffic*trafficcount;	}
												if(trafficmethod==2){traffic=(trafficapply>=pertraffic)?trafficapply:pertraffic;	}
											}	
//										System.out.println("Traffic Method Check:"+trafficmethod);
										finaltrafficsrvc+=traffic;
										costmovarray.add(trafficcount+"::"+traffic);
										counter++;
										trafficamt+=rstrafficvalues.getDouble("trafficamt");
										//System.out.println("============"+finaltrafficsrvc);
									}
									}
								else{
									finaltrafficsrvc=trafficrate*trafficcount;
									costmovarray.add(trafficcount+"::"+trafficrate);
									counter++;
								}
							
								
							}
							else{
								String strcostmov="select round(sum(if(aa.hourdiff<0,aa.hourdiff*-1,aa.hourdiff)),2) hourdiff,aa.fleet_no from( select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno"+
										" from ( select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+"',' ',tout) as datetime),cast(concat(dout,' ',tout) as"+
										" datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" ',tout) as datetime),cast(coalesce(concat(din,' ',tin),"+
										" '"+todate+" ',tout) as datetime)) din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"'  and trancode<>'DL'  and"+
										" (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"')) kk)aa"+
										" group by aa.fleet_no";
								ResultSet rscostmov=stmt.executeQuery(strcostmov);
								counter=0;
								while(rscostmov.next()){
									temptimediff+=rscostmov.getDouble("hourdiff");
									costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
									counter++;
										
								}
								
							}
						
						if(costmovarray.size()==0){
							String getmov="select fleet_no from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"' and trancode<>'DL')";
							ResultSet rsmov=stmt.executeQuery(getmov);
							while(rsmov.next()){
								fleetno=rsmov.getInt("fleet_no");
							}
							if(acnoid==10){
								String strdamagefleet="select rfleet fleetno from gl_vinspm where invno="+invno+" and invtype='INV'";
								ResultSet rsdamagefleet=stmt.executeQuery(strdamagefleet);
								while(rsdamagefleet.next()){
									fleetno=rsdamagefleet.getInt("fleetno");
								}								
							}
							int y=0;
							for(int k=0;k<tranarray.size();k++){
								String strcostentry="select costentry from gl_invmode where acno="+tranarray.get(k).split("::")[1];
								ResultSet rscost=stmt.executeQuery(strcostentry);
								while(rscost.next()){
									costentry=rscost.getInt("costentry");
								}
								if(costentry==1){
									y++;
									String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(k).split("::")[1]+"'"+
											",6,"+tranarray.get(k).split("::")[2]+","+y+","+tranarray.get(k).split("::")[0]+",0,"+fleetno+","+trno+")";
									Statement costinsert=conn.createStatement();
									System.out.println("Insert Single Cost Insert");
									int costval=costinsert.executeUpdate(strcostinsert);
									if(costval<=0){
//										System.out.println("Cost Insert Error-Single Fleet Rare Case");
										return 0;
									}
									
									else{
										String strupdatejvcost="update my_jvtran set costtype=6,costcode="+fleetno+" where tranid="+tranarray.get(k).split("::")[0];
										int updatejvcost=costinsert.executeUpdate(strupdatejvcost);
										if(updatejvcost<0){
											return 0;
										}
									}
								}
							}
						}
						
						for(int j=0,y=0;j<costmovarray.size();j++){
							
							//Getting costentry from gl_invmode corresponding to account-costentry-1 means insert otherwise not
							//System.out.println("======="+j);
							String strcostentry="select costentry from gl_invmode where acno="+acno;
							ResultSet rscost=stmt.executeQuery(strcostentry);
							while(rscost.next()){
								costentry=rscost.getInt("costentry");
							}
							//System.out.println("CostEntry: "+costentry);
							System.out.println("Counter: "+counter);
							if(costentry==1){
							if(counter==1){
								
							String costmov=costmovarray.get(j);
							String costmovamt=costmov.split("::")[0];
							String costmovfleet=costmov.split("::")[1];
							//Insert into costtran when there is only one fleet
						
							for(int c=0;c<tranarray.size();c++){
								y++;
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(c).split("::")[1]+"'"+
										",6,"+tranarray.get(c).split("::")[2]+","+y+","+tranarray.get(c).split("::")[0]+",0,"+costmovfleet+","+trno+")";
		
							
							System.out.println("Single Fleet Insert Costtran Sql:"+strcostinsert);
							int costinsertval=stmt.executeUpdate(strcostinsert);
							if(costinsertval<0){
								//conn.close();
//								System.out.println("Cost Insert Error");
								return 0;
							}
							else{
								String strupdatejvcost="update my_jvtran set costtype=6,costcode="+costmovfleet+" where tranid="+tranarray.get(c).split("::")[0];
								int updatejvcost=stmt.executeUpdate(strupdatejvcost);
								if(updatejvcost<0){
									return 0;
								}
							}
							}//Closing of tranarray
							}
							else if(counter>1){
								//Insert into costtran when there are multiple fleets
								String costmov=costmovarray.get(j);
								String costmovamt=costmov.split("::")[0];//hourdiff=amt
								
								String costmovfleet=costmov.split("::")[1];
								
								for(int c=0;c<tranarray.size();c++){
									double amt=(Double.parseDouble(costmovamt)/temptimediff)*Double.parseDouble(tranarray.get(c).split("::")[2]);
									/*ResultSet rstemp=stmtgetdata.executeQuery("select round("+amt+",2) amt");
									if(rstemp.next()){
										amt=rstemp.getDouble("amt");
									}*/
									
									y++;
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(c).split("::")[1]+"'"+
										",6,"+amt+","+y+","+tranarray.get(c).split("::")[0]+",0,"+costmovfleet+","+trno+")";
								System.out.println("Multi Fleet Insert Costtran Sql:"+strcostinsert);
								
								int costinsertval=stmt.executeUpdate(strcostinsert);
								if(costinsertval<0){
									//conn.close();
									System.out.println("Cost Insert Error2");
									return 0;
								}
								else{
									String strupdatejvcost="update my_jvtran set costtype=7,costcode=9999 where tranid="+tranarray.get(c).split("::")[0];
									int updatejvcost=stmt.executeUpdate(strupdatejvcost);
									if(updatejvcost<0){
										return 0;
									}
								}
								}

							}
						
						}
					
							
						}//Closing of Costmov loop
						
						}
					}
						else{
							//Get fleet_no from my_jvtran
							int costcode=0;
							int costtype=0;
							System.out.println("inside else");
							String strgetfleet="select costcode,costtype from my_jvtran where tr_no="+trno;
							ResultSet rsgetfleet=stmt.executeQuery(strgetfleet);
							while(rsgetfleet.next()){
								costcode=rsgetfleet.getInt("costcode");
								costtype=rsgetfleet.getInt("costtype");
							}
							int temp=1;
							for(int a=0;a<tranarray.size();a++){
								//inserts data to my_costtran corresponding maintenance accounts
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(a).split("::")[1]+"'"+
										","+gridcosttype+","+tranarray.get(a).split("::")[2]+","+temp+","+tranarray.get(a).split("::")[0]+",0,"+gridcostcode+","+trno+")";
								System.out.println("Insert MRU Costtran Sql:"+strcostinsert);
								temp++;
								Statement stmtins=conn.createStatement();
								int costinsertval=stmtins.executeUpdate(strcostinsert);
								if(costinsertval<=0){
									//conn.close(); 
									System.out.println("Cost Insert Error");
									return 0;
								}
	
								else{
									String strupdatejvcost="update my_jvtran set costtype="+costtype+",costcode="+costcode+" where tranid="+tranarray.get(a).split("::")[0];
									int updatejvcost=stmtins.executeUpdate(strupdatejvcost);
									if(updatejvcost<0){
										return 0;
									}
								}								
								
							}
								
						}
			
		}
				tranarray=new ArrayList<>();
				costmovarray=new ArrayList<>();
				temptimediff=0.0;
				counter=0;
				
			}
			conn.commit();
			return 1;
			
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return 0;
	}
	public int insert(String hidtrno, String hidgridacno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			
			String trno[]= hidtrno.split(",");
			String gridacnoarray[]=hidgridacno.split(",");
			//System.out.println("===trno==="+trno.length);
			java.sql.Date fromdate=null,todate=null;
			int agmtno=0;
			String agmttype="";
			int srno=0;
			int z=0;
			int costentry=0;
			double temptimediff=0.0;
			String dtype="";
			String strgetfleet="";
			int mrufleet=0;
			int gridacno=0;
			int grididno=0;
			//System.out.println("==== "+hidtrno);
			ArrayList<String> costmovarray=new ArrayList<String>();
			ArrayList<String> tranarray=new ArrayList<String>();
			ArrayList<String> vsiarray=new ArrayList<>();
			ArrayList<String> otherarray=new ArrayList<>();
			
			for(int i=0;i<trno.length;i++){
				System.out.println("==== "+trno[i]);
				//System.out.println("Inside");
				conn.setAutoCommit(false);
				Statement stmtdelete=conn.createStatement();
				Statement stmtgetdata=conn.createStatement();
				Statement stmtmruinsert=conn.createStatement();
				gridacno=Integer.parseInt(gridacnoarray[i]);
				grididno=getIdno(gridacno,conn);
				//Getting dtype of corresponding tr_no
				ArrayList<String> costtypearray=new ArrayList<>();
				costtypearray=getAccountCostType(Integer.parseInt(gridacnoarray[i]),conn);
				int gridcosttype=Integer.parseInt(costtypearray.get(0));
				int gridcostcode=Integer.parseInt(costtypearray.get(1));
				
				String strgetdtype="select dtype from my_jvtran where tr_no="+trno[i];
				ResultSet rsdtype=stmtgetdata.executeQuery(strgetdtype);
				if(rsdtype.next()){
					dtype=rsdtype.getString("dtype");
				}
				//System.out.println(dtype);
				//Getting agreement type,agreementno,fromdate,todate in case of invoice,salik,traffic,Credit Note
				int cnoagmtno=0;
				String cnoagmttype="";
				double cnoamount=0.0;
				if(dtype.equalsIgnoreCase("CNO")){
					
					String strgetagmtno="select rdocno,rtype from my_jvtran where tr_no="+trno[i];
					String strgetamount="select dramount from my_jvtran jv inner join my_head head on (jv.acno =head.doc_no and head.gr_type in (4,5)) where jv.tr_no="+trno[i];
					ResultSet rsagmtno=stmtgetdata.executeQuery(strgetagmtno);
					while(rsagmtno.next()){
						cnoagmtno=rsagmtno.getInt("rdocno");
						cnoagmttype=rsagmtno.getString("rtype");
					}
					ResultSet rsgetamount=stmtgetdata.executeQuery(strgetamount);
					while(rsgetamount.next()){
						cnoamount=+rsgetamount.getDouble("dramount");
					}
				}
				if(dtype.equalsIgnoreCase("INV")||dtype.equalsIgnoreCase("INS")||dtype.equalsIgnoreCase("INT")|| dtype.equalsIgnoreCase("CNO")){
					String strgetdata="";
					if(dtype.equalsIgnoreCase("CNO")){
						strgetdata="select ratype,rano,fromdate,todate from gl_invm where tr_no=(select max(tr_no) from"+
								" (select tr_no,sum(invd.amount) amount from gl_invm inv inner join gl_invd invd on (inv.doc_no=invd.rdocno)where rano="+cnoagmtno+" and "+
								" ratype='"+cnoagmttype+"' and dtype='INV' group by inv.tr_no ) a where a.amount>="+cnoamount+")";
//						System.out.println(strgetdata);
					}
					else{
						strgetdata="select ratype,rano,fromdate,todate from gl_invm where tr_no="+trno[i];
					}
					ResultSet rsgetdata=stmtgetdata.executeQuery(strgetdata);
					while(rsgetdata.next()){
						agmttype=rsgetdata.getString("ratype");
						agmtno=rsgetdata.getInt("rano");
						fromdate=rsgetdata.getDate("fromdate");
						todate=rsgetdata.getDate("todate");
					}
					
				}
				
				
				
				//Getting tranid and account of corresponding tr_no
				z=0;
				
				String strgettran="select tranid,acno,round(dramount,2) dramount,head.gr_type from my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in(4,5)) where jv.tr_no="+trno[i];
				Statement stmttran=conn.createStatement();
				ResultSet rsgettran=stmttran.executeQuery(strgettran);
				while(rsgettran.next()){
					tranarray.add(rsgettran.getString("tranid")+"::"+rsgettran.getString("acno")+"::"+rsgettran.getString("dramount")+"::"+srno+1);
					System.out.println(rsgettran.getInt("gr_type")+"::"+rsgettran.getString("acno"));
				}
				
				//Deleting costtran entries
				
				String strdelete="delete from my_costtran where tr_no="+trno[i];
				int deleteval=stmtdelete.executeUpdate(strdelete);
				
				if(deleteval>=0){
					
					if(gridcosttype==6){
						//getting details about number of fleets in which the cost is about to distribute 
						if(dtype.equalsIgnoreCase("INV") || dtype.equalsIgnoreCase("INS") || dtype.equalsIgnoreCase("INT") || dtype.equalsIgnoreCase("CNO")){
							
						String strcostmov="select round(sum(if(aa.hourdiff<0,aa.hourdiff*-1,aa.hourdiff)),2) hourdiff,aa.fleet_no from( select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno"+
								" from ( select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+"',' ',tout) as datetime),cast(concat(dout,' ',tout) as"+
								" datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" ',tout) as datetime),cast(coalesce(concat(din,' ',tin),"+
								" '"+todate+" ',tout) as datetime)) din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"'  and trancode<>'DL'  and"+
								" (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"')) kk)aa"+
								" group by aa.fleet_no";
						System.out.println(strcostmov);
						Statement stmtcostmov=conn.createStatement();
						ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
						int counter=0;
						while(rscostmov.next()){
							temptimediff+=rscostmov.getDouble("hourdiff");
								costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
								counter++;
								//System.out.println(costmovarray.get(counter));
								//System.out.println("counter: "+counter);
//								System.out.println(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
						}
						Statement stmtcostinsert=conn.createStatement();
						//System.out.println("Chekc cost size: "+costmovarray.size());
						
						
						if(costmovarray.size()==0){
							int fleetno=0;
							String getmov="select fleet_no from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"' and trancode<>'DL')";
							Statement stmtmov=conn.createStatement();
							ResultSet rsmov=stmtmov.executeQuery(getmov);
							while(rsmov.next()){
								fleetno=rsmov.getInt("fleet_no");
							}
							int y=0;
							for(int k=0;k<tranarray.size();k++){
								String strcostentry="select costentry from gl_invmode where acno="+tranarray.get(k).split("::")[1];
								ResultSet rscost=stmtgetdata.executeQuery(strcostentry);
								while(rscost.next()){
									costentry=rscost.getInt("costentry");
								}
								if(costentry==1){
									y++;
									String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(k).split("::")[1]+"'"+
											",6,"+tranarray.get(k).split("::")[2]+","+y+","+tranarray.get(k).split("::")[0]+",0,"+fleetno+","+trno[i]+")";
									Statement costinsert=conn.createStatement();
									int costval=costinsert.executeUpdate(strcostinsert);
									if(costval<=0){
										System.out.println("Cost Insert Error-Single Fleet Case");
										return 0;
									}
									
								}
							}
						}
						
						for(int j=0,y=0;j<costmovarray.size();j++){
							
							//Getting costentry from gl_invmode corresponding to account-costentry-1 means insert otherwise not
							//System.out.println("======="+j);
							String strcostentry="select costentry from gl_invmode where acno="+tranarray.get(z).split("::")[1];
							ResultSet rscost=stmtgetdata.executeQuery(strcostentry);
							while(rscost.next()){
								costentry=rscost.getInt("costentry");
							}
							//System.out.println("CostEntry: "+costentry);
							if(costentry==1){
							if(counter==1){
								
							String costmov=costmovarray.get(j);
							String costmovamt=costmov.split("::")[0];
							String costmovfleet=costmov.split("::")[1];
							//Insert into costtran when there is only one fleet
						
							for(int c=0;c<tranarray.size();c++){
								y++;
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(c).split("::")[1]+"'"+
										",6,"+tranarray.get(c).split("::")[2]+","+y+","+tranarray.get(c).split("::")[0]+",0,"+costmovfleet+","+trno[i]+")";
		
							
//							System.out.println("Single Fleet Insert Costtran Sql:"+strcostinsert);
							int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
							if(costinsertval<0){
								//conn.close();
								System.out.println("Cost Insert Error");
								return 0;
							}
							}//Closing of tranarray
							}
							else if(counter>1){
								//Insert into costtran when there are multiple fleets
								String costmov=costmovarray.get(j);
								String costmovamt=costmov.split("::")[0];//hourdiff=amt
								
								String costmovfleet=costmov.split("::")[1];
								
								for(int c=0;c<tranarray.size();c++){
									double amt=(Double.parseDouble(costmovamt)/temptimediff)*Double.parseDouble(tranarray.get(c).split("::")[2]);
									/*ResultSet rstemp=stmtgetdata.executeQuery("select round("+amt+",2) amt");
									if(rstemp.next()){
										amt=rstemp.getDouble("amt");
									}*/
									
									y++;
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(c).split("::")[1]+"'"+
										",6,"+amt+","+y+","+tranarray.get(c).split("::")[0]+",0,"+costmovfleet+","+trno[i]+")";
//								System.out.println("Multi Fleet Insert Costtran Sql:"+strcostinsert);
								
								int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
								if(costinsertval<0){
									//conn.close();
									System.out.println("Cost Insert Error2");
									return 0;
								}
								}

							}
						
						}
					
							
						}//Closing of Costmov loop
						
						}
						else{
							//Get fleet_no from my_jvtran
							int costcode=0;
							int costtype=0;
							System.out.println("inside else");
							strgetfleet="select costcode,costtype from my_jvtran where tr_no="+trno[i];
							ResultSet rsgetfleet=stmtgetdata.executeQuery(strgetfleet);
							while(rsgetfleet.next()){
								costcode=rsgetfleet.getInt("costcode");
								costtype=rsgetfleet.getInt("costtype");
							}
							int temp=1;
							for(int a=0;a<tranarray.size();a++){
								//inserts data to my_costtran corresponding maintenance accounts
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+tranarray.get(a).split("::")[1]+"'"+
										","+costtype+","+tranarray.get(a).split("::")[2]+","+temp+","+tranarray.get(a).split("::")[0]+",0,"+costcode+","+trno[i]+")";
								System.out.println("Insert MRU Costtran Sql:"+strcostinsert);
								temp++;
								Statement stmtins=conn.createStatement();
								int costinsertval=stmtins.executeUpdate(strcostinsert);
								if(costinsertval<=0){
									//conn.close(); 
									System.out.println("Cost Insert Error");
									return 0;
								}	
								
							}
								
						}
											
					}
					else{
						System.out.println("Inside Else Costran");
						for(int k=0;k<tranarray.size();k++){
							String strcostentry="select costentry from gl_invmode where acno="+tranarray.get(k).split("::")[1];
							ResultSet rscost=stmtgetdata.executeQuery(strcostentry);
							while(rscost.next()){
								costentry=rscost.getInt("costentry");
							}
							if(costentry==1){
								int sr=0;
								String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+
								" '"+tranarray.get(k).split("::")[1]+"',"+gridcosttype+","+tranarray.get(k).split("::")[2]+","+(sr+1)+","+tranarray.get(k).split("::")[0]+",0,"+gridcostcode+","+trno[i]+")";
								Statement costinsert=conn.createStatement();
								int costval=costinsert.executeUpdate(strcostinsert);
								if(costval<=0){
									System.out.println("Cost Insert Error-Single Fleet Case");
									return 0;
								}
							}
						}	
					}
	
				}
			vsiarray=new ArrayList<>();
			tranarray=new ArrayList<>();
			costmovarray=new ArrayList<>();
			otherarray=new ArrayList<>();
			temptimediff=0.0;
			conn.commit();
			}
			
			conn.close();
			return 1;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		System.out.println("End of Code");
		return 0;
	}
	
	
	private int getIdno(int gridacno, Connection conn) {
		// TODO Auto-generated method stub
		int idno=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select idno from gl_invmode where status=1 and acno="+gridacno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				idno=rs.getInt("idno");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return idno;
	}

	private ArrayList<String> getAccountCostType(int gridacno, Connection conn) {
		// TODO Auto-generated method stub
		ArrayList<String> costtypearray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select costtype,costcode from gl_invmode where acno="+gridacno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				costtypearray.add(rs.getString("costtype"));
				costtypearray.add(rs.getString("costcode"));
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return costtypearray;
	}

	public JSONArray getMissingData(String branch,String fromdate,String todate,String id) throws SQLException{
		
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}   
	    Connection  conn = null;
		java.sql.Date sqlfromdate=null,sqltodate=null;
           try {
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			
			conn=ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				/*String strsql="select jv.tr_no,head.doc_no acno,head.description,jv.doc_no,jv.dtype,jv.dramount from my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in (4,5)) "+
				" where (jv.costcode=0 or jv.costcode is null) and jv.date between '"+sqlfromdate+"' and '"+sqltodate+"' and jv.status=3";*/
				String sqlbranch="";
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and j.brhid="+branch;
				}
				/*String strsql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt dramount,coalesce(b.costtranamt,0) costtranamt,"+
						" coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,"+
						" j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3  "+sqlbranch+" and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+
						" and (j.dtype not in ('INV','INS','INT') or (j.dtype='CNO' and coalesce(j.rdocno,0)=0))) a left join (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group by tranid ) b on "+
						" a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)";*/
				String strsql="select a.tranid,a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt dramount,coalesce(b.costtranamt,0) costtranamt, "
						+ " coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ( select h.description,j.acno,j.doc_no, j.tr_no, "
						+ " tranid,dramount jvamt, j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3   "+sqlbranch 
						+ "  and j.date between  '"+sqlfromdate+"' and  '"+sqltodate+"'   ) a left join (select sum(amount) costtranamt,acno,tr_no,tranid "
						+ " from my_costtran cost group by tranid ) b on  a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)" ;
				System.out.println(strsql);
				ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			System.out.println("Connection Closed");
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
public JSONArray getMissingDataExcel(String branch,String fromdate,String todate,String id) throws SQLException{
		
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}   
	    Connection  conn = null;
		java.sql.Date sqlfromdate=null,sqltodate=null;
           try {
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			
			conn=ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				/*String strsql="select jv.tr_no,head.doc_no acno,head.description,jv.doc_no,jv.dtype,jv.dramount from my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in (4,5)) "+
				" where (jv.costcode=0 or jv.costcode is null) and jv.date between '"+sqlfromdate+"' and '"+sqltodate+"' and jv.status=3";*/
				String sqlbranch="";
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and j.brhid="+branch;
				}
				/*String strsql="select a.tr_no,a.doc_no,a.acno,a.description,a.dtype,a.jvamt dramount,coalesce(b.costtranamt,0) costtranamt,"+
						" coalesce(coalesce(a.jvamt,0)-coalesce(b.costtranamt,0),0) difference from ( select h.description,j.acno,j.doc_no, j.tr_no, tranid,dramount jvamt,"+
						" j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3  "+sqlbranch+" and j.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+
						" and (j.dtype not in ('INV','INS','INT') or (j.dtype='CNO' and coalesce(j.rdocno,0)=0))) a left join (select sum(amount) costtranamt,acno,tr_no,tranid from my_costtran cost group by tranid ) b on "+
						" a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)";*/
				String strsql="select a.acno 'ACNO',a.description 'ACCOUNT',a.doc_no 'DOC NO',a.dtype 'DOC TYPE',a.jvamt 'AMOUNT' "
						+ " from ( select h.description,j.acno,j.doc_no, j.tr_no, "
						+ " tranid,dramount jvamt, j.dtype from my_head h , my_jvtran j where gr_type in (4,5) and h.doc_no=j.acno and j.status=3   "+sqlbranch 
						+ "  and j.date between  '"+sqlfromdate+"' and  '"+sqltodate+"'   ) a left join (select sum(amount) costtranamt,acno,tr_no,tranid "
						+ " from my_costtran cost group by tranid ) b on  a.tranid=b.tranid where round(coalesce(b.costtranamt,0),0)!=round(a.jvamt,0)" ;
				System.out.println(strsql);
				ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			System.out.println("Connection Closed");
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public JSONArray costCodeDetailsSearch(String type, String costcode, String regno, String costcodename, String check) throws SQLException {
	     JSONArray RESULTDATA=new JSONArray();
	     Connection conn = null;
	   
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtCostLedger = conn.createStatement ();
	   
	    if(check.equalsIgnoreCase("1")) {
			
        	if(type.equalsIgnoreCase("1")) {
        		
        		String sql1="";
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and c1.costcode like '%"+costcode+"%'";
		        }
        		
        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
		            sql1=sql1+" and c1.description like '%"+costcodename+"%'";
		        }
        		
        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0"+sql1+"";
        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
        		stmtCostLedger.close();
				conn.close();
        	
        	} else if(type.equalsIgnoreCase("6")) {
        		
        		String sql1="";
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and fleet_no like '%"+costcode+"%'";
		        }
        		
        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
		            sql1=sql1+" and reg_no like '%"+regno+"%'";
		        }
        		
        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
		            sql1=sql1+" and flname like '%"+costcodename+"%'";
		        }
        		
        		String sql="select fleet_no doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0"+sql1+"";
        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
        		stmtCostLedger.close();
				conn.close();
        	
        	} else {
        		
        		if(!(type.equalsIgnoreCase("0")) && !(type.equalsIgnoreCase(""))){
        			
        		String sqls="select costgroup from my_costunit where status=1 and CostType="+type+"";
				ResultSet resultSets = stmtCostLedger.executeQuery(sqls);
			    
				String costgroup="";
				while (resultSets.next()) {
					costgroup=resultSets.getString("costgroup");
				}
				 
				if(costgroup.equalsIgnoreCase("AMC") || costgroup.equalsIgnoreCase("SJOB")) {
					
					String sql1="";
					
					if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and c.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
			        }
	        		
	        		System.out.println("costcodename ="+costcodename);
	        		
					String sql="select c.tr_no doc_no,c.doc_no code,a.refname name from cm_srvcontrm c left join my_acbook a on (c.cldocno=a.doc_no and a.dtype='CRM') " 
							+ "where c.status=3 and a.status=3 and c.dtype='"+costgroup+"'"+sql1+"";
					System.out.println("SQL ="+sql);
					ResultSet resultSet = stmtCostLedger.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtCostLedger.close();
					conn.close();
					
				} else if(costgroup.equalsIgnoreCase("Ticket No") || costgroup.equalsIgnoreCase("CREG")) {
					
					String sql1="";costgroup="CREG";
					
					if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and c.doc_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select c.tr_no doc_no,c.doc_no code,a.refname name from cm_srvcontrm c left join my_acbook a on (c.cldocno=a.doc_no and a.dtype='CRM') " 
							+ "where c.status=3 and a.status=3 and c.dtype='"+costgroup+"'"+sql1+"";
					ResultSet resultSet = stmtCostLedger.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtCostLedger.close();
					conn.close();
				}
        	  }
        	}
		}
	  } catch(Exception e){
	   e.printStackTrace();
	  } finally{
	   conn.close();
	   System.out.println("Connection Closed");
	  }
	     return RESULTDATA;
	 }

	public int updateMissing(String missingtrno, String cmbcosttype,String hidcostcode) throws SQLException {
		// TODO Auto-generated method stub
		
		Connection conn=null;		
		try{
			System.out.println("Inside DAO");
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			
			String trnoarray[]=missingtrno.split(",");
			System.out.println(trnoarray.length);
			for(int i=0;i<trnoarray.length;i++){
				int tranid=Integer.parseInt(trnoarray[i].split("::")[0]);
				//int acno=Integer.parseInt(trnoarray[i].split("::")[1]);
				int srno=0;
				System.out.println(tranid+"////////");
				ArrayList<String> tranarray=new ArrayList<>();
				String strdelete="delete from my_costtran where tranid="+tranid;
				int deleteval=stmt.executeUpdate(strdelete);
				
				String strgettran="select tranid,acno,round(dramount,2) dramount,head.gr_type,jv.tr_no from my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in(4,5)) where jv.tranid="+tranid;
				ResultSet rsgettran=stmt.executeQuery(strgettran);
				while(rsgettran.next()){
					tranarray.add(rsgettran.getString("tranid")+"::"+rsgettran.getString("acno")+"::"+rsgettran.getString("dramount")+"::"+srno+1+"::"+rsgettran.getString("tr_no"));
					System.out.println(rsgettran.getInt("gr_type")+"::"+rsgettran.getString("acno"));
				}

				String strsql="update my_jvtran set costcode="+hidcostcode+",costtype="+cmbcosttype+" where tranid="+tranid ;
				System.out.println("jvtran ==== "+strsql);
				int updateval=stmt.executeUpdate(strsql);
				if(updateval<0){
					errorstatus=1;
					return 0;
				}
				else{
					for(int j=0;j<tranarray.size();j++){
						/*int costentry=0;
						String strcostentry="select costentry from gl_invmode where acno="+tranarray.get(j).split("::")[1];
						ResultSet rscost=stmt.executeQuery(strcostentry);
						while(rscost.next()){
							costentry=rscost.getInt("costentry");
						}
						if(costentry==1){*/
							int sr=0;
							String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+
							" '"+tranarray.get(j).split("::")[1]+"',"+cmbcosttype+","+tranarray.get(j).split("::")[2]+","+(sr+1)+","+tranarray.get(j).split("::")[0]+",0,"+hidcostcode+","+tranarray.get(j).split("::")[4]+")";
							System.out.println("=cost tran === "+strcostinsert);
							Statement costinsert=conn.createStatement();
							int costval=costinsert.executeUpdate(strcostinsert);
							if(costval<=0){
								System.out.println("Cost Insert Error-Single Fleet Case");
								errorstatus=1;
								return 0;
							}
						/*}*/
					}
				}
			
			}
			if(errorstatus!=1){
				conn.commit();
				return 1;
				
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
			System.out.println("Connection Closed");
			
		}
		return 0;
	}
	
	
}
