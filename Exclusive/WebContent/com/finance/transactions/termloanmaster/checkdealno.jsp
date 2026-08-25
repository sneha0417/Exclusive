<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	String dealno=request.getParameter("dealno");
	String doc=request.getParameter("masterdoc");
		Connection conn = null;
 	try{
 		conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select vm.dealno from gl_termloandetm vm left join gl_termloanm vo on vo.doc_no=vm.rdocno where vm.dealno='"+dealno+"' and vo.status=3  and vo.doc_no!='"+doc+"' ";
//System.out.println("----------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	int status=0;
	//String id="";
	 if(rs.next()) {
		status=1;
					
  		}   
	 
	response.getWriter().print(status);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
 	}
	catch(Exception e){
		
			conn.close();
			
		} 
  
  %>
  
