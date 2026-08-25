package com.dashboard.accounts.journalvoucherlist;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;

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

public class JournalVoucherListAction {
	ClsCommon ClsCommon =new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	ClsJournalVoucherListDAO jvlistDAO=new ClsJournalVoucherListDAO();
	ClsJournalVouchersListBean  journalVouchersBean=new ClsJournalVouchersListBean();   
	//for hide
			private int firstarray;
			private int txtheader;  
	public int getFirstarray() {
				return firstarray;
			}

			public void setFirstarray(int firstarray) {
				this.firstarray = firstarray;
			}

			public int getTxtheader() {
				return txtheader;
			}

			public void setTxtheader(int txtheader) {
				this.txtheader = txtheader;
			}

		//Print
	    private String url;
		private String lblcompname;
		private String lblcompaddress;
		private String lblpobox;
		private String lblprintname;
		private String lblcomptel;
		private String lblcompfax;
		private String lblbranch;
		private String lbllocation;
		private String lblservicetax;
		private String lblpan;
		private String lblcstno;
		
		private String lbldate;
		private String lblvoucherno;
		private String lblrefno;
		private String lblnetamount;
		private String lblnetamountwords;
		private String lbldescription;
		private String lbldebittotal;
		private String lblcredittotal;
		private String lblpreparedby;   
		private String lblpreparedon;
		private String lblpreparedat;

	public String getLblcompname() {
			return lblcompname;
		}

		public void setLblcompname(String lblcompname) {
			this.lblcompname = lblcompname;
		}

		public String getLblcompaddress() {
			return lblcompaddress;
		}

		public void setLblcompaddress(String lblcompaddress) {
			this.lblcompaddress = lblcompaddress;
		}

		public String getLblpobox() {
			return lblpobox;
		}

		public void setLblpobox(String lblpobox) {
			this.lblpobox = lblpobox;
		}

		public String getLblprintname() {
			return lblprintname;
		}

		public void setLblprintname(String lblprintname) {
			this.lblprintname = lblprintname;
		}

		public String getLblcomptel() {
			return lblcomptel;
		}

		public void setLblcomptel(String lblcomptel) {
			this.lblcomptel = lblcomptel;
		}

		public String getLblcompfax() {
			return lblcompfax;
		}

		public void setLblcompfax(String lblcompfax) {
			this.lblcompfax = lblcompfax;
		}

		public String getLblbranch() {
			return lblbranch;
		}

		public void setLblbranch(String lblbranch) {
			this.lblbranch = lblbranch;
		}

		public String getLbllocation() {
			return lbllocation;
		}

		public void setLbllocation(String lbllocation) {
			this.lbllocation = lbllocation;
		}

		public String getLblservicetax() {
			return lblservicetax;
		}

		public void setLblservicetax(String lblservicetax) {
			this.lblservicetax = lblservicetax;
		}

		public String getLblpan() {
			return lblpan;
		}

		public void setLblpan(String lblpan) {
			this.lblpan = lblpan;
		}

		public String getLblcstno() {
			return lblcstno;
		}

		public void setLblcstno(String lblcstno) {
			this.lblcstno = lblcstno;
		}

		public String getLbldate() {
			return lbldate;
		}

		public void setLbldate(String lbldate) {
			this.lbldate = lbldate;
		}

		public String getLblvoucherno() {
			return lblvoucherno;
		}

		public void setLblvoucherno(String lblvoucherno) {
			this.lblvoucherno = lblvoucherno;
		}

		public String getLblrefno() {
			return lblrefno;
		}

		public void setLblrefno(String lblrefno) {
			this.lblrefno = lblrefno;
		}

		public String getLblnetamount() {
			return lblnetamount;
		}

		public void setLblnetamount(String lblnetamount) {
			this.lblnetamount = lblnetamount;
		}

		public String getLblnetamountwords() {
			return lblnetamountwords;
		}

		public void setLblnetamountwords(String lblnetamountwords) {
			this.lblnetamountwords = lblnetamountwords;
		}

		public String getLbldescription() {
			return lbldescription;
		}

		public void setLbldescription(String lbldescription) {
			this.lbldescription = lbldescription;
		}

		public String getLbldebittotal() {
			return lbldebittotal;
		}

		public void setLbldebittotal(String lbldebittotal) {
			this.lbldebittotal = lbldebittotal;
		}

