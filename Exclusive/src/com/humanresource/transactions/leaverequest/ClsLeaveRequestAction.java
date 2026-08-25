package com.humanresource.transactions.leaverequest;

import java.io.IOException;
import java.sql.Connection;
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
import com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsLeaveRequestAction extends ActionSupport{

	ClsCommon commonDAO=new ClsCommon();

	ClsLeaveRequestDAO leaveRequestDAO = new ClsLeaveRequestDAO();
	ClsLeaveRequestBean leaveRequestBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private int txtleaverequestdocno;
	private String leaveRequestDate;
	private String hidleaveRequestDate;
	private String cmbempdesignation;
	private String hidcmbempdesignation;
	private String cmbempdepartment;
	private String hidcmbempdepartment;
	private String cmbpayrollcategory;
	private String hidcmbpayrollcategory;
	private String txtemployeeid;
	private String txtemployeename;
	private int txtemployeedocno;
	private String fromDate;
	private String hidfromDate;
	private String toDate;
	private String hidtoDate;
	private String chckhalfday;
	private String hidchckhalfday;
	private String halfDayDate;
	private String hidhalfDayDate;
	private double txtnoofdays;
	private String cmbleavetype;
	private String hidcmbleavetype;
	private String txtdescription;
	
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

	public int getTxtleaverequestdocno() {
		return txtleaverequestdocno;
	}

	public void setTxtleaverequestdocno(int txtleaverequestdocno) {
		this.txtleaverequestdocno = txtleaverequestdocno;
	}

	public String getLeaveRequestDate() {
		return leaveRequestDate;
	}

	public void setLeaveRequestDate(String leaveRequestDate) {
		this.leaveRequestDate = leaveRequestDate;
	}

	public String getHidleaveRequestDate() {
		return hidleaveRequestDate;
	}

	public void setHidleaveRequestDate(String hidleaveRequestDate) {
		this.hidleaveRequestDate = hidleaveRequestDate;
	}

	public String getCmbempdesignation() {
		return cmbempdesignation;
	}

	public void setCmbempdesignation(String cmbempdesignation) {
		this.cmbempdesignation = cmbempdesignation;
	}

	public String getHidcmbempdesignation() {
		return hidcmbempdesignation;
	}

	public void setHidcmbempdesignation(String hidcmbempdesignation) {
		this.hidcmbempdesignation = hidcmbempdesignation;
	}

	public String getCmbempdepartment() {
		return cmbempdepartment;
	}

	public void setCmbempdepartment(String cmbempdepartment) {
		this.cmbempdepartment = cmbempdepartment;
	}

	public String getHidcmbempdepartment() {
		return hidcmbempdepartment;
	}

	public void setHidcmbempdepartment(String hidcmbempdepartment) {
		this.hidcmbempdepartment = hidcmbempdepartment;
	}

	public String getCmbpayrollcategory() {
		return cmbpayrollcategory;
	}

	public void setCmbpayrollcategory(String cmbpayrollcategory) {
		this.cmbpayrollcategory = cmbpayrollcategory;
	}

	public String getHidcmbpayrollcategory() {
		return hidcmbpayrollcategory;
	}

	public void setHidcmbpayrollcategory(String hidcmbpayrollcategory) {
		this.hidcmbpayrollcategory = hidcmbpayrollcategory;
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

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getHidfromDate() {
		return hidfromDate;
	}

	public void setHidfromDate(String hidfromDate) {
		this.hidfromDate = hidfromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getHidtoDate() {
		return hidtoDate;
	}

	public void setHidtoDate(String hidtoDate) {
		this.hidtoDate = hidtoDate;
	}

	public String getChckhalfday() {
		return chckhalfday;
	}

	public void setChckhalfday(String chckhalfday) {
		this.chckhalfday = chckhalfday;
	}

	public String getHidchckhalfday() {
		return hidchckhalfday;
	}

	public void setHidchckhalfday(String hidchckhalfday) {
		this.hidchckhalfday = hidchckhalfday;
	}

	public String getHalfDayDate() {
		return halfDayDate;
	}

	public void setHalfDayDate(String halfDayDate) {
		this.halfDayDate = halfDayDate;
	}

	public String getHidhalfDayDate() {
		return hidhalfDayDate;
	}

	public void setHidhalfDayDate(String hidhalfDayDate) {
		this.hidhalfDayDate = hidhalfDayDate;
	}

	public double getTxtnoofdays() {
		return txtnoofdays;
	}

	public void setTxtnoofdays(double txtnoofdays) {
		this.txtnoofdays = txtnoofdays;
	}

	public String getCmbleavetype() {
		return cmbleavetype;
	}

	public void setCmbleavetype(String cmbleavetype) {
		this.cmbleavetype = cmbleavetype;
	}

	public String getHidcmbleavetype() {
		return hidcmbleavetype;
	}

	public void setHidcmbleavetype(String hidcmbleavetype) {
		this.hidcmbleavetype = hidcmbleavetype;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	
	java.sql.Date leavesRequestDate=null;
	java.sql.Date leavesStartDate=null;
	java.sql.Date leavesEndDate=null;
	java.sql.Date halfDaysDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsLeaveRequestBean bean = new ClsLeaveRequestBean();

		leavesRequestDate = commonDAO.changeStringtoSqlDate(getLeaveRequestDate());
		leavesStartDate = (getFromDate()==null || getFromDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getFromDate());
		leavesEndDate = (getToDate()==null || getToDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getToDate());
		halfDaysDate = (getHalfDayDate()==null || getHalfDayDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getHalfDayDate());
		
		if(getHidchckhalfday().equalsIgnoreCase("0")) {
			halfDaysDate=null;
		}
		
		if(mode.equalsIgnoreCase("A")){
			
				int val=leaveRequestDAO.insert(getFormdetailcode(),leavesRequestDate,getCmbempdesignation(),getCmbempdepartment(),getCmbpayrollcategory(),getTxtemployeedocno(),leavesStartDate,leavesEndDate,getHidchckhalfday(),halfDaysDate,getTxtnoofdays(),getCmbleavetype(),getTxtdescription(),session,mode);
				if(val>0.0){
					
					setTxtleaverequestdocno(val);
					setData();
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setMsg("Not Saved");
					return "fail";
				}	
		} else if(mode.equalsIgnoreCase("E")){

			boolean Status=leaveRequestDAO.edit(getTxtleaverequestdocno(),getFormdetailcode(),leavesRequestDate,getCmbempdesignation(),getCmbempdepartment(),getCmbpayrollcategory(),getTxtemployeedocno(),leavesStartDate,leavesEndDate,getHidchckhalfday(),halfDaysDate,getTxtnoofdays(),getCmbleavetype(),getTxtdescription(),session,mode);
			if(Status){

				setTxtleaverequestdocno(getTxtleaverequestdocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtleaverequestdocno(getTxtleaverequestdocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
			
	  } else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=leaveRequestDAO.delete(getTxtleaverequestdocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtleaverequestdocno(getTxtleaverequestdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
		} else if(mode.equalsIgnoreCase("View")){
			
			leaveRequestBean=leaveRequestDAO.getViewDetails(getTxtleaverequestdocno());
			
			setLeaveRequestDate(leaveRequestBean.getLeaveRequestDate());
			setHidcmbempdesignation(leaveRequestBean.getHidcmbempdesignation());
			setHidcmbempdepartment(leaveRequestBean.getHidcmbempdepartment());
			setHidcmbpayrollcategory(leaveRequestBean.getHidcmbpayrollcategory());
    	    setTxtemployeeid(leaveRequestBean.getTxtemployeeid());
			setTxtemployeename(leaveRequestBean.getTxtemployeename());
			setTxtemployeedocno(leaveRequestBean.getTxtemployeedocno());
			setFromDate(leaveRequestBean.getFromDate());
			setToDate(leaveRequestBean.getToDate());
			setHidchckhalfday(leaveRequestBean.getChckhalfday());
			setHalfDayDate(leaveRequestBean.getHalfDayDate());
			setTxtnoofdays(leaveRequestBean.getTxtnoofdays());
			setHidcmbleavetype(leaveRequestBean.getHidcmbleavetype());
			setTxtdescription(leaveRequestBean.getTxtdescription());

			return "success";
		}
		
		return "fail";
	}

	public void setData() {

    	    if(leavesRequestDate != null){
    	    setHidleaveRequestDate(leavesRequestDate.toString());
    	    }
    	    setHidcmbempdesignation(getCmbempdesignation());
			setHidcmbempdepartment(getCmbempdepartment());
			setHidcmbpayrollcategory(getCmbpayrollcategory());
    	    setTxtemployeeid(getTxtemployeeid());
			setTxtemployeename(getTxtemployeename());
			setTxtemployeedocno(getTxtemployeedocno());
			if(leavesStartDate != null){
			setHidfromDate(leavesStartDate.toString());
			}
			if(leavesEndDate != null){
			setHidtoDate(leavesEndDate.toString());	
			}
			setHidchckhalfday(getHidchckhalfday());
			if(halfDaysDate != null){
			setHidhalfDayDate(halfDaysDate.toString() );	
			}
			setTxtnoofdays(getTxtnoofdays());
			setHidcmbleavetype(getCmbleavetype());
			setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
		}
	
	public String printAction() throws ParseException, SQLException{
		//System.out.println("inside printaction1");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");
		/*String brhid=request.getParameter("brhid");*/
		String dtype=request.getParameter("dtype");
		String contextPath=request.getContextPath();
		
		
		
		
		if(commonDAO.getPrintPath(dtype).contains(".jrxml")==true)
		{
			
			 ClsConnection conobj=new ClsConnection();
	    	   param = new HashMap();
	    	   Connection conn = null;
	    	   conn = conobj.getMyConnection();	        	   
	    	  
	    	   try{
	    		   Statement stmt= conn.createStatement();
	    		 
	    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	    		   imgpath=imgpath.replace("\\", "\\\\");
	    		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	    		   imgfooter=imgfooter.replace("\\", "\\\\");
	    		   
	    		
	    		   param.put("docno", docno);
	    		   param.put("imgheader", imgpath);
	    		   param.put("imgfooter", imgfooter);
	    		   
	    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath(dtype)));	      	     	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	               generateReportPDF(response, param, jasperReport, conn);
	    	   }catch (Exception e) {
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




