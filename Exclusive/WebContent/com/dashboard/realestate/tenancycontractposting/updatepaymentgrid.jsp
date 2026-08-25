<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");    
int rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?0:Integer.parseInt(request.getParameter("rdocno").trim().toString());
    
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;
System.out.println("gridarray ="+gridarray);

try{
	
	conn=objconn.getMyConnection();
	//conn.setAutoCommit(false);
	
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		
		System.out.println("new array ="+newarray);		
		
		for(int i=0;i<newarray.size();i++){
			 
					if (i == 0 ) {
						String sqls = "delete from rl_tncpayment where rdocno=" + rdocno;
						stmt.executeUpdate(sqls); 
					}
					
				String[] ar11 = ((String) newarray.get(i)).split("::");

				if (!(ar11[1].trim().equalsIgnoreCase("undefined")
						|| ar11[1].trim().equalsIgnoreCase("0")
						|| ar11[1].trim().equalsIgnoreCase("")
						|| ar11[1].trim().equalsIgnoreCase("NaN") || ar11[1]
							.isEmpty())) {
					
					String desc1=(ar11[0].trim().equalsIgnoreCase( "undefined") || ar11[0].trim().equalsIgnoreCase( "") || ar11[0].trim().equalsIgnoreCase( "NaN") || ar11[0].isEmpty() ? "0" : ar11[0].trim());
					java.sql.Date date=(ar11[1].trim().equalsIgnoreCase( "undefined") || ar11[1].trim().equalsIgnoreCase( "") || ar11[1].trim().equalsIgnoreCase( "NaN") || ar11[1].isEmpty() ? null : ClsCommon .changeStringtoSqlDate(ar11[1] .trim()));
					String amount=(ar11[2].trim().equalsIgnoreCase( "undefined") || ar11[2].trim().equalsIgnoreCase( "") || ar11[2].trim().equalsIgnoreCase( "NaN") || ar11[2].isEmpty() ? "0" : ar11[2].trim());
					String notes=(ar11[3].trim().equalsIgnoreCase( "undefined") || ar11[3].trim().equalsIgnoreCase( "") || ar11[3].trim().equalsIgnoreCase( "NaN") || ar11[3].isEmpty() ? "0" : ar11[3].trim());
					String chqno=(ar11[4].trim().equalsIgnoreCase( "undefined") || ar11[4].trim().equalsIgnoreCase( "") || ar11[4].trim().equalsIgnoreCase( "NaN") || ar11[4].isEmpty() ? "0" : ar11[4].trim());
					String paidto=(ar11[5].trim().equalsIgnoreCase( "undefined") || ar11[5].trim().equalsIgnoreCase( "") || ar11[5].trim().equalsIgnoreCase( "NaN") || ar11[5].isEmpty() ? "Self" : ar11[5].trim());
					String payment=(ar11[6].trim().equalsIgnoreCase( "undefined") || ar11[6].trim().equalsIgnoreCase( "") || ar11[6].trim().equalsIgnoreCase( "NaN") || ar11[6].isEmpty() ? "0" : ar11[6].trim());
					String bank=(ar11[7].trim().equalsIgnoreCase( "undefined") || ar11[7].trim().equalsIgnoreCase( "") || ar11[7].trim().equalsIgnoreCase( "NaN") || ar11[7].isEmpty() ? "0" : ar11[7].trim());
					String recieptno=(ar11[9].trim().equalsIgnoreCase("undefined") || ar11[9].trim().equalsIgnoreCase("") || ar11[9].trim().equalsIgnoreCase("NaN") || ar11[9].isEmpty() ? "0" : ar11[9].trim());
					String sql = "insert into rl_tncpayment(rdocno,slno, desc1, date, pamount, notes, chqno, paidto, payment, bank,recieptno)values"
							+ "("+rdocno+","+(i + 1)+",'"+desc1+"','"+date+"','"+amount+"','"+notes+"','"+chqno+"','"+paidto+"','"+payment+"','"+bank+"','"+recieptno+"')";

					System.out.println("===sql=====" + sql);

					int aa = stmt.executeUpdate(sql);
					if (aa <= 0) { 
						msg="failed";
						//conn.commit();
					}
					else
					{
						msg="success";
					}
					
					
				}
		}
 }
 
 
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(msg);
%>