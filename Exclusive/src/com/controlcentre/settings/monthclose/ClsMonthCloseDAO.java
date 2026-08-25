package com.controlcentre.settings.monthclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityBean;
import com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityDAO;

public class ClsMonthCloseDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date date, Date dateupto, Date mclosedate,
			HttpSession session, String brchName, HttpServletRequest request,String mode,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int docno=0;
			int vocno=0;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			java.sql.Date sqldate = null;
			String stdate= session.getAttribute("STYEAR").toString();
			if(!(stdate.equalsIgnoreCase("undefined"))&&!(stdate.equalsIgnoreCase(""))&&!(stdate.equalsIgnoreCase("0")))
	     	{
	     		sqldate=ClsCommon.changeStringtoSqlDate2(stdate);
	     	}
			CallableStatement stmtMclose = conn.prepareCall("{call monthCloseDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtMclose.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtMclose.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtMclose.setDate(1,date);
			stmtMclose.setDate(2,dateupto);
			stmtMclose.setDate(3, mclosedate);
			stmtMclose.setString(4, session.getAttribute("USERID").toString());
			stmtMclose.setString(5, brchName);
			stmtMclose.setString(8, mode);
			stmtMclose.setString(9, formdetailcode);
			stmtMclose.setDate(10,sqldate); 
			stmtMclose.executeQuery();
			docno=stmtMclose.getInt("docNo");
			vocno=stmtMclose.getInt("vocNo");
			request.setAttribute("VOCNO", vocno);
			if(docno>0){
				conn.commit();
				stmtMclose.close();
				conn.close();
				return docno;
			}
			else{
				stmtMclose.close();
				conn.close();
				return 0;
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

	public boolean delete(Date date, Date dateupto, Date mclosedate,
			HttpSession session, String brchName, HttpServletRequest request,
			String mode, String formdetailcode, int docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			java.sql.Date sqldate = null;
			String stdate= session.getAttribute("STYEAR").toString();
			if(!(stdate.equalsIgnoreCase("undefined"))&&!(stdate.equalsIgnoreCase(""))&&!(stdate.equalsIgnoreCase("0")))
	     	{
	     		sqldate=ClsCommon.changeStringtoSqlDate2(stdate);
	     	}
			//System.out.println("date--->>>"+sqldate);
			CallableStatement stmtMclose = conn.prepareCall("{call monthCloseDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtMclose.setInt(6, docno);
			stmtMclose.setInt(7, 0);
			stmtMclose.setDate(1,date);
			stmtMclose.setDate(2,dateupto);
			stmtMclose.setDate(3, mclosedate);
			stmtMclose.setString(4, session.getAttribute("USERID").toString());
			stmtMclose.setString(5, brchName);
			stmtMclose.setString(8, mode);
			stmtMclose.setString(9, formdetailcode);
			stmtMclose.setDate(10,sqldate);     
			int val=stmtMclose.executeUpdate();   
			
			
			if(val>0){
				conn.commit();
				stmtMclose.close();
				conn.close();
				return true;
			}
			else{
				stmtMclose.close();
				conn.close();
				return false;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}

	
	public  JSONArray getSearchDetails(String branch) throws SQLException{
		Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
		conn=ClsConnection.getMyConnection();
		Statement stmtSearch=conn.createStatement();
		
			JSONArray jsonArray = new JSONArray();
			 String strSql = "select doc_no, voc_no, date, dateupto, mclosedate from my_monthclose where status=3 and brhid="+branch;
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

	public int checkDeleteStatus(int docno, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int deletecheck=0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmtdelete=conn.createStatement();
			String strdelete="select if(max(doc_no)="+docno+",1,0) check1 from my_monthclose where status=3 and brhid="+brchName;
//			System.out.println(strdelete);
			ResultSet rsdelete=stmtdelete.executeQuery(strdelete);
			
			while(rsdelete.next()){
				deletecheck=rsdelete.getInt("check1");
			}
		stmtdelete.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return deletecheck;
	}
}