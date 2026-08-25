package com.procurement.purchase.purchaseinvoice;

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
 


 
public class ClspurchaseinvoiceAction {
	
	
	ClsCommon ClsCommon=new ClsCommon();
	
	
	private String  masterdate,txtlocation,invdate,hidinvdate,invno,hidmasterdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,formdetailcode,puraccname,refno,reqmasterdocno, reftype,rrefno,reftypeval,editdata;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount,expencenettotal,descgridhid,descgridtax;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,expgridlength,txtlocationid;
	private String venland,watermarks,venphon,lblpreparedby,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
	
	
	 
 
	
	



	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	
	
	private int cmbbilltype,hidcmbbilltype;
	
	
	 private int  hideitemtype, itemdocno,itemtype,costtr_no;
	 
	 private String itemname;
	 
	

	public int getHideitemtype() {
		return hideitemtype;
	}

	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}

	public int getItemdocno() {
		return itemdocno;
	}

	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}

	public int getItemtype() {
		return itemtype;
	}

	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}

	public int getCosttr_no() {
		return costtr_no;
	}

	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getWatermarks() {
		return watermarks;
	}

	public void setWatermarks(String watermarks) {
		this.watermarks = watermarks;
	}

	public String getVenland() {
		return venland;
	}

	public void setVenland(String venland) {
		this.venland = venland;
	}

	public String getVenphon() {
		return venphon;
	}

	public void setVenphon(String venphon) {
		this.venphon = venphon;
	}

	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public String getLblverifiedby() {
		return lblverifiedby;
	}

	public void setLblverifiedby(String lblverifiedby) {
		this.lblverifiedby = lblverifiedby;
	}

	public String getLblapprovedby() {
		return lblapprovedby;
	}

	public void setLblapprovedby(String lblapprovedby) {
		this.lblapprovedby = lblapprovedby;
	}

	public String getLblverifiedon() {
		return lblverifiedon;
	}

	public void setLblverifiedon(String lblverifiedon) {
		this.lblverifiedon = lblverifiedon;
	}

	public String getLblapprovedon() {
		return lblapprovedon;
	}

	public void setLblapprovedon(String lblapprovedon) {
		this.lblapprovedon = lblapprovedon;
	}

	public String getLblapprovedat() {
		return lblapprovedat;
	}

	public void setLblapprovedat(String lblapprovedat) {
		this.lblapprovedat = lblapprovedat;
	}

	public String getLblverifiedat() {
		return lblverifiedat;
	}

	public void setLblverifiedat(String lblverifiedat) {
		this.lblverifiedat = lblverifiedat;
	}

	public double getSt() {
		return st;
	}

	public void setSt(double st) {
		this.st = st;
	}

	public double getTaxontax1() {
		return taxontax1;
	}

	public void setTaxontax1(double taxontax1) {
		this.taxontax1 = taxontax1;
	}

	public double getTaxontax2() {
		return taxontax2;
	}

	public void setTaxontax2(double taxontax2) {
		this.taxontax2 = taxontax2;
	}

	public double getTaxontax3() {
		return taxontax3;
	}

	public void setTaxontax3(double taxontax3) {
		this.taxontax3 = taxontax3;
	}

	public double getTaxtotal() {
		return taxtotal;
	}

	public void setTaxtotal(double taxtotal) {
		this.taxtotal = taxtotal;
	}

	public int getCmbbilltype() {
		return cmbbilltype;
	}

	public void setCmbbilltype(int cmbbilltype) {
		this.cmbbilltype = cmbbilltype;
	}

	public int getHidcmbbilltype() {
		return hidcmbbilltype;
	}

	public void setHidcmbbilltype(int hidcmbbilltype) {
		this.hidcmbbilltype = hidcmbbilltype;
	}

	public String getEditdata() {
		return editdata;
	}

	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}

 

	public double getExpencenettotal() {
		return expencenettotal;
	}

	public void setExpencenettotal(double expencenettotal) {
		this.expencenettotal = expencenettotal;
	}

	public int getExpgridlength() {
		return expgridlength;
	}

	public void setExpgridlength(int expgridlength) {
		this.expgridlength = expgridlength;
	}

	public double getPrddiscount() {
		return prddiscount;
	}

	public void setPrddiscount(double prddiscount) {
		this.prddiscount = prddiscount;
	}

	public String getReqmasterdocno() {
		return reqmasterdocno;
	}

	public void setReqmasterdocno(String reqmasterdocno) {
		this.reqmasterdocno = reqmasterdocno;
	}

	public String getReftypeval() {
		return reftypeval;
	}

	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}

	public String getReftype() {
		return reftype;
	}

	public void setReftype(String reftype) {     
		this.reftype = reftype;
	}

	public String getRrefno() {
		return rrefno;
	}

	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
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

	public String getDeliverydate() {
		return deliverydate;
	}

	public void setDeliverydate(String deliverydate) { 
		this.deliverydate = deliverydate;
	}

	public String getHiddeliverydate() {
		return hiddeliverydate;
	}

	public void setHiddeliverydate(String hiddeliverydate) {
		this.hiddeliverydate = hiddeliverydate;
	}

	public String getDelterms() {
		return delterms;
	}

	public void setDelterms(String delterms) {
		this.delterms = delterms;
	}

	public String getPayterms() {
		return payterms;
	}

	public void setPayterms(String payterms) {
		this.payterms = payterms;
	}

	public String getPurdesc() {
		return purdesc;
	}

	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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

	public double getCurrate() {
		return currate;
	}

	public void setCurrate(double currate) { 
		this.currate = currate;
	}

	public double getProductTotal() { 
		return productTotal;
	}

	public void setProductTotal(double productTotal) {   
		this.productTotal = productTotal;
	}

	public double getDescPercentage() {
		return descPercentage;
	}

	public void setDescPercentage(double descPercentage) {
		this.descPercentage = descPercentage;
	}

	public double getDescountVal() {
		return descountVal;
	}

	public void setDescountVal(double descountVal) {
		this.descountVal = descountVal;
	}

	public double getRoundOf() {
		return roundOf;
	}

	public void setRoundOf(double roundOf) {
		this.roundOf = roundOf;
	}

	public double getNetTotaldown() {
		return netTotaldown;
	}

	public void setNetTotaldown(double netTotaldown) {
		this.netTotaldown = netTotaldown;
	}

	public double getNettotal() {
		return nettotal;
	}

	public void setNettotal(double nettotal) {
		this.nettotal = nettotal;
	}

	public double getOrderValue() {
		return orderValue;
	}

	public void setOrderValue(double orderValue) {
		this.orderValue = orderValue;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getCmbcurr() {
		return cmbcurr;
	}

	public void setCmbcurr(int cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public int getChkdiscount() {
		return chkdiscount;
	}

	public void setChkdiscount(int chkdiscount) {
		this.chkdiscount = chkdiscount;
	}
	
/*	nipurchaseorderdate hidnipurchaseorderdate refno docno cmbcurr currate
	
	deliverydate hiddeliverydate delterms payterms purdesc  productTotal chkdiscount descPercentage descountVal roundOf netTotaldown nettotal  orderValue msg mode deleted*/
	
	
	
	public int getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
	}
	
	public double getDescgridhid() {
		return descgridhid;
	}

	public void setDescgridhid(double descgridhid) {
		this.descgridhid = descgridhid;
	}

	public double getDescgridtax() {
		return descgridtax;
	}

	public void setDescgridtax(double descgridtax) {
		this.descgridtax = descgridtax;
	}	
	

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}




	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}

	public int getServiecGridlength() {
		return serviecGridlength;
	}

	public void setServiecGridlength(int serviecGridlength) {
		this.serviecGridlength = serviecGridlength;
	}




	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}




	public int getChkdiscountval() {
		return chkdiscountval;
	}

	public void setChkdiscountval(int chkdiscountval) {
		this.chkdiscountval = chkdiscountval;
	}




	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}

	public int getPuraccid() {
		return puraccid;
	}

	public void setPuraccid(int puraccid) {      
		this.puraccid = puraccid;
	}



 

 



	public double getCmbcurrval() {
		return cmbcurrval;
	}

	public void setCmbcurrval(double cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}









	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {       
		this.txtlocation = txtlocation;
	}

	public String getInvdate() {
		return invdate;
	}

	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}

	public String getHidinvdate() {
		return hidinvdate;
	}

	public void setHidinvdate(String hidinvdate) {
		this.hidinvdate = hidinvdate;
	}

	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}



	private String  lblsubtotal,lbltotal,lbltax,lblroundOf,lbltotnetamnt,lblnetamount,lblnetTotaldown,lblordervalue,lblordervaluewords,lblsubtotalexp,lblexptotal;
	
	public String getLblroundOf() {
		return lblroundOf;
	}

	public void setLblroundOf(String lblroundOf) {
		this.lblroundOf = lblroundOf;
	}

	public String getLbltotnetamnt() {
		return lbltotnetamnt;
	}

	public void setLbltotnetamnt(String lbltotnetamnt) {
		this.lbltotnetamnt = lbltotnetamnt;
	}

	
	public String getLbltax() {
		return lbltax;
	}

	public void setLbltax(String lbltax) {
		this.lbltax = lbltax;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
    
	public String getLblnetTotaldown() {
		return lblnetTotaldown;
	}

	public void setLblnetTotaldown(String lblnetTotaldown) {
		this.lblnetTotaldown = lblnetTotaldown;
	}



	private int firstarray,secarray,thirdarray;
	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName,lbltrnno, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblinvno,lblinvdate,lblloc;
	
	
	private int lbldoc;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblbranchtrno;	



	
	
	
	

	 //getTxtlocation() getInvdate() getHidinvdate() getInvno() getTxtlocationid()


	public String getLblsubtotalexp() {
		return lblsubtotalexp;
	}

	public void setLblsubtotalexp(String lblsubtotalexp) {
		this.lblsubtotalexp = lblsubtotalexp;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLblvendoeacc() {
		return lblvendoeacc;
	}

	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}

	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}

	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}

	public String getLbltrnno() {
		return lbltrnno;
	}

	public void setLbltrnno(String lbltrnno) {
		this.lbltrnno = lbltrnno;
	}

	public String getExpdeldate() {
		return expdeldate;
	}

	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}

	public String getLbldelterms() {
		return lbldelterms;
	}

	public void setLbldelterms(String lbldelterms) {
		this.lbldelterms = lbldelterms;
	}

	public String getLblpaytems() {
		return lblpaytems;
	}

	public void setLblpaytems(String lblpaytems) {
		this.lblpaytems = lblpaytems;
	}

	public String getLbldesc1() {
		return lbldesc1;
	}

	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}

	public String getLblinvdate() {
		return lblinvdate;
	}

	public void setLblinvdate(String lblinvdate) {
		this.lblinvdate = lblinvdate;
	}

	public String getLblloc() {
		return lblloc;
	}

	public void setLblloc(String lblloc) {
		this.lblloc = lblloc;
	}

	public int getLbldoc() {
		return lbldoc;
	}

	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}

	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}

	public String getLblsubtotal() {
		return lblsubtotal;
	}

	public void setLblsubtotal(String lblsubtotal) {
		this.lblsubtotal = lblsubtotal;
	}

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLblordervalue() {
		return lblordervalue;
	}

	public void setLblordervalue(String lblordervalue) {
		this.lblordervalue = lblordervalue;
	}

	public String getLblordervaluewords() {
		return lblordervaluewords;
	}

	public void setLblordervaluewords(String lblordervaluewords) {
		this.lblordervaluewords = lblordervaluewords;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public String getLblexptotal() {
		return lblexptotal;
	}

	public void setLblexptotal(String lblexptotal) {
		this.lblexptotal = lblexptotal;
	}

	
	public int getThirdarray() {
		return thirdarray;
	}

	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
	}

