package com.realestate.furniturefixtures;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.product.ClsProductBean;

public class ClsFurnitureFixturesDAO {
	ClsProductBean proact = new ClsProductBean();
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	
	public JSONArray roomMainLoad(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();  
			 String sql = "select doc_no,rdesc1,'' selectroom from re_mroom";
			 
			System.out.println("room query="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	

	public JSONArray roomLoad(HttpSession session,int pdocno) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql = "select doc_no,rdesc1,'' selectroom from re_mroom";
			String sql="select doc_no,rdesc1,if(tick>0,true,false) chk,pdoc_no from(SELECT r.doc_no,r.rdesc1,p.doc_no tick,p.pdoc_no FROM re_proomfurnfix p left join re_mroom r on r.doc_no=p.rdoc_no where p.pdoc_no="+pdocno+" "
					+ " union all select doc_no, rdesc1,0 tick,0 pdoc_no from re_mroom)a group by a.doc_no;";		
			
			System.out.println("room query="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray furnitureLoadByRoomID(HttpSession session, String rdocno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT fdesc1,sr_no,doc_no FROM re_mfurnfix r where r.ftype=1 and r.rdoc_no='"+rdocno+"'";
			//System.out.println("sql--->>>"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray InspectionLoadByRoomID(HttpSession session, String rdocno)
			throws SQLException {
 
		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT fdesc1,sr_no,doc_no FROM re_mfurnfix r where r.ftype=0 and r.rdoc_no='"+rdocno+"'";
 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public int insert(Connection conn, int docno,String roomdesc,
			ArrayList<String> furniturearray,
			ArrayList<String> inspectionarray, HttpSession session,
			HttpServletRequest request, String mode) throws SQLException {   
 
		
		try {
			Statement stmt = conn.createStatement();

			    if(docno==0){
			    	String sqlget="select max(doc_no)+1 doc_no from re_mroom";   
			    	ResultSet rs = stmt.executeQuery(sqlget);   
			    	while(rs.next()){
			    		docno=rs.getInt("doc_no");     
			    	}
			    	String sql="insert into re_mroom(doc_no,rdesc1) values('"+docno+"','"+roomdesc+"')";           
			    	int val = stmt.executeUpdate(sql);
			    	if (val <= 0) {     
						stmt.close();    
						conn.close();
						return 0;
					}
			    	
			    }
				// save Furnituregrid
				for (int i = 0; i < furniturearray.size(); i++) {   
					String[] farray = furniturearray.get(i).split("::"); 
					int frowno=farray[1].trim().equalsIgnoreCase("undefined") || farray[1].trim().equalsIgnoreCase("NaN")|| farray[1].trim().equalsIgnoreCase("")|| farray[1].isEmpty()?0:Integer.parseInt(farray[1].trim());
					String furdesc=farray[0].trim().equalsIgnoreCase("undefined") || farray[0].trim().equalsIgnoreCase("NaN")|| farray[0].isEmpty()?"":farray[0].trim();   
					if (!farray[0].trim().equalsIgnoreCase("undefined") && !farray[0].trim().equalsIgnoreCase("NaN")  && !farray[0].trim().equalsIgnoreCase("")) {
						if(frowno>0){    
							String sqlfurupdate = "update re_mfurnfix set fdesc1='"+furdesc+"' where doc_no='"+frowno+"'";    
							//System.out.println("sqlfurupdate--->>>"+sqlfurupdate);
							int res = stmt.executeUpdate(sqlfurupdate);                  
							if (res <= 0) {     
								stmt.close();    
								conn.close();
								return 0;
							}
						}else{     
							String sqlfurinsert = "insert into re_mfurnfix (rdoc_no, sr_no, fdesc1, ftype) values ('"+docno+"','"+(i+1)+"','"+furdesc+"','1')";
							//System.out.println("sqlfurinsert--->>>"+sqlfurinsert);    
							int re = stmt.executeUpdate(sqlfurinsert);
							if (re <= 0) {
								stmt.close();
								conn.close();
								return 0;
							}     
						}
					}
				}

				// save Inspectiongrid
				for (int i = 0; i < inspectionarray.size(); i++) {
					String[] iarray = inspectionarray.get(i).split("::"); 
					int irowno=iarray[1].trim().equalsIgnoreCase("undefined") || iarray[1].trim().equalsIgnoreCase("NaN")|| iarray[1].trim().equalsIgnoreCase("")|| iarray[1].isEmpty()?0:Integer.parseInt(iarray[1].trim());
					String insdesc=iarray[0].trim().equalsIgnoreCase("undefined") || iarray[0].trim().equalsIgnoreCase("NaN")|| iarray[0].isEmpty()?"":iarray[0].trim();   
					if (!iarray[0].trim().equalsIgnoreCase("undefined") && !iarray[0].trim().equalsIgnoreCase("NaN")  && !iarray[0].trim().equalsIgnoreCase("")) {
						if(irowno>0){    
							String sqlinsupdate = "update re_mfurnfix set fdesc1='"+insdesc+"' where doc_no='"+irowno+"'";    
							int res = stmt.executeUpdate(sqlinsupdate);                  
							if (res <= 0) {     
								stmt.close();    
								conn.close();
								return 0;
							}
						}else{     
							String sqlinsinsert = ("insert into re_mfurnfix (rdoc_no, sr_no, fdesc1, ftype) values ('"+docno+"','"+(i+1)+"','"+insdesc+"','0')");
							int re = stmt.executeUpdate(sqlinsinsert);
							if (re <= 0) {
								stmt.close();   
								conn.close();
								return 0;
							}     
						}
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return 1;
	}

}
