package com.sales.marketing.salesenquiry;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.controlcentre.masters.product.ClsProductDAO;
import com.google.common.collect.Sets.SetView;
import com.procurement.purchase.purchaserequest.ClsPurchaserequestBean;
import com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO;


public class ClsSalesEnquiryAction {

	ClsSalesEnquiryDAO DAO= new ClsSalesEnquiryDAO();

	private String date;
	private String hiddate;
	private String refno;
	private String docno;
	private String txtclient;
	private int clientid;
	private String txtclientdet;
	private String cmbcurr;
	private String currate;
	private String delterms;
	private String payterms;
	private String txtdesc;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetailcode;
	private String txtmob;
	private String txtemail;
	private int proGridlen,salespersonid;
	private String masterdoc_no,editdata,txtsalesperson;
	
	
	private int	shipdatagridlenght,shipdocno;
	
 
	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax;

	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	
	
	public int getSalespersonid() {
		return salespersonid;
	}
	public void setSalespersonid(int salespersonid) {
		this.salespersonid = salespersonid;
	}
	public String getTxtsalesperson() {
		return txtsalesperson;
	}
	public void setTxtsalesperson(String txtsalesperson) { 
		this.txtsalesperson = txtsalesperson;
	}
	public String getEditdata() {
		return editdata;
	}
	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}
	public String getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(String masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}

	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
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
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
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
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getProGridlen() {
		return proGridlen;
	}
	public void setProGridlen(int proGridlen) {
		this.proGridlen = proGridlen;
	}

	
	//print 
	
	 private String lblclient, lblclientaddress, lblmob, lblemail, docvals, lbldate, lbltypep;
	 
	 private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	 
	 
	 private String  lbldelterms ,lblpaytrems ,lbldesc1;
	 

	public String getLbldelterms() {
		return lbldelterms;
	}
	public void setLbldelterms(String lbldelterms) {
		this.lbldelterms = lbldelterms;
	}
	public String getLblpaytrems() {
		return lblpaytrems;
	}
	public void setLblpaytrems(String lblpaytrems) {
		this.lblpaytrems = lblpaytrems;
	}
	public String getLbldesc1() {
		return lbldesc1;
	}
	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getDocvals() {
		return docvals;
	}
	public void setDocvals(String docvals) {
		this.docvals = docvals;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltypep() {
		return lbltypep;
	}
	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
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
	public ClsSalesEnquiryBean getPintbean() {
		return pintbean;
	}
	public void setPintbean(ClsSalesEnquiryBean pintbean) {
		this.pintbean = pintbean;
	}
	
	
	
	
	
	
	
	
	
	public int getShipdatagridlenght() {
		return shipdatagridlenght;
	}
	public void setShipdatagridlenght(int shipdatagridlenght) {
		this.shipdatagridlenght = shipdatagridlenght;
	}
	public int getShipdocno() {
		return shipdocno;
	}
	public void setShipdocno(int shipdocno) {
		this.shipdocno = shipdocno;
	}
	public String getShipto() {
		return shipto;
	}
	public void setShipto(String shipto) {
		this.shipto = shipto;
	}
	public String getShipaddress() {
		return shipaddress;
	}
	public void setShipaddress(String shipaddress) {
		this.shipaddress = shipaddress;
	}
	public String getContactperson() {
		return contactperson;
	}
	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}
	public String getShiptelephone() {
		return shiptelephone;
	}
	public void setShiptelephone(String shiptelephone) {
		this.shiptelephone = shiptelephone;
	}
	public String getShipmob() {
		return shipmob;
	}
	public void setShipmob(String shipmob) {
		this.shipmob = shipmob;
	}
	public String getShipemail() {
		return shipemail;
	}
	public void setShipemail(String shipemail) {
		this.shipemail = shipemail;
	}
	public String getShipfax() {
		return shipfax;
	}
	public void setShipfax(String shipfax) {
		this.shipfax = shipfax;
	}
	public String saveEnquiryAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";

		try{

			java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
//			System.out.println("====getProGridlen===="+getProGridlen());
			

			int val=0;
			

			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> prodarray= new ArrayList<>();
				for(int i=0;i<getProGridlen();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}
				
				ArrayList<String> shiparray= new ArrayList<>();
				
				 
				
				for(int i=0;i<getShipdatagridlenght();i++){
					
				 
					String temp2=requestParams.get("shiptest"+i)[0];
				 
				
					shiparray.add(temp2);
					 
				}
				
				
				val=DAO.insert(getTxtmob(),getTxtemail(),date,getClientid(),getTxtclientdet(),getRefno(), getCmbcurr(),
						getCurrate(), getDelterms(), getPayterms(), getTxtdesc(), getMode(), getFormdetailcode(), prodarray,session,request,shiparray,getShipdocno(),getSalespersonid());
				int vdocno=(int) request.getAttribute("vdocNo");
				if(val>0){
					
				 
					
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					
					
					setDate(date.toString());
					setMasterdoc_no(val+"");
					setDocno(vdocno+"");
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());

					
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					
					 
					
						setTxtsalesperson(getTxtsalesperson());
						setSalespersonid(getSalespersonid());
					setDate(date.toString());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());
					setMode(getMode());
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					
					setMsg("Not Saved");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("E")){
				ArrayList<String> prodarray= new ArrayList<>();
				for(int i=0;i<getProGridlen();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}
				
				ArrayList<String> shiparray= new ArrayList<>();
					
				for(int i=0;i<getShipdatagridlenght();i++){
					
				 
					String temp2=requestParams.get("shiptest"+i)[0];
				 
				
					shiparray.add(temp2);
					 
				}
				
				
				val=DAO.update(Integer.parseInt(getMasterdoc_no()),Integer.parseInt(getDocno()),getTxtmob(),getTxtemail(),date,getClientid(),
						getTxtclientdet(),getRefno(), getCmbcurr(), getCurrate(), getDelterms(), getPayterms(), getTxtdesc(), getMode(), 
						getFormdetailcode(), prodarray,session,request,getEditdata(),shiparray,getShipdocno(),getSalespersonid());

				int vdocno=(int) request.getAttribute("vdocNo");
				if(val>0){
					
					 
					
						setTxtsalesperson(getTxtsalesperson());
						setSalespersonid(getSalespersonid());
					setDate(date.toString());
					setMasterdoc_no(val+"");
					setDocno(vdocno+"");
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					 
					
						setTxtsalesperson(getTxtsalesperson());
						setSalespersonid(getSalespersonid());
					setDate(date.toString());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());
					setMode(getMode());
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					setMsg("Not Updated");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("D")){

				val=DAO.delete(Integer.parseInt(getMasterdoc_no()),Integer.parseInt(getDocno()),getTxtmob(),getTxtemail(),date,getClientid(),getTxtclientdet(),getRefno(), getCmbcurr(), getCurrate(), getDelterms(), getPayterms(), getTxtdesc(), getMode(), getFormdetailcode(),session,request);

				if(val>0){
					setDocno(val+"");
					setDate(date.toString());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{
					setDate(date.toString());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRefno(getRefno());
					setCmbcurr(getCmbcurr());
					setCurrate(getCurrate());
					setDelterms(getDelterms());
					setPayterms(getPayterms());
					setTxtdesc(getTxtdesc());
					setMode(getMode());
					
					
		             setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
					
					setMsg("Not Deleted");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("view")){
				setDate(date.toString());
				returns="success";
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}

		return returns;
	}
	ClsSalesEnquiryBean  pintbean=new  ClsSalesEnquiryBean();
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 pintbean=DAO.getPrint(doc,request);
	  
 	    setDocvals(pintbean.getDocvals());
	    setLbldate(pintbean.getLbldate());
	    setLblclient(pintbean.getLblclient());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    
	    
	    setLbldelterms(pintbean.getLbldelterms());
	    setLblpaytrems(pintbean.getLblpaytrems());
	     setLbldesc1(pintbean.getLbldesc1());
	     setLbltypep(pintbean.getLbltypep());
		
		  //cl details
		 
		 setLblprintname("Sales Enquiry");
 
		    
		    
	 
		
		
		
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  

	   
		   
		 return "print";
		 }	
		
		

}
