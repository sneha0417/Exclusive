  <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 
Connection conn =null;
 try
{
	 
	 String psrno=request.getParameter("psrno").equalsIgnoreCase("0")|| request.getParameter("psrno")=="0"||request.getParameter("psrno")==null || request.getParameter("psrno")==""?"0":request.getParameter("psrno");
	 
	 System.out.println("===========psrno========="+psrno);
	 
			ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String doc_no="";
	String type="";
	if(psrno.equalsIgnoreCase("0"))
	{
		String strSql = " select unit code,doc_no from my_unitm where status=3  ";
		
		ResultSet rs = stmt.executeQuery(strSql);
	 
	 
		while(rs.next()) {
			doc_no+=rs.getInt("doc_no")+",";
			type+=rs.getString("code")+",";
		 
	  		} 
	}
	else
	{
		
		int method=0;
		Statement stmt31=conn.createStatement();
		String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
		ResultSet rss31=stmt31.executeQuery(chk311); 
		if(rss31.next())
		{

			method=rss31.getInt("method");
		}
		
		
		if(method>0)
		{
			String strSql = " select m.unit code,u.fr,m.doc_no doc_no,u.psrno from my_unit u  inner join my_unitm m on m.doc_no=u.unit where psrno='"+psrno+"' group by m.doc_no  ";
			ResultSet rs = stmt.executeQuery(strSql);
			
			 
			while(rs.next()) {
				doc_no+=rs.getInt("doc_no")+",";
				type+=rs.getString("code")+",";
			 
		  		} 
		}
		else
		{
			
			
			String strSql = " select m.unit code,m.doc_no  doc_no,u.psrno from my_main u  inner join my_unitm m on m.doc_no=u.munit where u.psrno='"+psrno+"' group by u.munit  ";
			ResultSet rs = stmt.executeQuery(strSql);
			
			 
			while(rs.next()) {
				doc_no+=rs.getInt("doc_no")+",";
				type+=rs.getString("code")+",";
			 
		  		} 
		}
		
		
		
	}
 
 
 
	response.getWriter().write(doc_no+"####"+type);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 