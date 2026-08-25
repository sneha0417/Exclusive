
 
<%@page import="java.util.ArrayList"%>
  <%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	


	 
	
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
			String branchid = request.getParameter("cmbbranch")==null?"0":request.getParameter("cmbbranch").trim();
		String sqlsss1="";	
   	if(!((branchid.equalsIgnoreCase("a")) || (branchid.equalsIgnoreCase("NA")) || (branchid.equalsIgnoreCase("0")))){
	    		
 
	    		
	    		sqlsss1= " and i.brhid='"+branchid+"'";
	 		}
			
		 ClsConnection ClsConnection=new ClsConnection();
 	 conn = ClsConnection.getMyConnection();
 	 conn.setAutoCommit(false);
 	 
 	 
 	 
 	 
 	 
 	 
 	 
	Statement stmt = conn.createStatement ();
	int acnos=0;
	String curris="1";
	double rates=1;



	String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
	 System.out.println("-----4--sql2----"+sql2) ;

	ResultSet tass1 = stmt.executeQuery (sql2);

	if (tass1.next()) {

		acnos=tass1.getInt("acno");		

	}


	int acnos2=0;
	String curris2="1";
	double rates2=1;



	String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
	 System.out.println("-----4--sql22----"+sql22) ;

	ResultSet tass12 = stmt.executeQuery (sql22);

	if (tass12.next()) {

		acnos2=tass12.getInt("acno");		

	}


	 

	
		Statement stmt1 = conn.createStatement ();
		Statement stmt2 = conn.createStatement ();
 
		
		String sqls=" select a.tr_no,sum(totalcost) totalcost,dtype from(  "
				+ "   select o.psrno,o.dtype,o.tr_no,o.qty qty, o.qty*i.cost_price totalcost from my_prddin i "
				+ "   left join  my_prddout o on o.stockid=i.stockid "
				+ "  	 where  i.cost_price!=0 and  o.cost_price=0 "+sqlsss1+"  group by o.doc_no) a group  by a.tr_no ";
		
		
		 System.out.println("---first--"+sqls) ;
		
		ResultSet rss=stmt2.executeQuery(sqls);
		
		 while(rss.next())
		 {
			 System.out.println("---while--") ;
						double totalcost=rss.getDouble("totalcost");
						int trmo=rss.getInt("tr_no");
						
						System.out.println("trmo==="+trmo);
						
						 System.out.println("---dtype--"+rss.getString("dtype")) ;	
						 
			 if(rss.getString("dtype").equalsIgnoreCase("INV"))
			 {
				 System.out.println("----if----") ;
				
				 
				 java.sql.Date date=null;
				   String sqlsdate="select date from my_jvtran where tr_no="+trmo+" limit 1 ";
				   ResultSet rd=stmt1.executeQuery(sqlsdate);
				   if(rd.first())
				  {
					 date=rd.getDate("date");
				   }
			      String sqlup="update my_prddout o inner join my_prddin i on i.stockid=o.stockid and o.cost_price=0 and i.cost_price!=0  and o.dtype='INV'   "
		           		  + " set o.cost_price=i.cost_price where    i.stockid=o.stockid and o.cost_price=0  and o.tr_no="+trmo+"  and o.dtype='INV'  ";
					 
			        val=stmt1.executeUpdate(sqlup);
			      
			      
			      if(val<=0)
			      {
			    	  break;
			      }
				 
			      
			     for (int i=0;i<=2;i++)
				   {
					 if(i==0)
					 {
							Statement s5 = conn.createStatement ();
							String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
							 System.out.println("-----5--sqls3----"+sqls3) ;
							ResultSet tass34 = s5.executeQuery (sqls3);
		
							if (tass34.next()) {
		
								curris=tass34.getString("curid");	
		
		
							}
							 
		                 
						 
						 String currencytype1="";
						 Statement s6 = conn.createStatement ();
							String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
							 System.out.println("-----6--sqlveh----"+sqlveh) ;
							ResultSet resultSet440 = s6.executeQuery(sqlveh);
		
							while (resultSet440.next()) {
								rates=resultSet440.getDouble("rate");
								currencytype1=resultSet440.getString("type");
							} 
		
							double pricetottal=totalcost*-1;
							double ldramounts=0 ;     
							if(currencytype1.equalsIgnoreCase("D"))
							{
		
								ldramounts=pricetottal/rates ;  
							}
		
							else
							{
								ldramounts=pricetottal*rates ;  
							}
							String sql11=" insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS) "
									+" (select date,ref_detail,doc_no,"+acnos+",description,"+curris+","+rates+","+pricetottal+","+ldramounts+",out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS from my_jvtran where id=-1 and tr_no="+trmo+" limit 1) ";
						 
							 System.out.println("----Inv Jv--1--"+sql11) ;
						 
							  val=stmt.executeUpdate(sql11);
							 
							 
							    
						      if(val<=0)
						      {
						    	  break;
						      }
							 
			      }
				 else if(i==1)
				 {
						//=======5	
				

 					Statement s7 = conn.createStatement ();
					String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
					 System.out.println("-----5--sqls32----"+sqls32) ;
					ResultSet tass312 = s7.executeQuery (sqls32);

					if (tass312.next()) {

						curris2=tass312.getString("curid");	


					}
					String currencytype12="";
					Statement s8 = conn.createStatement ();
					String sqlvh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
					 System.out.println("-----6--sqlvh12----"+sqlvh12) ;
					ResultSet resultSet442 = s8.executeQuery(sqlvh12);

					while (resultSet442.next()) {
						rates2=resultSet442.getDouble("rate");
						currencytype12=resultSet442.getString("type");
					} 

					double pricetottal2=totalcost;
					double ldramounts2=0 ;     
					if(currencytype12.equalsIgnoreCase("D"))
					{

						ldramounts2=pricetottal2/rates2 ;  
					}

					else
					{
						ldramounts2=pricetottal2*rates2 ;  
					}

				 
				 
				 
					String sql112=" insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS) "
							+" (select date,ref_detail,doc_no,"+acnos2+",description,"+curris2+","+rates2+","+pricetottal2+","+ldramounts2+",out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS from my_jvtran where id=1 and tr_no="+trmo+" limit 1) ";
					 System.out.println("----Inv Jv 2----"+sql112) ;
						
					 val=stmt.executeUpdate(sql112);
					
					 if(val<=0)
				      {
				    	  break;
				      }
					 
			  }
			 
			 
		    }
					
				 
			 }
			 else if(rss.getString("dtype").equalsIgnoreCase("GIS"))
			 {
				 
				 System.out.println("----else----") ;
				 
				 
				 String sqlup1="update my_prddout o inner join my_prddin i on i.stockid=o.stockid and o.cost_price=0 and i.cost_price!=0  and o.dtype='GIS'   "
		           		  + " set o.cost_price=i.cost_price where    i.stockid=o.stockid and o.cost_price=0  and o.tr_no="+trmo+"  and o.dtype='GIS'  ";
				 

				 stmt1.executeUpdate(sqlup1);
				 String sqlup11="update my_gisd d inner join my_prddout o on o.stockid=o.stockid and  o.psrno=d.psrno and o.tr_no=d.tr_no and o.cost_price=0   and o.dtype='GIS'   "
		           		  + " set d.cost_price=o.cost_price,d.totalcost_price=(o.cost_price*d.qty)  where   o.stockid=o.stockid and  o.psrno=d.psrno and o.tr_no=d.tr_no and o.cost_price=0   and o.dtype='GIS'  and o.tr_no="+trmo+"  and o.dtype='GIS'  ";
				 

				 stmt1.executeUpdate(sqlup11);
					 java.sql.Date date=null;
		 
					 int vocno=0;
					 int docno=0;
					 int brhid=0;
					 int issuetype=0;
					 int costtype=0;
					 int costdocno=0;
					 Statement s9 = conn.createStatement ();
				 String sqlselect ="select m.doc_no,voc_no,m.date,m.brhid,issuetype,m.costtype,c.doc_no costdocno from my_gism  m left join cm_srvcontrm c on m.costdocno=c.tr_no and m.costtype=c.costtype where m.tr_no="+trmo+" ";
				 ResultSet rdsa=s9.executeQuery(sqlselect);
				   if(rdsa.first())
				  {
					 date=rdsa.getDate("date");
					 vocno=rdsa.getInt("voc_no");
					 docno=rdsa.getInt("doc_no");
					 brhid=rdsa.getInt("brhid");
					 issuetype=rdsa.getInt("issuetype");
					 costtype=rdsa.getInt("costtype");
					 costdocno=rdsa.getInt("costdocno");
				   }
				 
					 
					String vendorcur="1"; 
					double venrate=1;
					
			         int accounts=0;
			 
			 
		 
				String refdetails="GIS"+""+vocno;
				
				int trno=trmo;
				
				
				System.out.println("trno=="+trno);
			  
						
					String sql291="select acno from my_issuetype where doc_no='"+issuetype+"' ";
			     	System.out.println("-----4--sql2----"+sql291) ;

					ResultSet tass191 = stmt.executeQuery (sql291);

					if (tass191.next()) {

						accounts=tass191.getInt("acno");		

					}
				 
					

					String sqls101="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet tass118 = stmt.executeQuery (sqls101);
					if(tass118.next()) {

						vendorcur=tass118.getString("curid");	


					}

                     Statement s1=conn.createStatement();
					String currencytype="";
					String sqlselect1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--sqlvenselect----"+sqlselect1) ;
					ResultSet resultSet3312 = s1.executeQuery(sqlselect1);

					while (resultSet3312.next()) {
						venrate=resultSet3312.getDouble("rate");
						currencytype=resultSet3312.getString("type");
					}

					double	dramount=totalcost;


					double ldramount=0;
					if(currencytype.equalsIgnoreCase("D"))
					{


						ldramount=dramount/venrate ;  
					}

					else
					{
						ldramount=dramount*venrate ;  
					}



					String    sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
								+ "values('"+date+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"','GIS','"+brhid+"',"+trno+",3,"+costtype+","+costdocno+")";
	 
					 System.out.println("----GIS jvtran insertion 1----"+sql1) ;
					  val = stmt.executeUpdate(sql1);

					 if(val<=0)
				      {
				    	  break;
				      }
					 

					 Statement s2=conn.createStatement();
					String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					 System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet tass3090 = s2.executeQuery (sqls3);

					if (tass3090.next()) {

						curris=tass3090.getString("curid");	


					}
					
					String currencytype1="";
					 Statement s3=conn.createStatement();
					String sqlop = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					 System.out.println("-----6--sqlop----"+sqlop) ;
					ResultSet resultSet441 = s3.executeQuery(sqlop);

					while (resultSet441.next()) {
						rates=resultSet441.getDouble("rate");
						currencytype1=resultSet441.getString("type");
					} 

					double pricetottal=totalcost*-1;
					double ldramounts=0 ;     
					if(currencytype1.equalsIgnoreCase("D"))
					{

						ldramounts=pricetottal/venrate ;  
					}

					else
					{
						ldramounts=pricetottal*venrate ;  
					}

					String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
							+ "values('"+date+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"','GIS','"+brhid+"',"+trno+",3,"+costtype+","+costdocno+")";

					 System.out.println("----GIS jvtran insertion 2----"+sql112) ;

					 val=stmt.executeUpdate(sql112);


						 if(val<=0)
					      {
					    	  break;
					      }
					
						 System.out.println("---completed--") ;
						 
						 
						 
						 
					/* String sqldelcst="delete cost.* from my_jvtran jv left join my_head h on jv.acno=h.doc_no and jv.dtype='GIS' "
							+ "left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) "
							+ "where h.gr_type in(4,5) and jv.costcode!=0 and (cost.tranid is null or cost.amount!=jv.dramount)";	 
						  */
						  
						  
						  
						  String sqldelcst="delete from my_costtran where tr_no='"+trno+"'";
						  
					
					System.out.println("gis costtran delete====="+sqldelcst);
					
					val=stmt.executeUpdate(sqldelcst);
					
					/* String sqlinscst="insert into my_costtran (acno, costType, amount,sr_no, tranid, projectId, jobId, tr_no, status)"
							         + "select jv.acno,jv.costtype,jv.dramount,1,jv.tranid,0,jv.costcode,jv.tr_no,3 from my_jvtran jv "
							         + "left join my_head h on jv.acno=h.doc_no and jv.dtype='GIS'"
							         + "left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) "
							         + "where h.gr_type in(4,5) and jv.costcode!=0 and"
							         + "(cost.tranid is null)"; */
							         
							         
							         String sqlinscst="insert into my_costtran (acno, costType, amount, sr_no, tranid, projectId, jobId, tr_no, status) select acno,costtype,dramount,1,tranid,0,costcode,jv.tr_no,3  from my_jvtran jv left join my_head h on h.doc_no=jv.acno where jv.costcode!=0 and h.gr_type in(4,5) and jv.tr_no='"+trno+"'";
					
					
					
					System.out.println("gis costtran insert====="+sqlinscst);
					
					val=stmt.executeUpdate(sqlinscst);
					
					Statement stmt21 = conn.createStatement ();
					
					String cstchk="select i.tr_no trno from my_prddout o left join my_prddin i on i.refstockid=o.stockid"
							     + " where o.cost_price!=0 and i.cost_price=0 and o.tr_no='"+trno+"'";
					
					
					System.out.println("gir wrong====="+cstchk);
					
					ResultSet rss1=stmt21.executeQuery(cstchk);
					
					int csttrno=0;
					while(rss1.next())
					 {
						 
									
									csttrno=rss1.getInt("trno");
									
									
									System.out.println("csttrno==="+csttrno);
									
									String sqlcstupdt="update my_prddout o left join my_prddin i on i.refstockid=o.stockid"
										     + " set i.cost_price=o.cost_price where o.cost_price!=0 and i.cost_price=0 and o.tr_no='"+trno+"'";
		
									System.out.println("prddin update====="+sqlcstupdt);
									
									stmt1.executeUpdate(sqlcstupdt);
									
									String sqlgirdupdt="update my_gird d inner join my_prddout o on o.stockid=o.stockid and  o.psrno=d.psrno and o.tr_no=d.tr_no and o.cost_price=0   and o.dtype='GIR'   "
							           		  + " set d.cost_price=o.cost_price,d.totalcost_price=(o.cost_price*d.qty)  where   o.stockid=o.stockid and  o.psrno=d.psrno and o.tr_no=d.tr_no and o.cost_price=0   and o.dtype='GIR'  and o.tr_no="+trno+"  and o.dtype='GIR'  ";
								
									
									System.out.println("gird update====="+sqlgirdupdt);

									 stmt1.executeUpdate(sqlgirdupdt);
									
									
									 java.sql.Date girdate=null;
									 
									 int girvocno=0;
									 int girdocno=0;
									 int girbrhid=0;
									 int girissuetype=0;
									 int gircosttype=0;
									 int gircostdocno=0;
									 Statement s10 = conn.createStatement ();
								 String sqlgirselect ="select doc_no,voc_no,date,brhid,issuetype,costtype,costdocno from my_girm where tr_no="+csttrno+" ";
								 
								 System.out.println("gir costtype selection 1====="+sqlgirselect);
								 
								 ResultSet rdsa1=s10.executeQuery(sqlgirselect);
								   if(rdsa1.first())
								  {
									   girdate=rdsa1.getDate("date");
									 girvocno=rdsa1.getInt("voc_no");
									 girdocno=rdsa1.getInt("doc_no");
									 girbrhid=rdsa1.getInt("brhid");
									 girissuetype=rdsa1.getInt("issuetype");
									 gircosttype=rdsa1.getInt("costtype");
									 gircostdocno=rdsa1.getInt("costdocno");
								   }
								 
								   String girvendorcur="1"; 
									double girvenrate=1;
									
							         int giraccounts=0;
							 
							 
						 
								String girrefdetails="GIR"+""+vocno;
								
								int girtrno=csttrno;
							  
										
									String sql2911="select acno from my_issuetype where doc_no='"+girissuetype+"' ";
							     	
									//System.out.println("-----4--sql2----"+sql291) ;

									System.out.println("gir acno selection 1====="+sql2911);
									
									ResultSet tass1911 = stmt.executeQuery (sql2911);

									if (tass1911.next()) {

										accounts=tass1911.getInt("acno");		

									}
								 
									String sqls1011="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
									//System.out.println("---1----sqls10----"+sqls10) ;
									
									System.out.println("gir curid selection 1====="+sqls1011);
									
									
									
									ResultSet tass1181 = stmt.executeQuery (sqls1011);
									if(tass1181.next()) {

										girvendorcur=tass1181.getString("curid");	


									}
								   
								   
									 Statement s11=conn.createStatement();
										String gircurrencytype="";
										String sqlselect11 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
										
										
										System.out.println("gir type selection 1====="+sqlselect11);
										
										ResultSet resultSet33121 = s1.executeQuery(sqlselect11);

										while (resultSet33121.next()) {
											girvenrate=resultSet33121.getDouble("rate");
											gircurrencytype=resultSet33121.getString("type");
										}

										double	girdramount=totalcost;


										double girldramount=0;
										if(gircurrencytype.equalsIgnoreCase("D"))
										{


											girldramount=girdramount/girvenrate ;  
										}

										else
										{
											girldramount=girdramount*girvenrate ;  
										}

                                        String sqldeljv="delete from my_jvtran where tr_no='"+csttrno+"'";
                                        
                                        System.out.println("gir jvtran delete=="+sqldeljv);
                                        
                                        val=stmt.executeUpdate(sqldeljv);

										String    sqlinsjv="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
													+ "values('"+girdate+"','"+refdetails+"',"+girdocno+",'"+accounts+"','"+refdetails+"','"+girvendorcur+"','"+girvenrate+"',"+(girdramount)*-1+","+(girldramount)*-1+",0,1,6,0,0,0,'"+girvenrate+"','GIR','"+brhid+"',"+csttrno+",3,"+costtype+","+costdocno+")";
						 
										
										System.out.println("gir jvtran insert 1====="+sqlinsjv);
										
										  val = stmt.executeUpdate(sqlinsjv);

										 if(val<=0)
									      {
									    	  break;
									      }
										 

										 Statement s21=conn.createStatement();
										String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
										 
										System.out.println("gir curid select====="+sqls31);
										
										ResultSet tass30901 = s21.executeQuery (sqls31);

										if (tass30901.next()) {

											curris=tass30901.getString("curid");	


										}
										
										String gircurrencytype1="";
										 Statement s31=conn.createStatement();
										String sqlop1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
										
										System.out.println("gir type select====="+sqlop1);
										
										ResultSet resultSet4411 = s31.executeQuery(sqlop1);

										while (resultSet4411.next()) {
											rates=resultSet4411.getDouble("rate");
											gircurrencytype1=resultSet4411.getString("type");
										} 

										double girpricetottal=totalcost*-1;
										double girldramounts=0 ;     
										if(gircurrencytype1.equalsIgnoreCase("D"))
										{

											girldramounts=girpricetottal/girvenrate ;  
										}

										else
										{
											girldramounts=girpricetottal*girvenrate ;  
										}

										String sql1121="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
												+ "values('"+date+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+(pricetottal)*-1+","+(ldramounts)*-1+",0,-1,6,0,0,0,'"+rates+"','GIR','"+brhid+"',"+csttrno+",3,"+costtype+","+costdocno+")";

										System.out.println("gir jvtran insert 2====="+sql1121);

										 val=stmt.executeUpdate(sql1121);
										 
										 
										  Statement s311=conn.createStatement();
										 
										 String girjvsum="select sum(dramount) dramount from my_jvtran where tr_no='"+csttrno+"' group by '"+csttrno+"'";
										 
										 
										  ResultSet resultSet311 = s311.executeQuery(girjvsum);
										 
										 while (resultSet311.next()) {
											 
												rates=resultSet311.getDouble("dramount");
												
											} 
										 
										 if(rates!=0.0){
											 val=0;
										 } 
										  
							
											 if(val<=0)
										      {
										    	  break;
										      }
										
										 
										/* String sqldelcst1="delete cost.* from my_jvtran jv left join my_head h on jv.acno=h.doc_no and jv.dtype='GIR' "
												+ "left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) "
												+ "where h.gr_type in(4,5) and jv.costcode!=0 and (cost.tranid is null or cost.amount!=jv.dramount or cost.amount=0)";	 
										 */
										 
										 
										 String sqldelcst1="delete from my_costtran where tr_no='"+csttrno+"'";
										 
										 
										System.out.println("gir delete costtran====="+sqldelcst1);
										
										val=stmt.executeUpdate(sqldelcst1);
										
										
										
										
										/* String sqlinscst1="insert into my_costtran (acno, costType, amount,sr_no, tranid, projectId, jobId, tr_no, status)"
												         + "select jv.acno,jv.costtype,jv.dramount,1,jv.tranid,0,jv.costcode,jv.tr_no,3 from my_jvtran jv left join my_head h on jv.acno=h.doc_no and jv.dtype='GIR'"
												         + "left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) where h.gr_type in(4,5) and jv.costcode!=0 and"
												         + "(cost.tranid is null or cost.amount=0)";
 */
										
										String sqlinscst1="insert into my_costtran (acno, costType, amount, sr_no, tranid, projectId, jobId, tr_no, status) select acno,costtype,dramount,1,tranid,0,costcode,jv.tr_no,3  from my_jvtran jv left join my_head h on h.doc_no=jv.acno where jv.costcode!=0 and h.gr_type in(4,5) and jv.tr_no='"+csttrno+"'";
										
										
											 
										System.out.println("gir costtran insert==="+sqlinscst1);
										
										val=stmt.executeUpdate(sqlinscst1);
								
					 }
			
			 }
			 
		 }
	  
		 if(val>0)
		 {
			  conn.commit();
			  response.getWriter().print(1);
		 }
		  else{
			 response.getWriter().print(0);
		 } 
		 
		 
	 	stmt.close();
	 	conn.close();
	 }
	 catch(Exception e){

			conn.close();
			  response.getWriter().print(0);
			e.printStackTrace();
		}
	    
	
	%>
