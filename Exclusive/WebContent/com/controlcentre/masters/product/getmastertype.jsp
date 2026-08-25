<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	 
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select  doc_no, mastertype, mtype from  my_prodmastertype where  status=3 ;";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String mtype="";
	String mtypeid="";
	while(rs.next()) {
		mtype+=rs.getString("mastertype")+",";		
		mtypeid+=rs.getString("doc_no")+",";
  		} 
	if(mtype.length()>0){
		mtype=mtype.substring(0, mtype.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(mtype+"###"+mtypeid);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
