package com.sales.InventoryTransfer.goodsissuenote;

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
 
 
public class ClsGoodsissuenoteDAO {     

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	Connection conn=null;
public int insert(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno) throws SQLException {
	 

	
	
	try{
		int docno;
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtgin= conn.prepareCall("{call tr_goodsissuenoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtgin.registerOutParameter(15, java.sql.Types.INTEGER);
		stmtgin.registerOutParameter(16, java.sql.Types.INTEGER);

		stmtgin.setDate(1,masterdate);
		stmtgin.setString(2,refno);
		stmtgin.setString(3,purdesc);
		stmtgin.setDouble(4,productTotal);
	  	 
		stmtgin.setString(5,session.getAttribute("USERID").toString());
		stmtgin.setString(6,session.getAttribute("BRANCHID").toString());
		stmtgin.setString(7,session.getAttribute("COMPANYID").toString());
		
		
	//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
		stmtgin.setString(8,formdetailcode);
		stmtgin.setString(9,mode);
 
		
		stmtgin.setInt(10,txtlocationid);
		
 
		stmtgin.setInt(11,siteid);
		stmtgin.setInt(12,type);
		stmtgin.setInt(13,itemtype);
		stmtgin.setInt(14,itemdocno);
		stmtgin.setInt(17,cldocno);
		
		
		stmtgin.executeQuery();
		docno=stmtgin.getInt("docNo");
 
		int vocno=stmtgin.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		 Statement stmt1=conn.createStatement();
		 
		 Statement stmt=conn.createStatement();
		 
		 
	 
		 
		 
			String sqlss11="select doc_no from cm_srvcontrm where tr_no="+itemdocno+" ";
			ResultSet selrs1=stmt1.executeQuery(sqlss11);
			
			if(selrs1.next())
			{
				itemdocno=selrs1.getInt("doc_no");
				
			}
		 
		 
		 
		 
			int mastertr_no=0;
			String sqlss="select tr_no from my_gism where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("tr_no");
				
			}
			int prodet=0;
			int prodout=0;
			for(int i=0;i< masterarray.size();i++){

				String[] prod=((String) masterarray.get(i)).split("::");
				System.out.println("prod[0]===="+prod[0]);
				if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

			String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			String specno=""+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"";
								 
			String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
			double masterqty=Double.parseDouble(rqty);
			double masterqty1=Double.parseDouble(rqty);
			
			 String unitidss=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
			    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			     
		    	 
		         
			     double fr=1;
			     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
			     
			     System.out.println("====slss==="+slss);
			     ResultSet rv1=stmt.executeQuery(slss);
			     if(rv1.next())
			     {
			    	 fr=rv1.getDouble("fr"); 
			     }
			     
			     
			    
					String sql="insert into my_gisd(TR_NO, SR_NO,rdocno,stockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,fr)VALUES"
							+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
							+ "'0',"
							+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
							+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
							+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
							+ "'"+masterqty+"',"
							+ "'0',"
							+ "'0',"
				 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
							+ "0,"+fr+")";

					//System.out.println("asdassssssssssssssssssssss"+sql);
					
					 stmt.executeUpdate(sql);
			     
			     
	    	 
			double balstkqty=0;
			double balstkqty1=0;
			int psrno=0;
			int stockid=0;
			double remstkqty=0;
			double outstkqty=0;
			double stkqty=0;
			double qty=0;
			double detqty=0;
			double unitprice=0.0;
			double tmp_qty=0.0;
			double outqtys=0.0;
			double refqty=0.0;
			String qty_fld="";
			String qryapnd="";
			String slquery="";
			masterqty=masterqty*fr;
			String loc="";
			
			
			double cost_price=0;
			 
			
			int locids=0;
			
		 
				qty_fld="out_qty";
				//qryapnd="and cost_price="+unitprice+"";
				//qryapnd="and stockid="+stkid+"";
			 	slquery="(out_qty+rsv_qty+del_qty)";
			  
			 	loc="and locid="+txtlocationid+" ";
				
		 

			


			Statement stmtstk=conn.createStatement();

			String stkSql="select cost_price,locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
					+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "+loc+"  and date<='"+masterdate+"'  "
					+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-"+slquery+"))>0 order by date,stockid";

			System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);

			ResultSet rsstk = stmtstk.executeQuery(stkSql);

			while(rsstk.next()) {

				balstkqty1=rsstk.getDouble("balstkqty");
				balstkqty=rsstk.getDouble("balstkqty");
				psrno=rsstk.getInt("psrno");
				outstkqty=rsstk.getDouble("out_qty");
				stockid=rsstk.getInt("stockid");
				stkqty=rsstk.getDouble("stkqty");
				qty=rsstk.getDouble("qty");
				outqtys=rsstk.getDouble("qtys");
				locids=rsstk.getInt("locid");
				 
				cost_price=rsstk.getDouble("cost_price");
				
				refqty=masterqty;
				System.out.println("---masterqty-----"+masterqty);	
				System.out.println("---balstkqty-----"+balstkqty);	
				System.out.println("---out_qty-----"+outstkqty);	
				System.out.println("---stkqty-----"+stkqty);
				System.out.println("---qty-----"+qty);
				
				System.out.println("---cost_price-----"+cost_price);
				

				String queryappnd="";
				
				/*if((rreftype.equalsIgnoreCase("SOR"))||(rreftype.equalsIgnoreCase("DEL"))){
					queryappnd=","+qty_fld+"="+tmp_qty+"";
				}*/

				if(remstkqty>0)
				{

					masterqty=remstkqty;
				}

				 
				if(masterqty<=balstkqty)
				{
					detqty=masterqty;

	 
			        queryappnd=","+qty_fld+"="+tmp_qty+"";	
					  
						
					 
					
					
					System.out.println("-----queryappnd-----"+queryappnd);
					

					masterqty=masterqty+outqtys;

					
					
					String sqls="update my_prddin set out_qty="+masterqty+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"   ";
					System.out.println("--1---sqls---"+sqls);
					stmt.executeUpdate(sqls);
	

					masterqty=detqty;
				}
				else if(masterqty>balstkqty)
				{



					if(stkqty>=(masterqty+outstkqty))

					{
						balstkqty=masterqty+outqtys;	
						remstkqty=stkqty-outstkqty;

						System.out.println("---balstkqty-1---"+balstkqty);
					}
					else
					{
						remstkqty=masterqty-balstkqty;
						balstkqty=stkqty-outstkqty+outqtys;

						System.out.println("---masterqty-2---"+masterqty);
						System.out.println("---outstkqty-2---"+outstkqty);
						System.out.println("---stkqty-2---"+stkqty);
						System.out.println("---remstkqty-2---"+remstkqty);
						System.out.println("---balstkqty--2--"+balstkqty);
					}
					detqty=stkqty-outstkqty;
 
					
					String sqls="update my_prddin set out_qty="+balstkqty+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
					System.out.println("-2----sqls---"+sqls);

					stmt.executeUpdate(sqls);	

					//remstkqty=masterqty-stkqty;



				}



	 
	/*			 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
						   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+rows[i].cost_price+" ::"+rows[i].savecost_price);
				
 
*/
               /*  double totalcostprice=cost_price*detqty;
				String sql="insert into my_gisd(TR_NO, SR_NO,rdocno,stockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid)VALUES"
						+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
						+ "'"+stockid+"',"
						+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
						+ "'"+detqty+"',"
						+ ""+cost_price+","
						+ ""+totalcostprice+","
			 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
						+ "'"+locids+"')";

				 stmt.executeUpdate(sql);*/
					
					
				
				 
                
				String cost_prices="0";

				Statement stmtstk1=conn.createStatement();

				String stkSql1="select  cost_price  from my_prddin where stockid='"+stockid+"'";

				System.out.println("=stkSql1 select cost_price insert="+stkSql1);

				ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);

