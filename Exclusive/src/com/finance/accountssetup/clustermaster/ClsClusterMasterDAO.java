package com.finance.accountssetup.clustermaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClusterMasterDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	 ClsClusterMasterBean clustermasterbean = new ClsClusterMasterBean();
		
	  public int insert(Date clusterMasterDate, String formdetailcode, String txtclustername, String txtdescription, ArrayList<String> clusteraccountsarray, HttpSession session,
				HttpServletRequest request, String mode) throws SQLException {
		 
		 		Connection conn = null;

		 		try{
		 			conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					
					CallableStatement stmtCLM = conn.prepareCall("{CALL clusterMastermDML(?,?,?,?,?,?,?,?)}");
					
					stmtCLM.registerOutParameter(7, java.sql.Types.INTEGER);
					stmtCLM.setDate(1,clusterMasterDate);
					stmtCLM.setString(2,txtclustername);
					stmtCLM.setString(3,txtdescription);
					stmtCLM.setString(4,formdetailcode);
					stmtCLM.setString(5,branch);
					stmtCLM.setString(6,userid);
					stmtCLM.setString(8,mode);
					stmtCLM.executeQuery();
					docno=stmtCLM.getInt("docNo");
					
					clustermasterbean.setTxtclmmasterdocno(docno);
					if (docno > 0) {
					int data=0;
					
					/*Cluster Account Grid Saving*/
					for(int i=0;i< clusteraccountsarray.size();i++){
					CallableStatement stmtCLM1=null;
					String[] cluster=clusteraccountsarray.get(i).split("::");
					if(!cluster[0].equalsIgnoreCase("undefined") && !cluster[0].equalsIgnoreCase("NaN")){
					    
						stmtCLM1 = conn.prepareCall("INSERT INTO my_setclusterd(rdocno, acno, status) VALUES(?,?,?)");
						
						stmtCLM1.setInt(1,docno); //doc_no
						stmtCLM1.setString(2,(cluster[0].trim().equalsIgnoreCase("undefined") || cluster[0].trim().equalsIgnoreCase("NaN") || cluster[0].trim().equalsIgnoreCase("") ||cluster[0].trim().isEmpty()?0:cluster[0].trim()).toString()); //accDocNo
						stmtCLM1.setString(3,"3"); //status
						data = stmtCLM1.executeUpdate();
						
						if(data<=0){
							stmtCLM1.close();
							conn.close();
							return 0;
					   }
					 }
					}
					
					conn.commit();
					stmtCLM.close();
					conn.close();
					return docno;
				}
					stmtCLM.close();
					conn.close();
					return docno;
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		}
		
	  public int edit(int txtclmmasterdocno, String formdetailcode, Date clusterMasterDate, String txtclustername, String txtdescription, ArrayList<String> clusteraccountsarray,
				HttpSession session, HttpServletRequest request, String mode) throws SQLException {

		 Connection conn = null;
		 	
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			CallableStatement stmtCLM = conn.prepareCall("{CALL clusterMastermDML(?,?,?,?,?,?,?,?)}");
				
				stmtCLM.setInt(7,txtclmmasterdocno);
				stmtCLM.setDate(1,clusterMasterDate);
				stmtCLM.setString(2,txtclustername);
				stmtCLM.setString(3,txtdescription);
				stmtCLM.setString(4,formdetailcode);
				stmtCLM.setString(5,branch);
				stmtCLM.setString(6,userid);
				stmtCLM.setString(8,mode);
				stmtCLM.executeQuery();
				int docno=stmtCLM.getInt("docNo");
				
				clustermasterbean.setTxtclmmasterdocno(docno);
				if (docno > 0) {
					int data=0;
					
					String sql="DELETE FROM my_setclusterd WHERE rdocno="+docno+"";
					stmtCLM.executeUpdate(sql);
					
					/*Cluster Account Grid Saving*/
					for(int i=0;i< clusteraccountsarray.size();i++){
					CallableStatement stmtCLM1=null;
					String[] cluster=clusteraccountsarray.get(i).split("::");
					if(!cluster[0].equalsIgnoreCase("undefined") && !cluster[0].equalsIgnoreCase("NaN")){
					    
						stmtCLM1 = conn.prepareCall("INSERT INTO my_setclusterd(rdocno, acno, status) VALUES(?,?,?)");
						
						stmtCLM1.setInt(1,docno); //doc_no
						stmtCLM1.setString(2,(cluster[0].trim().equalsIgnoreCase("undefined") || cluster[0].trim().equalsIgnoreCase("NaN") || cluster[0].trim().equalsIgnoreCase("") ||cluster[0].trim().isEmpty()?0:cluster[0].trim()).toString()); //accDocNo
						stmtCLM1.setString(3,"3"); //status
						data = stmtCLM1.executeUpdate();
						
						if(data<=0){
							stmtCLM1.close();
							conn.close();
							return 0;
					   }
					 }
					}
					
					conn.commit();
					stmtCLM.close();
					conn.close();
					return 1;
				}	
				stmtCLM.close();
				conn.close();
				return 1;
		 }catch(Exception e){
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		}

		public int delete(int txtclmmasterdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
	 		CallableStatement stmtCLM = conn.prepareCall("{CALL clusterMastermDML(?,?,?,?,?,?,?,?)}");
			
			stmtCLM.setInt(7,txtclmmasterdocno);
			stmtCLM.setDate(1,null);
			stmtCLM.setString(2,null);
			stmtCLM.setString(3,null);
			stmtCLM.setString(4,formdetailcode);
			stmtCLM.setString(5,branch);
			stmtCLM.setString(6,userid);
			stmtCLM.setString(8,mode);
			stmtCLM.executeQuery();
			int docno=stmtCLM.getInt("docNo");
			clustermasterbean.setTxtclmmasterdocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtCLM.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtCLM.close();
				conn.close();
				return docno;
			}
			stmtCLM.close();
			conn.close();
			return 0;
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
  }
     
		public  ClsClusterMasterBean getViewDetails(int docNo) throws SQLException {
			
			ClsClusterMasterBean clustermasterbean = new ClsClusterMasterBean();
			
			Connection conn = null;
			
			try {
			
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtCLM = conn.createStatement();

				String sql= ("select doc_no, date, desc1 name, remarks description from my_setclusterm where status=3 and doc_no="+docNo+"");
				
				ResultSet resultSet = stmtCLM.executeQuery(sql);
							
				while (resultSet.next()) {
					
					clustermasterbean.setClusterDate(resultSet.getDate("date").toString());
					clustermasterbean.setTxtclustername(resultSet.getString("name"));
					clustermasterbean.setTxtdescription(resultSet.getString("description"));
					
			        }
				stmtCLM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return clustermasterbean;
		}
    
    public JSONArray clusterAccountReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCLM = conn.createStatement();
				
				ResultSet resultSet = stmtCLM.executeQuery ("select d.acno doc_no,h.atype type,h.account,h.description accountname from my_setclusterd d left join my_head h on d.acno=h.doc_no " + 
						"where d.status=3 and d.rdocno="+docNo+"");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCLM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

    public JSONArray accountsDetails(HttpSession session,String atype,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
	           }

	            String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		        	sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) rate from my_head t left join my_curr c "
						+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			  conn.close();
			}
	       return RESULTDATA;
	  }
 
    public  JSONArray clusterMainSearch(HttpSession session,String docno,String date,String clustername,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtCLM = conn.createStatement();
    	   
    	   if(check.equalsIgnoreCase("1")){
        	    java.sql.Date sqlDate=null;
        	   
    	        date.trim();
    	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
    	        {
    	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
    	        }
    	        
    	        String sqltest="";

    	        if(!(docno.equalsIgnoreCase(""))){
    	        	sqltest=sqltest+" and doc_no like '%"+docno+"%'";
    	        }
    	        if(!(sqlDate==null)){
    	        	sqltest=sqltest+" and date='"+sqlDate+"'";
    	        } 
    	        if(!(clustername.equalsIgnoreCase(""))){
    	            sqltest=sqltest+" and desc1 like '%"+clustername+"%'";
    	        }
    	        
	       ResultSet resultSet = stmtCLM.executeQuery("select doc_no, date, desc1 name, remarks description from my_setclusterm where status=3"+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
    	   
    	   }
	       stmtCLM.close();
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
