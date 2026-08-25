package com.dashboard.procurment.stockageing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsStockageingDAO {           
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsConnection ClsConnection=new ClsConnection();
	
	public JSONArray stockageinggrid(String branch,String uptodate,String level1from, String level1to, String level2from, String level2to,
			String level3from,String check,String level3to,String level4from,String level4to,String level5from,String hidbrandid,String hidtypeid,String hideptid,String hidcatid,String hidsubcatid,String hidproductid) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
      
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtstock = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				 }
				 String sqlss=""; 
				String sql = "";
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
					sqlss=sqlss+" and m.doc_no in ("+hidproductid+")";
				}
			 
				if(!(hideptid.equalsIgnoreCase("0") || hideptid.equalsIgnoreCase("") || hideptid.equalsIgnoreCase("undefined"))){
					sqlss=sqlss+" and dep.doc_no in ("+hideptid+")";
				}


				if(check.equalsIgnoreCase("1")){
/*				sql = "  select d.prdid,bd.brand,d.qty,m.part_no productid,m.productname,"
					+ "  convert(if(l1qty=0,'',l1qty),char(50)) level_1qty,convert(if(l1amount=0,'',l1amount),char(50))  level_1amount  , "
					+ "  convert(if(l2qty=0,'',l2qty),char(50)) level_2qty, "
					+ "  convert(if(l2amount=0,'',l2amount),char(50))  level_2amount ,convert(if(l3qty=0,'',l3qty),char(50)) "
					+ "  level_3qty, convert(if(l3amount=0,'',l3amount),char(50))   level_3amount,convert(if(l4qty=0,'',l4qty),char(50)) level_4qty,convert(if(l4amount=0,'',l4amount),char(50))   level_4amount"
					+ "  ,convert(if(l5qty=0,'',l5qty),char(50)) level_5qty,convert(if(l5amount=0,'',l5amount),char(50))   level_5amount from \r\n "
					
					+ "   (select  c.brhid,sum(c.qty) qty,c.prdid,sum(c.l1amount) l1amount,sum(c.l2amount) l2amount,"
					+ " sum(c.l3amount) l3amount,sum(c.l4amount) l4amount,sum(c.l5amount) l5amount  \r\n"
					+ "   ,sum(c.l1qty) l1qty,sum(c.l2qty) l2qty,sum(c.l3qty) l3qty,sum(c.l4qty) l4qty,sum(c.l5qty) l5qty from \r\n"
					
					+ "   (select  b.brhid,b.qty ,b.prdid,amount ,duedys,if(duedys between "+level1from+" and "+level1to+" and amount>0,round((amount),2),0) l1amount, \r\n"
					+ "   if(duedys between  "+level2from+" and "+level2to+" and amount>0,round((amount),2),0) l2amount, \r\n"
					+ "   if(duedys between  "+level3from+" and "+level3to+" and amount>0,round((amount),2),0) l3amount, \r\n"
						+ "   if(duedys between  "+level4from+" and "+level4to+" and amount>0,round((amount),2),0) l4amount, \r\n"
					+ "   if(duedys >="+level5from+" and amount>0,round((amount),2),0) l5amount, \r\n"
					
					+ "   if(duedys between "+level1from+" and "+level1to+" and qty>0,round((qty),2),0) l1qty, \r\n"
					+ "   if(duedys between  "+level2from+" and "+level2to+" and qty>0,round((qty),2),0) l2qty, \r\n"
						+ "   if(duedys between  "+level3from+" and "+level3to+" and qty>0,round((qty),2),0) l3qty, \r\n"
							+ "   if(duedys between  "+level4from+" and "+level4to+" and qty>0,round((qty),2),0) l4qty, \r\n"
					+ "   if(duedys >="+level5from+" and qty>0,round((qty),2),0) l5qty from ( \r\n"
					+ "   select i.date,TIMESTAMPDIFF(Day,cast(i.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys, \r\n"
					+ "   i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid \r\n" 
					+ "   ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i \r\n"
					+ "   left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a \r\n"
					+ "   on a.stockid=i.stockid \r\n"
					+ "   where 1=1 group by i.stockid) b) c group by c.prdid ) d \r\n"
					+ "   left join my_main m on m.doc_no=d.prdId  left join my_desc de on(de.psrno=m.doc_no and d.brhid= de.brhid) \r\n"
					+ "   left join  my_brand bd on m.brandid=bd.doc_no left  join my_catm ca on m.catid=ca.doc_no  "
					+ "   left  join  my_scatm sc on m.scatid=sc.doc_no  left join my_unitm u on m.munit=u.doc_no "
					+ "  left join my_ptype pt on(m.typeid=pt.doc_no) left join my_dept dep on(dep.doc_no=m.deptid)   where d.qty>0 and m.status=3 "+sqlss+" ";
				*/
				
				
				
				
				
				
				sql = "  select d.prdid,bd.brand,d.qty,m.part_no productid,m.productname,"
						+ "  convert(if(l1qty=0,'',l1qty),char(50)) level_1qty,convert(if(l1amount=0,'',l1amount),char(50))  level_1amount  , "
						+ "  convert(if(l2qty=0,'',l2qty),char(50)) level_2qty, "
						+ "  convert(if(l2amount=0,'',l2amount),char(50))  level_2amount ,convert(if(l3qty=0,'',l3qty),char(50)) "
						+ "  level_3qty, convert(if(l3amount=0,'',l3amount),char(50))   level_3amount,convert(if(l4qty=0,'',l4qty),char(50)) level_4qty,convert(if(l4amount=0,'',l4amount),char(50))   level_4amount"
						+ "  ,convert(if(l5qty=0,'',l5qty),char(50)) level_5qty,convert(if(l5amount=0,'',l5amount),char(50))   level_5amount from \r\n "
						+ "   (select  c.brhid,sum(c.qty) qty,c.prdid,sum(c.l1amount) l1amount,sum(c.l2amount) l2amount,"
						+ " sum(c.l3amount) l3amount,sum(c.l4amount) l4amount,sum(c.l5amount) l5amount  \r\n"
						+ "   ,sum(c.l1qty) l1qty,sum(c.l2qty) l2qty,sum(c.l3qty) l3qty,sum(c.l4qty) l4qty,sum(c.l5qty) l5qty from \r\n"
						+ "   (select  b.brhid,b.qty ,b.prdid,amount ,duedys,if(duedys between "+level1from+" and "+level1to+"  ,round((amount),2),0) l1amount, \r\n"
						+ "   if(duedys between  "+level2from+" and "+level2to+"  ,round((amount),2),0) l2amount, \r\n"
						+ "   if(duedys between  "+level3from+" and "+level3to+"  ,round((amount),2),0) l3amount, \r\n"
							+ "   if(duedys between  "+level4from+" and "+level4to+" ,round((amount),2),0) l4amount, \r\n"
						+ "   if(duedys >="+level5from+" ,round((amount),2),0) l5amount, \r\n"
						+ "   if(duedys between "+level1from+" and "+level1to+"  ,round((qty),2),0) l1qty, \r\n"
						+ "   if(duedys between  "+level2from+" and "+level2to+"  ,round((qty),2),0) l2qty, \r\n"
							+ "   if(duedys between  "+level3from+" and "+level3to+"    ,round((qty),2),0) l3qty, \r\n"
								+ "   if(duedys between  "+level4from+" and "+level4to+"    ,round((qty),2),0) l4qty, \r\n"
						+ "   if(duedys >="+level5from+"    ,round((qty),2),0) l5qty from (select date,duedys,brhid,sum(qty) qty,prdid,sum(amount) amount from (select i.date,TIMESTAMPDIFF(Day,cast(i.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys, "
								+ " i.brhid,i.op_qty  qty,i.prdid,i.cost_price*(i.op_qty) amount from my_prddin  i where i.date<= '"+sqlUpToDate+"' "
								+ "  union all select date,0 duedys,brhid, qty*-1 outqty,prdid,(qty*cost_price)*-1 amount from  my_prddout   where date<= '"+sqlUpToDate+"')  a group by prdid) b) "
								+ "  c group by c.prdid ) d \r\n"
						+ "   left join my_main m on m.doc_no=d.prdId  left join my_desc de on(de.psrno=m.doc_no and d.brhid= de.brhid) \r\n"
						+ "   left join  my_brand bd on m.brandid=bd.doc_no left  join my_catm ca on m.catid=ca.doc_no  "
						+ "   left  join  my_scatm sc on m.scatid=sc.doc_no  left join my_unitm u on m.munit=u.doc_no "
						+ "  left join my_ptype pt on(m.typeid=pt.doc_no) left join my_dept dep on(dep.doc_no=m.deptid)   where d.qty!=0 and m.status=3 "+sqlss+" ";
					
			// System.out.println("===== "+sql);
				ResultSet resultSet = stmtstock.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				
				}
				
				stmtstock.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
}
