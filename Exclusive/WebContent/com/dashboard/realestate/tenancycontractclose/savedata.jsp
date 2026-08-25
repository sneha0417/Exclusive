 
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
	String closedate=request.getParameter("closedate")==null?"":request.getParameter("closedate");
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
 

	 String upsql=null,clsql=null;
	 
 	conn = ClsConnection.getMyConnection();
 
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	java.sql.Date sqlclosedate=null,sqlcontracttochkdate=null;
	if(!closedate.equalsIgnoreCase("") && closedate!=null && !closedate.equalsIgnoreCase("undefined")){
		sqlclosedate=ClsCommon.changeStringtoSqlDate(closedate);
	}
 	 	 
			   int brhid=0,curId=1;
			   int prtype=0;
			   int ttype=0;
			   int datechk=0;
			 
			   String mastersqlnw="  select  m.ttype  from rl_tncm  m  where m.doc_no='"+docno+"'";
				
				
				
				System.out.println("==mastersql="+mastersqlnw);
				
		            ResultSet rsmaterselnw=stmt.executeQuery(mastersqlnw);
				if(rsmaterselnw.next())
				{
					
					
					ttype=rsmaterselnw.getInt("ttype");
				
					 
				
				}
					
			if(ttype==3){
				
							String mastersql="  select  m.brhid ,  m.prtype,  m.ttype,  if(m.ttype=3,coalesce(datediff(curdate(),invdate),0),0)datechk  from rl_tncm  m  where m.doc_no='"+docno+"'";
							
							
							
							System.out.println("==mastersql="+mastersql);
							
					        ResultSet rsmatersel=stmt.executeQuery(mastersql);
						if(rsmatersel.next())
						{
							
							brhid=rsmatersel.getInt("brhid");
							prtype=rsmatersel.getInt("prtype");
							ttype=rsmatersel.getInt("ttype");
							datechk=rsmatersel.getInt("datechk");
							 
						
						}
							
							if(datechk>0){
							 String sqls="update rl_tncm set clstatus=1 ,invtodate='"+sqlclosedate+"' where doc_no='"+docno+"' ";
							 
								//  System.out.println("==sqls=="+sqls);
								 int aaa1= stmt.executeUpdate(sqls);
								 clsql="insert into rl_tncclose(contractno, closedate) values('"+docno+"','"+sqlclosedate+"')";
								 System.out.println("==clsql="+clsql);
								 
								 int bbb= stmt.executeUpdate(clsql);
							}
							else{
								response.getWriter().print(0);
							 	stmt.close();
							 	conn.close();
							}
			}
			else{
				
				
						String mastersql="  select  m.brhid ,  m.prtype,  m.ttype  from rl_tncm  m  where m.doc_no='"+docno+"'";
						
						
						
						System.out.println("==mastersql="+mastersql);
						
				            ResultSet rsmatersel=stmt.executeQuery(mastersql);
						if(rsmatersel.next())
						{
							
							brhid=rsmatersel.getInt("brhid");
							prtype=rsmatersel.getInt("prtype");
							ttype=rsmatersel.getInt("ttype");
						
							 
						
						}
							
							 String sqls="update rl_tncm set clstatus=1  where doc_no='"+docno+"' ";
							 
								//  System.out.println("==sqls=="+sqls);
								 int aaa1= stmt.executeUpdate(sqls);
				}
			 
 		 String sqls1="update rl_propertymaster set cnt_no=0,cnt_date=null where doc_no='"+prtype+"' and cnt_no='"+docno+"'  ";
 		 
 		 System.out.println("==sqls1=="+sqls1);
 		 
			 int aaa11= stmt.executeUpdate(sqls1); 
					
			 
			
			 
			 
					  upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','TCCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
