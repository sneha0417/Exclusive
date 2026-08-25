package com.controlcentre.settings.costcentermaster;


        
    import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

    import net.sf.json.JSONArray;

    import com.common.ClsCommon;
import com.connection.ClsConnection;


    public class ClsCostCenterDAO {
    	Connection conn;
    	ClsConnection ClsConnection=new ClsConnection();

    	ClsCommon ClsCommon=new ClsCommon();

    	
    	public int insert(Date date_accountmaster,String accountGroup,String category,String acccategory,String accountcode,String accountName,String accountgpName,String mode, HttpSession session,String Formdetailcode, 
    			HttpServletRequest request) throws SQLException {
    		
    		try{
    			int docno;
    			 conn=ClsConnection.getMyConnection();
    			 conn.setAutoCommit(false);
    	/*		Statement stmtCostMaster1 = conn.createStatement ();
    			String sql = "";
    			
    			if(accountcode.trim().equalsIgnoreCase("")){
    				sql=" and costcode=(select max(doc_no)+1 from my_ccentre)";
    			}
    			else{
    				sql=" and costcode ="+accountcode;
    			}
    			
    			String sql1="select doc_no from my_ccentre where 1=1 "+sql;
    			
			
    		
				ResultSet resultSet1 = stmtCostMaster1.executeQuery (sql1);
				
				while (resultSet1.next()) {
			
								 return -1;
					
			     }*/
    			
    			CallableStatement stmtCostMaster = conn.prepareCall("{CALL CostcenterMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
    			stmtCostMaster.registerOutParameter(2, java.sql.Types.INTEGER);
    			stmtCostMaster.setDate(1,date_accountmaster);
    			stmtCostMaster.setString(3,accountGroup.trim());
    			stmtCostMaster.setString(4,accountcode);
    			stmtCostMaster.setString(5,accountName);
    			stmtCostMaster.setString(6,accountgpName);
    			stmtCostMaster.setString(7,session.getAttribute("BRANCHID").toString());
    			stmtCostMaster.setString(8,session.getAttribute("USERID").toString());
    			stmtCostMaster.setString(9,session.getAttribute("CURRENCYID").toString());
    			stmtCostMaster.setString(10,category);
    			stmtCostMaster.setString(11,acccategory);
    			stmtCostMaster.setString(12,Formdetailcode);
    			stmtCostMaster.setString(13,mode);
    			stmtCostMaster.executeUpdate();
    			docno=stmtCostMaster.getInt("docNo");
   
    			
    			Statement stmtcostsMaster1 = conn.createStatement ();
    			String sql1 = "";
    			
    			String acc="";
    			 sql1="select costcode from my_ccentre where doc_no="+docno;
    			
    			ResultSet resultSet1 = stmtcostsMaster1.executeQuery (sql1);
    			
    			while (resultSet1.next()) {
    		
    				 acc=(resultSet1.getString("costcode"));	
    				
    		     }
    			
    			
    				request.setAttribute("accountcode",acc);
    			
    			
    			
    			if (docno > 0) {
    				conn.commit();
    				stmtcostsMaster1.close();
        			stmtCostMaster.close();
        			conn.close();
    				return docno;
    			}
    		}catch(Exception e){	
    			e.printStackTrace();
    			conn.close();
    		}
    		return 0;
    	}
    	
  	public int edit(int docno,Date date_accountmaster,String accountGroup,String category,String acccategory,String accountcode,String accountName,String accountgpName,String mode, HttpSession session,String Formdetailcode, HttpServletRequest request) throws SQLException
    	{
    		try{
    			 conn=ClsConnection.getMyConnection();
    			 conn.setAutoCommit(false);
    		/*	Statement stmtCostMaster1 = conn.createStatement ();
    			
    			
    			String sql = "";
    			
    			if(accountcode.trim().equalsIgnoreCase("")){
    				sql=" and costcode="+docno+" and   doc_no!="+docno+"";
    			}
    			else{
    				sql=" and costcode ="+accountcode+" and   doc_no!="+docno+"";
    			}
    			
    			String sql1="select doc_no from my_ccentre where 1=1 "+sql;
				ResultSet resultSet1 = stmtCostMaster1.executeQuery (sql1);
				
				while (resultSet1.next()) {
			
								 return -1;
					          
			     }*/
				CallableStatement stmtCostMaster = conn.prepareCall("{CALL CostcenterMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
    		
    			stmtCostMaster.setDate(1,date_accountmaster);
    			stmtCostMaster.setInt(2, docno);
    			stmtCostMaster.setString(3,accountGroup.trim());
    			stmtCostMaster.setString(4,accountcode);
    			stmtCostMaster.setString(5,accountName);
    			stmtCostMaster.setString(6,accountgpName);
    			stmtCostMaster.setString(7,session.getAttribute("BRANCHID").toString());
    			stmtCostMaster.setString(8,session.getAttribute("USERID").toString());
    			stmtCostMaster.setString(9,session.getAttribute("CURRENCYID").toString());
    			stmtCostMaster.setString(10,category);
    			stmtCostMaster.setString(11,acccategory);
    			stmtCostMaster.setString(12,Formdetailcode);
    			stmtCostMaster.setString(13,mode);
    			stmtCostMaster.executeUpdate();
    			 docno=stmtCostMaster.getInt("docNo");
    			//System.out.println(docno);
    			//brandBean.setDocno(aaa);
    			 Statement stmtcostMaster12 = conn.createStatement ();
 				String sql1 = "";
 				
 				String acc="";
 				 sql1="select costcode from my_ccentre where doc_no="+docno;
 				
 				ResultSet resultSet12 = stmtcostMaster12.executeQuery (sql1);
 				
 				while (resultSet12.next()) {
 			
 					 acc=(resultSet12.getString("costcode"));	
 					
 			     }
 				
 				
 					request.setAttribute("accountcode",acc);
    			if (docno > 0) {
    				conn.commit();
    				stmtcostMaster12.close();
        			stmtCostMaster.close();
        			conn.close();
    				System.out.println("Sucess");
    				return 1;
    			}
    		}catch(Exception e){
    			conn.close();
    		}
    		return 0;
    	}

    	public boolean delete(int docno,int delchk, HttpSession session,String Formdetailcode) throws SQLException {
    	
    	
    		try {
    			 conn=ClsConnection.getMyConnection();
    			 conn.setAutoCommit(false);
    			Statement stmtCostMaster1 = conn.createStatement ();
    			if(delchk==1||delchk==2)
				{
				String sql="select grpno from my_ccentre ";
				ResultSet resultSet = stmtCostMaster1.executeQuery (sql);
				while (resultSet.next()) {
					 int data = (resultSet.getInt("grpno"));
					 if(docno==data)
					 {
						 return false;
					 }
					}
			     }
					if(delchk==3)
					{
					String sql="select acno from my_costtran where acno="+docno+" ";
					ResultSet resultSet = stmtCostMaster1.executeQuery (sql);
					while (resultSet.next()) {
						 int data = (resultSet.getInt("acno"));
						 if(docno==data)
						 {
							 return false;
						 }
						}
	
					}
    			
    			CallableStatement stmtCostMaster = conn.prepareCall("{CALL CostcenterMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
    			stmtCostMaster.setDate(1,null);
    			stmtCostMaster.setInt(2, docno);
    			stmtCostMaster.setString(3,null);
    			stmtCostMaster.setString(4,null);
    			stmtCostMaster.setString(5,null);
    			stmtCostMaster.setString(6,null);
    			stmtCostMaster.setString(7,session.getAttribute("BRANCHID").toString());
    			stmtCostMaster.setString(8,session.getAttribute("USERID").toString());
    			stmtCostMaster.setString(9,session.getAttribute("CURRENCYID").toString());
    			stmtCostMaster.setString(10,null);
    			stmtCostMaster.setString(11,null);
    			stmtCostMaster.setString(12,Formdetailcode);
    			stmtCostMaster.setString(13,"D");
    			stmtCostMaster.executeUpdate();
    			 docno=stmtCostMaster.getInt("docNo");
    			
    			if (docno > 0) {
    				conn.commit();
        			stmtCostMaster.close();
        			conn.close();
    				System.out.println("Sucess");
    				return true;
    			}	
    		}catch(Exception e){
    			conn.close();
    		}
    		System.out.println("not deleted");
    		
			return false;
    		}
    	
    		
    	public  JSONArray searchDetails() throws SQLException {

            JSONArray RESULTDATA=new JSONArray();
            
            Connection conn = null;
    		try {
    				 conn = ClsConnection.getMyConnection();
    				Statement stmtVeh = conn.createStatement ();
                	
    				ResultSet resultSet = stmtVeh.executeQuery ("select h.Description,h.costtype,h.doc_no,h.date,h.costcode,if(h.m_s=1,'M','D')as md,h.m_s,h.alevel,h.grpno,a.costgroup from my_ccentre as h inner join  my_costunit as a on a.costtype=h.costtype;");

    				RESULTDATA=ClsCommon.convertToJSON(resultSet);
    				stmtVeh.close();
    				conn.close();

    		}
    		catch(Exception e){
    			conn.close();
    			
    		}
    		//System.out.println(RESULTDATA);
            return RESULTDATA;
        }

    	 public  JSONArray getChartOfCost() throws SQLException {
    		 JSONArray RESULTDATA=new JSONArray();
    		 Connection conn = null;
    		 try {
    			  conn = ClsConnection.getMyConnection();
    			 Statement stmtCost = conn.createStatement ();

    			/* String sqlnew="select (select  description from my_head where account=m.grpNo) group_name,m.grpNo,m.description,m.account,d.gp_id,p.fi_id,m.alevel,m.m_s,p.head,d.gp_desc "
    			 		+ " from my_head m inner join my_agrp p on m.den=p.fi_id "
    			 		+ "inner join gc_agrpd d on d.gp_id= p.gp_pr  and d.gtype='D'  where m.atype='GL' and m_s=0  "
    			 		+ "order by  d.gp_id,p.fi_id,m.alevel ";*/
    			 
    			 String sqlnew="select (select  description from my_ccentre where costcode=m.grpNo) group_name,m.grpNo,m.description,m.costcode,"
    			 		+ "p.CostType,m.alevel,m.m_s,p.CostGroup   from my_ccentre m inner join my_costunit p on m.costtype=p.costtype "
    			 		+ " where  m_s=0	order by  p.costtype,m.alevel";

    			 ResultSet resultSet = stmtCost.executeQuery (sqlnew);

    			 RESULTDATA=ClsCommon.convertToJSON(resultSet);

    			 stmtCost.close();
    			 conn.close();

    			// System.out.println("result data ===== "+RESULTDATA);
    		 }
    		 catch(Exception e){
    			 e.printStackTrace();
    			 conn.close();
    		 }

    		 return RESULTDATA;
       
     }

}
