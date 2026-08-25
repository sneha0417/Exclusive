package com.dashboard.projectexecution.proformaInvoice;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;

import net.sf.json.JSONArray;

public class ClsProformaInvoiceDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();



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
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=common.convertToJSON(resultSet);
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


	public  JSONArray loadGridData(String uptodate,String branchid,String clientid,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;


			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and cm.cldocno="+clientid+"";
			}

			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
			{
				sqluptodate=common.changeStringtoSqlDate(uptodate);

			}
			else{

			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and cm.brhid in ("+branchid+")";
			}
			else{   
				sql11=sql11 +" ";       
			}

			if(id>0){	
				String sqldata="select convert(concat(pd.sr_no,'/',p.mcntr),char(50)) as dueno,pd.sr_no,cm.doc_no,cm.dtype,ac.acno as clacno,ac.doc_no as clientid,con.row_no as cpersonid,ac.refname client,si.site,coalesce(con.cperson,' ') cperson,"
						+ "cm.ref_type refdtype,cm.refno,cm.validfrom sdate,cm.validupto edate,round(pd.amount,2) cval, round(cm.legalchrg,2) lfee,"
						+ "cm.brhid brch,cm.tr_no,pd.duedate as duedate,round(cm.contractval,2) contractval from cm_srvcontrm cm left join (select tr_no,group_concat(site) site from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join my_crmcontact con on(cm.cpersonid=con.row_no) left join  "
						+ "cm_srvcontrpd   pd on(pd.tr_no=cm.tr_no and pd.dueafser=98) left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') "
						+ "left join (select count(*) mcntr,tr_no from cm_srvcontrpd group by tr_no) p on(p.tr_no=cm.tr_no)  where cm.status=3  and cm.jbaction in (0,4) and cm.date<='"+sqluptodate+"' "
						+ "and pstatus=1 and pinvno=0 "+sql11+" order by cm.dtype,cm.doc_no";

				System.out.println("==sqldata==="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=common.convertToJSON(resultSet);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}


	public ArrayList Insert (HttpSession session,HttpServletRequest request ,java.sql.Date date,String formcode,String mode,ArrayList invList,String descp) throws SQLException{



		ArrayList retList=new  ArrayList();


		Connection conn=null;
		CallableStatement stmt =null;
		int docNo=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,clacno=0,brch=0;
		String dtype="",refdtype="",otype="",client="";
		double contramt=0.0,legalfee=0.0;

		java.sql.Date duedate,sdate,edate;
		try{
			ClsProjectInvoiceDAO invDAO=new ClsProjectInvoiceDAO();
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt1 = conn.createStatement ();
			
			for(int i=0;i< invList.size();i++){


				String[] surveydet=((String) invList.get(i)).split("::");
				if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
				{



					tr_no=(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:Integer.parseInt(surveydet[0].trim()));
					doc_no=(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:Integer.parseInt(surveydet[1].trim()));
					dtype=(String) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim().toString());
					refdtype=(String) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim().toString());
					sdate= (Date) (surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:common.changetstmptoSqlDate(surveydet[4].toString().trim()));
					edate= (Date) (surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:common.changetstmptoSqlDate(surveydet[5].toString().trim()));
					contramt=(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:Double.parseDouble(surveydet[6].trim().toString()));
					duedate=(Date) (surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:common.changetstmptoSqlDate(surveydet[7].trim()));
					legalfee=(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?0:Double.parseDouble(surveydet[8].trim().toString()));
					clientid=(surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?0:Integer.parseInt(surveydet[9].trim()));
					cpersonid=(surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?0:Integer.parseInt(surveydet[10].trim()));
					brch=(surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:Integer.parseInt(surveydet[11].trim()));
					clacno=(surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:Integer.parseInt(surveydet[12].trim()));
					client=(String) (surveydet[13].trim().equalsIgnoreCase("undefined") || surveydet[13].trim().equalsIgnoreCase("NaN")|| surveydet[13].trim().equalsIgnoreCase("")|| surveydet[13].isEmpty()?0:surveydet[13].trim().toString());
					String cltax="0",inctax="0";
					ArrayList taxlist=new ArrayList();
					
					double nettotal=contramt+legalfee;
					
					String inctaxsql="select coalesce(inctax,0) inctax from cm_srvcontrm where tr_no='"+tr_no+"'";
					ResultSet rsinctax = stmt1.executeQuery(inctaxsql);

					while (rsinctax.next()) {
						inctax=rsinctax.getString("inctax");
					}
					
					taxlist=invDAO.getTax(session,nettotal,date,"0",clientid);
					
					if(inctax.equalsIgnoreCase("1")) {
						double taxamount=0.00;
						for(int m=0;m< taxlist.size();m++){

							String[] surveydets=((String) taxlist.get(m)).split("::");
							if(!(surveydets[0].trim().equalsIgnoreCase("undefined")|| surveydets[0].trim().equalsIgnoreCase("NaN")||surveydets[0].trim().equalsIgnoreCase("")|| surveydets[0].isEmpty()))
							{
								taxamount=((surveydets[3].equalsIgnoreCase("undefined") || surveydets[3].equalsIgnoreCase("NaN") || surveydets[3].isEmpty()?0.0:Double.parseDouble(surveydets[3])));
							}
						}
						contramt=contramt-taxamount;
					}
					
					stmt = conn.prepareCall("{CALL Sr_profinvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmt.registerOutParameter(20, java.sql.Types.INTEGER);
					stmt.registerOutParameter(21, java.sql.Types.INTEGER);
					stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
					stmt.setDate(1,date);
					stmt.setInt(2,tr_no);
					stmt.setInt(3, doc_no);
					stmt.setString(4,dtype);
					stmt.setString(5,refdtype);
					stmt.setDate(6,sdate);
					stmt.setDate(7,edate);
					stmt.setDouble(8,contramt);
					stmt.setDate(9,duedate);
					stmt.setDouble(10,legalfee);
					stmt.setInt(11,clientid);
					stmt.setInt(12,cpersonid);
					stmt.setInt(13,brch);
					stmt.setInt(14,clacno);
					stmt.setString(15, session.getAttribute("USERID").toString());
					stmt.setString(16,formcode);
					stmt.setString(17,mode);
					stmt.setString(18,client);
					stmt.setString(19,descp);
					int val = stmt.executeUpdate();
					docNo=stmt.getInt("docNo");
					vocno=stmt.getInt("vocNo");
					otype=stmt.getString("otype");

					request.setAttribute("docNo", docNo);

					retList.add(otype+":"+vocno);
					
					String clsql="select nontax from my_acbook where dtype='CRM' and cldocno='"+clientid+"'";
					ResultSet rscltax = stmt.executeQuery(clsql);

					while (rscltax.next()) {
						cltax=rscltax.getString("nontax");
					}

					if(cltax.equalsIgnoreCase("1")){
						
						for(int j=0;j< taxlist.size();j++){

							String[] surveydets=((String) taxlist.get(j)).split("::");
							if(!(surveydets[0].trim().equalsIgnoreCase("undefined")|| surveydets[0].trim().equalsIgnoreCase("NaN")||surveydets[0].trim().equalsIgnoreCase("")|| surveydets[0].isEmpty()))
							{

							
								String sql="INSERT INTO my_pinvtaxdet( rdocno, taxid,acno, per, amount)VALUES"
										+ " ("+(docNo)+","
										+ "'"+(surveydets[4].trim().equalsIgnoreCase("undefined") || surveydets[4].trim().equalsIgnoreCase("NaN")|| surveydets[4].trim().equalsIgnoreCase("")|| surveydets[4].isEmpty()?0:surveydets[4].trim())+"',"
										+ "'"+(surveydets[1].trim().equalsIgnoreCase("undefined") || surveydets[1].trim().equalsIgnoreCase("NaN")|| surveydets[1].trim().equalsIgnoreCase("")|| surveydets[1].isEmpty()?0:surveydets[1].trim())+"',"
										+ "'"+(surveydets[2].trim().equalsIgnoreCase("undefined") || surveydets[2].trim().equalsIgnoreCase("NaN")|| surveydets[2].trim().equalsIgnoreCase("")|| surveydets[2].isEmpty()?0:surveydets[2].trim())+"',"
										+ "'"+(surveydets[3].trim().equalsIgnoreCase("undefined") || surveydets[3].trim().equalsIgnoreCase("NaN")|| surveydets[3].trim().equalsIgnoreCase("")|| surveydets[3].isEmpty()?0:surveydets[3].trim())+"')";
								
								int rest = stmt.executeUpdate (sql);
								if(rest<=0)
								{
									conn.close();
								}

							}

						}
						
					}
				}

			}
			
			

			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}





		return retList;


	}


}
