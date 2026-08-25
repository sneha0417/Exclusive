  
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
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>
 

<%
  
ClsServiceSaleDAO srDAO=new ClsServiceSaleDAO();
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String desc1=request.getParameter("desc1");
 
	String podate=request.getParameter("podate");
	String pono=request.getParameter("pono");
	String taxperc=request.getParameter("taxperc");
	String nettotals=request.getParameter("nettotal");
	
/* System.out.println("===docno="+docno);
System.out.println("===branchids="+branchids);
System.out.println("===desc1="+desc1);
System.out.println("===podate="+podate);
System.out.println("===pono="+pono);
	 */
	
 	 Connection conn1=null;
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
//	System.out.println("===list="+list);
	
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
 	session.setAttribute("BRANCHID", branchids);
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
			   java.sql.Date podates=null;
			   
			   if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
				{
				   podates=ClsCommon.changeStringtoSqlDate(podate);
					
				}
				else{
	
				}
			   
			   
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
					
					
					
 
					 int acno=0;
				 
					 int curid=1;
					 double rate=1;
					 double nettotal=Double.parseDouble(nettotals);
					 int voc_no=0;
					   java.sql.Date sqlStartDate1=null;
					 String atype="";
					      String sqlsal="select  m.nettotal netval,  m.acno,h.atype,h.curid,h.rate,m.date date,m.voc_no voc_no,h.description client,"
				              +" round(m.taxamount,2) taxvalue ,round(m.invvalue,2) nettotal,s.sal_name salesman,m.lpono,round(m.totalamount,2) total,round(m.discount,2) discount ,m.remarks "
				              +" from my_cutinvm m inner join my_cutinvd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
				              +" left join my_salm s on m.sal_id=s.doc_no   left join my_acbook ac on ac.acno=m.acno  "
				            		  +"   where m.status=3  and m.doc_no="+docno+" group by m.doc_no";
				
					 ResultSet rss=stmt.executeQuery(sqlsal);
					 
					 if(rss.next())
					 {
						 sqlStartDate1=rss.getDate("date");
						 atype=rss.getString("atype");
						 acno=rss.getInt("acno");
						 curid=rss.getInt("curid");
						 
						 rate=rss.getDouble("rate");
						 
						 voc_no=rss.getInt("voc_no");
					 }
					 
					 if(rate==0){rate=1.00;}
					  
					 if(curid==0){curid=1;}
					 
					 System.out.println("=====nettotal==="+nettotal);
					
					  val=srDAO.insert(sqlStartDate1,sqlStartDate1,"INV-"+voc_no,"",atype,""+acno,"", 
							  ""+curid,""+rate,"","",desc1,session,"A",nettotal,proday,"SRS",
							request,podates,pono,podate,0,Double.parseDouble(taxperc));
		 
		 
	   if(val>0)
		 {//
		   
		   String sqldata="update my_cutinvm set clstatus=1 where doc_no="+docno+"";
		   stmt.executeUpdate(sqldata);
		   conn.commit();  
		   
		   try
        	 {
          	conn1 = ClsConnection.getMyConnection();
       		Statement stmt11=conn1.createStatement();
   		  int jobno=0;   
   		  int tno=0;   
   				String sql="select case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
         			+ " when m.costtype in(5) then cs.doc_no  end as 'costcodeno' from my_cutinvm m "
         			+ " left join my_costunit u on u.costtype=m.costtype  "
         			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
         			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
         			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5    where   m.status=3 and    m.doc_no="+docno+" group by m.doc_no " ;
   		 		ResultSet rsds=stmt11.executeQuery(sql);
		   		 if(rsds.first())
		   		 {
		   			 jobno=rsds.getInt("costcodeno");
		   			
		   		 }
   		 
		   		 String sqlss="select max(tr_no) tr_no from my_jvtran where  acno="+acno+" limit 1 ";
		   		 ResultSet rsds1=stmt11.executeQuery(sqlss);
		   		 if(rsds1.first())
		   		 {
		   			 tno=rsds1.getInt("tr_no");
		   			
		   		 }
	   		   	String sqldata1="update my_jvtran set rdocno="+jobno+" where tr_no="+tno+" and acno="+acno+" ";
	   			stmt11.executeUpdate(sqldata1);
	   			conn1.close();
   		   
         	}
          catch(Exception e){
        		conn1.close();
                     }
		   
		   
		 }			
		conn.close();
		System.out.println("==conn==="+val);
		if(val>0)
		{
			response.getWriter().print(val);
		}
		else
		{
			response.getWriter().print(0);
		}
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 		}
	
	%>
