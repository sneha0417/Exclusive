package com.controlcentre.masters.relatedmaster.tourtype;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTourDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsTourBean checkinBean = new ClsTourBean();
	Connection conn;
	
	public int insert( String name,String code,String refund, HttpSession session,String mode,String formdetailcode,int childmin,int childmax,String hghtmin,String hghtmax,String wghtmin,String wghtmax,int agemin,int agemax,String desc, String transp,int privateval) throws SQLException {
		try{
//			System.out.println("DAO");
//			System.out.println(mode);
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			// System.out.println("refund========="+refund);
			CallableStatement stmtServiceType = conn.prepareCall("{call tourtypeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtServiceType.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtServiceType.setString(1, name);
			stmtServiceType.setString(2, code);
			stmtServiceType.setString(3, refund);
			stmtServiceType.setString(4,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(5,session.getAttribute("USERID").toString());
			stmtServiceType.setString(7,mode);
			stmtServiceType.setString(8, formdetailcode);
			stmtServiceType.setInt(9, childmin);
			stmtServiceType.setInt(10, childmax);
			stmtServiceType.setDouble(11,(hghtmin.equalsIgnoreCase("undefined") || hghtmin.isEmpty()?0.0:Double.parseDouble(hghtmin)));
			stmtServiceType.setDouble(12,(hghtmax.equalsIgnoreCase("undefined") || hghtmax.isEmpty()?0.0:Double.parseDouble(hghtmax)));
			stmtServiceType.setDouble(13,(wghtmin.equalsIgnoreCase("undefined") || wghtmin.isEmpty()?0.0:Double.parseDouble(wghtmin)));
			stmtServiceType.setDouble(14,(wghtmax.equalsIgnoreCase("undefined") || wghtmax.isEmpty()?0.0:Double.parseDouble(wghtmax)));
			stmtServiceType.setDouble(15, agemin);
			stmtServiceType.setDouble(16, agemax);
			stmtServiceType.setString(17, desc);   
			stmtServiceType.setString(18, transp);
			stmtServiceType.setInt(19, privateval);                      
			stmtServiceType.executeUpdate();

			docno=stmtServiceType.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			stmtServiceType.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	return 0;
  }

	public int edit( String name,String code,String refund,HttpSession session,String mode,int docno,String formdetailcode,int childmin,int childmax,String hghtmin,String hghtmax,String wghtmin,String wghtmax,int agemin,int agemax,String desc, String transp,int privateval) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call tourtypeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtServiceType.setInt(6, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2, code);
			stmtServiceType.setString(3, refund);
			stmtServiceType.setString(4,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(5,session.getAttribute("USERID").toString());
			stmtServiceType.setString(7,"E");
			stmtServiceType.setString(8, formdetailcode);
			stmtServiceType.setInt(9, childmin);
			stmtServiceType.setInt(10, childmax);
			stmtServiceType.setDouble(11,(hghtmin.equalsIgnoreCase("undefined") || hghtmin.isEmpty()?0.0:Double.parseDouble(hghtmin)));
			stmtServiceType.setDouble(12,(hghtmax.equalsIgnoreCase("undefined") || hghtmax.isEmpty()?0.0:Double.parseDouble(hghtmax)));
			stmtServiceType.setDouble(13,(wghtmin.equalsIgnoreCase("undefined") || wghtmin.isEmpty()?0.0:Double.parseDouble(wghtmin)));
			stmtServiceType.setDouble(14,(wghtmax.equalsIgnoreCase("undefined") || wghtmax.isEmpty()?0.0:Double.parseDouble(wghtmax)));
			stmtServiceType.setDouble(15, agemin);
			stmtServiceType.setDouble(16, agemax);
			stmtServiceType.setString(17, desc);
			stmtServiceType.setString(18, transp);
			stmtServiceType.setInt(19, privateval);  
			stmtServiceType.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtServiceType.close();
				conn.close();
				return documentNo;
			}
			stmtServiceType.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	return 0;
  }


	public boolean delete( String name,String code,String refund,HttpSession session,String mode,int docno,String formdetailcode,int childmin,int childmax,String hghtmin,String hghtmax,String wghtmin,String wghtmax,int agemin,int agemax,String desc , String transp,int privateval) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call tourtypeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtServiceType.setInt(6, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2, code);
			stmtServiceType.setString(3, refund);
			stmtServiceType.setString(4,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(5,session.getAttribute("USERID").toString());
			stmtServiceType.setString(7,"D");
			stmtServiceType.setString(8, formdetailcode);
			stmtServiceType.setInt(9, childmin);
			stmtServiceType.setInt(10, childmax);
			stmtServiceType.setDouble(11,(hghtmin.equalsIgnoreCase("undefined") || hghtmin.isEmpty()?0.0:Double.parseDouble(hghtmin)));
			stmtServiceType.setDouble(12,(hghtmax.equalsIgnoreCase("undefined") || hghtmax.isEmpty()?0.0:Double.parseDouble(hghtmax)));
			stmtServiceType.setDouble(13,(wghtmin.equalsIgnoreCase("undefined") || wghtmin.isEmpty()?0.0:Double.parseDouble(wghtmin)));
			stmtServiceType.setDouble(14,(wghtmax.equalsIgnoreCase("undefined") || wghtmax.isEmpty()?0.0:Double.parseDouble(wghtmax)));
			stmtServiceType.setDouble(15, agemin);
			stmtServiceType.setDouble(16, agemax);
			stmtServiceType.setString(17, desc);
			stmtServiceType.setString(18,transp);
			stmtServiceType.setInt(19, privateval);  
			stmtServiceType.executeUpdate();

			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				return true;
			}	
			stmtServiceType.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}

	/*public  List<ClsServiceBean> list() throws SQLException {
	    List<ClsServiceBean> listBean = new ArrayList<ClsServiceBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.email,m2.description "+
				" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='CHK'");

				while (resultSet.next()) {
					
					ClsServiceBean bean = new ClsServiceBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.settechniciandate(resultSet.getString("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setEmail(resultSet.getString("email"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setHidacno(resultSet.getString("acdoc"));
					listBean.add(bean);
				}
				stmtSalesAgent.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	*/
	
	public  JSONArray getTourGrid() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();   
            	String sqldata="select wt.private,wt.childmin,wt.childmax,wt.hghtmin,wt.hghtmax,wt.wghtmin,wt.wghtmax,wt.agemin,wt.agemax,wt.description,wt.doc_no,wt.name,wt.code,if(wt.refunable=0,'No','Yes') refund,wt.refunable refundable,if(wt.transport=0,'No','Yes') transport,wt.transport transportion  from tr_tours wt where status=3";
            	System.out.println("tour=="+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
   
	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.doc_no,m.voc_no,m.dtype,termsheader terms, replace(termsfooter,',','') conditions from my_termsm m  "
					+ "left join my_termsd d on(m.doc_no=d.rdocno) where m.status=3 and d.status=3 and m.mand=1 "
					+ " and d.mand=1 and m.dtype='"+dtype+"' order by m.priority,d.priority";
//						System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public   JSONArray termsSearch(HttpSession session,String dtype,String instypeid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,voc_no,dtype,termsheader as header from my_termsm where status=3 and dtype='"+dtype+"'  order by priority ";
						//System.out.println("-----termssearch---"+sql);  

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public   JSONArray condtnSearch(HttpSession session,String dtype,String tdocno,String cond) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 



			if(!(cond.trim().equalsIgnoreCase("undefined")||cond.trim().equalsIgnoreCase("NaN")||cond.trim().equalsIgnoreCase("")|| cond.isEmpty()))
			{

				if (cond.trim().endsWith(",")) {
					cond = cond.trim().substring(0,cond.length() - 1);
				}

			}
			else{
				cond="0";
			}


			String sql="select doc_no, rdocno, replace(termsfooter,',','') as termsfooter from my_termsd "
					+ "where  dtype='"+dtype+"' and rdocno="+tdocno+"  and doc_no not in("+cond+") and status=3 order by priority";

						//System.out.println("-----condtnSearch---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray termsGridReLoad(HttpSession session,String qotdoc,String qbrhid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql1="select m.voc_no,m.dtype,termsheader terms, replace(if(conditions='0','',conditions),',','') conditions,tr.priorno from tr_prtourterms tr left join my_termsm m "
					+ "on(tr.termsid=m.voc_no) where  tr.dtype='TOUR' and tr.rdocno="+qotdoc+" and tr.brhid='"+qbrhid+"' order by tr.priorno";	
						//System.out.println("===termsGridReLoad11111111--->>>"+sql1);    
			ResultSet rs1 = stmt.executeQuery(sql1);
			//			System.out.println("=== "+rs1);
			RESULTDATA=ClsCommon.convertToJSON(rs1);
			/*if(RESULTDATA.isEmpty()){                          
				String sql2="select m.voc_no,'TOUR' dtype,termsheader terms, replace(if(conditions='0','',conditions),',','') conditions,tr.priorno from in_trterms tr left join in_termsm m "
						+ "on(tr.termsid=m.voc_no) where  tr.dtype='ENQ' and tr.rdocno="+enqdoc+" and tr.brhid='"+ebrhid+"' order by tr.priorno";
								System.out.println("===termsGridReLoad222222222--->>>"+sql2);   
				ResultSet rs2 = stmt.executeQuery(sql2); 
				RESULTDATA=ClsCommon.convertToJSON(rs2);
			}    */     

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;  
	}
	
	public int termsave(int docno,ArrayList<String> contrmtypearray,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		Connection conn=null;
//		System.out.println("in................termsave"+docno);     
		try{            
			conn=ClsConnection.getMyConnection(); 
			Statement stmt =conn.createStatement();
			String sql1="",sql2="",temp="",dtype="TOUR";
			int val=0;
			String delsql="delete from tr_prtourterms where rdocno='"+docno+"' and brhid='"+session.getAttribute("BRANCHID")+"' and dtype='"+dtype+"'";
			val=stmt.executeUpdate(delsql);
//			System.out.println(val+"delete===="+delsql);     


//			System.out.println("forloop"+contrmtypearray.size());
			for(int i=0;i< contrmtypearray.size();i++){   
//				System.out.println("in i%%"+contrmtypearray.size());
				String[] contrtypedet=((String) contrmtypearray.get(i)).split("::");   
				if(!(contrtypedet[0].trim().equalsIgnoreCase("undefined")|| contrtypedet[0].trim().equalsIgnoreCase("NaN")||contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()))
				{    		
					sql1="insert into tr_prtourterms(rdocno, termsid, conditions,priorno, status,brhid, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(contrtypedet[0].trim().equalsIgnoreCase("undefined") || contrtypedet[0].trim().equalsIgnoreCase("NaN")|| contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()?"":contrtypedet[0].trim())+"',"
							+"'"+(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"0":contrtypedet[1].trim())+"',"
							+ "'"+(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"":contrtypedet[2].trim())+"',"
							+ "'"+3+"',"
							+ "'"+session.getAttribute("BRANCHID")+"'," 
							+ "'"+dtype+"')"; 

//					System.out.println("sql111====="+sql1);        
					val=stmt.executeUpdate (sql1);
				}  

			} 
			conn.close();
			return val;     

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	
   }
