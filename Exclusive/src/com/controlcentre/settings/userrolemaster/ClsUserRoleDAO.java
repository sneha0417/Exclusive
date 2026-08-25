package com.controlcentre.settings.userrolemaster;

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

public class ClsUserRoleDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsUserRoleBean userRoleBean = new ClsUserRoleBean();
	Connection conn;
	 
	public int insert(String txtrolename,String txtemail,String formdetailcode,ArrayList<String> userrolearray,HttpSession session, HttpServletRequest request,String mode) throws SQLException {
		 		try{
					conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtRLE1 = conn.createStatement();
					int data = 0;
					
					String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
		 			
					String sqls="select * from my_urole where user_role='"+txtrolename+"' and status=3";
					   ResultSet resultSet1 = stmtRLE1.executeQuery(sqls);
					   
				   while (resultSet1.next()) {
				        return -1;
				    }
					   
					CallableStatement stmtRLE = conn.prepareCall("{CALL userRoleDML(?,?,?,?,?,?,?)}");
					
					stmtRLE.registerOutParameter(6, java.sql.Types.INTEGER);
					stmtRLE.setString(1,txtrolename);
					stmtRLE.setString(2,txtemail);
					stmtRLE.setString(3,formdetailcode);
					stmtRLE.setString(4,branch);
					stmtRLE.setString(5,userid);
					stmtRLE.setString(7,mode);
					int datas=stmtRLE.executeUpdate();
					if(datas<=0){
						stmtRLE.close();
						conn.close();
						return 0;
					}
					int docno=stmtRLE.getInt("docNo");
					userRoleBean.setTxtuserroledocno(docno);
					
					if (docno > 0) {
						
						String sql1=("delete from my_powr where roleid="+docno);
					    int data1 = stmtRLE.executeUpdate(sql1);
					    
						/*User Role Grid Saving*/
						for(int i=0;i< userrolearray.size();i++){
						String[] userrole=userrolearray.get(i).split("::");
						if(!userrole[0].equalsIgnoreCase("undefined") && !userrole[0].equalsIgnoreCase("NaN")){
						
						int add = 0,edit = 0,del = 0,print = 0,attach = 0,excel = 0,email = 0,costing = 0,terms = 0;
						if(userrole[2].trim().equalsIgnoreCase("true")){
							add=1;
						}
						else if(userrole[2].trim().equalsIgnoreCase("") || userrole[2].trim().equalsIgnoreCase("false")){
							add=0;
						}
						if(userrole[3].trim().equalsIgnoreCase("true")){
							edit=1;
						}
						else if(userrole[3].trim().equalsIgnoreCase("") || userrole[3].trim().equalsIgnoreCase("false")){
							edit=0;
						}
						if(userrole[4].trim().equalsIgnoreCase("true")){
							del=1;
						}
						else if(userrole[4].trim().equalsIgnoreCase("") || userrole[4].trim().equalsIgnoreCase("false")){
							del=0;
						}
						if(userrole[5].trim().equalsIgnoreCase("true")){
							print=1;
						}
						else if(userrole[5].trim().equalsIgnoreCase("") || userrole[5].trim().equalsIgnoreCase("false")){
							print=0;
						}
						if(userrole[6].trim().equalsIgnoreCase("true")){
							attach=1;
						}
						else if(userrole[6].trim().equalsIgnoreCase("") || userrole[6].trim().equalsIgnoreCase("false")){
							attach=0;
						}
						if(userrole[7].trim().equalsIgnoreCase("true")){
							excel=1;
						}
						else if(userrole[7].trim().equalsIgnoreCase("") || userrole[7].trim().equalsIgnoreCase("false")){
							excel=0;
						}
						if(userrole[8].trim().equalsIgnoreCase("true")){
							email=1;
						}
						else if(userrole[8].trim().equalsIgnoreCase("") || userrole[8].trim().equalsIgnoreCase("false")){
							email=0;
						}
						if(userrole[9].trim().equalsIgnoreCase("true")){
							costing=1;
						}
						else if(userrole[9].trim().equalsIgnoreCase("") || userrole[9].trim().equalsIgnoreCase("false")){
							costing=0;
						}
						if(userrole[10].trim().equalsIgnoreCase("true")){
							terms=1;
						}
						else if(userrole[10].trim().equalsIgnoreCase("") || userrole[10].trim().equalsIgnoreCase("false")){
							terms=0;
						}
						
						stmtRLE = conn.prepareCall("{CALL userPowerDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						stmtRLE.setInt(1,docno);//Role Id
						stmtRLE.setString(2,(userrole[1].trim().equalsIgnoreCase("undefined") || userrole[1].trim().equalsIgnoreCase("NaN") || userrole[1].trim().equalsIgnoreCase("") ||userrole[1].trim().isEmpty()?0:userrole[1].trim()).toString()); //Menu Name
						stmtRLE.setInt(3,add); //Add
						stmtRLE.setInt(4,edit); //Edit
						stmtRLE.setInt(5,del);//Delete
						stmtRLE.setInt(6,print);//Print
						stmtRLE.setInt(7,attach);//Attach
						stmtRLE.setInt(8,excel);//Excel
						stmtRLE.setInt(9,email);//Email
						stmtRLE.setInt(10,costing);//Costing
						stmtRLE.setInt(11,terms);//Terms
						stmtRLE.setString(12,(userrole[0].trim().equalsIgnoreCase("undefined") || userrole[0].trim().equalsIgnoreCase("NaN") || userrole[0].trim().equalsIgnoreCase("") ||userrole[0].trim().isEmpty()?0:userrole[0].trim()).toString());//MNO
						stmtRLE.setString(13,mode);
					    data = stmtRLE.executeUpdate();
					 }
						if(data<=0){
							stmtRLE.close();
							conn.close();
							return 0;
						}
					}
				    if(data>0){
						conn.commit();
						stmtRLE.close();
						conn.close();
						return docno;
				    }
				}
				stmtRLE.close();
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
	
	public int edit(String formdetailcode, int txtuserroledocno, String txtrolename, String txtemail, ArrayList<String> userrolearray, HttpSession session, String mode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtRLE1 = conn.createStatement();
			int data = 0;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
 			
			String sqls="select * from my_urole where user_role='"+txtrolename+"' and status=3 and doc_no!="+txtuserroledocno;
			ResultSet resultSet1 = stmtRLE1.executeQuery(sqls);
			   
		   while (resultSet1.next()) {
		        return -1;
		    }
			   
			CallableStatement stmtRLE = conn.prepareCall("{CALL userRoleDML(?,?,?,?,?,?,?)}");
			
			stmtRLE.setInt(6,txtuserroledocno);
			stmtRLE.setString(1,txtrolename);
			stmtRLE.setString(2,txtemail);
			stmtRLE.setString(3,formdetailcode);
			stmtRLE.setString(4,branch);
			stmtRLE.setString(5,userid);
			stmtRLE.setString(7,mode);
			int datas=stmtRLE.executeUpdate();
			if(datas<=0){
				stmtRLE.close();
				conn.close();
				return 0;
			}

			int docno=stmtRLE.getInt("docNo");
			userRoleBean.setTxtuserroledocno(docno);
			
			if (docno > 0) {
				
				String sql1=("delete from my_powr where roleid="+docno);
				int data1 = stmtRLE.executeUpdate(sql1);
			    
				/*User Role Grid Saving*/
				for(int i=0;i< userrolearray.size();i++){
				String[] userrole=userrolearray.get(i).split("::");
				if(!userrole[0].equalsIgnoreCase("undefined") && !userrole[0].equalsIgnoreCase("NaN")){
				
				int add = 0,edit = 0,del = 0,print = 0,attach = 0,excel = 0,email = 0,costing = 0,terms = 0;
				if(userrole[2].trim().equalsIgnoreCase("true")){
					add=1;
				}
				else if(userrole[2].trim().equalsIgnoreCase("") || userrole[2].trim().equalsIgnoreCase("false")){
					add=0;
				}
				if(userrole[3].trim().equalsIgnoreCase("true")){
					edit=1;
				}
				else if(userrole[3].trim().equalsIgnoreCase("") || userrole[3].trim().equalsIgnoreCase("false")){
					edit=0;
				}
				if(userrole[4].trim().equalsIgnoreCase("true")){
					del=1;
				}
				else if(userrole[4].trim().equalsIgnoreCase("") || userrole[4].trim().equalsIgnoreCase("false")){
					del=0;
				}
				if(userrole[5].trim().equalsIgnoreCase("true")){
					print=1;
				}
				else if(userrole[5].trim().equalsIgnoreCase("") || userrole[5].trim().equalsIgnoreCase("false")){
					print=0;
				}
				if(userrole[6].trim().equalsIgnoreCase("true")){
					attach=1;
				}
				else if(userrole[6].trim().equalsIgnoreCase("") || userrole[6].trim().equalsIgnoreCase("false")){
					attach=0;
				}
				if(userrole[7].trim().equalsIgnoreCase("true")){
					excel=1;
				}
				else if(userrole[7].trim().equalsIgnoreCase("") || userrole[7].trim().equalsIgnoreCase("false")){
					excel=0;
				}
				if(userrole[8].trim().equalsIgnoreCase("true")){
					email=1;
				}
				else if(userrole[8].trim().equalsIgnoreCase("") || userrole[8].trim().equalsIgnoreCase("false")){
					email=0;
				}
				if(userrole[9].trim().equalsIgnoreCase("true")){
					costing=1;
				}
				else if(userrole[9].trim().equalsIgnoreCase("") || userrole[9].trim().equalsIgnoreCase("false")){
					costing=0;
				}
				if(userrole[10].trim().equalsIgnoreCase("true")){
					terms=1;
				}
				else if(userrole[10].trim().equalsIgnoreCase("") || userrole[10].trim().equalsIgnoreCase("false")){
					terms=0;
				}
				
				stmtRLE = conn.prepareCall("{CALL userPowerDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRLE.setInt(1,docno);//Role Id
				stmtRLE.setString(2,(userrole[1].trim().equalsIgnoreCase("undefined") || userrole[1].trim().equalsIgnoreCase("NaN") || userrole[1].trim().equalsIgnoreCase("") ||userrole[1].trim().isEmpty()?0:userrole[1].trim()).toString()); //Menu Name
				stmtRLE.setInt(3,add); //Add
				stmtRLE.setInt(4,edit); //Edit
				stmtRLE.setInt(5,del);//Delete
				stmtRLE.setInt(6,print);//Print
				stmtRLE.setInt(7,attach);//Attach
				stmtRLE.setInt(8,excel);//Excel
				stmtRLE.setInt(9,email);//Email
				stmtRLE.setInt(10,costing);//Costing
				stmtRLE.setInt(11,terms);//Terms
				stmtRLE.setString(12,(userrole[0].trim().equalsIgnoreCase("undefined") || userrole[0].trim().equalsIgnoreCase("NaN") || userrole[0].trim().equalsIgnoreCase("") ||userrole[0].trim().isEmpty()?0:userrole[0].trim()).toString());//MNO
				stmtRLE.setString(13,mode);
				data = stmtRLE.executeUpdate();

				}
				
				if(data<=0){
					stmtRLE.close();
					conn.close();
					return 0;
				}
			}
		    if(data>0){
				conn.commit();
				stmtRLE.close();
				conn.close();
				return docno;
		    }
		}
		stmtRLE.close();
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
	
	public boolean delete(int txtuserroledocno, String formdetailcode,HttpSession session) throws SQLException {
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtRLE = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				 /*Status change in my_urole*/
				 String sql=("update my_urole set STATUS=7 where doc_no="+txtuserroledocno);
				 int data = stmtRLE.executeUpdate(sql);
				 if(data<=0){
						stmtRLE.close();
						conn.close();
						return false;
				}
				/*Status change in my_cashbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtuserroledocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtRLE.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				int docno=txtuserroledocno;
				userRoleBean.setTxtuserroledocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtRLE.close();
				    conn.close();
					return true;
				}	
				stmtRLE.close();
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
        List<ClsUserRoleBean> userRoleSearchBean = new ArrayList<ClsUserRoleBean>();
        
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRLE = conn.createStatement();
            	
				String sql="select doc_no,user_role from my_urole";
				
            	ResultSet resultSet = stmtRLE.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRLE.close();
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
        List<ClsUserRoleBean> userRoleGridLoadingBean = new ArrayList<ClsUserRoleBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRLE = conn.createStatement();
            	
				String sql="select menu_name,mno from my_menu order by mno";
				
            	ResultSet resultSet = stmtRLE.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRLE.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray userRoleGridReloading(String roleId) throws SQLException {
        List<ClsUserRoleBean> userRoleGridReloadingBean = new ArrayList<ClsUserRoleBean>();
        
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRLE = conn.createStatement();
            	
				String sql="select m.menu_name,m.mno,p.add1,p.edit,p.del,p.print,p.attach,p.excel,p.email,p.costing,p.terms from my_menu m left join my_powr p on m.mno=p.mno and p.roleid="+roleId+" where gate='E' order by m.mno";
				
            	ResultSet resultSet = stmtRLE.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRLE.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray rleMainSearch(String rolename,String docNo,String date) throws SQLException {

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
            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
        }
        if(!(rolename.equalsIgnoreCase(""))){
         sqltest=sqltest+" and user_role like '%"+rolename+"%'";
        }
        if(!(sqlUserRoleDate==null)){
	         sqltest=sqltest+" and date='"+sqlUserRoleDate+"'";
	        } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtRLE = conn.createStatement();
	       
	       ResultSet resultSet = stmtRLE.executeQuery("select user_role,mail,date,doc_no from my_urole where status=3" +sqltest);
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);

	       stmtRLE.close();
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
