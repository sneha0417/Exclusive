package com.aviation.aviationinvoice;

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

import com.connection.*;
import com.common.*;
import com.finance.transactions.bankpayment.ClsBankPaymentBean;
import com.procurement.purchase.purchaseorder.ClspurchaseorderBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsaviationInvoiceDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String type,String chk,String aa) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		if(!(aa.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
	     java.sql.Date sqlDate=null;
	     date.trim();
	     String sqltest="";
	     
	     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	     {
	      sqlDate = ClsCommon.changeStringtoSqlDate(date);
	     }
	     
	     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
	     }
	     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
	      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
	     }
	     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
	       sqltest=sqltest+" and c.code like '%"+currency+"%'";
	     }
	  try {
	     conn = ClsConnection.getMyConnection();
	     if(chk.equalsIgnoreCase("1"))
	     {
	    	 Statement stmtCPV = conn.createStatement ();
	    	 String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,(select C_rate from my_curr where code='USD') c_rate, round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.doc_no=a.acno and "
	            + "a.dtype='CRM' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
	            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
	    	 
	    	 ResultSet resultSet = stmtCPV.executeQuery(sql);
	    	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    	 stmtCPV.close();
	     }
	    conn.close();
	  }
	  catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }
	        return RESULTDATA;
	    }
	
	
	
	public JSONArray productSearch(HttpSession session,String name,String code,String brand,String cat,String subcat,String docnos,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		if(!load.equalsIgnoreCase("yes"))
		{
			return RESULTDATA;
		}
		String sqltest="";
		if(!(docnos.equalsIgnoreCase("") )){
			sqltest=sqltest+" and  m.doc_no like '%"+docnos+"%'";
		}
		
		if(!(code.equalsIgnoreCase(""))){
			sqltest=sqltest+" and part_no like '%"+code+"%'";
		}
		if(!(name.equalsIgnoreCase(""))){
			sqltest=sqltest+" and productname like '%"+name+"%'";
		}
 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			
			String sql="select psrno doc_no,m.part_no productcode,m.productname,status  from my_main m  where m.status=3";
		 
			 
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();
			  conn.close();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa,String refnoss,String descriptions) throws SQLException {

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
	      
	      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and aa.refname like '%"+accnamess+"%'";
	      	}
	      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.notes like '%"+descriptions+"%'";
	      	}
	      	if((!(refnoss.equalsIgnoreCase(""))) && (!(refnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and mm.productname like '%"+refnoss+"%'";
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
				
				

				
	        	String pySql=("select m.DOC_NO, m.voc_no, m.date, m.CLIENT_ID,aa.refname,mm.productname,   notes "
	        			+ "  from av_invm m left join my_acbook aa on aa.cldocno=m.client_id "
	        			+ " and aa.dtype='CRM' left join my_main mm on mm.psrno=m.psrno where m.status=3  and m.branch='"+brcid+"' "+sqltest );
	     
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

	public JSONArray maingridreload(String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		 
	 
		try {
			
 
				
			
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			
			String sql="select  dd.row_no ddocno,aa.acno vndid,d.DATE dateoff,d.doc_no fdocno,m1.voc_no docno, d.DNO dono, d.operator,p.port,d.portid, d.FLEET_NO flno, d.ltrqty qpl, "
					+ "d.usgqty qpg, d.unitid, d.taxperrate tax, d.taxperinv itax,"
					+ "  d.sprice, d.pprice,d.amountusd,d.amountaed, d.amountusdp, d.amountaedp from av_invd "
					+ "  d left join av_fuelm  m1 on m1.doc_no=d.doc_no   left join av_fueld dd on m1.doc_no=dd.rdocno  left join my_acbook aa on aa.cldocno=m1.vndid and aa.dtype='VND' left join my_port p on d.portid=p.doc_no where d.rdocno="+docno+" group by d.rowno";
		 
			 //System.out.println("=====sql===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();
			  conn.close();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	
	
	public   JSONArray maingridreload(String cldocno,String fromdate2,String todate2,String psrno) throws SQLException {
		 
	 
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		 
	    Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();  
				
				Statement stmt1 = conn.createStatement ();  
				Statement stmt2 = conn.createStatement ();  
				
				
			     java.sql.Date fromdate=null;
			    
			  
			     if(!(fromdate2.equalsIgnoreCase("undefined"))&&!(fromdate2.equalsIgnoreCase(""))&&!(fromdate2.equalsIgnoreCase("0")))
			     {
			    	 fromdate = ClsCommon.changeStringtoSqlDate(fromdate2);
			     }
			     
			     
			     java.sql.Date todate=null;
		 
			     if(!(todate2.equalsIgnoreCase("undefined"))&&!(todate2.equalsIgnoreCase(""))&&!(todate2.equalsIgnoreCase("0")))
			     {
			    	 todate = ClsCommon.changeStringtoSqlDate(todate2);
			     }
				
				String date="";
 
				int portid=0;
				int vndids=0;
				double c_rate=0;
				double qpg=0;
			   String sqls="select d.unit unitid,d.row_no ddocno,aa.acno vndid,delnoteno,vndid vndids,u.unit,d.qty,d.portid, p.port,m1.doc_no fdocno ,m1.voc_no,d.date,(select C_rate from my_curr where code='USD') c_rate,d.operator,if(u.unit='USG',d.qty*3.7854,d.qty) qpl, "
			   +"  if(u.unit='USG',d.qty,d.qty/3.7854) qpg,fleet_no flno "
			   +"   from av_fuelm  m1 left join av_fueld d on m1.doc_no=d.rdocno left join my_acbook aa on aa.cldocno=m1.vndid and aa.dtype='VND' "
			     +"   left join my_port p on d.portid=p.doc_no left join my_unitm u on d.unit=u.doc_no  "
			     +"   where d.invoiced=0 and m1.cldocno="+cldocno+" and d.psrno="+psrno+" and d.date between '"+fromdate+"' and '"+todate+"'  " ;
			//System.out.println("====sqls==sqls==="+sqls);   
				ResultSet rss=stmt.executeQuery(sqls);
				
				while(rss.next())
				{
					date=rss.getString("date");
					portid=rss.getInt("portid");
					vndids=rss.getInt("vndids");
					obj.put("dateoff", date);
					obj.put("ddocno", rss.getInt("ddocno"));
					obj.put("docno", rss.getString("voc_no"));
					obj.put("fdocno", rss.getString("fdocno"));
					obj.put("dono", rss.getString("delnoteno"));
					obj.put("port", rss.getString("port"));
					obj.put("portid", rss.getString("portid"));
					obj.put("operator",  rss.getString("operator"));
					obj.put("flno",  rss.getString("flno"));
					obj.put("unitid",  rss.getString("unitid"));
					obj.put("qpl",  rss.getString("qpl"));
					obj.put("qpg",  rss.getString("qpg"));
					qpg= rss.getDouble("qpg");
					
					obj.put("vndid",  rss.getInt("vndid"));
					
					c_rate=rss.getDouble("c_rate");
					
					double sprice=0;
					String sqls1="select coalesce(tax,0)+coalesce(price,0) sprice,tax,itax  from Av_fuelpriced where rdocno=(SELECT max(m1.doc_no) FROM  Av_fuelpricem m1  left join Av_fuelpriced  "
							+ " d1 on m1.doc_no=d1.rdocno where dtype='S' and '"+date+"' between validfrm and validupto  and m1.status=3 and cldocno="+cldocno+" and portid="+portid+" and m1.psrno="+psrno+"  ) " ;
					
					//System.out.println("====sqls1==sqls1==="+sqls1);   
					
					ResultSet rss1=stmt1.executeQuery(sqls1);
					if(rss1.first())
					{
						obj.put("tax", rss1.getString("tax"));
						obj.put("itax", rss1.getString("itax"));
						obj.put("sprice", rss1.getString("sprice"));
						
						sprice= rss1.getDouble("sprice");
						
						
					}
					double pprice=0;
					String sqls2="select coalesce(tax,0)+coalesce(price,0) pprice,tax,itax  from Av_fuelpriced where rdocno=(SELECT max(m1.doc_no) FROM  Av_fuelpricem m1  left join Av_fuelpriced  "
							+ " d1 on m1.doc_no=d1.rdocno where dtype='P' and '"+date+"' between validfrm and validupto  and m1.status=3 and cldocno="+vndids+" and portid="+portid+" and m1.psrno="+psrno+"  ) " ;
					
					
					//System.out.println("====sqls2==sqls2==="+sqls2); 
					ResultSet rss2=stmt2.executeQuery(sqls2);
					if(rss2.first())
					{
						 
						obj.put("pprice", rss2.getString("pprice"));
						pprice= rss2.getDouble("pprice");
						
					}
					
					double amountusd=(qpg*(sprice* 0.01));
					double amountaed=(amountusd*c_rate);
					double amountusdp=(qpg*(pprice* 0.01));
					double amountaedp=(amountusdp*c_rate);
					obj.put("amountusd", amountusd);
					obj.put("amountaed", amountaed);
					obj.put("amountusdp", amountusdp);
					obj.put("amountaedp", amountaedp);
					jsonArray.add(obj);
					obj.clear();
					
				}
				 
				stmt.close();
				conn.close();
		} 
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return jsonArray;
	}

	Connection conn;
	
 
	public int insert(Date masterdate, Date fromdate, Date todate,
			Date duedate, int psrno, int puraccid, String formdetailcode,
			String desc1, double usdrate, ArrayList<String> descarray,
			HttpSession session, HttpServletRequest request) throws SQLException {
		try
		{
		int docno;
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtsave= conn.prepareCall("{call av_InvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtsave.registerOutParameter(14, java.sql.Types.INTEGER);
		stmtsave.registerOutParameter(15, java.sql.Types.INTEGER);
		stmtsave.setDate(1,masterdate); 
		stmtsave.setDate(2,fromdate);
		stmtsave.setDate(3,todate);
		stmtsave.setDate(4,duedate);
		stmtsave.setInt(5,psrno);
		stmtsave.setInt(6,puraccid);
		stmtsave.setDouble(7,usdrate); 
		stmtsave.setString(8,desc1); 
		stmtsave.setString(9,session.getAttribute("USERID").toString());
		stmtsave.setString(10,session.getAttribute("BRANCHID").toString());
		stmtsave.setString(11,session.getAttribute("COMPANYID").toString());
		stmtsave.setString(12,formdetailcode);
		stmtsave.setString(13,"A");
		stmtsave.executeQuery();
		docno=stmtsave.getInt("docNo");
		int vocno=stmtsave.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
		
		
		   int m=0;
		
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] detmasterarrays=descarray.get(i).split("::");
		     
		                                                                   
		            String upsqlsql="update  av_fueld set invoiced=1 where row_no='"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"'";                                                
		            stmtsave.executeUpdate(upsqlsql);  
		         
		            if(m==0)
		            {
		            String upsqlsql1="update  av_invm set vndacno="+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"  where doc_no="+docno+" ";                                                
		            
		            
		            stmtsave.executeUpdate(upsqlsql1); 
		            m=1;
		            }
		          
		            
		            if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[0].trim().equalsIgnoreCase("NaN")||detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()))
				     {
				    	  
		                                                                   
		  String insql="INSERT INTO av_invd(sr_no,rDOCNO,DATE,DOC_NO, DNO, operator, portid, fleet_no, ltrqty, usgqty, taxperrate, taxperinv, sprice, pprice, amountusd, amountaed,amountusdp,amountaedp,unitid,refdocno)VALUES"
							       + " ("+(i+1)+","+docno+","
							       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[0].trim()))+"',"
							       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
							       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
							       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
							       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
							       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
							       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
							        + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
							       + "'"+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"',"
							       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
							       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
							       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"', "
							       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"' ,"
							       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"', "
							       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"', "
							       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"' , "
		  							+ "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"' )";
		  
							     int resultSet2 = stmtsave.executeUpdate(insql);
							     if(resultSet2<=0)
									{
										conn.close();
										return 0;
										
									}
							     
							     
				     }
							
							     
							     
							     
							 }
		
		
		
		
		
		int mastertr_no=0;
		
    	
		 Statement stmt1=conn.createStatement();
		 int vndacno=0;
		String sqlss="select trno,vndacno from av_invm where doc_no='"+docno+"' ";
		ResultSet selrs=stmt1.executeQuery(sqlss);
		
		if(selrs.next())
		{
			mastertr_no=selrs.getInt("trno");
			vndacno=selrs.getInt("vndacno");
		}


	 
String descs=desc1; 

String refdetails="INV"+""+vocno;



Statement stmt = conn.createStatement(); 	 

int clientacno=0;
int doc_nosa=1;

String  sqlss11=" select acno ,(select doc_no from my_curr where code='USD') doc_no from (select acno  from my_acbook where dtype='CRM' and cldocno='"+puraccid+"' ) a ";



 
ResultSet rss10=stmt.executeQuery(sqlss11);
if(rss10.first())
{
	clientacno=rss10.getInt("acno");
	doc_nosa=rss10.getInt("doc_no");
}

double amountusd=0;
double amountaed=0;

double amountusdp=0;
double amountaedp=0;

 String sqlsss="select sum(amountusd) amountusd, sum(amountaed) amountaed, sum(amountusdp) amountusdp ,sum(amountaedp) amountaedp  from av_invd where rdocno='"+docno+"' ";

 
 ResultSet rss101=stmt.executeQuery(sqlsss);
 if(rss101.first())
 {
	 amountusd=rss101.getDouble("amountusd");
	 amountaed=rss101.getDouble("amountaed");
	 
	 amountusdp=rss101.getDouble("amountusdp");
	 amountaedp=rss101.getDouble("amountaedp");
	 
	 
 }

 
 

String sql11111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+clientacno+"','"+descs+"','"+doc_nosa+"','"+usdrate+"',"+amountusd+","+amountaed+",0,1,4,0,0,"+puraccid+",'"+usdrate+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

//		System.out.println("--sql1----"+sql1);
	int ss1 = stmt.executeUpdate(sql11111);

	if(ss1<=0)
	{
	conn.close();
	return 0;

	} 

 
 
 
 int salacno=0;

String sql22="select  acno from my_account where codeno='AVSALES' ";

ResultSet tass12 = stmt.executeQuery (sql22);

if (tass12.next()) {

	salacno=tass12.getInt("acno");		

}





 
int curris21=1;
double rates21=1; 


String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+salacno+"'";
ResultSet tass312 = stmt.executeQuery (sqls32);

if (tass312.next()) {

	curris21=tass312.getInt("curid");	
	rates21=tass312.getDouble("rate");	


} 

if(curris21==0){curris21=1;};
if(rates21==0){rates21=1;};
 
 
String sql1111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
	+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+salacno+"','"+descs+"','"+curris21+"','"+rates21+"',"+amountaed*-1+","+(amountaed)*-1+",0,-1,4,0,0,0,'"+rates21+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

int ss = stmt.executeUpdate(sql1111);

if(ss<=0)
{
conn.close();
return 0;

} 



String sql111111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+vndacno+"','"+descs+"','"+doc_nosa+"','"+usdrate+"',"+amountusdp*-1+","+(amountaedp)*-1+",0,-1,4,0,0,0,'"+usdrate+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

	int ss111 = stmt.executeUpdate(sql111111);

	if(ss111<=0)
	{
	conn.close();
	return 0;

	} 









		
int acnos2=0;
int curris2=1;
double rates2=1; 



String sql22111="select  acno from my_account where codeno='COST OF GOODS SOLD' ";

ResultSet tass112 = stmt.executeQuery (sql22111);

if (tass112.next()) {

	acnos2=tass112.getInt("acno");		

}



 String sqls3211="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
ResultSet tass31211 = stmt.executeQuery (sqls3211);

if (tass31211.next()) {

	curris2=tass31211.getInt("curid");	
	rates2=tass31211.getDouble("rate");	


} 

if(curris2==0){curris2=1;};
if(rates2==0){rates2=1;};
 
String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+amountaedp+","+amountaedp+",0,1,4,0,0,0,'"+rates2+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";


// System.out.println("---sql11----"+sql11) ; 

int ss12 = stmt.executeUpdate(sql112);

if(ss12<=0)
{
	conn.close();
	return 0;

}

		
		
		if(docno>0)
		{
			conn.commit();
			conn.close();
			
			return docno;
		}
		
		
		
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			conn.close();	
		}
		
		
		
		return 0;
	}


 
	
	public     ClsaviationInvoiceBean getViewDetails(int doc_no,HttpSession session) throws SQLException {
		
		ClsaviationInvoiceBean showBean = new ClsaviationInvoiceBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		

    	 
		
 		String sqls="select m.fdate,m.tdate,m.ddate,m.urate, m.DOC_NO, m.voc_no, m.date, m.CLIENT_ID,aa.refname,mm.productname,mm.part_no,branch,m.psrno,   notes,h.account "
 					+" from av_invm m left join my_acbook aa on aa.cldocno=m.client_id "
 					+" and aa.dtype='CRM' left join my_head  h on h.doc_no=aa.acno left join my_main mm on mm.psrno=m.psrno where m.status=3 and  m.doc_no='"+doc_no+"'   ";
		
		ResultSet resultSet = stmt.executeQuery(sqls);
 
		if (resultSet.next()) {
		
		 
			showBean.setHidmasterdate(resultSet.getString("date")); 
			showBean.setHidfromdate(resultSet.getString("fdate"));
			showBean.setHidtodate(resultSet.getString("tdate"));
			showBean.setHidduedatee(resultSet.getString("ddate"));
			
			showBean.setUsdrate(resultSet.getDouble("urate"));
			
			showBean.setAccount(resultSet.getInt("account"));
			
			showBean.setPart_no(resultSet.getString("part_no"));
			showBean.setPname(resultSet.getString("productname"));
			showBean.setPsrno(resultSet.getInt("psrno"));
			
			
			showBean.setPuraccid(resultSet.getInt("CLIENT_ID"));
			showBean.setPuraccname(resultSet.getString("refname"));
			showBean.setDesc1(resultSet.getString("notes"));
			
		 
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



	public int update(Date masterdate, Date fromdate, Date todate,
			Date duedate, int psrno, int puraccid, String formdetailcode,
			String desc1, double usdrate, ArrayList<String> descarray,
			HttpSession session, HttpServletRequest request, int masterdoc_no) throws SQLException {
 
	 
			try
			{
				 
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtsave= conn.prepareCall("{call av_InvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtsave.setInt(14,masterdoc_no);
			stmtsave.setInt(15,0);
			stmtsave.setDate(1,masterdate); 
			stmtsave.setDate(2,fromdate);
			stmtsave.setDate(3,todate);
			stmtsave.setDate(4,duedate);
			stmtsave.setInt(5,psrno);
			stmtsave.setInt(6,puraccid);
			stmtsave.setDouble(7,usdrate); 
			stmtsave.setString(8,desc1); 
			stmtsave.setString(9,session.getAttribute("USERID").toString());
			stmtsave.setString(10,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(11,session.getAttribute("COMPANYID").toString());
			stmtsave.setString(12,formdetailcode);
			stmtsave.setString(13,"E");
			int aa=stmtsave.executeUpdate();
			int docno=masterdoc_no;
			
			 
			if(aa<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			int vocno=0;	
			
			int mastertr_no=0;
			
	    	
			 Statement stmt1=conn.createStatement();
			 
			String sqlss="select trno,vndacno,voc_no from av_invm where doc_no='"+docno+"' ";
			ResultSet selrs=stmt1.executeQuery(sqlss);
			
			if(selrs.next())
			{
				mastertr_no=selrs.getInt("trno");
				 
				vocno=selrs.getInt("voc_no");
			}


			  int m=0;
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] detmasterarrays=descarray.get(i).split("::");
			     
			            String upsqlsql="update  av_fueld set invoiced=1 where row_no='"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"'";                                                
			            stmtsave.executeUpdate(upsqlsql);  
			          
			            if(m==0)
			            {
			            	
			            String sqlssss="delete from my_jvtran where tr_no="+mastertr_no+" ";
			            stmtsave.executeUpdate(sqlssss); 
			            
			            String sqlssss1="delete from av_invd where rdocno="+masterdoc_no+" ";
			            
			            stmtsave.executeUpdate(sqlssss1); 
			            String upsqlsql1="update  av_invm set vndacno="+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"  where doc_no="+docno+" ";                                                
			            stmtsave.executeUpdate(upsqlsql1); 
			            m=1;
			            }
			          
			            
			            if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[0].trim().equalsIgnoreCase("NaN")||detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()))
					     {
					    	  
			                                                                   
			  String insql="INSERT INTO av_invd(sr_no,rDOCNO,DATE,DOC_NO, DNO, operator, portid, fleet_no, ltrqty, usgqty, taxperrate, taxperinv, sprice, pprice, amountusd, amountaed,amountusdp,amountaedp,unitid,refdocno)VALUES"
								       + " ("+(i+1)+","+docno+","
								       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[0].trim()))+"',"
								       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
								       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
								       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
								       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
								       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
								       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
								       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
								        + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
								       + "'"+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"',"
								       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
								       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
								       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"', "
								       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"' ,"
								       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"', "
								       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"', "
								       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"' , "
		  							+ "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"' )";

			  
								     int resultSet2 = stmtsave.executeUpdate(insql);
								     if(resultSet2<=0)
										{
											conn.close();
											return 0;
											
										}
								     
								     
					     }
								
								     
								     
								     
								 }
			
			
			 Statement stmt11=conn.createStatement();
			 int vndacno=0;
			String sqlss1="select vndacno from av_invm where doc_no='"+docno+"' ";
			ResultSet selrs1=stmt11.executeQuery(sqlss1);
			
			if(selrs1.next())
			{
				 
				vndacno=selrs1.getInt("vndacno");
				 
			}

			 
		 
	String descs=desc1; 

	String refdetails="INV"+""+vocno;



	Statement stmt = conn.createStatement(); 	 

	int clientacno=0;
	int doc_nosa=1;

	String  sqlss11=" select acno ,(select doc_no from my_curr where code='USD') doc_no from (select acno  from my_acbook where dtype='CRM' and cldocno='"+puraccid+"' ) a ";



	 
	ResultSet rss10=stmt.executeQuery(sqlss11);
	if(rss10.first())
	{
		clientacno=rss10.getInt("acno");
		doc_nosa=rss10.getInt("doc_no");
	}

	double amountusd=0;
	double amountaed=0;

	double amountusdp=0;
	double amountaedp=0;

	 String sqlsss="select sum(amountusd) amountusd, sum(amountaed) amountaed, sum(amountusdp) amountusdp ,sum(amountaedp) amountaedp  from av_invd where rdocno='"+docno+"' ";

	 
	 ResultSet rss101=stmt.executeQuery(sqlsss);
	 if(rss101.first())
	 {
		 amountusd=rss101.getDouble("amountusd");
		 amountaed=rss101.getDouble("amountaed");
		 
		 amountusdp=rss101.getDouble("amountusdp");
		 amountaedp=rss101.getDouble("amountaedp");
		 
		 
	 }

	 
	 

	String sql11111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+clientacno+"','"+descs+"','"+doc_nosa+"','"+usdrate+"',"+amountusd+","+amountaed+",0,1,4,0,0,"+puraccid+",'"+usdrate+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

//			System.out.println("--sql1----"+sql1);
		int ss1 = stmt.executeUpdate(sql11111);

		if(ss1<=0)
		{
		conn.close();
		return 0;

		} 

	 
	 
	 
	 int salacno=0;

	String sql22="select  acno from my_account where codeno='AVSALES' ";

	ResultSet tass12 = stmt.executeQuery (sql22);

	if (tass12.next()) {

		salacno=tass12.getInt("acno");		

	}





	 
	int curris21=1;
	double rates21=1; 


	String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+salacno+"'";
	ResultSet tass312 = stmt.executeQuery (sqls32);

	if (tass312.next()) {

		curris21=tass312.getInt("curid");	
		rates21=tass312.getDouble("rate");	


	} 

	if(curris21==0){curris21=1;};
	if(rates21==0){rates21=1;};
	 
	 
	String sql1111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+salacno+"','"+descs+"','"+curris21+"','"+rates21+"',"+amountaed*-1+","+(amountaed)*-1+",0,-1,4,0,0,0,'"+rates21+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

	int ss = stmt.executeUpdate(sql1111);

	if(ss<=0)
	{
	conn.close();
	return 0;

	} 



	String sql111111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+vndacno+"','"+descs+"','"+doc_nosa+"','"+usdrate+"',"+amountusdp*-1+","+(amountaedp)*-1+",0,-1,4,0,0,0,'"+usdrate+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";

		int ss111 = stmt.executeUpdate(sql111111);

		if(ss111<=0)
		{
		conn.close();
		return 0;

		} 









			
	int acnos2=0;
	int curris2=1;
	double rates2=1; 



	String sql22111="select  acno from my_account where codeno='COST OF GOODS SOLD' ";

	ResultSet tass112 = stmt.executeQuery (sql22111);

	if (tass112.next()) {

		acnos2=tass112.getInt("acno");		

	}



	 String sqls3211="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
	ResultSet tass31211 = stmt.executeQuery (sqls3211);

	if (tass31211.next()) {

		curris2=tass31211.getInt("curid");	
		rates2=tass31211.getDouble("rate");	


	} 

	if(curris2==0){curris2=1;};
	if(rates2==0){rates2=1;};
	 
	String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+amountaedp+","+amountaedp+",0,1,4,0,0,0,'"+rates2+"',0,0,'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',"+mastertr_no+",3)";


	// System.out.println("---sql11----"+sql11) ; 

	int ss12 = stmt.executeUpdate(sql112);

	if(ss12<=0)
	{
		conn.close();
		return 0;

	}

			
			if(docno>0)
			{
				conn.commit();
				conn.close();
				
				return docno;
			}
			
			
			
			}
			
			catch(Exception e)
			{
				e.printStackTrace();
				conn.close();	
				return 0;
			}
			
			
			
			return 0;
		}



	public int delete(int masterdoc_no,HttpSession session,String formdetailcode) throws SQLException {   
 
	 
			try
			{
				
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtsave= conn.prepareCall("{call av_InvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtsave.setInt(14, masterdoc_no);
			stmtsave.setInt(15, 0);
			stmtsave.setDate(1,null); 
			stmtsave.setDate(2,null);
			stmtsave.setDate(3,null);
			stmtsave.setDate(4,null);
			stmtsave.setInt(5,0);
			stmtsave.setInt(6,0);
			stmtsave.setDouble(7,0); 
			stmtsave.setString(8,null); 
			stmtsave.setString(9,session.getAttribute("USERID").toString());
			stmtsave.setString(10,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(11,session.getAttribute("COMPANYID").toString());
			stmtsave.setString(12,formdetailcode);
			stmtsave.setString(13,"D");
			
			int aa=stmtsave.executeUpdate();
			int docno=masterdoc_no;
			
			 
			if(aa<=0)
			{
				conn.close();
				return 0;
				
			}
			
			if(docno>0)
			{
				
				 
				
				conn.commit();
				conn.close();
				
				return docno;
			}
}
catch(Exception e)
    {
	 conn.close();
	 return 0;
	
     }
			return 0;		
			
	}
}


