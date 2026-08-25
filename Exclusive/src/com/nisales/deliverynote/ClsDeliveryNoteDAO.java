package com.nisales.deliverynote;

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
 
 

public class ClsDeliveryNoteDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
 
	public   JSONArray searchProduct(HttpSession session,String id,String reftype,String reftypedocno) throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	 
 
	 	 if(!(id.equalsIgnoreCase("search")))
	 			 {
	 		 return  RESULTDATA;
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
				Statement sst = conn.createStatement (); 
	     	 
			 
				
				if(reftype.equalsIgnoreCase("COR"))
				{
					String pySql=(" select d.rdocno,d.rowno,m.doc_no,bd.brandname,  bb.code bevcodename,pp.code polcodename,d.floor, d.flat flatids, d.Width, d.height, d.qty-d.out_qty quantity,  d.sqm, d.totsize, d.price, "
		        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
		        			+ " specid ,m.part_no part_no,coalesce(d.productname,m.productname) productname,m.part_no proid ,"
		        			+ " coalesce(d.productname,m.productname) proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty-d.out_qty qtyval from my_cord d"
		        			+ " left join my_main m on m.doc_no=d.prdId  left join  my_brand bd on m.brandid=bd.doc_no    left join my_unitm u on d.unitid=u.doc_no "
		        			+ " left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
		        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+reftypedocno+"'  and (d.qty-d.out_qty)>0  ");
					
					
					
					ResultSet resultSet = sst.executeQuery (pySql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						sst.close();
				}
				else
				{
					String sqlss="select   bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;
				 	 
					ResultSet resultSet = sst.executeQuery (sqlss);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						sst.close();
					
					
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
	public   JSONArray searchcode(String name) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement aa = conn.createStatement ();
				 if(name.equalsIgnoreCase("1"))
				 {
					 
					 

		        	    String pySql=(" select doc_no,code from my_corcode where   status=3  and dtype='BLC'  "); 
		 
			        	//System.out.println("=====pySql========"+pySql);
			        	
						ResultSet resultSet = aa.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						aa.close();
						
					 
					 
				 }
				 else if(name.equalsIgnoreCase("2"))
				 {
					  String pySql=(" select doc_no,code from my_corcode where   status=3  and dtype='PLC'  "); 
						 
			        	//System.out.println("=====pySql========"+pySql);
			        	
						ResultSet resultSet = aa.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						aa.close();
				 }
				
				 conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}	
	
	public   JSONArray refreload(String docno,String reftype) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement aaa = conn.createStatement ();
				 
				
	        	String pySql=(" select d.refrow refrow,bb.code bevcodename,pp.code polcodename,d.floor, d.flat flatids, d.Width, d.height, d.qty quantity,  d.sqm, d.totsize, d.price, "
	        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
	        			+ " specid ,m.part_no productid,coalesce(d.productname,m.productname) productname,m.part_no proid ,"
	        			+ " coalesce (d.productname,m.productname) proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,((c.qty-c.out_qty)+d.qty) qtyval from my_dlym mm  left join  my_dlyd d on d.rdocno=mm.doc_no"
	        			+ " left join  my_cord  c on c.rowno=d.refrow "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
	        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where d.rdocno='"+docno+"' ");
				 
	        	 
	        	
				ResultSet resultSet = aaa.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				aaa.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
	public   JSONArray refreload(String masterrefno) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement aaa = conn.createStatement ();
				// bevcodename  polcodename refrowno 
				
	        	String pySql=(" select d.rowno refrow,bb.code bevcodename,pp.code polcodename,d.floor, d.flat flatids, d.Width, d.height, d.qty-d.out_qty quantity,  d.sqm, d.totsize, d.price, "
	        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
	        			+ " specid ,m.part_no productid,coalesce(d.productname,m.productname) productname,m.part_no proid ,"
	        			+ " coalesce(d.productname,m.productname)  proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty-out_qty qtyval from my_cord d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
	        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where d.rdocno='"+masterrefno+"' and (d.qty-d.out_qty)>0  ");
				 
				ResultSet resultSet = aaa.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				aaa.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray searchsalesman() throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select sal_name,doc_no from my_salm where status=3   ");
	        	 
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
	
	
public JSONArray clientAccountsDetails(HttpSession session,String dtype,String atype,String accountno,String accountname,String mobile,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
        
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
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
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
	           }

	            String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        
  
		        if(atype.equalsIgnoreCase("GL")){
	        	
			        sql="select 0 msg,t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
		        
		        }else{
		        
			 /*       sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
		        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
		        		+ "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
		        
		      */
			        sql= "select if(coalesce(jv.balance,0)>coalesce(aa.credit,0),1,0) msg,  jv.balance,aa.credit, t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
			        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
			        		+ "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid)"
			        				+ " left join ("+
						" select sum(j.dramount) balance,j.acno from my_jvtran j    where"+
						" j.status=3   group by j.acno) jv on jv.acno=t.doc_no left join my_acbook aa on aa.acno=t.doc_no  where a.active=1 and t.m_s=0"+sqltest;
			        
		        
		        
		        
		        }
	 
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			  conn.close();
			}
	       return RESULTDATA;
	  }



public int insert(ArrayList<String> descarray, Date masterdate, Date deldate,
		String deliveryTime, Date fixdate, int itemtype, int costtr_no,
		int salid, int acno, String lpono, String remarks, HttpSession session,
		HttpServletRequest request, String formdetailcode, String mode,int currsid, double ratess, int refdocno, String reftype) throws SQLException {
	   Connection conn = null; 
	
	   int docno;
  	try{
		
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtsave= conn.prepareCall("{call tr_DelNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtsave.registerOutParameter(1, java.sql.Types.INTEGER);
		stmtsave.registerOutParameter(2, java.sql.Types.INTEGER);

		stmtsave.setDate(3,masterdate); 
		stmtsave.setDate(4,deldate);
		stmtsave.setDate(5,fixdate);
		
		stmtsave.setString(6,deliveryTime);
		
		stmtsave.setInt(7,itemtype);
		stmtsave.setInt(8,costtr_no);
		stmtsave.setInt(9,salid);
		stmtsave.setInt(10,acno);
		stmtsave.setString(11,lpono);
		
		stmtsave.setString(12,remarks);
 
		
		stmtsave.setString(13,formdetailcode);
		
		stmtsave.setString(14,session.getAttribute("USERID").toString());
		stmtsave.setString(15,session.getAttribute("BRANCHID").toString());
		stmtsave.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtsave.setString(17,mode);
		stmtsave.setInt(18,currsid);
		stmtsave.setDouble(19,ratess);
		
		stmtsave.setInt(20,refdocno);
		stmtsave.setString(21,reftype);
		
		

		stmtsave.executeQuery();
		docno=stmtsave.getInt("docNo");
 
		int vocno=stmtsave.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
	 
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] detmasterarrays=descarray.get(i).split("::");
			     if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[0].trim().equalsIgnoreCase("NaN")||detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()))
			     {
			    	 
			    	 
			    	 
		     String sql="INSERT INTO my_dlyd(sr_no,psrno,prdId,unitid,SpecNo,floor,flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount,refrow,productname,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
				       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"'," 
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
				       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
				       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"',"
				       + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"',"
				       + "'"+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"',"
				       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
				       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
				       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
				       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
				      + "'"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")|| detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"',"
				       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtsave.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				  				     
				 
			     }	    
			     
				     
				     }
			
			
			
			if(reftype.equalsIgnoreCase("COR"))
			{
				String sql="update  my_dlyd d left join my_cord dd on dd.rowno=d.refrow	 set  dd.out_qty=(dd.out_qty+d.qty)  where d.rdocno='"+docno+"' ";
				int aa=stmtsave.executeUpdate(sql);
				
				if(aa<=0)
				{
					conn.close();
				return 0;
					
				}
				 
			}
			

 
		if(docno>0)
		{
			conn.commit();
			return docno;
		}
		
	
	
	
  	}
  	
  	catch(Exception e)
  	{
  		e.printStackTrace();
  		docno=0;
  	}
  	finally
  	{
  		conn.close();
  	}
    
  	return 0;
}



