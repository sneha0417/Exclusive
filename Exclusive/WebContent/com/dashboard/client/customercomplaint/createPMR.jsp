 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.realestate.tenantrequest.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

Connection conn=null;

ClsTenantRequestDAO  DAO =new ClsTenantRequestDAO ();
String pmrarray=request.getParameter("pmrarray")==null?"":request.getParameter("pmrarray");
int hidcmbtenant = request.getParameter("hidcmbtenant")==null || request.getParameter("hidcmbtenant").equals("")?0:Integer.parseInt(request.getParameter("hidcmbtenant").trim());
int hidcmbproperty = request.getParameter("hidcmbproperty")==null || request.getParameter("hidcmbproperty").equals("")?0:Integer.parseInt(request.getParameter("hidcmbproperty").trim());
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String rdocno=request.getParameter("rdocno")==null?"":request.getParameter("rdocno");
//System.out.println("rowno===="+rdocno);
int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=pmrarray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();


	 
	long millis=System.currentTimeMillis();  
	 java.sql.Date curdate=new java.sql.Date(millis); 
	//System.out.println("curdate======="+curdate);
	
	String curtime="";
	 String sql = "select curtime() curtime ";
       //System.out.println("curtime==="+sql);  
		ResultSet rs = stmt.executeQuery(sql);         
		while(rs.next()) {  
			curtime=rs.getString("curtime");  
			
		}  
		
	
	// System.out.println("mainarray-=========="+mainarray);
	 val= DAO.insert(curdate,0,curtime,0,hidcmbproperty,hidcmbtenant, mainarray,session,request,"A",0,0,1);
	//System.out.println("arrsaysss-=========="+val);
	
if(val>0){
	      docno =request.getAttribute("docno").toString();
	      vocno =request.getAttribute("vocno").toString();
	
	      String sql2="update rl_guestregd set request_docno="+docno+" where rowno="+rdocno+" ";
	     // System.out.println("update query==="+sql2);  
		  stmt.executeUpdate(sql2);         
		
		  conn.commit();
}
		
 response.getWriter().print(val+"####"+vocno);

 stmt.close();
 conn.close();
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}finally{
 conn.close();
}
%>