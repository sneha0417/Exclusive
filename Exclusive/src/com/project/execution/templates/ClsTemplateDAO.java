package com.project.execution.templates;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.google.common.base.Equivalence;

import net.sf.json.JSONArray;

public class ClsTemplateDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();

	public JSONArray projectSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname project,codeno,doc_no pdocno from my_groupvals where grptype='project' and status=3";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);
			

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray sectionSearch(HttpSession session) throws Exception{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			int i=1;
			String sql = "";

			sql="select groupname section,codeno,doc_no sdocno from my_groupvals where grptype='section' and status=3";
            
			ResultSet resultSet1 = stmt.executeQuery(sql);

			RESULTDATA1=com.convertToJSON(resultSet1);
		

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;

			String brcid=session.getAttribute("BRANCHID").toString();
			
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";

			
			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";
			*/

			System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray lchrgeSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="SELECT doc_no docno,name,code,rate FROM cm_chrgm c where status=3 and dtype='lcm'";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}




	public JSONArray echrgeSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="SELECT doc_no docno,name,code,rate FROM cm_chrgm c where status=3 and dtype='ecm'";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public int insert(java.sql.Date date,String txtrefno,int txtprojectid,int txtsectionid,String txtactivity,String txtdescription,String txtnettotal,String formcode,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,HttpSession session,HttpServletRequest request){


		Connection conn=null;
		int docNo=0;
		int vocno=0;

		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_TemplateDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3,txtprojectid);
			stmt.setInt(4, txtsectionid);
			stmt.setString(5,txtactivity);
			stmt.setString(6,txtdescription);
			stmt.setString(7,txtnettotal);
			stmt.setString(8,mode);
			stmt.setString(9,formcode);
			stmt.setString(10, session.getAttribute("BRANCHID").toString());
			stmt.setString(11, session.getAttribute("USERID").toString());

			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");
					if(!(arrayDet[4].trim().equalsIgnoreCase("undefined")|| arrayDet[4].trim().equalsIgnoreCase("NaN")||arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()))
					{

						//SpecNo					

						String sql="INSERT INTO cm_mprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"')";

						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< lablist.size();i++){


					String[] arrayDet=((String) lablist.get(i)).split("::");
					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{


						String sql="INSERT INTO cm_mprlabour(tr_no, SR_NO,othid,description,lblhours,lblmins, rateHr, total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< equplist.size();i++){


					String[] arrayDet=((String) equplist.get(i)).split("::");
					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{


						String sql="INSERT INTO cm_mprmachine(tr_no, SR_NO,assetid,description,lblhours,lblmins, rateHr, total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+2)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						System.out.println("==equplist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return vocno;

	}


	public int edit(int docNo,String vocno,java.sql.Date date,String txtrefno,int txtprojectid,int txtsectionid,String txtactivity,String txtdescription,String txtnettotal,String formcode,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,HttpSession session,HttpServletRequest request){


		Connection conn=null;


		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_TemplateDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3,txtprojectid);
			stmt.setInt(4, txtsectionid);
			stmt.setString(5,txtactivity);
			stmt.setString(6,txtdescription);
			stmt.setString(7,txtnettotal);
			stmt.setString(8,mode);
			stmt.setString(9,formcode);
			stmt.setString(10, session.getAttribute("BRANCHID").toString());
			stmt.setString(11, session.getAttribute("USERID").toString());
			stmt.setInt(12, docNo);
			stmt.setString(13,vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getString("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");
					if(!(arrayDet[4].trim().equalsIgnoreCase("undefined")|| arrayDet[4].trim().equalsIgnoreCase("NaN")||arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()))
					{

						//SpecNo					

						String sql="INSERT INTO cm_mprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"')";

						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< lablist.size();i++){


					String[] arrayDet=((String) lablist.get(i)).split("::");
					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{


						String sql="INSERT INTO cm_mprlabour(tr_no, SR_NO,othid,description,lblhours,lblmins, rateHr, total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< equplist.size();i++){


					String[] arrayDet=((String) equplist.get(i)).split("::");
					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{


						String sql="INSERT INTO cm_mprmachine(tr_no, SR_NO,assetid,description,lblhours,lblmins, rateHr, total, profitPer, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+2)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						System.out.println("==equplist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return Integer.parseInt(vocno);

	}
	

	public int delete(int docNo,String vocno,java.sql.Date date,String txtrefno,int txtprojectid,int txtsectionid,String txtactivity,String txtdescription,String txtnettotal,String formcode,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,HttpSession session,HttpServletRequest request){


		Connection conn=null;


		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_TemplateDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3,txtprojectid);
			stmt.setInt(4, txtsectionid);
			stmt.setString(5,txtactivity);
			stmt.setString(6,txtdescription);
			stmt.setString(7,txtnettotal);
			stmt.setString(8,mode);
			stmt.setString(9,formcode);
			stmt.setString(10, session.getAttribute("BRANCHID").toString());
			stmt.setString(11, session.getAttribute("USERID").toString());
			stmt.setInt(12, docNo);
			stmt.setString(13,vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getString("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return Integer.parseInt(vocno);

	}




	public JSONArray materialGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno from cm_mprdd d left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join my_unitm u on m.munit=u.doc_no  where tr_no="+trno+"";


			System.out.println("===materialGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray labourGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select tr_no,othid docno,s.code as codeno,s.name as desc1, rateHr rate,l.description, total total1, profitPer margin1, NetTotal netotal1, "
					+ "lblhours hrs, lblmins min from cm_mprlabour l left join cm_chrgm s on(s.doc_no=l.othid) where l.tr_no="+trno+"";


			System.out.println("===labourGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public JSONArray equipmentGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select tr_no,assetid docno,s.code as codeno,s.name as desc2, rateHr rate2,m.description, total total2, profitPer margin2, NetTotal netotal2, lblhours hrs2, lblmins min2 from cm_mprmachine m "
					+ "left join cm_chrgm s on(s.doc_no=m.assetid) where m.tr_no="+trno+"";

			System.out.println("===equipmentGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_project,String Cl_section,String Cl_activity,int id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		String sqltest="";

		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_project.equalsIgnoreCase("undefined"))&&!(Cl_project.equalsIgnoreCase(""))&&!(Cl_project.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and p.groupname like '%"+Cl_project+"%'";
		}
		if(!(Cl_section.equalsIgnoreCase("undefined"))&&!(Cl_section.equalsIgnoreCase(""))&&!(Cl_section.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and s.groupname like '%"+Cl_section+"%'";
		}
		if(!(Cl_activity.equalsIgnoreCase("undefined"))&&!(Cl_activity.equalsIgnoreCase(""))&&!(Cl_activity.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.jobtype like '%"+Cl_activity+"%'";
		}


		Connection conn = null;

		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

		if(id>0){
			String str1Sql=("select m.date,m.doc_no,m.tr_no,m.jobtype as activity,p.groupname as project,cgroup as projectid,s.groupname as section,"
					+ "cdivision as sectionid,m.description,coalesce(round(m.netotal,2),0.00) as total,coalesce(refno,'') as refno from cm_prjmaster m left join my_groupvals p on(m.cgroup= p.doc_no and p.grptype='project') "
					+ "left join my_groupvals s on(m.cdivision=s.doc_no and s.grptype='section') where m.status<>7  "+sqltest+"");


			//System.out.println("==refmainsearch==="+str1Sql);

			ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}




}
