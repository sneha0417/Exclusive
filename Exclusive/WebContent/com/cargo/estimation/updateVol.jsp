<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;
String docno=request.getParameter("docno");
String weight=request.getParameter("weight");
String enqddoc=request.getParameter("enqddoc");

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	int log=0;
	String gridarray=request.getParameter("gridarray");
	ArrayList<String> griddataarray = new ArrayList<String>();
	String[] temparray=gridarray.split(",");
	for(int i=0;i<temparray.length;i++){
	 griddataarray.add(temparray[i]);
	}
	
	Statement stmt = conn.createStatement();
	String sql="update cr_enqd set volume = replace('"+weight+"',',','') where doc_no="+enqddoc;
	System.out.println("--upsql--"+sql);
	log=stmt.executeUpdate(sql);
	if(log<=0){
		errorstatus=1;
	}
	else{
		log=0;
		String delsql="delete from cr_enqvol where rdocno="+enqddoc;
		stmt.executeUpdate(delsql);
	}

	if(errorstatus==0){
		for(int i=0;i< griddataarray.size();i++){
			String[] arrayDet=((String) griddataarray.get(i)).split("::");
			if(!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()))
			{
				String volsql="insert into cr_enqvol(rdocno, type, length, width, height, qty, volweight, actweight) values("
						+enqddoc+","
						+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
						+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
						+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
						+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
						+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
						+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
						+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"')";
				System.out.println("-volsql--"+volsql);
				int resultSet2 = stmt.executeUpdate (volsql);
				if(resultSet2<=0)
				{
					conn.close();
					errorstatus = 1;
				}
			}
		}
	}
	
	if(errorstatus==0){
		
		String userid=session.getAttribute("USERID").toString();
		String brhid =session.getAttribute("BRANCHID").toString();
		PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 
		 stmtlog.setString(1,docno);
		 stmtlog.setInt(2,Integer.parseInt(brhid));
		 stmtlog.setString(3,"CEST");
		 stmtlog.setString(4, userid);
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "E");
		 
		 log=stmtlog.executeUpdate();
		 
		 if(log<=0){
			errorstatus=1;
		 }
	}

	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().print(1);
}
finally{
	conn.close();
	
}
response.getWriter().print(errorstatus);
%>