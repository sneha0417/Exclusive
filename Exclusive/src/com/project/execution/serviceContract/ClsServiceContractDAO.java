package com.project.execution.serviceContract;

import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.project.execution.quotation.ClsQuotationBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsServiceContractDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsServiceContractBean bean=new ClsServiceContractBean();

	public JSONArray paymentGrid(HttpSession session,String date,String enddate,String txtinstnos,String txtamount,String gridload,String cmbfrequency,String txtdueafter) throws SQLException {


		JSONArray jsonArray = new JSONArray();


		if(!gridload.equalsIgnoreCase("1")){

			return jsonArray;
		}


		Connection conn = null; 

		try {


			java.sql.Date xdate=null;
			java.sql.Date fdate=null;
			java.sql.Date endsdate=null;

			double xtotal=0.0;
			double amount=0.0;
			int xsrno=0;

			date.trim();

			gridload=gridload.trim();


			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				xdate = com.changeStringtoSqlDate(date);
				fdate = com.changeStringtoSqlDate(date);
			}

			enddate.trim();
			if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
				endsdate = com.changeStringtoSqlDate(enddate);
			}

			String xsql="";


			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();



			Double txtinstamt=Double.parseDouble(txtamount)/Integer.parseInt(txtinstnos);
			xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			do							
			{	
				++xsrno;

				if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;

				int sr_no= xsrno;							
				int actualNoOfInst=xsrno;

				amount=((xtotal+txtinstamt)>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):txtinstamt);
				xtotal+=amount;

				JSONObject obj = new JSONObject();
				obj.put("sr_no",String.valueOf(sr_no));
				/*&& !(xdate.after(endsdate)) && !(xdate.before(endsdate)*/
				if(!(xdate==null)){
					obj.put("duedate",xdate.toString());
					/*obj.put("amount",String.valueOf(amount));
					obj.put("runtotal",String.valueOf(xtotal));*/
				}
				obj.put("amount",String.valueOf(amount));
				obj.put("runtotal",String.valueOf(xtotal));
				/*obj.put("amount",String.valueOf(amount));
				obj.put("runtotal",String.valueOf(xtotal));*/

				jsonArray.add(obj);

				if(xtotal>=Double.parseDouble(txtamount)) break;

//				System.out.println("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");

				ResultSet rs = stmt.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");
				if(rs.next()) xdate=rs.getDate("fdate");

				rs.close();
			}while(true);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}

	public JSONArray serviceScheduleGrid(HttpSession session,String date,String enddate,String txtinstnos,String txtamount,String gridload,String cmbfrequency,String txtdueafter) throws SQLException {


		JSONArray jsonArray = new JSONArray();


		//		System.out.println("===inside serviceScheduleGrid=====");


		if(!gridload.equalsIgnoreCase("1")){

			return jsonArray;
		}


		Connection conn = null; 

		try {


			java.sql.Date xdate=null;
			java.sql.Date fdate=null;
			java.sql.Date endsdate=null;

			double xtotal=0.0;
			double amount=0.0;
			int xsrno=0;

			date.trim();

			gridload=gridload.trim();


			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				xdate = com.changeStringtoSqlDate(date);
				fdate = com.changeStringtoSqlDate(date);
			}

			enddate.trim();
			if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
				endsdate = com.changeStringtoSqlDate(enddate);
			}

			String xsql="";


			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();



			Double txtinstamt=Double.parseDouble(txtamount)/Integer.parseInt(txtinstnos);
			xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			do							
			{	
				++xsrno;

				if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;

				int sr_no= xsrno;							
				int actualNoOfInst=xsrno;

				amount=((xtotal+txtinstamt)>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):txtinstamt);
				xtotal+=amount;

				JSONObject obj = new JSONObject();
				obj.put("sr_no",String.valueOf(sr_no));

				if(!(xdate==null) || !(endsdate.after(xdate))){
					obj.put("pldate",xdate.toString());
				}
				/*obj.put("amount",String.valueOf(amount));
					obj.put("runtotal",String.valueOf(xtotal));
				 */
				jsonArray.add(obj);

				if(xsrno>Integer.parseInt(txtinstnos)) break;

