 
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
 
String agtype=request.getParameter("agtype");
String agto=request.getParameter("agto");
String epmt=request.getParameter("equipment");
String trackid=request.getParameter("trackid");
 
String remarks=request.getParameter("remarks");
String expdate=request.getParameter("expdate");
String list=request.getParameter("listss")==null?"0":request.getParameter("listss");

//System.out.println("list="+list);
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlexpdate=null;

	 String upsql=null;
	 int val=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
 	
	Statement stmt = conn.createStatement ();
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
			String jobtrno=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
			
			String typeid=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
			
 
			
	 
		   if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0")))
			{
			   sqlexpdate=ClsCommon.changeStringtoSqlDate(expdate);
				
			}
			else{

			}
 
 
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from cr_assignment";
		        
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
			    
			 Statement st1=conn.createStatement();
			 Statement st2=conn.createStatement();
			     			 
/* 		    	String sqlss1111="update  cr_qotd set agtype='"+agtype+"',agdate=NOW(),agto='"+agto+"',expdate='"+sqlexpdate+"',equipment='"+epmt+"',remarks='"+remarks+"'  where doc_no='"+docno+"'";
		    	
		    	 
		    	stmt.executeUpdate(sqlss1111);
		    	 */
			 
			 
		     
		    	String sqls11="delete from  cr_assignment where  rdocno="+docno+" and jobno="+jobtrno+" ";
		    	 
		    	stmt.executeUpdate(sqls11);
			   
		    	String sqlss="insert into cr_assignment(doc_no, rdocno, agtype, agdate, agto, expdate, equipment, remarks, userid,jobno,srvtype,trackid)value("+docval+","+docno+",'"+agtype+"',NOW(),'"+agto+"','"+sqlexpdate+"','"+epmt+"','"+remarks+"' ,'"+session.getAttribute("USERID").toString()+"',"+jobtrno+","+typeid+",'"+trackid+"') ";
			  
			 	  int aa1=st2.executeUpdate(sqlss);
			    	
			    
			 
			 
			 
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','CASM',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			   val= stmt.executeUpdate(upsql);
		}
			  
	   if(val>0)
		 {//
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
