package com.cargo.costingforinvoicing;
 import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.*;

public class ClsCostingForInvoicingAction {

	ClsCommon ClsCommon=new ClsCommon();
	ClsCostingForInvoicingDAO Save =new  ClsCostingForInvoicingDAO();
	
	private int mastertr_no,masterdoc_no,docno,refno,savestatus;
	

	private String estmDate,hidestmDate,refnos,txtRemarks,msg,deleted,mode,formdetailcode;
	
	
	private String mawb,mbl, hawb ,hbl ,shipper, consignee, carrier ,flightno, Voage ,etd ,eta, ttime, boe ,contno, truckno,hidttime;
	
 
	public String getHidttime() {
		return hidttime;
	}

	public void setHidttime(String hidttime) {
		this.hidttime = hidttime;
	}

	public String getMawb() {
		return mawb;
	}

	public void setMawb(String mawb) { 
		this.mawb = mawb;
	}

	public String getMbl() {
		return mbl;
	}

	public void setMbl(String mbl) {
		this.mbl = mbl;
	}

	public String getHawb() {
		return hawb;
	}

	public void setHawb(String hawb) {
		this.hawb = hawb;
	}

	public String getHbl() {
		return hbl;
	}

	public void setHbl(String hbl) {
		this.hbl = hbl;
	}

	public String getShipper() {
		return shipper;
	}

	public void setShipper(String shipper) {
		this.shipper = shipper;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getCarrier() {
		return carrier;
	}

	public void setCarrier(String carrier) {
		this.carrier = carrier;
	}

	public String getFlightno() {
		return flightno;
	}

	public void setFlightno(String flightno) {
		this.flightno = flightno;
	}

	public String getVoage() {
		return Voage;
	}

	public void setVoage(String voage) {
		Voage = voage;
	}

	public String getEtd() {
		return etd;
	}

	public void setEtd(String etd) {
		this.etd = etd;
	}

	public String getEta() {
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	public String getTtime() {
		return ttime;
	}

	public void setTtime(String ttime) {
		this.ttime = ttime;
	}

	public String getBoe() {
		return boe;
	}

	public void setBoe(String boe) {
		this.boe = boe;
	}

	public String getContno() {
		return contno;
	}

	public void setContno(String contno) {
		this.contno = contno;
	}

	public String getTruckno() {
		return truckno;
	}

	public void setTruckno(String truckno) {
		this.truckno = truckno;
	}

	public int getSavestatus() {
		return savestatus;
	}

	public void setSavestatus(int savestatus) {
		this.savestatus = savestatus;
	}

	public int getMastertr_no() {
		return mastertr_no;
	}

	public void setMastertr_no(int mastertr_no) {
		this.mastertr_no = mastertr_no;
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

	public int getRefno() {
		return refno;
	}

	public void setRefno(int refno) {
		this.refno = refno;
	}

	public String getEstmDate() {
		return estmDate;
	}

	public void setEstmDate(String estmDate) {
		this.estmDate = estmDate;
	}

	public String getHidestmDate() {
		return hidestmDate;
	}

	public void setHidestmDate(String hidestmDate) {
		this.hidestmDate = hidestmDate;
	}

	public String getRefnos() {
		return refnos;
	}

	public void setRefnos(String refnos) {
		this.refnos = refnos;
	}

	public String getTxtRemarks() {
		return txtRemarks;
	}

	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
private int gridlenght;



	public int getGridlenght() {
	return gridlenght;
}

public void setGridlenght(int gridlenght) {
	this.gridlenght = gridlenght;
}

	public String saveForm() throws SQLException
	{
		 
		
	 
		
		
	 java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getEstmDate());
	 HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
	System.out.println("=======mode==ssssssssssssssssssssss=="+getMode());
		
		if(!(getMode().equalsIgnoreCase("view")))
		{
			
			ArrayList<String> descarray= new ArrayList<>();
			
			if(!(getMode().equalsIgnoreCase("D")))
			{
			
			
			for(int i=0;i<getGridlenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
				descarray.add(temp2);
			}
			
			}
			
			
			/**/
			
			
				int value=Save.saveData(getMasterdoc_no(),getMastertr_no(),getRefno(),masterdate,getMode(),
						 getFormdetailcode(),getTxtRemarks(),getRefnos(),session,request,descarray,getDocno(),getMawb(), getMbl(), getHawb(),getHbl(),getShipper(),getConsignee(),
				            getCarrier(),getFlightno(),getVoage(),getEta(),getEtd(),getTtime(),getBoe(),getContno(),getTruckno());
					 if(getMode().equalsIgnoreCase("A"))
					 {
							 if(value>0)
							 {
								 int vdocno=(int) request.getAttribute("vocno");
								 setMasterdoc_no(value);
								 setDocno(vdocno);
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Successfully Saved");
								 return "success"; 
							 }
							 else
							 {
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Not Saved");
								 return "fail";
							 }
						
							
					 }
					 
					 
					 
					 if(getMode().equalsIgnoreCase("E"))
					 {    
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Updated Successfully");
								 return "success"; 
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 setMsg("Not Updated");
								 return "fail";
							 }
							
							
					 }
					 
					 
					 
					 
					 if(getMode().equalsIgnoreCase("S"))
					 {    
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								/* setMsg("Updated Successfully");*/
								 setMsg("");
								 
								 setSavestatus(1);
								 return "success"; 
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								/* setMsg("Not Updated");*/
								 setMsg("");
								 setSavestatus(2);
								 return "fail";
							 }
							
							
					 }
					 
					 
					 
					 
					 if(getMode().equalsIgnoreCase("D"))
					 {
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setDeleted("DELETED");
								 setMsg("Successfully Deleted");
								 return "success";
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 setMsg("Not Deleted");
							     setDeleted("");
								 return "fail";
							 }
						
							
					    }
					 
						 }
					 
					 
					 
					 
				 
		else if((getMode().equalsIgnoreCase("view")))
		{
			
			ClsCostingForInvoicingBean bean=new ClsCostingForInvoicingBean();
			
			bean=Save.getViewDetails(getDocno(),session);
			setDocno(getDocno());
			 setHidestmDate(bean.getHidestmDate());
			 setRefno(bean.getRefno());
			 setMasterdoc_no(bean.getMasterdoc_no());
			 setRefnos(bean.getRefnos());
			 setMastertr_no(bean.getMastertr_no());
			 setTxtRemarks(bean.getTxtRemarks());
			 
			 
			 
			 setMawb(bean.getMawb());
			 setMbl(bean.getMbl());
			 setHawb(bean.getHawb());
			 setHbl(bean.getHbl());
			 setShipper(bean.getShipper());
			 setConsignee(bean.getConsignee());
	           setCarrier(bean.getCarrier());
	            setFlightno(bean.getFlightno());
	           setVoage(bean.getVoage());
	            setEta(bean.getEta());
	            setEtd(bean.getEtd());
	            setHidttime(bean.getTtime());
	            setBoe(bean.getBoe());
	            setContno(bean.getContno());
	           setTruckno(bean.getTruckno());								 
			 
			 
			
			 return "success";
			
		}
		
		 
		
				return "fail";
			}
	
	
	
}
