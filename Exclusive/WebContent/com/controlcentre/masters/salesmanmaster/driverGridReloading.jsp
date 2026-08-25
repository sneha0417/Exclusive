<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>

<%	
ClsConnection ClsConnection=new ClsConnection();


String clientid=request.getParameter("clientid");

	    JSONArray jsonArray = new JSONArray();
	    Connection conn = null;
	    
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtClient = conn.createStatement();
	            	
					ResultSet resultSet = stmtClient.executeQuery ("SELECT name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,"
							+ "visano,visa_exp FROM gl_drdetails where dr_id="+clientid+"");

					//RESULTDATA=convertToJSON(resultSet);
					
					
					while (resultSet.next()) {
							int total_rows = resultSet.getMetaData().getColumnCount();
							JSONObject obj = new JSONObject();
							for (int i = 0; i < total_rows; i++) {
								obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
							}
							jsonArray.add(obj);
					}
					stmtClient.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			
			response.getWriter().write(jsonArray.toString());
		
	 
  %>
  