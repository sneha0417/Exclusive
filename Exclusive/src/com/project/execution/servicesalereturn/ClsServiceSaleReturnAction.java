package com.project.execution.servicesalereturn;

 
 

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
 

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 
 


	@SuppressWarnings("serial")
	public class ClsServiceSaleReturnAction  {

		ClsCommon commDAO=new ClsCommon();

		ClsServiceSaleReturnDAO purchaseDAO= new ClsServiceSaleReturnDAO(); 
		ClsServiceSaleReturnBean pintbean= new ClsServiceSaleReturnBean(); 
		
		private String nipurchasedate;    
		private String hidnipurchasedate;
		private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no,rrefno;
		private String refno,acctype,nipuraccid,puraccname,cmbcurr,hidcmbcurr,currate,deliverydate,
		hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
		private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate;
		
		private Double nettotal,taxperc;
		
		// for print 
		
		private String lblbranchtrno,lblcltrnno;
		public int getRrefno() {
			return rrefno;
		}

		public void setRrefno(int rrefno) {
			this.rrefno = rrefno;
		}


		private String lbltaxamount,lblnettaxamount,lblamountinwords;
		private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc;
		
		private String  lblvenaddress,lblvenphon,lblvenland,lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,
		lbllocation,lblprintname,lblinvno,lblinvdate,lblnettotal;	
		
		private int interstate;
		private int hidinterstate;
		
		public Double getTaxperc() {
			return taxperc;
		}

		public void setTaxperc(Double taxperc) {
			this.taxperc = taxperc;
		}

		public String getLblvenaddress() {
		return lblvenaddress;
	}

	public void setLblvenaddress(String lblvenaddress) {
		this.lblvenaddress = lblvenaddress;
	}

	public String getLblvenphon() {
		return lblvenphon;
	}

	public void setLblvenphon(String lblvenphon) {
		this.lblvenphon = lblvenphon;
	}

	public String getLblvenland() {
		return lblvenland;
	}

	public void setLblvenland(String lblvenland) {
		this.lblvenland = lblvenland;
	}

	public String getLblbranchtrno() {
		return lblbranchtrno;
	}

	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}

	public String getLblcltrnno() {
		return lblcltrnno;
	}

	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
	}

	public String getLbltaxamount() {
		return lbltaxamount;
	}

	public void setLbltaxamount(String lbltaxamount) {
		this.lbltaxamount = lbltaxamount;
	}

	public String getLblnettaxamount() {
		return lblnettaxamount;
	}

	public void setLblnettaxamount(String lblnettaxamount) {
		this.lblnettaxamount = lblnettaxamount;
	}

	public String getLblamountinwords() {
		return lblamountinwords;
	}

	public void setLblamountinwords(String lblamountinwords) {
		this.lblamountinwords = lblamountinwords;
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


		private Map<String, Object> param=null;
		
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
		public int getNidescdetailslenght() {
			return nidescdetailslenght;
		}
		public void setNidescdetailslenght(int nidescdetailslenght) {
			this.nidescdetailslenght = nidescdetailslenght;
		}
		public int getTarannumber() {
			return tarannumber;
		}
		public void setTarannumber(int tarannumber) {
			this.tarannumber = tarannumber;
		}
		public int getMasterdoc_no() {
			return masterdoc_no;
		}
		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}
		public int getOrdermasterdoc_no() {
			return ordermasterdoc_no;
		}
		public void setOrdermasterdoc_no(int ordermasterdoc_no) {
			this.ordermasterdoc_no = ordermasterdoc_no;
		}
		public String getRefno() {
			return refno;
		}
		public void setRefno(String refno) {
			this.refno = refno;
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
		public String getHidcmbcurr() {
			return hidcmbcurr;
		}
		public void setHidcmbcurr(String hidcmbcurr) {
			this.hidcmbcurr = hidcmbcurr;
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
		public String getAccdocno() {
			return accdocno;
		}
		public void setAccdocno(String accdocno) {
			this.accdocno = accdocno;
		}
		public String getFormdetailcode() {
			return formdetailcode;
		}
		public void setFormdetailcode(String formdetailcode) {
			this.formdetailcode = formdetailcode;
		}
		public String getNireftype() {
			return nireftype;
		}
		public void setNireftype(String nireftype) {
			this.nireftype = nireftype;
		}
		public String getDeleted() {
			return deleted;
		}
		public void setDeleted(String deleted) {
			this.deleted = deleted;
		}
		public String getReftypeval() {
			return reftypeval;
		}
		public void setReftypeval(String reftypeval) {
			this.reftypeval = reftypeval;
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
		public Double getNettotal() {
			return nettotal;
		}
		public void setNettotal(Double nettotal) {
			this.nettotal = nettotal;
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
		public String getLblnettotal() {
			return lblnettotal;
		}
		public void setLblnettotal(String lblnettotal) {
			this.lblnettotal = lblnettotal;
		}
		public Map<String, Object> getParam() {
			return param;
		}
		public void setParam(Map<String, Object> param) {
			this.param = param;
		}
		
		public String url;
		
		
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public String saveAction() throws ParseException, SQLException{
			
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchasedate());
			java.sql.Date sqlpurdeldate = commDAO.changeStringtoSqlDate(getDeliverydate());
		
			java.sql.Date sqlinvdate=null;
			if(!(getInvno().equalsIgnoreCase("")) &&  !(getInvno().equalsIgnoreCase("NA"))){
                sqlinvdate = commDAO.changeStringtoSqlDate(getInvDate());
			}
			String mode=getMode();
		
	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> descarray= new ArrayList<>();
		
		for(int i=0;i<getNidescdetailslenght();i++){
			String temp2=requestParams.get("desctest"+i)[0];
			descarray.add(temp2);
		}
		int val=purchaseDAO.insert(sqlStartDate1,sqlpurdeldate,getNireftype(),getRefno(),getAcctype(),getAccdocno(),getPuraccname(), 
				getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),
				request,sqlinvdate,getInvno(),getInvDate(),getInterstate(),getTaxperc(),getOrdermasterdoc_no());
		
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			
			int tanss=(int) request.getAttribute("trans");
			setTarannumber(tanss);
			
			setHidinvDate(sqlinvdate.toString());
			setInvno(getInvno());
			setHidnipurchasedate(sqlStartDate1.toString());
			
			setHidnipurchasedate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
			setRrefno(getRrefno());
			setRefno(getRefno());
			setReftypeval(getNireftype());
			setAcctypeval(getAcctype());
			setNipuraccid(getNipuraccid());
			setPuraccname(getPuraccname());
			setHidcmbcurr(getCmbcurr());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
		    setCurrate(getCurrate());
		    setDelterms(getDelterms());
		    setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
		    setHidinterstate(getInterstate());
		    setTaxperc(getTaxperc());
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
			setRefno(getRefno());
			setReftypeval(getNireftype());
			setAcctypeval(getAcctype());
			setNipuraccid(getNipuraccid());
			setPuraccname(getPuraccname());
			setHidcmbcurr(getCmbcurr());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
		    setCurrate(getCurrate());
		    setDelterms(getDelterms());
		    setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			setDocno(vdocno);
			setRrefno(getRrefno());
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
			boolean Status=purchaseDAO.edit(getMasterdoc_no(),sqlStartDate1,sqlpurdeldate,getNireftype(),getRefno(),
					getAcctype(),getAccdocno(),getPuraccname(), getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
					getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getTarannumber(),
					request,sqlinvdate,getInvno(),getInvDate(),getInterstate(),getTaxperc(),getOrdermasterdoc_no());
			if(Status){
				
				setTarannumber(getTarannumber());
				
				setHidinvDate(sqlinvdate.toString());
				setInvno(getInvno());
				
				setHidnipurchasedate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
				setRefno(getRefno());
				setRrefno(getRrefno());
				setReftypeval(getNireftype());
				setAcctypeval(getAcctype());
				setNipuraccid(getNipuraccid());
				setPuraccname(getPuraccname());
				setHidcmbcurr(getCmbcurr());
				setCmbcurrval(getCmbcurr());
				setAccdocno(getAccdocno());
		    	setCurrate(getCurrate());
			    setDelterms(getDelterms());
		     	setPayterms(getPayterms());
			    setPurdesc(getPurdesc());
			    setNettotal(getNettotal());
			    setHidinterstate(getInterstate());
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
				setRrefno(getRrefno());
				setHidnipurchasedate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
				setRefno(getRefno());
				setReftypeval(getNireftype());
				setAcctypeval(getAcctype());
				setNipuraccid(getNipuraccid());
				setPuraccname(getPuraccname());
				setHidcmbcurr(getCmbcurr());
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
			setHidcmbcurr(getCmbcurr());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
		//	setDocno(getDocno());
		    setRrefno(getRrefno());
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
			setHidcmbcurr(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
		    setRrefno(getRrefno());
			//setDocno(getDocno());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setMsg("Not Deleted");
			return "fail";
		}
	
	}
	
	else if(mode.equalsIgnoreCase("view")){
		
		if(!(getInvno().equalsIgnoreCase("")) &&  !(getInvno().equalsIgnoreCase("NA")))
		{
		
		
		setHidinvDate(sqlinvdate.toString());
		}
		
		setHidcmbcurr(pintbean.getHidcmbcurr());
		setHiddeliverydate(sqlpurdeldate.toString());
		setHidnipurchasedate(sqlStartDate1.toString());
}
	
return "fail";	
	
}
		
		
		
		
		
		 public String printAction() throws ParseException, SQLException{
				
			  HttpServletRequest request=ServletActionContext.getRequest();
			  HttpSession session=request.getSession();
			 int doc=Integer.parseInt(request.getParameter("docno"));
			  String dtype=request.getParameter("dtype");
			
		 pintbean=purchaseDAO.getPrint(doc,request,session);
		 System.out.println("dtype"+dtype);
		 setUrl(commDAO.getPrintPath(dtype)); 
			 
			 
			
			  //cl details
					setLblvenaddress(pintbean.getLblvenaddress());
		 			setLblvenphon(pintbean.getLblvenphon());
		 			setLblvenland(pintbean.getLblvenland());
		 			setLblbranchtrno(pintbean.getLblbranchtrno());
		 			setLblcltrnno(pintbean.getLblcltrnno());
					 
			        setLblprintname("Service Sale Return ");
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
					setLbltaxamount(pintbean.getLbltaxamount());
			    	setLblnettaxamount(pintbean.getLblnettaxamount());
			    	setLblamountinwords(pintbean.getLblamountinwords());
			
	 	  setLblbranch(pintbean.getLblbranch());
		   setLblcompname(pintbean.getLblcompname());
		  
		  setLblcompaddress(pintbean.getLblcompaddress());
		 
		   setLblcomptel(pintbean.getLblcomptel());
		  
		  setLblcompfax(pintbean.getLblcompfax());
		   setLbllocation(pintbean.getLbllocation());
		  

		   setLblinvno(pintbean.getLblinvno());
		   setLblinvdate(pintbean.getLblinvdate());
		   
		   setLbltype(pintbean.getLbltype());
		 	 System.out.println("dddddddddddddddddddddd"+pintbean.getLbltype());
			  
	 
/*
			if(commDAO.getPrintPath(dtype).contains("jrxml")){
		   	 System.out.println("jasperrrrrrrr");
			    HttpServletResponse response = ServletActionContext.getResponse();
			    
			    String brhid=request.getParameter("brhid").toString();
			    
			   
			    ClsServiceSaleBean bean= new ClsServiceSaleBean(); 
			    bean=purchaseDAO.getPrint(doc,request,session);
				 
				
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "SrvSaleInvoice";
				 							
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
			     
				 try {
			            
		                    
		             
		            
		            
		             
			   
			          
			          String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
			          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
			          		+ "where  tr.dtype='SRS' and tr.brhid='"+brhid+"' and tr.rdocno="+doc+" and tr.status=3 ) tr "
			          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
			          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
			          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
			          		+ "   tr.dtype='SRS' and tr.rdocno="+doc+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
			        		  "select  @i:=@i+1 as srno,concat(coalesce(m.termsheader,''),' - ',coalesce(t.conditions,'')) terms "
			          		+ " from my_trterms t left join MY_termsm m on m.voc_no=t.termsid"
			          		+ " and t.dtype='PO',(select @i:=0) i     where t.dtype='PO' and t.rdocno="+doc+";";
			          
			      System.out.println("termsqueryyyyyyyyyyy"+termsquery);
			           param.put("termsquery",termsquery);
			           
			           
			          String descQry=" select @i:=@i+1 as srno,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
			          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice "
			        		+ "   from my_srvsaled d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";
			           
			           
			           
			           
			           
			        
			         param.put("descQry",descQry);
			         
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          String headereasylease=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			          headereasylease=headereasylease.replace("\\", "\\\\");
			          param.put("imghedderpathepic", headereasylease);
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			          
			      
			          param.put("vendor", bean.getLblacnoname());
			          param.put("attn", bean.getAttn());
			          //param.put("tel", bean.getTel());
			          param.put("fax", bean.getFax());
			          param.put("email", bean.getEmail());
			          param.put("docno",doc);
			          param.put("date", bean.getLbldate());
			          param.put("refno", bean.getRefno());
			          param.put("desc", bean.getLbldsc());
			          param.put("payterm", bean.getLblpatms());
			          param.put("delterm", bean.getLbldddtm());
			         // param.put("netamount", bean.getLblnettotal());
			         // param.put("amountwords", bean.getWordnetamount());


			          param.put("tel", bean.getTelno());
			          param.put("clienttrno",bean.getLblcltrnno());
			          param.put("compnytrno", bean.getCompanytrno());
			         
			          param.put("netamount", bean.getLblnettaxamount());
			          param.put("amountwords",bean.getLblamountinwords());
			          
			          param.put("total",bean.getLblnettotal());
			          param.put("vatamnt",bean.getLbltaxamount());
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			          
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/project/execution/ServiceSale/" +commDAO.getPrintPath(dtype)));
	         	 
	              JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	       

	   } catch (Exception e) {

	       e.printStackTrace();

	   }
				 
				 finally{
					 conn.close();
				 }
		   		
		   	}*/
	   	   
			 return "print";
			 }	
		
		
		
		/*	 public void jasperprintAction() throws ParseException, SQLException{
			 System.out.println("jasperrrrrrrr");
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
			    HttpServletResponse response = ServletActionContext.getResponse();
			    
			    int doc=Integer.parseInt(request.getParameter("docno"));
			    String brhid=request.getParameter("brhid").toString();
			    
			   
			    ClsServiceSaleBean bean= new ClsServiceSaleBean(); 
			    bean=purchaseDAO.getPrint(doc,request,session);
				 
				
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "SrvSaleInvoice";
				 							
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
			     
				 try {
			            
		                    
		             
		            
		            
		             
			   
			          
			          String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
			          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
			          		+ "where  tr.dtype='SRS' and tr.brhid='"+brhid+"' and tr.rdocno="+doc+" and tr.status=3 ) tr "
			          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
			          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
			          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
			          		+ "   tr.dtype='SRS' and tr.rdocno="+doc+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
			        		  /*"select  @i:=@i+1 as srno,concat(coalesce(m.termsheader,''),' - ',coalesce(t.conditions,'')) terms "
			          		+ " from my_trterms t left join MY_termsm m on m.voc_no=t.termsid"
			          		+ " and t.dtype='PO',(select @i:=0) i     where t.dtype='PO' and t.rdocno="+doc+";";
			          
			      System.out.println("termsqueryyyyyyyyyyy"+termsquery);
			           param.put("termsquery",termsquery);
			           
			           
			          String descQry=" select @i:=@i+1 as srno,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
			          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice "
			        		+ "   from my_srvsaled d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";
			           
			           
			           
			           
			           
			        
			         param.put("descQry",descQry);
			         
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			          
			      
			          param.put("vendor", bean.getLblacnoname());
			          param.put("attn", bean.getAttn());
			          param.put("tel", bean.getTel());
			          param.put("fax", bean.getFax());
			          param.put("email", bean.getEmail());
			          param.put("docno",doc);
			          param.put("date", bean.getLbldate());
			          param.put("refno", bean.getRefno());
			          param.put("desc", bean.getLbldsc());
			          param.put("payterm", bean.getLblpatms());
			          param.put("delterm", bean.getLbldddtm());
			          param.put("netamount", bean.getLblnettotal());
			          param.put("amountwords", bean.getWordnetamount());
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			          
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/project/execution/ServiceSale/" + reportFileName + ".jrxml"));
	         	 
	              JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	       

	   } catch (Exception e) {

	       e.printStackTrace();

	   }
				 
				 finally{
					 conn.close();
				 }
				
			}*/
		
		
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