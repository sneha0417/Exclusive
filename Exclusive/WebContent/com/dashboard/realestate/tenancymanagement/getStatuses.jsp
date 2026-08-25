
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
JSONArray statusarray=new JSONArray();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();     
	conn=objconn.getMyConnection();                   
	Statement stmt=conn.createStatement();
	 
	String sql2="select rowno,name from in_activitystatus where status=1 order by seqno";     
	// System.out.println("--------assgnuser----------"+sql2);
	ResultSet rs12=stmt.executeQuery(sql2);      
	while(rs12.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs12.getString("rowno"));
		objtemp.put("name",rs12.getString("name"));
    	statusarray.add(objtemp);
    }
	data.put("statusdata",statusarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>