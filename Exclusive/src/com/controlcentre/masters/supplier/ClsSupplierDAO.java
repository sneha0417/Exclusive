package com.controlcentre.masters.supplier;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.PreparedStatement;
import com.opensymphony.xwork2.ActionSupport;


public class ClsSupplierDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray areaSearch(HttpSession session) throws SQLException
	{
		
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
   	        
    	    	
        String brcid=session.getAttribute("BRANCHID").toString();
    	
    	
    
        
        Connection conn =null;
        Statement stmt =null;
  			try {
				 conn = ClsConnection.getMyConnection();
				 stmt = conn.createStatement ();
            	
				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				System.out.println("------------------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
	//	System.out.println(RESULTDATA);
        return RESULTDATA;
   
	}
	
	public   JSONArray countrySearch(HttpSession session) throws SQLException
	{
		
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
   	        
    	    	
        String brcid=session.getAttribute("BRANCHID").toString();
    	
    	
    
        
        Connection conn =null;
        Statement stmt =null;
  			try {
				 conn = ClsConnection.getMyConnection();
				 stmt = conn.createStatement ();
            	
				String sql= ("select doc_no as cdocno,country_name from my_acountry where status=3" );
				System.out.println("------------------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
	//	System.out.println(RESULTDATA);
        return RESULTDATA;
   
	}
	
	public   JSONArray activitySearch(HttpSession session) throws SQLException
	{
		
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
   	        
    	    	
        String brcid=session.getAttribute("BRANCHID").toString();
    	
    	
    
        
        Connection conn =null;
        Statement stmt =null;
  			try {
				 conn = ClsConnection.getMyConnection();
				 stmt = conn.createStatement ();
            	
				String sql= ("select doc_no as adocno,ay_name from my_activity where status=3" );
				System.out.println("------------------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
	//	System.out.println(RESULTDATA);
        return RESULTDATA;
   
	}

	
	public int insert(java.sql.Date sqlDate,String supplier_name, int Currency,int Cmbacgroupid,int Cmbsalesmanid,int catid,String Txtcstno,String Txttinno,
			Double Fcredit_period_min,Double Fcredit_period_max,Double Fcredit_limit,String Txtaddress,String Txtextnno,String Txtmobile,String Txttelephone,
			String Txtfax,String Txtweb,String Txtemail,String Txtcontact,int areaid,String Txtaccountno,String Txtbankname,
			String Txtbranchname,String Txtbranchaddress,String Txtswiftno,String Txtibanno,String Txtcity,int countryid,String txtcontact,ArrayList cparrayList,HttpSession session,String mode,String formcode) throws SQLException
	{
		
		Connection conn = null;
		CallableStatement stmtsupplier=null;
		int  docno=0;
		
		try {
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
		
		
System.out.println("CALL  EsupplierDML("+sqlDate+",'"+supplier_name+"',"+Currency+","+Cmbacgroupid+","+Cmbsalesmanid+","+catid+","+Fcredit_period_min+","+Fcredit_period_max+","+Fcredit_limit+
		",'"+Txttinno+"','"+Txtcstno+"','"+Txtaddress+"','"+Txttelephone+"','"+Txtmobile+"','"+Txtfax+"','"+Txtemail+"','"+Txtextnno+"','"+Txtweb+"','"+Txtcontact+"',"+areaid+
		",'"+Txtaccountno+"','"+Txtbankname+"','"+Txtbranchname+"','"+Txtbranchaddress+"','"+Txtswiftno+"','"+Txtibanno+"','"+Txtcity+"',"+countryid+","+Integer.parseInt(session.getAttribute("COMPANYID").toString().trim())+","+Integer.parseInt(session.getAttribute("BRANCHID").toString().trim())+","+Integer.parseInt(session.getAttribute("USERID").toString().trim())+",java.sql.Types.INTEGER,java.sql.Types.INTEGER,'"+mode+"','"+formcode+"'");
		
		 stmtsupplier = conn.prepareCall("{CALL  EsupplierDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtsupplier.registerOutParameter(32, java.sql.Types.INTEGER);
		stmtsupplier.registerOutParameter(33, java.sql.Types.INTEGER);
	      // main
		stmtsupplier.setDate(1,sqlDate);
		stmtsupplier.setString(2,supplier_name);
		stmtsupplier.setInt(3,Currency);
		stmtsupplier.setInt(4,Cmbacgroupid);
		stmtsupplier.setInt(5,Cmbsalesmanid);
		stmtsupplier.setInt(6,catid);
		stmtsupplier.setDouble(7,Fcredit_period_min);
		stmtsupplier.setDouble(8,Fcredit_period_max);
		stmtsupplier.setDouble(9,Fcredit_limit);
		stmtsupplier.setString(10,Txttinno);
		stmtsupplier.setString(11,Txtcstno);
		stmtsupplier.setString(12,Txtaddress);
		stmtsupplier.setString(13,Txttelephone);
		stmtsupplier.setString(14,Txtmobile);
		stmtsupplier.setString(15,Txtfax);
		stmtsupplier.setString(16,Txtemail);
		stmtsupplier.setString(17,Txtextnno);
		stmtsupplier.setString(18,Txtweb);
		stmtsupplier.setString(19,Txtcontact);
		stmtsupplier.setInt(20,areaid);
		stmtsupplier.setString(21,Txtaccountno);
		stmtsupplier.setString(22,Txtbankname);
		stmtsupplier.setString(23,Txtbranchname);
		stmtsupplier.setString(24,Txtbranchaddress);
		stmtsupplier.setString(25,Txtswiftno);
		stmtsupplier.setString(26,Txtibanno);
		stmtsupplier.setString(27,Txtcity);
		stmtsupplier.setInt(28,countryid);
		stmtsupplier.setInt(29,Integer.parseInt(session.getAttribute("COMPANYID").toString().trim()));
		stmtsupplier.setInt(30,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
		stmtsupplier.setInt(31,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
		stmtsupplier.setString(34,mode);
		//stmtsupplier.setString(35,formcode);

		stmtsupplier.executeQuery();
	     docno=stmtsupplier.getInt("docNo");
	   int documentNo=stmtsupplier.getInt("docNo");
	   
	   if(documentNo>0&&docno>0)
	   {
		   for(int i=0;i< cparrayList.size() ;i++){
				  String[] cparray=((String) cparrayList.get(i)).split("::");
				  int resultSettcl=0;
				   String tclsql="";
				   int j=1;
				   tclsql="INSERT INTO my_crmcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id) values('"+docno+"','"+formcode+"',"+j+","
							  +"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							  + "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							  +"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							  + "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							  + "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							  + "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"',"
							  + "'"+(cparray[7].trim().equalsIgnoreCase("undefined")||cparray[7]==null  || cparray[7].trim().equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:cparray[7].trim())+"')";
							  System.out.println("==tclsql===+"+tclsql);
							  
							   resultSettcl = stmtsupplier.executeUpdate (tclsql);
							  j=j+1;
							  if(resultSettcl<=0)
							     {
							    	 return 0; 
							     }
				   
				   
		   }
	   }
	   
	   System.out.println("====documentNo==="+documentNo+"==docno===="+docno);
	   
	   if(documentNo>0&&docno>0)
	   {	   
	   conn.commit();	   		
	   }
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		finally{
			 conn.close();
			   stmtsupplier.close();
		}
	  
	   
		return docno;
	}
	
	public int update(java.sql.Date sqlDate,String supplier_name, int Currency,int Cmbacgroupid,int Cmbsalesmanid,int catid,String Txtcstno,String Txttinno,
			Double Fcredit_period_min,Double Fcredit_period_max,Double Fcredit_limit,String Txtaddress,String Txtextnno,String Txtmobile,String Txttelephone,
			String Txtfax,String Txtweb,String Txtemail,String Txtcontact,int areaid,String Txtaccountno,String Txtbankname,
			String Txtbranchname,String Txtbranchaddress,String Txtswiftno,String Txtibanno,String Txtcity,int countryid,String txtcontact,ArrayList cparrayList,HttpSession session,String mode,String code,String hdocno,String formcode) throws SQLException
	{
		Connection conn=null;
		CallableStatement stmtsupplier=null;
		int docno=0;
		try{
			
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
System.out.println("CALL  EsupplierDML("+sqlDate+",'"+supplier_name+"',"+Currency+","+Cmbacgroupid+","+Cmbsalesmanid+","+catid+","+Fcredit_period_min+","+Fcredit_period_max+","+Fcredit_limit+
		",'"+Txttinno+"','"+Txtcstno+"','"+Txtaddress+"','"+Txttelephone+"','"+Txtmobile+"','"+Txtfax+"','"+Txtemail+"','"+Txtextnno+"','"+Txtweb+"','"+Txtcontact+"',"+areaid+
		",'"+Txtaccountno+"','"+Txtbankname+"','"+Txtbranchname+"','"+Txtbranchaddress+"','"+Txtswiftno+"','"+Txtibanno+"','"+Txtcity+"',"+countryid+","+Integer.parseInt(session.getAttribute("COMPANYID").toString().trim())+","+Integer.parseInt(session.getAttribute("BRANCHID").toString().trim())+","+Integer.parseInt(session.getAttribute("USERID").toString().trim())+","+Integer.parseInt(code)+","+Integer.parseInt(hdocno)+",'"+mode+"'");
		
		 stmtsupplier = conn.prepareCall("{CALL  EsupplierDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
		
		
		/*stmtsupplier.registerOutParameter(32, java.sql.Types.INTEGER);
		stmtsupplier.registerOutParameter(33, java.sql.Types.INTEGER);*/
		
		stmtsupplier.setInt(32, Integer.parseInt(code));
		stmtsupplier.setInt(33, Integer.parseInt(hdocno));
	      // main
		stmtsupplier.setDate(1,sqlDate);
		stmtsupplier.setString(2,supplier_name);
		stmtsupplier.setInt(3,Currency);
		stmtsupplier.setInt(4,Cmbacgroupid);
		stmtsupplier.setInt(5,Cmbsalesmanid);
		stmtsupplier.setInt(6,catid);
		stmtsupplier.setDouble(7,Fcredit_period_min);
		stmtsupplier.setDouble(8,Fcredit_period_max);
		stmtsupplier.setDouble(9,Fcredit_limit);
		stmtsupplier.setString(10,Txttinno);
		stmtsupplier.setString(11,Txtcstno);
		stmtsupplier.setString(12,Txtaddress);
		stmtsupplier.setString(13,Txttelephone);
		stmtsupplier.setString(14,Txtmobile);
		stmtsupplier.setString(15,Txtfax);
		stmtsupplier.setString(16,Txtemail);
		stmtsupplier.setString(17,Txtextnno);
		stmtsupplier.setString(18,Txtweb);
		stmtsupplier.setString(19,Txtcontact);
		stmtsupplier.setInt(20,areaid);
		stmtsupplier.setString(21,Txtaccountno);
		stmtsupplier.setString(22,Txtbankname);
		stmtsupplier.setString(23,Txtbranchname);
		stmtsupplier.setString(24,Txtbranchaddress);
		stmtsupplier.setString(25,Txtswiftno);
		stmtsupplier.setString(26,Txtibanno);
		stmtsupplier.setString(27,Txtcity);
		stmtsupplier.setInt(28,countryid);
		stmtsupplier.setInt(29,Integer.parseInt(session.getAttribute("COMPANYID").toString().trim()));
		stmtsupplier.setInt(30,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
		stmtsupplier.setInt(31,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
		stmtsupplier.setString(34,mode);

		stmtsupplier.executeQuery();
	     docno=stmtsupplier.getInt("docNo");
	   int documentNo=stmtsupplier.getInt("documentNo");
	   
	   if(documentNo>0&&docno>0)
	   {
		   for(int i=0;i< cparrayList.size() ;i++){
				  String[] cparray=((String) cparrayList.get(i)).split("::");
				  int resultSettcl=0;
				   String tclsql="";
				   int j=1;
				   tclsql="INSERT INTO my_crmcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id) values('"+docno+"','"+formcode+"',"+j+","
							  +"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							  + "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							  +"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							  + "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							  + "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							  + "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"',"
							  + "'"+(cparray[7].trim().equalsIgnoreCase("undefined")||cparray[7]==null  || cparray[7].trim().equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:cparray[7].trim())+"')";
							  System.out.println("==tclsql===+"+tclsql);
							  
							   resultSettcl = stmtsupplier.executeUpdate (tclsql);
							  j=j+1;
							  if(resultSettcl<=0)
							     {
							    	 return 0; 
							     }
				   
				   
		   }
	   }
	   
	   System.out.println("====documentNo==="+documentNo+"==docno===="+docno);
	   
	   if(documentNo>0&&docno>0)
	   {
	   
	   conn.commit();
	   }
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtsupplier.close();
				conn.close();
		}
		
	  
	   
		
		
		return docno;
	}

	
	public int delete(String docno,HttpSession session) throws SQLException{
		
		int result=0;
         Connection conn=null;
         CallableStatement stmt=null;
         int tranentry=0;
		try{
			
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
		
		String sql="update my_acbook set status=7 where doc_no='"+docno+"' and cldocno='"+docno+"' and dtype='VND'";
		
		String sql1="select count(*) as count from my_jvtran where acno=(select acno from my_acbook where doc_no='"+docno+"' and cldocno='"+docno+"' and dtype='VND')";
		
		String sql2="delete from my_head where cldocno='"+docno+"' and dtype='VND'";
		
		//String sql3="delete from my_crmcontact where cldocno='"+docno+"' and dtype='VND'";
		
		Statement cpstmt = conn.createStatement ();
		
		ResultSet resultSet = cpstmt.executeQuery (sql1);
		
		if(resultSet.next())
		{
			 tranentry=resultSet.getInt("count");
		}
		
		if(tranentry==0)
		{
			stmt = conn.prepareCall(sql);
			
			System.out.println("---sql-----"+sql);
			
			int resultSet2 = stmt.executeUpdate();
			
			CallableStatement mydelsmt =conn.prepareCall(sql2);
			
			int resultSet3 = mydelsmt.executeUpdate();
			
			/*CallableStatement mycrmsmt =conn.prepareCall(sql3);
			
			int resultSet4 = mycrmsmt.executeUpdate();*/
			
			if(resultSet2>0&&resultSet3>0)
				{
				result=1;
				
				}
		
		}
		conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
			stmt.close();
			conn.close();
		}
		return result;
	}
	
	
	 public   JSONArray cpGridload(HttpSession session,int docno) throws SQLException {

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
	 
	        String brnch=session.getAttribute("BRANCHID").toString();
	  
	        Connection conn =null;
	        Statement cpstmt =null;
	  			try {
					 conn = ClsConnection.getMyConnection();
					 cpstmt = conn.createStatement ();
	            	
					String  cpsql=("select cperson as cpersion,mob as mobile,email,tel as phone,area,area_id as areaid,extn,ay_name as activity,actvty_id as activity_id from my_crmcontact c left join my_area a on(c.area_id=a.doc_no) left join my_activity ac on(ac.doc_no=c.actvty_id) where c.cldocno="+docno+" and  c.dtype='VND'");
					System.out.println("------------------------------"+cpsql);
					
					ResultSet resultSet = cpstmt.executeQuery (cpsql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					cpstmt.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 
	 public   JSONArray mainSrearch(HttpSession session,String sclname,String smob,String rno,String Contact) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	    	    	
	        String brnchid=session.getAttribute("BRANCHID").toString();

	    	
	    	String sqltest="";
	    	
	    	if(!(sclname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '"+sclname+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and com_mob='"+smob+"'";
	    	}
	    	if(!(rno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and cldocno='"+rno+"%'";
	    	}
	    	/*if(!(Contact.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and Contact='"+Contact+"%'";
	    	}*/
	    	
	    	
	    	 
	        
	     
	    	Connection conn =null;
	        Statement stmtVeh7 =null;
	  			try {
					 conn = ClsConnection.getMyConnection();
					 stmtVeh7 = conn.createStatement ();
					 
					String str1Sql=("select cldocno,refname,com_mob,contact from my_acbook where dtype='VND' and status<>7 and  brhid="+brnchid +" " +sqltest+" group by cldocno");
					System.out.println("=========="+str1Sql);
					ResultSet resultSet = stmtVeh7.executeQuery (str1Sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
	  			finally{
	  				stmtVeh7.close();
					conn.close();
	  			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    

	 
	 
	 public   ClsSupplierBean getViewDetails(HttpSession session,String docNo) throws SQLException {
			String branch = session.getAttribute("BRANCHID").toString();
			ClsSupplierBean clsSupplierBean = new ClsSupplierBean();
			
			Connection conn =null;
	        Statement stmtCPV0 =null;
	  			try {
					 conn = ClsConnection.getMyConnection();
					 stmtCPV0 = conn.createStatement ();
			
			
			
			String strSql= ("select ac.cldocno,ac.date as supplierdate,catid,refname,address,contact,period,period2,ac.curid,credit,com_mob,tel,extn_tel,fax1,web1,mail1,cstno,tinno,acno,bank_name,account_no,branch_name,branch_address,ibanno,bnkswiftno,bnkcity,h.grpno,"
                           +"ac.area_id as areadocno,a.area as area,concat(city.city_name,',',c.country_name,',',r.reg_name) as area_det,bc.country_name as bnkcountry,h.doc_no as acc_no from my_acbook ac left join my_head h on(ac.cldocno=h.cldocno and h.dtype='VND')" 
                           +"left join my_area a on(ac.area_id=a.doc_no) left join my_acity city on(a.city_id=city.doc_no) left join my_acountry c on(c.doc_no=city.country_id) left join my_aregion r on(r.doc_no=c.reg_id) left join my_acountry bc on(bc.doc_no=ac.bnkcountryid) where ac.cldocno='"+docNo+"' and ac.dtype='VND'");
			
			System.out.println("===strSql====="+strSql);
			
			ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
	
			while (resultSet.next()) {
				
				clsSupplierBean.setTxtcode(resultSet.getString("ac.cldocno"));
				clsSupplierBean.setSupplierDate(resultSet.getString("supplierdate"));
				clsSupplierBean.setHidSupplierDate(resultSet.getString("ac.cldocno"));
				clsSupplierBean.setTxtsupplier_name(resultSet.getString("refname"));
				clsSupplierBean.setCurrencyid(resultSet.getInt("ac.curid"));
				clsSupplierBean.setHidcmbcurrencyid(resultSet.getInt("ac.curid"));
				clsSupplierBean.setCmbacgroup(resultSet.getInt("h.grpno"));
				clsSupplierBean.setHidcmbacgroup(resultSet.getInt("h.grpno"));
				clsSupplierBean.setCmbcategory(resultSet.getInt("catid"));
				clsSupplierBean.setHidcmbcategory(resultSet.getInt("catid"));
				clsSupplierBean.setTxtcstno(resultSet.getString("cstno"));
				clsSupplierBean.setTxttinno(resultSet.getString("tinno"));
				clsSupplierBean.setTxtcredit_period_min(resultSet.getDouble("period"));
				clsSupplierBean.setTxtcredit_period_max(resultSet.getDouble("period2"));
				clsSupplierBean.setTxtcredit_limit(resultSet.getDouble("credit"));
				clsSupplierBean.setTxtaddress(resultSet.getString("address"));
				clsSupplierBean.setTxtextnno(resultSet.getString("extn_tel"));
				clsSupplierBean.setTxtmobile(resultSet.getString("com_mob"));
				clsSupplierBean.setTxtfax(resultSet.getString("fax1"));
				clsSupplierBean.setTxtweb(resultSet.getString("web1"));
				clsSupplierBean.setTxttelephone(resultSet.getString("tel"));
				clsSupplierBean.setTxtemail(resultSet.getString("mail1"));
				clsSupplierBean.setTxtcontact(resultSet.getString("contact"));
				clsSupplierBean.setTxtareaid(resultSet.getInt("areadocno"));
				clsSupplierBean.setTxtareadet(resultSet.getString("area_det"));
				clsSupplierBean.setTxtarea(resultSet.getString("area"));
				clsSupplierBean.setTxtaccountno(resultSet.getString("account_no"));
				clsSupplierBean.setTxtbankname(resultSet.getString("bank_name"));
				clsSupplierBean.setTxtbranchname(resultSet.getString("branch_name"));
				clsSupplierBean.setTxtbranchaddress(resultSet.getString("branch_address"));
				clsSupplierBean.setTxtswiftno(resultSet.getString("bnkswiftno"));
				clsSupplierBean.setTxtibanno(resultSet.getString("ibanno"));
				clsSupplierBean.setTxtcity(resultSet.getString("bnkcity"));
				clsSupplierBean.setTxtcountry(resultSet.getString("bnkcountry"));
				clsSupplierBean.setTxtaccount(resultSet.getString("acc_no"));
				clsSupplierBean.setDocno(resultSet.getString("ac.cldocno"));
				
			}
			
				
			
				
			
			}
			catch(Exception e){
			e.printStackTrace();
			}
	  			finally{
	  				stmtCPV0.close();
	  				conn.close();
	  			}
			
			return clsSupplierBean;
			}

	

}
