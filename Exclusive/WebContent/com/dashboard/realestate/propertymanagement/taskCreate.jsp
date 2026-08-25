<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%

		System.out.println("taskcreation");
	
		//String task=request.getParameter("task");
		String sdate=request.getParameter("sdate");
		String stime=request.getParameter("stime");
		String user=request.getParameter("user");
		String hiduser=request.getParameter("hiduser");          
		String desc=request.getParameter("desc");
		String userid=request.getParameter("userid");
		String type="";  
		
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	
	
	Connection conn=null;
	
	
	int i=0;
	String msg="";
	String doc="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		
		
		    CallableStatement stmt=conn.prepareCall("{call an_taskcreationDML(?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(7, java.sql.Types.INTEGER);
			//stmt.setString(1,task);
			stmt.setString(1,sdate);
			stmt.setString(2,stime);
			stmt.setString(3,hiduser);  
			stmt.setString(4,desc);
			stmt.setString(5,userid);
			stmt.setString(6,type);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
				
				System.out.println("msg");
				msg="1";
				
				 
				
			}
			
			else
			{
				msg="0";
			}
		

	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	response.getWriter().write(msg);
%>