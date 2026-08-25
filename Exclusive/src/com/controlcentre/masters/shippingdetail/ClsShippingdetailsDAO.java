package com.controlcentre.masters.shippingdetail;
 
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsShippingdetailsDAO {

	
	
	Connection conn;
	ClsConnection ClsConnection=new ClsConnection();	 
	ClsCommon ClsCommon=new ClsCommon();
	
	

	public int insert(int chkcllient, int cldocno, String clname, String mode,
			String shipaddress, String formdetailcode, String contactperson,
			String shiptelephone, String shipemail, String shipmob,
			String shipfax, HttpServletRequest request, HttpSession session) throws SQLException {
 
	

		try
		{
		int	docno=0;
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
	 Statement	stmt=conn.createStatement(); 
	 	 
	 	String dsql="select coalesce(max(doc_no)+1,1) as docno from my_shipdetails";
		
		ResultSet resultSet = stmt.executeQuery(dsql);

		if(resultSet.next()){
			docno=resultSet.getInt("docno");
		}
	
		System.out.println("----chkcllient----"+chkcllient);
		if(chkcllient==1)
		{
		
	 	 String sqls="insert into my_shipdetails (doc_no, type, cldocno, claddress, contactperson, tel,email, mob, fax, status, brhid) values"
	 	 		+ "("+docno+","+chkcllient+",'"+cldocno+"','"+shipaddress+"' , '"+contactperson+"' ,'"+shiptelephone+"' ,'"+shipemail+"' ,'"+shipmob+"' , '"+shipfax+"',3,'"+session.getAttribute("BRANCHID").toString().trim()+"')  ";
	 	
		int aa=stmt.executeUpdate(sqls); 	 
		 if(aa<=0)
	      {
	    	  
	    	  conn.close();  
	    	 return 0; 
	      }
		 String sqls2=" insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+session.getAttribute("BRANCHID").toString().trim()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString().trim()+"','"+mode+"') ";
			int aa1=stmt.executeUpdate(sqls2); 	 
			if(aa1<=0)
		      {
		    	  
		    	  conn.close();  
		    	 return 0; 
		      }
		}
		else
		{
			 String sqls="insert into my_shipdetails (doc_no, type, clname, claddress, contactperson, tel,email, mob, fax, status, brhid) values"
			 	 		+ "("+docno+",0,'"+clname+"','"+shipaddress+"' , '"+contactperson+"' ,'"+shiptelephone+"' ,'"+shipemail+"' ,'"+shipmob+"' , '"+shipfax+"',3,'"+session.getAttribute("BRANCHID").toString().trim()+"')  ";
		
			 System.out.println("-sqls----"+sqls);
			 int aa=stmt.executeUpdate(sqls);
			 if(aa<=0)
		      {
		    	  
		    	  conn.close();  
		    	 return 0; 
		      }
			 
			 String sqls2=" insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+session.getAttribute("BRANCHID").toString().trim()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString().trim()+"','"+mode+"') ";
				int aa1=stmt.executeUpdate(sqls2); 	
				 System.out.println("-sqls2----"+sqls2);
				if(aa1<=0)
			      {
			    	  
			    	  conn.close();  
			    	 return 0; 
			      }
		}
	 	 if(docno>0)
	      {
	    	  conn.commit();
	    	  conn.close();  
	    	 return docno; 
	      }
	
		
		}
		
		catch (Exception e)
		{
			
			e.printStackTrace();
		     conn.close();
			 
			
		}
		
		 
		return 0;
	}

	 
	
 

	public JSONArray mastersearchFrom(String clname,String mob) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();  

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();     
			String sqltest="";

			if(!(clname.equalsIgnoreCase(""))){
				sqltest=sqltest+" and if(m.type=0,m.clname,ac.refname) like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.mob like '%"+mob+"%'";
			}

	 
			String sql=" select m.doc_no,m.type,m.cldocno,if(m.type=0,m.clname,ac.refname) clname, m.claddress,m.contactperson, m.tel, "
					+ " m.mob, m.email, m.fax from my_shipdetails m  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where  m.status=3  " +sqltest;
 System.out.println("----sql---"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

		//		System.out.println("==searchClient====");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 ,catid from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public int update(int docno, int chkcllient, int cldocno, String clname,
			String mode, String shipaddress, String formdetailcode,
			String contactperson, String shiptelephone, String shipemail,
			String shipmob, String shipfax, HttpServletRequest request,
			HttpSession session) throws SQLException {
		 
		try
		{
		 
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
	 Statement	stmt=conn.createStatement(); 
	 	 
 
	          String sqlsss="delete from my_shipdetails where doc_no="+docno+"";
	          
	      stmt.executeUpdate(sqlsss); 	 
		if(chkcllient==1)
		{
		 
			
			
			 String sqls="insert into my_shipdetails  (doc_no, type, cldocno, claddress, contactperson, tel,email, mob, fax, status, brhid) values"
	 	 		+ "("+docno+","+chkcllient+",'"+cldocno+"','"+shipaddress+"' , '"+contactperson+"' ,'"+shiptelephone+"' ,'"+shipemail+"' ,'"+shipmob+"' , '"+shipfax+"',3,'"+session.getAttribute("BRANCHID").toString().trim()+"')  ";
	 	
		int aa=stmt.executeUpdate(sqls); 	 
		 if(aa<=0)
	      {
	    	  
	    	  conn.close();  
	    	 return docno; 
	      }
		 String sqls2=" insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+session.getAttribute("BRANCHID").toString().trim()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString().trim()+"','"+mode+"') ";
			int aa1=stmt.executeUpdate(sqls2); 	 
			if(aa1<=0)
		      {
		    	  
		    	  conn.close();  
		    	 return docno; 
		      }
		}
		else
		{
			 String sqls="insert into my_shipdetails (doc_no, type, clname, claddress, contactperson, tel,email, mob, fax, status, brhid) values"
			 	 		+ "("+docno+",0,'"+clname+"','"+shipaddress+"' , '"+contactperson+"' ,'"+shiptelephone+"' ,'"+shipemail+"' ,'"+shipmob+"' , '"+shipfax+"',3,'"+session.getAttribute("BRANCHID").toString().trim()+"')  ";
		
			 System.out.println("-sqls----"+sqls);
			 int aa=stmt.executeUpdate(sqls);
			 if(aa<=0)
		      {
		    	  
		    	  conn.close();  
		    	 return docno; 
		      }
			 
			 String sqls2=" insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+session.getAttribute("BRANCHID").toString().trim()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString().trim()+"','"+mode+"') ";
				int aa1=stmt.executeUpdate(sqls2); 	
				 System.out.println("-sqls2----"+sqls2);
				if(aa1<=0)
			      {
			    	  
			    	  conn.close();  
			    	 return docno; 
			      }
		}
	 	 if(docno>0)
	      {
	    	  conn.commit();
	    	  conn.close();  
	    	 return docno; 
	      }
	
		
		}
		
		catch (Exception e)
		{
			
			e.printStackTrace();
		     conn.close();
			 
			
		}
		
		 
		return 0;
	}


	public int delete(int docno, String mode, String formdetailcode,
			HttpServletRequest request, HttpSession session) throws SQLException {
		try
		{
		 
		 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
	 Statement	stmt=conn.createStatement(); 
		
		String sqls="update  my_shipdetails set status=7 where doc_no="+docno+" ";
		int aa=stmt.executeUpdate(sqls);
		if(aa<=0)
	      {
	    	  
	    	  conn.close();  
	    	 return docno; 
	      }
		
		 String sqls2=" insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+session.getAttribute("BRANCHID").toString().trim()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString().trim()+"','"+mode+"') ";
			int aa1=stmt.executeUpdate(sqls2); 	
			 System.out.println("-sqls2----"+sqls2);
			if(aa1<=0)
		      {
		    	  
		    	  conn.close();  
		    	 return docno; 
		      }
			 if(docno>0)
		      {
		    	  conn.commit();
		    	  conn.close();  
		    	 return docno; 
		      }
		
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		     conn.close();
			 
		}
		return 0;
	}













	
	
	
	
	
}