				if(rsstk1.next()) {
					cost_prices=rsstk1.getString("cost_price");
				}
				
				
				
				
			String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,cost_price) Values"
							+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"+docno+","
							+ "'"+stockid+"',"
							+ "'"+masterdate+"',"
							+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
							+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
							+ "'"+detqty+"',"
							+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
							+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"',"+cost_prices+")";

				  
				System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
				prodout = stmt.executeUpdate (prodoutsql);
				System.out.println("masterqty--------------------------->>>>"+masterqty);
				
				System.out.println("balstkqty1---------------------------------->>>>"+balstkqty1);
		 	if(masterqty<=balstkqty1)
				{
					break;
				} 


			}
				}
				}
			
			String vendorcur="1"; 
			double venrate=1;
			
	 int accounts=0;
	 
	 
	 double  finalamt=0;
		String refdetails="GIS"+""+vocno;
		
		int trno=mastertr_no;
	 
		//String sql30="select tr_no,sum(totalcost_price) totalcost_price from my_gisd where rdocno='"+docno+"' ";
		
		String sql30="select tr_no,sum(totalcost_price) totalcost_price from ( select tr_no,cost_price*qty totalcost_price from my_prddout where tr_no="+trno+") a group by tr_no ";
		
		
		System.out.println("-----4--sql2----"+sql30) ;

			ResultSet tass30 = stmt.executeQuery (sql30);

			if (tass30.next()) {

				finalamt=tass30.getDouble("totalcost_price");		
				trno=tass30.getInt("tr_no");
			}
		 
	 
	 
				
			String sql29="select acno from my_issuetype where doc_no='"+type+"' ";
		System.out.println("-----4--sql2----"+sql29) ;

			ResultSet tass19 = stmt.executeQuery (sql29);

			if (tass19.next()) {

				accounts=tass19.getInt("acno");		

			}
		 
			

			String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
			//System.out.println("---1----sqls10----"+sqls10) ;
			ResultSet tass11 = stmt.executeQuery (sqls10);
			if(tass11.next()) {

				vendorcur=tass11.getString("curid");	


			}


			String currencytype="";
			String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
			 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
			ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

			while (resultSet33.next()) {
				venrate=resultSet33.getDouble("rate");
				currencytype=resultSet33.getString("type");
			}

			double	dramount=finalamt; 


			double ldramount=0;
			if(currencytype.equalsIgnoreCase("D"))
			{


				ldramount=dramount/venrate ;  
			}

			else
			{
				ldramount=dramount*venrate ;  
			}



			String sql1="";
		/*	if(itemtype==1)
			{*/

				  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";
         	
/*			}
			else if(itemtype==6)
			{

				  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,6,"+itemdocno+")";
         	
			}
			else
			{
				  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"',0,0,'GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
         	
			}
				*/
			
			
			//	System.out.println("--sql1----"+sql1);
			int ss = stmt.executeUpdate(sql1);

			if(ss<=0)
			{
				conn.close();
				return 0;

			}
			
			int acnos=0;
			String curris="1";
			double rates=1;



			String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
			//System.out.println("-----4--sql2----"+sql2) ;

			ResultSet tass1 = stmt.executeQuery (sql2);

			if (tass1.next()) {

				acnos=tass1.getInt("acno");		

			}



			String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
			//System.out.println("-----5--sqls3----"+sqls3) ;
			ResultSet tass3 = stmt.executeQuery (sqls3);

			if (tass3.next()) {

				curris=tass3.getString("curid");	


			}
			String currencytype1="";
			String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
			//System.out.println("-----6--sqlveh----"+sqlveh) ;
			ResultSet resultSet44 = stmt.executeQuery(sqlveh);

			while (resultSet44.next()) {
				rates=resultSet44.getDouble("rate");
				currencytype1=resultSet44.getString("type");
			} 

			double pricetottal=finalamt*-1;
			double ldramounts=0 ;     
			if(currencytype1.equalsIgnoreCase("D"))
			{

				ldramounts=pricetottal/venrate ;  
			}

			else
			{
				ldramounts=pricetottal*venrate ;  
			}

			String sql11="";
			/*if(itemtype==1)
			{*/

			  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
					+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";

			/*}*/
	/*		else if(itemtype==6)
			{

			  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
					+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,6,"+itemdocno+")";

			}
			else
			{

				  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"',0,0,'GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
	
			}*/
			// System.out.println("---sql11----"+sql11) ; 

			int ss1 = stmt.executeUpdate(sql11);

			if(ss1<=0)
			{
				conn.close();
				return 0;

			}
			
			
			
			if(itemtype>0)
			{

				 int TRANIDs=0;
				 int sno=1;
				  
			Statement sss=conn.createStatement();
					String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+mastertr_no+" and acno="+accounts+" ";
			
					ResultSet tass111 = sss.executeQuery (trsqlss);
					
					if (tass111.next()) {
				
						TRANIDs=tass111.getInt("TRANID");	
					
					
						
				     }
					
					String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
							+ " "+itemtype+","+finalamt+","+itemdocno+","+TRANIDs+","+mastertr_no+")";
							 
			  int costabsq=  stmtgin.executeUpdate(ssql);
			  
			  if(costabsq<=0)
				{
					conn.close();
					return 0;
					
				}
			}
			  String dql34= "delete from my_jvtran where    tr_no='"+trno+"' and dramount=0  ";
	    	  stmt.executeUpdate(dql34); 
			
			if(docno>0)
			{
			 	conn.commit();
				stmtgin.close();
				conn.close();
				return docno;
				
			}
	 
			
			}
