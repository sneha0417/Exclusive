package com.humanresource.transactions.leavetraveldisbursement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
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
public class ClsLeaveTravelDisbursementAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();

	ClsLeaveTravelDisbursementDAO leaveTravelDisbursementDAO= new ClsLeaveTravelDisbursementDAO();
	ClsLeaveTravelDisbursementBean leaveTravelDisbursementBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String brchName;
	private String leaveTravelDisbursementDate;
	private String hidleaveTravelDisbursementDate;
	private String notifyDate;
	private String hidnotifyDate;
	private int txtleavetraveldisbursementdocno;
	private String txtemployeeid;
	private String txtemployeename;
	private int txtemployeedocno;	
	private double txtalreadyprovisioneligibledays;
	private double txtcurrentprovisioneligibledays;
	private double txttotaleligibledays;
	private double txtleavesalarycalculated;
	private double txtleavesalaryalreadyprovided;
	private double txtleavesalarynettobeprovided;
	private double txtleavesalarytobepaid;
	private double txtleavesalarypaideligibledays;
	private int chckpartialpayment;
	private int hidchckpartialpayment;
	private double txttravelticketvalue;
	private double txttravelalreadyposted;
	private double txttravelcurrentexpenses;	
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	
	//Account Details Grid 
	private int gridlength;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
	private String lbldate;
	private String lblcalculatedupto;
	private String lbldocno;
	private String lblemployeename;
	private String lblalreadyprovisioneligibledays;
	private String lblcurrentprovisioneligibledays;
	private String lbltotaleligibledays;
	private String lblleavesalarycalculated;
	private String lblleavesalaryalreadyprovided;
	private String lblleavesalarynettobeprovided;
	private String lblleavesalarytobepaid;
	private String lbltravelticketvalue;
	private String lbltravelalreadyposted;
	private String lbltravelcurrentexpenses;	
	private String lbldrtotal;
	private String lblcrtotal;
	private String lbltrno;
	
	private Map<String, Object> param = null;

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getLeaveTravelDisbursementDate() {
		return leaveTravelDisbursementDate;
	}

	public void setLeaveTravelDisbursementDate(String leaveTravelDisbursementDate) {
		this.leaveTravelDisbursementDate = leaveTravelDisbursementDate;
	}

	public String getHidleaveTravelDisbursementDate() {
		return hidleaveTravelDisbursementDate;
	}

	public void setHidleaveTravelDisbursementDate(
			String hidleaveTravelDisbursementDate) {
		this.hidleaveTravelDisbursementDate = hidleaveTravelDisbursementDate;
	}

	public String getNotifyDate() {
		return notifyDate;
	}

	public void setNotifyDate(String notifyDate) {
		this.notifyDate = notifyDate;
	}

	public String getHidnotifyDate() {
		return hidnotifyDate;
	}

	public void setHidnotifyDate(String hidnotifyDate) {
		this.hidnotifyDate = hidnotifyDate;
	}

	public int getTxtleavetraveldisbursementdocno() {
		return txtleavetraveldisbursementdocno;
	}

	public void setTxtleavetraveldisbursementdocno(
			int txtleavetraveldisbursementdocno) {
		this.txtleavetraveldisbursementdocno = txtleavetraveldisbursementdocno;
	}

	public String getTxtemployeeid() {
		return txtemployeeid;
	}

	public void setTxtemployeeid(String txtemployeeid) {
		this.txtemployeeid = txtemployeeid;
	}

	public String getTxtemployeename() {
		return txtemployeename;
	}

	public void setTxtemployeename(String txtemployeename) {
		this.txtemployeename = txtemployeename;
	}

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public double getTxtalreadyprovisioneligibledays() {
		return txtalreadyprovisioneligibledays;
	}

	public void setTxtalreadyprovisioneligibledays(
			double txtalreadyprovisioneligibledays) {
		this.txtalreadyprovisioneligibledays = txtalreadyprovisioneligibledays;
	}

	public double getTxtcurrentprovisioneligibledays() {
		return txtcurrentprovisioneligibledays;
	}

	public void setTxtcurrentprovisioneligibledays(
			double txtcurrentprovisioneligibledays) {
		this.txtcurrentprovisioneligibledays = txtcurrentprovisioneligibledays;
	}

	public double getTxttotaleligibledays() {
		return txttotaleligibledays;
	}

	public void setTxttotaleligibledays(double txttotaleligibledays) {
		this.txttotaleligibledays = txttotaleligibledays;
	}

	public double getTxtleavesalarycalculated() {
		return txtleavesalarycalculated;
	}

	public void setTxtleavesalarycalculated(double txtleavesalarycalculated) {
		this.txtleavesalarycalculated = txtleavesalarycalculated;
	}

	public double getTxtleavesalaryalreadyprovided() {
		return txtleavesalaryalreadyprovided;
	}

	public void setTxtleavesalaryalreadyprovided(
			double txtleavesalaryalreadyprovided) {
		this.txtleavesalaryalreadyprovided = txtleavesalaryalreadyprovided;
	}

	public double getTxtleavesalarynettobeprovided() {
		return txtleavesalarynettobeprovided;
	}

	public void setTxtleavesalarynettobeprovided(
			double txtleavesalarynettobeprovided) {
		this.txtleavesalarynettobeprovided = txtleavesalarynettobeprovided;
	}

	public double getTxtleavesalarytobepaid() {
		return txtleavesalarytobepaid;
	}

	public void setTxtleavesalarytobepaid(double txtleavesalarytobepaid) {
		this.txtleavesalarytobepaid = txtleavesalarytobepaid;
	}
	
	public double getTxtleavesalarypaideligibledays() {
		return txtleavesalarypaideligibledays;
	}

	public void setTxtleavesalarypaideligibledays(
			double txtleavesalarypaideligibledays) {
		this.txtleavesalarypaideligibledays = txtleavesalarypaideligibledays;
	}

	public int getChckpartialpayment() {
		return chckpartialpayment;
	}

	public void setChckpartialpayment(int chckpartialpayment) {
		this.chckpartialpayment = chckpartialpayment;
	}

	public int getHidchckpartialpayment() {
		return hidchckpartialpayment;
	}

	public void setHidchckpartialpayment(int hidchckpartialpayment) {
		this.hidchckpartialpayment = hidchckpartialpayment;
	}

	public double getTxttravelticketvalue() {
		return txttravelticketvalue;
	}

	public void setTxttravelticketvalue(double txttravelticketvalue) {
		this.txttravelticketvalue = txttravelticketvalue;
	}

	public double getTxttravelalreadyposted() {
		return txttravelalreadyposted;
	}

	public void setTxttravelalreadyposted(double txttravelalreadyposted) {
		this.txttravelalreadyposted = txttravelalreadyposted;
	}

	public double getTxttravelcurrentexpenses() {
		return txttravelcurrentexpenses;
	}

	public void setTxttravelcurrentexpenses(double txttravelcurrentexpenses) {
		this.txttravelcurrentexpenses = txttravelcurrentexpenses;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
	
	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblcalculatedupto() {
		return lblcalculatedupto;
	}

	public void setLblcalculatedupto(String lblcalculatedupto) {
		this.lblcalculatedupto = lblcalculatedupto;
	}

	public String getLbldocno() {
		return lbldocno;
	}

	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}

	public String getLblemployeename() {
		return lblemployeename;
	}

	public void setLblemployeename(String lblemployeename) {
		this.lblemployeename = lblemployeename;
	}

	public String getLblalreadyprovisioneligibledays() {
		return lblalreadyprovisioneligibledays;
	}

	public void setLblalreadyprovisioneligibledays(
			String lblalreadyprovisioneligibledays) {
		this.lblalreadyprovisioneligibledays = lblalreadyprovisioneligibledays;
	}

	public String getLblcurrentprovisioneligibledays() {
		return lblcurrentprovisioneligibledays;
	}

	public void setLblcurrentprovisioneligibledays(
			String lblcurrentprovisioneligibledays) {
		this.lblcurrentprovisioneligibledays = lblcurrentprovisioneligibledays;
	}

	public String getLbltotaleligibledays() {
		return lbltotaleligibledays;
	}

	public void setLbltotaleligibledays(String lbltotaleligibledays) {
		this.lbltotaleligibledays = lbltotaleligibledays;
	}

	public String getLblleavesalarycalculated() {
		return lblleavesalarycalculated;
	}

	public void setLblleavesalarycalculated(String lblleavesalarycalculated) {
		this.lblleavesalarycalculated = lblleavesalarycalculated;
	}

	public String getLblleavesalaryalreadyprovided() {
		return lblleavesalaryalreadyprovided;
	}

	public void setLblleavesalaryalreadyprovided(
			String lblleavesalaryalreadyprovided) {
		this.lblleavesalaryalreadyprovided = lblleavesalaryalreadyprovided;
	}

	public String getLblleavesalarynettobeprovided() {
		return lblleavesalarynettobeprovided;
	}

	public void setLblleavesalarynettobeprovided(
			String lblleavesalarynettobeprovided) {
		this.lblleavesalarynettobeprovided = lblleavesalarynettobeprovided;
	}

	public String getLblleavesalarytobepaid() {
		return lblleavesalarytobepaid;
	}

	public void setLblleavesalarytobepaid(String lblleavesalarytobepaid) {
		this.lblleavesalarytobepaid = lblleavesalarytobepaid;
	}

	public String getLbltravelticketvalue() {
		return lbltravelticketvalue;
	}

	public void setLbltravelticketvalue(String lbltravelticketvalue) {
		this.lbltravelticketvalue = lbltravelticketvalue;
	}

	public String getLbltravelalreadyposted() {
		return lbltravelalreadyposted;
	}

	public void setLbltravelalreadyposted(String lbltravelalreadyposted) {
		this.lbltravelalreadyposted = lbltravelalreadyposted;
	}

	public String getLbltravelcurrentexpenses() {
		return lbltravelcurrentexpenses;
	}

	public void setLbltravelcurrentexpenses(String lbltravelcurrentexpenses) {
		this.lbltravelcurrentexpenses = lbltravelcurrentexpenses;
	}

	public String getLbldrtotal() {
		return lbldrtotal;
	}

	public void setLbldrtotal(String lbldrtotal) {
		this.lbldrtotal = lbldrtotal;
	}

	public String getLblcrtotal() {
		return lblcrtotal;
	}

	public void setLblcrtotal(String lblcrtotal) {
		this.lblcrtotal = lblcrtotal;
	}

	public String getLbltrno() {
		return lbltrno;
	}

	public void setLbltrno(String lbltrno) {
		this.lbltrno = lbltrno;
	}

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	java.sql.Date leaveTravelDisbursementsDate;
	java.sql.Date notifyingDate;
	
	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsLeaveTravelDisbursementBean bean = new ClsLeaveTravelDisbursementBean();

		leaveTravelDisbursementsDate = ClsCommon.changeStringtoSqlDate(getLeaveTravelDisbursementDate());
		notifyingDate = ClsCommon.changeStringtoSqlDate(getNotifyDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Account Grid*/
			ArrayList<String> accountsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				accountsarray.add(temp);
			}
			/*Account Grid Ends*/
			
			int val=leaveTravelDisbursementDAO.insert(getFormdetailcode(),getBrchName(),leaveTravelDisbursementsDate,notifyingDate,getTxtemployeedocno(),getTxtalreadyprovisioneligibledays(),
					getTxtcurrentprovisioneligibledays(),getTxttotaleligibledays(),getTxtleavesalarycalculated(),getTxtleavesalaryalreadyprovided(),getTxtleavesalarynettobeprovided(),
					getHidchckpartialpayment(),getTxtleavesalarytobepaid(),getTxtleavesalarypaideligibledays(),getTxttravelticketvalue(),getTxttravelalreadyposted(),getTxttravelcurrentexpenses(),getTxtdrtotal(),accountsarray,session,request,mode);
			if(val>0.0){
				
				setTxtleavetraveldisbursementdocno(val);
				setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}	
		} else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			leaveTravelDisbursementBean=leaveTravelDisbursementDAO.getViewDetails(session,getTxtleavetraveldisbursementdocno(),getTxttrno());
			
			setLeaveTravelDisbursementDate(leaveTravelDisbursementBean.getLeaveTravelDisbursementDate());
			setNotifyDate(leaveTravelDisbursementBean.getNotifyDate());
			setTxtemployeedocno(leaveTravelDisbursementBean.getTxtemployeedocno());
			setTxtemployeeid(leaveTravelDisbursementBean.getTxtemployeeid());
			setTxtemployeename(leaveTravelDisbursementBean.getTxtemployeename());
			setTxtalreadyprovisioneligibledays(leaveTravelDisbursementBean.getTxtalreadyprovisioneligibledays());
			setTxtcurrentprovisioneligibledays(leaveTravelDisbursementBean.getTxtcurrentprovisioneligibledays());
			setTxttotaleligibledays(leaveTravelDisbursementBean.getTxttotaleligibledays());
			setTxtleavesalarycalculated(leaveTravelDisbursementBean.getTxtleavesalarycalculated());
			setTxtleavesalaryalreadyprovided(leaveTravelDisbursementBean.getTxtleavesalaryalreadyprovided());
			setTxtleavesalarynettobeprovided(leaveTravelDisbursementBean.getTxtleavesalarynettobeprovided());
			setHidchckpartialpayment(leaveTravelDisbursementBean.getChckpartialpayment());
			setTxtleavesalarytobepaid(leaveTravelDisbursementBean.getTxtleavesalarytobepaid());
			setTxtleavesalarypaideligibledays(leaveTravelDisbursementBean.getTxtleavesalarypaideligibledays());
			setTxttravelticketvalue(leaveTravelDisbursementBean.getTxttravelticketvalue());
			setTxttravelalreadyposted(leaveTravelDisbursementBean.getTxttravelalreadyposted());
			setTxttravelcurrentexpenses(leaveTravelDisbursementBean.getTxttravelcurrentexpenses());
			setTxtdrtotal(leaveTravelDisbursementBean.getTxtdrtotal());
			setTxtcrtotal(leaveTravelDisbursementBean.getTxtcrtotal());
			setTxttrno(leaveTravelDisbursementBean.getTxttrno());
			
			setFormdetailcode(leaveTravelDisbursementBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
        
		try {
               
               conn = ClsConnection.getMyConnection();
               param = new HashMap();
               
        	   String trno = request.getParameter("trno");
        	   
               leaveTravelDisbursementBean=leaveTravelDisbursementDAO.getPrint(request,Integer.parseInt(trno),conn);
	       	   
               String reportFileName = "com/humanresource/transactions/leavetraveldisbursement/leaveTravelDisbursement.jrxml";
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
	       		
	           param.put("imgpath", imgpath);
	           param.put("compname", leaveTravelDisbursementBean.getLblcompname());
	           param.put("compaddress", leaveTravelDisbursementBean.getLblcompaddress());
	           param.put("comptel", leaveTravelDisbursementBean.getLblcomptel());
	           param.put("compfax", leaveTravelDisbursementBean.getLblcompfax());
	           param.put("compbranch", leaveTravelDisbursementBean.getLblbranch());
	           param.put("location", leaveTravelDisbursementBean.getLbllocation());
	           param.put("printname", leaveTravelDisbursementBean.getLblprintname());
	           param.put("subprintname", "");
	           
	           param.put("trno", leaveTravelDisbursementBean.getLbltrno());
	           param.put("employeename", leaveTravelDisbursementBean.getLblemployeename());
	           
	           param.put("date", leaveTravelDisbursementBean.getLbldate());
	           param.put("calculatedupto", leaveTravelDisbursementBean.getLblcalculatedupto());
	           param.put("docno", leaveTravelDisbursementBean.getLbldocno());
	           param.put("eligibledaysalreadyprovision", leaveTravelDisbursementBean.getLblalreadyprovisioneligibledays());
	           param.put("eligibledayscurrent", leaveTravelDisbursementBean.getLblcurrentprovisioneligibledays());
	           param.put("totaleligibledays", leaveTravelDisbursementBean.getLbltotaleligibledays());
	           param.put("leavesalarycalculated", leaveTravelDisbursementBean.getLblleavesalarycalculated());
	           param.put("alreadyprovided", leaveTravelDisbursementBean.getLblleavesalaryalreadyprovided());
	           param.put("nettobeprovided", leaveTravelDisbursementBean.getLblleavesalarynettobeprovided());
	           param.put("leavesalarytobepaid", leaveTravelDisbursementBean.getLblleavesalarytobepaid());
	           param.put("ticketvalue", leaveTravelDisbursementBean.getLbltravelticketvalue());
	           param.put("alreadyposted", leaveTravelDisbursementBean.getLbltravelalreadyposted());
	           param.put("currentexpense", leaveTravelDisbursementBean.getLbltravelcurrentexpenses());
	           
		       param.put("debittotal", leaveTravelDisbursementBean.getLbldrtotal());
		       param.put("credittotal", leaveTravelDisbursementBean.getLblcrtotal());
		       param.put("printby", session.getAttribute("USERNAME"));
	        	 
               JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
     	       JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
      
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

	public void setData() {

			if(leaveTravelDisbursementsDate != null){
	    	    setHidleaveTravelDisbursementDate(leaveTravelDisbursementsDate.toString());
	    	}
			if(notifyingDate != null){
	    	    setHidnotifyDate(notifyingDate.toString());
	    	}
			setTxtemployeedocno(getTxtemployeedocno());
			setTxtemployeeid(getTxtemployeeid());
			setTxtemployeename(getTxtemployeename());
			setTxtalreadyprovisioneligibledays(getTxtalreadyprovisioneligibledays());
			setTxtcurrentprovisioneligibledays(getTxtcurrentprovisioneligibledays());
			setTxttotaleligibledays(getTxttotaleligibledays());
			setTxtleavesalarycalculated(getTxtleavesalarycalculated());
			setTxtleavesalaryalreadyprovided(getTxtleavesalaryalreadyprovided());
			setTxtleavesalarynettobeprovided(getTxtleavesalarynettobeprovided());
			setHidchckpartialpayment(getHidchckpartialpayment());
			setTxtleavesalarytobepaid(getTxtleavesalarytobepaid());
			setTxtleavesalarypaideligibledays(getTxtleavesalarypaideligibledays());
			setTxttravelticketvalue(getTxttravelticketvalue());
			setTxttravelalreadyposted(getTxttravelalreadyposted());
			setTxttravelcurrentexpenses(getTxttravelcurrentexpenses());
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtcrtotal());
			
		}
}

