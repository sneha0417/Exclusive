package com.dashboard.realestate.propertyaccountmanagement;

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

public class ClsPropertyAccountManagementAction {
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
		String docno=request.getParameter("docno");
		String acno=request.getParameter("acno");
		String fromdate=request.getParameter("fromDate");           
		String todate=request.getParameter("toDate");
		String address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",name="",period="",paddress="",date="";                 
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
				java.sql.Date sqltodate=null;
				java.sql.Date sqlfromdate=null;                       
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();     
					if(!fromdate.equalsIgnoreCase("")){
						sqlfromdate=cmn.changeStringtoSqlDate(fromdate);	
					}
					if(!todate.equalsIgnoreCase("")){                                  
						sqltodate=cmn.changeStringtoSqlDate(todate);	
					}                   
					String sql777="select m.accname address,date_format(curdate(),'%M %d, %Y') date,o.primary_owner name,concat('Period from ', '"+fromdate+"',' To ', '"+todate+"') period from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.doc_no='"+docno+"'";            
					//System.out.println("print main--->>>"+sql777);     
					ResultSet rs777 = stmt.executeQuery(sql777);       
					while(rs777.next()){         
						name=rs777.getString("name");  
						period=rs777.getString("period");                
						paddress=rs777.getString("address"); 
						date=rs777.getString("date");    
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
					
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        param.put("address",address); 
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp","EXCLUSIVE LINKS REAL ESTATE MANAGEMENT");   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("pname",name);
			        param.put("period",period);     
			        param.put("paddress",paddress); 
			        param.put("date",date);
			        param.put("pacno",acno);    
			        param.put("fromdate",sqlfromdate);          
			        param.put("todate",sqltodate); 
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/propertyaccountmanagement/proaccountmgmtprint.jrxml"));     
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
	public String emailAction(String docno,String acno,String fromdate,String todate) throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",name="",period="",paddress="",date="", remail="", ccemail="", bccemail="";                 
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
				java.sql.Date sqltodate=null;
				java.sql.Date sqlfromdate=null;                       
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();     
					if(!fromdate.equalsIgnoreCase("")){
						sqlfromdate=cmn.changeStringtoSqlDate(fromdate);	
					}
					if(!todate.equalsIgnoreCase("")){                                  
						sqltodate=cmn.changeStringtoSqlDate(todate);	
					}                   
					String sql777="select coalesce(o.email,o.email2) email,m.accname address,date_format(curdate(),'%M %d, %Y') date,o.primary_owner name,concat('Period from ', '"+fromdate+"',' To ', '"+todate+"') period from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.doc_no='"+docno+"'";            
					//System.out.println("print main--->>>"+sql777);     
					ResultSet rs777 = stmt.executeQuery(sql777);       
					while(rs777.next()){         
						name=rs777.getString("name");  
						period=rs777.getString("period");                
						paddress=rs777.getString("address"); 
						date=rs777.getString("date"); 
						remail=rs777.getString("email");  
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
					
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        String msg="Dear "+name+" , please find the attach statement for period "+fromdate+" and "+todate ;
			        String subject="E-Statement for "+fromdate+" and "+todate ;
			        param.put("address",address); 
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp","EXCLUSIVE LINKS REAL ESTATE MANAGEMENT");   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("pname",name);
			        param.put("period",period);     
			        param.put("paddress",paddress); 
			        param.put("date",date);
			        param.put("pacno",acno);    
			        param.put("fromdate",sqlfromdate);          
			        param.put("todate",sqltodate); 
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/propertyaccountmanagement/proaccountmgmtprint.jrxml"));     
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportEmail(param, jasperReport, conn, remail, ccemail, bccemail, session, docno,msg,subject);       
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
  	  
  	String fileName="",path="", formcode="PAM",filepath="";    
  	String host="", port="", userName="", password="", recipient="",docnos="1";
  	String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
		String strSql3 = "select email,mailpass,smtpserver,smtphostport from my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";    
		//System.out.println("sql--->>>"+strSql3);   
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
		
		fileName = "PropertyAccountManagement"+currdate+".pdf";    
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
