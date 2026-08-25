<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
String dtype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
String clientid = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
String todate = request.getParameter("date")==null?"0":request.getParameter("date");
String frmdate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate");
int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
String schtrno = request.getParameter("schtrno")==null?"0":request.getParameter("schtrno");
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");

		 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		String sql11="";
		
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11+=" and p.cldocno in ("+clientid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
			sql11=sql11+" and p.dtype='"+dtype+"'";
		}

		if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
			sql11=sql11+" and p.refdocno='"+contractno+"'";
		}

		if(!(todate.equals("0") || todate.equals("") || todate.equals("undefined"))){
			java.sql.Date tdate=ClsCommon.changeStringtoSqlDate(todate);
			sql11=sql11+" and p.date<='"+tdate+"'"; 
		}

		if(!(frmdate.equals("0") || frmdate.equals("") || frmdate.equals("undefined"))){
			java.sql.Date fdate=ClsCommon.changeStringtoSqlDate(frmdate);
			sql11=sql11+" and p.date>='"+fdate+"'"; 
		}
		
	
		
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("USERID").toString();
		
		
			 strSql = "update cm_servplan p set status=6  where tr_no="+schtrno+" "+sql11+"";      
		
			 System.out.println("==strSql===="+strSql);
			 
		int rs = stmt.executeUpdate(strSql);
		
		
		if(rs>0){
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+schtrno+"','"+branchid+"','SRVC',now(),'"+userid+"','E')";
			 int datas= stmt.executeUpdate(sqls);
			 if(datas<=0){
				 stmt.close();
				    conn.close();
				}
		}
		
		response.getWriter().write(rs+"###"+dtype);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  