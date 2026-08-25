<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt=conn.createStatement();

		 String docNo=request.getParameter("docno")==null?"0":request.getParameter("docno");
		 String formcode=request.getParameter("dtype")==null?"":request.getParameter("dtype");
		 String serinter=request.getParameter("interval")==null?"0":request.getParameter("interval");
		 String srvtype=request.getParameter("frequency")==null?"0":request.getParameter("frequency");
		 String serdue=request.getParameter("servicedueafter")==null?"0":request.getParameter("servicedueafter");
		 String servicestartdate=request.getParameter("servicestartdate")==null?"0":request.getParameter("servicestartdate");
		 String editval=request.getParameter("editval")==null?"0":request.getParameter("editval");
		 String editfillval=request.getParameter("editfillval")==null?"0":request.getParameter("editfillval");
		 String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		
		 String sql=null,sql1=null;
		 int val = 0,docno=0,clientid=0,vocno=0,serstatus=3;
		 ArrayList<String> griddataarray=new ArrayList<String>();
		 ArrayList<String> serviceschedulerarray=new ArrayList<String>();
		 ArrayList<String> sitelistarray=new ArrayList<String>();
		
		 java.sql.Date serdate=null;
		
		 servicestartdate.trim();
		 if(!(servicestartdate.equalsIgnoreCase("undefined"))&&!(servicestartdate.equalsIgnoreCase(""))&&!(servicestartdate.equalsIgnoreCase("0"))){
			 serdate = ClsCommon.changeStringtoSqlDate(servicestartdate);
		 }
		
		
		 String[] temparray=gridarray.split(",");
		 for(int i=0;i<temparray.length;i++){
			 griddataarray.add(temparray[i]);
		 }
		
		 for(int i=0;i<griddataarray.size();i++){
			
			 String[] temp=griddataarray.get(i).split("::");
			 String pldate=temp[0];
			 String pltime=temp[1];
			 String priority=temp[2];
			 String trno=temp[3];
			 String workperc=temp[4];
			 String siteid=temp[5];
			
			 serviceschedulerarray.add(pldate+" :: "+pltime+" :: "+priority+" :: "+trno+" :: "+workperc+" :: "+siteid);
			
		 }
		
		 String selsqls="select cldocno,doc_no from cm_srvcontrm where tr_no="+docNo+"";
		 ResultSet resultdel = stmt.executeQuery(selsqls);
		 while(resultdel.next()){
			clientid=resultdel.getInt("cldocno");
			vocno=resultdel.getInt("doc_no");

		 }
			
		 String sitesql="select rowno, srvteamno from cm_srvcsited where tr_no="+docNo+"";
		 ResultSet resultsite = stmt.executeQuery(sitesql);
		 
		 while(resultsite.next()){
			 sitelistarray.add(resultsite.getString("rowno")+" :: "+resultsite.getString("srvteamno")+" :: ");
		 }
		 
		 String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bssu";
	        ResultSet resultSets = stmt.executeQuery(sqls);
	  
	        while (resultSets.next()) {
			   docno=resultSets.getInt("doc_no");
	        }
	        
	        if(serinter.trim().equalsIgnoreCase("")){
	        	serinter="0";
	        }
	        
	        if(serdue.trim().equalsIgnoreCase("")){
	        	serdue="0";
	        }
	        
	        if(serdate==null){
	        	
		        /*Inserting gl_bssu*/
			     String sql2="insert into gl_bssu(doc_no, date, tr_no, serinterval, serdueafter, fservDate, serduetype, userid) values("+docno+", now(), '"+docNo+"', '"+serinter+"', '"+serdue+"', null, '"+srvtype+"', '"+session.getAttribute("USERID").toString()+"')";
		         val= stmt.executeUpdate(sql2);
				 if(val<=0){
					    stmt.close();
						conn.close();
					}
				 /*Inserting gl_bssu Ends*/
	        } else {
	        	
	        	if(editval.equalsIgnoreCase("0") && editfillval.equalsIgnoreCase("1")){
			 		 String sqlContract="update cm_srvcontrm set serinterval='"+serinter+"', serdueafter='"+serdue+"', fservDate='"+serdate+"', serduetype='"+srvtype+"' where tr_no="+docNo+"";
			         val= stmt.executeUpdate(sqlContract);
					 if(val<=0){
						    stmt.close();
							conn.close();
						}
					 
					 String delContract="delete from cm_servplan where doc_no="+docNo+"";
				     int delval=stmt.executeUpdate (delContract);
			 	}
	        	
	        	/*Inserting gl_bssu*/
		   	     String sql2="insert into gl_bssu(doc_no, date, tr_no, serinterval, serdueafter, fservDate, serduetype, userid) values("+docno+", now(), '"+docNo+"', '"+serinter+"', '"+serdue+"', '"+serdate+"', '"+srvtype+"', '"+session.getAttribute("USERID").toString()+"')";
		         val= stmt.executeUpdate(sql2);
		   		 if(val<=0){
		   			    stmt.close();
		   				conn.close();
		   			}
		   		 /*Inserting gl_bssu Ends*/
	        }
		
		 for(int i=0;i<serviceschedulerarray.size();i++){
			 
			 String[] serviceschedule=((String) serviceschedulerarray.get(i)).split("::");
			 
			 String workpercentage=serviceschedule[4].trim().equalsIgnoreCase("undefined") || serviceschedule[4].trim().equalsIgnoreCase("NaN") || serviceschedule[4].trim().equalsIgnoreCase("") || serviceschedule[4].isEmpty()?"0":serviceschedule[4].trim();
			 String trno=serviceschedule[3].trim().equalsIgnoreCase("undefined") || serviceschedule[3].trim().equalsIgnoreCase("NaN") || serviceschedule[3].trim().equalsIgnoreCase("") || serviceschedule[3].isEmpty()?"0":serviceschedule[3].trim();
			 
			 if(Integer.parseInt(workpercentage)==0 && Integer.parseInt(trno)>0){
				 
					 if(!(serviceschedule[0].trim().equalsIgnoreCase("undefined")|| serviceschedule[0].trim().equalsIgnoreCase("NaN")||serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()))
						{	
							if(!(serviceschedule[3].trim().equalsIgnoreCase("undefined")|| serviceschedule[3].trim().equalsIgnoreCase("NaN")||serviceschedule[3].trim().equalsIgnoreCase("")|| serviceschedule[3].isEmpty()))
							{
								
								String sql1s="update cm_servplan set date='"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:ClsCommon.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ "plannedOn='"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:ClsCommon.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ "plTime='"+(serviceschedule[1].trim().equalsIgnoreCase("undefined") || serviceschedule[1].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[1].trim().equalsIgnoreCase("")|| serviceschedule[1].isEmpty()?0:serviceschedule[1].trim())+"',"
										+ "priorno='"+(serviceschedule[2].trim().equalsIgnoreCase("undefined") || serviceschedule[2].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[2].trim().equalsIgnoreCase("")|| serviceschedule[2].isEmpty()?0:serviceschedule[2].trim())+"' "
										+ "where doc_no="+(docNo)+" and tr_no="+trno+"";
								
								val = stmt.executeUpdate(sql1s);
								if(val<=0) {
									stmt.close();
									conn.close();
								}
							}
					
						}
				 
			 } else if(Integer.parseInt(workpercentage)==0 && Integer.parseInt(trno)==0){
				 
					for(int k=0;k<sitelistarray.size();k++){
					 
						 String[] sitelist=((String) sitelistarray.get(k)).split("::");
						
						 if(!(serviceschedule[0].trim().equalsIgnoreCase("undefined")|| serviceschedule[0].trim().equalsIgnoreCase("NaN")||serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()))
							{	
								
							 String sql1s="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno, refTrNo,doc_No,refdocno,siteid,status, cldocno,empGroupId) VALUES("
										+ " '"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:ClsCommon.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ " "+(i+1)+","
										+ " '"+(formcode)+"',"
										+ " "+(session.getAttribute("BRANCHID").toString())+","
										+ " '"+(formcode)+"',"
										+ " '"+(serviceschedule[0].trim().equalsIgnoreCase("undefined") || serviceschedule[0].trim().equalsIgnoreCase("NaN")|| serviceschedule[0].trim().equalsIgnoreCase("")|| serviceschedule[0].isEmpty()?0:ClsCommon.changetstmptoSqlDate(serviceschedule[0].trim()))+"',"
										+ " '"+(serviceschedule[1].trim().equalsIgnoreCase("undefined") || serviceschedule[1].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[1].trim().equalsIgnoreCase("")|| serviceschedule[1].isEmpty()?0:serviceschedule[1].trim())+"',"
										+ " '"+(serviceschedule[2].trim().equalsIgnoreCase("undefined") || serviceschedule[2].trim().equalsIgnoreCase("NaN:NaN")|| serviceschedule[2].trim().equalsIgnoreCase("")|| serviceschedule[2].isEmpty()?0:serviceschedule[2].trim())+"',"
										+ " "+(docNo)+","
										+ " "+(docNo)+","
										+ " "+(vocno)+","
										+ " "+(sitelist[0].trim().equalsIgnoreCase("undefined") || sitelist[0].trim().equalsIgnoreCase("NaN")|| sitelist[0].trim().equalsIgnoreCase("")|| sitelist[0].isEmpty()?"0":sitelist[0].trim())+","
								        + " '"+serstatus+"',"
								        + " '"+clientid+"',"
								        + " "+(sitelist[1].trim().equalsIgnoreCase("undefined") || sitelist[1].trim().equalsIgnoreCase("NaN")|| sitelist[1].trim().equalsIgnoreCase("")|| sitelist[1].isEmpty()?"0":sitelist[1].trim())+")";
								
								val = stmt.executeUpdate(sql1s);
								if(val<=0) {
									stmt.close();
									conn.close();
								}	
							}
				 	}
				 
			 }
			 
		 }
		
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','BSSU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
		 val= stmt.executeUpdate(sql);
	     
	     response.getWriter().print(val+"***"+docNo);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
