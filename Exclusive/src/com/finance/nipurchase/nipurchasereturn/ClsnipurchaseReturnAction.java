package com.finance.nipurchase.nipurchasereturn;

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
 

public class ClsnipurchaseReturnAction {
	ClsCommon commDAO=new ClsCommon();


	ClsnipurchaseReturnDAO purchaseDAO= new ClsnipurchaseReturnDAO(); 
	ClsnipurchaseReturnBean pintbean= new ClsnipurchaseReturnBean(); 
	ClsnipurchaseReturnBean viewobj= new ClsnipurchaseReturnBean(); 
	
	 
	
	
	private String nipurchasedate,amountinwords,lblroundof,lbltotals;
	public String getLbltotals() {
		return lbltotals;
	}
	public void setLbltotals(String lbltotals) {
		this.lbltotals = lbltotals;
	}
	public String getLblroundof() {
		return lblroundof;
	}
	public void setLblroundof(String lblroundof) {
		this.lblroundof = lblroundof;
	}



	private String hidnipurchasedate,ventrno;
	private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no;
	private String refno,acctype,nipuraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
	private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate,lblbranchtrno;
	
	
	private Double nettotal;
	
	// for print 
	private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblinvno,lblinvdate;	
	
	private String lblnettotal;
	
	private String venland,watermarks,venphon,lblrefno,lblpreparedby,venaddress,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
	
	private String url;
	
	
	
	private int taxaccount,hideproducttype;
	
	private double taxpers, roundof ,nettotalval ;
	
	public double getRoundof() { 
		return roundof;
	}
	public void setRoundof(double roundof) {
		this.roundof = roundof;
	}
	public double getNettotalval() {
		return nettotalval;
	}
	public void setNettotalval(double nettotalval) {
		this.nettotalval = nettotalval;
	}



	private String txtproducttype;
	
