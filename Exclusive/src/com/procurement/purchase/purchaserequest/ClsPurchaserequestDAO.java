package com.procurement.purchase.purchaserequest;

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
import com.procurement.purchase.purchaseorder.ClspurchaseorderBean;

public class ClsPurchaserequestDAO {
	Connection conn;
	
	ClsCommon ClsCommon=new ClsCommon();
	 ClsConnection ClsConnection=new ClsConnection();
	
	public int insert(Date masterdate, String refno, String purdesc,
			HttpSession session, String mode, String formdetailcode,
			HttpServletRequest request, ArrayList<String> masterarray,int itermtype,int costtrno) throws SQLException {
		 

		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaserequestDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtpurorder.registerOutParameter(8, java.sql.Types.INTEGER);
 
			stmtpurorder.setDate(1,masterdate); 
			
			stmtpurorder.setString(2,refno);
 
			stmtpurorder.setString(3,purdesc);
			 
			stmtpurorder.setString(4,session.getAttribute("USERID").toString());
			stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(9,formdetailcode);
			stmtpurorder.setString(10,mode);

			stmtpurorder.executeQuery();
			docno=stmtpurorder.getInt("docNo");
	 
			int vocno=stmtpurorder.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
		     	int cosrcodemethod=0;			
				Statement coststmt=conn.createStatement();
				String chk="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rs=coststmt.executeQuery(chk); 
				if(rs.next())
				{
					
					cosrcodemethod=rs.getInt("method");
				}
				
				if(cosrcodemethod>0)
				{
					String upcostsql="update my_reqm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
					coststmt.executeUpdate(upcostsql);
					
					
					
				}
					
				
				
				
			
			
	    	 ArrayList<String> descarray= new ArrayList<>(); 
			
 
			String prddocnos="";
			String refqtys="";
			
			
		 
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
			    	   String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
					    String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
					     
				    	 
				         
					     double fr=1;
					     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
					     
					     System.out.println("====slss==="+slss);
					     ResultSet rv1=stmtpurorder.executeQuery(slss);
					     if(rv1.next())
					     {
					    	 fr=rv1.getDouble("fr"); 
					     }	
    	 
		     String sql="INSERT INTO my_reqd(sr_no,psrno,prdId,unitid,qty,specno,tr_no,rdocno,fr)VALUES"
				       + " ("+(i+1)+","
				     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
				       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
				       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
				       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
				       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
				       +"'"+docno+"','"+docno+"',"+fr+")";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
 
 
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
		

	public int update(int masterdoc_no, Date masterdate, String refno,
			String purdesc, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request,
			ArrayList<String> masterarray,int itermtype,int costtrno) throws SQLException {


		
		try{
			int docno;
		
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaserequestDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.setInt(7, masterdoc_no);
			stmtpurorder.setInt(8, 0);
 
			stmtpurorder.setDate(1,masterdate); 
			
			stmtpurorder.setString(2,refno);
 
			stmtpurorder.setString(3,purdesc);
			 
			stmtpurorder.setString(4,session.getAttribute("USERID").toString());
			stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			stmtpurorder.setString(9,formdetailcode);
			stmtpurorder.setString(10,mode);

			stmtpurorder.executeQuery();
			docno=stmtpurorder.getInt("docNo");
	 
			int vocno=stmtpurorder.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
			
			
			
			String delsqls="delete from my_reqd where tr_no='"+masterdoc_no+"' ";
			stmtpurorder.executeUpdate(delsqls);
			
			
	     	int cosrcodemethod=0	;			
				Statement coststmt=conn.createStatement();
				String chk="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rs=coststmt.executeQuery(chk); 
				if(rs.next())
				{
					
					cosrcodemethod=rs.getInt("method");
				}
				
				if(cosrcodemethod>0)
				{
					String upcostsql="update my_reqm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+masterdoc_no+" ";
					coststmt.executeUpdate(upcostsql);
					
					
					
				}
					
				
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			   //  System.out.println("-----prdId---"+detmasterarrays[1]);
			     
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("null")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	// System.out.println("-----psrno---"+detmasterarrays[0]);
			    	  String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
					    String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
					     
				    	 
				         
					     double fr=1;
					     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
					     
					     System.out.println("====slss==="+slss);
					     ResultSet rv1=stmtpurorder.executeQuery(slss);
					     if(rv1.next())
					     {
					    	 fr=rv1.getDouble("fr"); 
					     }	
				     String sql="INSERT INTO my_reqd(sr_no,psrno,prdId,unitid,qty,specno,tr_no,rdocno,fr)VALUES"
						       + " ("+(i+1)+","
						     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
						       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
						       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
						       +"'"+docno+"','"+docno+"',"+fr+")";
		 
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
 
 
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
		
	
	
	
	
	
	
	

	public int delete(int masterdoc_no, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request) throws SQLException {


	 
			try{
				int docno;
			
				 conn=ClsConnection.getMyConnection();
		 
				CallableStatement stmtpurorder= conn.prepareCall("{call tr_PurchaserequestDML(?,?,?,?,?,?,?,?,?,?)}");
				stmtpurorder.setInt(7, masterdoc_no);
				stmtpurorder.setInt(8, 0);
	 
				stmtpurorder.setDate(1,null); 
				
				stmtpurorder.setString(2,null);
	 
				stmtpurorder.setString(3,null);
				 
				stmtpurorder.setString(4,session.getAttribute("USERID").toString());
				stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
				stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
			//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
				stmtpurorder.setString(9,formdetailcode);
				stmtpurorder.setString(10,mode);

				stmtpurorder.executeQuery();
				docno=stmtpurorder.getInt("docNo");
		 
				int vocno=stmtpurorder.getInt("vocNo");	
				request.setAttribute("vocno", vocno);
				//System.out.println("====vocno========"+vocno);
			
				if(docno<=0)
				{
					conn.close();
					return 0;
					
				}
				//System.out.println("sssssss"+session.getAttribute("USERID").toString());
				
				
				
			
	 
			//	System.out.println("sssssss"+docno);
				if (docno > 0) {
					 
					stmtpurorder.close();
					conn.close();
					return docno;
				}
			}catch(Exception e){	
				conn.close();
			e.printStackTrace();	
			}
			return 0;
		   }
			
 
	
	
	
	public   JSONArray searchProduct(HttpSession session,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String category, String subcategory) throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	 
	 	if(!(id.equalsIgnoreCase("1"))){
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
		    String brcid=session.getAttribute("BRANCHID").toString();
	 	   
	 	Connection conn = null;

		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
				String sql="";
				int method=0;
				java.sql.Date estdate=null;
				String sqltest="";
				
				if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
					estdate=ClsCommon.changeStringtoSqlDate(date);
					
				}
				
				String condtn="";
				
				if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
					condtn ="  and m.part_no like '%"+prdname+"%' ";
				}
				
				if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
					condtn +="  and brd.brandname like '%"+brandname+"%' ";
				}
				
				gridprdname=gridprdname.replaceAll("@","%");
				if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
					condtn +="  and m.productname like '%"+gridprdname+"%' ";
				}
				
