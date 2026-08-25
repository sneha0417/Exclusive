<%@page import="com.itextpdf.text.log.SysoCounter"%>
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
 <%@page import="com.dashboard.projectexecution.engineeringconfirmationupdate.ClsEngineeringConfirmationDAO"%>
<%
ClsEngineeringConfirmationDAO sd=new ClsEngineeringConfirmationDAO();
%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String trdocno=request.getParameter("trdocno").trim();
		
		String fdate=request.getParameter("fldate").trim();
		String remark=request.getParameter("remark");
		String bibpid=request.getParameter("bibpid");
		
		String brchid=request.getParameter("brchid");
		String userid=request.getParameter("userid");
		String queryarray=request.getParameter("productarray")==null || request.getParameter("productarray").trim().equalsIgnoreCase("")?"0":request.getParameter("productarray").toString();
		String contracttrno=request.getParameter("contracttrno").trim();
		java.sql.Date sqlDate=null;
	    if(!(fdate.equalsIgnoreCase("undefined"))&&!(fdate.equalsIgnoreCase(""))&&!(fdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(fdate);
		}
	   
	    String desc1="",prodoc="",psrno="",unitdocno="",qty="",amount="",total="",margin="",nettotal="",activityid="",site="",
	    		stypeid="",sitesrno="";
		String sql="",sqlsub="",sql1="",sqltrno="",sqltrno1="";
		
		String temp="";
		int val=0;
		 /*Submit */
		 
		 if((bibpid.equalsIgnoreCase("1")))
		{
			 sql="insert into gl_bengc( date, rtrno, fdate, remarks, bibpid, brhid, userid, status) values(now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+","+brchid+","+userid+",3)";
			 val= stmt.executeUpdate(sql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		 if((bibpid.equalsIgnoreCase("2")))
			{
				sql="update gl_bengc set status=7 where rtrno="+trdocno+" ";
		    	int dat= stmt.executeUpdate(sql);
		    	 sql="insert into gl_bengc( date, rtrno, fdate, remarks, bibpid, brhid, userid, status) values( now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+","+brchid+","+userid+",7)";
				 val= stmt.executeUpdate(sql);
		    	if(val>0)
				 {
					 temp="1";
				 }	
			}	
		 /* if((bibpid.equalsIgnoreCase("3")))
			{
				 sql="insert into gl_bengc( date, rtrno, fdate, remarks, bibpid, brhid, userid, status) values(now(),"+trdocno+",'"+sqlDate+"','"+remark+"',"+bibpid+","+brchid+","+userid+",7)";
				 val= stmt.executeUpdate(sql);
				 if(val>0)
				 {
					 temp="1";
				 }
				 sql="update cm_prjestm set cstatus=1 where TR_NO="+trdocno+" ";
				
				 val= stmt.executeUpdate(sql);		 
				 if(val>0)
				 {
					 temp="1";
				 }
				 
				 sql="delete from gl_estconfirm where TR_NO="+trdocno+" ";
				 val= stmt.executeUpdate(sql);	
				 System.out.println("productarray=="+productarray);
				 String splt[]=productarray.split(",");
				 for(int i=0;i<splt.length;i++)
				 {
					 String data[]=splt[i].split("::");
					 
					 desc1=data[0].trim().equalsIgnoreCase("undefined") || data[0].trim().equalsIgnoreCase("NaN")|| data[0].trim().equalsIgnoreCase("")|| data[0].isEmpty()?"0":data[0].trim();
					 prodoc=data[1].trim().equalsIgnoreCase("undefined") || data[1].trim().equalsIgnoreCase("NaN")|| data[1].trim().equalsIgnoreCase("")|| data[1].isEmpty()?"0":data[1].trim();
					 psrno=data[2].trim().equalsIgnoreCase("undefined") || data[2].trim().equalsIgnoreCase("NaN")|| data[2].trim().equalsIgnoreCase("")|| data[2].isEmpty()?"0":data[2].trim();
					 unitdocno=data[3].trim().equalsIgnoreCase("undefined") || data[3].trim().equalsIgnoreCase("NaN")|| data[3].trim().equalsIgnoreCase("")|| data[3].isEmpty()?"0":data[3].trim();
					 qty=data[4].trim().equalsIgnoreCase("undefined") || data[4].trim().equalsIgnoreCase("NaN")|| data[4].trim().equalsIgnoreCase("")|| data[4].isEmpty()?"0":data[4].trim();
					 amount=data[5].trim().equalsIgnoreCase("undefined") || data[5].trim().equalsIgnoreCase("NaN")|| data[5].trim().equalsIgnoreCase("")|| data[5].isEmpty()?"0":data[5].trim();
					 total=data[6].trim().equalsIgnoreCase("undefined") || data[6].trim().equalsIgnoreCase("NaN")|| data[6].trim().equalsIgnoreCase("")|| data[6].isEmpty()?"":data[6].trim();
					
					 margin=data[7].trim().equalsIgnoreCase("undefined") || data[7].trim().equalsIgnoreCase("NaN")|| data[7].trim().equalsIgnoreCase("")|| data[7].isEmpty()?"0":data[7].trim();
					 nettotal=data[8].trim().equalsIgnoreCase("undefined") || data[8].trim().equalsIgnoreCase("NaN")|| data[8].trim().equalsIgnoreCase("")|| data[8].isEmpty()?"0":data[8].trim();
					 activityid=data[9].trim().equalsIgnoreCase("undefined") || data[9].trim().equalsIgnoreCase("NaN")|| data[9].trim().equalsIgnoreCase("")|| data[9].isEmpty()?"0":data[9].trim();
					 site=data[10].trim().equalsIgnoreCase("undefined") || data[10].trim().equalsIgnoreCase("NaN")|| data[10].trim().equalsIgnoreCase("")|| data[10].isEmpty()?"0":data[10].trim();
					 stypeid=data[11].trim().equalsIgnoreCase("undefined") || data[11].trim().equalsIgnoreCase("NaN")|| data[11].trim().equalsIgnoreCase("")|| data[11].isEmpty()?"0":data[11].trim();
					 sitesrno=data[12].trim().equalsIgnoreCase("undefined") || data[12].trim().equalsIgnoreCase("NaN")|| data[12].trim().equalsIgnoreCase("")|| data[12].isEmpty()?"0":data[12].trim(); 				
					 if(!(desc1.equalsIgnoreCase("0")) || !(psrno.equalsIgnoreCase("0")) || !(stypeid.equalsIgnoreCase("0")))
					 {
						 sqltrno1="INSERT INTO gl_estconfirm
						(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,
						site,sertypeid,sitesrno,costdocno) values ("+trdocno+","+(i+1)+",'"+desc1+"',"+prodoc+","+prodoc+","+unitdocno+","+qty+","+amount+","+total+","+margin+","+activityid+","+nettotal+",'"+site+"',"+stypeid+","+sitesrno+","+contracttrno+")";
					System.out.println("sqltrno===="+sqltrno1);
						 val=stmt.executeUpdate(sqltrno1);
					 }
					 
				 }
				 if(val>0)
				 {
					 temp="1";
				 }
				 
				 System.out.println("temp33=="+temp);
				 
			}*/
		 if((bibpid.equalsIgnoreCase("4")))
			{
			 //System.out.println("queryarray----------"+queryarray);             
			 //System.out.println("contracttrno=="+contracttrno);
			/*  sql="delete from gl_estconfirm where TR_NO="+trdocno+" ";
			 val= stmt.executeUpdate(sql);	 */
			 ArrayList<String> gridarray=new ArrayList<String>();
			 if(queryarray.length()>0){
				String temparray[]=queryarray.split(",");
				for(int i=0;i<temparray.length;i++){
					gridarray.add(temparray[i]);
				}            
			}   
			val=sd.insert(sqlDate, trdocno, remark, brchid, userid, bibpid, gridarray, contracttrno);
			 if(val>0)
			 {
				 temp="1";
			 }
			}
		 //System.out.println("temp=="+temp);
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
