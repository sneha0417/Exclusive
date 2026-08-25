package com.finance.nipurchase.nipurchase;





import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderBean;
import com.opensymphony.xwork2.ActionSupport;




	@SuppressWarnings("serial")
	public class ClsnipurchaseAction extends ActionSupport{

		ClsCommon commDAO=new ClsCommon();


		ClsnipurchaseDAO purchaseDAO= new ClsnipurchaseDAO(); 
		ClsnipurchaseBean pintbean= new ClsnipurchaseBean(); 
		
		ClsnipurchaseBean viewobj= new ClsnipurchaseBean();
		
		private String nipurchasedate;
		private String hidnipurchasedate;
		private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no;
		
		private int cmbbilltype,hidcmbbilltype;
		
		private String refno,acctype,nipuraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
		private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate,lblcomptrn;
		
		
		private Double nettotal;
		
		// for print 
		private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblinvno,lblinvdate;	
		
		private String lblnettotal,lbltaxtot,lbltotal,lbldiscount,lbltotinword,lbltrno;
		
		private int interstate;
		private int hidinterstate;
		
		private int taxaccount,hideproducttype;
		
		private double taxpers ;
		
		private String txtproducttype;
		
	
		
		
		public String getLbltrno() {
			return lbltrno;
		}
		public void setLbltrno(String lbltrno) {
			this.lbltrno = lbltrno;
		}
		public String getLblcomptrn() {
			return lblcomptrn;
		}
		public void setLblcomptrn(String lblcomptrn) {
			this.lblcomptrn = lblcomptrn;
		}
		public String getLbltotinword() {
			return lbltotinword;
		}
		public void setLbltotinword(String lbltotinword) {
			this.lbltotinword = lbltotinword;
		}
		public String getLbltaxtot() {
			return lbltaxtot;
		}
		public void setLbltaxtot(String lbltaxtot) {
			this.lbltaxtot = lbltaxtot;
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
		public int getInterstate() {
			return interstate;
		}
		public void setInterstate(int interstate) {
			this.interstate = interstate;
		}
		public int getHidinterstate() {
			return hidinterstate;
		}
		public void setHidinterstate(int hidinterstate) {
			this.hidinterstate = hidinterstate;
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
		
		
		//-------------------------------------------------
		
		
		
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
		
		
	
		
		
		
		
		
		//-------------------------------------------------
		
		
		
		
		
		
		
		
		
		
		
		
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
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
		 
		}   //getInvno() getInvDate()  getHidinvDate()  
		int val=purchaseDAO.insert(sqlStartDate1,sqlpurdeldate,getNireftype(),getOrdermasterdoc_no(),getAcctype(),getAccdocno(),getPuraccname(), 
				getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),
				request,sqlinvdate,getInvno(),getInvDate(),getInterstate(),getHideproducttype(),getCmbbilltype(),getTxtproducttype());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			System.out.println("-----getHideproducttype()----------"+getHideproducttype());
			
			System.out.println("-----getHideproducttypeoooo----------");
			
			
			
			int tanss=(int) request.getAttribute("trans");
			setTarannumber(tanss);
			
			setHidinvDate(sqlinvdate.toString());
			setInvno(getInvno());
			setHidnipurchasedate(sqlStartDate1.toString());
			
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
		    setNettotal(getNettotal());
		    setHidinterstate(getInterstate());
		  // setCmbbilltype(getCmbbilltype());
		    setHidcmbbilltype(getCmbbilltype());
		    
			//setDocno(val);
			setDocno(vdocno);
			setMasterdoc_no(val);
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			
			System.out.println("-----elseeeeeeeee----------");

			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			setHidinvDate(sqlinvdate.toString());
			setInvno(getInvno());
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
		    setNettotal(getNettotal());
		    setHidcmbbilltype(getCmbbilltype());
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
					getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getTarannumber(),request,sqlinvdate,getInvno(),
					getInvDate(),getInterstate(),getHideproducttype(),getCmbbilltype());
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
			    setHidinterstate(getInterstate());
			   // setCmbbilltype(getCmbbilltype());
			    setHidcmbbilltype(getCmbbilltype());
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

			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
		//	setDocno(getDocno());
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

			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
		    setNettotal(getNettotal());
			//setDocno(getDocno());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setMsg("Not Deleted");
			return "fail";
		}
	
	}
	
/*	else if(mode.equalsIgnoreCase("view")){
		
		if(!(getInvno().equalsIgnoreCase("")) &&  !(getInvno().equalsIgnoreCase("NA")))
		{
		
		
		setHidinvDate(sqlinvdate.toString());
		}
		
		
		setHiddeliverydate(sqlpurdeldate.toString());
		setHidnipurchasedate(sqlStartDate1.toString());
}*/
	
else if(mode.equalsIgnoreCase("view")){
		
		
		System.out.println("====================="+getMasterdoc_no());
		
 
		viewobj=purchaseDAO.getViewDetails(getDocno(),session);
		
		
		setTarannumber(viewobj.getTarannumber());
		
		setHidinvDate(viewobj.getHidinvDate());
		setInvno(viewobj.getInvno());
		setHidnipurchasedate(viewobj.getHidnipurchasedate());
		
		  
		  setHideproducttype(viewobj.getHideproducttype());
		  setTxtproducttype(viewobj.getTxtproducttype());
		  setTaxpers(viewobj.getTaxpers());
		
		
		setHidcmbbilltype(viewobj.getCmbbilltype());
		//setCmbbilltype(viewobj.getCmbbilltype());
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
		
	     setHidinterstate(viewobj.getHidinterstate());
		
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
				
			  HttpServletRequest request=ServletActionContext.getRequest();
			  HttpSession session=request.getSession();
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String brhid=request.getParameter("brhid").toString();
			 String dtype=request.getParameter("dtype").toString();
			      
			setUrl(commDAO.getPrintPath(dtype));
			
			
		 pintbean=purchaseDAO.getPrint(doc,request,session,brhid);
			 
			 
			
			  //cl details
			 setLblcomptrn(pintbean.getLblcomptrn());
			          setLblprintname("Tax NI Purchase");
			         setLbldate(pintbean.getLbldate());
			    	   setLbltype(pintbean.getLbltype());
			    	   setDocvals(pintbean.getDocvals());
			    	   setLblacno(pintbean.getLblacno());
			    	    //upper
			    	   setLblacnoname(pintbean.getLblacnoname());
			    	   setLbldeldate(pintbean.getLbldeldate());
			    	    setLbldddtm(pintbean.getLbldddtm());
			    	    
			    	   setLbldsc(pintbean.getLbldsc());
			    	   setLblpatms(pintbean.getLblpatms());
			
			    	   setLblnettotal(pintbean.getLblnettotal());
			  
			
	 	  setLblbranch(pintbean.getLblbranch());
		   setLblcompname(pintbean.getLblcompname());
		  
		  setLblcompaddress(pintbean.getLblcompaddress());
		 
		   setLblcomptel(pintbean.getLblcomptel());
		  
		  setLblcompfax(pintbean.getLblcompfax());
		   setLbllocation(pintbean.getLbllocation());
		  

		   setLblinvno(pintbean.getLblinvno());
		   setLblinvdate(pintbean.getLblinvdate());
		   
		   setLbltotal(pintbean.getLbltotal());
		   setLbltaxtot(pintbean.getLbltaxtot());
		   setLbldiscount(pintbean.getLbldiscount());
		   setLbltotinword(pintbean.getLbltotinword());
		   setLbltrno(pintbean.getLbltrno());
		   
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