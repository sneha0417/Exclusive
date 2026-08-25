package com.dashboard.accounts.individualageing;

import java.sql.Connection;
import java.sql.SQLException;
import java.io.IOException;
import java.text.ParseException;
import java.util.Map;
import java.util.HashMap;
import javax.naming.NamingException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsIndividualAgeingAction extends ActionSupport{
    
	ClsIndividualAgeing ClsIndividualAgeingDAO= new ClsIndividualAgeing();
	ClsIndividualAgeingBean ClsIndividualAgeingBean;
	
	//Print
	private String companyname;
	private String address;
	private String mobileno;
	private String branchname;
	private String lbldate;
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountmobileno;
	private String lblcurrencycode;
	private String pqry;
	private String url;
	private String uptodate;
	private Map<String, Object> param=null;
	
	
	
	
	public String getUptodate() {
		return uptodate;
	}
	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}
	public String getPqry() {
		return pqry;
	}
	public void setPqry(String pqry) {
		this.pqry = pqry;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
			 
	 public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobileno() {
		return mobileno;
	}

	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}

	public String getBranchname() {
		return branchname;
	}

	public void setBranchname(String branchname) {
		this.branchname = branchname;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblaccountname() {
		return lblaccountname;
	}

	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}

	public String getLblaccountaddress() {
		return lblaccountaddress;
	}

	public void setLblaccountaddress(String lblaccountaddress) {
		this.lblaccountaddress = lblaccountaddress;
	}

	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}

	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
	}

	public String getLblcurrencycode() {
		return lblcurrencycode;
	}

	public void setLblcurrencycode(String lblcurrencycode) {
		this.lblcurrencycode = lblcurrencycode;
	}

	public String saveAction() throws ParseException, SQLException{
		return lblaccountname;
	}
	
		
	public String printAction() throws ParseException, SQLException{
		//System.out.println("Inside action 1 ");
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		  HttpSession session=request.getSession();
		 ClsCommon common=new ClsCommon();
		 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	     String atype = request.getParameter("atype"); 
	     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
	     
	     String check= request.getParameter("pqry")==null?"0":request.getParameter("check").trim(); 
		 
	     if(branchval.equalsIgnoreCase("a")){
	    	 branchval="a";
	     }
	     
		 //System.out.println("Inside action 2");
		 /*System.out.println("looooooooooooooogo="+logo);*/
		 ClsIndividualAgeing DAO=new ClsIndividualAgeing();
		 ClsIndividualAgeingBean printbean= new ClsIndividualAgeingBean();
		 //System.out.println("Inside action 3");
		 printbean=DAO.getPrint(branchval, upToDate, atype, accdocno, check);
		 //System.out.println("Inside action 4");
		 setUrl(common.getBIBPrintPath("IDA"));
      	  // System.out.println("iside jrxml");
      	  
      	   
      	   if(true){
      		 ClsConnection conobj=new ClsConnection();							 
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	   String reportFileName = "Individual Ageing"; 
      	   try {
      		   
      		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
      		   imgpath=imgpath.replace("\\", "\\\\");    
      		   
      		 String imgheader=request.getSession().getServletContext().getRealPath("/icons/city1header.jpg");
      		imgheader=imgheader.replace("\\", "\\\\");    
    		   
      		   param.put("imgheader", imgheader);
      		   param.put("imgpath", imgpath);
      		   param.put("pqry",printbean.getPqry());
      		 //System.out.println("pqry--->"+printbean.getPqry());
      		 param.put("compname", printbean.getLblcompname());
      		 //System.out.println("compname--->"+printbean.getLblcompname());
             param.put("compaddress", printbean.getLblcompaddress());
             param.put("comptel", printbean.getLblcomptel());
             param.put("compfax", printbean.getLblcompfax());
             param.put("compbranch", printbean.getLblbranch());
             param.put("printby", session.getAttribute("USERNAME"));
             param.put("printname", "Individual Ageing");
             param.put("uptodate", printbean.getUptodate());
             param.put("subprintname", "");
      		 
      		   
      		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(common.getBIBPrintPath("IDA")));	      	     	 
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