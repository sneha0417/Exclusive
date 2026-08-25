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
<%@page import="com.controlcentre.masters.client.ClsClientDAO" %>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
ClsClientDAO clientDAO=new ClsClientDAO();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String trdocno=request.getParameter("trdocno").trim();
		String fdate=request.getParameter("fldate").trim();
		String remark=request.getParameter("remark");
		String bibpid=request.getParameter("bibpid");
		String leadstatus=request.getParameter("leadstatus");
		String brchid=request.getParameter("brchid");
		String userid=request.getParameter("userid");
		String clientacid=request.getParameter("clientacid");
		String catid=request.getParameter("catid");
		String salesmanid=request.getParameter("salid");
		java.sql.Date sqlDate=null;
	    if(!(fdate.equalsIgnoreCase("undefined"))&&!(fdate.equalsIgnoreCase(""))&&!(fdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(fdate);
		}

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		 
		 if((bibpid.equalsIgnoreCase("1")))
		{
			 sql="insert into gl_blmf( date, trdocno, fdate, remarks, bibpid, leadstatus, brhid, userid, status) values(now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+",0,"+brchid+","+userid+",3);";
			 val= stmt.executeUpdate(sql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		 if((bibpid.equalsIgnoreCase("2")))
			{
				sql="update gl_blmf set status=7 where trdocno="+trdocno+" ";
		    	int dat= stmt.executeUpdate(sql);
		    	 sql1="insert into gl_blmf( date, trdocno, fdate, remarks, bibpid, leadstatus, brhid, userid, status) values( now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+",0,"+brchid+","+userid+",7)";
				 val= stmt.executeUpdate(sql1);
		    	if(val>0)
				 {
					 temp="1";
				 }	
			}	
		 if((bibpid.equalsIgnoreCase("3")))
			{
				 sql="insert into gl_blmf( date, trdocno, fdate, remarks, bibpid, leadstatus, brhid, userid, status) values(now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+","+leadstatus+","+brchid+","+userid+",7);";
				 val= stmt.executeUpdate(sql);
				 
				 sql1="update cm_prosclientm set priorstatus="+leadstatus+" where TR_NO="+trdocno+" ";
				 System.out.println("update="+sql1);
				 val= stmt.executeUpdate(sql1);		 
				 if(val>0)
				 {
					 temp="1";
				 }
			}
		 if((bibpid.equalsIgnoreCase("4")))
			{
			 String name="",mob="",email="";
			 int salid=0;
			 String pdname="",pdmob="",pdemail="",pdtel="",pdact="",pdext="",area="";
			 ArrayList<String> cparray= new ArrayList<String>();
			 ArrayList<String> array2= new ArrayList<String>();
			 String sqls="select m.name,m.sal_id,m.mob,m.email from cm_prosclientm m  where TR_NO="+trdocno+"";
			 ResultSet rsstk = stmt.executeQuery(sqls);

				while(rsstk.next()) {
					name=rsstk.getString("name");
					salid=rsstk.getInt("sal_id");
					mob=rsstk.getString("mob");
					email=rsstk.getString("email");
				}
				
				String sqlpd="select pd.cperson,pd.mob,pd.email,pd.tel,pd.actvty_id,pd.extn from cm_prosclientd pd where pd.rtrno="+trdocno+"";
				 ResultSet rspd = stmt.executeQuery(sqlpd);

					while(rspd.next()) {
						pdname=rspd.getString("cperson");
						pdmob=rspd.getString("mob");
						pdemail=rspd.getString("email");
						pdtel=rspd.getString("tel");
						pdact=rspd.getString("actvty_id");
						pdext=rspd.getString("extn");
					
						cparray.add(pdname+"::"+pdmob+" :: "+pdtel+" :: "+pdext+" :: "+pdemail+" :: "+area+" :: "+area+" :: "+pdact);
					}
			int dat=clientDAO.insert(sqlDate,name,0,Integer.parseInt(clientacid),salid,Integer.parseInt(catid),"","",0.0,0.0,0.0,"","",mob,"","","",
					 email,"",0,"","","","","","","",0,"",cparray,session,"A","CRM","","",request,0,0,array2);
	
			// System.out.println("dat==="+dat);
				 sql="insert into gl_blmf( date, trdocno, fdate, remarks, bibpid, leadstatus, brhid, userid, status) values(now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+",0,"+brchid+","+userid+",7);";
				 val= stmt.executeUpdate(sql);
				 
				 sql1="update cm_prosclientm set clientacid="+clientacid+" where TR_NO="+trdocno+" ";
				 System.out.println("update="+sql1);
				 val= stmt.executeUpdate(sql1);		 
				 if(val>0)
				 {
					 temp="1";
				 }
			}
		 if((bibpid.equalsIgnoreCase("5")))
			{
			     sql1="update cm_prosclientm set sal_id="+salesmanid+" where TR_NO="+trdocno+" ";
				 System.out.println("update="+sql1);
				 val= stmt.executeUpdate(sql1);		 
				 if(val>0)
				 {
					 temp="1";
				 }
			}
		  
		 response.getWriter().print(temp);
 		stmt.close();
 		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
