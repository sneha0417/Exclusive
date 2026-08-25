package com.fixedassets.assets.assetmaster;

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


public class ClsAssetmasterAction
{
	ClsCommon ClsCommon=new ClsCommon();

	ClsAssetmasterDAO masterDAO =  new ClsAssetmasterDAO();
	ClsAssetmasterBean masterBean;
	 private String masteredit,supplieraccName,formdetailcode,refno,remarks,assetid,purchrefno,wntydocno,masterdate,hidmasterdate,assetname,assetGroup,assetGroupval,locationval,location,supcmbcurrency,suphidcurrencytype,purchasedate,hidpurchasedate,warexpdate;
	 private String hidwarexpdate,depnotes;
	 private int docno,supplieraccId,supaccdocno,noofitems,subgriddisval,openingval,srno;
	 private double suprate,totalpuchvalue,accumdepr,lifetimeyear,depper;
	 
	 private int gridval;
	 
	 
	 
	public String getMasteredit() {
		return masteredit;
	}
	public void setMasteredit(String masteredit) {
		this.masteredit = masteredit;
	}
	public int getSrno() {
		return srno;
	}
	public void setSrno(int srno) {
		this.srno = srno;
	}
	public String getLocationval() {
		return locationval;
	}
	public void setLocationval(String locationval) {
		this.locationval = locationval;
	}
	public String getSupplieraccName() {
		return supplieraccName;
	}
	public void setSupplieraccName(String supplieraccName) {
		this.supplieraccName = supplieraccName;
	}
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
	private Map<String, Object> param = null;
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
		if(getMode().equalsIgnoreCase("A"))
		{
		
			java.sql.Date sqlmasterDate=ClsCommon.changeStringtoSqlDate(getMasterdate());
			java.sql.Date sqlwarExpDate=ClsCommon.changeStringtoSqlDate(getWarexpdate());
			java.sql.Date sqlpuchaseDate=ClsCommon.changeStringtoSqlDate(getPurchasedate());
			
			
			   ArrayList<String> paymentarray= new ArrayList<>();
				for(int i=0;i<getGridval();i++){
				 String temp2=requestParams.get("paytest"+i)[0];
				 paymentarray.add(temp2);
				 
				}
			
			
		int val=masterDAO.insert(request,session,sqlmasterDate,sqlwarExpDate,sqlpuchaseDate,getRefno(),getRemarks(),getAssetid(),getSupaccdocno(),getPurchrefno(),getNoofitems(),getWntydocno(),getSubgriddisval(),getOpeningval(),
				 getAssetGroup(),getLocation(),getSupcmbcurrency(),getSuphidcurrencytype(),getDepnotes(),getSuprate(),getTotalpuchvalue() ,getAccumdepr(),getLifetimeyear(),getDepper(),getAssetname(),
				 getMode(),getFormdetailcode(),paymentarray,getFixaccDocno(),getAccdepraccDocno(),getDepracDocno());
		
		int srno=(int) request.getAttribute("srno");
		if(val>0)
		{
			setSrno(srno);
			setDocno(val);
			setHidmasterdate(sqlmasterDate.toString());
			setAssetid(getAssetid());  
			setAssetname(getAssetname());
			setAssetGroupval(getAssetGroup());
			setLocationval(getLocation());
	        setSupcmbcurrency(getSupcmbcurrency()); 
	        setSuphidcurrencytype(getSuphidcurrencytype());
	        setHidpurchasedate(sqlpuchaseDate.toString());
	        setHidwarexpdate(sqlwarExpDate.toString());
	        setDepnotes(getDepnotes());
	        setRefno(getRefno()); 
	        setRemarks(getRemarks());
	        setSupplieraccId(getSupplieraccId());
	       setTotalpuchvalue(getTotalpuchvalue());
	        setSupplieraccName(getSupplieraccName());
	        
	        setSupaccdocno(getSupaccdocno());
	        setPurchrefno(getPurchrefno());
	        setNoofitems(getNoofitems());
	        setWntydocno(getWntydocno());
	        setSubgriddisval(getSubgriddisval());
	        setOpeningval(getOpeningval());
	        setSuprate(getSuprate());
	        setAccumdepr(getAccumdepr()); 
	        setLifetimeyear(getLifetimeyear());
	        setDepper(getDepper());
	        
	        //fin
	        //fix
	        setFixaccDocno(getFixaccDocno());
	        setFixedassetaccName(getFixedassetaccName());
	        setFixaccType(getFixaccType());
	        setFixedassetaccId(getFixedassetaccId());
	        setFixaccCurrid(getFixaccCurrid());
	        setFixaccRate(getFixaccRate());
	        
	          //acc.dep
	        setAccdepraccDocno(getAccdepraccDocno());
	        setAccdepraccName(getAccdepraccName());
	        setAccdepraccType(getAccdepraccType()) ;
	        setAccdepraccId(getAccdepraccId());
	        setAccdepraccCurrid(getAccdepraccCurrid());
	          setAccdepraccRate(getAccdepraccRate()); 
	      // dep
	       
	        
	 
	        
	        setDepracDocno(getDepracDocno());
	        setDepraccName(getDepraccName());
	        setDepracType(getDepracType());
	        setDepraccId(getDepraccId());
	        setDepracCurrid(getDepracCurrid());
	        setDepracRate(getDepracRate());
	        
            
	        
	        
	        
			setMsg("Successfully Saved");
			return "success";
			
			
		}
		else
		{
			setHidmasterdate(sqlmasterDate.toString());
			setAssetid(getAssetid());  
			setAssetname(getAssetname());
			setAssetGroupval(getAssetGroup());
			setLocationval(getLocation());
	        setSupcmbcurrency(getSupcmbcurrency()); 
	        setSuphidcurrencytype( getSuphidcurrencytype());
	        setHidpurchasedate(sqlpuchaseDate.toString());
	        setHidwarexpdate(sqlwarExpDate.toString());
	        setDepnotes(getDepnotes());
	        setRefno(getRefno()); 
	        
	        setSupplieraccName(getSupplieraccName());
	        
	        setRemarks(getRemarks());
	        setSupplieraccId(getSupplieraccId());
	        setSupaccdocno(getSupaccdocno());
	        setPurchrefno(getPurchrefno());
	        setNoofitems(getNoofitems());
	        setWntydocno(getWntydocno());
	        setSubgriddisval(getSubgriddisval());
	        setOpeningval(getOpeningval());
	        setSuprate(getSuprate());
	        setAccumdepr(getAccumdepr()); 
	        setLifetimeyear(getLifetimeyear());
	        setDepper(getDepper());
	        
	        setTotalpuchvalue(getTotalpuchvalue());
	        
	        //fin
	        //fix
	        setFixaccDocno(getFixaccDocno());
	        setFixedassetaccName(getFixedassetaccName());
	        setFixaccType(getFixaccType());
	        setFixedassetaccId(getFixedassetaccId());
	        setFixaccCurrid(getFixaccCurrid());
	        setFixaccRate(getFixaccRate());
	        
	          //acc.dep
	        setAccdepraccDocno(getAccdepraccDocno());
	        setAccdepraccName(getAccdepraccName());
	        setAccdepraccType(getAccdepraccType()) ;
	        setAccdepraccId(getAccdepraccId());
	        setAccdepraccCurrid(getAccdepraccCurrid());
	          setAccdepraccRate(getAccdepraccRate()); 
	      // dep
	       
	        
	 
	        
	        setDepracDocno(getDepracDocno());
	        setDepraccName(getDepraccName());
	        setDepracType(getDepracType());
	        setDepraccId(getDepraccId());
	        setDepracCurrid(getDepracCurrid());
	        setDepracRate(getDepracRate());
	        
	        
	        setMsg("Not Saved");
			return "fail";
			
		}
		}
		
		
		
