package com.project.execution.completioncertificate;

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

public class ClsCompletionCertificateDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsCompletionCertificateBean bean= new ClsCompletionCertificateBean();
	Connection conn;

	public int insert(Date sqldate,String contracttype,int contractno,int clientid,String desc,String contrval,String certper,ArrayList<String> enqarray,
			HttpSession session,String mode,String dtype,HttpServletRequest request) throws SQLException {
	
		try{
			int docno;
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmt1 = conn.prepareCall("{call Sr_CompletionCertificateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt1.registerOutParameter(17, java.sql.Types.INTEGER);	
			stmt1.setDate(1,sqldate);
			stmt1.setString(2,contracttype);
			stmt1.setInt(3,contractno);	
			stmt1.setInt(4,clientid);
			stmt1.setString(5,desc);
			stmt1.setDouble(6,Double.parseDouble(contrval));
			stmt1.setDouble(7,Double.parseDouble(certper));
			stmt1.setInt(8,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
			stmt1.setInt(9,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmt1.setDouble(10,Double.parseDouble("0.00"));
			stmt1.setDouble(11,Double.parseDouble("0.00"));
			stmt1.setDouble(12,Double.parseDouble("0.00"));
			stmt1.setDate(13,null);
			stmt1.setString(14,"");
			stmt1.setDouble(15,Double.parseDouble("0.00"));
			stmt1.setString(16,mode);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			request.setAttribute("docno", docno);

			if(docno<=0)
			{
				conn.close();
				return 0;
			}	

			if (docno > 0) {
				conn.commit();
				stmt1.close();
				conn.close();
				return docno;
			}

			//return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	public int edit(int trno,int docno,Date sqldate,String contracttype,int contractno,int clientid,String desc,String contrval,String certper,ArrayList<String> enqarray,
			HttpSession session,String mode,String dtype,HttpServletRequest request) throws SQLException {
		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			CallableStatement stmt1 = conn.prepareCall("{call Sr_CompletionCertificateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt1.setDate(1,sqldate);
			stmt1.setString(2,contracttype);
			stmt1.setInt(3,contractno);	
			stmt1.setInt(4,clientid);
			stmt1.setString(5,desc);
			stmt1.setDouble(6,Double.parseDouble(contrval));
			stmt1.setDouble(7,Double.parseDouble(certper));
			stmt1.setInt(8,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
			stmt1.setInt(9,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmt1.setDouble(10,Double.parseDouble("0.00"));
			stmt1.setDouble(11,Double.parseDouble("0.00"));
			stmt1.setDouble(12,Double.parseDouble("0.00"));
			stmt1.setDate(13,null);
			stmt1.setString(14,"");
			stmt1.setDouble(15,Double.parseDouble("0.00"));
			stmt1.setString(16,mode);
			stmt1.setInt(17,docno);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			request.setAttribute("docno", docno);

			if(docno<=0)
			{
				conn.close();
				return 0;
			}	

			if (docno > 0) {
				conn.commit();
				stmt1.close();
				conn.close();
				return docno;
			}

			return docno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}



	public int delete(int trno,int docno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String nettotal,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist) throws SQLException {
		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement ();
			
			int protrno;
			String amount="0";
			String lfee="0";
			
			for(int i=0;i< enqarray.size();i++){
				String[] invdata=enqarray.get(i).split("::");
				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN"))? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN"))? "0": invdata[1].trim();
			}

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt1.registerOutParameter(26, java.sql.Types.INTEGER);	
			stmt1.setDate(1,sqldate);
			stmt1.setString(2,refno);
			stmt1.setString(3,contracttype);		
			stmt1.setString(4,client);
			stmt1.setString(5,clientdet);
			stmt1.setString(6,desc);
			stmt1.setString(7,dtype.trim());
			stmt1.setString(8,mode);
			stmt1.setString(9,clacno);
			stmt1.setInt(10,clientid);
			stmt1.setString(11,session.getAttribute("USERID").toString());
			stmt1.setString(12,branchid);
			stmt1.setString(13,session.getAttribute("COMPANYID").toString());
			stmt1.setInt(14,costid);
			stmt1.setString(15,amount);
			stmt1.setString(16,lfee);
			stmt1.setInt(17,contractno);
			stmt1.setString(18,nettotal);
			stmt1.setString(19,pdid);
			stmt1.setString(20,exptotal);
			stmt1.setString(21,txtnotes);
			stmt1.setString(22,ptype);
			stmt1.setDouble(23,taxamt);
			stmt1.setInt(24,trno);
			stmt1.setInt(25,docno);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");
			request.setAttribute("docno", docno);

			if(protrno>0){

				conn.commit();


			}

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmt1.close();
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

	public JSONArray contractSrearch(HttpSession session,String msdocno,String Cl_names,String contrval,String enqdate,String dtype,String ptype) throws SQLException {

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


		String sqltest="",sqltest1="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest=" and cm.date<='"+sqlStartDate+"'";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cm.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(contrval.equalsIgnoreCase("undefined"))&&!(contrval.equalsIgnoreCase(""))&&!(contrval.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cm.contractval like '%"+contrval+"%'";
		}
		if(!(dtype.equalsIgnoreCase("undefined"))&&!(dtype.equalsIgnoreCase(""))&&!(dtype.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and cm.dtype='"+dtype+"'";
		}

		Connection conn =null;
		Statement stmt = null;
		
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			String sqldata="select cm.doc_no,cm.tr_no,cm.date duedate,cm.cldocno clientid,ac.refname client,coalesce(ac.address,'') details,"
					+ "cm.contractval cval,round(cm.progper,2) reten,coalesce(invsum,0) invsum from cm_srvcontrm cm "
					+ "left join cm_compcert c on cm.tr_no=c.rdocno "
					+ "left join (select sum(inv) invsum,doc_no,rdocno from cm_compcert where status=3 group by rdocno) cc on cc.rdocno=c.rdocno "
					+ "left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' "
					+ "where  cm.status=3 and cm.invprog>0 "+sqltest+" group by cm.tr_no having invsum<cval";

			//System.out.println("======contractSrearch===="+sqldata);

			ResultSet resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray serviceGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

						
			sql="SELECT c.doc_no docno,c.date,round(c.contrval,2) amount,round(c.certper,2) percentage,round(c.inv,2) invoiced,"
					+ "round(c.rententionamt,2) retention,round(cm.progper,2) retnper FROM cm_compcert c left join cm_srvcontrm cm on cm.tr_no=c.rdocno where c.status=3 and c.rdocno="+trno+"";

			//System.out.println("===sql===="+sql);

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

	public JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String contno,String invdate,String invtype,int id) throws SQLException {

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

		java.sql.Date sqlStartDate=null;

		//invdate.trim();
		if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(invdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and c.doc_no="+msdocno+" ";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and cm.doc_no like '%"+contno+"%'";
		}

		if(!(invtype.equalsIgnoreCase(""))){
			
			sqltest=sqltest+" and c.dtype='"+invtype+"'";
		}
		if(!(sqlStartDate==null || sqlStartDate.equals("0") || sqlStartDate.equals("") || sqlStartDate.equals("undefined"))){   
			sqltest=sqltest+" and c.date='"+sqlStartDate+"'";
		} 

		Connection conn = null;
		String clssql="";
		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();
			
			if(id>0){
				clssql= ("select c.doc_no,cm.doc_no contno,c.date,c.dtype contype,c.cldocno,ac.refname client,cm.tr_no ctrno,"
						+ "round(cm.progper,2) reten,c.inv   from cm_compcert c "
						+ "left join cm_srvcontrm cm on cm.tr_no=c.rdocno "
						+ "left join my_acbook ac on(c.cldocno=ac.doc_no and ac.dtype='CRM') "
						+ "where c.status=3  "+sqltest+" " );
			}
			
			//System.out.println("===ccmain search====="+clssql);
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

	public ClsCompletionCertificateBean getViewDetails(HttpSession session,int trno,String branchid) throws SQLException {
		ClsCompletionCertificateBean ProinvBean = new ClsCompletionCertificateBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtPRIV = conn.createStatement();

			String branch = branchid;

			String ccsql="select c.doc_no,cm.doc_no contno,cm.tr_no contrno,c.date,c.dtype contype,c.cldocno,ac.refname client,ac.address details,c.rdocno,c.desc1,"
					+ "round(c.contrval,2) contrval,round(c.certper,2) certper  from cm_compcert c left join cm_srvcontrm cm on cm.tr_no=c.rdocno "
					+ "left join my_acbook ac on(c.cldocno=ac.doc_no and ac.dtype='CRM') where c.doc_no="+trno+"";	
			ResultSet resultSet = stmtPRIV.executeQuery (ccsql);

			while (resultSet.next()) {
				ProinvBean.setDocno(resultSet.getInt("doc_no"));
				ProinvBean.setDate(resultSet.getDate("date").toString());
				ProinvBean.setTxtclient(resultSet.getString("client"));
				ProinvBean.setTxtclientdet(resultSet.getString("details"));
				ProinvBean.setCmbcontracttype(resultSet.getString("contype"));
				ProinvBean.setDesc(resultSet.getString("desc1"));
				ProinvBean.setMaintrno(resultSet.getInt("doc_no"));
				ProinvBean.setClientid(resultSet.getInt("cldocno"));
				ProinvBean.setTxtrefdetails(resultSet.getString("contno"));
				ProinvBean.setTxtcontract(resultSet.getInt("contrno"));
				ProinvBean.setCertifyper(resultSet.getString("certper"));
				ProinvBean.setContrval(resultSet.getString("contrval"));
			}
			stmtPRIV.close();
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




}
