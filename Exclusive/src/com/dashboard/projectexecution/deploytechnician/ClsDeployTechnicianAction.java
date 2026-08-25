package com.dashboard.projectexecution.deploytechnician;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
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

public class ClsDeployTechnicianAction extends ActionSupport{
    
	ClsDeployTechnicianDAO deployTechnicianDAO= new ClsDeployTechnicianDAO();
	ClsDeployTechnicianBean deployTechnicianBean;
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private Map<String, Object> param = null;
	
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

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        param = new HashMap();
	        
			String date = request.getParameter("date");
			String employeedocno = request.getParameter("employeedocno");
			String jobno = request.getParameter("jobno");
			
			if(!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))){
				sqlDate = commonDAO.changeStringtoSqlDate(date);
	        }
			
			deployTechnicianBean=deployTechnicianDAO.getPrint(request,date,employeedocno,jobno);
			
			String reportFileName = commonDAO.getBIBPrintPath("BDT");
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            String sql1="";
            
            if(!(sqlDate==null)){
	        	sql1+=" and m.date='"+sqlDate+"'";
		    }
            
            if(!(employeedocno.equalsIgnoreCase("") || employeedocno.equalsIgnoreCase("0"))){
            	sql1+=" and m.empid='"+employeedocno+"'";
            }
            
            if(!(jobno.equalsIgnoreCase("") || jobno.equalsIgnoreCase("0"))){
            	sql1+=" and m.costcode='"+jobno+"'";
            }
            
            String sqlJob = "select DATE_FORMAT(m.date,'%d-%m-%Y') date,CASE WHEN m.costtype=3 THEN 'AMC' WHEN m.costtype=4 THEN 'SJOB' ELSE '' END AS jobtype,coalesce(m.costcode,'') jobno,e.name,coalesce(m.sitename,'') site,m.intime fromtime,m.outtime totime from cm_deploytechd m "
            		+ "left join hr_empm e on m.empid=e.doc_no where 1=1"+sql1+"";
            
            param.put("imgpath", imgpath);
            param.put("compname", deployTechnicianBean.getLblcompname());
            param.put("compaddress", deployTechnicianBean.getLblcompaddress());
            param.put("comptel", deployTechnicianBean.getLblcomptel());
            param.put("compfax", deployTechnicianBean.getLblcompfax());
            param.put("compbranch", deployTechnicianBean.getLblbranch());
            param.put("location", deployTechnicianBean.getLbllocation());
            param.put("printname", deployTechnicianBean.getLblprintname());
            param.put("subprintname", deployTechnicianBean.getLblprintname1());
            param.put("jobdetailssql", sqlJob);
	        param.put("printby", session.getAttribute("USERNAME"));
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
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