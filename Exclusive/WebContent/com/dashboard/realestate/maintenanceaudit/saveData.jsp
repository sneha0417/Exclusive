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
<%@page import="com.dashboard.realestate.maintenanceaudit.ClsMaintenanceAuditDAO"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>
<%
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");     
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");  
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");                
    
ClsConnection objconn=new ClsConnection();              
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0; 
boolean invdat=false,cpudat=false,jvtdat=false;
//System.out.println("=============="+gridarray);               
try{
	    conn=objconn.getMyConnection();
	    session.setAttribute("BRANCHID",brhid);
	    conn.setAutoCommit(false);
	    Statement stmt=conn.createStatement();  
		ArrayList<String> cpuarray=new ArrayList();
		ArrayList<String> jvtarray=new ArrayList();
		ArrayList<String> invarray=new ArrayList();
	    ArrayList<String> newarray=new ArrayList();
	    ArrayList<String> subarray=new ArrayList();         
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		for(int i=0;i<newarray.size();i++){    
			
			String temp[]=newarray.get(i).split("::");         
			
			if(!temp[3].trim().equalsIgnoreCase("undefined") && !temp[3].trim().equalsIgnoreCase("NaN") && !temp[3].trim().equalsIgnoreCase("")){
				String est_cost = temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0.0":temp[0].trim().toString();
				String margin = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0.0":temp[1].trim().toString();
				String total = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0.0":temp[2].trim().toString();
				int rowsno= temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?0:Integer.parseInt(temp[3].trim().toString());
				int rowdelete= temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?0:Integer.parseInt(temp[4].trim().toString());            
				if(rowdelete==1){
					int testjvtrno=0,testcpudoc=0,testinvdoc=0,testval=0;  
					String sqltest="select rmbjvtrno,cpudoc,invdoc from re_mreqmgmt where rowno="+rowsno+"";        
					ResultSet rstest=stmt.executeQuery(sqltest);  
					while(rstest.next()){
						testjvtrno=rstest.getInt("rmbjvtrno");
						testcpudoc=rstest.getInt("cpudoc");
						testinvdoc=rstest.getInt("invdoc");	        
					}
					if(testjvtrno>0){
						String sqltest1="select count(*) val from re_mreqmgmt where rmbjvtrno="+testjvtrno+"";           
						ResultSet rstest1=stmt.executeQuery(sqltest1);     
						while(rstest1.next()){
							testval=rstest1.getInt("val");	        
						}
						if(testval==1){        
							String sqltestup1="update my_jvtran set status=7 where tr_no="+testjvtrno+"";      
							//System.out.println(sqltestup1);                   
							val=stmt.executeUpdate(sqltestup1); 
						}
					}
					if(testcpudoc>0){
						String sqltest2="select count(*) val from re_mreqmgmt where cpudoc="+testcpudoc+"";           
						ResultSet rstest2=stmt.executeQuery(sqltest2);     
						while(rstest2.next()){
							testval=rstest2.getInt("val");	        
						}
						if(testval==1){        
							String sqltestup2="update my_srvpurm set status=7 where doc_no="+testcpudoc+"";      
							//System.out.println(sqltestup2);                   
							val=stmt.executeUpdate(sqltestup2); 
						}
					}
					if(testinvdoc>0){               
						String sqltest3="select count(*) val from re_mreqmgmt where invdoc="+testinvdoc+"";           
						ResultSet rstest3=stmt.executeQuery(sqltest3);     
						while(rstest3.next()){
							testval=rstest3.getInt("val");     	        
						}
						if(testval==1){        
							String sqltestup3="update rl_prinvm set status=7 where doc_no="+testinvdoc+"";          
							//System.out.println(sqltestup3);                   
							val=stmt.executeUpdate(sqltestup3); 
						}
					}
					String sql1="delete from re_mreqmgmt where rowno="+rowsno+"";   
					//System.out.println(sql1);                   
					val=stmt.executeUpdate(sql1);     
				}else if(rowsno>0){                                                                                   
					String sql="update re_mreqmgmt set estval="+est_cost+", margin="+margin+", total="+total+" where rowno="+rowsno+"";   
					//System.out.println(sql);                   
					val=stmt.executeUpdate(sql);                 
				}else{}          
		}
	} 
  if(val>0){
	//CPU EDIT//  
	int cpuval=0;
	String sqlcpu="select coalesce(count(*),0) val from re_mreqmgmt m left join my_srvpurm sm on sm.doc_no=m.cpudoc where rvocno='"+vocno+"' and rbrhid='"+brhid+"' and sm.status=3 order by cpudoc";        
	ResultSet rscpu=stmt.executeQuery(sqlcpu);  
	while(rscpu.next()){
		cpuval=rscpu.getInt("val");
	}  
	if(cpuval>0){
		ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();   
		java.sql.Date sqlinvdate=null;  
		java.sql.Date sqldate=null;	
		java.sql.Date sqldeldate=null;	
		int dat=0,k=0,tranno=0,interstate=0,billtype=0,cpudocno=0;
		String t1="0",t2="0",job="",taxacno="",vndname="",vndacno="",purinclusive="0",desc="",invno="",delterm="",payterm="";                        
	    Double vatamt=0.0,amt=0.0,total=0.0,vatper=5.0,nettotal=0.0;           
	    String sqlcpu1="select mm.doc_no,mm.acno vendor_docno,h.description vendor_name,mm.date,mm.tr_no trnno,mm.invno,mm.invdate,mm.delterm,mm.payterm,mm.deldate,mm.desc1,mm.interstate,mm.billtype,j.job_desc job,(select acno from my_account where codeno='MAINTENANCE EXPENSE') taxacno,r.estval est_cost,r.purinclusive from re_mreqmgmt r left join my_srvpurm mm on mm.doc_no=r.cpudoc left join my_head h on h.doc_no=mm.acno left join rl_jobmaster j on j.doc_no=r.jobdocno where rvocno='"+vocno+"' and rbrhid='"+brhid+"' and mm.status=3 order by cpudoc";        
		ResultSet rscpu1=stmt.executeQuery(sqlcpu1);      
		while(rscpu1.next()){ 
			t1=rscpu1.getString("doc_no");       
			if(k==0){
				sqlinvdate=rscpu1.getDate("invdate");
				sqldate=rscpu1.getDate("date");
				sqldeldate=rscpu1.getDate("deldate");               
				vndname=rscpu1.getString("vendor_name");   
				vndacno=rscpu1.getString("vendor_docno");
				purinclusive=rscpu1.getString("purinclusive");
				desc=rscpu1.getString("desc1");
				invno=rscpu1.getString("invno");   
				delterm=rscpu1.getString("delterm");
				payterm=rscpu1.getString("payterm");
				tranno=rscpu1.getInt("trnno");
				interstate=rscpu1.getInt("interstate");
				billtype=rscpu1.getInt("billtype");
				cpudocno=rscpu1.getInt("doc_no");
				amt=rscpu1.getDouble("est_cost");
				job=rscpu1.getString("job");
				taxacno=rscpu1.getString("taxacno");      
				if(purinclusive.equalsIgnoreCase("1")){                              
					   vatamt=amt-((amt/105)*100);
					   total=amt;
					   amt=amt-vatamt;       
					 }
					 else{
			            vatamt=(amt*5)/100;
					    total=amt+vatamt;                          
					 } 
			 nettotal=nettotal+total;
			 cpuarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
			}
			else if(t1.equalsIgnoreCase(t2)){
				sqlinvdate=rscpu1.getDate("invdate");
				sqldate=rscpu1.getDate("date");
				sqldeldate=rscpu1.getDate("deldate");               
				vndname=rscpu1.getString("vendor_name");   
				vndacno=rscpu1.getString("vendor_docno");
				purinclusive=rscpu1.getString("purinclusive");
				desc=rscpu1.getString("desc1");
				invno=rscpu1.getString("invno");   
				delterm=rscpu1.getString("delterm");
				payterm=rscpu1.getString("payterm");
				tranno=rscpu1.getInt("trnno");
				interstate=rscpu1.getInt("interstate");
				billtype=rscpu1.getInt("billtype");
				cpudocno=rscpu1.getInt("doc_no");
				amt=rscpu1.getDouble("est_cost");
				job=rscpu1.getString("job");
				taxacno=rscpu1.getString("taxacno");      
				if(purinclusive.equalsIgnoreCase("1")){                             
					   vatamt=amt-((amt/105)*100);
					   total=amt;
					   amt=amt-vatamt;       
					 }
					 else{
			            vatamt=(amt*5)/100;
					    total=amt+vatamt;                          
					 }  
			 nettotal=nettotal+total;
			 cpuarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
			}else{
				cpudat=DAO.edit(cpudocno,sqldate,sqldeldate,"",0,"AP",vndacno,vndname,"1","1",delterm,payterm,desc,session,"E",nettotal,cpuarray,"CPU",tranno,request,sqlinvdate,invno,"",interstate,1,billtype);       
				    
				cpuarray=new ArrayList<String>();  
				nettotal=0.0;        
				sqlinvdate=rscpu1.getDate("invdate");
				sqldate=rscpu1.getDate("date");
				sqldeldate=rscpu1.getDate("deldate");               
				vndname=rscpu1.getString("vendor_name");   
				vndacno=rscpu1.getString("vendor_docno");
				purinclusive=rscpu1.getString("purinclusive");
				desc=rscpu1.getString("desc1");
				invno=rscpu1.getString("invno");   
				delterm=rscpu1.getString("delterm");
				payterm=rscpu1.getString("payterm");
				tranno=rscpu1.getInt("trnno");
				interstate=rscpu1.getInt("interstate");
				billtype=rscpu1.getInt("billtype");
				cpudocno=rscpu1.getInt("doc_no");
				amt=rscpu1.getDouble("est_cost");
				job=rscpu1.getString("job");
				taxacno=rscpu1.getString("taxacno");
				vndname=rscpu1.getString("vendor_name");               
				vndacno=rscpu1.getString("vendor_docno");   
				if(purinclusive.equalsIgnoreCase("1")){                              
					   vatamt=amt-((amt/105)*100);
					   total=amt;
					   amt=amt-vatamt;       
					 }
					 else{
			            vatamt=(amt*5)/100;
					    total=amt+vatamt;                          
					 }  
				nettotal=nettotal+total;
				cpuarray.add(0+" :: "+1+" :: "+job+" :: "+ amt+" :: "+amt+" :: "+0+" :: "+amt+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+taxacno+" :: "+vatper+" :: "+vatamt+" :: "+total+" :: "+0);           
			}
			t2=rscpu1.getString("doc_no");    
			k++;        
		}       
		cpudat=DAO.edit(cpudocno,sqldate,sqldeldate,"",0,"AP",vndacno,vndname,"1","1",delterm,payterm,desc,session,"E",nettotal,cpuarray,"CPU",tranno,request,sqlinvdate,invno,"",interstate,1,billtype);    
	    if(cpudat==false){    
	    	val=0;     
	    }
	 } 
  }   	
	if(val>0){     
	//PRIV EDIT//      
		int privval=0;
		String sqlpriv="select coalesce(count(*),0) val from re_mreqmgmt m left join rl_prinvm sm on sm.doc_no=m.invdoc where rvocno='"+vocno+"' and rbrhid='"+brhid+"' and sm.status=3 order by invdoc";        
		ResultSet rspriv=stmt.executeQuery(sqlpriv);  
		while(rspriv.next()){
			privval=rspriv.getInt("val");                       
		}
		if(privval>0){
			    ClsMaintenanceAuditDAO DAO= new ClsMaintenanceAuditDAO();      
				java.sql.Date sqlinvdate=null;  
				java.sql.Date sqldate=null;	
				java.sql.Date sqlfromdate=null;	
				java.sql.Date sqltodate=null;       	
				java.sql.Date sqldeldate=null;      
			    String rentsalevalue="",owner="",property="",manual="",paytype="",accdoc="",accname="",actype="",descptn="",maindesc="",inclusive="",refno="",pono="",t1="",t2="",delterm="",payterm="";  
			    int l=0,invdocno=0,tranno=0,interstate=0,invvocno=0,incomeacno=0;          
			    Double vatamt=0.0,amt=0.0,total=0.0,vatper=5.0,nettotal=0.0,netamt=0.0;                       
			    String sqlpriv1="select mm.refno,mm.manual, mm.property, mm.owner, mm.fromdate, mm.todate, mm.rentsalevalue,mm.type atype,mm.voc_no,mm.doc_no,mm.acno vendor_docno,h.description vendor_name,mm.date,mm.tr_no trnno,mm.invno,mm.invdate,mm.delterm,mm.payterm,mm.deldate,mm.desc1,mm.interstate,j.job_desc job,(select coalesce(acno,0) acno from my_account where codeno='MAINTENANCE INVOICE') incomeacno,r.total,r.invinclusive from re_mreqmgmt r left join rl_prinvm mm on mm.doc_no=r.invdoc left join my_head h on h.doc_no=mm.acno left join rl_jobmaster j on j.doc_no=r.jobdocno where rvocno='"+vocno+"' and rbrhid='"+brhid+"' and mm.status=3 order by invdoc";        
			    System.out.println(sqlpriv1);   
			    ResultSet rspriv1=stmt.executeQuery(sqlpriv1);      
				while(rspriv1.next()){         
					 t1=rspriv1.getString("doc_no");      
					 if(l==0){ 
						 refno=rspriv1.getString("refno");
						 actype=rspriv1.getString("atype");          
						 manual=rspriv1.getString("manual");   
						 property=rspriv1.getString("property");   
						 owner=rspriv1.getString("owner");   
						 rentsalevalue=rspriv1.getString("rentsalevalue");       
						 sqlinvdate=rspriv1.getDate("invdate");
						 sqldate=rspriv1.getDate("date");
						 sqlfromdate=rspriv1.getDate("fromdate");     
						 sqltodate=rspriv1.getDate("todate");  
						 sqldeldate=rspriv1.getDate("deldate");  
						 accname=rspriv1.getString("vendor_name");      
						 accdoc=rspriv1.getString("vendor_docno");
						 inclusive=rspriv1.getString("invinclusive");
						 maindesc=rspriv1.getString("desc1");
						 pono=rspriv1.getString("invno");   
						 delterm=rspriv1.getString("delterm");
						 payterm=rspriv1.getString("payterm");
						 tranno=rspriv1.getInt("trnno");
						 interstate=rspriv1.getInt("interstate");
						 invdocno=rspriv1.getInt("doc_no");
						 invvocno=rspriv1.getInt("voc_no");      
						 amt=rspriv1.getDouble("total");                
						 descptn=rspriv1.getString("job");   
						 incomeacno=rspriv1.getInt("incomeacno");        
						 total=0.0;   
						 vatamt=0.0;
						 netamt=0.0;
						 vatper=0.0;
						if(inclusive.equalsIgnoreCase("0")){            
								   vatper=5.0;
								   vatamt=ClsCommon.round((amt*5)/100,session);      
								   total=ClsCommon.round(amt,session);
								   netamt=ClsCommon.round(amt+vatamt,session);
							   }else{
								   vatper=5.0;
								   vatamt=ClsCommon.round(amt-((amt/105)*100),session);    
								   total=ClsCommon.round(amt-vatamt,session);
								   netamt=ClsCommon.round(amt,session);            
						}
						nettotal=nettotal+netamt;
						invarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: "); 
					 }else if(t1.equalsIgnoreCase(t2)){       
						 refno=rspriv1.getString("refno");
						 actype=rspriv1.getString("atype");          
						 manual=rspriv1.getString("manual");   
						 property=rspriv1.getString("property");   
						 owner=rspriv1.getString("owner");   
						 rentsalevalue=rspriv1.getString("rentsalevalue");       
						 sqlinvdate=rspriv1.getDate("invdate");
						 sqldate=rspriv1.getDate("date");
						 sqlfromdate=rspriv1.getDate("fromdate");     
						 sqltodate=rspriv1.getDate("todate");  
						 sqldeldate=rspriv1.getDate("deldate");  
						 accname=rspriv1.getString("vendor_name");      
						 accdoc=rspriv1.getString("vendor_docno");
						 inclusive=rspriv1.getString("invinclusive");
						 maindesc=rspriv1.getString("desc1");
						 pono=rspriv1.getString("invno");   
						 delterm=rspriv1.getString("delterm");
						 payterm=rspriv1.getString("payterm");
						 tranno=rspriv1.getInt("trnno");
						 interstate=rspriv1.getInt("interstate");
						 invdocno=rspriv1.getInt("doc_no");
						 invvocno=rspriv1.getInt("voc_no");      
						 amt=rspriv1.getDouble("total");                
						 descptn=rspriv1.getString("job");   
						 incomeacno=rspriv1.getInt("incomeacno");        
						 total=0.0;   
						 vatamt=0.0;
						 netamt=0.0;
						 vatper=0.0;
						 if(inclusive.equalsIgnoreCase("0")){            
							   vatper=5.0;
							   vatamt=ClsCommon.round((amt*5)/100,session);      
							   total=ClsCommon.round(amt,session);
							   netamt=ClsCommon.round(amt+vatamt,session);
						   }else{
							   vatper=5.0;
							   vatamt=ClsCommon.round(amt-((amt/105)*100),session);    
							   total=ClsCommon.round(amt-vatamt,session);
							   netamt=ClsCommon.round(amt,session);            
					     }
						nettotal=nettotal+netamt;    
						invarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: "); 
					 }else{
						         invdat=DAO.edit(conn,invdocno,sqldate,sqldeldate,"",refno,actype,accdoc,accname,"1","1","","",maindesc,session,"E",nettotal,invarray,"PRIV",tranno,request,sqlinvdate,pono,"",1,5.0,"","",subarray,property,owner,sqlfromdate,sqltodate,rentsalevalue,manual,invvocno);  
								 maindesc="";     
								 nettotal=0.0;
								 refno=rspriv1.getString("refno");
								 actype=rspriv1.getString("atype");          
								 manual=rspriv1.getString("manual");   
								 property=rspriv1.getString("property");   
								 owner=rspriv1.getString("owner");   
								 rentsalevalue=rspriv1.getString("rentsalevalue");       
								 sqlinvdate=rspriv1.getDate("invdate");
								 sqldate=rspriv1.getDate("date");
								 sqlfromdate=rspriv1.getDate("fromdate");     
								 sqltodate=rspriv1.getDate("todate");  
								 sqldeldate=rspriv1.getDate("deldate");  
								 accname=rspriv1.getString("vendor_name");      
								 accdoc=rspriv1.getString("vendor_docno");
								 inclusive=rspriv1.getString("invinclusive");
								 maindesc=rspriv1.getString("desc1");
								 pono=rspriv1.getString("invno");   
								 delterm=rspriv1.getString("delterm");
								 payterm=rspriv1.getString("payterm");
								 tranno=rspriv1.getInt("trnno");
								 interstate=rspriv1.getInt("interstate");
								 invdocno=rspriv1.getInt("doc_no");
								 invvocno=rspriv1.getInt("voc_no");      
								 amt=rspriv1.getDouble("total");                
								 descptn=rspriv1.getString("job");   
								 incomeacno=rspriv1.getInt("incomeacno");  
								 total=0.0;   
								 vatamt=0.0;
								 netamt=0.0;
								 vatper=0.0;
								 if(inclusive.equalsIgnoreCase("0")){            
									   vatper=5.0;
									   vatamt=ClsCommon.round((amt*5)/100,session);      
									   total=ClsCommon.round(amt,session);
									   netamt=ClsCommon.round(amt+vatamt,session);
								   }else{
									   vatper=5.0;
									   vatamt=ClsCommon.round(amt-((amt/105)*100),session);    
									   total=ClsCommon.round(amt-vatamt,session);
									   netamt=ClsCommon.round(amt,session);                
							}  
								nettotal=nettotal+netamt; 
								invarray=new ArrayList<String>();                     
								invarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: ");
					 }
					  t2=rspriv1.getString("doc_no");  
					  l++; 
		          }
				  invdat=DAO.edit(conn,invdocno,sqldate,sqldeldate,"",refno,actype,accdoc,accname,"1","1","","",maindesc,session,"E",nettotal,invarray,"PRIV",tranno,request,sqlinvdate,pono,"",1,5.0,"","",subarray,property,owner,sqlfromdate,sqltodate,rentsalevalue,manual,invvocno);  
				  if(invdat==false){        
				    	val=0;          
				    }
		    }  
	   }
	if(val>0){
		//JVT EDIT//         
		int jvtval=0,jvtrnos=0;   
		String sqljvt="select coalesce(count(*),0) val,m.rmbjvtrno from re_mreqmgmt m left join my_jvtran sm on sm.tr_no=m.rmbjvtrno where m.rvocno='"+vocno+"' and m.rbrhid='"+brhid+"' and sm.status=3 order by rmbjvtrno";        
		ResultSet rsjvt=stmt.executeQuery(sqljvt);  
		while(rsjvt.next()){
			jvtval=rsjvt.getInt("val"); 
			jvtrnos=rsjvt.getInt("rmbjvtrno");    
		}
	    if(jvtval>0){         
	    	ClsJournalVouchersDAO DAO= new ClsJournalVouchersDAO();     
	    	java.sql.Date sqldate=null;	
	    	Double amount=0.0,total=0.0;
	    	int jvtdocno=0,tranno=jvtrnos,tacno=0,oacno=0;  
	    	String invno="",desc="";   
	    	String sqljvt1="select jv.doc_no,jv.description,jv.date,jv.ref_detail invno,r.total from my_jvtran jv left join (select rmbjvtrno,sum(total) total from re_mreqmgmt group by rmbjvtrno) r on jv.tr_no=r.rmbjvtrno where jv.tr_no='"+tranno+"' group by jv.tr_no";        
		    System.out.println(sqljvt1);      
		    ResultSet rsjvt1=stmt.executeQuery(sqljvt1);         
			while(rsjvt1.next()){
				amount=rsjvt1.getDouble("total");   
				jvtdocno=rsjvt1.getInt("doc_no");
				invno=rsjvt1.getString("invno");
				sqldate=rsjvt1.getDate("date");      
				desc=rsjvt1.getString("description");   
			} 
			String sqljvt2="select a.* from(select coalesce(ac.acno,0) tacno,coalesce(p.acno,0) oacno,r.voc_no  from re_mreq r left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') where r.voc_no='"+vocno+"' and r.branch='"+brhid+"')a group by a.voc_no";
			ResultSet rsjvt2 = stmt.executeQuery(sqljvt2);     
			while(rsjvt2.next()){    
				tacno=rsjvt2.getInt("tacno");   
				oacno=rsjvt2.getInt("oacno");          
			}
			if(amount<0){
				  total=amount*-1;
			}else{
				  total=amount;
			}
			jvtarray.add(oacno+" :: "+desc+" :: "+ 1 +" :: "+ 1 +" :: "+total+" :: "+total+" ::"+ 2 +" :: "+1+" :: "+""+" :: "+""+" :: ");
			if(amount>0){
				  total=amount*-1;
			}else{
				  total=amount;
			}
			jvtarray.add(tacno+" :: "+desc+" :: "+ 1 +" :: "+ 1 +" :: "+total+" :: "+total+" ::"+ 2 +" :: "+-1+" :: "+""+" :: "+""+" :: ");
	    	jvtdat=DAO.edit(jvtdocno,"JVT",sqldate,invno, desc,tranno, amount, amount, jvtarray, session);  
	    	if(jvtdat==false){        
		    	val=0;          
		    }
	    }
	}
	    if(val>0){
			String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MAD',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Estimation values edit')";   
			//System.out.println(sql2);                 
			val=stmt.executeUpdate(sql2);   
	    }   
	    if(val>0){
	    	conn.commit();  
	    	stmt.close();            
	    	conn.close();
	    }
    	response.getWriter().print(val); 
}    
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>