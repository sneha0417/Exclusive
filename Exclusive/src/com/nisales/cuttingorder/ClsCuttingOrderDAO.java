package com.nisales.cuttingorder;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
 

import net.sf.json.JSONArray;

public class ClsCuttingOrderDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
 
	public   JSONArray searchProduct(HttpSession session,String id) throws SQLException {

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
	     	 
			 
				
				
			String sqlss="select   bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;
		 	 
			ResultSet resultSet = sst.executeQuery (sqlss);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				sst.close();
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
	public   JSONArray reload(String docno) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement aaa = conn.createStatement ();
				// bevcodename  polcodename
				
	        	String pySql=(" select bb.code bevcodename,pp.code polcodename,d.floor, d.flat flatids, d.Width, d.height, d.qty quantity,  d.sqm, d.totsize, d.price, "
	        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
	        			+ " specid ,m.part_no productid,coalesce(d.productname,m.productname) productname,m.part_no proid ,"
	        			+ " coalesce(d.productname,m.productname) proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty from my_cord d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
	        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+docno+"' ");
				 
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
	        	
			        sql="select 0 msg, t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
		        
		        }else{
		        
			        sql= "select if(coalesce(jv.balance,0)>coalesce(aa.credit,0),1,0) msg,  jv.balance,aa.credit, t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
		        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
		        		+ "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid)"
		        				+ " left join ("+
					" select sum(j.dramount) balance,j.acno from my_jvtran j    where"+
					" j.status=3   group by j.acno) jv on jv.acno=t.doc_no left join my_acbook aa on aa.acno=t.doc_no  where a.active=1 and t.m_s=0"+sqltest;
		        
		        }
	 //System.out.println("===sql====="+sql);
		        
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
		HttpServletRequest request, String formdetailcode, String mode,int currsid, double ratess) throws SQLException {
	   Connection conn = null; 
	
	   int docno;
  	try{
		
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtcor= conn.prepareCall("{call tr_CuttingOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtcor.registerOutParameter(1, java.sql.Types.INTEGER);
		stmtcor.registerOutParameter(2, java.sql.Types.INTEGER);

		stmtcor.setDate(3,masterdate); 
		stmtcor.setDate(4,deldate);
		stmtcor.setDate(5,fixdate);
		
		stmtcor.setString(6,deliveryTime);
		
		stmtcor.setInt(7,itemtype);
		stmtcor.setInt(8,costtr_no);
		stmtcor.setInt(9,salid);
		stmtcor.setInt(10,acno);
		stmtcor.setString(11,lpono);
		
		stmtcor.setString(12,remarks);
 
		
		stmtcor.setString(13,formdetailcode);
		
		stmtcor.setString(14,session.getAttribute("USERID").toString());
		stmtcor.setString(15,session.getAttribute("BRANCHID").toString());
		stmtcor.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtcor.setString(17,mode);
		stmtcor.setInt(18,currsid);
		stmtcor.setDouble(19,ratess);
		
		

		stmtcor.executeQuery();
		docno=stmtcor.getInt("docNo");
 
		int vocno=stmtcor.getInt("vocNo");	
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
			    	 
			    	 
			    	// TR_NO, rdocno, ROWNO, SR_NO, psrno, prdId, UNITID,  SpecNo, floor, flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount 
 	 
		     String sql="INSERT INTO my_cord(sr_no,psrno,prdId,unitid,SpecNo,floor,flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount,productname,tr_no,rdocno)VALUES"
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
				        +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtcor.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
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
		int currsid, double ratess,int docno) throws SQLException {
	   Connection conn = null; 
		
	   
	try{
		
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtcor= conn.prepareCall("{call tr_CuttingOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtcor.setInt(1, docno);
		stmtcor.setInt(2, 0);

		stmtcor.setDate(3,masterdate); 
		stmtcor.setDate(4,deldate);
		stmtcor.setDate(5,fixdate);
		
		stmtcor.setString(6,deliveryTime);
		
		stmtcor.setInt(7,itemtype);
		stmtcor.setInt(8,costtr_no);
		stmtcor.setInt(9,salid);
		stmtcor.setInt(10,acno);
		stmtcor.setString(11,lpono);
		
		stmtcor.setString(12,remarks);
 
		
		stmtcor.setString(13,formdetailcode);
		
		stmtcor.setString(14,session.getAttribute("USERID").toString());
		stmtcor.setString(15,session.getAttribute("BRANCHID").toString());
		stmtcor.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtcor.setString(17,mode);
		stmtcor.setInt(18,currsid);
		stmtcor.setDouble(19,ratess);
		
		

		int aa=stmtcor.executeUpdate();
		docno=stmtcor.getInt("docNo");

		int vocno=stmtcor.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(aa<=0)
		{
			conn.close();
			return 0;
			
		}
		
	 
			
			for(int i=0;i< descarray.size();i++){
		    	
				if(i==0)
				{
					String sq1l="delete from my_cord where rdocno="+docno+" ";
					stmtcor.executeUpdate(sq1l);
				}
				
				
			     String[] detmasterarrays=descarray.get(i).split("::");
			     if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[0].trim().equalsIgnoreCase("NaN")||detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()))
			     {
			    	 
			    	 
			    	// TR_NO, rdocno, ROWNO, SR_NO, psrno, prdId, UNITID,  SpecNo, floor, flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount 
	 
		     String sql="INSERT INTO my_cord(sr_no,psrno,prdId,unitid,SpecNo,floor,flat, Width, height, qty,  sqm, totsize, price, bcode, brate, bvalue, pcode, prate, pcharge, temp, amount,productname,tr_no,rdocno)VALUES"
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
				        +"'"+docno+"','"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtcor.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
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
		CallableStatement stmtcor= conn.prepareCall("{call tr_CuttingOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtcor.setInt(1, docno);
		stmtcor.setInt(2, 0);

		stmtcor.setDate(3,masterdate); 
		stmtcor.setDate(4,deldate);
		stmtcor.setDate(5,fixdate);
		
		stmtcor.setString(6,deliveryTime);
		
		stmtcor.setInt(7,itemtype);
		stmtcor.setInt(8,costtr_no);
		stmtcor.setInt(9,salid);
		stmtcor.setInt(10,acno);
		stmtcor.setString(11,lpono);
		
		stmtcor.setString(12,remarks);
 
		
		stmtcor.setString(13,formdetailcode);
		
		stmtcor.setString(14,session.getAttribute("USERID").toString());
		stmtcor.setString(15,session.getAttribute("BRANCHID").toString());
		stmtcor.setString(16,session.getAttribute("COMPANYID").toString());
 
		 
		stmtcor.setString(17,mode);
		stmtcor.setInt(18,currsid);
		stmtcor.setDouble(19,ratess);
		

		int aa=stmtcor.executeUpdate();
		docno=stmtcor.getInt("docNo");

		int vocno=stmtcor.getInt("vocNo");	
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
			
 
        	String pySql=("select * from (select case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcode' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,mm.amount,m.doc_no,m.voc_no,m.date,m.lpono,h.description,h.account,m.acno,m.remarks desc1 from my_corm m "
        			+ " left join   (select sum(amount) amount,rdocno from my_cord group by rdocno) mm on mm.rdocno=m.doc_no "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
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



public  ClsCuttingOrderBean getviewDetails(HttpSession session, int docno) throws SQLException {
	ClsCuttingOrderBean Bean=new ClsCuttingOrderBean();
	Connection conn=null;
	try
	{
		conn = ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		     
	String sql="select h.atype,r.code,m.curid,m.rate,m.lpono,sa.sal_name,m.sal_id,m.deldate,m.deltime,m.fixdate,m.costcode, m.costtype,case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcodeno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.remarks desc1 from my_corm m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId  where m.voc_no="+docno+" and m.brhid="+session.getAttribute("BRANCHID").toString()+" " ;
	
 
			ResultSet rd=st.executeQuery(sql);
			
			if(rd.first())
			{
				Bean.setMasterdoc_no(rd.getInt("doc_no"));
				
				Bean.setHiddate(rd.getString("date"));
				Bean.setHiddeliveryDate(rd.getString("deldate"));
				Bean.setHiddeliveryTime(rd.getString("deltime"));
				Bean.setHidfixDate(rd.getString("fixdate"));
				
				
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
public     ClsCuttingOrderBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsCuttingOrderBean bean = new ClsCuttingOrderBean();
	  Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			  ClsAmountToWords c = new ClsAmountToWords();
			 
			Statement stmtprint = conn.createStatement ();
       	
			String resql=("	select coalesce(ac.address,'') address,coalesce(coalesce(ac.per_mob,com_mob),'') mobno,coalesce(ac.fax1,'') fax1 "
					+ " ,h.atype,r.code,m.curid,m.rate,m.lpono,"
					+ " sa.sal_name,m.sal_id,DATE_FORMAT(m.deldate,'%d.%m.%Y') AS deldate ,m.deltime,"
					+ " DATE_FORMAT(m.fixdate,'%d.%m.%Y') AS fixdate,m.costcode, m.costtype,"
					+ " case when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costcodeno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' ,"
        			+ " u.costgroup,m.doc_no,m.voc_no, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description,h.account,m.acno,m.remarks desc1 from my_corm m "
        			+ " left join my_head h on h.doc_no=m.acno   "
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
        			+ " left join my_acbook ac on ac.acno=h.doc_no "
        			+ " left join my_salm sa on sa.doc_no=m.sal_id left join my_curr r on r.doc_no=m.curId   where   m.doc_no='"+docno+"'");
			
			
			//System.out.println("--resql--"+resql);
			
			ResultSet pintrs = stmtprint.executeQuery(resql);
			
	 
		       while(pintrs.next()){
		    	
		    	   bean.setLblOrderNO(pintrs.getString("voc_no"));
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
		     
		    	    
		    	  
		       }
			

			stmtprint.close();
			
		       
			Statement stmttot = conn.createStatement ();   
			String totsql="select format(sum(totsize),2) totsize from my_cord  where rdocno='"+docno+"'";
			ResultSet totrs=stmttot.executeQuery(totsql);
			while(totrs.next()){
				bean.setLbltotsize(totrs.getString("totsize"));
			}
			stmttot.close();
			
			
			
			 Statement stmt10 = conn.createStatement ();
			    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location,b.tinno from my_corm r  "
			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

			    	System.out.println("----------:"+companysql);
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
			 	String pySql=(" select coalesce(bb.code,' ') bevcodename,coalesce(pp.code,' ') polcodename,d.floor, d.flat, concat(round(d.Width),' x ',round(d.height)) wh, round(d.qty,2) qty ,  d.sqm, d.totsize, d.price, "
	        			+ "  d.bcode bevcode, d.brate bevrate, d.bvalue bevvalue, d.pcode polcode, d.prate polrate, d.pcharge polcharge, d.temp, d.amount,d.specno "
	        			+ " specid ,m.part_no productid,m.productname,m.part_no proid ,"
	        			+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty from my_cord d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
	        			+ " left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+docno+"' ");
				 
				String jasper="select @i:=@i+1 as srno,a.* from(select coalesce(d.productname,m.productname) productname,d.temp,concat(round(d.Width),' x ',round(d.height)) wh, round(d.qty,2) qty ,coalesce(bb.code,' ') bevcodename,coalesce(pp.code,' ') polcodename"
							+" from my_cord d left join my_main m on m.doc_no=d.prdId"
							+" left join my_unitm u on d.unitid=u.doc_no"
							+" left join my_corcode pp on pp.doc_no=d.pcode and pp.dtype='PLC'"
							+" left join my_corcode bb on bb.doc_no=d.bcode and bb.dtype='BLC' where rdocno='"+docno+"') a,(select @i:=0) r ;";
				bean.setCurqry(jasper); 
			      
				ResultSet rsdetail=stmtgrid.executeQuery(pySql);
				
				int rowcount=1;
		
				while(rsdetail.next()){

						 
						 
						temp=rowcount+"::"+rsdetail.getString("productname")+"::"+
						rsdetail.getString("temp")+"::"+rsdetail.getString("wh")+"::"+rsdetail.getString("qty")+"::"+
					    rsdetail.getString("bevcodename")+"::"+rsdetail.getString("polcodename") ;
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
