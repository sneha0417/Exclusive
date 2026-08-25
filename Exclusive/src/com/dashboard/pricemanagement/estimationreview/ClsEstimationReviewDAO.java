package com.dashboard.pricemanagement.estimationreview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEstimationReviewDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray mainlistgridsearch(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,
			String psrno,String load,String hidbrandid,String hidtypeid,String hideptid,String hidcatid,String hidsubcatid,String hidproductid,String optype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
        if(!load.equalsIgnoreCase("yes"))
        {
        	return RESULTDATA;
        }
        
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
			    java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{ 
		     
		     	}
	          String sqlgroup="";
	          String namesql="";
	          String wheresql="";
	          
	          String branchsql="";
	          
	   
	  		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA") && !branch.equalsIgnoreCase("")){
	  			branchsql=" and brhid="+branch;
			}
/*				
           	
	     	if(type.equalsIgnoreCase("BR"))
	     	{
	     		//sqlgroup= "group by ma.brandid ";
	     		sqlgroup= "group by pin.prdid";
	     		namesql = " a.brandname,a.brandid,";
	     		 wheresql= " and  a.brandid="+brandid+" ";
	     		 
	     		
	     	}
	     	else if(type.equalsIgnoreCase("PR"))
	     	{
	     		sqlgroup= "group by pin.prdid";
	     		namesql = "   a.brandname,a.brandid,";
	     		wheresql= " and  a.psrno="+psrno+" ";
	     		wheresql= " and  a.psrno="+psrno+" ";
	     	}
	     	
	     	else if(type.equalsIgnoreCase("CA"))
	     	{
	     		//sqlgroup= "group by ca.doc_no";
	     		sqlgroup= "group by pin.prdid";
	     		namesql = "   a.category brandname,a.catid brandid,";
	     		 wheresql= " and  a.catid="+catid+" ";
	     	 
	     	}
	     	
	     	else if(type.equalsIgnoreCase("SC"))
	     	{
	     		//sqlgroup= "group by sc.doc_no";
	     		sqlgroup= "group by pin.prdid";
	     		namesql = "   a.subcategory brandname,a.subcatid brandid,";
	     	 wheresql= " and  a.subcatid="+subcatid+" ";
	     		 
	     	}*/
		 if(type.equalsIgnoreCase("BR"))
		     	{
		     		//sqlgroup= "group by ma.brandid ";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = " bd.brandname,ma.brandid,";
		     		 wheresql= " and  ma.brandid="+brandid+" ";
		     		 
		     		
		     	}
		     	else if(type.equalsIgnoreCase("PR"))
		     	{
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   bd.brandname,ma.brandid,";
		     		wheresql= " and  ma.psrno="+psrno+" ";
		     		 
		     	}
		     	
		     	else if(type.equalsIgnoreCase("CA"))
		     	{
		     		//sqlgroup= "group by ca.doc_no";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   ca.category brandname,ca.doc_no brandid,";
		     		 wheresql= " and  ma.catid="+catid+" ";
		     	 
		     	}
		     	
		     	else if(type.equalsIgnoreCase("SC"))
		     	{
		     		//sqlgroup= "group by sc.doc_no";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   sc.subcategory brandname,sc.doc_no brandid,";
		     	 wheresql= " and ma.subcatid="+subcatid+" ";
		     		 
		     	}
		    
		
		// System.out.println("======type====="+type);
		// System.out.println("======brandid====="+brandid);
		 
		 String sqlss="";
		// String hidbrandid,String hidtypeid,String hideptid,String hidcatid,String hidsubcatid,String hidproductid
		// left join my_ptype pt on(ma.typeid=pt.doc_no) left join my_dept dep on(dep.doc_no=ma.deptid)
		 
		 
		 
		// System.out.println("===========hidbrandid======="+hidbrandid);
	//	 System.out.println("===========hidtypeid======="+hidtypeid);
		// System.out.println("===========hidcatid======="+hidcatid);
	//	 System.out.println("===========hidsubcatid======="+hidsubcatid);
		 
	//	 System.out.println("===========hidproductid======="+hidproductid);
	//	 System.out.println("===========hideptid======="+hideptid);
		 
			if(!(hidbrandid.equalsIgnoreCase("0") || hidbrandid.equalsIgnoreCase("") || hidbrandid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and bd.doc_no in ("+hidbrandid+")";
			}

			if(!(hidtypeid.equalsIgnoreCase("0") || hidtypeid.equalsIgnoreCase("") || hidtypeid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and pt.doc_no in ("+hidtypeid+")";
			}

			if(!(hidcatid.equalsIgnoreCase("0") || hidcatid.equalsIgnoreCase("") || hidcatid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and ca.doc_no in ("+hidcatid+")";
			}
			if(!(hidsubcatid.equalsIgnoreCase("0") || hidsubcatid.equalsIgnoreCase("") || hidsubcatid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and sc.doc_no in ("+hidsubcatid+")";
			}

			if(!(hidproductid.equalsIgnoreCase("0") || hidproductid.equalsIgnoreCase("") || hidproductid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and ma.doc_no in ("+hidproductid+")";
			}
		 
			if(!(hideptid.equalsIgnoreCase("0") || hideptid.equalsIgnoreCase("") || hideptid.equalsIgnoreCase("undefined"))){
				sqlss=sqlss+" and dep.doc_no in ("+hideptid+")";
			}

			 if(optype.equalsIgnoreCase("NR"))
		     	{
				 
				 //sqlss=sqlss+" and ma.maxdiscount=0 " ;
		     	}
			 
 		     	
/* 		     	
 		     	String sql=" select  "+namesql+" a.brhid,ps.cost_price-av.avgpurchsecost variation,av.avgpurchsecost avgcost,ps.op_qty qty ,ps.cost_price costprice,  "
 		     			+ "  a.brandid branddoc,convert(if(a.std_cost=0,'',std_cost),char(100)) std_cost,0 totalvalue,  "
 		     			+ " convert(if(a.fixing=0,'',fixing),char(100))   fixing,convert(if(a.fixing=0,'',fixing),char(100)) psellingprice ,  "
 		     			+ " convert(if(a.lbrchg=0,'',a.lbrchg),char(100))  labourcharge,  a.psrno,a.unit,a.part_no,a.productname,a.stkqty stkqty  	 from  "
 		     			+ " (select pin.date,pin.brhid,ma.lbrchg,ca.category,ca.doc_no catid,  "
 		     			+ " sc.subcategory,sc.doc_no subcatid,ma.stdprice std_cost,    ma.fixingprice fixing,bd.brandname,ma.brandid,  "
 		     			+ " pin.psrno,ma.part_no,ma.productname,  "
 		     			+ " sum(p.stkqty) stkqty, u.unit,pin.tr_no from  my_prddin pin  "
 		     			+ " left join my_main ma on ma.psrno=pin.psrno        left join  my_brand bd on ma.brandid=bd.doc_no  "
 		     			+ " left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no  "
 		     			+ " left join (select sum(stkqty) stkqty,prdid,stockid  "
 		     			+ " from   (select op_qty-(out_qty+del_qty+rsv_qty) stkqty ,prdid,stockid   from my_prddin where cost_price!=0) a group by stockid)  "
 		     			+ " p on p.stockid=pin.stockid left join my_unitm u on ma.munit=u.doc_no  where pin.cost_price!=0 and  "
 		     			+ "  pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqlgroup+"  ) a  "
 		     			+ " left join(select sum(cost_prices)/sum(totalqty) avgpurchsecost,prdid,stockid  from  "
 		     			+ " (select op_qty totalqty ,prdid,stockid,  "
 		     			+ " op_qty*cost_price   cost_prices   from my_prddin where cost_price!=0 "+branchsql+" group by stockid ) a  "
 		     			+ " group by a.prdid ) av on av.prdid=a.psrno "
 		     			+ " left join  (select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+" group by prdid) ss on ss.prdid=a.psrno  "
 		     			+ " left join (select op_qty,cost_price,prdid,stockid     from my_prddin where pstatus=1  "
 		     			+ " ) ps on ps.stockid=ss.stockid  where 1=1 and  a.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+wheresql+"  " ;
 		     	*/
 		     	
 //date
/* 		     	
		 String sql=" select   "+namesql+"  convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  labourcharge, "
		 		+ " convert(if(ma.maxdiscount=0,'',ma.maxdiscount),char(100)) curmaxdiscount , pin.brhid,ma.psrno,ma.brandid branddoc,0 totalvalue,  "
				 + "  convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))   fixing, convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))  "
		  + " psellingprice , convert(if(ma.stdprice=0,'',ma.stdprice),char(100)) std_cost, ma.part_no,ma.productname,bd.brandname,  "
		  + " u.unit,ps.op_qty qty,ps.cost_price costprice,st.stkqty ,av.price avgcost ,   (ps.cost_price-av.price) variation  "
		   + "   from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno left join  my_brand bd on ma.brandid=bd.doc_no  "
		   + "  left  join my_catm ca on ma.catid=ca.doc_no  "
		  + "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_unitm u on ma.munit=u.doc_no   "
		  + "   left join ( select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+"  group by prdid )  "
		   + "  ss on ss.prdid=ma.psrno  left join ( select op_qty,coalesce(cost_price,0) cost_price,prdid,stockid  "
		   + "  from my_prddin where pstatus=1   ) ps on ps.stockid=ss.stockid  	left join (select sum(op_qty-(out_qty+del_qty+rsv_qty))  "
		   + "   stkqty ,prdid from my_prddin  group by prdid) st on st.prdid=ma.psrno  	left join  "
		   + "   ( select coalesce(sum(coalesce(cost_price*op_qty,0))/sum(coalesce(op_qty,0)),0) price ,prdid  "
		   + "   from my_prddin where DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+branchsql+"	group by prdid) av on av.prdid=ma.psrno  "
		   + "   where 1=1 and  av.price is not null and ma.status=3 and pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'"+wheresql+"  group by ma.psrno  "  ; 
 		     	*/
 		     	
			wheresql=wheresql+sqlss	;
		 
		 
		 
 		     	/* having sum(p.stkqty)!=0*/
			
			
			 String sql="";
			
			 if(optype.equalsIgnoreCase("NP"))
		     	{
			   sql=" select "+namesql+"  convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  labourcharge, "
			   		+ "  pin.brhid,ma.psrno,ma.brandid branddoc,0 totalvalue,convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))   fixing, "
			   		+ " convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))   psellingprice , "
			   		+ " convert(if(ma.stdprice=0,'',ma.stdprice),char(100)) std_cost, ma.part_no,ma.productname, u.unit,'' qty,'' costprice,'' stkqty ,''  avgcost , " 
			   		+ " '' variation   from my_main ma left join my_prddin pin	on pin.prdid=ma.doc_no  left join  my_brand bd on ma.brandid=bd.doc_no  "
			   		+ "   left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no left join my_unitm u on ma.munit=u.doc_no "
			   		+ " left join my_ptype pt on(ma.typeid=pt.doc_no)         left join my_dept dep on(dep.doc_no=ma.deptid)  "
			   		+ "   where 1=1 and ma.status=3  and pin.prdid is null  "+wheresql+"   group by ma.psrno " ;
			 
				ResultSet resultSet = stmtVeh.executeQuery(sql);
       		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
			 
		     	}
			 else
			 {
			 
			 
			 
	   sql=" select   "+namesql+"  convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  labourcharge, "
	 		+ "  pin.brhid,ma.psrno,ma.brandid branddoc,0 totalvalue,  "
			 + "  convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))   fixing, convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))  "
	  + " psellingprice , convert(if(ma.stdprice=0,'',ma.stdprice),char(100)) std_cost, ma.part_no,ma.productname,  "
	  + " u.unit,ps.op_qty qty,ps.cost_price costprice,st.stkqty ,av.price avgcost ,   (ps.cost_price-av.price) variation  "
	   + "   from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno left join  my_brand bd on ma.brandid=bd.doc_no  "
	   + "  left  join my_catm ca on ma.catid=ca.doc_no  "
	  + "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_unitm u on ma.munit=u.doc_no "
	  + "  left join my_ptype pt on(ma.typeid=pt.doc_no) left join my_dept dep on(dep.doc_no=ma.deptid) "
	  + "   left join ( select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+"  group by prdid )  "
	   + "  ss on ss.prdid=ma.psrno  left join ( select op_qty,coalesce(cost_price,0) cost_price,prdid,stockid  "
	   + "  from my_prddin where pstatus=1   ) ps on ps.stockid=ss.stockid  	left join (select sum(op_qty-(out_qty+del_qty+rsv_qty))  "
	   + "   stkqty ,prdid from my_prddin  group by prdid) st on st.prdid=ma.psrno  	left join  "
	   + "   ( select coalesce(sum(coalesce(cost_price*op_qty,0))/sum(coalesce(op_qty,0)),0) price ,prdid  "
	   + "   from my_prddin where 1=1  "+branchsql+"	group by prdid) av on av.prdid=ma.psrno  "
	   + "   where 1=1 and  av.price is not null and ma.status=3 "+wheresql+"  group by ma.psrno  "  ; 
 
		ResultSet resultSet = stmtVeh.executeQuery(sql);
		 RESULTDATA=ClsCommon.convertToJSON(resultSet);

			 }
	 
   // System.out.println("-----sql----"+sql);
            	
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
	
	
	
	
	public   JSONArray mainlistgridsearchExcel(String branch,String fromdate,String todate,String type,String brandid,
			String catid,String subcatid,String psrno,String load,String hidbrandid,String hidtypeid,String hideptid,String hidcatid,String hidsubcatid,String hidproductid,String optype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!load.equalsIgnoreCase("yes"))
        {
        	return RESULTDATA;
        }
        
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
			    java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{ 
		     
		     	}
	          String sqlgroup="";
	          String namesql="";
	          String wheresql="";
	          
		     	if(type.equalsIgnoreCase("BR"))
		     	{
		     		//sqlgroup= "group by ma.brandid ";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = " ,bd.brandname  'Type'  ";
		     		 wheresql= " and  ma.brandid="+brandid+" ";
		     		 
		     		
		     	}
		     	else if(type.equalsIgnoreCase("PR"))
		     	{
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "  , bd.brandname 'Type'";
		     		wheresql= " and  ma.psrno="+psrno+" ";
		     		/*wheresql= " and  a.psrno="+psrno+" ";*/
		     	}
		     	
		     	else if(type.equalsIgnoreCase("CA"))
		     	{
		     		//sqlgroup= "group by ca.doc_no";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   ,ca.category 'Type'";
		     		 wheresql= " and  ma.catid="+catid+" ";
		     	 
		     	}
		     	
		     	else if(type.equalsIgnoreCase("SC"))
		     	{
		     		//sqlgroup= "group by sc.doc_no";
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   ,sc.subcategory  'Type'";
		     	 wheresql= " and  ma.subcatid="+subcatid+" ";
		     		 
		     	}
		     	
		     	  
		          String branchsql="";
		          
		   
		  		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA") && !branch.equalsIgnoreCase("")){
		  			branchsql=" and brhid="+branch;
				}
		  		String sqlss="";
		  		
		  		if(!(hidbrandid.equalsIgnoreCase("0") || hidbrandid.equalsIgnoreCase("") || hidbrandid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and bd.doc_no in ("+hidbrandid+")";
				}

				if(!(hidtypeid.equalsIgnoreCase("0") || hidtypeid.equalsIgnoreCase("") || hidtypeid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and pt.doc_no in ("+hidtypeid+")";
				}

				if(!(hidcatid.equalsIgnoreCase("0") || hidcatid.equalsIgnoreCase("") || hidcatid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and ca.doc_no in ("+hidcatid+")";
				}
				if(!(hidsubcatid.equalsIgnoreCase("0") || hidsubcatid.equalsIgnoreCase("") || hidsubcatid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and sc.doc_no in ("+hidsubcatid+")";
				}

				if(!(hidproductid.equalsIgnoreCase("0") || hidproductid.equalsIgnoreCase("") || hidproductid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and ma.doc_no in ("+hidproductid+")";
				}
			 
				if(!(hideptid.equalsIgnoreCase("0") || hideptid.equalsIgnoreCase("") || hideptid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and dep.doc_no in ("+hideptid+")";
				}

				 if(optype.equalsIgnoreCase("NR"))
			     	{
					 
					// sqlss=sqlss+" and ma.maxdiscount=0 " ;
			     	}
				 
	 		     		     
		     	  
 		     	
 /*		     	String sql=" select a.part_no 'Product Id',a.productname 'Product Name' "+namesql+",ps.op_qty  Qty,ps.cost_price 'Cost Per',a.stkqty 'Stock Qty' "
 		     			+ "  ,av.avgpurchsecost 'Avg Purchase Cost',ps.cost_price-av.avgpurchsecost variation,  "
 		     			+ " convert(if(a.std_cost=0,'',std_cost),char(100)) Std_Cost ,  "
 		     			+ " convert(if(a.fixing=0,'',fixing),char(100))   'Final Price',   "
 		     			+ " convert(if(a.lbrchg=0,'',a.lbrchg),char(100))  'Labour Charge'   from  "
 		     			+ " (select pin.date,pin.brhid,ma.lbrchg,ca.category,ca.doc_no catid,  "
 		     			+ " sc.subcategory,sc.doc_no subcatid,ma.stdprice std_cost,    ma.fixingprice fixing,bd.brandname,ma.brandid,  "
 		     			+ " pin.psrno,ma.part_no,ma.productname,  "
 		     			+ " sum(p.stkqty) stkqty, u.unit,pin.tr_no from  my_prddin pin  "
 		     			+ " left join my_main ma on ma.psrno=pin.psrno        left join  my_brand bd on ma.brandid=bd.doc_no  "
 		     			+ " left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no  "
 		     			+ " left join (select sum(stkqty) stkqty,prdid,stockid  "
 		     			+ " from   (select op_qty-(out_qty+del_qty+rsv_qty) stkqty ,prdid,stockid   from my_prddin where cost_price!=0) a group by stockid)  "
 		     			+ " p on p.stockid=pin.stockid left join my_unitm u on ma.munit=u.doc_no  where pin.cost_price!=0 and  "
 		     			+ "  pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqlgroup+"  ) a  "
 		     			+ " left join(select sum(cost_prices)/sum(totalqty) avgpurchsecost,prdid,stockid  from  "
 		     			+ " (select op_qty totalqty ,prdid,stockid,  "
 		     			+ " op_qty*cost_price   cost_prices   from my_prddin where cost_price!=0 "+branchsql+" group by stockid ) a  "
 		     			+ " group by a.prdid ) av on av.prdid=a.psrno "
 		     			+ " left join  (select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+" group by prdid) ss on ss.prdid=a.psrno  "
 		     			+ " left join (select op_qty,cost_price,prdid,stockid     from my_prddin where pstatus=1  "
 		     			+ " ) ps on ps.stockid=ss.stockid  where 1=1 and  a.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+wheresql+"   " ;
 		     	
 		 
 		     	*/
		   
		  		
			 
		  	//with date	
		 				  
		/* 		 String sql=" select ma.part_no 'Product Id',ma.productname 'Product Name' "+namesql+",ps.op_qty  Qty,ps.cost_price 'Cost Per',st.stkqty 'Stock Qty' "
		  		     			+ "  ,av.price 'Avg Purchase Cost',ps.cost_price-av.price variation,  "
		  		     			+ " convert(if(ma.stdprice=0,'',ma.stdprice),char(100))  Std_Cost ,  "
		  		     			+ " convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))    'Final Price',   "
		  		     			+ "  convert(if(ma.maxdiscount=0,'',ma.maxdiscount),char(100))  'MAX DISCOUNT'  ,convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))   'Labour Charge'   "
		  		     			+ "   from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno left join  my_brand bd on ma.brandid=bd.doc_no  "
		  		     			+ "  left  join my_catm ca on ma.catid=ca.doc_no  "
		  		     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_unitm u on ma.munit=u.doc_no   "
		  		     			+ "   left join ( select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+"  group by prdid )  "
		  		     			+ "  ss on ss.prdid=ma.psrno  left join ( select op_qty,coalesce(cost_price,0) cost_price,prdid,stockid  "
		  		     			+ "  from my_prddin where pstatus=1   ) ps on ps.stockid=ss.stockid  	left join (select sum(op_qty-(out_qty+del_qty+rsv_qty))  "
		  		     			+ "   stkqty ,prdid from my_prddin  group by prdid) st on st.prdid=ma.psrno  	left join  "
		  		     			+ "   ( select coalesce(sum(coalesce(cost_price*op_qty,0))/sum(coalesce(op_qty,0)),0) price ,prdid  "
		  		     			+ "   from my_prddin where DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+branchsql+"	group by prdid) av on av.prdid=ma.psrno  "
		  		     			+ "   where 1=1 and    av.price is not null  and ma.status=3 and  pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'"+wheresql+"  group by ma.psrno  "  ; 
		     	*/
 		     	/* having sum(p.stkqty)!=0*/
		  		
					wheresql=wheresql+sqlss	;
				
				
				 String sql="";
					
				 if(optype.equalsIgnoreCase("NP"))
			     	{
					 
					   sql=" select ma.part_no 'Product Id',ma.productname 'Product Name' "+namesql+",''  Qty,'' 'Cost Per','' 'Stock Qty' "
		  		     			+ "  ,'' 'Avg Purchase Cost','' variation,  "
		  		     			+ " convert(if(ma.stdprice=0,'',ma.stdprice),char(100))  Std_Cost ,  "
		  		     			+ " convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))    'Final Price',convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  'Labour Charge'     "
		  		     			+ "  from my_main ma left join my_prddin pin	on pin.prdid=ma.doc_no  left join  my_brand bd on ma.brandid=bd.doc_no  "
						   		+ "   left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no left join my_unitm u on ma.munit=u.doc_no "
						   		+ " left join my_ptype pt on(ma.typeid=pt.doc_no)         left join my_dept dep on(dep.doc_no=ma.deptid)  "
						   		+ "   where 1=1 and ma.status=3  and pin.prdid is null  "+wheresql+"   group by ma.psrno " ;
					 
					 ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			     	}
				
				
				 else
				 {
		 		   sql=" select ma.part_no 'Product Id',ma.productname 'Product Name' "+namesql+",ps.op_qty  Qty,ps.cost_price 'Cost Per',st.stkqty 'Stock Qty' "
	  		     			+ "  ,av.price 'Avg Purchase Cost',   "
	  		     			+ " convert(if(ma.stdprice=0,'',ma.stdprice),char(100))  Std_Cost ,  "
	  		     			+ " convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))    'Final Price',convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  'Labour Charge'  "
	  		     			 
	  		     			+ "   from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno left join  my_brand bd on ma.brandid=bd.doc_no  "
	  		     			+ "  left  join my_catm ca on ma.catid=ca.doc_no  "
	  		     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_unitm u on ma.munit=u.doc_no "
	  		     			+ " left join my_ptype pt on(ma.typeid=pt.doc_no) left join my_dept dep on(dep.doc_no=ma.deptid)  "
	  		     			+ "   left join ( select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+"  group by prdid )  "
	  		     			+ "  ss on ss.prdid=ma.psrno  left join ( select op_qty,coalesce(cost_price,0) cost_price,prdid,stockid  "
	  		     			+ "  from my_prddin where pstatus=1   ) ps on ps.stockid=ss.stockid  	left join (select sum(op_qty-(out_qty+del_qty+rsv_qty))  "
	  		     			+ "   stkqty ,prdid from my_prddin  group by prdid) st on st.prdid=ma.psrno  	left join  "
	  		     			+ "   ( select coalesce(sum(coalesce(cost_price*op_qty,0))/sum(coalesce(op_qty,0)),0) price ,prdid  "
	  		     			+ "   from my_prddin where 1=1  "+branchsql+"	group by prdid) av on av.prdid=ma.psrno  "
	  		     			+ "   where 1=1 and    av.price is not null  and ma.status=3 "+wheresql+"  group by ma.psrno  "  ; 
	     	
 
 
 // System.out.println("-----sql-asdsa---"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				 }
				 
				// System.out.println("-----sql-asdsa---"+sql);
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

	public   JSONArray offerlistgridsearch(String branch,String fromdate,String todate,String salescount,String type,String brandid,String catid,
			String subcatid,String psrno,String load,
			String hidbrandid,String hidtypeid,String hideptid,String hidcatid,String hidsubcatid,String hidproductid,String cldocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
			    java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}
		     	
		     	
		     	if(load.equalsIgnoreCase("Load"))
		     	{
		     	
		     	 String sqlgroup="";
		          String namesql="";
		          String wheresql="";
		          
/*			     	if(type.equalsIgnoreCase("BR"))
			     	{
			     		//sqlgroup= "group by ma.brandid ";
			     		sqlgroup= "group by pin.prdid";
			     		namesql = " a.brandname,a.brandid,";
			     		 wheresql= " and  a.brandid="+brandid+" ";
			     		 
			     		
			     	}
			     	else if(type.equalsIgnoreCase("PR"))
			     	{
			     		sqlgroup= "group by pin.prdid";
			     		namesql = "   a.brandname,a.brandid,";
			     		wheresql= " and  a.psrno="+psrno+" ";
			     		wheresql= " and  a.psrno="+psrno+" ";
			     	}
			     	
			     	else if(type.equalsIgnoreCase("CA"))
			     	{
			     		//sqlgroup= "group by ca.doc_no";
			     		sqlgroup= "group by pin.prdid";
			     		namesql = "   a.category brandname,a.catid brandid,";
			     		 wheresql= " and  a.catid="+catid+" ";
			     	 
			     	}
			     	
			     	else if(type.equalsIgnoreCase("SC"))
			     	{
			     		//sqlgroup= "group by sc.doc_no";
			     		sqlgroup= "group by pin.prdid";
			     		namesql = "   a.subcategory brandname,a.subcatid brandid,";
			     	 wheresql= " and  a.subcatid="+subcatid+" ";
			     		 
			     	}*/
			   	 String sqlss="";
 
					 
						if(!(hidbrandid.equalsIgnoreCase("0") || hidbrandid.equalsIgnoreCase("") || hidbrandid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.brandid in ("+hidbrandid+")";
						}

						if(!(hidtypeid.equalsIgnoreCase("0") || hidtypeid.equalsIgnoreCase("") || hidtypeid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.typeid in ("+hidtypeid+")";
						}

						if(!(hidcatid.equalsIgnoreCase("0") || hidcatid.equalsIgnoreCase("") || hidcatid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.catid in ("+hidcatid+")";
						}
						if(!(hidsubcatid.equalsIgnoreCase("0") || hidsubcatid.equalsIgnoreCase("") || hidsubcatid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.subcatid in ("+hidsubcatid+")";
						}

						if(!(hidproductid.equalsIgnoreCase("0") || hidproductid.equalsIgnoreCase("") || hidproductid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.psrno in ("+hidproductid+")";
						}
					 
						if(!(hideptid.equalsIgnoreCase("0") || hideptid.equalsIgnoreCase("") || hideptid.equalsIgnoreCase("undefined"))){
							sqlss=sqlss+" and a.deptid in ("+hideptid+")";
						}
						wheresql=wheresql+sqlss	;
		     	String sql=" select  a.brandname,a.brandid,  a.age,a.outqty,a.status, a.brandid branddoc,convert(if(a.std_cost=0,'',std_cost),char(100)) std_cost,"
		     			+ "  convert(if(a.fixing=0,'',fixing),char(100)) fixing,convert(if(a.fixing=0,'',fixing),char(100)) psellingprice, convert(coalesce(a.ofrprice,''),char(100)) clearprice, "
		     			+ " a.psrno,a.unit,a.part_no,a.productname,a.qty qty,a.costprice costprice,a.stkqty stkqty,   a.totalvalue totalvalue, "
		     			+ " a.totalvalue/a.stkqty avgcost,a.costprice-(a.totalvalue/a.stkqty) variation,a.typeid,a.deptid from "
		     			+ " (select cl.ofrprice,ma.deptid,ma.typeid,ma.status,ca.category,ca.doc_no catid,sc.subcategory,sc.doc_no subcatid,ma.clrprice clearprice ,ma.stdprice std_cost,ma.fixingprice fixing,bd.brandname,"
		     			+ " ma.brandid,ma.psrno,ma.part_no,ma.productname,sum(pin.op_qty) "
		     			+ "  qty,sum(pin.cost_price)/sum(total) costprice,sum(p.age)/sum(total) age  ,  sum(p.stkqty) stkqty,sum(p.outqty) outqty,sum(p.cost_prices) "
		     			+ "  totalvalue, u.unit,pin.tr_no from  my_main ma    left join my_prddin pin on ma.psrno=pin.psrno  "
		     			+ " left join my_ptype pt on(ma.typeid=pt.doc_no)  left join my_dept dep on(dep.doc_no=ma.deptid)  "
		     	        + "  left join  my_brand bd on ma.brandid=bd.doc_no  left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no   left join " 
		     	        + "  (select sum(age) age,count(*) total,sum(stkqty) stkqty,sum(outqty) outqty,sum(cost_prices) "
		     	        + "   cost_prices,prdid,stockid from   (select datediff(curdate(), date) age, "
		     	        + "  op_qty-(out_qty+del_qty+rsv_qty) stkqty ,(out_qty+del_qty+rsv_qty) outqty,prdid,stockid, "
		     	        + "  (op_qty-(out_qty+del_qty+rsv_qty))*cost_price   cost_prices "
		     	        + "  from my_prddin where cost_price!=0    and DATE between  '"+sqlfromdate+"' and  curdate()) a group by stockid) "
		     	        + "  p on p.stockid=pin.stockid 	  left join my_unitm u on ma.munit=u.doc_no left join my_clientoffer cl on cl.psrno=ma.psrno and cl.cldocno='"+cldocno+"'  where  "
		     	        + "   1=1 group by ma.psrno   ) a where 1=1 and a.status=3 "+wheresql+"  ";
		     	                     
		     /*	having sum(p.outqty)<="+salescount+" and sum(p.stkqty)!=0 */
 
 		  //  System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
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
	
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray suitbrandSearch1(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

		 	String sql="select convert(doc_no,char(50)) as doc_no,brand from (select '' doc_no ,'' brand union all  select doc_no,brand from my_sbrand where status=3  ) as a ";
			 
			 
		//	 System.out.println("=========sql===="+sql);
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray suitbrandSearch(HttpSession session,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

	
/*			 String sql = " select convert('',char(20)) doc_no ,'' brand  union all  select convert(b.doc_no,char(20)) doc_no, b.brand  from my_sbrand b	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.frmyomid>0  and f.yom<='"+yomfrm+"' and  "
					 +"	   t.yom>='"+yomto+"'  ";*/
			 
			String sql = " select convert('',char(20)) doc_no ,'' brand  union all  select convert(b.doc_no,char(20)) doc_no, b.brand  from my_sbrand b	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.frmyomid>0   and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN'))  "; 
			
			
	 // System.out.println("=========sql===="+sql);
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitmodelSearch(HttpSession session,String brandid,String yomfrm,String  yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			
			//String sql="select convert(doc_no,char(50)) as doc_no,model,brand from ( select '' doc_no ,'' model,'' brand union all select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"' ) as a";
			
		/*	 String sql = "select '' model,convert('',char(20)) doc_no ,'' brand  union all   select b.model,convert(b.doc_no,char(20)) doc_no,m.brand from my_smodel b left join my_sbrand m on(b.brandid=m.doc_no) 	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.brandid='"+brandid+"' and b.frmyomid>0  and f.yom<='"+yomfrm+"' and   t.yom>='"+yomto+"'  ";
			 
*/
			 String sql = "select '' model,convert('',char(20)) doc_no ,'' brand  union all   select b.model,convert(b.doc_no,char(20)) doc_no,m.brand from my_smodel b left join my_sbrand m on(b.brandid=m.doc_no) 	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.brandid='"+brandid+"' and b.frmyomid>0  and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN'))  ";
			 
			 
			
	 //	System.out.println("===modelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subModelSearch(HttpSession session,String brandid,String modelid,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
/*			 String sql="select convert('',char(50)) as doc_no,'' submodel,'' model union all select convert(doc_no,char(50)) as doc_no,submodel,model from "
						+ "( select  convert(m.doc_no,char(50)) as doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
						+ "on(m.modelid=mo.doc_no) left join my_syom f on f.doc_no= m.frmyomid "
						 +"		left join my_syom t on t.doc_no= m.toyomid where mo.status=3 and m.status=3 and"
						 + "   m.brandid="+brandid+" and m.modelid='"+modelid+"'   and f.yom<='"+yomfrm+"' and  "
						+"	   t.yom>='"+yomto+"'  ) as a";*/
			 
			 String sql="select convert('',char(50)) as doc_no,'' submodel,'' model union all select convert(doc_no,char(50)) as doc_no,submodel,model from "
						+ "( select  convert(m.doc_no,char(50)) as doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
						+ "on(m.modelid=mo.doc_no) left join my_syom f on f.doc_no= m.frmyomid "
						 +"		left join my_syom t on t.doc_no= m.toyomid where mo.status=3 and m.status=3 and"
						 + "   m.brandid="+brandid+" and m.modelid='"+modelid+"' and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN')) ) as a";
			 
			 
			
		/*	String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from "
					+ "(  select '' doc_no ,'' submodel,'' model union all select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
					+ "on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid="+modelid+""
					+ " and m.brandid="+brandid+" ) as a";*/
	// 	System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray yomSearch(HttpSession session,String type,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			String sqlappend="";
			if(!(yomfrm.equalsIgnoreCase(""))){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" ";
			}
			String joinsql="";
	 
			
			if(type.equalsIgnoreCase("frm"))
			{
			 
				
				sql="select convert('',char(20)) doc_no,'' yom,'' desc1 union all   select  convert(y.doc_no,char(20)) doc_no,y.yom,y.desc1 from my_syom  y  where y.status=3 order by desc1;"; 
				
			 
			}
			else if(type.equalsIgnoreCase("to"))
			 
			{
				
		 
				sql="  select  doc_no,yom,desc1 from (select convert('',char(20)) doc_no,'' yom,'' desc1 union all select  convert(doc_no,char(20)) doc_no,yom,desc1 from my_syom where desc1='0' "
						+ "	 union all  (select  convert(doc_no,char(20)) doc_no,yom,desc1 from my_syom where status=3 "+sqlappend+" ))a order by a.desc1 ";
			 
			}
			
	// System.out.println("=======sql==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray yomSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,yom from my_syom where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,yom from ( select '' doc_no ,'' yom  union all  select doc_no,yom from my_syom where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec1Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec1 where status=3";
		//	String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select '' doc_no ,'' spec  union all   select doc_no,spec from my_suitspec1 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
		/*	String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec1 s "
					+ "left join my_syom f on f.doc_no= s.frmyomid "
						 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
						+"	   t.yom>='"+yomto+"' " ;*/
			
			
			
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec1 s "
					+ "left join my_syom f on f.doc_no= s.frmyomid "
						 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN')) " ;
			
			
			
		// System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec2Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec2 where status=3";
		//	String sql="select convert(doc_no,char(50)) as doc_no,spec from (select '' doc_no ,'' spec  union all select doc_no,spec from my_suitspec2 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
			
			
	/*		String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec2 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
				+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
					+"	   t.yom>='"+yomto+"' " ;
			*/
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec2 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
				+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN')) " ;
			
			
			
	// 	System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec3Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec3 where status=3";
			//String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select '' doc_no ,'' spec  union all select doc_no,spec from my_suitspec3 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
			
	/*		String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec3 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"	left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					 + " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
					 +"	 t.yom>='"+yomto+"' " ;*/
			
			
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec3 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"	left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					 + " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and  (("+yomfrm+" between f.yom  and   t.yom ) or (f.yom<="+yomfrm+" and t.yom='OPEN')) " ;
		// 	System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray typeSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,producttype ptype from my_ptype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray productSearch(HttpSession session,String brandid,String catid,String subcatid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
			//System.out.println("brandid===="+brandid);
			if(!(brandid.equalsIgnoreCase("0") || brandid.equalsIgnoreCase(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}

			String sql2="";
			//System.out.println("brandid===="+brandid);
			if(!(catid.equalsIgnoreCase("0") || catid.equalsIgnoreCase(""))){
				sql2="and c.doc_no in ("+catid+")";
			}

			String sql3="";
			//System.out.println("brandid===="+brandid);
			if(!(subcatid.equalsIgnoreCase("0") || subcatid.equalsIgnoreCase(""))){
				sql3="and s.doc_no in ("+subcatid+")";
			}


			String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1+" "+sql2+" "+sql3+"";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray catSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category cat,doc_no  from my_catm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subCatSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory subcat,s.doc_no,category cat  from my_scatm s inner join my_catm c on(c.doc_no=s.catid) and c.doc_no in ("+catid+")";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray partSearch1(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String gridtype,String load
			,String brandid1,String modelid1,String submodelid1,String yomid1,String spec1id1,String spec2id1,String spec3id1) throws SQLException {


 	/*
		System.out.println("===brandid1===="+brandid1);
		System.out.println("===modelid1===="+modelid1);
		System.out.println("===submodelid1===="+submodelid1);
		System.out.println("===yomid1===="+yomid1);
		System.out.println("===spec1id1===="+spec1id1);
		System.out.println("===spec2id1===="+spec2id1);
		System.out.println("===spec3id1===="+spec3id1); */
		
		JSONArray RESULTDATA=new JSONArray();

	//	System.out.println("===load===="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
		//	System.out.println("===gridtype======="+gridtype);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
			if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			
			String sqlwhere="    ";
			
		 
			if(!(brandid1.equalsIgnoreCase("0") || brandid1.equalsIgnoreCase("")  || brandid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.sbrandid = "+brandid1+" ";
			}
			if(!(modelid1.equalsIgnoreCase("0") || modelid1.equalsIgnoreCase("")  || modelid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.smodelid ="+modelid1+" ";
			}
			
			if(!(submodelid1.equalsIgnoreCase("0") || submodelid1.equalsIgnoreCase("")  || submodelid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.submodelid  ="+submodelid1+" ";
			}
			
			
 		if(!(yomid1.equalsIgnoreCase("0") || yomid1.equalsIgnoreCase("")  || brandid1.equalsIgnoreCase("yomid1") )){
				 
						 
						
						sqlwhere= sqlwhere + "	 and if(coalesce(s.syomto_id,0)<=0,s.syomfrm_id<="+yomid1+","+yomid1+" between coalesce(s.syomfrm_id,0) "
								+ "  and coalesce(s.syomto_id,0))    and y1.yom is not null  " ;
			}
			 
			
			if(!(spec2id1.equalsIgnoreCase("0") || spec2id1.equalsIgnoreCase("")  || spec2id1.equalsIgnoreCase("undefined") )){
			 
				sqlwhere= sqlwhere + "and vs.esizeid="+spec2id1+" ";
			}
			
			
			if(!(spec1id1.equalsIgnoreCase("0") || spec1id1.equalsIgnoreCase("")  || spec1id1.equalsIgnoreCase("undefined") )){
				
				sqlwhere= sqlwhere + "and ((s.bsize1id=0 and  s.bsize2id=0  and s.bsize3id=0 )  or ( s.bsize1id="+spec1id1+" or  s.bsize2id="+spec1id1+"  or s.bsize3id="+spec1id1+" ))    ";
				
			}
			
			
			if(!(spec3id1.equalsIgnoreCase("0") || spec3id1.equalsIgnoreCase("")  || spec3id1.equalsIgnoreCase("undefined") )){
				
				sqlwhere= sqlwhere + "and ((s.csize1id=0 and  s.csize2id=0  and s.csize3id=0)  or (s.csize1id="+spec3id1+" or  s.csize2id="+spec3id1+"  or s.csize3id="+spec3id1+" ))    ";
				 
			}
			
			
		/*	,brandid1,modelid1,submodelid1,yomid1,spec1id1,spec2id1,spec3id1
			*/
			
			//System.out.println("==hidsbrand==="+hidsbrand+"==hidsmodel=="+hidsmodel+"==hidyom==="+hidyom+"=hidspec1=="+hidspec1+"==hidspec2=="+hidspec2+"==hidspec3=="+hidspec3+"==hidbrand==="+hidbrand+"==hidcat==="+hidcat+"==hidsubcat=="+hidsubcat+"==hidproduct="+hidproduct);


			String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			if(!(hidsbrand.equalsIgnoreCase("0") || hidsbrand.equalsIgnoreCase("") || hidsbrand.equalsIgnoreCase("undefined"))){
				if(hidsbrand.equalsIgnoreCase("-1")){
					sql1="and vs.sbrandid in ("+hidsbrand+")";
				}
				else{
					sql1="and sb.doc_no in ("+hidsbrand+")";
				}

			}

			if(!(hidsmodel.equalsIgnoreCase("0") || hidsmodel.equalsIgnoreCase("") || hidsmodel.equalsIgnoreCase("undefined"))){
				if(hidsmodel.equalsIgnoreCase("-1")){
					sql2="and vs.smodelid in ("+hidsmodel+")";
				}
				else{
					sql2="and sm.doc_no in ("+hidsmodel+")";
				}
			}


			if(!(hidsubmodel.equalsIgnoreCase("0") || hidsmodel.equalsIgnoreCase("") || hidsubmodel.equalsIgnoreCase("undefined"))){
				if(hidsubmodel.equalsIgnoreCase("-1")){
					sql2="and vs.submodelid in ("+hidsubmodel+")";
				}
				else{
					sql2="and sbm.doc_no in ("+hidsubmodel+")";
				}
			}

			if(!(hidyom.equalsIgnoreCase("0") || hidyom.equalsIgnoreCase("") || hidyom.equalsIgnoreCase("undefined"))){

				if(hidyom.equalsIgnoreCase("-1")){
					sql3 ="and s.syomfrm_id in ("+hidyom+") or s.syomto_id in ("+hidyom+")";
				}
				else{
					String sqlyom="select min(yom) y1,max(yom) y2 from my_syom where doc_no in ("+hidyom+")"; 
					ResultSet rsyom=stmt.executeQuery(sqlyom);
					while(rsyom.next()){
						minyom=rsyom.getString("y1");
						maxyom=rsyom.getString("y2");
						//System.out.println("===minyom===="+minyom+"==maxyom==="+maxyom);
					}

					sql3="and str_to_date(y1.yom, '%Y')<=str_to_date("+maxyom+" , '%Y') and str_to_date(y2.yom, '%Y')>=str_to_date("+minyom+" , '%Y') ";
				}
			}
			if(!( hidspec1.equalsIgnoreCase("") || hidspec1.equalsIgnoreCase("undefined"))){
				if(hidspec1.equalsIgnoreCase("0") || hidspec1.equalsIgnoreCase("-1")){
					sql4="and vs.bsize1id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize2id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize3id in ("+hidspec1+")";
				}
				else{
					sql4=" and s11.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s12.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s13.doc_no in ("+hidspec1+")";
				}
			}

			if(!(hidspec2.equalsIgnoreCase("0") || hidspec2.equalsIgnoreCase("") || hidspec2.equalsIgnoreCase("undefined"))){
				if(hidspec2.equalsIgnoreCase("-1")){
					sql5="and s.spec2_id in ("+hidspec2+")";

				}
				else{
					sql5="and s2.doc_no in ("+hidspec2+")";

				}
			}

			if(!(hidspec3.equalsIgnoreCase("null") || hidspec3.equalsIgnoreCase("") || hidspec3.equalsIgnoreCase("undefined"))){
				if(hidspec3.equalsIgnoreCase("-1") || hidspec3.equalsIgnoreCase("0")){
					sql6="and vs.csize1id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize2id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize3id in ("+hidspec3+")";
				}
				else{
					sql6=" and s31.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s32.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s33.doc_no in ("+hidspec3+")";
				}
			}
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7="and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8="and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9="and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10="and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}
		/*	if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql12="and d.brhid in ("+branchid+")";
			}*/
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13="and dep.doc_no in ("+hidept+")";
			}

			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;


			//System.out.println("===sqlfinal===="+sqlfinal);
			if(type.equalsIgnoreCase("1")){  

				  

				sql = "select  "+selectjoinsql+" if(d.brhid=0, cp.company, br.branchname) as branch,convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice,"
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice ,"
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,"
						+ " c.category as cat,sc.subcategory as scat,dep.department as dept "
						/*+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ "br.branchname as branch,"
						+ " */ +" from my_main m inner join my_desc d on(m.doc_no=d.psrno) " 
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"       
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"   
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid) left join my_comp cp on (cp.doc_no=d.cmpid)   "+joinsql+" "
						+ "where m.status=3 "+sqlfinal+" "+sqlwhere+" group by m.doc_no ";

			 // System.out.println("==sql=type1==="+sql);

						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);

			}
			else if(type.equalsIgnoreCase("2")){


				sql = "select  "+selectjoinsql+" br.branchname as branch,m.doc_no,m.part_no product,m.productname pdesc,pt.producttype as type "
						+ " ,convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice,"
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,convert(if(m.clrprice=0,'',m.clrprice),char(100)) clrprice, "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, b.brand as brand,c.category as cat,sc.subcategory as scat,dep.department as dept "
						/*+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when vs.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when vs.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when vs.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when vs.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when vs.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when vs.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ ""
						+ "  */ + "  from my_main m inner join my_desc d on(m.doc_no=d.psrno) "
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=vs.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=vs.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=vs.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=vs.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=vs.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=vs.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid)  "+joinsql+" "
						+ "where m.status=3 and vs.doc_no in("+suitid+") group by m.doc_no ";

			//System.out.println("==sql=type2==="+sql);

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
	
	public JSONArray partSearch(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String gridtype,String load
			,String brandid1,String modelid1,String submodelid1,String bedid,String engid,String cabid,String yomfrm,String yomto,String gentype) throws SQLException {


/* 	
		System.out.println("===brandid===="+brandid1);
		System.out.println("===modelid===="+modelid1);
		System.out.println("===submodelid===="+submodelid1);
		System.out.println("===yomfrm===="+yomfrm);
		System.out.println("===yomto===="+yomto);
		System.out.println("===Bed Size===="+bedid);
		System.out.println("===Engin Size===="+engid);
		System.out.println("===Cabin Size===="+cabid); */
		
		JSONArray RESULTDATA=new JSONArray();

	//	System.out.println("===load===="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
		//	System.out.println("===gridtype======="+gridtype);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
			int bedcount=0,enginecount=0;
			if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			
			String sqlwhere="";
			
			String sqlsuit="",sqlsubsuit="",sqltype="";
 
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ " and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and m.doc_no in ("+hidproduct+")";
			}
	 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and dep.doc_no in ("+hidept+")";
			}

			 
			
			if(!(brandid1.equalsIgnoreCase("0") || brandid1.equalsIgnoreCase("") || brandid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.brandid ="+brandid1+" ";
			}

			if(!(modelid1.equalsIgnoreCase("0") || modelid1.equalsIgnoreCase("") || modelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.modelid ="+modelid1+" ";
			}

			if(!(submodelid1.equalsIgnoreCase("0") || submodelid1.equalsIgnoreCase("") || submodelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.submodelid ="+submodelid1+" ";
			}
			 
			if((!(bedid.equalsIgnoreCase("0") || bedid.equalsIgnoreCase("") || bedid.equalsIgnoreCase("undefined"))) || 
			(!(engid.equalsIgnoreCase("0") || engid.equalsIgnoreCase("") || engid.equalsIgnoreCase("undefined"))) || 
			(!(cabid.equalsIgnoreCase("0") || cabid.equalsIgnoreCase("") || cabid.equalsIgnoreCase("undefined"))))
			{
			
				sqlsubsuit=" and  ( ";
				sqltype= " or m.mtypeid in ( 2   ";
				
			if(!(bedid.equalsIgnoreCase("0") || bedid.equalsIgnoreCase("") || bedid.equalsIgnoreCase("undefined"))){
				sqlsubsuit=sqlsubsuit+  " ( vs.bsizeid ="+bedid+" and m.mtypeid in ( 5  ) )  ";
				bedcount=1;
			}
			else{
				sqltype=sqltype+  " , 5 ";
			}

			
			if(!(engid.equalsIgnoreCase("0") || engid.equalsIgnoreCase("") || engid.equalsIgnoreCase("undefined"))){
				if(bedcount==1){
					sqlsubsuit=sqlsubsuit+  " or " ;
				}
				sqlsubsuit=sqlsubsuit+  "  ( vs.esizeid ="+engid+"  and m.mtypeid in (3 ) )  ";
				enginecount=1;
			}
			else{
				sqltype=sqltype+  " , 3 ";
			}

			
			if(!(cabid.equalsIgnoreCase("0") || cabid.equalsIgnoreCase("") || cabid.equalsIgnoreCase("undefined"))){
				if(bedcount==1 || enginecount==1){
					sqlsubsuit=sqlsubsuit+  " or " ;
				}
				sqlsubsuit=sqlsubsuit+  " ( vs.csizeid ="+cabid+"  and m.mtypeid in (4  ) )  ";
			}
			else{
				sqltype=sqltype+  " , 4 ";
			}

			if((!(bedid.equalsIgnoreCase("0") || bedid.equalsIgnoreCase("") || bedid.equalsIgnoreCase("undefined"))) &&
					(!(engid.equalsIgnoreCase("0") || engid.equalsIgnoreCase("") || engid.equalsIgnoreCase("undefined"))) && 
					(!(cabid.equalsIgnoreCase("0") || cabid.equalsIgnoreCase("") || cabid.equalsIgnoreCase("undefined"))))
					{
						sqlsubsuit=sqlsubsuit+  "or ( vs.csizeid ="+cabid+"  and vs.esizeid ="+engid+"  and  vs.bsizeid ="+bedid+" and  m.mtypeid in ( 6 ) )  ";
					}
					else{
						sqltype=sqltype+  " , 6 ";
					}
			
			// sqlsubsuit=sqlsubsuit+  " ) ";
			sqltype = sqltype+  " )) ";
			
			
			
			}
			if(!(yomfrm.equalsIgnoreCase("0") || yomfrm.equalsIgnoreCase("") || yomfrm.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  " and if(vs.pyomfrmid=0,(("+yomfrm+" between vs.yomfrm  and   vs.yomto) or (vs.yomfrm<="+yomfrm+" and vs.yomto='OPEN')),(("+yomfrm+" between vs.pyomfrm  and  vs.pyomto) or (vs.pyomfrm<="+yomfrm+" and vs.pyomto='OPEN'))) ";
			}

		/*	if(!(yomto.equalsIgnoreCase("0") || yomto.equalsIgnoreCase("") || yomto.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.yomto >='"+yomto+"' ";
			}
*/
 

 
		//	doc_no, psrno, typeid, yomfrm, yomfrmid, yomto, yomtoid, brandid, modelid, submodelid, esizeid, bsizeid, csizeid, date, status
				  
			String gen=" ";
			  System.out.println("==gentype=="+gentype);
			if(gentype.equalsIgnoreCase("1"))
			{
			
			  gen=" union all "
					+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";
			
			}
			
			

			sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+"  "+sqlwhere+" "+sqlsubsuit+" "+sqltype+" group by m.doc_no "+gen+" ;";
			 
			
			
/*
				sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+"  "+sqlwhere+" group by m.doc_no ;"
						+ " union all "
						+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";*/

		//  System.out.println("==sql=type1=1=="+sql);

						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
 

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray partSearchold(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String gridtype,String load
			,String brandid1,String modelid1,String submodelid1,String bedid,String engid,String cabid,String yomfrm,String yomto,String gentype) throws SQLException {


/* 	
		System.out.println("===brandid============================="+brandid1);
		System.out.println("===modelid===="+modelid1);
		System.out.println("===submodelid===="+submodelid1);
		System.out.println("===yomfrm===="+yomfrm);
		System.out.println("===yomto===="+yomto);
		System.out.println("===Bed Size===="+bedid);
		System.out.println("===Engin Size===="+engid);
		System.out.println("===Cabin Size===="+cabid); */
		
		JSONArray RESULTDATA=new JSONArray();

	//	System.out.println("===load===="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
		//	System.out.println("===gridtype======="+gridtype);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
			if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			
			String sqlwhere="";
			
			String sqlsuit="";
 
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ " and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and m.doc_no in ("+hidproduct+")";
			}
	 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and dep.doc_no in ("+hidept+")";
			}

			 
			
			if(!(brandid1.equalsIgnoreCase("0") || brandid1.equalsIgnoreCase("") || brandid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.brandid ="+brandid1+" ";
			}

			if(!(modelid1.equalsIgnoreCase("0") || modelid1.equalsIgnoreCase("") || modelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.modelid ="+modelid1+" ";
			}

			if(!(submodelid1.equalsIgnoreCase("0") || submodelid1.equalsIgnoreCase("") || submodelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.submodelid ="+submodelid1+" ";
			}
			 
			if(!(bedid.equalsIgnoreCase("0") || bedid.equalsIgnoreCase("") || bedid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.bsizeid ="+bedid+" ";
			}

			
			if(!(engid.equalsIgnoreCase("0") || engid.equalsIgnoreCase("") || engid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.esizeid ="+engid+" ";
			}

			
			if(!(cabid.equalsIgnoreCase("0") || cabid.equalsIgnoreCase("") || cabid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.csizeid ="+cabid+" ";
			}

			
			if(!(yomfrm.equalsIgnoreCase("0") || yomfrm.equalsIgnoreCase("") || yomfrm.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  " and if(vs.pyomfrmid=0,(("+yomfrm+" between vs.yomfrm  and   vs.yomto) or (vs.yomfrm<="+yomfrm+" and vs.yomto='OPEN')),(("+yomfrm+" between vs.pyomfrm  and  vs.pyomto) or (vs.pyomfrm<="+yomfrm+" and vs.pyomto='OPEN'))) ";
			}

		/*	if(!(yomto.equalsIgnoreCase("0") || yomto.equalsIgnoreCase("") || yomto.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.yomto >='"+yomto+"' ";
			}
*/
 

 
		//	doc_no, psrno, typeid, yomfrm, yomfrmid, yomto, yomtoid, brandid, modelid, submodelid, esizeid, bsizeid, csizeid, date, status
				  
			String gen=" ";
			  System.out.println("==gentype=="+gentype);
			if(gentype.equalsIgnoreCase("1"))
			{
			
			  gen=" union all "
					+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";
			
			}
			
			

			sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+"  "+sqlwhere+" group by m.doc_no "+gen+" ;";
			 
			
			
/*
				sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+"  "+sqlwhere+" group by m.doc_no ;"
						+ " union all "
						+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";*/

	//	  System.out.println("==sql=type1=1=="+sql);

						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
 

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	
	public JSONArray partSearch2(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String gridtype,String load
			,String brandid1,String modelid1,String submodelid1,String bedid,String engid,String cabid,String yomfrm,String yomto,String gentype) throws SQLException {


 	
/*		System.out.println("===brandid===="+brandid1);
		System.out.println("===modelid===="+modelid1);
		System.out.println("===submodelid===="+submodelid1);
		System.out.println("===yomfrm===="+yomfrm);
		System.out.println("===yomto===="+yomto);
		System.out.println("===Bed Size===="+bedid);
		System.out.println("===Engin Size===="+engid);
		System.out.println("===Cabin Size===="+cabid); 
		*/
		JSONArray RESULTDATA=new JSONArray();

	//	System.out.println("===load===="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
		//	System.out.println("===gridtype======="+gridtype);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
			if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			
			String sqlwhere="";
			
			String sqlsuit="";
 
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ " and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and m.doc_no in ("+hidproduct+")";
			}
	 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and dep.doc_no in ("+hidept+")";
			}

			 
			
			if(!(brandid1.equalsIgnoreCase("0") || brandid1.equalsIgnoreCase("") || brandid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.brandid ="+brandid1+" ";
			}

			if(!(modelid1.equalsIgnoreCase("0") || modelid1.equalsIgnoreCase("") || modelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.modelid ="+modelid1+" ";
			}

			if(!(submodelid1.equalsIgnoreCase("0") || submodelid1.equalsIgnoreCase("") || submodelid1.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.submodelid ="+submodelid1+" ";
			}
			 
	/*		if(!(bedid.equalsIgnoreCase("0") || bedid.equalsIgnoreCase("") || bedid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.bsizeid ="+bedid+" ";
			}

			
			if(!(engid.equalsIgnoreCase("0") || engid.equalsIgnoreCase("") || engid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.esizeid ="+engid+" ";
			}

			
			if(!(cabid.equalsIgnoreCase("0") || cabid.equalsIgnoreCase("") || cabid.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  "and vs.csizeid ="+cabid+" ";
			}*/

			
			if(!(yomfrm.equalsIgnoreCase("0") || yomfrm.equalsIgnoreCase("") || yomfrm.equalsIgnoreCase("undefined"))){
				sqlsuit=sqlsuit+  " and if(vs.pyomfrmid=0,(("+yomfrm+" between vs.yomfrm  and   vs.yomto) or (vs.yomfrm<="+yomfrm+" and vs.yomto='OPEN')),(("+yomfrm+" between vs.pyomfrm  and  vs.pyomto) or (vs.pyomfrm<="+yomfrm+" and vs.pyomto='OPEN'))) ";
			}

 	  
			String gen=" ";
			  System.out.println("==gentype=="+gentype);
			if(gentype.equalsIgnoreCase("1"))
			{
			
			  gen=" union all "
					+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";
			
			}
			
			

			sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
					+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
					+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
					+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
					+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
					+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
					+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+"  "+sqlwhere+" group by m.doc_no "+gen+" ;";
			 
	 

		  System.out.println("==pa=2=="+sql);
//
						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
 

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray suitSearch(HttpSession session,String yomfrm,String yomto,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		
		if(!(load.equalsIgnoreCase("load")))
		{
		return RESULTDATA;	
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select s.doc_no,coalesce(syf.yom,s.yom_frm) yomfrm,coalesce(syt.yom,s.yom_to) yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
					+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
					+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
					+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
					+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
					+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
					+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
					+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
					+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
					+ "s.sbrandid brandid,s.smodelid brandid,s.submodelid submodelid,s.esizeid,s.bsize1id,s.bsize2id,s.bsize3id,"
					+ "s.csize1id,s.csize2id,s.csize3id,ps.syomfrm_id yomfrmid,ps.syomto_id yomtoid  "
					+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid ) left join my_smodel m on(m.doc_no=s.smodelid)"
					+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)"
					+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
					+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
					+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
					+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
					+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
					+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
					+ "left join my_prodsuit ps on(ps.vehsuitid=s.doc_no)"
					+ "left join my_syom syf on(ps.syomfrm_id=syf.doc_no)"
					+ "left join my_syom syt on(ps.syomto_id=syt.doc_no)"
					+ "where s.status=3 ";

			/*and date_format(str_to_date(s.yom_frm,'%Y'),'%Y')>="+yomfrm+" and date_format(str_to_date(yom_to,'%Y'),'%Y')<="+yomto+"*/

		//	System.out.println("=sql==suitSearch="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray brandFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
 
	public JSONArray catFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category,doc_no  from my_catm where status <> 7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray subCatFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory,doc_no  from my_scatm where status <>7 ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

public JSONArray productSearch(HttpSession session) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
	 
		String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no) "
				+ "inner join my_catm c on(m.catid=c.doc_no)  where m.status=3 ";
		System.out.println("==productSearch==="+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}
public   JSONArray pricelistgridsearch(String psrno) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    

	
 	Connection conn = null;
    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			
				String sql=" select convert(a.scode,char(100)) scode,convert(a.sname,char(100)) sname,convert(a.doc_no,char(100)) sdoc_no,convert(a.stdcost,char(100)) stdcost "
						+ "    ,convert(a.margin,char(100)) salmargin,convert(a.fprice,char(100)) psellingprices,convert(a.fprice,char(100)) fixingprice  from "
						+ " ( select '1' nos, s.doc_no,s.scode,s.sname,p.stdcost,p.margin,p.fprice from my_scopepr p left join my_scope s on s.doc_no=p.scpid where psrno='"+psrno+"' union all "
						+ " select  '2' nos,  s.doc_no,s.scode,s.sname ,p.stdcost,p.margin,p.fprice from my_scope s left join my_scopepr p on s.doc_no=p.scpid and p.psrno='"+psrno+"' where status=3 and p.scpid is null) a where 1=1 order by a.nos,a.doc_no ";
			
					//System.out.println("-----sql----"+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
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



public   JSONArray pricelistgridsearchex(String psrno) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    

	
 	Connection conn = null;
    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			
			
 
			
				String sql=" select convert(a.scode,char(100)) 'Scope Code',convert(a.sname,char(100)) 'Scope Name',convert(a.stdcost,char(100)) 'Std_Cost' "
						+ "   ,convert(a.fprice,char(100)) 'Present Selling Price' ,convert(a.margin,char(100)) 'Sales Margin',convert(a.fprice,char(100)) 'Final Price'  from "
						+ " ( select '1' nos, s.doc_no,s.scode,s.sname,p.stdcost,p.margin,p.fprice from my_scopepr p left join my_scope s on s.doc_no=p.scpid where psrno='"+psrno+"' union all "
						+ " select  '2' nos,  s.doc_no,s.scode,s.sname ,p.stdcost,p.margin,p.fprice from my_scope s left join my_scopepr p on s.doc_no=p.scpid and p.psrno='"+psrno+"' where status=3 and p.scpid is null) a where 1=1 order by a.nos,a.doc_no ";
			
					//System.out.println("-----sql----"+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
public JSONArray brandmargin(String  brandid) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="select from_amt froms,to_amt tos ,per_margin  permargin from my_brandmargin where brdid='"+brandid+"';";

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
