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
<%@page import="com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO"%> 
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%> 
<%@page import="java.text.SimpleDateFormat" %>  
<%	

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;
	ClsPurchaserequestDAO sdao= new ClsPurchaserequestDAO();
	ClspurchaseorderDAO orderobj= new ClspurchaseorderDAO();

	try{
	 	conn = ClsConnection.getMyConnection();
	 	
		stmt = conn.createStatement();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
		
		
		String purchasestrarray=request.getParameter("purchasearray")==null?"":request.getParameter("purchasearray");
		String purchaserequestarray=request.getParameter("purchaserequestarray")==null?"":request.getParameter("purchaserequestarray");
		String purchaseorderarray=request.getParameter("purchaseorderarray")==null?"":request.getParameter("purchaseorderarray");
		String estimationrequestarray=request.getParameter("estimationrequestarray")==null?"":request.getParameter("estimationrequestarray");
		String estimationorderarray=request.getParameter("estimationorderarray")==null?"":request.getParameter("estimationorderarray");
		String contocno=request.getParameter("contocno")==null?"":request.getParameter("contocno");
		String conttrno=request.getParameter("conttrno")==null?"":request.getParameter("conttrno");
		String ordernet1=request.getParameter("ordernet")==null?"0":request.getParameter("ordernet");
		String ordertot1=request.getParameter("ordertot")==null?"0":request.getParameter("ordertot");
		String vendor1=request.getParameter("vendor")==null?"0":request.getParameter("vendor");
		double ordernet=Double.parseDouble(ordernet1);
		double ordertot=Double.parseDouble(ordertot1);
		int vendor=Integer.parseInt(vendor1);
		String click=request.getParameter("click")==null?"":request.getParameter("click");
		System.out.println("click=="+click);
	    System.out.println("purchasestrarray=="+purchasestrarray);
	    System.out.println("purchaserequestarray=="+purchaserequestarray);
 String sql="",sqlsub="",sql1="",sqltrno="",sqltrnosel="",sqlmatsel="";
 String rowno="0",resqty="0",purqty="0",brhid="0",psrnos="0",specno="0",locid="";
 String temp="0";
 int val=0;
 int p=0;
 int mytrno=0;
 double matresqty=0;
 double masterqty=0;
	double matpurqty=0;
	double reservqty=0;
	double resqty1=0;
	
	String sqlestsel="";
	double masterreqqty=0;
	double masterreserveqty=0;
	if(click.equalsIgnoreCase("reserve")){
		 conn.setAutoCommit(false);
 String splt[]=purchasestrarray.split(","); 
 for(int i=0;i<splt.length;i++)
 {
	 masterreserveqty=0;
	 String data[]=splt[i].split("::");
	 rowno=data[0].trim().equalsIgnoreCase("undefined") || data[0].trim().equalsIgnoreCase("NaN")|| data[0].trim().equalsIgnoreCase("")|| data[0].isEmpty()?"0":data[0].trim();
	 resqty=data[1].trim().equalsIgnoreCase("undefined") || data[1].trim().equalsIgnoreCase("NaN")|| data[1].trim().equalsIgnoreCase("")|| data[1].isEmpty()?"0":data[1].trim();
	 purqty=data[2].trim().equalsIgnoreCase("undefined") || data[2].trim().equalsIgnoreCase("NaN")|| data[2].trim().equalsIgnoreCase("")|| data[2].isEmpty()?"0":data[2].trim();
	 brhid=data[3].trim().equalsIgnoreCase("undefined") || data[3].trim().equalsIgnoreCase("NaN")|| data[3].trim().equalsIgnoreCase("")|| data[3].isEmpty()?"0":data[3].trim();
	 psrnos=data[4].trim().equalsIgnoreCase("undefined") || data[4].trim().equalsIgnoreCase("NaN")|| data[4].trim().equalsIgnoreCase("")|| data[4].isEmpty()?"0":data[4].trim();
	 specno=data[5].trim().equalsIgnoreCase("undefined") || data[5].trim().equalsIgnoreCase("NaN")|| data[5].trim().equalsIgnoreCase("")|| data[5].isEmpty()?"0":data[5].trim();
	 locid=data[6].trim().equalsIgnoreCase("undefined") || data[6].trim().equalsIgnoreCase("NaN")|| data[6].trim().equalsIgnoreCase("")|| data[6].isEmpty()?"0":data[6].trim();
	 masterqty=Double.parseDouble(resqty);
	reservqty=Double.parseDouble(resqty);
	masterreserveqty=Double.parseDouble(resqty);
	System.out.println("masterqty====="+masterqty);
	 if(masterqty>0)
	 {
		 sqltrno="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid) values("+session.getAttribute("USERID").toString()+",'BPRF',"+session.getAttribute("BRANCHID").toString()+",curdate(),0)";
		 System.out.println("sqltrno====="+sqltrno);
		 stmt.executeUpdate(sqltrno);
		
		sqltrnosel="select max(trno) mytrno from my_trno";
		ResultSet rstrno = stmt.executeQuery(sqltrnosel);
		while(rstrno.next()) {
			
			mytrno=rstrno.getInt("mytrno");
		}
	
 double delqtys=0;
	double balstkqty=0;
   int psrno=0;
	double ckkqty=0;
	int stockid=0;
	double remstkqty=0;
	double outstkqty=0;
	double stkqty=0;
	double qty=0;
	double detqty=0;
	double focmasterqty=0.0;
	int locidss=0;

	String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,"
			+ " (rsv_qty+out_qty+del_qty) out_qty,rsv_qty as qty,date from my_prddin "
			+ "where psrno="+psrnos+" and specno="+specno+" and prdid="+psrnos+" and brhid="+brhid+" "
			+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

	System.out.println("=stkSql======11=======inside insert="+stkSql);

	ResultSet rsstk = stmt.executeQuery(stkSql);

	while(rsstk.next()) {
		System.out.println("---loop---"+p++);

		balstkqty=rsstk.getDouble("balstkqty");
		psrno=rsstk.getInt("psrno");
		outstkqty=rsstk.getDouble("out_qty");
		stockid=rsstk.getInt("stockid");
		stkqty=rsstk.getDouble("stkqty");
		qty=rsstk.getDouble("qty");
		locidss=rsstk.getInt("locid");
		System.out.println("---focmasterqty-----"+focmasterqty);	
		System.out.println("---balstkqty-----"+balstkqty);	
		System.out.println("---out_qty-----"+outstkqty);	
		System.out.println("---stkqty-----"+stkqty);
		System.out.println("---qty-----"+qty);

		focmasterqty=masterqty;
		if(remstkqty>0)
		{

			focmasterqty=remstkqty;
		}
		   ckkqty=focmasterqty;

		if(focmasterqty<=balstkqty)
		{
			
			focmasterqty=focmasterqty+qty;
			
			detqty=masterqty;
			String sqs="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+psrnos+" and  psrno="+psrnos+" and specno="+specno+"";
			System.out.println("--1---sqls---"+sqs);
			stmt.executeUpdate(sqs);
			//break;
			delqtys=focmasterqty-qty;
			focmasterqty=ckkqty-focmasterqty-qty;

		}
		else if(masterqty>balstkqty)
		{

			if(stkqty>=(masterqty+outstkqty))

			{
				balstkqty=masterqty+qty;	
				remstkqty=stkqty-outstkqty;

			//	System.out.println("---balstkqty-1---"+balstkqty);
			}
			else
			{
				remstkqty=masterqty-balstkqty;
				balstkqty=stkqty-outstkqty+qty;

			}
			detqty=stkqty-outstkqty;

			String sqs="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+psrnos+" and  psrno="+psrnos+" and specno="+specno+"";	
		//	System.out.println("-2----sqls---"+sqs);

			stmt.executeUpdate(sqs);	
			delqtys=detqty;
			//remstkqty=masterqty-stkqty;

		}
		String prodoutsql="insert into my_prddout(sr_no,TR_NO, date,dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price) Values"
				+ " ("+(p+1)+","+mytrno+",curdate(),'BPRF',"+rowno+","
				+ "'"+stockid+"',"
				+ ""+specno+","
				+ ""+psrnos+","
				+ "'"+delqtys+"',"
				+ ""+psrnos+","
				+""+brhid+","+locid+",0)";

		//System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
	int	prodout = stmt.executeUpdate (prodoutsql);
	
	  
	
	String prodreqsql="insert into my_prddr(sr_no,voc_no,TR_NO, date,dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price,cost_price) Values"
			+ " ("+(p+1)+","+contocno+","+conttrno+",curdate(),'BPRF',"+rowno+","
			+ "'"+stockid+"',"
			+ ""+specno+","
			+ ""+psrnos+","
			+ "'"+delqtys+"',"
			+ ""+psrnos+","
			+""+brhid+","+locid+",0,0)";

	//System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
int	prodreq = stmt.executeUpdate (prodreqsql);
	
	
	
	sqlmatsel="select outqty from cm_estmprdd where rowno="+rowno+"";
	//System.out.println("sqlmatsel--->>>>Sql"+sqlmatsel);
	ResultSet rsmat1 = stmt.executeQuery(sqlmatsel);
	while(rsmat1.next()) {
		
		matpurqty=rsmat1.getDouble("outqty");
	}
	//System.out.println("matpurqty--->>>>Sql"+matpurqty);
	resqty1=reservqty+matpurqty;
	
	//update material table
	 sql="update cm_estmprdd set resqty="+resqty1+",purqty="+purqty+",outqty="+resqty1+",outtrno="+mytrno+" where rowno="+rowno+"";
	 val=stmt.executeUpdate(sql);
	 
		if(val>0)
		{
			temp="1";
		//	conn.commit();
		}
		if(focmasterqty<=0)
		{
			
		//	System.out.println("--2--");
			break;
		}
		
		
	}
	System.out.println("iiiiiiiiiiiiiiiii============>>"+i);
	
		sql="update gl_estconfirm set resqty=resqty+"+masterreserveqty+" where rowno="+rowno+"";
	 val=stmt.executeUpdate(sql);
	 
		if(val>0)
		{
			temp="1";
			conn.commit();
		}
	
	 }
	
	 
	 
	 
 }
		
	}
	else if(click.equalsIgnoreCase("request"))
	{
		 conn.setAutoCommit(false);
		String requp="",rownoreq="",purqtyreq="",sqlreqsel="",sqlrequp="";
		String sqlcost="";
		 int costtype=0;
		 sqlcost="select costtype from my_costunit where costgroup='sjob'";
			//System.out.println("sqlmatsel--->>>>Sql"+sqlmatsel);
			ResultSet rscost = stmt.executeQuery(sqlcost);
			while(rscost.next()) {
				
				costtype=rscost.getInt("costtype");
			}
		ArrayList<String> descarray= new ArrayList<String>();
		System.out.println("estimationrequestarray--->>>>"+estimationrequestarray);
		 String spltreq[]=estimationrequestarray.split(","); 
		 for(int i=0;i<spltreq.length;i++)
		 {
			 masterreqqty=0;
			 String data[]=spltreq[i].split("::");
			 rownoreq=data[0].trim().equalsIgnoreCase("undefined") || data[0].trim().equalsIgnoreCase("NaN")|| data[0].trim().equalsIgnoreCase("")|| data[0].isEmpty()?"0":data[0].trim();
			 purqtyreq=data[1].trim().equalsIgnoreCase("undefined") || data[1].trim().equalsIgnoreCase("NaN")|| data[1].trim().equalsIgnoreCase("")|| data[1].isEmpty()?"0":data[1].trim();
			 masterreqqty=Double.parseDouble(purqtyreq);
		
			if(masterreqqty>0){				
			 sqlrequp="update gl_estconfirm set purqty=purqty+"+masterreqqty+" where rowno="+rownoreq+"";
				System.out.println("sqlrequp--->>>>"+sqlrequp);
			 val=stmt.executeUpdate(sqlrequp);
			 
				if(val>0)
				{
					temp="1";
					
				}
			}
		 }
		
		
		
		String spltpurreq[]=purchaserequestarray.split(","); 
		 for(int i=0;i<spltpurreq.length;i++)
		 {
		 
			 String temp21=spltpurreq[i];
			
				descarray.add(temp21);
		 }
		 System.out.println("descarray--->>>>"+descarray);
		String refno="SJOB-"+contocno;
		String desc="Procurement Folllowup , SJOB-"+contocno;
		int reqval=sdao.insert(sqlDate, refno, desc, session, "A", "PR", request, descarray,0,0);
		if(reqval>0)
		{
			requp="update MY_REQM set COSTTYPE="+costtype+",costcode="+conttrno+" where doc_no="+reqval+" ";
		System.out.println("requp--->>>>"+requp);
			 int valup=stmt.executeUpdate(requp);
			 if(valup>0)
			 {
				 temp="1";
				 conn.commit();
			 }
		}
	}
	else if(click.equalsIgnoreCase("order"))
	{
		 conn.setAutoCommit(false);
		String requp="",rownoorder="",purqtyorder="",amount="",total="",margin="",nettotal="",sqlpurord="";
String sqlcost="";
		 int costtype=0;
		 sqlcost="select costtype from my_costunit where costgroup='sjob'";
			//System.out.println("sqlmatsel--->>>>Sql"+sqlmatsel);
			ResultSet rscost = stmt.executeQuery(sqlcost);
			while(rscost.next()) {
				
				costtype=rscost.getInt("costtype");
			}
		ArrayList<String> masterarray= new ArrayList<String>();
		ArrayList<String> descarray= new ArrayList<String>();
		ArrayList<String> termsarray= new ArrayList<String>();
		ArrayList<String> shiparray= new ArrayList<String>();
		String sqlordersel="";
		
		double masterorderqty=0;
		
		String spltorder[]=estimationorderarray.split(","); 
		 for(int i=0;i<spltorder.length;i++)
		 {
			 masterorderqty=0;
			 String data[]=spltorder[i].split("::");
			 rownoorder=data[0].trim().equalsIgnoreCase("undefined") || data[0].trim().equalsIgnoreCase("NaN")|| data[0].trim().equalsIgnoreCase("")|| data[0].isEmpty()?"0":data[0].trim();
			 purqtyorder=data[1].trim().equalsIgnoreCase("undefined") || data[1].trim().equalsIgnoreCase("NaN")|| data[1].trim().equalsIgnoreCase("")|| data[1].isEmpty()?"0":data[1].trim();
			
			 
			 masterorderqty=Double.parseDouble(purqtyorder);
			
			 
			 sqlpurord="update gl_estconfirm set purorder=purorder+"+masterorderqty+" where rowno="+rownoorder+"";
			 val=stmt.executeUpdate(sqlpurord);
			 
				if(val>0)
				{
					temp="1";
					
				}
		 }
		
		
		String spltord[]=purchaseorderarray.split(","); 
		 for(int i=0;i<spltord.length;i++)
		 {
		 
			 String temp22=spltord[i];
			
			 
			 masterarray.add(temp22);
			 
			 
			 
		 }
		String refno="SJOB-"+contocno;
		String desc="Procurement Folllowup , SJOB-"+contocno;
		
		System.out.println("==== "+masterarray);
		int reqval=orderobj.insert(sqlDate, sqlDate, refno, vendor, 1, 1.00, "", "", desc, ordertot,
				0.00, 0.00, 0.00, ordernet, 0.00, ordernet, 0, session, "A", "PO",
				request, descarray, masterarray, "DIR", "0", 0.00, termsarray, shiparray, 0, 0.00, 0.00, 0.00, 0.00, 
				0.00, 0,0,0);
		if(reqval>0)  
		{  int  taxmethod=1;
			int temptax=0;
			Statement stmt3111 = conn.createStatement (); 
			String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+vendor+"' ";
		   
			System.out.println("==sqlss====="+sqlss);
			ResultSet rsss=stmt3111.executeQuery(sqlss);
		    if(rsss.next())
		    {
		    	temptax=rsss.getInt("tax");
		    	
		    }
			if(temptax!=1)
			{
				taxmethod=0;
			}
			
			
			if(taxmethod==1)
			{
			
			String sqlsss="update my_ordd set  total=qty*amount,nettotal=qty*amount,taxper=5,taxamount=((qty*amount)*(5/100)),nettaxamount=qty*amount+((qty*amount)*(5/100))  where tr_no="+reqval+"";
			 stmt.executeUpdate(sqlsss);
				
			}
			else
			{
				String sqlsss1="update my_ordd set  total=qty*amount,nettotal=qty*amount,taxper=0,taxamount=0,nettaxamount=qty*amount  where tr_no="+reqval+"";
				 stmt.executeUpdate(sqlsss1);
			}
			
			
			requp="update MY_ORDM set COSTTYPE="+costtype+",costcode="+conttrno+" where doc_no="+reqval+" ";
			//System.out.println("requp--->>>>"+requp);
			 int valup=stmt.executeUpdate(requp);
			 if(valup>0)
			 {
				 temp="1";
				 conn.commit();
			 }
		}
	}
		 response.getWriter().print(temp);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
