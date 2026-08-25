package com.finance.nipurchase.vendormaster;

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

public class ClsVendorDetailsDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsVendorDetailsBean vendorDetailsBean = new ClsVendorDetailsBean();

	public int insert(Date vendorDate, String formdetailcode, String txtvendorname,String cmbcurrency, String cmbcategory,String cmbtype,String txtregisteredtrnno, String cmbaccgroup,
			String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, String txtaddress,String txtaddress1, String txttel, String txtmob,
			String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno,HttpSession session,HttpServletRequest request,ArrayList<String> venarray,ArrayList<String> cpnarray,String vndtax,String account,String bankname,String branchname,String branchaddress,String swiftno,String ibanno,String city,String cdocno,String commmode) throws SQLException {
		System.out.println("account========"+txtaccount);
		Connection conn = null;
		
		try{
			System.out.println("in dao");
			
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtVND = conn.prepareCall("{CALL vendorMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtVND.registerOutParameter(25, java.sql.Types.INTEGER);
				stmtVND.registerOutParameter(26, java.sql.Types.INTEGER);
				stmtVND.setDate(1,vendorDate);
				stmtVND.setString(2,txtvendorname);
				stmtVND.setString(3,cmbcurrency);
				stmtVND.setString(4,cmbcategory);
				stmtVND.setString(5,cmbtype);
				stmtVND.setString(6,txtregisteredtrnno);
				
				stmtVND.setString(7,cmbaccgroup);
				stmtVND.setInt(8,txtcredit_period_min);
				stmtVND.setInt(9,txtcredit_period_max);
				stmtVND.setInt(10,txtcredit_limit);

				stmtVND.setString(11,txtaddress);
				stmtVND.setString(12,txtaddress1);
				stmtVND.setString(13,txttel);
				stmtVND.setString(14,txtmob);
				stmtVND.setString(15,txtoffice);
				stmtVND.setString(16,txtfax);
				stmtVND.setString(17,txtemail);
				stmtVND.setString(18,txtcontact);
				stmtVND.setString(19,txtextno);
				
				stmtVND.setString(20,formdetailcode);
				stmtVND.setString(21,currency);
				stmtVND.setString(22,branch);
				stmtVND.setString(23,company);
				stmtVND.setString(24,userid);
				stmtVND.setString(27,"A");
				stmtVND.setString(28,vndtax.equalsIgnoreCase(" ") || vndtax.equalsIgnoreCase("") || vndtax.equalsIgnoreCase("null") || vndtax==null?"0":vndtax.trim());
				stmtVND.setString(29,account);
				stmtVND.setString(30,bankname);
				stmtVND.setString(31,branchname);
				stmtVND.setString(32,branchaddress);
				stmtVND.setString(33,swiftno);
				stmtVND.setString(34,ibanno);
				stmtVND.setString(35,city);
				stmtVND.setString(36,cdocno.equalsIgnoreCase(" ") || cdocno.equalsIgnoreCase("") || cdocno.equalsIgnoreCase("null") || cdocno==null?"0":cdocno.trim());
				stmtVND.setString(37,commmode.equalsIgnoreCase(" ") || commmode.equalsIgnoreCase("") || commmode.equalsIgnoreCase("null") || commmode==null?"0":commmode.trim());
				stmtVND.executeQuery();      
				
				int docno=stmtVND.getInt("docNo");
				int accountno=stmtVND.getInt("documentNo");
				request.setAttribute("acno", accountno);
				
				vendorDetailsBean.setTxtvendordocno(docno);
				System.out.println("docno==="+docno);
				
				if(docno<=0)
				{
					conn.close();
					return 0;
				}
				
				System.out.println("docno==="+docno);

				if (docno>0 && accountno>0) {
					
					/*Insertion to in_vendserv*/
					int insertData=insertion(conn, docno, formdetailcode, venarray,cpnarray, session);
					if(insertData<=0){
						stmtVND.close();
						conn.close();
						return 0;
					}
					/*Insertion to in_vendserv Ends*/
					
					conn.commit();
					stmtVND.close();
					conn.close();
					return docno;
				}
				
				stmtVND.close();
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

	public int edit(int txtvendordocno, String formdetailcode, Date vendorDate,String txtvendorname, String cmbcurrency, String cmbcategory,String cmbtype, 
			String txtregisteredtrnno,
			String cmbaccgroup, String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, String txtaddress,
			String txtaddress1, String txttel, String txtmob, String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno,
			ArrayList<String> venarray,ArrayList<String> cnparray,HttpSession session,String vndtax,String account,String bankname,String branchname,String branchaddress,String swiftno,String ibanno,String city,String cdocno,String commmode) throws SQLException {
		
			Connection conn = null;
		
		    try{
		    		conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtVND1 = conn.createStatement();
					
			    	String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
				
		 			CallableStatement stmtVND = conn.prepareCall("{CALL vendorMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");		

					stmtVND.setInt(25,txtvendordocno);
					stmtVND.setString(26,txtaccount);
					stmtVND.setDate(1,vendorDate);
					stmtVND.setString(2,txtvendorname);
					stmtVND.setString(3,cmbcurrency);
					stmtVND.setString(4,cmbcategory);
					stmtVND.setString(5,cmbtype);
					stmtVND.setString(6,txtregisteredtrnno);
					
					stmtVND.setString(7,cmbaccgroup);
					stmtVND.setInt(8,txtcredit_period_min);
					stmtVND.setInt(9,txtcredit_period_max);
					stmtVND.setInt(10,txtcredit_limit);

					stmtVND.setString(11,txtaddress);
					stmtVND.setString(12,txtaddress1);
					stmtVND.setString(13,txttel);
					stmtVND.setString(14,txtmob);
					stmtVND.setString(15,txtoffice);
					stmtVND.setString(16,txtfax);
					stmtVND.setString(17,txtemail);
					stmtVND.setString(18,txtcontact);
					stmtVND.setString(19,txtextno);
					
					stmtVND.setString(20,formdetailcode);
					stmtVND.setString(21,currency);
					stmtVND.setString(22,branch);
					stmtVND.setString(23,company);
					stmtVND.setString(24,userid);
					stmtVND.setString(27,"E");
					stmtVND.setString(28,vndtax.equalsIgnoreCase(" ") || vndtax.equalsIgnoreCase("") || vndtax.equalsIgnoreCase("null") || vndtax==null?"0":vndtax.trim());
					stmtVND.setString(29,account);
					stmtVND.setString(30,bankname);
					stmtVND.setString(31,branchname);
					stmtVND.setString(32,branchaddress);
					stmtVND.setString(33,swiftno);
					stmtVND.setString(34,ibanno);
					stmtVND.setString(35,city);
					stmtVND.setString(36,cdocno.equalsIgnoreCase(" ") || cdocno.equalsIgnoreCase("") || cdocno.equalsIgnoreCase("null") || cdocno==null?"0":cdocno.trim());
					stmtVND.setString(37,commmode.equalsIgnoreCase(" ") || commmode.equalsIgnoreCase("") || commmode.equalsIgnoreCase("null") || commmode==null?"0":commmode.trim());
					stmtVND.executeQuery();
					int docno=stmtVND.getInt("docNo");
					int accountno=stmtVND.getInt("documentNo");
					System.out.println("===stmtVND == "+stmtVND);
					vendorDetailsBean.setTxtvendordocno(docno);
					if (docno > 0 && accountno > 0) {
						
						String sql=("DELETE FROM in_vendserv where cldocno="+docno+"");
						// System.out.println("SQL ="+sql);
					    int data = stmtVND1.executeUpdate(sql);
					    
						/*Insertion to in_vendserv*/
						int insertData=insertion(conn, docno, formdetailcode, venarray,cnparray, session);
						if(insertData<=0){
							stmtVND.close();
							conn.close();
							return 0;
						}
						/*Insertion to in_vendserv Ends*/
						
						conn.commit();
						stmtVND.close();
						conn.close();
						return 1;
					}
					stmtVND.close();
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

	public int delete(int txtvendordocno, String txtaccount, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
 			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String currency=session.getAttribute("CURRENCYID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
		    
CallableStatement stmtVND = conn.prepareCall("{CALL vendorMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");		
			
			stmtVND.setInt(25,txtvendordocno);
			stmtVND.setString(26,txtaccount);
			stmtVND.setDate(1,null);
			stmtVND.setString(2,null);
			stmtVND.setString(3,null);
			stmtVND.setString(4,null);
			stmtVND.setString(5,"0");
			stmtVND.setString(6,null);
			
			stmtVND.setString(7,null);
			stmtVND.setInt(8,0);
			stmtVND.setInt(9,0);
			stmtVND.setInt(10,0);

			stmtVND.setString(11,null);
			stmtVND.setString(12,null);
			stmtVND.setString(13,null);
			stmtVND.setString(14,null);
			stmtVND.setString(15,null);
			stmtVND.setString(16,null);
			stmtVND.setString(17,null);
			stmtVND.setString(18,null);
			stmtVND.setString(19,null);
			
			stmtVND.setString(20,formdetailcode);
			stmtVND.setString(21,currency);
			stmtVND.setString(22,branch);
			stmtVND.setString(23,company);
			stmtVND.setString(24,userid);
			stmtVND.setString(27,"D");
			stmtVND.setString(28,null);
			stmtVND.setString(29,null);
			stmtVND.setString(30,null);
			stmtVND.setString(31,null);
			stmtVND.setString(32,null);
			stmtVND.setString(33,null);
			stmtVND.setString(34,null);
			stmtVND.setString(35,null);
			stmtVND.setString(36,null);
			stmtVND.setString(37,null);  
			stmtVND.executeQuery();
			int docno=stmtVND.getInt("docNo");
			int accountno=stmtVND.getInt("documentNo");
			
			vendorDetailsBean.setTxtvendordocno(docno);
			if (docno > 0 && accountno > 0) {
				
				conn.commit();
				stmtVND.close();
				conn.close();
				return 1;
			}	
			
			if (docno == -1){
				stmtVND.close();
				conn.close();
				return docno;
			}
			stmtVND.close();
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
	
	public int insertion(Connection conn,int docno,String formdetailcode, ArrayList<String> venarray,ArrayList<String> cparrayList,HttpSession session) throws SQLException{
		
		  try{
				Statement stmtVND = conn.createStatement();
				CallableStatement stmtPolicy=null;
				System.out.println("venarray size ="+venarray.size());
				for(int i=0;i< venarray.size();i++){

					String[] vendor=venarray.get(i).split("::");
					if(!(vendor[0].trim().equalsIgnoreCase("undefined")|| vendor[0].trim().equalsIgnoreCase("NaN")||vendor[1].trim().equalsIgnoreCase("")|| vendor[0].isEmpty()))
					{
						
						String sql="insert into in_vendserv(CLDOCNO,insurid,SERVID,availability,paymenttype) values( "
								+" '"+docno+"',"+0+" ,"    
								+ "'"+(vendor[0].trim().equalsIgnoreCase("undefined") || vendor[0].trim().equalsIgnoreCase("NaN")|| vendor[0].trim().equalsIgnoreCase("")|| vendor[0].isEmpty()?0:vendor[0].trim())+"',"
								+ "'"+(vendor[1].trim().equalsIgnoreCase("undefined") || vendor[1].trim().equalsIgnoreCase("NaN")|| vendor[1].trim().equalsIgnoreCase("")|| vendor[1].isEmpty()?0:vendor[1].trim())+"',"
						        + "'"+(vendor[2].trim().equalsIgnoreCase("undefined") || vendor[2].trim().equalsIgnoreCase("NaN")|| vendor[2].trim().equalsIgnoreCase("")|| vendor[2].isEmpty()?0:vendor[2].trim())+"')";
						System.out.println("SQL ="+i+"="+sql);	
						int resultSet2 = stmtVND.executeUpdate (sql);
						if(resultSet2<=0)
						{
							stmtVND.close();
							conn.close();
							return 0;
						}	

					}

				}
				System.out.println("cnparray size ="+cparrayList.size());
				int rownum=0 ;
				int resultSet2=0;
				for(int i=0;i< cparrayList.size() ;i++){
					String[] cparray=((String) cparrayList.get(i)).split("::");
					int resultSettcl=0;
					String tclsql="";
					int j=1;
					System.out.println("in for loop 1");
					if(!(cparray[0].trim().equalsIgnoreCase("undefined")|| cparray[0].trim().equalsIgnoreCase("NaN")||cparray[0].trim().equalsIgnoreCase("")|| cparray[0].isEmpty()))
					{
						System.out.println("in for loop 2"+cparray[7].trim());   
						 rownum=cparray[7].trim().equalsIgnoreCase("undefined") || cparray[7]==null || cparray[7].equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:Integer.parseInt(cparray[7].trim());
						 System.out.println("rownum ="+rownum);
						   
						 if(rownum > 0){
							    
							 System.out.println("rownum ="+rownum);
							 stmtPolicy = conn.prepareCall("update my_vndcontact set cperson=?,mob=?,tel=?,extn=?,email=?,area_id=?,actvty_id=? where cldocno='"+docno+"' and row_no='"+rownum+"'");     
								
								stmtPolicy.setString(1,(cparray[0].trim().equalsIgnoreCase("undefined") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].trim().equalsIgnoreCase("")|| cparray[0].isEmpty()?"0":cparray[0].trim().toString()));
								stmtPolicy.setString(2,(cparray[1].trim().equalsIgnoreCase("undefined") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].trim().equalsIgnoreCase("")|| cparray[1].isEmpty()?"0":cparray[1].trim().toString()));
								stmtPolicy.setString(3,(cparray[2].trim().equalsIgnoreCase("undefined") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].trim().equalsIgnoreCase("")|| cparray[2].isEmpty()?"0":cparray[2].trim().toString()));
								stmtPolicy.setString(4,(cparray[3].trim().equalsIgnoreCase("undefined") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].trim().equalsIgnoreCase("")|| cparray[3].isEmpty()?"0":cparray[3].trim().toString()));
								stmtPolicy.setString(5,(cparray[4].trim().equalsIgnoreCase("undefined") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].trim().equalsIgnoreCase("")|| cparray[4].isEmpty()?"0":cparray[4].trim().toString()));
								stmtPolicy.setString(6,(cparray[5].trim().equalsIgnoreCase("undefined") || cparray[5].trim().equalsIgnoreCase("NaN")|| cparray[5].trim().equalsIgnoreCase("")|| cparray[5].isEmpty()?"0":cparray[5].trim().toString()));
								stmtPolicy.setString(7,(cparray[6].trim().equalsIgnoreCase("undefined") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].trim().equalsIgnoreCase("")|| cparray[6].isEmpty()?"0":cparray[6].trim().toString()));  
								//stmtPolicy.setString(8,(cparray[7].trim().equalsIgnoreCase("undefined") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].trim().equalsIgnoreCase("")|| cparray[7].isEmpty()?0:cparray[7].trim()).toString());
						     resultSet2 = stmtPolicy.executeUpdate(); 
						     System.out.println("==tclsql===+"+stmtPolicy+" --- "+resultSet2);
							
							} else {
						
							tclsql="INSERT INTO my_vndcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id) values('"+docno+"','"+formdetailcode+"',"+j+","
									+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
									+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
									+"'"+(cparray[2].trim().equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?"":cparray[2].trim())+"',"
									+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
									+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
									+ "'"+(cparray[5].trim().equalsIgnoreCase("undefined")||cparray[5]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[5].trim().equalsIgnoreCase("NaN")|| cparray[5].isEmpty()?0:cparray[5].trim())+"',"
									+ "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[6].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"')";
							System.out.println("==tclsql===+"+tclsql);
						
							resultSet2 = stmtVND.executeUpdate (tclsql);   
							}
						 
					j=j+1;
					if(resultSet2<=0)
					{
						System.out.println("===1====");
						conn.close();
						return 0; 
					}
				}

			}
				System.out.println("====2===");   	
 }catch(Exception e){
	 System.out.println("===3====");
	 	e.printStackTrace();
	 	conn.close();
	 	return 0;
}
	return 1;
}

public   JSONArray cpGridload(HttpSession session,int docno) throws SQLException {

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

		String brnch=session.getAttribute("BRANCHID").toString();

		Connection conn =null;
		Statement cpstmt =null;

		try {
			conn = connDAO.getMyConnection();
			cpstmt = conn.createStatement ();

			String  cpsql=("select cperson as cpersion,mob as mobile,email,coalesce(tel,'') as phone,area,area_id as areaid,extn,ay_name as activity,actvty_id as activity_id, row_no from my_vndcontact c left join my_area a on(c.area_id=a.doc_no) left join my_activity ac on(ac.doc_no=c.actvty_id) where c.cldocno="+docno+" ");
			System.out.println("------------------------------"+cpsql);

			ResultSet resultSet = cpstmt.executeQuery (cpsql);
			RESULTDATA=commonDAO.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			cpstmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public ClsVendorDetailsBean getViewDetails(int docNo) throws SQLException {
		ClsVendorDetailsBean vendorDetailsBean = new ClsVendorDetailsBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtVND = conn.createStatement();

			ResultSet resultSet = stmtVND.executeQuery ("select coalesce(ac.cmode,0) cmode,co.country_name countryname,tax,bnkAccountno,bank_name,branch_name,branch_address,IBANno,bnkSwiftno,bnkCity,bnkCountryid,type,trnnumber,ac.date,codeno,RefName,curId,catid,acc_group,acno,period,period2,credit,address,address2,per_tel,"
								+ "per_mob,com_mob,fax1,mail1,contactPerson,EXT_NO,dtype, ac.DOC_NO,ac.STATUS from my_acbook ac left join my_acountry co on co.doc_no=ac.bnkCountryid where dtype='VND' and ac.status<>7 and ac.doc_no="+docNo);

			while (resultSet.next()) {
				vendorDetailsBean.setHidcmbcommmode(resultSet.getString("cmode"));           
				vendorDetailsBean.setTxtvendordocno(docNo);
				vendorDetailsBean.setJqxVendorDate(resultSet.getDate("date").toString());
				vendorDetailsBean.setTxtcode(resultSet.getInt("codeno"));
				vendorDetailsBean.setTxtvendorname(resultSet.getString("RefName"));
				vendorDetailsBean.setHidcmbcurrency(resultSet.getString("curId"));
				vendorDetailsBean.setHidcmbcategory(resultSet.getString("catid"));
				vendorDetailsBean.setHidcmbtype(resultSet.getString("type"));
				vendorDetailsBean.setTxtregisteredtrnno(resultSet.getString("trnnumber"));
				vendorDetailsBean.setVndtax(resultSet.getString("tax"));
				
				vendorDetailsBean.setHidcmbaccgroup(resultSet.getString("acc_group"));
				vendorDetailsBean.setTxtaccount(resultSet.getString("acno"));
				vendorDetailsBean.setTxtcredit_period_min(resultSet.getInt("period"));
				vendorDetailsBean.setTxtcredit_period_max(resultSet.getInt("period2"));
				vendorDetailsBean.setTxtcredit_limit(resultSet.getInt("credit"));
				vendorDetailsBean.setTxtaddress(resultSet.getString("address"));
				vendorDetailsBean.setTxtaddress1(resultSet.getString("address2"));
				vendorDetailsBean.setTxttel(resultSet.getString("per_tel"));
				vendorDetailsBean.setTxtmob(resultSet.getString("per_mob"));
				vendorDetailsBean.setTxtoffice(resultSet.getString("com_mob"));
				vendorDetailsBean.setTxtfax(resultSet.getString("fax1"));
				vendorDetailsBean.setTxtemail(resultSet.getString("mail1"));
				vendorDetailsBean.setTxtcontact(resultSet.getString("contactPerson"));
				vendorDetailsBean.setTxtextno(resultSet.getString("EXT_NO"));
				vendorDetailsBean.setTxtaccountno(resultSet.getString("bnkAccountno"));
				vendorDetailsBean.setTxtbankname(resultSet.getString("bank_name"));
				vendorDetailsBean.setTxtbranchname(resultSet.getString("branch_name"));
				vendorDetailsBean.setTxtbranchaddress(resultSet.getString("branch_address"));
				vendorDetailsBean.setTxtibanno(resultSet.getString("IBANno"));
				vendorDetailsBean.setTxtswiftno(resultSet.getString("bnkSwiftno"));
				vendorDetailsBean.setTxtcity(resultSet.getString("bnkCity"));
				vendorDetailsBean.setTxtcdocno(resultSet.getString("bnkCountryid"));
				vendorDetailsBean.setTxtcountryname(resultSet.getString("countryname"));
	
			    }
			stmtVND.close();
			conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return vendorDetailsBean;
			}
	
	 public JSONArray vndMainSearch(String vndname,String vndaccno,String vndmob,String vndtel,String id) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	       
	        if(!(id.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	      
	        Connection conn = null;
	        
			try {
					conn = connDAO.getMyConnection();
					Statement stmtVND = conn.createStatement();
	            	String sqltest="";
			        
			        if(!(vndname.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and refname like '%"+vndname+"%'";
			        }
			        if(!(vndaccno.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and acno like '%"+vndaccno+"%'";
			        }
			        if(!(vndtel.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and per_tel like '%"+vndtel+"%'";
			        }
			        if(!(vndmob.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and per_mob like '%"+vndmob+"%'";
			        }
					
					ResultSet resultSet = stmtVND.executeQuery("select refname,acno,per_tel,per_mob,doc_no from my_acbook where dtype='VND' and status<>7"+sqltest);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtVND.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
	        return RESULTDATA;
	    }
	 
	 public JSONArray vendorList() throws SQLException {
			Connection conn = null;
	        JSONArray RESULTDATA=new JSONArray();
	        
	  try {
		    conn = connDAO.getMyConnection();
		    Statement stmtVND = conn.createStatement();
		    
		    ResultSet resultSet = stmtVND.executeQuery ("SELECT category,refname,per_mob,sal_name,concat(address,'  ',address2) as address, "
		    		+ "mail1 FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='VND' left join my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' where cl.dtype='VND' ");
		                
		    RESULTDATA=commonDAO.convertToJSON(resultSet);
		    
		    stmtVND.close();
		    conn.close();
	  }catch(Exception e){
	     e.printStackTrace();
		 conn.close();
	  }finally{
			 conn.close();
		 }
	  return RESULTDATA;
	 }
	 
	 public JSONArray serviceTypeSearch(HttpSession session,String docno,String chk) throws SQLException
		{
           // System.out.println("in chk========="+chk);
            //System.out.println("in id========="+docno);  
			JSONArray RESULTDATA=new JSONArray();
			if(!docno.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Enumeration<String> Enumeration = session.getAttributeNames();
			int a=0;
			String sqltest="";
			while(Enumeration.hasMoreElements()){
				if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
					a=1;
				}
			}
			if(a==0){
				return RESULTDATA;
			}
            if(!(chk.equalsIgnoreCase("") || chk.equalsIgnoreCase("0") )){
            	sqltest="where doc_no not in ("+chk+")";  
            }



			Connection conn =null;
			Statement stmt =null;
			try {
				conn = connDAO.getMyConnection();
				stmt = conn.createStatement ();


				String sql= ("select name service_type,doc_no servid from tr_servicetype "+sqltest+" " );
				//System.out.println("-------serviceTypeSearch----------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=commonDAO.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
	 public JSONArray vendorGrid(String docno) throws SQLException {
			Connection conn = null;
	        JSONArray RESULTDATA=new JSONArray();
	        
	  try {
		    conn = connDAO.getMyConnection();
		    Statement stmtVND = conn.createStatement();
		    String sql="select ser.name servicetype,servid,availability,paymenttype from in_vendserv eq "
					+ "left join tr_servicetype ser on ser.doc_no=eq.servid where eq.cldocno="+docno+"";
		    //System.out.println("vndrgrd==========="+sql);
		    ResultSet resultSet = stmtVND.executeQuery (sql);
		    RESULTDATA=commonDAO.convertToJSON(resultSet);
		    
		    stmtVND.close();
		    conn.close();
	  }catch(Exception e){
	     e.printStackTrace();
		 conn.close();
	  }finally{
			 conn.close();
		 }
	  return RESULTDATA;
	 }
	 
	 public   JSONArray activitySearch(HttpSession session) throws SQLException
		{

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


			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;



			try {
				conn = connDAO.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select doc_no as adocno,ay_name from my_activity where status=3" );
//				System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=commonDAO.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
	 
	 public   JSONArray areaSearch(HttpSession session) throws SQLException
		{

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


			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = connDAO.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				//String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
//				System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=commonDAO.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				resultSet.close();
				stmt.close();
				conn.close();


			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
	 public   JSONArray countrySearch(HttpSession session) throws SQLException
		{

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


			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = connDAO.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select doc_no as cdocno,country_name country from my_acountry where status=3" );
//				System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=commonDAO.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				resultSet.close();
				stmt.close();
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
	 

}
