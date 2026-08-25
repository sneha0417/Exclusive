package com.finance.accountssetup.trfsetup;

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

public class ClsTrfSetUpDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	 ClsTrfSetUpBean trfsetupbean = new ClsTrfSetUpBean();
		
	  public int insert(Date trfDate, String formdetailcode, String txttrfsetupname,String txtmainaccountdocno,String txtdescription, ArrayList<String> intercompanyaccountsarray, HttpSession session,
				HttpServletRequest request, String mode) throws SQLException {
		 
		 		Connection conn = null;

		 		try{
		 			conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					
					CallableStatement stmtTRF = conn.prepareCall("{CALL trfSetUpmDML(?,?,?,?,?,?,?,?,?)}");
					
					stmtTRF.registerOutParameter(8, java.sql.Types.INTEGER);
					stmtTRF.setDate(1,trfDate);
					stmtTRF.setString(2,txttrfsetupname);
					stmtTRF.setString(3,txtmainaccountdocno);
					stmtTRF.setString(4,txtdescription);
					stmtTRF.setString(5,formdetailcode);
					stmtTRF.setString(6,branch);
					stmtTRF.setString(7,userid);
					stmtTRF.setString(9,mode);
					stmtTRF.executeQuery();
					docno=stmtTRF.getInt("docNo");
					
					trfsetupbean.setTxttrfsetupdocno(docno);
					if (docno > 0) {
					int data=0;
					
					/*Inter Company Account Grid Saving*/
					for(int i=0;i< intercompanyaccountsarray.size();i++){
					CallableStatement stmtTRF1=null;
					String[] intercompany=intercompanyaccountsarray.get(i).split("::");
					if(!intercompany[0].equalsIgnoreCase("undefined") && !intercompany[0].equalsIgnoreCase("NaN")){
					    
						stmtTRF1 = conn.prepareCall("INSERT INTO my_settrfd(rdocno, acno, status) VALUES(?,?,?)");
						
						stmtTRF1.setInt(1,docno); //doc_no
						stmtTRF1.setString(2,(intercompany[0].trim().equalsIgnoreCase("undefined") || intercompany[0].trim().equalsIgnoreCase("NaN") || intercompany[0].trim().equalsIgnoreCase("") ||intercompany[0].trim().isEmpty()?0:intercompany[0].trim()).toString()); //accDocNo
						stmtTRF1.setString(3,"3"); //status
						data = stmtTRF1.executeUpdate();
						
						if(data<=0){
							stmtTRF1.close();
							conn.close();
							return 0;
					   }
					 }
					}
					
					conn.commit();
					stmtTRF.close();
					conn.close();
					return docno;
				}
					stmtTRF.close();
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
		
	  public int edit(int txttrfsetupdocno, String formdetailcode, Date trfDate, String txttrfsetupname, String txtmainaccountdocno, String txtdescription, ArrayList<String> intercompanyaccountsarray,
				HttpSession session, HttpServletRequest request, String mode) throws SQLException {

		 Connection conn = null;
		 	
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			CallableStatement stmtTRF = conn.prepareCall("{CALL trfSetUpmDML(?,?,?,?,?,?,?,?,?)}");
				
	 			stmtTRF.setInt(8,txttrfsetupdocno);
	 			stmtTRF.setDate(1,trfDate);
	 			stmtTRF.setString(2,txttrfsetupname);
	 			stmtTRF.setString(3,txtmainaccountdocno);
	 			stmtTRF.setString(4,txtdescription);
	 			stmtTRF.setString(5,formdetailcode);
	 			stmtTRF.setString(6,branch);
	 			stmtTRF.setString(7,userid);
	 			stmtTRF.setString(9,mode);
	 			stmtTRF.executeQuery();
				int docno=stmtTRF.getInt("docNo");
				
				trfsetupbean.setTxttrfsetupdocno(docno);
				if (docno > 0) {
					int data=0;
					
					String sql="DELETE FROM my_settrfd WHERE rdocno="+docno+"";
					stmtTRF.executeUpdate(sql);
					
					/*Inter Company Account Grid Saving*/
					for(int i=0;i< intercompanyaccountsarray.size();i++){
					CallableStatement stmtTRF1=null;
					String[] intercompany=intercompanyaccountsarray.get(i).split("::");
					if(!intercompany[0].equalsIgnoreCase("undefined") && !intercompany[0].equalsIgnoreCase("NaN")){
					    
						stmtTRF1 = conn.prepareCall("INSERT INTO my_settrfd(rdocno, acno, status) VALUES(?,?,?)");
						
						stmtTRF1.setInt(1,docno); //doc_no
						stmtTRF1.setString(2,(intercompany[0].trim().equalsIgnoreCase("undefined") || intercompany[0].trim().equalsIgnoreCase("NaN") || intercompany[0].trim().equalsIgnoreCase("") ||intercompany[0].trim().isEmpty()?0:intercompany[0].trim()).toString()); //accDocNo
						stmtTRF1.setString(3,"3"); //status
						data = stmtTRF1.executeUpdate();
						
						if(data<=0){
							stmtTRF1.close();
							conn.close();
							return 0;
					   }
					 }
					}
					
					conn.commit();
					stmtTRF.close();
					conn.close();
					return 1;
				}	
				stmtTRF.close();
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

		public int delete(int txttrfsetupdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
	 		CallableStatement stmtTRF = conn.prepareCall("{CALL trfSetUpmDML(?,?,?,?,?,?,?,?,?)}");
			
	 		stmtTRF.setInt(8,txttrfsetupdocno);
	 		stmtTRF.setDate(1,null);
	 		stmtTRF.setString(2,null);
	 		stmtTRF.setString(3,null);
	 		stmtTRF.setString(4,null);
	 		stmtTRF.setString(5,formdetailcode);
	 		stmtTRF.setString(6,branch);
	 		stmtTRF.setString(7,userid);
	 		stmtTRF.setString(9,mode);
	 		stmtTRF.executeQuery();
			int docno=stmtTRF.getInt("docNo");
			trfsetupbean.setTxttrfsetupdocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtTRF.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtTRF.close();
				conn.close();
				return docno;
			}
			stmtTRF.close();
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
     
		public  ClsTrfSetUpBean getViewDetails(int docNo) throws SQLException {
			
			ClsTrfSetUpBean trfsetupbean = new ClsTrfSetUpBean();
			
			Connection conn = null;
			
			try {
			
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtTRF = conn.createStatement();

				String sql= ("select m.doc_no, m.date, m.desc1 name, m.acno, m.remarks description,h.account,h.description accountname from my_settrfm m left join my_head h on "
						+ "m.acno=h.doc_no where m.status=3 and m.doc_no="+docNo+"");
				
				ResultSet resultSet = stmtTRF.executeQuery(sql);
							
				while (resultSet.next()) {
					
					trfsetupbean.setTrfSetUpDate(resultSet.getDate("date").toString());
					trfsetupbean.setTxttrfsetupname(resultSet.getString("name"));
					trfsetupbean.setTxtdescription(resultSet.getString("description"));
					trfsetupbean.setTxtmainaccountdocno(resultSet.getString("acno"));
					trfsetupbean.setTxtmainaccountno(resultSet.getString("account"));
					trfsetupbean.setTxtmainaccountname(resultSet.getString("accountname"));
					
			        }
				stmtTRF.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return trfsetupbean;
		}
    
    public JSONArray interCompanyAccountReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtTRF = conn.createStatement();
				
				ResultSet resultSet = stmtTRF.executeQuery ("select d.acno doc_no,h.atype type,h.account,h.description accountname from my_settrfd d left join my_head h on d.acno=h.doc_no "
						+ "where d.status=3 and d.rdocno="+docNo+"");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtTRF.close();
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
		       Statement stmtTRF = conn.createStatement();
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
		        
		       ResultSet resultSet = stmtTRF.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtTRF.close();
		       conn.close();
		       }
	         stmtTRF.close();
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
 
    public  JSONArray interCompanyMainSearch(HttpSession session,String docno,String date,String clustername,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtTRF = conn.createStatement();
    	   
    	   if(check.equalsIgnoreCase("1")){
        	    java.sql.Date sqlDate=null;
        	   
    	        date.trim();
    	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
    	        {
    	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
    	        }
    	        
    	        String sqltest="";

    	        if(!(docno.equalsIgnoreCase(""))){
    	        	sqltest=sqltest+" and m.doc_no like '%"+docno+"%'";
    	        }
    	        if(!(sqlDate==null)){
    	        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
    	        } 
    	        if(!(clustername.equalsIgnoreCase(""))){
    	            sqltest=sqltest+" and m.desc1 like '%"+clustername+"%'";
    	        }
    	        
	       ResultSet resultSet = stmtTRF.executeQuery("select m.doc_no, m.date, m.desc1 name, m.acno, m.remarks description,h.account,h.description accountname from my_settrfm m "
	    		   + "left join my_head h on m.acno=h.doc_no where m.status=3"+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
    	   
    	   }
    	   stmtTRF.close();
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
