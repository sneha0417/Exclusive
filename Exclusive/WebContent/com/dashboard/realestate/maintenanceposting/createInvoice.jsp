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
<%@page import="com.dashboard.realestate.maintenanceposting.ClsMaintenancePostingDAO"%>     
<%@page import="com.common.ClsVatInsert"%>          
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%	
	ClsConnection connDAO=new ClsConnection();       
	ClsCommon commonDAO=new ClsCommon();        
	ClsMaintenancePostingDAO DAO= new ClsMaintenancePostingDAO();        
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                         
	java.sql.Date sqlStartDate2=null;    
	String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");      
	String inclusive=request.getParameter("inclusive")=="" || request.getParameter("inclusive")==null?"0":request.getParameter("inclusive");      
	String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
	String pono=request.getParameter("pono")=="" || request.getParameter("pono")==null?"0":request.getParameter("pono");
	String rowarray=request.getParameter("rowarray")=="" || request.getParameter("rowarray")==null?"0":request.getParameter("rowarray");   
	String desc=request.getParameter("desc")=="" || request.getParameter("desc")==null?"":request.getParameter("desc");
	String refno=request.getParameter("refno")=="" || request.getParameter("refno")==null?"0":request.getParameter("refno");
	String podate=request.getParameter("podate")=="" || request.getParameter("podate")==null?"0":request.getParameter("podate");  
	String mrfacno=request.getParameter("mrfacno")=="" || request.getParameter("mrfacno")==null?"0":request.getParameter("mrfacno");
	//System.out.println("inclusive--->>>"+inclusive);            
	String maindesc="",invvocno="",incomeacno="0",sqlss="",vndacno="",descptn="",rowno="0",expacno="0",paytype="",t1="",t2="",accdoc="",accname="",owneraccname="",tenantaccname="",mrfaccname="",incomeaccname="",expaccname="",actype="";      
	int trnosss=0,temp=0,jvtranno=0,val3=0,result=0,i=0,dat=0,trvocno=0,val1=0,id=0;          
	Double total=0.0,vatamt=0.0,netamt=0.0,vatper=0.0,amount=0.0,nettotal=0.0;
    try{      
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement();    
		Statement stmt2=conn.createStatement();    
		session.setAttribute("BRANCHID",brhid);   
		conn.setAutoCommit(false);             
		if(!(podate.equalsIgnoreCase("undefined")) && !(podate.equalsIgnoreCase("")) && !(podate.equalsIgnoreCase("0"))){    
	  	    sqlStartDate = commonDAO.changeStringtoSqlDate(podate);                       
	    }    	
		ArrayList<String> gridarray=new ArrayList<String>(); 
		ArrayList<String> subarray=new ArrayList<String>(); 
		
		String straccdata="select (select coalesce(acno,0) acno from my_account where codeno='MAINTENANCE INVOICE') incomeacno,(select coalesce(acno,0) acno from my_account where codeno='MRF ACCOUNT') mrfacno,(select acno from my_account where codeno='MAINTENANCE EXPENSE') expacno";
	     ResultSet rs=stmt2.executeQuery(straccdata);                              
		 while(rs.next()){  
				incomeacno=rs.getString("incomeacno");    
				//mrfacno=rs.getString("mrfacno");  
				expacno=rs.getString("expacno"); 
				//mrfaccname="MRF ACCOUNT";   
				incomeaccname="MAINTENANCE INVOICE";
				expaccname="MAINTENANCE EXPENSE";
		 } 
		 String strcountdata="select coalesce(hm.description,'') mrfaccname,coalesce(hm.doc_no,'') mrfacno,coalesce(hp.atype,'') patype,coalesce(ht.atype,'') tatype,coalesce(hp.doc_no,'') owneracno,coalesce(ht.doc_no,'') tenantacno,coalesce(hp.description,'') owneraccname,coalesce(ht.description,'') tenantaccname,coalesce(m.paytype,'') paytype,coalesce(j.job_desc,0) job,round(coalesce(m.total,0),2) total,m.rowno  from re_mreqmgmt m left join re_mreq r on r.doc_no=m.rdocno left join rl_jobmaster j on j.doc_no=m.jobdocno left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join my_head hp on hp.doc_no=p.acno left join my_head hm on hm.doc_no=p.mrf_acno left join my_head ht on ht.doc_no=ac.acno where m.rowno in("+rowarray+") order by m.paytype";          
		//System.out.println("strcountdata--->>>"+strcountdata);                                                             
		ResultSet rs5=stmt2.executeQuery(strcountdata);                
		while(rs5.next()){
   	         t1=rs5.getString("paytype");      
   	           //System.out.println("paytype<<<--->>>"+t1);        
			   //System.out.println(t1+"<t1<<--->>t2>"+t2);             
			 if(i==0){ 
				 paytype=rs5.getString("paytype");
				 //System.out.println(paytype+"--->>>in 1");
				 if(paytype.equalsIgnoreCase("Tenant")){                        
					 accdoc=rs5.getString("tenantacno");
					 accname=rs5.getString("tenantaccname");  
					 actype=rs5.getString("tatype");
				 }else if(paytype.equalsIgnoreCase("Owner")){
					 //System.out.println("====accdoc=="+rs5.getString("owneracno")+"===accname="+rs5.getString("owneraccname")); 
					 accdoc=rs5.getString("owneracno");      
					 accname=rs5.getString("owneraccname");  
					 actype=rs5.getString("patype");
				 }else if(paytype.equalsIgnoreCase("MRF")){  
					 accdoc=rs5.getString("mrfacno");     
					 accname=rs5.getString("mrfaccname");  
					 actype="GL"; 
				 }else if(paytype.equalsIgnoreCase("Expenses")){            
					 accdoc=expacno;
					 accname=expaccname; 
					 actype="GL"; 
				 }else{    
					 accdoc="";
					 accname=""; 
					 actype=""; 
				 }
				 //System.out.println("====accdoc=="+accdoc+"===accname="+accname);    
				 descptn=rs5.getString("job");
				 maindesc=desc+" - "+descptn+" (see Maint. Inv. for more details)";
				 amount=rs5.getDouble("total");  
			     rowno=rowno+rs5.getString("rowno")+",";    
				 total=0.0;   
				 vatamt=0.0;
				 netamt=0.0;
				 vatper=0.0;
				if(inclusive.equalsIgnoreCase("NO")){            
						   vatper=5.0;
						   vatamt=commonDAO.round((amount*5)/100,session);      
						   total=commonDAO.round(amount,session);
						   netamt=commonDAO.round(amount+vatamt,session);
					   }else{
						   vatper=5.0;
						   vatamt=commonDAO.round(amount-((amount/105)*100),session);    
						   total=commonDAO.round(amount-vatamt,session);
						   netamt=commonDAO.round(amount,session);            
				}
				nettotal=nettotal+netamt;
				gridarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: "); 
			 }else if(t1.equalsIgnoreCase(t2)){       
				 //System.out.println("--->>>in 2"+rs5.getString("paytype"));
				 paytype=rs5.getString("paytype");  
				 /* if(paytype.equalsIgnoreCase("Tenant")){                        
					 accdoc=rs5.getString("tenantacno");
					 accname=rs5.getString("tenantaccname");  
					 actype=rs5.getString("tatype");
				 }else if(paytype.equalsIgnoreCase("Owner")){    
					 accdoc=rs5.getString("owneracno");
					 accname=rs5.getString("owneraccname");  
					 actype=rs5.getString("patype");
				 }if(paytype.equalsIgnoreCase("MRF")){  
					 accdoc=mrfacno;
					 accname=mrfaccname; 
					 actype="GL"; 
				 }if(paytype.equalsIgnoreCase("Expenses")){            
					 accdoc=expacno;
					 accname=expaccname; 
					 actype="GL"; 
				 }else{    
					 accdoc="";
					 accname=""; 
					 actype=""; 
				 } */
				 descptn=rs5.getString("job");
				 amount=rs5.getDouble("total");  
			     rowno=rowno+rs5.getString("rowno")+",";    
				 total=0.0;   
				 vatamt=0.0;
				 netamt=0.0;
				 vatper=0.0;
				 if(inclusive.equalsIgnoreCase("NO")){            
					   vatper=5.0;
					   vatamt=commonDAO.round((amount*5)/100,session);      
					   total=commonDAO.round(amount,session);
					   netamt=commonDAO.round(amount+vatamt,session);
				   }else{
					   vatper=5.0;
					   vatamt=commonDAO.round(amount-((amount/105)*100),session);    
					   total=commonDAO.round(amount-vatamt,session);
					   netamt=commonDAO.round(amount,session);            
			     }
				nettotal=nettotal+netamt;    
				gridarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: "); 
			 }else{
				    //System.out.println("--->>>in 3 "+gridarray);
				    //System.out.println("--->>>in 3 "+accdoc);
				    rowno=rowno+"0";             
				    trnosss=DAO.insert(sqlStartDate,sqlStartDate,"",refno,actype,accdoc,accname,"1","1","","",maindesc,session,"A",nettotal,gridarray,"PRIV",request,sqlStartDate,pono,"",1,5.0,"","",subarray,0);  
				    trvocno=Integer.parseInt(request.getAttribute("vocno").toString());  
					if(trnosss>0){
							if(inclusive.equalsIgnoreCase("NO")){            
								   id=0;
							   }else{
								   id=1;               
						     }
							String strupdate="update re_mreqmgmt set invdoc="+trnosss+",invvoc="+trvocno+",invinclusive="+id+" where rowno in("+rowno+")";           
							//System.out.println("strupdate--->>>"+strupdate);      
							val1=stmt.executeUpdate(strupdate); 
							String strinvup="update rl_prinvm set manual=4 where doc_no='"+trnosss+"'";           
							//System.out.println("strinvup--->>>"+strinvup);           
							val1=stmt.executeUpdate(strinvup); 
						} 
						 rowno="";
						 maindesc="";
						 nettotal=0.0;
						 paytype=rs5.getString("paytype");
						 //System.out.println("=== "+paytype);
						 if(paytype.equalsIgnoreCase("Tenant")){                        
							 accdoc=rs5.getString("tenantacno");
							 accname=rs5.getString("tenantaccname");  
							 actype=rs5.getString("tatype");
						 }else if(paytype.equalsIgnoreCase("Owner")){    
							 accdoc=rs5.getString("owneracno");
							 accname=rs5.getString("owneraccname");  
							 actype=rs5.getString("patype");
						 }else if(paytype.equalsIgnoreCase("MRF")){  
							 accdoc=rs5.getString("mrfacno");  
							 accname=rs5.getString("mrfaccname"); 
							 actype="GL"; 
						 }else if(paytype.equalsIgnoreCase("Expenses")){            
							 accdoc=expacno;
							 accname=expaccname; 
							 actype="GL"; 
						 }else{    
							 accdoc="";
							 accname=""; 
							 actype=""; 
						 }
						 //System.out.println("====accdoc=="+accdoc+"===accname="+accname); 
						 descptn=rs5.getString("job");
						 maindesc=desc+" - "+descptn+" (see Maint. Inv. for more details)";         
						 amount=rs5.getDouble("total");  
					     rowno=rowno+rs5.getString("rowno")+",";    
						 total=0.0;   
						 vatamt=0.0;
						 netamt=0.0;
						 vatper=0.0;
						 if(inclusive.equalsIgnoreCase("NO")){            
							   vatper=5.0;
							   vatamt=commonDAO.round((amount*5)/100,session);      
							   total=commonDAO.round(amount,session);
							   netamt=commonDAO.round(amount+vatamt,session);
						   }else{
							   vatper=5.0;
							   vatamt=commonDAO.round(amount-((amount/105)*100),session);    
							   total=commonDAO.round(amount-vatamt,session);
							   netamt=commonDAO.round(amount,session);            
					}  
						nettotal=nettotal+netamt; 
						invvocno=invvocno+trvocno+",";       
						gridarray=new ArrayList<String>();               
						gridarray.add("0" + "::" + 1 + " :: " + descptn + " :: " + total + " :: " + total + " :: " + 0 + " :: " + total + " :: " + vatper + " :: " + vatamt + " :: " + netamt + " :: " + 0 + " :: " + "" + " :: " + "" + " :: " + "" + " :: " + incomeacno + " :: " + "aa" + " :: ");
			 }
			  t2=rs5.getString("paytype");  
			  //System.out.println("<<<--->>>"+i);        
			  i++; 
          }
		   rowno=rowno+"0"; 
		   //System.out.println(gridarray+"<<<-----accdoc---->>>"+accdoc);     
		   trnosss=DAO.insert(sqlStartDate,sqlStartDate,"",refno,actype,accdoc,accname,"1","1","","",maindesc,session,"A",nettotal,gridarray,"PRIV",request,sqlStartDate,pono,"",1,5.0,"","",subarray,0);  
		   //System.out.println(trnosss+"<<<---trnosss");     
		   trvocno=Integer.parseInt(request.getAttribute("vocno").toString());   
		if(trnosss>0){
				if(inclusive.equalsIgnoreCase("NO")){            
					   id=0;
				   }else{
					   id=1;                   
			     }          
				String strupdate="update re_mreqmgmt set invdoc="+trnosss+",invvoc="+trvocno+",invinclusive="+id+" where rowno in ("+rowno+")";           
				//System.out.println("strupdate--->>>"+strupdate);      
				val1=stmt.executeUpdate(strupdate); 
				String strinvup="update rl_prinvm set manual=4 where doc_no='"+trnosss+"'";           
				//System.out.println("strinvup--->>>"+strinvup);           
				val1=stmt.executeUpdate(strinvup);
			}  
		 invvocno=invvocno+trvocno+"";  
		 if(val1>0){
			    String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MAPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Property Invoice created')";            
				System.out.println(sql2);                 
				val1=stmt.executeUpdate(sql2);   
		 }
	     conn.commit();                             
  		 response.getWriter().write(trnosss+"###"+invvocno);                               
	 	 conn.close();       
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>