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
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		stmt = conn.createStatement();
		
		String btnclick=request.getParameter("btnclick")==null?"":request.getParameter("btnclick");
		String stdcost=request.getParameter("stdcost")==null?"":request.getParameter("stdcost");
		String sellprice=request.getParameter("sellprice")==null?"":request.getParameter("sellprice");
		String estamt=request.getParameter("estamt")==null?"":request.getParameter("estamt");
		String rowno=request.getParameter("rowno")==null?"":request.getParameter("rowno");
		String psrno=request.getParameter("psrno")==null?"":request.getParameter("psrno");
	//update material table
	String temp="0";
	int val=0;
	if(btnclick.equalsIgnoreCase("1")){
		String  sql="update my_main set stdprice="+stdcost+",sellprice="+sellprice+" where psrno="+psrno+"";

		val=stmt.executeUpdate(sql);
		}
	
	else if(btnclick.equalsIgnoreCase("2")){
	String  sql="update cm_estmprdd d left join cm_estmprdd m on m.rowno=d.rowno set d.costprice="+estamt+",d.total=(m.qty*"+estamt+"),d.nettotal=((m.qty*"+estamt+")+d.profitper) where d.rowno="+rowno+"";
		
	val=stmt.executeUpdate(sql);
	}
		if(val>0)
		{
			temp="1";
			conn.commit();
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