	private String alabbarqry,lbltotal,lbldiscount,lblnettax;
	
	
	public String getAlabbarqry() {
		return alabbarqry;
	}
	public void setAlabbarqry(String alabbarqry) {
		this.alabbarqry = alabbarqry;
	}
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLbldiscount() {
		return lbldiscount;
	}
	public void setLbldiscount(String lbldiscount) {
		this.lbldiscount = lbldiscount;
	}
	public String getLblnettax() {
		return lblnettax;
	}
	public void setLblnettax(String lblnettax) {
		this.lblnettax = lblnettax;
	}
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getAmountinwords() {
		return amountinwords;
	}
	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
	}
	public String getVentrno() {
		return ventrno;
	}
	public void setVentrno(String ventrno) {
		this.ventrno = ventrno;
	}
	public int getTaxaccount() {
		return taxaccount;
	}
	public void setTaxaccount(int taxaccount) {
		this.taxaccount = taxaccount;
	}
	public int getHideproducttype() {
		return hideproducttype;
	}
	public void setHideproducttype(int hideproducttype) {
		this.hideproducttype = hideproducttype;
	}
	public double getTaxpers() {
		return taxpers;
	}
	public void setTaxpers(double taxpers) {
		this.taxpers = taxpers;
	}
	public String getTxtproducttype() {
		return txtproducttype;
	}
	public void setTxtproducttype(String txtproducttype) {
		this.txtproducttype = txtproducttype;
	}
	public String getWatermarks() {
		return watermarks;
	}
	public void setWatermarks(String watermarks) {
		this.watermarks = watermarks;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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
	public String getLblverifiedon() {
		return lblverifiedon;
	}
	public void setLblverifiedon(String lblverifiedon) {
		this.lblverifiedon = lblverifiedon;
	}
	public String getLblverifiedat() {
		return lblverifiedat;
	}
	public void setLblverifiedat(String lblverifiedat) {
		this.lblverifiedat = lblverifiedat;
	}
	public String getLblapprovedby() {
		return lblapprovedby;
	}
	public void setLblapprovedby(String lblapprovedby) {
		this.lblapprovedby = lblapprovedby;
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
	public String getVenaddress() {
		return venaddress;
	}
	public void setVenaddress(String venaddress) {
		this.venaddress = venaddress;
	}
	public String getVenphon() {
		return venphon;
	}
	public void setVenphon(String venphon) {
		this.venphon = venphon;
	}
	public String getVenland() {
		return venland;
	}
	public void setVenland(String venland) {
		this.venland = venland;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
	
	

	public String getInvno() {                       
		return invno;
	}
	public void setInvno(String invno) {
		this.invno = invno;
	}
	public String getInvDate() {
		return invDate;
	}
	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}
	public String getHidinvDate() {
		return hidinvDate;
	}
	public void setHidinvDate(String hidinvDate) {
		this.hidinvDate = hidinvDate;
	}
	public int getOrdermasterdoc_no() {
		return ordermasterdoc_no;
	}
	public void setOrdermasterdoc_no(int ordermasterdoc_no) {
		this.ordermasterdoc_no = ordermasterdoc_no;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
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
	//-----------------------------------------------------
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
	public String getDocvals() {
		return docvals;
	}
	public void setDocvals(String docvals) {
		this.docvals = docvals;
	}
	public String getLblacno() {
		return lblacno;
	}
	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}
	public String getLblacnoname() {
		return lblacnoname;
	}
	public void setLblacnoname(String lblacnoname) {
		this.lblacnoname = lblacnoname;
	}
	public String getLbldeldate() {
		return lbldeldate;
	}
	public void setLbldeldate(String lbldeldate) {
		this.lbldeldate = lbldeldate;
	}
	public String getLbldddtm() {
		return lbldddtm;
	}
	public void setLbldddtm(String lbldddtm) {
		this.lbldddtm = lbldddtm;
	}
	public String getLblpatms() {
		return lblpatms;
	}
	public void setLblpatms(String lblpatms) {
		this.lblpatms = lblpatms;
	}
	public String getLbldsc() {
		return lbldsc;
	}
	public void setLbldsc(String lbldsc) {
		this.lbldsc = lbldsc;
	}
	
	
	
	
	
	
	
	
	
	
	
	//-----------------------------------------------
	
	
	
	
	
	
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
	public int getTarannumber() {
		return tarannumber;
	}
	public void setTarannumber(int tarannumber) {
		this.tarannumber = tarannumber;
	}
	public String getNipurchasedate() {
		return nipurchasedate;
	}
	public void setNipurchasedate(String nipurchasedate) {
		this.nipurchasedate = nipurchasedate;
	}
	public String getHidnipurchasedate() {
		return hidnipurchasedate;
	}
	public void setHidnipurchasedate(String hidnipurchasedate) {
		this.hidnipurchasedate = hidnipurchasedate;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getRefno() {    
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getAccdocno() {
		return accdocno;
	}
	public void setAccdocno(String accdocno) {
		this.accdocno = accdocno;
	}
	
	public String getAcctype() {
		return acctype;
	}

	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}


	public String getNipuraccid() {
		return nipuraccid;
	}
	public void setNipuraccid(String nipuraccid) {
		this.nipuraccid = nipuraccid;
	}
	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}
	public String getCmbcurr() {                            
		return cmbcurr;
	}
	public void setCmbcurr(String cmbcurr) {
		this.cmbcurr = cmbcurr;
	}
	public String getCurrate() {
		return currate;
	}
	public void setCurrate(String currate) {
		this.currate = currate;
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
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	public String getNireftype() {
		return nireftype;
	}
	public void setNireftype(String nireftype) {
		this.nireftype = nireftype;
	}

	public Double getNettotal() {
		return nettotal;
	}
	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}
	public int getNidescdetailslenght() {
		return nidescdetailslenght;
	}
	public void setNidescdetailslenght(int nidescdetailslenght) {
		this.nidescdetailslenght = nidescdetailslenght;
	}
	
	/// relode

	
	public String getCmbcurrval() {
		return cmbcurrval;
	}
	public void setCmbcurrval(String cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}
	public String getAcctypeval() {
		return acctypeval;
	}
	public void setAcctypeval(String acctypeval) {
		this.acctypeval = acctypeval;
	}
	
	
	
	public String getReftypeval() {
		return reftypeval;
	}
	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	// form name
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchasedate());
		java.sql.Date sqlpurdeldate = commDAO.changeStringtoSqlDate(getDeliverydate());
		
	
		java.sql.Date sqlinvdate=null;
		if(!(getInvno().equalsIgnoreCase("")) &&  !(getInvno().equalsIgnoreCase("NA")))
				{

                 sqlinvdate = commDAO.changeStringtoSqlDate(getInvDate());
                 
             	//System.out.println("-------getInvno---asdcsdafsdf");
				}
		
		
		
		String mode=getMode();

	
if(mode.equalsIgnoreCase("A")){
	ArrayList<String> descarray= new ArrayList<>();
	
	for(int i=0;i<getNidescdetailslenght();i++){
		String temp2=requestParams.get("desctest"+i)[0];
 
		descarray.add(temp2);
	 
	}   
	int val=purchaseDAO.insert(sqlStartDate1,sqlpurdeldate,getNireftype(),getOrdermasterdoc_no(),getAcctype(),getAccdocno(),getPuraccname(), 
			getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),
			request,sqlinvdate,getInvno(),getInvDate(),getHideproducttype(),getRoundof(),getNettotalval());
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0){
		 
		
		int tanss=(int) request.getAttribute("trans");
		setTarannumber(tanss);
		setRoundof(getRoundof());
		setNettotalval(getNettotalval());
		
		setHidinvDate(sqlinvdate.toString());
		setInvno(getInvno());
		setHidnipurchasedate(sqlStartDate1.toString());
		
		setHidnipurchasedate(sqlStartDate1.toString());
		setHiddeliverydate(sqlpurdeldate.toString());
		setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
		setTaxaccount(getTaxaccount());
		setHideproducttype(getHideproducttype());
		setTaxpers(getTaxpers());
		setTxtproducttype(getTxtproducttype());
		setRefno(getRefno());
		setReftypeval(getNireftype());
		setAcctypeval(getAcctype());
		setNipuraccid(getNipuraccid());
		setPuraccname(getPuraccname());
		setCmbcurrval(getCmbcurr());
		setAccdocno(getAccdocno());
	    setCurrate(getCurrate());
	    setDelterms(getDelterms());
	    setPayterms(getPayterms());
	    setPurdesc(getPurdesc());
	    setNettotal(getNettotal());
		//setDocno(val);
		setDocno(vdocno);
		setMasterdoc_no(val);
		setMsg("Successfully Saved");
		return "success";
	}
	else{
		setHidinvDate(sqlinvdate.toString());
		setInvno(getInvno());
		setHidnipurchasedate(sqlStartDate1.toString());
		setHiddeliverydate(sqlpurdeldate.toString());
		setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
		setTaxaccount(getTaxaccount());
		setHideproducttype(getHideproducttype());
		setTaxpers(getTaxpers());
		setTxtproducttype(getTxtproducttype());
		setRefno(getRefno());
		setReftypeval(getNireftype());
		setAcctypeval(getAcctype());
		setNipuraccid(getNipuraccid());
		setPuraccname(getPuraccname());
		setCmbcurrval(getCmbcurr());
		setAccdocno(getAccdocno());
	    setCurrate(getCurrate());
	    setDelterms(getDelterms());
		setRoundof(getRoundof());
		setNettotalval(getNettotalval());
	    setPayterms(getPayterms());
	    setPurdesc(getPurdesc());
	    setNettotal(getNettotal());
		setDocno(vdocno);
		setMasterdoc_no(val);
		setMsg("Not Saved");
		return "fail";
	}
}


	else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getNidescdetailslenght();i++){
			String temp2=requestParams.get("desctest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
		 
		}
		boolean Status=purchaseDAO.edit(getMasterdoc_no(),sqlStartDate1,sqlpurdeldate,getNireftype(),getOrdermasterdoc_no(),
				getAcctype(),getAccdocno(),getPuraccname(), getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getTarannumber(),request,sqlinvdate,
				getInvno(),getInvDate(),getHideproducttype(),getRoundof(),getNettotalval());
		if(Status){
			setTarannumber(getTarannumber());
			
			setHidinvDate(sqlinvdate.toString());
			setInvno(getInvno());
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			setHidnipurchasedate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
			setRefno(getRefno());
			setRoundof(getRoundof());
			setNettotalval(getNettotalval());
			setReftypeval(getNireftype());
			setAcctypeval(getAcctype());
			setNipuraccid(getNipuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			//setDocno(getDocno());
		
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setMsg("Updated Successfully");
			return "success";
		
		}
		else{
			setTarannumber(getTarannumber());
			
			setHidinvDate(sqlinvdate.toString());
			setInvno(getInvno());
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			setHidnipurchasedate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
			setRefno(getRefno());
			setReftypeval(getNireftype());
			setAcctypeval(getAcctype());
			setNipuraccid(getNipuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
			setRoundof(getRoundof());
			setNettotalval(getNettotalval());
		    setNettotal(getNettotal());
			//setDocno(getDocno());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setMsg("Not Updated");
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=purchaseDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
		setRefno(getRefno());
		setReftypeval(getNireftype());
		setAcctypeval(getAcctype());
		setNipuraccid(getNipuraccid());
		setPuraccname(getPuraccname());
		setCmbcurrval(getCmbcurr());
		setAccdocno(getAccdocno());
    	setCurrate(getCurrate());
	    setDelterms(getDelterms());
     	setPayterms(getPayterms());
	    setPurdesc(getPurdesc());
	    setNettotal(getNettotal());
	//	setDocno(getDocno());
		setRoundof(getRoundof());
		setNettotalval(getNettotalval());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
		setRefno(getRefno());
		setReftypeval(getNireftype());
		setAcctypeval(getAcctype());
		setNipuraccid(getNipuraccid());
		setPuraccname(getPuraccname());
		setCmbcurrval(getCmbcurr());
		setAccdocno(getAccdocno());
    	setCurrate(getCurrate());
	    setDelterms(getDelterms());
     	setPayterms(getPayterms());
	    setPurdesc(getPurdesc());
		setRoundof(getRoundof());
		setNettotalval(getNettotalval());
	    setNettotal(getNettotal());
		//setDocno(getDocno());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setMsg("Not Deleted");
		return "fail";
	}

}

else if(mode.equalsIgnoreCase("view")){
	
	
	System.out.println("====================="+getMasterdoc_no());
	

	viewobj=purchaseDAO.getViewDetails(getDocno(),session);
	
	
	setTarannumber(viewobj.getTarannumber());
	
	setHidinvDate(viewobj.getHidinvDate());
	setInvno(viewobj.getInvno());
	setHidnipurchasedate(viewobj.getHidnipurchasedate());
	
	setRoundof(viewobj.getRoundof());
	setNettotalval(viewobj.getNettotalval());
	 
	setHiddeliverydate(viewobj.getHiddeliverydate());
	setOrdermasterdoc_no(viewobj.getOrdermasterdoc_no()) ;
	setRefno(viewobj.getRefno());
	setReftypeval(viewobj.getReftypeval());
	setAcctypeval(viewobj.getAcctypeval());
	setNipuraccid(viewobj.getNipuraccid());
	setPuraccname(viewobj.getPuraccname());
	setCmbcurrval(viewobj.getCmbcurrval());
	setAccdocno(viewobj.getAccdocno());
	setCurrate(viewobj.getCurrate());
	  
	  setHideproducttype(viewobj.getHideproducttype());
	  setTxtproducttype(viewobj.getTxtproducttype());
	  setTaxpers(viewobj.getTaxpers());
	
	   
	
	 setDelterms(viewobj.getDelterms());
	 setPayterms(viewobj.getPayterms());
	 setPurdesc(viewobj.getPurdesc());
 setNettotal(viewobj.getNettotal());
	//setDocno(val);
	 setDocno(viewobj.getDocno());
	 setMasterdoc_no(viewobj.getMasterdoc_no());
	
	
 
	

}

return "fail";	

}
	
	
	
		
	
	
	 public String printAction() throws ParseException, SQLException{
		 //System.out.println("heloooooooo");
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 String brhid=request.getParameter("brhid").toString();
		 String dtype=request.getParameter("dtype").toString();
		      
		setUrl(commDAO.getPrintPath(dtype));
		System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
	 pintbean=purchaseDAO.getPrint(doc,request,session,brhid);
		 
		 
		
		  //cl details
	 setLblbranchtrno(pintbean.getLblbranchtrno());
	 
	 setLblroundof(pintbean.getLblroundof());
	 setLbltotals(pintbean.getLbltotals());
	 setVentrno(pintbean.getVentrno());
	 setWatermarks(pintbean.getWatermarks());
	 setLblpreparedby(pintbean.getLblpreparedby());
	 setLblpreparedon(pintbean.getLblpreparedon());
	    setLblpreparedat(pintbean.getLblpreparedat());
	      setLblverifiedat(pintbean.getLblverifiedat());
	      setLblverifiedon(pintbean.getLblverifiedon());
	      setLblapprovedat(pintbean.getLblapprovedat());
	      setLblapprovedon(pintbean.getLblapprovedon());
	      setLblapprovedby(pintbean.getLblapprovedby());
	      setLblverifiedby(pintbean.getLblverifiedby());
		          setLblprintname("NI Purchase Return");
		         setLbldate(pintbean.getLbldate());
		    	   setLbltype(pintbean.getLbltype());
		    	   setDocvals(pintbean.getDocvals());
		    	   setLblacno(pintbean.getLblacno());
			    	setVenland(pintbean.getVenland());
			    	setVenphon(pintbean.getVenphon());
			    	setVenaddress(pintbean.getVenaddress());
		    	   setLblacnoname(pintbean.getLblacnoname());
		    	   setLbldeldate(pintbean.getLbldeldate());
		    	    setLbldddtm(pintbean.getLbldddtm());
		    	    
		    	   setLbldsc(pintbean.getLbldsc());
		    	   setLblpatms(pintbean.getLblpatms());
		
		    	   setLblnettotal(pintbean.getLblnettotal());
		    	   setAmountinwords(pintbean.getWordnetamount());
		 // System.out.println("jdjjj"+(pintbean.getWordnetamount()));
		
 	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  

	   setLblinvno(pintbean.getLblinvno());
	   setLblinvdate(pintbean.getLblinvdate());
	   System.out.println("commDAO.getPrintPath(dtype)=="+commDAO.getPrintPath(dtype));
	   if(commDAO.getPrintPath(dtype).contains("jrxml")==true)
   	   
	   {
		  System.out.println("inside jrxml");
		    HttpServletResponse response = ServletActionContext.getResponse();
		    	 
			 param = new HashMap();
			 Connection conn = null;
			 
			 String reportFileName = "NIPurchaseInvoice";
			 							
			 ClsConnection conobj=new ClsConnection();
			 conn = conobj.getMyConnection();
		     
			 try {      
				   param.put("termsquery",pintbean.getTermQry());
		                
		         param.put("descQry",pintbean.getDescQry());
		         
		       //  System.out.println("product++++++++++"+productQuery);
		         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
		        	imgpath=imgpath.replace("\\", "\\\\");    
		          param.put("imghedderpath", imgpath);
		          
		          
		          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		        	imgpath2=imgpath2.replace("\\", "\\\\");    
		          param.put("imgfooterpath", imgpath2);
		          
		          
		      
		          param.put("vendor", pintbean.getLblacnoname());
		          param.put("attn", pintbean.getAttn());
		          param.put("tel", pintbean.getTel());
		          param.put("fax", pintbean.getFax());
		          param.put("email", pintbean.getEmail());
		          param.put("docno",doc);
		          param.put("date", pintbean.getLbldate());
		          param.put("refno", pintbean.getRefno());
		          param.put("desc", pintbean.getLbldsc());
		          param.put("payterm", pintbean.getLblpatms());
		          param.put("delterm", pintbean.getLbldddtm());
		          param.put("netamount", pintbean.getLblnettotal());
		          param.put("amountwords", pintbean.getWordnetamount());
			  param.put("taxnetamount", pintbean.getLblnettotal());
		          param.put("taxamountwords", pintbean.getWordnetamount());
		          param.put("clienttrno", pintbean.getTinno());
			  param.put("compnytrno", pintbean.getCompanytrno());
			  
			//alabbar
			  String imgpath1=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		      	imgpath1=imgpath1.replace("\\", "\\\\");
		        param.put("imghedderpath", imgpath1);

			  param.put("taxqry",pintbean.getAlabbarqry());
		      
		      param.put("address",pintbean.getVenaddress());
		      param.put("phoneno",pintbean.getVenphon());
		      param.put("trnno",pintbean.getVentrno());
		      param.put("landno",pintbean.getVenland());			      
		      param.put("refno",pintbean.getLblrefno());
		      param.put("deldate",pintbean.getLbldeldate());
		      param.put("delterms",pintbean.getLbldddtm());
		      param.put("payterms",pintbean.getLblpatms());
		      param.put("description",pintbean.getLbldsc());
		      param.put("docno",pintbean.getDocvals());
		      param.put("date",pintbean.getLbldate());
		      param.put("nettotal",pintbean.getLblnettotal());
		      param.put("amtinwords",pintbean.getWordnetamount());
		      param.put("preparedby",pintbean.getLblpreparedby());
		      param.put("pdate",pintbean.getLblpreparedon());
		      param.put("ptime",pintbean.getLblpreparedat());
		      param.put("verifiedby",pintbean.getLblverifiedby());
		      param.put("vdate",pintbean.getLblverifiedon());
		      param.put("vtime",pintbean.getLblverifiedat());
		      param.put("approvedby",pintbean.getLblapprovedby());
		      param.put("adate",pintbean.getLblapprovedon());
		      param.put("atime",pintbean.getLblapprovedon());
		      param.put("total", pintbean.getLbltotal());
		      param.put("discount", pintbean.getLbldiscount());
		      param.put("nettax", pintbean.getLblnettax());
		      param.put("invno", pintbean.getLblinvno());
		      param.put("type", pintbean.getLbltype());
		      param.put("invdate", pintbean.getLblinvdate());
		      
		      param.put("compbranch",pintbean.getLblbranch());
		      param.put("compname",pintbean.getLblcompname());				  
		      param.put("compaddress",pintbean.getLblcompaddress());				 
		      param.put("comptel",pintbean.getLblcomptel());				  
		      param.put("compfax",pintbean.getLblcompfax());
		      param.put("complocation",pintbean.getLbllocation());
			      
		       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
		     //   System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/nipurchase/nipurchase/"+commDAO.getPrintPath(dtype)));
         	 
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
