package com.aviation.fuelinginformation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
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

public class ClsfuelingInformationAction {

	ClsCommon ClsCommon=new ClsCommon();
	ClsfuelingInformationBean Beans=new ClsfuelingInformationBean();
	
	ClsfuelingInformationBean viewObj = new ClsfuelingInformationBean();
	ClsfuelingInformationDAO saveObj = new ClsfuelingInformationDAO();

	
	private String FuelInfoDate,hidFuelInfoDate,cmbclient,vendor;
	private String txtclientname,txtvendorname;
	private String txtnotes,deleted,enqdtype;
	private int masterdoc_no,docno,enqgridlenght;
	private String gridval,forradiochk,fromdatesval,todateval,txtradio,msg,formdetailcode,mode;
	private String lblclientname,lblcldocno,lblvendorname,lblnotes,lbldocno,lblfuelinfodate,lbladdress,lblmobno,lblfax;
	
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
			
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	
	public String getLblcldocno() {
		return lblcldocno;
	}
	public void setLblcldocno(String lblcldocno) {
		this.lblcldocno = lblcldocno;
	}
	public String getLblfuelinfodate() {
		return lblfuelinfodate;
	}
	public void setLblfuelinfodate(String lblfuelinfodate) {
		this.lblfuelinfodate = lblfuelinfodate;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLblmobno() {
		return lblmobno;
	}
	public void setLblmobno(String lblmobno) {
		this.lblmobno = lblmobno;
	}
	public String getLblfax() {
		return lblfax;
	}
	public void setLblfax(String lblfax) {
		this.lblfax = lblfax;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLblvendorname() {
		return lblvendorname;
	}
	public void setLblvendorname(String lblvendorname) {
		this.lblvendorname = lblvendorname;
	}
	public String getLblnotes() {
		return lblnotes;
	}
	public void setLblnotes(String lblnotes) {
		this.lblnotes = lblnotes;
	}
	public String getFuelInfoDate() {
		return FuelInfoDate;
	}
	public void setFuelInfoDate(String fuelInfoDate) {
		FuelInfoDate = fuelInfoDate;
	}
	public String getHidFuelInfoDate() {
		return hidFuelInfoDate;
	}
	public void setHidFuelInfoDate(String hidFuelInfoDate) {
		this.hidFuelInfoDate = hidFuelInfoDate;
	}
	public String getCmbclient() {
		return cmbclient;
	}
	public void setCmbclient(String cmbclient) {
		this.cmbclient = cmbclient;
	}
	
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	
	
	public String getTxtvendorname() {
		return txtvendorname;
	}
	public void setTxtvendorname(String txtvendorname) {
		this.txtvendorname = txtvendorname;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getEnqdtype() {
		return enqdtype;
	}
	public void setEnqdtype(String enqdtype) {
		this.enqdtype = enqdtype;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getEnqgridlenght() {
		return enqgridlenght;
	}
	public void setEnqgridlenght(int enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}
	public String getGridval() {
		return gridval;
	}
	public void setGridval(String gridval) {
		this.gridval = gridval;
	}
	public String getForradiochk() {
		return forradiochk;
	}
	public void setForradiochk(String forradiochk) {
		this.forradiochk = forradiochk;
	}
	public String getFromdatesval() {
		return fromdatesval;
	}
	public void setFromdatesval(String fromdatesval) {
		this.fromdatesval = fromdatesval;
	}
	public String getTodateval() {
		return todateval;
	}
	public void setTodateval(String todateval) {
		this.todateval = todateval;
	}
	public String getTxtradio() {
		return txtradio;
	}
	public void setTxtradio(String txtradio) {
		this.txtradio = txtradio;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	 
	ClsfuelingInformationDAO savefuelinfodata=new ClsfuelingInformationDAO();
	
	public String saveFuelInfo() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();		
		
		if(mode.equalsIgnoreCase("A")){
			java.sql.Date fuelInfoDate = ClsCommon.changeStringtoSqlDate(getFuelInfoDate());
			
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];
				descarray.add(temp2);
			}

			
		int val=savefuelinfodata.insert(fuelInfoDate,getCmbclient(),getVendor(),session,getMode(),getFormdetailcode(),request,descarray,getTxtnotes());
		int docno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(docno);
			setFuelInfoDate(fuelInfoDate.toString());
			setMasterdoc_no(val);
			setData();
			setMsg("Successfully Saved");
			return "success";
		}
		else
		{
			setHidFuelInfoDate(hidFuelInfoDate.toString());
			setData();
			setMsg("Not Saved");
			return "fail";
		}
		}
		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date fuelInfoDate = ClsCommon.changeStringtoSqlDate(getFuelInfoDate());
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				
			 
				String temp2=requestParams.get("enqtest"+i)[0];
			 

				descarray.add(temp2);
				 
			}
			int val=savefuelinfodata.update(getMasterdoc_no(),fuelInfoDate,cmbclient,vendor,getTxtnotes(),session,getMode(),getFormdetailcode(),request,descarray);
			if(val>0){
				
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
					setData();
					setMsg("Updated Successfully");
				    return "success";
			}
			else{
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
				setMsg("Not Updated");
				return "fail";
				}
		}
		
