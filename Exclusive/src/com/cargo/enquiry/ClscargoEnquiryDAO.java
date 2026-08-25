package com.cargo.enquiry;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.procurement.purchase.purchaserequest.ClsPurchaserequestBean;

import net.sf.json.JSONArray;

public class ClscargoEnquiryDAO {

	Connection conn;
		
	ClsConnection connDAO= new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();

	public   JSONArray searchmode() throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql="select modename ,doc_no from cr_mode where  status=3 ";
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	 public   JSONArray searchsubmode(String modeid) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	    	 
	     
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql="SELECT  submode submode1,doc_no FROM cr_smode where status=3 and modeid='"+modeid+"'";
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public   JSONArray searchterm(String modeid) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	    	 
	     
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql="SELECT  terms term,doc_no FROM cr_terms where status=3 and modeid='"+modeid+"'";
					System.out.println("====clsql===="+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	   
	 public   JSONArray searchshipment() throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	    	 
	     
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql="select shipment shipment1 ,doc_no from cr_shipment where  status=3 ";
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
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
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();  
		        	String pySql=("select m.modename mode,d.modeid,sm.submode,d.smodeid,sh.shipment,"
		        			+ " d.shipid,d.shipid shipmentid,d.termsid termid,t.terms,d.modeid,origin orgin,pol,pod,commodity comodity,"
		        			+ " wight weight,noofpacks,dimension,volume,remarks,qty"
		        			+ " from cr_enqd d left join cr_mode m on m.doc_no=d.modeid "
		        			+ " left join cr_smode sm on sm.doc_no=d.smodeid "
		        			+ " left join cr_shipment sh on sh.doc_no=d.shipid "
		        			+ " left join cr_terms t on t.doc_no=d.termsid where rdocno='"+nidoc+"'");
	 System.out.println("===gridsql= "+pySql);
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);