public int update(ArrayList<String> descarray, Date masterdate, Date deldate,
		String deliveryTime, Date fixdate, int itemtype, int costtr_no,
		int salid, int acno, String lpono, String remarks, HttpSession session,
		HttpServletRequest request, String formdetailcode, String mode,
		int currsid, double ratess,int docno, int refdocno, String reftype) throws SQLException {
	   Connection conn = null; 
		
	   
	try{
		
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtsave= conn.prepareCall("{call tr_DelNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtsave.setInt(1, docno);
		stmtsave.setInt(2, 0);

		stmtsave.setDate(3,masterdate); 
		stmtsave.setDate(4,deldate);
		stmtsave.setDate(5,fixdate);
		
		stmtsave.setString(6,deliveryTime);
		
		stmtsave.setInt(7,itemtype);
		stmtsave.setInt(8,costtr_no);
		stmtsave.setInt(9,salid);
		stmtsave.setInt(10,acno);
		stmtsave.setString(11,lpono);
		
		stmtsave.setString(12,remarks);
 
		
		stmtsave.setString(13,formdetailcode);
		
		stmtsave.setString(14,session.getAttribute("USERID").toString());
		stmtsave.setString(15,session.getAttribute("BRANCHID").toString());
		stmtsave.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtsave.setString(17,mode);
		stmtsave.setInt(18,currsid);
		stmtsave.setDouble(19,ratess);
		stmtsave.setInt(20,refdocno);
		stmtsave.setString(21,reftype);
		
		

		int aa=stmtsave.executeUpdate();
		docno=stmtsave.getInt("docNo");

		int vocno=stmtsave.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(aa<=0)
		{
			conn.close();
			return 0;
			
		}
		
	 
		
		
		if(reftype.equalsIgnoreCase("COR"))
		{
			String sql1="update  my_dlyd d left join my_cord dd on dd.rowno=d.refrow	 set  dd.out_qty=(dd.out_qty-d.qty)  where d.rdocno='"+docno+"' ";
			
			 
			
			int bb=stmtsave.executeUpdate(sql1);
			if(bb<=0)
			{
				conn.close();
			return 0;
				
			}
			 
		}
		
		
	 
			
			for(int i=0;i< descarray.size();i++){
		    	
				if(i==0)
				{
					String sq1l="delete from my_dlyd where rdocno="+docno+" ";
					stmtsave.executeUpdate(sq1l);
				}
				
				
			     String[] detmasterarrays=descarray.get(i).split("::");
			     if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[0].trim().equalsIgnoreCase("NaN")||detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()))
			     {
			    	 
			    	 
			    	// TR_NO, rdocno, ROWNO, SR_NO, psrno, prdId, UNITID,  SpecNo, floor, flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount 
	 
		     String sql="INSERT INTO my_dlyd(sr_no,psrno,prdId,unitid,SpecNo,floor,flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount,refrow,productname,tr_no,rdocno)VALUES"
				       + " ("+(i+1)+","
				     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
				       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"'," 
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
				       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
				       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"',"
				       + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"',"
				       + "'"+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"',"
				       + "'"+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"',"
				       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
				       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
				       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
				       + "'"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")|| detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"',"
				       +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtsave.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
		 if(reftype.equalsIgnoreCase("COR"))
			{
			  
				
				 
				String sql2="update  my_dlyd d left join my_cord dd on dd.rowno=d.refrow	 set  dd.out_qty=(dd.out_qty+d.qty)  where d.rdocno='"+docno+"' ";
				 
				int cc= stmtsave.executeUpdate(sql2);
				 
				 if(cc<=0)
					{
						conn.close();
					return 0;
						
					}
				 
				 
			} 
			

		if(docno>0)
		{
			conn.commit();
			return docno;
		}
		
	
	
	
	}
	
	catch(Exception e)
	{
		e.printStackTrace();
		docno=0;
	}
	finally
	{
		conn.close();
	}
 
	return 0;
}



public int delete(ArrayList<String> descarray, Date masterdate, Date deldate,
		String deliveryTime, Date fixdate, int itemtype, int costtr_no,
		int salid, int acno, String lpono, String remarks, HttpSession session,
		HttpServletRequest request, String formdetailcode, String mode,
		int currsid, double ratess, int docno) throws SQLException {
	Connection conn = null; 
	
	   
	try{
		
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtsave= conn.prepareCall("{call tr_DelNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtsave.setInt(1, docno);
		stmtsave.setInt(2, 0);

		stmtsave.setDate(3,masterdate); 
		stmtsave.setDate(4,deldate);
		stmtsave.setDate(5,fixdate);
		
		stmtsave.setString(6,deliveryTime);
		
		stmtsave.setInt(7,itemtype);
		stmtsave.setInt(8,costtr_no);
		stmtsave.setInt(9,salid);
		stmtsave.setInt(10,acno);
		stmtsave.setString(11,lpono);
		
		stmtsave.setString(12,remarks);
 
		
		stmtsave.setString(13,formdetailcode);
		
		stmtsave.setString(14,session.getAttribute("USERID").toString());
		stmtsave.setString(15,session.getAttribute("BRANCHID").toString());
		stmtsave.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtsave.setString(17,mode);
		stmtsave.setInt(18,currsid);
		stmtsave.setDouble(19,ratess);
		
		stmtsave.setInt(20,0);
		stmtsave.setString(21,"0");
		

		int aa=stmtsave.executeUpdate();
		docno=stmtsave.getInt("docNo");

		int vocno=stmtsave.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(aa<=0)
		{
			conn.close();
			return 0;
			
		}
		
	 
		 
			


		if(docno>0)
		{
			conn.commit();
			return docno;
		}
		
	
	
	
	}
	
	catch(Exception e)
	{
		e.printStackTrace();
		docno=0;
	}
	finally
	{
		conn.close();
	}
 
	return 0;
}


public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa,String descriptions,String costdocno,String slpono) throws SQLException {

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
  	   	if((!(slpono.equalsIgnoreCase(""))) && (!(slpono.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.lpono like '%"+slpono+"%'";
      	}
  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
      	}
      	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
      	}
      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
      	}
      
      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.remarks like '%"+descriptions+"%'";
      	}
      	 String sqlsss2="";
     	if((!(costdocno.equalsIgnoreCase(""))) && (!(costdocno.equalsIgnoreCase("NA")))){
     		sqlsss2=" and a.costcode like '%"+costdocno+"%'";
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
			
 
        	
        	 String pySql=(" select * from (select h.atype,r.code,m.curid,m.rate,m.lpono,sa.sal_name,m.sal_id,m.deldate,m.deltime,m.fixdate,m.costcode costtr_no, "
        	 		+ " m.costtype,case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcode' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,mm.amount,m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.remarks desc1 from my_dlym m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join   (select sum(amount) amount,rdocno from my_dlyd group by rdocno) mm on mm.rdocno=m.doc_no "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId"
        			+ "   where m.status<>7 "
        			+ "  and m.brhid='"+brcid+"' "+sqltest+" ) a where 1=1  "+sqlsss2+" ");
        	
        	
    
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

public   JSONArray cormainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa,String descriptions,String costdocno) throws SQLException {

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
      	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
      	}
      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
      	}
      
      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.remarks like '%"+descriptions+"%'";
      	}
      	 String sqlsss2="";
     	if((!(costdocno.equalsIgnoreCase(""))) && (!(costdocno.equalsIgnoreCase("NA")))){
     		sqlsss2=" and a.costcode like '%"+costdocno+"%'";
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
			
 
        	
        	 String pySql=(" select * from (select h.atype,r.code,m.curid,m.rate,m.lpono,sa.sal_name,m.sal_id,m.deldate,m.deltime,m.fixdate,m.costcode costtr_no, "
        	 		+ " m.costtype,case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcode' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.remarks desc1 from my_corm m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId"
        			+ "  left join my_cord dd on dd.rdocno=m.doc_no   where m.status<>7 "
        			+ "  and m.brhid='"+brcid+"' "+sqltest+" and (dd.qty-dd.out_qty)>0  group by m.doc_no) a where 1=1  "+sqlsss2+" ");
        	
        	
   
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


public  ClsDeliveryNoteBean getviewDetails(HttpSession session, int docno) throws SQLException {
	ClsDeliveryNoteBean Bean=new ClsDeliveryNoteBean();
	Connection conn=null;
	try
	{
		conn = ClsConnection.getMyConnection();
		Statement st=conn.createStatement();  
		     
	String sql="select m.rdtype,m.rrefno,cc.voc_no rrvocno,h.atype,r.code,m.curid,m.rate,m.lpono,sa.sal_name,m.sal_id,m.deldate,m.deltime,m.fixdate,m.costcode, m.costtype,case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcodeno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.remarks desc1 from my_dlym m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId "
        			+ "left join my_corm cc on  cc.doc_no=m.rrefno where m.voc_no="+docno+" and m.brhid="+session.getAttribute("BRANCHID").toString()+" " ;
	
	
	 
 
			ResultSet rd=st.executeQuery(sql);
			
			if(rd.first())
			{
				Bean.setMasterdoc_no(rd.getInt("doc_no"));
				
				Bean.setHiddate(rd.getString("date"));
				Bean.setHiddeliveryDate(rd.getString("deldate"));
				Bean.setHiddeliveryTime(rd.getString("deltime"));
				Bean.setHidfixDate(rd.getString("fixdate"));
				
				Bean.setMasterrrefno(rd.getInt("rrefno"));
				Bean.setRrefno(rd.getInt("rrvocno"));
				Bean.setRreftypeval(rd.getString("rdtype"));
				
				
				Bean.setHideitemtype(rd.getInt("costtype"));
				Bean.setItemdocno(rd.getInt("costcodeno"));
				Bean.setItemname(rd.getString("prjname"));
				Bean.setCosttr_no(rd.getInt("costcode"));
				
				
				Bean.setSalid(rd.getInt("sal_id"));
				Bean.setSalesmanname(rd.getString("sal_name"));
				
				Bean.setLpono(rd.getString("lpono"));
				
				
				Bean.setAccid(rd.getInt("account"));
				Bean.setAcno(rd.getInt("acno"));
				Bean.setAccname(rd.getString("description"));
				Bean.setAcctype(rd.getString("atype"));
				
				Bean.setCurrs(rd.getString("code"));
				Bean.setCurrsid(rd.getInt("curid"));
				Bean.setRatess(rd.getDouble("rate"));
				
				Bean.setRemarks(rd.getString("desc1"));
				
				
				
				
			}
			
	
	
	}
	catch(Exception e)
	{
	e.printStackTrace();	
	}
	finally
	{
		conn.close();
	}
	
	 
	return Bean;
}

public     ClsDeliveryNoteBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsDeliveryNoteBean bean = new ClsDeliveryNoteBean();
	  Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			 
			 
			Statement stmtprint = conn.createStatement ();
       	
			String resql=("	select coalesce(ac.tinno,'') trnnumber,cc.voc_no rrvocno,coalesce(ac.address,'') address,coalesce(coalesce(ac.per_mob,com_mob),'') mobno,coalesce(ac.fax1,'') fax1 "
					+ " ,h.atype,r.code,m.curid,m.rate,m.lpono,"
					+ " sa.sal_name,m.sal_id,DATE_FORMAT(m.deldate,'%d.%m.%Y') AS deldate ,m.deltime,"
					+ " DATE_FORMAT(m.fixdate,'%d.%m.%Y') AS fixdate,m.costcode, m.costtype,"
					+ " case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcodeno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,m.doc_no,m.voc_no, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description,h.account,m.acno,m.remarks desc1 from my_dlym m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_acbook ac on ac.acno=h.doc_no left join my_corm cc on  cc.doc_no=m.rrefno  "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId   where   m.doc_no='"+docno+"'");
			
			
			 
			
			ResultSet pintrs = stmtprint.executeQuery(resql);
			
	 
		       while(pintrs.next()){
		    	   bean.setLbldocNO(pintrs.getString("voc_no"));
		    	
		    	    bean.setLblOrderNO(pintrs.getString("rrvocno"));
		    	    bean.setLblDate(pintrs.getString("date"));
		    	    bean.setLblDeliveryDate(pintrs.getString("deldate"));
		    	    bean.setLblFixingDate(pintrs.getString("fixdate"));
		    	    bean.setLblBuye(pintrs.getString("description"));
		    	    bean.setLbladdresscl(pintrs.getString("address"));
		    	    bean.setLblTel(pintrs.getString("mobno"));
		    	    bean.setLblFax(pintrs.getString("fax1"));
		    	    bean.setLblRemarks(pintrs.getString("desc1"));  
		    	    bean.setLblProject(pintrs.getString("costgroup")+" - "+pintrs.getString("costcode")+" - "+pintrs.getString("prjname"));
		    	    bean.setLblPoNo(pintrs.getString("lpono")); 
		    	    bean.setLblSalseman(pintrs.getString("sal_name")); 
		    	    bean.setLblcltrno(pintrs.getString("trnnumber"));
		     
		    	    
		    	  
		       }
			

			stmtprint.close();
			
 
			
			
			 Statement stmt10 = conn.createStatement ();
			    String  companysql="select  b.tinno,b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_dlym r  "
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
			    	  
			       	   bean.setLbltrnno(resultsetcompany.getString("tinno"));
			    	   
			       } 
			     stmt10.close();
			     
		 
			       
			     ArrayList<String> arr =new ArrayList<String>();
			   	 Statement stmtgrid = conn.createStatement ();       
			     String temp="";  
			 	String pySql=(" select bb.code bevcodename,pp.code polcodename,d.floor, d.flat, concat(round(d.Width),' x ',round(d.height)) wh, round(d.qty,2) qty ,  d.sqm, d.totsize, d.price, "
	        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
	        			+ " specid ,m.part_no productid,m.productname,m.part_no proid ,"
	        			+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty from my_dlyd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
	        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+docno+"' ");
				 
				String jasperdly="select  @i:=@i+1 as srno,a.* from(select coalesce(d.productname,m.productname) productname,d.temp,concat(round(d.Width),' x ',round(d.height)) wh, round(d.qty,2) qty"
							   +" from my_dlyd d left join my_main m on m.doc_no=d.prdId"
							   +" left join my_unitm u on d.unitid=u.doc_no"
							   +" left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
							   +" left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+docno+"') a,(select @i:=0) r;";
			 	
				bean.setDlyqry(jasperdly);
				
			    System.out.println("dly----------:"+pySql);
				ResultSet rsdetail=stmtgrid.executeQuery(pySql);
				
				int rowcount=1;
		
				while(rsdetail.next()){
						 
						temp=rowcount+"::"+rsdetail.getString("productname")+"::"+
						rsdetail.getString("temp")+"::"+rsdetail.getString("wh")+"::"+rsdetail.getString("qty");
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


}
