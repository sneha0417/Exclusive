package com.operations.clientrelations.clientreview;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientReviewDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsClientReviewBean clientReviewBean = new ClsClientReviewBean();
	
	 public JSONArray operationLoading(String cldocno,String detailed) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
			
	        Connection conn = null;
			 
			 try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
					
					String xsql="";
					if(detailed.equalsIgnoreCase("0")){
						xsql=" limit 10";
					}
					
					String sql = "select d.doc_no, d.status, if(d.clstatus=0,'Open','Closed') clstatus, d.odate, d.otime, d.okm,CASE WHEN d.ofuel='0.000' THEN 'Level 0/8' WHEN d.ofuel='0.125' THEN 'Level 1/8' "
						+ "WHEN d.ofuel='0.250' THEN 'Level 2/8' WHEN d.ofuel='0.375' THEN 'Level 3/8'  WHEN d.ofuel='0.500' THEN 'Level 4/8' WHEN d.ofuel='0.625' THEN 'Level 5/8' WHEN d.ofuel='0.750' THEN 'Level 6/8' "
						+ "WHEN d.ofuel='0.875' THEN 'Level 7/8' WHEN d.ofuel='1.000' THEN 'Level 8/8' END as 'ofuel',d.brhid, d.rentaltype, d.rate, d.cdw, d.inkm,CASE WHEN d.infuel='0.000' THEN 'Level 0/8' WHEN d.infuel='0.125' "
						+ "THEN 'Level 1/8' WHEN d.infuel='0.250' THEN 'Level 2/8' WHEN d.infuel='0.375' THEN 'Level 3/8'  WHEN d.infuel='0.500' THEN 'Level 4/8' WHEN d.infuel='0.625' THEN 'Level 5/8' WHEN d.infuel='0.750' "
						+ "THEN 'Level 6/8' WHEN d.infuel='0.875' THEN 'Level 7/8' WHEN d.infuel='1.000' THEN 'Level 8/8' END as 'infuel',d.indate, d.intime, d.brout, d.flname, d.ibrhid, d.brin from ( select r.doc_no,r.clstatus status,"
						+ "r.clstatus,r.odate,r.otime,round(r.okm) okm,r.ofuel,r.brhid,t.rentaltype,round(t1.rate,2) rate,round(t1.cdw,2) cdw,round(c.inkm) inkm,c.infuel,c.indate,c.intime,b.branchname brout,v.flname,c.brchid ibrhid,"
						+ "br.branchname brin from gl_ragmt r left join gl_rtarif t on r.doc_no=t.rdocno and t.rstatus=5 left join gl_rtarif t1 on r.doc_no=t1.rdocno and t1.rstatus=7 left join gl_ragmtclosem c on r.doc_no=c.agmtno "
						+ "left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_brch b on r.brhid=b.doc_no left join my_brch br on c.brchid=br.doc_no where r.cldocno="+cldocno+" union select l.doc_no,l.clstatus status,l.clstatus,"
						+ "l.outdate odate,l.outtime otime,round(l.outkm) okm,l.outfuel ofuel,l.brhid,(select 'Monthly') rentaltype,round(t.rate,2) rate,round(t.cdw,2) cdw,round(c.inkm) inkm,c.infuel,c.indate,c.intime,b.branchname brout,"
						+ "v.flname,c.brchid ibrhid,br.branchname brin from gl_lagmt l left join gl_ltarif t on l.doc_no=t.rdocno left join gl_lagmtclosem c on l.doc_no=c.agmtno left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) "  
						+ "left join my_brch b on l.brhid=b.doc_no left join my_brch br on c.brchid=br.doc_no where l.cldocno="+cldocno+" )d ORDER BY d.odate DESC"+xsql+"";
	            	
					ResultSet resultSet = stmtCRW.executeQuery(sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				} finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
	    
	 public JSONArray quotationLoading(String cldocno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
			
	        Connection conn = null;
			 
			 try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
					
					
					String sql = "select  if(ref_type='DIR','Direct','Enquiry') ref_type,m.doc_no,b.brand_name,mo.vtype model,spec,color,unit,frmdate,todate,rtype,round(nettotal,2) nettotal from gl_quotm m "
						 + "left join gl_qenq e on e.rdocno=m.doc_no left join gl_vehbrand b on b.doc_no=e.brdid left join gl_vehmodel mo on mo.doc_no=e.modid "
						 + "left join my_color c on c.doc_no=e.clrid where m.status=3 and m.cldocno="+cldocno+" ORDER BY m.doc_no DESC";
	            	
					ResultSet resultSet = stmtCRW.executeQuery(sql);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				} finally{
					conn.close();
				}
		        return RESULTDATA;
		    }	
	 
	 public JSONArray accidentDamageLoading(String cldocno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
			
	        Connection conn = null;
			 
			 try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
					
					String sql = "SELECT g.rfleet,v.flname,g.acdate,g.place,if(g.claim=0,'OWN','Third Party') type,g.amount FROM gl_vinspm g left join "
							+ "gl_vehmaster v on (g.rfleet=v.fleet_no) left join gl_ragmt r on g.refdocno=r.doc_no and g.reftype='RAG' left join gl_lagmt l "
							+ "on g.refdocno=l.doc_no and g.reftype='LAG' where g.accident=1 and (r.cldocno="+cldocno+" or l.cldocno="+cldocno+") ORDER BY g.acdate DESC";

					ResultSet resultSet = stmtCRW.executeQuery(sql);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				} finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
	    
	    public JSONArray nonFinancialLoading(String cldocno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
			
	        Connection conn = null;
			 
			 try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
					
					String sql = "select n.doc_no,n.date, n.comment,u.user_name,b.branchname from my_clnonfin n left join my_user u on n.userid=u.doc_no left join "
							+ "my_brch b on n.brhid=b.doc_no where n.status=3 and n.cldocno="+cldocno+" ORDER BY n.date DESC";

					ResultSet resultSet = stmtCRW.executeQuery(sql);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				} finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
	 
	 public JSONArray paymentFollowUpLoading(String accountno,String cldocno,String detailed) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 
		 Connection conn = null;
		 
		 try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
	            	
					String xsql="";
					if(detailed.equalsIgnoreCase("0")){
						xsql=" limit 20";
					}
					
					ResultSet resultSet = stmtCRW.executeQuery ("select p.remarks,p.fdate,p.date,u.user_name,b.branchname from gl_bcpf p left join my_user u on p.userid=u.doc_no "
							+ "left join my_brch b on p.brhid=b.doc_no where p.rdocno="+cldocno+" ORDER BY p.fdate DESC"+xsql+"");
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	 public JSONArray driverLoading(String cldocno) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = connDAO.getMyConnection();
					Statement stmtCRW = conn.createStatement();
					
					ResultSet resultSet = stmtCRW.executeQuery ("SELECT doc_no,dr_id,sr_no srno,name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,hcdlno,"
							+ "hcissdate,hcled,if(pass_exp<=now(),'PASSPORT EXPIRED',if(led<=now(),'LICENCE EXPIRED','')) expired,'Attach' attachbtn FROM gl_drdetails where dtype='CRM' and doc_no="+cldocno+"");
	                
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRW.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return RESULTDATA;
	    }
	 
	 public JSONArray clientDetailsSearch(HttpSession session,String accountno,String accountname,String mobile,String currency,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtCRW = conn.createStatement();
		
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
		           
			        String sqltest="";
			        String sql="";
			        
			        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
			        }
			        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
			        }
			        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and a.per_mob like '%"+mobile+"%'";
			        }
			        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and c.code like '%"+currency+"%'";
				    }
			        
			        if(check.equalsIgnoreCase("1")){
			        	
			        sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
			        		+ "a.dtype='CRM' and t.atype='AR' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
			        		+ "from my_curbook cr where  coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtCRW.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			       stmtCRW.close();
			       conn.close();
			       }
			     stmtCRW.close();
				 conn.close();   
		     } catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     } finally{
				  conn.close();
			 }
		     return RESULTDATA;
		  }

	 public int insert(Date nonFinancialDate, String txtnonfinancialcomment, int txtcldocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			Connection conn = null;

			try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtNonFinancial = conn.prepareCall("{CALL nonFinancialCommentDML(?,?,?,?,?,?,?,?)}");
				
				stmtNonFinancial.registerOutParameter(7, java.sql.Types.INTEGER);
				
				stmtNonFinancial.setDate(1,nonFinancialDate);
				stmtNonFinancial.setString(2,txtnonfinancialcomment);
				stmtNonFinancial.setInt(3,txtcldocno);
				stmtNonFinancial.setString(4,formdetailcode);
				stmtNonFinancial.setString(5,branch);
				stmtNonFinancial.setString(6,userid);
				stmtNonFinancial.setString(8,mode);
				int datas=stmtNonFinancial.executeUpdate();
				if(datas<=0){
					stmtNonFinancial.close();
					conn.close();
					return 0;
				}
				int docno=stmtNonFinancial.getInt("docNo");
				clientReviewBean.setTxtnonfinancialdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtNonFinancial.close();
					conn.close();
					return docno;
				}
				stmtNonFinancial.close();
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

		public boolean edit(int txtnonfinancialdocno, Date nonFinancialDate, String txtnonfinancialcomment, int txtcldocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;

			try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();

				CallableStatement stmtNonFinancial = conn.prepareCall("{CALL nonFinancialCommentDML(?,?,?,?,?,?,?,?)}");
				
				stmtNonFinancial.setInt(7, txtnonfinancialdocno);
				
				stmtNonFinancial.setDate(1,nonFinancialDate);
				stmtNonFinancial.setString(2,txtnonfinancialcomment);
				stmtNonFinancial.setInt(3,txtcldocno);
				stmtNonFinancial.setString(4,formdetailcode);
				stmtNonFinancial.setString(5,branch);
				stmtNonFinancial.setString(6,userid);
				stmtNonFinancial.setString(8,mode);
				int datas=stmtNonFinancial.executeUpdate();
				if(datas<=0){
					stmtNonFinancial.close();
					conn.close();
					return false;
				}
				int docno=stmtNonFinancial.getInt("docNo");
				clientReviewBean.setTxtnonfinancialdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtNonFinancial.close();
					conn.close();
					return true;
				}
				stmtNonFinancial.close();
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

		public boolean delete(int txtnonfinancialdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;

			try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();

				CallableStatement stmtNonFinancial = conn.prepareCall("{CALL nonFinancialCommentDML(?,?,?,?,?,?,?,?)}");
				
				stmtNonFinancial.setInt(7, txtnonfinancialdocno);
				
				stmtNonFinancial.setDate(1,null);
				stmtNonFinancial.setString(2,null);
				stmtNonFinancial.setInt(3,0);
				stmtNonFinancial.setString(4,formdetailcode);
				stmtNonFinancial.setString(5,branch);
				stmtNonFinancial.setString(6,userid);
				stmtNonFinancial.setString(8,mode);
				int datas=stmtNonFinancial.executeUpdate();
				if(datas<=0){
					stmtNonFinancial.close();
					conn.close();
					return false;
				}
				int docno=stmtNonFinancial.getInt("docNo");
				clientReviewBean.setTxtnonfinancialdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtNonFinancial.close();
					conn.close();
					return true;
				}
				stmtNonFinancial.close();
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
}