/*		for(int i=0;i< masterarray.size();i++){

			String[] prod=((String) masterarray.get(i)).split("::");
			System.out.println("prod[0]===="+prod[0]);
			if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


				double balstkqty=0;
	 
				int psrno=0;
				int stockid=0;
				double remstkqty=0;
				double outstkqty=0;
				double stkqty=0;
				double qty=0;
				double detqty=0;
				double unitprice=0.0;
				double tmp_qty=0.0;
				double outqtys=0.0;
				double refqty=0.0;
				 
				String loc="";
				 
				
				int locids=0;	 
					
					
		
 
		String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
		String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
		String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
		String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
		double masterqty=Double.parseDouble(rqty);
		Statement stmtstk=conn.createStatement();
		
		String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum(op_qty-out_qty+rsv_qty+del_qty) balstkqty,sum(out_qty+rsv_qty+del_qty) out_qty, "
				+ " out_qty as qty,out_qty qtys,date from my_prddin "
				+ "where psrno='"+prdid+"' and specno='"+specno+"'  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"  "
				+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-out_qty+rsv_qty+del_qty))>0 order by date,stockid";

		 
		ResultSet rsstk = stmtstk.executeQuery(stkSql);

		while(rsstk.next()) {

		
			balstkqty=rsstk.getDouble("balstkqty");
			psrno=rsstk.getInt("psrno");
			outstkqty=rsstk.getDouble("out_qty");
			stockid=rsstk.getInt("stockid");
			stkqty=rsstk.getDouble("stkqty");
			qty=rsstk.getDouble("qty");
			outqtys=rsstk.getDouble("qtys");
			locids=rsstk.getInt("locid");
			 
			
			
			refqty=masterqty;
			System.out.println("---masterqty-----"+masterqty);	
			System.out.println("---balstkqty-----"+balstkqty);	
			System.out.println("---out_qty-----"+outstkqty);	
			System.out.println("---stkqty-----"+stkqty);
			System.out.println("---qty-----"+qty);

			String queryappnd="";
	 

			if(remstkqty>0)
			{

				masterqty=remstkqty;
			}

			 
			if(masterqty<=balstkqty)
			{
				detqty=masterqty;

			 
				
				
				System.out.println("-----queryappnd-----"+queryappnd);
				

				masterqty=masterqty+outqtys;

				
				
				String sqls="update my_prddin set out_qty="+masterqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"   ";
				System.out.println("--1---sqls---"+sqls);
				stmt.executeUpdate(sqls);



			}
			else if(masterqty>balstkqty)
			{



				if(stkqty>=(masterqty+outstkqty))

				{
					balstkqty=masterqty+outqtys;	
					remstkqty=stkqty-outstkqty;

					System.out.println("---balstkqty-1---"+balstkqty);
				}
				else
				{
					remstkqty=masterqty-balstkqty;
					balstkqty=stkqty-outstkqty+outqtys;

					System.out.println("---masterqty-2---"+masterqty);
					System.out.println("---outstkqty-2---"+outstkqty);
					System.out.println("---stkqty-2---"+stkqty);
					System.out.println("---remstkqty-2---"+remstkqty);
					System.out.println("---balstkqty--2--"+balstkqty);
				}
				detqty=stkqty-outstkqty;

		  
					
				}
				
				
				
				String sqls="update my_prddin set out_qty="+balstkqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
				System.out.println("-2----sqls---"+sqls);

				stmt.executeUpdate(sqls);	

				//remstkqty=masterqty-stkqty;



			}



 

 
 

			String prodoutsql="";

	 
				
				
				 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid) Values"
						+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"+docno+","
						+ "'"+stockid+"',"
						+ "'"+masterdate+"',"
						+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+detqty+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"')";

				
			 
			

			System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
			 stmt.executeUpdate (prodoutsql);

	 	if(masterqty<=balstkqty1)
			{
				break;
			} 
 

		}




		}*/

	
	
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	conn.close();
	return 0;
}


 
 
	
	
public   JSONArray locationsearch(HttpSession session) throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no,brhid from my_locm where status=3 and brhid="+session.getAttribute("BRANCHID").toString()+"" );
 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				


			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}


public   JSONArray searchProduct(HttpSession session,String locid,String date,
		String prdname,String brandname,String id,String gridunit,String gridprdname,String category, String subcategory) throws SQLException {

	 JSONArray RESULTDATA=new JSONArray();
	 
		if(!(id.equalsIgnoreCase("1"))){
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
	    String brcid=session.getAttribute("BRANCHID").toString();
	   
	Connection conn = null;

	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 
    	
			int method=0;
			
			String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
			ResultSet rs=stmtVeh.executeQuery(chk); 
			if(rs.next())
			{
				
				method=rs.getInt("method");
			}
			

			java.sql.Date sqlStartDate=null;


			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
			{
				sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
			}
			String condtn="";
			
			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn +="  and m.part_no like '%"+prdname+"%' ";
			}
			
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and bd.brandname like '%"+brandname+"%' ";
			}
			
			gridprdname=gridprdname.replaceAll("@","%");
			if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
				condtn +="  and m.productname like '%"+gridprdname+"%' ";
			}
			
			if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
				condtn +="  and u.unit like '%"+gridunit+"%' ";
			}
			
			if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
				condtn +="  and c.category like '%"+category+"%' ";
			}
			
			if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
				condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
			}
			
			String	sql="select   bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
					+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qutval,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
					+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty))*i.cost_price savecost_price,i.cost_price from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
					+ "  left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i "
					+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )    "
					+ "where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+locid+"' and i.date<='"+sqlStartDate+"'  "+condtn+" "
					+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
			
			
			System.out.println("---sql----"+sql);
			
 
 
			ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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



public JSONArray brandSearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="select doc_no,brandname from my_brand where status=3";

		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}

public JSONArray subCategorySearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="select doc_no,subcategory from my_scatm where status=3";

		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}











public JSONArray costunitsearch(HttpSession session,String typedocno,String docno,String refnames,String search) throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
          
          Connection conn = null; 
         
        try {
           conn = ClsConnection.getMyConnection();
           ClsCommon ClsCommon=new ClsCommon();
           Statement stmtmain = conn.createStatement();
   
           if(search.equalsIgnoreCase("yes")) {
            
            String sql="";
            
            if(typedocno.equalsIgnoreCase("1")) {
             
             sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "
                + "my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
            
            } else {
             
              String costgroup="";String sqltest="";
              Statement stmt=conn.createStatement();
              
              String sqls="select costtype,costgroup from my_costunit where costtype='"+typedocno+"' ";

              ResultSet rs=stmt.executeQuery(sqls);
              
              if(rs.next()) {
               costgroup=rs.getString("costgroup");
              }
              
             if(!(refnames.equalsIgnoreCase("0")) && !(refnames.equalsIgnoreCase(""))){
               sqltest=sqltest+" and ac.refname like '%"+refnames+"%'";
          }
             
             if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
                 sqltest=sqltest+" and m.doc_no='"+docno+"'";
             }
             
                    if(typedocno.equalsIgnoreCase("3") || typedocno.equalsIgnoreCase("4")) {
              
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_srvcontrm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.tr_no=m.tr_no where m.status=3  and m.dtype='"+costgroup+"' and m.pstatus!=1  "+sqltest+"";
              
             }
             
             if(typedocno.equalsIgnoreCase("5")) {
              
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.contracttype,' ',m.contractno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_cuscallm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.rowno=m.siteid where  m.status in(3)  "+sqltest+"";
              }
              
              stmt.close();
             
            }
            
           System.out.println("SQL ="+sql);
           ResultSet resultSet = stmtmain.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
              
           stmtmain.close();
           conn.close();
           }
         stmtmain.close();
         conn.close();
        } catch(Exception e){
          e.printStackTrace();
          conn.close();
        } finally{
      conn.close();
     }
          return RESULTDATA;
     }




public JSONArray fleetSearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement(); 


		String sql="select fleet_no fleetno ,flname fleetname,reg_no regno from gl_vehmaster where cost=0 ";
 
  
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}




public JSONArray prdGridReloads(HttpSession session,String docno,String locationid,String date) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();


		String sql="";
		int method=0;
 


		java.sql.Date sqlStartDate=null;


		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		}

