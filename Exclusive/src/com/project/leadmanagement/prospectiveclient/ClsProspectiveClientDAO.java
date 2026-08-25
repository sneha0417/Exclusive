package com.project.leadmanagement.prospectiveclient;

import java.io.File;
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
import javax.swing.filechooser.FileSystemView;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.project.leadmanagement.prospectiveclient.ClsProspectiveClientBean;










import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsProspectiveClientDAO {


	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsProspectiveClientBean bean=new ClsProspectiveClientBean();

	Connection conn;
	
	public int insert(Date sqldate,String txtname,String txtmob,String txtemail,int txtsalid,String desc,String branchid,ArrayList<String> cparrayList,HttpSession session,String mode,String dtype,HttpServletRequest request,String Txttelephone,
			String Txtfax,int areaid,int enqsourceid) throws SQLException {
		try{
			int docno;
			int protrno;
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			

			Statement stmtTest=conn.createStatement ();
			String testnameSql="SELECT NAME FROM cm_prosclientm where status<>7 and name='"+txtname+"' ";
			ResultSet resultSet1 = stmtTest.executeQuery (testnameSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			String testmobSql="SELECT mob FROM cm_prosclientm where status<>7 and mob='"+txtmob+"' and mob!=''";
			//System.out.println(testmobSql);
			ResultSet resultSetmob = stmtTest.executeQuery (testmobSql);
			if(resultSetmob.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			String testtelSql="SELECT tel FROM cm_prosclientm where status<>7 and tel='"+Txttelephone+"' and tel!='' ";
			ResultSet resultSettel = stmtTest.executeQuery (testtelSql);
			if(resultSettel.next()){
				stmtTest.close();
				conn.close();
				return -3;
			}
			String testmailSql="SELECT email FROM cm_prosclientm where status<>7 and email='"+txtemail+"' and email!='' ";
			ResultSet resultSetmail = stmtTest.executeQuery (testmailSql);
			if(resultSetmail.next()){
				stmtTest.close();
				conn.close();
				return -4;
			}
			
			
			
			CallableStatement stmtProsClient = conn.prepareCall("{call prospectiveClientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtProsClient.setDate(1,sqldate);
			stmtProsClient.setString(2,txtname);
			stmtProsClient.setString(3,txtmob);	
			stmtProsClient.setString(4,txtemail);
			stmtProsClient.setInt(5,txtsalid);
			stmtProsClient.setString(6,desc);
			stmtProsClient.setString(7,branchid);
			stmtProsClient.setString(8,mode);
			stmtProsClient.setString(9,dtype.trim());
			
			stmtProsClient.setString(10,session.getAttribute("USERID").toString());
			
			stmtProsClient.setString(11,session.getAttribute("COMPANYID").toString());

			stmtProsClient.setString(12,Txttelephone);
			stmtProsClient.setString(13,Txtfax);
			stmtProsClient.setInt(14,areaid);
			
			
			stmtProsClient.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtProsClient.registerOutParameter(16, java.sql.Types.INTEGER);
			
			stmtProsClient.setInt(17,enqsourceid);
			stmtProsClient.executeQuery();
			
			protrno=stmtProsClient.getInt("trno");
			docno=stmtProsClient.getInt("docno");
			request.setAttribute("documentno", docno);
			if(protrno>0)
			{
				int j=1;
				for(int i=0;i< cparrayList.size() ;i++){
					String[] cparray=((String) cparrayList.get(i)).split("::");
					int resultSettcl=0;
					String tclsql="";
					
					tclsql="INSERT INTO cm_prosclientd(rtrno,sr_no,cperson,mob,tel,extn,email,actvty_id) values('"+protrno+"',"+j+","
							+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							+"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							+ "'"+(cparray[5].trim().equalsIgnoreCase("undefined")||cparray[5]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[5].trim().equalsIgnoreCase("NaN")|| cparray[5].isEmpty()?0:cparray[5].trim())+"')";
							
					System.out.println("==cm_prosclientd===+"+tclsql);

					resultSettcl = stmtProsClient.executeUpdate (tclsql);
					j=j+1;
					if(resultSettcl<=0)
					{
						return 0; 
					}


				}
			}
			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmtProsClient.close();
				conn.close();
				return protrno;
			}

			return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	
	public int edit(int maintrno,String maindocno,Date sqldate,String txtname,String txtmob,
			String txtemail,int txtsalid,String desc,String branchid,ArrayList<String> cparrayList,
			HttpSession session,String mode,String dtype,HttpServletRequest request,String Txttelephone,
			String Txtfax,int areaid,int enqsourceid) throws SQLException {
		try{
				int docno;
			int protrno;
			 
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtdel = conn.createStatement ();
			
			Statement stmtTest=conn.createStatement ();
			String testSql="SELECT NAME FROM cm_prosclientm where status<>7 and name='"+txtname+"'  and doc_no<>"+maindocno+" ";
			System.out.println(testSql);
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			String testSqlmob="SELECT mob FROM cm_prosclientm where status<>7 and mob='"+txtmob+"'  and doc_no<>"+maindocno+" and mob!=''";
			System.out.println(testSqlmob);
			ResultSet resultSetmob = stmtTest.executeQuery (testSqlmob);
			if(resultSetmob.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			String testSqltel="SELECT tel FROM cm_prosclientm where status<>7 and tel='"+Txttelephone+"'  and doc_no<>"+maindocno+" and tel!=''";
			System.out.println(testSqltel);
			ResultSet resultSettel = stmtTest.executeQuery (testSqltel);
			if(resultSettel.next()){
				stmtTest.close();
				conn.close();
				return -3;
			}
			String testSqlmail="SELECT email FROM cm_prosclientm where status<>7 and email='"+txtemail+"'  and doc_no<>"+maindocno+" and email!=''";
			System.out.println(testSqlmail);
			ResultSet resultSetmail = stmtTest.executeQuery (testSqlmail);
			if(resultSetmail.next()){
				stmtTest.close();
				conn.close();
				return -4;
			}
			
			CallableStatement stmtProsClientedit = conn.prepareCall("{call prospectiveClientDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtProsClientedit.setDate(1,sqldate);
			stmtProsClientedit.setString(2,txtname);
			stmtProsClientedit.setString(3,txtmob);	
			stmtProsClientedit.setString(4,txtemail);
			stmtProsClientedit.setInt(5,txtsalid);
			stmtProsClientedit.setString(6,desc);
			stmtProsClientedit.setString(7,branchid);
			stmtProsClientedit.setString(8,mode);
			stmtProsClientedit.setString(9,dtype.trim());
			
			stmtProsClientedit.setString(10,session.getAttribute("USERID").toString());
			
			stmtProsClientedit.setString(11,session.getAttribute("COMPANYID").toString());

			stmtProsClientedit.setString(12,Txttelephone);
			stmtProsClientedit.setString(13,Txtfax);
			stmtProsClientedit.setInt(14,areaid);
			
			stmtProsClientedit.setInt(15, maintrno);
			stmtProsClientedit.setInt(16, Integer.parseInt(maindocno));
			stmtProsClientedit.setInt(17, enqsourceid);
			
			int datas=stmtProsClientedit.executeUpdate();
			
			protrno=stmtProsClientedit.getInt("trno");
			docno=stmtProsClientedit.getInt("docno");
			request.setAttribute("documentno", docno);
		//	System.out.println("protrno=="+protrno);
			if(protrno>0)
			{
				int rslt=0;
				String delsql="delete from cm_prosclientd where rtrno="+protrno+"";
				rslt=stmtdel.executeUpdate(delsql);
			//	System.out.println(rslt+"==="+delsql);
				
				int j=1;
				for(int i=0;i< cparrayList.size() ;i++){
					String[] cparray=((String) cparrayList.get(i)).split("::");
					int resultSettcl=0;
					String tclsql="";
					
					tclsql="INSERT INTO cm_prosclientd(rtrno,sr_no,cperson,mob,tel,extn,email,actvty_id) values('"+protrno+"',"+j+","
							+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
							+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
							+"'"+(cparray[2].equalsIgnoreCase("undefined")||cparray[2]==null || cparray[2].equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?0:cparray[2].trim())+"',"
							+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
							+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
							+ "'"+(cparray[5].trim().equalsIgnoreCase("undefined")||cparray[5]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[5].trim().equalsIgnoreCase("NaN")|| cparray[5].isEmpty()?0:cparray[5].trim())+"')";
							
					System.out.println("==cm_prosclientd===+"+tclsql);

					resultSettcl = stmtProsClientedit.executeUpdate (tclsql);
					j=j+1;
					if(resultSettcl<=0)
					{
						return 0; 
					}


				}
			
			}
			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmtdel.close();
				stmtProsClientedit.close();
				conn.close();
				return protrno;
			}

			return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}


	public int delete(int maintrno,String maindocno,Date sqldate,String txtname,String txtmob,String txtemail,int txtsalid,String desc,String branchid,ArrayList<String> cparrayList,HttpSession session,String mode,String dtype,HttpServletRequest request) throws SQLException{

		int docno;
		int protrno=0;
		Connection conn=null;

		conn=conobj.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmtProsClientdel = conn.prepareCall("{call prospectiveClientDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtProsClientdel.setDate(1,sqldate);
			stmtProsClientdel.setString(2,txtname);
			stmtProsClientdel.setString(3,txtmob);	
			stmtProsClientdel.setString(4,txtemail);
			stmtProsClientdel.setInt(5,txtsalid);
			stmtProsClientdel.setString(6,desc);
			stmtProsClientdel.setString(7,branchid);
			stmtProsClientdel.setString(8,mode);
			stmtProsClientdel.setString(9,dtype.trim());
			
			stmtProsClientdel.setString(10,session.getAttribute("USERID").toString());
			
			stmtProsClientdel.setString(11,session.getAttribute("COMPANYID").toString());

			stmtProsClientdel.setInt(12, maintrno);
			stmtProsClientdel.setInt(13, Integer.parseInt(maindocno));

			int datas=stmtProsClientdel.executeUpdate();
			
			protrno=stmtProsClientdel.getInt("trno");
			docno=stmtProsClientdel.getInt("docno");
			request.setAttribute("documentno", docno);

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				
				stmtProsClientdel.close();
				conn.close();
				return protrno;
			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

	return protrno;


	}


	public ClsProspectiveClientBean getViewDetails(HttpSession session,int trno) throws SQLException {
		ClsProspectiveClientBean ProinvBean = new ClsProspectiveClientBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtviewpc = conn.createStatement();

		//	String branch = branchid;

			String viewsql="select em.txtname emname,em.doc_no emdocno,pc.TR_NO,pc.DOC_NO,pc.dtype, pc.DATE,pc.brhid,pc.name,pc.mob,pc.email,pc.sal_id,"
					+ "pc.description,s.sal_name,pc.tel,pc.fax,pc.areaid,a.area as area,concat(city.city_name,',',c.country_name,',',r.reg_name) as area_det"
					+ " from cm_prosclientm pc left join my_salm s on s.doc_no=pc.sal_id "
					+ " left join my_area a on(pc.areaid=a.doc_no) left join my_acity city on(a.city_id=city.doc_no) "
					+ "left join my_acountry c on(c.doc_no=city.country_id) "
					+ "left join my_aregion r on(r.doc_no=c.reg_id) "
					+ "left join cm_enqsource em on (pc.enquiryid=em.doc_no) where pc.status=3 and pc.tr_no="+trno+" ";
			System.out.println("viewsql=="+viewsql);
			ResultSet resultSet = stmtviewpc.executeQuery (viewsql);
			
			while (resultSet.next()) {
				
				
				ProinvBean.setDocno(resultSet.getString("doc_no"));
				ProinvBean.setDate(resultSet.getDate("date").toString());
				ProinvBean.setTxtname(resultSet.getString("name"));
				ProinvBean.setTxtmob(resultSet.getString("mob"));
				ProinvBean.setTxtemail(resultSet.getString("email"));
				ProinvBean.setTxtsalesman(resultSet.getString("sal_name"));
				ProinvBean.setTxtsalid(resultSet.getInt("sal_id"));
				ProinvBean.setDesc(resultSet.getString("description"));
				ProinvBean.setMaintrno(resultSet.getInt("tr_no"));
				ProinvBean.setTxtfax(resultSet.getString("fax"));
				ProinvBean.setTxttelephone(resultSet.getString("tel"));
				ProinvBean.setTxtareaid(resultSet.getInt("areaid"));
				ProinvBean.setTxtareadet(resultSet.getString("area_det"));
				ProinvBean.setTxtarea(resultSet.getString("area"));
				ProinvBean.setTxtenqsource(resultSet.getString("emname"));
				ProinvBean.setTxtenqsourceid(resultSet.getInt("emdocno"));
						

			}
			stmtviewpc.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return ProinvBean;
	}



	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < arrayList.size(); i++) {

			JSONObject obj = new JSONObject();

			String[] Array=arrayList.get(i).split("::");

			obj.put("id",Array[0]);
			obj.put("description",Array[1]);
			obj.put("grpamt",Array[2]);
			obj.put("netamt",Array[3]);
			obj.put("childamt",Array[4]);
			obj.put("subchildamt",Array[5]);
			obj.put("parentid",Array[6]);
			obj.put("ordno",Array[7]);
			obj.put("groupno",Array[8]);
			obj.put("subac",Array[9]);
			obj.put("gp_id",Array[10]);

			jsonArray.add(obj);
		}
		return jsonArray;
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
	
	public   JSONArray cpGridload(HttpSession session,String trno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		
System.out.println("trno=="+trno);
		Connection conn =null;
		Statement cpstmt =null;

		try {
			conn = conobj.getMyConnection();
			cpstmt = conn.createStatement ();

			String  cpsql="select coalesce(cperson,'') as cpersion,coalesce(mob,'') as mobile,coalesce(email,'') email,coalesce(tel,'') as phone,"
					+ "coalesce(extn,'') extn,coalesce(ac.ay_name,'') as activity,actvty_id as activity_id from cm_prosclientd c  "
					+ "left join my_activity ac on ac.doc_no=c.actvty_id where c.rtrno="+trno+" order by c.sr_no";
			System.out.println("------------------------------"+cpsql);

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

public JSONArray salesmanDetailsSearch() throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = conobj.getMyConnection();
		       Statement stmtcalledby = conn.createStatement();
	
		     //   if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		        sql="select  coalesce(sal_name,'') salname,coalesce(mob_no,'') mob,doc_no from my_salm where status=3 ";
		        System.out.println("salesman sql===="+sql);
		       ResultSet resultSet = stmtcalledby.executeQuery(sql);
		       RESULTDATA=com.convertToJSON(resultSet);
	           
		       stmtcalledby.close();
		       conn.close();
		     //  }
		       stmtcalledby.close();
		     conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	  }

public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String salman,String cpdate) throws SQLException {


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



	java.sql.Date sqlcpDate=null;


	//enqdate.trim();
	if(!(cpdate.equalsIgnoreCase("undefined"))&&!(cpdate.equalsIgnoreCase(""))&&!(cpdate.equalsIgnoreCase("0")))
	{
		sqlcpDate = com.changeStringtoSqlDate(cpdate);
	}

	String sqltest="";
	if(!(msdocno.equalsIgnoreCase("")) && !(msdocno.equalsIgnoreCase("0"))){
		sqltest=sqltest+" and pc.doc_no="+msdocno+" ";
	}
	if(!(clnames.equalsIgnoreCase(""))&& !(clnames.equalsIgnoreCase("0"))){
		sqltest=sqltest+" and pc.name like '%"+clnames+"%'";
	}
	
	if(!(sqlcpDate==null)){
		sqltest=sqltest+" and pc.date='"+sqlcpDate+"'";
	} 
	if(!(salman.equalsIgnoreCase("")) && !(salman.equalsIgnoreCase("0"))){
		sqltest=sqltest+" and s.sal_name like '%"+salman+"%'";
	}
	


	Connection conn = null;

	try {
		conn = conobj.getMyConnection();
		Statement stmtenq1 = conn.createStatement ();

		String clssql= "select pc.tr_no,pc.doc_no,pc.date,pc.name,s.sal_name salname from cm_prosclientm pc left join my_salm s on s.doc_no=pc.sal_id "
				+ "where pc.status=3 and pc.brhid="+brid+""+sqltest;
		System.out.println("========"+clssql);
		ResultSet resultSet = stmtenq1.executeQuery(clssql);

		RESULTDATA=com.convertToJSON(resultSet);
		stmtenq1.close();
		conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;
}



/*
	public ClsProspectiveClientBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}

		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="";
		int contrno=0;
		String cntrtype="";
		String amount="0.00";
		String leglfee="0.00";
		String total="0.00";
		String description="";
		
		Connection conn = null;
		ArrayList sitelist=null;
		ArrayList trlist=null;
		ArrayList serlist=null;
		ArrayList paylist=null;
		try {
			sitelist= new ArrayList();
			trlist= new ArrayList();
			serlist= new ArrayList();
			paylist= new ArrayList();
			
			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();


			System.out.println("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");
			
			ResultSet resultSet = stmt.executeQuery ("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");

			
			while (resultSet.next()) {

				bean.setDocno(resultSet.getString("doc_no"));
				bean.setDate(resultSet.getString("date"));
				
				bean.setDesc(resultSet.getString("desp"));
				bean.setMaintrno(resultSet.getInt("tr_no"));
			
				bean.setTxtjobrefno(resultSet.getString("jobref"));
				bean.setTxtemail(resultSet.getString("email"));
				bean.setTxtmob(resultSet.getString("mob"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));

				
				contrno=resultSet.getInt("costid");
				cntrtype=resultSet.getString("costtype");
				amount=resultSet.getString("atotal");
				leglfee=resultSet.getString("legalchrg");
				total=resultSet.getString("total");

			}
			System.out.println("contrno==="+contrno);
			String contrsql="select coalesce(con.cperson,'') cperson,coalesce(con.tel,'') tel from cm_srvcontrm cm "
					+ "left join my_crmcontact con on cm.cpersonid= con.row_no where cm.tr_no="+contrno+" ";
		//	System.out.println("contrsql==="+contrsql);
ResultSet rscon = stmt.executeQuery(contrsql);
		
			String st="select "+total+" tot,@i:=@i+1 srno,a.* from ( select 'Contract Payment' as des,"+amount+" as amt "
					+ " union all"
					+ " select 'Civil Defense Contract Charges' as des,"+leglfee+" as amt)a, "
					+ "(select @i:=0) r" ;
			System.out.println("======st=========="+st);
			
			
			String sql1="select  IF(description IS NULL or description = '', '     ', description) description from cm_srvcontrpd "
					+ " where tr_no="+contrno+" and dueafser=98";

			ResultSet rs = stmt.executeQuery(sql1);
			
			while(rs.next()){
				description=rs.getString("description");
			}
			
			
			
			if(Double.parseDouble(total)>0){
				
				serlist.add("1"+"::"+cntrtype+"::"+"Contract Payment "+"::"+amount+"::"+description);
				
				
				serlist.add("2"+"::"+"DCD"+"::"+"Civil Defense Contract Charges "+"::"+leglfee+"::"+description);
				
				
				serlist.add(""+"::"+""+"::"+"Total "+"::"+total);
				
				serlist.add(""+"::"+""+"::"+"Total Job Value "+"::"+total);
				serlist.add(""+"::"+""+"::"+"Total invoiced (incl.this invoice) "+"::"+total);
				serlist.add(""+"::"+""+"::"+"Balance to be invoiced "+"::"+"0.00");
				
			}
		
			
			
			String csql="select round(p.amount,2) invamt,p.count as srno, mxrno ,round(balance,2) balance,round(total,2) total from "
					+ "(select sum(invamt) amount,count(*) as count,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno>0) p "
					+ "left join (select sum(amount) as total,tr_no,max(sr_no) as mxrno from cm_srvcontrpd where tr_no="+contrno+") as a on(a.tr_no=p.tr_no) "
					+ "left join (select sum(amount) as balance,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno<=0) as b on(b.tr_no=p.tr_no) "
					+ "where p.tr_no="+contrno+"";
			
			System.out.println("=====invoicedetails===="+csql);
			
			ResultSet crs = stmt.executeQuery(csql);
			int serno=1;
			if(crs.next()){
				
				String temp="";
				
				paylist.add("Invoice "+crs.getString("srno")+" of "+crs.getString("mxrno")+"");
				paylist.add("Total Job Value "+"::"+crs.getString("total"));
				paylist.add("Total invoiced (incl.this invoice) "+"::"+crs.getString("invamt"));
				paylist.add("Balance to be invoiced "+"::"+crs.getString("balance"));
				
		
				
				serno=serno+1;
			}
		

			String sql="select  groupname area,g.doc_no areaid,site,upper(concat(site,',',groupname)) as sited from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+contrno+"";

//			System.out.println("===sitelist==="+sql);

			ResultSet rs2 = stmt.executeQuery(sql);
			String site="";
			String temp="";
			while(rs2.next()){


				site=rs2.getString("sited")+"::"+site;

				temp=site.trim();
				
			}
			
	
				
				sitelist.add(temp);
				bean.setSitelist(sitelist);

			

			String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+msdocno+" order by terms";

//			System.out.println("==sql2===="+sql2);
			
			ResultSet rs3 = stmt.executeQuery(sql2);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			temp="";
			while(rs3.next()){


				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=trcount+")"+rs3.getString("conditions");
				temp=testing+"::"+cond;	

				trlist.add(temp);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);
			
			
			
			
			String str1="select '1' as qty,round(atotal,2) unitamount,description descp, "
					+ "round(atotal,2) amount,'' total from my_serpvm   where tr_no="+trno+" "
					+ " union all "
					+ " select '1' as qty,round(legalchrg,2) as unitamount,'Civil Defence Contract Charges' as descp, "
					+ " round(legalchrg,2) as amount,(round(atotal,2)+round(legalchrg,2)) as "
					+ " total from my_serpvm   where tr_no="+trno+";";
			bean.setProinvqry(str1);
			//System.out.println("=====bean.setProinvqry(str1)======"+bean.getProinvqry());
			stmt.close();
			conn.close();
		}

		catch(Exception e){
			
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;
	}*/

public  JSONArray getEnquirySource(HttpSession session) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;
	try {
		conn = conobj.getMyConnection();
		Statement stmtVehclr = conn.createStatement ();

		ResultSet resultSet = stmtVehclr.executeQuery ("SELECT txtname,doc_no FROM cm_enqsource c where status=3");

		RESULTDATA=com.convertToJSON(resultSet);
		stmtVehclr.close();
		conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;

}
}
