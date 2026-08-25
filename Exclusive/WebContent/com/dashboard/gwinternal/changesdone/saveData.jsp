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

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String cldocno=request.getParameter("cldocno");
		String docnos=request.getParameter("docnos");
	    
		String sql=null;
		int val=0,docNo=0;

		String[] docnoarray = docnos.split("::");
		
		for (int i = 0; i < docnoarray.length; i++) {
			String rdocno=docnoarray[i];	
			
			if(!(rdocno.equalsIgnoreCase(""))){
				 String sql1="";
				 
				 sql1="insert into gw_changescopied(rdocno, cldocno) values('"+rdocno+"', '"+cldocno+"')";
				 int data= stmt.executeUpdate(sql1);
				 if(data<=0){
					stmt.close();
					conn.close();
				}
			}
		}
		
		String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bchg";
        ResultSet resultSet = stmt.executeQuery(sqls);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
        
        /*Inserting gl_bchg*/
	     String sql2="insert into gl_bchg(doc_no, date, docnosno, userid) values("+docNo+", now() , '"+docnos+"', '"+session.getAttribute("USERID").toString()+"')";
	     val= stmt.executeUpdate(sql2);
		 if(val<=0){
			    stmt.close();
				conn.close();
			}
		 /*Inserting gl_bchg Ends*/
	 	 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BCHG',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