		if(getMode().equalsIgnoreCase("E"))
		{
		
			java.sql.Date sqlmasterDate=ClsCommon.changeStringtoSqlDate(getMasterdate());
			java.sql.Date sqlwarExpDate=ClsCommon.changeStringtoSqlDate(getWarexpdate());
			java.sql.Date sqlpuchaseDate=ClsCommon.changeStringtoSqlDate(getPurchasedate());
			
			
			   ArrayList<String> paymentarray= new ArrayList<>();
				for(int i=0;i<getGridval();i++){
				 String temp2=requestParams.get("paytest"+i)[0];
				 paymentarray.add(temp2);
				 
				}
			
			
		boolean status=masterDAO.edit(getSrno(),getMasteredit(),getDocno(),request,session,sqlmasterDate,sqlwarExpDate,sqlpuchaseDate,getRefno(),getRemarks(),getAssetid(),getSupaccdocno(),getPurchrefno(),getNoofitems(),getWntydocno(),getSubgriddisval(),getOpeningval(),
				 getAssetGroup(),getLocation(),getSupcmbcurrency(),getSuphidcurrencytype(),getDepnotes(),getSuprate(),getTotalpuchvalue() ,getAccumdepr(),getLifetimeyear(),getDepper(),getAssetname(),
				 getMode(),getFormdetailcode(),paymentarray,getFixaccDocno(),getAccdepraccDocno(),getDepracDocno());
		
		
		if(status)
		{
			 setSrno(getSrno());
				
			setDocno(getDocno());
			setHidmasterdate(sqlmasterDate.toString());
			setAssetid(getAssetid());  
			setAssetname(getAssetname());
			setAssetGroupval(getAssetGroup());
			setLocationval(getLocation());
	        setSupcmbcurrency(getSupcmbcurrency()); 
	        setSuphidcurrencytype(getSuphidcurrencytype());
	        setHidpurchasedate(sqlpuchaseDate.toString());
	        setHidwarexpdate(sqlwarExpDate.toString());
	        setDepnotes(getDepnotes());
	        setRefno(getRefno()); 
	        setRemarks(getRemarks());
	        setSupplieraccId(getSupplieraccId());
	       setTotalpuchvalue(getTotalpuchvalue());
	        setSupplieraccName(getSupplieraccName());
	        
	        setSupaccdocno(getSupaccdocno());
	        setPurchrefno(getPurchrefno());
	        setNoofitems(getNoofitems());
	        setWntydocno(getWntydocno());
	        setSubgriddisval(getSubgriddisval());
	        setOpeningval(getOpeningval());
	        setSuprate(getSuprate());
	        setAccumdepr(getAccumdepr()); 
	        setLifetimeyear(getLifetimeyear());
	        setDepper(getDepper());
	        
	        //fin
	        //fix
	        setFixaccDocno(getFixaccDocno());
	        setFixedassetaccName(getFixedassetaccName());
	        setFixaccType(getFixaccType());
	        setFixedassetaccId(getFixedassetaccId());
	        setFixaccCurrid(getFixaccCurrid());
	        setFixaccRate(getFixaccRate());
	        
	          //acc.dep
	        setAccdepraccDocno(getAccdepraccDocno());
	        setAccdepraccName(getAccdepraccName());
	        setAccdepraccType(getAccdepraccType()) ;
	        setAccdepraccId(getAccdepraccId());
	        setAccdepraccCurrid(getAccdepraccCurrid());
	          setAccdepraccRate(getAccdepraccRate()); 
	      // dep
	       
	        
	 
	        
	        setDepracDocno(getDepracDocno());
	        setDepraccName(getDepraccName());
	        setDepracType(getDepracType());
	        setDepraccId(getDepraccId());
	        setDepracCurrid(getDepracCurrid());
	        setDepracRate(getDepracRate());
	        
            
	        
	        
	        
			setMsg("Successfully Saved");
			return "success";
			
			
		}
		else
		{
			
			 setSrno(getSrno());
			 setSrno(getDocno());
			setHidmasterdate(sqlmasterDate.toString());
			setAssetid(getAssetid());  
			setAssetname(getAssetname());
			setAssetGroupval(getAssetGroup());
			setLocationval(getLocation());
	        setSupcmbcurrency(getSupcmbcurrency()); 
	        setSuphidcurrencytype( getSuphidcurrencytype());
	        setHidpurchasedate(sqlpuchaseDate.toString());
	        setHidwarexpdate(sqlwarExpDate.toString());
	        setDepnotes(getDepnotes());
	        setRefno(getRefno()); 
	        
	        setSupplieraccName(getSupplieraccName());
	        
	        setRemarks(getRemarks());
	        setSupplieraccId(getSupplieraccId());
	        setSupaccdocno(getSupaccdocno());
	        setPurchrefno(getPurchrefno());
	        setNoofitems(getNoofitems());
	        setWntydocno(getWntydocno());
	        setSubgriddisval(getSubgriddisval());
	        setOpeningval(getOpeningval());
	        setSuprate(getSuprate());
	        setAccumdepr(getAccumdepr()); 
	        setLifetimeyear(getLifetimeyear());
	        setDepper(getDepper());
	        
	        setTotalpuchvalue(getTotalpuchvalue());
	        
	        //fin
	        //fix
	        setFixaccDocno(getFixaccDocno());
	        setFixedassetaccName(getFixedassetaccName());
	        setFixaccType(getFixaccType());
	        setFixedassetaccId(getFixedassetaccId());
	        setFixaccCurrid(getFixaccCurrid());
	        setFixaccRate(getFixaccRate());
	        
	          //acc.dep
	        setAccdepraccDocno(getAccdepraccDocno());
	        setAccdepraccName(getAccdepraccName());
	        setAccdepraccType(getAccdepraccType()) ;
	        setAccdepraccId(getAccdepraccId());
	        setAccdepraccCurrid(getAccdepraccCurrid());
	          setAccdepraccRate(getAccdepraccRate()); 
	      // dep
	       
	        
	 
	        
	        setDepracDocno(getDepracDocno());
	        setDepraccName(getDepraccName());
	        setDepracType(getDepracType());
	        setDepraccId(getDepraccId());
	        setDepracCurrid(getDepracCurrid());
	        setDepracRate(getDepracRate());
	        
	        
	        setMsg("Not Saved");
			return "fail";
			
		}
		}
		
