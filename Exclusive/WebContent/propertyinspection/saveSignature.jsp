<%@page import="com.common.ClsAttachmaster"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
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
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%
	int errorstatus=0;
	ClsConnection objconn=new ClsConnection();
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
  	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	String signindex=request.getParameter("signindex");
  	String cmbsignstatus=request.getParameter("cmbsignstatus")==null?"0":request.getParameter("cmbsignstatus").toString();
  	String chkopt1=request.getParameter("chkopt1")==null?"0":request.getParameter("chkopt1");
	String chkopt2=request.getParameter("chkopt2")==null?"0":request.getParameter("chkopt2");
	String chkopt3=request.getParameter("chkopt3")==null?"0":request.getParameter("chkopt3");
	String chkopt4=request.getParameter("chkopt4")==null?"0":request.getParameter("chkopt4");
	String repairslist=request.getParameter("repairslist")==null?"":request.getParameter("repairslist");
  	String srno="0";
  	Connection conn =null;
 	try{
  		conn = objconn.getMyConnection();
  	  	conn.setAutoCommit(false);
  		Statement stmt = conn.createStatement();
		String strmaxdoc = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+doc+" and dtype='BPI'";
		System.out.println("Max Doc No"+strmaxdoc);
		ResultSet rsmaxdoc = stmt.executeQuery(strmaxdoc);
		while(rsmaxdoc.next()){
			srno=rsmaxdoc.getString("srno");
		}
		if(cmbsignstatus.trim().equalsIgnoreCase("")){
			cmbsignstatus="0";
		}
  		String fname="BPI"+'-'+doc+'-'+srno;
  		String fname2=fname+".png";
  		String dirname ="";
  		String path ="";
  		String strSql = "select imgPath from my_comp where doc_no=1";
  		ResultSet rs = stmt.executeQuery(strSql);
  		String path1="";
  		while(rs.next ()) {
  			path1=rs.getString("imgPath");
		}
  		path=path1.replace("\\", "/");
 		File dir = new File(path+ "/attachment/BPI");
  		dir.mkdirs();
  	
		CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
		stmtAttach.setString(1,"BPI");
		stmtAttach.setString(2,doc);
		stmtAttach.setString(3,"1");
		stmtAttach.setString(4,"1");
		stmtAttach.setString(5,path+"//attachment//VIP//"+fname2);
		stmtAttach.setString(6,fname2);
		stmtAttach.setString(7,desc);
		stmtAttach.setString(8,reftypid);
		stmtAttach.executeQuery();
		int no=stmtAttach.getInt("srNo");
		if(no<=0){
			errorstatus=1;
		}
		String check=path+"//attachment//BPI//"+ fname2;
		String strsignature="";
		System.out.println("Sign Index:"+signindex+"//");
		if(signindex.equalsIgnoreCase("1")){
			strsignature="update rl_propinspm set signstatus="+cmbsignstatus+",signature='"+path+"/attachment/BPI/"+fname2+"',chkopt1="+chkopt1+",chkopt2="+chkopt2+",chkopt3="+chkopt3+",chkopt4="+chkopt4+",repairdet='"+repairslist+"' where doc_no="+doc;
			//Thread.sleep(1000);
		}
		else if(signindex.equalsIgnoreCase("2")){
			strsignature="update rl_propinspm set signstatus="+cmbsignstatus+",tenantsign='"+path+"/attachment/BPI/"+fname2+"' where doc_no="+doc;
		}
		System.out.println(strsignature);
		int savesign=stmt.executeUpdate(strsignature);
		if(savesign<=0){
			errorstatus=1;
		}
		String strl="",docn="";
  		String imageString = data;  
		byte byteArray[] = new byte[1000000];
		FileOutputStream fos = new FileOutputStream(path +"/attachment/BPI/"+ fname2); 
		byteArray = Base64.decodeBase64(imageString);
		fos.write(byteArray);
		fos.flush();
		fos.close();
		if(no>0 && errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close(); 
	}
response.getWriter().write(errorstatus+"");
%>