//				System.out.println("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");

				ResultSet rs = stmt.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+xdate+"')))) fdate ");
				if(rs.next()) xdate=rs.getDate("fdate");

				rs.close();
			}while(true);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsonArray;
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
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
						+ " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
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


			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
					//System.out.println("------------------"+sql);
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

	public int insert(java.sql.Date date,java.sql.Date stdate,java.sql.Date enddate,java.sql.Date findate,java.sql.Date serdate,int clientid,int cpersonid,
			int isleagal,String reftype,String refvocno,int refdocno,String legaldoc,
			String legalamt,String cntrinterval,String taxper,String paytype,String paydue,String instalmnts,String serdue,
			String srvtype,String amount,String budget,String incentive,String saleinc,ArrayList paylist,ArrayList sitelist,ArrayList servlist,
			ArrayList serclist,HttpSession session,HttpServletRequest request,String mode,String formcode,String payinter,String serinter,
			int isproforma,int salid,int editval,int istax,int iserv,String txtrefno,int chkinv,String splinstruct,
			String cmbprog,String progperiod,String progper,int cmbprocess,String txtthresholdlimit,String txtpartlimitperc) throws SQLException{

		Connection conn=null;
		int docNo=0;
		int vocno=0;
		int tranid=0;
		try{


			if(legalamt==null){
				legalamt="0";
			} else if(legalamt.trim().equalsIgnoreCase("")){   
				legalamt="0";
			} else {}
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(37, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(38, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setInt(3, cpersonid);
			stmt.setDate(4,stdate);
			stmt.setDate(5,enddate);
			stmt.setInt(6,isleagal);
			stmt.setString(7,reftype);
			stmt.setString(8,refvocno);
			stmt.setInt(9,refdocno);
			stmt.setString(10,legaldoc);
			stmt.setString(11, legalamt);
			stmt.setString(12, amount);
			stmt.setString(13, taxper);
			stmt.setString(14, cntrinterval);
			stmt.setString(15, paytype);
			stmt.setDate(16,findate);
			stmt.setString(17, instalmnts);
			stmt.setString(18, srvtype);
			stmt.setDate(19,serdate);
			stmt.setString(20, incentive);
			stmt.setString(21, saleinc);
			stmt.setString(22, mode);
			stmt.setString(23, formcode);
			stmt.setString(24, session.getAttribute("BRANCHID").toString());
			stmt.setString(25, session.getAttribute("USERID").toString());
			stmt.setString(26, paydue=="" || paydue==null || paydue.equalsIgnoreCase("")?"0":paydue);
			stmt.setString(27, serdue=="" || serdue==null || serdue.equalsIgnoreCase("")?"0":serdue);
			stmt.setString(28, payinter=="" || payinter==null || payinter.equalsIgnoreCase("")?"0":payinter);
			stmt.setString(29, serinter=="" || serinter==null || serinter.equalsIgnoreCase("")?"0":serinter); 
			stmt.setInt(30,isproforma);
			stmt.setInt(31,salid);
			stmt.setInt(32,editval);
			stmt.setInt(33,istax);
			stmt.setInt(34,iserv);
			stmt.setString(35,txtrefno);
			stmt.setInt(36,chkinv);
			stmt.setString(39,splinstruct);
			stmt.setString(40, cmbprog=="" || cmbprog==null || cmbprog.equalsIgnoreCase("")?"0":cmbprog);
			stmt.setInt(41, progperiod=="" || progperiod==null || progperiod.equalsIgnoreCase("")?0:Integer.parseInt(progperiod));
			stmt.setDouble(42, progper=="" || progper==null || progper.equalsIgnoreCase("")?0.00:Double.parseDouble(progper));
			stmt.setInt(43, cmbprocess);
			stmt.setString(44,txtthresholdlimit.trim().equalsIgnoreCase("")?"0":txtthresholdlimit);
			stmt.setString(45,txtpartlimitperc.trim().equalsIgnoreCase("")?"0":txtpartlimitperc);
			stmt.setString(46, budget=="" ||budget==null || budget.equalsIgnoreCase("")?"0":budget );
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< sitelist.size();i++){


					String[] surveydet=((String) sitelist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_srvcsited(sr_no, site, areaId, siteadd, contactid,srvteamno,tr_no)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+docNo+"')";

						//						System.out.println("==sitelist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< paylist.size();i++){


					String[] surveydet=((String) paylist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{	

						if (surveydet[4].equalsIgnoreCase("LEGAL DOCUMENT")) {
							surveydet[5]="99";
						}
						if (surveydet[4].equalsIgnoreCase("SERVICE")) {
							surveydet[5]=surveydet[6];
						}
						if (surveydet[4].equalsIgnoreCase("PROFORMA INVOICE")) {
							surveydet[5]="98";
						}


						String sql="INSERT INTO cm_srvcontrpd(sr_no,dueDate, amount,runtotal, description,terms,dueafser,serviceno,tr_no)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?"":surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?"":surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+ "'"+(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:surveydet[6].trim())+"',"
								+"'"+docNo+"')";


						//						System.out.println("====sql====="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}


				for(int i=0;i< servlist.size();i++){

					String[] surveydet=((String) servlist.get(i)).split("::");



					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{		

						String sql="INSERT INTO cm_srvcontrd(sr_no,servId,Equips, qty, Amount,total,description, tr_no)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"":surveydet[5].trim())+"',"
								+"'"+docNo+"')";


						//						System.out.println("====sql====="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}

				/*String sql1 = "";
				int siteid=0;

				sql1="select rowno from  cm_srvcsited where tr_no="+docNo+"";

				ResultSet resultSet1 = stmt.executeQuery(sql1);
				while(resultSet1.next()){
					siteid=resultSet1.getInt("rowno");
					list.add(siteid);

				}*/
				String sql1 ="";
				int siteid=0;
				int steamno=0;
				int serstatus=3;
				//System.out.println("serclist ="+serclist);
				if(iserv>0){

					for(int i=0;i< serclist.size();i++){

						String[] surveydet=((String) serclist.get(i)).split("::");

						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
						{	


							sql1 ="";
							siteid=0;
							steamno=0;
							serstatus=3;
							sql1="select rowno,srvteamno from  cm_srvcsited where tr_no="+docNo+" and sr_no="+surveydet[4].trim()+"";
						    ResultSet resultSet1 = stmt.executeQuery(sql1);
							while(resultSet1.next()){
								siteid=resultSet1.getInt("rowno");
								steamno=resultSet1.getInt("srvteamno");

							}
							/*
							if(steamno>0)
								{
									serstatus=4;
								}
							*/
							
							//System.out.println("***********Type 1***********"+surveydet[4]+"==="+surveydet[7]);
							
							String sql="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno,servid,servamt,refTrNo,doc_No,refdocno,siteid,status,iserv,serinv, cldocno,empGroupId,type)VALUES"
									+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
									+ " "+(i+1)+","
									+ "'"+(formcode)+"',"
									+ " "+(session.getAttribute("BRANCHID").toString())+","
									+ "'"+(formcode)+"',"
									+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
									+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
									+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
									+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
									+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
									+ " "+(docNo)+","
									+ " "+(docNo)+","
									+ " "+(vocno)+","
									+ " "+siteid+","
									+ " "+serstatus+","
									+ " 1,"
									+ " "+chkinv+","
									+"'"+clientid+"',"
									+ " "+steamno+","
									+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:surveydet[7].trim())+"')";


							int resultSet2 = stmt.executeUpdate (sql);
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}	

						}



					}
				}
				else{

					ArrayList list=new ArrayList();
					ArrayList liststeam=new ArrayList();

					sql1="select rowno,srvteamno from   cm_srvcsited where tr_no="+docNo+"";

					//				System.out.println("==sql1=cm_srvcsited==="+sql1);

					ResultSet resultSet1 = stmt.executeQuery(sql1);
					while(resultSet1.next()){
						siteid=resultSet1.getInt("rowno");
						steamno=resultSet1.getInt("srvteamno");
						list.add(siteid);
						liststeam.add(steamno);
						
						//System.out.println("steamno=="+steamno);

					}
					System.out.println("liststeam=="+liststeam);
					for(int k=0;k< list.size();k++){

						for(int i=0;i< serclist.size();i++){

							String[] surveydet=((String) serclist.get(i)).split("::");
							if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
							{		
							/*	
					if(Integer.parseInt(liststeam.get(k).toString())>0)
								{
									serstatus=4;
								} 
								*/
								
								
								//System.out.println("***********Type 2***********"+surveydet[4]+"==="+surveydet[7]);
								

								String sql="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno, refTrNo,doc_No,refdocno,siteid,status, cldocno,empGroupId,type)VALUES"
										+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
										+ " "+(i+1)+","
										+ "'"+(formcode)+"',"
										+ " "+(session.getAttribute("BRANCHID").toString())+","
										+ "'"+(formcode)+"',"
										+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
										+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
										+ " "+(docNo)+","
										+ " "+(docNo)+","
										+ " "+(vocno)+","
										+ " "+list.get(k)+","
										+ " '"+serstatus+"',"
										+"'"+clientid+"',"
										+ ""+liststeam.get(k)+","
										+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"')";



								//							System.out.println("====sql====="+sql);

								int resultSet2 = stmt.executeUpdate (sql);
								if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}	

							}

						}

					}

				}



				conn.commit();
			}

		}

		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return vocno;
	}


	public JSONArray serviceteamSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,grpcode team from cm_serteamm where status=3";


			//			System.out.println("===sql===="+sql);

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


	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


			//			System.out.println("===sql===="+sql);

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
	
	public JSONArray assignfrm(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select grpcode,doc_no  from cm_serteamm where status=3";


			//			System.out.println("===sql===="+sql);

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


	public JSONArray assignteam(HttpSession session,int assignid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";


			//			System.out.println("===sql===="+sql);

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


	public JSONArray serviceType(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



			//			System.out.println("===sql===="+sql);

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

	public JSONArray serviceSite(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname site,codeno,doc_no docno from my_groupvals where grptype='site' and status=3";



			//			System.out.println("===sql===="+sql);

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


	public JSONArray serviceScheudleGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select plannedOn pldate, plTime pltime,type,s.site,p.priorno as priority,coalesce(grpcode,'') as asgngrp,coalesce(e.name,'') as emp, "
					+ "coalesce(gr.groupname,'') asgnmode,coalesce(p.remarks,'') desc1,coalesce(gs.groupname,'') as service,p.servid as serviceid,coalesce(p.servamt,0.0) as value,DAYname(date_format(plannedOn,'%Y-%m-%d')) as days,p.tr_no trno from  cm_servplan p "
					+ "left join cm_srvcsited s on(p.siteid=s.rowno) left join cm_serteamm m on(p.empgroupid=m.doc_no) "
					+ "left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm e on(md.empid=e.doc_no) "
					+ "left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') "
					+ "where p.reftrno='"+doc_no+"' and p.dtype='AMC' and p.brhid="+brhid+"";

			//System.out.println("===serviceScheudleGridLoad two===="+sql);

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


	public JSONArray serviceGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select groupname stype,doc_no stypeid, d.description desc1, Equips item, qty,round(Amount,2) as amount,round(total,2) as total,d.tr_no trno,d.sr_no srno from "
					+ "cm_srvcontrd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') where tr_no='"+doc_no+"'";

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


	public JSONArray serRefGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select groupname stype,g.doc_no stypeid, d.description desc1, concat(site,' : ',equips) item, qty,round(d.Amount,2) as amount,round(d.total,2) as total from "
					+ "cm_srvqotm m left join cm_srvqotd d on m.tr_no=d.tr_no and m.revision_no = d.revision_no left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) "
					+ "where m.tr_no="+doc_no+"";

			//			System.out.println("===sql===="+sql);

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

	public JSONArray siteRefGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select  groupname area,g.doc_no areaid,site,refrowno rowno  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+doc_no+"";

//			System.out.println("===siteRefGridLoad===="+sql);

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



	public JSONArray payGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select b.*,@i:=@i+amount runtotal from (select dueDate, amount,  description desc1, DueAfSer dueser, runtotal,terms,termsid,if(terms='SERVICE',dueafser,0) service,rowno,invtrno "
					+ "from cm_srvcontrpd where tr_no='"+doc_no+"') b,(select @i:=0) i";

						//System.out.println("===payment gridsql===="+sql);

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

	public JSONArray siteGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select  groupname area,g.doc_no areaid,site,siteadd,cperson contper,tel contmob,contactid contid,d.rowno,d.srvteamno steamid,stm.grpcode serviceteam from  cm_srvcsited  d "
					+ "left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') left join my_crmcontact c on(c.row_no=d.contactid) "
					+ " left join cm_serteamm stm on d.srvteamno=stm.doc_no where tr_no='"+doc_no+"'";

			//			System.out.println("===sql==siteGridLoad=="+sql);

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

	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_names,String Cl_enqno,String surdate,String dtype,int id,String cl_area,String cl_site) throws SQLException {


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


		String sqltest="";
		if(!(surdate.equalsIgnoreCase("undefined"))&&!(surdate.equalsIgnoreCase(""))&&!(surdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(surdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_enqno.equalsIgnoreCase("undefined"))&&!(Cl_enqno.equalsIgnoreCase(""))&&!(Cl_enqno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.ref_type like '%"+Cl_enqno+"%'";
		}

		if(!(cl_site.equalsIgnoreCase("undefined"))&&!(cl_site.equalsIgnoreCase(""))&&!(cl_site.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and d.site like '%"+cl_site+"%'";
		}

		if(!(cl_area.equalsIgnoreCase("undefined"))&&!(cl_area.equalsIgnoreCase(""))&&!(cl_area.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and g.groupname like '%"+cl_area+"%'";
		}


		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			if(id>0){

				String str1Sql=("select m.tr_no,m.doc_no,m.date,m.dtype,m.ref_type reftype,ac.refname as name,ac.doc_no as clientid,groupname area,g.doc_no areaid,site,d.rowno as siteid,coalesce(pd.pytno,0) pytno,m.jbaction,m.brhid from  cm_srvcontrm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join cm_srvcsited  d on(m.tr_no=d.tr_no) left join my_groupvals g on(d.areaid=g.doc_no and grptype='area')"
						+ " left join (select tr_no,if(invtrno=0,0,1) pytno from cm_srvcontrpd) pd on pd.tr_no=m.tr_no "
						+ " where m.status!=7 and m.brhid="+brid+" and m.dtype='AMC' "+sqltest+" group by d.rowno");


				//System.out.println("==refmainsearch==="+str1Sql);

				ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
			}
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public ClsServiceContractBean getViewdetails(HttpSession session,HttpServletRequest request,int doc_no,String dpdocno) throws SQLException{

		Connection conn=null;
		try { 
			conn = conobj.getMyConnection();
			Statement stmt  = conn.createStatement ();
			String brhid=session.getAttribute("BRANCHID").toString();


			String sqls="select tr_no,m.doc_no,m.date,round(netAmount,2) as netAmount,m.cldocno,validfrom,validupto,finstdate,noofinsts,m.ref_type,serinterval,trim(address) address,"
					+ "per_mob,trim(mail1) mail1,"
					+ "serdueafter,fservdate,cpersonid,instdueafter,instduetype,serduetype,round(incentive,2) incentive,round(salincentive,2) as salincentive ,round(contractval,2) as contractval,m.ref_type"
					+ " reftype,ac.refname as name,ac.doc_no as clientid,c.cperson,islegal,round(taxper,2) as taxper,m.cpersonid,"
					+ "round(legalchrg,2) as legalchrg,refdocno,reftrno,sm.sal_name as salname,sm.doc_no as salid,m.inctax,m.iser,"
					+ "m.refno,m.serinv,m.splinstruct, m.invprog, m.progperiod, round(m.progper,2) progper,m.sjobtype,m.thresholdlimit,m.partlimitperc from  cm_srvcontrm m left join my_acbook ac "
					+ "on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_crmcontact c on(m.cpersonid=c.row_no) left join my_salm sm on(sm.doc_no=m.sal_id) where m.doc_no="+dpdocno+" and m.brhid="+brhid+" and m.dtype='AMC'";

		   //System.out.println("===getViewdetails===="+sqls);

			ResultSet resultSet = stmt.executeQuery(sqls);    

			while (resultSet.next()) {

				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setDocno(resultSet.getString("doc_no"));
				bean.setMasterdoc_no(resultSet.getInt("tr_no"));
				bean.setDate(resultSet.getString("date"));
				bean.setTxtclient(resultSet.getString("name"));
				bean.setTxtcontact(resultSet.getString("cperson"));
				bean.setCpersonid(resultSet.getInt("cpersonid"));
				bean.setStdate(resultSet.getString("validfrom"));
				bean.setEnddate(resultSet.getString("validupto"));
				bean.setCmbreftype(resultSet.getString("ref_type"));
				bean.setIslegaldoc(resultSet.getInt("islegal"));
				bean.setSalesincentive(resultSet.getString("salincentive"));
				bean.setIncentive(resultSet.getString("incentive"));
				bean.setTxtcntrval(resultSet.getString("contractval"));
				bean.setTxttaxper(resultSet.getString("taxper"));
				bean.setTemp1(resultSet.getString("legalchrg"));
				/*bean.setTemp2();*/
				bean.setInstallments(resultSet.getString("noofinsts"));
				bean.setPaydueafter(resultSet.getString("instdueafter"));
				bean.setCmbpaytype(resultSet.getString("instduetype"));
				bean.setFinsdate(resultSet.getString("finstdate"));
				bean.setTxtrefno(resultSet.getString("refno"));
				bean.setSrvcinterval(resultSet.getString("serinterval"));
				bean.setSerdueafter(resultSet.getString("serdueafter"));
				bean.setCmbsrvctype(resultSet.getString("serduetype"));
				bean.setSerdate(resultSet.getString("fservdate"));

				bean.setRrefno(resultSet.getString("refdocno"));
				bean.setRefmasterdoc_no(resultSet.getInt("reftrno"));

				bean.setTxtclientdet(resultSet.getString("address"));
				bean.setTxtmob2(resultSet.getString("per_mob"));
				bean.setTxtemail(resultSet.getString("mail1"));
				bean.setTxtsalman(resultSet.getString("salname"));
				bean.setSalid(resultSet.getInt("salid"));

				bean.setChkincltax(resultSet.getInt("inctax"));
				bean.setChkserv(resultSet.getInt("iser"));
				bean.setChkinv(resultSet.getInt("serinv")); 
				bean.setTxtsplinstruct(resultSet.getString("splinstruct"));
				bean.setCmbprog(resultSet.getString("invprog")); 
				bean.setTxtprogperiod(resultSet.getString("progperiod"));
				bean.setTxtprogper(resultSet.getString("progper"));
				bean.setHidcmbprocess(resultSet.getInt("sjobtype"));
				bean.setTxtthresholdlimit(resultSet.getString("thresholdlimit"));
				bean.setTxtpartlimitperc(resultSet.getString("partlimitperc"));
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return bean;

	}



	public int edit(int docNo,int vocno, java.sql.Date date,java.sql.Date stdate,java.sql.Date enddate,java.sql.Date findate,java.sql.Date serdate,int clientid,int cpersonid,
			int isleagal,String reftype,String refvocno,int refdocno,String legaldoc,
			String legalamt,String cntrinterval,String taxper,String paytype,String paydue,String instalmnts,String serdue,
			String srvtype,String amount,String budget,String incentive,String saleinc,ArrayList paylist,ArrayList sitelist,ArrayList servlist,
			ArrayList serclist,HttpSession session,HttpServletRequest request,String mode,String formcode,String payinter,
			String serinter,int isproforma,int salid,int editval,int istax,int iserv,String txtrefno,int chkinv,String splinstruct,
			String cmbprog,String progperiod,String progper,int cmbprocess,String txtthresholdlimit,String txtpartlimitperc) throws SQLException{

		
		System.out.println("progper======"+progper);
		Connection conn=null;
		int srvschedins=0;
		int tranid=0;
		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			Statement stmnt=conn.createStatement();
			String serint="",serduea="",serduet="";
			java.sql.Date srvdates=null;
			
			if(legalamt==null){
				legalamt="0";
			} else if(legalamt.trim().equalsIgnoreCase("")){
				legalamt="0";
			} else {}
			
			if(iserv==0){
			String selsqls="select serinterval,serdueafter,serduetype,fservdate from cm_srvcontrm where tr_no="+docNo+"";
			ResultSet resultdel = stmnt.executeQuery(selsqls);
			while(resultdel.next()){
				serint=resultdel.getString("serinterval");
				serduea=resultdel.getString("serdueafter");
				serduet=resultdel.getString("serduetype");
				srvdates=resultdel.getDate("fservdate");

			}
		
			if((serdue.equalsIgnoreCase(serduea) && serinter.equalsIgnoreCase(serint) && srvtype.equalsIgnoreCase(serduet) && serdate.equals(srvdates)))
			{
				srvschedins=2;
			}
			else{
				srvschedins=1;
			}
			}
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setInt(3, cpersonid);
			stmt.setDate(4,stdate);
			stmt.setDate(5,enddate);
			stmt.setInt(6,isleagal);
			stmt.setString(7,reftype);
			stmt.setString(8,refvocno);
			stmt.setInt(9,refdocno);
			stmt.setString(10,legaldoc);
			stmt.setString(11, legalamt);
			stmt.setString(12, amount);
			stmt.setString(13, taxper);
			stmt.setString(14, cntrinterval);
			stmt.setString(15, paytype);
			stmt.setDate(16,findate);
			stmt.setString(17, instalmnts);
			stmt.setString(18, srvtype);
			stmt.setDate(19,serdate);
			stmt.setString(20, incentive);
			stmt.setString(21, saleinc);
			stmt.setString(22, mode);
			stmt.setString(23, formcode);
			stmt.setString(24, session.getAttribute("BRANCHID").toString());
			stmt.setString(25, session.getAttribute("USERID").toString());
			stmt.setString(26, paydue=="" || paydue==null || paydue.equalsIgnoreCase("")?"0":paydue);
			stmt.setString(27, serdue=="" || serdue==null || serdue.equalsIgnoreCase("")?"0":serdue);
			stmt.setString(28, payinter=="" || payinter==null || payinter.equalsIgnoreCase("")?"0":payinter);
			stmt.setString(29, serinter=="" || serinter==null || serinter.equalsIgnoreCase("")?"0":serinter);
			stmt.setInt(30, isproforma);
			stmt.setInt(31, salid);
			stmt.setInt(32, editval);
			stmt.setInt(33,istax);
			stmt.setInt(34,iserv);
			stmt.setString(35,txtrefno);
			stmt.setInt(36,chkinv);
			stmt.setInt(37, docNo);
			stmt.setInt(38, vocno);
			stmt.setString(39,splinstruct);
			stmt.setString(40, cmbprog=="" || cmbprog==null || cmbprog.equalsIgnoreCase("")?"0":cmbprog);
			stmt.setInt(41, progperiod=="" || progperiod==null || progperiod.equalsIgnoreCase("")?0:Integer.parseInt(progperiod));
			stmt.setDouble(42, progper=="" || progper==null || progper.equalsIgnoreCase("")?0.00:Double.parseDouble(progper));
			stmt.setInt(43, cmbprocess);
			stmt.setString(44,txtthresholdlimit.trim().equalsIgnoreCase("")?"0":txtthresholdlimit);
			stmt.setString(45,txtpartlimitperc.trim().equalsIgnoreCase("")?"0":txtpartlimitperc);
			stmt.setString(46, budget=="" ||budget==null || budget.equalsIgnoreCase("")?"0":budget );
			
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){

				if(editval>0){
				//	System.out.println("==sitelist.size(==="+sitelist.size());
					for(int i=0;i<sitelist.size();i++){

						String[] surveydet=((String) sitelist.get(i)).split("::");
					//	System.out.println("==sitedet0==="+surveydet[0]);
						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
						{
						//	System.out.println("==sitedet4==="+surveydet[4]);
							if(!(surveydet[4].trim().equalsIgnoreCase("undefined")|| surveydet[4].trim().equalsIgnoreCase("NaN")||surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()))
							{
							String sql3="update cm_srvcsited set site='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
									+ "areaId='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
									+ "siteadd='"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
									+ "contactid='"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
									+ "srvteamno='"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"'"
									+ " where tr_no='"+docNo+"' and rowno="+surveydet[4].trim()+" ";
							
						//System.out.println("==sitelist-update==="+sql3);

							int result = stmt.executeUpdate(sql3);

							}
							else{
								
								String sqlsn="INSERT INTO cm_srvcsited(sr_no, site, areaId, siteadd, contactid,srvteamno,tr_no)VALUES"
										+ " ("+(i+1)+","
										+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
										+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
										+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
										+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
										+"'"+docNo+"')";

								//System.out.println("==sitelist-insert==="+sqlsn);

								int res = stmt.executeUpdate (sqlsn);
								System.out.println("==res-insert==="+res);
								if(res<=0)
								{
									conn.close();
									return 0;
								}
								
							}

						}

					}

					String delpyt="delete from cm_srvcontrpd where tr_no='"+docNo+"'";
					int delval=stmt.executeUpdate (delpyt);
					for(int i=0;i< paylist.size();i++){


						String[] surveydet=((String) paylist.get(i)).split("::");
						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
						{		

							if (surveydet[4].equalsIgnoreCase("LEGAL DOCUMENT")) {
								surveydet[5]="99";
							}
							if (surveydet[4].equalsIgnoreCase("SERVICE")) {
								surveydet[5]=surveydet[6];
							}
							if (surveydet[4].equalsIgnoreCase("PROFORMA INVOICE")) {
								surveydet[5]="98";
							}
							String sqlpyt="INSERT INTO cm_srvcontrpd(sr_no,dueDate, amount,runtotal, description,terms,dueafser,serviceno,tr_no)VALUES"
									+ " ("+(i+1)+","
									+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
									+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
									+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"":surveydet[2].trim())+"',"
									+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?"":surveydet[3].trim())+"',"
									+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?"":surveydet[4].trim())+"',"
									+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
									+ "'"+(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:surveydet[6].trim())+"',"
									+"'"+docNo+"')";
							//System.out.println("==payment-insert==="+sqlpyt);
							int resultSet2 = stmt.executeUpdate (sqlpyt);
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}	

						}

					}


					for(int i=0;i< servlist.size();i++){

						String[] surveydet=((String) servlist.get(i)).split("::");
						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
						{	
							
							if(!(surveydet[6].trim().equalsIgnoreCase("undefined")|| surveydet[6].trim().equalsIgnoreCase("NaN")||surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()))
							{
								String sqlservup="update cm_srvcontrd set servId='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
										+ "Equips='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ " qty='"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
										+ " Amount='"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
										+ "total='"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
										+ "description='"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"'"
										+ " where tr_no="+surveydet[6].trim()+" and sr_no="+surveydet[7].trim()+"";
								int res = stmt.executeUpdate(sqlservup);
							}
						else{
							String sql="INSERT INTO cm_srvcontrd(sr_no,servId,Equips, qty, Amount,total,description, tr_no)VALUES"
									+ " ("+(i+1)+","
									+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
									+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
									+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
									+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
									+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
									+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
									+"'"+docNo+"')";


							//						System.out.println("====sql====="+sql);

							int resultSet2 = stmt.executeUpdate (sql);
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}	
						}
						}

					}

					String sql1 ="";
					int siteid=0;
					int steamno=0;
					int serstatus=3;
					if(iserv>0){
//System.out.println("iserv=="+iserv);
						for(int i=0;i< serclist.size();i++){

							String[] surveydet=((String) serclist.get(i)).split("::");

							if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
							{	
								if(!(surveydet[6].trim().equalsIgnoreCase("undefined")|| surveydet[6].trim().equalsIgnoreCase("NaN")||surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()))
								{	

									sql1 ="";
									siteid=0;

									String sql="update cm_servplan set date='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
											+ "plannedOn='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
											+ "plTime='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',  "
											+ "priorno='"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"', "
											+ "type='"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:surveydet[7].trim())+"'"
                                            + "  where doc_no="+(docNo)+" and tr_no="+surveydet[6].trim()+"";
									

									//System.out.println("serplanupdate=="+sql);
									int resultSet2 = stmt.executeUpdate (sql);
								
								
								}
								else{
									
									sql1 ="";
									siteid=0;
									steamno=0;
									serstatus=3;
									sql1="select rowno,srvteamno from  cm_srvcsited where tr_no="+docNo+" and sr_no="+surveydet[4].trim()+"";
									//System.out.println("sitesqll=="+sql1);
									ResultSet resultSet1 = stmt.executeQuery(sql1);
									while(resultSet1.next()){
										siteid=resultSet1.getInt("rowno");
										steamno=resultSet1.getInt("srvteamno");
										//System.out.println("siteid=="+siteid);

									}
/*
									if(steamno>0)
									{
										serstatus=4;
									}
*/

									String sql="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno,servid,servamt,refTrNo,doc_No,refdocno,siteid,status,iserv, cldocno,empGroupId,type)VALUES"
											+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
											+ " "+(i+1)+","
											+ "'"+(formcode)+"',"
											+ " "+(session.getAttribute("BRANCHID").toString())+","
											+ "'"+(formcode)+"',"
											+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
											+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
											+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
											+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
											+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
											+ " "+(docNo)+","
											+ " "+(docNo)+","
											+ " "+(vocno)+","
											+ " "+siteid+","
											+ " "+serstatus+","
											+ " 1,"
											+"'"+clientid+"',"
											+ ""+steamno+","
											+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:surveydet[7].trim())+"')";

									//System.out.println("serplaninsert=="+sql);
									int resultSet2 = stmt.executeUpdate (sql);
									if(resultSet2<=0)
									{
										conn.close();
										return 0;
									}	
									
								}

							}



						}
					}
					else{  //normal service scheduler
						String srvrownos="";
						
						for(int i=0;i<sitelist.size();i++){

							String[] surveydet=((String) sitelist.get(i)).split("::");
						//	System.out.println("==sitedet0==="+surveydet[0]);
							if(!(surveydet[4].trim().equalsIgnoreCase("undefined")|| surveydet[4].trim().equalsIgnoreCase("NaN")||surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()))
							{
								srvrownos=srvrownos+surveydet[4].trim()+",";
								}
							}
						String subsrv=srvrownos.trim();
						ArrayList listsite=new ArrayList();
						ArrayList liststeam=new ArrayList();
						int siteidrow=0;
						if(!subsrv.equalsIgnoreCase(""))
						{
						subsrv = subsrv.substring(0, subsrv.length()-1);
						
						//System.out.println(subsrv);
						
						String sql123="select rowno,srvteamno from cm_srvcsited where tr_no="+docNo+" and rowno not in("+subsrv+")";

					//System.out.println("==rowno==="+sql123);

						ResultSet resultrow = stmt.executeQuery(sql123);
						while(resultrow.next()){
							siteidrow=resultrow.getInt("rowno");
							steamno=resultrow.getInt("srvteamno");
							listsite.add(siteidrow);
							liststeam.add(steamno);
						}
						}
						if(listsite.size()>0 && srvschedins==2)
						{
							//System.out.println(listsite);
							for(int k=0;k<listsite.size();k++){
								//System.out.println("serclist.size()==="+serclist.size());
								for(int i=0;i< Integer.parseInt(serint);i++){

									String[] surveydet=((String) serclist.get(i)).split("::");
									if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
									{	
								//System.out.println("surveydet[3].trim()="+surveydet[3].trim());
/*
										if(Integer.parseInt(liststeam.get(k).toString())>0)
										{
											serstatus=4;
										}
*/
										
										String sql1s="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno, refTrNo,doc_No,refdocno,siteid,status, cldocno,empGroupId,type)VALUES"
												+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ " "+(i+1)+","
												+ "'"+(formcode)+"',"
												+ " "+(session.getAttribute("BRANCHID").toString())+","
												+ "'"+(formcode)+"',"
												+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
												+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
												+ " "+(docNo)+","
												+ " "+(docNo)+","
												+ " "+(vocno)+","
												+ " "+listsite.get(k)+","
												+ " '"+serstatus+"',"
												+"'"+clientid+"',"
												+ ""+liststeam.get(k)+","
												+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"')";
										//System.out.println("sqlinserttttt==="+sql1s);
										int resul2 = stmt.executeUpdate (sql1s);
										if(resul2<=0)
										{
											conn.close();
											return 0;
										}	
							
									}

								}

							}
						
						}
						
						
						if(srvschedins==1)
						{
							ArrayList list=new ArrayList();
							ArrayList liststeam1=new ArrayList();

							sql1="select rowno,srvteamno from cm_srvcsited where tr_no="+docNo+"";

						//System.out.println("==rowno==="+sql1);

							ResultSet resultSet1 = stmt.executeQuery(sql1);
							while(resultSet1.next()){
								siteid=resultSet1.getInt("rowno");
								steamno=resultSet1.getInt("srvteamno");
								list.add(siteid);
								liststeam1.add(steamno);

							}
							//System.out.println("===different===");
							String delsql="Delete from cm_servplan where doc_no="+docNo+"";
							int rsd = stmt.executeUpdate (delsql);
						
							//System.out.println("list.size()==="+list.size());
							for(int k=0;k<list.size();k++){
								//System.out.println("serclist.size()==="+serclist.size());
								for(int i=0;i< serclist.size();i++){

									String[] surveydet=((String) serclist.get(i)).split("::");
									if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
									{	
								//System.out.println("surveydet[3].trim()="+surveydet[3].trim());
/*

if(Integer.parseInt(liststeam1.get(k).toString())>0)
								{
									serstatus=4;
								}
*/
								//System.out.println("liststeam1.get(k)===="+liststeam1.get(k));
										String sql1s="INSERT INTO cm_servplan(date,sr_no,dTYPE, brhid, ref_type, plannedOn, plTime,priorno, refTrNo,doc_No,refdocno,siteid,status, cldocno,empGroupId,type)VALUES"
												+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ " "+(i+1)+","
												+ "'"+(formcode)+"',"
												+ " "+(session.getAttribute("BRANCHID").toString())+","
												+ "'"+(formcode)+"',"
												+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
												+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
												+ " "+(docNo)+","
												+ " "+(docNo)+","
												+ " "+(vocno)+","
												+ " "+list.get(k)+","
                                                + " '"+serstatus+"',"
										        +"'"+clientid+"',"
										        + ""+liststeam1.get(k)+","
										        + "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"')";
										//System.out.println("sqlinserttttt==="+sql1s);
										int resul2 = stmt.executeUpdate (sql1s);
										if(resul2<=0)
										{
											conn.close();
											return 0;
										}	
										
								

									}

								}

							}
						
							
						}
						else if(srvschedins==2 && listsite.size()==0){
							//System.out.println("===same===");
							for(int i=0;i< serclist.size();i++){

								String[] surveydet=((String) serclist.get(i)).split("::");
								if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
								{	
									if(!(surveydet[3].trim().equalsIgnoreCase("undefined")|| surveydet[3].trim().equalsIgnoreCase("NaN")||surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()))
									{
										//System.out.println("surveydet[1].trim()="+surveydet[1].trim());
										String sqlck="update cm_servplan set date='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ " plannedOn='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:com.changetstmptoSqlDate(surveydet[0].trim()))+"',"
												+ " plTime='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
												+ "priorno='"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN:NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
												+ "type='"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"'"
												+ " where doc_no="+(docNo)+" and tr_no="+surveydet[3].trim()+" ";
										//System.out.println("sqlck="+sqlck);
										
										int rs = stmt.executeUpdate(sqlck);
										
										 if(rs<=0)
										{
											//System.out.println("=== inside error === ");
											conn.close();
											return 0;
										}
										// conn.close();
								}
							
								}

							}

													
					}		

					}

				}
				//System.out.println("=== before commit == ");
				conn.commit();
			}
		}

		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return vocno;
	}


	public int Delete(int docNo,int vocno, java.sql.Date date,java.sql.Date stdate,java.sql.Date enddate,java.sql.Date findate,java.sql.Date serdate,int clientid,int cpersonid,
			int isleagal,String reftype,String refvocno,int refdocno,String legaldoc,
			String legalamt,String cntrinterval,String taxper,String paytype,String paydue,String instalmnts,String serdue,
			String srvtype,String amount,String budget,String incentive,String saleinc,ArrayList paylist,ArrayList sitelist,ArrayList servlist,
			ArrayList serclist,HttpSession session,HttpServletRequest request,String mode,String formcode,String payinter,
			String serinter,int isproforma,
			int salid,int editval,int istax,int iserv,String txtrefno,int chkinv,String splinstruct,String cmbprog,String progperiod,String progper,int cmbprocess,String txtthresholdlimit,String txtpartlimitperc) throws SQLException{

		Connection conn=null;

		int tranid=0;
		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			if(legalamt==null){
				legalamt="0";
			} else if(legalamt.trim().equalsIgnoreCase("")){
				legalamt="0";
			} else {}
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setInt(3, cpersonid);
			stmt.setDate(4,stdate);
			stmt.setDate(5,enddate);
			stmt.setInt(6,isleagal);
			stmt.setString(7,reftype);
			stmt.setString(8,refvocno);
			stmt.setInt(9,refdocno);
			stmt.setString(10,legaldoc);
			stmt.setString(11, legalamt);
			stmt.setString(12, amount);
			stmt.setString(13, taxper);
			stmt.setString(14, cntrinterval);
			stmt.setString(15, paytype);
			stmt.setDate(16,findate);
			stmt.setString(17, instalmnts);
			stmt.setString(18, srvtype);
			stmt.setDate(19,serdate);
			stmt.setString(20, incentive);
			stmt.setString(21, saleinc);
			stmt.setString(22, mode);
			stmt.setString(23, formcode);
			stmt.setString(24, session.getAttribute("BRANCHID").toString());
			stmt.setString(25, session.getAttribute("USERID").toString());
			stmt.setString(26, paydue);
			stmt.setString(27, serdue);
			stmt.setString(28, payinter);
			stmt.setString(29, serinter);
			stmt.setInt(30, isproforma);
			stmt.setInt(31, salid);
			stmt.setInt(32, editval);
			stmt.setInt(33,istax);
			stmt.setInt(34,iserv);
			stmt.setString(35,txtrefno);
			stmt.setInt(36,chkinv);
			stmt.setInt(37, docNo);
			stmt.setInt(38, vocno); 
			stmt.setString(39,splinstruct);
			stmt.setString(40, cmbprog=="" || cmbprog==null || cmbprog.equalsIgnoreCase("")?"0":cmbprog);
			stmt.setInt(41, progperiod=="" || progperiod==null || progperiod.equalsIgnoreCase("")?0:Integer.parseInt(progperiod));
			stmt.setDouble(42, progper=="" || progper==null || progper.equalsIgnoreCase("")?0.00:Double.parseDouble(progper));
			stmt.setInt(43, cmbprocess);
			stmt.setString(44,txtthresholdlimit.trim().equalsIgnoreCase("")?"0":txtthresholdlimit);
			stmt.setString(45,txtpartlimitperc.trim().equalsIgnoreCase("")?"0":txtpartlimitperc);
			stmt.setString(46, budget=="" ||budget==null || budget.equalsIgnoreCase("")?"0":budget );
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){

				conn.commit();

			}

		}

		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return vocno;
	}


	public JSONArray refSearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,String dtype,String formcode) throws SQLException {

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


		String sqltest="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
		}
		if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.cldocno="+clientid+"";
		}



		Connection conn =null;
		Statement stmt = null;
		String str1Sql="";
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(dtype.equalsIgnoreCase("ENQ")){

				if(!(formcode.equalsIgnoreCase("undefined"))&&!(formcode.equalsIgnoreCase(""))&&!(formcode.equalsIgnoreCase("0"))){
					sqltest=sqltest+" and m.contrmode='"+formcode+"'";
				}

				str1Sql=("select m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
						+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
						+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
						+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob from gl_enqm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid)"
						+ " where 1=1 and cntrtrno=0 and m.status=3  and qottrno=0 "+sqltest+"");
			}
			if(dtype.equalsIgnoreCase("SQOT")){

				if(!(formcode.equalsIgnoreCase("undefined"))&&!(formcode.equalsIgnoreCase(""))&&!(formcode.equalsIgnoreCase("0"))){
					sqltest=sqltest+" and m.cntr_type='"+formcode+"'";
				}

				str1Sql=("select m.date,m.tr_no doc_no,m.doc_no voc_no, ac.refname as name,coalesce(ac.doc_no,0) as clientid, "
						+ "concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'')) as details, "
						+ " c.cperson as cperson,coalesce(c.row_no,0) as cpersonid, "
						+ "c.mob as contmob,round(m.legalchrg,2) as legchrg,round(coalesce(m.total,0.0),2) as cntrval,m.chklegal from cm_srvqotm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) "
						+ "where 1=1 and cntrtrno=0 and m.status=3 "+sqltest+"");
			}

			//System.out.println("======str1Sql===="+str1Sql);

			ResultSet resultSet = stmt.executeQuery (str1Sql);
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

	

	public ClsServiceContractBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


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
		Connection conn = null;
		ArrayList list=null;
		ArrayList trlist=null;
		ArrayList sitelist=null;
		ArrayList serlist=null;
		ArrayList schlist=null;
		ArrayList paylist=null;
		try {
			list= new ArrayList();
			trlist= new ArrayList();
			sitelist= new ArrayList();
			serlist= new ArrayList();
			schlist= new ArrayList();
			paylist = new ArrayList();
			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();
				
			
			String preparedby="select u.user_id from my_user u left join cm_srvcontrm s on u.doc_no=s.userId where s.doc_no=1";
			ResultSet rsPreBy = stmt.executeQuery(preparedby);
			while (rsPreBy.next()) {
				bean.setPreparedby("user_id");
				
			}
			String sqls="select tr_no,m.doc_no,DATE_FORMAT(m.date,'%d/%m/%Y') as date,round(netAmount,2) as netAmount,m.cldocno,validfrom,validupto,finstdate,noofinsts,m.ref_type,serinterval,trim(ac.address) address,"
					+ "per_mob,trim(mail1) mail1,"
					+ "serdueafter,fservdate,cpersonid,instdueafter,instduetype,serduetype,round(incentive,2) incentive,round(salincentive,2) as salincentive ,round(contractval,2) as contractval,m.ref_type"
					+ " reftype,ac.refname as name,ac.doc_no as clientid,c.cperson,islegal,round(taxper,2) as taxper,m.cpersonid,round(legalchrg,2) as legalchrg,refdocno,reftrno,sm.sal_name as salname,"
					+ "sm.doc_no as salid,cur.code as code,b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,cur.code,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, curtime() as curtime,m.refno "
					+ " from  cm_srvcontrm m left join my_acbook ac "
					+ "on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_crmcontact c on(m.cpersonid=c.row_no) left join my_salm sm on(sm.doc_no=m.sal_id)"
					+ "left join my_curr cur on(cur.doc_no=ac.curid) "
					+ "left join my_brch b on(b.doc_no=m.brhid)  left join my_comp com on(com.doc_no=b.cmpid) where tr_no="+trno+" and m.brhid="+brhid+" and m.dtype='"+dtype+"'";

			//System.out.println("===inside print getViewdetails===="+sqls);

			ResultSet resultSet = stmt.executeQuery(sqls);    

			while (resultSet.next()) {

				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setDocno(resultSet.getString("doc_no"));
				bean.setMasterdoc_no(resultSet.getInt("tr_no"));
				bean.setDate(resultSet.getString("date"));
				bean.setTxtclient(resultSet.getString("name"));
				bean.setTxtcontact(resultSet.getString("cperson"));
				bean.setCpersonid(resultSet.getInt("cpersonid"));
				bean.setStdate(resultSet.getString("validfrom"));
				bean.setEnddate(resultSet.getString("validupto"));
				bean.setCmbreftype(resultSet.getString("ref_type"));
				bean.setIslegaldoc(resultSet.getInt("islegal"));
				bean.setSalesincentive(resultSet.getString("salincentive"));
				bean.setIncentive(resultSet.getString("incentive"));
				bean.setTxtcntrval(resultSet.getString("contractval"));
				bean.setTxttaxper(resultSet.getString("taxper"));
				bean.setTemp1(resultSet.getString("legalchrg"));
				/*bean.setTemp2();*/
				bean.setInstallments(resultSet.getString("noofinsts"));
				bean.setPaydueafter(resultSet.getString("instdueafter"));
				bean.setCmbpaytype(resultSet.getString("instduetype"));
				bean.setFinsdate(resultSet.getString("finstdate"));

				bean.setSrvcinterval(resultSet.getString("serinterval"));
				bean.setSerdueafter(resultSet.getString("serdueafter"));
				bean.setCmbsrvctype(resultSet.getString("serduetype"));
				bean.setSerdate(resultSet.getString("fservdate"));

				bean.setRrefno(resultSet.getString("refdocno"));
				bean.setRefmasterdoc_no(resultSet.getInt("reftrno"));
				bean.setTxtrefno(resultSet.getString("refno"));
				bean.setTxtclientdet(resultSet.getString("address"));
				bean.setTxtmob2(resultSet.getString("per_mob"));
				bean.setTxtemail(resultSet.getString("mail1"));
				bean.setTxtsalman(resultSet.getString("salname"));
				bean.setSalid(resultSet.getInt("salid"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				//bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));
				bean.setLblfinaltime(resultSet.getString("curtime"));

			//fire7
				bean.setMaintnchrg(resultSet.getString("netAmount"));
			}
			ClsAmountToWords caw=new ClsAmountToWords();
			bean.setMaintnchrginword(caw.convertAmountToWords(bean.getMaintnchrg()));
			//System.out.println(bean.getMaintnchrginword());
			
			String ppm="select @i:=@i+1 srno, a.* from(select coalesce(groupname,'') stype,'3 Months' maintfreq,'4 Times' yrlyvst,doc_no stypeid, Equips item "
					+ " from cm_srvcontrd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') where tr_no="+trno+")a,(select @i:=0)r";
bean.setPpmqry(ppm);

			//System.out.println("======ppm========="+ppm);
			/*String prepared="select u.user_id  user from my_user u left join cm_srvcontrm s on u.doc_no=s.userId where s.doc_no="+msdocno+" ";
			ResultSet pb=stmt.executeQuery(prepared);
			//String preby="";
			while(pb.next())
			{
				//preby=pb.getString("user");
			//	bean.setPreparedby(pb.getString("user"));
				System.out.println("========bean.setPreparedby(user_id)====="+bean.getPreparedby()+",,,,"+prepared);
			}*/
			String sql="select  groupname area,g.doc_no areaid,site,upper(site) site,upper(groupname) as area from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+trno+"";

			ResultSet rs2 = stmt.executeQuery(sql);
			String site="";
			int siteno=1;
			while(rs2.next()){
				if(siteno==1){
					bean.setFirstSite(rs2.getString("site")+"::"+rs2.getString("area"));
				}
				site=siteno+"::"+rs2.getString("site")+"::"+rs2.getString("area");
				sitelist.add(site);
				siteno=siteno+1;
			}		
			
			bean.setSitelist(sitelist);
			
			
			
			
			ResultSet rsarea = stmt.executeQuery(sql);
			String st1="";
			if(rsarea.first())
			{
				 st1="Location ("+rsarea.getString("area")+")";
			}
			
			bean.setArea(st1);

			String sql3="select @id:=@id+1 srno,a.* ,concat(stype,'(',p.count,' service/Year)') pstype from (select groupname stype,doc_no stypeid, d.description desc1, Equips item, qty,round(Amount,2) as amount,round(total,2) as total from "
					+ "cm_srvcontrd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') where tr_no="+trno+")a,(select @id:=0)m ,(select count(*) count from cm_servplan where doc_no="+trno+") p";

			//System.out.println("===sitesql===="+sql3);
bean.setServiceqry(sql3);
			ResultSet rs4 = stmt.executeQuery(sql3);
			String service="";
			int serno=1;
			while(rs4.next()){

				service=serno+"::"+rs4.getString("stype")+"::"+rs4.getString("desc1")+"::"+rs4.getString("item")+"::"+rs4.getString("qty")+"::"+rs4.getString("amount")+"::"+rs4.getString("total")+"::"+rs4.getString("pstype");

				serlist.add(service);
				serno=serno+1;
			}



			bean.setSerlist(serlist);



			String sql4="select count(*) as count,DATE_FORMAT(validfrom,'%d-%b-%Y') validfrom,DATE_FORMAT(validupto,'%d-%b-%Y') validupto from cm_srvcontrm m left join cm_servplan p on(m.tr_no=p.doc_no) where m.tr_no="+trno+"";

			//System.out.println("===sitesql===="+sql4);

			ResultSet rs5 = stmt.executeQuery(sql4);
			String scheduler="";
			int schno=1;
			while(rs5.next()){

				bean.setStartDate(rs5.getString("validfrom"));
				bean.setEndDate(rs5.getString("validupto"));

				
				
				schlist.add("1"+"::"+"The maintenance servcies will be commence from"+"::"+rs5.getString("validfrom"));
				schlist.add("2"+"::"+"Valid till"+"::"+rs5.getString("validupto"));
				schlist.add("3"+"::"+"Number of quarterly visits during the contract period"+"::"+rs5.getString("count"));
				serno=serno+1;
			}



			bean.setSchlist(schlist);



			String sql5="select DATE_FORMAT(duedate,'%d/%m/%Y') duedate,round(amount,2) as amount,IF(description IS NULL or description = '', '     ', description) as description from cm_srvcontrpd  where tr_no="+trno+"";

			//System.out.println("===sitesql===="+sql5);

			ResultSet rs6 = stmt.executeQuery(sql5);
			String pay="";
			int payno=1;
			while(rs6.next()){

				pay=payno+"::"+rs6.getString("duedate")+"::"+rs6.getString("amount")+"::"+rs6.getString("description");

				paylist.add(pay);
				payno=payno+1;
			}



			bean.setPaylist(paylist);




			String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+msdocno+" and tr.status=3 order by tr.priorno";

			//System.out.println("==sql2===terms===="+sql2);

			ResultSet rs3 = stmt.executeQuery(sql2);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			while(rs3.next()){

				String temp="";
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


			String siteQry="select @i:=@i+1 srno,a.* from (select  site ,g.doc_no areaid,groupname area from  cm_srvcsited  d "
	        		+ " left join my_groupvals g on(d.areaid=g.doc_no and grptype='area')  where tr_no='"+trno+"') a ,(select @i:=0) r";
	           
			bean.setSiteQry(siteQry);
			   String termsQry="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
	            		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
	            		+ "  where  tr.dtype='AMC' and tr.brhid='"+brhid+"' and tr.rdocno='"+msdocno+"' and tr.status=3 ) tr "
	            		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
	            		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
	            		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
	            		+ " tr.dtype='AMC' and tr.rdocno='"+msdocno+"' and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno; ";
	        bean.setTermQry(termsQry);
			 // System.out.println("termsssssssss"+termsQry);
			  String payQry="select @i:=@i+1 srno,a.* from (select DATE_FORMAT(dueDate,'%d-%b-%Y') dueDate, amount,  description desc1, DueAfSer dueser, "
	            		+ "runtotal,terms,termsid,if(terms='SERVICE',dueafser,0) service from cm_srvcontrpd where tr_no='"+trno+"') a, "
	            		+ "(select @i:=0)r";
			  
			  bean.setPayQry(payQry);
			  
			  String payAITSQry="select @i:=@i+1 srno,a.* from (select DATE_FORMAT(d.dueDate,'%d-%b-%Y') dueDate, round(d.amount,2) amount,if(m.inctax=1,CONCAT(d.description,' [INCLUSIVE OF TAX]'),d.description) desc1,"
					    + "d.DueAfSer dueser,d.runtotal,d.terms,d.termsid,if(d.terms='SERVICE',d.dueafser,0) service from cm_srvcontrpd d left join cm_srvcontrm m on m.tr_no=d.tr_no where d.tr_no='"+trno+"' "
					    + "UNION ALL select DATE_FORMAT(date,'%d-%b-%Y') dueDate, round(legalchrg,2) amount,if(inctax=1,CONCAT('Dubai Civil Defence contract attestation charge',' [INCLUSIVE OF TAX]'),"
					    + "'Dubai Civil Defence contract attestation charge') desc1, 0 dueser,legalchrg runtotal,'' terms,0 termsid,0 service from cm_srvcontrm "
					    + "where islegal=1 and tr_no='"+trno+"') a, (select @i:=0)r";

			  bean.setPayAITSQry(payAITSQry);
			  
			stmt.close();
			conn.close();
		}

		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;
	}

	public JSONArray serviceScheduleGrid(HttpSession session,String frmdate,String todate,String days,String srvalue,
			String srvid,String siteid,String service,String site,String gridload,String srvint,String srvdue,String csrvtyp,String chkday) throws SQLException {


		JSONArray jsonArray = new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

//			System.out.println("==chkday===="+chkday);

//			System.out.println("==gridload===="+gridload);


			if(gridload.equalsIgnoreCase("1")){

				if(chkday.equalsIgnoreCase("1")){

					java.sql.Date stdate=com.changeStringtoSqlDate(frmdate);
					java.sql.Date enddate=com.changeStringtoSqlDate(todate);

					if (days.trim().endsWith(",")) {
						days = days.trim().substring(0,days.length() - 1);
					}

					for(int i=0;i<2;i++){

						String clsql= ("select  date_format(date,'%Y-%m-%d') as pldate,DAYname(date_format(date,'%Y-%m-%d')) as days,'"+service+"' as service, "
								+ "round("+srvalue+",2) as value,'"+site+"' as site,'"+siteid+"' as siteid,'"+srvid+"' as serviceid from ( select  date_add('"+stdate+"', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date "
								+ "from  (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
								+ "union all select 6 union all select 7 union all select 8 union all select 9) n1, "
								+ "(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
								+ "union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1 "
								+ " union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 "
								+ " union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3 "
								+ " union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4 "
								+ " ) a where date >='"+stdate+"' and date <='"+enddate+"' and weekday(date) in ("+days+") order by date");


//						System.out.println("====clsql====="+clsql);

						ResultSet resultSet = stmt.executeQuery(clsql);

						jsonArray=com.convertToJSON(resultSet);

					}

				}
				else{
					java.sql.Date xdate=null;
					java.sql.Date fdate=null;
					java.sql.Date endsdate=null;

					double xtotal=0.0;
					double amount=0.0;
					int xsrno=0;



					if(!(frmdate.equalsIgnoreCase("undefined"))&&!(frmdate.equalsIgnoreCase(""))&&!(frmdate.equalsIgnoreCase("0"))){
						xdate = com.changeStringtoSqlDate(frmdate);
						fdate = com.changeStringtoSqlDate(frmdate);
					}


					if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
						endsdate = com.changeStringtoSqlDate(todate);
					}

					String xsql="";




					Double txtinstamt=Double.parseDouble(srvalue)/Integer.parseInt(srvint);
					xsql=Integer.parseInt(srvdue) + (csrvtyp.equalsIgnoreCase("1")?" Day ":csrvtyp.equalsIgnoreCase("2")?" Month ":" Year ");
					do							
					{	
						++xsrno;

						if (Integer.parseInt(srvint)>0 && xsrno>Integer.parseInt(srvint))
							break;

						int sr_no= xsrno;							
						int actualNoOfInst=xsrno;

						amount=((xtotal+txtinstamt)>Double.parseDouble(srvalue)?(Double.parseDouble(srvalue)-xtotal):txtinstamt);
						xtotal+=amount;

						JSONObject obj = new JSONObject();
						obj.put("sr_no",String.valueOf(sr_no));

						if(!(xdate==null) || !(endsdate.after(xdate))){

							//System.out.println("===xdate====="+xdate);

							String formatter = new SimpleDateFormat("EEEE").format(xdate);


							//System.out.println("===formatter====="+formatter);

							obj.put("pldate",xdate.toString());
							obj.put("service",service.toString());
							obj.put("value",srvalue.toString());
							obj.put("site",site.toString());
							obj.put("siteid",siteid.toString());
							obj.put("serviceid",srvid.toString());
							obj.put("days",formatter.toString());

							//obj.put("pldate",xdate.toString());
						}
						/*obj.put("amount",String.valueOf(amount));
							obj.put("runtotal",String.valueOf(xtotal));
						 */
						jsonArray.add(obj);

						if(xsrno>Integer.parseInt(srvint)) break;
						/*System.out.println("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(srvdue)+",'-',day('"+xdate+"')))) pldate,DAYname(coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(srvdue)+",'-',day('"+xdate+"'))))) as days,'"+service+"' as service, "
								+ "round("+srvalue+",2) as value,'"+site+"' as site,'"+siteid+"' as siteid,'"+srvid+"' as serviceid ");*/

						ResultSet rs = stmt.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(srvdue)+",'-',day('"+xdate+"')))) pldate,DAYname(coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(srvdue)+",'-',day('"+xdate+"'))))) as days,'"+service+"' as service, "
								+ "round("+srvalue+",2) as value,'"+site+"' as site,'"+siteid+"' as siteid,'"+srvid+"' as serviceid ");
						if(rs.next()) 
							xdate=rs.getDate("pldate");
						// days=rs.getString("days");

						rs.close();
					}while(true);	

				}



			}
			else{

			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}




}
