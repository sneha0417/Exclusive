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
	 
		Statement stmt1 = conn.createStatement();
		ArrayList<String> masterarray= new ArrayList<String>();
		
		String refNo="",description="";
		int issuetype=0,costtype=0,costdocno=0,siteid=0,locId=0,cldocno=0,brhid=0;
		java.sql.Date dates=null;
		String mastersql="select dtype, refNo,date,issuetype,costtype,costdocno,siteid,locId,description,cldocno,brhid from my_mreqm where doc_no='"+masterdocno+"'";
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
				 
				brhid=rsmatersel.getInt("brhid");	
			}
		
			for(int k=0;k<proday.size();k++)
			{
				String[] prod=((String) proday.get(k)).split("::"); 
				String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			 
				String psrno=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
				int prdid=Integer.parseInt(psrno);
				int unitid=0,specno=0;
				double qty=0;
			  	String sqlsel=" select   ROWNO,  prdId,  UNITID, SpecNo,qty from my_mreqd where rdocno="+masterdocno+" and rowno='"+rowno+"' " ; 
			//	System.out.println("--------sqlsel-------"+sqlsel);
			  	
				ResultSet rssel=stmt.executeQuery(sqlsel);
					if(rssel.next())
					{
						prdid=rssel.getInt("prdId");	
						specno=rssel.getInt("SpecNo");	
						unitid=rssel.getInt("UNITID");	
						qty=rssel.getDouble("qty");	
					}
					String updatesql="update my_mreqd set approval=1  where rowno='"+rowno+"' ";
				//	System.out.println("--------updatesql-------"+updatesql);
					stmt.executeUpdate(updatesql);
					int etrno=0;
				/* 	String sqlsel11=" select eq.esttrno from cm_srvcontrm cm left join gl_enqm eq on cm.reftrno=eq.qottrno where cm.tr_no='"+costdocno+"' and dtype='sjob' "; */
					//System.out.println("--------sqlsel11-------"+sqlsel11);
				String sqlsel11="select pq.tr_no esttrno from cm_srvcontrm cm inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+"	left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 "
					+"	left join cm_srvdetm sm on sm.TR_no=sq.refdocno and sQ.ref_type='SRVE' "
					+"	left join cm_prjestm Pq on ((Eq.doc_no=pq.refdocno and pq.ref_type ='ENQ') or (SM.DOC_NO=pq.refdocno and pq.ref_type ='SRVE')) "
					+"	and pq.status=3  where cm.tr_no='"+costdocno+"' and cm.dtype='sjob' ";
					ResultSet rssel1=stmt.executeQuery(sqlsel11);
					if(rssel1.next())
					{
						etrno=rssel1.getInt("esttrno");
					}
					
					double eqtys=0;
					double saveqtys=0;
					String sqlss=" select sum(coalesce(qty,0)) qty from gl_estconfirm where tr_no='"+etrno+"' and psrno="+prdid+" ";
					ResultSet rss=stmt.executeQuery(sqlss);
					if(rss.next())
					{
						eqtys=rss.getDouble("qty");
					}
					if(eqtys>0)
					{
						saveqtys=qty-eqtys;
					}
					else
					{
						saveqtys=qty;
					}
					
					
					String updatesqls=" insert into gl_estconfirm(tr_no,  SR_NO, psrno, prdId, qty,  UNITID, SpecNo, costdocno) value  "
									 +" ('"+etrno+"','"+(k+1)+"','"+prdid+"','"+prdid+"','"+saveqtys+"','"+unitid+"','"+specno+"','"+costdocno+"') ";
					
					
				 	//System.out.println("--------updatesqls-------"+updatesqls);
					stmt.executeUpdate(updatesqls);
				 
			}
		
 
				
				response.getWriter().print(1);
				 conn.commit();
				conn.close();
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(2);
	    }
	 	
	 	
%>



 