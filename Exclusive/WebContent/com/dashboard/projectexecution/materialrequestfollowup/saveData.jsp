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
<%@page import="com.sales.InventoryTransfer.materialrequest.ClsMaterialrequestDAO"%> 
 
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;
	ClsMaterialrequestDAO sdao= new ClsMaterialrequestDAO();
 

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
		String contocno=request.getParameter("contocno")==null?"0":request.getParameter("contocno");
		String conttrno=request.getParameter("conttrno")==null?"0":request.getParameter("conttrno");
		String ordernet1=request.getParameter("ordernet")==null?"0":request.getParameter("ordernet");
		String ordertot1=request.getParameter("ordertot")==null?"0":request.getParameter("ordertot");
		String vendor1=request.getParameter("vendor")==null?"0":request.getParameter("vendor");
		
		
		String txtcldocno=request.getParameter("txtcldocno")==null?"0":request.getParameter("txtcldocno");
		String txtsiteid=request.getParameter("txtsiteid")==null?"0":request.getParameter("txtsiteid");
		String click=request.getParameter("click")==null?"":request.getParameter("click");
		
		
		
		System.out.println("===txtcldocno=="+txtcldocno);
		System.out.println("===txtsiteid=="+txtsiteid);
		System.out.println("===click=="+click);
		
		
 
		 String temp="0";
	  if(click.equalsIgnoreCase("request"))
	{
		 conn.setAutoCommit(false);
		String requp="",rownoreq="",purqtyreq="",sqlreqsel="",sqlrequp="";
		String sqlcost="";
		 int costtype=0;
		 
		 int cldocno= Integer.parseInt(txtcldocno);
		 int siteid= Integer.parseInt(txtsiteid);
		 
		 
		 
		 sqlcost="select costtype from my_costunit where costgroup='sjob'";
			//System.out.println("sqlmatsel--->>>>Sql"+sqlmatsel);
			ResultSet rscost = stmt.executeQuery(sqlcost);
			while(rscost.next()) {
				
				costtype=rscost.getInt("costtype");
			}
			ArrayList<String> descarray= new ArrayList<String>();
 
		
		String spltpurreq[]=purchaserequestarray.split(","); 
		 for(int i=0;i<spltpurreq.length;i++)
		 {
		 
			 String temp21=spltpurreq[i];
			
				descarray.add(temp21);
		 }
		// System.out.println("descarray--->>>>"+descarray);
		String refno="SJOB-"+contocno;
		String desc=" Material Request, SJOB-"+contocno;
		//int reqval=sdao.insert(sqlDate, refno, desc, session, "A", "PR", request, descarray,0,0);
		
		int reqval=sdao.insert(sqlDate, refno, desc,0.00, session, "A", "MR", request, descarray,1,cldocno,siteid,1,costtype,Integer.parseInt(conttrno));
		/* 
		public int insert(Date masterdate, String refno, String purdesc,
				double productTotal, HttpSession session, String mode,
				String formdetailcode, HttpServletRequest request,
				ArrayList<String> masterarray, int txtlocationid, int cldocno,
				int siteid, int type, int itemtype, int itemdocno) throws SQLException { */
			
			 if(reqval>0)
			 {
				 temp="1";
				 conn.commit();
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