		else if(mode.equalsIgnoreCase("D")){


			int val=savefuelinfodata.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);

			if(val>0)
			{
				
				
			 
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
			    setDeleted("DELETED");
				setMsg("Successfully Deleted");
			    return "success";
			}
			else
			{
				 
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
				setMsg("Not Deleted");
			     return "fail";
					
			}
		}
			else if(mode.equalsIgnoreCase("view")){
				
				viewObj=saveObj.getViewDetails(getMasterdoc_no() , session);
				setDocno(viewObj.getDocno());
				setMasterdoc_no(viewObj.getMasterdoc_no());
				setTxtnotes(viewObj.getTxtnotes());
				setHidFuelInfoDate(viewObj.getHidFuelInfoDate());
				setCmbclient(viewObj.getCmbclient());
				setTxtclientname(viewObj.getTxtclientname());
				setVendor(viewObj.getVendor());
				setTxtvendorname(viewObj.getTxtvendorname());
				
				return "success";
			}


				
		return "fail";
		
	}
	
	public void setData(){
		setDocno(getDocno());
		setCmbclient(getCmbclient());
		 setEnqdtype(getEnqdtype());
		 setEnqgridlenght(getEnqgridlenght());
		 setFuelInfoDate(getFuelInfoDate());
		 setFormdetailcode(getFormdetailcode());
		 setForradiochk(getForradiochk());
		 setFromdatesval(getFromdatesval());
		 setGridval(getGridval());
		 setMode(getMode());
		 setHidFuelInfoDate(getHidFuelInfoDate());
		 setTodateval(getTodateval());
		 setTxtclientname(getTxtclientname());
		 setTxtradio(getTxtradio());
		 setTxtnotes(getTxtnotes());
		 setMasterdoc_no(getMasterdoc_no());
	}	
	public String printAction() throws ParseException, SQLException{
		//System.out.println("gshfdgprint");
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		  HttpSession session=request.getSession();
		 ClsCommon common=new ClsCommon();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 String brhid=request.getParameter("brhid");
		 String dtype=request.getParameter("dtype");
		 
		 System.out.println("looo"+dtype);
		 
		 ClsfuelingInformationDAO ClsfuelingInformationDAO=new ClsfuelingInformationDAO();
		 ClsfuelingInformationBean pintbean= new ClsfuelingInformationBean();
		 
		 pintbean=ClsfuelingInformationDAO.getPrint(doc);
		 
		 System.out.println("looooooooooooooogo="+common.getPrintPath(dtype));
          	  setLblclientname(pintbean.getLblclientname());
          	  setLblvendorname(pintbean.getLblvendorname());
          	  setLblnotes(pintbean.getLblnotes());
          	  setLbldocno(pintbean.getLbldocno());
          	  setLblfuelinfodate(pintbean.getLblfuelinfodate());
          	  setLbladdress(pintbean.getLbladdress());
          	  setLblmobno(pintbean.getLblmobno());
          	  setLblfax(pintbean.getLblfax());
          	  setLblcldocno(pintbean.getLblcldocno());
        /* if(common.getPrintPath(dtype).contains(".jrxml")==true)
				{	*/			   
       
     				  
      	   System.out.println("inside jrxml");
      	   ClsConnection conobj=new ClsConnection();
											 
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	   String reportFileName = "fuelinfo";
      	   try {
      		   
      		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aviation_header.png");
      		   imgpath=imgpath.replace("\\", "\\\\"); 
      		   param.put("img",imgpath);
      		   param.put("clientname", pintbean.getLblclientname());
      		   param.put("vendorname", pintbean.getLblvendorname());
      		   param.put("notes", pintbean.getLblnotes());
      		   param.put("docno", pintbean.getLbldocno());
      		   param.put("date", pintbean.getLblfuelinfodate());
      		   param.put("mobno", pintbean.getLblmobno());
      		   param.put("address", pintbean.getLbladdress());
	      		param.put("fax", pintbean.getLblfax());
	      		param.put("notes", pintbean.getLblnotes());
	      		param.put("cldocno", pintbean.getLblcldocno());
	      		param.put("printedby",session.getAttribute("USERNAME").toString());
      		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/aviation/fuelinginformation/fuelingInformation.jrxml"));	      	     	 
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
