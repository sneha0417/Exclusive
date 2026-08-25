package com.dashboard.pricemanagement.pricemanagementreview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPriceManagementReviewDAO { 

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray listgridsearch(String branch,String fromdate,String todate,String sta) throws SQLException {

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

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
 				String sql="select pin.op_qty-pin.out_qty,m.doc_no,m.tr_no,m.voc_no,m.acno,t.account account,t.description accname from my_srvm m "
						+ "	left join  my_head t on t.doc_no=m.acno inner join my_acbook a on (t.cldocno=a.cldocno and "
						+ "	  a.dtype='VND' and t.atype='AP' and a.active=1 and t.m_s=0 ) left join my_srvd d on d.rdocno=m.doc_no  "
						+ "  left join my_prddin pin on pin.stockid=d.stockid where m.status=3 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "
								+ " group by m.doc_no having sum(pin.op_qty-pin.out_qty)!=0 ";
				
            	 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	public   JSONArray  gridsearch(String branch,String fromdate,String todate,String sta) throws SQLException {

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

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
 				String sql="select pin.op_qty-pin.out_qty,m.doc_no,m.tr_no,m.voc_no,m.acno,t.account account,t.description accname from my_srvm m "
						+ "	left join  my_head t on t.doc_no=m.acno inner join my_acbook a on (t.cldocno=a.cldocno and "
						+ "	  a.dtype='VND' and t.atype='AP' and a.active=1 and t.m_s=0 ) left join my_srvd d on d.rdocno=m.doc_no  "
						+ "  left join my_prddin pin on pin.stockid=d.stockid where m.status=3 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "
								+ " group by m.doc_no having sum(pin.op_qty-pin.out_qty)!=0 ";
				
            	 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	
	public   JSONArray  clientmgtreports(String branch,String fromdate,String todate,String cldocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
				
				String sqltest="";
				
				 if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
                     sqltest=sqltest+" and a.cldocno = '"+cldocno+"'";
                }
				 
				 
 				String sql="select c.date,u.user_name,a.refname,a.per_mob,m1.cat_name oldcat,m2.cat_name newcat, "
 						+ " if(c.dtype='RCM','Retail Client Management','Client Management') type from my_bclmgt c left join my_acbook a on a.cldocno=c.cldocno "
 						+ " left join my_user u on u.doc_no=c.userid left join my_clcatm m1 on m1.doc_no=c.oldcatid  "
 						+ " left join my_clcatm m2 on m2.doc_no=c.newcatid where a.dtype='CRM' "+sqltest;
				
            	 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	
	public   JSONArray mainlistgridsearch(String branch,String fromdate,String todate,String sta,String doc_no) throws SQLException {

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

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{ 
		     
		     	}
		     	
		     	
		     	
		     	
		     	
	          
				String sql="select  convert(if(a.std_cost=0,'',std_cost),char(100)) std_cost,convert(if(a.fixing=0,'',a.fixing),char(100)) fixing,convert(if(a.fixing=0,'',a.fixing),char(100))"
						+ " psellingprice, a.brandname,a.brandid,a.psrno,a.unit,a.part_no,a.productname,a.qty qty,a.costprice costprice,a.stkqty stkqty,a.totalvalue totalvalue, "
						+ "   a.totalvalue/a.stkqty avgcost,a.costprice-(a.totalvalue/a.stkqty) variation from( "
						+ "  select bd.brandname,ma.stdprice std_cost,ma.fixingprice fixing,ma.brandid,pin.psrno,ma.part_no,ma.productname,pin.op_qty qty,pin.cost_price costprice,p.stkqty,p.cost_prices  "
						+ "  totalvalue,m.doc_no,m.voc_no,m.acno,	t.account account,t.description accname,u.unit,pin.tr_no from my_srvm m  "
						+ " left join  my_head t on t.doc_no=m.acno inner join my_acbook a  on (t.cldocno=a.cldocno and	a.dtype='VND' and t.atype='AP' and a.active=1 and t.m_s=0)  "
						+ "       left join my_srvd d on d.rdocno=m.doc_no  left join my_prddin pin on pin.stockid=d.stockid and pin.cost_price!=0 left join my_main ma on ma.psrno=pin.psrno  "
						+ " left join  my_brand bd on ma.brandid=bd.doc_no  left join (select sum(stkqty) stkqty,sum(cost_prices) cost_prices,prdid from  "
						+ " (select op_qty-(out_qty+del_qty+rsv_qty) stkqty ,prdid,(op_qty-(out_qty+del_qty+rsv_qty))*cost_price   cost_prices   from my_prddin where cost_price!=0) a group by prdid) "
						+ "    p on p.prdid=pin.prdid "
						+ "	  left join my_unitm u on d.unitid=u.doc_no"
						+ " where m.status=3 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"') a where 1=1 and a.doc_no='"+doc_no+"' group by a.doc_no,a.psrno having sum(a.stkqty)!=0  ";
				
	            
	            
/*	            
	            String sql=" select a.brandname,a.brandid,a.psrno,a.unit,a.part_no,a.productname,sum(a.qty) qty,sum(a.costprice) costprice,sum(a.stkqty) stkqty,sum(a.totalvalue) totalvalue, "
						+ "	sum(a.avgcost) avgcost from( select bd.brandname,ma.brandid,pin.psrno,ma.part_no,ma.productname,pin.op_qty qty, "
						+ "	pin.cost_price costprice,(pin.op_qty-pin.out_qty) stkqty,(pin.op_qty-pin.out_qty)*pin.cost_price "
						+ " totalvalue,((pin.op_qty-pin.out_qty)*pin.cost_price)/(pin.op_qty-pin.out_qty) avgcost,m.doc_no,m.voc_no,m.acno, "
						+ "	t.account account,t.description accname,u.unit,pin.tr_no from my_srvm m	left join  my_head t on t.doc_no=m.acno inner join my_acbook a "
						+ " on (t.cldocno=a.cldocno and	a.dtype='VND' and t.atype='AP' and a.active=1 and t.m_s=0) left join my_srvd d on d.rdocno=m.doc_no "
						+ "	 left join my_prddin pin on pin.stockid=d.stockid left join my_main ma on ma.psrno=pin.psrno  left join my_unitm u on d.unitid=u.doc_no"
						+ " left join  my_brand bd on ma.brandid=bd.doc_no   "
						+ " where m.status=3 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"') a where 1=1 and a.doc_no='"+doc_no+"' group by a.doc_no,a.psrno having sum(a.stkqty)!=0  ";*/
				
          // System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	public   JSONArray genaralmainlistgridsearch(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,String psrno) throws SQLException {

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
 		     	
 
 		     	
		 String sql=" select   "+namesql+"  convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))  labourcharge,pin.brhid,ma.psrno,ma.brandid branddoc,0 totalvalue,  "
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
		   + "   where 1=1 and  av.price is not null and   pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'"+wheresql+"  group by ma.psrno  "  ; 
 		     	
 		     	
		     	
 		     	/* having sum(p.stkqty)!=0*/
 
 
      //System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	
	
	public   JSONArray genaralmainlistgridsearchExcel(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,String psrno) throws SQLException {

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
		   
		  		
			 
		  		
		 				  
		 		 String sql=" select ma.part_no 'Product Id',ma.productname 'Product Name' "+namesql+",ps.op_qty  Qty,ps.cost_price 'Cost Per',st.stkqty 'Stock Qty' "
		  		     			+ "  ,av.price 'Avg Purchase Cost',ps.cost_price-av.price variation,  "
		  		     			+ " convert(if(ma.stdprice=0,'',ma.stdprice),char(100))  Std_Cost ,  "
		  		     			+ " convert(if(ma.fixingprice=0,'',ma.fixingprice),char(100))    'Final Price',   "
		  		     			+ " convert(if(ma.lbrchg=0,'',ma.lbrchg),char(100))   'Labour Charge'    "
		  		     			+ "   from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno left join  my_brand bd on ma.brandid=bd.doc_no  "
		  		     			+ "  left  join my_catm ca on ma.catid=ca.doc_no  "
		  		     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_unitm u on ma.munit=u.doc_no   "
		  		     			+ "   left join ( select max(stockid) stockid,prdid from my_prddin where pstatus=1 "+branchsql+"  group by prdid )  "
		  		     			+ "  ss on ss.prdid=ma.psrno  left join ( select op_qty,coalesce(cost_price,0) cost_price,prdid,stockid  "
		  		     			+ "  from my_prddin where pstatus=1   ) ps on ps.stockid=ss.stockid  	left join (select sum(op_qty-(out_qty+del_qty+rsv_qty))  "
		  		     			+ "   stkqty ,prdid from my_prddin  group by prdid) st on st.prdid=ma.psrno  	left join  "
		  		     			+ "   ( select coalesce(sum(coalesce(cost_price*op_qty,0))/sum(coalesce(op_qty,0)),0) price ,prdid  "
		  		     			+ "   from my_prddin where DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+branchsql+"	group by prdid) av on av.prdid=ma.psrno  "
		  		     			+ "   where 1=1 and    av.price is not null and  pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'"+wheresql+"  group by ma.psrno  "  ; 
		     	
 		     	/* having sum(p.stkqty)!=0*/
 
 
  // System.out.println("-----sql-asdsa---"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
	
	public   JSONArray stockclearlistgridsearch(String branch,String fromdate,String todate,String salescount,String type,String brandid,String catid,String subcatid,String psrno,String load) throws SQLException {

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
			     		/*wheresql= " and  a.psrno="+psrno+" ";*/
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
			     		 
			     	}
			     	
		     	String sql=" select   "+namesql+"  a.age,a.outqty, a.brandid branddoc,convert(if(a.std_cost=0,'',std_cost),char(100)) std_cost,"
		     			+ "  convert(if(a.fixing=0,'',fixing),char(100)) fixing,convert(if(a.fixing=0,'',fixing),char(100)) psellingprice,convert(if(a.clearprice=0,'',clearprice),char(100)) clearprice, "
		     			+ " a.psrno,a.unit,a.part_no,a.productname,a.qty qty,a.costprice costprice,a.stkqty stkqty,   a.totalvalue totalvalue, "
		     			+ " a.totalvalue/a.stkqty avgcost,a.costprice-(a.totalvalue/a.stkqty) variation from "
		     			+ " (select ca.category,ca.doc_no catid,sc.subcategory,sc.doc_no subcatid,ma.clrprice clearprice ,ma.stdprice std_cost,ma.fixingprice fixing,bd.brandname,"
		     			+ " ma.brandid,pin.psrno,ma.part_no,ma.productname,sum(pin.op_qty) "
		     			+ "  qty,sum(pin.cost_price)/sum(total) costprice,sum(p.age)/sum(total) age  ,  sum(p.stkqty) stkqty,sum(p.outqty) outqty,sum(p.cost_prices) "
		     			+ "  totalvalue, u.unit,pin.tr_no from  my_prddin pin   left join my_main ma on ma.psrno=pin.psrno "
		     	        + "  left join  my_brand bd on ma.brandid=bd.doc_no  left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no   left join " 
		     	        + "  (select sum(age) age,count(*) total,sum(stkqty) stkqty,sum(outqty) outqty,sum(cost_prices) "
		     	        + "   cost_prices,prdid,stockid from   (select datediff(curdate(), date) age, "
		     	        + "  op_qty-(out_qty+del_qty+rsv_qty) stkqty ,(out_qty+del_qty+rsv_qty) outqty,prdid,stockid, "
		     	        + "  (op_qty-(out_qty+del_qty+rsv_qty))*cost_price   cost_prices "
		     	        + "  from my_prddin where cost_price!=0    and DATE between  '"+sqlfromdate+"' and  curdate()) a group by stockid) "
		     	        + "  p on p.stockid=pin.stockid 	  left join my_unitm u on ma.munit=u.doc_no where pin.cost_price!=0 "
		     	        + "   and  pin.DATE between '"+sqlfromdate+"' and     curdate() group by pin.prdid having sum(p.outqty)<="+salescount+" and sum(p.stkqty)!=0   ) a where 1=1 "+wheresql+"  ";
		     	                     
 
 
 		     //	System.out.println("-----sql----"+sql);
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
	
	
	
	public   JSONArray offerlistgridsearch(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,String psrno) throws SQLException {

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
		     		namesql = " a.brandname,a.brandid,";
		     		 wheresql= " and  a.brandid="+brandid+" ";
		     		 
		     		
		     	}
		     	else if(type.equalsIgnoreCase("PR"))
		     	{
		     		sqlgroup= "group by pin.prdid";
		     		namesql = "   a.brandname,a.brandid,";
		     		wheresql= " and  a.psrno="+psrno+" ";
		     		/*wheresql= " and  a.psrno="+psrno+" ";*/
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
		     		 
		     	}
		     	
		
		/*		String sql="select   "+namesql+" a.brandid branddoc,a.psrno,a.unit,a.part_no,a.productname,a.qty qty,a.costprice costprice,a.stkqty stkqty,a.totalvalue totalvalue, "
						+ "   a.totalvalue/a.stkqty avgcost,a.costprice-(a.totalvalue/a.stkqty) variation from( "
						+ "  select bd.brandname,ma.brandid,pin.psrno,ma.part_no,ma.productname,pin.op_qty qty,pin.cost_price costprice,p.stkqty,p.cost_prices  "
						+ "  totalvalue ,u.unit,pin.tr_no my_prddin pin on pin.stockid=d.stockid and pin.cost_price!=0 left join my_main ma on ma.psrno=pin.psrno  "
						+ " left join  my_brand bd on ma.brandid=bd.doc_no  left join (select sum(stkqty) stkqty,sum(cost_prices) cost_prices,prdid from  "
						+ " (select op_qty-(out_qty+del_qty+rsv_qty) stkqty ,prdid,(op_qty-(out_qty+del_qty+rsv_qty))*cost_price   cost_prices  "
						+ "  from my_prddin where cost_price!=0) a group by prdid) "
						+ "    p on p.prdid=pin.prdid "
						+ "	  left join my_unitm u on d.unitid=u.doc_no left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no"
						+ " where m.status=3 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"') a where 1=1 and "+wheresql+" group by a.psrno having sum(a.stkqty)!=0  ";
		     	
		     	*/
		     	
 		     	String sql=" select  "+namesql+" a.brandid branddoc,0 cellselects,a.star,convert(if(a.std_cost=0,'',std_cost),char(100)) std_cost, "
 		     			+ " convert(if(a.fixing=0,'',fixing),char(100)) psellingprice, convert(if(a.fixing=0,'',fixing),char(100)) fixing,"
 		     			+ "  a.psrno,a.unit,a.part_no,a.productname,a.qty qty,a.costprice costprice,a.stkqty stkqty, "
		     			+ "  a.totalvalue totalvalue,    a.totalvalue/a.stkqty avgcost,a.costprice-(a.totalvalue/a.stkqty) variation from  "
		     			+ "   (select ma.star,ca.category,ca.doc_no catid,sc.subcategory,sc.doc_no subcatid,ma.stdprice std_cost,ma.fixingprice fixing,"
		     			+ " bd.brandname,ma.brandid,pin.psrno,ma.part_no,ma.productname,sum(pin.op_qty) qty,sum(pin.cost_price)/sum(total) costprice, "
		     			+ "   sum(p.stkqty) stkqty,sum(p.cost_prices)  totalvalue, u.unit,pin.tr_no from  my_prddin pin "
		     			+ "  left join my_main ma on ma.psrno=pin.psrno        left join  my_brand bd on ma.brandid=bd.doc_no  "
		     			+ "   left  join my_catm ca on ma.catid=ca.doc_no  left  join  my_scatm sc on ma.scatid=sc.doc_no "
		     			+ "  left join (select count(*) total,sum(stkqty) stkqty,sum(cost_prices) "
		     			+ "    cost_prices,prdid,stockid from   (select op_qty-(out_qty+del_qty+rsv_qty) stkqty ,prdid,stockid, "
		     			+ "   (op_qty-(out_qty+del_qty+rsv_qty))*cost_price   cost_prices   from my_prddin where cost_price!=0  "
		     			+ "  and DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"') a group by stockid) "
		     	       + "      p on p.stockid=pin.stockid 	  left join my_unitm u on ma.munit=u.doc_no where pin.cost_price!=0 "
		     	      + "    and  pin.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlgroup+" having sum(p.stkqty)!=0  ) a where 1=1 "+wheresql+" "; 
		     	
		     	
 
 
     //    System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	

	public   JSONArray clientsudeseaarch(String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
 
     
      String sqltest="";
                  /*   if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }*/
                     
                     
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and a.refname like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select a.cldocno,a.refname,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from  "
    		+ "  my_acbook a  where  a.dtype='CRM'	 "+sqltest;
 
    
  //  System.out.println("-----sql---+"+sql);
    
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	
	
	
	public   JSONArray clientsearch(String branch,String fromdate,String todate,String cldocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
			    /*java.sql.Date sqlfromdate = null;*/
		     /*	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
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
		     
		     	}*/
				 String sqltest="";
			    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    		sqltest+=" and a.brhid='"+branch+"'";
			 		}
				
				 
				 if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
                     sqltest=sqltest+" and a.cldocno = '"+cldocno+"'";
                }
				
 				String sql="select a.refname, a.per_mob ,a.address ,a.mail1,c.category,a.cldocno from my_acbook a "
 						+ "  left join my_clcatm c on c.doc_no=a.catid and c.dtype='CRM' where a.dtype='crm' "+sqltest;
				
            	// System.out.println("--sql--"+sql);
            		 ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	public   JSONArray pricelistgridsearch(String psrno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  

/*				String sql="select   convert(p.catid,char(100)) catid ,convert(if(p.price1=0,'',p.price1),char(100)) price1,convert(if(p.price2=0,'',p.price2),char(100)) price2,convert(if(p.price3=0,'',p.price3),char(100)) price3, "
						+ " convert(if(p.discount1=0,'',p.discount1),char(100)) discount1,convert(if(p.discount2=0,'',p.discount2),char(100)) discount2,convert(if(p.discount3=0,'',p.discount3),char(100)) discount3, "
						+ " convert(if(p.foc1=0,'',p.foc1),char(100)) foc1, convert(if(p.foc2=0,'',p.foc2),char(100)) foc2,convert(if(p.foc3=0,'',p.foc3),char(100)) foc3, "
						+ " convert(if(p.qty1=0,'',p.qty1),char(100)) qty1,convert(if(p.qty2=0,'',p.qty2),char(100))  qty2,convert(if(p.qty3=0,'',p.qty3),char(100)) qty3,c.cat_name from my_descpr p left join my_clcatm c on p.catid=c.doc_no where psrno='"+psrno+"' "
								+ "	union all select  convert(doc_no,char(100)) catid,  convert('',char(100)) price1, convert('',char(100)) price2, convert('',char(100)) price3, convert('',char(100)) discount1,convert('',char(100)) discount2, convert('',char(100)) discount3, "
								+ "	convert('',char(100)) foc1, convert('',char(100)) foc2, convert('',char(100)) foc3,convert('',char(100)) qty1,convert('',char(100)) qty2,convert('',char(100)) qty3, cat_name from my_clcatm 	where doc_no not in(select catid from my_descpr where psrno='"+psrno+"')";
				
						*/
				
				int counts=0;
				String sqls="select count(*) counts from my_clcatm where dtype='CRM' and status=3 and  pricegroup not in(0)";
				ResultSet rss=stmtVeh.executeQuery(sqls);
				if(rss.next())
				{
					counts=rss.getInt("counts");
				}
				
				
				String sql="select convert(cat_name,char(100)) cat_name,convert(pricegroup,char(100)) pricegroup,convert(catid,char(100)) catid ,convert(discount1,char(100)) discount1,'"+counts+"' counts,convert(olddiscount,char(100)) olddiscount from( "
						+ " select c.cat_name,c.pricegroup,p.catid,if(c.pricegroup=0,0,'') discount1,p.discount1 olddiscount from my_descpr p "
						+ " left join my_clcatm c on p.catid=c.doc_no where c.status=3 and psrno='"+psrno+"' and  c.dtype='CRM' "
						+ " union all select  m.cat_name,m.pricegroup,convert(m.doc_no,char(100)) catid,if(m.pricegroup=0,0,'') discount1,'' olddiscount from my_clcatm m "
						+ " where m.status=3 and doc_no not in(select catid from my_descpr where psrno='"+psrno+"'  and  m.dtype='CRM') and  m.dtype='CRM') a order by pricegroup";
				
				
				
				
            	  //System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	
	
	public   JSONArray usersearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select user_name,doc_no,user_id from my_user where status=3";
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
	
	
	public   JSONArray searchSalesPerson() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select m.doc_no,m.sal_name,m.mob_no,m.mail,u.user_name username,cl.cat_name category,m.usgper from my_salm m  "
					+ " left join my_user u on m.userid=u.doc_no left join my_clcatm cl on cl.doc_no=m.catid where m.status=3;";
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
	
	public   JSONArray brandmaingrid(String branch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
		 
  /*
				String sql=" select max(cost_price) maxprice,min(cost_price) minprice,brand,b.doc_no from my_prddin p "
						+ " inner join my_main m on p.prdid=m.doc_no inner join my_brand b on b.doc_no=m.brandid  group by b.doc_no   order by   b.doc_no;  ";
				*/
		
				
				String sql=" select convert(coalesce(max(inv.amount),''),char(100)) maxsale,convert(coalesce(min(inv.amount),''),char(100))  minsale, "
						+ " convert(coalesce(max(cost_price),''),char(100)) maxprice,convert(coalesce(min(cost_price),''),char(100))  minprice,brand,b.doc_no from my_prddin p "
						+ " inner join my_main m on p.prdid=m.doc_no inner join my_brand b on b.doc_no=m.brandid "
						+ " left join my_invd inv on inv.prdid=m.doc_no where p.cost_price>0 "
						+ " group by b.doc_no   order by   b.doc_no ";
				
            	// System.out.println("-----sql----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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