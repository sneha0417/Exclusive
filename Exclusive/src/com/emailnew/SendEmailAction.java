 package com.emailnew;   

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
 
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.mailwithpdf.*;

public class SendEmailAction {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	EmailUtility eut=new EmailUtility();
	EmailProcess mailwithpdf=new EmailProcess();
	    private String host,txtmsg,mode,urls,msg,texturl,userid,brchid,formcode,docno,trno;
		public String getTrno() {
			return trno;
		}

		public void setTrno(String trno) {
			this.trno = trno;
		}
		private String port;
	    private String userName,reformcode;      
	    public String getReformcode() {
			return reformcode;
		}

		public void setReformcode(String reformcode) {
			this.reformcode = reformcode;
		}
		private String password;
	    private String CC;
	    private String BCC;
	    private File file;
	    private String fileFileName;  
	    private String fileFileContentType;
		public String getUserid() {
			return userid;
		}

		public void setUserid(String userid) {
			this.userid = userid;
		}

		public String getBrchid() {
			return brchid;
		}

		public void setBrchid(String brchid) {  
			this.brchid = brchid;
		}

		public String getFormcode() {
			return formcode;
		}

		public void setFormcode(String formcode) {
			this.formcode = formcode;
		}

		public String getDocno() {
			return docno;
		}

		public void setDocno(String docno) {
			this.docno = docno;
		}
	    public String getTexturl() {
			return texturl;
		}

