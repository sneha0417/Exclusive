package com.aviation.fuelinginformation;

	
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

import com.cargo.enquiry.ClscargoEnquiryBean;
import com.common.ClsCommon;
import com.connection.ClsConnection;
	




import net.sf.json.JSONArray;

	public class ClsfuelingInformationDAO {

		Connection conn;
			
		ClsConnection connDAO= new ClsConnection();
		ClsCommon commonDAO= new ClsCommon();

		
		 public   JSONArray maingridreload(String nidoc) throws SQLException {
			 
				JSONArray RESULTDATA=new JSONArray();
			    
			    
			    Connection conn = null;
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtVeh1 = conn.createStatement (); 
						String pySql=("select a.date,p.port,a.portid,m.ProductName product,m.psrno productid,p.desc1 portname,a.AC_TYPE ac_type,a.acraft_no aircraftno,a.fleet_no flightno,a.unit unitid,u.unit,a.qty,a.operator,"
										+ "a.eta,a.etd,a.TZONE timezone,a.remarks,a.parking,a.invoiced,a.delstat "
										+ "from av_fueld a left join my_port p on p.doc_no=a.portid"
										+" left join my_main m on m.doc_no=a.psrno"
										+" left join my_unitm u on u.doc_no=a.unit where rdocno='"+nidoc+"'");
						
						
//			        	
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
		 
		   
		 public   JSONArray searchClient(HttpSession session,String clname,String mob,String load,String dtypes) throws SQLException {


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
		            	
						String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='"+dtypes+"'  " +sqltest);
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
		 public   JSONArray searchProduct() throws SQLException {


		   	 JSONArray RESULTDATA=new JSONArray();
		   	 
		    	Connection conn = null;
		    
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	
						String clsql= ("select doc_no,part_no,ProductName product from my_main where status=3");
						
						System.out.println("========"+clsql);
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
		 public   JSONArray searchUnit() throws SQLException {


		   	 JSONArray RESULTDATA=new JSONArray();
		   	 
		    	Connection conn = null;
		    
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	
						String clsql= ("select doc_no,unit,unit_desc from my_unitm where status=3");
						
						System.out.println("========"+clsql);
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
		 public   JSONArray searchPort() throws SQLException {


		   	 JSONArray RESULTDATA=new JSONArray();
		   	 
		    	Connection conn = null;
		    
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	
						String clsql= ("select port,desc1 portnam,country region,doc_no from my_port where status=3");
						
						System.out.println("========"+clsql);
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
		 public int insert(Date fuelInfoDate,  String cmbclient,String vendor,
					HttpSession session, String mode, String formdetailcode,
					HttpServletRequest request, ArrayList<String> masterarray,String txtnotes) throws SQLException {
				// TODO Auto-generated method stub
				
				try
				{
					int docno;
					
					 conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtpurorder= conn.prepareCall("{call cr_AviationfuelinginfoDML(?,?,?,?,?,?,?,?,?,?)}");
					stmtpurorder.registerOutParameter(6, java.sql.Types.INTEGER);
					stmtpurorder.registerOutParameter(7, java.sql.Types.INTEGER);

					stmtpurorder.setDate(1,fuelInfoDate); 
					
					stmtpurorder.setString(2,cmbclient);
					stmtpurorder.setString(3,txtnotes);
					 
					stmtpurorder.setString(4,session.getAttribute("USERID").toString());
					stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
					//stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
				//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
					stmtpurorder.setString(8,formdetailcode);
					stmtpurorder.setString(9,mode);
					stmtpurorder.setString(10,vendor);
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
					    	 
					    	 
					     String sql="INSERT INTO av_fueld(sr_no, rdocno, date, portid, psrno, ac_type, acraft_no, fleet_no, unit, qty, operator, eta, etd, tzone, remarks,parking)VALUES"
							       + " ("+(i+1)+","+(docno)+","
							     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?null:commonDAO.changeStringtoSqlDate(detmasterarrays[0].trim()))+"',"
							       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
							       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
							       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
							       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
							       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
							       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
							       + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
							       + "'"+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?"00:00":detmasterarrays[9].trim())+"',"
							       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?"00:00":detmasterarrays[10].trim())+"',"
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

			public int update(int masterdoc_no,Date fuelInfoDate,String cmbclient,String vendor,
					String txtnotes, HttpSession session, String mode,
					String formdetailcode, HttpServletRequest request,ArrayList<String> masterarray) throws SQLException {
				// TODO Auto-generated method stub
				try{
					int docno;
				
					 conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtpurorder= conn.prepareCall("{call cr_AviationfuelinginfoDML(?,?,?,?,?,?,?,?,?,?)}");
					stmtpurorder.setInt(6, masterdoc_no);
					stmtpurorder.setInt(7, 0);
		 
					stmtpurorder.setDate(1,fuelInfoDate); 
					
					stmtpurorder.setString(2,cmbclient);
		 
					stmtpurorder.setString(3,txtnotes);
					 
					stmtpurorder.setString(4,session.getAttribute("USERID").toString());
					stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
					//stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
				//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
					stmtpurorder.setString(8,formdetailcode);
					stmtpurorder.setString(9,mode);
					stmtpurorder.setString(10,vendor);
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
							String delsqls="delete from av_fueld where rdocno='"+masterdoc_no+"' ";
							stmtpurorder.executeUpdate(delsqls);
							
						}
				    	
					     String[] detmasterarrays=masterarray.get(i).split("::");
					   //  System.out.println("-----prdId---"+detmasterarrays[1]);
					     
					     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("null")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
					     {
					    	 
					    	 String sql="INSERT INTO av_fueld(sr_no, rdocno, date, portid, psrno, ac_type, acraft_no, fleet_no, unit, qty, operator, eta, etd, tzone, remarks,parking,invoiced,delstat)VALUES"
								       + " ("+(i+1)+","+(docno)+","
								     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?null:commonDAO.changeStringtoSqlDate(detmasterarrays[0].trim()))+"',"
								       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
								       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
								       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
								       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
								       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
								       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
								       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
								       + "'"+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")||detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"',"
								       + "'"+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")||detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?"00:00":detmasterarrays[9].trim())+"',"
								       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?"00:00":detmasterarrays[10].trim())+"',"
								       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
								       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
								       + "'"+(detmasterarrays[13].trim().equalsIgnoreCase("undefined") || detmasterarrays[13].trim().equalsIgnoreCase("NaN")||detmasterarrays[13].trim().equalsIgnoreCase("")|| detmasterarrays[13].isEmpty()?0:detmasterarrays[13].trim())+"',"
								       + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"' ,"
					    	 		   + "'"+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"' )";
				               
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
			 
					CallableStatement stmtpurorder= conn.prepareCall("{call cr_AviationfuelinginfoDML(?,?,?,?,?,?,?,?,?,?)}");
					stmtpurorder.setInt(6, masterdoc_no);
					stmtpurorder.setInt(7, 0);
		 
					stmtpurorder.setDate(1,null); 
					
					stmtpurorder.setString(2,null);
		 
					stmtpurorder.setString(3,null);
					 
					stmtpurorder.setString(4,session.getAttribute("USERID").toString());
					stmtpurorder.setString(5,session.getAttribute("BRANCHID").toString());
					//stmtpurorder.setString(6,session.getAttribute("COMPANYID").toString());
				//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
					stmtpurorder.setString(8,formdetailcode);
					stmtpurorder.setString(9,mode);
					stmtpurorder.setString(10,null);
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
		    
			public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype,String dtypes) throws SQLException {


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
			            	
							String clssql= ("select m.date, m.doc_no,m.voc_no,m.cldocno,a.refname name,trim(a.address) com_add1,a.per_mob mob,vnd.refname vendor,m.notes "
									+ "  from av_fuelm m left join my_acbook a "
									+ "on a.cldocno=m.cldocno and a.dtype='CRM' left join my_acbook vnd on vnd.cldocno=m.cldocno and vnd.dtype='VND' where m.status=3 and m.brhid='"+brid+"' " +sqltest);
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

		 public ClsfuelingInformationBean getViewDetails(int docno, HttpSession session) throws SQLException {
				// TODO Auto-generated method stub
			 ClsfuelingInformationBean showBean = new ClsfuelingInformationBean();
				Connection conn=null;
				try { conn = connDAO.getMyConnection();
				Statement stmt  = conn.createStatement ();
				
				
				String sqls="select m.date,m.doc_no,m.voc_no,m.cldocno,a.refname client,m.vndid,vnd.refname vendor,m.notes from av_fuelm m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' "
						+ "left join my_acbook vnd on vnd.cldocno=m.vndid and vnd.dtype='VND' WHERE M.DOC_NO="+docno ;
				
				System.out.println("======sqls===="+sqls);
				
				ResultSet resultSet = stmt.executeQuery(sqls);
				while (resultSet.next()) {
					
					showBean.setDocno(resultSet.getInt("voc_no"));
					showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
					showBean.setTxtnotes(resultSet.getString("notes"));
					showBean.setHidFuelInfoDate(resultSet.getString("date"));
					
					 
					
					showBean.setVendor(resultSet.getString("vndid"));
					
					showBean.setTxtvendorname(resultSet.getString("vendor"));
					
					showBean.setCmbclient(resultSet.getString("cldocno"));
					
					showBean.setTxtclientname(resultSet.getString("client"));
					
					
					
					
					
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
				
				public ClsfuelingInformationBean getPrint(int doc)  throws SQLException {
					ClsfuelingInformationBean bean = new ClsfuelingInformationBean();
					  Connection conn = null;
					try {
							 conn = connDAO.getMyConnection();

							 
							Statement stmtprint = conn.createStatement ();
				       	
							String sqls="select date_format(m.date,'%d-%m-%Y') date,m.doc_no,m.voc_no,m.cldocno,a.refname client,m.vndid,vnd.fax1 fax,vnd.per_mob mobno,vnd.address,vnd.refname vendor,m.notes from av_fuelm m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' "
									+ "left join my_acbook vnd on vnd.cldocno=m.vndid and vnd.dtype='VND' WHERE M.DOC_NO="+doc ;
							
							//System.out.println("yswftcywefwt"+sqls);
							ResultSet pintrs = stmtprint.executeQuery(sqls);
						       while(pintrs.next()){
						    	bean.setLblclientname(pintrs.getString("client"));
						    	bean.setLblvendorname(pintrs.getString("vendor"));
						    	bean.setLblnotes(pintrs.getString("notes"));
						    	bean.setLbladdress(pintrs.getString("address"));
						    	bean.setLblmobno(pintrs.getString("mobno"));
						    	bean.setLblfuelinfodate(pintrs.getString("date"));
						    	bean.setLbldocno(pintrs.getString("doc_no"));
						    	bean.setLblfax(pintrs.getString("fax"));
						    	bean.setLblcldocno(pintrs.getString("cldocno"));
						       }
							conn.close();
							
					}
					catch(Exception e){
						conn.close();
						e.printStackTrace();
					}
					return bean;
					

				
				
				
			}


	
	}

