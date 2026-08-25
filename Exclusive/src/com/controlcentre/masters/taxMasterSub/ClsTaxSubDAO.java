package com.controlcentre.masters.taxMasterSub;

 

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsTaxSubDAO{
	
	
	static ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
		
		
	
	public JSONArray accounttypesearch() throws SQLException
	{


		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;

		try 
		{
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
				String sql="select description,doc_no,account from my_head where atype='GL' and m_s=0";

				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}
		catch(Exception e)
		{
			e.printStackTrace();

		}
		finally
		{
			conn.close();
		}
		return RESULTDATA;
	}
	
	

	
	public JSONArray taxsearch() throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA=new JSONArray();
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtCompany = conn.createStatement (); 
		        	
					String q1="select t.doc_no doc_no,t.date tdate,t.provid provid,"
							+ " t.tax_name tax_name,t.tax_code tax_code,t.per per,t.cstper cstper,t.value,t.seqno hidseqno,t.type hidtype, "
							+ " case when t.value=-1 then 'value' when t.value=0 then 'tax%' else  m.tax_name end as hidtaxid, "
							+ " t.fromdate fromdate,t.todate todate,t.acno docacno, "
							+ " pr.name provname,h.description accdescription,h.account account from"
							+ " gl_taxsubmaster t left join my_province pr on pr.doc_no=t.provid left join my_head h on h.doc_no=t.acno"
							+ " left join gl_taxsubmaster m on m.doc_no=t.value"
							+ " where t.status=3";
					System.out.println("query"+q1);
					ResultSet resultSet = stmtCompany.executeQuery(q1);
				
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtCompany.close();

			}
			
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
		//System.out.println("nitin===="+listBean);
		    return RESULTDATA;
		}

	
	
	
	public JSONArray provincetypesearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,name ptype from my_province where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	


	public JSONArray taxsubsearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement(); 

			String sql="select -1 doc_no,'' tax_code,'value' taxname"
					+ " union all"
					+ " select 0 doc_no,'' tax_code,'tax%' taxname "
					+ " union all "
					+ " select doc_no,tax_code taxcode,tax_name taxname from gl_taxsubmaster where status=3;";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}





	public static int insert(int tdocno,Date sqlDate,int txtprovinceid,
			String txttaxname,String txttaxcode,
			double txtpercentage,double txtcst,int hidtaxdocid,
			Date sqlfromDate,Date sqltoDate,int acctdocno,int i,String tmode,int hidtype,int hidsqno) throws SQLException {		
			Connection conn=null;
			CallableStatement stmttax=null;
			ClsConnection ClsConnection=new ClsConnection();	
			try
			{		
				conn=ClsConnection.getMyConnection();



		
				stmttax = conn.prepareCall("{CALL  taxsubproDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
				/*stmttax.registerOutParameter(32, java.sql.Types.INTEGER);
				stmttax.registerOutParameter(33, java.sql.Types.INTEGER);*/
	      // main
		stmttax.registerOutParameter(1,java.sql.Types.INTEGER);
		stmttax.setDate(2,sqlDate);
		
		stmttax.setInt(3,txtprovinceid);
		stmttax.setString(4,tmode);
		stmttax.setString(5,txttaxname);
		stmttax.setString(6,txttaxcode);
		stmttax.setDouble(7,txtpercentage);
		stmttax.setDouble(8,txtcst);
		
		stmttax.setInt(9,hidtaxdocid);
		stmttax.setDate(10,sqlfromDate);
		stmttax.setDate(11,sqltoDate);
		stmttax.setInt(12,acctdocno);
		stmttax.setInt(13,i);
		stmttax.setInt(14,hidtype);
		stmttax.setInt(15,hidsqno);
		
		
		
		
				
		stmttax.executeQuery();
		
	   tdocno=stmttax.getInt("docNo");
	   System.out.println("==tdocno===="+tdocno);
	   System.out.println("doc no="+tdocno);
	   if(tdocno>0)
	   {
		   System.out.println("doc no="+tdocno);
		   stmttax.close();
			conn.close();

			return tdocno;
	  
	   }
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			 stmttax.close();
				conn.close();
		}
	  
		
		return tdocno;
	}
	
	
	
	
	
	




	public int update(int tdocno, Date sqlDate, int txtprovinceid,
			String txttaxname, String txttaxcode,
			double txtpercentage, double txtcst,int hidtaxdocid,
			Date sqlfromDate, Date sqltoDate, int acctdocno, int i,
            String tmode,int hidtype,int hidseqno) throws SQLException
	{
		
		
		
		Connection conn=null;
		CallableStatement stmttax=null;
		ClsConnection ClsConnection=new ClsConnection();	
		try
		{		
			conn=ClsConnection.getMyConnection();



	
			stmttax = conn.prepareCall("{CALL  taxsubproDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	
			/*stmttax.registerOutParameter(32, java.sql.Types.INTEGER);
			stmttax.registerOutParameter(33, java.sql.Types.INTEGER);*/
			// main
					stmttax.setInt(1,tdocno);
					stmttax.setDate(2,sqlDate);
	
					stmttax.setInt(3,txtprovinceid);
					stmttax.setString(4,tmode);
					stmttax.setString(5,txttaxname);
					stmttax.setString(6,txttaxcode);
					stmttax.setDouble(7,txtpercentage);
					stmttax.setDouble(8,txtcst);
	
					stmttax.setInt(9,hidtaxdocid);
					stmttax.setDate(10,sqlfromDate);
					stmttax.setDate(11,sqltoDate);
					stmttax.setInt(12,acctdocno);
					stmttax.setInt(13,i);
					stmttax.setInt(14,hidtype);
					stmttax.setInt(15,hidseqno);
					
					
	
	
			
					stmttax.executeQuery();
	
					tdocno=stmttax.getInt("docNo");
					System.out.println("==tdocno===="+tdocno);

					if(tdocno>0)
					{
   
						stmttax.close();
						conn.close();

						return tdocno;
  
					}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		
		}
		finally
		{
			stmttax.close();
			conn.close();
		}
  
	
		return tdocno;
	}





	public static int delete(int tdocno, HttpSession session)throws SQLException
	{		
	
			System.out.println(" delet");
	        Connection conn=null;
	        CallableStatement stmt=null;
	        
			try{
				
			
			conn=ClsConnection.getMyConnection();
			/*conn.setAutoCommit(false);*/
			Statement cpstmt = conn.createStatement ();
			String sql="update gl_taxsubmaster set status=7 where doc_no='"+tdocno+"'";
			
			cpstmt.executeUpdate(sql);
			cpstmt.close();
	
			 
			}
			catch(Exception e){
				e.printStackTrace();
				tdocno=0;
			}
			finally{
				
				conn.close();
				
			}
			return tdocno;
		
	}


		
	
	
}
