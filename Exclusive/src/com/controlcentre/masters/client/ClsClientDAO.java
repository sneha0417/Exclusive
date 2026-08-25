package com.controlcentre.masters.client;

import java.sql.CallableStatement;
import java.sql.Connection;
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

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public   JSONArray areaSearch(HttpSession session) throws SQLException {
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
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
			//String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
		//	System.out.println("------------------"+sql);
			resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
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

	public  JSONArray SalesgentSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String salsql="select doc_no,sal_name from my_salm where  status<>7 ";

			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
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
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			String sql= ("select doc_no as cdocno,country_name from my_acountry where status=3" );
			System.out.println("------------------"+sql);
			resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
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
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			String sql= ("select doc_no as adocno,ay_name from my_activity where status=3" );
			System.out.println("------------------"+sql);
			resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
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


	public int insert(java.sql.Date sqlDate,String client_name, int Currency,int Cmbacgroupid,int Cmbsalesmanid,int catid,String Txtcstno,String Txttinno,
			Double Fcredit_period_min,Double Fcredit_period_max,Double Fcredit_limit,String Txtaddress,String Txtextnno,String Txtmobile,String Txttelephone,
			String Txtfax,String Txtweb,String Txtemail,String Txtcontact,int areaid,String Txtaccountno,String Txtbankname,
			String Txtbranchname,String Txtbranchaddress,String Txtswiftno,String Txtibanno,String Txtcity,
			int countryid,String txtcontact,ArrayList cparrayList,HttpSession session,String mode,String formcode,String fin_name,String fin_adress,
			HttpServletRequest request,int chknotax,int chkinterserv, ArrayList<String> documentsarray) throws SQLException
			{
		Connection conn=null;
		CallableStatement stmtclient=null;
		int  docno=0;
		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);


			stmtclient = conn.prepareCall("{CALL  SrclientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtclient.registerOutParameter(32, java.sql.Types.INTEGER);
			stmtclient.registerOutParameter(33, java.sql.Types.INTEGER);
			// main
			stmtclient.setDate(1,sqlDate);
			stmtclient.setString(2,client_name.toUpperCase());
			stmtclient.setInt(3,Currency);
			stmtclient.setInt(4,Cmbacgroupid);
			stmtclient.setInt(5,Cmbsalesmanid);
			stmtclient.setInt(6,catid);
			stmtclient.setDouble(7,Fcredit_period_min);
			stmtclient.setDouble(8,Fcredit_period_max);
			stmtclient.setDouble(9,Fcredit_limit);
			stmtclient.setString(10,Txttinno);
			stmtclient.setString(11,Txtcstno);
			stmtclient.setString(12,Txtaddress);
			stmtclient.setString(13,Txttelephone);
			stmtclient.setString(14,Txtmobile);
			stmtclient.setString(15,Txtfax);
			stmtclient.setString(16,Txtemail);
			stmtclient.setString(17,Txtextnno);
			stmtclient.setString(18,Txtweb);
			stmtclient.setString(19,Txtcontact);
			stmtclient.setInt(20,areaid);
			stmtclient.setString(21,Txtaccountno);
			stmtclient.setString(22,Txtbankname);
			stmtclient.setString(23,Txtbranchname);
			stmtclient.setString(24,Txtbranchaddress);
			stmtclient.setString(25,Txtswiftno);
			stmtclient.setString(26,Txtibanno);
			stmtclient.setString(27,Txtcity);
			stmtclient.setInt(28,countryid);
			stmtclient.setInt(29,Integer.parseInt(session.getAttribute("COMPANYID").toString().trim()));
			stmtclient.setInt(30,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
			stmtclient.setInt(31,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
			stmtclient.setString(34,mode);
			stmtclient.setString(35,fin_name);
			stmtclient.setString(36,fin_adress);
			stmtclient.setInt(37, chknotax);
			stmtclient.setInt(38, chkinterserv);			

			stmtclient.executeQuery();
			docno=stmtclient.getInt("docNo");
			int documentNo=stmtclient.getInt("documentNo");
			request.setAttribute("accountno", documentNo);
			
			if(documentNo>0&&docno>0)
			{
				System.out.println("--inside if--");
				for(int i=0;i< cparrayList.size() ;i++){
					String[] cparray=((String) cparrayList.get(i)).split("::");
					int resultSettcl=0;
					String tclsql="";
					int j=1;
					tclsql="INSERT INTO my_crmcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id) values('"+docno+"','"+formcode+"',"+j+","
							+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							+"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							+ "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"',"
							+ "'"+(cparray[7].trim().equalsIgnoreCase("undefined")||cparray[7]==null  || cparray[7].trim().equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:cparray[7].trim())+"')";
					System.out.println("==tclsql===+"+tclsql);

					resultSettcl = stmtclient.executeUpdate (tclsql);
					j=j+1;
					if(resultSettcl<=0)
					{
						return 0; 
					}
				}
				
				int data1=0;
				for(int i=0;i< documentsarray.size();i++){
					
					CallableStatement stmtEMP2=null;
					String[] employee=documentsarray.get(i).split("::");
					if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date issueDate=(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||  employee[1].trim().isEmpty()?null:com.changeStringtoSqlDate(employee[1].trim()));
						java.sql.Date expDate=(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||  employee[2].trim().isEmpty()?null:com.changeStringtoSqlDate(employee[2].trim()));
						
						stmtEMP2 = conn.prepareCall("INSERT INTO rl_cldoc(cldocno, docId, issdt, expdt, placeofiss, remarks, docIdnum) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP2.setInt(1,docno); //doc_no
						stmtEMP2.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //document Id
						stmtEMP2.setDate(3,issueDate); //issueDate
						stmtEMP2.setDate(4,expDate); //expDate
						stmtEMP2.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //Place of issue
//						stmtEMP2.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //location
						stmtEMP2.setString(6,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						stmtEMP2.setString(7,(employee[6].trim().equalsIgnoreCase("undefined") || employee[6].trim().equalsIgnoreCase("NaN") || employee[6].trim().equalsIgnoreCase("") ||employee[6].trim().isEmpty()?0:employee[6].trim()).toString()); //document Number
						data1 = stmtEMP2.executeUpdate();
						System.out.println(data1+"==="+stmtEMP2.toString());
						if(data1<=0){
							stmtEMP2.close();
							conn.close();
							return 0;
						}
					}
				}
			}

			


			if(documentNo>0&&docno>0)
			{

				conn.commit();

			}
		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			stmtclient.close();
			conn.close();
		}


		return docno;
			}

	public int update(java.sql.Date sqlDate,String client_name, int Currency,int Cmbacgroupid,int Cmbsalesmanid,int catid,String Txtcstno,String Txttinno,
			Double Fcredit_period_min,Double Fcredit_period_max,Double Fcredit_limit,String Txtaddress,String Txtextnno,String Txtmobile,String Txttelephone,
			String Txtfax,String Txtweb,String Txtemail,String Txtcontact,int areaid,String Txtaccountno,String Txtbankname,
			String Txtbranchname,String Txtbranchaddress,String Txtswiftno,String Txtibanno,String Txtcity,int countryid,
			String txtcontact,ArrayList cparrayList,HttpSession session,String mode,String code,String hdocno,String formcode,
			String fin_name,String fin_adress,HttpServletRequest request,int chknotax,int chkinterserv, ArrayList<String> documentsarray) throws SQLException
			{
		Connection conn=null;
		CallableStatement stmtclient=null;
		int  docno=0;
		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			stmtclient = conn.prepareCall("{CALL  SrclientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			stmtclient.setInt(32, Integer.parseInt(code));
			stmtclient.setInt(33, Integer.parseInt(hdocno));
			stmtclient.setDate(1,sqlDate);
			stmtclient.setString(2,client_name);
			stmtclient.setInt(3,Currency);
			stmtclient.setInt(4,Cmbacgroupid);
			stmtclient.setInt(5,Cmbsalesmanid);
			stmtclient.setInt(6,catid);
			stmtclient.setDouble(7,Fcredit_period_min);
			stmtclient.setDouble(8,Fcredit_period_max);
			stmtclient.setDouble(9,Fcredit_limit);
			stmtclient.setString(10,Txttinno);
			stmtclient.setString(11,Txtcstno);
			stmtclient.setString(12,Txtaddress);
			stmtclient.setString(13,Txttelephone);
			stmtclient.setString(14,Txtmobile);
			stmtclient.setString(15,Txtfax);
			stmtclient.setString(16,Txtemail);
			stmtclient.setString(17,Txtextnno);
			stmtclient.setString(18,Txtweb);
			stmtclient.setString(19,Txtcontact);
			stmtclient.setInt(20,areaid);
			stmtclient.setString(21,Txtaccountno);
			stmtclient.setString(22,Txtbankname);
			stmtclient.setString(23,Txtbranchname);
			stmtclient.setString(24,Txtbranchaddress);
			stmtclient.setString(25,Txtswiftno);
			stmtclient.setString(26,Txtibanno);
			stmtclient.setString(27,Txtcity);
			stmtclient.setInt(28,countryid);
			stmtclient.setInt(29,Integer.parseInt(session.getAttribute("COMPANYID").toString().trim()));
			stmtclient.setInt(30,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
			stmtclient.setInt(31,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
			stmtclient.setString(34,mode);
			stmtclient.setString(35,fin_name);
			stmtclient.setString(36,fin_adress);
			stmtclient.setInt(37, chknotax);
			stmtclient.setInt(38, chkinterserv);

			stmtclient.executeQuery();
			docno=stmtclient.getInt("docNo");
			int documentNo=stmtclient.getInt("documentNo");
			request.setAttribute("accountno", documentNo);
			if(documentNo>0&&docno>0)
			{
				for(int i=0;i< cparrayList.size() ;i++){
					String[] cparray=((String) cparrayList.get(i)).split("::");
					int resultSettcl=0;
					String tclsql="";
					int j=1;
					tclsql="INSERT INTO my_crmcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id) values('"+docno+"','"+formcode+"',"+j+","
							+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							+"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							+ "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"',"
							+ "'"+(cparray[7].trim().equalsIgnoreCase("undefined")||cparray[7]==null  || cparray[7].trim().equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:cparray[7].trim())+"')";
					System.out.println("==tclsql===+"+tclsql);

					resultSettcl = stmtclient.executeUpdate (tclsql);
					j=j+1;
					if(resultSettcl<=0)
					{
						return 0; 
					}
				}
			}
			Statement stmtEMP=conn.createStatement();
			String sql1="DELETE FROM rl_cldoc WHERE cldocno="+docno+"";
			stmtEMP.executeUpdate (sql1);
			
			int data1=0;
			/*Documents Grid Saving*/
			for(int i=0;i< documentsarray.size();i++){
			CallableStatement stmtEMP2=null;
			String[] employee=documentsarray.get(i).split("::");
			if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
			    
				java.sql.Date issueDate=(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||  employee[1].trim().isEmpty()?null:com.changeStringtoSqlDate(employee[1].trim()));
				java.sql.Date expDate=(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||  employee[2].trim().isEmpty()?null:com.changeStringtoSqlDate(employee[2].trim()));
				
				stmtEMP2 = conn.prepareCall("INSERT INTO rl_cldoc(cldocno, docId, issdt, expdt, placeofiss, remarks, docIdnum) VALUES(?,?,?,?,?,?,?)");
				
				stmtEMP2.setInt(1,docno); //doc_no
				stmtEMP2.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //document Id
				stmtEMP2.setDate(3,issueDate); //issueDate
				stmtEMP2.setDate(4,expDate); //expDate
				stmtEMP2.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //Place of issue
//				stmtEMP2.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //location
				stmtEMP2.setString(6,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
				stmtEMP2.setString(7,(employee[6].trim().equalsIgnoreCase("undefined") || employee[6].trim().equalsIgnoreCase("NaN") || employee[6].trim().equalsIgnoreCase("") ||employee[6].trim().isEmpty()?0:employee[6].trim()).toString()); //document Number
				data1 = stmtEMP2.executeUpdate();
				
				if(data1<=0){
					stmtEMP2.close();
					conn.close();
					return 0;
			   }
			 }
			 stmtEMP2.close();
			}

			System.out.println("====documentNo==="+documentNo+"==docno===="+docno);

			if(documentNo>0&&docno>0)
			{

				conn.commit();

			}
		}
		catch(Exception e){

		}
		finally{
			stmtclient.close();
			conn.close();
		}

		return docno;
			}


	public int delete(String docno,HttpSession session) throws SQLException{

		int result=0;
		Connection conn=null;
		CallableStatement stmt=null;
		int tranentry=0,contrmentry=0;
		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);


			String sql="update my_acbook set acno=0,status=7 where doc_no='"+docno+"' and cldocno='"+docno+"' and dtype='CRM'";
			//System.out.println("acbook======"+sql);
			String sql1="select count(*) as count from my_jvtran where acno=(select acno from my_acbook where doc_no='"+docno+"' and cldocno='"+docno+"' and dtype='CRM') and status!=7";
			//System.out.println("jvtran======"+sql1);
			String sql3="select  count(*) as count from cm_srvcontrm where cldocno=(select cldocno from my_acbook where doc_no='"+docno+"' and cldocno='"+docno+"' and dtype='CRM') and status!=7 and dtype in('SJOB','AMC')";
			//System.out.println("srvcontrm======"+sql3);
			String sql2="delete from my_head where cldocno='"+docno+"' and dtype='CRM'";
			//System.out.println("head======"+sql2);
			//String sql3="delete from my_crmcontact where cldocno='"+docno+"' and dtype='CRM'";

			Statement cpstmt = conn.createStatement ();
			Statement cpstmtn = conn.createStatement ();

			ResultSet resultSet = cpstmt.executeQuery (sql1);
			ResultSet resultSetm = cpstmtn.executeQuery (sql3);

			if(resultSet.next())
			{
				tranentry=resultSet.getInt("count");
				//System.out.println("tranentry======"+tranentry);
			}
			if(resultSetm.next())
			{
				contrmentry=resultSetm.getInt("count");
				//System.out.println("contrmentry======"+contrmentry);
				
			}

			if(tranentry==0 && contrmentry==0)
			{
				stmt = conn.prepareCall(sql);

				System.out.println("---sql-----"+sql);

				int resultSet2 = stmt.executeUpdate();

				CallableStatement mydelsmt =conn.prepareCall(sql2);

				int resultSet3 = mydelsmt.executeUpdate();


				if(resultSet2>0&&resultSet3>0)
				{
					result=1;

				}

			}
			else{
				result=-1;
			}
			conn.commit();

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
//			stmt.close();
			conn.close();

		}
		return result;
	}
	
	public JSONArray documentsLoading() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = conobj.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				ResultSet resultSet = stmtEMP.executeQuery ("select doc_no documentid,desc1 document from rl_setdoc where status=3");
                
				RESULTDATA=com.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray documentsEditReloading(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				conn = conobj.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				String sql="select a.* from (select m.docId documentid,s.desc1 document,m.docIdnum documentno,m.issdt issue_date,m.expdt exp_date,"
						+ "m.placeofiss place_of_issue,m.remarks from rl_cldoc m left join rl_setdoc s on m.docId=s.doc_no where m.cldocno="+docNo+" "  
						+ "UNION ALL select doc_no documentid,desc1 document,' ' documentno,null issue_date,null exp_date,' ' place_of_issue,' ' remarks from rl_setdoc "  
						+ "where status=3) a group by a.documentid";
				System.out.println("edit--sql--"+sql);
				
				ResultSet resultSet = stmtEMP.executeQuery (sql);
				RESULTDATA=com.convertToJSON(resultSet);
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray documentsReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
				conn = conobj.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				String sql="select m.docId documentid,s.desc1 document,m.docIdnum documentno, "
						+ "m.issdt issue_date,m.expdt exp_date,m.placeofiss place_of_issue,m.remarks "
						+ "from rl_cldoc m left join rl_setdoc s on m.docId=s.doc_no where m.cldocno="+docNo+"";   
				ResultSet resultSet = stmtEMP.executeQuery (sql);
                //System.out.println("sql---->>>"+sql);     
				RESULTDATA=com.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
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
			conn = conobj.getMyConnection();
			cpstmt = conn.createStatement ();

			String  cpsql=("select cperson as cpersion,mob as mobile,email,tel as phone,area,area_id as areaid,extn,ay_name as activity,actvty_id as activity_id from my_crmcontact c left join my_area a on(c.area_id=a.doc_no) left join my_activity ac on(ac.doc_no=c.actvty_id) where c.cldocno="+docno+" and c.dtype='CRM'");
//			System.out.println("------------------------------"+cpsql);

			ResultSet resultSet = cpstmt.executeQuery (cpsql);
			RESULTDATA=com.convertToJSON(resultSet);

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


	public   JSONArray mainSrearch(HttpSession session,String sclname,String smob,String rno,String Contact) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		String brnchid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(sclname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+sclname+"%'";
		}
		if(!(smob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and com_mob like '"+smob+"'";
		}
		if(!(rno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and cldocno like '"+rno+"%'";
		}
		/*if(!(Contact.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and Contact='"+Contact+"%'";
	    	}*/


		Connection conn =null;
		Statement stmtVeh7=null;

		try {
			conn = conobj.getMyConnection();
			stmtVeh7 = conn.createStatement ();
			String str1Sql=("select cldocno,refname,com_mob,contactperson as contact from my_acbook where dtype='CRM' and status<>7  " +sqltest);
			System.out.println("=========="+str1Sql);
			ResultSet resultSet = stmtVeh7.executeQuery (str1Sql);
			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtVeh7.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}




	public  ClsClientBean getViewDetails(HttpSession session,String docNo) throws SQLException {
		String branch = session.getAttribute("BRANCHID").toString();
		ClsClientBean clsClientBean = new ClsClientBean();

		Connection conn =null;
		Statement stmtCPV0 =null;
		try {
			conn = conobj.getMyConnection();
			stmtCPV0 = conn.createStatement ();



			String strSql= ("select ac.cldocno,ac.date as clientdate,ac.catid,refname,address,contactperson contact,period,period2,ac.curid,credit,com_mob,per_tel tel,ext_no extn_tel,fax1,web1,mail1,cstno,tinno,acno,bank_name,account_no,branch_name,branch_address,ibanno,bnkswiftno,bnkcity,h.grpno,"
					+"ac.area_id as areadocno,a.area as area,concat(city.city_name,',',c.country_name,',',r.reg_name) as area_det,bc.country_name as bnkcountry,h.doc_no as acc_no,fin_name,fin_address,sm.doc_no as salid,sm.sal_name as salname,ac.nontax,ac.interserv from my_acbook ac left join my_head h on(ac.cldocno=h.cldocno and h.dtype='CRM')" 
					+"left join my_area a on(ac.area_id=a.doc_no) left join my_acity city on(a.city_id=city.doc_no) left join my_acountry c on(c.doc_no=city.country_id) left join my_aregion r on(r.doc_no=c.reg_id) left join my_acountry bc on(bc.doc_no=ac.bnkcountryid) left join my_salm sm on(ac.sal_id=sm.doc_no) where ac.cldocno='"+docNo+"' and ac.dtype='CRM'");


			ResultSet resultSet = stmtCPV0.executeQuery(strSql);


			while (resultSet.next()) {

				clsClientBean.setTxtcode(resultSet.getString("ac.cldocno"));
				clsClientBean.setClientDate(resultSet.getString("clientdate"));
				clsClientBean.setHidClientDate(resultSet.getString("ac.cldocno"));
				clsClientBean.setTxtclient_name(resultSet.getString("refname"));
				clsClientBean.setCurrencyid(resultSet.getInt("ac.curid"));
				clsClientBean.setHidcmbcurrencyid(resultSet.getInt("ac.curid"));
				clsClientBean.setCmbacgroup(resultSet.getInt("h.grpno"));
				clsClientBean.setHidcmbacgroup(resultSet.getInt("h.grpno"));
				clsClientBean.setCmbcategory(resultSet.getInt("catid"));
				clsClientBean.setHidcmbcategory(resultSet.getInt("catid"));
				clsClientBean.setTxtcstno(resultSet.getString("cstno"));
				clsClientBean.setTxttinno(resultSet.getString("tinno"));
				clsClientBean.setTxtcredit_period_min(resultSet.getDouble("period"));
				clsClientBean.setTxtcredit_period_max(resultSet.getDouble("period2"));
				clsClientBean.setTxtcredit_limit(resultSet.getDouble("credit"));
				clsClientBean.setTxtaddress(resultSet.getString("address"));
				clsClientBean.setTxtextnno(resultSet.getString("extn_tel"));
				clsClientBean.setTxtmobile(resultSet.getString("com_mob"));
				clsClientBean.setTxtfax(resultSet.getString("fax1"));
				clsClientBean.setTxtweb(resultSet.getString("web1"));
				clsClientBean.setTxttelephone(resultSet.getString("tel"));
				clsClientBean.setTxtemail(resultSet.getString("mail1"));
				clsClientBean.setTxtcontact(resultSet.getString("contact"));
				clsClientBean.setTxtareaid(resultSet.getInt("areadocno"));
				clsClientBean.setTxtareadet(resultSet.getString("area_det"));
				clsClientBean.setTxtarea(resultSet.getString("area"));
				clsClientBean.setTxtaccountno(resultSet.getString("account_no"));
				clsClientBean.setTxtbankname(resultSet.getString("bank_name"));
				clsClientBean.setTxtbranchname(resultSet.getString("branch_name"));
				clsClientBean.setTxtbranchaddress(resultSet.getString("branch_address"));
				clsClientBean.setTxtswiftno(resultSet.getString("bnkswiftno"));
				clsClientBean.setTxtibanno(resultSet.getString("ibanno"));
				clsClientBean.setTxtcity(resultSet.getString("bnkcity"));
				clsClientBean.setTxtcountry(resultSet.getString("bnkcountry"));
				clsClientBean.setTxtaccount(resultSet.getString("acc_no"));
				clsClientBean.setDocno(resultSet.getString("ac.cldocno"));
				clsClientBean.setTxtfinname(resultSet.getString("fin_name"));
				clsClientBean.setTxtfinaddress(resultSet.getString("fin_address"));
				clsClientBean.setTxtsalman(resultSet.getString("salname"));
				clsClientBean.setSalid(resultSet.getInt("salid"));
				clsClientBean.setChknontax(resultSet.getInt("nontax"));
				clsClientBean.setChkinterserv(resultSet.getInt("interserv"));
			}





		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtCPV0.close();
			conn.close();
		}

		return clsClientBean;
	}



}
