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
		
		String pdocno=request.getParameter("prddocno")==null?"0":request.getParameter("prddocno");
		


		ArrayList<String> prodarray= new ArrayList<String>();
		String aa[]=list.split(",");
 
	 
		for(int i=0;i<aa.length;i++)
		{
				// System.out.println("----------"+aa[i]);
				 String bb[]=aa[i].split("::");
	  
	 					 String temp="";
				 for(int j=0;j<bb.length;j++)
				 { 
		 
							//  System.out.println("----------"+bb[j]);
							 temp=temp+bb[j]+"::";
		 
				}
				 prodarray.add(temp);
	 
		} 
 	
	 		
		
				Connection conn=null;
	    		 String sql="";
	  		     try
	    		 {
	  		    	 
	  		    	 conn = ClsConnection.getMyConnection();
	  		    	Statement stmt = conn.createStatement();
	  		    	Statement stmt1 = conn.createStatement();
	  		    	int comp_brach=0;
	   	             String sqlss="select if(brhid=0,1,2) types from my_desc where psrno="+pdocno+" ";
	   	             
	   	            // System.out.println("==sqlss======="+sqlss);
	   	             ResultSet rss=stmt1.executeQuery(sqlss);
	 					   if(rss.first())
	 					   {
	 						  comp_brach=rss.getInt("types") ;
	 					   }
					
					
					for(int k=0;k< prodarray.size();k++){
						String[] prod=((String) prodarray.get(k)).split("::");
						if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){


							if(k==0)
							{
								String delsql="delete  from my_desc where psrno='"+pdocno+"'";
								stmt.executeUpdate(delsql);
							}
							
							
							if(comp_brach==2 || comp_brach==0)
							{
							String sql10="INSERT INTO my_desc(psrno, brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
									+ " ('"+pdocno+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
									+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
									+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



							///System.out.println("branchper--->>>>Sql"+sql10);
							stmt.executeUpdate (sql10);
							}
							
							else if(comp_brach==1)
							{
								String sql11="INSERT INTO my_desc(psrno, cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
										+ " ('"+pdocno+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
										+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
										+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
										+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
										+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
										+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"' ,"
										+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
										+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



								/// System.out.println("branchper--->>>>sql11"+sql11);
								 stmt.executeUpdate (sql11);
							}
						 
						}

					}

		
/* 					for(int k=0;k<pmgntarray.size();k++)
					{
		
						   
		 
	 
								String[] pmgntarr=((String) pmgntarray.get(k)).split("::"); 
 
								String psrno=""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";		
								String  doc_no=""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
								String  reorderlevels=""+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"";
								String  reorderqtys=""+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"";
								
	 
								
								
	
								String updatesqls1=" update my_desc set reorderlevel="+reorderlevels+",reorderqty="+reorderqtys+" where psrno="+psrno+" and doc_no="+doc_no+" ";
								stmt.executeUpdate(updatesqls1);
								System.out.println("updatesqls1="+updatesqls1);
	
								
					 }
	 */
	
					stmt.close();
		 
					conn.close();
					response.getWriter().print(1);
    	
   				
	    	}
    		catch(Exception e)
   			 {
    					e.printStackTrace();
    					 response.getWriter().print(2);
   			 }
	  		 finally
	  		 {
    	
    					conn.close();
    					
   			 }
%>



 