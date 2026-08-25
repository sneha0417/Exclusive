package com.dashboard.accounts.chequeupdate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsChequeUpdateAction extends ActionSupport{

	ClsConnection connDAO = new ClsConnection();
	ClsChequeUpdateDAO chequeUpdateDAO= new ClsChequeUpdateDAO();
	ClsChequeUpdateBean chequeUpdateBean;
	
	//Cheque Print
	private String lblbankid;
	private String lblbankname;
	private String lblpageheight;
	private String lblpagewidth;
	private String lblpagesheight;
	private String lblpageswidth;
	private String lbldatex;
	private String lbldatey;
	private String lblpaytovertical;
	private String lblpaytohorizontal;
	private String lblpaytolength;
	private String lblaccountpayingx;
	private String lblaccountpayingy;
	private String lblamtwordsvertical;
	private String lblamtwordshorizontal;
	private String lblamtwordslength;
	private String lblamountx;
	private String lblamounty;
	private String lblamtwords1vertical;
	private String lblamtwords1horizontal;
	private String lblamtwords1length;
	
	private String lblchequedate;
	private String lblpaidto;
	private String lblaccountno;
	private String lblamountwords;
	private String lblamountwords1;
	private String lblamount;
	
	private String printurl;
	
	private Map<String, Object> param=null;
	
	public String getLblbankid() {
		return lblbankid;
	}

	public void setLblbankid(String lblbankid) {
		this.lblbankid = lblbankid;
	}

	public String getLblbankname() {
		return lblbankname;
	}

	public void setLblbankname(String lblbankname) {
		this.lblbankname = lblbankname;
	}

	public String getLblpageheight() {
		return lblpageheight;
	}

	public void setLblpageheight(String lblpageheight) {
		this.lblpageheight = lblpageheight;
	}

	public String getLblpagewidth() {
		return lblpagewidth;
	}

	public void setLblpagewidth(String lblpagewidth) {
		this.lblpagewidth = lblpagewidth;
	}

	public String getLblpagesheight() {
		return lblpagesheight;
	}
	
	public void setLblpagesheight(String lblpagesheight) {
		this.lblpagesheight = lblpagesheight;
	}
	
	public String getLblpageswidth() {
		return lblpageswidth;
	}
	
	public void setLblpageswidth(String lblpageswidth) {
		this.lblpageswidth = lblpageswidth;
	}
	
	public String getLbldatex() {
		return lbldatex;
	}

	public void setLbldatex(String lbldatex) {
		this.lbldatex = lbldatex;
	}

	public String getLbldatey() {
		return lbldatey;
	}

	public void setLbldatey(String lbldatey) {
		this.lbldatey = lbldatey;
	}

	public String getLblpaytovertical() {
		return lblpaytovertical;
	}

	public void setLblpaytovertical(String lblpaytovertical) {
		this.lblpaytovertical = lblpaytovertical;
	}

	public String getLblpaytohorizontal() {
		return lblpaytohorizontal;
	}

	public void setLblpaytohorizontal(String lblpaytohorizontal) {
		this.lblpaytohorizontal = lblpaytohorizontal;
	}

	public String getLblpaytolength() {
		return lblpaytolength;
	}

	public void setLblpaytolength(String lblpaytolength) {
		this.lblpaytolength = lblpaytolength;
	}

	public String getLblaccountpayingx() {
		return lblaccountpayingx;
	}

	public void setLblaccountpayingx(String lblaccountpayingx) {
		this.lblaccountpayingx = lblaccountpayingx;
	}

	public String getLblaccountpayingy() {
		return lblaccountpayingy;
	}

	public void setLblaccountpayingy(String lblaccountpayingy) {
		this.lblaccountpayingy = lblaccountpayingy;
	}

	public String getLblamtwordsvertical() {
		return lblamtwordsvertical;
	}

	public void setLblamtwordsvertical(String lblamtwordsvertical) {
		this.lblamtwordsvertical = lblamtwordsvertical;
	}

	public String getLblamtwordshorizontal() {
		return lblamtwordshorizontal;
	}

	public void setLblamtwordshorizontal(String lblamtwordshorizontal) {
		this.lblamtwordshorizontal = lblamtwordshorizontal;
	}

	public String getLblamtwordslength() {
		return lblamtwordslength;
	}

	public void setLblamtwordslength(String lblamtwordslength) {
		this.lblamtwordslength = lblamtwordslength;
	}

	public String getLblamountx() {
		return lblamountx;
	}

	public void setLblamountx(String lblamountx) {
		this.lblamountx = lblamountx;
	}

	public String getLblamounty() {
		return lblamounty;
	}

	public void setLblamounty(String lblamounty) {
		this.lblamounty = lblamounty;
	}

	public String getLblamtwords1vertical() {
		return lblamtwords1vertical;
	}

	public void setLblamtwords1vertical(String lblamtwords1vertical) {
		this.lblamtwords1vertical = lblamtwords1vertical;
	}

	public String getLblamtwords1horizontal() {
		return lblamtwords1horizontal;
	}

	public void setLblamtwords1horizontal(String lblamtwords1horizontal) {
		this.lblamtwords1horizontal = lblamtwords1horizontal;
	}

	public String getLblamtwords1length() {
		return lblamtwords1length;
	}

	public void setLblamtwords1length(String lblamtwords1length) {
		this.lblamtwords1length = lblamtwords1length;
	}

	public String getLblchequedate() {
		return lblchequedate;
	}

	public void setLblchequedate(String lblchequedate) {
		this.lblchequedate = lblchequedate;
	}

	public String getLblpaidto() {
		return lblpaidto;
	}

	public void setLblpaidto(String lblpaidto) {
		this.lblpaidto = lblpaidto;
	}

	public String getLblaccountno() {
		return lblaccountno;
	}

	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}

	public String getLblamountwords() {
		return lblamountwords;
	}

	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}

	public String getLblamountwords1() {
		return lblamountwords1;
	}

	public void setLblamountwords1(String lblamountwords1) {
		this.lblamountwords1 = lblamountwords1;
	}

	public String getLblamount() {
		return lblamount;
	}

	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}
	
	public String getPrinturl() {
		return printurl;
	}
	
	public void setPrinturl(String printurl) {
		this.printurl = printurl;
	}
	
	public Map<String, Object> getParam() {
		return param;
	}
	
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	/*Multiple Print Constructor*/
	public ClsChequeUpdateAction(){}
	/*Multiple Print Constructor*/
	
	/*Multiple Print */
	public ClsChequeUpdateAction(String lblpageheight,String lblpagewidth,String lblpagesheight,String lblpageswidth,String lbldatex,
			String lbldatey,String lblpaytovertical,String lblpaytohorizontal,String lblpaytolength,String lblaccountpayingx,String lblaccountpayingy,String lblamtwordsvertical,
			String lblamtwordshorizontal,String lblamtwordslength,String lblamountx,String lblamounty,String lblamtwords1vertical,String lblamtwords1horizontal,
			String lblamtwords1length,String lblchequedate,String lblpaidto,String lblamountwords,String lblamountwords1,String lblamount ) {
		
		this.lblpageheight = lblpageheight;
		this.lblpagewidth = lblpagewidth;
		this.lblpagesheight = lblpagesheight;
		this.lblpageswidth = lblpageswidth;
		this.lbldatex = lbldatex;
		this.lbldatey = lbldatey;
		this.lblpaytovertical = lblpaytovertical;
		this.lblpaytohorizontal = lblpaytohorizontal;
		this.lblpaytolength = lblpaytolength;
		this.lblaccountpayingx = lblaccountpayingx;
		this.lblaccountpayingy = lblaccountpayingy;
		this.lblamtwordsvertical = lblamtwordsvertical;
		this.lblamtwordshorizontal = lblamtwordshorizontal;
		this.lblamtwordslength = lblamtwordslength;
		this.lblamountx = lblamountx;
		this.lblamounty = lblamounty;
		this.lblamtwords1vertical = lblamtwords1vertical;
		this.lblamtwords1horizontal = lblamtwords1horizontal;
		this.lblamtwords1length = lblamtwords1length;
		this.lblchequedate = lblchequedate;
		this.lblpaidto = lblpaidto;
		this.lblamountwords = lblamountwords;
		this.lblamountwords1 = lblamountwords1;
		this.lblamount = lblamount;

	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String acno=request.getParameter("acno");
		String docno=request.getParameter("docno");
		String dtype=request.getParameter("dtype");
		String branch=request.getParameter("branch");
		chequeUpdateBean=chequeUpdateDAO.getPrint(acno,docno,dtype,branch);
		setLblbankid(chequeUpdateBean.getLblbankid());
		setLblbankname(chequeUpdateBean.getLblbankname());
		setLblpageswidth(chequeUpdateBean.getLblpageswidth());
		setLblpagesheight(chequeUpdateBean.getLblpagesheight());
		setLblpagewidth(chequeUpdateBean.getLblpagewidth());
		setLblpageheight(chequeUpdateBean.getLblpageheight());
		setLbldatex(chequeUpdateBean.getLbldatex());
		setLbldatey(chequeUpdateBean.getLbldatey());
		setLblpaytovertical(chequeUpdateBean.getLblpaytovertical());
		setLblpaytohorizontal(chequeUpdateBean.getLblpaytohorizontal());
		setLblpaytolength(chequeUpdateBean.getLblpaytolength());
		setLblaccountpayingx(chequeUpdateBean.getLblaccountpayingx());
		setLblaccountpayingy(chequeUpdateBean.getLblaccountpayingy());
		setLblamtwordsvertical(chequeUpdateBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(chequeUpdateBean.getLblamtwordshorizontal());
		setLblamtwordslength(chequeUpdateBean.getLblamtwordslength());
		setLblamountx(chequeUpdateBean.getLblamountx());
		setLblamounty(chequeUpdateBean.getLblamounty());
		setLblamtwords1vertical(chequeUpdateBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(chequeUpdateBean.getLblamtwords1horizontal());
		setLblamtwords1length(chequeUpdateBean.getLblamtwords1length());
		
		setLblchequedate(chequeUpdateBean.getLblchequedate());
		setLblpaidto(chequeUpdateBean.getLblpaidto());
		setLblaccountno(chequeUpdateBean.getLblaccountno());
		setLblamountwords(chequeUpdateBean.getLblamountwords());
		setLblamountwords1(chequeUpdateBean.getLblamountwords1());
		setLblamount(chequeUpdateBean.getLblamount());
		setPrinturl(chequeUpdateBean.getPrinturl());
		
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("multichqprintsql", request.getAttribute("multichequeprintingsql").toString());
				 param.put("multichequeprintcount", Integer.parseInt(request.getAttribute("multichequeprintingcount").toString()));
				 	        	 
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getPrinturl()));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn);

			} catch (Exception e) {
	              e.printStackTrace();
	              conn.close();
	      	} finally{
	      		conn.close();
	      	}
            
		}
		
		return "print";
	}
	
	/*Multiple Print ENDS*/
	
	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype");
		int branch=Integer.parseInt(request.getParameter("branch"));
		chequeUpdateBean=chequeUpdateDAO.getChequePrint(docno,dtype,branch);
		setLblbankid(chequeUpdateBean.getLblbankid());
		setLblbankname(chequeUpdateBean.getLblbankname());
		setLblpageswidth(chequeUpdateBean.getLblpageswidth());
		setLblpagesheight(chequeUpdateBean.getLblpagesheight());
		setLblpagewidth(chequeUpdateBean.getLblpagewidth());
		setLblpageheight(chequeUpdateBean.getLblpageheight());
		setLbldatex(chequeUpdateBean.getLbldatex());
		setLbldatey(chequeUpdateBean.getLbldatey());
		setLblpaytovertical(chequeUpdateBean.getLblpaytovertical());
		setLblpaytohorizontal(chequeUpdateBean.getLblpaytohorizontal());
		setLblpaytolength(chequeUpdateBean.getLblpaytolength());
		setLblaccountpayingx(chequeUpdateBean.getLblaccountpayingx());
		setLblaccountpayingy(chequeUpdateBean.getLblaccountpayingy());
		setLblamtwordsvertical(chequeUpdateBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(chequeUpdateBean.getLblamtwordshorizontal());
		setLblamtwordslength(chequeUpdateBean.getLblamtwordslength());
		setLblamountx(chequeUpdateBean.getLblamountx());
		setLblamounty(chequeUpdateBean.getLblamounty());
		setLblamtwords1vertical(chequeUpdateBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(chequeUpdateBean.getLblamtwords1horizontal());
		setLblamtwords1length(chequeUpdateBean.getLblamtwords1length());
		
		setLblchequedate(chequeUpdateBean.getLblchequedate());
		setLblpaidto(chequeUpdateBean.getLblpaidto());
		setLblaccountno(chequeUpdateBean.getLblaccountno());
		setLblamountwords(chequeUpdateBean.getLblamountwords());
		setLblamountwords1(chequeUpdateBean.getLblamountwords1());
		setLblamount(chequeUpdateBean.getLblamount());
		setPrinturl(chequeUpdateBean.getPrinturl());
		
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", chequeUpdateBean.getLblchequedate());
				 param.put("payto", chequeUpdateBean.getLblpaidto());
				 param.put("amountinwords", chequeUpdateBean.getLblamountwords()+" "+(chequeUpdateBean.getLblamountwords1()==null?" ":chequeUpdateBean.getLblamountwords1()));
				 param.put("amount", "#"+chequeUpdateBean.getLblamount()+"#");
	        	 
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getPrinturl()));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn);

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