		public void setTexturl(String texturl) {
			this.texturl = texturl;
		}
	    public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}  
	    public String getUrls() {
			return urls;
		}

		public void setUrls(String urls) {
			this.urls = urls;
		}
	    public String getTxtmsg() {
			return txtmsg;
		}

		public void setTxtmsg(String txtmsg) {
			this.txtmsg = txtmsg;
		}

		public String getMode() {
			return mode;
		}

		public void setMode(String mode) {
			this.mode = mode;
		}
	    public String getFileFileName() {
			return fileFileName;
		}

		public void setFileFileName(String fileFileName) {
			this.fileFileName = fileFileName;
		}

		public String getFileFileContentType() {
			return fileFileContentType;
		}

		public void setFileFileContentType(String fileFileContentType) {
			this.fileFileContentType = fileFileContentType;
		}

		public File getFile() {
			return file;
		}

		public void setFile(File file) {
			this.file = file;
		}

		public String getBCC() {
			return BCC;
		}

		public void setBCC(String bCC) {
			BCC = bCC;
		}

		public String getHost() {
	        return host;
	    }
	 
	    public void setHost(String host) {
	        this.host = host;
	    }
	 
	    public String getPort() {
	        return port;
	    }
	 
	    public void setPort(String port) {
	        this.port = port;
	    }
	 
	    public String getUserName() {
	        return userName;
	    }
	 
	    public void setUserName(String userName) {
	        this.userName = userName;
	    }
	 
	    public String getPassword() {
	        return password;
	    }
	 
	    public void setPassword(String password) {
	        this.password = password;
	    }
	
	 
	    public String getRecipient() {
	        return recipient;
	    }
	 
	    public void setRecipient(String recipient) {
	        this.recipient = recipient;
	    }
	    public String getCC() {
	        return CC;
	    }
	 
	    public void setCC(String CC) {
	        this.CC = CC;
	    }
	 
	 
	    public String getSubject() {
	        return subject;
	    }
	 
	    public void setSubject(String subject) {
	        this.subject = subject;
	    }
	 
	    public String getMessage() {
	        return message;
	    }
	 
	    public void setMessage(String message) {
	        this.message = message;
	    }
	    private String recipient;
	    private String subject;
	    private String message;
	 
	    public String doSendEmail()  throws ParseException, SQLException, AddressException, MessagingException {     
	    	    Connection conn = ClsConnection.getMyConnection();
	    		HttpServletRequest request=ServletActionContext.getRequest();
	    		HttpSession session=request.getSession();
	    		
	    		if(mode.equalsIgnoreCase("SEND")){
					 recipient=getRecipient();
					 CC=getCC();
			       	 BCC=getBCC();  
			       	 subject=getSubject();
			       	 message=getTxtmsg();         
			       	 String host=getHost(); 
			       	 String port=getPort();
			       	 String urll=getTexturl();             
			       	 String redtype=getReformcode(); 
			       	 String trnos=getTrno();
			     	 String value="";
			     	  File saveFile = null;
			       	  Statement stmt1 = conn.createStatement();  
					  String strSql1 = "select email,mailpass FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
					  ResultSet rs1 = stmt1.executeQuery(strSql1);
					  while(rs1.next ()) {
					  setUserName(rs1.getString("email"));
					  setPassword(ClsEncrypt.getInstance().decrypt(rs1.getString("mailpass")));
				      }     
					  System.out.println("password===="+getPassword());   
					    if(redtype.equalsIgnoreCase("UND")){
					    	//System.out.println("IN....1.1");
					    	emailAction(trnos,getFormcode());     
					    	//System.out.println("IN....2");
					    	saveFile=(File) request.getAttribute("files");
					    	  //System.out.println("IN....3");      
					    	value=eut.sendEmailpdf(host, port, userName, password, recipient,CC,subject, message, urll,BCC,saveFile);	
					    }else{
					    	
					    	 value=eut.sendEmail(host, port, userName, password, recipient,CC,subject, message, urll,BCC);
					  //  	 value=eut.sendEmailwithMultiplepdfBCC(host, port, userName, password, recipient, CC, BCC, subject, message, urll, saveFile, docno);
					    	 
					    /*mailwithMultiplepdfBCC(String host, String port, String userName, String password, String rto, String rcc, String rbcc, String subject, String message, File attachFile, File attachFile1, String docnos) throws AddressException, MessagingException*/

					    }
                     //String value=eut.sendEmail(host, port, userName, password, recipient,CC,subject, message, urll,BCC);                  
                     if(value.equalsIgnoreCase("success")){
                    		String refid="";
                    	/*  Inserting into emaillog*/  
                    		String sqls="insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email) values ('"+getDocno()+"','"+getBrchid()+"','"+getFormcode()+"',now(),'"+getUserid()+"','"+refid+"','"+recipient+"')";
                    		int datas = stmt1.executeUpdate(sqls);
                    	/*	Inserting into emaillog Ends	*/
                     conn.close();
                     setMsg("E-Mail Send Successfully");
         			 return "success"; 
         		     }
         		     else{
         		    	conn.close();
         		   	 setMsg("E-Mail Sending failed");      
         			 return "fail";
         		    }
         	     }
         	return "fail";  
        }
		public void emailAction(String trno,String fromtype) throws ParseException, SQLException{

			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			int doc=Integer.parseInt(trno); 
			int brhid=0;
			String amount="";  
			String dtype="";
			  
			  ClsAmountToWords obj = new ClsAmountToWords();
			//System.out.println("IN...3");
			if(com.getPrintPath(fromtype).contains(".jrxml")==true)
			{
				//System.out.println("IN...3.1");
				HttpServletResponse response = ServletActionContext.getResponse();

				Connection conn = null;
				 try {    
					ClsConnection conobj= new ClsConnection();
						 Map param = new HashMap();
				                conn = conobj.getMyConnection();
				          	    Statement stmt1 = conn.createStatement();         
				                
				          	  String strSql1 = "select  c.dtype,round(cd.premium,2)+round(cd.premium* if(ac.tax=1,0.05,0),2) amount,c.brhid from in_contract c left join my_acbook ac on ac.cldocno=c.cldocno left join in_contractd cd on cd.rdocno=c.doc_no where c.doc_no='"+trno+"'";
							  ResultSet rs1 = stmt1.executeQuery(strSql1);
							  while(rs1.next ()) {
							 dtype=rs1.getString("dtype");  
							 brhid=rs1.getInt("brhid");  
							 amount=rs1.getString("amount");  
							  }   
					    String amountwords = obj.convertAmountToWords(amount);
				        String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/nsibheader.jpg");
				        imgpathheader=imgpathheader.replace("\\", "\\\\");
				     String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/nsibfooter.jpg");
				     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
				     param.put("docno", doc) ; 
				      param.put("amountwords", amountwords);
				      param.put("imgheader", imgpathheader);
				      param.put("imgfooter", imgpathfooter);
				      param.put("obj", obj); 
						JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(com.getPrintPath(dtype)));
			         	 
			         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
			                           generateReportPDF(request,param, jasperReport, conn);
			                 } catch (Exception e) {
			                     e.printStackTrace();
			                 }
				 finally{
					 conn.close();   
				 }
			}     
		}
		
		private void generateReportPDF(HttpServletRequest request,Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
			  byte[] bytes = null;   
	      bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	     	Statement stmtrr=conn.createStatement();
	  	     
	  	String fileName="",path="", formcode="",filepath=""; 
	  	String host="", port="", userName="", password="", recipient="",subject="", message="",docnos="1";
	  	String strSql1 = "select imgPath from my_comp";

			ResultSet rs1 = stmtrr.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("imgPath");
			}
				     
			DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
			java.util.Date date = new java.util.Date();
			String currdate=dateFormat.format(date);
			
			fileName = "INSURANCE_CONTRACT"+currdate+".pdf";
			filepath=path+ "/Attachment/"+formcode+"/"+fileName;

			File dir = new File(path+ "/attachment/"+formcode); 
			dir.mkdirs();    
			    
			FileOutputStream fos = new FileOutputStream(filepath);
	  	    fos.write(bytes);
	  	    fos.flush();
	  	    fos.close();
	  	
	     	File saveFile=new File(filepath);
	     	request.setAttribute("files", saveFile);              
	}
   }