/* old
		sql="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
				+ "case when (totqty-outqty)=0 then 0 else (balqty) end as balqty,0 size,part_no,productid as proid,productid,"
				+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
				+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
				+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select bd.brandname,i.stockid as stkid,"
				+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,ii.inblqty as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
				+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
				+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)"
				+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
				+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid)  "
				+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
				+ "	from my_prddin where 1=1 group by psrno,locid) ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid) "
				+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locationid+"'   group by i.prdid "
				+ "  order by  i.prdid,i.date ) as a ) as b ; ";*/
	   /*prodoc ,unitdocno, psrno ,specid, unit*/
		
		
	 
	/*	multi
		sql="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, qty,qty as oldqty,outqty,"
				+ " qutval,0 size,part_no,productid as proid,productid,"
				+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
				+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys+qty as qutval, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
				+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select bd.brandname,i.stockid as stkid,"
				+ "d.specno as specid,d.rdocno,m.doc_no psrno,d.qty as qty,ii.inblqty/d.fr as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty)/d.fr as outqty,"
				+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
				+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)"
				+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
				+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid   and i.locid='"+locationid+"'  and i.date<='"+sqlStartDate+"' )  "
				+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
				+ "	   from my_prddin where locid='"+locationid+"' and  date<='"+sqlStartDate+"' group by psrno,brhid) ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid  ) "
				+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'   group by d.psrno,d.unitid,d.specno"
				+ "  order by  d.prdid,i.date ) as a ) as b ; ";
				
		*/
		
		sql="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, qty,qty as oldqty,outqty,"
				+ " qutval,0 size,part_no,productid as proid,productid,"
				+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
				+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys+qty as qutval, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
				+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select bd.brandname,0 as stkid,"
				+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,ii.inblqty/d.fr as qtys,outqty/d.fr as outqty,"
				+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
				+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)"
				+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  "
				+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
				+ "	   from my_prddin where locid='"+locationid+"' and  date<='"+sqlStartDate+"' group by psrno,brhid) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid and d.specno=ii.specno and ma.brhid=ii.brhid  ) "
				+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'   group by d.psrno,d.unitid,d.specno"
				+ "  order by  d.prdid ) as a ) as b ; ";
		
		
		System.out.println("=========23333===================="+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}





public   JSONArray mainsearch(HttpSession session,String docnoss,String types,String datess,String aa,String prjdocnos) throws SQLException {

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
    
    
    
    java.sql.Date  sqlStartDate = null;
  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
      	{
      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
      	}
      	
      	
  	    
  		String sqltest="";
  	    
  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
      	}
      	if((!(types.equalsIgnoreCase(""))) && (!(types.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and t.type like '%"+types+"%'  ";
      	}
       String sqlsss2="";
      	if((!(prjdocnos.equalsIgnoreCase(""))) && (!(prjdocnos.equalsIgnoreCase("NA")))){
      		sqlsss2= " and a.costdocno like '%"+prjdocnos+"%'  ";
      	}
       
      	
      	
      	
      	if(!(sqlStartDate==null)){
      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
      	}
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		if(aa.equalsIgnoreCase("yes"))
		{	
		
			Statement stmtmain = conn.createStatement ();
			
			

			
/*        	String pySql=("select m.doc_no,m.voc_no,m.date,t.type,m.description desc1 from my_gism m left join my_issuetype t on t.doc_no=m.issuetype "
        			+ " where m.status=3   and m.brhid='"+brcid+"' "+sqltest );
        	
        	*/
        	String pySql=" select * from ( select u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
        			+ "m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
        			+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
        			+ " from my_gism m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
        			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
        			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
        			+ " where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"  ) a where 1=1 "+sqlsss2+" "; ;
        	
        	//System.out.println("=======pySql======="+pySql);
        	
     
			ResultSet resultSet = stmtmain.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmtmain.close();
			
		}
		conn.close();
		  return RESULTDATA;
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}



public   ClsGoodsissuenoteBean   getViewDetails(int masterdoc_no) throws SQLException {
	
	ClsGoodsissuenoteBean showBean = new ClsGoodsissuenoteBean();
	Connection conn=null;
	try { conn = ClsConnection.getMyConnection();
	Statement stmt  = conn.createStatement ();
/*	
	String sqls="select m.refinvDate, m.refInvNo,m.rdtype,if(m.rdtype='PO',m.rrefno,'') rrefno,m.doc_no,m.voc_no,m.refno,m.date,h.description descs, "
			+ "	h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper,  "
			+ "	 m.discount,m.roundVal,m.netAmount,m.supplExp,m.nettotal,m.prddiscount,m.delterms,m.payterms,m.description,m.deldate,l.loc_name,m.locid "
			+ "		from my_grnm m left join my_head h on h.doc_no=m.acno  left join my_locm l on l.doc_no=m.locid where  m.doc_no='"+masterdoc_no+"'";
	*/

	String sqls=" select m.costdocno costtr_no,m.description,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			+ " case when m.costtype=6 then m.costdocno  when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
 	+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
	+ " case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
	+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
	+ " from my_gism m left join my_locm l on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
    + " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
	+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
	+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
	+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
	+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
	+ " where m.status=3 and  m.doc_no='"+masterdoc_no+"'";

	
	//System.out.println("======sqls====="+sqls);
	
	
	ResultSet resultSet = stmt.executeQuery(sqls);    
 
	while (resultSet.next()) {
	
		showBean.setDocno(resultSet.getInt("voc_no"));
			
		showBean.setMasterdate(resultSet.getString("date"));
	 
		showBean.setPurdesc(resultSet.getString("description"));
		 
	 
		showBean.setTxtlocation(resultSet.getString("loc_name"));
		
		showBean.setTxtlocationid(resultSet.getInt("locid"));
	 
 	
		showBean.setRefno(resultSet.getString("refno"));
		 
			 
		showBean.setType(resultSet.getInt("issuetype"));
		showBean.setItemtype(resultSet.getInt("costtype"));
	 	
		showBean.setItemname(resultSet.getString("prjname"));
	 	
		showBean.setItemdocno(resultSet.getInt("costdocno"));
	    
		   
		showBean.setCldocno(resultSet.getInt("cldocno"));
	    
		showBean.setClientname(resultSet.getString("refname"));
	    
		showBean.setSite(resultSet.getString("site"));
		    
		showBean.setSiteid(resultSet.getInt("siteid"));
	    
	    
		showBean.setCosttr_no(resultSet.getInt("costtr_no"));
		 

		
		
	
	}
	 
 
	
	stmt.close();
	conn.close();
	}
	catch(Exception e){
		
	e.printStackTrace();
	conn.close();
	}
	return showBean;
}