private String url;
	
	
	
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	ClspurchaseinvoiceDAO saveObj = new ClspurchaseinvoiceDAO();
	
	ClspurchaseinvoiceBean viewObj = new ClspurchaseinvoiceBean();
 
 
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());

	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		
		java.sql.Date invdate = ClsCommon.changeStringtoSqlDate(getInvdate());
		
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			
		 
			String temp2=requestParams.get("desctest"+i)[0];
		 
		
			descarray.add(temp2);
			 
		}
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		 
		
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		ArrayList<String> exparray= new ArrayList<>();
 
		
		for(int i=0;i<getExpgridlength();i++){
			
		 
			String temp2=requestParams.get("exptest"+i)[0];
		 
		
			exparray.add(temp2);
			 
		}
		
		
		
		
		
		
		int val=saveObj.insert(masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,getNetTotaldown(),getNettotal(),
				getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,masterarray,getReftype(),
				getReqmasterdocno(),getPrddiscount(),exparray,getExpencenettotal(),invdate,getInvno(),getTxtlocationid(),
				getSt(),getTaxontax1() ,getTaxontax2() ,getTaxontax3(),getTaxtotal(),getCmbbilltype(),getItemtype(),getCosttr_no(),getDescgridhid(),getDescgridtax());
	
		int vdocno=(int) request.getAttribute("vocno");
		
		System.out.println("val========"+val);
		if(val>0)
		{
			setDocno(vdocno);
			setMasterdoc_no(val);
			
			 setDescgridhid(getDescgridhid());
			 setDescgridtax(getDescgridtax());
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			// getMasterdate getHidmasterdate	
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());               
			
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 setHidinvdate(invdate.toString());
			 setInvno(getInvno());
			 
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 
			 setPrddiscount(getPrddiscount());
		
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
        	 setExpencenettotal(getExpencenettotal());
        	    
           	setHideitemtype(getItemtype());
           	
           	setCosttr_no(getCosttr_no());
           
           	setItemname(getItemname());
           	
           	setItemdocno(getItemdocno());
			setMsg("Successfully Saved");
			return "success";
			
		}
		else
		{
			
			// getMasterdate setHidmasterdate	
			setHidmasterdate(masterdate.toString());
			
			
			
			 setDescgridhid(getDescgridhid());
			 setDescgridtax(getDescgridtax());
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 setHidinvdate(invdate.toString());
			 setInvno(getInvno());
				setReqmasterdocno(getReqmasterdocno());
				setReftypeval(getReftype());
				setRrefno(getRrefno());
				
			 setProductTotal(0);
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(0);
             setNettotal(0);
             setOrderValue(0);
			 
        	 setExpencenettotal(0);
        	    
           	setHideitemtype(getItemtype());
           	
           	setCosttr_no(getCosttr_no());
           
           	setItemname(getItemname());
           	
           	setItemdocno(getItemdocno());
			setMsg("Not Saved");
			return "fail";
			
		}
		
		
		
		
		
		
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		java.sql.Date invdate = ClsCommon.changeStringtoSqlDate(getInvdate());
		
		
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			
		 
			String temp2=requestParams.get("desctest"+i)[0];
		 
		
			descarray.add(temp2);
			 
		}
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		
		
		ArrayList<String> exparray= new ArrayList<>();
		
		 
		
		for(int i=0;i<getExpgridlength();i++){
			
		 
			String temp2=requestParams.get("exptest"+i)[0];
		 
		
			exparray.add(temp2);
			 
		}
		
		
		
		
		int val=saveObj.update(getMasterdoc_no(),masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),
				getDelterms(),getPayterms(),getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,
				getNetTotaldown(),getNettotal(),getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,
				masterarray,getReftype(),getReqmasterdocno(),getPrddiscount(),exparray,getEditdata(),getExpencenettotal(),invdate,getInvno(),getTxtlocationid(),
				getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3(), getTaxtotal(),getCmbbilltype(),getItemtype(),getCosttr_no(),getDescgridhid(),getDescgridtax());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			
			
			 setDescgridhid(getDescgridhid());
			 setDescgridtax(getDescgridtax());
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			// getMasterdate setHidmasterdate	
			setHidmasterdate(masterdate.toString());
		//	setHidnipurchaseorderdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			 
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 setHidinvdate(invdate.toString());
			 setInvno(getInvno());
			 
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
        	 setExpencenettotal(getExpencenettotal());
        	    
           	setHideitemtype(getItemtype());
           	
           	setCosttr_no(getCosttr_no());
           
           	setItemname(getItemname());
           	
           	setItemdocno(getItemdocno());
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
			
			
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			
			
			
			 setDescgridhid(getDescgridhid());
			 setDescgridtax(getDescgridtax());
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 setHidinvdate(invdate.toString());
			 setInvno(getInvno());
			 
			 
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
        	 setExpencenettotal(getExpencenettotal());
        	    
           	setHideitemtype(getItemtype());
           	
           	setCosttr_no(getCosttr_no());
           
           	setItemname(getItemname());
           	
           	setItemdocno(getItemdocno());
				setMsg("Not Updated");
			return "fail";
			
		}
		
	 
	}
	else if(mode.equalsIgnoreCase("D")){
		
		
	int val=saveObj.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);
		
		if(val>0)
		{
			
			
		 
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			
			
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 
			 setInvno(getInvno());
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             
        	 setExpencenettotal(getExpencenettotal());
             
             setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
		}
		else
		{
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			
			
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 
			 setInvno(getInvno());
			 
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             
        	 setExpencenettotal(getExpencenettotal());
             
             setMsg("Not Deleted");
             return "fail";
 			
		}
		
		
		
	}	
	else if(mode.equalsIgnoreCase("view")){
		
		ClspurchaseinvoiceDAO ClspurchaseinvoiceDAO=new ClspurchaseinvoiceDAO();
		viewObj= ClspurchaseinvoiceDAO.getViewDetails(getMasterdoc_no());
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(getMasterdoc_no());
 
 
		

		 setDescgridhid(viewObj.getDescgridhid());
		 setDescgridtax(viewObj.getDescgridtax());
		 setSt(viewObj.getSt()); 
		 setTaxontax1(viewObj.getTaxontax1());
		 setTaxontax2(viewObj.getTaxontax2());
		 setTaxontax3(viewObj.getTaxontax3());
		 setTaxtotal(viewObj.getTaxtotal());
		 setHidcmbbilltype(viewObj.getCmbbilltype());

		
		
		setHidmasterdate(viewObj.getMasterdate());
		setHiddeliverydate(viewObj.getDeliverydate());
		setDelterms(viewObj.getDelterms());
		setPayterms(viewObj.getPayterms());
		setPurdesc(viewObj.getPurdesc());
		setCurrate(viewObj.getCurrate());
		setRefno(viewObj.getRefno());
		setCmbcurrval(viewObj.getCmbcurr());
		setAccdocno(viewObj.getAccdocno());
		 setPuraccid(viewObj.getPuraccid()); 
		 setPuraccname(viewObj.getPuraccname());
		 
		 
			
		 setReftypeval(viewObj.getReftype());
		 setRrefno(viewObj.getRrefno());
		 
		 setReqmasterdocno(viewObj.getReqmasterdocno());
		 
		 
		//duwn
		 setProductTotal(viewObj.getProductTotal());
		 setChkdiscountval(viewObj.getChkdiscountval());
		 setDescPercentage(viewObj.getDescPercentage());
		 
		 setPrddiscount(viewObj.getPrddiscount());
		 
		 
		 setDescountVal(viewObj.getDescountVal());
		 setRoundOf(viewObj.getRoundOf());
		 setNetTotaldown(viewObj.getNetTotaldown());
         setNettotal(viewObj.getNettotal());
         setOrderValue(viewObj.getOrderValue());
         setExpencenettotal(viewObj.getExpencenettotal());
         
		
		 setTxtlocation(viewObj.getTxtlocation());   
		 setTxtlocationid(viewObj.getTxtlocationid());
		 setHidinvdate(viewObj.getInvdate());
		 setInvno(viewObj.getInvno());
         
		 setHideitemtype(viewObj.getItemtype());
			
			setCosttr_no(viewObj.getCosttr_no());

			setItemname(viewObj.getItemname());
			
			setItemdocno(viewObj.getItemdocno());
			
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
		ClspurchaseinvoiceBean pintbean= new ClspurchaseinvoiceBean();

		public String printAction() throws ParseException, SQLException{
			//System.out.println("in print action===============");
			  HttpServletRequest request=ServletActionContext.getRequest();
			// System.out.println("in print==========");
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String dtype=request.getParameter("dtype").toString();
			 String brhid=request.getParameter("brhid").toString();
			
			 ClspurchaseinvoiceDAO ClspurchaseinvoiceDAO=new ClspurchaseinvoiceDAO();
			
			 pintbean=ClspurchaseinvoiceDAO.getPrint(doc,request,brhid);
		  String path=ClsCommon.getPrintPath(dtype);
				        setUrl(path);
				  
			 
			
			  //cl details
			 setWatermarks(pintbean.getWatermarks());
			    setLblprintname("Purchase Invoice");
			    setLblbranchtrno(pintbean.getLblbranchtrno());
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			    
		 	      
	    	     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
	    	     setLbltype(pintbean.getLbltype());
	    	     setLblvendoeacc(pintbean.getLblvendoeacc());  
	    	     setLblvendoeaccName(pintbean.getLblvendoeaccName());
	    	     setLbltrnno(pintbean.getLbltrnno());
			     setExpdeldate(pintbean.getExpdeldate());
		 
						
			   	    
                  setLblinvno(pintbean.getLblinvno());
                  setLblinvdate(pintbean.getLblinvdate());
			  
			     
	    	  
					   setLblbranch(pintbean.getLblbranch());
					   setLblcompname(pintbean.getLblcompname());
					  
					   setLblcompaddress(pintbean.getLblcompaddress());
					   setLblcomptel(pintbean.getLblcomptel());
					   setLblcompfax(pintbean.getLblcompfax());
					   setLbllocation(pintbean.getLbllocation());
					  

					    setLblloc(pintbean.getLblloc());
					    
					    
					    
					    
					     setLblroundOf(pintbean.getLblroundOf());
			      	   setLbltotnetamnt(pintbean.getLbltotnetamnt());
			      	     setLbltotal(pintbean.getLbltotal());
			      	   setLbltax(pintbean.getLbltax());
			      	 setLblnetamount(pintbean.getLblnetamount());
			      	setLblnetTotaldown(pintbean.getLblnetTotaldown());   
			    	     setLblsubtotal(pintbean.getLblsubtotal());
			    	     setLblsubtotalexp(pintbean.getLblsubtotalexp());
			    	    
			    	    
			            setLblordervaluewords(pintbean.getLblordervaluewords());
			    	     
			    	    
			    	     setLblordervalue(pintbean.getLblordervalue());
					      
			    	     setLblexptotal(pintbean.getLblexptotal());
					    
					    
			    	      setFirstarray(pintbean.getFirstarray());
				            setSecarray(pintbean.getSecarray());
							 setThirdarray(pintbean.getThirdarray()); 
							 setLblpreparedon(pintbean.getLblpreparedon());
					    	    setLblpreparedat(pintbean.getLblpreparedat());
							 setLblpreparedby(pintbean.getLblpreparedby());
							      setLblverifiedat(pintbean.getLblverifiedat());
							      setLblverifiedon(pintbean.getLblverifiedon());
							      setLblapprovedat(pintbean.getLblapprovedat());
							      setLblapprovedon(pintbean.getLblapprovedon());
							      setLblapprovedby(pintbean.getLblapprovedby());
							      setLblverifiedby(pintbean.getLblverifiedby());
					//jrxml
							 
							 //System.out.println("ClsCommon.getPrintPath(dtype)="+ClsCommon.getPrintPath(dtype));

							if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
			{
								
				
			    HttpServletResponse response = ServletActionContext.getResponse();
			    
			  // System.out.println("in if====");
			    setUrl(ClsCommon.getPrintPath(dtype));
			   
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "PurchaseInvoice";
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
			     
				 try {      
					// System.out.println("=======bean.getterms======"+pintbean.getTermQry());
					// System.out.println("=======bean.prd======"+pintbean.getPrdQry());
			       param.put("termsquery",pintbean.getTermQry()==null?"":pintbean.getTermQry());
			       param.put("productQuery",pintbean.getPrdQry()==null?"":pintbean.getPrdQry());
			       param.put("servquery",pintbean.getSrvQyy()==null?"":pintbean.getSrvQyy());
			       
			       String imghedderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader1.jpg");
			       imghedderpath=imghedderpath.replace("\\", "\\\\");
			       String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			       imgpath=imgpath.replace("\\", "\\\\");    
			       String imgpath2=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			       imgpath2=imgpath2.replace("\\", "\\\\");   
			       
			       String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/footer.jpg");
			       imgpathfooter=imgpathfooter.replace("\\", "\\\\");
			       
			       String imgpathmmj=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			       imgpathmmj=imgpathmmj.replace("\\", "\\\\");    
		          param.put("headermmj", imgpathmmj);
		          
		          
		          String imgpath2mmj=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		          imgpath2mmj=imgpath2mmj.replace("\\", "\\\\");    
		          param.put("footermmj", imgpath2mmj);
			      
			      
			       param.put("imghedderpath", imghedderpath);
			       param.put("imgpathfooter", imgpathfooter);
			       param.put("vendor", pintbean.getLblvendoeaccName());
			       param.put("attn", pintbean.getAttn());
			       param.put("tel", pintbean.getTel());
			       param.put("fax", pintbean.getFax());
			       param.put("email", pintbean.getEmail());
			       param.put("docno",doc);
			       param.put("date", pintbean.getLbldate());
			       param.put("refno", pintbean.getLblrefno());
			       param.put("desc", pintbean.getLbldesc1());
			       param.put("payterm", pintbean.getLblpaytems());
			       param.put("delterm", pintbean.getLbldelterms());
			       param.put("prdnetamount", pintbean.getLbltotal());
			       param.put("srvnetamount", pintbean.getSrvtotal());
			       param.put("netamount", pintbean.getNetAmountprint());
			       param.put("amountwords", pintbean.getWordnetAmtPrint());
			       param.put("clienttrno", pintbean.getTinno());
			       param.put("compnytrno", pintbean.getCompanytrno());
				   param.put("aitsprdnetamount", pintbean.getAitsprdchrg());
				   param.put("tsrvnetamount", pintbean.getAitssrcchrg());
				   param.put("tdiscount", pintbean.getAitsnetdiscount());
				   param.put("taxamnt", pintbean.getAitstax());
				   param.put("tnetamount",pintbean.getAitsnettotal());
				   param.put("tamountwords", pintbean.getAitsnettotword());
				   ///////////////////////
				   param.put("type", pintbean.getLbltype());
				   param.put("type", pintbean.getLbltype());
				   param.put("deldate", pintbean.getExpdeldate());
				   param.put("dellocation", pintbean.getLblloc());
				   param.put("invno", pintbean.getLblinvno());
				   param.put("invdate", pintbean.getLblinvdate());
				   
				   param.put("preparedby", pintbean.getLblpreparedby());
				   param.put("verifiedby", pintbean.getLblverifiedby());
				   param.put("approvedby", pintbean.getLblapprovedby());
				   
				   param.put("compname", pintbean.getLblcompname());
				   param.put("compaddress", pintbean.getLblcompaddress());
				   param.put("comptel", pintbean.getLblcomptel());
				   param.put("compfax", pintbean.getLblcompfax());
				   param.put("compbranch", pintbean.getLblbranch());
				   param.put("complocation", pintbean.getLbllocation());
				   
				  // System.out.println("compbranch>>><<<"+pintbean.getLblbranch()+"---"+pintbean.getLbllocation());
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			         /* String path[]=ClsCommon.getPrintPath(dtype).split("purchaseinvoice/");
				        setUrl(path[1]);*/
			            path=ClsCommon.getPrintPath(dtype);
				        setUrl(path);
				      // System.out.println("print==========="+path);
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/Procurement/Purchase/purchaseinvoice/"+ClsCommon.getPrintPath(dtype)));
		                 
	            // JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(ClsCommon.getPrintPath(dtype)));
	         	 JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	       

	   } 
				 catch (Exception e) {

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
