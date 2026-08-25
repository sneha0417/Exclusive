package com.sales.marketing.salesorder;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.marketing.salesquotation.ClsSalesQuotationBean;

public class ClsSalesOrderDAO {
	ClsSalesOrderBean bean= new ClsSalesOrderBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchunit(String mode,String psrno,HttpSession session,String oldqty,String unitdocno,String date) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				 String brchid=session.getAttribute("BRANCHID").toString(); 

java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
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
				 +"  and brhid="+brchid+"  and  date<='"+sqlStartDate+"'  group by psrno) i on i.psrno=u.psrno where u.psrno='"+psrno+"'  "); 

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
								 +"  and brhid="+brchid+" and  date<='"+sqlStartDate+"'  group by psrno) i on i.psrno=u.psrno where u.psrno='"+psrno+"'  "); 

			        //	System.out.println("=====pySql===A====="+pySql);
			        	
						ResultSet resultSet = stmtVeh1.executeQuery(pySql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
				 }
				
			    	 
				
				
/*	        	String pySql=("   select u.unit doc_no,u.fr,m.unit from my_unit u left join my_unitm m on m.doc_no=u.unit where psrno='"+psrno+"';   ");*/
 
; 
				
				
				 
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
	
	public   JSONArray hidesearchProduct(HttpSession session,String prodsearchtype,String rdoc,String cmbprice,String clientid,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			Statement stmt1 = conn.createStatement (); 
			String sql="";
			int method=0;
			int method1=0;
	 
			int pricemgt=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/
			String catid=clientcaid;
			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}

			
			  String brchid=session.getAttribute("BRANCHID").toString();
			  
			  
			  java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
		     	}

				
 
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				 
				System.out.println("=================prodsearchtype==================="+prodsearchtype);
	 
			if(prodsearchtype.equals("0")){ // o main only else prddin
				
				String chk1="select method  from gl_prdconfig where field_nme='edit'";
				ResultSet rs1=stmt1.executeQuery(chk1); 
				if(rs1.next())
				{

					method1=rs1.getInt("method");
				}
		/*		String chk2="select catid from my_acbook where dtype='CRM' and cldocno='"+clientid+"'";
				ResultSet rs2=stmt1.executeQuery(chk2); 
				if(rs2.next())
				{

					catid=rs2.getInt("catid");
				}
			 */
				 
				String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
				ResultSet rs3=stmt1.executeQuery(chk3); 
				if(rs3.next())
				{

					pricemgt=rs3.getInt("method");
				}
			 
				
			 
				if(method>0){ // eidtprice price mgt edit unit price

					if(pricemgt>0)
	                {
	                	
					sql="select "+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
							+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
							+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
							+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
							+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
						 	+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  and pr.discount1 is not null  "
							+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date   ";
                        
			 //	System.out.println("-1111111111---1-- sk ck-"+sql);
	                }
					else
					{
						sql="select "+fsql+"  bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
								+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
								+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
								+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
							 	+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'    "
								+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";
	                        
				 //	System.out.println("-1111111111---1-- sk ck-"+sql);
					}
					
				}
				else{

				 
					if(pricemgt>0)
	                {
						sql="select  "+fsql+"  case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,0 method,'"+method1+"' eidtprice, "
	                			+ " at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
							    + "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							    + "left join my_desc de on(de.psrno=m.doc_no)   "
							    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
									+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' and pr.discount1 is not null group by m.doc_no ";
					  System.out.println("--aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa--3- not chk stk--");
	                }
					else
					{
						sql="select  "+fsql+" bd.brandname,0 method,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
								+ "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "left join my_desc de on(de.psrno=m.doc_no)   "
							    + " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";
						//  System.out.println("----3- not chk stk--");
						
					}
				}

			
			
			}
			else{

				if(method>0){

					
		 			
					
					
					sql="select  "+outfsql+"   brandname,1 method, stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
							+ "( select "+fsql+"  bd.brandname,i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(i.op_qty) as qty,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
							+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  "
							+ "  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid)  "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a ";

					
				 	//System.out.println("1");
					

				}
				else{


					
 
					
					sql="select   "+outfsql+"   brandname,0 method, stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno,unitprice,total, "
							+ " discper,dis,netotal from "
							+ "( select  "+fsql+"  bd.brandname,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,"
							+ " d.amount unitprice,sum(d.qty-d.out_qty)*d.amount total,d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100)  netotal  from "
							+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
							+ " my_unitm u on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+joinsql+"   where  d.clstatus=0 and m.status=3 and d.rdocno in("+rdoc+") "
							 + "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ) as a ";
 
					
					// System.out.println("2="+sql);
				}

 
			}
