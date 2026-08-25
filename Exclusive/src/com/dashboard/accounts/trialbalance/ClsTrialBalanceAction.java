package com.dashboard.accounts.trialbalance;

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

public class ClsTrialBalanceAction extends ActionSupport{
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
    
	ClsTrialBalance trialbalanceDAO= new ClsTrialBalance();
	ClsTrialBalanceBean trailbalanceBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblsubprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblsubprintname() {
		return lblsubprintname;
	}
	public void setLblsubprintname(String lblsubprintname) {
		this.lblsubprintname = lblsubprintname;
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
				
		String barchval = request.getParameter("barchval");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String acctype = request.getParameter("acctype");
		String includingzero = request.getParameter("includingzero");
		
		trailbalanceBean=trialbalanceDAO.getPrint(request,barchval,fromdate,todate,acctype,includingzero);
		setLblcompname(trailbalanceBean.getLblcompname());
		setLblcompaddress(trailbalanceBean.getLblcompaddress());
		setLblprintname(trailbalanceBean.getLblprintname());
		setLblcomptel(trailbalanceBean.getLblcomptel());
		setLblcompfax(trailbalanceBean.getLblcompfax());
		setLblbranch(trailbalanceBean.getLblbranch());
		setLbllocation(trailbalanceBean.getLbllocation());
		
		if(ClsCommon.getBIBPrintPath("BTB").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
			 try {
				 param = new HashMap();
			
		      	 conn = ClsConnection.getMyConnection();
             	 Statement stmtPC = conn.createStatement();
             	 String reportFileName = ClsCommon.getBIBPrintPath("BTB");
                 
                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	 
               	 String sqlTotal = "";
               	
               	 if(acctype.equalsIgnoreCase("")) {
               		 sqlTotal = "select format(round((sum(opening_dr)/2),2),2) opening_dr,format(round((sum(opening_cr)/2),2),2) opening_cr,format(round((sum(transaction_dr)/2),2),2) transaction_dr,format(round((sum(transaction_cr)/2),2),2) transaction_cr,format(round((sum(netbalance_dr)/2),2),2) netbalance_dr,format(round((sum(netbalance_cr)/2),2),2) netbalance_cr from Tialbalance";
               	 } else {
               		sqlTotal = "select format(round((sum(opening_dr)),2),2) opening_dr,format(round((sum(opening_cr)),2),2) opening_cr,format(round((sum(transaction_dr)),2),2) transaction_dr,format(round((sum(transaction_cr)),2),2) transaction_cr,format(round((sum(netbalance_dr)),2),2) netbalance_dr,format(round((sum(netbalance_cr)),2),2) netbalance_cr from Tialbalance";
               	 }
	             
				 ResultSet resultSetTotal = stmtPC.executeQuery(sqlTotal);
					
				 String openingdrtotal="0.00",openingcrtotal="0.00",transactiondrtotal="0.00",transactioncrtotal="0.00",netbalancedrtotal="0.00",netbalancecrtotal="0.00";
				 while(resultSetTotal.next()){
					 openingdrtotal=resultSetTotal.getString("opening_dr");
					 openingcrtotal=resultSetTotal.getString("opening_cr");
					 transactiondrtotal=resultSetTotal.getString("transaction_dr");
					 transactioncrtotal=resultSetTotal.getString("transaction_cr");
					 netbalancedrtotal=resultSetTotal.getString("netbalance_dr");
					 netbalancecrtotal=resultSetTotal.getString("netbalance_cr");
				 }
               	 
               	 param.put("openingdrtot", openingdrtotal);
               	 param.put("openingcrtot", openingcrtotal);
               	 param.put("transactionsdrtot", transactiondrtotal);
               	 param.put("transactionscrtot", transactioncrtotal);
               	 param.put("netbalancedrtot", netbalancedrtotal);
               	 param.put("netbalancecrtot", netbalancecrtotal);
		         param.put("imgpath", imgpath);
		         param.put("printname", trailbalanceBean.getLblprintname());
		         param.put("subprintname", trailbalanceBean.getLblsubprintname());
		         param.put("compname", trailbalanceBean.getLblcompname());
		         param.put("compaddress", trailbalanceBean.getLblcompaddress());
		         param.put("comptel", trailbalanceBean.getLblcomptel());
		         param.put("compfax", trailbalanceBean.getLblcompfax());
		         param.put("compbranch", trailbalanceBean.getLblbranch());
		         param.put("location", trailbalanceBean.getLbllocation());
		         param.put("printname", trailbalanceBean.getLblprintname()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		        
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
         	 
                JasperReport jasperReport = JasperCompileManager.compileReport(design);
                generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
                     e.printStackTrace();
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