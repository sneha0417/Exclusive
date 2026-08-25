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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
 
<% 
	ClsConnection ClsConnection=new ClsConnection();
	String list=request.getParameter("list")==null?"0":request.getParameter("list");
	String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");
	
	String val=request.getParameter("val")==null?"0":request.getParameter("val");
	
	
	ArrayList<String> arr1= new ArrayList<String>();
	 
		String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 arr1.add(temp);
		}

	  Connection conn=null;
	    String sql="";
	    try
	    {
	    	
	    conn = ClsConnection.getMyConnection();
	    conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		int mm=0;
			for(int k=0;k<arr1.size();k++)
			{
				String[] aaarsss=((String) arr1.get(k)).split("::"); 
				String desc1=""+(aaarsss[0].trim().equalsIgnoreCase("undefined") || aaarsss[0].trim().equalsIgnoreCase("NaN")|| aaarsss[0].trim().equalsIgnoreCase("")|| aaarsss[0].isEmpty()?0:aaarsss[0].trim())+"";
				String rownos=""+(aaarsss[1].trim().equalsIgnoreCase("undefined") || aaarsss[1].trim().equalsIgnoreCase("NaN")|| aaarsss[1].trim().equalsIgnoreCase("")|| aaarsss[1].isEmpty()?0:aaarsss[1].trim())+"";
			 
 
				int rowno=Integer.parseInt(rownos);
				
				System.out.println("aaaaaaaaa"+rowno);
				
				 
				if(val.equalsIgnoreCase("1") && rowno>0 &&  (!desc1.equalsIgnoreCase("0"))) 
				{
					String sqls="update  hr_designpretermsm set terms='"+desc1+"' where rdocno='"+masterdocno+"'and rowno='"+rownos+"' ";
					stmt.executeUpdate(sqls);
					
					
				}
				else if(val.equalsIgnoreCase("1") && rowno==0 && (!desc1.equalsIgnoreCase("0"))) 
				{
					
					String sqls="insert into hr_designpretermsm (rdocno,terms)values('"+masterdocno+"','"+desc1+"')";
					stmt.executeUpdate(sqls);
					
				}
				 
				else if(val.equalsIgnoreCase("2") && rowno>0 && (!desc1.equalsIgnoreCase("0"))) 
				{
					if(mm==0)
					{
						String sqls=" delete from  hr_designpretermsd where  refno='"+rownos+"'"	;
						stmt.executeUpdate(sqls);
						mm=1;
					}
					
					
					String sqls="insert into hr_designpretermsd (rdocno,terms,refno)values('"+masterdocno+"','"+desc1+"','"+rownos+"')";
					stmt.executeUpdate(sqls);
					
					
					
					
				}
				
					
				}
			
			 
			conn.commit();
			stmt.close();
			conn.close();
			response.getWriter().print(1);
			
				 
				
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(2);
	    }
	 	
	 	
%>



 