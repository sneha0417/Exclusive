<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>   
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
 
 String term=request.getParameter("term")=="" || request.getParameter("term")==null?"":request.getParameter("term").toString();

 ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
		JSONObject objdata=new JSONObject();         
	 	conn = ClsConnection.getMyConnection();
	 	ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement(); 
		
		String strSql = "select doc_no,area from my_area where area like '%"+term+"%'";
		    System.out.println("sql====="+strSql);                      
			ResultSet rs1 = stmt.executeQuery(strSql);
			JSONArray dataarray=new JSONArray();
			while(rs1.next()) {  
				JSONObject temp=new JSONObject();  			 
				temp.put("id",rs1.getString("doc_no"));
				temp.put("text",rs1.getString("area")); 
				dataarray.add(temp);	
			} 
			  
		response.getWriter().print(dataarray);                                                        
 		  
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>