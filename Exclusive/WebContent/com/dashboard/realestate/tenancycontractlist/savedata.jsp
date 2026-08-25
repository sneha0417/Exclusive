 
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
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
  
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
 

	 String upsql=null;
	 
 	conn = ClsConnection.getMyConnection();
 
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
	 	 
			   int brhid=0,curId=1;
			   int prtype=0;
			 
				String mastersql="  select  m.brhid ,  m.prtype  from rl_tncm  m  where m.doc_no='"+docno+"'";
						
						
						
						System.out.println("==mastersql="+mastersql);
						
				ResultSet rsmatersel=stmt.executeQuery(mastersql);
					if(rsmatersel.next())
					{
						
						brhid=rsmatersel.getInt("brhid");
						prtype=rsmatersel.getInt("brhid");
						 
					
					}
					
					
			 String sqls="update rl_tncm set clstatus=1 where doc_no='"+docno+"' ";
			 
			//  System.out.println("==sqls=="+sqls);
			 int aaa1= stmt.executeUpdate(sqls);
			 
 		 String sqls1="update rl_propertymaster set cnt_no=0,cnt_date=null where doc_no='"+prtype+"' and cnt_no='"+docno+"'  ";
 		 
 //		 System.out.println("==sqls1=="+sqls1);
 		 
			 int aaa11= stmt.executeUpdate(sqls1); 
					
					  
					  upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','TCCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
					  System.out.println("==upsql="+upsql);
						 
						 int aaa= stmt.executeUpdate(upsql);	
					  
					 
					 response.getWriter().print(aaa);
					 	stmt.close();
					 	conn.close();
				 
					
					
	 
			 
		
						 
					  
			   
		   
	 		
		
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 		}
	 
	 
	 
		

	
	%>
