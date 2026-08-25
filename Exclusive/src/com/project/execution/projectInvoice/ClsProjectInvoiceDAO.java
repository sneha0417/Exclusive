package com.project.execution.projectInvoice;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.common.ClsVatInsert;
import com.connection.ClsConnection;

public class ClsProjectInvoiceDAO {


	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsProjectInvoiceBean bean= new ClsProjectInvoiceBean();
	Connection conn;


	public int insert(Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String inctax,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist,String nontax) throws SQLException {
		try{
			int docno;
			int protrno;
			int trno=-1;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement ();
			
			String cltax="select nontax from my_acbook where doc_no="+clientid+" and dtype = 'crm' ";
			ResultSet resultSetTax = stmt.executeQuery(cltax);
		    
			 while (resultSetTax.next()) {
				 nontax=resultSetTax.getString("nontax");
			 }
			 
			double taxcalcamt=Double.parseDouble(legalamt)+Double.parseDouble(seramt)+Double.parseDouble(exptotal);

			trno=getTrno(session, dtype, branchid,conn);

			amount=seramt;
			lfee=legalamt;

			double taxinvamt=0.0;
			double totaltaxper=0.0;
			
			if(nontax.equalsIgnoreCase("1")){
			     if(inctax.equalsIgnoreCase("1")){
			    	 taxinvamt=Double.parseDouble(seramt)-taxamt;

			       }
			     else {
			    	 taxinvamt=Double.parseDouble(seramt);
			     }
			}
			
			else{
				
				taxinvamt=Double.parseDouble(seramt);
			}
			if(contracttype.equalsIgnoreCase("SINV"))
			{
				amount=seramt+"";
			}
			else{
				amount=taxinvamt+"";
			}
			
			//System.out.println("=amount=="+amount+"==lfee==="+lfee+"==exptotal=="+exptotal+"===taxamt==="+taxamt+"==nettotal=="+nettotal);

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt1.registerOutParameter(25, java.sql.Types.INTEGER);	
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
			stmt1.setDouble(18,taxcalcamt);
			stmt1.setString(19,pdid==null || pdid=="" || pdid.equalsIgnoreCase("")?"0":pdid);
			stmt1.setString(20,exptotal);
			stmt1.setString(21,txtnotes);
			stmt1.setString(22,ptype);
			stmt1.setDouble(23,taxamt);
			stmt1.setInt(24,trno);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");

			request.setAttribute("docno", docno);
			request.setAttribute("jvtrno", protrno);
			
		    int sitemethod=0;
			String description=desc;
			if(protrno>0){

				// site in jvtran with description
				String siteconfig="select method from gl_config where field_nme='invoicesite'";
				ResultSet siters = stmt.executeQuery (siteconfig);
				if (siters.next()) {
					sitemethod=siters.getInt("method");
				}
				if(sitemethod==1)
				{
					String sitedata="select site from cm_srvcsited where tr_no='"+costid+"' order by rowno limit 1";
					ResultSet sitedatars = stmt.executeQuery (sitedata);
					if (sitedatars.next()) {
						description=contracttype+"-"+contractno+","+desc+"-"+sitedatars.getString("site");
					}
				}


				for(int i=0;i< exparray.size();i++){


					String[] surveydet=((String) exparray.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_servd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

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

				//tmp=resultSet.getString("codeno")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");
				System.out.println("nontax=="+nontax);
				if(nontax.equalsIgnoreCase("1")){
				for(int i=0;i< taxlist.size();i++){
					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						totaltaxper=totaltaxper+Double.parseDouble(surveydet[2].trim());
					
						String sql="INSERT INTO my_invtaxdet( rdocno, taxid,acno, per, amount)VALUES"
								+ " ("+(protrno)+","
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"')";
						System.out.println("invtaxdetsql=="+sql);
						int rest = stmt.executeUpdate (sql);
						if(rest<=0)
						{
							conn.close();
							return 0;
						}
					}

				}

}
				if(ptype.equalsIgnoreCase("2")){

					String sqlpl="update cm_servplan set invtrno="+trno+" where iserv=1 and doc_no="+costid+" and tr_no in ("+pdid+")";

					int spl = stmt.executeUpdate(sqlpl);
					
					String sqlothrupd="update cm_srvspares ss left join cm_srvdetm sv on sv.tr_no=ss.tr_no left join cm_servplan sch "
							+ "on sch.tr_no=sv.schrefdocno and ss.chg=1 and ss.invtrno=0 set ss.invtrno="+trno+" "
									+ "where sv.schrefdocno in ("+pdid+")";
					
					int othin = stmt.executeUpdate(sqlothrupd);
					if(spl<=0)
					{
						conn.close();
						return 0;

					}	

				}



				int acnos=0;
				String curris="1";
				double rates=1;
				double finalamt=0.0;
				double tper=0.0;
				int costtype=0;
				int costcode=0;
				int cldocno=0;
				String descs="Invoice "+dtype+"-"+""+docno+""+":-Dated :- "+sqldate; 
				String refdetails=""+dtype+""+docno;
				String sql2="";
				String jvbranch="";
				int id=0;
				int tranid=0;
				int loopval=3;
				loopval=taxlist.size()>0?(loopval+taxlist.size()):loopval;
				

				for(int a=0;a<=loopval;a++){

					acnos=0;

					if(a==0){
						if(contracttype.equalsIgnoreCase("AMC")){
							costtype=3;
							costcode=contractno;
							sql2="select  acno from my_account where codeno='AMC INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SJOB")){
							costtype=4;
							costcode=contractno;
							sql2="select  acno from my_account where codeno='SJOB INCOME' ";
						}
						
						System.out.println("==contracttype==="+contracttype);
						
						if(contracttype.equalsIgnoreCase("SINV")){
							costtype=0;
							costcode=contractno;
							sql2="select  acno from my_account where codeno='SINCOME' ";
						}

						ResultSet tass1 = stmt.executeQuery (sql2);

						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid;
						id=-1;

						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(seramt);

						}
						else if(inctax.equalsIgnoreCase("1")){
							//finalamt=Double.parseDouble(seramt)-taxamt;
							
							
							finalamt=Double.parseDouble(seramt)/((totaltaxper/100)+1);
							System.out.println("finalamt=="+finalamt);
						}

						cldocno=0;
					}
					if(a==1){
						sql2="select  acno from my_account where codeno='Legal Contract' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(legalamt);

						}
						else if(inctax.equalsIgnoreCase("1")){
							
							finalamt=Double.parseDouble(legalamt)/((totaltaxper/100)+1);
						}
						
						//costtype=0;
						//costcode=0;
						cldocno=0;
					}

					if(a==2){
						sql2="select  acno from my_account where codeno='Other' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(exptotal);

						}
						else if(inctax.equalsIgnoreCase("1")){
							
							finalamt=Double.parseDouble(exptotal)/((totaltaxper/100)+1);
						}
					
						cldocno=0;
					}

					if(a==3){

						acnos=Integer.parseInt(clacno);
						jvbranch=branchid+"";
						id=1;

						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=taxcalcamt+taxamt;

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=taxcalcamt;
						}
						costtype=0;
						costcode=0;
						cldocno=clientid;
					}

