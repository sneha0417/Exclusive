package com.humanresource.transactions.additionanddeduction;

import java.io.IOException;
import java.sql.Connection;
import java.text.ParseException;
import java.sql.SQLException;
import java.util.ArrayList;
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

public class ClsAdditionandDeductionAction {
	
	ClsCommon ClsCommon=new ClsCommon();

	private String  masterdate,hidmasterdate,refno, mode, deleted ,msg,formdetailcode,desc;
	private int cmbyear,hidcmbyear,cmbmonth,hidcmbmonth,docno,descdetailsGridlenght;
	private String url;
	ClsAdditionandDeductionDAO saveDAO= new ClsAdditionandDeductionDAO();
	ClsAdditionandDeductionBean viewDAO= new ClsAdditionandDeductionBean();
	
	
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMasterdate() {
		return masterdate;
	}
	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}
	public String getHidmasterdate() {
		return hidmasterdate;
	}
	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
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
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(int cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getHidcmbyear() {
		return hidcmbyear;
	}
	public void setHidcmbyear(int hidcmbyear) {
		this.hidcmbyear = hidcmbyear;
	}
	public int getCmbmonth() {
		return cmbmonth;
	}
	public void setCmbmonth(int cmbmonth) {
		this.cmbmonth = cmbmonth;
	}
	public int getHidcmbmonth() {
		return hidcmbmonth;
	}
	public void setHidcmbmonth(int hidcmbmonth) {
		this.hidcmbmonth = hidcmbmonth;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getDescdetailsGridlenght() {
		return descdetailsGridlenght;
	}
	public void setDescdetailsGridlenght(int descdetailsGridlenght) {
		this.descdetailsGridlenght = descdetailsGridlenght;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String saveAction() throws SQLException {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap(); 
		
		if(getMode().equalsIgnoreCase("A")) {
	 
			java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		
			ArrayList<String> comparray= new ArrayList<>();
			for(int i=0;i<getDescdetailsGridlenght();i++){
				String temp1=requestParams.get("test"+i)[0];
				comparray.add(temp1);
			}
   
			int val=saveDAO.insert(getDesc(),getCmbyear(),getCmbmonth(),masterdate,getRefno(),getFormdetailcode(),getMode(),request,session,comparray);
			if(val>0) {
				
				 setDocno(val);
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 setHidmasterdate(masterdate.toString());
		        
				 setMsg("Successfully Saved");
				 return "success";
				 
			} else {
	 
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 setHidmasterdate(masterdate.toString());
				  
				 setMsg("Not Saved");
				 return "fail";
				
			}
			
		}
		
		else if(getMode().equalsIgnoreCase("E")) {
	 
			 java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());

			 ArrayList<String> comparray= new ArrayList<>();
			 for(int i=0;i<getDescdetailsGridlenght();i++){
				 String temp1=requestParams.get("test"+i)[0];
				 comparray.add(temp1);
			 }

			 int val=saveDAO.update(getDocno(),getDesc(),getCmbyear(),getCmbmonth(),masterdate,getRefno(),getFormdetailcode(),getMode(),request,session,comparray);
					
			 if(val>0) {
						
					 setDocno(getDocno());
					 setDesc(getDesc());
					 setHidcmbyear(getCmbyear());
					 setHidcmbmonth(getCmbmonth());
					 setRefno(getRefno());
					 setHidmasterdate(masterdate.toString());
			         
					 setMsg("Updated Successfully");
					 return "success";
						
			  } else {
						 
					 setDocno(getDocno());
					 setDesc(getDesc());
					 setHidcmbyear(getCmbyear());
					 setHidcmbmonth(getCmbmonth());
					 setRefno(getRefno());
					 setHidmasterdate(masterdate.toString());
					  
			         setMsg("Not Updated");
				     return "fail";
						
			 }
		}
		
	 	else if(getMode().equalsIgnoreCase("D")) {
	 		 
		 	int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request); 
			if(val>0) {
				
				 setDocno(getDocno());
				 setDesc(getDesc());	
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());

				 setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				 return "success";
			} else {
				 
				 setDocno(getDocno());
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 
				 setMsg("Not Deleted");
	             return "fail";
			}
		} 
		
	 	else if(mode.equalsIgnoreCase("View")){
	 		
			String branch=null;
			viewDAO=saveDAO.getViewDetails(session,getDocno());
			
			setMasterdate(viewDAO.getMasterdate());
			setRefno(viewDAO.getRefno());
			setHidcmbyear(viewDAO.getHidcmbyear());
			setHidcmbmonth(viewDAO.getHidcmbmonth());
			setDesc(viewDAO.getDesc());
			setFormdetailcode(viewDAO.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	public String PrintAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	
		int doc=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype").toString();
		
		
		setUrl(ClsCommon.getPrintPath(dtype));
		if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();

			Connection conn = null;
			 try {
				ClsConnection conobj= new ClsConnection();
					 param = new HashMap();
			                conn = conobj.getMyConnection();
			        param.put("docno", doc) ;       
			            
			        String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        imgpathheader=imgpathheader.replace("\\", "\\\\");
			     String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
			     
			   
			      param.put("imgheader", imgpathheader);
			      param.put("imgfooter", imgpathfooter);
			     
					
					
					JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(ClsCommon.getPrintPath(dtype)));
		         	 
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