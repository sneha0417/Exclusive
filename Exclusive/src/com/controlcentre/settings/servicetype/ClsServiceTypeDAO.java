package com.controlcentre.settings.servicetype;

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


public class ClsServiceTypeDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	ClsServiceTypeBean activityBean=new ClsServiceTypeBean();
	public int insert(String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_servicetypeDML(?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(8,java.sql.Types.INTEGER);
			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);

			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");



			if(aaa>0)
			{
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");

					String tclsql="";
					int j=1;
					tclsql="INSERT INTO cm_proptyped(doc_no, description, sr_no) values("+aaa+","
							+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"+(i+1)+")";

					System.out.println("==tclsql===="+tclsql);

					resultSetd = stmt.executeUpdate (tclsql);
					j=j+1;
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

	public int edit(int docno,String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_servicetypeDML(?,?,?,?,?,?,?,?)}");

			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);
			stmt.setInt(8,docno);

			System.out.println("===inside edit===docno"+docno);

			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");



			if(aaa>0)
			{
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");

					String tclsql="";
					int j=1;
					tclsql="INSERT INTO cm_proptyped(doc_no, description, sr_no) values("+aaa+","
							+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"+(i+1)+")";

					System.out.println("==tclsql===="+tclsql);

					resultSetd = stmt.executeUpdate (tclsql);
					j=j+1;
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


	public int delete(int docno,String txtname,String txtdesc,ArrayList descarray,HttpSession session,java.sql.Date sqlStartDate,String mode,String formdetailcode) throws SQLException{


		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_servicetypeDML(?,?,?,?,?,?,?,?)}");

			stmt.setString(1,txtname.toUpperCase());	
			stmt.setString(2,txtdesc.toUpperCase());
			stmt.setDate  (3,sqlStartDate);
			stmt.setString(4,session.getAttribute("BRANCHID").toString());
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.setString(6,mode);
			stmt.setString(7,formdetailcode);
			stmt.setInt(8,docno);



			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");



			if(aaa>0)
			{
				
				conn.commit();
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


	public JSONArray descLoad(String docno) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			System.out.println("select  description from cm_proptyped where doc_no="+docno+"");

			ResultSet resultSet = stmt.executeQuery ("select  description from cm_proptyped where doc_no="+docno+"");


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

	public JSONArray mainSrearch(String stype) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			
			String sqltest="";
			stype=stype.trim();
			//System.out.println("===stype==="+stype);
			if(((stype.equalsIgnoreCase(""))||(stype.equalsIgnoreCase("undefined"))||(stype.equalsIgnoreCase("0"))||(stype.isEmpty()))){

				sqltest="and Name like '%"+stype+"%'";
			}
			
			System.out.println("select doc_no docno, Name stype, Description desc1,date from cm_proptypem where 1=1 "+sqltest+"");

			ResultSet resultSet = stmt.executeQuery ("select doc_no docno, Name stype, Description desc1,date from cm_proptypem where status=3 "+sqltest+"");


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
