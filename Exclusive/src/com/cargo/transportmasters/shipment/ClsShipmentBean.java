package com.cargo.transportmasters.shipment;
import java.util.*;

import com.common.ClsCommon;
public class ClsShipmentBean {
	
	
	

	
	private int docno;
	private String shipmentdate;
	private String shipmentid;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	
	
		
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	

	public String getShipmentdate() {
		return shipmentdate;
	}
	public void setShipmentdate(String shipmentdate) {
		this.shipmentdate = shipmentdate;
	}
	public String getShipmentid() {
		return shipmentid;
	}
	public void setShipmentid(String shipmentid) {
		this.shipmentid = shipmentid;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
}
