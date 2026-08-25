package com.controlcentre.settings.serviceteam;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsServiceTeamDAO {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsServiceTeamBean activityBean=new ClsServiceTeamBean();

	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
		Connection conn=null;

		JSONArray RESULTDATA1=new JSONArray();

		try {
			conn = conobj.getMyConnection();
			Statement stmtATTN = conn.createStatement();

			String sql = "";

			if(!(empid.equalsIgnoreCase(""))){
				sql=sql+" and codeno like '%"+empid+"%'";
			}
			if(!(employeename.equalsIgnoreCase(""))){
				sql=sql+" and name like '%"+employeename+"%'";
			}
			if(!(contact.equalsIgnoreCase(""))){
				sql=sql+" and pmmob like '%"+contact+"%'";
			}

			sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where status=3 "+sql;

			System.out.println("===sql===="+sql);
			
			ResultSet resultSet1 = stmtATTN.executeQuery(sql);

			RESULTDATA1=com.convertToJSON(resultSet1);

			stmtATTN.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA1;
	}

	public JSONArray userDetailsSearch(String teamusername) throws SQLException {
		Connection conn=null;

		JSONArray RESULTDATA1=new JSONArray();

		try {
			conn = conobj.getMyConnection();
			Statement stmtATTN = conn.createStatement();

			String sql = "";

			
			if(!(teamusername.equalsIgnoreCase(""))){
				sql=sql+" and user_name like '%"+teamusername+"%'";
			}
			
			sql = "select user_name,doc_no from my_user where status=3 "+sql;

			ResultSet resultSet1 = stmtATTN.executeQuery(sql);

			RESULTDATA1=com.convertToJSON(resultSet1);

			stmtATTN.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA1;
	}

	public int insert(String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode,int ismulemp,String txtteamuserlinkid) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_serviceteamDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmt.registerOutParameter(10,java.sql.Types.INTEGER);
			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);
			stmt.setInt(8,ismulemp);
			stmt.setString(9,txtteamuserlinkid);
			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			if(aaa>0)
			{
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");
					if(!((descgridarray[0].trim().equalsIgnoreCase("0"))||(descgridarray[0].trim().equalsIgnoreCase("undefined")) ||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty())){
						String tclsql="";
						int j=1;
						tclsql="INSERT INTO cm_serteamd(rdocno, empid, serteamuserlink, sr_no) values("+aaa+","
								+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"
								+ "'"+(descgridarray[1].trim().equalsIgnoreCase("undefined")||descgridarray[1]==null  || descgridarray[1].trim().equalsIgnoreCase("") || descgridarray[1].trim().equalsIgnoreCase("NaN")|| descgridarray[1].isEmpty()?"0":descgridarray[1].trim())+"',"+(i+1)+")";

						System.out.println("==tclsql===="+tclsql);

						resultSetd = stmt.executeUpdate (tclsql);
						j=j+1;
					}
					if(resultSetd<=0)
					{

						return 0; 
					}


				}
			}

			System.out.println(aaa);


		}catch(Exception e){	
			e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return aaa;
	}

	public int edit(int docno,String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode,int ismulemp,String txtteamuserlinkid) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_serviceteamDML(?,?,?,?,?,?,?,?,?,?)}");

			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);
			stmt.setInt(8,ismulemp);
			stmt.setString(9,txtteamuserlinkid);
			stmt.setInt(10,docno);
			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			if(aaa>0)
			{
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");
					if(!((descgridarray[0].trim().equalsIgnoreCase("0"))||(descgridarray[0].trim().equalsIgnoreCase("undefined")) ||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty())){


						String tclsql="";
						int j=1;
						tclsql="INSERT INTO cm_serteamd(rdocno, empid, serteamuserlink, sr_no) values("+aaa+","
								+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"
								+ "'"+(descgridarray[1].trim().equalsIgnoreCase("undefined")||descgridarray[1]==null  || descgridarray[1].trim().equalsIgnoreCase("") || descgridarray[1].trim().equalsIgnoreCase("NaN")|| descgridarray[1].isEmpty()?"0":descgridarray[1].trim())+"',"+(i+1)+")";

						System.out.println("==tclsql===="+tclsql);

						resultSetd = stmt.executeUpdate (tclsql);
						j=j+1;

					}
					if(resultSetd<=0)
					{

						return 0; 
					}


				}
			}

			System.out.println(aaa);


		}catch(Exception e){	
			e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return aaa;
	}


	public int delete(int docno,String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode,int ismulemp,String txtteamuserlinkid) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_serviceteamDML(?,?,?,?,?,?,?,?,?,?)}");

			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);
			stmt.setInt(8,ismulemp);
			stmt.setString(9,txtteamuserlinkid);
			stmt.setInt(10,docno);
			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");


		}catch(Exception e){	
			e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return aaa;
	}

	public JSONArray descLoad(String docno,HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTeamBean> listBean = new ArrayList<ClsServiceTeamBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			//System.out.println("select empid,name as empname,codeno as empcode from cm_serteamd d left join hr_empm e on(d.empid=e.doc_no) where d.rdocno="+docno+"");

			ResultSet resultSet = stmt.executeQuery ("select d.empid,name as empname,codeno as empcode,d.serteamuserlink teamuserlinkid,u.user_name teamuserlinkname from cm_serteamd d left join hr_empm e on(d.empid=e.doc_no) left join my_user u on u.doc_no=d.serteamuserlink where d.rdocno="+docno+"");


			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray mainSrearch(String grpcode) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTeamBean> listBean = new ArrayList<ClsServiceTeamBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			String sqltest="";
			grpcode=grpcode.trim();
			//System.out.println("===grpcode==="+grpcode);
			if(((grpcode.equalsIgnoreCase(""))||(grpcode.equalsIgnoreCase("undefined"))||(grpcode.equalsIgnoreCase("0"))||(grpcode.isEmpty()))){

				sqltest="and m.grpcode like '%"+grpcode+"%'";
			}

			ResultSet resultSet = stmt.executeQuery ("select m.grpcode,m.description desc1,m.doc_no docno,m.ismulemp,m.serteamuserlink teamuserlinkid,u.user_name teamuserlinkname from cm_serteamm m left join my_user u on u.doc_no=m.serteamuserlink where m.status=3 "+sqltest+"");


			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}

}
