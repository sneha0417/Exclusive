package com.controlcentre.settings.usermaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;

public class ClsUserMasterDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	Connection conn;

	ClsUserMasterBean userBean = new ClsUserMasterBean();
	
	public int insert(ClsUserMasterBean bean, HttpSession session,ArrayList<String> usermasterarray,Date sqlStartDate,String formcode,int levels) throws SQLException {

		try{
			int docno;
		    conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false); 
			CallableStatement stmtUser = conn.prepareCall("{CALL vehUserDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtUser.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtUser.setString(1,bean.getTxtuser());
			stmtUser.setString(2,ClsEncrypt.getInstance().encrypt(bean.getTxtuserpassword()));
			stmtUser.setString(3,bean.getTxtusername());
			stmtUser.setInt(4,bean.getTxtroleid());
			stmtUser.setString(5,bean.getCmblanguage());
			stmtUser.setString(6,bean.getTxtusermail());
			stmtUser.setString(7,bean.getCmpermission());
			stmtUser.setString(8,session.getAttribute("BRANCHID").toString());
			stmtUser.setString(9,session.getAttribute("USERID").toString());
			stmtUser.setString(11,bean.getMode());
			stmtUser.setDate(12,sqlStartDate);
			stmtUser.setString(13,formcode);
			stmtUser.setInt(14,levels);
			stmtUser.setString(15,ClsEncrypt.getInstance().encrypt(bean.getTxtmailpswd()));
			stmtUser.setString(16,bean.getTxtmailsign());
			stmtUser.setString(17,bean.getTxtmailhost());
			stmtUser.setString(18,bean.getTxtmailport());
			stmtUser.executeQuery();
			docno=stmtUser.getInt("docNo");
			
			if(docno<=0)
			{
				 
				conn.close();
				return 0;
			}	
		
			for(int i=0;i< usermasterarray.size();i++){
		    	
			     String[] userarray=usermasterarray.get(i).split("::");
			     if(!(userarray[1].trim().equalsIgnoreCase("undefined")|| userarray[1].trim().equalsIgnoreCase("NaN")||userarray[1].trim().equalsIgnoreCase("")|| userarray[1].isEmpty()))
			     {
			    	
		     String sql="INSERT INTO my_usrbr(user_id,brhid,cmpid)VALUES"
				       + "("+docno+","
				        + "'"+(userarray[0].trim().equalsIgnoreCase("undefined") || userarray[0].trim().equalsIgnoreCase("NaN")|| userarray[0].trim().equalsIgnoreCase("")|| userarray[0].isEmpty()?0:userarray[0].trim())+"',"
				       + "'"+(userarray[1].trim().equalsIgnoreCase("undefined") || userarray[1].trim().equalsIgnoreCase("NaN")|| userarray[1].trim().equalsIgnoreCase("")|| userarray[1].isEmpty()?0:userarray[1].trim())+"')";
				  
		     
		
				     int resultSet2 = stmtUser.executeUpdate(sql);
				     if(resultSet2<=0)
				 	{
				 		 conn.close();
				 		return 0;
				 	}	
				     
			     }
				     
				     }
			
			if (docno > 0) {
				conn.commit();
				stmtUser.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
		e.printStackTrace();
		conn.close();
		}
		return 0;
	}
	
	public boolean edit(int docno,ClsUserMasterBean bean,HttpSession session,ArrayList<String> usermasterarray,Date sqlStartDate,String formcode,int levels) throws SQLException {
		try{
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false); 
		CallableStatement stmtUser = conn.prepareCall("{CALL vehUserDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtUser.setString(1,bean.getTxtuser());
		stmtUser.setString(2,ClsEncrypt.getInstance().encrypt(bean.getTxtuserpassword()));
		stmtUser.setString(3,bean.getTxtusername());
		stmtUser.setInt(4,bean.getTxtroleid());
		stmtUser.setString(5,bean.getCmblanguage());
		stmtUser.setString(6,bean.getTxtusermail());
		stmtUser.setString(7,bean.getCmpermission());
		stmtUser.setString(8,session.getAttribute("BRANCHID").toString());
		stmtUser.setString(9,session.getAttribute("USERID").toString());
		stmtUser.setInt(10,bean.getDocno());
		stmtUser.setString(11,bean.getMode());
		stmtUser.setDate(12,sqlStartDate);
		stmtUser.setString(13,formcode);
		stmtUser.setInt(14,levels);
		stmtUser.setString(15,ClsEncrypt.getInstance().encrypt(bean.getTxtmailpswd()));
		stmtUser.setString(16,bean.getTxtmailsign());
		stmtUser.setString(17,bean.getTxtmailhost());
		stmtUser.setString(18,bean.getTxtmailport());
		stmtUser.executeQuery();
		
		int aaa=stmtUser.getInt("docNo");
		
		userBean.setDocno(aaa);
		
		
		if(aaa<=0)
		{
			 
			conn.close();
			return false;
		}	
		
		 String delsql="Delete from my_usrbr where user_id="+docno+" ";
		stmtUser.executeUpdate(delsql);
		
	
		for(int i=0;i< usermasterarray.size();i++){
	    	
		     String[] userarray=usermasterarray.get(i).split("::");
		     if(!(userarray[1].trim().equalsIgnoreCase("undefined")|| userarray[1].trim().equalsIgnoreCase("NaN")||userarray[1].trim().equalsIgnoreCase("")|| userarray[1].isEmpty()))
		     {
		    	
	     String sql="INSERT INTO my_usrbr(user_id,brhid,cmpid)VALUES"
			       + "("+docno+","
			        + "'"+(userarray[0].trim().equalsIgnoreCase("undefined") || userarray[0].trim().equalsIgnoreCase("NaN")|| userarray[0].trim().equalsIgnoreCase("")|| userarray[0].isEmpty()?0:userarray[0].trim())+"',"
			       + "'"+(userarray[1].trim().equalsIgnoreCase("undefined") || userarray[1].trim().equalsIgnoreCase("NaN")|| userarray[1].trim().equalsIgnoreCase("")|| userarray[1].isEmpty()?0:userarray[1].trim())+"')";
			  
	     
	
			     int resultSet2 = stmtUser.executeUpdate(sql);
			     if(resultSet2<=0)
			 	{
			 		 conn.close();
			 		return false;
			 	}	
			     
		     }
			     
			     }
		
		if (aaa > 0) {
			conn.commit();
			stmtUser.close();
			conn.close();
			
			return true;
		}		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		return false;
	}

	public boolean delete(ClsUserMasterBean bean,HttpSession session,String formcode) throws SQLException {

		try{
			 conn=ClsConnection.getMyConnection();
			CallableStatement stmtUser = conn.prepareCall("{CALL vehUserDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtUser.setString(1,bean.getTxtuser());
			stmtUser.setString(2,bean.getTxtuserpassword());
			stmtUser.setString(3,bean.getTxtusername());
			stmtUser.setInt(4,bean.getTxtroleid());
			stmtUser.setString(5,bean.getCmblanguage());
			stmtUser.setString(6,bean.getTxtusermail());
			stmtUser.setString(7,bean.getCmpermission());
			stmtUser.setString(8,session.getAttribute("BRANCHID").toString());
			stmtUser.setString(9,session.getAttribute("USERID").toString());
			stmtUser.setInt(10,bean.getDocno());
			stmtUser.setString(11,bean.getMode());
			stmtUser.setString(12,null);
			stmtUser.setString(13,formcode);
			stmtUser.setInt(14,0);
			stmtUser.executeQuery();
			int aaa=stmtUser.getInt("docNo");
			
			userBean.setDocno(aaa);
			
			if (aaa > 0) {
				
				stmtUser.close();
				conn.close();
				return true;
			}		
		}catch(Exception e){
		
			
			conn.close();
		}
		
		
		return false;
	}

/*	public ClsUserMasterBean getViewDetails(String docno) { 
		 PreparedStatement pst;
         try{
         pst = conn.prepareStatement("select u.user_id,u.pass,u.user_name,u.role_id,u.lang,u.email,u.Permission,r.user_role from my_user u left join my_urole r on u.role_id=r.doc_no where u.doc_no=?");
         pst.setString(1, docno);
         ResultSet rs = pst.executeQuery();
         while(rs.next()){
        	 ClsUserMasterBean bean=new  ClsUserMasterBean();
        	 
        	 bean.setTxtuser(rs.getString(1));
        	 bean.setTxtuserpassword(rs.getString(2));
        	 bean.setTxtusername(rs.getString(3));
        	 bean.setCmblanguage(rs.getString(5));
        	 bean.setTxtusermail(rs.getString(6));
        	 bean.setCmpermission(rs.getString(7));
        	 bean.setTxtbrole(rs.getString(8));
        	 
        	 return bean;
         }
        
         }catch(Exception e){
 			
 		}
        
         return null;
	}
	*/
	 public  JSONArray searchDetails() throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
	        List<ClsUserMasterBean> listBean = new ArrayList<ClsUserMasterBean>();
			
	         Connection conn =null;
			 Statement stmtUser =null;
		  try {
		     conn = ClsConnection.getMyConnection();
		     stmtUser = conn.createStatement ();
		     
		     System.out.println("=== select user_id,user_name,role_id from my_user WHERE block=0");
					ResultSet resultSet = stmtUser.executeQuery ("select user_id,user_name,role_id from my_user WHERE block=0");
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
		  finally{
			  stmtUser.close();
			  conn.close();
		  }

	        return RESULTDATA;
	    }
 

	 public  JSONArray FillGridDetails(String docno) throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
	      
		 Connection conn =null;
		 Statement stmtUser =null;
	  try {
	     conn = ClsConnection.getMyConnection();
	     stmtUser = conn.createStatement ();
	     
				String resql=("select b.doc_no brhid,b.branchname,c.doc_no compid,c.company,convert(coalesce(br.sr_no,'NA'),char(100)) srno from my_brch b left join my_comp c on b.cmpid=c.doc_no "
							+ " left join my_usrbr br on(br.cmpid=c.doc_no and br.brhid=b.doc_no and br.user_id='"+docno+"') group by  b.doc_no");
				System.out.println("resql"+resql);
		
				ResultSet resultSet = stmtUser.executeQuery(resql); 
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			}
			catch(Exception e){
				e.printStackTrace();
			}
	  finally{
		  stmtUser.close();
		  conn.close();
		  
	  }
	        return RESULTDATA;
	    }
	 
	 public  JSONArray userRoleSearch() throws SQLException {
	        List<ClsUserMasterBean> userRoleSearchBean = new ArrayList<ClsUserMasterBean>();
	        JSONArray RESULTDATA=new JSONArray();
	  
	        Connection conn =null;
			 Statement stmtRLE =null;
		  try {
		     conn = ClsConnection.getMyConnection();
		     stmtRLE = conn.createStatement ();
	             
	    String sql="select doc_no,user_role from my_urole where status=3";
	    
	             ResultSet resultSet = stmtRLE.executeQuery(sql);
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	   
	  }
	  catch(Exception e){
	   e.printStackTrace();
	  }
		  finally{
			  stmtRLE.close();
			    conn.close();
		  }
	        return RESULTDATA;
	    }
	 	 public  JSONArray searchMaster(HttpSession session) throws SQLException {
	     
	        JSONArray RESULTDATA=new JSONArray();
	       
	         Connection conn =null;
			 Statement stmtRLE =null;
		  try {
		     conn = ClsConnection.getMyConnection();
		     stmtRLE = conn.createStatement ();
		     String curuser=session.getAttribute("USERID").toString();
		     String qryappend="";
		     
		     Statement stmt = conn.createStatement();
			
			 String strSql1 = "select r.urolelevel from my_user u  "
	    		+ "left join my_urole r on r.doc_no=u.role_id where u.status=3 and u.doc_no="+curuser+" ";
				
			 //System.out.println("==strSql1==="+strSql1);
			 
				ResultSet rs1 = stmt.executeQuery(strSql1);
				
				int urolelvl=0;
				while(rs1.next()) {
					urolelvl=rs1.getInt("urolelevel");
					
			  		} 
		     //System.out.println("==urolelvl==="+urolelvl);
		     if(urolelvl==1){
		    	 qryappend="";
		     }
		     else{
		    	 qryappend="and u.doc_no="+curuser+"";
		     }
		     
		     String sql="select u.date,u.pass,u.doc_no,u.user_id,u.user_name,u.role_id,u.email,u.permission,u.lang,r.user_role,u.ulevel from my_user u  "
	    		+ "left join my_urole r on r.doc_no=u.role_id where u.status=3 "+qryappend+" and block=0";

	             ResultSet resultSet = stmtRLE.executeQuery(sql);
	      RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	    
	  }
	  catch(Exception e){
	   e.printStackTrace();
	  }
		  finally{
			  stmtRLE.close();
			    conn.close();
		  }
	        return RESULTDATA;
	    }
	 
	 
	 
	 public  ClsUserMasterBean getViewDetails(int doc_no) throws SQLException {
	     
		 ClsUserMasterBean bean= new ClsUserMasterBean();
		 Connection conn =null;
		 Statement stmtRLE =null;
	  try {
	     conn = ClsConnection.getMyConnection();
	     stmtRLE = conn.createStatement ();
	             
	    String sql="select smtpServer,smtpHostPort,u.date as date,u.pass as pass,u.doc_no,u.user_id as user_id,u.user_name as user_name,u.role_id as role_id,u.email as email,u.permission as permission,u.lang as lang,r.user_role as user_role,u.ulevel as ulevel,mailpass,signature from my_user u  "
	    		+ "left join my_urole r on r.doc_no=u.role_id where u.status=3 and u.doc_no="+doc_no+"";

	    System.out.println("==sql==sql==sql===sql"+sql);
	    
	             ResultSet rs = stmtRLE.executeQuery(sql);
	   
	             while (rs.next()){
	            	 
	            	 bean.setJqxUserMasterDate(rs.getDate("date"));
	            	 bean.setHidjqxUserMasterDate(rs.getString("date"));
	            	 bean.setTxtuserpassword(ClsEncrypt.getInstance().decrypt(rs.getString("pass")));
	            	 bean.setTxtpasswordconfirm(ClsEncrypt.getInstance().decrypt(rs.getString("pass")));
	            	 bean.setTxtuser(rs.getString("user_id"));
	            	 bean.setTxtusername(rs.getString("user_name"));
	            	 bean.setTxtroleid(rs.getInt("role_id"));
	            	 bean.setTxtusermail(rs.getString("email"));
	            	 bean.setCmpermission(rs.getString("permission"));
	            	 bean.setHidcmpermission(rs.getString("permission"));
	            	 bean.setCmblanguage(rs.getString("lang"));
	            	 bean.setHidcmblanguage(rs.getString("lang"));
	            	 bean.setTxtbrole(rs.getString("user_role"));
	            	 bean.setHidcmbrole(rs.getString("user_role"));
	            	 bean.setLevels(rs.getInt("ulevel"));
	            	 bean.setHidelevels(rs.getInt("ulevel"));
	            	 bean.setTxtmailpswd(ClsEncrypt.getInstance().decrypt(rs.getString("mailpass")));
	            	 bean.setTxtmailsign(rs.getString("signature"));
	            	 bean.setTxtmailhost(rs.getString("smtpServer"));
	            	 bean.setTxtmailport(rs.getString("smtpHostPort"));
	             }
	    
	    
	  }
	  catch(Exception e){
	   e.printStackTrace();
	  }
	  finally{
		  stmtRLE.close();
		    conn.close();
	  }
	        return bean;
	    }


	 
}