public int update(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno,int docno, String updatadata) throws SQLException {
 
	
	
	
	
	try{
		 
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtgin= conn.prepareCall("{call tr_goodsissuenoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
 
		stmtgin.setInt(15,docno);
		stmtgin.setInt(16,0);

		stmtgin.setDate(1,masterdate);
		stmtgin.setString(2,refno);
		stmtgin.setString(3,purdesc);
		stmtgin.setDouble(4,productTotal);
	  	 
		stmtgin.setString(5,session.getAttribute("USERID").toString());
		stmtgin.setString(6,session.getAttribute("BRANCHID").toString());
		stmtgin.setString(7,session.getAttribute("COMPANYID").toString());
		
		
	//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
		stmtgin.setString(8,formdetailcode);
		stmtgin.setString(9,mode);
 
		
		stmtgin.setInt(10,txtlocationid);
		
 
		stmtgin.setInt(11,siteid);
		stmtgin.setInt(12,type);
		stmtgin.setInt(13,itemtype);
		stmtgin.setInt(14,itemdocno);
		stmtgin.setInt(17,cldocno);
		
		
		stmtgin.executeQuery();
		docno=stmtgin.getInt("docNo");
 
		int vocno=stmtgin.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		System.out.println("====docno========"+docno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
		
		if(updatadata.equalsIgnoreCase("Editvalue"))
		{	
				
			
			
			System.out.println("-----updatadata----"+updatadata);
			
					 Statement stmt1=conn.createStatement();
					 
					 Statement stmt=conn.createStatement();
							 
					int mastertr_no=0;
					String sqlss="select tr_no,voc_no from my_gism where doc_no='"+docno+"' ";
					ResultSet selrs=stmt1.executeQuery(sqlss);
					
					if(selrs.next())
					{
						mastertr_no=selrs.getInt("tr_no");
						vocno=selrs.getInt("voc_no");
					}
					
					
					
					String sqlss11="select doc_no from cm_srvcontrm where tr_no="+itemdocno+" ";
					ResultSet selrs1=stmt1.executeQuery(sqlss11);
					
					if(selrs1.next())
					{
						itemdocno=selrs1.getInt("doc_no");
						
					}
				 
					
					
					
					
					
					int prodet=0;
					int prodout=0;
						for(int i=0;i< masterarray.size();i++){
			
							String[] prod=((String) masterarray.get(i)).split("::");
							System.out.println("prod[0]===="+prod[0]);
							if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){
								
								
								
								
								
								
								if(i==0)
								{
									 			
									
									 
						        int counts=0;							
						        String tempstk="0";	
						        
						        int stkids=0;
						        
						        String tempstkids="0";
						      
								double chkqtys=0;	
								double prdqty=0;
				
								double saveqty=0;
								int tmptrno=0;
								
								int prdidss=0;
								

								int outdocno=0;


								int stk=0;
				
								//String sql9="select count(*) tmpcount from my_gisd where rdocno='"+docno+"'"	;			
								String sql9="select count(*) tmpcount from my_prddout where rdocno='"+docno+"'  and dtype='"+formdetailcode+"' and tr_no="+mastertr_no+" "	;				

						 
						 	System.out.println("-----sql9-----"+sql9);
								
								ResultSet rsstk11 = stmt.executeQuery(sql9);
				
								
								if(rsstk11.next())
								{
									counts=rsstk11.getInt("tmpcount");
								}
								
								Statement st=conn.createStatement();
							     for(int m=0;m<=counts;m++)
							     {
							    	 String sql2="select stockid,qty,doc_no,prdid,tr_no from my_prddout where rdocno='"+docno+"' and tr_no="+mastertr_no+" and dtype='"+formdetailcode+"' and doc_no not in("+tempstk+") group by doc_no limit 1";
							    	//String sql2="select stockid,qty,prdid,tr_no from my_gisd where rdocno='"+docno+"' and stockid not in("+tempstk+") group by stockid limit 1";
							    	System.out.println("-----sql2-----"+sql2);
							    	ResultSet rsstk111 = stmt.executeQuery(sql2);
							    	
							    	
							    	if(rsstk111.next())
							    	{
							    		/*chkqtys=rsstk111.getDouble("qty");
							    		stkids=rsstk111.getInt("stockid");
							    		prdidss=rsstk111.getInt("prdid");
							    		tmptrno=rsstk111.getInt("tr_no");*/
							    		
							    		chkqtys=rsstk111.getDouble("qty");
							    		stk=rsstk111.getInt("stockid");
							    		stkids=rsstk111.getInt("doc_no");
							    		prdidss=rsstk111.getInt("prdid");
							    		tmptrno=rsstk111.getInt("tr_no");
							    		outdocno=rsstk111.getInt("doc_no");
							    	
							     		String sql3=" select out_qty   prdqty  from my_prddin where stockid='"+stk+"'";
								    	 System.out.println("-----sql3-----"+sql3);
							    		ResultSet rsstk1111 = stmt.executeQuery(sql3);
							    	
							    	
							    	if(rsstk1111.next())
							    	{
							    		prdqty=rsstk1111.getDouble("prdqty");
								    	saveqty=prdqty-chkqtys;
								    	
								    	if(saveqty<0){
								    	saveqty=0;
								    	
								    	}
								    	
								      	String sql31="update my_prddin set out_qty="+saveqty+" where stockid='"+stk+"'";
								    	 System.out.println("-----sql31-----"+sql31);
								    	 stmt.executeUpdate(sql31);
								    	 
								    	 /*	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+"  ";
									    //	System.out.println("-----sql34-----"+sql34);
									    	 stmt.executeUpdate(sql34);*/
								    	 
								    	 String sql34="delete from my_prddout  where   stockid='"+stk+"' and prdid='"+prdidss+"' and tr_no="+mastertr_no+" and doc_no='"+outdocno+"' and dtype='"+formdetailcode+"'  ";
							    	 	 
										     	System.out.println("-----sql34-----"+sql34);
										    	 stmt.executeUpdate(sql34);
									    	 
								    	 
								    	 if(m==0)
								    	 {
								    		 tempstk=String.valueOf(stkids);	 
								    	 }
								    	 else
								    	 {
								    	 tempstkids=tempstk+","+stkids+",";
								    	 tempstk=tempstkids;
								    	 }
								    	 System.out.println("-----tempstkids-----"+tempstkids);
								    	 //System.out.println("========"+m+"-----tempstk-----"+tempstk);
								    	  
								    	
								    	 
								    	 if(tempstk.endsWith(","))
											{
								    		 tempstk = tempstk.substring(0,tempstk.length() - 1);
											}
							    		
							    		
							    	}
/*							    	String sql3=" select out_qty   prdqty  from my_prddin where stockid='"+stkids+"'";
							    	 System.out.println("-----sql3-----"+sql3);
							    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
							    	
							    	
							    	if(rsstk1111.next())
							    	{
							    		prdqty=rsstk1111.getDouble("prdqty");
								    	saveqty=prdqty-chkqtys;
								    	
								    	if(saveqty<0){
								    	saveqty=0;
								    	
								    	}
								    	
								      	String sql31="update my_prddin set out_qty="+saveqty+" where stockid='"+stkids+"'";
								    	 System.out.println("-----sql31-----"+sql31);
								    	 stmt.executeUpdate(sql31);
								    	 
								    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+"  ";
									    //	System.out.println("-----sql34-----"+sql34);
									    	 stmt.executeUpdate(sql34);
								    	 
								    	 if(m==0)
								    	 {
								    		 tempstk=String.valueOf(stkids);	 
								    	 }
								    	 else
								    	 {
								    	 tempstkids=tempstk+","+stkids+",";
								    	 tempstk=tempstkids;
								    	 }
								    	 System.out.println("-----tempstkids-----"+tempstkids);
								    	 //System.out.println("========"+m+"-----tempstk-----"+tempstk);
								    	  
								    	
								    	 
								    	 if(tempstk.endsWith(","))
											{
								    		 tempstk = tempstk.substring(0,tempstk.length() - 1);
											}
							    		
							    		
							    	}
							    	*/
							    	
							    	}

			    	 
			     }
		 


  
									
	 		
									
		    	 
		    	      String dql31="delete from my_gisd where rdocno='"+docno+"'";
		    	      
		    	      System.out.println("-------dql31-----"+dql31);
		    	      
		    	 	  stmt.executeUpdate(dql31);
		    	 	 
		   	 	 
		    	  
		    	 	 String dql34= "delete from my_jvtran where tr_no='"+mastertr_no+"'  ";
		    	 	 
		    	 
		    	 	 stmt.executeUpdate(dql34);
		    			
								
								
								
								
							}
							
								
								
								
			
						String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						String specno=""+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"";
											 
						String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
						double masterqty=Double.parseDouble(rqty);
						double masterqty1=Double.parseDouble(rqty);
						
						 String unitidss=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
						    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						     
					    	 
					         
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
						     
						     System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
						     
						     
								String sql="insert into my_gisd(TR_NO, SR_NO,rdocno,stockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid,fr)VALUES"
										+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
										+ "'0',"
										+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+masterqty+"',"
										+ "'0',"
										+ "'0',"
							 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
										+ "0,"+fr+")";

								System.out.println("asdassssssssssssssssssssss"+sql);
								
								 stmt.executeUpdate(sql);
			 
						double balstkqty=0;
						double balstkqty1=0;
						int psrno=0;
						int stockid=0;
						double remstkqty=0;
						double outstkqty=0;
						double stkqty=0;
						double qty=0;
						double detqty=0;
						double unitprice=0.0;
						double tmp_qty=0.0;
						double outqtys=0.0;
						double refqty=0.0;
						String qty_fld="";
						String qryapnd="";
						String slquery="";
						masterqty=masterqty*fr;
						
						String loc="";
						
						
						double cost_price=0;
						 
						
						int locids=0;
						
						 
							qty_fld="out_qty";
								 
							slquery="(out_qty+rsv_qty+del_qty)";
							  
							loc="and locid="+txtlocationid+" ";
								
						 

							
							System.out.println("GIN");


					Statement stmtstk=conn.createStatement();
		
					String stkSql="select cost_price,locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
							+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "+loc+" and date<='"+masterdate+"' "
							+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-"+slquery+"))>0 order by date,stockid";
		
					System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);
		
					ResultSet rsstk = stmtstk.executeQuery(stkSql);
		
					while(rsstk.next()) {
		
						balstkqty1=rsstk.getDouble("balstkqty");
						balstkqty=rsstk.getDouble("balstkqty");
						psrno=rsstk.getInt("psrno");
						outstkqty=rsstk.getDouble("out_qty");
						stockid=rsstk.getInt("stockid");
						stkqty=rsstk.getDouble("stkqty");
						qty=rsstk.getDouble("qty");
						outqtys=rsstk.getDouble("qtys");
						locids=rsstk.getInt("locid");
						 
						cost_price=rsstk.getDouble("cost_price");
						
						refqty=masterqty;
						System.out.println("---masterqty-----"+masterqty);	
						System.out.println("---balstkqty-----"+balstkqty);	
						System.out.println("---out_qty-----"+outstkqty);	
						System.out.println("---stkqty-----"+stkqty);
						System.out.println("---qty-----"+qty);
						
						System.out.println("---cost_price-----"+cost_price);
						
		
						String queryappnd="";
						
						/*if((rreftype.equalsIgnoreCase("SOR"))||(rreftype.equalsIgnoreCase("DEL"))){
							queryappnd=","+qty_fld+"="+tmp_qty+"";
						}*/
		
						if(remstkqty>0)
						{
		
							masterqty=remstkqty;
						}
		
						 
						if(masterqty<=balstkqty)
						{
							detqty=masterqty;
		
			 
					        queryappnd=","+qty_fld+"="+tmp_qty+"";	
							  
								
							 
							
							
							System.out.println("-----queryappnd-----"+queryappnd);
							
		
							masterqty=masterqty+outqtys;
		
							
							
							String sqls="update my_prddin set out_qty="+masterqty+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"   ";
							System.out.println("--1---sqls---"+sqls);
							stmt.executeUpdate(sqls);
							masterqty=detqty;
		
		
						}
						else if(masterqty>balstkqty)
						{
		
		
		
							if(stkqty>=(masterqty+outstkqty))
		
							{
								balstkqty=masterqty+outqtys;	
								remstkqty=stkqty-outstkqty;
		
								System.out.println("---balstkqty-1---"+balstkqty);
							}
							else
							{
								remstkqty=masterqty-balstkqty;
								balstkqty=stkqty-outstkqty+outqtys;
		
								System.out.println("---masterqty-2---"+masterqty);
								System.out.println("---outstkqty-2---"+outstkqty);
								System.out.println("---stkqty-2---"+stkqty);
								System.out.println("---remstkqty-2---"+remstkqty);
								System.out.println("---balstkqty--2--"+balstkqty);
							}
							detqty=stkqty-outstkqty;
		 
							
							String sqls="update my_prddin set out_qty="+balstkqty+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
							System.out.println("-2----sqls---"+sqls);
		
							stmt.executeUpdate(sqls);	
		
							//remstkqty=masterqty-stkqty;
		
		
		
						}

						
						System.out.println("masterqty--------------------------->>>>"+masterqty);
						
						System.out.println("balstkqty1---------------------------------->>>>"+balstkqty1);

			          /*  double totalcostprice=cost_price*detqty;
							String sql="insert into my_gisd(TR_NO, SR_NO,rdocno,stockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid)VALUES"
									+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
									+ "'"+stockid+"',"
									+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
									+ "'"+detqty+"',"
									+ ""+cost_price+","
									+ ""+totalcostprice+","
						 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
									+ "'"+locids+"')";
			
							 stmt.executeUpdate(sql);
								*/
						String cost_prices="0";

						Statement stmtstk1=conn.createStatement();

						String stkSql1="select  cost_price  from my_prddin where stockid='"+stockid+"'";

						System.out.println("=stkSql1 select cost_price insert="+stkSql1);

						ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);

						if(rsstk1.next()) {
							cost_prices=rsstk1.getString("cost_price");
						}
						
						
							
						String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,cost_price) Values"
										+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"+docno+","
										+ "'"+stockid+"',"
										+ "'"+masterdate+"',"
										+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+detqty+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"',"+cost_prices+")";
			
							  
 							System.out.println("prodoutsql--asdasdasdas->>>>Sql"+prodoutsql);
							prodout = stmt.executeUpdate (prodoutsql);
							
				
			
					 	if(masterqty<=balstkqty1)
							{
								break;
							} 
			
			
						}
							}
							}
			
							String vendorcur="1"; 
							double venrate=1;
							
					 int accounts=0;
					 
					 
					 double  finalamt=0;
						String refdetails="GIS"+""+vocno;
						
						int trno=mastertr_no;
					 
				/*		String sql30="select tr_no,sum(totalcost_price) totalcost_price from my_gisd where rdocno='"+docno+"' ";
						System.out.println("-----4--sql2----"+sql30) ;
				
							ResultSet tass30 = stmt.executeQuery (sql30);
				
							if (tass30.next()) {
				
								finalamt=tass30.getDouble("totalcost_price");		
								trno=tass30.getInt("tr_no");
							}
						 */
					 
						String sql30="select tr_no,sum(totalcost_price) totalcost_price from ( select tr_no,cost_price*qty totalcost_price from my_prddout where tr_no="+trno+") a group by tr_no ";
						
						
						System.out.println("-----4--sql2----"+sql30) ;

							ResultSet tass30 = stmt.executeQuery (sql30);

							if (tass30.next()) {

								finalamt=tass30.getDouble("totalcost_price");		
								trno=tass30.getInt("tr_no");
							}
						 
					 
								
							String sql29="select acno from my_issuetype where doc_no='"+type+"' ";
						System.out.println("-----4--sql2----"+sql29) ;
				
							ResultSet tass19 = stmt.executeQuery (sql29);
				
							if (tass19.next()) {
				
								accounts=tass19.getInt("acno");		
				
							}
						 
							
				
							String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet tass11 = stmt.executeQuery (sqls10);
							if(tass11.next()) {
				
								vendorcur=tass11.getString("curid");	
				
				
							}
				
				
							String currencytype="";
							String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
							 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
							ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);
				
							while (resultSet33.next()) {
								venrate=resultSet33.getDouble("rate");
								currencytype=resultSet33.getString("type");
							}
				
							double	dramount=finalamt; 
				
				
							double ldramount=0;
							if(currencytype.equalsIgnoreCase("D"))
							{
				
				
								ldramount=dramount/venrate ;  
							}
				
							else
							{
								ldramount=dramount*venrate ;  
							}
							String sql1="";
						/*	if(itemtype==1 || itemtype==6)
							{*/
				
								  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";
				    /*     	
							}
							else
							{
								  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"',0,0,'GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
				         	
							}
								*/
							
							
							//	System.out.println("--sql1----"+sql1);
							int ss = stmt.executeUpdate(sql1);
				
							if(ss<=0)
							{
								conn.close();
								return 0;
				
							}
							
							int acnos=0;
							String curris="1";
							double rates=1;
				
				
				
							String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
							//System.out.println("-----4--sql2----"+sql2) ;
				
							ResultSet tass1 = stmt.executeQuery (sql2);
				
							if (tass1.next()) {
				
								acnos=tass1.getInt("acno");		
				
							}
				
				
				
							String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
							//System.out.println("-----5--sqls3----"+sqls3) ;
							ResultSet tass3 = stmt.executeQuery (sqls3);
				
							if (tass3.next()) {
				
								curris=tass3.getString("curid");	
				
				
							}
							String currencytype1="";
							
							
							String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
							//System.out.println("-----6--sqlveh----"+sqlveh) ;
							ResultSet resultSet44 = stmt.executeQuery(sqlveh);
				
							while (resultSet44.next()) {
								rates=resultSet44.getDouble("rate");
								currencytype1=resultSet44.getString("type");
							} 
				
							double pricetottal=finalamt*-1;
							double ldramounts=0 ;     
							if(currencytype1.equalsIgnoreCase("D"))
							{
				
								ldramounts=pricetottal/venrate ;  
							}
				
							else
							{
								ldramounts=pricetottal*venrate ;  
							}
							String sql11="";
						/*	if(itemtype==1 || itemtype==6)
							{*/
				
							  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"','GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3,"+itemtype+","+itemdocno+")";
				
					/*		}
							else
							{

								  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"',0,0,'GIS','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
					
							}*/
							// System.out.println("---sql11----"+sql11) ; 
				
							int ss1 = stmt.executeUpdate(sql11);
				
							if(ss1<=0)
							{
								conn.close();
								return 0;
				
							}
						//	System.out.println("88888888888888888------itemtype---"+itemtype);
						if(itemtype>0)
						{
			
							 int TRANIDs=0;
							 int sno=1;
							  
						Statement sss=conn.createStatement();
								String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+mastertr_no+" and acno="+accounts+" ";
								System.out.println("---trsqlss--"+trsqlss);
								ResultSet tass111 = sss.executeQuery (trsqlss);
								
								if (tass111.next()) {
							
									TRANIDs=tass111.getInt("TRANID");	
								
								
									
							     }
								
								System.out.println("---TRANIDs--"+TRANIDs);
								String sqlssss="delete from my_costtran where tr_no='"+mastertr_no+"'";
								System.out.println("---sqlssss--"+sqlssss);
								 stmtgin.executeUpdate(sqlssss);
								String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
										+ " "+itemtype+","+finalamt+","+itemdocno+","+TRANIDs+","+mastertr_no+")";
										 
						  int costabsq=  stmtgin.executeUpdate(ssql);
						  
						  if(costabsq<=0)
							{
								conn.close();
								return 0;
								
							}
						}
						  String dql34= "delete from my_jvtran where    tr_no='"+trno+"' and dramount=0  ";
				    	  stmt.executeUpdate(dql34); 
	
		}
		if(docno>0)
		{
			 conn.commit();
			stmtgin.close();
			conn.close();
			return docno;
			
		}
 
		
			}
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	conn.close();
	return 0;
}




public     ClsGoodsissuenoteBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	  ClsGoodsissuenoteBean bean = new ClsGoodsissuenoteBean();
	  Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			 Statement stmt10 = conn.createStatement ();
			 Statement stmtprint=conn.createStatement();
			    String  ginsql=" select a.refname,m.doc_no,A.CLDOCNO,a.contactperson,a.per_mob,if(m.costtype=6, "
			    		+ "concat(mm.fleet_no,'-',mm.flname),'') flname, "
			    		+ "m.costdocno costtr_no,m.description as desc1,m.refno,m.doc_no,m.voc_no,DATE_FORMAT(m.date,'%d/%m/%Y') as date,m.issuetype,m.locid, "
			    		+ " l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			    		+ " case when m.costtype=6 then concat(cu.costgroup,'-',m.costdocno) "
			    		+ " when m.costtype=1 then concat(cu.costgroup,'-',m.costdocno) when m.costtype in(3,4) "
			    		+ "then concat(cu.costgroup,'-',co.doc_no)	when m.costtype in(5) then concat(cu.costgroup,'-',cs.doc_no) "
			    		+ "end as 'costdocno' ,  case when m.costtype=6 then mm.flname "
			    		+ "	when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno), "
			    		+ "	char(100))   when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  "
			    		+ " end as 'prjname'  from my_gism m left join my_locm l on l.doc_no=m.locid "
			    		+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1"
			    		+ " 	left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
			    		+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno"
			    		+ "	 and m.costtype=5  left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6  "
			    		+ "left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5)  "
			    		+ "left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5)"
			    		+ " and a.dtype='CRM'  left join my_costunit cu on cu.costtype= m.costtype  where m.status=3 and  m.doc_no="+docno+";";
