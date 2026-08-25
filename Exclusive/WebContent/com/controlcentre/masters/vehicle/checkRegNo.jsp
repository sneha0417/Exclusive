<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

try{
	conn=ClsConnection.getMyConnection();
	String regno=request.getParameter("regno");
	String plate=request.getParameter("plate");
	String mode=request.getParameter("mode");
	String docno=request.getParameter("docno");
	String sqltest="";
	if(mode.equalsIgnoreCase("E")){
		sqltest=" and doc_no<>"+docno+"";
	}
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select count(*) count from gl_vehmaster where reg_no='"+regno+"' and pltid="+plate+" and tran_code<>'FS'  and statu=3 "+sqltest;
	//System.out.println("Check Count Query:"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	int count=0;
	while(rs.next()) {
		count=rs.getInt("count");
  		} 
//System.out.println("Check count:"+count);
stmt.close();
conn.close();
response.getWriter().write(count+"");

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
	
}
finally{
	conn.close();
}

  %>