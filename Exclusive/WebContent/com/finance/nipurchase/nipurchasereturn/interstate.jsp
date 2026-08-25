
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

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

String docnos=request.getParameter("docnos")==null || request.getParameter("docnos")==""?"0":request.getParameter("docnos"); 
	



java.sql.Date sqlexdate=null;



	 String upsql=null;

	 int val=0;
	 int docval=0;
	 Connection conn=null;

	 try{
 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmt1 = conn.createStatement ();
	
		   
		
				   upsql="select method from gl_config where field_nme ='tax'";
				   ResultSet resultSet = stmt.executeQuery(upsql);
				    
				    if (resultSet.next()) {
				    	docval=resultSet.getInt("method");
				    }		  
			 if(docval==0){
		  			
				 upsql="select method from gl_prdconfig where field_nme ='tax'";
				   ResultSet resultSet1 = stmt1.executeQuery(upsql);
				   
				    if (resultSet1.next()) {
				    	docval=resultSet1.getInt("method");
				    }			
		 
			 }
			 
			 
			 int vals=0;
			 
			 
			 
			String sqls="select  coalesce(t1.tax,0) tax,t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate  from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
			    		+ "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
			    		+ "from my_curbook cr where  coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid)"
			    		+ "left join my_vndtax t1 on t1.doc_no=a.type  where a.active=1 and t.m_s=0 and  t.doc_no='"+docnos+"' ";
			
			
			
		    ResultSet rss=stmt.executeQuery(sqls);
		    
		    if(rss.first())
		    {
		    	
		    	vals=rss.getInt("tax");
		    }
			
			
	 
			 response.getWriter().print(docval+"::"+vals);
	 	stmt.close();
	 	stmt1.close();
	 	conn.close();
	 }
	 catch(Exception e){

			conn.close();
			e.printStackTrace();
		}
	    
	
	%>
