package com.controlcentre.settings.yearclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsYearcloseDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date date, Date dateupto, Date yclosedate, HttpSession session, HttpServletRequest request,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		
			
		Connection conn=null;
		try{
			int docno=0;
			 
			conn=ClsConnection.getMyConnection();
		
			CallableStatement stmtMclose = conn.prepareCall("{call yearCloseDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtMclose.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtMclose.setDate(1,date);
			stmtMclose.setDate(2,dateupto);
			stmtMclose.setDate(3,yclosedate);
			stmtMclose.setString(4,session.getAttribute("USERID").toString());
			stmtMclose.setString(5,session.getAttribute("COMPANYID").toString());
			stmtMclose.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMclose.setString(8,"A");
			stmtMclose.setString(9,formdetailcode);
			stmtMclose.executeQuery();
			docno=stmtMclose.getInt("docNo");
			//vocno=stmtMclose.getInt("vocNo");
			//request.setAttribute("VOCNO", vocno);
			//System.out.println("----docno----"+docno);
			if(docno>0){
				//conn.commit();
				stmtMclose.close();
				conn.close();
				return docno;
			}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public int update(int docno, Date date, Date dateupto, Date yclosedate,
			HttpSession session, HttpServletRequest request,
			String formdetailcode) throws SQLException {


		Connection conn=null;
		try{
			 
			 
			conn=ClsConnection.getMyConnection();
		
			CallableStatement stmtMclose = conn.prepareCall("{call yearCloseDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtMclose.setInt(7, docno);
			stmtMclose.setDate(1,date);
			stmtMclose.setDate(2,dateupto);
			stmtMclose.setDate(3,yclosedate);
			stmtMclose.setString(4,session.getAttribute("USERID").toString());
			stmtMclose.setString(5,session.getAttribute("COMPANYID").toString());
			stmtMclose.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMclose.setString(8,"E");
			stmtMclose.setString(9,formdetailcode);
			int aaa=stmtMclose.executeUpdate();
			docno=stmtMclose.getInt("docNo");
			//vocno=stmtMclose.getInt("vocNo");
			//request.setAttribute("VOCNO", vocno);
			//System.out.println("----docno----"+docno);
			if(aaa>0){
				//conn.commit();
				stmtMclose.close();
				conn.close();
				return docno;
			}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}

	public int delete(int docno, HttpSession session,
			HttpServletRequest request, String formdetailcode) throws SQLException {
		 
		
		

		Connection conn=null;
		try{
			 
			 
			conn=ClsConnection.getMyConnection();
		
			CallableStatement stmtMclose = conn.prepareCall("{call yearCloseDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtMclose.setInt(7, docno);
			stmtMclose.setDate(1,null);
			stmtMclose.setDate(2,null);
			stmtMclose.setDate(3,null);
			stmtMclose.setString(4,session.getAttribute("USERID").toString());
			stmtMclose.setString(5,session.getAttribute("COMPANYID").toString());
			stmtMclose.setString(6,session.getAttribute("BRANCHID").toString());
			stmtMclose.setString(8,"D");
			stmtMclose.setString(9,formdetailcode);
			int aaa=stmtMclose.executeUpdate();
			docno=stmtMclose.getInt("docNo");
			//vocno=stmtMclose.getInt("vocNo");
			//request.setAttribute("VOCNO", vocno);
			//System.out.println("----docno----"+docno);
			if(aaa>0){
				//conn.commit();
				stmtMclose.close();
				conn.close();
				return docno;
			}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return 0;
	}
		
		
		
/*	public  JSONArray getSearchDetails(String branch) throws SQLException{
		Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
		conn=ClsConnection.getMyConnection();
		Statement stmtSearch=conn.createStatement(); 
			String strSql = "select doc_no,  date, ACCYR_F dateupto,ACCYR_T mclosedate,cl_stat clstat from my_year where  brhid="+branch;
			
			
			System.out.println( "------strSql-----"+strSql);
				ResultSet rsagmtno = stmtSearch.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(rsagmtno);
				stmtSearch.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		
	    return RESULTDATA;
}

	*/
	
	
	
	
	
	
	
	
 	 public  JSONArray getSearchDetails(String branch)  throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn = null;
		 try {
			  conn = ClsConnection.getMyConnection();
			 Statement stmtCost = conn.createStatement ();

				String strSql = "select doc_no,  date, ACCYR_F dateupto,ACCYR_T mclosedate,if(cl_stat=0,'yes','no') clstat from my_year where  brhid="+branch;

			 ResultSet resultSet = stmtCost.executeQuery (strSql);

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
