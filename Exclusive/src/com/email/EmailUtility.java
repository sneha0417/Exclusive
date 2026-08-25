package com.email;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
 

public class EmailUtility {

	
	public  void sendEmail(String host, String port,
            final String userName, final String password,
            String recipient, String CC ,String subject, String message, File attachFile,String BCC)
                    throws AddressException, MessagingException {
        // sets SMTP server properties
		
//		System.out.println("==recipient==="+recipient+"=CC=="+CC);
		
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName);
        		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        
        
        /*if(!(CC.equals(""))){
        //msg.setFrom(new InternetAddress(userName));	
        InternetAddress[] mailCC = { new InternetAddress(CC.trim(),true) };
        System.out.println("===mailCC===="+mailCC);
        msg.setRecipients(Message.RecipientType.CC, mailCC);
        }
        
        if(!(BCC.equals(""))){
        //msg.setFrom(new InternetAddress(userName));
        InternetAddress[] mailBCC = { new InternetAddress(BCC.trim(),true) };
        msg.setRecipients(Message.RecipientType.BCC, mailBCC);
        }*/
        
        
        String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }
        
        
        if(!(subject.equals(""))){
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
 
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
 
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
 
        // adds attachments
       if (attachFile != null) {
            MimeBodyPart attachPart = new MimeBodyPart();
 
            try {
                attachPart.attachFile(attachFile);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
 
            multipart.addBodyPart(attachPart);
        }
        // sets the multi-part as e-mail's content*/
        msg.setContent(multipart);
 
        // sends the e-mail
//        System.out.println("=====dfghjkjhgfdfghjkl======="+msg);
        Transport.send(msg);
        
    }

	
	
}
