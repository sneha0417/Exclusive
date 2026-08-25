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
String vocnos=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
String brhids=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");     

ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;      
//System.out.println("=============="+gridarray);        
try{
	conn=objconn.getMyConnection();
	
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
			String job_docno = temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim().toString();    
			String vendor_docno = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0":temp[1].trim().toString();
			String pay = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"":temp[2].trim().toString();
			String est_cost = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0.0":temp[3].trim().toString();
			String margin = temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"0.0":temp[4].trim().toString();
			String total = temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?"0.0":temp[5].trim().toString();
			int rowsno= temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().isEmpty()?0:Integer.parseInt(temp[6].trim().toString());
			String docno = temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().equalsIgnoreCase("NaN") || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().isEmpty()?"0":temp[7].trim().toString();
			String vocno = temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().equalsIgnoreCase("NaN") || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().isEmpty()?"0":temp[8].trim().toString();
			String brhid = temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN") || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().isEmpty()?"0":temp[9].trim().toString();
			String workscope = temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().equalsIgnoreCase("NaN") || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().isEmpty()?"0":temp[10].trim().toString();

			if(rowsno>0){                                                            
				String sql="update re_mreqmgmt set rbrhid='"+brhid+"',rvocno='"+vocno+"',rdocno='"+docno+"',jobdocno='"+job_docno+"', vndacno='"+vendor_docno+"', paytype='"+pay+"', estval="+est_cost+", margin="+margin+", total="+total+",workscope='"+workscope+"' where rowno="+rowsno+"";   
				val=stmt.executeUpdate(sql); 
				//System.out.println(val+"====sql===="+sql);
			}else{ 
				String sql="insert into re_mreqmgmt(rbrhid, rvocno, rdocno, jobdocno, vndacno, paytype, estval, margin, total,workscope) values('"+brhid+"','"+vocno+"','"+docno+"','"+job_docno+"','"+vendor_docno+"','"+pay+"',"+est_cost+","+margin+","+total+",'"+workscope+"')";       
				val=stmt.executeUpdate(sql);   
				//System.out.println(val+"====sql===="+sql);
			}
			if(val>0){
				String sql3="update re_mreq set mstatus=1,statusid=2 where doc_no='"+docno+"'";               
				val=stmt.executeUpdate(sql3);    
				//System.out.println(val+"=====sql3===="+sql3); 
			}           
		}
	} 
		 if(val>0){   
				String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocnos+",'"+brhids+"','MMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Estimated')";               
				 val=stmt.executeUpdate(sqllog);  
				 //System.out.println(val+"====sqllog===="+sqllog);
			}
}    
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);           
%>