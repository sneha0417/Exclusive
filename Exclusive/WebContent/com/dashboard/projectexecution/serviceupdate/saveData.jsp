<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
ClsServiceReportDAO sdao= new ClsServiceReportDAO();
	Connection conn = null;
	Statement stmt=null;
String temp="0";
ArrayList<String> activityarray= new ArrayList<String>();
ArrayList<String> tobeinvoicedarray= new ArrayList<String>();


SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
String dt=sdf.format(new java.util.Date());
java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
	try{
	 	conn = ClsConnection.getMyConnection();
	 	 //conn.setAutoCommit(false);
		stmt = conn.createStatement();
		//activityarray=null;	
		String btnaction=request.getParameter("btnaction")==null?"":request.getParameter("btnaction");
	//System.out.println("1");
		int txtcustomerdocno=request.getParameter("txtcustomerdocno")==null || request.getParameter("txtcustomerdocno")==""?0:Integer.parseInt(request.getParameter("txtcustomerdocno"));
		int txtcustomeracno=request.getParameter("txtcustomeracno")==null || request.getParameter("txtcustomeracno")==""?0:Integer.parseInt(request.getParameter("txtcustomeracno"));
		String cmbcontracttype=request.getParameter("cmbcontracttype")==null?"":request.getParameter("cmbcontracttype");
		String txtcontracttrno=request.getParameter("txtcontracttrno")==null?"":request.getParameter("txtcontracttrno");
		String txtsiteid=request.getParameter("txtsiteid")==null?"":request.getParameter("txtsiteid");
		String txtareaid=request.getParameter("txtareaid")==null?"":request.getParameter("txtareaid");
		int txtscheduleno=request.getParameter("txtscheduleno")==null || request.getParameter("txtscheduleno")==""?0:Integer.parseInt(request.getParameter("txtscheduleno"));
		String servicetype=request.getParameter("servicetype")==null?"0":request.getParameter("servicetype");
		double txtxper=request.getParameter("txtxper")==null || request.getParameter("txtxper")==""?0.0:Double.parseDouble(request.getParameter("txtxper"));
		String txtdesc=request.getParameter("txtdesc")==null?"":request.getParameter("txtdesc");
		int rectval=request.getParameter("rectval")==null || request.getParameter("rectval")==""?0:Integer.parseInt(request.getParameter("rectval"));
		int txtsrtrno=request.getParameter("txtsrtrno")==null || request.getParameter("txtsrtrno")==""?0:Integer.parseInt(request.getParameter("txtsrtrno"));
		int txtsrdocno=request.getParameter("txtsrdocno")==null || request.getParameter("txtsrdocno")==""?0:Integer.parseInt(request.getParameter("txtsrdocno"));
		//System.out.println("2");  
		
		if(btnaction.equalsIgnoreCase("btnsave"))
		{
			activityarray.add(servicetype+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"Auto Generated Service Report"+"::");
			if(txtsrtrno>0){
				boolean Status=sdao.edit(txtsrdocno,"SRVE",txtsrtrno,sqlDate,"",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
				txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"E",rectval,txtdesc);
				//System.out.println("3");
				if(Status)
		{
			temp="1";
		}
		else{
			temp="0";
		}
			}
			else{
			int val=sdao.insert(sqlDate,"SRVE","",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
					txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"A",rectval,txtdesc);
			//System.out.println("4");
			if(val>0)
			{
				temp="1";
			}
			}
		}
		else{
			
			String sql="update cm_srvdetm set confirm=1 where tr_no="+txtsrtrno+"";	
			//System.out.println("sql===="+sql);
		 int val=stmt.executeUpdate(sql);	
		 if(val>0)
		 {
			 temp="1";
		 }
		}
		 response.getWriter().print(temp);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
