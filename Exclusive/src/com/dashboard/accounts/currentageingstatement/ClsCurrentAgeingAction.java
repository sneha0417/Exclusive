package com.dashboard.accounts.currentageingstatement;

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

public class ClsCurrentAgeingAction extends ActionSupport{
    
	ClsCurrentAgeingDAO currentAgeingStatementDAO= new ClsCurrentAgeingDAO();
	ClsCurrentAgeingBean currentAgeingStatementBean;
	
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
	private String lbllevel1from;
	private String lbllevel1to;
	private String lbllevel2from;
	private String lbllevel2to;
	private String lbllevel3from;
	private String lbllevel3to;
	private String lbllevel4from;
	private String lbllevel4to;
	private String lbllevel5from;
	private String pqry;
	private String url;
	private Map<String, Object> param=null;
	
	
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
	
	public String getLbllevel1from() {
		return lbllevel1from;
	}

	public void setLbllevel1from(String lbllevel1from) {
		this.lbllevel1from = lbllevel1from;
	}

	public String getLbllevel1to() {
		return lbllevel1to;
	}

	public void setLbllevel1to(String lbllevel1to) {
		this.lbllevel1to = lbllevel1to;
	}

	public String getLbllevel2from() {
		return lbllevel2from;
	}

	public void setLbllevel2from(String lbllevel2from) {
		this.lbllevel2from = lbllevel2from;
	}

	public String getLbllevel2to() {
		return lbllevel2to;
	}

	public void setLbllevel2to(String lbllevel2to) {
		this.lbllevel2to = lbllevel2to;
	}

	public String getLbllevel3from() {
		return lbllevel3from;
	}

	public void setLbllevel3from(String lbllevel3from) {
		this.lbllevel3from = lbllevel3from;
	}

	public String getLbllevel3to() {
		return lbllevel3to;
	}

	public void setLbllevel3to(String lbllevel3to) {
		this.lbllevel3to = lbllevel3to;
	}

	public String getLbllevel4from() {
		return lbllevel4from;
	}

	public void setLbllevel4from(String lbllevel4from) {
		this.lbllevel4from = lbllevel4from;
	}

	public String getLbllevel4to() {
		return lbllevel4to;
	}

	public void setLbllevel4to(String lbllevel4to) {
		this.lbllevel4to = lbllevel4to;
	}

	public String getLbllevel5from() {
		return lbllevel5from;
	}

	public void setLbllevel5from(String lbllevel5from) {
		this.lbllevel5from = lbllevel5from;
	}
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		  HttpSession session=request.getSession();
		 ClsCommon common=new ClsCommon();
		 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	     String atype = request.getParameter("atype"); 
	     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
	     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
	     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	     String level1From = request.getParameter("level1from")==null?"0":request.getParameter("level1from").trim();
	     String level1To = request.getParameter("level1to")==null?"0":request.getParameter("level1to").trim();
	     String level2From = request.getParameter("level2from")==null?"0":request.getParameter("level2from").trim();
	     String level2To = request.getParameter("level2to")==null?"0":request.getParameter("level2to").trim();
	     String level3From = request.getParameter("level3from")==null?"0":request.getParameter("level3from").trim();
	     String level3To = request.getParameter("level3to")==null?"0":request.getParameter("level3to").trim();
	     String level4From = request.getParameter("level4from")==null?"0":request.getParameter("level4from").trim();
	     String level4To = request.getParameter("level4to")==null?"0":request.getParameter("level4to").trim();
	     String level5From = request.getParameter("level5from")==null?"0":request.getParameter("level5from").trim();
	     String check= request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
		 
	     if(branchval.equalsIgnoreCase("a")){
	    	 branchval="a";
	     }
	     
		 System.out.println("Inside action ");
		 /*System.out.println("looooooooooooooogo="+logo);*/
		 ClsCurrentAgeingDAO DAO=new ClsCurrentAgeingDAO();
		 ClsCurrentAgeingBean printbean= new ClsCurrentAgeingBean();
		 
		 printbean=DAO.getPrint(branchval, upToDate, atype, accdocno, salesperson, category, level1From, level1To, level2From, level2To, level3From, level3To, level4From, level4To, level5From,check);
		 setUrl(common.getPrintPath("currentageing.jrxml"));
      	  // System.out.println("iside jrxml");
      	   ClsConnection conobj=new ClsConnection();
											 
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	   String reportFileName = "Current Ageing";
      	   try {
      		   
      		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
      		   imgpath=imgpath.replace("\\", "\\\\");    
      		   param.put("imgpath", imgpath);
      		   param.put("pqry",printbean.getPqry());
      		 param.put("compname", printbean.getLblcompname());
             param.put("compaddress", printbean.getLblcompaddress());
             param.put("comptel", printbean.getLblcomptel());
             param.put("compfax", printbean.getLblcompfax());
             param.put("compbranch", printbean.getLblbranch());
             param.put("printby", session.getAttribute("USERNAME"));
             param.put("printname", "Current Ageing");
             param.put("subprintname", "");
      		 
      		   
      		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/currentageingstatement/currentageing.jrxml"));	      	     	 
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