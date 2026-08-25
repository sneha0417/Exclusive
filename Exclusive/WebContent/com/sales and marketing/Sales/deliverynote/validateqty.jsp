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
int status=0;


     String list=request.getParameter("list")==null?"0":request.getParameter("list");

   ClsConnection ClsConnection=new ClsConnection();
   ClsCommon ClsCommon=new ClsCommon();
 //  System.out.println("-----list-------"+list);
     
    String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
    String location=request.getParameter("location")==null?"0":request.getParameter("location");
    String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
    String date=request.getParameter("date")==null?"0":request.getParameter("date");
    
    java.sql.Date sqlStartDate=null;


	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	{
		sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
	}


    
     String aa[]=list.split(",");

 	ArrayList<String> mainarray= new ArrayList<String>();
 	 
   for(int i=0;i<aa.length;i++){
 	 
 	 String bb[]=aa[i].split("::");
 
 	 String temp="";
 	 for(int j=0;j<bb.length;j++){ 
 		 temp=temp+bb[j]+"::";
 		 
 	}
 	//System.out.println("-----temp-------"+temp);
 	 
 	 mainarray.add(temp);
 	 
     } 
    Connection conn=null;
	Statement stmt =null;
    String sql="";
    
    String temp1="";
    String temp2="";
    double acqty=0;
    try
    {
   	
    	conn = ClsConnection.getMyConnection();
    	  stmt = conn.createStatement();
    	int mulqty=0;
    	Statement stmt31 = conn.createStatement (); 

    	String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
    	ResultSet rss31=stmt31.executeQuery(chk311); 
    	if(rss31.next())
    	{

    		mulqty=rss31.getInt("method");
    	}


     
    	
    	
			    
				
				
				int calcu=0;
				
				for(int k=0;k<mainarray.size();k++)
				{
				
				if(k==0)
					
				{
					stmt.executeUpdate("truncate my_stockchk");
				}	  
					
				      
				  
				  String[] serarray=mainarray.get(k).split("::");  
					//System.out.println("----serarray[0]--------"+serarray[0]);
				     
				     String  prdids=""+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"";
				     String specnos=""+(serarray[1].equalsIgnoreCase("undefined") || serarray[1].equalsIgnoreCase("") || serarray[1].trim().equalsIgnoreCase("NaN")|| serarray[1].isEmpty()?0:serarray[1].trim())+"";
				     String qtys=""+(serarray[2].equalsIgnoreCase("undefined") || serarray[2].equalsIgnoreCase("") || serarray[2].trim().equalsIgnoreCase("NaN")|| serarray[2].isEmpty()?0:serarray[2].trim())+"";
				     String unitdocno=""+(serarray[3].equalsIgnoreCase("undefined") || serarray[3].equalsIgnoreCase("") || serarray[3].trim().equalsIgnoreCase("NaN")|| serarray[3].isEmpty()?0:serarray[3].trim())+"";
				   
				//	System.out.println("----prdids--------"+prdids);	
					//System.out.println("----specnos--------"+specnos);
				//	System.out.println("----qtys--------"+qtys);
					
					//System.out.println("----unitdocno--------"+unitdocno);
					 
			  		 
					
				 int prdid=Integer.parseInt(prdids);
				 int specno=Integer.parseInt(specnos);
				 double qty=Double.parseDouble(qtys);
				 
			     double fr=1;
			     String slss=" select fr from my_unit where psrno="+prdid+" and unit='"+unitdocno+"' ";
			     
			   //  System.out.println("====slss==="+slss);
			     ResultSet rv1=stmt.executeQuery(slss);
			     if(rv1.next())
			     {
			    	 fr=rv1.getDouble("fr"); 
			     }
			 
			   
				 double oldqtys=0;
				 
				   if(mode.equalsIgnoreCase("E"))
				     {
				    	 
					   String oldqty=""+(serarray[4].equalsIgnoreCase("undefined") || serarray[4].equalsIgnoreCase("") || serarray[4].trim().equalsIgnoreCase("NaN")|| serarray[4].isEmpty()?0:serarray[4].trim())+"";
					   
							   
							   Statement stmt1 = conn.createStatement ();
					     double fr1=1;
					     String slss1=" select fr from my_unit where psrno="+prdid+" and unit='"+unitdocno+"' ";
					     
					     System.out.println("====slss==="+slss1);
					     ResultSet rv11=stmt1.executeQuery(slss1);
					     if(rv11.next())
					     {
					    	 fr1=rv11.getDouble("fr"); 
					     }
			    	 
					  oldqtys=Double.parseDouble(oldqty);
						 
					oldqtys=oldqtys*fr1;
							   
				     }
				 
			     
			     
				 
				 String sqls="insert into my_stockchk( qty, psrno,specno,unit,oldqty) values("+qty*fr+","+prdid+","+specno+","+unitdocno+","+oldqtys+") ";
				 
				 int rl= stmt.executeUpdate(sqls);
				 
				 
				// System.out.println("----rl--------"+rl);
				 
				 
				}
				
				
				
				
				
				
				for(int k=0;k<mainarray.size();k++)
				{
			    
				  
				  String[] serarray=mainarray.get(k).split("::");  
					 
				     
				     String  prdids=""+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"";
				     String specnos=""+(serarray[1].equalsIgnoreCase("undefined") || serarray[1].equalsIgnoreCase("") || serarray[1].trim().equalsIgnoreCase("NaN")|| serarray[1].isEmpty()?0:serarray[1].trim())+"";
				     String qtys=""+(serarray[2].equalsIgnoreCase("undefined") || serarray[2].equalsIgnoreCase("") || serarray[2].trim().equalsIgnoreCase("NaN")|| serarray[2].isEmpty()?0:serarray[2].trim())+"";
				     String unitdocno=""+(serarray[3].equalsIgnoreCase("undefined") || serarray[3].equalsIgnoreCase("") || serarray[3].trim().equalsIgnoreCase("NaN")|| serarray[3].isEmpty()?0:serarray[3].trim())+"";
				   
				   //  System.out.println("====prdids==="+prdids);
					 int prdid=Integer.parseInt(prdids);
					 int specno=Integer.parseInt(specnos);
					 double qty=Double.parseDouble(qtys);
			
					     
					 
					   
						
						
					  double actqty=0;
					  double qtyold=0;
					
				    String slsss=" select sum(qty) actqty,sum(oldqty)  oldqty from my_stockchk where  psrno="+prdid+"    and specno="+specno+" group by psrno";
				     
				    System.out.println("====slsss==="+slsss);
				     ResultSet rv21=stmt.executeQuery(slsss);
				     if(rv21.next())
				     {
				    	 actqty=rv21.getDouble("actqty"); 
				    	 qtyold=rv21.getDouble("oldqty"); 
				     }
				 
					
				     
				     double stockqty=0;
				     String stksql=" select (sum(op_qty)-sum(out_qty+rsv_qty+del_qty)) stockqty  from my_prddin where psrno="+prdid+" and brhid="+branch+" and locid="+location+" and specno="+specno+" and  date<='"+sqlStartDate+"'  group by psrno ";
				     
				    System.out.println("====stksql==="+stksql);
				     ResultSet rv23=stmt.executeQuery(stksql);
				     if(rv23.next())
				     {
				    	 stockqty=rv23.getDouble("stockqty"); 
				     }
				     
				  
				 
				     
				     System.out.println("===actqty==="+actqty); 
				     
				     System.out.println("===stockqty==="+stockqty); 
				     System.out.println("===qtyold==="+qtyold); 
				     
				     if(actqty>(stockqty+qtyold))
				     {
				    	 
				       //System.out.println("==In==1==="); 
				    	 status=1;
				    	 break;
				    	 
				     }
				     
		 
				 
 
				 
				 
				}
				
				
			 	 System.out.println("====status==="+status);  
				   if(status==1)
				     {
						
						if(sqlStartDate==null)
						{
							   response.getWriter().print(0); 
						}
						else
						{
							   response.getWriter().print(1); 	
						}
					     
					   
					
				    	 
				     }
				   else
				   {
					   response.getWriter().print(0); 
				   }
			     
				
			 
			
				       
			      stmt.executeUpdate("truncate my_stockchk");    	 
				   
				 
    	 
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	response.getWriter().print(0);
   	 stmt.executeUpdate("truncate my_stockchk");
    	 
    	 
    }
    finally
    {
   	stmt.close();
   	conn.close();
    }
	 	
	 	
	 	
%>
