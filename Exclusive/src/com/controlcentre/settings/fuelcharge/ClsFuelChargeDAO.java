package com.controlcentre.settings.fuelcharge;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;



public class ClsFuelChargeDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	Connection conn;
	public int insert(Date masterdate, Date fromdate, Date todate, double petrol, double deisel, HttpSession session,String formcode) throws SQLException {
		conn=ClsConnection.getMyConnection();
		
		try
		{
		int docno=0;	
		Statement stmt = conn.createStatement();	

		String sql1="select coalesce((max(doc_no)+1),1) docno from gl_fuelcharge"; 
		ResultSet rs = stmt.executeQuery(sql1);
		
		if(rs.next())
		{
		docno=rs.getInt("docno");
			
		}
		String upsql1="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','"+formcode+"',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		int aaaa=stmt.executeUpdate(upsql1);	
		
		if(aaaa<0)
		{
			
 			conn.close();
			return 0;
		}
		
		String upsql="insert into gl_fuelcharge(doc_no, date, frmdate, todate, userid, brchid, ptlchg, deslchg,status) values ('"+docno+"','"+masterdate+"','"+fromdate+"','"+todate+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+petrol+"','"+deisel+"',3)";
			
		int aaa=stmt.executeUpdate(upsql);	
			
		if(aaa>0)
		{
			stmt.close();
 			conn.close();
			return docno;
		}
		
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}

	
	 public  JSONArray masterSearch() throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
		 Connection conn = null;
			try {
				 
					 conn = ClsConnection.getMyConnection();
				Statement stmtUser =conn.createStatement();            	
				String resql=("select doc_no,date,frmdate,todate,ptlchg,deslchg from gl_fuelcharge");
				//System.out.println("resql"+resql);
		
				ResultSet resultSet = stmtUser.executeQuery(resql); 
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtUser.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
	
}