System.out.println("ginsql==="+ginsql);

		         ResultSet resultsetcompany = stmt10.executeQuery(ginsql); 
			       
			       while(resultsetcompany.next()){
			    	   
			    	   bean.setRefname(resultsetcompany.getString("refname"));
			    	   bean.setCostdoc(resultsetcompany.getString("costdocno"));

			    	   
			    	   bean.setContperson(resultsetcompany.getString("contactperson"));
			    	   bean.setMob(resultsetcompany.getString("per_mob"));

			    	   bean.setDesc(resultsetcompany.getString("desc1"));
			    	   bean.setDate(resultsetcompany.getString("date"));
			    	   bean.setLoc_name(resultsetcompany.getString("loc_name"));
			    	   bean.setFlname(resultsetcompany.getString("flname"));


			       } 
			       
			       
			       String resql=" select cost.costgroup,iss.type issuetypes,m.costdocno costtr_no,m.description,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid, "
				   			+ " l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
				   			+ " case when m.costtype=6 then m.costdocno  when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
				   		 	+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
				   			+ " case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
				   			+ " when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
				   			+ " from my_gism m left join my_locm l on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
				   		    + " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
				   			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
				   			+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
				   			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5)  left join my_costunit cost on cost.costtype=m.costtype "
				   			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM'  left join my_issuetype iss on iss.doc_no=m.issuetype "
				   			+ " where m.status=3 and  m.doc_no='"+docno+"'";

				   			
				   			//System.out.println("=========resql======="+resql);
				   			
				   			ResultSet pintrs = stmtprint.executeQuery(resql);
				   			
				   	 
				   		       while(pintrs.next()){
				   		    	
				   		    	    bean.setLbldocno(pintrs.getString("voc_no"));
				   		    	    bean.setLbldate(pintrs.getString("date"));
				   		    	    bean.setLblrefno(pintrs.getString("refno"));
				   		    	    bean.setLbldesc1(pintrs.getString("description"));
				   		    	    bean.setLbllocation1(pintrs.getString("loc_name"));
				   		    	    
				   		    	 
				   		    	    bean.setLbltype(pintrs.getString("issuetypes"));
				    
				   		    	    bean.setLblprjname(pintrs.getString("costgroup")+" - "+pintrs.getString("costdocno")+" - "+pintrs.getString("prjname"));
				   		    	    bean.setLblclname(pintrs.getString("refname"));
				   		    	    bean.setLblsite(pintrs.getString("site"));
				   		    	     
				    
				   		    	    
				   		    	  
				   		       }
				   			

				   			stmtprint.close();
				   			
				   			
				   			
				   			 Statement companystmt10 = conn.createStatement ();
				   			    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_gism r  "
				   			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				   			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


				   		         ResultSet resultsetcompanyst10 = companystmt10.executeQuery(companysql); 
				   			       
				   			       while(resultsetcompanyst10.next()){
				   			    	   
				   			    	   bean.setLblbranch(resultsetcompanyst10.getString("branchname"));
				   			    	   bean.setLblcompname(resultsetcompanyst10.getString("company"));
				   			    	  
				   			    	   bean.setLblcompaddress(resultsetcompanyst10.getString("address"));
				   			    	   bean.setLblcomptel(resultsetcompanyst10.getString("tel"));
				   			    	  
				   			    	   bean.setLblcompfax(resultsetcompanyst10.getString("fax"));
				   			    	   bean.setLbllocation(resultsetcompanyst10.getString("location"));
				   			    	  
				   			    	   
				   			    	   
				   			       } 
				   			     stmt10.close();
				   			       
				   			    
				   						
				   			     ArrayList<String> arr =new ArrayList<String>();
				   			   	 Statement stmtgrid = conn.createStatement();       
				   			     String temp="";  
				    
				   			       String	strSqldetail="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, round(qty,2) qty,qty as oldqty,outqty,"
				   							+ " qutval,0 size,part_no,productid as proid,productid,"
				   							+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
				   							+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys+qty as qutval, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
				   							+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select bd.brandname,i.stockid as stkid,"
				   							+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,ii.inblqty as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
				   							+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
				   							+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno)"
				   							+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				   							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
				   							+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and i.locid=d.locid)  "
				   							+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
				   							+ "	   from my_prddin where 1=1 group by psrno,locid) ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=i.locid) "
				   							+ " where m.status=3 and d.rdocno in("+docno+") group by i.prdid"
				   							+ "  order by  i.prdid,i.date ) as a ) as b ; ";
				   					
                                          System.out.println("====strSqldetail======="+strSqldetail);
				   			       
				   			       
				   				ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
				   				
				   				int rowcount=1;
				   		
				   				while(rsdetail.next()){
				   					 
				   						 
				   						temp=rowcount+"::"+rsdetail.getString("part_no")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("brandname")+"::"+
				   						rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;
				   						arr.add(temp);
				   						rowcount++;
				   		
				   						 
				   			          }
				   			             
				   				request.setAttribute("details", arr);
				   				stmtgrid.close();
				   				
				   				
				   				
				       
				       
			       
			       
			       conn.close();



					
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}
public   JSONArray searchunit(String mode,String psrno,HttpSession session,String oldqty,String unitdocno,String locationid,String date) throws SQLException {
	 
	JSONArray RESULTDATA=new JSONArray();
    
    
    Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			 String brchid=session.getAttribute("BRANCHID").toString(); 
			 java.sql.Date sqlStartDate=null;


				if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
				{
					sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
				}
			 if(mode.equalsIgnoreCase("E"))
			 {
				 Statement stmt = conn.createStatement ();
			     double fr=1;
			     String slss=" select fr from my_unit where psrno="+psrno+" and unit='"+unitdocno+"' ";
			     
			     System.out.println("====slss==="+slss);
			     ResultSet rv1=stmt.executeQuery(slss);
			     if(rv1.next())
			     {
			    	 fr=rv1.getDouble("fr"); 
			     }
	    	 
			double oldqtys=Double.parseDouble(oldqty);
				 
			oldqtys=oldqtys*fr;
				 
			 String pySql=("  select u.unit doc_no,u.fr,m.unit,u.psrno,(balqty+"+oldqtys+")/u.fr balqty,(outqty+"+oldqtys+")/u.fr outqty,(totqty+"+oldqtys+")/u.fr totqty,"+oldqtys+"/u.fr oldqty from my_unit u "
			+" left join my_unitm m on m.doc_no=u.unit and  psrno='"+psrno+"' "
			+"  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty)  balqty, sum(out_qty) outqty,sum(op_qty) as totqty,psrno "
			+ " from my_prddin where psrno='"+psrno+"' "
			 +"  and brhid="+brchid+" and locid="+locationid+" and date<='"+sqlStartDate+"' group by psrno) i on i.psrno=u.psrno where u.psrno='"+psrno+"'  "); 

	         //	System.out.println("=====pySql====E===="+pySql);
	        	
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			 }
			 else
			 {
				 
				 String pySql=("  select u.unit doc_no,u.fr,m.unit,u.psrno,balqty/u.fr balqty,outqty/u.fr outqty,totqty/u.fr totqty from my_unit u "
							+" left join my_unitm m on m.doc_no=u.unit and  psrno='"+psrno+"' "
							+"  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty)  balqty, sum(out_qty) outqty,sum(op_qty) as totqty,psrno "
							+ " from my_prddin where psrno='"+psrno+"' "
							 +"  and brhid="+brchid+" and locid="+locationid+" and date<='"+sqlStartDate+"'  group by psrno) i on i.psrno=u.psrno where u.psrno='"+psrno+"'  "); 

		     //   System.out.println("=====pySql===A====="+pySql);
		        	
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
			 }
			
		    	 
			

			
			
			 
			stmtVeh1.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}	


}