//
 
			System.out.println("=================sfdsdfsdfffffffffffffffffffffffffffff==================="+sql);
			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public  JSONArray searchqty(HttpSession session,String reftype,String psrno,String locid,String load,String mode,String values) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		 if(!(load.equalsIgnoreCase("yes")))
		 {
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
		String brcid = session.getAttribute("BRANCHID").toString(); 

		String sqltest="";

 
		Connection conn = null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement (); 
			
 
			String pySql="";
			System.out.println("===mode====="+mode);
			System.out.println("===values====="+values);  
			
			if(mode.equalsIgnoreCase("E"))
					{
	/*			pySql=" select 'true' chk,  coalesce(i.qty,0)) qty ,coalesce(i.foc,0))  foc "
						+ "(pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty)+(coalesce(i.qty,0)+coalesce(i.foc,0)) stkqty, "
						+ "pin.stockid,pin.cost_price,pin.batch_no,pin.exp_date  from my_prddin pin "
				+ "left join my_sorderddet  i on i.stockid=pin.stockid and  i.orddono="+values+"  "
				+ "where i.psrno='"+psrno+"' and pin.brhid='"+brcid+"'    and  i.orddono="+values+" and "
				+ "(pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty)+coalesce(i.qty,0)+coalesce(i.foc,0))>0    group by pin.stockid "
				+ " union all "
				+ " select 'false' chk,'' qty ,'' foc , op_qty-(out_qty+rsv_qty+del_qty) stkqty,stockid,cost_price,batch_no,exp_date "
				 + " from my_prddin where psrno='"+psrno+"' and brhid='"+brcid+"'   and op_qty-(out_qty+rsv_qty+del_qty)>0 "
				 		+ " and stockid not in ( "
				 		+ " select pin.stockid  from my_prddin pin "
				+ "left join my_sorderddet  i on i.stockid=pin.stockid and  i.orddono="+values+"  "
				+ "where i.psrno='"+psrno+"' and pin.brhid='"+brcid+"'    and  i.orddono="+values+" and "
				+ "(pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty)+coalesce(i.qty,0)+coalesce(i.foc,0))>0    group by pin.stockid ) ";
				 
				*/
				pySql=" select 'true' chk,  convert(coalesce(i.qty,0),char(100)) qty ,convert(coalesce(i.foc,0),char(100))  foc ,(pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty))+ "
						+ "(coalesce(i.qty,0)+coalesce(i.foc,0))  stkqty, pin.stockid,pin.cost_price,pin.batch_no,pin.exp_date  from my_prddin pin "
						+ " left join my_sorderddet  i on i.stockid=pin.stockid and  i.rdocno="+values+"   where i.psrno='"+psrno+"' and pin.brhid='"+brcid+"'  "
						+ " and  i.rdocno="+values+"   group by pin.stockid union all "
				       + " select 'false' chk,'' qty ,'' foc , op_qty-(out_qty+rsv_qty+del_qty) stkqty, "
				      + "stockid,cost_price,batch_no,exp_date  from my_prddin where psrno='"+psrno+"' and brhid='"+brcid+"' "
				        + " and op_qty-(out_qty+rsv_qty+del_qty)>0  and stockid not in ( "
				       + " select pin.stockid  from my_prddin pin left join my_sorderddet  i "
				       + " on i.stockid=pin.stockid and  i.rdocno="+values+"  where i.psrno='"+psrno+"' and pin.brhid='"+brcid+"' "
				        + " and  i.rdocno="+values+"  group by pin.stockid )  " ;
				
				
				
				
				
				
				
				
					}
			else
			{
				
				  pySql="select '' qty ,'' foc , op_qty-(out_qty+rsv_qty+del_qty) stkqty,stockid,cost_price,batch_no,exp_date "
						+ " from my_prddin where psrno='"+psrno+"' and brhid='"+brcid+"'   and op_qty-(out_qty+rsv_qty+del_qty)>0;";

				
			  
			}
			


			// System.out.println("====pySql===="+pySql);
		 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
		 
			

			stmtmain.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String cmbprice,String clientid,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			Statement stmt1 = conn.createStatement (); 
			String sql="";
			int method=0;
			int method1=0;
	 
			int pricemgt=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/
			String catid=clientcaid;
			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}

			
			  String brchid=session.getAttribute("BRANCHID").toString();
			  
			  
			  java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
		     	}

				

				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
			    	int taxid=0;
					String sqltax="select tax from my_acbook where dtype='CRM' and cldocno="+clientid+"";
					System.out.println("===sqltax======"+sqltax);
					ResultSet rs0=stmt.executeQuery(sqltax);				
					if(rs0.first())
					{
						taxid=rs0.getInt("tax");
					}
					
					if(taxid==0)
					{
						tax=0;
					}
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
		/*			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					}
					
				}
				
		
 
			if(prodsearchtype.equals("0")){ // o main only else prddin
				
				String chk1="select method  from gl_prdconfig where field_nme='edit'";
				ResultSet rs1=stmt1.executeQuery(chk1); 
				if(rs1.next())
				{

					method1=rs1.getInt("method");
				}
		/*		String chk2="select catid from my_acbook where dtype='CRM' and cldocno='"+clientid+"'";
				ResultSet rs2=stmt1.executeQuery(chk2); 
				if(rs2.next())
				{

					catid=rs2.getInt("catid");
				}
			 */
				 
				String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
				ResultSet rs3=stmt1.executeQuery(chk3); 
				if(rs3.next())
				{

					pricemgt=rs3.getInt("method");
				}
			 
				int discountset=0;
				String chk311="select method  from gl_prdconfig where field_nme='discountset'";
				ResultSet rs31=stmt1.executeQuery(chk311); 
				if(rs31.next())
				{

					discountset=rs31.getInt("method");
				}
			 
				int superseding=0;
				String chk21="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs21=stmt1.executeQuery(chk21); 
				if(rs21.next())
				{
					
					superseding=rs21.getInt("method");
				}
					
			
				
                String sqls=""; 
 
				if(method>0){ // eidtprice price mgt edit unit price

					if(pricemgt>0)
	                {
						if(superseding==1)
						{
							
							sql="  select s.part_no,m.* from (  select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
		                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
									+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
									+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
									+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
									+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"') "
									+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
								 	+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
									+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ) "
							  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
							
					 //	System.out.println("-main1-"+sql);	
						}
						else
						{
					sql="select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
							+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
							+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
							+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"') "
							+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
						 	+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
							+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";
                        
			 //	System.out.println("-1111111111---1-- sk ck-"+sql);
						}
	                }
					else
					{
						if(superseding==1)
						{
							sql=" select s.part_no,m.* from (  select "+fsql+"  bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
									+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
									+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
									+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
									+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
								 	+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
									+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ) "
							  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
					// 	System.out.println("-main 2-"+sql);
						}
						
						else
						{
							sql="select "+fsql+"  bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
									+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
									+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
									+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
									+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
								 	+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
									+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";
		                        
					// 	System.out.println("-1111111111---1-- sk ck-"+sql);
						}
						
						
					
					}
					
				}
				else{

				 
					if(pricemgt>0)
	                {
						
						if(superseding==1)
						{
							
							
							sql=" select s.part_no,m.* from ( select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
		                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,0 method,'"+method1+"' eidtprice, "
		                			+ " at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
								    + "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								    + "left join my_desc de on(de.psrno=m.doc_no)   "
								    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
										+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  group by m.doc_no ) "
							  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
							
							
					//	  System.out.println("---main 3--");	
						}
						else
						{
							
						
						
							sql="select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
		                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,0 method,'"+method1+"' eidtprice, "
		                			+ " at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
								    + "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								    + "left join my_desc de on(de.psrno=m.doc_no)   "
								    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
										+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  group by m.doc_no  ";
						//  System.out.println("----3- not chk stk--");	
							
						}
						
					
	                }
					else
					{
						
					
						
						
						if(superseding==1)
						{
							
							sql=" select s.part_no,m.* from ( select  "+fsql+" bd.brandname,0 method,'"+method1+"' eidtprice,at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
									+ "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
									+ "left join my_desc de on(de.psrno=m.doc_no)   "
								    + " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  )  "
							  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
							
							//  System.out.println("----main 4--");
							
						}
						
						else
						{
							
							sql="select  "+fsql+" bd.brandname,0 method,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,"
									+ "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
									+ "left join my_desc de on(de.psrno=m.doc_no)   "
								    + " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";
							//  System.out.println("----3- not chk stk--");	
							
						}
						
						
						
					
						
					}
				}

			
			
			}
			else{

				if(method>0){

					
		 			
					
					
					sql="select  "+outfsql+"   brandname,1 method, stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
							+ "( select "+fsql+"  bd.brandname,i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(i.op_qty) as qty,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
							+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  "
							+ "  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid)  "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a ";

					
				 	//System.out.println("1");
					

				}
				else{


					
 
					
					sql="select   "+outfsql+"   brandname,0 method, allowdiscount,stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno,unitprice,total, "
							+ " discper,dis,netotal from "
							+ "( select  "+fsql+"  bd.brandname,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,"
							+ " d.amount unitprice,sum(d.qty-d.out_qty)*d.amount total,d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100)  netotal,d.allowdiscount  from "
							+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
							+ " my_unitm u on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+joinsql+"   where  d.clstatus=0 and m.status=3 and d.rdocno in("+rdoc+") "
							 + "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ) as a ";
 
					
					 System.out.println("2="+sql);
				}


				/*sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
						+ "( select "+sqlselect+" as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
						+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "+sqlcond2+" ) as a ";
				 */
			}

	 	System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public   JSONArray searchSalesPerson(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,sal_name from my_salm where status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"' and status=3 ";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid) throws SQLException {

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
		String brcid = session.getAttribute("BRANCHID").toString(); 

		String sqltest="";


		java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}


		if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
		}
		if((!(refnosss.equalsIgnoreCase(""))) && (!(refnosss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.refno like '%"+refnosss+"%'  ";
		}

		/*if((!(clientid.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'  ";
      	}*/


		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();

			String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_qotm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_qotd d on(d.rdocno=m.doc_no)  where d.clstatus=0 and  m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
			System.out.println("====pySql===="+pySql);
			ResultSet resultSet = stmtmain.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 

			stmtmain.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype,String Cl_clientsale1,String Cl_mobnos) throws SQLException {


	//	System.out.println("==searchMaster===");

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


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}

		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}

		if(!(enqtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.ref_type like '%"+enqtype+"%'";
		}

		if(!(enqno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.rrefno like '%"+enqno+"%'";
		}

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 
		if(!(Cl_mobnos.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+Cl_mobnos+"%'";
		}


		if(!(Cl_clientsale1.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale1+"%'";
		}

		 

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select ac.per_mob,sa.doc_no saldocno,sa.sal_name,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,"
					+ "m.ref_type,rrefno from my_sorderm m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ "  left join my_salm sa on sa.doc_no=ac.sal_id and   ac.dtype='CRM' where m.brhid="+brid+" and m.status "+sqltest+"");
			//System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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



	/*public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

		//		System.out.println("==searchClient====");

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






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 ,catid from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
		 
			
		 
			String clsql= ("select a.catid,cl.cat_name,cl.pricegroup,a.per_tel pertel,a.cldocno,a.refname,trim(a.address) address,a.per_mob,trim(a.mail1) mail1  "
					+ "  from my_acbook a left join my_clcatm cl on cl.doc_no=a.catid where  a.dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
*/
	public JSONArray searchClient(HttpSession session,String clname,String mob,String Cl_clientsale) throws SQLException {

		//		System.out.println("==searchClient====");

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






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}
		if(!(Cl_clientsale.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale+"%'";
		}
		


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			String clsql= ("select sa.doc_no saldocno,sa.sal_name,a.catid,cl.cat_name,cl.pricegroup,a.per_tel pertel,a.cldocno,a.refname,trim(a.address) address,a.per_mob,trim(a.mail1) mail1  "
					+ "  from my_acbook a left join my_clcatm cl on cl.doc_no=a.catid  left join my_salm sa on sa.doc_no=a.sal_id  and a.dtype='CRM' where  a.dtype='CRM'  " +sqltest);
			System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno,stkid from "
					+ "( select at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.stockid as stkid from "
					+ "my_qotd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
			//System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String reftype,String dates,String cmbbilltype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			if(((enqdoc.equalsIgnoreCase(""))||(enqdoc.equalsIgnoreCase("undefined")))){

				enqdoc="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();


			String sql="";
			int method=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/

			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}


			int mulqty=0;
			Statement stmt31 = conn.createStatement (); 
		 
			String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
			ResultSet rss31=stmt31.executeQuery(chk311); 
			if(rss31.next())
			{

				mulqty=rss31.getInt("method");
			}
			
			String joinsqls="";
			String joinsqls1="";
			String joinsqls2="";
			String joinsqls3="";
			String joinsqls4="";
			String groupsql="";
			if(mulqty>0)
			{
				joinsqls=",i.unitid,i.specno ";
				joinsqls1= " and i.unitid=d.unitid ";
				joinsqls2= " and ii.unitid=i.unitid ";
				
				joinsqls3= "and aa.unitid=i.unitid and  aa.specno=i.specno ";
				
				joinsqls4= ",unitid ";
				 groupsql=",unitid,specno";
			}
			


			if(method>0){

				/*sql="select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "(select  stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,"
						+ " d.discount dis,d.nettotal netotal from "
						+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid and d.stockid=i.stockid) "
						+ "where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
						+ "group by i.stockid  order by i.date ) as a) as b ";*/


			/*	sql="select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
						+ "case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,"
						+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
						+ "(select  stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,"
						+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select i.stockid as stkid,"
						+ "d.specno as specid,d.rdocno,m.doc_no psrno,d.qty as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
						+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
						+ "d.total,d.disper discper, d.discount dis,d.nettotal netotal from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno)"
						+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)"
						+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
						+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid) where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid"
						+ "  order by i.date ) as a ) as b ; ";*/

			//	taxper sum(taxamount)  taxperamt sum(nettaxamount) taxamount disper
		/*		sql=" select allowdiscount,brandname,clstatus,1 method, stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,qty+balqty totqty, qty,qty as oldqty, "
						+ "  outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no, "
				  + "  productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg, "
				  + "  kgprice, unitprice, total, discper,  dis, netotal,taxper,taxperamt,taxamount,taxdocno from(select  allowdiscount,brandname,clstatus,stkid,specid,psrno as doc_no, "
				 + "   rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid, "
				 + "   productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal,taxper,taxdocno,taxperamt,taxamount from "
				 + "   ( select bd.brandname,d.clstatus, d.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,aa.qty as qty, ii.op_qty "
				 + "   as qtys,ii.outqty,m.part_no,m.part_no productid,m.productname, "
				+ "    u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,aa.total total,d.taxper,d.taxdocno,d.disper "
				 + "   discper, aa.discount dis,aa.nettotal netotal,aa.taxperamt,aa.taxamount,aa.allowdiscount from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) "
				 + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
				  + "  left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join  my_brand bd on m.brandid=bd.doc_no "
				 + "  left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno "
				  + "   and ma.brhid=i.brhid) "
				  + "  left join (select sum(qty) qty,sum(total) total,sum(discount) discount,sum(nettotal) nettotal,sum(taxamount) taxperamt,sum(nettaxamount) taxamount,sum(allowdiscount) allowdiscount,"
				  + " psrno,rdocno,specno,prdid from my_sorderd where  rdocno in("+docno+") "
				   + " group by  psrno) aa on aa.psrno=i.psrno "
				   + "  left join( select date,sum(op_qty) op_qty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid "
				  + "  from my_prddin where 1=1 group by psrno) ii on "
				 + "   (ii.psrno=i.psrno and ii.prdid=i.prdid and ii.specno=i.specno and ma.brhid=ii.brhid) "
				 + "    where m.status=3  and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid  order by i.date,i.prdid ) as a ) as b ";
	*/
				if(reftype.equalsIgnoreCase("DIR"))
				{
				sql=" select descqty collectqty,foc,allowdiscount,brandname,clstatus,1 method, stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,qty+balqty totqty, qty,qty as oldqty, "
						+ "  outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no, "
				  + "  productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg, "
				  + "  kgprice, unitprice, total, discper,  dis, netotal,taxper,taxperamt,taxamount from(select descqty,foc,allowdiscount,brandname,clstatus,"
				  + " stkid,specid,psrno as doc_no, "
				 + "   rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid, "
				 + "   productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal,taxper,taxperamt,taxamount from "
				 + "   ( select d.descqty,d.foc, bd.brandname,d.clstatus, d.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,aa.qty as qty, ii.op_qty/d.fr "
				 + "   as qtys,ii.outqty/d.fr outqty,m.part_no,m.part_no productid,m.productname, "
				+ "    u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,aa.total total,d.taxper,d.disper "
				 + "   discper, aa.discount dis,aa.nettotal netotal,aa.taxperamt,aa.taxamount,aa.allowdiscount from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) "
				 + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
				  + "  left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join  my_brand bd on m.brandid=bd.doc_no "
				 + "  left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno "
				  + "   and ma.brhid=i.brhid  and i.unitid=d.unitid ) "
				  + "  left join (select sum(qty) qty,sum(total) total,sum(discount) discount,sum(nettotal) nettotal,sum(taxamount) taxperamt,"
				  + "sum(nettaxamount) taxamount,sum(allowdiscount) allowdiscount,"
				  + " psrno,rdocno,specno,prdid,unitid from my_sorderd where  rdocno in("+docno+") "
				   + " group by  psrno,specno,unitid ) aa on aa.psrno=i.psrno and aa.specno=i.specno  and aa.unitid=i.unitid "
				   + "  left join( select date,sum(op_qty) op_qty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,unitid  "
				  + "  from my_prddin where 1=1 group by psrno,specno,unitid ) ii on "
				 + "   (ii.psrno=i.psrno and ii.prdid=i.prdid and ii.specno=i.specno and ma.brhid=ii.brhid  and ii.unitid=i.unitid  ) "
				 + "    where m.status=3  and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'"
				 		+ " group by i.prdid,i.specno,i.unitid  order by  d.sr_no ) as a ) as b ";
				System.out.println("=====sql==="+sql);
				}
			 
				  else
					{
						
						
						sql="select allowdiscount"+groupsql+",brandname,clstatus,1 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
								+ "  balqty,0 size,part_no,productid as proid,productid, "
							+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
							+ " ,unitprice unitprice1,discper disper1 ,taxper,taxperamt,taxamount "
							+ " from (select allowdiscount"+groupsql+",brandname,clstatus, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys-qty  as "
							+ " balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
							+ " dis, netotal,taxper,taxperamt,taxamount from ( select bd.brandname,d.unitid,d.specno,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,(aa.qty-aa.out_qty)+sum(d.qty)  "
							+ " as qtys,aa.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG "
							+ " totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper  "
							+ " discper, d.discount dis,d.nettotal netotal,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxper,d.allowdiscount  "
							+ " from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
							+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "   left join (select sum(qty) qty,sum(out_qty) out_qty, psrno,rdocno,specno,prdid,amount,disper,unitid from my_qotd where rdocno in("+enqdoc+") and clstatus=0   "
							+ " group by  psrno,unitid,specno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper and aa.unitid=d.unitid and aa.specno=d.specno  "
						+ " 	where m.status=3 	and d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
								+ "group by d.prdid,d.unitid,d.specno,aa.amount,aa.disper  ) as a) as b " ;	
						
						
						
						
					}

			}
	/*		else{

			 
				
				if(reftype.equalsIgnoreCase("DIR"))
				{
				
				sql="select allowdiscount,brandname,clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,"
						+ "  dis, netotal,taxper,taxperamt,taxamount,taxdocno from "
						+ "(select  allowdiscount,brandname,clstatus,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,"
						+ "  dis, netotal,taxper,taxperamt,taxamount,taxdocno from "
						+ "( select bd.brandname,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(d.qty) as qtys,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,"
						+ " d.discount dis,d.nettotal netotal,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxper,d.allowdiscount,d.taxdocno from "
						+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
						+ "group by d.prdid  ) as a) as b ";

			 	System.out.println("==33333333333333333         =prdGridReload===="+sql);
				}
				
				else
				{
					
					sql="select allowdiscount,brandname,clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
							+ "  balqty,0 size,part_no,productid as proid,productid, "
						+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
						+ " ,unitprice unitprice1,discper disper1 ,taxper,taxperamt,taxamount,taxdocno "
						+ " from (select allowdiscount,brandname,clstatus, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys-qty  as "
						+ " balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
						+ " dis, netotal,taxper,taxperamt,taxamount,taxdocno from ( select bd.brandname,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,(aa.qty-aa.out_qty)+sum(d.qty)  "
						+ " as qtys,aa.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG "
						+ " totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper  "
						+ " discper, d.discount dis,d.nettotal netotal,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxper,d.allowdiscount,d.taxdocno  "
						+ " from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
						+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "   left join (select sum(qty) qty,sum(out_qty) out_qty, psrno,rdocno,specno,prdid,amount,disper from my_qotd where rdocno in("+enqdoc+") and clstatus=0   "
						+ " group by  psrno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper "
					+ " 	where m.status=3 	and d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid,aa.amount,aa.disper  ) as a) as b " ;
					 
				}
				
	 
			}
*/

			else{

				//System.out.println("=====reftype==="+reftype);
				
				if(reftype.equalsIgnoreCase("DIR"))
				{
				
				sql="select allowdiscount"+groupsql+",brandname,clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,"
						+ "  dis, netotal,taxper,taxperamt,taxamount from "
						+ "(select  allowdiscount"+groupsql+",brandname,clstatus,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,"
						+ "  dis, netotal,taxper,taxperamt,taxamount from "
						+ "( select d.unitid,d.specno,bd.brandname,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(d.qty) as qtys,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,"
						+ " d.discount dis,d.nettotal netotal,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxper,d.allowdiscount from "
						+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
						+ "group by d.prdid,d.unitid,d.specno ) as a) as b ";

			 	System.out.println("===prdGridReload===="+sql);
				}
				
				else
				{
					
					sql="select allowdiscount"+groupsql+",brandname,clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
							+ "  balqty,0 size,part_no,productid as proid,productid, "
						+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
						+ " ,unitprice unitprice1,discper disper1 ,taxper,taxperamt,taxamount "
						+ " from (select allowdiscount"+groupsql+",brandname,clstatus, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys-qty  as "
						+ " balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
						+ " dis, netotal,taxper,taxperamt,taxamount from ( select bd.brandname,d.unitid,d.specno,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,(aa.qty-aa.out_qty)+sum(d.qty)  "
						+ " as qtys,aa.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG "
						+ " totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper  "
						+ " discper, d.discount dis,d.nettotal netotal,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxper,d.allowdiscount  "
						+ " from my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
						+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "   left join (select sum(qty) qty,sum(out_qty) out_qty, psrno,rdocno,specno,prdid,amount,disper,unitid from my_qotd where rdocno in("+enqdoc+") and clstatus=0   "
						+ " group by  psrno,unitid,specno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper and aa.unitid=d.unitid and aa.specno=d.specno  "
					+ " 	where m.status=3 	and d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
							+ "group by d.prdid,d.unitid,d.specno,aa.amount,aa.disper  ) as a) as b " ;
					//System.out.println("==234234234prdGridReload===="+sql);
				}
				
	 
			}
 

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray prdGridReload(HttpSession session,String docno,String dates,String cmbbilltype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
              int method=0;

			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}

			
			
			 java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
		     	}
			
				
				

				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				 
				
				
				if(tax>0)
				{
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
	/*				joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";
					*/

					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				
			
				int mulqty=0;
				Statement stmt31 = conn.createStatement (); 
			 
				String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
				ResultSet rss31=stmt31.executeQuery(chk311); 
				if(rss31.next())
				{

					mulqty=rss31.getInt("method");
				}
				
				String joinsqls="";
				String joinsqls1="";
				String joinsqls2="";
				String joinsqls3="";
				String joinsqls4="";
				String groupsql="";
				if(mulqty>0)
				{
					joinsqls=",d.unitid,d.specno ";
					joinsqls1= " and i.unitid=d.unitid ";
					joinsqls2= " and ii.unitid=i.unitid ";
					
					joinsqls3= "and aa.unitid=i.unitid and  aa.specno=i.specno ";
					
					joinsqls4= ",unitid ";
					 groupsql=",unitid,specno";
				}
				
			
 		
			if(method==0)
			{
 
	 	/*		String sql="select "+fsql+" bd.brandname,0 method,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty )outqty,sum(qty-out_qty) balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ " d.amount unitprice,d.amount unitprice1,d.disper disper1, sum(qty-out_qty)*amount total,disper discper,(sum(qty-out_qty)*amount*disper)/100 dis,((sum(qty-out_qty)*amount)-(sum(qty-out_qty)*amount*disper)/100)  netotal from my_qotd d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no   "+joinsql+"  where d.clstatus=0 and  m.status=3 and d.rdocno in("+docno+") group by d.psrno,d.amount,d.disper "
						+ "having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ";
				
				*/
	 			String sql="select "+fsql+" bd.brandname,0 method,d.specno as specid"+joinsqls+",d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty )outqty,sum(qty-out_qty) balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ " d.amount unitprice,d.amount unitprice1,d.disper disper1, sum(qty-out_qty)*amount total,disper discper,(sum(qty-out_qty)*amount*disper)/100 dis,((sum(qty-out_qty)*amount)-(sum(qty-out_qty)*amount*disper)/100)  netotal from my_qotd d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join "
						+ " my_brand bd on m.brandid=bd.doc_no   "+joinsql+"  where d.clstatus=0 and  m.status=3 and d.rdocno in("+docno+")"
								+ " group by d.psrno"+joinsqls+",d.amount,d.disper "
						+ "having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ";
				
				

	 			
	 			
				
 		 	System.out.println("===11111111prdGridReload===1=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			 
			}
			
			else
			{
			
/*			String sql="select "+fsql+" bd.brandname,i.stockid as stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,ii.qty totqty,ii.qty "
					+ "as oldqty,if(ii.qty>aa.qty,aa.qty,ii.qty) qty "
			+ " ,aa.out_qty outqty,d.qty as balqty,part_no,m.part_no productid,m.part_no "
			+ " as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice "
			 + " kgprice,d.amount unitprice, total,d.disper discper,d.discount dis,d.nettotal netotal from my_qotm  ma left join  my_qotd d "
			+ "on(ma.doc_no=d.rdocno) "
			+ "  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) "
			 + "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
			+ "  left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno "
					+ "   and ma.brhid=i.brhid) "
					+ "	  left join (select sum(qty) qty,(sum(qty)-sum(out_qty)) out_qty, psrno,rdocno,specno,prdid from my_qotd where rdocno in("+docno+") "
					+ "	group by  psrno) aa on aa.psrno=i.psrno "
					+ "	   left join( select date,(sum(op_qty)-sum(out_qty+del_qty+rsv_qty)) qty, sum(op_qty) op_qty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid "
				+ "		from my_prddin where 1=1 group by psrno) ii on "
			   + "   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=i.specno and ma.brhid=i.brhid) "
			   + "   "+joinsql+" where m.status=3 and d.rdocno in("+docno+") "
			   + " group by d.psrno having sum(d.qty-d.out_qty)>0 ";
			
			*/
			String sql="select "+fsql+" bd.brandname,1 method,d.specno as specid"+joinsqls+",d.psrno as "
					+ " doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty )outqty,sum(qty-out_qty) balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ " d.amount unitprice,d.amount unitprice1,d.disper disper1, sum(qty-out_qty)*amount total,disper discper,(sum(qty-out_qty)*amount*disper)/100 dis,((sum(qty-out_qty)*amount)-(sum(qty-out_qty)*amount*disper)/100)  netotal from my_qotd d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join "
					+ " my_brand bd on m.brandid=bd.doc_no   "+joinsql+"  where d.clstatus=0 and  m.status=3 and d.rdocno in("+docno+")"
							+ " group by d.psrno"+joinsqls+",d.amount,d.disper "
					+ "having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ";
			
			
	 	//System.out.println("==11111111111111111111111111111111111111=prdGridReload===2=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			}
			
			

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}




	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m   "
					+ " inner join my_termsd d on(m.voc_no=d.rdocno and  d.status=3) where m.status=3 and d.dtype='"+dtype+"' order by terms";
		//	System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" order by terms";
			//System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}



	public   JSONArray qotgridreload(String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			
		 
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";

			if(((doc.equalsIgnoreCase(""))||(doc.equalsIgnoreCase("undefined")))){

				doc="0";
			}

			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}


			if(method>0){
				sqlcond1="inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";
				sqlcond2="group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date";
				sqlselect="i.stockid";
			}
			else{
				sqlselect="0";
				sqlcond1="";
				sqlcond2="group by psrno having sum(d.qty-d.out_qty)>0";
			}


			sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
					+ "( select "+sqlselect+" as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
					+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+doc+")  "+sqlcond2+" ) as a group by psrno";


		 	//System.out.println("=qotgridreload==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmt.close();


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


	public int insert(java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,
			ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,
			String qotmasterdocno,String descper, ArrayList<String> shiparray,int shipdocno,String delterms,
			double stval, double tax1, double tax2, double tax3, double nettax,int cmbbilltype) throws SQLException{

		Connection conn=null;
		int sodocno=0;
		conn=ClsConnection.getMyConnection();

		try{
			if(descper.equalsIgnoreCase("") || descper==null)
			{
				descper="0";
			}
			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(26, java.sql.Types.VARCHAR);
	
			
			//System.out.println("================================clientid=="+clientid);
			
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,qotmasterdocno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(nettotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23, Integer.parseInt(pricegrp));
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				
				
				Statement st=conn.createStatement();
				String sqlss="update my_sorderm set delterms='"+delterms+"' where doc_no='"+sodocno+"' ";
				
				st.executeUpdate(sqlss);
				
				int prodet=0;
				int prodout=0;
				
				String rownochk="0";    
			 
				
				
				
				
				
				
				
				
				
				
				
				
				
				int taxmethod=0;
				 Statement stmttax=conn.createStatement();
				
				 String chkss="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chkss); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }

				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_sorderm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sodocno+"' ";
					  
					  System.out.println("======sqltax1========="+sqltax1);
					  
					  stmt.executeUpdate(sqltax1);
					  
					  
					  

					  int prvdocno=0;
						 
						  Statement pv=conn.createStatement();
							
							String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
							
							System.out.println("=======dd========"+dd);
							
							
							ResultSet rs13=pv.executeQuery(dd); 
							if(rs13.next())
							{

								prvdocno=rs13.getInt("prvdocno");
							}
							System.out.println("======prvdocno========"+prvdocno);

					  
					  
					  	Statement ssss=conn.createStatement();
						  
						 String sql100=" select s.value "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							
							 	typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_sorderm set typeoftax='"+typeoftax+"'    where doc_no='"+sodocno+"' ";
								  
								 
								  
							 stmt.executeUpdate(sqltax11);						 	
						 	
						 }
					  
					  
					  
				  }
				
				
				
				
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

						int method=0;
						String chk="select method  from gl_prdconfig  where field_nme='prosearch_stock'";
						ResultSet rsconfiq=stmt.executeQuery(chk); 
						if(rsconfiq.next())
						{

							method=rsconfiq.getInt("method");
						}
						
						   double expenxetotal=0;
						     double resultexptotal=0;
						     double totalpriceallqty=0;
						     
						     double costprice=0;
						     String  qtychk=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
						    	//String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    	 
						    	 
							     double chkqty=Double.parseDouble(qtychk);
                       String gridnettotals=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";
				    	 
				    	 double gridnettotal=Double.parseDouble(gridnettotals);
				    	// Double.parseDouble(nettotal);
				    	// System.out.println("--gridnettotal---"+gridnettotal);
				    	 expenxetotal=Double.parseDouble(servamt);
				    	 
				    	 if(expenxetotal>0)
				    	 {
					//	 System.out.println("--expenxetotal---"+expenxetotal);
				    	 resultexptotal=(expenxetotal/Double.parseDouble(nettotal))*gridnettotal;
				    	// System.out.println("--resultexptotal---"+resultexptotal);
				    	 totalpriceallqty=gridnettotal+resultexptotal;
				    	// System.out.println("--totalpriceallqty---"+totalpriceallqty);
				    	 costprice=totalpriceallqty/chkqty;
				    	// System.out.println("--costprice---"+costprice);
				    	 }
				    	 else
				    	 {
				    		 
				    		 costprice=gridnettotal/chkqty;
				    		 
				    	 }
						
						
						
						
						
						   
				 		
				    		
				         String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
						    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						     
					    	 
						 
						      
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
						     
						   System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
				    	 
					

					 


							String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno,fr)VALUES"
									+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
									+ "'"+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
									+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
									+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"' ,"
						 			+ "'"+(prod[17].trim().equalsIgnoreCase("undefined") || prod[17].trim().equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| taxmethod==0  ||  prod[17].isEmpty()?0:prod[17].trim())+"',"
									+ "'"+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[18].isEmpty()?0:prod[18].trim())+"',"
									+ "'"+(prod[19].trim().equalsIgnoreCase("undefined") || prod[19].trim().equalsIgnoreCase("") || prod[19].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[19].isEmpty()?0:prod[19].trim())+"', "
									+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"' , "
									+ "'"+(prod[21].trim().equalsIgnoreCase("undefined") || prod[21].trim().equalsIgnoreCase("") || prod[21].trim().equalsIgnoreCase("NaN")|| prod[21].isEmpty()?0:prod[21].trim())+"',"+fr+" )";
									 

							System.out.println("branchper--->>>>Sql"+sql);
							prodet = stmt.executeUpdate (sql);


//
//							String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price) Values"
//									+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
//									+ "'"+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
//									+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
//									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
//									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
//									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
//									+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice+"')";
//
//							System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
//							prodout = stmt.executeUpdate (prodoutsql);

						 

						if(vocno>0)
						{

			/*				String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double masterqty1=Double.parseDouble(rqty);
							//int stockid=Integer.parseInt(stkid);
							double foc=Double.parseDouble(""+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].trim().equalsIgnoreCase("")|| prod[16].isEmpty()?0:prod[16].trim())+"");
							System.out.println("==method==="+method);*/
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							
							masterqty=masterqty*fr;
							
							System.out.println("==metmasterqtymasterqtymasterqtymasterqtymasterqtymasterqtymasterqtyhod==="+masterqty);
							
							double masterqty1=Double.parseDouble(rqty);
							//int stockid=Integer.parseInt(stkid);
							double foc=Double.parseDouble(""+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].trim().equalsIgnoreCase("")|| prod[16].isEmpty()?0:prod[16].trim())+"");
					
/*
							
							System.out.println("==mathodfoc==="+mathodfoc);*/
/*							if(method>0){
								double delqtys=0;
								double balstkqty=0;
								int psrno=0;
								double ckkqty=0;
								int stockid=0;
								double remstkqty=0;
								double outstkqty=0;
								double stkqty=0;
								double qty=0;
								double detqty=0;
								double focmasterqty=0.0;
								
								
	                            String taxper1=""+(prod[17].equalsIgnoreCase("undefined") || prod[17].equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| prod[17].isEmpty()?0:prod[17].trim())+"";
	                            
	                            double taxper=0;
	                            double taxamount=0;
								
								
								Statement stmtstk=conn.createStatement();

								String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,rsv_qty as qty,date from my_prddin "
										+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

								System.out.println("=stkSql======11=======inside insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {


									balstkqty=rsstk.getDouble("balstkqty");
									psrno=rsstk.getInt("psrno");
									outstkqty=rsstk.getDouble("out_qty");
									stockid=rsstk.getInt("stockid");
									stkqty=rsstk.getDouble("stkqty");
									qty=rsstk.getDouble("qty");

									System.out.println("---focmasterqty-----"+focmasterqty);	
									System.out.println("---balstkqty-----"+balstkqty);	
									System.out.println("---out_qty-----"+outstkqty);	
									System.out.println("---stkqty-----"+stkqty);
									System.out.println("---qty-----"+qty);

									focmasterqty=masterqty+foc;
									if(remstkqty>0)
									{

										focmasterqty=remstkqty;
									}
									   ckkqty=focmasterqty;

									if(focmasterqty<=balstkqty)
									{
										
										focmasterqty=focmasterqty+qty;
										
										detqty=masterqty;
										String sqls="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
										System.out.println("--1---sqls---"+sqls);
										stmt.executeUpdate(sqls);
										//break;
										delqtys=focmasterqty-qty;
										focmasterqty=ckkqty-focmasterqty-qty;

									}
									else if(masterqty>balstkqty)
									{



										if(stkqty>=(masterqty+outstkqty))

										{
											balstkqty=masterqty+qty;	
											remstkqty=stkqty-outstkqty;

											System.out.println("---balstkqty-1---"+balstkqty);
										}
										else
										{
											remstkqty=masterqty-balstkqty;
											balstkqty=stkqty-outstkqty+qty;

											System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);
										}
										detqty=stkqty-outstkqty;

										String sqls="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										delqtys=detqty;
										//remstkqty=masterqty-stkqty;



									}
									System.out.println("-delqtys---"+delqtys);
									System.out.println("-detqty---"+detqty);

									double NtWtKG=0.0;
									double KGPrice=0.0;
									double unitprice=0.0;
									double total=0.0;
									double discper=0.0;
									double discount=0.0;
									double netotal=0.0;
									Double nettaxamount=0.0;
									NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
									KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
									total=delqtys*unitprice;
								 
									discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									discount=(total*discper)/100;
									netotal=total-discount;
									
									 if(taxmethod>0)
									  {
								         taxper=Double.parseDouble(taxper1);
				                           taxamount=netotal*(taxper/100);
				                           nettaxamount=netotal+taxamount; 
									  }
			 

 

									String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno)VALUES"
											+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+NtWtKG+"',"
											+ "'"+KGPrice+"',"
											+ "'"+unitprice+"',"
											+ "'"+total+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+discount+"',"
											+ "'"+netotal+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"', "
											+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"'  , "
									+ "'"+(prod[21].trim().equalsIgnoreCase("undefined") || prod[21].trim().equalsIgnoreCase("") || prod[21].trim().equalsIgnoreCase("NaN")|| prod[21].isEmpty()?0:prod[21].trim())+"' )";
									System.out.println("branchper--->>>>Sql"+sql);
									prodet = stmt.executeUpdate (sql);


									String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price,date) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice+"','"+date+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);

									if(focmasterqty<=0)
									{
										
										System.out.println("--2--");
										break;
									}


								}





							}*/
							  if(method>0){
								//=======================================================================================
								double delqtys=0;
								double balstkqty=0;
								int psrno=0;
								double ckkqty=0;
								int stockid=0;
								double remstkqty=0;
								double outstkqty=0;
								double stkqty=0;
								double qty=0;
								double detqty=0;
								double focmasterqty=0.0;
								
								int sfr;
	                            String taxper1=""+(prod[17].equalsIgnoreCase("undefined") || prod[17].equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| prod[17].isEmpty()?0:prod[17].trim())+"";
	                            
	                            double taxper=0;
	                            double taxamount=0;
								
								
								Statement stmtstk=conn.createStatement();

								String stkSql="select fr,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,sum(rsv_qty) as qty,date from my_prddin "
										+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"'  and brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

								System.out.println("=stkSql======11=======inside insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {


									balstkqty=rsstk.getDouble("balstkqty");
									psrno=rsstk.getInt("psrno");
									outstkqty=rsstk.getDouble("out_qty");
									stockid=rsstk.getInt("stockid");
									stkqty=rsstk.getDouble("stkqty");
									qty=rsstk.getDouble("qty");
									sfr=rsstk.getInt("fr");
								 

									focmasterqty=(masterqty+foc);
									System.out.println("---focmasterqty-----"+focmasterqty);	
									System.out.println("---balstkqty-----"+balstkqty);	
									System.out.println("---out_qty-----"+outstkqty);	
									System.out.println("---stkqty-----"+stkqty);
					
									if(remstkqty>0)
									{

										focmasterqty=remstkqty;
									}
									   ckkqty=focmasterqty;

									if(focmasterqty<=balstkqty)
									{
										
										focmasterqty=focmasterqty+qty;
										
										detqty=masterqty;
										String sqls="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" "  ;
										System.out.println("--1---sqls---"+sqls);
										stmt.executeUpdate(sqls);
										//break;
										delqtys=focmasterqty-qty;
										focmasterqty=ckkqty-focmasterqty-qty;

									}
									else if(masterqty>balstkqty)
									{



										if(stkqty>=(masterqty+outstkqty))

										{
											balstkqty=masterqty+qty;	
											remstkqty=stkqty-outstkqty;

											System.out.println("---balstkqty-1---"+balstkqty);
										}
										else
										{
											remstkqty=masterqty-balstkqty;
											balstkqty=stkqty-outstkqty+qty;

											/*System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);*/
										}
										detqty=stkqty-outstkqty;

										String sqls="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" " ;
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										delqtys=detqty;
										//remstkqty=masterqty-stkqty;



									}
									//System.out.println("-delqtys---"+delqtys);
									//System.out.println("-detqty---"+detqty);

									double NtWtKG=0.0;
									double KGPrice=0.0;
									double unitprice=0.0;
									double total=0.0;
									double discper=0.0;
									double discount=0.0;
									double netotal=0.0;
									Double nettaxamount=0.0;
									NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
									KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
									total=delqtys*unitprice;
								 
									discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									discount=(total*discper)/100;
									netotal=total-discount;
									
									 if(taxmethod>0)
									  {
								         taxper=Double.parseDouble(taxper1);
				                           taxamount=netotal*(taxper/100);
				                           nettaxamount=netotal+taxamount; 
									  }
			 

 

		/*							String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount)VALUES"
											+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+NtWtKG+"',"
											+ "'"+KGPrice+"',"
											+ "'"+unitprice+"',"
											+ "'"+total+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+discount+"',"
											+ "'"+netotal+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"', "
											+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"' )";
									System.out.println("branchper--->>>>Sql"+sql);
									prodet = stmt.executeUpdate (sql);
*/

									String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price,date) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice/fr+"','"+date+"')";

									//System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);

									if(focmasterqty<=0)
									{
										
										System.out.println("--2--");
										break;
									}


								}





							}

							if(rreftype.equalsIgnoreCase("SQOT"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

							
								String amount=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")||prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
								  
								   
								   
								String discper=""+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("NaN")||prod[15].trim().equalsIgnoreCase("")|| prod[15].isEmpty()?0:prod[15].trim())+"";
								    
					   		 
								 System.out.println("---amount--"+amount);
								 System.out.println("---discper--"+discper);
								
								
								Statement stmt1=conn.createStatement();

					/*			String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_qotm m  left join "
										+ "my_qotd d on m.doc_no=d.rdocno where d.clstatus=0 and  d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.doc_no not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";
*/
								
								
								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_qotm m  left join "
										+ "my_qotd d on m.doc_no=d.rdocno where d.clstatus=0 and   d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' "
												+ " and d.doc_no not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"' and d.specno="+specno+" and d.unitid="+unitidss+" group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";
								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");


									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);

									rownochk=rownochk+","+docno;
									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{
										masterqty1=masterqty1+out_qty;



										String sqls="update my_qotd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"  and clstatus=0    and specno="+specno+" and unitid="+unitidss+" " ;

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{



										if(qtys>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_qotd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"  and clstatus=0   and specno="+specno+" and unitid="+unitidss+"	";
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){     

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_sordser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+(sorderarray[7].trim().equalsIgnoreCase("undefined") || sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()?0:sorderarray[7].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+sodocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}


				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sodocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}
				
				
				
				
				
				
				
				
				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+sodocno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmt.executeUpdate(shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_sorderm set shipdetid='"+shipdocno+"' where doc_no='"+sodocno+"' ";
				
				stmt.executeUpdate (updatesql);
				


			}



			 conn.commit();
		}
		catch(Exception e){
			sodocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return sodocno;
	}

	public  ClsSalesOrderBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select   m.billtype,m.totaltax,m.tax1,m.tax2,m.tax3,m.nettotaltax ,m.delterms,m.shipdetid, if(sh.type=0,sh.clname,ac1.refname) clname,  sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax,"
					+ " m.pricegroup,m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,cr.c_rate as curate,m.brhid,"
					+ " ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,"
					+ " coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid,coalesce(s.sal_name,'') as sal_name, "
					+ " coalesce(m.amount,0.00) as proamt,coalesce(m.discount,0.00) as discount,coalesce(m.netAmount,0.00) as netotal,coalesce(m.disper,0.00) as discper, "
					+ " coalesce(m.grantamt,0.00) as ordervalue,coalesce(m.servamt,0.00) as servamt,coalesce(m.roundof,0.00) as roundof "
					+ "from my_sorderm m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ " left join my_salm s on(s.doc_no=m.sal_id) left join my_curr cr on(m.curid=cr.doc_no)"
					+ " left join my_shipdetails sh on sh.doc_no=m.shipdetid and sh.type>0 "
					+ "  left join my_acbook ac1 on(ac1.doc_no=sh.cldocno and ac1.dtype='CRM') "
					+ " where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails==left join my_sorderd d on(m.doc_no=d.rdocno)=="+sql);
			String dtype="";
			String sqot="";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				
			
				
				bean.setSt(rs.getDouble("totaltax")); 
				bean.setTaxontax1(rs.getDouble("tax1"));
				bean.setTaxontax2(rs.getDouble("tax2"));
				bean.setTaxontax3(rs.getDouble("tax3"));
				bean.setTaxtotal(rs.getDouble("nettotaltax"));
				bean.setCmbbilltype(rs.getInt("billtype"));
				
				
				
				bean.setDelterms(rs.getString("delterms"));
				bean.setHidcmbprice(rs.getString("pricegroup"));
				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setCmbcurr(rs.getString("currid"));
				bean.setHidcmbcurrency(rs.getString("currid"));
				bean.setCurrate(rs.getString("curate"));
				bean.setSalespersonid(rs.getInt("salid"));
				bean.setTxtsalesperson(rs.getString("sal_name"));
				bean.setClientid(rs.getInt("cldocno"));
				 
				bean.setRefmasterdocno(rs.getString("rrefno"));
				
				
				
				bean.setCmbreftype(rs.getString("ref_type"));
				bean.setHidcmbreftype(rs.getString("ref_type"));
				dtype=rs.getString("ref_type");
				sqot=rs.getString("rrefno");
				bean.setProdsearchtype(rs.getString("ref_type").equalsIgnoreCase("DIR")?"0":"2");
				bean.setTxtpaymentterms(rs.getString("payterms"));
				bean.setTxtdescription(rs.getString("descrptn"));
				bean.setTxtproductamt(rs.getString("proamt"));
				bean.setTxtdiscount(rs.getString("discount"));
				bean.setDescPercentage(rs.getString("discper"));
				bean.setRoundOf(rs.getString("roundof"));
				bean.setTxtnettotal(rs.getString("netotal"));
				bean.setNettotal(rs.getString("servamt"));
				bean.setOrderValue(rs.getString("ordervalue"));
				
				
				
				
				 
				
				bean.setShipdocno(rs.getInt("shipdetid"));
				bean.setShipto(rs.getString("clname"));
				bean.setShipaddress(rs.getString("claddress"));
				bean.setContactperson(rs.getString("contactperson"));
				bean.setShiptelephone(rs.getString("tel"));
				
				
				bean.setShipmob(rs.getString("mob"));
				bean.setShipemail(rs.getString("email"));
				bean.setShipfax(rs.getString("fax"));
			

			}


			int i=0;
			String qotdoc="";
			if(dtype.equalsIgnoreCase("SQOT"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_qotm where doc_no in ("+sqot+") ";
				//System.out.println("==sqlss==="+sqlss);

				ResultSet resultSet1= stmt1.executeQuery(sqlss);


				while (resultSet1.next()) {

					if(i==0)
					{
						qotdoc=resultSet1.getString("voc_no")+",";	
					}
					else
					{
						qotdoc=qotdoc+resultSet1.getString("voc_no")+",";
					}


					i++;



				}

				if(qotdoc.endsWith(","))
				{
					qotdoc = qotdoc.substring(0,qotdoc.length() - 1);
				}

				bean.setRrefno(qotdoc);

			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
finally
{
	conn.close();
}
		return bean;
	}



	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,
			ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,
			String qotmasterdocno,String descper,String updatadata, ArrayList<String> shiparray,int shipdocno,String delterms,
			double stval, double tax1, double tax2, double tax3, double nettax,int cmbbilltype)  throws SQLException{

		Connection conn=null;
		int sodocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,qotmasterdocno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(nettotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23, Integer.parseInt(pricegroup));
			stmt.setInt(24,doc_no);
			stmt.setInt(25,Integer.parseInt(voc_no));
			stmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			
	
			
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			
			if(val<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			if(vocno>0){

			
				
				Statement st10=conn.createStatement();
				String sqlss="update my_sorderm set delterms='"+delterms+"' where doc_no='"+sodocno+"' ";
				
				st10.executeUpdate(sqlss);
				
		  System.out.println("=========updatadata============="+updatadata);
				
			
			int taxmethod=0;
			 Statement stmttax=conn.createStatement();
			
			 String chkss="select method  from gl_prdconfig where field_nme='tax'";
			 ResultSet rssz=stmttax.executeQuery(chkss); 
			 if(rssz.next())
			 {
			 	
				 taxmethod=rssz.getInt("method");
			 }

			  if(taxmethod>0)
			  {
				  String sqltax1= " update my_sorderm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
				  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sodocno+"' ";
				  
				  System.out.println("======sqltax1========="+sqltax1);
				  
				  stmt.executeUpdate(sqltax1);
				  
				  
				  

				  int prvdocno=0;
					 
					  Statement pv=conn.createStatement();
						
						String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
						
						System.out.println("=======dd========"+dd);
						
						
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						System.out.println("======prvdocno========"+prvdocno);

				  
				  
				  	Statement ssss=conn.createStatement();
					  
					 String sql100=" select s.value "
							 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
							 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  ) "
							 		+ "  and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  " ;
				System.out.println("=====sql======"+sql100);
					 ResultSet rstaxxx=ssss.executeQuery(sql100); 
					 if(rstaxxx.next())
					 {
						 String typeoftax="0";
						
						 	typeoftax=rstaxxx.getString("value");
						 
						 String sqltax11= " update my_sorderm set typeoftax='"+typeoftax+"'    where doc_no='"+sodocno+"' ";
							  
							 
							  
						 stmt.executeUpdate(sqltax11);						 	
					 	
					 }
				  
				  
				  
			  }
			
			
			
				
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{
					
					
					
					int prodet=0;
					int prodout=0;
					int updateid=0;
					Statement st=conn.createStatement();
					
					Statement prddinst=conn.createStatement();
					
					Statement prddoust=conn.createStatement();
					
					int dstockid=0;
					int dpsrno=0;
					double dqty=0.00;
					
					int dtr_no=0;
					String rownochk="0"; 
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[10].trim().equalsIgnoreCase("undefined")|| prod[10].trim().equalsIgnoreCase("null")|| prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()))){

						
						
						
						
						
						
						
						
					/*	
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

		String sql9="select count(*) tmpcount from my_sorderd where rdocno='"+sodocno+"'"	;				
 
	//	System.out.println("-----sql9-----"+sql9);
		
		ResultSet rsstk11 = stmt.executeQuery(sql9);

		
		if(rsstk11.next())
		{
			counts=rsstk11.getInt("tmpcount");
		}
		
		Statement st1=conn.createStatement();
	     for(int m=0;m<=counts;m++)
	     {
	    	 
	    	String sql2="select stockid,qty,prdid,tr_no from my_sorderd where rdocno='"+sodocno+"' and stockid not in("+tempstk+") group by stockid limit 1";
	    	System.out.println("-----sql2-----"+sql2);
	    	ResultSet rsstk111 = stmt.executeQuery(sql2);
	    	
	    	
	    	if(rsstk111.next())
	    	{
	    		chkqtys=rsstk111.getDouble("qty");
	    		stkids=rsstk111.getInt("stockid");
	    		prdidss=rsstk111.getInt("prdid");
	    		tmptrno=rsstk111.getInt("tr_no");
	    	
	    	
	    	String sql3=" select rsv_qty   prdqty  from my_prddin where stockid='"+stkids+"'";
	    	 System.out.println("-----sql3-----"+sql3);
	    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
	    	
	    	
	    	if(rsstk1111.next())
	    	{
	    		prdqty=rsstk1111.getDouble("prdqty");
		    	saveqty=prdqty-chkqtys;
		    	
		    	if(saveqty<0){
		    	saveqty=0;
		    	
		    	}
		    	
		      	String sql31="update my_prddin set rsv_qty="+saveqty+" where stockid='"+stkids+"'";
		    	 System.out.println("-----sql31-----"+sql31);
		    	 stmt.executeUpdate(sql31);
		    	 
		    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"'  ";
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
	    	}

	    	 
	     }
 

 

    	 
    	      String dql31="delete from my_sorderd where rdocno='"+sodocno+"'";
    	 	  stmt.executeUpdate(dql31);
    	 	 String dql32="delete from my_sordser where rdocno='"+sodocno+"'";
    	 	 stmt.executeUpdate(dql32);
   	 	 
    	 	 String dql33= "delete from my_trterms where rdocno='"+sodocno+"' and dtype='"+formcode+"' ";
    	 	 stmt.executeUpdate(dql33);
      	 	 
      	 	 String deltermssqls="delete from my_deldetaild where rdocno='"+sodocno+"' and  dtype='"+formcode+"'  ";
	    	 	stmt.executeUpdate(deltermssqls);
    			
						}
						*/
						int method=0;
						String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
						ResultSet rsconfiq=stmt.executeQuery(chk); 
						if(rsconfiq.next())
						{

							method=rsconfiq.getInt("method");
						}
						
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
		int deldocno=0;
		int stk=0;

		
		if(method>0){
			
		String sql9="select count(*) tmpcount from my_prddout where rdocno='"+sodocno+"' and dtype='SOR' and tr_no="+trno+" " 	;				
 
	//	System.out.println("-----sql9-----"+sql9);
		
		ResultSet rsstk11 = stmt.executeQuery(sql9);

		
		if(rsstk11.next())
		{
			counts=rsstk11.getInt("tmpcount");
		}
		
		Statement st1=conn.createStatement();
	     for(int m=0;m<=counts;m++)
	     {
	    	 
	    	String sql2="select doc_no,rsv_qty qty,prdid,tr_no,stockid,doc_no deldocno from my_prddout where rdocno='"+sodocno+"' and tr_no="+trno+" and doc_no not in("+tempstk+")    and dtype='SOR' group by doc_no limit 1";
	    //	System.out.println("-----sql2-----"+sql2);
	    	ResultSet rsstk111 = stmt.executeQuery(sql2);
	    	
	    	
	    	if(rsstk111.next())
	    	{
	    		chkqtys=rsstk111.getDouble("qty");
	    		stk=rsstk111.getInt("stockid");
	    		stkids=rsstk111.getInt("doc_no");
	    		prdidss=rsstk111.getInt("prdid");
	    		tmptrno=rsstk111.getInt("tr_no");
	    		deldocno=rsstk111.getInt("deldocno");
	    	
	    	
	    	String sql3=" select rsv_qty   prdqty  from my_prddin where stockid='"+stk+"'";
	    	 System.out.println("-----sql3-----"+sql3);
	    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
	    	
	    	
	    	if(rsstk1111.next())
	    	{
	    		prdqty=rsstk1111.getDouble("prdqty");
		    	saveqty=prdqty-chkqtys;
		    	
		    	if(saveqty<0){
		    	saveqty=0;
		    	
		    	}
		    	
		      	String sql31="update my_prddin set rsv_qty="+saveqty+" where stockid='"+stk+"'";
		    	 System.out.println("-----sql31-----"+sql31);
		    	 stmt.executeUpdate(sql31);
		    	 
		    	 	String sql34="delete from my_prddout  where stockid='"+stk+"' and prdid='"+prdidss+"' and doc_no='"+deldocno+"' and dtype='SOR'  ";
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
	    	}

	    	 
	     }
						}         //method

 

    	 
    	      String dql31="delete from my_sorderd where rdocno='"+sodocno+"'";
    	 	  stmt.executeUpdate(dql31);
    	      String dql311="delete from my_sorderddet where rdocno='"+sodocno+"'";
    	 	  stmt.executeUpdate(dql311);
    	 	 
    	 	 String dql32="delete from my_sordser where rdocno='"+sodocno+"'";
    	 	 stmt.executeUpdate(dql32);
   	 	 
    	 	 String dql33= "delete from my_trterms where rdocno='"+sodocno+"' and dtype='"+formcode+"' ";
    	 	 stmt.executeUpdate(dql33);
      	 	 
      	 	 String deltermssqls="delete from my_deldetaild where rdocno='"+sodocno+"' and  dtype='"+formcode+"'  ";
	    	 	stmt.executeUpdate(deltermssqls);
    			
						}
						
/*
						if(updatadata='Editvalue') then

						select count(*) into tmpcount from my_sorderd where rdocno=sodocno;

						WHILE i  <=tmpcount DO

						    select stockid,qty,tr_no,psrno into tmpstkid,detqty,dtrno,dpsrno from my_sorderd where rdocno=sodocno and stockid not in(tmpstkids) group by stockid limit 1;

						    select (rsv_qty) into prdqty  from my_prddin where stockid=tmpstkid and psrno=dpsrno;

						    set dtmpqty=prdqty-detqty;

						    if(dtmpqty<0) then
						     set  dtmpqty=0;
						    end if;

						    update my_prddin set rsv_qty=dtmpqty where stockid=tmpstkid and psrno=dpsrno;
						    delete from my_prddout where stockid=tmpstkid and psrno=dpsrno and tr_no=dtrno;
						    SET  tmpstkids = CONCAT(tmpstkids,tmpstkid,',');
						    SET  i = i + 1;


						  END WHILE;












						delete from my_sorderd where rdocno=sodocno;

						delete from my_sordser where rdocno=sodocno;

						delete from my_trterms where rdocno=sodocno and dtype=doctype;
						    end if;
									*/
						
						

	/*					String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
								+ "'"+(prod[12].trim().equalsIgnoreCase("undefined")|| prod[12].trim().equalsIgnoreCase("null") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined")|| prod[10].trim().equalsIgnoreCase("null")|| prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("null")|| prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("null")|| prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("null")|| prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("null")|| prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("null")|| prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("null")|| prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("null")|| prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("null")|| prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("null")|| prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";

						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);*/

						prodet=1;
						if(prodet>0)
						{

			/*				String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined")|| prod[2].trim().equalsIgnoreCase("null") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							
							String qtyss=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"";
							double masterqty1=Double.parseDouble(qtyss);
							 double oldqty=Double.parseDouble(""+(prod[13].equalsIgnoreCase("undefined") || prod[13].equalsIgnoreCase("") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].isEmpty()?0:prod[13].trim())+"");
							 masterqty1=(masterqty1-oldqty)+masterqty;
								double foc=Double.parseDouble(""+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].trim().equalsIgnoreCase("")|| prod[16].isEmpty()?0:prod[16].trim())+"");
							int method=0;
							String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
							ResultSet rsconfiq=stmt.executeQuery(chk); 
							if(rsconfiq.next())
							{

								method=rsconfiq.getInt("method");
							}
							*/

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined")|| prod[2].trim().equalsIgnoreCase("null") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							
							String qtyss=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"";
							double masterqty1=Double.parseDouble(qtyss);
							 double oldqty=Double.parseDouble(""+(prod[13].equalsIgnoreCase("undefined") || prod[13].equalsIgnoreCase("") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].isEmpty()?0:prod[13].trim())+"");
							 masterqty1=(masterqty1-oldqty)+masterqty;
								double foc=Double.parseDouble(""+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].trim().equalsIgnoreCase("")|| prod[16].isEmpty()?0:prod[16].trim())+"");
					
							
							
				    		
					         String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
							    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							     
						    	 
						         
							     double fr=1;
							     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
							     
							   System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
					    	 
							
							
							
							 double expenxetotal=0;
						     double resultexptotal=0;
						     double totalpriceallqty=0;
						     
						     double costprice=0;
						     String  qtychk=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
						    	//String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						    	 
						    	 
							     double chkqty=Double.parseDouble(qtychk);
                          String gridnettotals=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";
				    	 
				    	 double gridnettotal=Double.parseDouble(gridnettotals);
				    	// Double.parseDouble(nettotal);
				    	// System.out.println("--gridnettotal---"+gridnettotal);
				    	 expenxetotal=Double.parseDouble(servamt);
				    	 
				    	 if(expenxetotal>0)
				    	 {
					//	 System.out.println("--expenxetotal---"+expenxetotal);
				    	 resultexptotal=(expenxetotal/Double.parseDouble(nettotal))*gridnettotal;
				    	// System.out.println("--resultexptotal---"+resultexptotal);
				    	 totalpriceallqty=gridnettotal+resultexptotal;
				    	// System.out.println("--totalpriceallqty---"+totalpriceallqty);
				    	 costprice=totalpriceallqty/chkqty;
				    	// System.out.println("--costprice---"+costprice);
				    	 }
				    	 else
				    	 {
				    		 
				    		 costprice=gridnettotal/chkqty;
				    		 
				    	 }
 
					 

								String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno,fr)VALUES"
										+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
										+ "'"+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
										+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
										+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
										+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
										+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
										+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
										+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
										+ "'"+(prod[17].trim().equalsIgnoreCase("undefined") || prod[17].trim().equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[17].isEmpty()?0:prod[17].trim())+"',"
										+ "'"+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[18].isEmpty()?0:prod[18].trim())+"',"
										+ "'"+(prod[19].trim().equalsIgnoreCase("undefined") || prod[19].trim().equalsIgnoreCase("") || prod[19].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[19].isEmpty()?0:prod[19].trim())+"', "
										+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"'  , "
									+ "'"+(prod[21].trim().equalsIgnoreCase("undefined") || prod[21].trim().equalsIgnoreCase("") || prod[21].trim().equalsIgnoreCase("NaN")|| prod[21].isEmpty()?0:prod[21].trim())+"',"+fr+" )";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);



 