		public String getLblcredittotal() {
			return lblcredittotal;
		}

		public void setLblcredittotal(String lblcredittotal) {
			this.lblcredittotal = lblcredittotal;
		}

		public String getLblpreparedby() {
			return lblpreparedby;
		}

		public void setLblpreparedby(String lblpreparedby) {
			this.lblpreparedby = lblpreparedby;
		}

		public String getLblpreparedon() {
			return lblpreparedon;
		}

		public void setLblpreparedon(String lblpreparedon) {
			this.lblpreparedon = lblpreparedon;
		}

		public String getLblpreparedat() {
			return lblpreparedat;
		}

		public void setLblpreparedat(String lblpreparedat) {
			this.lblpreparedat = lblpreparedat;
		}

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
		String srvdetmdocno=request.getParameter("docno");
		String srvdetmtrno=request.getParameter("trno");
		String dtype=request.getParameter("dtype");
		ClsAmountToWords objamt=new com.common.ClsAmountToWords();
		//System.out.println("srvdetmtrno--->>>"+srvdetmtrno);          
		//System.out.println("srvdetmdocno--->>>"+srvdetmdocno);
		String tranno="0",docanno="0";
		String[] docanarray = srvdetmdocno.split(",");  
		String[] tranarray = srvdetmtrno.split(",");
			int aaa= 0;   
			for (int i = 0; i < docanarray.length; i++) {
				 docanno=docanarray[i];
				 }     
		   
		int header=Integer.parseInt(request.getParameter("header"));
		String branch=request.getParameter("branch");  
		 
		journalVouchersBean=jvlistDAO.getPrint(request,docanno,branch,header,dtype);
		
		setLblcompname(journalVouchersBean.getLblcompname());
		setLblcompaddress(journalVouchersBean.getLblcompaddress());      
		setLblpobox(journalVouchersBean.getLblpobox());
		setLblprintname(journalVouchersBean.getLblprintname());
		setLblcomptel(journalVouchersBean.getLblcomptel());
		setLblcompfax(journalVouchersBean.getLblcompfax());
		setLblbranch(journalVouchersBean.getLblbranch());
		setLbllocation(journalVouchersBean.getLbllocation());
		setLblservicetax(journalVouchersBean.getLblservicetax());
		setLblpan(journalVouchersBean.getLblpan());
		setLblcstno(journalVouchersBean.getLblcstno());

		// for hide
		setFirstarray(journalVouchersBean.getFirstarray());
		setTxtheader(journalVouchersBean.getTxtheader());   
		 System.out.println("in...");
		if(ClsCommon.getPrintPath("JVT").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
	        Connection conn = null;
			 try {
				 param = new HashMap();
	             	 conn = ClsConnection.getMyConnection();    
	             	Statement stmtPC = conn.createStatement();
	             
	             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	               	imgpath=imgpath.replace("\\", "\\\\");
	               	
	               	String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	               	imgpathfooter=imgpathfooter.replace("\\", "\\\\");
	              	
	                 param.put("header", new Integer(header));
			         param.put("imgpath", imgpath);
			         param.put("imgpathfooter", imgpathfooter);
			         
			         param.put("compname", journalVouchersBean.getLblcompname());
			         param.put("compaddress", journalVouchersBean.getLblcompaddress());
			         param.put("comptel", journalVouchersBean.getLblcomptel());
			         param.put("compfax", journalVouchersBean.getLblcompfax());
			         param.put("compbranch", journalVouchersBean.getLblbranch());
			         param.put("location", journalVouchersBean.getLbllocation());
			         param.put("printname", journalVouchersBean.getLblprintname());
			         for (int i = 0; i < tranarray.length; i++) {
						 //tranno=tranarray[i];
						 param.put("p"+i,tranarray[i]);                                       
					 }   
			         
	        	 param.put("doc", new Integer(docanno));
		         param.put("brch", branch); 
		         param.put("objamt", objamt);
		         param.put("dtype", dtype);         
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		   
		       System.out.println("in...end");    
	           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/journalvoucherlist/journalvoucherprint.jrxml"));
	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn);
	                 
	                 
	             } catch (Exception e) {   

	                 e.printStackTrace();

	             }
	            	 finally{
					conn.close();  
				}	  
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
