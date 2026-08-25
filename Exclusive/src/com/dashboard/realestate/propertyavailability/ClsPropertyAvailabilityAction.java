package com.dashboard.realestate.propertyavailability;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

public class ClsPropertyAvailabilityAction {
	ClsCommon cmn=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();  
	private String url;
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String uptodate=request.getParameter("uptodate"); 
		String relodestatus=request.getParameter("reloadstatus"); 
		String managed=request.getParameter("managed");       
		String branch=request.getParameter("branch");
		String refdate="",telno="",address="",client="",guest="",receiptno="",trnno="",date="",amount="",cardno="",gstphno="",bookedby="",bphno="",bookrefno="",tourid=""; 
		String imgpath="",comp="",tel="",fax="",brch="",location="",cmpname="",dloc="",ploc="",loctype="",refno="",rname="",printedby="",refon="",vocno="0";      
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
	    java.sql.Date sqluptodate=null;
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					String pasql="";
					String sqlmanaged="";
					sqluptodate=cmn.changeStringtoSqlDate(uptodate);
					if(managed.equalsIgnoreCase("1")){
						sqlmanaged= " and mgprpty=1 ";
					}
					if(relodestatus.equalsIgnoreCase("1")){   
						
						pasql="select @i:=@i+1 srno,a.* from(select m.address1 address,u.user_name lastedit,if(m.cnt_date<curdate() or tn.period_to is null ,'Vacant',coalesce(rs.statusname,'',rs.statusname))  cstatus,prid keyode,if(mgprpty=1,'Y','N') managed, m.accname propid, o.primary_owner  owner,pt.code proptype,aa.area area,if(convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))='',curdate(),convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)))  availdate, round(buildup_area,2) barea,terms_rentalvaluefrom value,desc1 propdesc,specialnotes splnote,contactperson contactper,conatctnumber contactno,SUBSTRING(Ut.UNITTYPE,1,1) noofbeds  from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof left join rl_tncm tn on tn.doc_no=m.cnt_no left join rl_contractrenewalstatus rs on rs.doc_no=tn.renewalstatus "
							 + "  left join my_user u on u.doc_no=m.userid where m.status=3  and coalesce(tn.renewalstatus,0) not in(1,8,15,17) and m.active=1 and pforrent='Rent' and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" group by m.doc_no  order by ut.unittype,address1)a,(select @i:=0)c";
					
					}else if(relodestatus.equalsIgnoreCase("2")){  
						
						pasql="select @i:=@i+1 srno,a.* from(select m.address1 address,u.user_name lastedit,if(m.cnt_date<curdate() or tn.period_to is null ,'Vacant',coalesce(rs.statusname,'',rs.statusname))  cstatus,prid keyode,if(mgprpty=1,'Y','N') managed, m.accname propid, o.primary_owner  owner,pt.code proptype,aa.area area,if(convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))='',curdate(),convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)))  availdate, round(buildup_area,2) barea,terms_rentalvaluefrom value,desc1 propdesc,specialnotes splnote,contactperson contactper,conatctnumber contactno,SUBSTRING(Ut.UNITTYPE,1,1) noofbeds  from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof left join rl_tncm tn on tn.doc_no=m.cnt_no left join rl_contractrenewalstatus rs on rs.doc_no=tn.renewalstatus "
							 + "  left join my_user u on u.doc_no=m.userid where m.status=3  and coalesce(tn.renewalstatus,0) not in(1,8,15,17) and m.active=1 and pforsale='Sale' and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" group by m.doc_no  order by ut.unittype,address1)a,(select @i:=0)c";
					}     
					
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");         
					}
					/*String sql="select c.imgpath,b.branchname,c.company,c.tel,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
							+ "b.cmpid=c.doc_no where b.doc_no="+branch+" group by brhid";*/   
					String sql="select c.company from  my_comp c group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);    
					while(resultSet.next()){
						comp=resultSet.getString("company");
						/*tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						brch=resultSet.getString("branchname");
						location=resultSet.getString("location");    */     
					}
					
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        System.out.println("in...."+pasql);    
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",brch);
			        param.put("location",location);
			        param.put("pasql",pasql);
			        
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/propertyavailability/propertyavailibiltyprint.jrxml"));  
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportPDF(response, param, jasperReport, conn);        
	               } catch (Exception e) {      

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();
		}	  	
	return "print";   
	} 
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
 		  byte[] bytes = null;
         bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
           resp.reset();
         resp.resetBuffer();
         
         resp.setContentType("application/pdf");  
         resp.setContentLength(bytes.length);
         ServletOutputStream ouputStream = resp.getOutputStream();
         ouputStream.write(bytes, 0, bytes.length);
            
         ouputStream.flush();
         ouputStream.close();
     }
}
