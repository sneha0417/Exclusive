package com.procurement.purchase.purchaseexpenses;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsExpDAO {

	
	
	Connection conn;
	ClsConnection ClsConnection=new ClsConnection();	
	ClsCommon ClsCommon=new ClsCommon();
	public int insert(int accdocno, String desc1, String mode,
			String formdetailcode, HttpServletRequest request, HttpSession session) throws SQLException {
	 
		try
		{
		
	 	 conn = ClsConnection.getMyConnection();
 
	 	CallableStatement stmtexp= conn.prepareCall("{call tr_purchaseExpDML(?,?,?,?,?,?,?)}");
	 	stmtexp.registerOutParameter(7, java.sql.Types.INTEGER);
		 
	 	stmtexp.setInt(1,accdocno);
	 	stmtexp.setString(2,desc1);
		stmtexp.setString(3,formdetailcode);
	 	stmtexp.setString(4,mode);
	 	stmtexp.setString(5,session.getAttribute("USERID").toString());
	 	stmtexp.setString(6,session.getAttribute("BRANCHID").toString());
  
	 	stmtexp.executeQuery();
	int	docno=stmtexp.getInt("docNo");
 
	
	      if(docno>0)
	      {
	    	  
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
	
	
	
	

	public int update(int docno, int accdocno, String desc1, String mode,
			String formdetailcode, HttpServletRequest request, HttpSession session)throws SQLException  {

		try
		{
		
	 	 conn = ClsConnection.getMyConnection();

	 	CallableStatement stmtexp= conn.prepareCall("{call tr_purchaseExpDML(?,?,?,?,?,?,?)}");
 
		 
	 	stmtexp.setInt(1,accdocno);
	 	stmtexp.setString(2,desc1);
		stmtexp.setString(3,formdetailcode);
	 	stmtexp.setString(4,mode);
	 	stmtexp.setString(5,session.getAttribute("USERID").toString());
	 	stmtexp.setString(6,session.getAttribute("BRANCHID").toString());
		stmtexp.setInt(7,docno );
	 int res= stmtexp.executeUpdate();
	 

		if(res>0)
		{
			stmtexp.close();
			conn.close();
			return 1;	
		}
		
		
		
	}
		
		catch (Exception e)
		{
			
			e.printStackTrace();
		     conn.close();
			 
			
		}
		
		
		return 0;	 
	}


	
	

	public int delete(int docno, int accdocno, String desc1, String mode,
			String formdetailcode, HttpServletRequest request, HttpSession session) throws SQLException {
		try
		{

	 	 conn = ClsConnection.getMyConnection();

	 	CallableStatement stmtexp= conn.prepareCall("{call tr_purchaseExpDML(?,?,?,?,?,?,?)}");
	 
		 
	 	stmtexp.setInt(1,accdocno);
	 	stmtexp.setString(2,desc1);
		stmtexp.setString(3,formdetailcode);
	 	stmtexp.setString(4,mode);
	 	stmtexp.setString(5,session.getAttribute("USERID").toString());
	 	stmtexp.setString(6,session.getAttribute("BRANCHID").toString());
	 	stmtexp.setInt(7,docno );
	        int res= stmtexp.executeUpdate();
		
		
		
		
		if(res>0)
		{
			stmtexp.close();
			conn.close();
			return 1;	
		}
		
		
		
		}
		
		catch (Exception e)
		{
			
			e.printStackTrace();
		     conn.close();
			 
			
		}
		
		return 0;	
	 
	}





	
	
	public JSONArray accountsDetailsFrom() throws SQLException {


		JSONArray RESULTDATA=new JSONArray(); 

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();    //    descsrno  accountdono

	/*		String sql=" select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
					+ "  left join my_curbook cb on t.curid=cb.curid  where  t.grpno=(select acno from my_account where codeno='PEXPAY')";
			
			*/
			
			String sql=" select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
					+ "  left join my_curbook cb on t.curid=cb.curid  where  t.m_s=0 and t.atype='GL' ";
			
			
			
		// System.out.println("===zxdfghjkl,mnbvcxcvkl;====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}



	public JSONArray mastersearchFrom() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();  

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();    //    descsrno  accountdono

			String sql="  select e.doc_no,e.acno,e.desc1,  t.account,t.description accname from  my_purchexp e  "
					+ " left join my_head t    on t.doc_no=e.acno  where   status=3 ";
		//System.out.println("===zxdfghjkl,mnbvcxcvkl;====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}









	
	
	
	
	
}