					if(a>3){
						
						String[] taxdet=((String) taxlist.get(a-4)).split("::");
						if(!(taxdet[0].trim().equalsIgnoreCase("undefined")|| taxdet[0].trim().equalsIgnoreCase("NaN")||taxdet[0].trim().equalsIgnoreCase("")|| taxdet[0].isEmpty()))
						{

							acnos=Integer.parseInt(taxdet[1].trim());
							finalamt=Double.parseDouble(taxdet[3].trim());
					
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
						
						}
					
					}
					
				/*	if(a==4){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=1";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
					}
					if(a==5){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=2";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;


						cldocno=0;
					}
					if(a==6){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=3";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;

						cldocno=0;
					}
					*/




					String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet tass3 = stmt.executeQuery (sqls3);

					if (tass3.next()) {

						curris=tass3.getString("curid");	


					}
					String currencytype1="";
					String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+sqldate+"' and frmDate<='"+sqldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					//System.out.println("-----6--sqlveh----"+sqlveh) ;
					ResultSet resultSet44 = stmt.executeQuery(sqlveh);

					while (resultSet44.next()) {
						rates=resultSet44.getDouble("rate");
						currencytype1=resultSet44.getString("type");
					} 

					double pricetottal=(finalamt)*id;
					double ldramounts=0 ;     
					if(currencytype1.equalsIgnoreCase("D"))
					{

						ldramounts=pricetottal/rates ;  
					}

