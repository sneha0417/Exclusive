package com.sales.Sales.branchInvoice;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
 

public class ClsBranchInvoiceDAO {
	ClsBranchInvoiceBean bean= new ClsBranchInvoiceBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	
	public   JSONArray hidesearchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String cmbprice,String clientid,String cmbreftype,String location,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			int method1=0;
			String catid=clientcaid;
			
			int pricemgt=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/

 System.out.println("=====rdoc===="+rdoc);
 Statement stmt2 = conn.createStatement (); 
 
 
 
	String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
	ResultSet rs3=stmt2.executeQuery(chk3); 
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
				
				
			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"'  and status=3 and type=1  and provid='"+prvdocno+"' group by typeid ) t1 on "
					+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
			
			fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
			
			outfsql=outfsql+ " taxper , ";
			
			
			
			}
			
		}
		
	 
	
	
			if(prodsearchtype.equals("0")){
				Statement stmt1 = conn.createStatement (); 
				String chk1="select method  from gl_prdconfig where field_nme='edit'";
				ResultSet rs1=stmt1.executeQuery(chk1); 
				if(rs1.next())
				{

					method1=rs1.getInt("method");
				}
	 
				
			
				
                String sqls=""; 
                
                if(pricemgt>0) 
                {
                	
                	
                			sql="select  "+fsql+" case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,"
    						+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid "
    						+ " "+sqls+"  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
    						+ "   inner join my_prddin i "
    						+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )"
    						+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
    						+ " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' and pr.discount1 is not null "
    						+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date ";	
                	

                  	System.out.println("=====sql===with price==="+sql);
                	ResultSet resultSet = stmt.executeQuery(sql);
        			RESULTDATA=ClsCommon.convertToJSON(resultSet);               	

                	
                }
                else
                {
                	
                	sql="select  "+fsql+" bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
    						+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
    						+ " '' unitprice  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
    						+ "   inner join my_prddin i "
    						+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  )  " 
    						+ " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' "
    						+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
                	System.out.println("=====sql===with out price==="+sql);	
                
                	ResultSet resultSet = stmt.executeQuery (sql);
        			RESULTDATA=ClsCommon.convertToJSON(resultSet);
                }
                
 	
 
			
                

			}
			else{
				  

				if(reftype.equalsIgnoreCase("DEL")){

 
					   if(pricemgt>0)
					   {
						   
						   
							sql="select   "+outfsql+" allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
									+ " proid,productname,proname,unit,unitdocno,if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
									+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','0',dis),char(10)) dis,convert(if(a.ref_type='DIR','0',discper),char(10)) discper, "
									+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
									+ " case   when '"+masterdate+"' between "
									+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
									+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
									+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
									+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
									+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
									+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
									+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
									+ " "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0) a  where allowdiscount is not null";
						System.out.println("==sql==="+sql);
							
							ResultSet resultSet = stmt.executeQuery (sql);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);
							
					   }
					   else
					   {
										sql="select "+fsql+" bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
												+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
												+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
												+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
												+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
												+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
												+ "  "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ";
										
										ResultSet resultSet = stmt.executeQuery (sql);
										RESULTDATA=ClsCommon.convertToJSON(resultSet);
										
										
										
					   }
				}
				else if(reftype.equalsIgnoreCase("SOR")){

		
				      sql=" select  "+fsql+" bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc, "
								+ " ii.inblqty  totqty,sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as "
								+ " balqty,part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit, "
								+ " u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,d.amount unitprice,((qty-out_qty)*d.amount) total, "
								+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal from  my_sorderm m1 left join my_sorderd d  "
								+ " on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u "
								+ " on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
								+ " prdid,psrno,specno,brhid,locid "
								+ " from my_prddin where 1=1 group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
								+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "+joinsql+"  "
								+ " where m.status=3 "
								+ " and  d.clstatus=0 and  d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"   "
								+ " group by psrno having sum(d.qty-d.out_qty)>0     ";
				      
				      ResultSet resultSet = stmt.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				
				
				}

				else if(reftype.equalsIgnoreCase("JOR")){
					

			        if(pricemgt>0)   
			        {
			        	  		sql=" select "+outfsql+" lbrchg,unitprice*qty total, unitprice*qty netotal, unitprice,allowdiscount,brandname,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty, "
			        	  				+ " part_no,productid,proid,productname,proname,unit,unitdocno  "
			        	  				+ " from(select  "+fsql+" m.lbrchg,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, "
			        	  				+ " case   when '"+masterdate+"' between   clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount, "
			        	  				+ " bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
			        	  				+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
			        	  				+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
			        	  				+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
			        	  				+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
			        	  				+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
			        	  				+ " left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
			        	  				+ "   "+joinsql+"  where m.status=3  and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
			        	  				+ " group by psrno having sum(d.qty-d.out_qty)>0 ) a where allowdiscount is not null";
			        	  		
			        	  		System.out.println("----sadfsdf-sql---"+sql);
			        	  		
			        	  		ResultSet resultSet = stmt.executeQuery (sql);
			        			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			        	  		
						
			        }
			        else
			        {
			        	 sql=" select  "+fsql+" m.lbrchg,bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
					        		+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
					        		+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
					        		+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
					        		+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
					        		+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					                + "  "+joinsql+"  where m.status=3  and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
					                + " group by psrno having sum(d.qty-d.out_qty)>0  ";
			        	 
			        	 System.out.println("----sadfsdf-sql---"+sql);
			        	 ResultSet resultSet = stmt.executeQuery (sql);
			 			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			        	
			        	
			        }
			
			
				}
		        

		 
			 
		}



			 
			 
 
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


	
	
	
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String cmbprice,String clientid,String cmbreftype,String location,String clientcaid,String dates,String cmbbilltype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			int method1=0;
			String catid=clientcaid;
			
			int pricemgt=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/

 System.out.println("=====rdoc===="+rdoc);
 Statement stmt2 = conn.createStatement (); 
 
 
 
	String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
	ResultSet rs3=stmt2.executeQuery(chk3); 
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
		 Statement stmt43=conn.createStatement();
		int discountset=0;
		String chk311="select method  from gl_prdconfig where field_nme='discountset'";
		ResultSet rs31=stmt43.executeQuery(chk311); 
		if(rs31.next())
		{

			discountset=rs31.getInt("method");
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
				
				
			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"'  and status=3 and type=1  and provid='"+prvdocno+"' group by typeid ) t1 on "
					+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
			
			fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
			
			outfsql=outfsql+ " taxper , ";
			
			
			
			}
			
		}
		
		
		 Statement stmt93=conn.createStatement();
			double discval=0;
			int discmethod=0;
			String prds="select value,method  from gl_prdconfig where field_nme='brinv'";
			ResultSet prdsrs=stmt93.executeQuery(prds); 
			if(prdsrs.next())
			{

				discval=prdsrs.getDouble("value");
				
				discmethod=prdsrs.getInt("method");
			}
			
			
			String sqlsdicount="";
			
			if(discmethod>0)
			{
				sqlsdicount="(((((m.fixingprice - m.stdprice) / fixingprice ) * 100) - m.maxdiscount )* "+discval+" ) + m.maxdiscount " ;
				
			}
			
		 
	 
	
	
			if(prodsearchtype.equals("0")){
				Statement stmt1 = conn.createStatement (); 
				String chk1="select method  from gl_prdconfig where field_nme='edit'";
				ResultSet rs1=stmt1.executeQuery(chk1); 
				if(rs1.next())
				{

					method1=rs1.getInt("method");
				}
	 
				
			
				
                String sqls= ""; 
                
                if(pricemgt>0) 
                {
                	
                	
                			sql="select  "+fsql+" "+discountset+" discountset,  m.fixingprice  as unitprice,"
                			+ "  "+sqlsdicount+"  as allowdiscount,"
                			+ "bd.brandname,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,"
    						+ " sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid "
    						+ " "+sqls+"  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
    						+ "   inner join my_prddin i "
    						+ " on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )"
    					    + " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' "
    						+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date ";	
                	

                  	System.out.println("=====sql===with price==="+sql);
                	ResultSet resultSet = stmt.executeQuery(sql);
        			RESULTDATA=ClsCommon.convertToJSON(resultSet);               	

                	
                }
                else
                {
                	
                	sql="select  "+fsql+" bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
    						+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
    						+ " '' unitprice  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
    						+ "   inner join my_prddin i "
    						+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  )  " 
    						+ " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' "
    						+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
                	System.out.println("=====sql===with out price==="+sql);	
                
                	ResultSet resultSet = stmt.executeQuery (sql);
        			RESULTDATA=ClsCommon.convertToJSON(resultSet);
                }
                
 	
 
			
                

			}
			else{
				  

				if(reftype.equalsIgnoreCase("DEL")){

 
					   if(pricemgt>0)
					   {
						   
						   
							sql="select   "+outfsql+" "+discountset+" discountset,allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
									+ " proid,productname,proname,unit,unitdocno,if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
									+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','0',dis),char(10)) dis,convert(if(a.ref_type='DIR','0',discper),char(10)) discper, "
									+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
									+ " case   when '"+masterdate+"' between "
									+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
									+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
									+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
									+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
									+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
									+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
									+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"' )) "
									+ " "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0) a  ";
						System.out.println("==sql==="+sql);
							
							ResultSet resultSet = stmt.executeQuery (sql);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);
							
					   }
					   else
					   {
										sql="select "+fsql+" bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
												+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
												+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
												+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
												+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
												+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
												+ "  "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ";
										
										ResultSet resultSet = stmt.executeQuery (sql);
										RESULTDATA=ClsCommon.convertToJSON(resultSet);
										
										
										
					   }
				}
				else if(reftype.equalsIgnoreCase("SOR")){

		
				      sql=" select  "+fsql+" bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc, "
								+ " ii.inblqty  totqty,sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as "
								+ " balqty,part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit, "
								+ " u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,d.amount unitprice,((qty-out_qty)*d.amount) total, "
								+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal from  my_sorderm m1 left join my_sorderd d  "
								+ " on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u "
								+ " on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
								+ " prdid,psrno,specno,brhid,locid "
								+ " from my_prddin where 1=1 group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
								+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "+joinsql+"  "
								+ " where m.status=3 "
								+ " and  d.clstatus=0 and  d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"   "
								+ " group by psrno having sum(d.qty-d.out_qty)>0     ";
				      
				      ResultSet resultSet = stmt.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				
				
				}

				else if(reftype.equalsIgnoreCase("JOR")){
					

			        if(pricemgt>0)   
			        {
			        	  		sql=" select "+outfsql+" "+discountset+" discountset,lbrchg,unitprice*qty total, unitprice*qty netotal, unitprice,allowdiscount,brandname,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty, "
			        	  				+ " part_no,productid,proid,productname,proname,unit,unitdocno  "
			        	  				+ " from(select  "+fsql+" m.lbrchg,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, "
			        	  				+ " case   when '"+masterdate+"' between   clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount, "
			        	  				+ " bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
			        	  				+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
			        	  				+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
			        	  				+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
			        	  				+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
			        	  				+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
			        	  				+ " left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
			        	  				+ "   "+joinsql+"  where m.status=3  and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
			        	  				+ " group by psrno having sum(d.qty-d.out_qty)>0 ) a ";
			        	  		
			        	  		System.out.println("----sadfsdf-sql---"+sql);
			        	  		
			        	  		ResultSet resultSet = stmt.executeQuery (sql);
			        			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			        	  		
						
			        }
			        else
			        {
			        	 sql=" select  "+fsql+" m.lbrchg,bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
					        		+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
					        		+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
					        		+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
					        		+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
					        		+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					                + "  "+joinsql+"  where m.status=3  and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
					                + " group by psrno having sum(d.qty-d.out_qty)>0  ";
			        	 
			        	 System.out.println("----sadfsdf-sql---"+sql);
			        	 ResultSet resultSet = stmt.executeQuery (sql);
			 			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			        	
			        	
			        }
			
			
				}
		        

		 
			 
		}



			 
			 
 
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


	public   JSONArray searchLocation(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			String sql="select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brcid+"";
			System.out.println("-----searchLocation---"+sql);

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


	public   JSONArray searchAccount(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			String sql="select a.acno,h.account acc,h.description as account,a.description from my_salexpaccount a left join my_head h on(a.acno=h.doc_no) where a.status=3 ;";
		//	System.out.println("-----searchLocation---"+sql);

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


			String sql="select s.doc_no,s.sal_name,u.user_id,s.catid,s.usgper from my_salm s left join my_user u on u.doc_no=s.userid where s.status=3;";
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


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"' and status=3";
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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String clientid,String reftype,String ref) throws SQLException {

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

			System.out.println("reftype===="+reftype);

			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();
			String pySql="";

			
			if(reftype.equalsIgnoreCase("DEL")){
 
				if(ref.equalsIgnoreCase("SOR"))
				{
					sqltest=" and m.ref_type='SOR' ";	
				}
				else
				{
					sqltest=" and m.ref_type='DIR' ";	
				}
				
				pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_delm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_deld d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
			
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			}
			else if(reftype.equalsIgnoreCase("SOR")){

				pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_sorderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_sorderd d on(d.rdocno=m.doc_no)  where d.clstatus=0 and m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
			
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			}
			else if(reftype.equalsIgnoreCase("JOR")){

				
				pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.regno as refno,m.voc_no,m.date,ac.refname as "
						+ "	 client,0 as chk from my_joborderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') "
						+ "	 left join my_joborderd d on(d.rdocno=m.doc_no)  where d.status=2 and m.status=3  and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+"   group by m.doc_no) as a having qty>0 ");
				
				System.out.println("----pySql-------"+pySql);
		 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			}

			//System.out.println("====pySql===="+pySql);
			

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



	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype,String transid
			,String Cl_mobnos,String Cl_salper) throws SQLException {


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
		
		if(!(Cl_salper.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_salper+"%'";
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



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();  
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select sa.doc_no saldocno,sa.sal_name,ac.per_mob, m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,"
					+ "m.cldocno,m.ref_type,rrefno from my_invm m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sa on (sa.doc_no=ac.sal_id and ac.dtype='CRM' ) "
					+ " where m.brhid="+brid+" and m.status=3 and paymode="+transid+" and ftype=1  "+sqltest+"");
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



	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

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
			sqltest=sqltest+" and a.refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and a.per_mob like '%"+mob+"%'";
		}


		
		
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();  
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

	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno,stkid from "
					+ "( select at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.stockid as stkid from "
					+ "my_qotd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
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

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String reftype,String locationid,String catid,String cmbbilltype) throws SQLException {


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

			System.out.println("------reftype--- --"+reftype);
			
			System.out.println("==enqmasterdocno==asdasd="+enqdoc);
			
			if(reftype.equalsIgnoreCase("DIR")) 
			{
			//	taxper sum(d.nettaxamount) taxamount,d.taxper  taxamount,taxper

			sql="select brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "case when (totqty-outqty)=0 then 0 else (balqty) end as balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal,taxamount,taxper,taxperamt,allowdiscount from"
					+ "(select  brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys+qty  as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal,taxamount,taxper,taxperamt,allowdiscount from ( select bd.brandname,i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,ii.inblqty as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
					+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
					+ "sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal,sum(d.nettaxamount) taxamount,d.allowdiscount,d.taxper,sum(d.taxamount) taxperamt "
					+ "  from my_invm ma left join my_invd d on(ma.doc_no=d.rdocno)"
					+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and i.locid=d.locid)  "
					+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
					+ "	   from my_prddin where 1=1 group by psrno,locid,brhid) ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=i.locid) "
					+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locationid+"' group by i.prdid"
					+ "  order by  i.prdid,i.date ) as a ) as b ; ";
			
			
		//	System.out.println("===prdGridReload=stockcheck==Dir="+sql);	
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			
			else if(reftype.equalsIgnoreCase("DEL"))
			{
				
				
				
				
		 
				
				sql="	select brandname,locid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
						+ "	case when (totqty-outqty)=0 then 0 else (balqty) end as balqty,0 size,part_no,productid as proid, "
						+ " productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper, "
						+ " dis, netotal,taxamount,taxper,taxperamt,allowdiscount from(select   brandname,locid,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys+qty "
						+ "  as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
						+ "   dis, netotal,taxamount,taxper,taxperamt,allowdiscount from ( select  bd.brandname,d.locid, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno, "
						+ "   sum(d.qty) as qty,ii.inblqty as qtys,ii.outqty as outqty,m.part_no,m.part_no "
						+ "   productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount "
						+ "   unitprice,sum(d.total) total,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal,sum(d.nettaxamount) taxamount,d.allowdiscount,d.taxper,sum(d.taxamount) taxperamt from my_invm ma "
						+ "   left join my_invd d on(ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) "
						+ "  left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
						+ "    left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid "
						+ "   and d.stockid=i.stockid)   left join(select date,sum(dd.qty)-sum(dd.out_qty) "
						+ "   inblqty,dd.stockid,sum(dd.out_qty) outqty,dd.prdid,dd.psrno,dd.specno,dm.brhid,dm.locid "
						+ "    from my_delm dm left join  my_deld dd on dd.rdocno=dm.doc_no where dd.rdocno in("+enqdoc+") group by dd.psrno,dm.locid) "
						+ "     ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and    i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=d.locid) "
						+ "    where m.status=3 and d.rdocno in("+docno+") "
						+ "     and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid,d.locid  order by  d.prdid,d.locid  ) as a ) as b " ;
			 	System.out.println("===prdGridReload=stockcheck==1="+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			}
			
			
			
		
			else if(reftype.equalsIgnoreCase("SOR"))

				
				
			{
				
/*				
				sql="	select locid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
						+ "	case when (totqty-outqty)=0 then 0 else (balqty) end as balqty,0 size,part_no,productid as proid, "
			 + " productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper, "
			+ " dis, netotal from(select   locid,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,qtys+qty "
			+ "  as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
			+ "   dis, netotal from ( select d.locid, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno, "
			+ "   sum(d.qty) as qty,ii.inblqty as qtys,ii.outqty as outqty,m.part_no,m.part_no "
			 + "   productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount "
			 + "   unitprice,d.total,d.disper discper, d.discount dis,d.nettotal netotal from my_invm ma "
			  + "   left join my_invd d on(ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) "
			  + "  left join  my_unitm u on(d.unitid=u.doc_no)left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
			 + "    left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid "
			  + "   and d.stockid=i.stockid)   left join(select date,sum(dd.qty)-sum(dd.out_qty) "
			  + "   inblqty,dd.stockid,sum(dd.out_qty) outqty,dd.prdid,dd.psrno,dd.specno,dm.brhid,dm.locid "
			    + "    from my_delm dm left join  my_deld dd on dd.rdocno=dm.doc_no where dd.rdocno in("+enqdoc+") group by dd.psrno,dm.locid) "
			   + "     ii on   (ii.psrno=i.psrno and ii.prdid=i.prdid and    i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=d.locid) "
			     + "    where m.status=3 and d.rdocno in("+docno+") "
			    + "     and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid,d.locid  order by  d.prdid,d.locid  ) as a ) as b " ;
			
				
				*/
				
				sql="	select  brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,  "
						 + " balqty,0 size,part_no,productid as proid,  "
						 + "   productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total,  "
						 + "  discper,  dis, netotal,taxamount,taxper,taxperamt,allowdiscount from(select    brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys  "
						 + "   as totqty, qty,qtys,outqty,balqty+qty   as balqty,0 size,part_no,productid,productname,unit,unitdocno,  "
						 + "   totwtkg, kgprice, unitprice, total, discper,    dis, netotal,taxamount,taxper,taxperamt,allowdiscount  "
						 + "   from ( select  bd.brandname,0 as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,  "
						 + "   sum(d.qty) as qty,ii.inblqty1 as qtys,dd.outqty as outqty,dd.orderblqty balqty, m.part_no,m.part_no  "
						 + "  productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount  "
						 + "     unitprice,sum(d.total) total ,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal,sum(d.nettaxamount) taxamount,d.taxper,sum(d.taxamount) taxperamt,d.allowdiscount  from my_invm ma  "
						 + "   left join my_invd d on(ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno)  "
						 + "    left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  "
						 + "   left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty1,stockid,sum(out_qty+del_qty+rsv_qty) outqty1,  "
						 + "	 prdid,psrno,specno,brhid,locid	  from my_prddin where 1=1 group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid  "
						 + "				 	and d.specno=ii.specno and ma.brhid=ii.brhid) "
						 + "   left join(select sum(dd.qty)-sum(dd.out_qty)    orderblqty,dd.stockid,sum(dd.out_qty) outqty,dd.prdid,dd.psrno,  "
						 + "  dd.specno   from   my_sorderd dd  where dd.clstatus=0 and dd.rdocno in("+enqdoc+")  "
						 + "  group by dd.psrno)      dd on   (dd.psrno=d.psrno and dd.prdid=d.prdid and  "
						 + "    dd.specno=d.specno and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"')     where m.status=3 and  d.rdocno in("+docno+") "
						 + "       and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid  order by  d.prdid ) as a ) as b  ";
				
				

				
				
				
			//	System.out.println("===prdGridReload=stockcheck==2="+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			}
			
			
			
			
			
			else if(reftype.equalsIgnoreCase("JOR"))

				
				
			{
				 
				
				sql="	select lbrchg, brandname,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,balqty-qty totqty, qty,qty as oldqty,outqty,  "
						 + " balqty,0 size,part_no,productid as proid,  "
						 + "   productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total,  "
						 + "  discper,  dis, netotal, taxamount,taxper,taxperamt,allowdiscount from(select    lbrchg,brandname,stkid,specid,psrno as doc_no,rdocno,psrno,qtys  "
						 + "   as totqty, qty,qtys,outqty,balqty+qty   as balqty,0 size,part_no,productid,productname,unit,unitdocno,  "
						 + "   totwtkg, kgprice, unitprice, total, discper,    dis, netotal, taxamount,taxper,taxperamt,allowdiscount  "
						 + "   from ( select  m.lbrchg,bd.brandname,0 as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,  "
						 + "   sum(d.qty) as qty,ii.inblqty1 as qtys,dd.outqty as outqty,dd.orderblqty balqty, m.part_no,m.part_no  "
						 + "  productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount  "
						 + "     unitprice,sum(d.total) total ,d.disper discper,sum(d.discount) dis,sum(d.nettotal) netotal,sum(d.nettaxamount) taxamount,d.taxper,sum(d.taxamount) taxperamt,d.allowdiscount  from my_invm ma  "
						 + "   left join my_invd d on(ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno)  "
						 + "    left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  "
						 + "   left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty1,stockid,sum(out_qty+del_qty+rsv_qty) outqty1,  "
						 + "	 prdid,psrno,specno,brhid,locid	  from my_prddin where 1=1 group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid  "
						 + "				 	and d.specno=ii.specno and ma.brhid=ii.brhid) "
						 + "   left join(select sum(dd.qty)-sum(dd.out_qty)    orderblqty,dd.stockid,sum(dd.out_qty) outqty,dd.prdid,dd.psrno,  "
						 + "  dd.specno   from   my_joborderd dd  where dd.status=2 and dd.rdocno in("+enqdoc+")  "
						 + "  group by dd.psrno)      dd on   (dd.psrno=d.psrno and dd.prdid=d.prdid and  "
						 + "    dd.specno=d.specno and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"')     where m.status=3 and  d.rdocno in("+docno+") "
						 + "       and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid  order by  d.prdid ) as a ) as b  ";
				
				 
				
			//	System.out.println("===prdGridReload=stockcheck==2="+sql);	
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


	public JSONArray prdGridReload(HttpSession session,String docno,String reftype,String dates,String catid,String cmbbilltype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}
			String sql="";
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			
           int pricemgt=0;
			String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rs3=stmt1.executeQuery(chk3); 
			if(rs3.next())
			{

				pricemgt=rs3.getInt("method");
			}
		 
			
			 java.sql.Date masterdate = null;
				if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))&&!(dates.equalsIgnoreCase("NA")))
		     	{
					masterdate=ClsCommon.changeStringtoSqlDate(dates);
		     		
		     	}
		     	else{
		     
		     	}
				 Statement stmt43=conn.createStatement();
					int discountset=0;
					String chk311="select method  from gl_prdconfig where field_nme='discountset'";
					ResultSet rs31=stmt43.executeQuery(chk311); 
					if(rs31.next())
					{

						discountset=rs31.getInt("method");
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
						
						
					joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1   and provid='"+prvdocno+"' group by typeid ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno   ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper ,if(a.ref_type='DIR',qty*unitprice1,netotal)+if(a.ref_type='DIR',qty*unitprice1,netotal)*(taxper/100)  taxamount , ";
					
					
					
					}
					
				}
				
			 
			


			if((reftype.equalsIgnoreCase("DEL")) || (reftype.equalsIgnoreCase("SOR") || (reftype.equalsIgnoreCase("JOR")))){



				if(reftype.equalsIgnoreCase("DEL")){

	 
/*			with out price		
					sql="select m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
							+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
					 + " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice, "
					 + " d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper,d.discount dis,((d.qty-d.out_qty)*d.amount) netotal "
					+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) "
					+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
				+ " 	where m.status=3 and d.rdocno in("+docno+") group by d.psrno,m1.locid having sum(d.qty-d.out_qty)>0  ";*/
					
	/*			String sqls="select count(d.psrno)  count   from my_delm m1 left join	 my_deld d on m1.doc_no=d.rdocno  "
						+ " left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ " where d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"   "
								+ "  group by d.psrno,m1.locid having sum(d.qty-d.out_qty)>0 " ;
				
				*/
				String sqls="select count(c) counts from (select count(d.psrno) c   ,d.psrno,m.productname  from my_delm m1 left join "
						+ "  my_deld d on m1.doc_no=d.rdocno   left join my_main m on(d.psrno=m.doc_no) "
						+ "  left join  my_brand bd on m.brandid=bd.doc_no  left join  my_unitm u on(d.unitid=u.doc_no) "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)  where d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
						+ "   group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ) a group by  psrno ";
				
				//System.out.println("=asd==sqls="+sqls);
				ResultSet rss=stmt.executeQuery(sqls);
				int count=0;
				while(rss.next())
				
				{
					
					count=rss.getInt("counts");
					if(count>1)
					{
						count=2;
					}
					
				}
				
				if(pricemgt>0)
				{
				
					
					
					sql="select  "+outfsql+"  "+count+" count,"+discountset+" discountset ,round(allowdiscount,2) allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
							+ " proid,productname,proname,unit,unitdocno, if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
							+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','',dis),char(10)) dis,convert(if(a.ref_type='DIR','',discper),char(10)) discper, "
							+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
							+ " case   when '"+masterdate+"' between "
							+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
							+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
							+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
							+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
							+ " "+joinsql+" where m.status=3 and d.rdocno in("+docno+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0 ) a ";
					
			 	
					System.out.println("===del===2=="+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					 
				}
				else
				{
					
					
					sql=" select "+fsql+" "+count+" count, bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
							+ "   sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
							+ "   m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,d.amount unitprice,((qty-out_qty)*d.amount) total, "
								+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
							+ "   from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "   left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						    + "  "+joinsql+" where m.status=3 and d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"    group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ";
							
							System.out.println("===prdGridReload===2=="+sql);
							ResultSet resultSet = stmt.executeQuery(sql);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);	
					
					
				}
					
				}
				else if(reftype.equalsIgnoreCase("SOR")){
					///(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100)  netotal
					
				          sql=" select "+fsql+" bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc, "
							+ " ii.inblqty  totqty,sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as "
							+ " balqty,part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit, "
							+ " u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,d.amount unitprice,((qty-out_qty)*d.amount) total, " 
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal from  my_sorderm m1 left join my_sorderd d  "
							+ " on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u "
							+ " on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
							+ " prdid,psrno,specno,brhid,locid "
							+ " from my_prddin where 1=1 group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
							+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "+joinsql+" "
							+ " where m.status=3 "
							+ " and  d.clstatus=0 and d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"   "
							+ " group by psrno having sum(d.qty-d.out_qty)>0   ";
					
	 
					System.out.println("===prdGridReload===2=="+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					 
				}
				else if(reftype.equalsIgnoreCase("JOR")){
				

					        if(pricemgt>0)   
					        {
					        	if(tax>0)
								{
					        	    	outfsql= " taxper ,(unitprice*qty)+unitprice*qty*(taxper/100)  taxamount, ";
								}
					        	  		sql=" select "+outfsql+"   "+discountset+" discountset,lbrchg,unitprice*qty total, unitprice*qty netotal, unitprice,round(allowdiscount,2) allowdiscount,brandname,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty, "
					        	  				+ " part_no,productid,proid,productname,proname,unit,unitdocno  "
					        	  				+ " from(select "+fsql+" m.lbrchg,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice, "
					        	  				+ " case   when '"+masterdate+"' between   clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount, "
					        	  				+ " bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
					        	  				+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
					        	  				+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
					        	  				+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
					        	  				+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
					        	  				+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					        	  				+ " left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
					        	  				+ " "+joinsql+" where m.status=3  and  d.status=2 and d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
					        	  				+ " group by psrno having sum(d.qty-d.out_qty)>0 ) a ";
					        	  		
					        	  		System.out.println("-----sql---"+sql);
								
					        }
					        else
					        {
					        	
					        
					        	
					        	 sql=" select "+fsql+" m.lbrchg,bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
							        		+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
							        		+ " part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,  u.doc_no unitdocno  "
							        		+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no)  "
							        		+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no "
							        		+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							                + " "+joinsql+"  where m.status=3  and  d.status=2 and d.rdocno in("+docno+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
							                + " group by psrno having sum(d.qty-d.out_qty)>0  ";
					        	
					        	
					        }
					
					
				          
				        
	
					System.out.println("===prdGridReload===2=="+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					 
				}

			
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

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m  "
					+ "  inner join my_termsd d on(m.voc_no=d.rdocno and d.status=3) where m.status=3 and d.dtype='"+dtype+"' order by terms";
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



	public   JSONArray qotgridreload(String doc,String reftype) throws SQLException {

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

			if(reftype.equalsIgnoreCase("DEL")){

				sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
						+ "my_delm ma left join my_deld d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) inner join my_prddin i "
						+ "on(i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno) where m.status=3 and d.rdocno in("+doc+")  group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a group by psrno";


			}



			System.out.println("=qotgridreload==="+sql);

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
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,
			ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,java.sql.Date payduedate
			,int locationid,String modepay,String deltems, ArrayList<String> shiparray,int shipdocno, double stval, double tax1, double tax2, double tax3, double nettax, 
			int cmbbilltype)  throws SQLException{

		Connection conn=null;
		int sodocno=0;
		int tranid=0;
		conn=ClsConnection.getMyConnection();

		try{
			
			if(modepay.equalsIgnoreCase("cash")){
				tranid=1;
			}
			else if(modepay.equalsIgnoreCase("credit")){
				tranid=2;
			}

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(30, java.sql.Types.VARCHAR);
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
			stmt.setInt(23,0);
			stmt.setDate(24,payduedate);
			stmt.setInt(25,locationid);
			stmt.setInt(26,tranid);
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				 Statement stmtss=conn.createStatement();
				 String sqlsu= " update my_invm set delterms='"+deltems+"',ftype=1   where doc_no='"+sodocno+"' ";
				 stmtss.executeUpdate(sqlsu);
				int taxmethod=0;
				 Statement stmttax=conn.createStatement();

				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }

				 int stacno=0;
				 int tax1acno=0;
				 int tax2acno=0;
				 int tax3acno=0;
				 
				 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_invm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sodocno+"' ";
					  
					  System.out.println("======sqltax1========="+sqltax1);
					  
					  stmtss.executeUpdate(sqltax1);
				
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

						 
					 
					  
					  	Statement ssss10=conn.createStatement();
				  
						 String sql10="  select acno,value from gl_taxmaster where doc_no=(select max(doc_no) tdocno from gl_taxmaster where  "
						 		+ "  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and provid='"+prvdocno+"'  )  and status=3 and type=1 and provid='"+prvdocno+"'  " ;
					
						 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
						 if(rstaxxx101.next())
						 {
							 
							 stacno=rstaxxx101.getInt("acno");
							
													 	
						 	
						 }

					  
					  	Statement ssss=conn.createStatement();
				  
						 String sql100=" select s.acno,s.value "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							 tax1acno=rstaxxx.getInt("acno");
							 	typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_invm set typeoftax='"+typeoftax+"'    where doc_no='"+sodocno+"' ";
								  
								  System.out.println("======sqltax11========="+sqltax11);
								  
								  stmtss.executeUpdate(sqltax11);						 	
						 	
						 }

						  	Statement ssss1=conn.createStatement();
					  
							 String sql166=" select s.acno"
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
							 if(rstaxxx1.next())
							 {
								 
								 tax2acno=rstaxxx1.getInt("acno");
														 	
							 	
							 }
				  
								Statement ssss3=conn.createStatement();
								  
								 String sql311=" select s.acno "
										 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
										 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  " ;
							
								 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
								 if(rstaxxx3.next())
								 {
									 
									 tax3acno=rstaxxx3.getInt("acno");
															 	
								 	
								 }
					  
				  
				  
				  }
				 
				  
				  
				  
					  

				 
				 

				 
				 
				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){
 
						if(vocno>0)
						{
							
							
							
						
						 
				
							

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);

                            String gridlocation=""+(prod[15].equalsIgnoreCase("undefined") || prod[15].equalsIgnoreCase("") || prod[15].trim().equalsIgnoreCase("NaN")|| prod[15].isEmpty()?0:prod[15].trim())+"";

                          
                            
                            String taxper1=""+(prod[16].equalsIgnoreCase("undefined") || prod[16].equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].isEmpty()?0:prod[16].trim())+"";
                            String taxamount1=""+(prod[16].equalsIgnoreCase("undefined") || prod[16].equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].isEmpty()?0:prod[16].trim())+"";
                       	 
							 String allowdiscount=""+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")|| prod[18].isEmpty()?0:prod[18].trim())+"";
							 
                            double taxper=0;
                            double taxamount=0;
                            
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
							
							String loc="";
							 
							
							int locids=0;
							
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
							if(rreftype.equalsIgnoreCase("SOR")){                // aaaaaa
							/*	qty_fld="rsv_qty";
							 
								slquery="(out_qty+del_qty)";*/
								qty_fld="out_qty";	
								slquery="(out_qty+rsv_qty+del_qty)";
								
							}
							if(rreftype.equalsIgnoreCase("JOR")){                // aaaaaa
								qty_fld="rsv_qty";
								 
									slquery="(out_qty+del_qty)";
									 
									
								}
							
							else if(rreftype.equalsIgnoreCase("DEL")){
								qty_fld="del_qty";
								 qryapnd="and locid="+gridlocation+"";
								slquery="(out_qty+rsv_qty)";
							}
							else if(rreftype.equalsIgnoreCase("DIR")){
								qty_fld="out_qty";
								//qryapnd="and cost_price="+unitprice+"";
								//qryapnd="and stockid="+stkid+"";
								slquery="(out_qty+rsv_qty+del_qty)";
								
								loc="and locid="+locationid+" ";
								 
							}

							


							Statement stmtstk=conn.createStatement();

							String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "+loc+"  "
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
								 
								
								
								refqty=masterqty;
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);

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

									if(rreftype.equalsIgnoreCase("SOR")){
									/*	qty_fld="rsv_qty";
										tmp_qty=qty-masterqty;
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	*/
									}
									else if(rreftype.equalsIgnoreCase("DEL")){
										qty_fld="del_qty";
										tmp_qty=qty-masterqty;
										
										if(tmp_qty<=0)
										{
											tmp_qty=0;
										}
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	
									  
										
									}
									
									else if(rreftype.equalsIgnoreCase("JOR")){
									qty_fld="rsv_qty";
										tmp_qty=qty-masterqty;
										if(tmp_qty<=0)
										{
											tmp_qty=0;
										}
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	
									}
									
									
									System.out.println("-----queryappnd-----"+queryappnd);
									

									masterqty=masterqty+outqtys;
 
									
									
									String sqls="update my_prddin set out_qty="+masterqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"   ";
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

									if(rreftype.equalsIgnoreCase("SOR")){               
									/*	qty_fld="rsv_qty";
										tmp_qty=qty-balstkqty;
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	*/
									}
									else if(rreftype.equalsIgnoreCase("DEL")){
										qty_fld="del_qty";
										tmp_qty=qty-balstkqty;
										queryappnd=","+qty_fld+"="+tmp_qty+"";	
									  
										
									}
									else if(rreftype.equalsIgnoreCase("JOR")){               
										 qty_fld="rsv_qty";
											tmp_qty=qty-balstkqty;
											
											if(tmp_qty<=0)
											{
												tmp_qty=0;
											}
											
											queryappnd=","+qty_fld+"="+tmp_qty+"";	
										}
									
									
									String sqls="update my_prddin set out_qty="+balstkqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remstkqty=masterqty-stkqty;



								}



								Double NtWtKG=0.0;
								Double KGPrice=0.0;
								Double total=0.0;
								Double discper=0.0;
								Double discount=0.0;
								Double netotal=0.0;
								
								//prddout case
								
								Double outnetotal=0.0;
								
								
								Double nettaxamount=0.0;
								
								NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								total=detqty*unitprice;
								discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
									 
															 
								 discount=(total*discper)/100; 
								 
								// discount=Double.parseDouble(""+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"");
								
								 
								 netotal=total-discount;
							//prddout case
								 outnetotal=netotal/detqty;
								 
								 if(taxmethod>0)
									{
										  
		                           taxper=Double.parseDouble(taxper1);
		                           taxamount=netotal*(taxper/100);
		                           nettaxamount=netotal+taxamount;
									}
		/*						 System.out.println("==NtWtKG===="+NtWtKG);

									 System.out.println("==KGPrice===="+KGPrice);

									 System.out.println("==unitprice===="+unitprice);

									 System.out.println("==total===="+total);

									 System.out.println("==discper===="+discper);

									 System.out.println("==discount===="+discount);

									 System.out.println("==netotal===="+netotal); */


								String sql="insert into my_invd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,locid,taxper,taxamount,nettaxamount,allowdiscount)VALUES"
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
										+ "'"+netotal+"','"+locids+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"','"+allowdiscount+"')";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);

								String prodoutsql="";
                                
								String cost_prices="0";

								Statement stmtstk1=conn.createStatement();

								String stkSql1="select  cost_price  from my_prddin where stockid='"+stockid+"'";

								System.out.println("=stkSql1 select cost_price insert="+stkSql1);

								ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);

								if(rsstk1.next()) {
									cost_prices=rsstk1.getString("cost_price");
								}
								
								
								if(rreftype.equalsIgnoreCase("DIR") || rreftype.equalsIgnoreCase("SOR")){
									
									
									 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+date+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"',"+outnetotal+",'"+cost_prices+"')";

									
								}
								else{
									
									 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,"+qty_fld+",brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+date+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(detqty*-1)+"','"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+locids+","+outnetotal+",'"+cost_prices+"')";
									
								}
								
								

								System.out.println("prodoutsql----------------------------------------------->>>>Sql"+prodoutsql);
								
								prodout = stmt.executeUpdate (prodoutsql);
								System.out.println("masterqty--->>>>"+masterqty);
								System.out.println("balstkqty1--->>>>"+balstkqty1);
						 	if(masterqty<=balstkqty1)
								{
									break;
								} 

						 	/*if(rreftype.equalsIgnoreCase("SOR"))
							{
								System.out.println("masterqty="+masterqty);
								System.out.println("balstkqty="+balstkqty);
								 if(masterqty<=balstkqty)
									{
										break;
									}

							}*/
							}



							if(rreftype.equalsIgnoreCase("DEL"))
							{
								
								
								
								

						 

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delm m  left join "
										+ "my_deld d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid="+gridlocation+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);

								balqty=0.0;
								balqty=0.0;
								qtys=0.0;
								remqty=0.0;
								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");


									System.out.println("---refqty-----"+refqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;


										String sqls="update my_deld set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_deld set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  







							}
							//refqty=0.0;
							if(rreftype.equalsIgnoreCase("SOR"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_sorderm m  left join "
										+ "my_sorderd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.clstatus=0 group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");

								//	refqty=masterqty;
									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;


										String sqls="update my_sorderd set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_sorderd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  



							}


							if(rreftype.equalsIgnoreCase("JOR"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_joborderm m  left join "
										+ "my_joborderd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.status=2 group by d.rowno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.rowno";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");

								//	refqty=masterqty;
									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;


										String sqls="update my_joborderd set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and status=2";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_joborderd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and status=2";	
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
					if(!(sorderarray[7].trim().equalsIgnoreCase("undefined")|| sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()))
					{

						String sql="INSERT INTO my_invdser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
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
				
				
				String updatesql="update my_invm set shipdetid='"+shipdocno+"' where doc_no='"+sodocno+"' ";
				
				stmt.executeUpdate (updatesql);
				

				String descs="Sales INV-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INV"+""+vocno;



//=====1

				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;
				
				if(modepay.equalsIgnoreCase("cash")){
					
				String sql29="select  acno from my_account where codeno='CASHACSALES' ";
			System.out.println("-----4--sql2----"+sql29) ;

				ResultSet tass19 = stmt.executeQuery (sql29);

				if (tass19.next()) {

					clientaccount=tass19.getInt("acno");		

				}
				}
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt); 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				
				
				//=====2
				
				String expcurrid="1"; 
				double exprate=1;
				for(int i=0;i< servarray.size();i++){

					String[] singleexparray=((String) servarray.get(i)).split("::");
					if(!(singleexparray[7].trim().equalsIgnoreCase("undefined")|| singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()))
					{


						String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
						String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 

						String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet rsexp = stmt.executeQuery (sqlsexp);
						if(rsexp.next()) {

							expcurrid=rsexp.getString("curid");	


						}


						String expcurrencytype="";
						String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
						//System.out.println("-----2--sqlss----"+sqlss) ;
						ResultSet rsexpx = stmt.executeQuery(sqlexpselect);

						while (rsexpx.next()) {

							exprate=rsexpx.getDouble("rate");
							expcurrencytype=rsexpx.getString("type");

						}

						double	expdramount=Double.parseDouble(exptotaldramounts)*-1; 


						double expldramount=0;
						if(expcurrencytype.equalsIgnoreCase("D"))
						{


							expldramount=expdramount/exprate;  
						}

						else
						{
							expldramount=expdramount*exprate;  
						}



						String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,-1,4,0,0,0,'"+exprate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						System.out.println("--sql1----"+sql1);
						int sss = stmt.executeUpdate(sql1s);

						if(sss<=0)
						{
							conn.close();
							return 0;

						}



					}

				}






				//=====3
				
				
				
				
				int acnos1=0;
				String curris1="1";
				double rates1=1;

				String sql21="";
				if(modepay.equalsIgnoreCase("credit")){
					 sql21="select  acno from my_account where codeno='SALESCR' ";
				}
				if(modepay.equalsIgnoreCase("cash")){
					 sql21="select  acno from my_account where codeno='SALESCH' ";
				}
				
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal)*-1;
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
				
				
				

				
				

/*				int acnos1=0;
				String curris1="1";
				double rates1=1;

				String sql21="";
				if(modepay.equalsIgnoreCase("credit")){
					 sql21="select  acno from my_account where codeno='SALESCR' ";
				}
				if(modepay.equalsIgnoreCase("cash")){
					 sql21="select  acno from my_account where codeno='SALESCH' ";
				}
				
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal)*-1;
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
				*/
				
				String totalcostval="0";
				String s="select sum(a.totalvals) totalvals,a.tr_no from (select cost_price*qty totalvals,tr_no from my_prddout where  tr_no="+trno+" group by doc_no) a group by a.tr_no ";
	 
				System.out.println("-totalvalsssssssssssssssssssssssssss----"+s) ;

				ResultSet tcosts = stmt.executeQuery (s);

				if (tcosts.next()) {

					totalcostval=tcosts.getString("totalvals");		

				}

 
				
				
				//=====4
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
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(totalcostval)*-1;
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,4,0,0,0,'"+rates+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}
// ==5
				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 

				double pricetottal2=Double.parseDouble(totalcostval);
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,4,0,0,0,'"+rates2+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}


				
				
				
				//tax
				
				if(taxmethod>0)
				{
					
					
					
					//client part

					String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet tax1sql = stmt.executeQuery (ggg);
					if(tax1sql.next()) {

						vendorcur=tax1sql.getString("curid");	


					}

     
					String taxcurrencytype1="";
					String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--dddd----"+dddd) ;
					ResultSet resultSet = stmt.executeQuery(dddd);

					while (resultSet.next()) {
						venrate=resultSet.getDouble("rate");
						taxcurrencytype1=resultSet.getString("type");
					}

					double	dramounts=nettax; 


					double ldramountss=0;
					if(taxcurrencytype1.equalsIgnoreCase("D"))
					{


						ldramountss=dramounts/venrate ;  
					}

					else
					{
						ldramountss=dramounts*venrate ;  
					}



					String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

					//	System.out.println("--sql1----"+sql1);
					int ss1111 = stmt.executeUpdate(rdse);

					if(ss1111<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					
					
					
					
					
					
					
					// total tax amount  int stacno=0;
					System.out.println("=========================stacno===================================="+stacno);
					
					
					String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet t1sql1 = stmt.executeQuery(lll);
					if(t1sql1.next()) {

						vendorcur=t1sql1.getString("curid");	


					}

     
					String taxcurre="";
					String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--ppp----"+ppp) ;
					ResultSet r1 = stmt.executeQuery(ppp);

					while (r1.next()) {
						venrate=r1.getDouble("rate");
						taxcurre=r1.getString("type");
					}

					double	dramt=stval*-1; 


					double ldramt=0;
					if(taxcurre.equalsIgnoreCase("D"))
					{


						ldramt=dramt/venrate;  
					}

					else
					{
						ldramt=dramt*venrate;  
					}



					String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

					//	System.out.println("--sql1----"+sql1);
					int aa = stmt.executeUpdate(sltax11);

					if(aa<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					// tax1acno tax 1

					
				 
					
					
					if(tax1acno>0)
					{
						System.out.println("=========================tax1acno===================================="+tax1acno);
						String tsqls="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax1acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tsqlsa = stmt.executeQuery(tsqls);
						if(tsqlsa.next()) {

							vendorcur=tsqlsa.getString("curid");	


						}

	     
						String taxcur="";
						String sqlvenslect111 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenslect111----"+sqlvenslect111) ;
						ResultSet r11 = stmt.executeQuery(sqlvenslect111);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur=r11.getString("type");
						}

						double	dramt1=tax1*-1; 


						double ldramt1=0;
						if(taxcur.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String sqlax111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax1acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(sqlax111);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					if(tax2acno>0)
					{
						
						
						System.out.println("=========================tax2acno===================================="+tax2acno);
						
						
						String sqlstax10111="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax2acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql111 = stmt.executeQuery(sqlstax10111);
						if(tax1sql111.next()) {

							vendorcur=tax1sql111.getString("curid");	


						}

	     
						String taxcur1="";
						String gjjj = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--gjjj----"+gjjj) ;
						ResultSet r11 = stmt.executeQuery(gjjj);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur1=r11.getString("type");
						}

						double	dramt1=tax2*-1; 


						double ldramt1=0;
						if(taxcur1.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String oops="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax2acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(oops);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					
					if(tax3acno>0)
					{
						System.out.println("=========================tax3acno===================================="+tax3acno);
						String pyy="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax3acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql1111 = stmt.executeQuery(pyy);
						if(tax1sql1111.next()) {

							vendorcur=tax1sql1111.getString("curid");	


						}

	     
						String taxcur2="";
						String ttt = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenselect----"+ttt) ;
						ResultSet r111 = stmt.executeQuery(ttt);

						while (r111.next()) {
							venrate=r111.getDouble("rate");
							taxcur2=r111.getString("type");
						}

						double	dramt1=tax3*-1; 


						double ldramt1=0;
						if(taxcur2.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String eee="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax3acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(eee);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					
					
					
					
					
				}
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{

					System.out.println("--iiiiiiiinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn---") ;
					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql22----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',4,0,0,0,'"+adjustcurrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}




				}




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

	public  ClsBranchInvoiceBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select  m.billtype,m.totaltax,m.tax1,m.tax2,m.tax3,m.nettotaltax ,m.shipdetid, if(sh.type=0,sh.clname,ac1.refname) clname,  sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax,"
					+ " m.delterms,m.pricegroup,m.duedate,m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,"
					+ " cr.c_rate as curate,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,"
					+ " coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid, "
					+ " coalesce(s.sal_name,'') as sal_name,round(m.amount,2) as proamt,round(m.discount,2)  as discount,round(m.netAmount,2) as netotal, "
					+ " round(m.disper,2) as discper,round(m.grantamt,2) as ordervalue,round(m.servamt,2) as servamt,round(m.roundof,2) as roundof,m.pricegroup,l.loc_name,m.locid "
					+ "from my_invm m  left join my_locm l on(l.doc_no=m.locid) "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ "left join my_salm s on(s.doc_no=m.sal_id) left join my_curr cr on(m.curid=cr.doc_no)"
					+ " left join my_shipdetails sh on sh.doc_no=m.shipdetid and sh.type>0 "
					+ "  left join my_acbook ac1 on(ac1.doc_no=sh.cldocno and ac1.dtype='CRM') "
					+ " where m.doc_no="+docno+" and m.brhid="+branchid+"");

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
				
				
				
				bean.setPayDueDate(rs.getString("duedate"));
				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setDate(rs.getString("date"));
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
				bean.setProdsearchtype(rs.getString("ref_type")=="DIR"?"0":"2");
				bean.setTxtpaymentterms(rs.getString("payterms"));
				bean.setTxtdescription(rs.getString("descrptn"));
				bean.setTxtproductamt(rs.getString("proamt"));
				bean.setTxtdiscount(rs.getString("discount"));
				bean.setDescPercentage(rs.getString("discper"));
				bean.setRoundOf(rs.getString("roundof"));
				bean.setTxtnettotal(rs.getString("netotal"));
				bean.setNettotal(rs.getString("servamt"));
				bean.setOrderValue(rs.getString("ordervalue"));
				bean.setCmbprice(rs.getString("pricegroup"));
				bean.setLocationid(rs.getInt("locid"));
				bean.setTxtlocation(rs.getString("loc_name"));
				
				bean.setTxtdelterms(rs.getString("delterms"));
				
				
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
			if(dtype.equalsIgnoreCase("SOR"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_sorderm where doc_no in ("+sqot+")";
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
			else if(dtype.equalsIgnoreCase("DEL"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_delm where doc_no in ("+sqot+") ";
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

			else if(dtype.equalsIgnoreCase("JOR"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_joborderm where doc_no in ("+sqot+") ";
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



	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,
			ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,
			java.sql.Date payduedate,int locationid,String modepay,String updatadata,String deltems, ArrayList<String> shiparray,int shipdocno
			, double stval, double tax1, double tax2, double tax3, double nettax, int cmbbilltype) throws SQLException{

		Connection conn=null;
		int sodocno=0;
		conn=ClsConnection.getMyConnection();
		int tranid=0;
		try{

			if(modepay.equalsIgnoreCase("cash")){
				tranid=1;
			}
			else if(modepay.equalsIgnoreCase("credit")){
				tranid=2;
			}
			
			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(30, java.sql.Types.VARCHAR);
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
			stmt.setInt(23, 0);
			stmt.setDate(24,payduedate);
			stmt.setInt(25,locationid);
			stmt.setInt(26,tranid);
			stmt.setInt(27, doc_no);
			stmt.setInt(28, Integer.parseInt(voc_no));
			
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			
			if(val<=0)
			{
				conn.close();
				return 0;
				
			}
			
			 Statement stmtss=conn.createStatement();
			 String sqlsu= "update my_invm set delterms='"+deltems+"',ftype=1  where doc_no='"+sodocno+"' ";
			 System.out.println("==========sqlsu======"+sqlsu);
			 stmtss.executeUpdate(sqlsu);
			
			if(vocno>0){
				System.out.println("==========updatadata======"+updatadata);
				
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{	
					System.out.println("==========IN===================");
				int prodet=0;
				int prodout=0;
				
				
				
				
				
				//tax
				int taxmethod=0;
				 Statement stmttax=conn.createStatement();

				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }

				 int stacno=0;
				 int tax1acno=0;
				 int tax2acno=0;
				 int tax3acno=0;
				 
				 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_invm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sodocno+"' ";
					  
					  System.out.println("======sqltax1========="+sqltax1);
					  
					  stmtss.executeUpdate(sqltax1);
				
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

						 
					 
					  
					  	Statement ssss10=conn.createStatement();
				  
						 String sql10="  select acno,value from gl_taxmaster where doc_no=(select max(doc_no) tdocno from gl_taxmaster where  "
						 		+ "  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and provid='"+prvdocno+"'  )  and status=3 and type=1 and provid='"+prvdocno+"'  " ;
					
						 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
						 if(rstaxxx101.next())
						 {
							 
							 stacno=rstaxxx101.getInt("acno");
							
													 	
						 	
						 }

					  
					  	Statement ssss=conn.createStatement();
				  
						 String sql100=" select s.acno,s.value "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							 tax1acno=rstaxxx.getInt("acno");
							 	typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_invm set typeoftax='"+typeoftax+"'    where doc_no='"+sodocno+"' ";
								  
								  System.out.println("======sqltax11========="+sqltax11);
								  
								  stmtss.executeUpdate(sqltax11);						 	
						 	
						 }

						  	Statement ssss1=conn.createStatement();
					  
							 String sql166=" select s.acno"
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
							 if(rstaxxx1.next())
							 {
								 
								 tax2acno=rstaxxx1.getInt("acno");
														 	
							 	
							 }
				  
								Statement ssss3=conn.createStatement();
								  
								 String sql311=" select s.acno "
										 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
										 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  " ;
							
								 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
								 if(rstaxxx3.next())
								 {
									 
									 tax3acno=rstaxxx3.getInt("acno");
															 	
								 	
								 }
					  
				  
				  
				  }
				 
				  
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


						if(vocno>0)
						{
						 	System.out.println("-----rreftype----"+rreftype);
							
						
								
								if(i==0)
								{
									if(rreftype.equalsIgnoreCase("DIR") || rreftype.equalsIgnoreCase("SOR"))
									{				
									
									System.out.println("----i----"+i);
		        int counts=0;							
		        String tempstk="0";	
		        
		        int stkids=0;
		        
		        String tempstkids="0";
		      
				double chkqtys=0;	
				double prdqty=0;

				double saveqty=0;
				int tmptrno=0;
				
				int prdidss=0;

				String sql9="select count(*) tmpcount from my_invd where rdocno='"+sodocno+"'"	;				
		 
		 	System.out.println("-----sql9-----"+sql9);
				
				ResultSet rsstk11 = stmt.executeQuery(sql9);

				
				if(rsstk11.next())
				{
					counts=rsstk11.getInt("tmpcount");
				}
				
				Statement st=conn.createStatement();
			     for(int m=0;m<=counts;m++)
			     {
			    	 
			    	String sql2="select stockid,qty,prdid,tr_no from my_invd where rdocno='"+sodocno+"' and stockid not in("+tempstk+") group by stockid limit 1";
			    	System.out.println("-----sql2-----"+sql2);
			    	ResultSet rsstk111 = stmt.executeQuery(sql2);
			    	
			    	
			    	if(rsstk111.next())
			    	{
			    		chkqtys=rsstk111.getDouble("qty");
			    		stkids=rsstk111.getInt("stockid");
			    		prdidss=rsstk111.getInt("prdid");
			    		tmptrno=rsstk111.getInt("tr_no");
			    	
			    	
			    	String sql3=" select out_qty   prdqty  from my_prddin where stockid='"+stkids+"'";
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
			    	}

			    	 
			     }
		 


 
									}
									
									
				 else if(rreftype.equalsIgnoreCase("DEL"))
					 	{	
					 
				        int counts=0;							
				        String tempstk="0";	
				        
				        int stkids=0;
				        
				        String tempstkids="0";
				      
						double chkqtys=0;	
						double prdqty=0;
						double delqtys=0;
						double saveqty=0;
						int tmptrno=0;
						double delqtyssave=0;
						int prdidss=0;
						
						int locidss=0;

						String sql9="select count(*) tmpcount from my_invd where rdocno='"+sodocno+"'"	;				
				 
				 	System.out.println("-----sql9-----"+sql9);
						
						ResultSet rsstk11 = stmt.executeQuery(sql9);

						
						if(rsstk11.next())
						{
							counts=rsstk11.getInt("tmpcount");
						}
						
						Statement st=conn.createStatement();
					     for(int m=0;m<=counts;m++)
					     {
					    	 
					    	String sql2="select stockid,qty,prdid,tr_no,locid from my_invd where rdocno='"+sodocno+"' and stockid not in("+tempstk+") group by stockid limit 1";
					    	System.out.println("-----sql2-----"+sql2);
					    	ResultSet rsstk111 = stmt.executeQuery(sql2);
					    	
					    	
					    	if(rsstk111.next())
					    	{
					    		chkqtys=rsstk111.getDouble("qty");
					    		stkids=rsstk111.getInt("stockid");
					    		prdidss=rsstk111.getInt("prdid");
					    		tmptrno=rsstk111.getInt("tr_no");
					    		locidss=rsstk111.getInt("locid");
					    	
					    		
				 
					    	 
					    		
					    		
					    		
					    	String sql3=" select out_qty   prdqty,del_qty   from my_prddin where stockid='"+stkids+"'";
					    	 System.out.println("-----sql3-----"+sql3);
					    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
					    	
					    	
					    	if(rsstk1111.next())
					    	{
					    		prdqty=rsstk1111.getDouble("prdqty");
					    		delqtys=rsstk1111.getDouble("del_qty");
					    		
						    	saveqty=prdqty-chkqtys;
						    	delqtyssave=delqtys+chkqtys;
						    	if(saveqty<0){
						    	saveqty=0;
						    	
						    	}
						    	
						    	if(delqtyssave<0){
						    		delqtyssave=0;
							    	
							    	}
						    	
						    	
						      	String sql31="update my_prddin set out_qty="+saveqty+",del_qty="+delqtyssave+" where stockid='"+stkids+"'";
						    	 System.out.println("-----sql31-----"+sql31);
						    	 stmt.executeUpdate(sql31);
						    	 
						    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locidss+"  ";
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
				 	 
					 
					 
					 
					 	}
					
									
									
									
									
									
				 else if(rreftype.equalsIgnoreCase("JOR"))
					 	{	
					 
				        int counts=0;							
				        String tempstk="0";	
				        
				        int stkids=0;
				        
				        String tempstkids="0";
				      
						double chkqtys=0;	
						double prdqty=0;
						double delqtys=0;
						double saveqty=0;
						int tmptrno=0;
						double delqtyssave=0;
						int prdidss=0;
						
						int locidss=0;

						String sql9="select count(*) tmpcount from my_invd where rdocno='"+sodocno+"'"	;				
				 
				 	System.out.println("-----sql9-----"+sql9);
						
						ResultSet rsstk11 = stmt.executeQuery(sql9);

						
						if(rsstk11.next())
						{
							counts=rsstk11.getInt("tmpcount");
						}
						
						Statement st=conn.createStatement();
					     for(int m=0;m<=counts;m++)
					     {
					    	 
					    	String sql2="select stockid,qty,prdid,tr_no,locid from my_invd where rdocno='"+sodocno+"' and stockid not in("+tempstk+") group by stockid limit 1";
					    	System.out.println("-----sql2-----"+sql2);
					    	ResultSet rsstk111 = stmt.executeQuery(sql2);
					    	
					    	
					    	if(rsstk111.next())
					    	{
					    		chkqtys=rsstk111.getDouble("qty");
					    		stkids=rsstk111.getInt("stockid");
					    		prdidss=rsstk111.getInt("prdid");
					    		tmptrno=rsstk111.getInt("tr_no");
					    		locidss=rsstk111.getInt("locid");
					    	
					    		
				 
					    	 
					    		
					    		
					    		
					    	String sql3=" select out_qty   prdqty,rsv_qty del_qty   from my_prddin where stockid='"+stkids+"'";
					    	 System.out.println("-----sql3-----"+sql3);
					    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
					    	
					    	
					    	if(rsstk1111.next())
					    	{
					    		prdqty=rsstk1111.getDouble("prdqty");
					    		delqtys=rsstk1111.getDouble("del_qty");
					    		
						    	saveqty=prdqty-chkqtys;
						    	delqtyssave=delqtys+chkqtys;
						    	if(saveqty<0){
						    	saveqty=0;
						    	
						    	}
						    	
						    	if(delqtyssave<0){
						    		delqtyssave=0;
							    	
							    	}
						    	
						    	
						      	String sql31="update my_prddin set out_qty="+saveqty+",rsv_qty="+delqtyssave+" where stockid='"+stkids+"'";
						    	 System.out.println("-----sql31-----"+sql31);
						    	 stmt.executeUpdate(sql31);
						    	 
						    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locidss+"  ";
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
				 	 
					 
					 
					 
					 	}
									
									
									
									
		    	 
		    	      String dql31="delete from my_invd where rdocno='"+sodocno+"'";
		    	      
		    	      System.out.println("-------dql31-----"+dql31);
		    	      
		    	 	  stmt.executeUpdate(dql31);
		    	 	 String dql32="delete from my_invdser where rdocno='"+sodocno+"'";
		    	 	 
		    	 	// System.out.println("-------dql32-----"+dql32);
		    	 	 stmt.executeUpdate(dql32);
		   	 	 
		    	 	 String dql33= "delete from my_trterms where rdocno='"+sodocno+"' and dtype='"+formcode+"' ";
		    	 	 
		    		// System.out.println("-------dql33-----"+dql33);
		    	 	 
		    	 	 stmt.executeUpdate(dql33);
		    	 	 String dql34= "delete from my_jvtran where tr_no='"+trno+"'  ";
		    	 	 
		    	 	 
		    		// System.out.println("-------dql34-----"+dql34);
		    	 	 stmt.executeUpdate(dql34);
		    			
		    	 	 String deltermssqls="delete from my_deldetaild where rdocno='"+sodocno+"' and  dtype='"+formcode+"'  ";
			    	 	stmt.executeUpdate(deltermssqls);
		    					
								
								
								
							}
							
							
							
							
							
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);

							   String gridlocation=""+(prod[15].equalsIgnoreCase("undefined") || prod[15].equalsIgnoreCase("") || prod[15].trim().equalsIgnoreCase("NaN")|| prod[15].isEmpty()?0:prod[15].trim())+"";

							   
				               String taxper1=""+(prod[16].equalsIgnoreCase("undefined") || prod[16].equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].isEmpty()?0:prod[16].trim())+"";
	                            String taxamount1=""+(prod[16].equalsIgnoreCase("undefined") || prod[16].equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].isEmpty()?0:prod[16].trim())+"";
	                       	 
								 String allowdiscount=""+(prod[18].trim().equalsIgnoreCase("undefined") || prod[18].trim().equalsIgnoreCase("") || prod[18].trim().equalsIgnoreCase("NaN")|| prod[18].isEmpty()?0:prod[18].trim())+"";
								 
					              double taxper=0;
		                            double taxamount=0;
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
							String qty_fld="";
							String qryapnd="";
							double refqty=0.0;
							int locids=0;
							String loc="";
							String slquery="";
							double balstkqty1=0;
						 	double outqty=Double.parseDouble(""+(prod[11].equalsIgnoreCase("undefined") || prod[11].equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"");
							
						 	double oldqty=Double.parseDouble(""+(prod[13].equalsIgnoreCase("undefined") || prod[13].equalsIgnoreCase("") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].isEmpty()?0:prod[13].trim())+"");
							refqty=(outqty-oldqty)+masterqty;
							
							
							 
							
							
							if(rreftype.equalsIgnoreCase("SOR")){             // aaaaaa
							/*	qty_fld="rsv_qty";
								 
								slquery="(out_qty+del_qty)";*/
								qty_fld="out_qty";	
								slquery="(out_qty+rsv_qty+del_qty)";	
								 
								
							}
							
							if(rreftype.equalsIgnoreCase("JOR")){                // aaaaaa
								qty_fld="rsv_qty";
								 
									slquery="(out_qty+del_qty)";
									 
									
								}
							else if(rreftype.equalsIgnoreCase("DEL")){
								qty_fld="del_qty";
								 qryapnd="and locid="+gridlocation+"";
								slquery="(out_qty+rsv_qty)";
							}
							else if(rreftype.equalsIgnoreCase("DIR")){
								qty_fld="out_qty";
								//qryapnd="and cost_price="+unitprice+"";
								//qryapnd="and stockid="+stkid+"";
								slquery="(out_qty+rsv_qty+del_qty)";
								loc="and locid="+locationid+" ";
							}

							
							
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");


							Statement stmtstk=conn.createStatement();
/*
							String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locationid+" "
									+ "group by stockid,cost_price,prdid,psrno  order by date,stockid";*/
							
							String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "+loc+" "
									+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-"+slquery+"))>0 order by date,stockid";

							/*having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0*/
							
							System.out.println("=stkSql=inside insert="+stkSql);

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

									if(rreftype.equalsIgnoreCase("SOR")){
									/*	qty_fld="rsv_qty";
										tmp_qty=qty-masterqty;
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	*/
									}
									else if(rreftype.equalsIgnoreCase("DEL")){
										qty_fld="del_qty";
										tmp_qty=qty-masterqty;
										
										if(tmp_qty<=0)
										{
											tmp_qty=0;
										}
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	
									  
										
									}
									else if(rreftype.equalsIgnoreCase("JOR")){
										qty_fld="rsv_qty";
											tmp_qty=qty-masterqty;
											if(tmp_qty<=0)
											{
												tmp_qty=0;
											}
											
											queryappnd=","+qty_fld+"="+tmp_qty+"";	
										}
									
									
									masterqty=masterqty+outqtys;


							 
									String sqls="update my_prddin set out_qty="+masterqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"   ";
									
								//	String sqls="update my_prddin set out_qty="+masterqty+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									//break;
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

									
									if(rreftype.equalsIgnoreCase("SOR")){
								/*		qty_fld="rsv_qty";
										tmp_qty=qty-balstkqty;
										
										queryappnd=","+qty_fld+"="+tmp_qty+"";	*/
									}
									else if(rreftype.equalsIgnoreCase("DEL")){
										qty_fld="del_qty";
										tmp_qty=qty-balstkqty;
										queryappnd=","+qty_fld+"="+tmp_qty+"";	
									  
										
									}
									else if(rreftype.equalsIgnoreCase("JOR")){               
										 qty_fld="rsv_qty";
											tmp_qty=qty-balstkqty;
											
											if(tmp_qty<=0)
											{
												tmp_qty=0;
											}
											
											queryappnd=","+qty_fld+"="+tmp_qty+"";	
										}
									
									String sqls="update my_prddin set out_qty="+balstkqty+" "+queryappnd+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
								//	String sqls="update my_prddin set out_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and  brhid="+session.getAttribute("BRANCHID").toString()+" and locid="+locids+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remstkqty=masterqty-stkqty;



								}



								Double NtWtKG=0.0;
								Double KGPrice=0.0;
								Double total=0.0;
								Double discper=0.0;
								Double discount=0.0;
								Double netotal=0.0;
								Double nettaxamount=0.0;
								
		//prddout case
								
								Double outnetotal=0.0;
								
								
								NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								total=detqty*unitprice;
								discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								//
								 discount=(total*discper)/100;
								
								//discount=Double.parseDouble(""+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"");
								netotal=total-discount;

								//prddout case
								 outnetotal=netotal/detqty;
								 
								 if(taxmethod>0)
									{
										  
		                           taxper=Double.parseDouble(taxper1);
		                           taxamount=netotal*(taxper/100);
		                           nettaxamount=netotal+taxamount;
									}
								
								 System.out.println("==NtWtKG===="+NtWtKG);

									 System.out.println("==KGPrice===="+KGPrice);

									 System.out.println("==unitprice===="+unitprice);

									 System.out.println("==total===="+total);

									 System.out.println("==discper===="+discper);

									 System.out.println("==discount===="+discount);

									 System.out.println("==netotal===="+netotal); 


								String sql="insert into my_invd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,locid,taxper,taxamount,nettaxamount,allowdiscount)VALUES"
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
										+ "'"+netotal+"','"+locids+"','"+taxper+"','"+taxamount+"','"+nettaxamount+"','"+allowdiscount+"')";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);


								/*String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,qty,prdid,"+qty_fld+",brhid,locid) Values"
										+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
										+ "'"+stockid+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+detqty+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(detqty*-1)+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',0)";*/
								
								String prodoutsql="";
								
								
								String cost_prices="0";

								Statement stmtstk1=conn.createStatement();

								String stkSql1="select  cost_price  from my_prddin where stockid='"+stockid+"'";

								System.out.println("=stkSql1 select cost_price insert="+stkSql1);

								ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);

								if(rsstk1.next()) {
									cost_prices=rsstk1.getString("cost_price");
								}
								
								if(rreftype.equalsIgnoreCase("DIR")||rreftype.equalsIgnoreCase("SOR")){
									
									
									 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+date+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locids+"',"+outnetotal+",'"+cost_prices+"')";

									
								}
								else{
									
									 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,"+qty_fld+",brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+sodocno+","
											+ "'"+stockid+"',"
											+ "'"+date+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(detqty*-1)+"','"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+locids+","+outnetotal+",'"+cost_prices+"')";
									
								}
								

								System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
								prodout = stmt.executeUpdate (prodoutsql);

				 	           if(masterqty<=balstkqty1)
								{
									break;
								}


							/*	if(rreftype.equalsIgnoreCase("SOR"))
								{
									System.out.println("masterqty====="+masterqty);
									System.out.println("balstkqty======="+balstkqty);
									 if(masterqty<=balstkqty)
										{
											break;
										}

								}*/
								
								
							}



							if(rreftype.equalsIgnoreCase("DEL"))
							{

								
		                 	 int pridforchk=Integer.parseInt(prdid);
						    	 
								 String zerosqls=" update  my_delm m,my_deld d set    d.out_qty=0     where  m.doc_no = d.rdocno and d.prdid="+pridforchk+" and m.locid="+gridlocation+" and  d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" " ;
					    	 
					 			//String sqls="update  my_cusenqd set out_qty=0 where rdocno in ("+qotmasterdocno+") and prdid="+pridforchk+" and ";
			  
			    			//  System.out.println("-----"+sqls);
			    			   	
					 			stmt.executeUpdate(zerosqls);
								
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delm m  left join "
										+ "my_deld d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"'and m.locid="+gridlocation+" group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
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


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;
                                    

										String sqls="update my_deld set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_deld set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  







							}
						//	refqty=0.0;
							if(rreftype.equalsIgnoreCase("SOR"))  
							{

								
					          	 int pridforchk=Integer.parseInt(prdid);
						    	  
								 String zerosqls="update  my_sorderd set out_qty=0 where rdocno in ("+qotmasterdocno+") and prdid="+pridforchk+"  and clstatus=0 ";
								  
								   System.out.println("-----"+zerosqls);
								    			   	
								 stmt.executeUpdate(zerosqls);
								
								
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_sorderm m  left join "
										+ "my_sorderd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.clstatus=0 group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");

								//	refqty=masterqty;
									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;


										String sqls="update my_sorderd set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0 ";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_sorderd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0 ";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  






							}
							
							
							
							
							
							if(rreftype.equalsIgnoreCase("JOR"))
							{
								
					          	 int pridforchk=Integer.parseInt(prdid);
						    	  
								 String zerosqls="update  my_joborderd set out_qty=0 where rdocno in ("+qotmasterdocno+") and prdid="+pridforchk+" and  status=2 ";
								  
								   System.out.println("-----"+zerosqls);
								    			   	
								 stmt.executeUpdate(zerosqls);
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_joborderm m  left join "
										+ "my_joborderd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and d.status=2 group by d.rowno having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.rowno";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");

								//	refqty=masterqty;
									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										refqty=remqty;
									}


									if(refqty<=balqty)
									{
										refqty=refqty+out_qty;


										String sqls="update my_joborderd set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and status=2";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(refqty>balqty)
									{



										if(qtys>=(refqty+out_qty))

										{
											balqty=refqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=refqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_joborderd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docno+" and status=2";	
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
					if(!(sorderarray[7].trim().equalsIgnoreCase("undefined")|| sorderarray[7].trim().equalsIgnoreCase("NaN")||sorderarray[7].trim().equalsIgnoreCase("")|| sorderarray[7].isEmpty()))
					{

						String sql="INSERT INTO my_invdser(srno,qty,desc1,unitprice,total,discount,nettotal,acno,brhid,rdocno)VALUES"
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
				
				
				String updatesql="update my_invm set shipdetid='"+shipdocno+"' where doc_no='"+sodocno+"' ";
				
				stmt.executeUpdate (updatesql);

/*
				String descs="Sales INV-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INV"+""+vocno;





				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;
				
				if(modepay.equalsIgnoreCase("cash")){
					
					String sql29="select  acno from my_account where codeno='CASHACSALES' ";
					//System.out.println("-----4--sql2----"+sql2) ;

					ResultSet tass19 = stmt.executeQuery (sql29);

					if (tass19.next()) {

						clientaccount=tass19.getInt("acno");		

					}
					}
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//System.out.println("-----2--sqlss----"+sqlss) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				String expcurrid="1"; 
				double exprate=1;
				for(int i=0;i< servarray.size();i++){

					String[] singleexparray=((String) servarray.get(i)).split("::");
					if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
					{


						String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
						String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 

						String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet rsexp = stmt.executeQuery (sqlsexp);
						if(rsexp.next()) {

							expcurrid=rsexp.getString("curid");	


						}


						String expcurrencytype="";
						String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
						//System.out.println("-----2--sqlss----"+sqlss) ;
						ResultSet rsexpx = stmt.executeQuery(sqlexpselect);

						while (rsexpx.next()) {

							exprate=rsexpx.getDouble("rate");
							expcurrencytype=rsexpx.getString("type");

						}

						double	expdramount=Double.parseDouble(exptotaldramounts); 


						double expldramount=0;
						if(expcurrencytype.equalsIgnoreCase("D"))
						{


							expldramount=expdramount/exprate;  
						}

						else
						{
							expldramount=expdramount*exprate;  
						}



						String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,1,3,0,0,0,'"+exprate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						System.out.println("--sql1----"+sql1);
						int sss = stmt.executeUpdate(sql1s);

						if(sss<=0)
						{
							conn.close();
							return 0;

						}



					}

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
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(nettotal);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}



				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{


					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql2----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}
*/

				String descs="Sales INV-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INV"+""+vocno;



//========1

				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;
				
				if(modepay.equalsIgnoreCase("cash")){
					
				String sql29="select  acno from my_account where codeno='CASHACSALES' ";
			System.out.println("-----4--sql2----"+sql29) ;

				ResultSet tass19 = stmt.executeQuery (sql29);

				if (tass19.next()) {

					clientaccount=tass19.getInt("acno");		

				}
				}
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt); 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				
				
				
	//=======2			
				String expcurrid="1"; 
				double exprate=1;
				for(int i=0;i< servarray.size();i++){

					String[] singleexparray=((String) servarray.get(i)).split("::");
					if(!(singleexparray[7].trim().equalsIgnoreCase("undefined")|| singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()))
					{


						String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
						String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 

						String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet rsexp = stmt.executeQuery (sqlsexp);
						if(rsexp.next()) {

							expcurrid=rsexp.getString("curid");	


						}


						String expcurrencytype="";
						String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
						//System.out.println("-----2--sqlss----"+sqlss) ;
						ResultSet rsexpx = stmt.executeQuery(sqlexpselect);

						while (rsexpx.next()) {

							exprate=rsexpx.getDouble("rate");
							expcurrencytype=rsexpx.getString("type");

						}

						double	expdramount=Double.parseDouble(exptotaldramounts)*-1; 


						double expldramount=0;
						if(expcurrencytype.equalsIgnoreCase("D"))
						{


							expldramount=expdramount/exprate;  
						}

						else
						{
							expldramount=expdramount*exprate;  
						}



						String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,-1,4,0,0,0,'"+exprate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						System.out.println("--sql1----"+sql1);
						int sss = stmt.executeUpdate(sql1s);

						if(sss<=0)
						{
							conn.close();
							return 0;

						}



					}

				}


//======3
				
				
				

				int acnos1=0;
				String curris1="1";
				double rates1=1;

				String sql21="";
				if(modepay.equalsIgnoreCase("credit")){
					 sql21="select  acno from my_account where codeno='SALESCR' ";
				}
				if(modepay.equalsIgnoreCase("cash")){
					 sql21="select  acno from my_account where codeno='SALESCH' ";
				}
				
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal)*-1;
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
				


 			
		String totalcostval="0";
				
				String s="select sum(a.totalvals) totalvals,a.tr_no from (select cost_price*qty totalvals,tr_no from my_prddout where  tr_no="+trno+" group by doc_no) a group by a.tr_no ";
				System.out.println("-totalvalsssssssssssssssssssssssssss----"+s) ;

				ResultSet tcosts = stmt.executeQuery (s);

				if (tcosts.next()) {

					totalcostval=tcosts.getString("totalvals");		

				}

				//=======4	


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
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(totalcostval)*-1;
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,4,0,0,0,'"+rates+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}
				
				

				//=======5	
				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 

				double pricetottal2=Double.parseDouble(totalcostval);
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,4,0,0,0,'"+rates2+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}


				
				///tax part
				
				
				
				
				

				//tax
				
				if(taxmethod>0)
				{
					
					
					
					//client part

					String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet tax1sql = stmt.executeQuery (ggg);
					if(tax1sql.next()) {

						vendorcur=tax1sql.getString("curid");	


					}

     
					String taxcurrencytype1="";
					String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--dddd----"+dddd) ;
					ResultSet resultSet = stmt.executeQuery(dddd);

					while (resultSet.next()) {
						venrate=resultSet.getDouble("rate");
						taxcurrencytype1=resultSet.getString("type");
					}

					double	dramounts=nettax; 


					double ldramountss=0;
					if(taxcurrencytype1.equalsIgnoreCase("D"))
					{


						ldramountss=dramounts/venrate ;  
					}

					else
					{
						ldramountss=dramounts*venrate ;  
					}



					String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

					//	System.out.println("--sql1----"+sql1);
					int ss1111 = stmt.executeUpdate(rdse);

					if(ss1111<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					
					
					
					
					
					
					
					// total tax amount  int stacno=0;
					System.out.println("=========================stacno===================================="+stacno);
					
					
					String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
					ResultSet t1sql1 = stmt.executeQuery(lll);
					if(t1sql1.next()) {

						vendorcur=t1sql1.getString("curid");	


					}

     
					String taxcurre="";
					String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
					 System.out.println("-----2--ppp----"+ppp) ;
					ResultSet r1 = stmt.executeQuery(ppp);

					while (r1.next()) {
						venrate=r1.getDouble("rate");
						taxcurre=r1.getString("type");
					}

					double	dramt=stval*-1; 


					double ldramt=0;
					if(taxcurre.equalsIgnoreCase("D"))
					{


						ldramt=dramt/venrate;  
					}

					else
					{
						ldramt=dramt*venrate;  
					}



					String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

					//	System.out.println("--sql1----"+sql1);
					int aa = stmt.executeUpdate(sltax11);

					if(aa<=0)
					{
						conn.close();
						return 0;

					}
					
					
					
					// tax1acno tax 1

					
				 
					
					
					if(tax1acno>0)
					{
						System.out.println("=========================tax1acno===================================="+tax1acno);
						String tsqls="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax1acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tsqlsa = stmt.executeQuery(tsqls);
						if(tsqlsa.next()) {

							vendorcur=tsqlsa.getString("curid");	


						}

	     
						String taxcur="";
						String sqlvenslect111 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenslect111----"+sqlvenslect111) ;
						ResultSet r11 = stmt.executeQuery(sqlvenslect111);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur=r11.getString("type");
						}

						double	dramt1=tax1*-1; 


						double ldramt1=0;
						if(taxcur.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String sqlax111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax1acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(sqlax111);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					if(tax2acno>0)
					{
						
						
						System.out.println("=========================tax2acno===================================="+tax2acno);
						
						
						String sqlstax10111="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax2acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql111 = stmt.executeQuery(sqlstax10111);
						if(tax1sql111.next()) {

							vendorcur=tax1sql111.getString("curid");	


						}

	     
						String taxcur1="";
						String gjjj = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--gjjj----"+gjjj) ;
						ResultSet r11 = stmt.executeQuery(gjjj);

						while (r11.next()) {
							venrate=r11.getDouble("rate");
							taxcur1=r11.getString("type");
						}

						double	dramt1=tax2*-1; 


						double ldramt1=0;
						if(taxcur1.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String oops="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax2acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(oops);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					
					if(tax3acno>0)
					{
						System.out.println("=========================tax3acno===================================="+tax3acno);
						String pyy="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax3acno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql1111 = stmt.executeQuery(pyy);
						if(tax1sql1111.next()) {

							vendorcur=tax1sql1111.getString("curid");	


						}

	     
						String taxcur2="";
						String ttt = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--sqlvenselect----"+ttt) ;
						ResultSet r111 = stmt.executeQuery(ttt);

						while (r111.next()) {
							venrate=r111.getDouble("rate");
							taxcur2=r111.getString("type");
						}

						double	dramt1=tax3*-1; 


						double ldramt1=0;
						if(taxcur2.equalsIgnoreCase("D"))
						{


							ldramt1=dramt1/venrate ;  
						}

						else
						{
							ldramt1=dramt1*venrate ;  
						}



						String eee="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+tax3acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa1 = stmt.executeUpdate(eee);

						if(aa1<=0)
						{
							conn.close();
							return 0;

						}
						
					
					}
					
					
					
					
					
					
					
					
					
					
					
				}
				
				
				
				
				
				
				
				
				 
				
				
				
				
				
				
				
				
				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{


					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql22----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',4,0,0,0,'"+adjustcurrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}



				}




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

			CallableStatement stmt = conn.prepareCall("{CALL saleInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


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

						String sql="INSERT INTO my_invdser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno)VALUES"
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
			String pySql=("select srno,desc1 description,unitprice price,qty,total,discount,nettotal,ir.acno as acno,h.description as account from my_invdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno='"+docno+"' ");
			System.out.println("====srv===="+pySql);
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

	
	 public    ClsBranchInvoiceBean getPrint(int docno, HttpServletRequest request,String formcode) throws SQLException {
		 ClsBranchInvoiceBean bean = new ClsBranchInvoiceBean();
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
			/*    int type=2;
				 
				 if(formcode.equalsIgnoreCase("CASH"))
				 {
					 type=1;
					 
				 }
				    
				*/
				String rdtype="";
				String  dtype="INV";
				String resql=("select m.dtype, m.shipdetid, if(sh.type=0,sh.clname,ac1.refname) clname,  sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
						+ " cu.country_name,ac.address,ac.per_mob ,ar.area,m.paymode,l.loc_name location,coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno,if(m.ref_type='DIR','Direct',if(m.ref_type='DEL','Delivery Note','Sales Order')) type, "
						+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,DATE_FORMAT(m.duedate,'%d.%m.%Y') AS duedate,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
						+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
				+ "  from my_invm m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id"
				+ " left join my_locm l on l.doc_no=m.locid left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'   "
				+ " left join my_area ar on ar.doc_no=ac.area_id left join my_acountry cu on cu.doc_no=ar.country_id "
				+ " left join my_shipdetails sh on sh.doc_no=m.shipdetid and sh.type>0  left join my_acbook ac1 on(ac1.doc_no=sh.cldocno and ac1.dtype='CRM') "
				+ " where   m.doc_no='"+docno+"' and m.ftype=1  ");
				
				 
			 System.out.println("---resql----"+resql);
				
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
			    	    bean.setLbllocation1(pintrs.getString("location"));
			    	    
			    	    rdtype=pintrs.getString("rdtype");
			    	    			    	    
			    	    bean.setLblduedate(pintrs.getString("duedate"));
			    	    
			    	    
			    	 //   bean.setExpdeldate(pintrs.getString("deldate"));
			    	    
		/*	    	 
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			            
			    	    bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    */
			    	    bean.setLblinvno(pintrs.getString("voc_no"));
			    	    bean.setLblclientaddress(pintrs.getString("address"));
			    	   
			    	    bean.setLblclientcity(pintrs.getString("area"));
			    	    
			    	    bean.setLblclientcountry(pintrs.getString("country_name"));
			    	    
			    	    bean.setLblclientmob(pintrs.getString("per_mob"));
			    	    
			    	    
			    	    bean.setLblshipto(pintrs.getString("clname"));
			    	    bean.setLblshipaddress(pintrs.getString("claddress"));
			    	    bean.setLblcontactperson(pintrs.getString("contactperson"));
			    	    bean.setLblshiptelephone(pintrs.getString("tel"));
						bean.setLblshipmob(pintrs.getString("mob"));
			    	    bean.setLblshipemail(pintrs.getString("email"));
			    	    bean.setLblshipfax(pintrs.getString("fax"));
			    	    dtype=pintrs.getString("dtype");
			    	    
			    	  //  getLblclientaddress(),getLblclientcity(),getLblclientcountry(),getLblclientmob(),getLblinvno(),getLblcompemail()
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select c.web,b.branchname,c.email,c.company,c.address,c.tel,c.fax,l.loc_name location from my_invm r  "
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
				    	  
				    	   bean.setLblcompemail(resultsetcompany.getString("web"));
				    	   
				       } 
				     stmt10.close();
				       
				     double total=0;
				     double grndtotal=0;
				     double srvtotal=0;
				     DecimalFormat DF=new DecimalFormat("##.00");
				     Statement stmtgrid3 = conn.createStatement ();      
				     String	strSqldetail1="select round(sum(nettotal),2) nettotal  from my_invd   where rdocno='"+docno+"'";
					 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
				 
						if(rsdetail1.next()){
							
							total=rsdetail1.getDouble("nettotal");
							bean.setLbltotal(DF.format(total)+"");
							grndtotal+=total;
						}
						
					//	 System.out.println("====grndtotal=2="+grndtotal);
						 
						
						
						 Statement stmtgrid4 = conn.createStatement (); 	 
						 String	strSqldetail4="select round(sum(nettotal),2) nettotal  from my_invdser   where rdocno='"+docno+"'";
						 
					//	 System.out.println("====strSqldetail4=="+strSqldetail4);
						 
						 ResultSet rsdetail4=stmtgrid4.executeQuery(strSqldetail4);
					 
							if(rsdetail4.next()){
								
								srvtotal=rsdetail4.getDouble("nettotal");
								   bean.setLblsubtotal(DF.format(srvtotal)+"");
								   grndtotal+=srvtotal;
							     }
							 System.out.println("====grndtotal=3="+grndtotal);
							
							 bean.setLblordervaluewords(c.convertAmountToWords(grndtotal+""));
					    	 bean.setLblordervalue(DF.format(grndtotal)+"");
							
					    	String sqltest="";
					    	 if(rdtype.equalsIgnoreCase("DEL"))
					    	 {
					    		 sqltest=",d.locid";
					    	 }
					    	 
					    	 
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty,"
				       		+ " round(d.amount,2) amount,round(sum(d.total),2) total,round(sum(d.discount),2) discount,round(sum(d.nettotal),2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_invd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' group by d.prdid"+sqltest;
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
/*							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") ;*/
							
							
							temp=rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
									rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
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
				       		+ " discount ,round(nettotal,2) nettotal from my_invdser     where rdocno='"+docno+"'";
					
			
					ResultSet rsdetail2=stmtgrid2.executeQuery(strSqldetail2);
					
					int rowcounts=1;
			
					while(rsdetail2.next()){

							 
							 
						/*temp2=rowcounts+"::"+rsdetail2.getString("description")+"::"+rsdetail2.getString("qty")+"::"+
							rsdetail2.getString("unitprice")+"::"+rsdetail2.getString("total")+"::"+rsdetail2.getString("discount")+"::"+
						    rsdetail2.getString("nettotal") ;*/
						
						
						
						temp2=rsdetail2.getString("description")+"::"+rsdetail2.getString("qty")+"::"+rsdetail2.getString("nettotal") ;
							arr2.add(temp2);
							rowcounts++;
			
							bean.setSecarray(2);
						
				          }
				             
					request.setAttribute("subdetails", arr2);
					stmtgrid2.close();
					 
					
					
					   
				     ArrayList<String> arr5=new ArrayList<String>();
				   	 Statement stmtgrid5 = conn.createStatement ();       
				     String temp5="";  
		 
					
						String strSqldetail5="select   refdocno doc_nos, desc1, refno,  DATE_FORMAT(date,'%d.%m.%Y') AS date from  my_deldetaild where status=3 and rdocno='"+docno+"' and dtype='"+dtype+"' ";	
				       
			
					ResultSet rsdetail5=stmtgrid5.executeQuery(strSqldetail5);
					
			 
			
					while(rsdetail5.next()){

							 
							 
				temp5=rsdetail5.getString("desc1")+"::"+rsdetail5.getString("refno")+"::"+rsdetail5.getString("date") ;
						arr5.add(temp5);
						 
						bean.setThirdarray(3);
							 
						
				          }
				             
					request.setAttribute("shipdetails", arr5);
					stmtgrid5.close();
					 
					
					
					 
				
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
			//  System.out.println("-----sql---"+sql);

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

