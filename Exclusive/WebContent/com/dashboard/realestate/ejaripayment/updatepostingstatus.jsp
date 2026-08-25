<%@page import="com.realestate.propertyinvoice.ClsPropertyInvoiceDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.common.*"%>

<%	
	String casharray=request.getParameter("agentarray")==null?"":request.getParameter("agentarray");
	int errorstatus=0;
	
	ArrayList<String> stparray=new ArrayList();
	String temparray[]=casharray.split(",");
	int aa =0;
	for(int i=0;i<temparray.length;i++){
		stparray.add(temparray[i]);
	}

	Connection conn=null;
	int val=0;
	int val2=0;
	 
	try{
		ClsConnection ClsConnection =new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqlprocessdate=null;
		
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement ();

	    for(int i=0;i<stparray.size();i++){			 
			String docno11="0";
			String[] ar11 = ((String) stparray.get(i)).split("::");
			if (!(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("0") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty())) {
				docno11=(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty() ? 0: ar11[0].trim()).toString();
			    
				String sql1="update rl_tncterms set paytrno="+9999999+" where rdocno="+docno11+"";
				System.out.println(sql1);
				val = stmt.executeUpdate(sql1);
				
				if(val>0){
					String sqlBrhId="select brhid from rl_tncm where doc_no="+docno11;
					ResultSet rsBrhId = stmt.executeQuery(sqlBrhId);
					int brhId=0;
					while (rsBrhId.next()) {
						brhId=rsBrhId.getInt("brhid");
					}
					
					String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+docno11+","+brhId+",'EJPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Mark As Posted')";   
					val2 = stmt.executeUpdate(sql2);
				}						
			}					
		} 
	   
	   if(val>0 && val2>0){
		   conn.commit();
	   }else{
			errorstatus=1;  
	   }
	   
		response.getWriter().print(errorstatus);
	}
	 catch(Exception e)
	 {
		 e.printStackTrace();
		 conn.close();
		 response.getWriter().print(errorstatus);
	 }
	finally{
		conn.close();
	}
	
	%>
