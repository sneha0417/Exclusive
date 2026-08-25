package com.sales.marketing.salesquotation;

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
import com.procurement.purchase.purchaseorder.ClspurchaseorderBean;
 

public class ClsSalesQuotationDAO {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	ClsSalesQuotationBean bean= new ClsSalesQuotationBean();
	
	
	
	public   JSONArray hidesearchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftypes,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		System.out.println("----reftypes---"+reftypes);
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			Statement stmt1 = conn.createStatement ();
			
			int pricemgt=0;
			 
			String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rs3=stmt1.executeQuery(chk3); 
			if(rs3.next())
			{

				pricemgt=rs3.getInt("method");
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
						
						
					/*joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
					
					
					}
					
				}
				
			 
				int discountset=0;
				String chk311="select method  from gl_prdconfig where field_nme='discountset'";
				ResultSet rs31=stmt1.executeQuery(chk311); 
				if(rs31.next())
				{

					discountset=rs31.getInt("method");
				}
			 
				 
			
			String sql="";
			if(reftypes.equalsIgnoreCase("DIR"))
			{ 
				
				  String brchid=session.getAttribute("BRANCHID").toString();
				
				
				if(pricemgt>0)
				{
					sql="select "+fsql+" "+discountset+" discountset,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
							+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+clientcaid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.=pr.catid)) " 
							+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' and pr.discount1 is not null group by m.doc_no  ";
					
		 

					ResultSet resultSet = stmt.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmt.close();
					
				}
				else
				{
				sql="select "+fsql+" bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
						+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";
				
	 

				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				}
			}
			else{
				 
		
				if(reftypes.equalsIgnoreCase("CEQ"))
				{
					
					
					if(pricemgt>0)
					{
						
 
						sql="select "+outfsql+" (qty-outqty)*unitprice total,"+discountset+" discountset, (qty-outqty)*unitprice netotal,unitprice,allowdiscount,brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno from "
								+ "( select "+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
								+ "my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+clientcaid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+clientcaid+"')) "  
								+ " "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'   and pr.discount1 is not null group by psrno having sum(d.qty-d.out_qty)>0) as a ";

					 ;

						ResultSet resultSet = stmt.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmt.close();
							
					}
					else
					{
						sql="select "+outfsql+" brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno from "
								+ "( select "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
								+ "my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)"
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+")  "
										+ "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno having sum(d.qty-d.out_qty)>0) as a ";

						
						 

						ResultSet resultSet = stmt.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmt.close();
					}
					
				
				}
				
				else if(reftypes.equalsIgnoreCase("RFQ")) 
				{
					sql="select "+outfsql+" brandname,specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,(qty-outqty) totqty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno,discper,"
							+ " total,dis,netotal,unitprice from "
							+ " (select "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname, "
							+ " u.unit,u.doc_no unitdocno , d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
							+ " from my_prfqm ma left join  my_prfqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no)  "
							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "+joinsql+"  where d.clstatus=0 and ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+rdoc+") group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno) as a ";
			 

					ResultSet resultSet = stmt.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmt.close();

				}
			}

			
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
 
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftypes,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		System.out.println("----reftypes---"+reftypes);
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			Statement stmt1 = conn.createStatement ();
			
			int pricemgt=0;
			 
			String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rs3=stmt1.executeQuery(chk3); 
			if(rs3.next())
			{

				pricemgt=rs3.getInt("method");
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
						
/*						
					joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				
			 
				int discountset=0;
				String chk311="select method  from gl_prdconfig where field_nme='discountset'";
				ResultSet rs31=stmt1.executeQuery(chk311); 
				if(rs31.next())
				{

					discountset=rs31.getInt("method");
				}
			 
				 
				int mulqty=0;
				Statement stmt31 = conn.createStatement (); 
			 
				String chk3111="select method  from gl_prdconfig where field_nme='multiqty' ";
				ResultSet rss31=stmt31.executeQuery(chk3111); 
				if(rss31.next())
				{

					mulqty=rss31.getInt("method");
				}
				
				String joinsqls="";
				String joinsqls1="";
				 
				if(mulqty>0)
				{
					joinsqls=" ,unitid,specno ";
					
					  joinsqls1=",d.unitid,d.specno";
				 
					
					 
					 
					
				}
				
			String sql="";
			if(reftypes.equalsIgnoreCase("DIR"))
			{ 
				
				
				int superseding=0;
				String chk1="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs1=stmt1.executeQuery(chk1); 
				if(rs1.next())
				{
					
					superseding=rs1.getInt("method");
				}
				
				
				
				
				
				  String brchid=session.getAttribute("BRANCHID").toString();
				
				
				if(pricemgt>0)
				{
					
					
					if(superseding==1)
					{
			 
						sql=" select s.part_no,m.* from (  select "+fsql+" "+discountset+" discountset,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
								+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+clientcaid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+clientcaid+"' )) " 
								+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' group by m.doc_no ) "
								+ "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
						//System.out.println("==1==sql==="+sql);
						
					}
					else
					{
						
						sql="select "+fsql+" "+discountset+" discountset,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
								+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+clientcaid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+clientcaid+"' )) " 
								+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' group by m.doc_no ";
						
						//System.out.println("====sql==="+sql);
						
					}
					
					
			
					
				}
				else
				{
					if(superseding==1)
					{
					
				sql=" select s.part_no,m.* from ( select "+fsql+" bd.brandname,at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
						+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' )  "
						+ "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
				
				//System.out.println("==2==sql==="+sql);
					}
					
					else
					{
						
						sql="select "+fsql+" bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty  from my_main m "
								+ "  left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";
						
					//	System.out.println("====sql==="+sql);
						
					}
			
				
				
				}
			
			
			
			
			}
			else{
				 
		
				if(reftypes.equalsIgnoreCase("CEQ"))
				{
					
					
					if(pricemgt>0)
					{
						
						
			/*			pySql="select  (qty-outqty)*unitprice total, (qty-outqty)*unitprice netotal,unitprice,allowdiscount,brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno from "
								+ "( select case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_cusenqm ma left join "
								+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.catid=pr.catid)) " 
								+ " where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
		
						*/
						
						sql="select "+outfsql+" (qty-outqty)*unitprice total,"+discountset+" discountset, (qty-outqty)*unitprice netotal,unitprice"+joinsqls+",allowdiscount,brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno from "
								+ "( select d.unitid,d.specno,"+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
								+ "my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+clientcaid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+clientcaid+"')) "  
								+ " "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno"+joinsqls+" having sum(d.qty-d.out_qty)>0) as a ";

							
					}
					else
					{
					/*	sql="select "+outfsql+" brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno from "
								+ "( select "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
								+ "my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)"
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+")  "
										+ "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno having sum(d.qty-d.out_qty)>0) as a ";

						*/
						sql="select "+outfsql+" brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size"+joinsqls+",part_no,productid,productname,unit,unitdocno from "
								+ "( select  d.unitid,d.specno, "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
								+ "my_cusenqm ma left join my_cusenqd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)"
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+")  "
										+ "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno"+joinsqls+" having sum(d.qty-d.out_qty)>0) as a ";

							
							
					}
					
				
				}
				
				else if(reftypes.equalsIgnoreCase("RFQ")) 
				{
//					sql="select "+outfsql+" brandname,specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,(qty-outqty) totqty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno,discper,"
//							+ " total,dis,netotal,unitprice from "
//							+ " (select "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname, "
//							+ " u.unit,u.doc_no unitdocno , d.amount unitprice,((qty-out_qty)*d.amount) total, "
//							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
//							+ " from my_prfqm ma left join  my_prfqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no)  "
//							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "+joinsql+"  where d.clstatus=0 and ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+rdoc+") group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno) as a ";
//
//					
					sql="select "+outfsql+" brandname"+joinsqls+",specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,(qty-outqty) totqty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno,discper,"
							+ " total,dis,netotal,unitprice from "
							+ " (select "+fsql+" bd.brandname,  d.unitid,d.specno,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname, "
							+ " u.unit,u.doc_no unitdocno , d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
							+ " from my_prfqm ma left join  my_prfqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no)  "
							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "+joinsql+"  where d.clstatus=0 and ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+rdoc+") group by  d.psrno"+joinsqls1+",d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno) as a ";



				}
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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid,String cmbreftype) throws SQLException {

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

			
			if(cmbreftype.equalsIgnoreCase("CEQ"))
			{
				String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_cusenqm m left join   my_acbook ac on(m.clientid=ac.doc_no and ac.dtype='CRM') left join my_cusenqd d on(d.rdocno=m.doc_no)  where   m.status=3 and m.clientid='"+clientid+"'  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
				 
				System.out.println("====pySql===="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);	
			}
			else if(cmbreftype.equalsIgnoreCase("RFQ"))
			{
				String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.refno,m.voc_no,m.date,0 as chk,h.description client from my_prfqm m   left join my_prfqd d on(d.rdocno=m.doc_no) left join my_head h on h.doc_no=m.acno  where d.clstatus=0 and m.status=3    and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
				 
				System.out.println("====pySql===="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			 

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


		System.out.println("==searchMaster===");

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
		if(!(Cl_mobnos.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+Cl_mobnos+"%'";
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

		if(!(Cl_clientsale1.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale1+"%'";
		}

		 


		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement (); 

			String clssql= ("select  ac.per_mob,sa.doc_no saldocno,sa.sal_name,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,m.ref_type,rrefno from my_qotm m  "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sa on sa.doc_no=ac.sal_id and   ac.dtype='CRM' where m.brhid="+brid+" and m.status "+sqltest+"");
			System.out.println("====searchmaster===="+clssql);
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

	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno from "
					+ "( select at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
					+ "my_cusenqd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
			System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String redtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			System.out.println("===DIR=="+redtype);
			if(redtype.equalsIgnoreCase("DIR"))
			{
				enqdoc="0";	
			}
			
			else{
				
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
			
			String joinselect="";
			String injoinsqls="";
			String sorjoinsqls="";
			if(mulqty>0)
			{
				
				injoinsqls=" and unitid=d.unitid and specno=d.specno  ";
				joinselect= " ,unitid,specno ";
				joinsqls=" ,d.unitid,d.specno  ";
				sorjoinsqls=" and aa.unitid=d.unitid and aa.specno=d.specno  ";
				
			}
			if(redtype.equalsIgnoreCase("DIR") || redtype.equalsIgnoreCase("CEQ"))
			{
			
/*			String sql="select  taxdocno,taxper,taxperamt,taxamount,clstatus,brandname,specid,psrno as doc_no,rdocno,psrno,psrno as prodoc,(totqty-outqty)+qty totqty,qty as oldqty,qty qty,outqty,(totqty-outqty) as balqty,part_no,productid,"
					+ "productid as proid,productname,productname as proname,unit,unitdocno,NtWtKG totwtkg, KGPrice kgprice,amount unitprice, total,disper discper,"
					+ " discount dis,nettotal netotal,allowdiscount from ( select d.clstatus,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,(select coalesce(sum(qty),0) from  my_cusenqd "
					+ " where rdocno in ("+enqdoc+") and prdid=d.prdid) as totqty,(select coalesce(sum(out_qty),0) from  my_cusenqd  where rdocno in ("+enqdoc+") and prdid=d.prdid) as outqty,"
					+ "d.qty ,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno, NtWtKG, KGPrice,amount, total, "
					+ " disper,discount,nettotal,d.taxper,d.taxamount  taxperamt ,d.nettaxamount taxamount,d.allowdiscount,d.taxdocno from my_qotd d   "
					+ " left join  my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno ) as a ";

			*/
			String sql="select  taxdocno,taxper "+joinselect+",taxperamt,taxamount,clstatus,brandname,specid,psrno as doc_no,rdocno,psrno,psrno as prodoc,(totqty-outqty)+qty totqty,qty as oldqty,(outqty-qty) as pqty,qty qty,outqty,(totqty-outqty) as balqty,part_no,productid,"
					+ "productid as proid,productname,productname as proname,unit,unitdocno,NtWtKG totwtkg, KGPrice kgprice,amount unitprice, total,disper discper,"
					+ " discount dis,nettotal netotal,allowdiscount from ( select  d.clstatus"+joinsqls+",bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,"
							+ "(select coalesce(sum(qty),0) from  my_cusenqd "
					+ " where rdocno in ("+enqdoc+") and prdid=d.prdid "+injoinsqls+" ) as totqty,(select coalesce(sum(out_qty),0) from "
							+ "  my_cusenqd  where rdocno in ("+enqdoc+") and prdid=d.prdid "+injoinsqls+") as outqty,"
					+ "d.qty ,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno, NtWtKG, KGPrice,amount, total, "
					+ " disper,discount,nettotal,d.taxper,d.taxamount  taxperamt ,d.nettaxamount taxamount,d.allowdiscount,d.taxdocno from my_qotd d   "
					+ " left join  my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno"+joinselect+" ) as a ";

			//System.out.println("===prdGridReload===11111=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			
			else if(redtype.equalsIgnoreCase("RFQ"))
			{
	/*			String sql="select  taxdocno,taxper,taxperamt,taxamount,brandname,clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
						+ "  balqty,0 size,part_no,productid as proid,productid, "
					+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal,unitprice unitprice1,discper disper1 "
					+ " from (select clstatus, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys-qty  as "
					+ " balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
					+ " dis, netotal from ( select bd.brandname,d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,(aa.qty-aa.out_qty)+sum(d.qty)  "
					+ " as qtys,aa.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG "
					+ " totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper, d.discount dis,d.nettotal netotal,d.taxper,d.taxamount taxperamt ,d.nettaxamount taxamount ,d.taxdocno "
					+ " from my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
					+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "   left join (select sum(qty) qty,sum(out_qty) out_qty, psrno,rdocno,specno,prdid,amount,disper from my_prfqd where rdocno in("+enqdoc+") "
					+ " 	and clstatus=0 group by  psrno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper "
				+ " 	where m.status=3 	and d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid,aa.amount,aa.disper  ) as a) as b " ;*/
				
				String sql="select  taxdocno,taxper,taxperamt,taxamount,brandname"+joinselect+",clstatus,0 method,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,qty as pqty,outqty, "
						+ "  balqty,0 size,part_no,productid as proid,productid, "
					+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal,unitprice unitprice1,discper disper1 "
					+ " from (select   clstatus"+joinselect+", stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys-qty  as "
					+ " balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
					+ " dis, netotal from ( select bd.brandname"+joinsqls+",d.clstatus,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,(aa.qty-aa.out_qty)+sum(d.qty)  "
					+ " as qtys,aa.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG "
					+ " totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper, d.discount dis,d.nettotal netotal,d.taxper,d.taxamount taxperamt ,d.nettaxamount taxamount ,d.taxdocno  "
					+ " from my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) "
					+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "   left join (select sum(qty) qty,sum(out_qty) out_qty, psrno,rdocno,specno,prdid,amount,disper from my_prfqd where rdocno in("+enqdoc+") "
					+ " 	and clstatus=0 group by  psrno,amount,disper) aa on aa.psrno=d.psrno and  aa.amount=d.amount and aa.disper=d.disper "+sorjoinsqls+" "
				+ " 	where m.status=3 	and d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid"+joinsqls+",aa.amount,aa.disper  ) as a) as b " ;
				
				//System.out.println("===prdGridReload===11111=="+sql);
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


	public JSONArray prdGridReload(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String sql="select d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,qty totqty,qty as oldqty,qty qty,out_qty outqty,qty as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ "amount unitprice, total,disper discper,discount dis,nettotal netotal from my_qotd d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno "
					+ "having sum(d.qty-d.out_qty)>0";

			System.out.println("===prdGridReload====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


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

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m  "
					+ " inner join my_termsd d on(m.voc_no=d.rdocno and  d.status=3) where m.status=3 and d.dtype='"+dtype+"' order by terms";
			System.out.println("===termsGridLoad====="+sql);
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
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public   JSONArray enqgridreload(HttpSession session,String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();      
			String pySql="";
	 

			int mulqty=0;
			Statement stmt31 = conn.createStatement (); 
		 
			String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
			ResultSet rss31=stmt31.executeQuery(chk311); 
			if(rss31.next())
			{

				mulqty=rss31.getInt("method");
			}
			
			String joinsqls="";
			if(mulqty>0)
			{
				joinsqls=",unitid,specno ";
				
			}
/*			pySql="select  brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno, "
					+ " squoteprice unitprice,(qty-outqty)*squoteprice total,'' discper,''  dis,(qty-outqty)*squoteprice netotal from "
					+ "( select  bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,bd1.netprice squoteprice from my_cusenqm ma left join "
					+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "left join my_benqps bd1 on bd1.rdocno=d.rdocno and bd1.refdocno=d.docno left join  my_brand bd on m.brandid=bd.doc_no "
					+ " where ma.status=3  and ma.doc_no in("+doc+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
*/
 pySql="select   brandname"+joinsqls+",specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno, "
		+ " squoteprice unitprice,(qty-outqty)*squoteprice total,'' discper,''  dis,(qty-outqty)*squoteprice netotal from "
		+ "( select  bd.brandname,d.unitid,d.specno,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,bd1.netprice squoteprice from my_cusenqm ma left join "
		+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
		+ "left join my_benqps bd1 on bd1.rdocno=d.rdocno and bd1.refdocno=d.docno left join  my_brand bd on m.brandid=bd.doc_no "
		+ " where ma.status=3  and ma.doc_no in("+doc+") group by psrno"+joinsqls+"  having sum(d.qty-d.out_qty)>0) as a ";


	//		System.out.println("----enqgridreload----"+pySql);



			ResultSet resultSet = stmt.executeQuery(pySql);

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

	public   JSONArray enqgridreload(HttpSession session,String doc,String reftype,String catid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			Statement stmt1 = conn.createStatement ();  
			String pySql="";
			if(doc.equalsIgnoreCase(""))
			{
				doc="0";
			}
			System.out.println("----doc----"+doc);
			if(reftype.equalsIgnoreCase("CEQ"))
			{
			int pricemgt=0;
				
				String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
				ResultSet rs3=stmt1.executeQuery(chk3); 
				if(rs3.next())
				{

					pricemgt=rs3.getInt("method");
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
							
							
					/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
						
						outfsql=outfsql+ " taxper , ";
						*/
						
							
							

							joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
									+ " t1.typeid=m.typeid   ";
						
							
							fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
							
							outfsql=outfsql+ " taxper ,taxdocno, ";
						
						}
						
					}
					
					
					
					int discountset=0;
					String chk311="select method  from gl_prdconfig where field_nme='discountset'";
					ResultSet rs31=stmt1.executeQuery(chk311); 
					if(rs31.next())
					{

						discountset=rs31.getInt("method");
					}
					int mulqty=0;
					Statement stmt31 = conn.createStatement (); 
				 
					String chk3111="select method  from gl_prdconfig where field_nme='multiqty' ";
					ResultSet rss31=stmt31.executeQuery(chk3111); 
					if(rss31.next())
					{

						mulqty=rss31.getInt("method");
					}
					
					String joinsqls="";
					if(mulqty>0)
					{
						joinsqls=" ,unitid,specno ";
						
					}
					
					
					
					if(pricemgt>0)  
					{
/*						pySql="select  "+outfsql+" "+discountset+" discountset, (qty-outqty)*unitprice total, (qty-outqty)*unitprice netotal,unitprice,round(allowdiscount,2) allowdiscount,brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno from "
								+ "( select "+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_cusenqm ma left join "
								+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) " 
								+ "   "+joinsql+"  where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";*/
		
						pySql="select   "+outfsql+" "+discountset+" discountset, (qty-outqty)*unitprice total "+joinsqls+", (qty-outqty)*unitprice netotal,unitprice,round(allowdiscount,2) allowdiscount,brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno from "
								+ "( select  d.unitid,d.specno,"+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_cusenqm ma left join "
								+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
								+ "left join  my_brand bd on m.brandid=bd.doc_no "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) " 
								+ "   "+joinsql+"  where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by psrno"+joinsqls+" having sum(d.qty-d.out_qty)>0) as a ";

						ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
					
					}
					else
					{
					
		/*	pySql="select "+outfsql+"  brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno from "
					+ "( select "+fsql+"  bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_cusenqm ma left join "
					+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join  my_brand bd on m.brandid=bd.doc_no   "+joinsql+"   where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";

			*/
			
			
			 			pySql="select   "+outfsql+"  brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty "+joinsqls+",size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno from "
					+ "( select  d.unitid,d.specno,"+fsql+"  bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_cusenqm ma left join "
					+ "my_cusenqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join  my_brand bd on m.brandid=bd.doc_no   "+joinsql+"   where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by psrno"+joinsqls+" having sum(d.qty-d.out_qty)>0) as a ";

					

						ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
					
					}
			//System.out.println("----enqgridreload----"+pySql);



			}
/*				
			else if(reftype.equalsIgnoreCase("RFQ")) 
			{
				
	 
				
				pySql="select  "+outfsql+"  brandname,specid,psrno as prodoc,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productid as proid,productname,productname as proname,unit,unitdocno,discper,"
						+ " total,dis,netotal,unitprice,unitprice unitprice1,discper disper1 from "
						+ " (select "+fsql+" bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname, "
						+ " u.unit,u.doc_no unitdocno , d.amount unitprice,((qty-out_qty)*d.amount) total, "
						+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
						+ " from my_prfqm ma left join  my_prfqd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no)  "
						+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  where d.clstatus=0 and ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+")  "
					    + " group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno) as a ";


				System.out.println("----enqgridreload----"+pySql);



				ResultSet resultSet = stmt.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			}
				
			*/
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


	public int insert(java.sql.Date date,String refno,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String netotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,
			HttpServletRequest request,String enqmasterdocno,String descper,String ordrvalue,String delterms,
			double stval, double tax1, double tax2, double tax3, double nettax,int cmbbilltype) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);
	 
			
 

			CallableStatement stmt = conn.prepareCall("{CALL saleQotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,enqmasterdocno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(netotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			int val = stmt.executeUpdate();
			sqdocno=stmt.getInt("sqdocno");
			int vocno=stmt.getInt("vdocNo");
			request.setAttribute("vdocNo", vocno);

			if(vocno<=0)
			{
				conn.close();
				return 0;
				
			}
		      
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){
				
				
				Statement st=conn.createStatement();
				String sqlss="update my_qotm set delterms='"+delterms+"' where doc_no='"+sqdocno+"' ";
				
				st.executeUpdate(sqlss);
				
				String rownochk="0";    
				int prodet=0;
				
				
				int taxmethod=0;
				 Statement stmttax=conn.createStatement();
				
				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }
 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_qotm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sqdocno+"' ";
					  
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
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							
							 	typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_qotm set typeoftax='"+typeoftax+"'    where doc_no='"+sqdocno+"' ";
								  
								 
								  
							 stmt.executeUpdate(sqltax11);						 	
						 	
						 }
					  
					  
					  
				  }
				
				
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					
					System.out.println("=============="+prodarray.get(i));
					
					
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


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



						String sql="insert into my_qotd(sr_no,rdocno,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno,fr)VALUES"
								+ " ("+(i+1)+",'"+sqdocno+"',"
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
								+ "'"+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("") || prod[15].trim().equalsIgnoreCase("NaN")|| taxmethod==0 ||  prod[15].isEmpty()?0:prod[15].trim())+"',"
								+ "'"+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[16].isEmpty()?0:prod[16].trim())+"',"
								+ "'"+(prod[17].trim().equalsIgnoreCase("undefined") || prod[17].trim().equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| taxmethod==0 ||  prod[17].isEmpty()?0:prod[17].trim())+"',"
								+ "'"+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")||   prod[18].isEmpty()?0:prod[18].trim())+"' , "
								+ "'"+(prod[19].trim().equalsIgnoreCase("undefined") || prod[19].trim().equalsIgnoreCase("") || prod[19].trim().equalsIgnoreCase("NaN")||   prod[19].isEmpty()?0:prod[19].trim())+"',"+fr+" )";

						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);

						if(prodet<=0)
						{
							conn.close();
							return 0;
							
						}
					      
                     


						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double masterqty1=Double.parseDouble(rqty);
							
						     String unitids=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
							  String spec=""+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].trim().equalsIgnoreCase("")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							   
							 
							if(rreftype.equalsIgnoreCase("CEQ"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;
								int unitid=0;
								int specno=0;
								Statement stmt1=conn.createStatement();

							/*	String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.docno,d.rdocno,d.out_qty out_qty,d.prdid  from my_cusenqm m  left join "
										+ "my_cusenqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.docno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.docno";

								*/
								
								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.docno,d.rdocno,d.out_qty out_qty,d.prdid,d.unitid,d.specno  from my_cusenqm m  left join "
										+ "my_cusenqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.unitid='"+unitids+"' and d.specno="+spec+" and d.prdid='"+prdid+"' group by d.docno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.docno";
								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("docno");
									qty=rs.getDouble("qty");
									unitid=rs.getInt("unitid");
									specno=rs.getInt("specno");

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


									//	String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";
										String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+" and unitid="+unitid+" and specno="+specno+"  ";
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

										String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+" and unitid="+unitid+" and specno="+specno+"  ";
										//String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}
							
							

						     
						     
							else if(rreftype.equalsIgnoreCase("RFQ"))
					         {
						    	
								
								String amount=""+(prod[13].trim().equalsIgnoreCase("undefined") || prod[13].trim().equalsIgnoreCase("NaN")||prod[13].trim().equalsIgnoreCase("")|| prod[13].isEmpty()?0:prod[13].trim())+"";
								  
								   
								   
								String discper=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")||prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
								    
								   System.out.println("-amount---"+amount);
								   System.out.println("-discper---"+discper);
								
								
								
								
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;
								
								int unitid=0;
								int specno=0;

								Statement stmt1=conn.createStatement();

							/*	String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_prfqm m  left join "
										+ "my_prfqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and d.clstatus=0 and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.rowno not in("+rownochk+") and   d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.rowno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.rowno";
*/
							
								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid,d.unitid,d.specno  from my_prfqm m  left join "
										+ "my_prfqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and d.clstatus=0 and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.unitid='"+unitids+"' and d.specno="+spec+" and d.rowno not in("+rownochk+") and   d.amount='"+amount+"' and d.disper='"+discper+"'  group by d.rowno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.rowno";

								
								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");
									
									unitid=rs.getInt("unitid");
									specno=rs.getInt("specno");


									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);

									rownochk=rownochk+","+docno;
									if(remqty>0)
									{

										masterqty1=remqty;
									}
     
									
									String sqls1="update my_prfqm set pstatus=2 where doc_no="+rdocno+" " ;
									System.out.println("--1---sqls1---"+sqls1);
									stmt.executeUpdate(sqls1);
									

									if(masterqty1<=balqty)
									{
										masterqty1=masterqty1+out_qty;


										//String sqls="update my_prfqd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0";
										String sqls="update my_prfqd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";
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

										String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0  and unitid="+unitid+" and specno="+specno+"  ";
										//String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0 ";	
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

						String sql="INSERT INTO my_qotdser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+(sorderarray[7].trim().equalsIgnoreCase("undefined") || sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()?0:sorderarray[7].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+sqdocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
					      
                     
					}	    

				}

				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sqdocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);
						if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}
					}
				}


			}

          if(sqdocno>0)
          {

			conn.commit();
          }
		}
		catch(Exception e){
			e.printStackTrace();
			sqdocno=0;
		}
		finally{
			conn.close();
		}

		return sqdocno;
	}

	public  ClsSalesQuotationBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select m.billtype,m.totaltax,m.tax1,m.tax2,m.tax3,m.nettotaltax ,m.doc_no,m.delterms,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,cr.c_rate as curate,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid,coalesce(s.sal_name,'') as sal_name,coalesce(m.amount,0.00) as proamt,coalesce(m.discount,0.00) as discount,coalesce(m.netAmount,0.00) as netotal,coalesce(m.disper,0.00) as discper,coalesce(m.grantamt,0.00) as ordervalue,coalesce(m.servamt,0.00) as servamt,coalesce(m.roundof,0.00) as roundof "
					+ "from my_qotm m left join my_qotd d on(m.doc_no=d.rdocno) left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on(s.doc_no=m.sal_id) left join my_curr cr on(m.curid=cr.doc_no) where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails===="+sql);
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
				
				bean.setHiddate(rs.getString("date"));
				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setCmbcurr(rs.getString("currid"));
				bean.setHidcmbcurrency(rs.getString("currid"));
				bean.setCurrate(rs.getString("curate"));
				bean.setSalespersonid(rs.getInt("salid"));
				bean.setTxtsalesperson(rs.getString("sal_name"));
				bean.setClientid(rs.getInt("cldocno"));
				bean.setEnqmasterdocno(rs.getString("rrefno"));
				
				
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

			}


			int i=0;
			String qotdoc="";
			if(dtype.equalsIgnoreCase("CEQ"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_cusenqm where doc_no in ("+sqot+")";
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

			if(dtype.equalsIgnoreCase("RFQ"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_prfqm where doc_no in ("+sqot+")";
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



	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String netotal,String servamt,String roundof,String finalamt,String mode,String formcode,
			ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,
			String enqmasterdocno,String descper,String updatadata,String delterms,
			double stval, double tax1, double tax2, double tax3, double nettax,int cmbbilltype) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			
			CallableStatement stmt = conn.prepareCall("{CALL saleQotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			
			System.out.println("----prodamt----"+prodamt);
			System.out.println("----descount----"+descount);
			
			if(descount==null)
			{
				descount="0";
			}

			if(descper==null)
			{
				descper="0";
			}
			
			
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,enqmasterdocno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(netotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23,doc_no);
			stmt.setInt(24, Integer.parseInt(voc_no));
			
			int val = stmt.executeUpdate();
			sqdocno=stmt.getInt("sqdocno");
			int vocno=stmt.getInt("vdocNo");
			request.setAttribute("vdocNo", vocno);


			if(val<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			if(sqdocno>0){
				Statement st=conn.createStatement();
				String sqlss="update my_qotm set delterms='"+delterms+"' where doc_no='"+sqdocno+"' ";
				
				st.executeUpdate(sqlss);
				System.out.println("==updatadata==="+updatadata);
				
				

				int taxmethod=0;
				 Statement stmttax=conn.createStatement();
				
				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }
 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_qotm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sqdocno+"' ";
					  
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
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							
							 	typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_qotm set typeoftax='"+typeoftax+"'    where doc_no='"+sqdocno+"' ";
								  
								 
								  
							 stmt.executeUpdate(sqltax11);						 	
						 	
						 }
					  
					  
					  
				  }
				
				
    
                     
				
				
				
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{
					
					
					String rownochk="0";    
				int	updateid=0;
				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")) ||(prod[0].equalsIgnoreCase("null")))){

						System.out.println("======IN=======");
						if(i==0)
						{
						
					     String dql31="delete from my_qotd where rdocno='"+sqdocno+"'";
			    	 	  stmt.executeUpdate(dql31);
			    	 	 String dql32="delete from my_qotdser where rdocno='"+sqdocno+"'";
			    	 	 stmt.executeUpdate(dql32);
			   	 	 
			    	 	 String dql33= "delete from my_trterms where rdocno='"+sqdocno+"' and dtype='"+formcode+"' ";
			    	 	 stmt.executeUpdate(dql33);
						}
					/*	
						delete from my_qotd where rdocno=sqdocno;

						delete from my_qotdser where rdocno=sqdocno;

						delete from my_trterms where rdocno=sqdocno and dtype=doctype;*/
						
						

/*
						String sql="insert into my_qotd(sr_no,rdocno,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+(i+1)+",'"+sqdocno+"',"
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
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";

*/			         String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";



double fr=1;
String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";

System.out.println("====slss==="+slss);
ResultSet rv1=stmt.executeQuery(slss);
if(rv1.next())
{
	 fr=rv1.getDouble("fr"); 
}


						
						String sql="insert into my_qotd(sr_no,rdocno,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,taxper,taxamount,nettaxamount,allowdiscount,taxdocno,fr)VALUES"
									+ " ("+(i+1)+",'"+sqdocno+"',"
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
									+ "'"+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("") || prod[15].trim().equalsIgnoreCase("NaN")|| taxmethod==0 ||  prod[15].isEmpty()?0:prod[15].trim())+"',"
									+ "'"+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| taxmethod==0 || prod[16].isEmpty()?0:prod[16].trim())+"',"
									+ "'"+(prod[17].trim().equalsIgnoreCase("undefined") || prod[17].trim().equalsIgnoreCase("") || prod[17].trim().equalsIgnoreCase("NaN")|| taxmethod==0 ||  prod[17].isEmpty()?0:prod[17].trim())+"',"
									+ "'"+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")||   prod[18].isEmpty()?0:prod[18].trim())+"',"
									+ "'"+(prod[19].trim().equalsIgnoreCase("undefined") || prod[19].trim().equalsIgnoreCase("") || prod[19].trim().equalsIgnoreCase("NaN")||   prod[19].isEmpty()?0:prod[19].trim())+"',"+fr+" )";

						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);
						if(prodet<=0)
						{
							conn.close();
							return 0;
							
						}

						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[11].isEmpty()?0:prod[11].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							String qtyss=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"";
							double masterqty1=Double.parseDouble(qtyss);
							/*double oldqty=Double.parseDouble(""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"");
							masterqty1=(masterqty1-oldqty)+masterqty;
*/  String  specnos=""+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].trim().equalsIgnoreCase("")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							if(rreftype.equalsIgnoreCase("CEQ"))
							{

								System.out.println("enqmasterdocno==="+enqmasterdocno);

								/*								if(i==0)
								{
									String sqls="update my_cusenqd set out_qty=0 where rdocno in ("+enqmasterdocno+") ";



									stmt.executeUpdate(sqls);
								}*/
								
							  
								
								 int pridforchk=Integer.parseInt(prdid);
						    	 
								  
					    		 
					    		/* if(pridforchk!=updateid)
					    		 {*/
					    		 
					 			String sql1s="update  my_cusenqd set out_qty=0 where rdocno in ("+enqmasterdocno+") and prdid="+pridforchk+"  and unitid="+unitidss+" and specno="+specnos+" ";
			  
			    			//  System.out.println("-----"+sqls);
			    			   	
					 			stmt.executeUpdate(sql1s);
			    				
			    				/*updateid=pridforchk;
					    		 
					    		 }*/
			    				
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;
								int unitid=0;
								int specno=0;
								Statement stmt1=conn.createStatement();

							/*	String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.docno,d.rdocno,d.out_qty out_qty,d.prdid  from my_cusenqm m  left join "
										+ "my_cusenqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.docno "
										+ "order by m.date,d.docno";*/
								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.docno,d.rdocno,d.out_qty out_qty,d.prdid,d.unitid,d.specno  from my_cusenqm m  left join "
										+ "my_cusenqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and d.unitid="+unitidss+" and d.specno="+specnos+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.docno "
										+ "order by m.date,d.docno";


								//System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("docno");
									qty=rs.getDouble("qty");
									
									unitid=rs.getInt("unitid");
									specno=rs.getInt("specno");

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


									//	String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";
										String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+" and unitid="+unitid+" and specno="+specno+"  ";
									//	System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qty>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qty-out_qty;
											//System.out.println("-1--balqty--"+balqty);
											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty-balqty;
											balqty=qty;
										//	System.out.println("--2-balqty--"+balqty);
											//System.out.println("---remqty--2--"+remqty);
										}

										String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+" and unitid="+unitid+" and specno="+specno+"  ";
										//String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";	
									//	System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										 



									}


								}  







							}

						     
								else if(rreftype.equalsIgnoreCase("RFQ"))
						         {
							    	 
									double balqty=0;
									int docno=0;
									int rdocno=0;
									double remqty=0;
									double out_qty=0;
									double qtys=0;
									int unitid=0;
									int specno=0;
									
									Statement stmt2=conn.createStatement();
									 int pridforchk=Integer.parseInt(prdid);
							    	 
										String amount=""+(prod[13].trim().equalsIgnoreCase("undefined") || prod[13].trim().equalsIgnoreCase("NaN")||prod[13].trim().equalsIgnoreCase("")|| prod[13].isEmpty()?0:prod[13].trim())+"";
										  
										   
										   
										String discper=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")||prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
										    
										   System.out.println("-amount---"+amount);
										   System.out.println("-discper---"+discper);
						    		/* if(pridforchk!=updateid)
						    		 {*/
						    		 
						 		//	String sqls5="update  my_prfqd set out_qty=0 where rdocno in ("+enqmasterdocno+") and prdid="+pridforchk+"  and amount='"+amount+"' and disper='"+discper+"' and clstatus=0 and rowno not in("+rownochk+") ";
											String sqls5="update  my_prfqd set out_qty=0 where rdocno in ("+enqmasterdocno+") and prdid="+pridforchk+"  and amount='"+amount+"' and disper='"+discper+"' and clstatus=0 and rowno not in("+rownochk+") and unitid="+unitidss+" and specno="+specnos+" ";
				    			   System.out.println("-----"+sqls5);
				    			   	
						 			stmt2.executeUpdate(sqls5);
									
									
									Statement stmt1=conn.createStatement();

									/*String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_prfqm m  left join "
											+ "my_prfqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and d.clstatus=0 and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.rowno not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"' group by d.rowno  "
											+ "order by m.date,d.rowno";*/

									String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid,d.unitid,d.specno  from my_prfqm m  left join "
											+ "my_prfqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and d.clstatus=0 and d.unitid="+unitidss+" and d.specno="+specnos+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.rowno not in("+rownochk+") and d.amount='"+amount+"' and d.disper='"+discper+"' group by d.rowno  "
											+ "order by m.date,d.rowno";

									
	 
									
									System.out.println("---strSql-----"+strSql);
									ResultSet rs = stmt1.executeQuery(strSql);


									while(rs.next()) {


										balqty=rs.getDouble("balqty");
										rdocno=rs.getInt("rdocno");
										out_qty=rs.getDouble("out_qty");

										docno=rs.getInt("doc_no");
										qtys=rs.getDouble("qty");
										
										unitid=rs.getInt("unitid");
										specno=rs.getInt("specno");


										System.out.println("---masterqty-----"+masterqty1);	
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

											String sqls="update my_prfqd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
											//String sqls="update my_prfqd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0";

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

											String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0 and unitid="+unitid+" and specno="+specno+"  ";
										//	String sqls="update my_prfqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and clstatus=0 ";	
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

						String sql="INSERT INTO my_qotdser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+(sorderarray[7].trim().equalsIgnoreCase("undefined") || sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()?0:sorderarray[7].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+sqdocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}


					}
				}

				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sqdocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);
						
						if(termsdet<=0)
						{
							conn.close();
							return 0;
							
						}

					}
				}


			}
			}
				if(sqdocno>0)
				{
			  	conn.commit();		
					return sqdocno;
				}
				

			 
		}
		catch(Exception e){
			e.printStackTrace();
			sqdocno=0;
			 
		}
		finally{
			conn.close();
		}

		return sqdocno;
	}

	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String netotal,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,HttpSession session,HttpServletRequest request,String enqmasterdocno,String descper) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleQotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			System.out.println("CALL saleQotDML('"+date+"','"+refno+"',"+Integer.parseInt(curr)+","+Double.parseDouble(currate)+","+salesid+",'"+rreftype+"','"+rrefno+"',"
					+ "'"+payterms+"','"+desc+"','"+Double.parseDouble(prodamt)+"','"+Double.parseDouble(descount)+"','"+Double.parseDouble(netotal)+"','"+mode+"','"+formcode+"',"
					+ "'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("COMPANYID").toString()+"','"+doc_no+"','"+ Integer.parseInt(voc_no)+"','"+date+"')");

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
			stmt.setDouble(13,Double.parseDouble(netotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setInt(19, doc_no);
			stmt.setInt(20, Integer.parseInt(voc_no));

			int val = stmt.executeUpdate();
			sqdocno=stmt.getInt("sqdocno");
			int vocno=stmt.getInt("vdocNo");	
			request.setAttribute("vdocNo", vocno);
			//System.out.println("=update==vocno====="+vocno);
			/*			if(vocno>0){

				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")) ||(prod[0].equalsIgnoreCase("null")))){




						String sql="insert into my_qotd(sr_no,rdocno,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+(i+1)+",'"+sqdocno+"',"
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
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";


						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);


						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[11].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							if(rreftype.equalsIgnoreCase("CEQ"))
							{

									System.out.println("enqmasterdocno==="+enqmasterdocno);

								if(i==0)
								{
									String sqls="update my_cusenqd set out_qty=0 where rdocno in ("+enqmasterdocno+") ";



									stmt.executeUpdate(sqls);
								}

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.docno,d.rdocno,d.out_qty out_qty,d.prdid  from my_cusenqm m  left join "
										+ "my_cusenqd d on m.doc_no=d.rdocno where d.rdocno in ("+enqmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.docno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.docno";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("docno");
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


										String sqls="update my_cusenqd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";

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


										String sqls="update my_cusenqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  docno="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}



						}

					}

				}

				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+sqdocno+"',"
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

		return sqdocno;
	}

	public   JSONArray reloadserviceGrid(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			String pySql=("select srno,desc1 description,unitprice price,qty,total,discount,nettotal,ir.acno as acno,h.description as account from my_qotdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno='"+docno+"' ");
			//System.out.println("========"+pySql);
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
	 
	 public    ClsSalesQuotationBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsSalesQuotationBean bean = new ClsSalesQuotationBean();
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
				
				String resql=("select coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno,if(m.ref_type='DIR','Direct',if(m.ref_type='CEQ','Sales Enquiry','Purchase Request For Quote')) type, "
						+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
						+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
				+ "  from my_qotm m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id   where   m.doc_no='"+docno+"'");
				
				
			 
				
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
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_qotm r  "
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
				     String	strSqldetail1="select round(sum(nettotal),2) nettotal  from my_qotd   where rdocno='"+docno+"'";
					 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
				 
						if(rsdetail1.next()){
							
							total=rsdetail1.getDouble("nettotal");
							bean.setLbltotal(total+"");
							grndtotal+=total;
						}
						
						 System.out.println("====grndtotal=2="+grndtotal);
						
						 Statement stmtgrid4 = conn.createStatement (); 	 
						 String	strSqldetail4="select round(sum(nettotal),2) nettotal  from my_qotdser   where rdocno='"+docno+"'";
						 
						 System.out.println("====strSqldetail4=="+strSqldetail4);
						 
						 ResultSet rsdetail4=stmtgrid4.executeQuery(strSqldetail4);
					 
							if(rsdetail4.next()){
								
								srvtotal=rsdetail4.getDouble("nettotal");
								   bean.setLblsubtotal(srvtotal+"");
								   grndtotal+=srvtotal;
							     }
							 System.out.println("====grndtotal=3="+grndtotal);
							
							 bean.setLblordervaluewords(c.convertAmountToWords(grndtotal+""));
					    	 bean.setLblordervalue(grndtotal+"");
							
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty,"
				       		+ " round(d.amount,2) amount,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_qotd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"'";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") ;
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
				       		+ " discount ,round(nettotal,2) nettotal from my_qotdser     where rdocno='"+docno+"'";
					
			
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
	 
}

