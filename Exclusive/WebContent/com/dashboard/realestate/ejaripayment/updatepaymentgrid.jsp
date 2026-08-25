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
Double pymt=request.getParameter("amount")==null || request.getParameter("amount")==""?0.0:Double.parseDouble(request.getParameter("amount").trim().toString());
    
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
		int aa =0;
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		
		System.out.println("new array ="+newarray);		
		
		for(int i=0;i<newarray.size();i++){
			 
			String docno="0";
			String[] ar11 = ((String) newarray.get(i)).split("::");
			if (!(ar11[0].trim().equalsIgnoreCase("undefined")
					|| ar11[0].trim().equalsIgnoreCase("0")
					|| ar11[0].trim().equalsIgnoreCase("")
					|| ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0]
						.isEmpty())) {
				docno=(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty() ? 0: ar11[0].trim()).toString();
			    /* pymt=(ar11[1].trim().equalsIgnoreCase("undefined") || ar11[1].trim().equalsIgnoreCase("") || ar11[1].trim().equalsIgnoreCase("NaN") || ar11[1].isEmpty() ? 0.0: Double.parseDouble(ar11[1].trim())); */
				String sqltst="update rl_tncterms set ejaripay="+pymt+" where rdocno="+docno+"";
			   // System.out.println("update statement "+sqltst);
				aa = stmt.executeUpdate(sqltst);
				
				if(aa>0){
					String sqlBrhId="select brhid from rl_tncm where doc_no="+docno;
					ResultSet rsBrhId = stmt.executeQuery(sqlBrhId);
					int brhId=0;
					while (rsBrhId.next()) {
						brhId=rsBrhId.getInt("brhid");
					}
					
					String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+docno+","+brhId+",'EJPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Amount Updated')";   
					int val2 = stmt.executeUpdate(sql2);
				}	
			}
			
			
			}
		if (aa <= 0) { 
			msg="failed";
			//conn.commit();
		}
		else
		{
			msg="success";
		}
			
					/* if (i == 0 ) {
						String sqls = "delete from rl_tncpayment where rdocno=" + rdocno;
						stmt.executeUpdate(sqls); 
					}
					
				String[] ar11 = ((String) newarray.get(i)).split("::");

				if (!(ar11[1].trim().equalsIgnoreCase("undefined")
						|| ar11[1].trim().equalsIgnoreCase("0")
						|| ar11[1].trim().equalsIgnoreCase("")
						|| ar11[1].trim().equalsIgnoreCase("NaN") || ar11[1]
							.isEmpty())) {

					String sql = "insert into rl_tncpayment(rdocno,slno, desc1, date, pamount, notes, chqno, paidto, payment, bank,recieptno)values"
							+ "("
							+ rdocno
							+ ","
							+ (i + 1)
							+ ","
							+ "'"
							+ (ar11[0].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[0].trim().equalsIgnoreCase(
											"")
									|| ar11[0].trim().equalsIgnoreCase(
											"NaN") || ar11[0].isEmpty() ? 0
									: ar11[0].trim())
							+ "',"
							+ "'"
							+ (ar11[1].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[1].trim().equalsIgnoreCase(
											"")
									|| ar11[1].trim().equalsIgnoreCase(
											"NaN") || ar11[1].isEmpty() ? 0
									: ClsCommon
											.changeStringtoSqlDate(ar11[1]
													.trim()))
							+ "',"
							+ "'"
							+ (ar11[2].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[2].trim().equalsIgnoreCase(
											"")
									|| ar11[2].trim().equalsIgnoreCase(
											"NaN") || ar11[2].isEmpty() ? 0
									: ar11[2].trim())
							+ "',"
							+ "'"
							+ (ar11[3].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[3].trim().equalsIgnoreCase(
											"")
									|| ar11[3].trim().equalsIgnoreCase(
											"NaN") || ar11[3].isEmpty() ? 0
									: ar11[3].trim())
							+ "',"
							+ "'"
							+ (ar11[4].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[4].trim().equalsIgnoreCase(
											"")
									|| ar11[4].trim().equalsIgnoreCase(
											"NaN") || ar11[4].isEmpty() ? 0
									: ar11[4].trim())
							+ "',"
							+ "'"
							+ (ar11[5].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[5].trim().equalsIgnoreCase(
											"")
									|| ar11[5].trim().equalsIgnoreCase(
											"NaN") || ar11[5].isEmpty() ? 0
									: ar11[5].trim())
							+ "',"
							+ "'"
							+ (ar11[6].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[6].trim().equalsIgnoreCase(
											"")
									|| ar11[6].trim().equalsIgnoreCase(
											"NaN") || ar11[6].isEmpty() ? 0
									: ar11[6].trim())
							+ "',"
							+ "'"
							+ (ar11[7].trim().equalsIgnoreCase(
									"undefined")
									|| ar11[7].trim().equalsIgnoreCase(
											"")
									|| ar11[7].trim().equalsIgnoreCase(
											"NaN") || ar11[7].isEmpty() ? 0
									: ar11[7].trim()) + "','"+(ar11[8].trim().equalsIgnoreCase("undefined") || ar11[8].trim().equalsIgnoreCase("") || ar11[8].trim().equalsIgnoreCase("NaN") || ar11[8].isEmpty() ? 0 : ar11[8].trim())+"') ";
 */
					//System.out.println("===sql=====" + sql);

					
					
					
				
 }
 
 
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(msg);
%>