					else
					{
						ldramounts=pricetottal*rates ;  
					}
					if(pricetottal!=0){

						String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+sqldate+"','"+refno+"',"+docno+",'"+acnos+"','"+description+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

						//					System.out.println("====sql11==a"+a+"===="+sql11);

						int ss1 = stmt.executeUpdate(sql11);

						if(ss1<=0)
						{
							conn.close();
							return 0;

						}

						if(a!=3){

							if(costtype>0) {
							
							String sqlss="select tranid from my_jvtran where tr_no='"+trno+"' and brhId='"+jvbranch+"' and acno='"+acnos+"' and doc_no='"+docno+"' and dtype='"+dtype+"'";

							ResultSet rss = stmt.executeQuery(sqlss);

							while (rss.next()) {
								tranid=rss.getInt("tranid");
							}	

							String sql="insert into my_costtran(acno, costType, amount, tr_no, jobId,tranid,sr_no) "
									+ "values('"+acnos+"','"+costtype+"',"+ldramounts+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							//System.out.println("==sql===="+sql);

							int rs2 = stmt.executeUpdate(sql);

							if(rs2<=0)
							{
								conn.close();
								return 0;

							}
						  }
						}
					}
					


				}

				String accdoc="";
				String sql="select acno from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
				ResultSet rs11=stmt.executeQuery(sql);
				while(rs11.next()){
					accdoc=rs11.getString("acno");
				}
				
				 ArrayList<String> arr=new ArrayList<String>(); 
					ClsVatInsert ClsVatInsert=new ClsVatInsert();
					Statement newStatement=conn.createStatement();
					String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
							+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
							+"  sum(a.total9) total9,sum(a.total10) total10, "
							+"  sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
							+"  sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
							+"  from ( "
						+" 	 select  d.netAmount+legalchrg+coalesce(d.taxamt,0) nettaxamount,if(coalesce(d.taxamt,0)>0,d.netAmount+legalchrg,0) total1, "
							+"  if(coalesce(d.taxamt,0)=0,d.netAmount+legalchrg,0) total2 ,0 total3, "
							 +"  0 total4,0 total5, "
							+"  0 total6,0 total7, "
							+"  0 total8,0 total9, "
							+"  0 total10, "
							+"  if(d.taxamt>0,d.taxamt,0) tax1,  0 tax2, "
							+"  0 tax3,  0 tax4, "
							+"  0 tax5, 0 tax6, "
							+"  0 tax7,  0 tax8, "
							+"  0 tax9,  0 tax10 "
							 +"  from my_servm d where doc_no="+docno+" ) a" ;
					System.out.println("--selectsqls--"+selectsqls);
					ResultSet rss101=newStatement.executeQuery(selectsqls);
					if(rss101.first())
						{
						arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
								rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
								rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
								rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
								rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
								rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
								rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
						}   
					System.out.println("=== "+accdoc+"===== "+acnos);
						int result=ClsVatInsert.vatinsert(1,2,conn,trno,Integer.parseInt(clacno),docno,sqldate,"PJIV",session.getAttribute("BRANCHID").toString(),""+docno,1,arr,mode)	;
							if(result==0)	
						        {
								conn.close();
								return 0;
								}
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

			//return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	public int edit(int trno,int docno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String inctax,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			double taxcalcamt=Double.parseDouble(legalamt)+Double.parseDouble(seramt)+Double.parseDouble(exptotal);
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
			stmt1.setDouble(18,taxcalcamt);
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


				/*				for(int i=0;i< exparray.size();i++){


					String[] surveydet=((String) exparray.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_servd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

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


				for(int i=0;i< taxlist.size();i++){

					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_invtaxdet( rdocno, taxid,acno, per, amount)VALUES"
								+ " ("+(protrno)+","
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"')";

						int rest = stmt.executeUpdate (sql);
						if(rest<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

				if(ptype.equalsIgnoreCase("2")){

					String sqlpl="update cm_servplan set invtrno="+trno+" where iserv=1 and doc_no="+costid+" and tr_no in ("+pdid+")";

					int spl = stmt.executeUpdate(sqlpl);

					if(spl<=0)
					{
						conn.close();
						return 0;

					}	

				}

				int acnos=0;
				String curris="1";
				double rates=1;
				double finalamt=0.0;
				double tper=0.0;
				int costtype=0;
				int costcode=0;
				int cldocno=0;
				String descs="Invoice "+dtype+"-"+""+docno+""+":-Dated :- "+sqldate; 
				String refdetails=""+dtype+""+docno;
				String sql2="";
				String jvbranch="";
				int id=0;
				int tranid=0;
				int loopval=3;
				loopval=taxlist.size()>0?(loopval+taxlist.size()):loopval;

				for(int a=0;a<=loopval;a++){

					acnos=0;

					if(a==0){
						if(contracttype.equalsIgnoreCase("AMC")){
							costtype=3;
							costcode=costid;
							sql2="select  acno from my_account where codeno='AMC INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SJOB")){
							costtype=4;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SJOB INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SINV")){
							costtype=0;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SINCOME' ";
						}

						ResultSet tass1 = stmt.executeQuery (sql2);

						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid;
						id=-1;

						if(inctax.equalsIgnoreCase("0")){
							finalamt=Double.parseDouble(seramt);

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=Double.parseDouble(seramt)-taxamt;
						}

						cldocno=0;
					}
					if(a==1){
						sql2="select  acno from my_account where codeno='Legal Contract' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						finalamt=Double.parseDouble(legalamt);
						//costtype=0;
						//costcode=0;
						cldocno=0;
					}

					if(a==2){
						sql2="select  acno from my_account where codeno='Other' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						finalamt=Double.parseDouble(exptotal);

						cldocno=0;
					}

					if(a==3){

						acnos=Integer.parseInt(clacno);
						jvbranch=branchid+"";
						id=1;

						if(inctax.equalsIgnoreCase("0")){
							finalamt=taxcalcamt+taxamt;

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=taxcalcamt;
						}
						costtype=0;
						costcode=0;
						cldocno=clientid;
					}

					if(a==4){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=1";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
					}
					if(a==5){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=2";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;


						cldocno=0;
					}
					if(a==6){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=3";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;

						cldocno=0;
					}




					String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet tass3 = stmt.executeQuery (sqls3);

					if (tass3.next()) {

						curris=tass3.getString("curid");	


					}
					String currencytype1="";
					String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+sqldate+"' and frmDate<='"+sqldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					//System.out.println("-----6--sqlveh----"+sqlveh) ;
					ResultSet resultSet44 = stmt.executeQuery(sqlveh);

					while (resultSet44.next()) {
						rates=resultSet44.getDouble("rate");
						currencytype1=resultSet44.getString("type");
					} 

					double pricetottal=(finalamt)*id;
					double ldramounts=0 ;     
					if(currencytype1.equalsIgnoreCase("D"))
					{

						ldramounts=pricetottal/rates ;  
					}

					else
					{
						ldramounts=pricetottal*rates ;  
					}
					if(pricetottal!=0){

						String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+sqldate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+desc+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

						//					System.out.println("====sql11==a"+a+"===="+sql11);

						int ss1 = stmt.executeUpdate(sql11);

						if(ss1<=0)
						{
							conn.close();
							return 0;

						}

						if(a!=3){

							String sqlss="select tranid from my_jvtran where tr_no='"+trno+"' and brhId='"+jvbranch+"' and acno='"+acnos+"' and doc_no='"+docno+"' and dtype='"+dtype+"'";

							ResultSet rss = stmt.executeQuery(sqlss);

							while (rss.next()) {
								tranid=rss.getInt("tranid");
							}	

							String sql="insert into my_costtran(acno, costType, amount, tr_no, jobId,tranid,sr_no) "
									+ "values('"+acnos+"','"+costtype+"',"+ldramounts+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							//System.out.println("==sql===="+sql);

							int rs2 = stmt.executeUpdate(sql);

							if(rs2<=0)
							{
								conn.close();
								return 0;

							}
						}
					}




				}
				 */
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



	public int delete(int trno,int docno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String nettotal,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			/*			String insql="insert into my_trno(userno,trtype,brhid,edate,transid) values("+session.getAttribute("USERID").toString() +",'"+dtype+"',"+branchid +",NOW(),0)";
			int inres=stmt.executeUpdate(insql);

			if(inres<=0)
			{
				stmt.close();
				conn.close(); 
				return -1;
			}
			String upsql="select max(trno) trno from my_trno ";
			ResultSet resultSet = stmt.executeQuery(upsql);
			 */
			/*while (resultSet.next()) {
				trno=resultSet.getInt("trno");
			}*/		  
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




	public JSONArray contractSrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String dtype,String ptype, String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		/*if(a==0){
			return RESULTDATA;
		}*/

		if(!(check.equalsIgnoreCase("1")))
        {
        	return RESULTDATA;
        }
		

		String brcid=session.getAttribute("BRANCHID").toString();


		String sqltest="",sqltest1="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest1=" having  duedate<='"+sqlStartDate+"'";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and a.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and a.client like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and a.contactNo like '%"+Cl_mobno+"%'";
		}
		if(!(dtype.equalsIgnoreCase("undefined"))&&!(dtype.equalsIgnoreCase(""))&&!(dtype.equalsIgnoreCase("0"))){
			if(ptype.equalsIgnoreCase("1")){
				sqltest=sqltest+" and dtype='"+dtype+"'";
			}
			else{

			}

		}




		Connection conn =null;
		Statement stmt = null;
		ResultSet resultSet = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
            String sqlmeth = "select method from gl_config where field_nme='prjInvoice'";
        
            ResultSet rs = stmt.executeQuery(sqlmeth);
            int method=0;
            System.out.println("method---"+method);
            while (rs.next()) {
                method = rs.getInt("method");
                
            }
            System.out.println("methodout---"+method);
            if (method ==0){

			/*			String str1Sql="select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.doc_no doc_no,cm.refno as refno, ac.refname as name,ac.com_mob as contmob ,  "
					+ "concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
					+ "cm.date date,if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval,round(coalesce(sv.netamount,0.0),2) tobeinvamt, "
					+ "round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid from "
					+ "(select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) "
					+ "where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where pd.dueafser=99 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser not in (98,99) and serviceno>0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join cm_servplan sch "
					+ "on ( a.tr_no=sch.doc_no and workper=100) left join cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') "
					+ "where  cm.status=3 "+sqltest+" and jbaction not in(1) "+sqltest1+" order by duedate,cm.tr_no,cm.doc_no ";
			 */
			/*			String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
					+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
					+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
					+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, ifnull(ac.per_mob,ac.com_mob) contactno, "
					+ "concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
					+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
					+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
					+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
					+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
					+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction not in(1) union all "
					+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
					+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
					+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ " coalesce(ac.per_mob,ac.com_mob) contactno,concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
					+ "pd.tr_no as pdid,2 as ptype from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction not in(1) ) as a "
					+ " where 1=1 "+sqltest+" "+sqltest1+" and ptype="+ptype+" order by duedate,tr_no,doc_no";
			 */
			String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
					+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
					+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
					+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
					+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,cm.inctax from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
					+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
					+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
					+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
					+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction not in(1) union all "
					+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
					+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
					+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
					+ "pd.tr_no as pdid,2 as ptype,cm.inctax from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction not in(1) ) as a "
					+ " where 1=1 "+sqltest+" "+sqltest1+"   and ptype="+ptype+" order by duedate,tr_no,doc_no";

			 resultSet = stmt.executeQuery (sqldata);
			System.out.println("Contract Search--->  "+sqldata);
			
            }else if(method ==1){
            	String sqldata="select costType, ptype, dtype,clacno,rowno,pdid,clientid, doc_no,client, details,contactNo from(select if(cm.dtype='AMC',3,4) costType,1 as ptype,cm.dtype,ac.acno as clacno, pd.rowno,pd.tr_no pdid, "
            			       +" ac.cldocNo clientid, cm.doc_no,cm.status,ac.RefName client,ac.address details, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo from cm_srvcontrm cm "
                               +" inner join cm_srvcontrpd pd on(cm.tr_no=pd.tr_no and pstatus!=1) inner join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM')) a where a.status=3 "+sqltest+" and ptype="+ptype+"";
            
            	resultSet = stmt.executeQuery (sqldata);
    			System.out.println("Contract Search--->  "+sqldata);
    			
            
            }

					//	System.out.println("======contractSrearch===="+sqldata);

			/*ResultSet resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
			System.out.println("Contract Search--->  "+sqldata);*/
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

			sql="select sm.ref_type dtype,m.doc_no docno,sm.date,sm.description descp,round(sm.atotal,2) amount,round(sm.legalchrg,2) lfee from "
					+ "my_servm sm left join  cm_srvcontrm m on(sm.costid=m.tr_no)   where sm. tr_no="+trno+"";

			//	System.out.println("===sql===="+sql);

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

	public JSONArray expenseGridLoad(HttpSession session,String trno , String docType) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select concat(d.description,' : ',ma.productname) desc1,round(qty,2) as qty,round(d.total,2) amount,round(d.nettotal,2) total,ma.psrno as psrno,ma.doc_no as prdid from cm_srvspares d "
					+ "left join cm_srvdetm m on(d.tr_no=m.tr_no) left join my_main ma on(d.psrno=ma.doc_no and d.prdid=ma.doc_no) "
					+ "where m.wrkper=100 and  m.costid="+trno+" and d.invtrno=0 and m.ref_type='"+docType+"'";

						System.out.println("===sql===="+sql);

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

	public JSONArray expenseGridReLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

		//	sql="select description desc1,productid as prdid,productid as psrno,qty,amount,nettotal as total from my_servd where tr_no="+trno+" ";
			sql="select description desc1,productid as prdid,productid as psrno,round(qty) qty,round(amount,2) amount,round(nettotal,2) as total "
					+ "from my_servd where tr_no="+trno+" ";

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

	public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String contno,String invdate,String invtype,String aa) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		System.out.println("aa====="+aa);
		if(!(aa.equalsIgnoreCase("yes"))){
			return RESULTDATA;
		}
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
		if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(invdate);
		}






		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'"; 
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.refdocno like '%"+contno+"%'";
		}

		if(!(invtype.equalsIgnoreCase(""))){
			String invtypeval="";
			if(invtype.equalsIgnoreCase("AMC"))
			{
				invtypeval="3";
			}
			else if(invtype.equalsIgnoreCase("SJOB"))
			{
				invtypeval="4";
			}
			else
			{
			}

			sqltest=sqltest+" and m.costtype like '%"+invtypeval+"%'";
		}
		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement();

			String clssql= ("select m.doc_no,m.refdocno contno,ac.refname client,m.date,m.ref_type contype,m.tr_no,m.cldocno,m.costid,m.acno clacno,m.costtype conttypeval from my_servm m "
					+ "inner join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 and m.brhid="+brid+" " +sqltest);
			System.out.println("====search master===="+clssql);
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

	public ClsProjectInvoiceBean getViewDetails(HttpSession session,int trno,String branchid) throws SQLException {
		ClsProjectInvoiceBean ProinvBean = new ClsProjectInvoiceBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtPRIV = conn.createStatement();

			String branch = branchid;


			

			
			ResultSet resultSet = stmtPRIV.executeQuery ("select m.tr_no,m.doc_no,m.date,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,m.rettrno,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.costtype,if(refdocno=0,c2.description,refdocno) as refdocno,m.pdrowno,round(m.etotal,2) etotal,round(m.netamount,2) netamount,round(m.atotal) as atotal,round(m.legalchrg,2) as legalchrg,coalesce(notes,'') notes "
					+ "from my_servm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join my_ccentre c2 on(c2.doc_no=m.costid)  where m.status=3 and m.dtype='PJIV' and m.brhid="+branch+" and m.tr_no="+trno+"");

			System.out.println("get view details---> "+resultSet);


			while (resultSet.next()) {
				ProinvBean.setDocno(resultSet.getInt("doc_no"));
				ProinvBean.setDate(resultSet.getDate("date").toString());
				ProinvBean.setRefno(resultSet.getString("refno"));
				ProinvBean.setTxtclient(resultSet.getString("client"));
				ProinvBean.setTxtclientdet(resultSet.getString("details"));
				ProinvBean.setCmbcontracttype(resultSet.getString("conttype"));
				ProinvBean.setDesc(resultSet.getString("desp"));
				ProinvBean.setMaintrno(resultSet.getInt("tr_no"));
				ProinvBean.setClientid(resultSet.getInt("cldocno"));
				ProinvBean.setClacno(resultSet.getString("clacno"));
				ProinvBean.setCostid(resultSet.getInt("costid"));
				ProinvBean.setTxtrefdetails(resultSet.getString("refdocno"));
				//System.out.println("hhhhhhhhhhh"+resultSet.getString("refdocno"));
				
				ProinvBean.setPdid(resultSet.getString("m.pdrowno"));
				ProinvBean.setTxtnettotal(resultSet.getString("netamount"));
				ProinvBean.setTxtseramt(resultSet.getString("atotal"));
				ProinvBean.setTxtlegalamt(resultSet.getString("legalchrg"));
				ProinvBean.setTxtexptotal(resultSet.getString("etotal"));
				ProinvBean.setTxtnotes(resultSet.getString("notes"));
                ProinvBean.setTxtcontract(resultSet.getInt("refdocno"));
				ProinvBean.setTxtpjivreturned(resultSet.getString("rettrno"));
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




	

	public ClsProjectInvoiceBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}

	//	String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="";
		int contrno=0;
		String cntrtype="";
		String amount="0.00";
		String leglfee="0.00";
		String total="0.00";
		String taxper="0.00";
		String taxamount="0.00";
		String nettotal="0.00";
		String nettotaltobepaid="0.00";
		String description="";

		Connection conn = null;
		ArrayList sitelist=null;
		ArrayList trlist=null;
		ArrayList serlist=null;
		ArrayList paylist=null;
		ArrayList list=null;
		try {
			sitelist= new ArrayList();
			trlist= new ArrayList();
			serlist= new ArrayList();
			paylist= new ArrayList();
			list= new ArrayList();

			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();
			
			String lglfeeConfig="1",netAmountRoundConfig="0",srvcYeardocnoConfig="0";
			
			String lglfeeConfigSql = "select method from gl_config where field_nme='srvcPJIVLegalFee'";
			ResultSet rslglfeeConfig = stmt.executeQuery(lglfeeConfigSql);
			
			while(rslglfeeConfig.next()) {
				lglfeeConfig=rslglfeeConfig.getString("method");
			}
			
			String netAmountRoundConfigSql = "select method from gl_config where field_nme='srvcPJIVNetAmountRound'";
			ResultSet rsnetAmountRoundConfig = stmt.executeQuery(netAmountRoundConfigSql);
			
			while(rsnetAmountRoundConfig.next()) {
				netAmountRoundConfig=rsnetAmountRoundConfig.getString("method");
			}
			
			String srvcYeardocnoConfigSql = "select method from gl_config where field_nme='srvcYeardocno'";
			ResultSet rssrvcYeardocnoConfig = stmt.executeQuery(srvcYeardocnoConfigSql);
			
			while(rssrvcYeardocnoConfig.next()) {
				srvcYeardocnoConfig=rssrvcYeardocnoConfig.getString("method");
			}
			
			/*System.out.println("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");*/

			/*ResultSet resultSet = stmt.executeQuery ("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_servm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");*/

			/*String st1="select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as tel ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_servm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"";*/
			/*String st1="select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client, "
					+ "coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as tel ,"
					+ "coalesce(c.mail1,'') as email,m.ref_type conttype,m.description desp,m.cldocno,m.costid,"
					+ "m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref, "
					+ " b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,"
					+ "DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, coalesce(cm.cperson,con.cperson) cperson"
					+ "from my_servm m left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') "
					+ "left join my_brch b on(b.doc_no=m.brhid) "
					+ "left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)"
					+ "   left join cm_srvcontrm cm on m.refdocno=cm.doc_no  and cm.dtype=m.ref_type"
					+ "    left join my_crmcontact con on cm.cpersonid=con.row_no where m.status=3"
					+ "    and m.brhid=1 and m.tr_no=112";*/

			/*String st1="select concat('TRN NO','   ',b.tinno) companytrno,concat('TIN NO:','   ',b.tinno) companytinno,cm.inctax inclusivestat,coalesce(m.notes,'') notes,concat(DATE_FORMAT(m.date,'%b/%y'),'-',m.doc_no) invono,m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%b-%Y') date,"
					+ "if("+srvcYeardocnoConfig+"=1,CONCAT(com.comp_code,'/',YEAR(m.date),'/',LPAD(m.doc_no,4,0)),m.refno) refno,c.refname client, coalesce(c.tinno,'') tinno,concat('From:','  ',cm.validfrom) validfrom,concat('To:','  ',cm.validupto) validupto, "
					+ "coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as cltel ,coalesce(c.per_tel,'') as cltelno,"
					+ "coalesce(c.mail1,'') as email,m.ref_type conttype,m.description desp,m.cldocno,m.costid,"
					+ "m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref,"
					+ "round(atotal,2) as atotal,round(m.legalchrg,2) as legalchrg,(round(atotal,2)+round(m.legalchrg,2)) as total, "
					+ "CONCAT(round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,(round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)) as nettotal,round(round((round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)),0),2) as nettotaltobepaid,"
					+ " b.branchname brch,b.address as baddress,b.tel,b.fax,b.tinno trnno,com.company comp,com.address compaddress,com.tel comtel,com.fax comfax,com.email comemail,loc.loc_name,"
					+ "DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, coalesce(cm.cperson,con.cperson) cperson,m.refdocno "
					+ "from my_servm m left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') "
					+ "left join my_brch b on(b.doc_no=m.brhid) "
					+ " left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)"
					+ " left join cm_srvcontrm cm on m.refdocno=cm.doc_no  and cm.dtype=m.ref_type"
					+ " left join my_crmcontact con on cm.cpersonid=con.row_no left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3"
					+ "    and m.brhid="+brhid+" and m.tr_no="+trno+"";*/
			
			String st1="select concat('TRN NO','   ',b.tinno) companytrno,concat('TIN NO:','   ',b.tinno) companytinno,cm.inctax inclusivestat,coalesce(m.notes,'') notes,concat(DATE_FORMAT(m.date,'%b/%y'),'-',m.doc_no) invono,m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%b-%Y') date,"
					+ "if("+srvcYeardocnoConfig+"=1,CONCAT(com.comp_code,'/',substring(m.doc_no,1,4),'/',substring(m.doc_no,5,9)),m.refno)  refno,c.refname client, coalesce(c.tinno,'') tinno,concat('From:','  ',cm.validfrom) validfrom,concat('To:','  ',cm.validupto) validupto, "
					+ "coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as cltel ,coalesce(c.per_tel,'') as cltelno,"
					+ "coalesce(c.mail1,'') as email,m.ref_type conttype,m.description desp,m.cldocno,m.costid,"
					+ "m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref,"
					+ "round(atotal,2) as atotal,round(m.legalchrg,2) as legalchrg,round((round(atotal,2)+round(m.legalchrg,2)),2) as total, "
					+ "CONCAT(round(coalesce(tax.per,0),2),' %') taxper,format(coalesce(tax.amount,0),2) taxamount,(round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)) as nettotal,round(round((round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)),0),2) as nettotaltobepaid,"
					+ " b.branchname brch,b.address as baddress,b.tel,b.fax,b.tinno trnno,com.company comp,com.address compaddress,com.tel comtel,com.fax comfax,com.email comemail,loc.loc_name,"
					+ "DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, coalesce(c.contactPerson,con.cperson) cperson,m.refdocno "
					+ "from my_servm m left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') "
					+ "left join my_brch b on(b.doc_no=m.brhid) "
					+ " left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)"
					+ " left join cm_srvcontrm cm on m.refdocno=cm.doc_no  and cm.dtype=m.ref_type"
					+ " left join my_crmcontact con on cm.cpersonid=con.row_no left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3"
					+ "    and m.brhid="+brhid+" and m.tr_no="+trno+"";
			System.out.println("+++++attn select?+++++"+st1);
			ResultSet resultSet = stmt.executeQuery (st1);

			while (resultSet.next()) {
				
				//System.out.println("====notes = "+resultSet.getString("notes"));
				bean.setLblcompanyaddress(resultSet.getString("compaddress"));
				bean.setCompanytrno(resultSet.getString("companytrno"));
				bean.setCompanytinno(resultSet.getString("companytinno"));
				bean.setInclusivestat(resultSet.getString("inclusivestat"));
			    bean.setTxtnotes(resultSet.getString("notes"));
				bean.setTinno(resultSet.getString("tinno"));
				
				bean.setLblcltrnno(resultSet.getString("tinno"));
				bean.setCperson(resultSet.getString("cperson"));
				bean.setDocno(resultSet.getInt("doc_no"));
				bean.setDate(resultSet.getString("date"));
				bean.setRefno(resultSet.getString("refno"));
				bean.setTxtclient(resultSet.getString("client"));
				bean.setTxtclientdet(resultSet.getString("details"));
				bean.setCmbcontracttype(resultSet.getString("costtype"));
				bean.setDesc(resultSet.getString("desp"));
				bean.setMaintrno(resultSet.getInt("tr_no"));
				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setClacno(resultSet.getString("clacno"));
				bean.setCostid(resultSet.getInt("costid"));
				bean.setTxtjobrefno(resultSet.getString("jobref"));
				bean.setTxtemail(resultSet.getString("email"));
				bean.setTxtmob(resultSet.getString("mob"));
				bean.setTelph(resultSet.getString("cltel"));
				bean.setCltelno(resultSet.getString("cltelno"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblbranchtrno(resultSet.getString("trnno"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));
				bean.setConttrno(resultSet.getString("costid"));
				bean.setTxtdtype(resultSet.getString("conttype"));

				bean.setTaxamount(resultSet.getString("taxamount"));
				bean.setNettotal(resultSet.getString("nettotal"));
				bean.setTaxpercent(resultSet.getString("taxper"));
				
				bean.setRefdocno(resultSet.getString("refdocno"));
				
				bean.setFrom(resultSet.getString("validfrom"));
				bean.setTo(resultSet.getString("validupto"));
				bean.setComtel(resultSet.getString("comtel"));
				bean.setComfax(resultSet.getString("comfax"));
				bean.setComemail(resultSet.getString("comemail"));
				
               


				contrno=resultSet.getInt("costid");
				cntrtype=resultSet.getString("costtype");
				amount=resultSet.getString("atotal");
				leglfee=resultSet.getString("legalchrg");
				total=resultSet.getString("total");
				taxper=resultSet.getString("taxper");
				taxamount=resultSet.getString("taxamount");
				nettotal=resultSet.getString("nettotal");
				nettotaltobepaid=resultSet.getString("nettotaltobepaid");
				
			}

			ClsAmountToWords atw=new ClsAmountToWords();
			bean.setStaramuntword(atw.convertAmountToWords(nettotal));
			
			ClsAmountToWords amnt=new ClsAmountToWords();
			bean.setAmtwordsfire7(amnt.convertAmountToWords(nettotal));

			list.add("1"+"::"+"Contract Payment "+"::"+amount);
			
			if(lglfeeConfig.equalsIgnoreCase("1")){
				list.add("2"+"::"+"Civil Defense Contract Charges "+"::"+leglfee);
			}
			list.add(""+"::"+"Total "+"::"+total);
			list.add(""+"::"+"VAT "+taxper+"::"+taxamount);
			list.add(""+"::"+"Net Total "+"::"+nettotal);
			
			if(netAmountRoundConfig.equalsIgnoreCase("1")){
				list.add(""+"::"+"Net Total to be Paid"+"::"+nettotaltobepaid);	
			}

			bean.setList(list);
		
			String invonoqry="select concat(DATE_FORMAT(m.date,'%b'),DATE_FORMAT(y.ACCYR_F,'/%y'),'-',DATE_FORMAT(y.ACCYR_T,'%y/'),m.doc_no) invono "
					+ "from my_year y,my_servm m where y.cl_stat=0 and m.tr_no="+trno+" and m.status=3 and m.dtype='PJIV' and m.brhid="+brhid+" ;";
			//System.out.println("invonoqry="+invonoqry);
			ResultSet invonors = stmt.executeQuery(invonoqry);
			while(invonors.next()){
				
				bean.setInvono(invonors.getString("invono"));
							
			}
			
			String brch_detqry="select BRANCHNAME,Address,pbno,if(coalesce(tel,'')!='' and coalesce(tel2,'')!='',concat(tel,'/',tel2),if(coalesce(tel,'')!='',tel,coalesce(tel2,''))) tel,EMAIL from my_brch where doc_no="+brhid+";";
			ResultSet br_det=stmt.executeQuery(brch_detqry);
			while(br_det.next()){
				bean.setBrch_name(br_det.getString("BRANCHNAME"));
				bean.setBrch_address(br_det.getString("Address"));
				bean.setBrch_pbno(br_det.getString("pbno"));
				bean.setBrch_tel(br_det.getString("tel"));
				bean.setBrch_email(br_det.getString("EMAIL"));
				
			}
		
			/*String sitqry="select distinct coalesce(s.site,'') site from my_servm m left join cm_servplan n on (m.tr_no=n.invtrno) left join"
					+ " cm_srvcsited s on (n.siteid=s.rowno) where m.status=3 and m.tr_no="+trno+";";*/

			String sitqry="select  if(sitecount>1,'',coalesce(site,'')) site, serinv from (select distinct coalesce(s.site,'') site,n.serinv,count( distinct n.siteid) sitecount"
				     + " from my_servm m "
				     + "left join cm_servplan n on (m.tr_no=n.invtrno) left join cm_srvcsited s on (n.siteid=s.rowno)  "
				     + "where n.serinv=1 and m.status=3 and m.tr_no="+trno+"  union all (select distinct coalesce(sd.site,'') site, 0 serinv,0 sitecount from my_servm m "
				     + "left join cm_srvcsited sd on m.costid=sd.tr_no  where m.status=3 and m.tr_no="+trno+" limit 1 ))a "
				     + "where serinv=(if(serinv=0,(select 0 from  cm_srvcontrpd where invtrno="+trno+" limit 1  ),"
				     + "(select serinv from  cm_servplan where invtrno="+trno+" limit 1))) ;";
			
			ResultSet siters = stmt.executeQuery(sitqry);
			
		//	System.out.println("======sitqry========="+sitqry);
			
			String sites="";
			
			while(siters.next()){
				sites=sites+siters.getString("site")+"\n";
					
			}
			
			
			
			bean.setSite(sites);
			
			
			
			
			
			String sql1="select  round(amount,2) as amount,IF(description IS NULL or description = '', '     ', description) description from cm_srvcontrpd "
					+ " where tr_no="+contrno+"";
		
			//System.out.println("=====payterms===="+sql1);

			ResultSet rs = stmt.executeQuery(sql1);
			int payno=1;
			while(rs.next()){

				String temp="";
				temp=payno+"::"+rs.getString("amount")+"::"+rs.getString("description");
				paylist.add(temp);

				payno=payno+1;
			}

			//			System.out.println("===paylist===="+paylist.size());

			if(lglfeeConfig.equalsIgnoreCase("1")){
				paylist.add("DCD"+"::"+leglfee+"::"+"    ");
			}
			
			bean.setPaylist(paylist);


			String fire7contractsql="select total,invoicedamt,total-invoicedamt balance,invc,totc from (select sum(amount) invoicedamt,count(*) invc from cm_srvcontrpd "
					+" where tr_no="+contrno+" and invtrno!=0  and sr_no <=(select sr_no from cm_srvcontrpd  where tr_no="+contrno+" and invtrno="+trno+" )) a, "
					+ " (select coalesce(sum(amount),0) total,count(*) totc from cm_srvcontrpd where tr_no="+contrno+") b;";

	//System.out.println("=====invoicedetails numbering method fire7=new qry==="+fire7contractsql);

	ResultSet f7con=stmt.executeQuery(fire7contractsql);
	while(f7con.next()){
		bean.setFire7invamt(f7con.getString("invoicedamt"));
		bean.setFire7total(f7con.getString("total"));
		bean.setFire7balance(f7con.getString("balance"));
		bean.setFire7srno(f7con.getString("invc"));
		bean.setFire7mxrno(f7con.getString("totc"));
		
		bean.setInvoived(f7con.getString("invoicedamt"));
		bean.setTotal1(f7con.getString("total"));
		bean.setBalance(f7con.getString("balance"));
		bean.setMxrnomin(f7con.getString("invc"));
		bean.setMxrnomax(f7con.getString("totc"));

		serlist.add("Invoice "+f7con.getString("invc")+" of "+f7con.getString("totc")+"");
		serlist.add("Total Job Value (excluding VAT) "+"::"+f7con.getString("total"));
		serlist.add("Total invoiced (incl.this invoice, excl.VAT) "+"::"+f7con.getString("invoicedamt"));
		serlist.add("Balance to be invoiced (excluding VAT) "+"::"+f7con.getString("balance"));
	}

			String csql="select round(p.amount,2) invamt,p.count as srno, mxrno ,coalesce(round(balance,2),0.00) balance,round(total,2) total from "
					+ "(select sum(invamt) amount,count(*) as count,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno>0) p "
					+ "left join (select sum(amount) as total,tr_no,max(sr_no) as mxrno from cm_srvcontrpd where tr_no="+contrno+") as a on(a.tr_no=p.tr_no) "
					+ "left join (select sum(amount) as balance,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno<=0) as b on(b.tr_no=p.tr_no) "
					+ "where p.tr_no="+contrno+"";

		//	System.out.println("=====invoicedetails===="+csql);


			ResultSet crs = stmt.executeQuery(csql);
			int serno=1;
			if(crs.next()){
				
				//bean.setMxrnomin(crs.getString("srno"));
				//bean.setMxrnomax(crs.getString("mxrno"));
				//bean.setTotal1(crs.getString("total"));
			//	bean.setInvoived(crs.getString("invamt"));
				//bean.setBalance(crs.getString("balance"));
				String temp="";
/*
				serlist.add("Invoice "+crs.getString("srno")+" of "+crs.getString("mxrno")+"");
				serlist.add("Total Job Value "+"::"+crs.getString("total"));
				serlist.add("Total invoiced (incl.this invoice) "+"::"+crs.getString("invamt"));
				serlist.add("Balance to be invoiced "+"::"+crs.getString("balance"));
*/


				serno=serno+1;
			}

			bean.setSerlist(serlist);



			String sql="select  groupname area,g.doc_no areaid,site,coalesce(upper(concat(coalesce(site,''),',',coalesce(groupname,''))),'') as sited from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+contrno+"";

		//	System.out.println("===sitelist==="+sql);

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
				//fire 7 site in print qry
			String fire7site="select GROUP_CONCAT(sd.site) site from MY_SERVM sm left join cm_srvcsited sd on sm.costid=sd.tr_no where sm.tr_no="+trno+" ";
			Statement f7site=conn.createStatement();
			ResultSet f7rs=f7site.executeQuery(fire7site);
			while(f7rs.next()){
				bean.setFire7site(f7rs.getString("site"));
			}

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
	}




	public int getTrno(HttpSession session,String dtype,String branchid,Connection conn) throws SQLException {

		int trno=-1;
		//Connection Connection=null;
		try{

			//ClsConnection ClsConnection=new ClsConnection();

			//Connection=ClsConnection.getMyConnection();

			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			String insql="insert into my_trno(userno,trtype,brhid,edate,transid) values("+session.getAttribute("USERID").toString() +",'"+dtype+"',"+branchid +",NOW(),0)";
			int inres=stmt.executeUpdate(insql);

			if(inres<=0)
			{
				stmt.close();
				conn.close(); 
				return -1;
			}else{
				conn.commit();
			}

			String upsql="select max(trno) trno from my_trno ";
			ResultSet resultSet = stmt.executeQuery(upsql);

			while (resultSet.next()) {
				trno=resultSet.getInt("trno");
			}  

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();

		}

		//System.out.println(RESULTDATA);
		return trno;
	}

	public ArrayList getTax(HttpSession session,Double netamount,java.sql.Date date,String inter,int cldocno) throws SQLException {

		int trno=-1;
		int config=0;
		int cltax=0;
		Connection Connection=null;
		ArrayList taxlist=null;
		String tmp="";
		try{

			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
			Connection.setAutoCommit(false);


			taxlist=new ArrayList();
			
			Statement stmt = Connection.createStatement ();

			String consql="select method from gl_config where field_nme='tax'";
			ResultSet rsconfg = stmt.executeQuery(consql);

			while (rsconfg.next()) {
				config=rsconfg.getInt("method");
			}
			
			String clsql="select nontax from my_acbook where dtype='CRM' and cldocno='"+cldocno+"'";
			ResultSet rscltax = stmt.executeQuery(clsql);

			while (rscltax.next()) {
				cltax=rscltax.getInt("nontax");
			}

			if(config>0 && cltax==1){
			
				String upsql="";
				
				if(inter.equalsIgnoreCase("1")) //inter-state_IGST
				{
					upsql=" select t.tax_code,t.acno,t.value,cstper per,("+netamount+"*t.cstper)/100 as taxamt,t.doc_no docno "
							+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0" ;
				}
				else{
					upsql=" select t.tax_code,t.acno,t.value,per,("+netamount+"*t.per)/100 as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0" ;
				}
				//System.out.println("===exclusivetax====="+upsql);

				ResultSet resultSet = stmt.executeQuery(upsql);

				while (resultSet.next()) {

					
					tmp=resultSet.getString("t.tax_code")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");

					taxlist.add(tmp);
				}

			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
		//System.out.println(RESULTDATA);
		return taxlist;
	}	

	
	public ArrayList getinclusiveTax(HttpSession session,Double netamount,java.sql.Date date,String inter,int cldocno) throws SQLException {

		int trno=-1;
		int config=0;
		int cltax=0;
		Connection Connection=null;
		ArrayList taxlist=null;
		String tmp="";
		try{

			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
			Connection.setAutoCommit(false);

			taxlist=new ArrayList();
			Statement stmt = Connection.createStatement ();

			String consql="select method from gl_config where field_nme='tax'";
			ResultSet rsconfg = stmt.executeQuery(consql);

			while (rsconfg.next()) {
				config=rsconfg.getInt("method");
			}

			String clsql="select nontax from my_acbook where dtype='CRM' and cldocno='"+cldocno+"'";
			ResultSet rscltax = stmt.executeQuery(clsql);

			while (rscltax.next()) {
				cltax=rscltax.getInt("nontax");
			}

			if(config>0 && cltax==1){
			
			double totalper=0.0;
			String upsql="";
			
		if(inter.equalsIgnoreCase("1")) //inter-state_IGST
		{
			String netamtsql=" select cstper "
					+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0 " ;
			ResultSet resultSetnet = stmt.executeQuery(netamtsql);
			while (resultSetnet.next()) {
				totalper=totalper+resultSetnet.getDouble("cstper");
			}
			
			upsql=" select t.tax_code,t.acno,t.value,cstper per,round(( ("+netamount+" / (("+totalper+"/100)+1)))* (t.cstper/100),2) as taxamt,t.doc_no docno "
					+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0 " ;
		}
		else{
				String netamtsql=" select per "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0 " ;
				ResultSet resultSetnet = stmt.executeQuery(netamtsql);
				while (resultSetnet.next()) {
					totalper=totalper+resultSetnet.getDouble("per");
				}
				
				upsql=" select t.tax_code,t.acno,t.value,per,round(( ("+netamount+" / (("+totalper+"/100)+1)))* (t.per/100),2) as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0 " ;
		}
				
				
				System.out.println("===inclusivetax====="+upsql);

				ResultSet resultSet = stmt.executeQuery(upsql);

				while (resultSet.next()) {

					
					tmp=resultSet.getString("t.tax_code")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");

					taxlist.add(tmp);
				}

			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
		//System.out.println(RESULTDATA);
		return taxlist;
	}	
		

	public  JSONArray costCodeSearch() throws SQLException {
		
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	    Connection Connection=null;
	    
		try {
			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
				Statement stmtVehclr = Connection.createStatement ();
			
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) ";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
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
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,acno from my_acbook where  dtype='CRM'  " +sqltest);

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



}
