 
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
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
	String refno=request.getParameter("refno");
	
	String enqdetdocno=request.getParameter("enqdetdocno");
	
	
 
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;

	 String upsql=null;
	 int val=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
	
	 
		   if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
			{
			sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
				
			}
			else{

			}
		   int ddocno=0;
		   String sqls=" select   rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where dtype='CAQF') and srno='"+cmbinfo+"' ";
		   ResultSet rsss=stmt.executeQuery(sqls);
		   
			   if(rsss.next())
			   {
				   ddocno= rsss.getInt("rowno");
			   }
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from cr_caqf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
			    
			    
			    
			    if(cmbinfo.equalsIgnoreCase("3"))
			    {
			    	
			    	String sqlss="update  cr_enqd set clstatus=1 where doc_no='"+enqdetdocno+"'";
			    	stmt.executeUpdate(sqlss);
			    	
			    }
			    
 		    
			    else  if(cmbinfo.equalsIgnoreCase("2"))
			    {
			 Statement st1=conn.createStatement();
			 Statement st2=conn.createStatement();
			    	int brhid=0;
			    	int cmpid=0;
			     	int cldocno=0;
			     	double amount=0;
			String sqlss1="select m.doc_no,m.brhid,m.cmpid,m.cldocno,sum(d.btotal) total from cr_qotm m "
					 +" left join cr_qotd d on d.rdocno=m.doc_no where m.doc_no='"+docno+"' and d.refdocno='"+enqdetdocno+"' ";
		 	ResultSet rsd1=st1.executeQuery(sqlss1);
	    	if(rsd1.first())
	    	{
	    		brhid=rsd1.getInt("brhid");
	    		cmpid=rsd1.getInt("cmpid");
	    		cldocno=rsd1.getInt("cldocno");
	    		amount=rsd1.getDouble("total");
	    	}
			 
			 
			 int tr_no=0;
			 int cdocno=0;  	
			    	String sqls11111111="select coalesce(max(tr_no)+1,1) tr_no from cm_srvcontrm  ";
			    	ResultSet rsd=st1.executeQuery(sqls11111111);
			    	if(rsd.first())
			    	{
			    		tr_no=rsd.getInt("tr_no");
			    	}
			    	
			    	
			    	String sqlsccc="select coalesce(max(doc_no)+1,1) doc_no from cm_srvcontrm where brhid='"+brhid+"'  ";
			    	ResultSet rsdxx=st1.executeQuery(sqlsccc);
			    	if(rsdxx.first())
			    	{
			    		cdocno=rsdxx.getInt("doc_no");
			    	}
			    	
			    	
			    	
			   		 String sqlss="insert into cm_srvcontrm(TR_NO, DOC_NO, DATE,  dTYPE, cmpid, brhid, netAmount, locId, "
			    		  + " Remarks, TRTYPE, userId, status, cldocno,  costId, costType, refTrNo, ref_type, grTotal, "
			    				  + "	refNo, jbaction, contractval, sjobtype )value("+tr_no+","+cdocno+",'"+sqlprocessdate+"','SJOB','"+cmpid+"','"+brhid+"','"+amount+"',1, "
			    				  + " '"+remarks+"','4','"+session.getAttribute("USERID").toString()+"',3,"+cldocno+",4,4,0,'DIR','"+amount+"',	'"+refno+"' , 1, '"+amount+"',1  ) ";
			 		  int aa=st2.executeUpdate(sqlss);
			 
			  
			   		 String sqlssdd="insert into cm_srvcsited(TR_NO, site, areaId )value("+tr_no+",'site1',1) ";
			    	 int aa1=st2.executeUpdate(sqlssdd);
			 	  
			 		 String sqlssdd1="insert into cr_joblist(jobno,enqdocno)value("+tr_no+",'"+enqdetdocno+"')";
				     int aa11=st2.executeUpdate(sqlssdd1);
			    	
			    	 String sqlss1111="update  cr_enqd set out_qty=out_qty+1 where doc_no='"+enqdetdocno+"'";
			    	 stmt.executeUpdate(sqlss1111);
			    	
			 	  
			 	 
			    	
			    }
			    
			    
			    
			    
		     upsql=" insert into cr_caqf (doc_no,date, rdocno, bibpid, fdate, remarks, userid, status,rrefno)values('"+docval+"',now(),'"+enqdetdocno+"','"+ddocno+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,'"+cmbinfo+"') ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 
			 
			 
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BRQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  
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