/*
							 
							if(method>0){
								
								
	                            String taxper1=""+(prod[17].equalsIgnoreCase("undefined") || prod[17].equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| prod[17].isEmpty()?0:prod[17].trim())+"";
	                            
	                            double taxper=0;
	                            double taxamount=0;
	                            
								double delqtys=0;
								double balstkqty=0;
								int psrno=0;
								double ckkqty=0;
								int stockid=0;
								double remstkqty=0;
								double outstkqty=0;
								double stkqty=0;
								double qty=0;
								double detqty=0;
								double focmasterqty=0.0;
								Statement stmtstk=conn.createStatement();

								String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,rsv_qty as qty,date from my_prddin "
										+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

								System.out.println("=stkSql======11=======inside insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {


									balstkqty=rsstk.getDouble("balstkqty");
									psrno=rsstk.getInt("psrno");
									outstkqty=rsstk.getDouble("out_qty");
									stockid=rsstk.getInt("stockid");
									stkqty=rsstk.getDouble("stkqty");
									qty=rsstk.getDouble("qty");

									System.out.println("---focmasterqty-----"+focmasterqty);	
									System.out.println("---balstkqty-----"+balstkqty);	
									System.out.println("---out_qty-----"+outstkqty);	
									System.out.println("---stkqty-----"+stkqty);
									System.out.println("---qty-----"+qty);

									focmasterqty=masterqty+foc;
									if(remstkqty>0)
									{

										focmasterqty=remstkqty;
									}
									   ckkqty=focmasterqty;

									if(focmasterqty<=balstkqty)
									{
										
										focmasterqty=focmasterqty+qty;
										
										detqty=masterqty;
										String sqls="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
										System.out.println("--1---sqls---"+sqls);
										stmt.executeUpdate(sqls);
										//break;
										delqtys=focmasterqty-qty;
										focmasterqty=ckkqty-focmasterqty-qty;

									}
									else if(masterqty>balstkqty)
									{



										if(stkqty>=(masterqty+outstkqty))

										{
											balstkqty=masterqty+qty;	
											remstkqty=stkqty-outstkqty;

											System.out.println("---balstkqty-1---"+balstkqty);
										}
										else
										{
											remstkqty=masterqty-balstkqty;
											balstkqty=stkqty-outstkqty+qty;

											System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);
										}
										detqty=stkqty-outstkqty;

										String sqls="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										delqtys=detqty;
										//remstkqty=masterqty-stkqty;



									}

									System.out.println("-detqty--asdasd-"+detqty);
									System.out.println("-delqtys---asdasdasd ==="+delqtys);

									double NtWtKG=0.0;
									double KGPrice=0.0;
									double unitprice=0.0;
									double total=0.0;
									double discper=0.0;
									double discount=0.0;
									double netotal=0.0;
									Double nettaxamount=0.0;
									NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
									KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
									total=delqtys*unitprice;
						 
									
									discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									discount=(total*discper)/100;
									netotal=total-discount;

					 

									
									 if(taxmethod>0)
									  {
								         taxper=Double.parseDouble(taxper1);
				                           taxamount=netotal*(taxper/100);
				                           nettaxamount=netotal+taxamount; 
									  }
			 

 
									

									String sql11="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno)VALUES"
											+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+NtWtKG+"',"
											+ "'"+KGPrice+"',"
											+ "'"+unitprice+"',"
											+ "'"+total+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+discount+"',"
											+ "'"+netotal+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"', "
											+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"'  , "
									+ "'"+(prod[21].trim().equalsIgnoreCase("undefined") || prod[21].trim().equalsIgnoreCase("") || prod[21].trim().equalsIgnoreCase("NaN")|| prod[21].isEmpty()?0:prod[21].trim())+"' )";
									System.out.println("branchper--->>>>Sql"+sql11);
									prodet = stmt.executeUpdate (sql11);


									String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price,date) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice+"','"+date+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);

									if(focmasterqty<=0)
									{
										
										System.out.println("--2--");
										break;
									}


								}
*/
								
								  if(method>0){
								
								
	                            String taxper1=""+(prod[17].equalsIgnoreCase("undefined") || prod[17].equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| prod[17].isEmpty()?0:prod[17].trim())+"";
	                        	masterqty=masterqty*fr;
	                            double taxper=0;
	                            double taxamount=0;
	                            
								double delqtys=0;
								double balstkqty=0;
								int psrno=0;
								double ckkqty=0;
								int stockid=0;
								double remstkqty=0;
								double outstkqty=0;
								double stkqty=0;
								double qty=0;
								double detqty=0;
								double focmasterqty=0.0;
								Statement stmtstk=conn.createStatement();

								String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty ,rsv_qty as qty,date from my_prddin "
										+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"'   and brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

								System.out.println("=stkSql======11=======inside insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {


									balstkqty=rsstk.getDouble("balstkqty");
									psrno=rsstk.getInt("psrno");
									outstkqty=rsstk.getDouble("out_qty");
									stockid=rsstk.getInt("stockid");
									stkqty=rsstk.getDouble("stkqty");
									qty=rsstk.getDouble("qty");

									System.out.println("---focmasterqty-----"+focmasterqty);	
									System.out.println("---balstkqty-----"+balstkqty);	
									System.out.println("---out_qty-----"+outstkqty);	
									System.out.println("---stkqty-----"+stkqty);
									System.out.println("---qty-----"+qty);

									focmasterqty=masterqty+foc;
									if(remstkqty>0)
									{

										focmasterqty=remstkqty;
									}
									   ckkqty=focmasterqty;

									if(focmasterqty<=balstkqty)
									{
										
										focmasterqty=focmasterqty+qty;
										
										detqty=masterqty;
										String sqls="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"   ";
										System.out.println("--1---sqls---"+sqls);
										stmt.executeUpdate(sqls);
										//break;
										delqtys=focmasterqty-qty;
										focmasterqty=ckkqty-focmasterqty-qty;

									}
									else if(masterqty>balstkqty)
									{



										if(stkqty>=(masterqty+outstkqty))

										{
											balstkqty=masterqty+qty;	
											remstkqty=stkqty-outstkqty;

											System.out.println("---balstkqty-1---"+balstkqty);
										}
										else
										{
											remstkqty=masterqty-balstkqty;
											balstkqty=stkqty-outstkqty+qty;

											/*System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);*/
										}
										detqty=stkqty-outstkqty;

										String sqls="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"   ";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										delqtys=detqty;
										//remstkqty=masterqty-stkqty;



									}

									System.out.println("-detqty--asdasd-"+detqty);
									System.out.println("-delqtys---asdasdasd ==="+delqtys);

									double NtWtKG=0.0;
									double KGPrice=0.0;
									double unitprice=0.0;
									double total=0.0;
									double discper=0.0;
									double discount=0.0;
									double netotal=0.0;
									Double nettaxamount=0.0;
									NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
									KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
									total=delqtys*unitprice;
						 
									
									discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									discount=(total*discper)/100;
									netotal=total-discount;

									/*System.out.println("==NtWtKG===="+NtWtKG);

									 System.out.println("==KGPrice===="+KGPrice);

									 System.out.println("==unitprice===="+unitprice);

									 System.out.println("==total===="+total);

									 System.out.println("==discper===="+discper);

									 System.out.println("==discount===="+discount);

									 System.out.println("==netotal===="+netotal);*/

									
									 if(taxmethod>0)
									  {
								         taxper=Double.parseDouble(taxper1);
				                           taxamount=netotal*(taxper/100);
				                           nettaxamount=netotal+taxamount; 
									  }
			 

 
									
/*
									String sql="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount)VALUES"
											+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+NtWtKG+"',"
											+ "'"+KGPrice+"',"
											+ "'"+unitprice+"',"
											+ "'"+total+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+discount+"',"
											+ "'"+netotal+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"', "
											+ "'"+(prod[20].trim().equalsIgnoreCase("undefined") || prod[20].trim().equalsIgnoreCase("") || prod[20].trim().equalsIgnoreCase("NaN")|| prod[20].isEmpty()?0:prod[20].trim())+"' )";

									System.out.println("branchper--->>>>Sql"+sql);
									prodet = stmt.executeUpdate (sql);
*/

									String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price,date) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+delqtys+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice/fr+"','"+date+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);

									if(focmasterqty<=0)
									{
										
										System.out.println("--2--");
										break;
									}


								}


			/*					double balstkqty=0;
								int psrno=0;
								int stockid=0;
								double remstkqty=0;
								double outstkqty=0;
								double stkqty=0;
								double qty=0;
								double detqty=0;
								Statement stmtstk=conn.createStatement();

								String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,rsv_qty as qty,date from my_prddin "
										+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

								System.out.println("=stkSql======11=======inside insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {


									balstkqty=rsstk.getDouble("balstkqty");
									psrno=rsstk.getInt("psrno");
									outstkqty=rsstk.getDouble("out_qty");
									stockid=rsstk.getInt("stockid");
									stkqty=rsstk.getDouble("stkqty");
									qty=rsstk.getDouble("qty");

									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balstkqty-----"+balstkqty);	
									System.out.println("---out_qty-----"+outstkqty);	
									System.out.println("---stkqty-----"+stkqty);
									System.out.println("---qty-----"+qty);



									if(remstkqty>0)
									{

										masterqty=remstkqty;
									}


									if(masterqty<=balstkqty)
									{
										detqty=masterqty;
										masterqty=masterqty+qty;
										

										String sqls="update my_prddin set rsv_qty="+masterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
										System.out.println("--1---sqls---"+sqls);
										stmt.executeUpdate(sqls);
										//break;


									}
									else if(masterqty>balstkqty)
									{



										if(stkqty>=(masterqty+outstkqty))

										{
											balstkqty=masterqty+qty;	
											remstkqty=stkqty-outstkqty;

											System.out.println("---balstkqty-1---"+balstkqty);
										}
										else
										{
											remstkqty=masterqty-balstkqty;
											balstkqty=stkqty-outstkqty+qty;

											System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);
										}
										detqty=stkqty-outstkqty;

										String sqls="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remstkqty=masterqty-stkqty;



									}



									Double NtWtKG=0.0;
									Double KGPrice=0.0;
									Double unitprice=0.0;
									Double total=0.0;
									Double discper=0.0;
									Double discount=0.0;
									Double netotal=0.0;

									NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
									KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
									unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
									total=detqty*unitprice;
									discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									discount=(total*discper)/100;
									netotal=total-discount;

		 

									String sql1="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
											+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+NtWtKG+"',"
											+ "'"+KGPrice+"',"
											+ "'"+unitprice+"',"
											+ "'"+total+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+discount+"',"
											+ "'"+netotal+"')";

									System.out.println("branchper--->>>>Sql"+sql1);
									prodet = stmt.executeUpdate (sql1);


									String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0,'"+costprice+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);

							 //	if(masterqty<=balstkqty)
								//	{
									//	break;
								//	}
 
									if(masterqty<=0)
									{
										
										System.out.println("--2--");
										break;
									}
								}


*/


							}


							if(rreftype.equalsIgnoreCase("SQOT"))
							{
								Statement stmt2=conn.createStatement();
								 int pridforchk=Integer.parseInt(prdid);
						    	 
									String amount=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")||prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
									  
									   
									   
									String discper=""+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("NaN")||prod[15].trim().equalsIgnoreCase("")|| prod[15].isEmpty()?0:prod[15].trim())+"";
									    
						   		 
									 System.out.println("---amount--"+amount);
									 System.out.println("---discper--"+discper);
									
					    		/* if(pridforchk!=updateid)
					    		 {*/
					    		 
					 			String sqls5="update  my_qotd set out_qty=0 where rdocno in ("+qotmasterdocno+") and prdid="+pridforchk+"  and amount='"+amount+"' and disper='"+discper+"' and doc_no not in("+rownochk+")  and clstatus=0  and specno="+specno+" and unitid="+unitidss+"  ";
			  
			    			   System.out.println("-----"+sqls5);
			    			   	
					 			stmt2.executeUpdate(sqls5);
			    				
			    				updateid=pridforchk;
					    		 
					    		/* }*/
			    				
								
								
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_qotm m  left join "
										+ "my_qotd d on m.doc_no=d.rdocno where  d.clstatus=0 and  d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+"  and d.specno="+specno+" and d.unitid="+unitidss+" and d.amount='"+amount+"' and d.disper='"+discper+"' and d.prdid='"+prdid+"'and d.doc_no not in("+rownochk+") group by d.doc_no      "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qty=rs.getDouble("qty");

									System.out.println("---masterqty1-----"+masterqty1);	

									System.out.println("---balqty-----"+balqty);	

									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qty-----"+qty);
									rownochk=rownochk+","+docno;

									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{
										masterqty1=masterqty1+out_qty;


										String sqls="update my_qotd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"  and clstatus=0 and specno="+specno+" and unitid="+unitidss+" ";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{



										if(qty>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qty-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qty;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_qotd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"  and clstatus=0 and specno="+specno+" and unitid="+unitidss+" ";
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_sordser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+(sorderarray[7].trim().equalsIgnoreCase("undefined") || sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()?0:sorderarray[7].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+sodocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}



				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sodocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}
				
				
				
				
				
				
				
				
				
				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+sodocno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmt.executeUpdate(shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_sorderm set shipdetid='"+shipdocno+"' where doc_no='"+sodocno+"' ";
				
				stmt.executeUpdate (updatesql);
				

				
				
				


			}


			 
			  
		}
			
			
			if(sodocno>0)
			{
				conn.commit();		
				return sodocno;
			}
			
			
		}	
		
		catch(Exception e){
			sodocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return sodocno;
	}

	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper) throws SQLException{

		Connection conn=null;
		int sodocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,rrefno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(nettotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23, Integer.parseInt(pricegroup));
			stmt.setInt(24,doc_no);
			stmt.setInt(25,Integer.parseInt(voc_no));
			stmt.setInt(26,0);
			stmt.setString(27,"0" );
			
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");	
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			/*			if(vocno>0){

				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						String sql="insert into my_sorderd(sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+(i+1)+",'"+sodocno+"',"
								+ "'"+(prod[12].equalsIgnoreCase("undefined")|| prod[12].equalsIgnoreCase("null") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
								+ "'"+(prod[10].equalsIgnoreCase("undefined")|| prod[10].equalsIgnoreCase("null") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("null")|| prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("null")|| prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("null")|| prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("null")|| prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("null")|| prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("null")|| prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("null")|| prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("null")|| prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("null")|| prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";


						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);


						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined")|| prod[2].trim().equalsIgnoreCase("null") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							if(rreftype.equalsIgnoreCase("SQOT"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_qotm m  left join "
										+ "my_qotd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qty=rs.getDouble("qty");

									System.out.println("---masterqty-----"+masterqty);	

									System.out.println("---balqty-----"+balqty);	

									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qty-----"+qty);


									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										String sqls="update my_qotd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qty>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qty-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty-balqty;
											balqty=qty;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_qotd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_sordser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+sodocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}


				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sodocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}


			}*/



			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return sodocno;
	}


	public   JSONArray reloadserviceGrid(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			String pySql=("select srno,desc1 description,unitprice,qty,total,discount,nettotal,acno,coalesce(h.description,'') as account from my_sordser s left join my_head h on(s.acno=h.doc_no)  where s.rdocno='"+docno+"' ");
		//	System.out.println("========"+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
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


	 public    ClsSalesOrderBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsSalesOrderBean bean = new ClsSalesOrderBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();  

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
	        	
/*				String resql=("select m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='CEQ','Sales Enquiry','Sales Quotation')) type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_qotm m left join my_head h on h.doc_no=m.acno   where   m.doc_no='"+docno+"'");
				*/
				
				String resql=("select coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno,if(m.ref_type='DIR','Direct','Sales Quotation') type, "
						+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
						+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
				+ "  from my_sorderm m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id   where   m.doc_no='"+docno+"'");
				
				
				 System.out.println("====resql=2="+resql);
					
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    
			    	    
			    	    bean.setLblsalesPerson(pintrs.getString("sal_name"));
			    	 //   bean.setExpdeldate(pintrs.getString("deldate"));
			    	    
		/*	    	 
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			            
			    	    bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    */
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_sorderm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   
				    	   
				       } 
				     stmt10.close();
				       
				     double total=0;
				     double grndtotal=0;
				     double srvtotal=0;
				     Statement stmtgrid3 = conn.createStatement ();      
				     String	strSqldetail1="select round(sum(nettotal),2) nettotal  from my_sorderd   where rdocno='"+docno+"'";
					 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
				 
						if(rsdetail1.next()){
							
							total=rsdetail1.getDouble("nettotal");
							bean.setLbltotal(total+"");
							grndtotal+=total;
						}
						
						// System.out.println("====grndtotal=2="+grndtotal);
						
						 Statement stmtgrid4 = conn.createStatement (); 	 
						 String	strSqldetail4="select round(sum(nettotal),2) nettotal  from my_sordser   where rdocno='"+docno+"'";
						 
						// System.out.println("====strSqldetail4=="+strSqldetail4);
						 
						 ResultSet rsdetail4=stmtgrid4.executeQuery(strSqldetail4);
					 
							if(rsdetail4.next()){
								
								srvtotal=rsdetail4.getDouble("nettotal");
								   bean.setLblsubtotal(srvtotal+"");
								   grndtotal+=srvtotal;
							     }
						//	 System.out.println("====grndtotal=3="+grndtotal);
							
							 bean.setLblordervaluewords(c.convertAmountToWords(grndtotal+""));
					    	 bean.setLblordervalue(grndtotal+"");
							
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_sorderd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") ;
							arr.add(temp);
							rowcount++;
			
							bean.setFirstarray(1);
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					
					
					
					
					
					   
				     ArrayList<String> arr2 =new ArrayList<String>();
				   	 Statement stmtgrid2 = conn.createStatement ();       
				     String temp2="";  
				       String	strSqldetail2="select srno,desc1 description,round(unitprice,2)  unitprice,round(qty,2) qty,round(total,2) total,round(discount,2)"
				       		+ " discount ,round(nettotal,2) nettotal from my_sordser     where rdocno='"+docno+"'";
					
			
					ResultSet rsdetail2=stmtgrid2.executeQuery(strSqldetail2);
					
					int rowcounts=1;
			
					while(rsdetail2.next()){

							 
							 
						temp2=rowcounts+"::"+rsdetail2.getString("description")+"::"+rsdetail2.getString("qty")+"::"+
							rsdetail2.getString("unitprice")+"::"+rsdetail2.getString("total")+"::"+rsdetail2.getString("discount")+"::"+
						    rsdetail2.getString("nettotal") ;
							arr2.add(temp2);
							rowcounts++;
			
							bean.setSecarray(2);
						
				          }
				             
					request.setAttribute("subdetails", arr2);
					stmtgrid2.close();
					 
					
					
					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
		public   JSONArray deldetailsSearch() throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 


				String sql="select doc_no,desc1 from  my_deldetailm where status=3; ";
				// System.out.println("-----sql---"+sql);

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
		
		public   JSONArray reloadshipSearch(HttpSession session,String masterdocno,String formcode) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 


				String sql="select   refdocno doc_nos, desc1, refno, date from  my_deldetaild where status=3 and rdocno='"+masterdocno+"' and dtype='"+formcode+"' ";
			  System.out.println("-----sql---"+sql);

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
		

		public JSONArray shipsearchFrom(String clname,String mob) throws SQLException {


			JSONArray RESULTDATA=new JSONArray();  

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();     
				String sqltest="";

				if(!(clname.equalsIgnoreCase(""))){
					sqltest=sqltest+" and if(m.type=0,m.clname,ac.refname) like '%"+clname+"%'";
				}
				if(!(mob.equalsIgnoreCase(""))){
					sqltest=sqltest+" and m.mob like '%"+mob+"%'";
				}

		 
				String sql=" select m.doc_no,m.type,m.cldocno,if(m.type=0,m.clname,ac.refname) clname, m.claddress,m.contactperson, m.tel, "
						+ " m.mob, m.email, m.fax from my_shipdetails m  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'  "
						+ " where  m.status=3 and m.type>0  " +sqltest;
	 
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);


			}catch(Exception e){
				e.printStackTrace();

			}finally{
				conn.close();
			}
			return RESULTDATA;
		}



}

