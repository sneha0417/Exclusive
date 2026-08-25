package com.controlcentre.settings.userrolebi;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsUserRoleBIDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsUserRoleBIBean userRoleBean = new ClsUserRoleBIBean();
	Connection conn;
	 
	public int insert(String txtrolename,int txtroleid,String formdetailcode,ArrayList<String> userrolearray,HttpSession session, HttpServletRequest request,String mode) throws SQLException {
		 		try{
					conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtUBI1 = conn.createStatement();
					int data = 0;
					
					String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
		 			
					String sqls="select * from my_urolebi where user_role='"+txtrolename+"' and status<>7";
					   ResultSet resultSet1 = stmtUBI1.executeQuery(sqls);
					   
				   while (resultSet1.next()) {
				        return -1;
				    }
					   
					CallableStatement stmtUBI = conn.prepareCall("{CALL userRoleDML(?,?,?,?,?,?,?)}");
					
					stmtUBI.registerOutParameter(6, java.sql.Types.INTEGER);
					stmtUBI.setString(1,txtrolename);
					stmtUBI.setString(2,null);
					stmtUBI.setString(3,formdetailcode);
					stmtUBI.setString(4,branch);
					stmtUBI.setString(5,userid);
					stmtUBI.setString(7,mode);
					int datas=stmtUBI.executeUpdate();
					if(datas<=0){
						stmtUBI.close();
						conn.close();
						return 0;
					}
					int docno=stmtUBI.getInt("docNo");
					userRoleBean.setTxtuserrolebidocno(docno);
					
					if (docno > 0) {
						
						String sql1=("delete from my_powrbi where rdocno="+docno);
					    int data1 = stmtUBI.executeUpdate(sql1);
					    
						/*User Role Grid Saving*/
						for(int i=0;i< userrolearray.size();i++){
						String[] userrole=userrolearray.get(i).split("::");
						if(!userrole[0].equalsIgnoreCase("undefined") && !userrole[0].equalsIgnoreCase("NaN")){
						
						int permission = 0,email = 0,excel = 0;
						if(userrole[4].trim().equalsIgnoreCase("true")){
							permission=1;
						}

						if(userrole[5].trim().equalsIgnoreCase("true")){
							email=1;
						}

						if(userrole[6].trim().equalsIgnoreCase("true")){
							excel=1;
						}
												
						stmtUBI = conn.prepareCall("{CALL userPowerBIDML(?,?,?,?,?,?,?,?,?,?)}");
						
						stmtUBI.setInt(1,docno);//Rdocno
						stmtUBI.setInt(2,txtroleid);//Role Id
						stmtUBI.setString(3,(userrole[0].trim().equalsIgnoreCase("undefined") || userrole[0].trim().equalsIgnoreCase("NaN") || userrole[0].trim().equalsIgnoreCase("") ||userrole[0].trim().isEmpty()?0:userrole[0].trim()).toString()); //MNO
						stmtUBI.setString(4,(userrole[1].trim().equalsIgnoreCase("undefined") || userrole[1].trim().equalsIgnoreCase("NaN") || userrole[1].trim().equalsIgnoreCase("") ||userrole[1].trim().isEmpty()?0:userrole[1].trim()).toString()); //Master
						stmtUBI.setString(5,(userrole[2].trim().equalsIgnoreCase("undefined") || userrole[2].trim().equalsIgnoreCase("NaN") || userrole[2].trim().equalsIgnoreCase("") ||userrole[2].trim().isEmpty()?0:userrole[2].trim()).toString()); //DNO
						stmtUBI.setString(6,(userrole[3].trim().equalsIgnoreCase("undefined") || userrole[3].trim().equalsIgnoreCase("NaN") || userrole[3].trim().equalsIgnoreCase("") ||userrole[3].trim().isEmpty()?0:userrole[3].trim()).toString()); //Detail
						stmtUBI.setInt(7,permission);//Permission
						stmtUBI.setInt(8,email);//Email
						stmtUBI.setInt(9,excel);//Excel
						stmtUBI.setString(10,mode);
					    data = stmtUBI.executeUpdate();
					 }
						if(data<=0){
							stmtUBI.close();
							conn.close();
							return 0;
						}
					}
				    if(data>0){
						conn.commit();
						stmtUBI.close();
						conn.close();
						return docno;
				    }
				}
				stmtUBI.close();
				conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 }finally{
				conn.close();
			}
	return 0;
	}
	
	public int edit(String formdetailcode, int txtuserrolebidocno, int txtroleid, String txtrolename,ArrayList<String> userrolearray, HttpSession session, String mode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtUBI1 = conn.createStatement();
			int data = 0;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
 			
 			String sqls="select * from my_urolebi where user_role='"+txtrolename+"' and status=3 and doc_no!="+txtuserrolebidocno;
			ResultSet resultSet1 = stmtUBI1.executeQuery(sqls);
			   
		   while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtUBI = conn.prepareCall("{CALL userRoleDML(?,?,?,?,?,?,?)}");
			
			stmtUBI.setInt(6,txtuserrolebidocno);
			stmtUBI.setString(1,txtrolename);
			stmtUBI.setString(2,null);
			stmtUBI.setString(3,formdetailcode);
			stmtUBI.setString(4,branch);
			stmtUBI.setString(5,userid);
			stmtUBI.setString(7,mode);
			int datas=stmtUBI.executeUpdate();
			if(datas<=0){
				stmtUBI.close();
				conn.close();
				return 0;
			}
			int docno=stmtUBI.getInt("docNo");
			userRoleBean.setTxtuserrolebidocno(docno);
			
			if (docno > 0) {
				
				String sql1=("delete from my_powrbi where roleid="+txtroleid+" and rdocno="+txtuserrolebidocno);
			    int data1 = stmtUBI.executeUpdate(sql1);
			    
				/*User Role Grid Saving*/
				for(int i=0;i< userrolearray.size();i++){
				String[] userrole=userrolearray.get(i).split("::");
				if(!userrole[0].equalsIgnoreCase("undefined") && !userrole[0].equalsIgnoreCase("NaN")){
				
				int permission = 0,email = 0,excel = 0;
				if(userrole[4].trim().equalsIgnoreCase("true")){
					permission=1;
				}
				
				if(userrole[5].trim().equalsIgnoreCase("true")){
					email=1;
				}

				if(userrole[6].trim().equalsIgnoreCase("true")){
					excel=1;
				}
				
				stmtUBI = conn.prepareCall("{CALL userPowerBIDML(?,?,?,?,?,?,?,?,?,?)}");
				
				stmtUBI.setInt(1,docno);//Rdocno
				stmtUBI.setInt(2,txtroleid);//Role Id
				stmtUBI.setString(3,(userrole[0].trim().equalsIgnoreCase("undefined") || userrole[0].trim().equalsIgnoreCase("NaN") || userrole[0].trim().equalsIgnoreCase("") ||userrole[0].trim().isEmpty()?0:userrole[0].trim()).toString()); //MNO
				stmtUBI.setString(4,(userrole[1].trim().equalsIgnoreCase("undefined") || userrole[1].trim().equalsIgnoreCase("NaN") || userrole[1].trim().equalsIgnoreCase("") ||userrole[1].trim().isEmpty()?0:userrole[1].trim()).toString()); //Master
				stmtUBI.setString(5,(userrole[2].trim().equalsIgnoreCase("undefined") || userrole[2].trim().equalsIgnoreCase("NaN") || userrole[2].trim().equalsIgnoreCase("") ||userrole[2].trim().isEmpty()?0:userrole[2].trim()).toString()); //DNO
				stmtUBI.setString(6,(userrole[3].trim().equalsIgnoreCase("undefined") || userrole[3].trim().equalsIgnoreCase("NaN") || userrole[3].trim().equalsIgnoreCase("") ||userrole[3].trim().isEmpty()?0:userrole[3].trim()).toString()); //Detail
				stmtUBI.setInt(7,permission);//Permission
				stmtUBI.setInt(8,email);//Email
				stmtUBI.setInt(9,excel);//Excel
				stmtUBI.setString(10,mode);
			    data = stmtUBI.executeUpdate();
			 }
				if(data<=0){
					stmtUBI.close();
					conn.close();
					return 0;
				}
			}
		    if(data>0){
				conn.commit();
				stmtUBI.close();
				conn.close();
				return docno;
		    }
		}
		stmtUBI.close();
		conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
			conn.close();
	  }
	 return 0;
	}
	
	public boolean delete(int txtuserrolebidocno, String formdetailcode,HttpSession session) throws SQLException {
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtUBI = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				 /*Status change in my_urolebi*/
				 String sql=("update my_urolebi set STATUS=7 where doc_no="+txtuserrolebidocno);
				 int data = stmtUBI.executeUpdate(sql);
				 if(data<=0){
						stmtUBI.close();
						conn.close();
						return false;
				}
				/*Status change in my_urolebi Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtuserrolebidocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtUBI.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				int docno=txtuserrolebidocno;
				userRoleBean.setTxtuserrolebidocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtUBI.close();
				    conn.close();
					return true;
				}	
				stmtUBI.close();
			    conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
				conn.close();
			}
			return false;
	    }
	
	public  JSONArray userRoleSearch() throws SQLException {
        List<ClsUserRoleBIBean> userRoleSearchBean = new ArrayList<ClsUserRoleBIBean>();
        
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtUBI = conn.createStatement();
            	
				/*String sql="select doc_no,user_role from my_urole where status=3 ";*/
				String sql="select u.doc_no,u.user_role from my_urole u left join my_urolebi bi on bi.user_role=u.user_role and u.status=3 where u.status=3 and bi.doc_no is null;";
            	ResultSet resultSet = stmtUBI.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtUBI.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray userRoleGridLoading() throws SQLException {
        List<ClsUserRoleBIBean> userRoleGridLoadingBean = new ArrayList<ClsUserRoleBIBean>();
        
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null; 
        		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtUBI = conn.createStatement();
            	
				String sql="select m.doc_no mno,m.description master,d.doc_no dno,d.description detail from gl_bibm m left join gl_bibd d on d.rdocno=m.doc_no "
						+ "where m.status=1 and d.status=1 order by m.doc_no";
				
            	ResultSet resultSet = stmtUBI.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtUBI.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray userRoleGridReloading(String docNo) throws SQLException {
        List<ClsUserRoleBIBean> userRoleGridReloadingBean = new ArrayList<ClsUserRoleBIBean>();
        
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null; 
        		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtUBI = conn.createStatement();
            	
				String sql="select m.doc_no mno,m.description master,d.doc_no dno,d.description detail,p.permission,p.email,p.excel from gl_bibm m left join gl_bibd d on d.rdocno=m.doc_no "
						+ "left join my_powrbi p on p.mno=m.doc_no and p.dno=d.doc_no and p.rdocno="+docNo+" where m.status=1 and d.status=1 order by m.doc_no";
				
            	ResultSet resultSet = stmtUBI.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtUBI.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray ubiMainSearch(String rolename,String docNo,String date) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlUserRoleDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlUserRoleDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and bi.doc_no like '%"+docNo+"%'";
        }
        if(!(rolename.equalsIgnoreCase(""))){
         sqltest=sqltest+" and bi.user_role like '%"+rolename+"%'";
        }
        if(!(sqlUserRoleDate==null)){
	         sqltest=sqltest+" and bi.date='"+sqlUserRoleDate+"'";
	        } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtUBI = conn.createStatement();
	       
	       ResultSet resultSet = stmtUBI.executeQuery("select bi.user_role,bi.date,bi.doc_no,u.doc_no roleid from my_urolebi bi left join my_urole u on "
	       		+ "bi.user_role=u.user_role where bi.status<>7 and u.doc_no is not null " +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       stmtUBI.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
			conn.close();
		}
       return RESULTDATA;
   }

}
