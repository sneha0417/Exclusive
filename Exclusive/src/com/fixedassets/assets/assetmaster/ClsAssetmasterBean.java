package com.fixedassets.assets.assetmaster;

import java.io.IOException;


public class ClsAssetmasterBean {
	
	 private String formdetailcode,refno,remarks,assetid,purchrefno,wntydocno,masterdate,hidmasterdate,assetname,assetGroup,assetGroupval,location,supcmbcurrency,suphidcurrencytype,purchasedate,hidpurchasedate,warexpdate;
	 private String hidwarexpdate,depnotes;
	 private int docno,supplieraccId,supaccdocno,noofitems,subgriddisval,openingval;
	 private double suprate,totalpuchvalue,accumdepr,lifetimeyear,depper;
	 
	 private int gridval;
	 
	public int getGridval() {
		return gridval;
	}
	public void setGridval(int gridval) {
		this.gridval = gridval;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public String getAssetname() {
		return assetname;
	}
	public void setAssetname(String assetname) {
		this.assetname = assetname;
	}
	public String getAssetGroup() {
		return assetGroup;
	}
	public void setAssetGroup(String assetGroup) {
		this.assetGroup = assetGroup;
	}
	public String getAssetGroupval() {                      
		return assetGroupval;
	}
	public void setAssetGroupval(String assetGroupval) {
		this.assetGroupval = assetGroupval;
	}
	public String getLocation() {                 
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSupcmbcurrency() {
		return supcmbcurrency;
	}
	public void setSupcmbcurrency(String supcmbcurrency) {
		this.supcmbcurrency = supcmbcurrency;
	}
	public String getSuphidcurrencytype() {
		return suphidcurrencytype;
	}
	public void setSuphidcurrencytype(String suphidcurrencytype) {
		this.suphidcurrencytype = suphidcurrencytype;
	}
	public String getPurchasedate() {
		return purchasedate;
	}
	public void setPurchasedate(String purchasedate) {
		this.purchasedate = purchasedate;
	}
	public String getHidpurchasedate() {
		return hidpurchasedate;
	}
	public void setHidpurchasedate(String hidpurchasedate) {
		this.hidpurchasedate = hidpurchasedate;
	}
	public String getWarexpdate() {
		return warexpdate;
	}
	public void setWarexpdate(String warexpdate) {
		this.warexpdate = warexpdate;
	}
	public String getHidwarexpdate() {
		return hidwarexpdate;
	}
	public void setHidwarexpdate(String hidwarexpdate) {
		this.hidwarexpdate = hidwarexpdate;
	}
	public String getDepnotes() {       //  getAssetGroupval(),getLocation(),getSupcmbcurrency(),getSuphidcurrencytype(),getDepnotes(),
		return depnotes;
	}
	public void setDepnotes(String depnotes) {
		this.depnotes = depnotes;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) { //getRefno(),getRemarks(),getAssetid(),getSupaccdocno(),getPurchrefno(),getNoofitems(),getWntydocno(),getSubgriddisval(),getOpeningval()
		this.refno = refno;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getAssetid() {
		return assetid;
	}
	public void setAssetid(String assetid) {
		this.assetid = assetid;
											
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getSupplieraccId() {
		return supplieraccId;
	}
	public void setSupplieraccId(int supplieraccId) {
		this.supplieraccId = supplieraccId;
	}
	public int getSupaccdocno() {
		return supaccdocno;
		
		
         
	}
	public void setSupaccdocno(int supaccdocno) {
		this.supaccdocno = supaccdocno;
	}
	public String getPurchrefno() {
		return purchrefno;
	}
	public void setPurchrefno(String purchrefno) {
		this.purchrefno = purchrefno;
	}
	public int getNoofitems() {
		return noofitems;
	}
	public void setNoofitems(int noofitems) {
		this.noofitems = noofitems;
	}
	public String getWntydocno() {
		return wntydocno;
	}
	public void setWntydocno(String wntydocno) {
		this.wntydocno = wntydocno;
	}
	public int getSubgriddisval() {
		return subgriddisval;
	}
	public void setSubgriddisval(int subgriddisval) {
		this.subgriddisval = subgriddisval;
	}
	public int getOpeningval() {
		return openingval;
	}
	public void setOpeningval(int openingval) {// getSuprate(),getTotalpuchvalue() ,getAccumdepr(),getLifetimeyear(),getDepper()
		this.openingval = openingval;
	}
	public double getSuprate() {
		return suprate;
	}
	public void setSuprate(double suprate) {
		

        
		
		this.suprate = suprate;
	}
	public double getTotalpuchvalue() {
		return totalpuchvalue;
	}
	public void setTotalpuchvalue(double totalpuchvalue) {
		this.totalpuchvalue = totalpuchvalue;
	}
	public double getAccumdepr() {
		return accumdepr;
	}
	public void setAccumdepr(double accumdepr) {
		this.accumdepr = accumdepr;
	}
	public double getLifetimeyear() {
		return lifetimeyear;
	}
	public void setLifetimeyear(double lifetimeyear) {
		this.lifetimeyear = lifetimeyear;
	}
	public double getDepper() {
		return depper;
	}
	public void setDepper(double depper) {
		this.depper = depper;
	}
	
	
	private String mode,deleted,msg;
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

	 private String fixedassetaccName ,fixaccType, accdepraccName, accdepraccType,  depraccName, depracType;
	 private int fixaccDocno,fixedassetaccId,fixaccCurrid,accdepraccId,accdepraccDocno,accdepraccCurrid,depraccId,depracCurrid,depracDocno;
	   private double fixaccRate, accdepraccRate, depracRate;

	
	

	public int getDepracDocno() {
		return depracDocno;
	}
	public void setDepracDocno(int depracDocno) { /*getDepracDocno(),getFixaccDocno(),getFixedassetaccName(),getFixaccType()
		                                         getAccdepraccName(), getAccdepraccType() getDepraccName()
		                                         getDepracType() getFixedassetaccId()  getFixaccCurrid() getAccdepraccId()
		                                            getAccdepraccDocno() getAccdepraccCurrid() getDepraccId()
		                                             getDepracCurrid() getFixaccRate() getAccdepraccRate()  getDepracRate() */
		
		
		this.depracDocno = depracDocno;
	}
	public int getFixaccDocno() {
		return fixaccDocno;
	}
	public void setFixaccDocno(int fixaccDocno) {
		this.fixaccDocno = fixaccDocno;
	}
	public String getFixedassetaccName() {
		return fixedassetaccName;
	}
	public void setFixedassetaccName(String fixedassetaccName) {
		this.fixedassetaccName = fixedassetaccName;
	}
	public String getFixaccType() {
		return fixaccType;
	}
	public void setFixaccType(String fixaccType) {
		this.fixaccType = fixaccType;
	}
	public String getAccdepraccName() {
		return accdepraccName;
	}
	public void setAccdepraccName(String accdepraccName) {
		this.accdepraccName = accdepraccName;
	}
	public String getAccdepraccType() {
		return accdepraccType;
	}
	public void setAccdepraccType(String accdepraccType) {
		this.accdepraccType = accdepraccType;
	}
	public String getDepraccName() {
		return depraccName;
	}
	public void setDepraccName(String depraccName) {
		this.depraccName = depraccName;
	}
	public String getDepracType() {
		return depracType;
	}
	public void setDepracType(String depracType) {
		this.depracType = depracType;
	}
	public int getFixedassetaccId() {
		return fixedassetaccId;
	}
	public void setFixedassetaccId(int fixedassetaccId) {
		this.fixedassetaccId = fixedassetaccId;
	}
	public int getFixaccCurrid() {
		return fixaccCurrid;
	}
	public void setFixaccCurrid(int fixaccCurrid) {
		this.fixaccCurrid = fixaccCurrid;
	}
	public int getAccdepraccId() {
		return accdepraccId;
	}
	public void setAccdepraccId(int accdepraccId) {
		this.accdepraccId = accdepraccId;
	}
	public int getAccdepraccDocno() {
		return accdepraccDocno;
	}
	public void setAccdepraccDocno(int accdepraccDocno) {
		this.accdepraccDocno = accdepraccDocno;
	}
	public int getAccdepraccCurrid() {
		return accdepraccCurrid;
	}
	public void setAccdepraccCurrid(int accdepraccCurrid) {
		this.accdepraccCurrid = accdepraccCurrid;
	}
	public int getDepraccId() {
		return depraccId;
	}
	public void setDepraccId(int depraccId) {
		this.depraccId = depraccId;
	}
	public int getDepracCurrid() {
		return depracCurrid;
	}
	public void setDepracCurrid(int depracCurrid) {
		this.depracCurrid = depracCurrid;
	}
	public double getFixaccRate() {
		return fixaccRate;
	}
	public void setFixaccRate(double fixaccRate) {
		this.fixaccRate = fixaccRate;
	}
	public double getAccdepraccRate() {
		return accdepraccRate;
	}
	public void setAccdepraccRate(double accdepraccRate) {
		this.accdepraccRate = accdepraccRate;
	}
	public double getDepracRate() {
		return depracRate;
	}
	public void setDepracRate(double depracRate) {
		this.depracRate = depracRate;
	}
	private String  supplieraccName;
	public String getSupplieraccName() {
		return supplieraccName;
	}
	public void setSupplieraccName(String supplieraccName) {
		this.supplieraccName = supplieraccName;
	}
}
