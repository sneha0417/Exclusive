package com.email;

import java.io.File;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.common.ClsEncrypt;
import com.connection.ClsConnection;

public class SendEmailAction {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	EmailUtility eut=new EmailUtility();
	
	
	    private String host;
	    private String port;
	    private String userName;
	    private String password;
	    private String CC;
	    private String BCC;
	    private File file;
	    private String fileFileName;  
	    private String fileFileContentType;
	    
	    
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
	    
	 
	    // file upload properties - fetched by interceptor fileUpload
	    
	    
	 
	    // e-mail fields - fetched from EmailForm.jsp
	    private String recipient;
	    private String subject;
	    private String message;
	 
	    public String doSendEmail() throws IOException, AddressException,
	            MessagingException {
	    	
	    	
	    	
	    	
	    	    Connection conn = ClsConnection.getMyConnection();
	    		HttpServletRequest request=ServletActionContext.getRequest();
	    		HttpSession session=request.getSession();
	    	
	    		
	    		 recipient=request.getParameter("recipient");
	        	 CC=request.getParameter("CC");
	        	 BCC=request.getParameter("BCC");
	        	 subject=request.getParameter("subject");
	        	 message=request.getParameter("message");
	        	 String host=request.getParameter("host");
	        	 String port=request.getParameter("port");
	    	
	    	try{
//	    	System.out.println("==host==="+host+"==fileFileName===="+fileFileName+"==file=="+file);
	    	
//	    	System.out.println("FILEFILEFILE"+this.getFile());
	    	
//	    	System.out.println("getfiname"+this.getFileFileName());
	    	
	        File saveFile = null,uploadfile=null;
	        System.out.println("file before : "+file);
	        //new File("C:/Users/" + System.getProperty("user.name") + "/Downloads/");
	        file= new File("C://Users//" + System.getProperty("user.name") + "//Downloads//Vehicle_List.csv");
	        System.out.println("file after : "+file);
	        if(!(file==null)){
	        	
	        String tempPath = System.getProperty("java.io.tmpdir");
	       // saveFile = new File(tempPath + File.separator + fileFileName);
	        
	        saveFile = new File(tempPath + File.separator + "Vehicle_List.csv");
	        FileUtils.copyFile(file, saveFile);
	        System.out.println(" file ====== "+file);
	        System.out.println("===== "+tempPath+" --- "+ File.separator+" --- "+fileFileName);
	        }
	        
try {
				
				Statement stmt1 = conn.createStatement();
				 String strSql1 = "select email,mailpass FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
//				  	System.out.println("==strSql1===="+strSql1);
				  ResultSet rs1 = stmt1.executeQuery(strSql1);
				  while(rs1.next ()) {
				    
			
				  setUserName(rs1.getString("email"));
				  setPassword(ClsEncrypt.getInstance().decrypt(rs1.getString("mailpass")));
				//  setPassword(rs1.getString("mailpass"));
//				  System.out.println("getpassword====="+getPassword());
				  
				  }
	        }
				  catch(Exception e){
					  e.printStackTrace();
				  }

//System.out.println("===host====="+host);

//System.out.println("===port====="+port);

//System.out.println("===file====="+saveFile);
	        
	        eut.sendEmail(host, port, userName, password, recipient,CC,
	                subject, message, saveFile,BCC);
	 
	        if (saveFile != null) {
	            saveFile.delete();
	        }
	    	}
	    	catch(Exception e){
	    		e.printStackTrace();
	    		return "error";
	    	}
	 
	        return "success";
	    }
	 

}
