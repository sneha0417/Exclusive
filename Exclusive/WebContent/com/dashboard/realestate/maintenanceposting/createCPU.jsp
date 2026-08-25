<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>       
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
	try{                                                          
	 	conn = ClsConnection.getMyConnection();        
		Statement stmt = conn.createStatement();    
		Statement stmt2 = conn.createStatement();    
		String purincl=request.getParameter("purincl")=="" || request.getParameter("purincl")==null?"":request.getParameter("purincl");
		String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");
		String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String gridarray=request.getParameter("gridarray")=="" || request.getParameter("gridarray")==null?"0":request.getParameter("gridarray");
		String purnetamt=request.getParameter("purnetamt")=="" || request.getParameter("purnetamt")==null?"0.0":request.getParameter("purnetamt");
		String desc=request.getParameter("desc")=="" || request.getParameter("desc")==null?"":request.getParameter("desc");
		String invno=request.getParameter("invno")=="" || request.getParameter("invno")==null?"0":request.getParameter("invno");
		String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");    
		String sql="",sqlsub="",sql1="",sql2="",sql3="",typez="",accno="0";
		int dat=0,trvocno=0,val1=0,i=0,id=0;  
		System.out.println(purincl+"==in=="+gridarray);         
		ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();        
		     session.setAttribute("BRANCHID",brhid);
			 ArrayList<String> newarray=new ArrayList();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     java.sql.Date sqlinvdate=null;
		     java.sql.Date sqlpostdate=null;
		     if(!invdate.equalsIgnoreCase("0") && !invdate.equalsIgnoreCase("")){                         
		    	 sqlinvdate=ClsCommon.changeStringtoSqlDate(invdate);              
		     }     
		     String t1="0",t2="0",rownos="",job="",taxacno="",vndname="",vndacno="",cpuvocnos="";                
		     Double vatamt=0.0,amt=0.0,total=0.0,vatper=5.0,nettotal=0.0;    
		        String strcountvnd="select (select acno from my_account where codeno='MAINTENANCE EXPENSE') taxacno,r.rowno,j.job_desc job,h.description vendor_name,h.account vendor_acno,h.doc_no vendor_docno, r.estval est_cost from re_mreqmgmt r left join rl_jobmaster j on j.doc_no=r.jobdocno left join my_head h on (h.doc_no=r.vndacno and h.atype='ap') where r.rowno in("+gridarray+") order by r.vndacno";
				//System.out.println("strcountvnd--->>>"+strcountvnd);                                   
				ResultSet rs5=stmt2.executeQuery(strcountvnd);                                 
				while(rs5.next()){     
					t1=rs5.getString("vendor_docno");   
					if(i==0){
						vndname=rs5.getString("vendor_name");   
						vndacno=rs5.getString("vendor_docno");
						amt=rs5.getDouble("est_cost");
						job=rs5.getString("job");
						taxacno=rs5.getString("taxacno");      
						if(purincl.equalsIgnoreCase("1")){                          
							   vatamt=amt-((amt/105)*100);
							   total=amt;
							   amt=amt-vatamt;       
							 }
							 else{
					            vatamt=(amt*5)/100;
							    total=amt+vatamt;                          
							 } 
					 nettotal=nettotal+total;
					 newarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
					 rownos=rs5.getString("rowno");                           
					}
					else if(t1.equalsIgnoreCase(t2)){
						amt=rs5.getDouble("est_cost");
						job=rs5.getString("job");
						taxacno=rs5.getString("taxacno");      
						if(purincl.equalsIgnoreCase("1")){                          
							   vatamt=amt-((amt/105)*100);
							   total=amt;
							   amt=amt-vatamt;       
							 }
							 else{
					            vatamt=(amt*5)/100;
							    total=amt+vatamt;                          
							 }  
					 nettotal=nettotal+total;
					 newarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
					 rownos+=","+rs5.getString("rowno");             
					}else{
						dat=DAO.insert(sqlinvdate,sqlinvdate,"",0,"AP",vndacno,vndname,"1","1","","",desc,session,"A",nettotal,newarray,"CPU",request,sqlinvdate,invno,"",0,1,1,"");       
						trvocno=Integer.parseInt(request.getAttribute("vocno").toString());  
						cpuvocnos=cpuvocnos+trvocno+", ";
						if(dat>0){  
							  if(purincl.equalsIgnoreCase("1")){                          
								    id=1;  
								 }else{     
						            id=0;                        
								 } 
								String strupdate="update re_mreqmgmt set cpudoc="+dat+",cpuvoc="+trvocno+",purinclusive="+id+" where rowno in("+rownos+")";                      
								//System.out.println("strupdate--->>>"+strupdate);              
								val1=stmt.executeUpdate(strupdate);   
						}    
						newarray=new ArrayList<String>();  
						rownos="";
						nettotal=0.0;
						amt=rs5.getDouble("est_cost");
						job=rs5.getString("job");
						taxacno=rs5.getString("taxacno");
						vndname=rs5.getString("vendor_name");               
						vndacno=rs5.getString("vendor_docno");
						if(purincl.equalsIgnoreCase("1")){                          
							   vatamt=amt-((amt/105)*100);
							   total=amt;
							   amt=amt-vatamt;       
							 }
							 else{
					            vatamt=(amt*5)/100;
							    total=amt+vatamt;                          
							 }  
						nettotal=nettotal+total;
					    newarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
					    rownos+=rs5.getString("rowno");               
					}
					t2=rs5.getString("vendor_docno"); 
					i++; 
				}
		         dat=DAO.insert(sqlinvdate,sqlinvdate,"",0,"AP",vndacno,vndname,"1","1","","",desc,session,"A",nettotal,newarray,"CPU",request,sqlinvdate,invno,"",0,1,1,"");       
				 trvocno=Integer.parseInt(request.getAttribute("vocno").toString()); 
				 cpuvocnos=cpuvocnos+trvocno;
				 if(dat>0){  
						 if(purincl.equalsIgnoreCase("1")){                          
							    id=1;  
							 }else{     
					            id=0;                        
							 }         
							String strupdate="update re_mreqmgmt set cpudoc="+dat+",cpuvoc="+trvocno+",purinclusive="+id+" where rowno in("+rownos+")";                   
							//System.out.println("strupdate--->>>"+strupdate);      
							val1=stmt.executeUpdate(strupdate);   
				  }	
				if(val1>0){
					    String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MAPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Purchase Invoice created')";            
						System.out.println(sqllog);                     
						val1=stmt.executeUpdate(sqllog);      
				}                 
			response.getWriter().print(val1+"###"+cpuvocnos);                                                              
 	stmt.close();    
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
