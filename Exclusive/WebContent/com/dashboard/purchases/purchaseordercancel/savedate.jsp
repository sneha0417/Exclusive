
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


	String radocno=request.getParameter("radocno");
 
	
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
		 ClsConnection ClsConnection=new ClsConnection();
 	 conn = ClsConnection.getMyConnection();
 	 conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	
	Statement stmt1 = conn.createStatement ();
	
	
		upsql="update  my_ordd  set clstatus=1 where rowno='"+radocno+"' ";
		
		 val= stmt.executeUpdate(upsql);
		 
		 double balqty=0;
		 String type="";
		 String rrefno="0"; 
		 int psrno=0;
		 String sqls="select  m.rdtype,m.rrefno,d.rdocno,d.qty-d.out_qty  balqty,d.psrno from  my_ordd d left join my_ordm m on m.doc_no=d.rdocno  where d.rowno='"+radocno+"' ";
		  
	 
		 ResultSet rss=stmt.executeQuery(sqls);
		 
		 if(rss.next())
		 {
			 balqty=rss.getDouble("balqty");
					 
			 type=rss.getString("rdtype");
			 rrefno=rss.getString("rrefno");
			 psrno=rss.getInt("psrno");
		 }
	 
		 if(type.equalsIgnoreCase("PR"))
		 
		 {
			 double qty=0;
			 double out_qty=0;
			 
			 double saveqty=0;
			 
			 int rowno=0; 
			 
			 String sqlss="select d.qty,d.out_qty,d.rowno   from  my_reqd d where d.rdocno  in ("+rrefno+") and d.psrno='"+psrno+"' ";
			 
			 ResultSet rss1=stmt1.executeQuery(sqlss);
			 
			 while(rss1.next())
			 {
				 
				 out_qty=rss1.getDouble("out_qty");
				 qty=rss1.getDouble("qty");
				 rowno=rss1.getInt("rowno");
				
				 
				 if(out_qty>balqty)
				 {
					 
					 
					 saveqty=out_qty-balqty; 
					 balqty=balqty-saveqty;
				 }
				 else if(out_qty<=balqty)
				 {
					 
					 
					 saveqty=0;
					 balqty=balqty-out_qty;
				 }
				 
			 
				
				 
				 
				 String upsqls="update my_reqd set out_qty="+saveqty+" where rowno='"+rowno+"'";
				 
			 
				 
				 val= stmt.executeUpdate(upsqls);
		
				
				 if(balqty<=0)
					{
						   
						 break;
					}
					
				 
			 }
			 
	
			 response.getWriter().print(val); 
			  conn.commit();
			 
			 
			 
		 }
		 else
		 {
			 response.getWriter().print(val); 
			  conn.commit();
		 }
		 
		 
		 
	 	stmt.close();
	 	conn.close();
	 }
	 catch(Exception e){

			conn.close();
			e.printStackTrace();
		}
	    
	
	%>
