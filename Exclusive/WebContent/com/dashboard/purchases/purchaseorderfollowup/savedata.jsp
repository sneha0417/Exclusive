 
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
<%@page import="com.dashboard.purchases.purchaseorderfollowup.ClsPurchaseorderFollowupDAO"%>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>

<%	
    ClsPurchaseorderFollowupDAO saveDAO=new ClsPurchaseorderFollowupDAO();
ClspurchaseinvoiceDAO ClspurchaseinvoiceDAO=new ClspurchaseinvoiceDAO();
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
	String cmbText=request.getParameter("cmbText") ;
	String statuschg=request.getParameter("statuschg");
	String invdate=request.getParameter("invdate");
	String invno=request.getParameter("invno");
	String txtlocationid=request.getParameter("txtlocationid")==null?"0":request.getParameter("txtlocationid");
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
 
	
	String refrowno="0";
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;

	 String upsql=null;
	 int val=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	
	   
	
	   if(cmbinfo.equalsIgnoreCase("1"))
	   {
		   if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
			{
			sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
				
			}
			else{

			}
		   int ddocno=0;
		   String sqls=" select   rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where dtype='BPOF') and srno='"+cmbinfo+"' ";
		   ResultSet rsss=stmt.executeQuery(sqls);
		   
			   if(rsss.next())
			   {
				   ddocno= rsss.getInt("rowno");
			   }
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from my_bpof";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		     upsql="insert into my_bpof (doc_no,date, rdocno, bibpid, fdate, remarks, userid, status,refrowno)values('"+docval+"',now(),'"+docno+"','"+ddocno+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,'"+refrowno+"') ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BPOF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  }
		   else if(cmbinfo.equalsIgnoreCase("2"))
		   {
		     String sqlss="update my_ordm set statuschg='"+statuschg+"' where doc_no='"+docno+"' ";
		     val= stmt.executeUpdate(sqlss);
		   }
		   else if(cmbinfo.equalsIgnoreCase("3"))
		   {
			   java.sql.Date invDates=null;
			   
			   if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0")))
				{
				   invDates=ClsCommon.changeStringtoSqlDate(invdate);
					
				}
				else{
	
				}
			   
			   
			   
				String refNo="",description="";
				String payterms="",delterms="";
				
				int acno=0,curId=1,disstatus=0,siteid=0,locId=0,cldocno=0,brhid=0,costtype=0,costcode=0;
				double rate=1,amount=0,disper=0,discount=0,roundVal=0,netAmount=0,supplExp=0,nettotal=0,prddiscount=0,nettaxamount=0;
				String costsql="";
				int cosrcodemethod=0;			
				Statement coststmt=conn.createStatement();
				String chks="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rss1=coststmt.executeQuery(chks); 
				if(rss1.next())
				{
					cosrcodemethod=rss1.getInt("method");
				}
				
				if(cosrcodemethod>0) 
				{
					costsql= " costtype,costcode, " ;
				}
				
				int billtype=0;
				
				java.sql.Date dates=null,deldate=null;
				String mastersql=" select "+costsql+"  m.brhid,coalesce(m.billtype,0) billtype, m.refno,m.date,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper , "
						     + " m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate  "
						     + " from my_ordm m where doc_no='"+docno+"'";
				ResultSet rsmatersel=stmt.executeQuery(mastersql);
					if(rsmatersel.next())
					{
						
						brhid=rsmatersel.getInt("brhid");
						refNo=rsmatersel.getString("refno");
						dates=rsmatersel.getDate("date");
						description=rsmatersel.getString("description");
						payterms=rsmatersel.getString("payterms");
						delterms=rsmatersel.getString("delterms");
						deldate=rsmatersel.getDate("deldate");
						rate=rsmatersel.getDouble("rate");
						billtype=rsmatersel.getInt("billtype");
						//amount=rsmatersel.getDouble("amount");	
						//disper=rsmatersel.getDouble("disper");
						//discount=rsmatersel.getDouble("discount");	
						//roundVal=rsmatersel.getDouble("roundVal");	
						//netAmount=rsmatersel.getDouble("netAmount");	
						//supplExp=rsmatersel.getDouble("supplExp");
						//nettotal=rsmatersel.getDouble("nettotal");	
						//prddiscount=rsmatersel.getDouble("prddiscount");	
					//	disstatus=rsmatersel.getInt("disstatus");	
						acno=rsmatersel.getInt("acno");	
						curId=rsmatersel.getInt("curId");	
						
						
						if(cosrcodemethod>0) 
						{
							
							costtype=rsmatersel.getInt("costtype");
							costcode=rsmatersel.getInt("costcode");
							
							
						}
						
						roundVal=0;
						disper=0;
						disstatus=0;
						roundVal=0;
						supplExp=0;
					
					
					}
			   session.setAttribute("BRANCHID", brhid);
				ArrayList<String> proday= new ArrayList<String>();
				String aa[]=list.split(",");
					for(int i=0;i<aa.length;i++){
						 String bb[]=aa[i].split("::");
						 String temp="";
						 for(int j=0;j<bb.length;j++){ 
							 temp=temp+bb[j]+"::";
						}
						 proday.add(temp);
					  } 
					
					
					ArrayList<String> masterarray= new ArrayList<String>();
					ArrayList<String> descarray= new ArrayList<String>();
					ArrayList<String> exparray= new ArrayList<String>();
					for(int k=0;k<proday.size();k++)
					{
						String[] prod=((String) proday.get(k)).split("::"); 
						String psrno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
				 
						
						int prdid=Integer.parseInt(psrno);
						int unitid=0,specno=0;
						double mqty=0,mamount=0,mtotal=0,mdiscount=0,mnettotal=0,mdisper=0,omqty=0,taxpers=0,taxamounts=0,nettax=0;
						
						String taxadocno="0";
						
					  	String sqlsel=" select psrno,prdId,unitid,qty-out_qty qty, amount,ROUND(amount*(qty-out_qty),2) total, "
					  			+" ROUND(amount*(qty-out_qty)*disper/100,2)  discount,  ROUND((amount*(qty-out_qty)-(amount*(qty-out_qty)*disper/100)),2) "
					  			+"   nettotal,taxdocno,specno,disper,taxper,round(((amount*(qty-out_qty)-(amount*(qty-out_qty)*disper/100))*taxper/100),2) taxamount,((amount*(qty-out_qty)-(amount*(qty-out_qty)*disper/100))+((amount*(qty-out_qty)-(amount*(qty-out_qty)*disper/100))*taxper/100)) nettaxamount from my_ordd where rdocno="+docno+" and psrno='"+psrno+"' " ; 
						   System.out.println("===sqlsel====="+sqlsel);
						   
						//  amount netAmount nettotal
						ResultSet rssel=stmt.executeQuery(sqlsel);
							if(rssel.next())
							{
								prdid=rssel.getInt("prdId");	
								specno=rssel.getInt("specno");	
								unitid=rssel.getInt("unitid");	
								mqty=rssel.getDouble("qty");
								mamount=rssel.getDouble("amount");
								mtotal=rssel.getDouble("total");
								mdiscount=rssel.getDouble("discount");
								mdisper=rssel.getDouble("disper");
								mnettotal=rssel.getDouble("nettotal");
								omqty=rssel.getDouble("qty");
								taxpers=rssel.getDouble("taxper");
								taxamounts=rssel.getDouble("taxamount");
								nettax=rssel.getDouble("nettaxamount");
								taxadocno=rssel.getString("taxdocno");
								
								amount=amount+mamount;
								prddiscount=prddiscount+mdiscount;
								netAmount=netAmount+mnettotal;
								nettaxamount=nettaxamount+taxamounts;
								 
								
								
								
								
							}
							masterarray.add(psrno+"::"+prdid+" :: "+unitid+" :: "+mqty+" :: "+mamount+" :: "+mtotal+" :: "+mdiscount+" :: "+mnettotal+" :: "+mqty
									   +" :: "+0+" :: "+specno+" :: "+mdisper+" :: "+0+" :: "+0+" :: "+0+" :: "+mdisper+" :: "+mamount+"::"+taxpers+"::"+taxamounts+"::"+nettax+"::"+0+"::"+0+"::"+taxadocno+"::"+"0000"+"::"); 
							 
							
 
							
							
					}
					
				/* 		 int ssreno=0;
						String sdesc1="";
						double sqty=0,sunitprice=0,stotal=0,sdiscount=0,snettotal=0;
						
						Statement stmStatement=conn.createStatement();
						
					  	String sqlsel11=" select srno sr_no,qty,desc1,unitprice,total,discount,nettotal from  my_ordser where rdocno="+docno+"  " ; 
					  	
					    System.out.println("===sqlsel11====="+sqlsel11);
						ResultSet rssel111=stmStatement.executeQuery(sqlsel11);
							if(rssel111.next())
							{
								sqty=rssel111.getDouble("qty");
								sdesc1=rssel111.getString("desc1");
								sunitprice=rssel111.getDouble("unitprice");	
								stotal=rssel111.getDouble("total");
								sdiscount=rssel111.getDouble("discount");
								snettotal=rssel111.getDouble("nettotal");
								ssreno=rssel111.getInt("sr_no");
								descarray.add(ssreno+"::"+sqty+" :: "+sdesc1+" :: "+sunitprice+" :: "+stotal+" :: "+sdiscount+" :: "+snettotal+" :: "); 
								
							} */
					
							 val=ClspurchaseinvoiceDAO.insert(dates,deldate,refNo,acno,curId,rate,delterms,payterms,
									  description,amount,disper,discount,roundVal ,netAmount+nettaxamount,supplExp,
									  netAmount+nettaxamount,disstatus,session,"A","PIV",request,descarray,masterarray,"PO",
									docno,prddiscount,exparray,0.00,invDates,invno,Integer.parseInt(txtlocationid),
									nettaxamount, 0.00 ,0.00,nettaxamount,0.00,billtype,costtype,costcode,0,0);
					 // val=(int) request.getAttribute("vocno");	
					 
					
					//  System.out.println("===val=docno===="+val);
			   
		   }
	   if(val>0)
		 {//
            conn.commit();
             conn.close();
		 }			
		response.getWriter().print(val);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 		}
	
	%>
