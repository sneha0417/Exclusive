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
<%@ page import="com.dashboard.projectexecution.materialissue.ClsMaterialIssueDAO"%>
<%
	ClsConnection ClsConnection=new ClsConnection();
	String list=request.getParameter("list")==null?"0":request.getParameter("list");
	String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");
	
	System.out.println("masterdocno=="+masterdocno);
	
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
	  Connection conn=null;
	    String sql="";
	    try
	    {
	    	
	    	
	    	
	    conn = ClsConnection.getMyConnection();
	    conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		String formcode="MR";
		ClsMaterialIssueDAO  saveObj=new ClsMaterialIssueDAO();
		ArrayList<String> masterarray= new ArrayList<String>();
		
		Statement stmtaa = conn.createStatement ();
		
		int method=0;
		String chk="select method from  gl_prdconfig where field_nme='materialissueload' ";
		ResultSet rs=stmtaa.executeQuery(chk); 
		if(rs.next())
		{
			
			method=rs.getInt("method");
		}

		
		
			for(int k=0;k<proday.size();k++)
			{
				String[] prod=((String) proday.get(k)).split("::"); 
				String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
				String qty=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
				String psrno=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
				
				String rnos=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
				String res=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[4].isEmpty()?0:prod[4].trim())+"";
				int unitid=1,specno=Integer.parseInt(psrno);
				int prdid=Integer.parseInt(psrno);
				if(method==1)
				{
					
				  	String sqlsel=" select m.doc_no prdId,m.munit UNITID,mspecno SpecNo  from  my_main m  left join my_prodattrib at on(at.mpsrno=m.doc_no)  where m.psrno="+psrno+" " ; 
				  
				  	
				  	ResultSet rssel=stmt.executeQuery(sqlsel);
						if(rssel.next())
						{
							prdid=rssel.getInt("prdId");	
							specno=rssel.getInt("SpecNo");	
							unitid=rssel.getInt("UNITID");	
							
						}
				}
				
				else
				{
				
		
			  	String sqlsel=" select   ROWNO,  prdId,  UNITID, SpecNo from my_mreqd where rdocno="+masterdocno+" and rowno='"+rowno+"' " ; 
			  	
			  	System.out.println("my_reqd select====="+sqlsel);
			  	
				ResultSet rssel=stmt.executeQuery(sqlsel);
					if(rssel.next())
					{
						prdid=rssel.getInt("prdId");	
						specno=rssel.getInt("SpecNo");	
						unitid=rssel.getInt("UNITID");	
						
					}
				}
					
					
				masterarray.add(psrno+"::"+prdid+" :: "+unitid+" :: "+qty+" :: "+0+" :: "+0+" :: "+specno+" :: "+0+" :: "+0+" :: "+0+" :: "+rnos+" :: "+res+" :: "+0+"");
			}
		
		String refNo="",description="";
		int issuetype=0,costtype=0,costdocno=0,siteid=0,locId=0,cldocno=0,brhid=0;
		java.sql.Date dates=null;
	
		if(method==1)
		{
		
			locId=1;
			
			String mastersql="select u.costtype,es.costdocno,1 issuetype,m.date,si.rowno siteid ,m.brhid,s.cldocno  from cm_prjestm m left join gl_estconfirm es on es.tr_no=m.tr_no "
					+ " left join cm_srvcontrm s on es.costdocno=s.tr_no left join cm_srvcsited si on si.tr_no=s.tr_no"
							+ "  left join my_costunit u on u.costgroup=s.dtype where  m.tr_no='"+masterdocno+"' group by m.tr_no";
			 
			
			System.out.println("=master==== "+mastersql);
			
			
			ResultSet rsmatersel=stmt.executeQuery(mastersql);
				if(rsmatersel.next())
				{
					issuetype=rsmatersel.getInt("issuetype");	
					costtype=rsmatersel.getInt("costtype");	
					costdocno=rsmatersel.getInt("costdocno");	
					siteid=rsmatersel.getInt("siteid");	
					 
					cldocno=rsmatersel.getInt("cldocno");	
				//	description=rsmatersel.getString("description");
					//refNo=rsmatersel.getString("refNo");
					dates=rsmatersel.getDate("date");
				//	formcode=rsmatersel.getString("dtype");
					brhid=rsmatersel.getInt("brhid");	
				}
		}
		
		
		
		
		
		
		
		else
		{
			
			String mastersql="select dtype,refNo,date,issuetype,costtype,costdocno,siteid,locId,description,cldocno,brhid from my_mreqm m "
					+ " where doc_no='"+masterdocno+"'";
			
			System.out.println("costdocno selection====="+mastersql);
			
			ResultSet rsmatersel=stmt.executeQuery(mastersql);
				if(rsmatersel.next())
				{
					issuetype=rsmatersel.getInt("issuetype");	
					costtype=rsmatersel.getInt("costtype");	
					costdocno=rsmatersel.getInt("costdocno");	
					siteid=rsmatersel.getInt("siteid");	
					locId=rsmatersel.getInt("locId");	
					cldocno=rsmatersel.getInt("cldocno");	
					description=rsmatersel.getString("description");
					refNo=rsmatersel.getString("refNo");
					dates=rsmatersel.getDate("date");
					formcode=rsmatersel.getString("dtype");
					brhid=rsmatersel.getInt("brhid");
				
					
				}
				
		}
		
		
			
			
				int val=saveObj.insert(dates,refNo,description,0,session,"A","GIS",request,  
				masterarray,locId,cldocno,siteid,issuetype,costtype,costdocno,brhid,conn,Integer.parseInt(masterdocno));
				if(val>0)
				{
					 
					String updatesql1="update my_gism set rdtype='"+formcode+"', rrefno='"+masterdocno+"' where doc_no='"+val+"' ";
					
					
					System.out.println("gis update==="+updatesql1);
					
					stmt.executeUpdate(updatesql1);
					
					 
					
			 
					
					for(int k=0;k<proday.size();k++)
					{
						String[] prod=((String) proday.get(k)).split("::"); 
						String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						String qty=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
						String updatesql="update my_mreqd set clstatus=1,out_qty='"+qty+"' where rowno='"+rowno+"' ";
						
						
						System.out.println("my_mreqd update==="+updatesql);
						
						stmt.executeUpdate(updatesql);
					    Statement ss=conn.createStatement();
				        String sql11="select qty,out_qty from my_mreqd     where rowno='"+rowno+"'  and  out_qty>qty ";	
				        
				        
				        System.out.println("my_mreqd select==="+sql11);
				        
						ResultSet rs2=ss.executeQuery(sql11);
							if(rs2.next())
							{
								String sqls2="update my_mreqd set out_qty=qty where  rowno='"+rowno+"'  ";
								
								
								System.out.println("my_mreqd update==="+sqls2);
								
								ss.executeUpdate(sqls2);
								
							}
						
						
					}
					
					
					 
					 conn.commit();
					stmt.close();
					conn.close();
					response.getWriter().print(1);
					
				}
				else
				{
					response.getWriter().print(0);	
				}
				
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(2);
	    }
	 	
	 	
%>



 