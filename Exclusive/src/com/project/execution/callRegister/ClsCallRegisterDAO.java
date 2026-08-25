package com.project.execution.callRegister;

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

public class ClsCallRegisterDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsCallRegisterBean callRegisterBean = new ClsCallRegisterBean();
	
	    public int insert(Date callRegistersDate, String formdetailcode, String txtrefno, int txtclientdocno, String txtcontactperson, String txtcontactpersontele, String txtcontactpersonmob,
			String txtcontactpersonmail, Date contractDate, String contractTime, String cmbcontracttype, String txtcontracttrno, String txtsiteid, String txtdescription, ArrayList<String> complaintsarray, 
			HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		  	Connection conn = null;
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtCREG = conn.prepareCall("{CALL callRegistermDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCREG.registerOutParameter(18, java.sql.Types.INTEGER);
			stmtCREG.registerOutParameter(19, java.sql.Types.INTEGER);
			
			stmtCREG.setDate(1,callRegistersDate);
			stmtCREG.setString(2,txtrefno);
			stmtCREG.setString(3,txtdescription);
			stmtCREG.setInt(4,txtclientdocno);
			stmtCREG.setString(5,txtcontactperson);
			stmtCREG.setString(6,txtcontactpersontele);
			stmtCREG.setString(7,txtcontactpersonmob);
			stmtCREG.setString(8,txtcontactpersonmail);
			stmtCREG.setDate(9,contractDate);
			stmtCREG.setString(10,contractTime);
			stmtCREG.setString(11,cmbcontracttype);
			stmtCREG.setString(12,txtcontracttrno);
			stmtCREG.setInt(13,Integer.parseInt(txtsiteid));
			stmtCREG.setString(14,formdetailcode);
			stmtCREG.setString(15,company);
			stmtCREG.setString(16,branch);
			stmtCREG.setString(17,userid);
			stmtCREG.setString(20,mode);
			int datas=stmtCREG.executeUpdate();
			if(datas<=0){
				stmtCREG.close();
				conn.close();
				return 0;
			}
			int docno=stmtCREG.getInt("docNo");
			int trno=stmtCREG.getInt("itranNo");
			request.setAttribute("tranno", trno);
			callRegisterBean.setTxtcallregisterdocno(docno);
			if (docno > 0) {
				
				/*Insertion to cm_cuscalld,cm_servplan*/
				int insertData=insertion(conn, docno, trno, formdetailcode, callRegistersDate, txtrefno, txtdescription, txtclientdocno, txtsiteid, complaintsarray, session, mode);
				if(insertData<=0){
					stmtCREG.close();
					conn.close();
					return 0;
				}
				/*Insertion to cm_cuscalld,cm_servplan Ends*/
					
					conn.commit();
					stmtCREG.close();
					conn.close();
					return docno;
			}
			
			stmtCREG.close();
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
			
	  public boolean edit(int txtcallregisterdocno, String formdetailcode, Date callRegistersDate, String txtrefno, int txtcallregistertrno, int txtclientdocno, String txtcontactperson, String txtcontactpersontele,
				String txtcontactpersonmob, String txtcontactpersonmail, Date contractDate, String contractTime, String cmbcontracttype, String txtcontracttrno, String txtsiteid, String txtdescription, 
				ArrayList<String> complaintsarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		 	   
		       Connection conn = null;
		 	
		 try {
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtCREG1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				int trno = txtcallregistertrno;
				
				/*Updating cm_cuscallm*/
				CallableStatement stmtCREG = conn.prepareCall("{CALL callRegistermDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtCREG.setInt(18,txtcallregisterdocno);
				stmtCREG.setInt(19,trno);
				
				stmtCREG.setDate(1,callRegistersDate);
				stmtCREG.setString(2,txtrefno);
				stmtCREG.setString(3,txtdescription);
				stmtCREG.setInt(4,txtclientdocno);
				stmtCREG.setString(5,txtcontactperson);
				stmtCREG.setString(6,txtcontactpersontele);
				stmtCREG.setString(7,txtcontactpersonmob);
				stmtCREG.setString(8,txtcontactpersonmail);
				stmtCREG.setDate(9,contractDate);
				stmtCREG.setString(10,contractTime);
				stmtCREG.setString(11,cmbcontracttype);
				stmtCREG.setString(12,txtcontracttrno);
				stmtCREG.setInt(13,Integer.parseInt(txtsiteid));
				stmtCREG.setString(14,formdetailcode);
				stmtCREG.setString(15,company);
				stmtCREG.setString(16,branch);
				stmtCREG.setString(17,userid);
				stmtCREG.setString(20,mode);
				int datas=stmtCREG.executeUpdate();
				if(datas<=0){
					stmtCREG.close();
					conn.close();
					return false;
				}
				/*Updating cm_cuscallm Ends*/
			    
			    String sql=("DELETE FROM cm_cuscalld WHERE tr_no="+trno);
			    int data = stmtCREG1.executeUpdate(sql);
			    
			    String sql1=("DELETE FROM cm_servplan WHERE doc_no="+trno);
			    int data1 = stmtCREG1.executeUpdate(sql1);
			    
			    int docno=txtcallregisterdocno;
			    callRegisterBean.setTxtcallregisterdocno(docno);
				if (docno > 0) {
				
					/*Insertion to cm_cuscalld,cm_servplan*/
					int insertData=insertion(conn, docno, trno, formdetailcode, callRegistersDate, txtrefno, txtdescription, txtclientdocno, txtsiteid, complaintsarray, session, mode);
					if(insertData<=0){
						stmtCREG.close();
						conn.close();
						return false;
					}
					/*Insertion to cm_cuscalld,cm_servplan Ends*/
					
						conn.commit();
						stmtCREG.close();
						stmtCREG1.close();
						conn.close();
						return true;
				}
				stmtCREG.close();
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

	public boolean delete(int txtcallregisterdocno, String formdetailcode, int txtcallregistertrno, HttpSession session, String mode) throws SQLException {
		  
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				CallableStatement stmtCREG = conn.prepareCall("{CALL callRegistermDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtCREG.setInt(18,txtcallregisterdocno);
				stmtCREG.setInt(19,txtcallregistertrno);
				
				stmtCREG.setDate(1,null);
				stmtCREG.setString(2,null);
				stmtCREG.setString(3,null);
				stmtCREG.setInt(4,0);
				stmtCREG.setString(5,null);
				stmtCREG.setString(6,null);
				stmtCREG.setString(7,null);
				stmtCREG.setString(8,null);
				stmtCREG.setDate(9,null);
				stmtCREG.setString(10,null);
				stmtCREG.setString(11,null);
				stmtCREG.setString(12,null);
				stmtCREG.setInt(13,0);
				stmtCREG.setString(14,formdetailcode);
				stmtCREG.setString(15,company);
				stmtCREG.setString(16,branch);
				stmtCREG.setString(17,userid);
				stmtCREG.setString(20,mode);
				int datas=stmtCREG.executeUpdate();
				if(datas<=0){
					stmtCREG.close();
					conn.close();
					return false;
				}
				 
				int docno=txtcallregisterdocno;
				callRegisterBean.setTxtcallregisterdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtCREG.close();
				    conn.close();
					return true;
				}	
				stmtCREG.close();
			    conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
				return false;
	    }
	
	public JSONArray contractDetailsGridLoading(String cldocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
				
            	String sql = "select a.costType, a.costId, a.reftype, a.refdocno,a.project,CONVERT(COALESCE(a.projectname,''),CHAR(100)) projectname, a.cldocNo, a.stdate, a.enddate, a.refno from ("
            		+ "select if(m.dtype='AMC',3,4) costType,m.tr_no costId,m.dtype reftype,m.doc_no refdocno,m.ref_type project,m.refDocNo projectname,m.cldocNo,validFrom stdate,"
            		+ "validUpto enddate,m.refno from cm_srvcontrm m left join cm_projectm p on m.refTrNo=p.tr_no and m.costId=2 where m.status=3 and m.jbaction in (0,4) and m.cldocno='"+cldocno+"' union all "
            		+ "select 2 costType,tr_no costId,'Project' reftype,0 refdocno,project,projectname,cldocNo,null,null,null from cm_projectm m where status=3 and m.cldocno='"+cldocno+"') a order by a.refdocno desc";
            	
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
	
	public JSONArray complaintsGridReLoading(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        System.out.println("docNo="+docno);
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
			    
				String sql="select c.description,c.cmplid complaintid,c.servid sertypeid,CONVERT(COALESCE(c.equips,''),CHAR(100)) item,cs.groupname stype,cm.groupname complaint from cm_cuscalld c left join "
						+ "my_groupvals cs on (c.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm on (c.cmplid=cm.doc_no and cm.grptype='complaints') where c.tr_no="+docno+"";
				System.out.println("======complaintgrid"+sql);
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
	
	/*public JSONArray complaintsGridEditReLoading(String docno,String contractno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
			    
				String sql="select a.description,CONVERT(a.complaintid,CHAR(100)) complaintid,a.sertypeid,CONVERT(coalesce(a.item,''),CHAR(100)) item,a.stype,CONVERT(a.complaint,CHAR(100)) complaint from ( select c.description,c.cmplid complaintid,"
						+ "c.servid sertypeid,c.equips item,cs.groupname stype,cm.groupname complaint from cm_cuscalld c left join my_groupvals cs on (c.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm "
						+ "on (c.cmplid=cm.doc_no and cm.grptype='complaints') where c.tr_no="+docno+" UNION ALL select d.description,'' complaintid,doc_no sertypeid,equips item,groupname stype,'' complaint from cm_srvcontrd d "
						+ "left join my_groupvals g on (d.servid=g.doc_no and grptype='service') where tr_no="+contractno+") a group by a.sertypeid,a.item";
				
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
    }*/
	
	public JSONArray servicePendingComplaintGridLoading(String docno,String contractno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
				String sql1 = "";
				
				if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
					 sql1=sql1+" and s.doc_no<"+docno+"";
			    }
				 
        		/*String sql="select c.description descriptions,c.cmplid complaintid,c.servid sertypeid,c.equips items,cs.groupname stypes,cm.groupname complaints from cm_servplan s left join cm_cuscalld c on s.doc_no=c.tr_no "
        				+ "left join my_groupvals cs on (c.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm on (c.cmplid=cm.doc_no and cm.grptype='complaints') where s.workper!=100 and s.dtype='CREG' "
        				+ "and s.cldocno="+cldocno+""+sql1+"";*/
				
        		String sql = "select d.description descriptions,d.cmplid complaintid,d.servid sertypeid,d.equips items,cs.groupname stypes,cm.groupname complaints,st.site from cm_servplan s left join cm_cuscallm m on s.doc_no=m.tr_no "
        				+ "left join cm_cuscalld d on s.doc_no=d.tr_no left join cm_srvcsited st on st.rowno=s.siteid left join my_groupvals cs on (d.servid=cs.doc_no and cs.grptype='service') left join my_groupvals cm on "
        				+ "(d.cmplid=cm.doc_no and cm.grptype='complaints') where s.workper!=100 and s.dtype='CREG' and m.contractno="+contractno+""+sql1+"";
        		
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
	
	public JSONArray serviceComplaintGridLoading(String contractno, String servicesdetails, String itemsdetails, String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null;
        
        try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				String sqltest="";
				
				if(!(servicesdetails.equalsIgnoreCase("0")) && !(servicesdetails.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and groupname like '%"+servicesdetails+"%'";
			    }
		        
		        if(!(itemsdetails.equalsIgnoreCase("0")) && !(itemsdetails.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and equips like '%"+itemsdetails+"%'";
			    }
			        
        		String sql="select groupname,doc_no, CONVERT(coalesce(equips,''),CHAR(100)) item from cm_srvcontrd d left join my_groupvals g on "
        				+ "(d.servid=g.doc_no and grptype='service') where tr_no="+contractno+""+sqltest+"";
				
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
	
	public JSONArray complaintsGridSearchLoading(String complaintno, String complaintdetails, String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCREG = conn.createStatement();
			    
				if(check.equalsIgnoreCase("1")){
					
					String sqltest="";
					
					if(!(complaintdetails.equalsIgnoreCase("0")) && !(complaintdetails.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and groupname like '%"+complaintdetails+"%'";
				    }
			        
			        if(!(complaintno.equalsIgnoreCase("0")) && !(complaintno.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and doc_no="+complaintno+"";
				    }
			        
					String sql="select groupname,doc_no from my_groupvals where status=3 and grptype='complaints'"+sqltest+"";
					
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
	
	public JSONArray clientDetailsSearch(String clientid, String clientname, String contactno,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCREG = conn.createStatement();
	
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
	
	public JSONArray contractDetailsSearch(String contractno,String contractdetails,String branch, String contracttype, String cldocno, String check, String area, String site) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCREG = conn.createStatement();
	
		       if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		        if(!(contractno.equalsIgnoreCase("0")) && !(contractno.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and cm.doc_no="+contractno+"";
			    }
		        
		        if(!(contractdetails.equalsIgnoreCase("0")) && !(contractdetails.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and cm.refno like '%"+contractdetails+"%'";
		        }
		        if(!(area.equalsIgnoreCase("0")) && !(area.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and mg.groupname like '%"+area+"%'";
		        }
		        System.out.println("site=="+site);
		        if(!(site.equalsIgnoreCase("0")) && !(site.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and sd.site like '%"+site+"%'";
		        }
		       /* sql="select doc_no,tr_no,refno from cm_srvcontrm where status=3 and jbaction in (0,4) and dtype='"+contracttype+"' and cldocno="+cldocno+""+sqltest;*/
		       
		       sql="select cm.doc_no,cm.tr_no,refno,sd.site,sd.rowno,mg.groupname area from cm_srvcsited sd "
		       		+ "left join cm_srvcontrm cm on cm.tr_no=sd.tr_no "
		       		+ "left join  my_groupvals mg on( sd.areaid=mg.doc_no and mg.grptype='area' and mg.status=3) "
		       		+ "where cm.status=3 and cm.jbaction in (0,4) and cm.dtype='"+contracttype+"' and cm.cldocno="+cldocno+" "+sqltest;
		        
		       //System.out.println("cont ser=="+sql);
		        
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
	
	public JSONArray siteDetailsSearch(String sitedetails,String contractno,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCREG = conn.createStatement();
	
		       if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		        
		        if(!(sitedetails.equalsIgnoreCase("0")) && !(sitedetails.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and site like '%"+sitedetails+"%'";
			    }
		        
		        sql="select rowno,site from cm_srvcsited where tr_no="+contractno+""+sqltest;
		        
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
	
public JSONArray calledbyDetailsSearch(String cldocno) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtcalledby = conn.createStatement();
	
		    //   if(check.equalsIgnoreCase("1")){
		    	   
		        String sqltest="";
		        String sql="";
		       
		       
		        sql="select coalesce(cperson,'') cperson,coalesce(tel,'') tel,coalesce(mob,'') mob,coalesce(email,'') email "
		        		+ "from my_crmcontact where cldocno="+cldocno+" and dtype='CRM' ";
		        System.out.println("called by sql===="+sql);
		       ResultSet resultSet = stmtcalledby.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtcalledby.close();
		       conn.close();
		     //  }
		       stmtcalledby.close();
		     conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
	 		conn.close();
	 	}
	       return RESULTDATA;
	  }

	public JSONArray cregMainSearch(HttpSession session, String clientsname, String docNo, String date, String contractstype, String contractsno) throws SQLException {

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
	       Statement stmtCREG = conn.createStatement();
	       
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
	         sqltest=sqltest+" and m.contracttype='"+contractstype+"'";
	        }
	        
	        if(!(contractsno.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and cm.doc_no like '%"+contractsno+"%'";
		    }
	        
	       ResultSet resultSet = stmtCREG.executeQuery("select m.doc_no,m.date,c.refname client,m.contracttype,cm.doc_no contractno from cm_cuscallm m left join my_acbook c on m.cldocno=c.doc_no "  
	       		+ "and c.dtype='CRM' left join cm_srvcontrm cm on cm.tr_no=m.contractno and cm.dtype=m.contracttype where m.status<>7 and m.dtype='CREG'" +sqltest);
	
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
	
	 public ClsCallRegisterBean getViewDetails(HttpSession session,int docNo,String branch) throws SQLException {
		ClsCallRegisterBean complaintsmentBean = new ClsCallRegisterBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtCREG = conn.createStatement();
		
			
			
			ResultSet resultSet = stmtCREG.executeQuery ("select m.tr_no trno,m.doc_no,m.date,m.refno,m.remarks,m.cldocno,m.calledby,m.calledbytele,m.calledbymob,m.calledbymail,"
					+ "m.calldate,m.calltime,m.contracttype,m.contractno,m.siteid,c.refname clientname,c.acno clientaccount,c.address clientaddress,c.per_mob clientmobile,"
					+ "c.com_mob clienttele,c.mail1 clientmail,cm.doc_no contractvocno,cm.refno contractdetails,cs.site from cm_cuscallm m left join my_acbook c on m.cldocno=c.doc_no "
					+ "and c.dtype='CRM' left join cm_srvcontrm cm on cm.tr_no=m.contractno left join cm_srvcsited cs on cs.rowno=m.siteid where m.status=3 and m.dtype='CREG' and "
					+ "m.brhid="+branch+" and m.doc_no="+docNo+"");

			System.out.println("ResultSet"+resultSet);
			while (resultSet.next()) {
					complaintsmentBean.setTxtcallregisterdocno(docNo);
					complaintsmentBean.setTxtcallregistertrno(resultSet.getInt("trno"));
					complaintsmentBean.setCallRegisterDate(resultSet.getDate("date").toString());
					complaintsmentBean.setTxtrefno(resultSet.getString("refno"));
					
					complaintsmentBean.setTxtclientname(resultSet.getString("clientname"));
					complaintsmentBean.setTxtclientdocno(resultSet.getInt("cldocno"));
					complaintsmentBean.setTxtclientacno(resultSet.getString("clientaccount"));
					complaintsmentBean.setTxtclientdetails(resultSet.getString("clientaddress"));
					complaintsmentBean.setTxtclienttele(resultSet.getString("clienttele"));
					complaintsmentBean.setTxtclientmobile(resultSet.getString("clientmobile"));
					complaintsmentBean.setTxtclientmail(resultSet.getString("clientmail"));
					complaintsmentBean.setTxtcontactperson(resultSet.getString("calledby"));
					complaintsmentBean.setTxtcontactpersontele(resultSet.getString("calledbytele"));
					complaintsmentBean.setTxtcontactpersonmob(resultSet.getString("calledbymob"));
					complaintsmentBean.setTxtcontactpersonmail(resultSet.getString("calledbymail"));
					complaintsmentBean.setContractDate(resultSet.getDate("calldate")==null?"":resultSet.getDate("calldate").toString());
					complaintsmentBean.setContractTime(resultSet.getString("calltime"));

					complaintsmentBean.setHidcmbcontracttype(resultSet.getString("contracttype"));
					complaintsmentBean.setTxtcontractno(resultSet.getString("contractvocno"));
					complaintsmentBean.setTxtcontracttrno(resultSet.getString("contractno"));
					complaintsmentBean.setTxtcontractdetails(resultSet.getString("contractdetails"));
					complaintsmentBean.setTxtsite(resultSet.getString("site"));
					complaintsmentBean.setTxtsiteid(resultSet.getString("siteid"));
					complaintsmentBean.setTxtdescription(resultSet.getString("remarks"));
		    }
		  stmtCREG.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return complaintsmentBean;
		}
	 
	 public ClsCallRegisterBean getPrint(HttpServletRequest request,int docNo,int branch,int header,String trno) throws SQLException {
		 ClsCallRegisterBean bean = new ClsCallRegisterBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtCREG = conn.createStatement();
			
			String sqlqry="select m.tr_no trno,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y')mdate,m.refno,m.remarks,m.cldocno,m.contracttype,CONCAT(contracttype,cm.doc_no)dtype,m.contractno,m.siteid,c.refname clientname,p.sr_no,mm.grpcode, "
				   + "cm.doc_no contractvocno,cm.refno contractdetails,cs.site from cm_cuscallm m left join my_acbook c on m.cldocno=c.doc_no "
				   + "and c.dtype='CRM' left join cm_srvcontrm cm on cm.tr_no=m.contractno "
				   + "left join cm_servplan p on m.tr_no=p.doc_no and m.dtype=p.dtype left join cm_serteamm mm on p.empGroupId=mm.doc_no left join cm_srvcsited cs on cs.rowno=m.siteid where m.status=3 and m.dtype='CREG' and "
				   + "m.brhid="+branch+" and m.doc_no="+docNo+" ";
			
			ResultSet calreg=stmtCREG.executeQuery(sqlqry);
			
			while(calreg.next()){
				
				bean.setLblclname(calreg.getString("clientname"));
				bean.setLbljobdat(calreg.getString("mdate"));
				bean.setLblsite(calreg.getString("site"));
				bean.setLbldocnno(calreg.getString("doc_no"));
				bean.setLbldtype(calreg.getString("dtype"));
				bean.setLblschno(calreg.getString("sr_no"));
				bean.setLblarea(calreg.getString("grpcode"));
				bean.setLblclientlpo(calreg.getString("contractdetails"));
				bean.setLbldescription(calreg.getString("remarks"));
				
			
			}
			
			 String sqlgrid="";
				sqlgrid=" select @i:=@i+1 as srno,a.* from (select c.description,c.cmplid complaintid,cm.groupname complaint from cm_cuscalld c  left join my_groupvals cm on (c.cmplid=cm.doc_no and cm.grptype='complaints') where c.tr_no="+trno+")a,(select @i:=0) r ";
				 
			
				ResultSet resultSet2 = stmtCREG.executeQuery(sqlgrid);
				
				ArrayList<String> creggrid= new ArrayList<String>();
				
				while(resultSet2.next()){
					
					String temp1="";
					temp1=resultSet2.getString("complaint")+"::"+resultSet2.getString("description");
					creggrid.add(temp1);
				}
				request.setAttribute("creggrid", creggrid);
						
			
			
			
			
			stmtCREG.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	   public int insertion(Connection conn, int docno, int trno, String formdetailcode, Date callRegistersDate, String txtrefno, String txtdescription, int txtclientdocno, 
			   String txtsiteid, ArrayList<String> complaintsarray, HttpSession session, String mode) throws SQLException {
		     
		  try{
				CallableStatement stmtCREG1=null;
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Complaints Grid and Details Saving*/
				for(int i=0;i< complaintsarray.size();i++){
					String[] complaints=complaintsarray.get(i).split("::");
					if(!complaints[3].trim().equalsIgnoreCase("undefined") && !complaints[3].trim().equalsIgnoreCase("NaN")){
					
						stmtCREG1 = conn.prepareCall("INSERT INTO cm_cuscalld(servId, Equips, cmplId, description, sr_no, tr_no) VALUES(?,?,?,?,?,?)");
						
						stmtCREG1.setString(1,(complaints[0].trim().equalsIgnoreCase("undefined") || complaints[0].trim().equalsIgnoreCase("NaN") || complaints[0].trim().equalsIgnoreCase("") ||complaints[0].trim().isEmpty()?"0":complaints[0].trim()).toString()); //service Id
						stmtCREG1.setString(2,(complaints[1].trim().equalsIgnoreCase("undefined") || complaints[1].trim().equalsIgnoreCase("NaN") || complaints[1].trim().equalsIgnoreCase("") ||complaints[1].trim().isEmpty()?" ":complaints[1].trim()).toString()); //item
						stmtCREG1.setString(3,(complaints[2].trim().equalsIgnoreCase("undefined") || complaints[2].trim().equalsIgnoreCase("NaN") || complaints[2].trim().equalsIgnoreCase("") ||complaints[2].trim().isEmpty()?"0":complaints[2].trim()).toString()); //complaint Id
						stmtCREG1.setString(4,(complaints[3].trim().equalsIgnoreCase("undefined") || complaints[3].trim().equalsIgnoreCase("NaN") || complaints[3].trim().equalsIgnoreCase("") ||complaints[3].trim().isEmpty()?" ":complaints[3].trim()).toString()); //description
						stmtCREG1.setInt(5,(i+1)); //sr_no
						stmtCREG1.setInt(6,trno); //doc_no
						int detail=stmtCREG1.executeUpdate();
						if(detail<=0){
							stmtCREG1.close();
							conn.close();
							return 0;
						}
						
						stmtCREG1 = conn.prepareCall("INSERT INTO cm_servplan(DATE, refNo, Remarks, ref_type, refDocNo, refTrNo, cldocno, sr_no, siteId, active, Priorno, dTYPE, cmpid, brhid, userId, DOC_NO, status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtCREG1.setDate(1,callRegistersDate); //date
						stmtCREG1.setString(2,txtrefno); //ref No
						stmtCREG1.setString(3,(complaints[3].trim().equalsIgnoreCase("undefined") || complaints[3].trim().equalsIgnoreCase("NaN") || complaints[3].trim().equalsIgnoreCase("") ||complaints[3].trim().isEmpty()?" ":complaints[3].trim()).toString()); //description
						stmtCREG1.setString(4,formdetailcode);
						stmtCREG1.setInt(5,docno);
						stmtCREG1.setInt(6,trno);
						stmtCREG1.setInt(7,txtclientdocno);
						stmtCREG1.setInt(8,(i+1)); //sr_no
						stmtCREG1.setInt(9,Integer.parseInt(txtsiteid)); //siteid
						stmtCREG1.setInt(10,1); //active
						stmtCREG1.setInt(11,1); //Priorno
						stmtCREG1.setString(12,formdetailcode); //dtype
						stmtCREG1.setString(13,company);
						stmtCREG1.setString(14,branch);
						stmtCREG1.setString(15,userid);
						stmtCREG1.setInt(16,trno);
						stmtCREG1.setString(17,"3");
						int detail1=stmtCREG1.executeUpdate();
						if(detail1<=0){
							stmtCREG1.close();
							conn.close();
							return 0;
						}
						
      				  }
				    }
				    /*Complaints Grid and Details Saving Ends*/
			    
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
