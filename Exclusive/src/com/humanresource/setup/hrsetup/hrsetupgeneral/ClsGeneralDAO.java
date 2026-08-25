package com.humanresource.setup.hrsetup.hrsetupgeneral;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 

public class ClsGeneralDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(Date masterdate, Date fromdate, Date lastdate,int cmbcategory, String workingtime, int leaveid, int carryforward, double eligibledays, 
			double forworkingdays,String convformula, String normalrate, String ot, String holidayot,String mode, String formdetailcode, String woff,
			HttpSession session, HttpServletRequest request,ArrayList<String> beniarray, ArrayList<String> termiarray, ArrayList<String> resiarray, 
			ArrayList<String> accsetuparray)  throws SQLException {
		 
		Connection conn=null;

			try{
				    conn=ClsConnection.getMyConnection();
	                conn.setAutoCommit(false);
				    CallableStatement sethrsetup = conn.prepareCall("{CALL HR_hrsetupDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
				    sethrsetup.registerOutParameter(19, java.sql.Types.INTEGER);
	              
					sethrsetup.setDate(1,masterdate);
					sethrsetup.setDate(2,fromdate);
					sethrsetup.setDate(3,lastdate);
					
					sethrsetup.setInt(4,cmbcategory);
					sethrsetup.setString(5,workingtime);
					sethrsetup.setInt(6,leaveid);
					
					sethrsetup.setInt(7,carryforward);
					sethrsetup.setDouble(8,eligibledays);
					sethrsetup.setDouble(9,forworkingdays);
					
					sethrsetup.setString(10,convformula);
					sethrsetup.setString(11,normalrate);
					sethrsetup.setString(12,ot);
					sethrsetup.setString(13,holidayot);
					sethrsetup.setString(14,woff);
					sethrsetup.setString(15,mode);
					  
					sethrsetup.setString(16,session.getAttribute("USERID").toString().trim());
					sethrsetup.setString(17,session.getAttribute("BRANCHID").toString().trim());
					sethrsetup.setString(18,formdetailcode);

					
					sethrsetup.executeQuery();
					int	 docno=sethrsetup.getInt("docNo");
					
					if(docno<=0) {
						conn.close();
						return 0;
					}	     
			
			for(int i=0;i< beniarray.size();i++){
				 
			     String[] beniarraysec=beniarray.get(i).split("::");
			     
			     if(!(beniarraysec[0].trim().equalsIgnoreCase("undefined")|| beniarraysec[0].trim().equalsIgnoreCase("NaN")||beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty())) {
			    	 
			    	String sql="INSERT INTO hr_payeos(sr_no, alwid, rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(beniarraysec[0].trim().equalsIgnoreCase("undefined") || beniarraysec[0].trim().equalsIgnoreCase("NaN")|| beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()?0:beniarraysec[0].trim())+"',"
				       +"'"+docno+"')";

				     int resultSet2 = sethrsetup.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			     }
			
			}
			
			     for(int j=0;j< termiarray.size();j++){
				    	
				     String[] termiarraysec=termiarray.get(j).split("::");
				     if(!(termiarraysec[0].trim().equalsIgnoreCase("undefined")|| termiarraysec[0].trim().equalsIgnoreCase("NaN")||termiarraysec[0].trim().equalsIgnoreCase("")|| termiarraysec[0].isEmpty())) {
				    	 
			     String sql="INSERT INTO hr_payeost(sr_no,years,days,rdocno)VALUES"
					       + " ("+(j+1)+","
					       + "'"+(termiarraysec[0].trim().equalsIgnoreCase("undefined") || termiarraysec[0].trim().equalsIgnoreCase("NaN")|| termiarraysec[0].trim().equalsIgnoreCase("")|| termiarraysec[0].isEmpty()?0:termiarraysec[0].trim())+"',"
					        + "'"+(termiarraysec[1].trim().equalsIgnoreCase("undefined") || termiarraysec[1].trim().equalsIgnoreCase("NaN")|| termiarraysec[1].trim().equalsIgnoreCase("")|| termiarraysec[1].isEmpty()?0:termiarraysec[1].trim())+"',"
					       +"'"+docno+"')";

					     int resultSet2 = sethrsetup.executeUpdate(sql);
					     if(resultSet2<=0) {
								conn.close();
								return 0;
							}
				     }
			     }
				
				     for(int k=0;k< resiarray.size();k++){
					    	
					     String[] resiarraysec=resiarray.get(k).split("::");
					     if(!(resiarraysec[0].trim().equalsIgnoreCase("undefined")|| resiarraysec[0].trim().equalsIgnoreCase("NaN")||resiarraysec[0].trim().equalsIgnoreCase("")|| resiarraysec[0].isEmpty()))
					     {
					    	 
				     String sql="INSERT INTO hr_payeosr(sr_no,years,days,rdocno)VALUES"
						       + " ("+(k+1)+","
						       + "'"+(resiarraysec[0].trim().equalsIgnoreCase("undefined") || resiarraysec[0].trim().equalsIgnoreCase("NaN")|| resiarraysec[0].trim().equalsIgnoreCase("")|| resiarraysec[0].isEmpty()?0:resiarraysec[0].trim())+"',"
						        + "'"+(resiarraysec[1].trim().equalsIgnoreCase("undefined") || resiarraysec[1].trim().equalsIgnoreCase("NaN")|| resiarraysec[1].trim().equalsIgnoreCase("")|| resiarraysec[1].isEmpty()?0:resiarraysec[1].trim())+"',"
						        +"'"+docno+"')";
				   
						     int resultSet2 = sethrsetup.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
					     }
				     }
				     for(int l=0;l< accsetuparray.size();l++){
					    	
					     String[] accsetuparraysec=accsetuparray.get(l).split("::");
					     if(!(accsetuparraysec[0].trim().equalsIgnoreCase("undefined")|| accsetuparraysec[0].trim().equalsIgnoreCase("NaN")||accsetuparraysec[0].trim().equalsIgnoreCase("")|| accsetuparraysec[0].isEmpty()))
					     {
					    	 
				     String sql="INSERT INTO hr_paycodeac(sr_no,alwid,acno,costtype,costcode,rdocno)VALUES"
						       + " ("+(l+1)+","
						       + "'"+(accsetuparraysec[0].trim().equalsIgnoreCase("undefined") || accsetuparraysec[0].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[0].trim().equalsIgnoreCase("")|| accsetuparraysec[0].isEmpty()?0:accsetuparraysec[0].trim())+"',"
						       + "'"+(accsetuparraysec[1].trim().equalsIgnoreCase("undefined") || accsetuparraysec[1].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[1].trim().equalsIgnoreCase("")|| accsetuparraysec[1].isEmpty()?0:accsetuparraysec[1].trim())+"',"
						       + "'"+(accsetuparraysec[2].trim().equalsIgnoreCase("undefined") || accsetuparraysec[2].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[2].trim().equalsIgnoreCase("")|| accsetuparraysec[2].isEmpty()?0:accsetuparraysec[2].trim())+"',"
						       + "'"+(accsetuparraysec[3].trim().equalsIgnoreCase("undefined") || accsetuparraysec[3].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[3].trim().equalsIgnoreCase("")|| accsetuparraysec[3].isEmpty()?0:accsetuparraysec[3].trim())+"',"
						        +"'"+docno+"')";
				 
						     int resultSet2 = sethrsetup.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
					     }
				     }
						
					
			
			
					
			if (docno > 0) {
				conn.commit();
				sethrsetup.close();
				conn.close();
	          return docno;
			}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

  

	public int update(int docno, Date masterdate, Date fromdate, Date lastdate, int cmbcategory, String workingtime, int leaveid, int carryforward, double eligibledays, 
			double forworkingdays, String convformula,String normalrate, String ot, String holidayot, String mode, String formdetailcode, String woff, HttpSession session,
			HttpServletRequest request, ArrayList<String> beniarray,ArrayList<String> termiarray, ArrayList<String> resiarray,ArrayList<String> accsetuparray) throws SQLException {
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				CallableStatement sethrsetup = conn.prepareCall("{CALL HR_hrsetupDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
			    sethrsetup.setInt(19, docno);
              
				sethrsetup.setDate(1,masterdate);
				sethrsetup.setDate(2,fromdate);
				sethrsetup.setDate(3,lastdate);
				
				sethrsetup.setInt(4,cmbcategory);
				sethrsetup.setString(5,workingtime);
				sethrsetup.setInt(6,leaveid);
				
				sethrsetup.setInt(7,carryforward);
				sethrsetup.setDouble(8,eligibledays);
				sethrsetup.setDouble(9,forworkingdays);
				
				sethrsetup.setString(10,convformula);
				sethrsetup.setString(11,normalrate);
				sethrsetup.setString(12,ot);
				sethrsetup.setString(13,holidayot);
				sethrsetup.setString(14,woff);
				sethrsetup.setString(15,mode);
				  
				sethrsetup.setString(16,session.getAttribute("USERID").toString().trim());
				sethrsetup.setString(17,session.getAttribute("BRANCHID").toString().trim());
				sethrsetup.setString(18,formdetailcode);
 				
				int result=	sethrsetup.executeUpdate();
				
			    docno=sethrsetup.getInt("docNo");
					
			    if(result<=0) {
			    	conn.close();
			    	return 0;
			    }	   	  
			
			  String delsql1="Delete from hr_paycodeac where rdocno="+docno+"  ";
			  sethrsetup.executeUpdate(delsql1);
			   
			   
			   String delsql2="Delete from hr_payeosr where rdocno="+docno+"  ";
			   sethrsetup.executeUpdate(delsql2);
			   
			   
			   String delsql3="Delete from hr_payeost where rdocno="+docno+"  ";
			   sethrsetup.executeUpdate(delsql3);
			   
			   String delsql4="Delete from hr_payeos where rdocno="+docno+"  ";
			   sethrsetup.executeUpdate(delsql4);
			
			   for(int i=0;i< beniarray.size();i++){
				
			     String[] beniarraysec=beniarray.get(i).split("::");
			     
			     if(!(beniarraysec[0].trim().equalsIgnoreCase("undefined")|| beniarraysec[0].trim().equalsIgnoreCase("NaN")||beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO hr_payeos(sr_no, alwid, rdocno)VALUES" 
				       + " ("+(i+1)+","
				       + "'"+(beniarraysec[0].trim().equalsIgnoreCase("undefined") || beniarraysec[0].trim().equalsIgnoreCase("NaN")|| beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()?0:beniarraysec[0].trim())+"',"
				       +"'"+docno+"')";
		    
				     int resultSet2 = sethrsetup.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			     }
			}
			
			     for(int j=0;j< termiarray.size();j++){
				    	
				     String[] termiarraysec=termiarray.get(j).split("::");
				     if(!(termiarraysec[0].trim().equalsIgnoreCase("undefined")|| termiarraysec[0].trim().equalsIgnoreCase("NaN")||termiarraysec[0].trim().equalsIgnoreCase("")|| termiarraysec[0].isEmpty()))
				     {
				    	 
			     String sql="INSERT INTO hr_payeost(sr_no,years,days,rdocno)VALUES" 
					       + " ("+(j+1)+","
					       + "'"+(termiarraysec[0].trim().equalsIgnoreCase("undefined") || termiarraysec[0].trim().equalsIgnoreCase("NaN")|| termiarraysec[0].trim().equalsIgnoreCase("")|| termiarraysec[0].isEmpty()?0:termiarraysec[0].trim())+"',"
					        + "'"+(termiarraysec[1].trim().equalsIgnoreCase("undefined") || termiarraysec[1].trim().equalsIgnoreCase("NaN")|| termiarraysec[1].trim().equalsIgnoreCase("")|| termiarraysec[1].isEmpty()?0:termiarraysec[1].trim())+"',"
					       +"'"+docno+"')";

					     int resultSet2 = sethrsetup.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}
				     }
			     }
				
				     for(int k=0;k< resiarray.size();k++){
					    	
					     String[] resiarraysec=resiarray.get(k).split("::");
					     if(!(resiarraysec[0].trim().equalsIgnoreCase("undefined")|| resiarraysec[0].trim().equalsIgnoreCase("NaN")||resiarraysec[0].trim().equalsIgnoreCase("")|| resiarraysec[0].isEmpty()))
					     {
					    	 
				     String sql="INSERT INTO hr_payeosr(sr_no,years,days,rdocno)VALUES"     
						       + " ("+(k+1)+","
						       + "'"+(resiarraysec[0].trim().equalsIgnoreCase("undefined") || resiarraysec[0].trim().equalsIgnoreCase("NaN")|| resiarraysec[0].trim().equalsIgnoreCase("")|| resiarraysec[0].isEmpty()?0:resiarraysec[0].trim())+"',"
						        + "'"+(resiarraysec[1].trim().equalsIgnoreCase("undefined") || resiarraysec[1].trim().equalsIgnoreCase("NaN")|| resiarraysec[1].trim().equalsIgnoreCase("")|| resiarraysec[1].isEmpty()?0:resiarraysec[1].trim())+"',"
						        +"'"+docno+"')";

						     int resultSet2 = sethrsetup.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
					     }
				     }
				     for(int l=0;l< accsetuparray.size();l++){
					    	
					     String[] accsetuparraysec=accsetuparray.get(l).split("::");
					     if(!(accsetuparraysec[0].trim().equalsIgnoreCase("undefined")|| accsetuparraysec[0].trim().equalsIgnoreCase("NaN")||accsetuparraysec[0].trim().equalsIgnoreCase("")|| accsetuparraysec[0].isEmpty()))
					     {
					    	 
				     String sql="INSERT INTO hr_paycodeac(sr_no,alwid,acno,costtype,costcode,rdocno)VALUES"
						       + " ("+(l+1)+","
						       + "'"+(accsetuparraysec[0].trim().equalsIgnoreCase("undefined") || accsetuparraysec[0].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[0].trim().equalsIgnoreCase("")|| accsetuparraysec[0].isEmpty()?0:accsetuparraysec[0].trim())+"',"
						       + "'"+(accsetuparraysec[1].trim().equalsIgnoreCase("undefined") || accsetuparraysec[1].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[1].trim().equalsIgnoreCase("")|| accsetuparraysec[1].isEmpty()?0:accsetuparraysec[1].trim())+"',"
						       + "'"+(accsetuparraysec[2].trim().equalsIgnoreCase("undefined") || accsetuparraysec[2].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[2].trim().equalsIgnoreCase("")|| accsetuparraysec[2].isEmpty()?0:accsetuparraysec[2].trim())+"',"
						       + "'"+(accsetuparraysec[3].trim().equalsIgnoreCase("undefined") || accsetuparraysec[3].trim().equalsIgnoreCase("NaN")|| accsetuparraysec[3].trim().equalsIgnoreCase("")|| accsetuparraysec[3].isEmpty()?0:accsetuparraysec[3].trim())+"',"
						       + "'"+docno+"')";

						     int resultSet2 = sethrsetup.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
					     }
				     }
					
			if (docno > 0) {
				conn.commit(); 
				sethrsetup.close();
				conn.close();
	          return docno;
			}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
	return 0;
	}

	public int delete(int docno, String mode, String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException {
		
		Connection conn=null;
		
		try{
			
			    conn=ClsConnection.getMyConnection();
			    CallableStatement sethrsetup = conn.prepareCall("{CALL HR_hrsetupDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
			    sethrsetup.setInt(19, docno);
              
				sethrsetup.setDate(1,null);
				sethrsetup.setDate(2,null);
				sethrsetup.setDate(3,null);
				
				sethrsetup.setInt(4,0);
				sethrsetup.setString(5,null);
				sethrsetup.setInt(6,0);
				
				sethrsetup.setInt(7,0);
				sethrsetup.setDouble(8,0);
				sethrsetup.setDouble(9,0);
				
				sethrsetup.setString(10,null);
				sethrsetup.setString(11,null);
				sethrsetup.setString(12,null);
				sethrsetup.setString(13,null);
				sethrsetup.setString(14,null);
				sethrsetup.setString(15,mode);
				  
				sethrsetup.setString(16,session.getAttribute("USERID").toString().trim());
				sethrsetup.setString(17,session.getAttribute("BRANCHID").toString().trim());
				sethrsetup.setString(18,formdetailcode);

				int result=	sethrsetup.executeUpdate();
				
			    docno=sethrsetup.getInt("docNo");
					
			    if(result<=0) {
			    	conn.close();
			    	return 0;
			    }	     
			
			    if (docno > 0) {
			    	sethrsetup.close();
					conn.close();
					return docno;
			    }		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

		public JSONArray searchacsetupreload(String docno) throws SQLException {
		    	JSONArray RESULTDATA=new JSONArray();

			    Connection conn=null;
		  
				try {
						conn = ClsConnection.getMyConnection();
						Statement stmt  = conn.createStatement (); 
						
						String  sql=("select ac.alwid allowanceid,a.desc1 'allowance',convert(coalesce(h.account,''),char(50)) account,ac.acno,convert(coalesce(h.gr_type,''),char(50)) grtype,ac.costtype,ac.costcode,f.costgroup "
								+ "from hr_paycodeac ac left join hr_setallowance a on ac.alwid=a.doc_no left join my_head h on h.doc_no=ac.acno left join my_costunit f on ac.costtype=f.costtype where rdocno='"+docno+"'");
						
						ResultSet resultSet = stmt.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmt.close();
						conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
		        return RESULTDATA;
		    }
	
	 public JSONArray searchresiorelode(String docno) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();

		    Connection conn=null;
	  
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmt  = conn.createStatement (); 
	 
					String  sql=("select years,days,years hidyears from hr_payeosr where rdocno='"+docno+"'  ");
					
					ResultSet resultSet = stmt.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

					stmt.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	 public JSONArray searchtermorelode(String docno) throws SQLException {
	    	JSONArray RESULTDATA=new JSONArray();

		    Connection conn=null;
	  
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmt  = conn.createStatement (); 
	 
					String  sql=("select years,days,years hidyears from hr_payeost where rdocno='"+docno+"'  ");
					
					ResultSet resultSet = stmt.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

					stmt.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	    public JSONArray mastersearch() throws SQLException {
	    	JSONArray RESULTDATA=new JSONArray();

		    Connection conn=null;
	  
			try {
					conn = ClsConnection.getMyConnection(); 
					Statement stmtVeh5 = conn.createStatement ();
	            	
					String  sql=("select m.doc_no,m.date,m.valfrmdate,m.revdate,c.desc1 cat,l.desc1 leavdesc from hr_paycode m  left join hr_setpaycat c on m.catid=c.doc_no \r\n" + 
							" left join hr_setleave l on l.doc_no=m.annual_id where m.status=3;");
					
					ResultSet resultSet = stmtVeh5.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

					stmtVeh5.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }

	    public JSONArray searchbenirelodeEdit(String docno) throws SQLException {
	    	JSONArray RESULTDATA=new JSONArray();
		    
	    	Connection conn=null;
	  
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmt  = conn.createStatement (); 
	            					
					String sql="select * from ( select CONVERT(e.alwid,CHAR(50))  allowanceid,a.desc1 allowance, '1' ckecked from hr_payeos e left join hr_setallowance a "  
							+ "on  e.alwid=a.doc_no where e.rdocno='"+docno+"' union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'0' ckecked  from hr_setallowance "
							+ "where status=3) a group by a.allowanceid order by ckecked desc";
					
					ResultSet resultSet = stmt.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

					stmt.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
	
    public JSONArray searchbenirelode(String docno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement (); 
 
				String  sql=("select e.alwid allowanceid,a.desc1 allowance,'1' ckecked  from hr_payeos e left join hr_setallowance a on e.alwid=a.doc_no where rdocno='"+docno+"'");
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
    public JSONArray searchAllowance() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

    	Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement (); 
				
				String sql="select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance from hr_setallowance where status=3 and doc_no>=0";
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	
    public JSONArray searchAccountAllowance() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement ();  
				
				String sql="select convert(a.doc_no,char(50)) allowanceid,a.desc1 allowance,convert(h.account,char(50)) account ,convert(a.acno,char(50)) acno,convert(h.gr_type,char(50)) grtype "
						+ "from hr_setallowance a left join my_head h on h.doc_no=a.acno  where a.status=3";
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	public  ClsGeneralBean getViewDetails(int docno) throws SQLException {
		ClsGeneralBean showBean = new ClsGeneralBean();
		
		Connection conn=null;
		
		try { 
			   conn = ClsConnection.getMyConnection();
			   Statement stmt  = conn.createStatement ();
		
		       String sqls="select date,  valfrmdate, revdate, catId, whrs, woff, annual_id, cf, aelg, awdays, dailyRate, nRate, OTRate, HOTRate from hr_paycode where doc_no='"+docno+"' ";
		
		       ResultSet resultSet = stmt.executeQuery(sqls);
 
			   while (resultSet.next()) {
				
					showBean.setHidmasterdate(resultSet.getString("date"));
					showBean.setValidfromdate(resultSet.getString("valfrmdate"));
					showBean.setLastreviseddate(resultSet.getString("revdate"));
					showBean.setHidcatval(resultSet.getInt("catId"));
					 
					showBean.setHidworkingtime(resultSet.getString("whrs"));
					 
					showBean.setEligibledays(resultSet.getDouble("aelg"));
					showBean.setHidleaveid(resultSet.getInt("annual_id"));
					showBean.setForworkingdays(resultSet.getDouble("awdays"));
					 
					showBean.setConvformula(resultSet.getString("dailyRate"));
					showBean.setNormalrate(resultSet.getString("nRate")); 
					showBean.setOt(resultSet.getString("OTRate")); 
					showBean.setHolidayot(resultSet.getString("HOTRate"));
					 
					showBean.setHidcarryforward(resultSet.getInt("cf"));
					showBean.setHidweakoff(resultSet.getString("woff"));
					
				}
		
			   stmt.close();
			   conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
			}
			return showBean;
		}

}
