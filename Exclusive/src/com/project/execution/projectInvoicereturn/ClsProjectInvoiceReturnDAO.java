package com.project.execution.projectInvoicereturn;

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
import com.common.ClsVatInsert;
import com.connection.ClsConnection;

public class ClsProjectInvoiceReturnDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	
	ClsProjectInvoiceReturnBean bean= new ClsProjectInvoiceReturnBean();
	Connection conn;

	public int insert(Date sqldate,String rrefno,int reftrno,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,String legalamt,String seramt,String exptotal,
			String inctax,String pdid,String txtnotes,String ptype,Double taxamt,String txtpjivnettotal,String txtpjivnetlegalamt,String txtpjivnetrettotal,String txtpjivnetretlegalamt,
			ArrayList taxlist,String nontax) throws SQLException {
		try{
			int docno;
			int protrno;
			int trno=-1;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement ();
			
			String cltax="select nontax from my_acbook where doc_no="+clientid+"";
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
			
			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

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
			stmt1.setString(27,rrefno);
			stmt1.setInt(28,reftrno);
			stmt1.setString(29,txtpjivnetrettotal);
			stmt1.setString(30,txtpjivnetretlegalamt);
			stmt1.setString(31,txtpjivnettotal);
			stmt1.setString(32,txtpjivnetlegalamt);
			System.out.println("stmt1 ="+stmt1);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			System.out.println("docno====="+docno);
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

						String sql="INSERT INTO my_servretd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

					    System.out.println("==sitelist==="+sql);

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
				
				if(nontax.equalsIgnoreCase("1")){
				
				for(int i=0;i< taxlist.size();i++){

					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						totaltaxper=totaltaxper+Double.parseDouble(surveydet[2].trim());
					
						String sql="INSERT INTO my_invtaxretdet( rdocno, taxid,acno, per, amount)VALUES"
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
						
						System.out.println("taxdet==="+taxdet);
						
						if(!(taxdet[0].trim().equalsIgnoreCase("undefined")|| taxdet[0].trim().equalsIgnoreCase("NaN")||taxdet[0].trim().equalsIgnoreCase("")|| taxdet[0].isEmpty()))
						{
							System.out.println("taxdet[3]==="+taxdet[3]);
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
					
					
					
					System.out.println("-----type and rate----"+sqlveh) ;
					
					
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
								+ "values('"+sqldate+"','"+refno+"',"+docno+",'"+acnos+"','"+description+"','"+curris+"','"+rates+"',"+(pricetottal)*-1+","+(ldramounts)*-1+",0,"+(id)*-1+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

		                System.out.println("JV TRAN "+a+"="+sql11);

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
									+ "values('"+acnos+"','"+costtype+"',"+(ldramounts)*-1+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							System.out.println("==Cost Tran insertion===="+sql);

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
							 +"  from my_servretm d where doc_no="+docno+" ) a" ;
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
					//System.out.println("=== "+accdoc+"===== "+acnos);
						int result=ClsVatInsert.vatinsert(1,2,conn,trno,Integer.parseInt(clacno),docno,sqldate,"PJIR",session.getAttribute("BRANCHID").toString(),""+docno,1,arr,mode)	;
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

	public int edit(int trno,int docno,Date sqldate,String rrefno,int reftrno,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String inctax,String pdid,String txtnotes,String ptype,Double taxamt,String txtpjivnettotal,String txtpjivnetlegalamt,
			String txtpjivnetrettotal,String txtpjivnetretlegalamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			String nontax="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			
			String cltax="select nontax from my_acbook where doc_no="+clientid+"";
			ResultSet resultSetTax = stmt.executeQuery(cltax);
		    
			 while (resultSetTax.next()) {
				 nontax=resultSetTax.getString("nontax");
			 }
			 
			double totaltaxper=0.0;
			double taxcalcamt=Double.parseDouble(legalamt)+Double.parseDouble(seramt)+Double.parseDouble(exptotal);
			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN"))? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN"))? "0": invdata[1].trim();


			}

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


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

			stmt1.setString(27,rrefno);
			stmt1.setInt(28,reftrno);
			stmt1.setString(29,txtpjivnetrettotal);
			stmt1.setString(30,txtpjivnetretlegalamt);
			stmt1.setString(31,txtpjivnettotal);
			stmt1.setString(32,txtpjivnetlegalamt);
			
			stmt1.executeQuery();
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");

			request.setAttribute("docno", docno);

			int sitemethod=0;
			String description=desc;
			if(protrno>0){
				
				/*Deleting from my_servretd*/
				String sql1="DELETE FROM my_servretd WHERE tr_no="+protrno+"";
				
				System.out.println("edit 1===="+sql1);
				
				int data1=stmt.executeUpdate(sql1);
				/*Deleting from my_servretd Ends*/
				 
			    /*Deleting from my_invtaxretdet*/
				String sql2="DELETE FROM my_invtaxretdet WHERE rdocno="+trno+"";
				
				System.out.println("edit 2===="+sql2);
				
				
				int data2 = stmt.executeUpdate(sql2);
				/*Deleting from my_invtaxretdet Ends*/

				 /*Deleting from my_invtaxretdet*/
				String sql3="DELETE FROM my_jvtran WHERE tr_no="+trno+"";
				
				System.out.println("edit 3===="+sql3);
				
				int data3 = stmt.executeUpdate(sql3);
				/*Deleting from my_invtaxretdet Ends*/
				
				// site in jvtran with description
				String siteconfig="select method from gl_config where field_nme='invoicesite'";
				
				System.out.println("edit 4===="+siteconfig);
				
				ResultSet siters = stmt.executeQuery (siteconfig);
				if (siters.next()) {
					sitemethod=siters.getInt("method");
				}
				if(sitemethod==1)
				{
					String sitedata="select site from cm_srvcsited where tr_no='"+costid+"' order by rowno limit 1";
					
					System.out.println("edit 5===="+sitedata);
					
					
					ResultSet sitedatars = stmt.executeQuery (sitedata);
					if (sitedatars.next()) {
						description=contracttype+"-"+contractno+","+desc+"-"+sitedatars.getString("site");
					}
				}


				for(int i=0;i< exparray.size();i++){


					String[] surveydet=((String) exparray.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_servretd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

					    System.out.println("==sitelist==="+sql);

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
				
				if(nontax.equalsIgnoreCase("1")){
				
				for(int i=0;i< taxlist.size();i++){

					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						totaltaxper=totaltaxper+Double.parseDouble(surveydet[2].trim());
					
						String sql="INSERT INTO my_invtaxretdet( rdocno, taxid,acno, per, amount)VALUES"
								+ " ("+(protrno)+","
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"')";

						
						System.out.println("edit 6===="+sql);
						
						
						int rest = stmt.executeUpdate (sql);
						if(rest<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

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
				String sql5="";
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
							sql5="select  acno from my_account where codeno='AMC INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SJOB")){
							costtype=4;
							costcode=contractno;
							sql5="select  acno from my_account where codeno='SJOB INCOME' ";
						}
						
						System.out.println("==contracttype==="+contracttype);
						
						if(contracttype.equalsIgnoreCase("SINV")){
							costtype=0;
							costcode=contractno;
							sql5="select  acno from my_account where codeno='SINCOME' ";
						}

						System.out.println("edit 7==="+sql5);
						
						ResultSet tass1 = stmt.executeQuery(sql5);

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
								+ "values('"+sqldate+"','"+refno+"',"+docno+",'"+acnos+"','"+description+"','"+curris+"','"+rates+"',"+(pricetottal)*-1+","+(ldramounts)*-1+",0,"+(id)*-1+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

		                System.out.println("JV TRAN "+a+"="+sql11);

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
							
							
							
							String del="delete from my_costtran where tr_no='"+trno+"'";
							
							
							System.out.println("delete costtran==="+del);
							
							int rs3 = stmt.executeUpdate(del);
							
							
							
							
							

							String sql="insert into my_costtran(acno, costType, amount, tr_no, jobId,tranid,sr_no) "
									+ "values('"+acnos+"','"+costtype+"',"+(ldramounts)*-1+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							System.out.println("==Cost Tran edit===="+sql);

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
							 +"  from my_servretm d where doc_no="+docno+" ) a" ;
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
					//System.out.println("=== "+accdoc+"===== "+acnos);
						int result=ClsVatInsert.vatinsert(1,2,conn,trno,Integer.parseInt(clacno),docno,sqldate,"PJIR",session.getAttribute("BRANCHID").toString(),""+docno,1,arr,mode)	;
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

			return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}



	public int delete(int trno,int docno,Date sqldate,String rrefno,int reftrno,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String nettotal,String pdid,String txtnotes,String ptype,Double taxamt,String txtpjivnettotal,String txtpjivnetlegalamt,
			String txtpjivnetrettotal,String txtpjivnetretlegalamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN"))? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN"))? "0": invdata[1].trim();


			}

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


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

			stmt1.setString(27,rrefno);
			stmt1.setInt(28,reftrno);
			stmt1.setString(29,txtpjivnetrettotal);
			stmt1.setString(30,txtpjivnetretlegalamt);
			stmt1.setString(31,txtpjivnettotal);
			stmt1.setString(32,txtpjivnetlegalamt);
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




	public JSONArray contractSrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String dtype,String ptype) throws SQLException {

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
			sqltest1=" having  duedate<='"+sqlStartDate+"'";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cm.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
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
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


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



			//			System.out.println("======contractSrearch===="+sqldata);

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

	public JSONArray serviceGridLoading(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select sm.ref_type dtype,m.doc_no docno,sm.date,sm.description descp,round(sm.atotal,2) atotal,round(sm.legalchrg,2) legalchrg,round(sm.retAmount,2) retamount,"
					+ "round(sm.retLegalCharge,2) retlegalcharge,(round(sm.atotal,2)-round(sm.retAmount,2)) amount,(round(sm.legalchrg,2)-round(sm.retLegalCharge,2)) lfee from "
					+ "my_servm sm left join  cm_srvcontrm m on(sm.costid=m.tr_no) where sm.status=3 and sm.tr_no="+trno+"";

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
	
	public JSONArray serviceGridReoading(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select sm.ref_type dtype,m.doc_no docno,sm.date,sm.description descp,round(sm.atotal,2) amount,round(sm.legalchrg,2) lfee,(round(inv.retAmount,2)-round(sm.atotal,2)) retamount,(round(inv.retLegalCharge,2)-round(sm.legalchrg,2)) retlegalcharge,"
					+ "round(pjivAmount,2) atotal,round(pjivLegalCharge,2) legalchrg from my_servretm sm left join my_servm inv on sm.rtrno=inv.tr_no left join  cm_srvcontrm m on(sm.costid=m.tr_no) where sm.status=3 and m.status=3 and sm.tr_no="+trno+"";

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

	public JSONArray expenseGridReloading(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select description desc1,productid as prdid,productid as psrno,round(qty) qty,round(amount,2) amount,round(nettotal,2) as total "
					+ "from my_servretd where tr_no="+trno+" ";

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

	public JSONArray expenseGridLoading(HttpSession session,String pjinvtrno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select description desc1,productid as prdid,productid as psrno,round(qty) qty,round(amount,2) amount,round(nettotal,2) as total "
					+ "from my_servd where tr_no="+pjinvtrno+" ";
System.out.println("========="+sql);
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

	public JSONArray projectInvoiceGridLoading(HttpSession session,String msdocno,String clnames,String contno,String invdate,String invtype) throws SQLException {


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

			String clssql= ("select m.doc_no,m.refdocno contno,m.refno,m.date,ac.refname client,concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
					+ "m.ref_type contype,m.tr_no,m.cldocno,m.costid,m.acno clacno,m.costtype conttypeval,m.description desp,CONVERT(if(refdocno=0,c2.description,refdocno),CHAR(100)) as refdocno,m.pdrowno,"
					+ "round(m.etotal,2) etotal,round(m.netamount,2) netamount,round(m.atotal) as atotal,round(m.legalchrg,2) as legalchrg,coalesce(notes,'') notes,"
					+ "CASE WHEN m.ref_type='AMC' Then 3 WHEN m.ref_type='SJOB' Then 4 WHEN m.ref_type='SAMC' Then 3 ELSE 0 END AS contypeid,CASE WHEN m.ref_type='SAMC' Then 2 WHEN m.ref_type='SINV' Then m.ref_type ELSE 1 END AS ptypeid "
					+ "from my_servm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_ccentre c2 on(c2.doc_no=m.costid) where m.status=3 and ((round(m.atotal,2)-round(m.retAmount,2))>0 or (round(m.legalchrg,2)-round(m.retLegalCharge,2))>0) "
					+ "and m.brhid="+brid+" " +sqltest);
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
	
	public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String contno,String invdate,String invtype) throws SQLException {


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
		if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(invdate);
		}






		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no="+msdocno+" ";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.rdocno like '%"+contno+"%'";
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
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select m.doc_no,m.rdocno contno,ac.refname client,m.date,if(m.costtype=3,'AMC','SJOB') contype,m.tr_no from my_servretm m "
					+ "left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 and m.brhid="+brid+" " +sqltest);
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

	public ClsProjectInvoiceReturnBean getViewDetails(HttpSession session,int trno,String branchid) throws SQLException {
		ClsProjectInvoiceReturnBean ProinvretBean = new ClsProjectInvoiceReturnBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtPRIV = conn.createStatement();

			String branch = branchid;
			
			ResultSet resultSet = stmtPRIV.executeQuery ("select m.tr_no,m.doc_no,m.date,m.rdocno,m.rtrno,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.costtype,if(refdocno=0,c2.description,refdocno) as refdocno,m.pdrowno,round(m.etotal,2) etotal,round(m.netamount,2) netamount,round(m.atotal) as atotal,round(m.legalchrg,2) as legalchrg,coalesce(notes,'') notes,"
					+ "m.ctype,CASE WHEN m.ref_type='AMC' Then 3 WHEN m.ref_type='SJOB' Then 4 WHEN m.ref_type='SAMC' Then 3 ELSE 0 END AS contypeid,CASE WHEN m.ref_type='SAMC' Then 2 WHEN m.ref_type='SINV' Then m.ref_type ELSE 1 END AS ptypeid "
					+ "from my_servretm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join my_ccentre c2 on(c2.doc_no=m.costid)  where m.status=3 and m.dtype='PJIR' and m.brhid="+branch+" and m.tr_no="+trno+"");

			while (resultSet.next()) {
				ProinvretBean.setDocno(resultSet.getInt("doc_no"));
				ProinvretBean.setDate(resultSet.getDate("date").toString());
				ProinvretBean.setRrefno(resultSet.getString("rdocno"));
				ProinvretBean.setRreftrno(resultSet.getInt("rtrno"));
				ProinvretBean.setHidnireftype("PJIV");
				ProinvretBean.setRefno(resultSet.getString("refno"));
				ProinvretBean.setTxtclient(resultSet.getString("client"));
				ProinvretBean.setTxtclientdet(resultSet.getString("details"));
				ProinvretBean.setCmbcontracttype(resultSet.getString("conttype"));
				ProinvretBean.setCmbcontracttypeid(resultSet.getString("contypeid"));
				ProinvretBean.setContypeval(resultSet.getString("costtype"));
				ProinvretBean.setDesc(resultSet.getString("desp"));
				ProinvretBean.setMaintrno(resultSet.getInt("tr_no"));
				ProinvretBean.setClientid(resultSet.getInt("cldocno"));
				ProinvretBean.setClacno(resultSet.getString("clacno"));
				ProinvretBean.setCostid(resultSet.getInt("costid"));
				ProinvretBean.setTxtrefdetails(resultSet.getString("refdocno"));
				
				ProinvretBean.setPdid(resultSet.getString("pdrowno"));
				ProinvretBean.setTxtnettotal(resultSet.getString("netamount"));
				ProinvretBean.setTxtseramt(resultSet.getString("atotal"));
				ProinvretBean.setTxtlegalamt(resultSet.getString("legalchrg"));
				ProinvretBean.setTxtexptotal(resultSet.getString("etotal"));
				ProinvretBean.setTxtnotes(resultSet.getString("notes"));
				ProinvretBean.setTxtcontract(resultSet.getInt("refdocno"));
				ProinvretBean.setPtype(resultSet.getString("ctype"));
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
		return ProinvretBean;
	}

	public ClsProjectInvoiceReturnBean getPrint(HttpServletRequest request,int docNo,int branch,int trno,String dtype) throws SQLException {
		ClsProjectInvoiceReturnBean bean = new ClsProjectInvoiceReturnBean();
		 Connection conn = null;
		 
		try {
			
				conn = conobj.getMyConnection();
				Statement stmtPJIR = conn.createStatement();
				
				
				String headersql="select if(m.dtype='PJIV','TAX INVOICE RETURN','  ') vouchername,c.company,c.address,c.tel,c.fax,c.email,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno,b.tinno,m.rdocno from my_servretm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='PJIR' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtPJIR.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						bean.setLblcomptrno(resultSetHead.getString("tinno"));
						bean.setLblrrefno(resultSetHead.getString("rdocno"));
						bean.setLblemail(resultSetHead.getString("email"));
					}
					/*TCN No=====concat(c.comp_code,'/',year(sm.date),'/',LPAD(m.doc_no,4,0))series,*/
					
				String sql="select m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,m.notes,round((coalesce(m.atotal,0)+coalesce(m.legalchrg,0)),2) grossamount,round(coalesce(d.amount,0),2) vatamount,concat(c.comp_code,'/','CN','/',substring(m.doc_no,1,4),'/',substring(m.doc_no,5,9)) series,"
					+ "(round((coalesce(m.atotal,0)+coalesce(m.legalchrg,0)),2)+round(coalesce(d.amount,0),2)) nettotal,GROUP_CONCAT(sd.site) site,a.refname,a.address,a.tinno from my_servretm m left join my_invtaxretdet d on m.tr_no=d.rdocno "
					+ "left join my_servm sm on m.rtrno=sm.tr_no left join cm_srvcsited sd on sm.costid=sd.tr_no left join my_acbook a on (m.cldocno=a.doc_no and a.dtype='CRM') left join my_comp c on c.doc_no=sm.cmpid where m.status=3 and m.tr_no="+trno+"";
							
					ResultSet resultSet = stmtPJIR.executeQuery(sql);
					System.out.println("sqlqry____________"+sql);
					
					ClsAmountToWords atw=new ClsAmountToWords();
					while(resultSet.next()){
						bean.setLbldocno(resultSet.getString("doc_no"));
						bean.setLbldate(resultSet.getString("date"));
						bean.setLblrefno(resultSet.getString("refno"));
						bean.setLblnotes(resultSet.getString("notes"));
						bean.setLblsite(resultSet.getString("site"));
						bean.setLblclientname(resultSet.getString("refname"));
						bean.setLblclientaddress(resultSet.getString("address"));
						bean.setLblclienttrno(resultSet.getString("tinno"));
						bean.setLblgrossamount(resultSet.getString("grossamount"));
						bean.setLblvatamount(resultSet.getString("vatamount"));
						bean.setLblnettotal(resultSet.getString("nettotal"));
						bean.setSeries(resultSet.getString("series"));
						bean.setLblamountinwords(atw.convertAmountToWords(resultSet.getString("nettotal")));
					}
					
					String sqlreturndet="select @i:=@i+1 srno, a.* from (select CONVERT(description,CHAR(1000)) description,'' amount,'1' qty,round(atotal,2) price,'5%' vatperc,"
					   + "round(atotal,2) pricetot from my_servretm where status=3 and tr_no="+trno+" UNION ALL select CONVERT('',CHAR(50)) description,'' amount,'1' qty,round(legalchrg,2) price,"
					   + "'' vatperc,'' pricetot from my_servretm where status=3 and legalchrg>0 and tr_no="+trno+") a,(SELECT @i:= 0) as i UNION ALL select '' srno,CONVERT('',CHAR(50)) description,"
					   + "'' amount,'' qty,'' price,'' vatperc,'' pricetot UNION ALL select '' srno,CONVERT('',CHAR(50)) description,'' amount,'' qty,'' price,'' vatperc,'' pricetot UNION ALL "
					   + "select '' srno,CONVERT(CONCAT('Initial Tax Invoice No.',sm.rdocno,' Dated ',DATE_FORMAT(inv.date,'%d-%m-%Y'),' (excluding VAT)'),CHAR(500)) description,round(sm.pjivamount,2) amount,"
					   + "'' qty,'' price,'' vatperc,'' pricetot from my_servretm sm left join my_servm inv on sm.rtrno=inv.tr_no where sm.status=3 and sm.tr_no="+trno+" UNION ALL select '' srno,"
					   + "CONVERT('Revised value(excluding VAT)',CHAR(50)) description,round(pjivamount-atotal,2) amount,'' qty,'' price,'' vatperc,'' pricetot from my_servretm where status=3 and tr_no="+trno+"";
				
					bean.setLblreturndetailsquery(sqlreturndet);
				
				stmtPJIR.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
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
