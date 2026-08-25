package com.operations.marketing.enquiry;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.enquiry.ClsEnquiryBean;



public class ClsEnquiryDAO {
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();
	Connection conn;
	public int insert(Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client, 
			String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype, String telno,HttpServletRequest request,
			int Sourceid,String contactperson,int cpersonid,String cnt,int cmbprocess) throws SQLException {
		try{
			int docno;
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false); 
			
			
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtEnquiry.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,Sourceid);
			stmtEnquiry.setString(17,contactperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(21,cmbprocess);

			stmtEnquiry.executeQuery();
			docno=stmtEnquiry.getInt("docNo");
			int vocno=stmtEnquiry.getInt("vocNo");	
			request.setAttribute("vocno", vocno);

			if(docno<=0)
			{
				conn.close();
				return 0;
			}	
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				{
					/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
					String sql="INSERT INTO gl_enqd(sr_no, desc1, qty, remarks,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+"'"+docno+"')";

					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			if (docno > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}



	public boolean edit(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt,int cmbprocess) throws SQLException {

		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

		
			
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(20,0);
			stmtEnquiry.setInt(21,cmbprocess);
			int aaa=stmtEnquiry.executeUpdate();
			docno=stmtEnquiry.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			String delsql="Delete from gl_enqd where rdocno="+docno+"  ";
			stmtEnquiry.executeUpdate(delsql);
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				{

					String sql="INSERT INTO gl_enqd(sr_no, desc1, qty, remarks,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+"'"+docno+"')";

					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}

			/*	for(int i=0;i<enqarray.size();i++){

			     String[] enqiury=enqarray.get(i).split("::");
			     System.out.println("sdf"+enqarray.get(i).split("::"));
			     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
			     {
			    	  RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE
		     String sql="update  gl_enqd set SR_NO="+(i+1)+","
		     		   + "BRDID='"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
				       + "MODID='"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
				       + "SPEC='"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
				       + "CLRID='"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
				       + "RTYPE='"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
				       + "FRMDATE='"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[6].trim()))+"',"
				       + "TODATE='"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[7].trim()))+"',"
				       + "UNIT='"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"' where rdocno="+docno+"";

		     //System.out.println(""+sql);
		     int resultSet4 = stmtEnquiry.executeUpdate(sql);
		     if(resultSet4<=0)
             {
                 return false;
                } 
			     }

				     }
			 */

			if (aaa > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt) throws SQLException {

		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

		
			
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(20,0);

			int aaa=stmtEnquiry.executeUpdate();
			docno=stmtEnquiry.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			if (aaa > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}


	public    JSONArray searchrelode(String docno,HttpSession session) throws SQLException {

		//JSONArray RESULTDATA=new JSONArray();

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


		String brid=session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtrelode = conn.createStatement ();

			/*String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ");*/

			String resql="select sr_no, desc1 descritpion, qty, remarks,rdocno from gl_enqd eq where eq.rdocno='"+docno+"'";
			System.out.println("resql==="+resql);
			ResultSet resultSet = stmtrelode.executeQuery(resql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtrelode.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}
	/*public    JSONArray searchUnit() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();


		try {
				Connection conn = conobj.getMyConnection();
				Statement stmtunit = conn.createStatement ();

				ResultSet resultSet = stmtunit.executeQuery ("select unit,doc_no from my_unitm where status<>7;");

				RESULTDATA=com.convertToJSON(resultSet);
				stmtunit.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}*/
	public    JSONArray searchColor() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();

			ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color  where status<>7 order by  doc_no;");

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


	public JSONArray searchSource(HttpSession session) throws SQLException {

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



	public    List<ClsEnquiryBean> list4() throws SQLException {
		List<ClsEnquiryBean> list1Bean = new ArrayList<ClsEnquiryBean>();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt6 = conn.createStatement ();


			String tasql= ("select rentaltype from gl_tlistm where status=1;");
			//System.out.println("----------"+tasql);
			ResultSet resultSet5 = stmt6.executeQuery(tasql);
			while (resultSet5.next()) {

				ClsEnquiryBean bean = new ClsEnquiryBean();

				bean.setRentaltype(resultSet5.getString("rentaltype"));




				list1Bean.add(bean);
				//System.out.println(list1Bean);
			}
			stmt6.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return list1Bean;
	}




	public    JSONArray searchBrand() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

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

	public    JSONArray searchModel(String brandval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh3 = conn.createStatement ();

			String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid='"+brandval+"' and status<>7;");

			//System.out.println("========"+modelsql);

			ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh3.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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


		String brid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM' and status<>7  " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public    JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype) throws SQLException {


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


		//enqdate.trim();
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
		}






		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and voc_no like '%"+msdocno+"%'";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and name like '%"+clnames+"%'";
		}
		if(!(mobno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.mob like '%"+mobno+"%'";
		}

		if(!(enqtype.equalsIgnoreCase(""))){
			String enqtypeval="";
			if(enqtype.equalsIgnoreCase("general"))
			{
				enqtypeval="0";
			}
			else if(enqtype.equalsIgnoreCase("client"))
			{
				enqtypeval="1";
			}
			else
			{
			}

			sqltest=sqltest+" and enqtype like '%"+enqtypeval+"%'";
		}
		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select telno,m.doc_no,voc_no,m.date,remarks,m.cldocno,name,com_add1,ct.mob,ct.email,enqtype,sourceid,txtname as source,m.cperson,cpersonid,contrmode,m.sjobtype from gl_enqm m left join cm_enqsource s on(m.sourceid=s.doc_no) left join my_crmcontact ct on(ct.row_no=m.cpersonid) where m.status=3 and m.brhid="+brid+" " +sqltest);
			//System.out.println("========"+clssql);
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

	public   ClsEnquiryBean getPrint(int docno,HttpSession session) throws SQLException {
		ClsEnquiryBean bean = new ClsEnquiryBean();
		//  String brhid=session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtprint = conn.createStatement ();

			String resql=("Select e.voc_no,DATE_FORMAT(e.date,'%d.%m.%Y') AS date,e.name,e.com_add1,e.mob,e.email,if(e.enqtype=1,'Client','General') enqtype,contrmode  from gl_enqm e where e.doc_no='"+docno+"'  ");

			ResultSet pintrs = stmtprint.executeQuery(resql);


			while(pintrs.next()){
				// cldatails

				/* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/


				bean.setLblclient(pintrs.getString("name"));
				bean.setLblclientaddress(pintrs.getString("com_add1"));
				bean.setLblmob(pintrs.getString("mob"));
				bean.setLblemail(pintrs.getString("email"));
				//upper
				bean.setLbldate(pintrs.getString("date"));
				bean.setLbltypep(pintrs.getString("enqtype"));
				bean.setDocvals(pintrs.getInt("voc_no"));
				bean.setHidradio(pintrs.getString("contrmode"));
			}


			stmtprint.close();



			Statement stmtinvoice10 = conn.createStatement ();
			/*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_enqm r  "
					    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
			String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_enqm r inner join my_brch b on  "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
			//System.out.println("--------"+companysql);
			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 

			while(resultsetcompany.next()){

				bean.setLblbranch(resultsetcompany.getString("branchname"));
				bean.setLblcompname(resultsetcompany.getString("company"));

				bean.setLblcompaddress(resultsetcompany.getString("address"));

				bean.setLblcomptel(resultsetcompany.getString("tel"));

				bean.setLblcompfax(resultsetcompany.getString("fax"));
				bean.setLbllocation(resultsetcompany.getString("location"));


				bean.setLblcstno(resultsetcompany.getString("cstno"));

				bean.setLblservicetax(resultsetcompany.getString("stcno"));
				bean.setLblpan(resultsetcompany.getString("pbno"));


				// setLblcstno setLblservicetax setLblpan

			} 
			stmtinvoice10.close();


			conn.close();




		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;


	}
	public  ArrayList<String> getPrintdetails(int docno,HttpSession session) throws SQLException {
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn = null;
		// String brhid=session.getAttribute("BRANCHID").toString();
		try {
			conn = conobj.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			strSqldetail="select  desc1,qty,remarks   FROM gl_enqd eq   where eq.rdocno='"+docno+"' ";


			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;

			while(rsdetail.next()){

				String temp="";
				String spci="";
				
				temp=rowcount+"::"+rsdetail.getString("desc1")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("remarks");

				arr.add(temp);
				rowcount++;



			}
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return arr;
	}


	public JSONArray contactpersonSearch(HttpSession session,int clientid) throws SQLException
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
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno,email,c.mob from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			System.out.println("-------contactpersonSearch----------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
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


}
