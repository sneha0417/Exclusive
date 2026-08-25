<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String insptype=request.getParameter("insptype")==null?"":request.getParameter("insptype");
String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");
String attachdesc=request.getParameter("attachdesc")==null?"":request.getParameter("attachdesc");
String inspdocno=request.getParameter("inspdocno")==null?"":request.getParameter("inspdocno");
String roomdocno=request.getParameter("roomdocno")==null?"":request.getParameter("roomdocno");
String furndocno=request.getParameter("furndocno")==null?"":request.getParameter("furndocno");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String> attachdocarray=new ArrayList();
	String strgetattachdocno="select rowno from my_fileattach where dtype='BPI' and doc_no="+inspdocno+" and ref_id="+roomdocno;
	ResultSet rsgetattachdocno=stmt.executeQuery(strgetattachdocno);
	while(rsgetattachdocno.next()){
		attachdocarray.add(rsgetattachdocno.getString("rowno"));
	}
	for(int i=0;i<attachdocarray.size();i++){
		//Checking if attachdocno exists
		String attachdocno=attachdocarray.get(i);
		String strexists="select count(*) rowcount from rl_propinspattach where inspdocno="+inspdocno+" and attachdocno="+attachdocno;
		int rowcount=0;
		ResultSet rsexist=stmt.executeQuery(strexists);
		while(rsexist.next()){
			rowcount=rsexist.getInt("rowcount");
		}
		if(rowcount==0){
			String strinsert="insert into rl_propinspattach(inspdocno, roomdocno, furndocno, attachdocno)values("+inspdocno+","+roomdocno+","+furndocno+","+attachdocno+")";
			System.out.println(strinsert);
			int insert=stmt.executeUpdate(strinsert);
			if(insert<=0){
				errorstatus=1;
			}
		}
	}
	if(errorstatus==0){
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