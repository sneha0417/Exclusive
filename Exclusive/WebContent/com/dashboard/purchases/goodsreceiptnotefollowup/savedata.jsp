 
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
<%@page import="com.dashboard.purchases.goodsreceiptnotefollowup.ClsGoodsReceiptNoteFollowupDAO"%>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<%	
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
	String cmbText=request.getParameter("cmbText") ;
	String statuschg=request.getParameter("statuschg");
	String invdate=request.getParameter("invdate");
	String invno=request.getParameter("invno");
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
	ClsGoodsReceiptNoteFollowupDAO saveDAO=new ClsGoodsReceiptNoteFollowupDAO();
		ClspurchaseinvoiceDAO ClspurchaseinvoiceDAO=new ClspurchaseinvoiceDAO();
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
		   String sqls=" select   rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where dtype='BGRNF') and srno='"+cmbinfo+"' ";
		   ResultSet rsss=stmt.executeQuery(sqls);
		   
			   if(rsss.next())
			   {
				   ddocno= rsss.getInt("rowno");
			   }
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from my_bgrnf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		     upsql="insert into my_bgrnf (doc_no,date, rdocno, bibpid, fdate, remarks, userid, status,refrowno)values('"+docval+"',now(),'"+docno+"','"+ddocno+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,'"+refrowno+"') ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BGRNF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  }
		   else if(cmbinfo.equalsIgnoreCase("2"))
		   {
		     String sqlss="update my_grnm set statuschg='"+statuschg+"' where doc_no='"+docno+"' ";
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
				int acno=0,curId=1,disstatus=0,siteid=0,locId=0,cldocno=0,brhid=0,txtlocationid=0,costtype=0,costcode=0;
				double rate=1,amount=0,disper=0,discount=0,roundVal=0,netAmount=0,supplExp=0,nettotal=0,prddiscount=0;
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
				
				java.sql.Date dates=null,deldate=null;
				String mastersql=" select  "+costsql+" m.locid,m.brhid, m.refno,m.date,m.acno,m.curId,m.rate,m.amount,m.disper , "
						     + " m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate  "
						     + " from my_grnm m where doc_no='"+docno+"'";
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
						txtlocationid=rsmatersel.getInt("locid");
						
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
					
					Statement tempstamt=conn.createStatement();
					for(int k=0;k<proday.size();k++)
					{
						if(k==0){String sqssl="truncate my_bgrnfd";
						tempstamt.executeUpdate(sqssl);}
					     String[] detmasterarrays=((String) proday.get(k)).split("::"); 
			             String insql="INSERT INTO my_bgrnfd(sr_no,psrno,specno,unitid,qty,amount,total,disper,discount,nettotal,stockid,tr_no,rdocno)VALUES"
					       + " ("+(k+1)+","
					       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
					       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
					       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
					       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
					       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
					       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
					       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
					       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
					       + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
					       + "'"+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"',"
					       +"'"+docno+"','"+docno+"')";
					     int resultSet2 = tempstamt.executeUpdate(insql);
						
					}
					ArrayList<String> masterarray= new ArrayList<String>();
					ArrayList<String> descarray= new ArrayList<String>();
					ArrayList<String> exparray= new ArrayList<String>();
					for(int k=0;k<proday.size();k++)
					{
						String[] prod=((String) proday.get(k)).split("::"); 
						String psrno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						String stockid=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";
						 
						
						int prdid=Integer.parseInt(psrno);
						int unitid=0,specno=0;
						double mqty=0,mamount=0,mtotal=0,mdiscount=0,mnettotal=0,mdisper=0,omqty=0;
						
						
						
					  	String sqlsel=" select psrno,unitid, qty, amount,  total, "
					  			+"    discount,   nettotal,specno,disper  from my_bgrnfd where rdocno="+docno+" and psrno='"+psrno+"' and stockid="+stockid+" " ; 
						//   System.out.println("===sqlsel====="+sqlsel);
						   
						//  amount netAmount nettotal
						ResultSet rssel=stmt.executeQuery(sqlsel);
							if(rssel.next())
							{
								prdid=rssel.getInt("psrno");	
								specno=rssel.getInt("specno");	
								unitid=rssel.getInt("unitid");	
								mqty=rssel.getDouble("qty");
								mamount=rssel.getDouble("amount");
								mtotal=rssel.getDouble("total");
								mdiscount=rssel.getDouble("discount");
								mdisper=rssel.getDouble("disper");
								mnettotal=rssel.getDouble("nettotal");
								omqty=rssel.getDouble("qty");
								amount=amount+mamount;
								prddiscount=prddiscount+mdiscount;
								netAmount=netAmount+mnettotal;
							}
							masterarray.add(psrno+"::"+prdid+" :: "+unitid+" :: "+mqty+" :: "+mamount+" :: "+mtotal+" :: "+mdiscount+" :: "+mnettotal+" :: "+mqty
									   +" :: "+0+" :: "+specno+" :: "+mdisper+" :: "+stockid+" :: "+0+" :: "+0+" :: "+mdisper+" :: "+mamount+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+"0000"+"::"); 
							
						 
					}
					
					  val=ClspurchaseinvoiceDAO.insert(dates,deldate,refNo,acno,curId,rate,delterms,payterms,
							  description,amount,disper,discount,roundVal ,netAmount,supplExp,
							  netAmount,disstatus,session,"A","PIV",request,descarray,masterarray,"GRN",
							docno,prddiscount,exparray,0.00,invDates,invno,txtlocationid,
							0.00, 0.00 ,0.00,0.00,0.00,0,costtype,costcode,0,0);
					  
			   
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
