
 <%@page import="sun.misc.BASE64Encoder"%>
 <%@page import="java.io.File"%>
 <%@page import="java.io.FileOutputStream"%>
 <%@page import="java.io.Reader"%> 
 <%@page import="java.util.Random"%>
 <%@page import="javax.servlet.http.HttpServlet"%>
 <%@page import="javax.servlet.http.HttpServletRequest"%>
 <%@page import="javax.servlet.http.HttpServletResponse"%>
 <%@page import=" sun.misc.BASE64Decoder"%> 
 <%@page import="java.sql.Connection"%>
 <%@page import="com.connection.ClsConnection"%>
 <%@page import="java.sql.Statement"%>
 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement;"%>
 
 <%
 

 ClsConnection ClsConnection=new ClsConnection();
 
 StringBuffer buffer = new StringBuffer(); 
 Reader reader = request.getReader(); 
 int current; 
 while((current = reader.read()) >= 0)
  buffer.append((char) current); 
  String data = new String(buffer); 
  data = data.substring(data.indexOf(",") + 1);
  
  String code=request.getParameter("formname");
  String doc=request.getParameter("docno");
  String desc=request.getParameter("descpt");
  String reftypid=request.getParameter("reftypid");
  String drid=request.getParameter("drid");
  String srno="";
 
 Connection conn = ClsConnection.getMyConnection();
 
    Statement stmt1 = conn.createStatement();
	String strSql1 = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+doc+" and dtype='"+code+"'";

	ResultSet rs1 = stmt1.executeQuery(strSql1);
	while(rs1.next()) {
		srno=rs1.getString("srno");
	}
 
  String fname=code+'-'+doc+'-'+srno;
  String fname2=fname+".png";
  String dirname ="";
  String path ="";
  
  Statement stmt = conn.createStatement ();
  String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
  ResultSet rs = stmt.executeQuery(strSql);
  String path1="";
  while(rs.next ()) {
  	path1=rs.getString("imgPath");
  }
  path=path1.replace("\\", "/");
 
  //ServletContext context = request.getServletContext();

  File dir = new File(path+ "/attachment/"+code);
  	dir.mkdirs();
  	
  	conn.setAutoCommit(false);
	CallableStatement stmtAttach = conn.prepareCall("{CALL fileMultiAttach(?,?,?,?,?,?,?,?,?,?,?)}");
	
	stmtAttach.registerOutParameter(10, java.sql.Types.INTEGER);
	stmtAttach.registerOutParameter(11, java.sql.Types.INTEGER);
	stmtAttach.setString(1,code);
	stmtAttach.setString(2,doc);
	stmtAttach.setString(3,session.getAttribute("BRANCHID").toString());
	stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
	stmtAttach.setString(5,path+"\\attachment\\"+code+"\\"+fname2);
	stmtAttach.setString(6,fname2);
	stmtAttach.setString(7,desc);
	stmtAttach.setString(8,reftypid);
	stmtAttach.setString(9,drid);
	stmtAttach.executeQuery();
	int no=stmtAttach.getInt("srNo");
	if(no>0){
		conn.commit();
	}
  	
    FileOutputStream output = new FileOutputStream(new File(path +"/attachment/"+code+ "/"+ fname2));
    output.write(new BASE64Decoder().decodeBuffer(data));
    output.flush();
    output.close();
%>
