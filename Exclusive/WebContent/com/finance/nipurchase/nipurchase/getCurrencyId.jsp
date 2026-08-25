<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection connDAO=new ClsConnection();
	String date=request.getParameter("date");
 	Connection conn = null;
 	//java.sql.Date sqlDate=null;
 	long millis=System.currentTimeMillis();  
    java.sql.Date sqlDate=new java.sql.Date(millis); 	
 	try
 	{
 	conn = connDAO.getMyConnection();
	String dtype=session.getAttribute("Code").toString();
	String brch=session.getAttribute("BRANCHID").toString();
	
	date.trim();
    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
    {
    	sqlDate = ClsCommon.changeStringtoSqlDate(date);
    }
    
	Statement stmt = conn.createStatement ();
	
	String strSq = "select multiCur from my_brch where doc_no='"+brch+"'";
	System.out.println("strSq ="+strSq);
	ResultSet rs1 = stmt.executeQuery(strSq);
	int multi = 0;
	while(rs1.next()){
	multi = rs1.getInt("multiCur");
	}
	
	String strSql = "";
	if(multi==0){
		/* strSql = "select c.doc_no,code,c.c_rate,c.type from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'"; */
		
		strSql = "select c.doc_no,c.code,cb.rate c_rate,cb.type from my_brch b inner join my_curr c on(c.doc_no=b.curId) inner join my_curbook cb on (b.curid=cb.curid) "
		+"inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where  coalesce(toDate,curdate())>=coalesce('"+sqlDate+"',now()) and "
		+"frmDate<=coalesce('"+sqlDate+"',now()) group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where b.doc_no='"+brch+"'";
		
		// System.out.println("strSql ="+strSql);
	}else{
		/* strSql = "select doc_no,code,c_rate,type from my_curr where status <> 7"; */
		
		   strSql = "select a.curid doc_no,c.code,a.rate c_rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate "
				   +"from my_curbook cb where  coalesce(toDate,curdate())>=coalesce('"+sqlDate+"',now()) and frmDate<=coalesce('"+sqlDate+"',now()) group by cb.curid) as b on(a.doc_no=b.doc_no "
				   +"and a.curid=b.curid) inner join my_curr c on a.curid=c.doc_no";
	}
	// System.out.println("strSql ="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String curid="";
	String curcode="";
	String currate="";
	while(rs.next()) {
		curid+=rs.getInt("doc_no")+",";
		curcode+=rs.getString("code")+",";
		currate+=rs.getString("c_rate")+",";
  		} 
	curid=curid.substring(0, curid.length()-1);
	curcode=curcode.substring(0, curcode.length()-1);
	currate=currate.substring(0, currate.length()-1);
	//System.out.println(curid+"####"+curcode+"####"+currate+"####"+multi);
	response.getWriter().write(curid+"####"+curcode+"####"+currate+"####"+multi);

	stmt.close();
	conn.close();
 	}
 	catch (Exception e)
 	{
	
	 e.printStackTrace();
	conn.close();
 	}
  %>
  
