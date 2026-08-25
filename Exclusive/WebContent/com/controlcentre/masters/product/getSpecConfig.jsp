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
	String strSql = "select coalesce(spec_name,'spec') as spec_name from my_specval where ref_master='PRD.SPEC'";
	ResultSet rs = stmt.executeQuery(strSql);
	String size="";
	String clr="";
	String patrn="";
	String other="";
	int i=0;
	while(rs.next()) {
		if(i==0)
			size=rs.getString("spec_name");
		if(i==1)
			clr=rs.getString("spec_name");
		if(i==2)
			patrn=rs.getString("spec_name");
		if(i==3)
			other=rs.getString("spec_name");
		i++;
			} 
	
	response.getWriter().write(size+"###"+clr+"###"+patrn+"###"+other);
	System.out.println("inside"+size+"###"+clr+"###"+patrn+"###"+other);
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
  
