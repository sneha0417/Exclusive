package com.project.execution.serviceReport;

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

public class ClsServiceReportDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsServiceReportBean serviceReportBean = new ClsServiceReportBean();
	
		public int insert(Date serviceReportsDate, String formdetailcode, String txtrefno, int txtcustomerdocno, int txtcustomeracno, String cmbcontracttype, String txtcontracttrno, 
			String txtsiteid, String txtareaid, int txtscheduleno, double txtcompletionperc, double txttobeinvoicednettotal, ArrayList<String> activityarray, ArrayList<String> tobeinvoicedarray, 
			HttpSession session, HttpServletRequest request, String mode,int chkrect,String txtrect) throws SQLException {
		
		  	Connection conn = null;
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtSRVE = conn.prepareCall("{CALL serviceReportmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtSRVE.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtSRVE.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtSRVE.setInt(18,chkrect);
			stmtSRVE.setString(19,txtrect);
			
			stmtSRVE.setDate(1,serviceReportsDate);
			stmtSRVE.setString(2,txtrefno);
			stmtSRVE.setInt(3,txtcustomerdocno);
			stmtSRVE.setInt(4,txtcustomeracno);
			stmtSRVE.setString(5,cmbcontracttype);
			stmtSRVE.setString(6,txtcontracttrno);
			stmtSRVE.setString(7,txtsiteid);
			stmtSRVE.setInt(8,txtscheduleno);
			stmtSRVE.setDouble(9,txtcompletionperc);
			stmtSRVE.setDouble(10,txttobeinvoicednettotal);
			stmtSRVE.setString(11,formdetailcode);
			stmtSRVE.setString(12,company);
			stmtSRVE.setString(13,branch);
			stmtSRVE.setString(14,userid);
			stmtSRVE.setString(17,mode);
			int datas=stmtSRVE.executeUpdate();
			if(datas<=0){
				stmtSRVE.close();
				conn.close();
				return 0;
			}
			int docno=stmtSRVE.getInt("docNo");
			int trno=stmtSRVE.getInt("itranNo");
			request.setAttribute("tranno", trno);
			serviceReportBean.setTxtservicereportdocno(docno);
			if (docno > 0) {
				System.out.println("inside insertion");
				/*Insertion to cm_srvactiond,cm_srvspares*/
				int insertData=insertion(conn, trno, formdetailcode, activityarray, tobeinvoicedarray, session, mode);
				if(insertData<=0){
					stmtSRVE.close();
					conn.close();
					return 0;
				}
				/*Insertion to cm_srvactiond,cm_srvspares Ends*/
					
					conn.commit();
					stmtSRVE.close();
					conn.close();
					return docno;
			}
			
			stmtSRVE.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}
		 	   
		public boolean edit(int txtservicereportdocno, String formdetailcode, int txtservicereporttrno, Date serviceReportsDate, String txtrefno, int txtcustomerdocno, int txtcustomeracno, 
				String cmbcontracttype, String txtcontracttrno, String txtsiteid, String txtareaid, int txtscheduleno, double txtcompletionperc, double txttobeinvoicednettotal, 
				ArrayList<String> activityarray, ArrayList<String> tobeinvoicedarray, HttpSession session, HttpServletRequest request, String mode,int chkrect,String txtrect) throws SQLException {
			
		       Connection conn = null;
		 	
		 try {
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtSRVE1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				int trno = txtservicereporttrno;
				
				/*Updating cm_srvdetm*/
				CallableStatement stmtSRVE = conn.prepareCall("{CALL serviceReportmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtSRVE.setInt(15,txtservicereportdocno);
				stmtSRVE.setInt(16,txtservicereporttrno);
				stmtSRVE.setInt(18,chkrect);
				stmtSRVE.setString(19,txtrect);
				stmtSRVE.setDate(1,serviceReportsDate);
				stmtSRVE.setString(2,txtrefno);
				stmtSRVE.setInt(3,txtcustomerdocno);
				stmtSRVE.setInt(4,txtcustomeracno);
				stmtSRVE.setString(5,cmbcontracttype);
				stmtSRVE.setString(6,txtcontracttrno);
				stmtSRVE.setString(7,txtsiteid);
				stmtSRVE.setInt(8,txtscheduleno);
				stmtSRVE.setDouble(9,txtcompletionperc);
				stmtSRVE.setDouble(10,txttobeinvoicednettotal);
				stmtSRVE.setString(11,formdetailcode);
				stmtSRVE.setString(12,company);
				stmtSRVE.setString(13,branch);
				stmtSRVE.setString(14,userid);
				stmtSRVE.setString(17,mode);
				int datas=stmtSRVE.executeUpdate();
				if(datas<=0){
					stmtSRVE.close();
					conn.close();
					return false;
				}
				/*Updating cm_srvdetm Ends*/
			    
			    String sql=("DELETE FROM cm_srvactiond WHERE tr_no="+trno);
			    int data = stmtSRVE1.executeUpdate(sql);
			    
			    String sql1=("DELETE FROM cm_srvspares WHERE tr_no="+trno);
			    int data1 = stmtSRVE1.executeUpdate(sql1);
			    
			    int docno=txtservicereportdocno;
			    serviceReportBean.setTxtservicereportdocno(docno);
				if (docno > 0) {
				
					/*Insertion to cm_srvactiond,cm_srvspares*/
					int insertData=insertion(conn, trno, formdetailcode, activityarray, tobeinvoicedarray, session, mode);
					if(insertData<=0){
						stmtSRVE.close();
						conn.close();
						return false;
					}
					/*Insertion to cm_srvactiond,cm_srvspares Ends*/
					
						conn.commit();
						stmtSRVE.close();
						stmtSRVE1.close();
						conn.close();
						return true;
				}
				stmtSRVE.close();
			    conn.close();
		 } catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
			return false;
	}

	public boolean delete(int txtservicereportdocno, String formdetailcode, int txtservicereporttrno, HttpSession session, String mode) throws SQLException {
		  
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				CallableStatement stmtSRVE = conn.prepareCall("{CALL serviceReportmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtSRVE.setInt(15,txtservicereportdocno);
				stmtSRVE.setInt(16,txtservicereporttrno);
				
				stmtSRVE.setDate(1,null);
				stmtSRVE.setString(2,null);
				stmtSRVE.setInt(3,0);
				stmtSRVE.setInt(4,0);
				stmtSRVE.setString(5,null);
				stmtSRVE.setString(6,null);
				stmtSRVE.setString(7,null);
				stmtSRVE.setInt(8,0);
				stmtSRVE.setDouble(9,0);
				stmtSRVE.setDouble(10,0);
				stmtSRVE.setString(11,formdetailcode);
				stmtSRVE.setString(12,company);
				stmtSRVE.setString(13,branch);
				stmtSRVE.setString(14,userid);
				stmtSRVE.setString(17,mode);
				int datas=stmtSRVE.executeUpdate();
				if(datas<=0){
					stmtSRVE.close();
					conn.close();
					return false;
				}
				 
				int docno=txtservicereportdocno;
				serviceReportBean.setTxtservicereportdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtSRVE.close();
				    conn.close();
					return true;
				}	
				stmtSRVE.close();
			    conn.close();
		 } catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 } finally{
			 conn.close();
		 }
			return false;
	    }
	
	public JSONArray serviceActivityGridReLoading(String trno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtSRVE = conn.createStatement();
			    
				String sql = "select m.servId sertypeid, m.actvId activityid, m.description, m.Equips item, m.qty numbers,cs.groupname stype,cm.groupname activity from cm_srvactiond m left join "
						   + "my_groupvals cs on (m.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm on (m.actvid=cm.doc_no and cm.grptype='serviceactivity') where m.tr_no="+trno+"";
				
				System.out.println("==serviceActivityGridReLoading"+sql);
				
				
				ResultSet resultSet = stmtSRVE.executeQuery(sql);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
					
			    stmtSRVE.close();
			    conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray serviceActivityGridEditReLoading(String trno,String contractno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtSRVE = conn.createStatement();
			    
				String sql = "select a.sertypeid, CONVERT(a.activityid,CHAR(50)) activityid, a.description, a.item, CONVERT(a.numbers,CHAR(50)) numbers, a.stype,CONVERT(a.activity,CHAR(50)) activity from ( "
						   + "select m.servId sertypeid, m.actvId activityid, m.description, m.Equips item, m.qty numbers,cs.groupname stype,cm.groupname activity from cm_srvactiond m left join my_groupvals cs "
						   + "on (m.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm on (m.actvid=cm.doc_no and cm.grptype='serviceactivity') where m.tr_no="+trno+" UNION ALL select doc_no sertypeid,"
						   + "'' activityid,d.description desc1,Equips item,''  numbers,groupname stype,'' activity from cm_srvcontrd d left join my_groupvals g on (d.servid=g.doc_no and grptype='service') where "
						   + "tr_no="+contractno+") a group by a.sertypeid,a.item";
				
			System.out.println("=======edit=="+sql);
				
				ResultSet resultSet = stmtSRVE.executeQuery(sql);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
					
			    stmtSRVE.close();
			    conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray toBeInvoicedGridReloading(String trno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = connDAO.getMyConnection();
				Statement stmtSRVE = conn.createStatement();
				
        		String sql = "select m.Description desc1,m.qty,round(m.costPrice,2) amount,round(m.total,2) total,if(m.chg>0,true,false) invoiced,m.prdId prodoc,m.UNITID unitdocno,m.psrno,m.SpecNo specid,p.part_no productid,"
        			       + "p.part_no proid,p.productname,p.productname proname,u.unit from cm_srvspares m left join my_main p on m.prdId=p.doc_no left join my_unitm u on m.UNITID=u.doc_no where m.tr_no="+trno+"";
				
				System.out.println("to invoice grid"+sql);
        		ResultSet resultSet = stmtSRVE.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				
				stmtSRVE.close();
			conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray customerDetailsSearch(String clientid, String clientname, String contactno,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtSRVE = conn.createStatement();
	
		       if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		        if(!(clientid.equalsIgnoreCase("0")) && !(clientid.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and codeno like '%"+clientid+"%'";
			    }
		        
		        if(!(clientname.equalsIgnoreCase("0")) && !(clientname.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and refname like '%"+clientname+"%'";
			    }
		        
		        if(!(contactno.equalsIgnoreCase("0")) && !(contactno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and per_mob like '%"+contactno+"%'";
		        }
		        
		        sql="select doc_no,codeno,refname name,address,per_mob mobile,com_mob tele,mail1 mail,acno from my_acbook where active=1 and dtype='CRM' and status=3"+sqltest;
		        
		       ResultSet resultSet = stmtSRVE.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtSRVE.close();
		       conn.close();
		       }
		     stmtSRVE.close();
		     conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	  }
	
	public JSONArray contractDetailsSearch(HttpSession session,String contracttype,String scheduleno,String contractno,String site,String cldocno,String branch,String search) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtSRVE = conn.createStatement();
	
		       if(search.equalsIgnoreCase("yes")) {
		    	   
		        String sql="";String sqltest="";
	    	   	 
	    	   	if(contracttype.equalsIgnoreCase("AMC") || contracttype.equalsIgnoreCase("SJOB")) {
	    	   		
	    	   		if(!(scheduleno.equalsIgnoreCase("0")) && !(scheduleno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and s.tr_no='"+scheduleno+"'";
			        }
		    	   	
		    		if(!(contractno.equalsIgnoreCase("0")) && !(contractno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and c.doc_no='"+contractno+"'";
			        }
		    	   	
			        if(!(site.equalsIgnoreCase("0")) && !(site.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and st.site like '%"+site+"%'";
				    }
			        
	    	   		sql = "select s.tr_no scheduleno,c.tr_no contracttrno,c.doc_no contractdocno,c.refno contractdetails,c.dtype contracttype,st.site,st.rowno siteid,st.areaid,g.groupname area "
	    	   			+ "from cm_servplan s left join cm_srvcontrm c on s.doc_no=c.tr_no left join cm_srvcsited st on st.tr_no=c.tr_no and s.siteid=st.rowno left join my_groupvals g on "
	    	   			+ "g.doc_no=st.areaid and g.grptype='area' where c.status=3 and s.status=4 and s.brhid="+branch+" and s.dtype='"+contracttype+"' and s.cldocno="+cldocno+""+sqltest+"";
	    	   		
	    	   	}
	    	   	
	    	   	if(contracttype.equalsIgnoreCase("CREG")) {
	    	   		
	    	   		if(!(scheduleno.equalsIgnoreCase("0")) && !(scheduleno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and sp.tr_no='"+scheduleno+"'";
			        }
		    	   	
		    		if(!(contractno.equalsIgnoreCase("0")) && !(contractno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and sc.doc_no='"+contractno+"'";
			        }
		    	   	
			        if(!(site.equalsIgnoreCase("0")) && !(site.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and s.site like '%"+site+"%'";
				    }
			        
	    	   		sql = "select sp.tr_no scheduleno,m.tr_no contracttrno,sc.doc_no contractdocno,sc.refno contractdetails,m.contracttype,s.site,s.rowno siteid,s.areaid,g.groupname area from "
	    	   			+ "cm_cuscallm m left join cm_servplan sp on m.tr_no=sp.doc_no left join cm_srvcontrm sc on m.contractno=sc.tr_no left join cm_srvcsited s on s.rowno=m.siteid left join "
	    	   			+ "my_groupvals g on g.doc_no=s.areaid and g.grptype='area' where sc.status=3 and sp.status=4 and sp.brhid="+branch+" and sp.dtype='"+contracttype+"' and sp.cldocno="+cldocno+""+sqltest+"";
		         }
	    	   	 
	    	   	System.out.println("===CREG==sql===="+sql);
	    	   	
		       ResultSet resultSet = stmtSRVE.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtSRVE.close();
		       conn.close();
		       }
		     stmtSRVE.close();
		     conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	  }
	
	public JSONArray serviceActivityGridLoading(String contractno,String dtype,String serdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        String sql="";
        try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
				String sqltest="";
				
				
				
				if(!(dtype.equalsIgnoreCase("CREG"))){
					
					 if(!(serdocno.equalsIgnoreCase("") || serdocno.equalsIgnoreCase("0"))){
				         sqltest=sqltest+" and g.doc_no="+serdocno+"";
				        }
					
					 sql="select groupname stype,doc_no sertypeid, d.description desc1, Equips item, qty, Amount, total from cm_srvcontrd d left join my_groupvals g on "
		        				+ "(d.servid=g.doc_no and grptype='service') where tr_no="+contractno+" "+sqltest+"";
				}
				if((dtype.equalsIgnoreCase("CREG"))){
					
					 if(!(serdocno.equalsIgnoreCase("") || serdocno.equalsIgnoreCase("0"))){
				         sqltest=sqltest+" and cs.doc_no="+serdocno+"";
				        }
					
					 sql="select c.description desc1,c.cmplid complaintid,c.servid sertypeid,CONVERT(COALESCE(c.equips,''),CHAR(100)) item,cs.groupname stype, "
					 		+ "cm.groupname complaint from cm_cuscalld c left join my_groupvals cs on (c.servid=cs.doc_no and cs.grptype='service') "
					 		+ "left join my_groupvals cm on (c.cmplid=cm.doc_no and cm.grptype='complaints') where c.tr_no="+contractno+" "+sqltest+"";
				}
				
        		
				
        		System.out.println("==serviceActivityGridLoading===="+sql);
        		
				ResultSet resultSet = stmtCREG.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				
				stmtCREG.close();
			conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray activityGridSearchLoading(String activity, String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
			    
				if(check.equalsIgnoreCase("1")){
					String sqltest="";
					
					if(!(activity.equalsIgnoreCase("0")) && !(activity.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and groupname like '%"+activity+"%'";
				    }
					
					String sql="select groupname activity,doc_no docno from my_groupvals where grptype='serviceactivity'"+sqltest+"";
					
					ResultSet resultSet = stmtCREG.executeQuery(sql);
	                
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCREG.close();
					conn.close();
				}
			 stmtCREG.close();
			 conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	
	public JSONArray brandSearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=commonDAO.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	 public JSONArray searchProduct(String prdname,String gridprdname,String gridunit,String category,String subcategory,String brandname,String id) throws SQLException {

		  JSONArray RESULTDATA=new JSONArray();
		  if(!id.equalsIgnoreCase("1")){
			  return RESULTDATA;
		  }

		  Connection conn = null;

		  try {
		   conn = connDAO.getMyConnection();
		   Statement stmt = conn.createStatement (); 
		   String sql="",condtn="";
		   
		   if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn ="  and m.part_no like '%"+prdname+"%' ";
			}
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and bd.brandname like '%"+brandname+"%' ";
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

		    sql="select c.category,sc.subcategory,bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno from my_main m left join my_brand bd on m.brandid=bd.doc_no left join my_unitm u on m.munit=u.doc_no "
		      + "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no  where m.status=3  "+condtn+" "
		      + "group by m.psrno  order by m.psrno ";
            System.out.println("sql============"+sql);
		   ResultSet resultSet = stmt.executeQuery (sql);
		   RESULTDATA=commonDAO.convertToJSON(resultSet);

		   stmt.close();
		   conn.close();

		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  }
		  return RESULTDATA;
		 }
	/* public   JSONArray searchProduct(HttpSession session,String acno,String cmbbilltype,String dates,String clientid,String date,
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
					 conn = connDAO.getMyConnection();
					Statement stmtVeh = conn.createStatement (); 
		     	
					int method=0;
	           String condtn="";
					
					if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
						condtn ="  and m.part_no like '%"+prdname+"%' ";
					}
					
					if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
						condtn +="  and bd.brandname like '%"+brandname+"%' ";
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
					
				    int method1=0;
					String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
					ResultSet rs1=stmtVeh.executeQuery(chk1); 
					if(rs1.next())
						{
									
						method1=rs1.getInt("method");
						}


					String sqlstest="";
								
				    if(method1>0)
					{
					  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
					}
				
				    
				    

					int tax=0;
					Statement stmt3 = conn.createStatement (); 
				 
					String chk31="select method  from gl_prdconfig where field_nme='tax' ";
					ResultSet rss3=stmt3.executeQuery(chk31); 
					if(rss3.next())
					{

						tax=rss3.getInt("method");
					}
					
					int temptax=0;
					Statement stmt3111 = conn.createStatement (); 
					String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
				 // System.out.println("===sqlss======"+sqlss);
					ResultSet rsss=stmt3111.executeQuery(sqlss);
				    if(rsss.next())
				    {
				    	temptax=rsss.getInt("tax");
				    	
				    }
					if(temptax!=1)
					{
						tax=0;
					}
					String joinsql="";
					
					String fsql="";
					
					String outfsql="";
					
					
					if(tax>0)
					{
						
						java.sql.Date masterdate = null;
						if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
				     	{
							masterdate=commonDAO.changeStringtoSqlDate(dates);
				     		
				     	}
				     	else{
				     
				     	}
					
						
						if(Integer.parseInt(cmbbilltype)>0)
						{
							
							
							
							Statement pv=conn.createStatement();
							int prvdocno=0;
							String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
							ResultSet rs13=pv.executeQuery(dd); 
							if(rs13.next())
							{

								prvdocno=rs13.getInt("prvdocno");
							}
							
							
						joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
						
						outfsql=outfsql+ " taxper , ";
						
						joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
								+ " t1.typeid=m.typeid   ";
					
						
						fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
						
						outfsql=outfsql+ " taxper ,taxdocno, ";
						
						}
						
					}
					int superseding=0;
					String chk11="select method  from gl_prdconfig where field_nme='superseding'";
					ResultSet rs11=stmtVeh.executeQuery(chk11); 
					if(rs11.next())
					{
						
						superseding=rs11.getInt("method");
					}
						
					if(superseding==1)
					{
						String sql=" select s.part_no,m.* from (  select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
								+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
								+ "   left join my_desc de on(de.psrno=m.doc_no)  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
								+ "   where m.status=3 "+condtn+" and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
							    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

						System.out.println("-----sql-ASD--"+sql);
			 
						ResultSet resultSet = stmtVeh.executeQuery (sql);
							RESULTDATA=commonDAO.convertToJSON(resultSet);
							stmtVeh.close();
					}
					
					else
					{    // left join my_desc de on(de.psrno=m.doc_no) and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'
						String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
								+ " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
								+ "      left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
								+ "   where m.status=3 "+condtn+"  "	;
						System.out.println("-----sql-ASD--"+sql);
			 
						ResultSet resultSet = stmtVeh.executeQuery (sql);
							RESULTDATA=commonDAO.convertToJSON(resultSet);
							stmtVeh.close();	
						
					}
			
					
				String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
						+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
						+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
						+ "   where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;
		 
					conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
		 return RESULTDATA;
		}*/
	
	public JSONArray srveMainSearch(HttpSession session, String clientsname, String docNo, String date, String contractstype, String contractsno, String scheduleno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
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
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtSRVE = conn.createStatement();
	       
	       java.sql.Date sqlCallRegisterDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlCallRegisterDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        
	        if(!(sqlCallRegisterDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlCallRegisterDate+"'";
		    } 
	        
	        if(!(clientsname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and c.refname like '%"+clientsname+"%'";
	        }
	        
	        if(!(contractstype.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.ref_type='"+contractstype+"'";
	        }
	        
	        if(!(contractsno.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and cm.doc_no like '%"+contractsno+"%'";
		    }
	        
	        if(!(scheduleno.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.schrefdocno like '%"+scheduleno+"%'";
		    }
	       String sql= "select s.site,m.chkrect,m.rect,m.tr_no,m.date,m.doc_no,m.schrefdocno scheduleno,c.refname client,m.ref_type contracttype,cm.doc_no contractno from cm_srvdetm m left join cm_srvcontrm cm on cm.tr_no=m.costid and cm.dtype=m.ref_type  left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join cm_srvcsited s on m.siteId=s.rowno "  
		       		+ "where m.status<>7 and m.dtype='SRVE' and m.brhid="+branch+"" +sqltest ;
	      
	       System.out.println("===="+sql);
	       ResultSet resultSet = stmtSRVE.executeQuery(sql);
	      
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtSRVE.close();
	       conn.close();
     } catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     } finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public ClsServiceReportBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsServiceReportBean serviceReportBean = new ClsServiceReportBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtSRVE = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtSRVE.executeQuery ("select m.chkrect,m.rect,m.tr_no,m.date,m.refno,m.cldocno customerdocno,m.acno customeracno,c.refname customer,c.address customerdetails,m.ref_type contracttype,m.costid contracttrno,sc.doc_no contractvocno,"
					+ "sc.refno contractdetails,m.siteid,st.site,st.areaid,g.groupname area,m.schrefdocno scheduleno,m.wrkper,round(m.netamount,2) netamount from cm_srvdetm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join cm_srvcontrm sc "
					+ "on sc.tr_no=m.costid left join cm_srvcsited st on m.siteid=st.rowno left join my_groupvals g on g.doc_no=st.areaid and g.grptype='area' where m.status=3 and m.dtype='SRVE' and m.brhid="+branch+" and m.doc_no="+docNo+"");
             System.out.println("view Grid"+"select m.chkrect,m.rect,m.tr_no,m.date,m.refno,m.cldocno customerdocno,m.acno customeracno,c.refname customer,c.address customerdetails,m.ref_type contracttype,m.costid contracttrno,sc.doc_no contractvocno,"
					+ "sc.refno contractdetails,m.siteid,st.site,st.areaid,g.groupname area,m.schrefdocno scheduleno,m.wrkper,round(m.netamount,2) netamount from cm_srvdetm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join cm_srvcontrm sc "
					+ "on sc.tr_no=m.costid left join cm_srvcsited st on m.siteid=st.rowno left join my_groupvals g on g.doc_no=st.areaid and g.grptype='area' where m.status=3 and m.dtype='SRVE' and m.brhid="+branch+" and m.doc_no="+docNo+"");
			while (resultSet.next()) {
					serviceReportBean.setTxtservicereportdocno(docNo);
					serviceReportBean.setTxtservicereporttrno(resultSet.getInt("tr_no"));
					serviceReportBean.setServiceReportDate(resultSet.getDate("date").toString());
					serviceReportBean.setTxtrefno(resultSet.getString("refno"));
					serviceReportBean.setTxtcustomer(resultSet.getString("customer"));
					serviceReportBean.setTxtcustomerdocno(resultSet.getInt("customerdocno"));
					serviceReportBean.setTxtcustomeracno(resultSet.getInt("customeracno"));
					serviceReportBean.setTxtcustomerdetails(resultSet.getString("customerdetails"));
					serviceReportBean.setHidcmbcontracttype(resultSet.getString("contracttype"));
					serviceReportBean.setTxtcontractno(resultSet.getString("contractvocno"));
					serviceReportBean.setTxtcontracttrno(resultSet.getString("contracttrno"));
					serviceReportBean.setTxtcontractdetails(resultSet.getString("contractdetails"));
					serviceReportBean.setTxtsitename(resultSet.getString("site"));
					serviceReportBean.setTxtsiteid(resultSet.getString("siteid"));
					serviceReportBean.setTxtareaname(resultSet.getString("area"));
					serviceReportBean.setTxtareaid(resultSet.getString("areaid"));
					serviceReportBean.setTxtscheduleno(resultSet.getInt("scheduleno"));
					serviceReportBean.setTxtcompletionperc(resultSet.getDouble("wrkper"));
					serviceReportBean.setTxttobeinvoicednettotal(resultSet.getDouble("netamount"));
					serviceReportBean.setChkrect(resultSet.getInt("chkrect"));
					serviceReportBean.setTextrect(resultSet.getString("rect"));
					
		    }
		  stmtSRVE.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return serviceReportBean;
		}
	 
	 public ClsServiceReportBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsServiceReportBean bean = new ClsServiceReportBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtSRVE = conn.createStatement();
			
			stmtSRVE.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	   public int insertion(Connection conn, int trno, String formdetailcode, ArrayList<String> activityarray, ArrayList<String> tobeinvoicedarray, HttpSession session, String mode) throws SQLException {
		     
		  try{
				CallableStatement stmtSRVE1=null;
				
				/*Activity Grid and Details Saving*/
				for(int i=0;i< activityarray.size();i++){
					System.out.println("inside insertion 1111");
					String[] activity=activityarray.get(i).split("::");
					if(!activity[2].trim().equalsIgnoreCase("undefined") && !activity[2].trim().equalsIgnoreCase("NaN")){
						System.out.println("inside insertion 2222");
						stmtSRVE1 = conn.prepareCall("INSERT INTO cm_srvactiond(servId,Equips,qty,actvId,description,sr_no,tr_no) VALUES(?,?,?,?,?,?,?)");
						
						stmtSRVE1.setString(1,(activity[0].trim().equalsIgnoreCase("undefined") || activity[0].trim().equalsIgnoreCase("NaN") || activity[0].trim().equalsIgnoreCase("") ||activity[0].trim().isEmpty()?"0":activity[0].trim()).toString()); //service Id
						stmtSRVE1.setString(2,(activity[1].trim().equalsIgnoreCase("undefined") || activity[1].trim().equalsIgnoreCase("NaN") || activity[1].trim().equalsIgnoreCase("") ||activity[1].trim().isEmpty()?"":activity[1].trim()).toString()); //item
						stmtSRVE1.setString(3,(activity[2].trim().equalsIgnoreCase("undefined") || activity[2].trim().equalsIgnoreCase("NaN") || activity[2].trim().equalsIgnoreCase("") ||activity[2].trim().isEmpty()?"0":activity[2].trim()).toString()); //nos
						stmtSRVE1.setString(4,(activity[3].trim().equalsIgnoreCase("undefined") || activity[3].trim().equalsIgnoreCase("NaN") || activity[3].trim().equalsIgnoreCase("") ||activity[3].trim().isEmpty()?"0":activity[3].trim()).toString()); //activity Id
						stmtSRVE1.setString(5,(activity[4].trim().equalsIgnoreCase("undefined") || activity[4].trim().equalsIgnoreCase("NaN") || activity[4].trim().equalsIgnoreCase("") ||activity[4].trim().isEmpty()?"0":activity[4].trim()).toString()); //description
						stmtSRVE1.setInt(6,(i+1)); //sr_no
						stmtSRVE1.setInt(7,trno); //tr_no
						int detail=stmtSRVE1.executeUpdate();
						if(detail<=0){
							stmtSRVE1.close();
							conn.close();
							return 0;
						}
						
      				  }
				    }
				    /*Activity Grid and Details Saving Ends*/
				
					/*To Be Invoiced Grid and Details Saving*/
					for(int j=0;j< tobeinvoicedarray.size();j++){
						String[] tobeinvoiced=tobeinvoicedarray.get(j).split("::");
						if(!tobeinvoiced[6].trim().equalsIgnoreCase("undefined") && !tobeinvoiced[6].trim().equalsIgnoreCase("NaN")){
							String invoiced = "0";
							
							if(tobeinvoiced[8].trim().equalsIgnoreCase("true")){
								invoiced="1";
							}
							else if(tobeinvoiced[8].trim().equalsIgnoreCase("false")){
								invoiced="0";
							}
							
							stmtSRVE1 = conn.prepareCall("INSERT INTO cm_srvspares(Description,prdId,psrno,UNITID,SpecNo,qty,fr,costPrice,total,chg,SR_NO,tr_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
							
							stmtSRVE1.setString(1,(tobeinvoiced[0].trim().equalsIgnoreCase("undefined") || tobeinvoiced[0].trim().equalsIgnoreCase("NaN") || tobeinvoiced[0].trim().equalsIgnoreCase("") ||tobeinvoiced[0].trim().isEmpty()?"0":tobeinvoiced[0].trim()).toString()); //description
							stmtSRVE1.setString(2,(tobeinvoiced[1].trim().equalsIgnoreCase("undefined") || tobeinvoiced[1].trim().equalsIgnoreCase("NaN") || tobeinvoiced[1].trim().equalsIgnoreCase("") ||tobeinvoiced[1].trim().isEmpty()?"0":tobeinvoiced[1].trim()).toString()); //Product Id
							stmtSRVE1.setString(3,(tobeinvoiced[2].trim().equalsIgnoreCase("undefined") || tobeinvoiced[2].trim().equalsIgnoreCase("NaN") || tobeinvoiced[2].trim().equalsIgnoreCase("") ||tobeinvoiced[2].trim().isEmpty()?"0":tobeinvoiced[2].trim()).toString()); //Product Srno
							stmtSRVE1.setString(4,(tobeinvoiced[3].trim().equalsIgnoreCase("undefined") || tobeinvoiced[3].trim().equalsIgnoreCase("NaN") || tobeinvoiced[3].trim().equalsIgnoreCase("") ||tobeinvoiced[3].trim().isEmpty()?"0":tobeinvoiced[3].trim()).toString()); //Unit Id
							stmtSRVE1.setString(5,(tobeinvoiced[4].trim().equalsIgnoreCase("undefined") || tobeinvoiced[4].trim().equalsIgnoreCase("NaN") || tobeinvoiced[4].trim().equalsIgnoreCase("") ||tobeinvoiced[4].trim().isEmpty()?"0":tobeinvoiced[4].trim()).toString()); //Spec Id
							stmtSRVE1.setString(6,(tobeinvoiced[5].trim().equalsIgnoreCase("undefined") || tobeinvoiced[5].trim().equalsIgnoreCase("NaN") || tobeinvoiced[5].trim().equalsIgnoreCase("") ||tobeinvoiced[5].trim().isEmpty()?"0":tobeinvoiced[5].trim()).toString()); //Quantity
							stmtSRVE1.setInt(7,1); //fr
							stmtSRVE1.setString(8,(tobeinvoiced[6].trim().equalsIgnoreCase("undefined") || tobeinvoiced[6].trim().equalsIgnoreCase("NaN") || tobeinvoiced[6].trim().equalsIgnoreCase("") ||tobeinvoiced[6].trim().isEmpty()?"0":tobeinvoiced[6].trim()).toString()); //Amount
							stmtSRVE1.setString(9,(tobeinvoiced[7].trim().equalsIgnoreCase("undefined") || tobeinvoiced[7].trim().equalsIgnoreCase("NaN") || tobeinvoiced[7].trim().equalsIgnoreCase("") ||tobeinvoiced[7].trim().isEmpty()?"0":tobeinvoiced[7].trim()).toString()); //Quantity
							stmtSRVE1.setString(10,invoiced); //Invoiced
							stmtSRVE1.setInt(11,(j+1)); //sr_no
							stmtSRVE1.setInt(12,trno); //tr_no
							int detail1=stmtSRVE1.executeUpdate();
							if(detail1<=0){
								stmtSRVE1.close();
								conn.close();
								return 0;
							}
							
	      				  }
					    }
					    /*To Be Invoiced Grid and Details Saving Ends*/
			    
				
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

public JSONArray workstat(String trno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	           
	      
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtSRVE = conn.createStatement();

		       String sql= "select mu.user_name,sr.date,sr.wrkper from cm_srvreportstatus sr "
		       		+ "left join my_user mu on mu.doc_no=sr.userid where sr.rtrno="+trno+" ";
		       ResultSet resultSet = stmtSRVE.executeQuery(sql);
		      
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtSRVE.close();
		       conn.close();
	     } catch(Exception e){
	    	 e.printStackTrace();
	    	 conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	   }


public JSONArray serviceTypeSearch(String contractno, String servicesdetails, String itemsdetails, String check ,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
				String sql="";
				if(check.equalsIgnoreCase("1")){
				
				String sqltest="";
				
				if(!(servicesdetails.equalsIgnoreCase("0")) && !(servicesdetails.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and groupname like '%"+servicesdetails+"%'";
			    }
		        
		        if(!(itemsdetails.equalsIgnoreCase("0")) && !(itemsdetails.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and equips like '%"+itemsdetails+"%'";
			    }
		        if((dtype.equalsIgnoreCase("CREG"))){
					
					
					 sql="select c.servid doc_no,CONVERT(COALESCE(c.equips,''),CHAR(100)) item,g.groupname  from cm_cuscalld c "
					 		+ "left join my_groupvals g on (c.servid=g.doc_no and g.grptype='service')  "
					 		+ "where c.tr_no="+contractno+" "+sqltest+"";
				}   
		        else{
        		sql="select groupname,doc_no, CONVERT(coalesce(equips,''),CHAR(100)) item from cm_srvcontrd d left join my_groupvals g on "
        				+ "(d.servid=g.doc_no and grptype='service') where tr_no="+contractno+""+sqltest+"";
				
		        }
        		
        		System.out.println("serviceType=="+sql);
        		
				ResultSet resultSet = stmtCREG.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				}
				
				stmtCREG.close();
			conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	

}
