<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;
String gridarray=request.getParameter("gridarray");
ArrayList<String> griddataarray = new ArrayList<String>();
String docno=request.getParameter("docno").toString();

String[] temparray=gridarray.split(",");
for(int i=0;i<temparray.length;i++){
 griddataarray.add(temparray[i]);
}

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
/* 	String delsql="delete from cr_qotd where rdocno="+docno+" and  refdocno="+arrayDet[0].trim()+"  ";
	stmt.executeUpdate(delsql); */
	for(int i=0;i< griddataarray.size();i++){
		String[] arrayDet=((String) griddataarray.get(i)).split("::");
		if(!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()))
		{
			String sql="INSERT INTO cr_qotd(refdocno, rdocno, typeid, curid, rate, price, qty, uom, total, btotal, billing, vndid) VALUES("
					+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
					+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
					+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
					+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
					+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
					+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
					+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
					+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
					+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
					+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
					+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
					+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"')";
					int resultSet2 = stmt.executeUpdate (sql);
			if(resultSet2<=0)
			{
				conn.close();
				errorstatus = 1;
			}
		}
	}
	int log=0;
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
		 stmtlog.setString(7, "A");
		 
		 log=stmtlog.executeUpdate();
		 if(log<=0){
			 errorstatus=1;
		 }
	}
	System.out.println("-errorstats-"+errorstatus);

	if(errorstatus==0){
		response.getWriter().print(errorstatus);
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().print(0);
}
finally{
	conn.close();
}

%>