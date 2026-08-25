<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	String invno=request.getParameter("invno");

String masterdocno=request.getParameter("masterdocno")==null||request.getParameter("masterdocno")==""?"0":request.getParameter("masterdocno");
String acno=request.getParameter("accdocno");
ClsConnection connDAO=new ClsConnection();
 	Connection conn = null;
 	try{
 		conn = connDAO.getMyConnection();
 		int status=0;
 		Statement stmt = conn.createStatement ();
	
	String strSql = "select method from gl_config where field_nme='invnochk' ";
	//System.out.println("-----34-----"+strSql);
		ResultSet rs1 = stmt.executeQuery(strSql);

		int method=0;
		//String id="";
		if(rs1.next()) {
			method=rs1.getInt("method");
						
	  		} 
	//	System.out.println("-----method----"+method);
		if(method==0)
		{
		
	String strSql1 = "select invno from my_srvsalem where invno='"+invno+"' and acno='"+acno+"'  and doc_no<>'"+masterdocno+"' ";
//System.out.println("-----34-----"+strSql);
	ResultSet rs = stmt.executeQuery(strSql1);


	//String id="";
	if(rs.next()) {
		status=1;
					
  		} 
	
	
		}
		else
		{
			status=0;
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
  
