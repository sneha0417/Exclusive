package com.dashboard.leadmanagement.leadfollowuplog;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


 
public class ClsLeadFollowupLogDAO

{
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

		
	public  JSONArray subDetails(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        String sqltest="";
       
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	/*if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and b.rdocno="+cldocno+"";
        }*/
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
	      				String sql="  select u.user_name user,count(*) count,b.userid from gl_blmf b left join my_user u on u.doc_no=b.userid where b.fdate between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" group by b.userid "; 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	 public JSONArray clentdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' and pcase=0 ";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	
	public  JSONArray masterdetails(String usr,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
        
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
        
     	/*if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and bp.rdocno="+cldocno+"";
        }*/
        
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				 // System.out.println("-----code------"+code);
			
			String sql="select bp.date,  bp.trdocno,cm.name clientnme,cm.mob ,cm.email, bp.remarks comnt,fdate folupdate, process,b.branchname from gl_blmf bp\r\n" + 
					" left join cm_prosclientm cm on cm.tr_no=bp.trdocno\r\n" +
					" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
					"  left join  my_brch b on b.doc_no=bp.brhid where bp.fdate between  '"+sqlfromdate+"' and  '"+sqltodate+"' and  bp.userid='"+usr+"' "+sqltest+" ";
			//System.out.println("-----asdasd------"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public  JSONArray masterdetailsexcel(String usr,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
        
     	else{
    
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
        
     	/*if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and bp.rdocno="+cldocno+"";
        }*/
     	
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				 // System.out.println("-----code------"+code);
			
			String sql="select bp.date 'Date',  bp.trdocno 'Doc No',cm.name Clientnme,cm.mob 'Mobile',cm.email 'Email', bp.remarks comnt ,fdate Folupdate, process 'Process',b.branchname 'Branch' from gl_blmf bp\r\n" + 
					" left join cm_prosclientm cm on cm.tr_no=bp.trdocno\r\n" +
					" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
					"  left join  my_brch b on b.doc_no=bp.brhid where bp.date between  '"+sqlfromdate+"' and  '"+sqltodate+"' and  bp.userid='"+usr+"' "+sqltest+" ";
			//System.out.println("-----asdasdmmmmmmm------"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	
	public  ClsLeadFollowupLogBean getPrint(HttpServletRequest request,int cldocno,String fromdate,String todate) throws SQLException {
		ClsLeadFollowupLogBean bean = new ClsLeadFollowupLogBean();
		 Connection conn = null;
			
	        java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			String mainbranch="";
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
			
			
				mainbranch="1";
			
			String headersql="select b.branchname,'Client Followup Log' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
					+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
					+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";

					ResultSet resultSetHead = stmtVeh.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblprintname1(resultSetHead.getString("vouchername1"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						}
		
					
		String sqldet="select refname,acno,address,per_mob,codeno from my_acbook where status=3 and dtype='CRM' and pcase=0 and  cldocno='"+cldocno+"' ";				
					
		ResultSet resultSetdet = stmtVeh.executeQuery(sqldet);
		
		while(resultSetdet.next()){
			bean.setLblname(resultSetdet.getString("refname"));
			bean.setLblacno(resultSetdet.getString("acno"));
			bean.setLbladdress(resultSetdet.getString("address"));
			bean.setLblmobno(resultSetdet.getString("per_mob"));
			bean.setLblcodeno(resultSetdet.getString("codeno"));
				}		
					
			String sql = "";
			
			sql="select DATE_FORMAT(bp.date,'%d-%m-%Y') date,  bp.acno, bp.remarks comnt,DATE_FORMAT(fdate,'%d-%m-%Y')  folupdate, process,b.branchname,mu.user_name usern from gl_bcpf bp\r\n" + 
					"left join my_acbook a on a.acno=bp.acno\r\n" + 
					" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
					"  left join  my_brch b on b.doc_no=bp.brhid "
					+ "left join  my_user mu on mu.doc_no=bp.userid where bp.date between  '"+sqlFromDate+"' and  '"+sqlToDate+"' and  bp.rdocno='"+cldocno+"' ";

			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printclientarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("branchname")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("comnt")+"::"+resultSet1.getString("process")+"::"+resultSet1.getString("folupdate")+"::"+resultSet1.getString("usern");
				printclientarray.add(temp1);
			}
			request.setAttribute("printclientarray", printclientarray);
					
			stmtVeh.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
	
	
	
}




