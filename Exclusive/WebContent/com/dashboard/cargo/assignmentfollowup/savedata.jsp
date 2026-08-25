 
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


	//String docno=request.getParameter("doc_no");
    String sdocno=request.getParameter("sdocno");
    String subsdocno=request.getParameter("subsdocno")==null || request.getParameter("subsdocno")==""?"0":request.getParameter("subsdocno");
    String list=request.getParameter("listss")==null?"0":request.getParameter("listss");

   System.out.println("list=="+list);
   System.out.println("sdoc_no=="+sdocno);
	 Connection conn=null;
	 String upsql=null;
	 int val=0;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	int aaa=0;
	int docval=0;
	
	ArrayList<String> proday= new ArrayList<String>();
	String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 proday.add(temp);
		  } 
		
		
		
		
		
		
		
		for(int k=0;k<proday.size();k++)
		{
			String[] prod=((String) proday.get(k)).split("::"); 
			String docno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			
			String branchids=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
			
 
			String adocno=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
			
			 
			
			
			
	
	if(sdocno.equalsIgnoreCase("99"))
	{

	    String sql="update cr_assignment  set pstatus=1, cur_status="+sdocno+" where doc_no="+adocno+";";
		  
		      aaa= stmt.executeUpdate(sql);
	    
	}
	else
	{
		
		
		
		String sql="update cr_assignment  set  cur_status="+sdocno+",cur_substatus="+subsdocno+" where doc_no="+adocno+";";
		 
		System.out.println("sql---"+sql);
		      aaa= stmt.executeUpdate(sql);
	}
	System.out.println("aaaaaa---"+aaa);


 
	
	 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchids+"','CASF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 
	   val= stmt.executeUpdate(upsql);
 }  
	   if(val>0)
		 {
		   
		   conn.commit();
           conn.close();
		 }			
		response.getWriter().print(val);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
