package com.sms;

import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  
import java.io.PrintWriter;  
import java.net.HttpURLConnection;  
import java.net.MalformedURLException;
import java.net.URL;  
import java.net.URLEncoder;  
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;  
import java.util.Vector;  

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;

public class SmsAction {


	public  String doSendSms() throws Exception {
		ClsConnection ClsConnection=new ClsConnection();


		Connection conn = ClsConnection.getMyConnection();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();


		String phone="",msg="",uid="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="";

		try{

			phone=request.getParameter("recipient").toString().trim();

			msg=request.getParameter("message").toString().trim();


			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;

			////        if ((uid == null) || (uid.length() == 0)) {  
			////            throw new IllegalArgumentException("User ID should be present.");  
			////        }  
			////  
			////        uid = URLEncoder.encode(uid, "UTF-8");  
			////  
			////        if ((pwd == null) || (pwd.length() == 0)) {  
			////            throw new IllegalArgumentException("Password should be present.");  
			////        }  
			////        pwd = URLEncoder.encode(pwd, "UTF-8");  
			////  
			////        if ((phone == null) || (phone.length() == 0)) {  
			////            throw new IllegalArgumentException("At least one phone number should be present.");  
			////        }  
			if ((msg == null) || (msg.length() == 0)) {  
				//throw new IllegalArgumentException("SMS message should be present.");  
				return "0";
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			/*try
			{
				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select  msg  from my_msgsettings where dtype='INT' and  brhid in(0)");
		
				if(rs.next())
				{
					msg =rs.getString("msg").trim().replaceAll("ref_name", "Krishnanunni").replaceAll("inv_amount","2000").replaceAll("voc_no", "10552").replaceAll("inv_date", "03-04-2016").replaceAll(" ", "%20");
					
					
				}
				rs.close();	
			}catch(SQLException e){}*/
			

			try
			{
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;

			System.out.println("====content====="+content);

			URL u = new URL(content);  
			HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream(), Charset.forName("UTF-8")));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId)" +
						" VALUES(?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1));prest.setInt(4,0);	
				prest.setInt(5,loginUserId);
				prest.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}


	public  String doSendSms(String phone,String clname,String invamount,String invno,String invdate,String dtype,String brhid) throws Exception {

		ClsConnection ClsConnection=new ClsConnection();

		
		Connection conn = ClsConnection.getMyConnection();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();


		String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";

		try{

		

			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;

			////        if ((uid == null) || (uid.length() == 0)) {  
			////            throw new IllegalArgumentException("User ID should be present.");  
			////        }  
			////  
			////        uid = URLEncoder.encode(uid, "UTF-8");  
			////  
			////        if ((pwd == null) || (pwd.length() == 0)) {  
			////            throw new IllegalArgumentException("Password should be present.");  
			////        }  
			////        pwd = URLEncoder.encode(pwd, "UTF-8");  
			////  
			////        if ((phone == null) || (phone.length() == 0)) {  
			////            throw new IllegalArgumentException("At least one phone number should be present.");  
			////        }  
			
			
			
			
			try
			{
				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
		
				if(rs.next())
				{
					//msg =rs.getString("msg").replaceAll("ref_name", clname).replaceAll("inv_amount",invamount).replaceAll("voc_no", invno).replaceAll("inv_date", invdate).replaceAll(" ", "%20");
					
					msg =rs.getString("msg").replaceAll("ref_name", clname).replaceAll("inv_amount",invamount).replaceAll("voc_no", invno).replaceAll("inv_date", invdate);
					
					
				}
				rs.close();	
			}catch(SQLException e){}
			
			
			
			if ((msg == null) || (msg == "") || (msg.length() == 0)) {  
				return "0";
				//throw new IllegalArgumentException("SMS message should be present."); 
				
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			
			
			

			try
			{
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;

			System.out.println("====content====="+content);

			
			URL u = new URL(content);  
			HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId)" +
						" VALUES(?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1));prest.setInt(4,0);	
				prest.setInt(5,loginUserId);
				prest.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}

}
