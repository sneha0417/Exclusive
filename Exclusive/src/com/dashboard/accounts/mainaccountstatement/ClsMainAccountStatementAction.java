package com.dashboard.accounts.mainaccountstatement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsMainAccountStatementAction extends ActionSupport{
    
	ClsMainAccountStatementDAO mainAccountStatementDAO= new ClsMainAccountStatementDAO();
	ClsMainAccountStatementBean mainAccountStatementBean;
	
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private double txtnetamount;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String fromdate;
	private String todate;
	private String accountno;
	private String accountname;
	private String date;
	private String type;
	private String docno;
	private String description;
	private String debit;
	private String credit;
	private String lblnetamount;
	
	private Map<String, Object> param = null;
	
	public double getTxtnetamount() {
		return txtnetamount;
	}
	public void setTxtnetamount(double txtnetamount) {
		this.txtnetamount = txtnetamount;
	}
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getAccountno() {
		return accountno;
	}
	public void setAccountno(String accountno) {
		this.accountno = accountno;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDebit() {
		return debit;
	}
	public void setDebit(String debit) {
		this.debit = debit;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String saveAction() throws ParseException, SQLException{
		return accountname;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String atype = request.getParameter("type");
		String acno=request.getParameter("acno");
		String branch = request.getParameter("branch");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String includingzero = request.getParameter("includingzero");
		mainAccountStatementBean=mainAccountStatementDAO.getPrint(request,acno,atype,branch,fromDate,toDate,includingzero);
		
		String reportFileName = commonDAO.getBIBPrintPath("BMAS");
		
		setLblcompname(mainAccountStatementBean.getLblcompname());
		setLblcompaddress(mainAccountStatementBean.getLblcompaddress());
		setLblpobox(mainAccountStatementBean.getLblpobox());
		setLblprintname(mainAccountStatementBean.getLblprintname());
		setLblprintname1(mainAccountStatementBean.getLblprintname1());
		setLblcomptel(mainAccountStatementBean.getLblcomptel());
		setLblcompfax(mainAccountStatementBean.getLblcompfax());
		setLblbranch(mainAccountStatementBean.getLblbranch());
		setLbllocation(mainAccountStatementBean.getLbllocation());
		setLblservicetax(mainAccountStatementBean.getLblservicetax());
		setLblpan(mainAccountStatementBean.getLblpan());
		setLblcstno(mainAccountStatementBean.getLblcstno());
		setAccountname(mainAccountStatementBean.getAccountname());
		setLblnetamount(mainAccountStatementBean.getLblnetamount());

		if(reportFileName.contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 Statement stmtMainAccountStatement1 =conn.createStatement();
				 param = new HashMap();
            
				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");
	             
	             String sqlTotal = "";
	             if(!((acno.equalsIgnoreCase("")) || (acno.equalsIgnoreCase("0")))){
	                 sqlTotal = "select format(round(sum(opening_dr),2),2) opening_dr,format(round(sum(opening_cr),2),2) opening_cr,format(round(sum(transaction_dr),2),2) transaction_dr,format(round(sum(transaction_cr),2),2) transaction_cr,format(round(sum(netbalance_dr),2),2) netbalance_dr,format(round(sum(netbalance_cr),2),2) netbalance_cr,format(round(sum(netbalance_dr)-sum(netbalance_cr),2),2) nettotal from gl_bmainaccountstatement";
	             } else {
	            	 sqlTotal = "select format(round((sum(opening_dr)/2),2),2) opening_dr,format(round((sum(opening_cr)/2),2),2) opening_cr,format(round((sum(transaction_dr)/2),2),2) transaction_dr,format(round((sum(transaction_cr)/2),2),2) transaction_cr,format(round((sum(netbalance_dr)/2),2),2) netbalance_dr,format(round((sum(netbalance_cr)/2),2),2) netbalance_cr,format(round((sum(netbalance_dr)-sum(netbalance_cr))/2,2),2) nettotal from gl_bmainaccountstatement";
	             }
				 ResultSet resultSetTotal = stmtMainAccountStatement1.executeQuery(sqlTotal);
					
				 String openingdrtotal="0.00",openingcrtotal="0.00",transactiondrtotal="0.00",transactioncrtotal="0.00",netbalancedrtotal="0.00",netbalancecrtotal="0.00",nettotal="0.00";
				 while(resultSetTotal.next()){
					 openingdrtotal=resultSetTotal.getString("opening_dr");
					 openingcrtotal=resultSetTotal.getString("opening_cr");
					 transactiondrtotal=resultSetTotal.getString("transaction_dr");
					 transactioncrtotal=resultSetTotal.getString("transaction_cr");
					 netbalancedrtotal=resultSetTotal.getString("netbalance_dr");
					 netbalancecrtotal=resultSetTotal.getString("netbalance_cr");
					 nettotal=resultSetTotal.getString("nettotal");
				 }
					
	             param.put("imgpath", imgpath);
	             param.put("compname", mainAccountStatementBean.getLblcompname());
	             param.put("compaddress", mainAccountStatementBean.getLblcompaddress());
	             param.put("comptel", mainAccountStatementBean.getLblcomptel());
	             param.put("compfax", mainAccountStatementBean.getLblcompfax());
	             param.put("printname", mainAccountStatementBean.getLblprintname());
	             param.put("subprintname", mainAccountStatementBean.getLblprintname1());
	             param.put("account", mainAccountStatementBean.getAccountno());
	             param.put("openingdrtot", openingdrtotal);
	             param.put("openingcrtot", openingcrtotal);
	             param.put("transactionsdrtot", transactiondrtotal);
	             param.put("transactionscrtot", transactioncrtotal);
	             param.put("netbalancedrtot", netbalancedrtotal);
	             param.put("netbalancecrtot", netbalancecrtotal);
	             param.put("nettotal", nettotal);
	             param.put("printby", session.getAttribute("USERNAME"));
	             
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn);

				 stmtMainAccountStatement1.close();
			} catch (Exception e) {
	              e.printStackTrace();
	              conn.close();
	      	} finally{
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