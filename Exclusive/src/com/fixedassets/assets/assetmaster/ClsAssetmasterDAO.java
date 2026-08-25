package com.fixedassets.assets.assetmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;



import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class ClsAssetmasterDAO{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public  JSONArray AccountsDetails(HttpSession session,String accountno,String accountname,String mobile,String currency,String date,String check) throws SQLException {
        
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
		          
		 
		          
		           sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
		            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
		            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0" +sqltest;
		 
		          
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
	
	public  JSONArray subdetails(HttpSession session,String docno) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		 
               String sql="select sr_no,desc1,qty from my_fixd where rsrno='"+docno+"'";
		        //  System.out.println("---------"+sql);
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	
	public  JSONArray masterSearch(HttpSession session,String assetname,String assetid,String sdocno,String assetgroup,String chk) throws SQLException {
        
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
 	    	
		        
		        Connection conn = null; 
		       
		      try {
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		    	 if(chk.equalsIgnoreCase("yes"))
		    			 {
		         String sqltest="";
			    	
			    	if(!(assetname.equalsIgnoreCase("")) && !(assetname.equalsIgnoreCase("0"))){
			    		sqltest=sqltest+" and f.assetname like '%"+assetname+"%'";
			    	}
			    	if(!(assetid.equalsIgnoreCase("")) &&  !(assetid.equalsIgnoreCase("0"))){
			    		sqltest=sqltest+" and f.assetid like '%"+assetid+"%'";
			    	}
			    	if(!(sdocno.equalsIgnoreCase("")) &&  !(sdocno.equalsIgnoreCase("0"))){
			    		sqltest=sqltest+" and f.doc_no like '%"+sdocno+"%'";
			    	}
			    	if(!(assetgroup.equalsIgnoreCase("")) &&  !(assetgroup.equalsIgnoreCase("0"))){
			    		sqltest=sqltest+" and g.grp_name like '%"+assetgroup+"%'";
			    	}
			    	
	
             String sql="select f.sr_no,f.doc_no,f.assetid,f.assetname,f.date,coalesce(g.grp_name,'') gpname from my_fixm f left join  "
             		+ " my_fagrp g on g.doc_no=f.assetgp where f.status=3 and f.brhid='"+session.getAttribute("BRANCHID").toString()+"' "+ sqltest;
		        //  System.out.println("---------"+sql);
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	
	

	
	
	
	
	public  JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String date,String check) throws SQLException {
        
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
	        	   
		        String sqltest="";
		        String sql="";
		        
		        date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
		           }
		         //  and t.den=305
		     
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 " +sqltest;
		        
		     ///   System.out.println( "------"+sql);
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		     /*  stmt.close();
		       conn.close();*/
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




	public int insert(HttpServletRequest request, HttpSession session, Date sqlmasterDate, Date sqlwarExpDate,
			Date sqlpuchaseDate, String refno, String remarks, String assetid,
			int supaccdocno, String purchrefno, int noofitems, String wntydocno,
			int subgriddisval, int openingval, String assetGroupval,
			String location, String supcmbcurrency, String suphidcurrencytype,
			String depnotes, double suprate, double totalpuchvalue,
			double accumdepr, double lifetimeyear, double depper, String assetname,String mode,String formcode,ArrayList<String> descarray, int fixacdocno, int aumdeprdocno, int depdocno) throws SQLException {
		location=location==null?"0":location;
		assetGroupval=assetGroupval==null?"0":assetGroupval;
		if(location.equalsIgnoreCase(""))
		{
			location="0";	
		}
		if(assetGroupval.equalsIgnoreCase(""))
		{
			assetGroupval="0";	
		}
		Connection conn=null;
		try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement assetmaster=conn.prepareCall("{CALL assetMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		assetmaster.setDate(1,sqlmasterDate);
		assetmaster.setDate(2,sqlwarExpDate);
		assetmaster.setDate(3,sqlpuchaseDate);
		assetmaster.setString(4,refno);
		assetmaster.setString(5,remarks);
		assetmaster.setString(6,assetid);
		assetmaster.setInt(7,supaccdocno);
		assetmaster.setString(8,purchrefno);
		assetmaster.setInt(9,noofitems);
		assetmaster.setString(10,wntydocno);
		assetmaster.setInt(11,subgriddisval);
		assetmaster.setInt(12,openingval);
		assetmaster.setString(13,assetGroupval.trim());
		assetmaster.setString(14,location.trim());
		assetmaster.setString(15,assetname);
		assetmaster.setString(16,depnotes);
		assetmaster.setDouble(17,totalpuchvalue);
		assetmaster.setDouble(18,accumdepr);
		assetmaster.setDouble(19,lifetimeyear);
		assetmaster.setDouble(20,depper);
		assetmaster.registerOutParameter(21, java.sql.Types.INTEGER);
		assetmaster.setString(22,session.getAttribute("BRANCHID").toString());
		assetmaster.setString(23,session.getAttribute("USERID").toString());
		assetmaster.setString(24,mode);
		assetmaster.setString(25,formcode);
		assetmaster.registerOutParameter(26, java.sql.Types.INTEGER);
		
		assetmaster.setInt(27,fixacdocno);
		assetmaster.setInt(28,aumdeprdocno);
		assetmaster.setInt(29,depdocno);
		assetmaster.executeQuery();
		  int docno=assetmaster.getInt("docNo");
		  
		  int vocno=assetmaster.getInt("vocNo");	
			request.setAttribute("srno", vocno);
		  
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			     

			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
		  
		     String sql="INSERT INTO my_fixd(sr_no,desc1,qty,rsrno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				        +"'"+vocno+"')";
				     int resultSet2 = assetmaster.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
			     }
			}
			
			
			
		  	Statement stmt = conn.createStatement(); 	
		  	
		  	
		  	int method=0;
		  	String trsql1="select method from gl_config where field_nme='Fajv'";
			
			ResultSet tass1 = stmt.executeQuery (trsql1);
			
			if (tass1.next()) {
		
				method=tass1.getInt("method");		
				
		     }
			 int tranno=0;
				
				String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
			
				ResultSet tass = stmt.executeQuery (trsql);
				
				if (tass.next()) {
			
					tranno=tass.getInt("trno");		
					
			     }
				
				String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
				
				int dd=stmt.executeUpdate(trnosql);
			     
						 if(dd<=0)
							{
								conn.close();
								return 0;
								
							}
				
		  	
			if(method==1 && openingval==0)
		  	
			{
			String refdetails=formcode+""+docno;
		     
		     
					 
					 String vendorcur=""; 
					 double venrate=0.00;
					 
					 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+supaccdocno+"'";
			
					   ResultSet tass11 = stmt.executeQuery (sqls10);
					   if(tass11.next()) {
					
						   vendorcur=tass11.getString("curid");	
					
							
					     }
					 
					
				     String currencytype="";
				     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
				        +"where  coalesce(toDate,curdate())>='"+sqlmasterDate+"' and frmDate<='"+sqlmasterDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				
				     ResultSet resultSet33 = stmt.executeQuery(sqlss);
				         
				      while (resultSet33.next()) {
				    	  venrate=resultSet33.getDouble("rate");
				     currencytype=resultSet33.getString("type");
				      }
				     
					 
					   double	dramount=totalpuchvalue*-1; 
					   
					
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
					 		+ "values('"+sqlmasterDate+"','"+refdetails+"',"+docno+",'"+supaccdocno+"','Asset Master','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'FAM','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
				     
					 
				
					 int ss = stmt.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     int acnos=0;
				     String curris="";
				     double rates=0.00;
				     
				     //noushad
				     
	
					
					
					 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+fixacdocno+"'";
				//	System.out.println("-----sqls3-----"+sqls3); 
					   ResultSet tass3 = stmt.executeQuery (sqls3);
						
						if (tass3.next()) {
					
							curris=tass3.getString("curid");	
							//rates=tass3.getDouble("rate");	
							
					     }
						String currencytype1="";
						 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							        +"where  coalesce(toDate,curdate())>='"+sqlmasterDate+"' and frmDate<='"+sqlmasterDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
						
							     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
							         
							      while (resultSet44.next()) {
							    	  rates=resultSet44.getDouble("rate");
							      currencytype1=resultSet44.getString("type");
							      } 
					
							      
							      double ldramounts=0 ;     
							      if(currencytype1.equalsIgnoreCase("D"))
							      {
							      
					                   ldramounts=totalpuchvalue/venrate ;  
							      }
							      
							      else
							      {
							    	   ldramounts=totalpuchvalue*venrate ;  
							      }
				     
					 String sql10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+sqlmasterDate+"','"+refdetails+"',"+docno+",'"+fixacdocno+"','Asset Master','"+curris+"','"+rates+"',"+totalpuchvalue+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'FAM','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
					     
						 
				
						 int ss1 = stmt.executeUpdate(sql10);

					     if(ss1<=0)
							{
								conn.close();
								return 0;
								
							}
					     
					     

				
					 				   
									   
							     
				     
			}
			
			
			
			if(openingval==1)
			{
				
				  double  accumdeprval=accumdepr*-1;
					
				     String sqla1="INSERT INTO my_fatran(date,doc_no,asset_no,acno,dramount,brhid,ttype,ftype,tr_no,depr)VALUES"
						       + " ('"+sqlpuchaseDate+"','"+vocno+"',"
						       + "'"+vocno+"',"
						       + "'"+aumdeprdocno+"',"
						       + "'"+accumdeprval+"',"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'FAM','"+assetGroupval+"','"+tranno+"','"+depper+"' )";
				     
				 	//System.out.println("---sqla-------"+sqla);
						     int resultSet31 = stmt.executeUpdate(sqla1);
						    
						     if(resultSet31<=0)
								{
									conn.close();
									return 0;
									
								}	
				
			}
			

			
				
						
			
									     String sqla="INSERT INTO my_fatran(date,doc_no,asset_no,acno,dramount,brhid,ttype,ftype,tr_no,depr)VALUES"
											       + " ('"+sqlpuchaseDate+"','"+vocno+"',"
											       + "'"+vocno+"',"
											       + "'"+fixacdocno+"',"
											       + "'"+totalpuchvalue+"',"
											       + "'"+session.getAttribute("BRANCHID").toString()+"',"
											       +"'FAM','"+assetGroupval+"','"+tranno+"','"+depper+"' )";
									     
									 	//System.out.println("---sqla-------"+sqla);
											     int resultSet3 = stmt.executeUpdate(sqla);
											    
											     if(resultSet3<=0)
													{
														conn.close();
														return 0;
														
													}					   
									   
							     
							     
						
			
			
			
			
		String sqlupdates="update my_fixm set tr_no='"+tranno+"' where doc_no='"+docno+"' ";	
			
			int lastval=stmt.executeUpdate(sqlupdates);
			
			if(lastval<=0)
			{
				conn.close();
				return 0;
			}
						
	     
			
			
			
			
		  
		  
		  if (docno > 0) {
				conn.commit();
				assetmaster.close();
				conn.close();
	          return docno;
		}
		}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		
		
		return 0;
	}

	public  ClsAssetmasterBean getViewDetails(HttpSession session,int docno) throws SQLException {
		
		
		
		ClsAssetmasterBean ab = new ClsAssetmasterBean();
		Connection conn=null;
		try {
		  conn = ClsConnection.getMyConnection();
		Statement stmtCPV0 = conn.createStatement ();
		String branch = session.getAttribute("BRANCHID").toString();
		
		String strSql=("select doc_no, sr_no, date, refno, assetid, assetname, remarks, assetgp, loc, supacno, purefno, purdate, noofitems, "
				+ " totpurval, warexpdate, wardocno, subchk, opgchk, round(accumdepr,2) accumdepr,  round(lifetime,2) lifetime,  "
				+ " round(deprper,2) deprper, notes, fixastacno, accdepacno, "
				+ "depacno, brhid, userid, status from  my_fixm where doc_no='"+docno+"' and brhid='"+branch+"'");
		
		 
			ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
			
			int supacno=0;
			int fixacc=0;
			int accdep=0;
			int depacc=0;
			
			java.sql.Date sqlDate =null;
 	
			if (resultSet.next()) {
				
				sqlDate=resultSet.getDate("date");
				ab.setDocno(resultSet.getInt("doc_no"));
				ab.setMasterdate(resultSet.getString("date"));
				ab.setAssetid(resultSet.getString("assetid"));  
				ab.setAssetname(resultSet.getString("assetname"));
				
				ab.setAssetGroup(resultSet.getString("assetgp"));
				ab.setLocation(resultSet.getString("loc"));
				
				
				supacno=resultSet.getInt("supacno");
				fixacc=resultSet.getInt("fixastacno");
				accdep=resultSet.getInt("accdepacno");
				depacc=resultSet.getInt("depacno");

				
				ab.setPurchasedate(resultSet.getString("purdate"));
				ab.setWarexpdate(resultSet.getString("warexpdate"));
				ab.setDepnotes(resultSet.getString("notes"));
				ab.setRefno(resultSet.getString("refno")); 
				ab.setTotalpuchvalue(resultSet.getDouble("totpurval"));
				
				ab.setRemarks(resultSet.getString("remarks"));
				
			
				ab.setPurchrefno(resultSet.getString("purefno"));
				
				ab.setNoofitems(resultSet.getInt("noofitems"));
				ab.setWntydocno(resultSet.getString("wardocno"));
				
				ab.setSubgriddisval(resultSet.getInt("subchk"));
				ab.setOpeningval(resultSet.getInt("opgchk"));
				
		
				ab.setAccumdepr(resultSet.getDouble("accumdepr"));
				ab.setLifetimeyear(resultSet.getDouble("lifetime"));
				ab.setDepper(resultSet.getDouble("deprper"));
				
				
			}
				
		if(supacno>0)
		{
			
		    String   sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
			            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
			            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0 and t.doc_no='"+supacno+"'";
		       ResultSet resultSet1 = stmtCPV0.executeQuery(sql);     
		       
		       
		       
		       if(resultSet1.next()) {
		    	   
		    	   
		    	    ab.setSupaccdocno(supacno);
		    	    ab.setSupcmbcurrency(resultSet1.getString("curid")); 
		    		ab.setSuphidcurrencytype(resultSet1.getString("type"));
		    		ab.setSupplieraccId(resultSet1.getInt("account"));
		    		ab.setSuprate(resultSet1.getInt("rate"));
		    		ab.setSupplieraccName(resultSet1.getString("description"));
		       
		       }
		       
		       
		}
		
		if(fixacc>0)
		{
			
			

		    String  sql1="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
		        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
		        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
		        	  + "where t.atype='GL' and t.m_s=0 and t.doc_no='"+fixacc+"'" ;
		       ResultSet resultSet2 = stmtCPV0.executeQuery(sql1);     
		       
		       
		       
		       if(resultSet2.next()) {
		    	   


			        
			        
		    	    ab.setFixaccDocno(fixacc);
		    		ab.setFixedassetaccName(resultSet2.getString("description"));
		    		ab.setFixaccType(resultSet2.getString("type"));
		    		ab.setFixedassetaccId(resultSet2.getInt("account"));
		    	    ab.setFixaccCurrid(resultSet2.getInt("curid")); 
		    		ab.setFixaccRate(resultSet2.getInt("rate"));
		    	
		       
		       }
		       
			
		}
		
		
		if(accdep>0)
		{
			
			

		    String  sql3="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
		        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
		        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
		        	  + "where t.atype='GL' and t.m_s=0 and t.doc_no='"+accdep+"'" ;
		//    System.out.println("----sql3---"+sql3);
		    
		       ResultSet resultSet3 = stmtCPV0.executeQuery(sql3);     
		       
		       
		       
		       if(resultSet3.next()) {
		
			        
			        
		    	    ab.setAccdepraccDocno(accdep);
		    		ab.setAccdepraccName(resultSet3.getString("description"));
		    		ab.setAccdepraccType(resultSet3.getString("type"));
		    		ab.setAccdepraccId(resultSet3.getInt("account"));
		    	    ab.setAccdepraccCurrid(resultSet3.getInt("curid")); 
		    		ab.setAccdepraccRate(resultSet3.getInt("rate"));
		    	
		       
		       }
		       
			
		}
		
		
		if(depacc>0)
		{
			
			

		    String  sql4="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
		        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
		        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
		        	  + "where t.atype='GL' and t.m_s=0 and t.doc_no='"+depacc+"'" ;
		    
		    
		    //System.out.println("----sql4---"+sql4);
		       ResultSet resultSet4 = stmtCPV0.executeQuery(sql4);     
		       
		       
		       
		       
		       
		       
		       if(resultSet4.next()) {

			        
		    	    ab.setDepracDocno(depacc);
		    		ab.setDepraccName(resultSet4.getString("description"));
		    		ab.setDepracType(resultSet4.getString("type"));
		    		ab.setDepraccId(resultSet4.getInt("account"));
		    	    ab.setDepracCurrid(resultSet4.getInt("curid")); 
		    		ab.setDepracRate(resultSet4.getInt("rate"));
		    	
		       
		       }
		       
			
		}
		
			
		
		
		stmtCPV0.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		
		return ab;
		
		
		
	}

	public int delete(int docno,String mode, HttpSession session) throws SQLException {
        Connection conn = null; 
		try{
			
			conn=ClsConnection.getMyConnection();
			
					
			CallableStatement assetmaster=conn.prepareCall("{CALL assetMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			assetmaster.setDate(1,null);
			assetmaster.setDate(2,null);
			assetmaster.setDate(3,null);
			assetmaster.setString(4,null);
			assetmaster.setString(5,null);
			assetmaster.setString(6,null);
			assetmaster.setInt(7,0);
			assetmaster.setString(8,null);
			assetmaster.setInt(9,0);
			assetmaster.setString(10,null);
			assetmaster.setInt(11,0);
			assetmaster.setInt(12,0);
			assetmaster.setString(13,null);
			assetmaster.setString(14,null);
			assetmaster.setString(15,null);
			assetmaster.setString(16,null);
			assetmaster.setDouble(17,0);
			assetmaster.setDouble(18,0);
			assetmaster.setDouble(19,0);
			assetmaster.setDouble(20,0);
			assetmaster.setInt(21,docno);
			assetmaster.setString(22,session.getAttribute("BRANCHID").toString());
			assetmaster.setString(23,null);
			assetmaster.setString(24,"D");
			assetmaster.setString(25,null);
			assetmaster.setInt(26,0);
			
			assetmaster.setInt(27,0);
			assetmaster.setInt(28,0);
			assetmaster.setInt(29,0);
		//	assetmaster.executeQuery();
			int aaa=assetmaster.executeUpdate();
			
			
			
			if (aaa > 0) {
				
				assetmaster.close();
				conn.close();
				System.out.println("Sucess");
				return docno;
			}	
		}catch(Exception e){
			
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}

	public boolean edit(int vocno,String masrter, int docno, HttpServletRequest request,
			HttpSession session, Date sqlmasterDate, Date sqlwarExpDate,
			Date sqlpuchaseDate, String refno, String remarks, String assetid,
			int supaccdocno, String purchrefno, int noofitems,
			String wntydocno, int subgriddisval, int openingval,
			String assetGroupval, String location, String supcmbcurrency,
			String suphidcurrencytype, String depnotes, double suprate,
			double totalpuchvalue, double accumdepr, double lifetimeyear,
			double depper, String assetname, String mode,
			String formcode, ArrayList<String> descarray,
			int fixacdocno, int aumdeprdocno, int depdocno) throws SQLException {
		
		//System.out.println("----location-------"+location);
		//System.out.println("----assetGroupval-------"+assetGroupval);
		location=location==null?"0":location;
		assetGroupval=assetGroupval==null?"0":assetGroupval;
		if(location.equalsIgnoreCase(""))
		{
			location="0";	
		}
		if(assetGroupval.equalsIgnoreCase(""))
		{
			assetGroupval="0";	
		}
		
		Connection conn=null;
		try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
		CallableStatement assetmaster=conn.prepareCall("{CALL assetMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		assetmaster.setDate(1,sqlmasterDate);
		assetmaster.setDate(2,sqlwarExpDate);
		assetmaster.setDate(3,sqlpuchaseDate);
		assetmaster.setString(4,refno);
		assetmaster.setString(5,remarks);
		assetmaster.setString(6,assetid);
		assetmaster.setInt(7,supaccdocno);
		assetmaster.setString(8,purchrefno);
		assetmaster.setInt(9,noofitems);
		assetmaster.setString(10,wntydocno);
		assetmaster.setInt(11,subgriddisval);
		assetmaster.setInt(12,openingval);
		assetmaster.setString(13,assetGroupval.trim());
		assetmaster.setString(14,location.trim());
		assetmaster.setString(15,assetname);
		assetmaster.setString(16,depnotes);
		assetmaster.setDouble(17,totalpuchvalue);
		assetmaster.setDouble(18,accumdepr);
		assetmaster.setDouble(19,lifetimeyear);
		assetmaster.setDouble(20,depper);
		assetmaster.setInt(21,docno);
		assetmaster.setString(22,session.getAttribute("BRANCHID").toString());
		assetmaster.setString(23,session.getAttribute("USERID").toString());
		assetmaster.setString(24,mode);
		assetmaster.setString(25,formcode);
		assetmaster.setInt(26,vocno);
		
		assetmaster.setInt(27,fixacdocno);
		assetmaster.setInt(28,aumdeprdocno);
		assetmaster.setInt(29,depdocno);
		assetmaster.executeQuery();
	
		 // int vocno=assetmaster.getInt("vocNo");	
		  
		  
		  String delsql="Delete from my_fixd where sr_no='"+vocno+"'  ";
		  assetmaster.executeUpdate(delsql);
		  
			for(int i=0;i< descarray.size();i++){
		    	
				
				
				     String[] vehpurreqarray=descarray.get(i).split("::");
			     

			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
		  
		     String sql="INSERT INTO my_fixd(sr_no,desc1,qty,rsrno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				        +"'"+vocno+"')";
				     int resultSet2 = assetmaster.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return false;
							
						}
				     
			     }
			}
			
			
			
			if(masrter.equalsIgnoreCase("master"))
			{
				
				conn.commit();
				assetmaster.close();
				conn.close();
	          return true;
				
			}
			
			
			else
			{
			
			
			
			
			
			
			

		  	Statement stmt = conn.createStatement(); 	
		  	
		  	
		  	int method=0;
		  	String trsql1="select method from gl_config where field_nme='Fajv'";
			
			ResultSet tass1 = stmt.executeQuery (trsql1);
			
			if (tass1.next()) {
		
				method=tass1.getInt("method");		
				
		     }
			 int tranno=0;
				
				String trsql="SELECT tr_no trno FROM my_fixm where sr_no='"+vocno+"'";
			
				//System.out.println("------trsql---"+trsql);
				
				ResultSet tass = stmt.executeQuery (trsql);
				
				if (tass.next()) {
			
					tranno=tass.getInt("trno");		
					
			     }
				
				
				
				  
				  String delsql1="Delete from my_jvtran where tr_no='"+tranno+"'  ";
					//System.out.println("------trsql---"+delsql1);
				  assetmaster.executeUpdate(delsql1);
				  String delsql2="Delete from my_fatran where asset_no='"+vocno+"'  ";
					//System.out.println("------trsql---"+delsql2);
				  assetmaster.executeUpdate(delsql2);
				
		  	
			if(method==1 && openingval==0)
		  	
			{
			String refdetails=formcode+""+docno;
		     
		     
					 
					 String vendorcur=""; 
					 double venrate=0.00;
					 
					 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+supaccdocno+"'";
			
					   ResultSet tass11 = stmt.executeQuery (sqls10);
					   if(tass11.next()) {
					
						   vendorcur=tass11.getString("curid");	
					
							
					     }
					 
					
				     String currencytype="";
				     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
				        +"where  coalesce(toDate,curdate())>='"+sqlmasterDate+"' and frmDate<='"+sqlmasterDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				
				     ResultSet resultSet33 = stmt.executeQuery(sqlss);
				         
				      while (resultSet33.next()) {
				    	  venrate=resultSet33.getDouble("rate");
				     currencytype=resultSet33.getString("type");
				      }
				     
					 
					   double	dramount=totalpuchvalue*-1; 
					   
					
					   double ldramount=0;
					   if(currencytype.equalsIgnoreCase("D"))
					   {
					   
			           	
			           	 ldramount=dramount/venrate ;  
					   }
					   
					   else
					   {
						    ldramount=dramount*venrate ;  
					   }
					   
				java.sql.Date sqlDate=null;
			String sqlfixmdate="select date fixmdate from my_fixm where tr_no="+tranno+"";
			
			System.out.println("date from my_fixm===="+sqlfixmdate);
			
			  ResultSet tass112 = stmt.executeQuery (sqlfixmdate);
			   if(tass112.next()) {
			
				  sqlDate=tass112.getDate("fixmdate");	
			
					
			     }
			 
			
			
				
					
					 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlDate+"','"+refdetails+"',"+docno+",'"+supaccdocno+"','Asset Master','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'FAM','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
				     
					 System.out.println("jvtran edit insertion===="+sql1);
				
					 int ss = stmt.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return false;
							
						}
				     
				     int acnos=0;
				     String curris="";
				     double rates=0.00;
				     
				     //noushad
				     
	
					
					
					 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+fixacdocno+"'";
				//	System.out.println("-----sqls3-----"+sqls3); 
					   ResultSet tass3 = stmt.executeQuery (sqls3);
						
						if (tass3.next()) {
					
							curris=tass3.getString("curid");	
							//rates=tass3.getDouble("rate");	
							
					     }
						String currencytype1="";
						 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							        +"where  coalesce(toDate,curdate())>='"+sqlmasterDate+"' and frmDate<='"+sqlmasterDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
						
							     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
							         
							      while (resultSet44.next()) {
							    	  rates=resultSet44.getDouble("rate");
							      currencytype1=resultSet44.getString("type");
							      } 
					
							      
							      double ldramounts=0 ;     
							      if(currencytype1.equalsIgnoreCase("D"))
							      {
							      
					                   ldramounts=totalpuchvalue/venrate ;  
							      }
							      
							      else
							      {
							    	   ldramounts=totalpuchvalue*venrate ;  
							      }
				     
							      
							      
							  	java.sql.Date fixmdate=null;
								String sqlfixmdate2="select date fixmdate from my_fixm where tr_no="+tranno+"";
								
								System.out.println("date from my_fixm===="+sqlfixmdate2);
								
								  ResultSet tass1122 = stmt.executeQuery (sqlfixmdate2);
								   if(tass1122.next()) {
								
									   fixmdate=tass1122.getDate("fixmdate");	
								
										
								     }
								 
							      
							      
							      
							      
					 String sql10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+fixmdate+"','"+refdetails+"',"+docno+",'"+fixacdocno+"','Asset Master','"+curris+"','"+rates+"',"+totalpuchvalue+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'FAM','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
					     
						 
				
						 int ss1 = stmt.executeUpdate(sql10);

					     if(ss1<=0)
							{
								conn.close();
								return false;
								
							}
					     
			
			
				     
			          }

			if(openingval==1)
			{
				
				  double  accumdeprval=accumdepr*-1;
					
				     String sqla1="INSERT INTO my_fatran(date,doc_no,asset_no,acno,dramount,brhid,ttype,ftype,tr_no,depr)VALUES"
						       + " ('"+sqlpuchaseDate+"','"+vocno+"',"
						       + "'"+vocno+"',"
						       + "'"+aumdeprdocno+"',"
						       + "'"+accumdeprval+"',"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'FAM','"+assetGroupval+"','"+tranno+"','"+depper+"' )";
				     
				 	//System.out.println("---sqla-------"+sqla);
						     int resultSet31 = stmt.executeUpdate(sqla1);
						    
						     if(resultSet31<=0)
								{
									conn.close();
									return false;
									
								}	
				
			}
			
				
						
			

						     String sqla="INSERT INTO my_fatran(date,doc_no,asset_no,acno,dramount,brhid,ttype,ftype,tr_no,depr)VALUES"
								       + " ('"+sqlpuchaseDate+"','"+vocno+"',"
								       + "'"+vocno+"',"
								       + "'"+fixacdocno+"',"
								       + "'"+totalpuchvalue+"',"
								       + "'"+session.getAttribute("BRANCHID").toString()+"',"
								       +"'FAM','"+assetGroupval+"','"+tranno+"','"+depper+"' )";
						     
						 			
									     
									 	//System.out.println("---sqla-------"+sqla);
											     int resultSet3 = stmt.executeUpdate(sqla);
											    
											     if(resultSet3<=0)
													{
														conn.close();
														return false;
														
													}					   
									   
							     
							     
						
			
			}
		
		
		  if (docno > 0) {
				conn.commit();
				assetmaster.close();
				conn.close();
	          return true;
		}
		}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		
		
	
	
		
		
		
		
		return false;
	}




}