					RESULTDATA=commonDAO.convertToJSON(resultSet); 
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
	 
	   
	 public   JSONArray searchClient(HttpSession session,String clname,String mob,String load) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	   	 if(!(load.equalsIgnoreCase("yes")))
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
	   	        
	    	    	
	   	 String brid=session.getAttribute("BRANCHID").toString();
	    	
	    	
	    	    	
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and per_mob like '%"+mob+"%'";
	    	}
	    	
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }

	public int insert(Date enquirydate,  String cmbclient,
			HttpSession session, String mode, String formdetailcode,
			HttpServletRequest request, ArrayList<String> masterarray,String txtRemarks) throws SQLException {
		// TODO Auto-generated method stub
		
		try
		{
			int docno;
			
			 conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call cr_CargoenquiryDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtpurorder.registerOutParameter(8, java.sql.Types.INTEGER);

			stmtpurorder.setDate(1,enquirydate); 
			
			stmtpurorder.setString(2,cmbclient);
			stmtpurorder.setString(3,txtRemarks);
			 
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
			
			for(int i=0;i< masterarray.size();i++){
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 
//			    	   String unitids=""+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"";
//					    String prsros=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"";
//					     
//				    	 
//				         
//					     double fr=1;
//					     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
//					     
//					     System.out.println("====slss==="+slss);
//					     ResultSet rv1=stmtpurorder.executeQuery(slss);
//					     if(rv1.next())
//					     {
//					    	 fr=rv1.getDouble("fr"); 
//					     }	
   	 
			   /* 	                           0                        1                   2                        3
			    	   newTextBox.val(rows[i].modeid+" :: "+rows[i].smodeid+" :: "+rows[i].shipmentid+" :: "+rows[i].termid+" ::"
			    	   		+ ""     4                         5              6                    7                     8                      
			    	   		+ " "+rows[i].orgin+" :: "+rows[i].pol+" :: "+rows[i].pod+" :: "+rows[i].commodity+" :: "+rows[i].weight+" ::"
			    	   				+ ""                9                     10                   11                      12                   13
			    	   				+ " "+rows[i].noofpacks+" :: "+rows[i].dimension+" :: "+rows[i].volume+" :: "+rows[i].remarks+" :: "+rows[i].qty+" :: ");
			   		
			    	 */
		     String sql="INSERT INTO cr_enqd(rdocno, modeid, smodeid, shipid, termsid, origin, pol, pod, commodity, wight, noofpacks, dimension, volume, remarks, qty)VALUES"
				       + " ("+(docno)+","
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
				       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"' )";
				      
		     
		       System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			
			if(docno>0){
				conn.commit();
				conn.close();
				return docno;
			}
		}
	catch(Exception e)
	{
		conn.close();
		e.printStackTrace();
	}
		
		
		return 0;
	}

	public int update(int masterdoc_no, Date enquirydate,String cmbclient,
			String txtRemarks, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request,ArrayList<String> masterarray) throws SQLException {
		// TODO Auto-generated method stub
		try{
			int docno;
		
			 conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call cr_CargoenquiryDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.setInt(7, masterdoc_no);
			stmtpurorder.setInt(8, 0);
 
			stmtpurorder.setDate(1,enquirydate); 
			
			stmtpurorder.setString(2,cmbclient);
 
			stmtpurorder.setString(3,txtRemarks);
			 
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
			
			for(int i=0;i< masterarray.size();i++){
				if(i==0){
					String delsqls="delete from cr_enqd where rdocno='"+masterdoc_no+"' ";
					stmtpurorder.executeUpdate(delsqls);
					
				}
		    	
			     String[] detmasterarrays=masterarray.get(i).split("::");
			   //  System.out.println("-----prdId---"+detmasterarrays[1]);
			     
			     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("null")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			     {
			    	 
			    	 String sql="INSERT INTO cr_enqd(rdocno, modeid, smodeid, shipid, termsid, origin, pol, pod, commodity, wight, noofpacks, dimension, volume, remarks, qty)VALUES"
						       + " ("+(docno)+","
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
						       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"' )";
						      
			    	 System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
				     }
			
			if(docno>0){
				conn.commit();
				conn.close();
				return docno;
			}
		}
	catch(Exception e)
	{
		conn.close();
		e.printStackTrace();
		
	}
		
		return 0;
	}

	public int delete(int masterdoc_no, HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		try{
			int docno;
		
			 conn=connDAO.getMyConnection();
	 
			CallableStatement stmtpurorder= conn.prepareCall("{call cr_CargoenquiryDML(?,?,?,?,?,?,?,?,?,?)}");
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
	
	
	  public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype) throws SQLException {


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
		    
		    	
		    	//enqdate.trim();
		    	if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = commonDAO.changeStringtoSqlDate(enqdate);
		    	}
		    	
		    	
		    		    	
		    	String sqltest="";
		    	if(!(msdocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		    	}
		    	if(!(clnames.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and a.refname like '%"+clnames+"%'";
		    	}
		    	if(!(mobno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and a.per_mob like '%"+mobno+"%'";
		    	}
		    	
		    	 
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		    	} 
		        
		    	
		    	 	    	
		    	 Connection conn = null;
		 
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
		            	
						String clssql= ("select m.date, m.doc_no,m.voc_no,m.cldocno,a.refname name,trim(a.address) com_add1,a.per_mob mob,trim(a.mail1) email,m.remarks "
								+ "  from cr_enqm m left join my_acbook a "
								+ "on a.cldocno=m.cldocno and a.dtype='CRM' where m.status=3 and m.brhid='"+brid+"' " +sqltest);
						System.out.println("========"+clssql);
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtenq1.close();
						conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }

	public ClscargoEnquiryBean getViewDetails(int docno, HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		ClscargoEnquiryBean showBean = new ClscargoEnquiryBean();
		Connection conn=null;
		try { conn = connDAO.getMyConnection();
		Statement stmt  = conn.createStatement ();
		
		
		String sqls="select m.date,m.doc_no,m.voc_no,m.cldocno,a.refname,"
				+ "trim(a.address) address,a.per_mob,trim(a.mail1) "
				+ "mail1,m.remarks from cr_enqm m "
				+ "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' WHERE M.DOC_NO="+docno ;
		
		System.out.println("======sqls===="+sqls);
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		while (resultSet.next()) {
			
			showBean.setDocno(resultSet.getInt("voc_no"));
			showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
			showBean.setTxtRemarks(resultSet.getString("remarks"));
			showBean.setHidEnquiryDate(resultSet.getString("date"));
			
			 
			showBean.setTxtaddress(resultSet.getString("address"));
			
			showBean.setTxtmobile(resultSet.getString("per_mob"));

			showBean.setCmbclient(resultSet.getString("cldocno"));
			
			showBean.setTxtclientname(resultSet.getString("refname"));
			
			
			
			
			
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

	    
}