		 else if(getMode().equalsIgnoreCase("View")){
     		
	  			//String branch=null;
	  			
			 masterBean=masterDAO.getViewDetails(session,getDocno());
			 setSrno(getSrno());
	  			setDocno(getDocno());
	  			setHidmasterdate(masterBean.getMasterdate());
				setAssetid(masterBean.getAssetid());  
				setAssetname(masterBean.getAssetname());
				setAssetGroupval(masterBean.getAssetGroup());
				setLocationval(masterBean.getLocation());
		        setSupcmbcurrency(masterBean.getSupcmbcurrency()); 
		        setSuphidcurrencytype(masterBean.getSuphidcurrencytype());
		        setHidpurchasedate(masterBean.getPurchasedate());
		        setHidwarexpdate(masterBean.getWarexpdate());
		        setDepnotes(masterBean.getDepnotes());
		        setRefno(masterBean.getRefno()); 
		        setRemarks(masterBean.getRemarks());
		        setSupplieraccId(masterBean.getSupplieraccId());
		        setSupaccdocno(masterBean.getSupaccdocno());
		        setPurchrefno(masterBean.getPurchrefno());
		        
		        setNoofitems(masterBean.getNoofitems());
		        setWntydocno(masterBean.getWntydocno());
		        setSubgriddisval(masterBean.getSubgriddisval());
		        setOpeningval(masterBean.getOpeningval());
		        setSuprate(masterBean.getSuprate());
		        setAccumdepr(masterBean.getAccumdepr()); 
		        setLifetimeyear(masterBean.getLifetimeyear());
		        setDepper(masterBean.getDepper());
	  			
		        setTotalpuchvalue(masterBean.getTotalpuchvalue());
		        setSupplieraccName(masterBean.getSupplieraccName());
	  			
		        setFixaccDocno(masterBean.getFixaccDocno());
		        setFixedassetaccName(masterBean.getFixedassetaccName());
		        setFixaccType(masterBean.getFixaccType());
		        setFixedassetaccId(masterBean.getFixedassetaccId());
		        setFixaccCurrid(masterBean.getFixaccCurrid());
		        setFixaccRate(masterBean.getFixaccRate());
		        
		          //acc.dep
		        setAccdepraccDocno(masterBean.getAccdepraccDocno());
		        setAccdepraccName(masterBean.getAccdepraccName());
		        setAccdepraccType(masterBean.getAccdepraccType()) ;
		        setAccdepraccId(masterBean.getAccdepraccId());
		        setAccdepraccCurrid(masterBean.getAccdepraccCurrid());
		          setAccdepraccRate(masterBean.getAccdepraccRate()); 
		      // dep
		       
		        
		 
		        
		        setDepracDocno(masterBean.getDepracDocno());
		        setDepraccName(masterBean.getDepraccName());
		        setDepracType(masterBean.getDepracType());
		        setDepraccId(masterBean.getDepraccId());
		        setDepracCurrid(masterBean.getDepracCurrid());
		        setDepracRate(masterBean.getDepracRate());
		        
	  			
	  			
	  			
	  			
	  			
	  			
	  			
	  			
				
				
				
	  			return "success";
	  		}
		 else if(getMode().equalsIgnoreCase("D")){
				
				int Status=masterDAO.delete(getDocno(),getMode(),session);
				//System.out.println("Status"+Status);
			if(Status>0){
				
				 setSrno(getSrno());
				setDocno(getDocno());
			
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			
						
			else{
				 setSrno(getSrno());
					setDocno(getDocno());
				setMsg("Not Deleted");
				return "fail";
			}
	
		
		}
	
		
		return "fail";	
		
	}
	public String PrintAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		 HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String docno=(request.getParameter("docno"));
		String branch=(request.getParameter("branch"));
		
	
		if(ClsCommon.getPrintPath("FAM").contains(".jrxml")==true){
			 
		   param = new HashMap();
		   ClsConnection conobj=new ClsConnection();
       	   Connection conn = null;
       	          	   
       	
       	   
       	   try{
       		   
       		conn = conobj.getMyConnection();	
       		
       		
       		
       		
       		   String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/city1header.jpg");
       		   imgpathheader=imgpathheader.replace("\\", "\\\\");    
       		   
       		 String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/city1footer.jpg");
     		   imgpathfooter=imgpathfooter.replace("\\", "\\\\");    
     		   
     		  String logo=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
    		   logo=logo.replace("\\", "\\\\");    
     		   
       		   param.put("docno", docno);
       		   param.put("brhid", branch);
       		   param.put("imgheader", imgpathheader);
       		   param.put("imgfooter", imgpathfooter);
       		   param.put("logo", logo);
       		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(ClsCommon.getPrintPath("FAM")));	      	     	 
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

private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException,Exception {
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
