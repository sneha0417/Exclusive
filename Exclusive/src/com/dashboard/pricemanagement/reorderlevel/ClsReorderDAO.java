package com.dashboard.pricemanagement.reorderlevel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsReorderDAO 
{

		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();

	
		public   JSONArray reordersearch(String branch,String fromdate,String todate,String type,String brandid,String catid,
				String subcatid,String psrno,String load,String levelcount) throws SQLException
		{

					JSONArray RESULTDATA=new JSONArray();
        
   
    	
					Connection conn = null;
        
					try
					{
							conn = ClsConnection.getMyConnection();
							Statement stmtVeh = conn.createStatement ();  
							if(load.equalsIgnoreCase("yes"))  
							{
							  java.sql.Date sqlfromdate = null;
						     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
						     	{
						     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
						     		//System.out.println("fffffffffffffffffffffffffffffff"+fromdate);
						     		
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
						     	String branchsql="";
						     	String branchsqlin="";
						     	String branchsqlout="";
						     	String branchsql1="";
						  		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA") && !branch.equalsIgnoreCase("")){
						  			branchsqlin=" and pin.brhid="+branch+" "; 
						  			branchsqlout=" and pout.brhid="+branch+" ";
						  			branchsql=" and brhid="+branch+" "; 
						  			
						  			branchsql1="	and if(ds.brhid=0,"+branch+",ds.brhid)='"+branch+"' ";
								}
						  		
						  	 
						  		
						  		
									
									String sqlgroup="";
									String namesql="";
									String wheresql="";
		          
									if(type.equalsIgnoreCase("BR"))
									{
											//sqlgroup= "group by ma.brandid ";
										
											wheresql= " and  ma.brandid="+brandid+" ";
			     		 
			     		
									}
									else if(type.equalsIgnoreCase("PR"))
									{
			     		 
											wheresql= " and  ma.doc_no="+psrno+" ";
											/*wheresql= " and  a.psrno="+psrno+" ";*/
									}
			     	
									else if(type.equalsIgnoreCase("CA"))
									{
											//sqlgroup= "group by ca.doc_no";
			     		 
											wheresql= " and  ma.catid="+catid+" ";
			     	 
									}
			     	
									else if(type.equalsIgnoreCase("SC"))
									{
											//sqlgroup= "group by sc.doc_no";
			     		 
											wheresql= " and ma.scatid="+subcatid+" ";
			     		 
									}
									
								//	System.out.println("-----load----"+load);
									
									
									
									
								 	int t=0;
										
								  		String sql1="select datediff('"+sqltodate+"','"+sqlfromdate+"')";	
								  		
								  		System.out.println("datediff="+sql1);
								     	ResultSet resultSet = stmtVeh.executeQuery(sql1);
							    
							    
							  		
							while(resultSet.next())
									{
									t=resultSet.getInt(1);
 						   
							 	}
							String sqltest="";
							String sqltest1="";
							if(!(psrno.equalsIgnoreCase("0")) && !(psrno.equalsIgnoreCase(""))){
								sqltest=sqltest+" and ma.psrno= '"+psrno+"'";
								sqltest1=" and pin.prdid= '"+psrno+"'";
								
							}
			     	
									/*		String sql="select ma.doc_no psrno ,if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel) reorderlevel, "
											+ " sum(ds.reorderqty) reorderqty,ma.part_no,ma.productname,bd.brandname brand "
											+ " from  my_main ma   left join  my_brand bd on ma.brandid=bd.doc_no  "
											+" left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no "
											+ " left join my_desc ds on ds.psrno=ma.doc_no where 1=1 "+wheresql+"  group by ma.doc_no ";
 		     */
							String sqlscounts="";
							
							if(!(levelcount.equalsIgnoreCase("0")) && !(levelcount.equalsIgnoreCase(""))){
								sqlscounts= " having d.stockquantity<(sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1)+"+Double.parseDouble(levelcount)+") " ;
							 
							}					     	
							else
							{
								
								// sqlscounts= " having d.stockquantity<sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1) ";
							}
					     	
							 
					     /*	String sql=" select  if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(a.cou,1),1) reorderlevel, "
					     			+ "  sum(ds.reorderqty)/if(ds.brhid=0,coalesce(a.cou,1),1) reorderqty,b.psrno,b.prdid,productname,part_no,purchasequantity,salequantity,stockquantity, "
					     			+ "  averagesalespermonth,averagepurchasepermonth,brand "
					     			+ " from ( select  bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, ma.productname, ma.part_no, "
					     			+ "   sum(pin.op_qty) purchasequantity,(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty)) salequantity, "
					     			+ "  (select sum(pin.op_qty)-(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))) stockquantity, "
					     			+ "  (select ((sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))/"+t+")*30) averagesalespermonth, "
					     			+ " (select (sum(pin.op_qty)/"+t+")*30) averagepurchasepermonth from my_main ma  "
					     			+ "  left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     			+ "   left join my_dept dep on(dep.doc_no=ma.deptid)     left  join my_catm ca on ma.catid=ca.doc_no "
					     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_prddin pin on pin.prdid=ma.doc_no "+branchsql+" where ma.status=3  "+wheresql+"  "
					     	       + "   group by ma.doc_no) b inner join my_desc ds on ds.psrno=b.psrno   "
					     	       + "left join (select   count(*) cou,psrno  from my_desc   where brhid>0 group by psrno) a on a.psrno=ds.psrno  "
					     	       + " where 1=1 "+sqlscounts+"   group by b.psrno " ;
					     	*/ 
					     	String sql=" 	select  ds.brhid '',k.cou '',if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1) reorderlevel, "
					     			+ "  sum(ds.reorderqty)/if(ds.brhid=0,coalesce(k.cou,1),1) reorderqty,b.brand,b.psrno,b.prdid,b.part_no, "
					     	 + "  b.productname,a.purchasequantity,c.salequantity, ((a.purchasequantity/"+t+")*30) averagepurchasepermonth, "
					     	 + "   ((c.salequantity/"+t+")*30) averagesalespermonth,d.stockquantity ,sv.stockprice from(select bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, "
					     	 + "    ma.productname, ma.part_no  from my_main ma "
					     	+ "   left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     	+ "   left join my_dept dep on(dep.doc_no=ma.deptid) "
					     	+ "   left  join my_catm ca on ma.catid=ca.doc_no "
					        + "  	left  join  my_scatm sc on ma.scatid=sc.doc_no "
					     	+ "  left join my_prddin pin on pin.psrno=ma.psrno "
					        + "  	where   ma.status=3  "+wheresql+" group by ma.doc_no) b "
					     	+ "  left join (select pin.stockid,pin.psrno,coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.qty),0) purchasequantity from my_prddin pin " /*branchsqlin branchsqlout*/
					     + "  	left join my_prddout pout on(pin.stockid=pout.stockid and pout.dtype in ('PIR','GRR') and pout.date between'"+sqlfromdate+"' and '"+sqltodate+"' and pout.brhid=1  ) "
					       + "  	where pin.dtype in ('PIV','GRN') and pin.date between '"+sqlfromdate+"' and '"+sqltodate+"' and pin.brhid=1  group by  pin.psrno) a on a.psrno=b.psrno "
					      		+ " left join (select pout.stockid,pout.psrno,coalesce(sum(pout.qty+pout.del_qty),0)-coalesce(pin.op_qty,0) salequantity "
					     		+ " from my_prddout pout  left join (select sum(pin.op_qty) op_qty,pin.refstockid,pin.dtype from my_prddin pin   left join my_invr m on (m.tr_no=pin.tr_no and m.ftype=0) "
					     		+ " where pin.dtype in ('INR','DLR') and pin.date between '"+sqlfromdate+"' and '"+sqltodate+"'   and m.ftype=0      group by pin.refstockid)  pin  on(pin.refstockid=pout.stockid) "
					     		+ "  left join my_invm m on (m.tr_no=pout.tr_no and m.ftype=0) where    pout.dtype in ('INV','DEL') and m.ftype=0 and  pout.date  between '"+sqlfromdate+"' and '"+sqltodate+"'   group by  pout.psrno) c on c.psrno=b.psrno"
					     	+ " left join (select coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.outqty),0) stockquantity,pin.psrno,pin.stockid from  my_prddin pin "
					     	+ " left join (select sum(qty+del_qty) outqty,stockid,psrno from  my_prddout where  date<='"+sqltodate+"'   group by stockid ) "
					     	+ " pout  on (pout.stockid=pin.stockid ) where pin.date<='"+sqltodate+"'   group by pin.psrno) d on d.psrno=b.psrno "
					     	+ " left join (select sum(stockprice)/sum(op_qty) stockprice, psrno from (select op_qty*cost_price  stockprice ,op_qty,psrno,stockid "
					     	+ " from  my_prddin where date<='"+sqltodate+"'  group by stockid) k group by psrno ) sv on sv.psrno=d.psrno  "
					     	+ "   inner join my_desc ds on ds.psrno=b.psrno  "
					     	+ "   left join (select   count(*) cou,psrno  from my_desc "
					     	+ "   where brhid>0 group by psrno) k on k.psrno=ds.psrno where 1=1     group by b.psrno  "+sqlscounts+" " ;
					     	
					     	
/*					     	select m.ftype,pout.stockid,pout.psrno,coalesce(sum(pout.qty+pout.del_qty),0)-coalesce(pin.op_qty,0)
					     	salequantity  from my_prddout pout  left join (select sum(pin.op_qty) op_qty,pin.refstockid,pin.dtype
					     	 from my_prddin pin   left join my_invr m on (m.tr_no=pin.tr_no and m.ftype=0)
					     	  where pin.dtype in ('INR','DLR') and pin.date between '2017-01-01' and '2017-04-03'
					     	 and pin.psrno=2658 and m.ftype=0 group by pin.refstockid)  pin  on(pin.refstockid=pout.stockid)
					     	 left join my_invm m on (m.tr_no=pout.tr_no and m.ftype=0) where
					     	  pout.dtype in ('INV','DEL') and  pout.date  between '2017-01-01' and '2017-04-03'
					     	 and pout.psrno=2658 and m.ftype=0 group by  pout.psrno;*/
					     	
					     	
					     	
					     	 System.out.println("=========+"+sql);
					     	
	 
	 
											ResultSet resultSet1 = stmtVeh.executeQuery(sql);
											RESULTDATA=ClsCommon.convertToJSON(resultSet1);
											stmtVeh.close();
									}
            
									conn.close();
									
					}
					catch(Exception e)
					{
							e.printStackTrace();
							conn.close();
					}
					//System.out.println(RESULTDATA);
					return RESULTDATA;
		}	
	
		

		public   JSONArray reordersearchex(String branch,String fromdate,String todate,String type,String brandid,String catid,
				String subcatid,String psrno,String load,String levelcount) throws SQLException
		{

					JSONArray RESULTDATA=new JSONArray();
        
   
    	
					Connection conn = null;
        
					try
					{
							conn = ClsConnection.getMyConnection();
							Statement stmtVeh = conn.createStatement ();  
							if(load.equalsIgnoreCase("yes"))  
							{
							  java.sql.Date sqlfromdate = null;
						     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
						     	{
						     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
						     		//System.out.println("fffffffffffffffffffffffffffffff"+fromdate);
						     		
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
						     	
						      	String branchsql="";
						     	String branchsqlin="";
						     	String branchsqlout="";
						     	String branchsql1="";
						  		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("NA") && !branch.equalsIgnoreCase("")){
						  			branchsqlin=" and pin.brhid="+branch+" "; 
						  			branchsqlout=" and pout.brhid="+branch+" ";
						  			branchsql=" and brhid="+branch+" "; 
						  			
						  			branchsql1="	and if(ds.brhid=0,"+branch+",ds.brhid)='"+branch+"' ";
								}
						  		
						  	 
									
									String sqlgroup="";
									String namesql="";
									String wheresql="";
		          
									if(type.equalsIgnoreCase("BR"))
									{
											//sqlgroup= "group by ma.brandid ";
										
											wheresql= " and  ma.brandid="+brandid+" ";
			     		 
			     		
									}
									else if(type.equalsIgnoreCase("PR"))
									{
			     		 
											wheresql= " and  ma.doc_no="+psrno+" ";
											/*wheresql= " and  a.psrno="+psrno+" ";*/
									}
			     	
									else if(type.equalsIgnoreCase("CA"))
									{
											//sqlgroup= "group by ca.doc_no";
			     		 
											wheresql= " and  ma.catid="+catid+" ";
			     	 
									}
			     	
									else if(type.equalsIgnoreCase("SC"))
									{
											//sqlgroup= "group by sc.doc_no";
			     		 
											wheresql= " and ma.scatid="+subcatid+" ";
			     		 
									}
									
								//	System.out.println("-----load----"+load);
									
									
									
									
									
										
								  		String sql1="select datediff('"+sqltodate+"','"+sqlfromdate+"')";		     	
								     	ResultSet resultSet = stmtVeh.executeQuery(sql1);
							     //	System.out.println("sssssssssssssssssssssss"+sql1);
							     	int t=0;
							  		
							while(resultSet.next())
									{
									t=resultSet.getInt(1);
//							  	 System.out.println("ttttttttttttttttttttttttt"+t);
							 	}
							String sqltest="";
							String sqltest1="";
					/*		if(!(psrno.equalsIgnoreCase("0")) && !(psrno.equalsIgnoreCase(""))){
								sqltest=sqltest+" and ma.psrno= '"+psrno+"'";
								sqltest1=" and pin.prdid= '"+psrno+"'";
								
							}
			     	*/
									/*		String sql="select ma.doc_no psrno ,if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel) reorderlevel, "
											+ " sum(ds.reorderqty) reorderqty,ma.part_no,ma.productname,bd.brandname brand "
											+ " from  my_main ma   left join  my_brand bd on ma.brandid=bd.doc_no  "
											+" left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no "
											+ " left join my_desc ds on ds.psrno=ma.doc_no where 1=1 "+wheresql+"  group by ma.doc_no ";
 		     */
							String sqlscounts="";
							
						 /*	if(!(levelcount.equalsIgnoreCase("0")) && !(levelcount.equalsIgnoreCase(""))){
								sqlscounts= " and ds.reorderlevel <="+levelcount+" " ;
							 
							}	*/
							if(!(levelcount.equalsIgnoreCase("0")) && !(levelcount.equalsIgnoreCase(""))){
								sqlscounts= " having d.stockquantity<(sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1)+"+Double.parseDouble(levelcount)+") " ;
							 
							}					     	
							else
							{
								
								// sqlscounts= " having d.stockquantity<sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1) ";
							}
							 
							 
							
	/*				     	String sql=" select  if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(a.cou,1),1) reorderlevel, "
					     			+ "  sum(ds.reorderqty)/if(ds.brhid=0,coalesce(a.cou,1),1) reorderqty,b.psrno,b.prdid,productname,part_no,purchasequantity,salequantity,stockquantity, "
					     			+ "  averagesalespermonth,averagepurchasepermonth,brand "
					     			+ " from ( select  bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, ma.productname, ma.part_no, "
					     			+ "   sum(pin.op_qty) purchasequantity,(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty)) salequantity, "
					     			+ "  (select sum(pin.op_qty)-(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))) stockquantity, "
					     			+ "  (select ((sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))/"+t+")*30) averagesalespermonth, "
					     			+ " (select (sum(pin.op_qty)/"+t+")*30) averagepurchasepermonth from my_main ma  "
					     			+ "  left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     			+ "   left join my_dept dep on(dep.doc_no=ma.deptid)     left  join my_catm ca on ma.catid=ca.doc_no "
					     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_prddin pin on pin.prdid=ma.doc_no where ma.status=3  "+wheresql+" "+branchsql+" "
					     	       + "   group by ma.doc_no) b inner join my_desc ds on ds.psrno=b.psrno   "
					     	       + "left join (select   count(*) cou,psrno  from my_desc   where brhid>0 group by psrno) a on a.psrno=ds.psrno  "
					     	       + " where 1=1 "+sqlscounts+"  "+branchsql1+" group by b.psrno " ;
							
							
					     	*/
		/*			     	String sql=" select part_no 'Product Id', productname 'Product Name',   if(ds.brhid=0,'Company','Branch') type,  "
					     			+ "  purchasequantity 'Purchase Qty'  ,salequantity 'Sale Qty' ,stockquantity 'Stock Qty', "
					     			+ "  averagesalespermonth 'Avg Purchase/Month' ,averagepurchasepermonth 'Avg Sales/Month', sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(a.cou,1),1) 'reorder level',   "
					     			+ " sum(ds.reorderqty)/if(ds.brhid=0,coalesce(a.cou,1),1) 'reorder qty' from ( select  bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, ma.productname, ma.part_no, "
					     			+ "   sum(pin.op_qty) purchasequantity,(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty)) salequantity, "
					     			+ "  (select sum(pin.op_qty)-(sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))) stockquantity, "
					     			+ "  (select ((sum(pin.out_qty)+sum(pin.rsv_qty)+sum(pin.del_qty))/"+t+")*30) averagesalespermonth, "
					     			+ " (select (sum(pin.op_qty)/"+t+")*30) averagepurchasepermonth from my_main ma  "
					     			+ "  left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     			+ "   left join my_dept dep on(dep.doc_no=ma.deptid)     left  join my_catm ca on ma.catid=ca.doc_no "
					     			+ "   left  join  my_scatm sc on ma.scatid=sc.doc_no  left join my_prddin pin on pin.prdid=ma.doc_no "+branchsql+" where ma.status=3  "+wheresql+"    "
					     	       + "   group by ma.doc_no) b inner join my_desc ds on ds.psrno=b.psrno  "
					     	       + "  left join (select   count(*) cou,psrno  from my_desc   where brhid>0 group by psrno) a on a.psrno=ds.psrno  " 
					     	       		+ " where 1=1 "+sqlscounts+" "+branchsql1+" group by b.psrno " ;
					     	*/
	/*				     	
					     	String sql=" select b.part_no 'Product Id',b.productname 'Product Name', b.brand  'Brand Name', if(ds.brhid=0,'Company','Branch') type,"
					     			+ " a.purchasequantity 'Purchase Qty',c.salequantity 'Sale Qty',d.stockquantity 'Stock Qty',sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1)  'reorder level', "
					     			+ "  sum(ds.reorderqty)/if(ds.brhid=0,coalesce(k.cou,1),1) 'reorder qty' , "
					     	 + "   ((a.purchasequantity/"+t+")*30) 'Avg Purchase/Month', "
					     	 + "   ((c.salequantity/"+t+")*30) 'Avg Sales/Month' ,ds.brhid srno1 ,coalesce(k.cou,1) srno2    from(select bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, "
					     	 + "    ma.productname, ma.part_no from my_main ma "
					     	+ "   left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     	+ "   left join my_dept dep on(dep.doc_no=ma.deptid) "
					     	+ "   left  join my_catm ca on ma.catid=ca.doc_no "
					        + "  	left  join  my_scatm sc on ma.scatid=sc.doc_no "
					   
					    	+ "  left join my_prddin pin on pin.psrno=ma.psrno "
					        + "  	where   ma.status=3  "+wheresql+" group by ma.doc_no) b "
					     	+ "  left join (select pin.stockid,pin.psrno,coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.qty),0) purchasequantity from my_prddin pin " branchsqlin branchsqlout
					     + "  	left join my_prddout pout on(pin.stockid=pout.stockid and pout.dtype in ('PIR','GRR') and pout.date between'"+sqlfromdate+"' and '"+sqltodate+"' "+branchsqlout+"  ) "
					       + "  	where pin.dtype in ('PIV','OPN','GRN') and pin.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+branchsqlin+"  group by  pin.psrno) a on a.psrno=b.psrno "
					      		+ " left join (select pout.stockid,pout.psrno,coalesce(sum(pout.qty+pout.del_qty),0)-coalesce(pin.op_qty,0) salequantity "
					     		+ " from my_prddout pout  left join (select sum(op_qty) op_qty,refstockid,dtype from my_prddin "
					     		+ " where dtype in ('INR','DLR') and date between '"+sqlfromdate+"' and '"+sqltodate+"'   "+branchsql+"  group by refstockid)  pin  on(pin.refstockid=pout.stockid) "
					     		+ " where    pout.dtype in ('INV','DEL') and  pout.date  between '"+sqlfromdate+"' and '"+sqltodate+"'  "+branchsqlout+"   group by  pout.psrno) c on c.psrno=b.psrno"
					     	+ " left join (select coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.outqty),0) stockquantity,pin.psrno,pin.stockid from  my_prddin pin "
					     	+ " left join (select sum(qty+del_qty) outqty,stockid,psrno from  my_prddout where  date<='"+sqltodate+"' "+branchsql+" group by stockid ) "
					     	+ " pout  on (pout.stockid=pin.stockid ) where pin.date<='"+sqltodate+"' "+branchsqlin+" group by pin.psrno) d on d.psrno=b.psrno "
					     	+ "   inner join my_desc ds on ds.psrno=b.psrno  "
					     	+ "   left join (select   count(*) cou,psrno  from my_desc "
					     	+ "   where brhid>0 group by psrno) k on k.psrno=ds.psrno where 1=1  "+branchsql1+"  group by b.psrno  "+sqlscounts+" " ;
					     	
			 		     	
					     	*/
					     	
					     	String sql=" select b.part_no 'Product Id',b.productname 'Product Name', b.brand  'Brand Name', if(ds.brhid=0,'Company','Branch') type,"
					     			+ " a.purchasequantity 'Purchase Qty',c.salequantity 'Sale Qty',d.stockquantity 'Stock Qty',sum(ds.reorderlevel)/if(ds.brhid=0,coalesce(k.cou,1),1)  'reorder level', "
					     			+ "  sum(ds.reorderqty)/if(ds.brhid=0,coalesce(k.cou,1),1) 'reorder qty' , "
					     	 + "   ((a.purchasequantity/"+t+")*30) 'Avg Purchase/Month', "
					     	 + "   ((c.salequantity/"+t+")*30) 'Avg Sales/Month' ,ds.brhid srno1 ,coalesce(k.cou,1) srno2, sv.stockprice    from(select bd.brandname brand,ma.star,ma.psrno,ma.psrno prdid, "
					     	 + "    ma.productname, ma.part_no from my_main ma "
					     	+ "   left join  my_brand bd on ma.brandid=bd.doc_no   left join my_ptype pt on(ma.typeid=pt.doc_no) "
					     	+ "   left join my_dept dep on(dep.doc_no=ma.deptid) "
					     	+ "   left  join my_catm ca on ma.catid=ca.doc_no "
					        + "  	left  join  my_scatm sc on ma.scatid=sc.doc_no "
					   
								+ "  left join my_prddin pin on pin.psrno=ma.psrno "
									+ "  	where   ma.status=3  "+wheresql+" group by ma.doc_no) b "
									+ "  left join (select pin.stockid,pin.psrno,coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.qty),0) purchasequantity from my_prddin pin " /*branchsqlin branchsqlout*/
									+ "  	left join my_prddout pout on(pin.stockid=pout.stockid and pout.dtype in ('PIR','GRR') and pout.date between'"+sqlfromdate+"' and '"+sqltodate+"' and pout.brhid=1  ) "
									+ "  	where pin.dtype in ('PIV','GRN') and pin.date between '"+sqlfromdate+"' and '"+sqltodate+"' and pin.brhid=1  group by  pin.psrno) a on a.psrno=b.psrno "
									+ " left join (select pout.stockid,pout.psrno,coalesce(sum(pout.qty+pout.del_qty),0)-coalesce(pin.op_qty,0) salequantity "
									+ " from my_prddout pout  left join (select sum(pin.op_qty) op_qty,pin.refstockid,pin.dtype from my_prddin pin   left join my_invr m on (m.tr_no=pin.tr_no and m.ftype=0) "
									+ " where pin.dtype in ('INR','DLR') and pin.date between '"+sqlfromdate+"' and '"+sqltodate+"'   and m.ftype=0      group by pin.refstockid)  pin  on(pin.refstockid=pout.stockid) "
									+ "  left join my_invm m on (m.tr_no=pout.tr_no and m.ftype=0) where    pout.dtype in ('INV','DEL') and m.ftype=0 and  pout.date  between '"+sqlfromdate+"' and '"+sqltodate+"'   group by  pout.psrno) c on c.psrno=b.psrno"
									+ " left join (select coalesce(sum(pin.op_qty),0)-coalesce(sum(pout.outqty),0) stockquantity,pin.psrno,pin.stockid from  my_prddin pin "
									+ " left join (select sum(qty+del_qty) outqty,stockid,psrno from  my_prddout where  date<='"+sqltodate+"'   group by stockid ) "
									+ " pout  on (pout.stockid=pin.stockid ) where pin.date<='"+sqltodate+"'   group by pin.psrno) d on d.psrno=b.psrno "
									+ " left join (select sum(stockprice)/sum(op_qty) stockprice, psrno from(select op_qty*cost_price  stockprice ,"
									+ " op_qty,psrno,stockid  from  my_prddin where date<='"+sqltodate+"' group by stockid) k group by psrno ) sv "
									+ " on sv.psrno=d.psrno  "
					     	+ "   inner join my_desc ds on ds.psrno=b.psrno  "
					     	+ "   left join (select   count(*) cou,psrno  from my_desc "
					     	+ "   where brhid>0 group by psrno) k on k.psrno=ds.psrno where 1=1    group by b.psrno  "+sqlscounts+" " ;
					     	
			 		     	
					     		
					     	
 
	 
					     //	System.out.println("-----sql----"+sql);
											ResultSet resultSet1 = stmtVeh.executeQuery(sql);
											RESULTDATA=ClsCommon.convertToEXCEL(resultSet1);
											stmtVeh.close();
									}
            
									conn.close();
									
					}
					catch(Exception e)
					{
							e.printStackTrace();
							conn.close();
					}
					//System.out.println(RESULTDATA);
					return RESULTDATA;
		}	
	
		
		
		public   JSONArray tobereordersearch(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,String psrno,String load) throws SQLException
		{

					JSONArray RESULTDATA=new JSONArray();
        
   
    	
					Connection conn = null;
        
					try
					{
							conn = ClsConnection.getMyConnection();
							Statement stmtVeh = conn.createStatement ();  
							java.sql.Date sqlfromdate = null;
					/*		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
							{
									sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
							}
							else
							{
		     
							}*/
									String sqlgroup="";
									String namesql="";
									String wheresql="";
		          
									if(type.equalsIgnoreCase("BR"))
									{
											//sqlgroup= "group by ma.brandid ";
										
											wheresql= " and  ma.brandid="+brandid+" ";
			     		 
			     		
									}
									else if(type.equalsIgnoreCase("PR"))
									{
			     		 
											wheresql= " and  ma.doc_no="+psrno+" ";
											/*wheresql= " and  a.psrno="+psrno+" ";*/
									}
			     	
									else if(type.equalsIgnoreCase("CA"))
									{
											//sqlgroup= "group by ca.doc_no";
			     		 
											wheresql= " and  ma.catid="+catid+" ";
			     	 
									}
			     	
									else if(type.equalsIgnoreCase("SC"))
									{
											//sqlgroup= "group by sc.doc_no";
			     		 
											wheresql= " and ma.scatid="+subcatid+" ";
			     		 
									}
									
									//System.out.println("-----load----"+load);
									
									if(load.equalsIgnoreCase("yes"))  
									{
			     	
											String sql="select sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)) stkqty, a.psrno,a.type,a.reorderlevel,a.reorderqty,a.part_no,a.productname,a.brand from "
											+ "(select ma.doc_no psrno ,if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel) reorderlevel, "
											+ " sum(ds.reorderqty) reorderqty,ma.part_no,ma.productname,bd.brandname brand "
											+ " from  my_main ma   left join  my_brand bd on ma.brandid=bd.doc_no  "
											+ " left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no "
											+ " left join my_desc ds on ds.psrno=ma.doc_no where 1=1 "+wheresql+"  group by ma.doc_no) a left join my_prddin pin on pin.psrno=a.psrno group by a.psrno ";
 		     
									
											// 	System.out.println("-----sql----"+sql);
											ResultSet resultSet = stmtVeh.executeQuery(sql);
											RESULTDATA=ClsCommon.convertToJSON(resultSet);
											stmtVeh.close();
									}
            
									conn.close();
									
					}
					catch(Exception e)
					{
							e.printStackTrace();
							conn.close();
					}
					//System.out.println(RESULTDATA);
					return RESULTDATA;
		}	
	
		
		
		
		
		public   JSONArray tobereordersearchex(String branch,String fromdate,String todate,String type,String brandid,String catid,String subcatid,String psrno,String load) throws SQLException
		{

					JSONArray RESULTDATA=new JSONArray();
        
   
    	
					Connection conn = null;
        
					try
					{
							conn = ClsConnection.getMyConnection();
							Statement stmtVeh = conn.createStatement ();  
							java.sql.Date sqlfromdate = null;
					/*		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
							{
									sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
							}
							else
							{
		     
							}*/
									String sqlgroup="";
									String namesql="";
									String wheresql="";
		          
									if(type.equalsIgnoreCase("BR"))
									{
											//sqlgroup= "group by ma.brandid ";
										
											wheresql= " and  ma.brandid="+brandid+" ";
			     		 
			     		
									}
									else if(type.equalsIgnoreCase("PR"))
									{
			     		 
											wheresql= " and  ma.doc_no="+psrno+" ";
											/*wheresql= " and  a.psrno="+psrno+" ";*/
									}
			     	
									else if(type.equalsIgnoreCase("CA"))
									{
											//sqlgroup= "group by ca.doc_no";
			     		 
											wheresql= " and  ma.catid="+catid+" ";
			     	 
									}
			     	
									else if(type.equalsIgnoreCase("SC"))
									{
											//sqlgroup= "group by sc.doc_no";
			     		 
											wheresql= " and ma.scatid="+subcatid+" ";
			     		 
									}
									
									//System.out.println("-----load----"+load);
									
									if(load.equalsIgnoreCase("yes"))  
									{
			     	
											String sql="select a.part_no 'Product Id' ,a.productname  'Product Name',a.brand  'Brand Name' ,a.type, "
													+ "sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)) 'Stock Qty',  a.reorderlevel 'Reorder Level',"
													+ " a.reorderqty 'Reoder Qty'   from "
											+ "(select ma.doc_no psrno ,if(ds.brhid=0,'Company','Branch') type, sum(ds.reorderlevel) reorderlevel, "
											+ " sum(ds.reorderqty) reorderqty,ma.part_no,ma.productname,bd.brandname brand "
											+ " from  my_main ma   left join  my_brand bd on ma.brandid=bd.doc_no  "
											+ " left  join my_catm ca on ma.catid=ca.doc_no left  join  my_scatm sc on ma.scatid=sc.doc_no "
											+ " left join my_desc ds on ds.psrno=ma.doc_no where 1=1 "+wheresql+"  group by ma.doc_no) a left join my_prddin pin on pin.psrno=a.psrno group by a.psrno ";
 		     
											
											
											
										 
									
											// 	System.out.println("-----sql----"+sql);
											ResultSet resultSet = stmtVeh.executeQuery(sql);
											RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
											stmtVeh.close();
									}
            
									conn.close();
									
					}
					catch(Exception e)
					{
							e.printStackTrace();
							conn.close();
					}
					//System.out.println(RESULTDATA);
					return RESULTDATA;
		}	
	
		
		
		
		
		
		
		public   JSONArray reordersubsearch(String subpsrno) throws SQLException
		{

				JSONArray RESULTDATA=new JSONArray();
        
   
    	
				Connection conn = null;
        
				try
				{
							conn = ClsConnection.getMyConnection();
							Statement stmt = conn.createStatement (); 
							
							
							  
		/*				
						 	String sql="select ds.psrno psrno,ds.doc_no,ds.reorderlevel reorderlevels, ds.reorderqty reorderqtys,if(brhid=0,c.company,b.branchname)"
									+ " type  from my_desc ds left join my_comp c on c.doc_no=ds.cmpid left join my_brch b on"
									+ " b.doc_no=ds.brhid where ds.psrno="+subpsrno+";";
 		  
							 
							*/
							
							//System.out.println("=====subpsrno===="+subpsrno);
							
							int brhid=0;
							String sqlss="select brhid from my_desc where psrno='"+subpsrno+"'  ";
							System.out.println("=====sqlss===="+sqlss);
							ResultSet resultSets = stmt.executeQuery(sqlss);
							if(resultSets.next())
							{
								brhid=resultSets.getInt("brhid");
							}
							
							
							if(brhid>0)
							{
							
							String sql="select 'branch' typess, selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
									+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.BRANCHNAME branch,"
									+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
									+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_brch b "
									+ " left join my_desc d "
									+ "on(d.brhid=b.doc_no) where d.psrno='"+subpsrno+"' union all "
									+ "select 0 as selects,b.BRANCHNAME branch,b.doc_no bdocno,0 as discontinued,'' as bin,"
									+ "0 as minstock,0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
									+ " from my_brch b where b.doc_no not in(select brhid from my_desc where psrno='"+subpsrno+"')) as a";
							
				 //	System.out.println("===brach===1=="+sql);
							ResultSet resultSet = stmt.executeQuery(sql);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);
							}
							else if(brhid==0)
							{
						      
								 	String sql="select 'company' typess,selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
											+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.COMPANY branch,"
											+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
											+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_comp b left join my_desc d "
											+ "on(d.cmpid=b.doc_no) where d.psrno='"+subpsrno+"' union all "
											+ "select 0 as selects,b.COMPANY branch,b.doc_no bdocno,0 as discontinued,'' as bin,0 as minstock"
											+ ",0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
											+ " from my_comp b where b.doc_no not in(select cmpid from my_desc where psrno='"+subpsrno+"')) as a";
							
							
							
								 //	System.out.println("===COMPANY===2=="+sql);
							ResultSet resultSet = stmt.executeQuery(sql);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);  
							stmt.close();
							}
            
							conn.close();

				}
				catch(Exception e)
				{
						e.printStackTrace();
						conn.close();
				}
				//System.out.println(RESULTDATA);
				return RESULTDATA;
		}	
	
}
