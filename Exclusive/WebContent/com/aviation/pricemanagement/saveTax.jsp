<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;
String rdocno=request.getParameter("rdocno");
String mode=request.getParameter("mode");
String type=request.getParameter("type");
String tax=request.getParameter("tax");
System.out.println("--type--"+type+"--"+tax);
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
	if(!mode.equalsIgnoreCase("A")){
		String delsql="delete from av_taxdet where rdocno="+rdocno+" and ttype="+type;
		stmt.executeUpdate(delsql);
		String upsql="";int n=0;
		if(type.equalsIgnoreCase("1")){
			upsql="update av_fuelpriced set tax=round(replace('"+tax+"',',',''),2) where idno="+rdocno;
			n=stmt.executeUpdate(upsql);
		}
		else if(type.equalsIgnoreCase("2")){
			upsql="update av_fuelpriced set itax=round(replace('"+tax+"',',',''),2) where idno="+rdocno;
			n=stmt.executeUpdate(upsql);
		}
		if(n==0){
			errorstatus=1;
		}
	}	
	if(errorstatus==0){
		for(int i=0;i< griddataarray.size();i++){
			String[] arrayDet=((String) griddataarray.get(i)).split("::");
			if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
			{
				String sql="insert into av_taxdet(rdocno, taxid, curr, perc, amount, ttype) values("
						+rdocno+","
						+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
						+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
						+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
						+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
						+type+")";
				int resultSet2 = stmt.executeUpdate (sql);
				System.out.println("--insert--"+resultSet2);
				if(resultSet2<=0)
				{
					conn.close();
					errorstatus = 1;
				}
				else{
					String userid=session.getAttribute("USERID").toString();
					String brhid =session.getAttribute("BRANCHID").toString();
					PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
					 
					 stmtlog.setString(1,rdocno);
					 stmtlog.setInt(2,Integer.parseInt(brhid));
					 stmtlog.setString(3,"APM");
					 stmtlog.setString(4, userid);
					 stmtlog.setInt(5, 0);
					 stmtlog.setInt(6, 0);
					 stmtlog.setString(7, "E");
					 
					 log=stmtlog.executeUpdate();
					 System.out.println("--bib--"+log);
					 if(log<=0){
						errorstatus=1;
					 }
				}
			}
			else{
				if(log<=0){
					errorstatus=1;
				 }
			}
		}
	}

	if(errorstatus==0){
		conn.commit();
		conn.close();
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