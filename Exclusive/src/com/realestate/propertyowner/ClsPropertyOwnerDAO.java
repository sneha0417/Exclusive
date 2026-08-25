package com.realestate.propertyowner;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.nipurchase.suppliers.ClsVendorDetailsBean;
import com.finance.nipurchase.suppliers.ClsVendorDetailsDAO;
import com.operations.clientrelations.clientcategory.ClsClientCategoryBean;

public class ClsPropertyOwnerDAO {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon commonDAO = new ClsCommon();
	ClsPropertyOwnerBean propertyOwnerBean = new ClsPropertyOwnerBean();  
	ClsVendorDetailsDAO vendorDetailsDAO = new ClsVendorDetailsDAO();
	Connection conn = null;

	public int insert(Date Date, String ejarino, String primeowner,
			String coowner1, String coowner2, Date birthdate, String address,
			String telephn, String mobile, String email, String passport,
			String issuedplce, Date expiry, int natid, String bankname,
			String accountno, String accountname, String bankaddress,
			String Bankcountry, String bankswift, String bankiban,
			String bankremarks, String formdetailcode, String cmbcurrency,
			String specialinstructions, String telephone2, String mobile2,
			String email2, String aliasname, int OwnerId,ArrayList<String> bankaccarray,ArrayList<String> splarray, HttpSession session,
			HttpServletRequest request) throws SQLException {
		System.out.println(Date);
		Connection conn = null;

		
		System.out.println("grid array ===" + bankaccarray);  
		try {
			conn = connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String company = session.getAttribute("COMPANYID").toString().trim();
			String branch = session.getAttribute("BRANCHID").toString().trim();
			String currency = session.getAttribute("CURRENCYID").toString().trim();
			String userid = session.getAttribute("USERID").toString().trim();
			Statement stmtss = conn.createStatement();
			CallableStatement stmtPOW = conn.prepareCall("{CALL propertyownerDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtPOW.registerOutParameter(28, java.sql.Types.INTEGER);
			stmtPOW.registerOutParameter(29, java.sql.Types.INTEGER);
			stmtPOW.setDate(1, Date);
			stmtPOW.setString(2, ejarino);
			stmtPOW.setString(3, primeowner);
			stmtPOW.setString(4, coowner1);

			stmtPOW.setString(5, coowner2);
			stmtPOW.setDate(6, birthdate);
			stmtPOW.setString(7, address);
			stmtPOW.setString(8, telephn);

			stmtPOW.setString(9, mobile);
			stmtPOW.setString(10, email);
			stmtPOW.setString(11, passport);
			stmtPOW.setString(12, issuedplce);
			stmtPOW.setDate(13, expiry);
			stmtPOW.setInt(14, natid);
			stmtPOW.setString(15, bankname);
			stmtPOW.setString(16, accountno);
			stmtPOW.setString(17, accountname);
			stmtPOW.setString(18, bankaddress);
			stmtPOW.setString(19, Bankcountry);
			stmtPOW.setString(20, bankswift);
			stmtPOW.setString(21, bankiban);
			stmtPOW.setString(22, bankremarks);
			stmtPOW.setString(23, formdetailcode);
			stmtPOW.setString(24, currency);
			stmtPOW.setString(25, branch);
			stmtPOW.setString(26, userid);
			stmtPOW.setString(27, "A");

			// Added by saranya on 17/11/2019
			stmtPOW.setString(30, aliasname);
			stmtPOW.setString(31, specialinstructions);
			stmtPOW.setString(32, telephone2);
			stmtPOW.setString(33, mobile2);
			stmtPOW.setString(34, email2);
			stmtPOW.setInt(35, OwnerId);

			stmtPOW.executeQuery();
			int docno = stmtPOW.getInt("docNo");
			int vocNo = stmtPOW.getInt("vocNo");

			request.setAttribute("vocNo", vocNo);
			// int accountno=stmtPOW.getInt("documentNo");
			// request.setAttribute("acno", accountno);

			if (docno > 0) {
				
				/* bank acc det grid Saving */
				for (int j = 0; j < bankaccarray.size(); j++) {
					String[] spl = bankaccarray.get(j).split("::");
					if (!spl[1].trim().equalsIgnoreCase("undefined")
							&& !spl[1].trim().equalsIgnoreCase("NaN")) {

						CallableStatement s1 = conn.prepareCall("{CALL rl_ownerbankdetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						 
						s1.setInt(2, docno);
						
						int docn = Integer.parseInt(spl[0].equalsIgnoreCase("")|| spl[0].equalsIgnoreCase("undefined")|| spl[0] == null ? "0" : spl[0]);
						s1.setInt(1, docn);   
						s1.setString(3,(spl[1].trim().equalsIgnoreCase("undefined")|| spl[1].trim().equalsIgnoreCase("NaN")|| spl[1].trim().isEmpty() ? 0 : spl[1].trim()).toString()); 
						s1.setString(4, spl[2].trim().equalsIgnoreCase("undefined")  || spl[2].trim().equalsIgnoreCase("NaN") || spl[2].trim().isEmpty() ? "0" : spl[2].trim().toString());
						s1.setString(5, spl[3].trim().equalsIgnoreCase("undefined")  || spl[3].trim().equalsIgnoreCase("NaN") || spl[3].trim().isEmpty() ? "0" : spl[3].trim().toString());
						s1.setString(6, spl[4].trim().equalsIgnoreCase("undefined")  || spl[4].trim().equalsIgnoreCase("NaN") || spl[4].trim().isEmpty() ? "0" : spl[4].trim().toString());
						
						int cntryid=Integer.parseInt(spl[5].equalsIgnoreCase("")|| spl[5].equalsIgnoreCase("undefined")|| spl[5] == null ? "0" : spl[5]);
						s1.setInt(7,cntryid);
						
						int currid=Integer.parseInt(spl[6].equalsIgnoreCase("")|| spl[6].equalsIgnoreCase("undefined")|| spl[6] == null ? "0" : spl[6]);
						s1.setInt(8,currid);
						 
						s1.setString(9, spl[7].trim().equalsIgnoreCase("undefined")  || spl[7].trim().equalsIgnoreCase("NaN") || spl[7].trim().isEmpty() ? "0" : spl[7].trim().toString());
						s1.setString(10, spl[8].trim().equalsIgnoreCase("undefined") || spl[8].trim().equalsIgnoreCase("NaN") || spl[8].trim().isEmpty() ? "0" : spl[
						8].trim().toString());
						s1.setString(11, spl[9].trim().equalsIgnoreCase("undefined") || spl[9].trim().equalsIgnoreCase("NaN") || spl[9].trim().isEmpty() ? "0" : spl[9].trim().toString());
						
						int defaultacc=Integer.parseInt(spl[10].equalsIgnoreCase("")|| spl[10].equalsIgnoreCase("undefined")|| spl[10] == null ? "0" : spl[10]);
						s1.setInt(12,defaultacc);
						
						s1.setString(13, "A");
						 
						int splinschk = s1.executeUpdate();
						
						if (splinschk <= 0) {
							s1.close();
							return 0;
						}
						s1.close();
					}
				}
				/* bank acc det Grid Saving Ends */    
				
				for(int i=0;i< splarray.size();i++){

					String[] enqser=splarray.get(i).split("::");   
					//int refdocno=enqser[0].trim().equalsIgnoreCase("undefined") || enqser[0].trim().equalsIgnoreCase("NaN")|| enqser[0].trim().equalsIgnoreCase("")|| enqser[0].isEmpty()?0:Integer.parseInt(enqser[0].trim());       
					if(!(enqser[1].trim().equalsIgnoreCase("undefined")|| enqser[1].trim().equalsIgnoreCase("NaN")||enqser[1].trim().equalsIgnoreCase("")|| enqser[1].isEmpty()))
					{   
						String sql="insert into re_ownersplins (remarks, srno, rdocno) values ("       
								+ "'"+(enqser[1].trim().equalsIgnoreCase("undefined") || enqser[1].trim().equalsIgnoreCase("NaN")|| enqser[1].trim().equalsIgnoreCase("")|| enqser[1].isEmpty()?"":enqser[1].trim())+"',"
								+ (i+1)+","                
								+ "'"+docno+"')";                      
					    //System.out.println("==="+sql);	            
						int val1 = stmtss.executeUpdate (sql);       
						if(val1<=0)   
						{
							conn.close();    
							return 0;
						}	
					}
				}
				/*	int catm = 1;
				int accgrp = 0;

				String sqls = "select doc_no,acc_group accgrp  from my_clcatm where status=3 and dtype='VND' and tenant=1 "
						+ " union all select doc_no,acc_group  accgrp  from my_clcatm where status=3 and dtype='VND'  limit 1 ";

				ResultSet rss = stmtPOW.executeQuery(sqls);
				if (rss.first()) {
					catm = rss.getInt("doc_no");
					accgrp = rss.getInt("accgrp");
				}

				int val = vendorDetailsDAO.insert(Date, "VND", primeowner, ""
						+ currency, "" + catm, "" + 1, "" + 0, "" + accgrp,
						"" + 0, 0, 0, 0, address, "", telephn, mobile, telephn,
						"" + 0, email, coowner1, "" + 0, session, request);

				String acno = request.getAttribute("acno").toString();
				
				request.setAttribute("acno", acno);             
 
				String sqls1 = "update rl_propertryowner set acno='" + acno
						+ "' where doc_no='" + docno + "' ";
				stmtPOW.executeUpdate(sqls1);

				if (val > 0) {
					conn.commit();
					stmtPOW.close();
					conn.close();
					return docno;
				}  */                

			}
			if (docno > 0) {       
				conn.commit();
				stmtPOW.close();
				conn.close();
				return docno;
			} 
			if (docno <= 0) {  
				stmtPOW.close();
				conn.close();
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		} finally {
			conn.close();
		}
		return 0;
	}

	public int edit(int docno, int vocno, Date Date, String ejarino,
			String primeowner, String coowner1, String coowner2,
			Date birthdate, String address, String telephn, String mobile,
			String email, String passport, String issuedplce, Date expiry,
			int natid, String bankname, String accountno, String accountname,
			String bankaddress, String Bankcountry, String bankswift,
			String bankiban, String bankremarks, String formdetailcode,
			String cmbcurrency, String specialinstructions, String telephone2,
			String mobile2, String email2, String aliasname, int OwnerId,ArrayList<String> bankaccarray,ArrayList<String> splarray,    
			HttpSession session, HttpServletRequest request)
			throws SQLException {

		Connection conn = null;

		try {
			conn = connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String company = session.getAttribute("COMPANYID").toString()
					.trim();
			String branch = session.getAttribute("BRANCHID").toString().trim();
			String currency = session.getAttribute("CURRENCYID").toString()
					.trim();
			String userid = session.getAttribute("USERID").toString().trim();
			Statement stmtss = conn.createStatement();
			CallableStatement stmtPOW = conn
					.prepareCall("{CALL propertyownerDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtPOW.setInt(28, docno);
			stmtPOW.setInt(29, vocno);
			stmtPOW.setDate(1, Date);
			stmtPOW.setString(2, ejarino);
			stmtPOW.setString(3, primeowner);
			stmtPOW.setString(4, coowner1);

			stmtPOW.setString(5, coowner2);
			stmtPOW.setDate(6, birthdate);
			stmtPOW.setString(7, address);
			stmtPOW.setString(8, telephn);

			stmtPOW.setString(9, mobile);
			stmtPOW.setString(10, email);
			stmtPOW.setString(11, passport);
			stmtPOW.setString(12, issuedplce);
			stmtPOW.setDate(13, expiry);
			stmtPOW.setInt(14, natid);
			stmtPOW.setString(15, bankname);
			stmtPOW.setString(16, accountno);
			stmtPOW.setString(17, accountname);
			stmtPOW.setString(18, bankaddress);
			stmtPOW.setString(19, Bankcountry);
			stmtPOW.setString(20, bankswift);
			stmtPOW.setString(21, bankiban);
			stmtPOW.setString(22, bankremarks);
			stmtPOW.setString(23, formdetailcode);
			stmtPOW.setString(24, currency);
			stmtPOW.setString(25, branch);
			stmtPOW.setString(26, userid);
			stmtPOW.setString(27, "E");

			// Added by saranya on 17/11/2019
			stmtPOW.setString(30, aliasname);
			stmtPOW.setString(31, specialinstructions);
			stmtPOW.setString(32, telephone2);
			stmtPOW.setString(33, mobile2);
			stmtPOW.setString(34, email2);
			stmtPOW.setInt(35, OwnerId);

			stmtPOW.executeQuery();
			int docNo = stmtPOW.getInt("docNo");
			int vocNo = stmtPOW.getInt("vocNo");

			request.setAttribute("vocNo", vocNo);

			if (docNo > 0) {				
				/* bank acc det grid Saving */
				for (int j = 0; j < bankaccarray.size(); j++) {
					String[] spl = bankaccarray.get(j).split("::");
					if (!spl[0].trim().equalsIgnoreCase("undefined")
							&& !spl[0].trim().equalsIgnoreCase("NaN")) {

						CallableStatement s1 = conn.prepareCall("{CALL rl_ownerbankdetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						 
						s1.setInt(2, docNo);
						
						int docn = Integer.parseInt(spl[0].equalsIgnoreCase("")|| spl[0].equalsIgnoreCase("undefined")|| spl[0] == null ? "0" : spl[0]);
						s1.setInt(1, docn);   
						s1.setString(3,(spl[1].trim().equalsIgnoreCase("undefined")|| spl[1].trim().equalsIgnoreCase("NaN")|| spl[1].trim().isEmpty() ? 0 : spl[1].trim()).toString()); 
						s1.setString(4, spl[2].trim().equalsIgnoreCase("undefined")  || spl[2].trim().equalsIgnoreCase("NaN") || spl[2].trim().isEmpty() ? "" : spl[2].trim().toString());
						s1.setString(5, spl[3].trim().equalsIgnoreCase("undefined")  || spl[3].trim().equalsIgnoreCase("NaN") || spl[3].trim().isEmpty() ? "" : spl[3].trim().toString());
						s1.setString(6, spl[4].trim().equalsIgnoreCase("undefined")  || spl[4].trim().equalsIgnoreCase("NaN") || spl[4].trim().isEmpty() ? "" : spl[4].trim().toString());
						 
						int cntryid=Integer.parseInt(spl[5].equalsIgnoreCase("")|| spl[5].equalsIgnoreCase("undefined")|| spl[5] == null ? "0" : spl[5]);
						s1.setInt(7,cntryid);
						
						int currid=Integer.parseInt(spl[6].equalsIgnoreCase("")|| spl[6].equalsIgnoreCase("undefined")|| spl[6] == null ? "0" : spl[6]);
						s1.setInt(8,currid);
						 
						s1.setString(9, spl[7].trim().equalsIgnoreCase("undefined")  || spl[7].trim().equalsIgnoreCase("NaN") || spl[7].trim().isEmpty() ? "" : spl[7].trim().toString());
						s1.setString(10, spl[8].trim().equalsIgnoreCase("undefined") || spl[8].trim().equalsIgnoreCase("NaN") || spl[8].trim().isEmpty() ? "" : spl[8].trim().toString());
						s1.setString(11, spl[9].trim().equalsIgnoreCase("undefined") || spl[9].trim().equalsIgnoreCase("NaN") || spl[9].trim().isEmpty() ? "" : spl[9].trim().toString());
						
						int defaultacc=Integer.parseInt(spl[10].equalsIgnoreCase("")|| spl[10].equalsIgnoreCase("undefined")|| spl[10] == null ? "0" : spl[10]);
						s1.setInt(12,defaultacc);
						
						s1.setString(13, "E");
						 
						
						int splinschk = s1.executeUpdate();
						
						System.out.println("spl instruction  query="+s1);
						
						System.out.println("spl instruction check ="+splinschk);
						if (splinschk <= 0) {
							s1.close();
							return 0;
						}
						s1.close();
					}
				}
				/* bank acc det Grid Saving Ends */
				for(int i=0;i< splarray.size();i++){    

					String[] enqser=splarray.get(i).split("::");   
					int refdocno=enqser[0].trim().equalsIgnoreCase("undefined") || enqser[0].trim().equalsIgnoreCase("NaN")|| enqser[0].trim().equalsIgnoreCase("")|| enqser[0].isEmpty()?0:Integer.parseInt(enqser[0].trim());       
					if(!(enqser[1].trim().equalsIgnoreCase("undefined")|| enqser[1].trim().equalsIgnoreCase("NaN")||enqser[1].trim().equalsIgnoreCase("")|| enqser[1].isEmpty()))
					{   
						if(refdocno>0){        
							String sql="update re_ownersplins set remarks='"+(enqser[1].trim().equalsIgnoreCase("undefined") || enqser[1].trim().equalsIgnoreCase("NaN")|| enqser[1].trim().equalsIgnoreCase("")|| enqser[1].isEmpty()?"":enqser[1].trim())+"', srno="+(i+1)+" where rowno='"+refdocno+"'";                          
						    //System.out.println("==="+sql);	            
							int val1 = stmtss.executeUpdate (sql);           
							if(val1<=0)   
							{
								conn.close();    
								return 0;
							}
						}else{
							String sql="insert into re_ownersplins (remarks, srno, rdocno) values ("       
									+ "'"+(enqser[1].trim().equalsIgnoreCase("undefined") || enqser[1].trim().equalsIgnoreCase("NaN")|| enqser[1].trim().equalsIgnoreCase("")|| enqser[1].isEmpty()?"":enqser[1].trim())+"',"
									+ (i+1)+","                
									+ "'"+docno+"')";                      
						    //System.out.println("==="+sql);	            
							int val1 = stmtss.executeUpdate (sql);       
							if(val1<=0)   
							{
								conn.close();    
								return 0;
							}
						}
					}
				}
				
/*
				int catm = 1;
				int accgrp = 0;

				String sqls = "select doc_no,acc_group accgrp  from my_clcatm where status=3 and dtype='VND' and tenant=1 "
						+ " union all select doc_no,acc_group  accgrp  from my_clcatm where status=3 and dtype='VND'  limit 1 ";

				ResultSet rss = stmtPOW.executeQuery(sqls);
				if (rss.first()) {
					catm = rss.getInt("doc_no");
					accgrp = rss.getInt("accgrp");
				}

				int cldocno = 0;
				int acno = 0;

				String sqlss = "select cldocno,acno from my_acbook where dtype='VND' and acno=(select acno from rl_propertryowner where doc_no="
						+ docNo + ") ";
				System.out.println("sqlss================================"
						+ sqlss);

				ResultSet rsss = stmtPOW.executeQuery(sqlss);
				if (rsss.first()) {
					cldocno = rsss.getInt("cldocno");
					acno = rsss.getInt("acno");
				}

				System.out.println("cldocno================================"
						+ cldocno);
				System.out.println("acno================================"
						+ acno);

				int val = vendorDetailsDAO.edit(cldocno, "VND", Date,
						primeowner, "" + currency, "" + catm, "" + 1, "" + 0,
						"" + accgrp, "" + acno, 0, 0, 0, address, "", telephn,
						mobile, telephn, "" + 0, email, coowner1, "" + 0,
						session);

				System.out.println("valll================================"
						+ val);

				if (val > 0) {
					conn.commit();
					stmtPOW.close();
					conn.close();
					return 1;
				}*/

			}
			if (docNo > 0) {       
				conn.commit();
				stmtPOW.close();
				conn.close();
				return docNo;
			} 
			if (docNo <= 0) {  
				stmtPOW.close();
				conn.close();
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		} finally {
			conn.close();
		}
		return 0;
	}

	public int delete(int docno, String dtype, HttpSession session, String mode)
			throws SQLException {
		// System.out.println("kjnjgbkjdskj"+docno);
		conn = connDAO.getMyConnection();
		Statement stmtCAT1 = conn.createStatement();

		try {

			String branch = session.getAttribute("BRANCHID").toString().trim();
			String userid = session.getAttribute("USERID").toString();

			String resql = "update rl_propertryowner set status=7 where doc_no="
					+ docno + " ";
			stmtCAT1.executeUpdate(resql);
			String sql = "insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("
					+ docno
					+ ","
					+ branch
					+ ",'"
					+ dtype
					+ "',now(),"
					+ userid
					+ ",'" + mode + "')";
			stmtCAT1.executeUpdate(sql);
			stmtCAT1.close();
			conn.close();

			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmtCAT1.close();
			conn.close();

		}

		return 0;
	}

	public JSONArray nationsearch(String docno, String bdcenter, String chk)
			throws SQLException {

		JSONArray RESULTDATA1 = new JSONArray();

		if (!(chk.equalsIgnoreCase("1"))) {
			return RESULTDATA1;
		}
		Connection conn = null;
		try {

			String sql1 = "";

			if (!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))) {
				sql1 = sql1 + " and bd.doc_no like '%" + docno + "%'";
			}

			if (!((bdcenter.equalsIgnoreCase("")) || (bdcenter
					.equalsIgnoreCase("0")))) {
				sql1 = sql1 + " and bd.nation like '%" + bdcenter + "%'";
			}
			conn = connDAO.getMyConnection();
			Statement stmtAgeingStatement1 = conn.createStatement();

			String sql = "";

			sql = "select doc_no,nation from my_natm bd where 1=1" + sql1;

			ResultSet resultSet1 = stmtAgeingStatement1.executeQuery(sql);

			RESULTDATA1 = commonDAO.convertToJSON(resultSet1);

			stmtAgeingStatement1.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA1;
	}

public JSONArray vndMainSearch(String powner, String address,
			String vndmob, String vndemail,String id) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
if(!id.equalsIgnoreCase("1")){
	return RESULTDATA;
}
		Connection conn = null;

		try {
			conn = connDAO.getMyConnection();
			Statement stmtVND = conn.createStatement();
			String sqltest = "";

			if ((!(powner.equalsIgnoreCase("")))
					&& (!(powner.equalsIgnoreCase("0")))) {
				sqltest = sqltest + " and pow.primary_owner like '%" + powner
						+ "%'";
			}

			if ((!(address.equalsIgnoreCase("")))
					&& (!(address.equalsIgnoreCase("0")))) {

				sqltest = sqltest + " and pow.address like '%" + address
						+ "%'";
			}

			if ((!(vndemail.equalsIgnoreCase("")))
					&& (!(vndemail.equalsIgnoreCase("0")))) {

				sqltest = sqltest + " and pow.email like '%" + vndemail + "%'";
			}
			if ((!(vndmob.equalsIgnoreCase("")))
					&& (!(vndmob.equalsIgnoreCase("0")))) {
				sqltest = sqltest + " and pow.mobile like '%" + vndmob + "%'";
			}
			
			String query="select pow.primary_owner owner,pow.ejari_no,pow.tele_phn,pow.mobile,pow.doc_no,pow.address,pow.email,pow.acno from rl_propertryowner pow where  status<>7"
					+ sqltest;

			System.out.println("search query="+query);
			
			ResultSet resultSet = stmtVND.executeQuery(query); 
		 
			RESULTDATA = commonDAO.convertToJSON(resultSet);

			stmtVND.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public ClsPropertyOwnerBean getViewDetails(int docNo) throws SQLException {
		ClsPropertyOwnerBean propertyOwnerBean = new ClsPropertyOwnerBean();

		Connection conn = null;

		try {
			conn = connDAO.getMyConnection();
			Statement stmtPOW = conn.createStatement();
				
			 String qry="select pr.doc_no, pr.ejari_no, pr.primary_owner, pr.co_owner1,"
						+ " pr.co_owner2,pr.acno, "
						+ "tm.nation,pr.Birth_date, pr.address, pr.tele_phn, pr.mobile, pr.email, pr.acno, "
						+ "pr.passport_no, pr.place_of_issue, pr.Expiry_date, pr.natid, pr.bank_name, pr.account_no,"
						+ " pr.account_name, pr.bank_address, "
						+ "pr.country, pr.currency_id, pr.swift_code, pr.iban, pr.remarks, pr.voc_no, pr.date, pr.brhid, pr.userid, "
						+ "pr.status,pr.OwnerId,pr.aliasname,pr.specialinstructions,pr.mobile2,pr.email2,pr.telephone2 from rl_propertryowner pr left join my_natm tm on tm.doc_no=pr.natid where pr.status<>7 and pr.doc_no="
						+ docNo;
			 System.out.println("viewdatadet=="+qry);
			 
			 ResultSet resultSet = stmtPOW.executeQuery(qry);
			
			
			
			while (resultSet.next()) {
				propertyOwnerBean.setDocno(docNo);
				propertyOwnerBean.setJqxDate(resultSet.getDate("date")
						.toString());
				propertyOwnerBean.setTxtprimeowner(resultSet
						.getString("primary_owner"));
				propertyOwnerBean.setHidcmbcurrency(resultSet
						.getString("currency_id"));
				propertyOwnerBean
						.setTxtejarino(resultSet.getString("ejari_no"));
				propertyOwnerBean.setTxtcoowner1(resultSet
						.getString("co_owner1"));
				propertyOwnerBean.setTxtcoowner2(resultSet
						.getString("co_owner2"));
				if(resultSet.getDate("Birth_date")!=null){
					propertyOwnerBean.setJqxBirthDate(resultSet.getDate("Birth_date").toString());
				}
				propertyOwnerBean.setTxtaddress(resultSet.getString("address"));
				propertyOwnerBean
						.setTxttelepho(resultSet.getString("tele_phn"));
				propertyOwnerBean.setTxtmobpho(resultSet.getString("mobile"));
				propertyOwnerBean.setTxtemail(resultSet.getString("email"));
				propertyOwnerBean.setTxtpassport(resultSet
						.getString("passport_no"));
				propertyOwnerBean.setTxtissuedplace(resultSet
						.getString("place_of_issue"));
				propertyOwnerBean.setJqxexpiryDate(resultSet.getDate(
						"Expiry_date").toString());
				propertyOwnerBean.setTxtnationality(resultSet
						.getString("nation"));
				propertyOwnerBean.setTxtbankname(resultSet
						.getString("bank_name"));
				propertyOwnerBean.setTxtaccountno(resultSet
						.getString("account_no"));
				propertyOwnerBean.setTxtaccountname(resultSet
						.getString("account_name"));
				propertyOwnerBean.setTxtbankaddress(resultSet
						.getString("bank_address"));
				propertyOwnerBean.setTxtbankcountry(resultSet
						.getString("country"));
				propertyOwnerBean.setTxtbankswift(resultSet
						.getString("swift_code"));
				propertyOwnerBean.setTxtbankiban(resultSet.getString("iban"));
				propertyOwnerBean.setTxtbankremarks(resultSet
						.getString("remarks"));

				propertyOwnerBean.setTxtOwnerId(resultSet.getInt("OwnerId"));
				propertyOwnerBean.setTxtaliasname(resultSet
						.getString("aliasname"));
				propertyOwnerBean.setTxtspecialinstructions(resultSet
						.getString("specialinstructions"));
				propertyOwnerBean.setTxtemail2(resultSet.getString("email2"));
				propertyOwnerBean.setTxttelepho2(resultSet
						.getString("telephone2"));
				propertyOwnerBean.setTxtmobpho2(resultSet.getString("mobile2"));
				propertyOwnerBean.setHidowneraccount(resultSet.getString("acno"));

			}
			stmtPOW.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return propertyOwnerBean;
	}
	
	public JSONArray AccountLoadByownerID(HttpSession session, int docno)
			throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
		   
			conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select ob.doc_no ,ob.ownerid,ob.bankname ,ob.accnumber ,ob.accname ,ob.bankaddress,ob.bankcountry countryid,n.nation country ,ob.currency currencyid,c.code currency ,ob.swiftcode ,ob.iban , ob.remarks,if(ob.defaultacc=1,true,false) chk  from rl_ownerbankdetails ob left join my_curr c on c.doc_no=ob.currency left join my_natm n on n.doc_no=ob.bankcountry where ob.ownerid="
					+ docno;
			System.out.println("accgrid sql"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = commonDAO.convertToJSON(resultSet);
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
	public JSONArray splInstructionData(HttpSession session, String docno, String id)
			throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;    
		}
		Connection conn = null;
		try {
		   
			conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select rowno,remarks desc1 from re_ownersplins where rdocno='"+docno+"' and status<>7";  
			System.out.println("splInstructionData--->>>"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = commonDAO.convertToJSON(resultSet);
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


}
