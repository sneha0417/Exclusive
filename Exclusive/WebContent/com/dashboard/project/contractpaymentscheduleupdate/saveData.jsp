<%@page import="java.text.DecimalFormat"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();

		String docNo=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		
		String sql=null,sql1=null;
		int val = 0,docno=0;
		double netamount=0;
		
		ArrayList<String> griddataarray=new ArrayList<String>();
		String[] temparray=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);
		}
		System.out.println("==griddataarray===="+griddataarray);
		ArrayList<String> paymentdetailsarray=new ArrayList<String>();
		for(int i=0;i<griddataarray.size();i++){
			String[] temp=griddataarray.get(i).split("::");
			String duedate=temp[0];
			String amount=temp[1];
			String runtotal=temp[2];
			String desc1=temp[3];
			String terms=temp[4];
			String dueafterser=temp[5];
			String service=temp[6];
			String rowno=temp[7];
			String invtrno=temp[8];
			
			paymentdetailsarray.add(duedate+" :: "+amount+" :: "+runtotal+" :: "+desc1+" :: "+terms+" :: "+dueafterser+" :: "+service+" :: "+rowno+" :: "+invtrno);
			
		}
		System.out.println("==paymentdetailsarray===="+paymentdetailsarray);
		
		String delpyt="delete from cm_srvcontrpd where tr_no='"+docNo+"'";
		int delval=stmt.executeUpdate (delpyt);
		
		
		String pstatusupdate="update cm_srvcontrm set pstatus=0 where tr_no='"+docNo+"'";
		int pstatusval=stmt.executeUpdate (pstatusupdate);
		
		String legalupdate1="update cm_srvcontrm set islegal=0 where tr_no='"+docNo+"'";
		int legalval1=stmt.executeUpdate (legalupdate1);
		
		for(int i=0;i< paymentdetailsarray.size();i++){


			String[] surveydet=((String) paymentdetailsarray.get(i)).split("::");
			if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
			{		

				if (surveydet[4].contains("LEGAL DOCUMENT")) {
					surveydet[5]="99";
					String legalupdate="update cm_srvcontrm set islegal=1 where tr_no='"+docNo+"'";
					int legalval=stmt.executeUpdate (legalupdate);
				}
				if (surveydet[4].contains("SERVICE")) {
					surveydet[5]=surveydet[6];
				}
				if (surveydet[4].contains("PROFORMA INVOICE")) {
					surveydet[5]="98";
					 pstatusupdate="update cm_srvcontrm set pstatus=1 where tr_no='"+docNo+"'";
					 pstatusval=stmt.executeUpdate (pstatusupdate);
				}
				
				if(!(surveydet[7].trim().equalsIgnoreCase("undefined")|| surveydet[7].trim().equalsIgnoreCase("NaN")||surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()))
				{
					
					sql1="INSERT INTO cm_srvcontrpd(sr_no,dueDate,amount,runtotal,description,terms,dueafser,serviceno,rowno,invtrno,tr_no) VALUES"
							+ " ("+(i+1)+","
							+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?"0":ClsCommon.changetstmptoSqlDate(surveydet[0].trim()))+"',"
							+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"0":surveydet[1].trim())+"',"
							+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"":surveydet[2].trim())+"',"
							+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?"":surveydet[3].trim())+"',"
							+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?"":surveydet[4].trim())+"',"
							+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"0":surveydet[5].trim())+"',"
							+ "'"+(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?"0":surveydet[6].trim())+"',"
							+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?"0":surveydet[7].trim())+"',"
							+ "'"+(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?"0":surveydet[8].trim())+"',"
							+"'"+docNo+"')";
					if(!(surveydet[8].trim().equalsIgnoreCase("undefined")|| surveydet[8].trim().equalsIgnoreCase("NaN")||surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()))
					{
						int invtrno=Integer.parseInt(surveydet[8].trim());
						if(invtrno>0){
							int inctax=0,invupstatus=0;
							double amount=0,taxamt=0,nettaxamount=0,legalchrg=0;
							String clacc="",txacc="",sjobacc="",amcacc="",dType="";
							
							String contrsql="select inctax from cm_srvcontrm where tr_no="+docNo;
							ResultSet rs=stmt.executeQuery(contrsql);
							while(rs.next()){
								inctax=rs.getInt("inctax");
							}
							DecimalFormat df=new DecimalFormat("#.##");
							if(inctax>0){
								nettaxamount=Double.parseDouble(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"0":surveydet[1].trim());
								amount=Double.valueOf(df.format((nettaxamount/105)*100));
								taxamt=Double.valueOf(df.format(nettaxamount-amount));
							}
							else{
								amount=Double.parseDouble(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"0":surveydet[1].trim());
								taxamt=Double.valueOf(df.format((amount*0.05)));
								nettaxamount=Double.valueOf(df.format(amount+taxamt));
							}
							String sqlup1="update my_servm set NETAMOUNT="+nettaxamount+",ATOTAL="+amount+",TAXAMT="+taxamt+" where tr_no="+invtrno+"";
 							System.out.println("sqlup1==="+sqlup1);
							String sqlup2="update MY_INVTAXDET set AMOUNT="+taxamt+" where rdocno="+invtrno+"";
 							System.out.println("sqlup2==="+sqlup2);
							
							String sqlacc="select m.legalChrg,m.dType,ac.acno clacc,coalesce(tx.acno,0) taxacc1,acc1.acno sjobacc,acc2.acno amcacc from cm_srvcontrm m "
									+" left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcontrpd pd on pd.tr_no=m.tr_no "
									+" left join MY_INVTAXDET tx on tx.rdocno=pd.invtrno left join my_account acc1 on acc1.codeno='SJOB INCOME' "
									+" left join my_account acc2 on acc2.codeno='AMC INCOME' where m.tr_no="+docNo+" ";
 							System.out.println("sqlacc11==="+sqlacc);
							ResultSet rs2=stmt.executeQuery(sqlacc);
							while(rs2.next()){
								clacc=rs2.getString("clacc");
								
								sjobacc=rs2.getString("sjobacc");
								amcacc=rs2.getString("amcacc");
								dType=rs2.getString("dType");
								legalchrg=rs2.getDouble("legalChrg");
								
							}
							String sqlacc11="select coalesce(tx.acno,0) taxacc1 from my_invtaxdet tx where tx.rdocno="+invtrno;
							ResultSet rs22=stmt.executeQuery(sqlacc11);
							while(rs22.next()){
								txacc=rs22.getString("taxacc1");
 								System.out.println("txacc==="+rs22.getInt("taxacc1"));
							}
							
							String sqljv1="update MY_JVTRAN set dramount="+( nettaxamount+legalchrg)+",ldramount="+(nettaxamount+legalchrg)+" where tr_no="+invtrno+" and acno="+clacc+"";
 							System.out.println("sqljv1==="+sqljv1);
 							String sqljv2="";
 							if(txacc!=""){
							sqljv2="update MY_JVTRAN set dramount="+(-1*taxamt)+",ldramount="+(-1*taxamt)+" where tr_no="+invtrno+" and acno="+txacc+"";
 							System.out.println("sqljv2==="+sqljv2);
 							}
							String sqljv3="";
							if(dType.equalsIgnoreCase("SJOB")){
								sqljv3="update MY_JVTRAN set dramount="+(-1*amount)+",ldramount="+(-1*amount)+" where tr_no="+invtrno+" and acno="+sjobacc+"";
 								System.out.println("sqljv3==="+sqljv3);
							}
							else if(dType.equalsIgnoreCase("AMC")){
								sqljv3="update MY_JVTRAN set dramount="+(-1*amount)+",ldramount="+(-1*amount)+" where tr_no="+invtrno+" and acno="+amcacc+"";
 								System.out.println("sqljv3==="+sqljv3);
							}
							
							invupstatus=stmt.executeUpdate (sqlup1);
							invupstatus=stmt.executeUpdate (sqlup2);
							invupstatus=stmt.executeUpdate (sqljv1);
							if(txacc!=""){
							invupstatus=stmt.executeUpdate (sqljv2);
							}
							invupstatus=stmt.executeUpdate (sqljv3);
 							System.out.println("===amount"+amount+"--taxamt--"+taxamt+"--nettaxamount--"+nettaxamount);
							/* if(invupstatus<=0){
							    stmt.close();
								conn.close();
							}	 */
							
						}
					}
					
					
				
				} else {
					
					sql1="INSERT INTO cm_srvcontrpd(sr_no,dueDate,amount,runtotal,description,terms,dueafser,serviceno,invtrno,tr_no) VALUES"
							+ " ("+(i+1)+","
							+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?"0":ClsCommon.changetstmptoSqlDate(surveydet[0].trim()))+"',"
							+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"0":surveydet[1].trim())+"',"
							+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"":surveydet[2].trim())+"',"
							+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?"":surveydet[3].trim())+"',"
							+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?"":surveydet[4].trim())+"',"
							+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"0":surveydet[5].trim())+"',"
							+ "'"+(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?"0":surveydet[6].trim())+"',"
							+ "'"+(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?"0":surveydet[8].trim())+"',"
							+"'"+docNo+"')";
					
				}
				
				val = stmt.executeUpdate (sql1);
				if(val<=0){
				    stmt.close();
					conn.close();
				}	
				netamount+=Double.parseDouble(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"0":surveydet[1].trim());
			}

		}
		
		String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bpsu";
        ResultSet resultSets = stmt.executeQuery(sqls);
  
        while (resultSets.next()) {
		   docno=resultSets.getInt("doc_no");
        }
        
        /*Inserting gl_bpsu*/
	     String sql2="insert into gl_bpsu(doc_no, date, tr_no, userid) values("+docno+", now(), '"+docNo+"', '"+session.getAttribute("USERID").toString()+"')";
	     val= stmt.executeUpdate(sql2);
		 if(val<=0){
			    stmt.close();
				conn.close();
			}
		 /*Inserting gl_bpsu Ends*/
		
		
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','BPSU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
	     val= stmt.executeUpdate(sql);
	     if(val>0){
	    	 String sqlupcontr="update cm_srvcontrm set netamount="+netamount+",contractval="+netamount+" where tr_no="+docNo+"";
// 				System.out.println("sqlupcontr==="+sqlupcontr);
				val=stmt.executeUpdate(sqlupcontr);
	     }
	     
	     
		
	     if(val>0){
	 	 	conn.commit();
	    	stmt.close();
	 	 	conn.close();
	     }
	     response.getWriter().print(val+"***"+docNo);
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>

