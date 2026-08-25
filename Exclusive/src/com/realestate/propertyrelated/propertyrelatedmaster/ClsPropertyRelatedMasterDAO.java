package com.realestate.propertyrelated.propertyrelatedmaster;

import java.sql.Date;

import com.connection.*;
import com.common.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsPropertyRelatedMasterDAO {
	Connection c = null;
	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();

	public int saveBuilding(Date masterdate, int docno, String mode,
			int txtareaid, String name, String plotnumber,ArrayList<String> aar,HttpSession session,HttpServletRequest request,String fcode) throws SQLException {
		  
		try
		{
			 c=ClsConnection.getMyConnection();
		    c.setAutoCommit(false);
          CallableStatement s = c.prepareCall("{CALL rl_BuildingDML(?,?,?,?,?,?,?,?,?,?)}");
          
          System.out.println("=mode=="+mode);
          
          System.out.println("=array=="+aar);
          
			if(mode.equalsIgnoreCase("A"))
			{
				s.registerOutParameter(10,java.sql.Types.INTEGER);
			}
			
			else
			{
				s.setInt(10,docno);
			}
			
			
		 	s.setDate(1,masterdate);
			s.setString(2,name);
			s.setString(3,plotnumber);
			s.setInt(4,txtareaid);
			s.setString(5,session.getAttribute("BRANCHID").toString());
			s.setString(6,session.getAttribute("USERID").toString());
			s.setString(7, session.getAttribute("COMPANYID").toString());
			s.setString(8,mode);
			s.setString(9,fcode);
			
			int val = s.executeUpdate();
			
			int doc=s.getInt("docNo");
			
			if(mode.equalsIgnoreCase("E"))
			{
			
			if(val>0 && doc>0){
				
				for(int i=0;i< aar.size();i++){
					
					if(i==0 && mode.equalsIgnoreCase("E"))
					{
						String sqls="delete from rl_buildingd where rdocno="+doc+"  ";
						s.executeUpdate(sqls);          
					}
					
					String[] ar=((String) aar.get(i)).split("::");
					 
					if(!(ar[0].trim().equalsIgnoreCase("undefined") || ar[0].trim().equalsIgnoreCase("") || ar[0].trim().equalsIgnoreCase("NaN")|| ar[0].isEmpty())){
						
						
						String sql="insert into rl_buildingd(rdocno,slno,name, mob, remarks)values"
								+ "("+doc+","+i+","
								+ "'"+(ar[0].trim().equalsIgnoreCase("undefined") || ar[0].trim().equalsIgnoreCase("") || ar[0].trim().equalsIgnoreCase("NaN")|| ar[0].isEmpty()?0:ar[0].trim())+"',"
								+ "'"+(ar[1].trim().equalsIgnoreCase("undefined") || ar[1].trim().equalsIgnoreCase("") || ar[1].trim().equalsIgnoreCase("NaN")|| ar[1].isEmpty()?0:ar[1].trim())+"',"
								+ "'"+(ar[2].trim().equalsIgnoreCase("undefined") || ar[2].trim().equalsIgnoreCase("") || ar[2].trim().equalsIgnoreCase("NaN")|| ar[2].isEmpty()?0:ar[2].trim())+"' ) ";
					 
						int aa=s.executeUpdate(sql);
						if(aa<=0)
						{
							c.close();
							return 0; 
							}
						
					}
				}
				
			}
			
		} 
			if(val>0  && doc>0)
			{
				c.commit();
				c.close();
				return doc;
				
			}
			
			if( mode.equalsIgnoreCase("D"))
			{
				String sql1="delete from rl_buildingd where rdocno="+doc+"  ";
				int re=s.executeUpdate(sql1);
				if(re<=0)
				{
					c.close(); 
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			c.close();
		}
		
		
		
		return 0;
	}

	public JSONArray maingridreload(String doc) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String pySql = (" select   name, mob, remarks  from rl_buildingd where rdocno='"
					+ doc + "' ");

			ResultSet resultSet = stmt.executeQuery(pySql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray Load(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name, "
					+ " m.doc_no, m.name, m.plno,   m.date from rl_buildingm m "
					+ " left join    my_area a on m.area=a.doc_no inner join my_acity c on(a.city_id=c.doc_no) "
					+ " left join my_acountry ac on(ac.doc_no=c.country_id) "
					+ "left join my_aregion r on(r.doc_no=ac.reg_id)where m.status=3 ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public int saveT(Date masterdate, int docno, String mode, String ptmtype,
			String pcode, HttpSession session, HttpServletRequest request,
			String formdetailcode) throws SQLException {

		c = ClsConnection.getMyConnection();
		c.setAutoCommit(false);
		CallableStatement s = c
				.prepareCall("{CALL rl_PropertytypeDML(?,?,?,?,?,?,?,?,?,?)}");

		System.out.println("=mode==" + mode);
		try {
			if (mode.equalsIgnoreCase("A")) {
				s.registerOutParameter(10, java.sql.Types.INTEGER);
			}

			else {
				s.setInt(10, docno);
			}

			s.setDate(1, masterdate);
			s.setString(2, pcode);
			s.setString(3, ptmtype);
			s.setInt(4, 0);
			s.setString(5, session.getAttribute("BRANCHID").toString());
			s.setString(6, session.getAttribute("USERID").toString());
			s.setString(7, session.getAttribute("COMPANYID").toString());
			s.setString(8, mode);
			s.setString(9, formdetailcode);

			int val = s.executeUpdate();

			docno = s.getInt("docNo");

			if (val > 0 && docno > 0) {
				c.commit();
				c.close();
				return docno;

			}

		} catch (Exception e) {
			e.printStackTrace();
			c.close();
		}

		return docno;
	}

	public JSONArray prdtypeLoad(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select doc_no, code, prtype, cmpid, userid, brhid, status, date  from rl_propertytype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray searchptypr() throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();

			String pySql = (" select  prtype,doc_no FROM rl_propertytype where status=3 ");
			// System.out.println("=====pySql========"+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray searchunitm() throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();

			String pySql = (" SELECT u.doc_no, u.date, u.prtype prtypeid,p.prtype, unittype  from rl_unittype u left join "
					+ " rl_propertytype p on p.doc_no=u.prtype where u.status=3 ");

			// System.out.println("=====pySql========"+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public int saveU(Date masterdate, int docno, String mode, int prtypeid,
			String unit, HttpSession session, HttpServletRequest request,
			String formdetailcode) throws SQLException {

		c = ClsConnection.getMyConnection();
		c.setAutoCommit(false);
		CallableStatement s = c
				.prepareCall("{CALL rl_unittypeDML(?,?,?,?,?,?,?,?,?,?)}");

		System.out.println("=mode==" + mode);
		try {
			if (mode.equalsIgnoreCase("A")) {
				s.registerOutParameter(10, java.sql.Types.INTEGER);
			}

			else {
				s.setInt(10, docno);
			}

			s.setDate(1, masterdate);
			s.setInt(2, prtypeid);
			s.setString(3, unit);
			s.setInt(4, 0);
			s.setString(5, session.getAttribute("BRANCHID").toString());
			s.setString(6, session.getAttribute("USERID").toString());
			s.setString(7, session.getAttribute("COMPANYID").toString());
			s.setString(8, mode);
			s.setString(9, formdetailcode);

			int val = s.executeUpdate();
			docno = s.getInt("docNo");

			if (val > 0 && docno > 0) {
				c.commit();
				c.close();
				return docno;
			}

		} catch (Exception e) {
			e.printStackTrace();
			c.close();
		}
		return docno;
	}

}
