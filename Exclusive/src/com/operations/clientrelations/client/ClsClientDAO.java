package com.operations.clientrelations.client;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsClientDAO {

	 ClsCommon commonDAO = new ClsCommon();
	 ClsConnection connDAO = new ClsConnection();
	 ClsClientBean clientBean = new ClsClientBean();
	 
	 public int insert(Date clientDate, String formdetailcode, String txtclient_name, String cmbsalutation, String cmbcurrency, String cmbgroup, String cmbcategory,
			    String cmbsalesman, int hidchckadvance, String cmbinvoicing_method,int cmbdel_charges, String cmbgroup1, String txtaccount,int txtcredit_period_min, int txtcredit_period_max,
				int txtcredit_limit, int hidchckdefault, String txtsalik,String txttraffic, String txtref_no, String txtref_type,String txtpersonal_add1, 
				String txtpersonal_add2,String txtpersonal_tel1, String personal_tel2,String txtpersonal_fax, String txtpersonal_email,String txtpersonal_contact, 
				String txtpersonal_extn_no,String txtoffice_add1, String txtoffice_add2,String txtoffice_tel1, String office_tel2, String txtoffice_fax,String txtoffice_email, 
				String txtoffice_contact,String txtoffice_extn_no, String txtresidence_add1,String txtresidence_add2, String txtresidence_tel1,String residence_tel2, 
				String txtresidence_fax, String txtresidence_email,String txtresidence_contact, String txtresidence_extn_no,String txthome_add1, String txthome_add2, 
				String txthome_tel1,String home_tel2, String txthome_fax, String txthome_email, String txthome_contact,String txthome_extn_no, String txtname, String txtaddress,
				String txttelephone, int txtid, String cmbnationality,String txtsecurity, String txtsecurity1, String txtcontractno, Date contractDate, String txtcontractremarks, 
				ArrayList<String> driverarray,ArrayList<String> referencearray,ArrayList<String> attacharray,ArrayList<String> creditcardarray,HttpSession session,HttpServletRequest request) 
				throws SQLException {
			
		 		Connection conn = null;

		 		try{
		 			conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
					
		 			String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					String drivermobileno = driverarray.size()>0?(driverarray.get(0).split("::")[3]!=null?driverarray.get(0).split("::")[3].trim().toString():""):"";
					
					if(drivermobileno.trim().equalsIgnoreCase("undefined")){
						drivermobileno="";
					}
					
					CallableStatement stmtCRM = conn.prepareCall("{CALL clientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
							+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtCRM.registerOutParameter(66, java.sql.Types.INTEGER);
					stmtCRM.registerOutParameter(67, java.sql.Types.INTEGER);
					stmtCRM.setDate(1,clientDate);
					stmtCRM.setString(2,cmbsalutation.equalsIgnoreCase("")?txtclient_name:cmbsalutation+" "+txtclient_name);
					stmtCRM.setString(3,cmbcurrency);
					stmtCRM.setString(4,cmbgroup);
					stmtCRM.setString(6,cmbcategory);
					stmtCRM.setString(5,cmbsalesman);
					stmtCRM.setString(7,cmbinvoicing_method);
					stmtCRM.setInt(8, cmbdel_charges);
					stmtCRM.setString(9,cmbgroup1);
					
					stmtCRM.setInt(10,txtcredit_period_min);
					stmtCRM.setInt(11,txtcredit_period_max);
					stmtCRM.setInt(12,txtcredit_limit);
					stmtCRM.setInt(13,hidchckdefault);
					stmtCRM.setString(14,txtsalik);
					stmtCRM.setString(15,txttraffic);
					
					stmtCRM.setString(16,"0");
					stmtCRM.setString(17,"0");
					stmtCRM.setString(18,txtpersonal_add1);
					stmtCRM.setString(19,txtpersonal_add2);
					stmtCRM.setString(20,txtpersonal_tel1);
					stmtCRM.setString(21,personal_tel2.equalsIgnoreCase("")?drivermobileno:personal_tel2);
					stmtCRM.setString(22,txtpersonal_fax);
					stmtCRM.setString(23,txtpersonal_email);
					stmtCRM.setString(24,txtpersonal_contact);
					stmtCRM.setString(25,txtpersonal_extn_no);
					stmtCRM.setString(26,txtoffice_add1);
					stmtCRM.setString(27,txtoffice_add2);
					stmtCRM.setString(28,txtoffice_tel1);
					stmtCRM.setString(29,office_tel2);
					stmtCRM.setString(30,txtoffice_fax);
					stmtCRM.setString(31,txtoffice_email);
					stmtCRM.setString(32,txtoffice_contact);
					stmtCRM.setString(33,txtoffice_extn_no);
					stmtCRM.setString(34,txtresidence_add1);
					stmtCRM.setString(35,txtresidence_add2);
					stmtCRM.setString(36,txtresidence_tel1);
					stmtCRM.setString(37,residence_tel2);
					stmtCRM.setString(38,txtresidence_fax);
					stmtCRM.setString(39,txtresidence_email);
					stmtCRM.setString(40,txtresidence_contact);
					stmtCRM.setString(41,txtresidence_extn_no);
					stmtCRM.setString(42,txthome_add1);
					stmtCRM.setString(43,txthome_add2);
					stmtCRM.setString(44,txthome_tel1);
					stmtCRM.setString(45,home_tel2);
					stmtCRM.setString(46,txthome_fax);
					stmtCRM.setString(47,txthome_email);
					stmtCRM.setString(48,txthome_contact);
					stmtCRM.setString(49,txthome_extn_no);
					
					stmtCRM.setString(50,txtname);
					stmtCRM.setString(51,txtaddress);
					stmtCRM.setString(52,txttelephone);
					stmtCRM.setInt(53,txtid);
					stmtCRM.setString(54,cmbnationality);
					stmtCRM.setString(55,txtsecurity);
					stmtCRM.setString(56,txtsecurity1);
					stmtCRM.setString(57,txtcontractno);
					stmtCRM.setDate(58,contractDate);
					stmtCRM.setString(59,txtcontractremarks);
					stmtCRM.setString(60,cmbsalutation);
					
					stmtCRM.setString(61,formdetailcode);
					stmtCRM.setString(62,currency);
					stmtCRM.setString(63,company);
					stmtCRM.setString(64,branch);
					stmtCRM.setString(65,userid);
					stmtCRM.setInt(68,hidchckadvance);
					stmtCRM.setString(69,"A");
					stmtCRM.executeQuery();
					docno=stmtCRM.getInt("docNo");
					int accountno=stmtCRM.getInt("documentNo");
					request.setAttribute("acno", accountno);
					
					clientBean.setTxtclientdocno(docno);
					if (docno > 0 && accountno>0) {
					int data=0;
					int data1=0;
					int data8=0;
					
					String sql6="DELETE FROM gl_drdetails WHERE doc_no="+docno;
					int data6 = stmtCRM.executeUpdate(sql6);
					
					/*Driver Grid Saving*/
					for(int i=0;i< driverarray.size();i++){
					CallableStatement stmtCRM1=null;
					String[] client=driverarray.get(i).split("::");
					if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date dob=(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||  client[1].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[1].trim()));
						java.sql.Date passexp=(client[5].trim().equalsIgnoreCase("undefined") || client[5].trim().equalsIgnoreCase("NaN") || client[5].trim().equalsIgnoreCase("") ||  client[5].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[5].trim()));
						java.sql.Date issdate=(client[7].trim().equalsIgnoreCase("undefined") || client[7].trim().equalsIgnoreCase("NaN") || client[7].trim().equalsIgnoreCase("") ||  client[7].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[7].trim()));
						java.sql.Date led=(client[9].trim().equalsIgnoreCase("undefined") || client[9].trim().equalsIgnoreCase("NaN") || client[9].trim().equalsIgnoreCase("") ||  client[9].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[9].trim()));
						java.sql.Date visaexp=(client[12].trim().equalsIgnoreCase("undefined") || client[12].trim().equalsIgnoreCase("NaN") || client[12].trim().equalsIgnoreCase("") ||  client[12].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[12].trim()));
						java.sql.Date hcissdate=(client[15].trim().equalsIgnoreCase("undefined") || client[15].trim().equalsIgnoreCase("NaN") || client[15].trim().equalsIgnoreCase("") ||  client[15].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[15].trim()));
						java.sql.Date hcled=(client[16].trim().equalsIgnoreCase("undefined") || client[16].trim().equalsIgnoreCase("NaN") || client[16].trim().equalsIgnoreCase("") ||  client[16].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[16].trim()));
						
						stmtCRM1 = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,hcdlno,hcissdate,hcled,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtCRM1.setString(1,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString());
						stmtCRM1.setDate(2,dob);
						stmtCRM1.setString(3,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
						stmtCRM1.setString(4,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
						stmtCRM1.setString(5,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString());
						stmtCRM1.setDate(6,passexp);
						stmtCRM1.setString(7,(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("") ||client[6].trim().isEmpty()?0:client[6].trim()).toString());
						stmtCRM1.setDate(8,issdate);
						stmtCRM1.setString(9,(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("") ||client[8].trim().isEmpty()?0:client[8].trim()).toString());
						stmtCRM1.setDate(10,led);
						stmtCRM1.setString(11,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
						stmtCRM1.setString(12,(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("") ||client[11].trim().isEmpty()?0:client[11].trim()).toString());
						stmtCRM1.setDate(13,visaexp);
						stmtCRM1.setString(14,(client[14].trim().equalsIgnoreCase("undefined") || client[14].trim().equalsIgnoreCase("NaN") || client[14].trim().equalsIgnoreCase("") ||client[14].trim().isEmpty()?0:client[14].trim()).toString());
						stmtCRM1.setDate(15,hcissdate);
						stmtCRM1.setDate(16,hcled);
						stmtCRM1.setInt(17,(i+1));
						stmtCRM1.setString(18,formdetailcode);
						stmtCRM1.setString(19,branch);
						stmtCRM1.setInt(20,docno);
						stmtCRM1.setInt(21,docno);
					    data = stmtCRM1.executeUpdate();
					 }
					if(data<=0){
						stmtCRM1.close();
						conn.close();
						return 0;
					}
					}
					
					String sql5="DELETE FROM my_crmcont WHERE doc_no="+docno;
					int data5 = stmtCRM.executeUpdate (sql5);
					
					/*Reference Grid Saving*/
					for(int i=0;i< referencearray.size();i++){
					String[] client=referencearray.get(i).split("::");
					if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					
					String sql1="INSERT INTO my_crmcont(CPERSON,DESIG,MOB,EMAIL,sr_no,doc_no)VALUES"
							+ " ('"+(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") || client[0].trim().isEmpty()?0:client[0].trim())+"',"
							+ "'"+(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") || client[1].trim().isEmpty()?0:client[1].trim())+"',"
							+ "'"+(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") || client[2].trim().isEmpty()?0:client[2].trim())+"',"
							+ "'"+(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("") || client[3].trim().isEmpty()?0:client[3].trim())+"',"
							+ ""+i+1+",'"+docno+"')";
					
					 data1 = stmtCRM.executeUpdate(sql1);
					 }
					if(data1<=0){
						stmtCRM.close();
						conn.close();
						return 0;
					}
					}
					
					String sql7="DELETE FROM my_clbankdet WHERE rdocno="+docno;
					int data7 = stmtCRM.executeUpdate(sql7);
					
					/*Credit Card Grid Saving*/
					for(int i=0;i< creditcardarray.size();i++){
					CallableStatement stmtCRM2=null;
					String[] client=creditcardarray.get(i).split("::");
					if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date cardexp=(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||  client[2].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[2].trim()));
						
						int defaultcard = 0;
						if(client[3].trim().equalsIgnoreCase("true")){
							defaultcard=1;
						}
						else if(client[3].trim().equalsIgnoreCase("false")){
							defaultcard=0;
						}

						stmtCRM2 = conn.prepareCall("INSERT INTO my_clbankdet(rowno, rdocno, type, cardno, exp_date, remarks, defaultcard) VALUES(?, ?, ?, ?, ?, ?, ?)");
						
						stmtCRM2.setInt(1,(i+1)); //rowno
						stmtCRM2.setInt(2,docno); //docno
						stmtCRM2.setString(3,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString()); //type
						stmtCRM2.setString(4,(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||client[1].trim().isEmpty()?0:client[1].trim()).toString()); //card no
						stmtCRM2.setDate(5,cardexp); //card expiry
						stmtCRM2.setString(6,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString()); //remarks
						stmtCRM2.setInt(7,defaultcard); //default

						data8 = stmtCRM2.executeUpdate();
					 }
						if(data8<=0){
							stmtCRM2.close();
							conn.close();
							return 0;
						}
					}
					
					conn.commit();
					stmtCRM.close();
					conn.close();
					return docno;
				}
					stmtCRM.close();
					conn.close();
					return docno;
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		}

	 public int edit(int txtclientdocno, String formdetailcode, Date clientDate,String txtclient_name, String cmbsalutation, String cmbcurrency, String cmbgroup,String cmbcategory,
			 String cmbsalesman, int hidchckadvance, String cmbinvoicing_method,int cmbdel_charges, String cmbgroup1, String txtaccount,int txtcredit_period_min, int txtcredit_period_max,
			 int txtcredit_limit, int hidchckdefault, String txtsalik,String txttraffic, String txtref_no, String txtref_type,String txtpersonal_add1, String txtpersonal_add2,
			 String txtpersonal_tel1, String personal_tel2,String txtpersonal_fax, String txtpersonal_email,String txtpersonal_contact, String txtpersonal_extn_no,String txtoffice_add1,
			 String txtoffice_add2,String txtoffice_tel1, String office_tel2, String txtoffice_fax,String txtoffice_email, String txtoffice_contact,String txtoffice_extn_no,
			 String txtresidence_add1,String txtresidence_add2, String txtresidence_tel1,String residence_tel2, String txtresidence_fax,String txtresidence_email, String txtresidence_contact,
			 String txtresidence_extn_no, String txthome_add1,String txthome_add2, String txthome_tel1, String home_tel2,String txthome_fax, String txthome_email, String txthome_contact,
			 String txthome_extn_no, String txtname, String txtaddress,String txttelephone, int txtid, String cmbnationality,String txtsecurity, String txtsecurity1, String txtcontractno, 
			 Date contractDate, String txtcontractremarks,ArrayList<String> driverarray,ArrayList<String> referencearray, ArrayList<String> attacharray, ArrayList<String> creditcardarray, 
			 HttpSession session) throws SQLException {
		 
		 	Connection conn = null;
		 	
		 try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String currency=session.getAttribute("CURRENCYID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			String drivermobileno = driverarray.size()>0?(driverarray.get(0).split("::")[3]!=null?driverarray.get(0).split("::")[3].trim().toString():""):"";
	 			
	 			if(drivermobileno.trim().equalsIgnoreCase("undefined")){
					drivermobileno="";
				}
	 			
				CallableStatement stmtCRM = conn.prepareCall("{CALL clientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
						+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtCRM.setInt(66,txtclientdocno);
				stmtCRM.setString(67,txtaccount);
				
				stmtCRM.setDate(1,clientDate);
				stmtCRM.setString(2,cmbsalutation.equalsIgnoreCase("")?txtclient_name:cmbsalutation+" "+txtclient_name);
				stmtCRM.setString(3,cmbcurrency);
				stmtCRM.setString(4,cmbgroup);
				stmtCRM.setString(6,cmbcategory);
				stmtCRM.setString(5,cmbsalesman);
				stmtCRM.setString(7,cmbinvoicing_method);
				stmtCRM.setInt(8, cmbdel_charges);
				stmtCRM.setString(9,cmbgroup1);
				
				stmtCRM.setInt(10,txtcredit_period_min);
				stmtCRM.setInt(11,txtcredit_period_max);
				stmtCRM.setInt(12,txtcredit_limit);
				stmtCRM.setInt(13,hidchckdefault);
				stmtCRM.setString(14,txtsalik);
				stmtCRM.setString(15,txttraffic);
				
				stmtCRM.setString(16,txtref_no);
				stmtCRM.setString(17,txtref_type);
				stmtCRM.setString(18,txtpersonal_add1);
				stmtCRM.setString(19,txtpersonal_add2);
				stmtCRM.setString(20,txtpersonal_tel1);
				stmtCRM.setString(21,personal_tel2.trim().equalsIgnoreCase("")?drivermobileno:personal_tel2);
				stmtCRM.setString(22,txtpersonal_fax);
				stmtCRM.setString(23,txtpersonal_email);
				stmtCRM.setString(24,txtpersonal_contact);
				stmtCRM.setString(25,txtpersonal_extn_no);
				stmtCRM.setString(26,txtoffice_add1);
				stmtCRM.setString(27,txtoffice_add2);
				stmtCRM.setString(28,txtoffice_tel1);
				stmtCRM.setString(29,office_tel2);
				stmtCRM.setString(30,txtoffice_fax);
				stmtCRM.setString(31,txtoffice_email);
				stmtCRM.setString(32,txtoffice_contact);
				stmtCRM.setString(33,txtoffice_extn_no);
				stmtCRM.setString(34,txtresidence_add1);
				stmtCRM.setString(35,txtresidence_add2);
				stmtCRM.setString(36,txtresidence_tel1);
				stmtCRM.setString(37,residence_tel2);
				stmtCRM.setString(38,txtresidence_fax);
				stmtCRM.setString(39,txtresidence_email);
				stmtCRM.setString(40,txtresidence_contact);
				stmtCRM.setString(41,txtresidence_extn_no);
				stmtCRM.setString(42,txthome_add1);
				stmtCRM.setString(43,txthome_add2);
				stmtCRM.setString(44,txthome_tel1);
				stmtCRM.setString(45,home_tel2);
				stmtCRM.setString(46,txthome_fax);
				stmtCRM.setString(47,txthome_email);
				stmtCRM.setString(48,txthome_contact);
				stmtCRM.setString(49,txthome_extn_no);
				
				stmtCRM.setString(50,txtname);
				stmtCRM.setString(51,txtaddress);
				stmtCRM.setString(52,txttelephone);
				stmtCRM.setInt(53,txtid);
				stmtCRM.setString(54,cmbnationality);
				stmtCRM.setString(55,txtsecurity);
				stmtCRM.setString(56,txtsecurity1);
				stmtCRM.setString(57,txtcontractno);
				stmtCRM.setDate(58,contractDate);
				stmtCRM.setString(59,txtcontractremarks);
				stmtCRM.setString(60,cmbsalutation);
				
				stmtCRM.setString(61,formdetailcode);
				stmtCRM.setString(62,currency);
				stmtCRM.setString(63,company);
				stmtCRM.setString(64,branch);
				stmtCRM.setString(65,userid);
				stmtCRM.setInt(68,hidchckadvance);
				stmtCRM.setString(69,"E");
				stmtCRM.executeQuery();
				int docno=stmtCRM.getInt("docNo");
				int accountno=stmtCRM.getInt("documentNo");
				
				clientBean.setTxtclientdocno(docno);
				if (docno > 0 && accountno>0) {
					int data1=0;
					int data2=0;
					int data8=0;
					
					/*Driver Grid Updating*/
					for(int i=0;i< driverarray.size();i++){
					CallableStatement stmtCRM1 =null;
					String[] client=driverarray.get(i).split("::");
					
					java.sql.Date dob=(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("NA") || client[1].trim().equalsIgnoreCase("") ||  client[1].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[1].trim()));
					java.sql.Date passexp=(client[5].trim().equalsIgnoreCase("undefined") || client[5].trim().equalsIgnoreCase("NaN") || client[5].trim().equalsIgnoreCase("NA") || client[5].trim().equalsIgnoreCase("") ||  client[5].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[5].trim()));
					java.sql.Date issdate=(client[7].trim().equalsIgnoreCase("undefined") || client[7].trim().equalsIgnoreCase("NaN") || client[7].trim().equalsIgnoreCase("NA") || client[7].trim().equalsIgnoreCase("") ||  client[7].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[7].trim()));
					java.sql.Date led=(client[9].trim().equalsIgnoreCase("undefined") || client[9].trim().equalsIgnoreCase("NaN") || client[9].trim().equalsIgnoreCase("NA") || client[9].trim().equalsIgnoreCase("") ||  client[9].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[9].trim()));
					java.sql.Date visaexp=(client[12].trim().equalsIgnoreCase("undefined") || client[12].trim().equalsIgnoreCase("NaN") || client[12].trim().equalsIgnoreCase("NA") || client[12].trim().equalsIgnoreCase("") ||  client[12].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[12].trim()));
					java.sql.Date hcissdate=(client[15].trim().equalsIgnoreCase("undefined") || client[15].trim().equalsIgnoreCase("NaN") || client[15].trim().equalsIgnoreCase("") ||  client[15].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[15].trim()));
					java.sql.Date hcled=(client[16].trim().equalsIgnoreCase("undefined") || client[16].trim().equalsIgnoreCase("NaN") || client[16].trim().equalsIgnoreCase("") ||  client[16].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[16].trim()));
					
					if(!client[13].trim().equalsIgnoreCase("undefined") && !client[13].trim().equalsIgnoreCase("NaN")){

						stmtCRM1 = conn.prepareCall("update gl_drdetails set branch=?,name=?,dob=?,nation=?,mobno=?,passport_no=?,pass_exp=?,dlno=?,issdate=?,issfrm=?,led=?,ltype=?,visano=?,visa_exp=?,hcdlno=?,hcissdate=?,hcled=? where dr_id=?");
						
						stmtCRM1.setString(1,session.getAttribute("BRANCHID").toString());
						stmtCRM1.setString(2,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("NA") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString());
						stmtCRM1.setDate(3,dob);
						stmtCRM1.setString(4,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("NA") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
						stmtCRM1.setString(5,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("NA") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
						stmtCRM1.setString(6,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("NA") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString());
						stmtCRM1.setDate(7,passexp);
						stmtCRM1.setString(8,(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("NA") || client[6].trim().equalsIgnoreCase("") ||client[6].trim().isEmpty()?0:client[6].trim()).toString());
						stmtCRM1.setDate(9,issdate);
						stmtCRM1.setString(10,(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("NA") || client[8].trim().equalsIgnoreCase("") ||client[8].trim().isEmpty()?0:client[8].trim()).toString());
						stmtCRM1.setDate(11,led);
						stmtCRM1.setString(12,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("NA") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
						stmtCRM1.setString(13,(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("NA") || client[11].trim().equalsIgnoreCase("") ||client[11].trim().isEmpty()?0:client[11].trim()).toString());
						stmtCRM1.setDate(14,visaexp);
						stmtCRM1.setString(15,(client[14].trim().equalsIgnoreCase("undefined") || client[14].trim().equalsIgnoreCase("NaN") || client[14].trim().equalsIgnoreCase("") ||client[14].trim().isEmpty()?0:client[14].trim()).toString());
						stmtCRM1.setDate(16,hcissdate);
						stmtCRM1.setDate(17,hcled);
						stmtCRM1.setString(18,(client[13].trim().equalsIgnoreCase("undefined") || client[13].trim().equalsIgnoreCase("NaN") || client[13].trim().equalsIgnoreCase("NA") || client[13].trim().equalsIgnoreCase("") ||client[13].trim().isEmpty()?0:client[13].trim()).toString());
						
						data1 = stmtCRM1.executeUpdate();
					}
					
					else{
						stmtCRM1 = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,hcdlno,hcissdate,hcled,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtCRM1.setString(1,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("NA") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString());
						stmtCRM1.setDate(2,dob);
						stmtCRM1.setString(3,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("NA") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
						stmtCRM1.setString(4,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("NA") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
						stmtCRM1.setString(5,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("NA") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString());
						stmtCRM1.setDate(6,passexp);
						stmtCRM1.setString(7,(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("NA") || client[6].trim().equalsIgnoreCase("") ||client[6].trim().isEmpty()?0:client[6].trim()).toString());
						stmtCRM1.setDate(8,issdate);
						stmtCRM1.setString(9,(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("NA") || client[8].trim().equalsIgnoreCase("") ||client[8].trim().isEmpty()?0:client[8].trim()).toString());
						stmtCRM1.setDate(10,led);
						stmtCRM1.setString(11,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("NA") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
						stmtCRM1.setString(12,(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("NA") || client[11].trim().equalsIgnoreCase("") ||client[11].trim().isEmpty()?0:client[11].trim()).toString());
						stmtCRM1.setDate(13,visaexp);
						stmtCRM1.setString(14,(client[14].trim().equalsIgnoreCase("undefined") || client[14].trim().equalsIgnoreCase("NaN") || client[14].trim().equalsIgnoreCase("") ||client[14].trim().isEmpty()?0:client[14].trim()).toString());
						stmtCRM1.setDate(15,hcissdate);
						stmtCRM1.setDate(16,hcled);
						stmtCRM1.setInt(17,(i+1));
						stmtCRM1.setString(18,formdetailcode);
						stmtCRM1.setString(19,branch);
						stmtCRM1.setInt(20,docno);
						stmtCRM1.setInt(21,docno);

						data1 = stmtCRM1.executeUpdate();
					    }
						if(data1<=0){
							stmtCRM1.close();
							conn.close();
							return 0;
						  }
					   }
					
					String sql5="DELETE FROM my_crmcont WHERE doc_no="+docno;
					int data5 = stmtCRM.executeUpdate (sql5);
					
					/*Reference Grid Updating*/
					for(int i=0;i< referencearray.size();i++){
					String[] client=referencearray.get(i).split("::");
					
					String sql3="INSERT INTO my_crmcont(CPERSON,DESIG,MOB,EMAIL,sr_no,doc_no)VALUES"
							+ " ('"+(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("0") || client[0].trim().equalsIgnoreCase("") || client[0].trim().isEmpty()?0:client[0].trim())+"',"
							+ "'"+(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("0") || client[1].trim().equalsIgnoreCase("") || client[1].trim().isEmpty()?0:client[1].trim())+"',"
							+ "'"+(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("0") || client[2].trim().equalsIgnoreCase("") || client[2].trim().isEmpty()?0:client[2].trim())+"',"
							+ "'"+(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("0") || client[3].trim().equalsIgnoreCase("") || client[3].trim().isEmpty()?0:client[3].trim())+"',"
							+ ""+i+1+",'"+docno+"')";
					
					
					data2 = stmtCRM.executeUpdate(sql3);
					if(data2<=0){
						stmtCRM.close();
						conn.close();
						return 0;
					}
					}
					
					String sql7="DELETE FROM my_clbankdet WHERE rdocno="+docno;
					int data7 = stmtCRM.executeUpdate(sql7);
					
					/*Credit Card Grid Saving*/
					for(int i=0;i< creditcardarray.size();i++){
					CallableStatement stmtCRM2=null;
					String[] client=creditcardarray.get(i).split("::");
					if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date cardexp=(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||  client[2].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(client[2].trim()));
						
						int defaultcard = 0;
						if(client[3].trim().equalsIgnoreCase("true")){
							defaultcard=1;
						}
						else if(client[3].trim().equalsIgnoreCase("false")){
							defaultcard=0;
						}
						
						stmtCRM2 = conn.prepareCall("INSERT INTO my_clbankdet(rowno, rdocno, type, cardno, exp_date, remarks, defaultcard) VALUES(?, ?, ?, ?, ?, ?, ?)");
						
						stmtCRM2.setInt(1,(i+1)); //rowno
						stmtCRM2.setInt(2,docno); //docno
						stmtCRM2.setString(3,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString()); //type
						stmtCRM2.setString(4,(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||client[1].trim().isEmpty()?0:client[1].trim()).toString()); //card no
						stmtCRM2.setDate(5,cardexp); //card expiry
						stmtCRM2.setString(6,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString()); //remarks
						stmtCRM2.setInt(7,defaultcard); //default

						data8 = stmtCRM2.executeUpdate();
					 }
						if(data8<=0){
							stmtCRM2.close();
							conn.close();
							return 0;
						}
					}
					
					conn.commit();
					stmtCRM.close();
					conn.close();
					return 1;
				}	
				stmtCRM.close();
				conn.close();
				return 1;
		 }catch(Exception e){
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		}

		public int delete(int txtclientdocno, String txtaccount, String formdetailcode, HttpSession session) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String currency=session.getAttribute("CURRENCYID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
			CallableStatement stmtCRM = conn.prepareCall("{CALL clientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCRM.setInt(66,txtclientdocno);
			stmtCRM.setString(67,txtaccount);
			stmtCRM.setDate(1,null);
			stmtCRM.setString(2,null);
			stmtCRM.setString(3,null);
			stmtCRM.setString(4,null);
			stmtCRM.setString(6,null);
			stmtCRM.setString(5,null);
			stmtCRM.setString(7,null);
			stmtCRM.setInt(8, 0);
			stmtCRM.setString(9,null);
			
			stmtCRM.setInt(10,0);
			stmtCRM.setInt(11,0);
			stmtCRM.setInt(12,0);
			stmtCRM.setInt(13,0);
			stmtCRM.setString(14,null);
			stmtCRM.setString(15,null);
			
			stmtCRM.setString(16,null);
			stmtCRM.setString(17,null);
			stmtCRM.setString(18,null);
			stmtCRM.setString(19,null);
			stmtCRM.setString(20,null);
			stmtCRM.setString(21,null);
			stmtCRM.setString(22,null);
			stmtCRM.setString(23,null);
			stmtCRM.setString(24,null);
			stmtCRM.setString(25,null);
			stmtCRM.setString(26,null);
			stmtCRM.setString(27,null);
			stmtCRM.setString(28,null);
			stmtCRM.setString(29,null);
			stmtCRM.setString(30,null);
			stmtCRM.setString(31,null);
			stmtCRM.setString(32,null);
			stmtCRM.setString(33,null);
			stmtCRM.setString(34,null);
			stmtCRM.setString(35,null);
			stmtCRM.setString(36,null);
			stmtCRM.setString(37,null);
			stmtCRM.setString(38,null);
			stmtCRM.setString(39,null);
			stmtCRM.setString(40,null);
			stmtCRM.setString(41,null);
			stmtCRM.setString(42,null);
			stmtCRM.setString(43,null);
			stmtCRM.setString(44,null);
			stmtCRM.setString(45,null);
			stmtCRM.setString(46,null);
			stmtCRM.setString(47,null);
			stmtCRM.setString(48,null);
			stmtCRM.setString(49,null);
			
			stmtCRM.setString(50,null);
			stmtCRM.setString(51,null);
			stmtCRM.setString(52,null);
			stmtCRM.setInt(53,0);
			stmtCRM.setString(54,null);
			stmtCRM.setString(55,null);
			stmtCRM.setString(56,null);
			stmtCRM.setDate(57,null);
			stmtCRM.setString(57,null);
			stmtCRM.setDate(58,null);
			stmtCRM.setString(59,null);
			stmtCRM.setString(60,null);
			
			stmtCRM.setString(61,formdetailcode);
			stmtCRM.setString(62,currency);
			stmtCRM.setString(63,company);
			stmtCRM.setString(64,branch);
			stmtCRM.setString(65,userid);
			stmtCRM.setInt(68,0);
			stmtCRM.setString(69,"D");
			stmtCRM.executeQuery();
			int docno=stmtCRM.getInt("docNo");
			int accountno=stmtCRM.getInt("documentNo");
			clientBean.setTxtclientdocno(docno);
			if (docno > 0 && accountno>0) {
				
				conn.commit();
				stmtCRM.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtCRM.close();
				conn.close();
				return docno;
			}
			stmtCRM.close();
			conn.close();
			return 0;
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
  }
     
		public ClsClientBean getViewDetails(int docNo) throws SQLException {
			
			ClsClientBean clientBean = new ClsClientBean();
			
			Connection conn = null;
			
			try {
			
				conn = connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtCRM = conn.createStatement();

				String sql= ("SELECT c.date,c.codeno,trim(REPLACE(RefName,coalesce(salutation,''),'')) RefName,c.salutation,c.curId,c.c_group,c.sal_id,c.catid,c.advance,"
						+ "c.invc_method,c.del_charges,c.acc_group,c.acno,c.period,c.period2,c.credit,c.ser_default,c.per_salikrate,c.per_trafficharge,c.refNo,"
						+ "c.ref_type,c.address,c.address2,c.per_tel,c.per_mob,c.fax1,c.mail1,c.contactPerson,c.EXT_NO,c.pay_mode,c.contractno,c.contract_upto,"
						+ "c.con_remarks,s.off_address,s.off_address2,s.off_tel,s.off_mob,s.off_fax,s.off_mail,s.off_contactPerson,s.off_EXTNO,s.res_address,s.res_address2,"
						+ "s.res_tel,s.res_mob,s.res_fax,s.res_mail,s.res_contactPerson,s.res_EXTNO,s.hme_address,s.hme_address2,s.hme_tel,s.hme_mob,s.hme_fax,s.hme_mail,"
						+ "s.hme_contactPerson,s.hme_EXTNO,s.SponsorName,s.address sponsoraddress,s.mobile,s.id,s.nationality,s.secType,s.secId,(select method from gl_config "
						+ "where field_nme='crmIDPDetails') idpinfo FROM my_acbook c left join gl_sponsor s "
						+ "on(c.DOC_NO=s.DOC_NO) WHERE c.dtype='CRM' and c.DOC_NO="+docNo);
	           
				ResultSet resultSet = stmtCRM.executeQuery(sql);
							
				while (resultSet.next()) {
					clientBean.setJqxClientDate(resultSet.getDate("date").toString());
					clientBean.setTxtcode(resultSet.getInt("codeno"));
					clientBean.setTxtclient_name(resultSet.getString("RefName"));
					clientBean.setHidcmbsalutation(resultSet.getString("salutation"));
					clientBean.setHidcmbcurrency(resultSet.getString("curId"));
					clientBean.setTxtclientdocno(docNo);
					clientBean.setHidcmbgroup(resultSet.getString("c_group"));
					clientBean.setHidcmbsalesman(resultSet.getString("sal_id"));
					clientBean.setHidcmbcategory(resultSet.getString("catid"));
					clientBean.setChckadvance(resultSet.getInt("advance"));
					clientBean.setHidcmbinvoicing_method(resultSet.getString("invc_method"));
					clientBean.setHidcmbdel_charges(resultSet.getInt("del_charges"));
					clientBean.setHidcmbgroup1(resultSet.getString("acc_group"));
					clientBean.setTxtaccount(resultSet.getString("acno"));
					clientBean.setTxtcredit_period_min(resultSet.getInt("period"));
					clientBean.setTxtcredit_period_max(resultSet.getInt("period2"));
					clientBean.setTxtcredit_limit(resultSet.getInt("credit"));
					clientBean.setChckdefault(resultSet.getInt("ser_default"));
					clientBean.setTxtsalik(resultSet.getString("per_salikrate"));
					clientBean.setTxttraffic(resultSet.getString("per_trafficharge"));
					clientBean.setTxtref_no(resultSet.getString("refNo"));
					clientBean.setTxtref_type(resultSet.getString("ref_type"));
					clientBean.setTxtpersonal_add1(resultSet.getString("address"));
					clientBean.setTxtpersonal_add2(resultSet.getString("address2"));
					clientBean.setTxtpersonal_tel1(resultSet.getString("per_tel"));
					clientBean.setPersonal_tel2(resultSet.getString("per_mob"));
					clientBean.setTxtpersonal_fax(resultSet.getString("fax1"));
					clientBean.setTxtpersonal_email(resultSet.getString("mail1"));
					clientBean.setTxtpersonal_contact(resultSet.getString("contactPerson"));
					clientBean.setTxtpersonal_extn_no(resultSet.getString("EXT_NO"));
					clientBean.setTxtoffice_add1(resultSet.getString("off_address"));
					clientBean.setTxtoffice_add2(resultSet.getString("off_address2"));
					clientBean.setTxtoffice_tel1(resultSet.getString("off_tel"));
					clientBean.setOffice_tel2(resultSet.getString("off_mob"));
					clientBean.setTxtoffice_fax(resultSet.getString("off_fax"));
					clientBean.setTxtoffice_email(resultSet.getString("off_mail"));
					clientBean.setTxtoffice_contact(resultSet.getString("off_contactPerson"));
					clientBean.setTxtoffice_extn_no(resultSet.getString("off_EXTNO"));
					clientBean.setTxtresidence_add1(resultSet.getString("res_address"));
					clientBean.setTxtresidence_add2(resultSet.getString("res_address2"));
					clientBean.setTxtresidence_tel1(resultSet.getString("res_tel"));
					clientBean.setResidence_tel2(resultSet.getString("res_mob"));
					clientBean.setTxtresidence_fax(resultSet.getString("res_fax"));
					clientBean.setTxtresidence_email(resultSet.getString("res_mail"));
					clientBean.setTxtresidence_contact(resultSet.getString("res_contactPerson"));
					clientBean.setTxtresidence_extn_no(resultSet.getString("res_EXTNO"));
					clientBean.setTxthome_add1(resultSet.getString("hme_address"));
					clientBean.setTxthome_add2(resultSet.getString("hme_address2"));
					clientBean.setTxthome_tel1(resultSet.getString("hme_tel"));
					clientBean.setHome_tel2(resultSet.getString("hme_mob"));
					clientBean.setTxthome_fax(resultSet.getString("hme_fax"));
					clientBean.setTxthome_email(resultSet.getString("hme_mail"));
					clientBean.setTxthome_contact(resultSet.getString("hme_contactPerson"));
					clientBean.setTxthome_extn_no(resultSet.getString("hme_EXTNO"));
					clientBean.setTxtname(resultSet.getString("SponsorName"));
					clientBean.setTxtaddress(resultSet.getString("sponsoraddress"));
					clientBean.setTxttelephone(resultSet.getString("mobile"));
					clientBean.setTxtid(resultSet.getInt("id"));
					clientBean.setHidcmbnationality(resultSet.getString("nationality"));
					clientBean.setTxtsecurity(resultSet.getString("secType"));
					clientBean.setTxtsecurity1(resultSet.getString("secId"));
					clientBean.setTxtcontractno(resultSet.getString("contractno"));
					clientBean.setJqxContractDate(resultSet.getDate("contract_upto")==null?"":resultSet.getDate("contract_upto").toString());
					clientBean.setTxtcontractremarks(resultSet.getString("con_remarks"));
					clientBean.setIdpdetailsallowed(resultSet.getString("idpinfo"));
			        }
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return clientBean;
		}
    
    public JSONArray driverGridSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT nation FROM my_natm order by nation");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray stateGridSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select state from my_uaestatesm order by state");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray driverGridReloading(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT doc_no,dr_id,sr_no srno,name,dob,DATE_FORMAT(dob,'%d.%m.%Y') AS hiddob,nation as nation1,mobno,"
						+ "passport_no,pass_exp,DATE_FORMAT(pass_exp,'%d.%m.%Y') AS hidpassexp,dlno,issdate,DATE_FORMAT(issdate,'%d.%m.%Y') AS hidissdate,issfrm,led,"
						+ "DATE_FORMAT(led,'%d.%m.%Y') AS hidled,ltype,visano,visa_exp,DATE_FORMAT(visa_exp,'%d.%m.%Y') AS hidvisaexp,hcdlno,hcissdate,"
						+ "DATE_FORMAT(hcissdate,'%d.%m.%Y') AS hidhcissdate,hcled,DATE_FORMAT(hcled,'%d.%m.%Y') AS hidhcled,'Attach' attachbtn FROM gl_drdetails "
						+ "where dtype='CRM' and doc_no="+docNo+"");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public String getCardType() throws SQLException {
    	 
    	  String cellarray1 = "";  
    	  Connection conn = null;
    	  
    	try {
    	     conn = connDAO.getMyConnection();
    	     Statement stmtCRM = conn.createStatement();
    	   
    	    String sql= ("select mode  from my_cardm where id=1 and dtype='card'");
    	    ResultSet resultSet = stmtCRM.executeQuery(sql);
    	    
    	    while (resultSet.next()) {
    	        cellarray1+=resultSet.getString("mode")+",";
    	    }
    	    
    	    cellarray1=cellarray1.substring(0, cellarray1.length()-1);
    	    
    	    stmtCRM.close();
    	    conn.close();
    	  }catch(Exception e){
    	     conn.close();
    	     e.printStackTrace();
    	    }
    	   return cellarray1;
     }
    
    public JSONArray creditCardGridReloading(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				ResultSet resultSet = stmtCRM.executeQuery ("select type,cardno,exp_date,DATE_FORMAT(exp_date,'%d.%m.%Y') AS hidexpdate,remarks,defaultcard from my_clbankdet where rdocno="+docNo+"");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
    
    public JSONArray referenceDetailsGridReloading(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT cperson,desig,mob,email "
							+ "FROM my_crmcont where doc_no="+docNo+"");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
    
    public JSONArray documentsAttachGridReloading(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT extension,description,fileName,dtype,doc_no "
							+ "FROM my_dbimages where doc_no="+docNo+"");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
    
    public JSONArray clientSearch(HttpSession session,String clname,String mob,String lcno,String clientid,String nation,String dob) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
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
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlStartDate=null;
       
        
         dob.trim();
        if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
        {
        sqlStartDate = commonDAO.changeStringtoSqlDate(dob);
        }
        
        
        String sqltest="";
        
        if(!(clientid.equalsIgnoreCase(""))){
            sqltest=sqltest+" and c.doc_no like '%"+clientid+"%'";
        }
        if(!(clname.equalsIgnoreCase(""))){
         sqltest=sqltest+" and c.RefName like '%"+clname+"%'";
        }
        if(!(mob.equalsIgnoreCase(""))){
         sqltest=sqltest+" and c.per_mob like '%"+mob+"%'";
        }
        if(!(lcno.equalsIgnoreCase(""))){
         sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
        }
        if(!(nation.equalsIgnoreCase(""))){
         sqltest=sqltest+" and d.nation like '%"+nation+"%'";
        }
         if(!(sqlStartDate==null)){
         sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
        } 
           
     try {
    	   conn = connDAO.getMyConnection();
    	   Statement stmtCRM = conn.createStatement();
       
	       ResultSet resultSet = stmtCRM.executeQuery("select c.doc_no clientid,trim(c.RefName) refname,trim(d.DLNO) dlno,d.dob,c.per_mob,c.per_tel,trim(c.address) address,d.nation from my_acbook c left join "
	          		+ "gl_drdetails d on d.cldocno=c.doc_no and d.dtype=c.dtype where status <> 7 and c.dtype='CRM'" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtCRM.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }

}