				if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
					condtn +="  and u.unit like '%"+gridunit+"%' ";
				}
				
				if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
					condtn +="  and c.category like '%"+category+"%' ";
				}
				
				if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
					condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
				}
				
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
				
				
			String fleetsql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from "
					+ " my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_catm c on c.doc_no=m.catid left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no  left join my_scatm sc on m.scatid=sc.doc_no   where m.status=3 "+condtn+" and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;
			System.out.println("-----fleetsql---"+fleetsql);
	/*		String fleetsql=("select "+method+" method,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join "
					+ " my_unitm u on m.munit=u.doc_no where m.status=3");*/
		// System.out.println("-----fleetsql---"+fleetsql);
			ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
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
	
	
	public   JSONArray maingridreload(String nidoc) throws SQLException {
 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select bd.brandname,d.specno specid ,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty from my_reqd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no   where tr_no='"+nidoc+"' ");
 System.out.println("==== "+pySql);
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
	
	
	public   JSONArray mainsearch(HttpSession session,String docnoss,String datess,String aa,String descriptions,String refnoss) throws SQLException {

		
		
		JSONArray RESULTDATA=new JSONArray();
		if(!(aa.equalsIgnoreCase("yes")))
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
	       
	      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.description like '%"+descriptions+"%'";
	      	}
	      
	     	if((!(refnoss.equalsIgnoreCase(""))) && (!(refnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.refno like '%"+refnoss+"%'";
	      	}
	      
	      	
	      	
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	   
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
			
				Statement stmtmain = conn.createStatement ();
				
				
 		
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno  from my_reqm m    where m.status!=7 and m.brhid='"+brcid+"' "+sqltest+" ");
	     //   System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			 
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
	
	
	 public     ClsPurchaserequestBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsPurchaserequestBean bean = new ClsPurchaserequestBean();
		 
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select voc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,if(coalesce(description,'')!='',description,coalesce(description,''))description,refno from my_reqm where doc_no='"+docno+"'");
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	 
			    	   
			    	   
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	 
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location,b.tinno from my_reqm r  "
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
				    	   bean.setTinno(resultsetcompany.getString("tinno"));
				    	  
				    	 
				    	   
				       } 
				       stmt10.close();
				       
				       ArrayList<String> arr =new ArrayList<String>();
				   	Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty  from my_reqd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where tr_no='"+docno+"'";
					
				     //  System.out.println("product======"+strSqldetail);
				       
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;

							arr.add(temp);
							rowcount++;
			
					
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					 
					  String productQuery="select @i:=@i+1 as srno,a.* from (Select m.part_no productid,m.productname, u.unit,round(d.qty,2) qty  from my_reqd d "
			   	         		+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where tr_no="+docno+") a,(select @i:=0) r";
			   	        bean.setPrdQry(productQuery);
			   	        
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	
/*	 public     ClsPurchaserequestBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsPurchaserequestBean bean = new ClsPurchaserequestBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select voc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,description,refno from my_reqm where doc_no='"+docno+"'");
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	 
			    	   
			    	   
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	 
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_reqm r  "
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
				       
				       ArrayList<String> arr =new ArrayList<String>();
				   	Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty  from my_reqd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where tr_no='"+docno+"'";
					
			
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;

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


		 
	*/
	
	public ClsPurchaserequestBean getViewDetails(int docno, HttpSession session) throws SQLException {
		ClsPurchaserequestBean showBean = new ClsPurchaserequestBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		
	//	String sqls="select   m.doc_no,m.voc_no,m.date,m.description,m.refno  from my_reqm m    where  m.voc_no='"+docno+"' and  m.brhid="+session.getAttribute("BRANCHID").toString()+"  ";
		
		
    	int cosrcodemethod=0;			
				Statement coststmt=conn.createStatement();
				String chk="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rs=coststmt.executeQuery(chk); 
				if(rs.next())
				{
					
					cosrcodemethod=rs.getInt("method");
				}
				String sq1="";
				String jsq1="";
		
				if(cosrcodemethod>0)
				{
				  sq1=  " m.costtype,m.costcode costtr_no,case when m.costtype=6 then m.costcode  when m.costtype=1 then m.costcode when m.costtype in(3,4) then co.doc_no "
					   + " when m.costtype in(5) then cs.doc_no  end as 'costcode' ,case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
					   + "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' , ";
				jsq1= "  left join my_ccentre c on c.costcode=m.costcode and m.costtype=1 "
						+ " left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) "
						+ " left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 "
						+ " left join gl_vehmaster mm on mm.fleet_no=m.costcode and m.costtype=6 " ;
					  
				}
				
				
		
		String sqls="select   "+sq1+"  "
				+ " m.doc_no,m.voc_no,m.date,m.description,m.refno  from my_reqm m "
			 	+"  "+jsq1+"  where  m.voc_no='"+docno+"' and  m.brhid="+session.getAttribute("BRANCHID").toString()+"  ";
		
		
		System.out.println("======sqls===="+sqls);
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		while (resultSet.next()) {
			
			showBean.setDocno(resultSet.getInt("voc_no"));
			showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
			showBean.setPurdesc(resultSet.getString("description"));
			showBean.setHidreqmasterdate(resultSet.getString("date"));
			showBean.setRefno(resultSet.getString("refno"));
			
			if(cosrcodemethod>0)
			{
			showBean.setItemtype (resultSet.getInt("costtype"));
			
			showBean.setCosttr_no(resultSet.getInt("costtr_no"));

			showBean.setItemname(resultSet.getString("prjname"));
			
			showBean.setItemdocno(resultSet.getInt("costcode"));
			}
			
			
			
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
	
	public JSONArray brandSearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray subCategorySearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,subcategory from my_scatm where status=3";

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
