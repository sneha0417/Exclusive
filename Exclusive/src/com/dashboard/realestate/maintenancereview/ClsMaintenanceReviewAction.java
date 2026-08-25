package com.dashboard.realestate.maintenancereview;

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

public class ClsMaintenanceReviewAction {
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
		String docno=request.getParameter("property"); 
		String frmld=request.getParameter("frmld");
		String from=request.getParameter("from");
		String to=request.getParameter("to");
		String alltbl="",mrsqlpending="",mrsqlall="",address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",property="",ownername="",owneraddress="",ownertel="",owneremail="";             
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					 java.sql.Date sqltodate = null,sqlfromdate=null;
					 String sqltest1="";
					 if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0")))
				     	{
						 sqlfromdate=cmn.changeStringtoSqlDate(from);
				     		
				     	}
				     	if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0")))
				     	{
				     		sqltodate=cmn.changeStringtoSqlDate(to);
				     		
				     	}
				     	if(sqlfromdate!=null && sqltodate!=null ){
				     		sqltest1="and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"' ";
				     	}
					if(frmld.equalsIgnoreCase("pending")){
						
					mrsqlpending="select r.voc_no docno,r.comments,r.sr_no,ac.refname tenant,r.edate date,r.est_amt,j.job_desc job, ntdate, appdate, appamt from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" and r.confirm=0  order by r.doc_no,r.sr_no";
					}
					if(frmld.equalsIgnoreCase("all")){
						alltbl="1";
						 mrsqlpending="select r.voc_no docno,r.comments,r.sr_no,ac.refname tenant,r.edate date,r.est_amt,j.job_desc job, ntdate, appdate, appamt from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" and r.confirm=0  order by r.doc_no,r.sr_no";
						 mrsqlall="select r.voc_no docno,r.sr_no,ac.refname tenant,r.edate date,j.job_desc job,st.name status,rm.description jobdone,'' remarks,rm.total amount from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno left join re_pstatus st on st.doc_no=r.statusid where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" order by r.doc_no,r.sr_no";           
					}  
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");    
					}
					String sql777="select p.accname property,o.primary_owner ownername, o.address, o.tele_phn,o.email from re_mreq r left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid where r.pdoc_no='"+docno+"'";   
					//System.out.println("print main--->>>"+sql777); 
					ResultSet rs777 = stmt.executeQuery(sql777);    
					while(rs777.next()){
						property=rs777.getString("property");  
						ownername=rs777.getString("ownername"); 
						owneraddress=rs777.getString("address"); 
						ownertel=rs777.getString("tele_phn"); 
						owneremail=rs777.getString("email"); 
					}
					String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);         
					while(resultSet.next()){
						comp=resultSet.getString("company");
						tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						address=resultSet.getString("address");
					}
					
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        System.out.println(mrsqlall+".....in...."+mrsqlpending);    
			        param.put("address",address); 
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("mrsqlall",mrsqlall);
			        param.put("mrsqlpending",mrsqlpending);     
			        param.put("property",property);
			        param.put("owner",ownername);    
			        param.put("owneraddress",owneraddress);  
			        param.put("ownertel",ownertel);
			        param.put("owneremail",owneremail);
			        param.put("alltbl",alltbl);
			        
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/maintenancereview/maintenancereview.jrxml"));  
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
	public String emailAction(String docno,String frmld,String from,String to) throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mrsqlpending="",mrsqlall="",address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",property="",ownername="",owneraddress="",ownertel="",owneremail="";
		String alltbl="",name="",period="",paddress="",date="", remail="", ccemail="", bccemail="";                 
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
				                      
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement(); 
					 java.sql.Date sqltodate = null,sqlfromdate=null;
					 String sqltest1="";
					 if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0")))
				     	{
						 sqlfromdate=cmn.changeStringtoSqlDate(from);
				     		
				     	}
				     	if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0")))
				     	{
				     		sqltodate=cmn.changeStringtoSqlDate(to);
				     		
				     	}
				     	if(sqlfromdate!=null && sqltodate!=null ){
				     		sqltest1="and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"' ";
				     	}
					if(frmld.equalsIgnoreCase("pending")){
						mrsqlpending="select r.voc_no docno,r.comments,r.sr_no,ac.refname tenant,r.edate date,r.est_amt,j.job_desc job, ntdate, appdate, appamt from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" and r.confirm=0  order by r.doc_no,r.sr_no";
						}
						if(frmld.equalsIgnoreCase("all")){
							alltbl="1";
							 mrsqlpending="select r.voc_no docno,r.comments,r.sr_no,ac.refname tenant,r.edate date,r.est_amt,j.job_desc job, ntdate, appdate, appamt from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" and r.confirm=0  order by r.doc_no,r.sr_no";
							 mrsqlall="select r.voc_no docno,r.sr_no,ac.refname tenant,r.edate date,j.job_desc job,st.name status,rm.description jobdone,'' remarks,rm.total amount from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_jobmaster j on j.doc_no=rm.jobdocno left join re_pstatus st on st.doc_no=r.statusid where r.status=3 and p.doc_no='"+docno+"' "+sqltest1+" order by r.doc_no,r.sr_no";           
						}  
						String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
						//System.out.println("print main--->>>"+sql123); 
						ResultSet rs123 = stmt.executeQuery(sql123);    
						while(rs123.next()){
							printedby=rs123.getString("USER_NAME");    
						}
						String sql777="select p.accname property,o.primary_owner ownername, o.address, o.tele_phn,o.email from re_mreq r left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid where r.pdoc_no='"+docno+"'";   
						//System.out.println("print main--->>>"+sql777); 
						ResultSet rs777 = stmt.executeQuery(sql777);    
						while(rs777.next()){
							property=rs777.getString("property");  
							ownername=rs777.getString("ownername"); 
							owneraddress=rs777.getString("address"); 
							ownertel=rs777.getString("tele_phn"); 
							owneremail=rs777.getString("email"); 
						}
						String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
						//System.out.println("print main--->>>"+sql); 
						ResultSet resultSet = stmt.executeQuery(sql);         
						while(resultSet.next()){
							comp=resultSet.getString("company");
							tel=resultSet.getString("tel");
							fax=resultSet.getString("fax");
							address=resultSet.getString("address");
						}
						
					    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
				        imgpath=imgpath.replace("\\", "\\\\");      
				        //String user=session.getAttribute("USERNAME").toString();
				        System.out.println(mrsqlall+".....in...."+mrsqlpending);  
				        String msg="Dear "+ownername+" , please find the attachment of maintenance details";
				        String subject="Maintenance Review.PDF" ;
				        param.put("address",address); 
				        param.put("img",imgpath); 
				        param.put("printedby",printedby);          
				        param.put("comp",comp);   
				        param.put("tel",tel);
				        param.put("fax",fax);
				        param.put("mrsqlall",mrsqlall);
				        param.put("mrsqlpending",mrsqlpending);     
				        param.put("property",property);
				        param.put("owner",ownername);    
				        param.put("owneraddress",owneraddress);  
				        param.put("ownertel",ownertel);
				        param.put("owneremail",owneremail);
				        param.put("alltbl",alltbl);
				        
				        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/maintenancereview/maintenancereview.jrxml"));  
	  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportEmail(param, jasperReport, conn, owneremail, ccemail, bccemail, session, docno,msg,subject);       
	               } catch (Exception e) {      

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();
		}	  	
	return "print";   
	} 
	private void generateReportEmail(Map parameters, JasperReport jasperReport, Connection conn, String remail, String ccemail,String bccemail, HttpSession session,String docno, String message, String subject)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  byte[] bytes = null;
      bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
      EmailProcess ep=new EmailProcess();   
  	Statement stmtrr=conn.createStatement();
  	  
  	String fileName="",path="", formcode="MRW",filepath="";    
  	String host="", port="", userName="", password="", recipient="",docnos="1";
  	String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
		String strSql3 = "select email,mailpass,smtpserver,smtphostport from my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";    
		System.out.println("usersql--->>>"+strSql3);   
		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		while(rs3.next ()) {   
			userName=rs3.getString("email");    
			port=rs3.getString("smtphostport");
			host=rs3.getString("smtpserver");
			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
		}
			  
		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
		fileName = "Maintenance Review"+currdate+".pdf";    
		filepath=path+ "/Attachment/"+formcode+"/"+fileName;

		File dir = new File(path+ "/attachment/"+formcode); 
		dir.mkdirs();
		    
		FileOutputStream fos = new FileOutputStream(filepath);
  	    fos.write(bytes);
  	    fos.flush();
  	    fos.close();
  	
     	File saveFile=new File(filepath);
		//String[] remails=remail.split(",");
		
			try {
				ep.sendEmailwithpdf(host, port, userName, password, remail, subject, message, saveFile,docnos);	     
			} catch (javax.mail.MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();  
			}   
         
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
