<%-- <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@ page import="java.io.*"%>
<%@page import="javax.xml.bind.DatatypeConverter" %>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import=" java.io.ByteArrayInputStream"%>
<%@page import=" java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import=" java.io.FileOutputStream"%>


<%	
System.out.println("============"+request.getParameter("canvasData"));
//session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
String code=request.getParameter("formdetailcode");
String doc=request.getParameter("doc");
String srno=request.getParameter("srno");

String fname=code+'-'+doc+'-'+srno;
String fname2=fname+".png";
//System.out.println("CODE==="+code);
//	System.out.println("Code"+getFormdetailcode());
String dirname ="";
//System.out.println(dirname);
String path ="";
Connection conn = ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
//System.out.println(strSql);
ResultSet rs = stmt.executeQuery(strSql);
String path1="";
while(rs.next ()) {
	path1=rs.getString("imgPath");
//	System.out.println("IMGPATH:"+path);
}
path=path1.replace("\\", "/");
ServletContext context = request.getServletContext();
//String path = context.getRealPath("/");

File dir = new File(path+ "/attachment/"+dirname);
	dir.mkdirs();
try
{
	
	String img64 ="";
	System.out.println("====img64====="+img64);
    byte[] decodedBytes = DatatypeConverter.parseBase64Binary(img64 );
    BufferedImage bfi = ImageIO.read(new ByteArrayInputStream(decodedBytes));    
    File outputfile = new File("saved.png");
    ImageIO.write(bfi , "png", outputfile);
    bfi.flush();
	

} catch (Exception e) {  
e.printStackTrace();  
conn.close();

}  
finally{
conn.close();
}


  %>
  
 --%>
 
 
 <%@page import="com.common.ClsCommon"%>
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

 
 <%
 


 ClsConnection objconn=new ClsConnection();
 ClsCommon objcommon=new ClsCommon();
 StringBuffer buffer = new StringBuffer(); 
 Reader reader = request.getReader(); 
 int current; 
 while((current = reader.read()) >= 0)
  buffer.append((char) current); 
  String data = new String(buffer); 
  data = data.substring(data.indexOf(",") + 1);
  
    String code=request.getParameter("formname");
  String doc=request.getParameter("docno");
  String srno=request.getParameter("srno");
 
 System.out.println("===doc====="+doc);
 
 /* String code="VOP";
 String doc="1";
 String srno="2"; */

 
 
  String fname=code+'-'+doc+'-'+srno;
  String fname2=fname+".png";
  //System.out.println("CODE==="+code);
//  	System.out.println("Code"+getFormdetailcode());
  String dirname ="";
  //System.out.println(dirname);
  String path ="";
  Connection conn = objconn.getMyConnection();
  Statement stmt = conn.createStatement ();
  String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
  System.out.println("====strSql======="+strSql);
  ResultSet rs = stmt.executeQuery(strSql);
  String path1="";
  while(rs.next ()) {
  	path1=rs.getString("imgPath");
//  	System.out.println("IMGPATH:"+path);
  }
  path=path1.replace("\\", "/");
 
  ServletContext context = ((HttpSession) request).getServletContext();
  //String path = context.getRealPath("/");

  File dir = new File(path+ "/attachment/"+code);
  	dir.mkdirs();
  	
  	Statement stmtupdate=conn.createStatement();
    String strupdate="update gl_vinspd set attach='"+fname2+"',path='"+path + "/attachment/"+code+ "/"+ fname2+"' where rdocno="+doc+" and rowno="+srno ;
   
    int val=stmtupdate.executeUpdate(strupdate);
  
   System.out.println("PNG imarwrwrwrwrwge data on Base64: " + doc);
    FileOutputStream output = new FileOutputStream(new File(path +"/attachment/"+code+ "/"+ fname2));
     output.write(new BASE64Decoder().decodeBuffer(data));
      output.flush();
       output.close();
%>
 
 
 
 
 
 
 
 
 