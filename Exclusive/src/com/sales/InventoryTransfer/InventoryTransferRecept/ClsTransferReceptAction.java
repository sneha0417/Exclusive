package com.sales.InventoryTransfer.InventoryTransferRecept;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.tomcat.util.digester.SetTopRule;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;
import com.google.common.collect.Sets.SetView;


public class ClsTransferReceptAction {

	ClsTransferReceptDAO DAO= new ClsTransferReceptDAO();
	ClsTransferReceptBean bean= new ClsTransferReceptBean();
	ClsCommon ClsCommon=new ClsCommon();
 
	private String date;
	private String hiddate;
	private String txtrefno;
	private String docno;
	private String txtclient;
	private int clientid;
	private String txtclientdet;
	private String txtsalesperson;
	private int salespersonid;
	private String cmbcurr;
	private String hidcmbcurrency;
	private String currate;
	private String cmbreftype;
	private String hidcmbreftype;
	private String rrefno;
	private String txtpaymentterms;
	private String txtdescription;
	private String txtproductamt;
	private String txtdiscount;
	private String txtnettotal;
	private String formdetailcode;
	private String mode;
	private String msg;
	private String deleted;
	private int gridlength;
	private int termsgridlength;
	private int servgridlen;
	private int masterdoc_no;
	private String refmasterdocno;
	private String prodsearchtype;
	private String descPercentage;
	private String orderValue;
	private String roundOf;
	private String nettotal;
	private String cmbprice;
	private String hidcmbprice;
	private String txtlocation;
	private String locationid;
	private String txtfrmbranch;
	private int branchfrmid;
	private String txtfrmlocation;
	private int locationfrmid;
	private String txttobranch;
	private int branchtoid;
	private String txttolocation;
	private int locationtoid;
	private String txtremark;


	
	public String getTxtfrmbranch() {
		return txtfrmbranch;
	}
	public void setTxtfrmbranch(String txtfrmbranch) {
		this.txtfrmbranch = txtfrmbranch;
	}
	public int getBranchfrmid() {
		return branchfrmid;
	}
	public void setBranchfrmid(int branchfrmid) {
		this.branchfrmid = branchfrmid;
	}
	public String getTxtfrmlocation() {
		return txtfrmlocation;
	}
	public void setTxtfrmlocation(String txtfrmlocation) {
		this.txtfrmlocation = txtfrmlocation;
	}
	public int getLocationfrmid() {
		return locationfrmid;
	}
	public void setLocationfrmid(int locationfrmid) {
		this.locationfrmid = locationfrmid;
	}
	public String getTxttobranch() {
		return txttobranch;
	}
	public void setTxttobranch(String txttobranch) {
		this.txttobranch = txttobranch;
	}
	public int getBranchtoid() {
		return branchtoid;
	}
	public void setBranchtoid(int branchtoid) {
		this.branchtoid = branchtoid;
	}
	public String getTxttolocation() {
		return txttolocation;
	}
	public void setTxttolocation(String txttolocation) {
		this.txttolocation = txttolocation;
	}
	public int getLocationtoid() {
		return locationtoid;
	}
	public void setLocationtoid(int locationtoid) {
		this.locationtoid = locationtoid;
	}
	public String getTxtremark() {
		return txtremark;
	}
	public void setTxtremark(String txtremark) {
		this.txtremark = txtremark;
	}
	public String getTxtlocation() {
		return txtlocation;
	}
	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}
	public String getLocationid() {
		return locationid;
	}
	public void setLocationid(String locationid) {
		this.locationid = locationid;
	}
	public String getCmbprice() {
		return cmbprice;
	}
	public void setCmbprice(String cmbprice) {
		this.cmbprice = cmbprice;
	}
	public String getHidcmbprice() {
		return hidcmbprice;
	}
	public void setHidcmbprice(String hidcmbprice) {
		this.hidcmbprice = hidcmbprice;
	}
	public int getServgridlen() {
		return servgridlen;
	}
	public void setServgridlen(int servgridlen) {
		this.servgridlen = servgridlen;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getRoundOf() {
		return roundOf;
	}
	public void setRoundOf(String roundOf) {
		this.roundOf = roundOf;
	}
	public String getOrderValue() {
		return orderValue;
	}
	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}
	public String getDescPercentage() {
		return descPercentage;
	}
	public void setDescPercentage(String descPercentage) {
		this.descPercentage = descPercentage;
	}
	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}
	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}
	public String getProdsearchtype() {
		return prodsearchtype;
	}
	public void setProdsearchtype(String prodsearchtype) {
		this.prodsearchtype = prodsearchtype;
	}

	public String getRefmasterdocno() {
		return refmasterdocno;
	}
	public void setRefmasterdocno(String refmasterdocno) {
		this.refmasterdocno = refmasterdocno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
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

	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
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
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtsalesperson() {
		return txtsalesperson;
	}
	public void setTxtsalesperson(String txtsalesperson) {
		this.txtsalesperson = txtsalesperson;
	}
	public int getSalespersonid() {
		return salespersonid;
	}
	public void setSalespersonid(int salespersonid) {
		this.salespersonid = salespersonid;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public String getTxtpaymentterms() {
		return txtpaymentterms;
	}
	public void setTxtpaymentterms(String txtpaymentterms) {
		this.txtpaymentterms = txtpaymentterms;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getTxtproductamt() {
		return txtproductamt;
	}
	public void setTxtproductamt(String txtproductamt) {
		this.txtproductamt = txtproductamt;
	}
	public String getTxtdiscount() {
		return txtdiscount;
	}
	public void setTxtdiscount(String txtdiscount) {
		this.txtdiscount = txtdiscount;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTermsgridlength() {
		return termsgridlength;
	}
	public void setTermsgridlength(int termsgridlength) {
		this.termsgridlength = termsgridlength;
	}
	
	private String lbldate,lblrefno,lbldocno,lblreftype,lblbranchfrom,lbllocationfrom,lblbranchto,lbllocationto,lblremarks,lblissueno;
	 private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	 
	 
	 
	 
	 
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblreftype() {
		return lblreftype;
	}
	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}
	public String getLblbranchfrom() {
		return lblbranchfrom;
	}
	public void setLblbranchfrom(String lblbranchfrom) {
		this.lblbranchfrom = lblbranchfrom;
	}
	public String getLbllocationfrom() {
		return lbllocationfrom;
	}
	public void setLbllocationfrom(String lbllocationfrom) {
		this.lbllocationfrom = lbllocationfrom;
	}
	public String getLblbranchto() {
		return lblbranchto;
	}
	public void setLblbranchto(String lblbranchto) {
		this.lblbranchto = lblbranchto;
	}
	public String getLbllocationto() {
		return lbllocationto;
	}
	public void setLbllocationto(String lbllocationto) {
		this.lbllocationto = lbllocationto;
	}
	public String getLblremarks() {
		return lblremarks;
	}
	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}
	public String getLblissueno() {
		return lblissueno;
	}
	public void setLblissueno(String lblissueno) {
		this.lblissueno = lblissueno;
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
	public String savetransferReceptAction(){

		
		//System.out.println("==savetransferReceptAction====");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;
		try{
		//	System.out.println("==getDate()===="+getDate());

			ArrayList<String> prodarray= new ArrayList<>();
			ArrayList<String> termsarray= new ArrayList<>();
			ArrayList<String> servarray= new ArrayList<>();

			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("prodg"+i)[0];		
				prodarray.add(temp);
			}

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				
				
				val=DAO.insert(getTxtrefno(),date,getCmbreftype(),getBranchfrmid(),getLocationfrmid(),getBranchtoid(),getLocationtoid(),getTxtremark(),
						getTxtproductamt(),getTxtnettotal(),getNettotal(),getRefmasterdocno(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,session,request);
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setTxtfrmbranch(getTxtfrmbranch());
					setTxtfrmlocation(getTxtfrmlocation());
					setTxttobranch(getTxttobranch());
					
					setRrefno(getRrefno());
					
					setRefmasterdocno(getRefmasterdocno());
					setHidcmbreftype(getCmbreftype());
					setHiddate(date.toString());
					setBranchfrmid(getBranchfrmid());
					setLocationfrmid(getLocationfrmid());
					setBranchtoid(getBranchtoid());
					setLocationtoid(getLocationtoid());
					setTxttolocation(getTxttolocation());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setTxtfrmbranch(getTxtfrmbranch());
					setTxtfrmlocation(getTxtfrmlocation());
					setTxttobranch(getTxttobranch());
					setRrefno(getRrefno());
					setHiddate(date.toString());
					setBranchfrmid(getBranchfrmid());
					setLocationfrmid(getLocationfrmid());
					setRefmasterdocno(getRefmasterdocno());
					setBranchtoid(getBranchtoid());
					setLocationtoid(getLocationtoid());
					setTxttolocation(getTxttolocation());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setHidcmbreftype(getCmbreftype());
					setFormdetailcode(getFormdetailcode());
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
				bean=DAO.getViewDetails(getRefmasterdocno(),getBranchfrmid());
				 
				 
				setRrefno(bean.getRrefno());
				setTxtrefno(getTxtrefno());
				setTxtfrmbranch(getTxtfrmbranch());
				setTxtfrmlocation(getTxtfrmlocation());
				setTxttobranch(getTxttobranch());
				setHiddate(date.toString());
				setBranchfrmid(getBranchfrmid());
				setLocationfrmid(getLocationfrmid());
				setBranchtoid(getBranchtoid());
				setLocationtoid(getLocationtoid());
				setTxttolocation(getTxttolocation());
				setTxtproductamt(getTxtproductamt());
				setRoundOf(getRoundOf());
				setOrderValue(getOrderValue());
				setTxtdiscount(getTxtdiscount());
				setTxtnettotal(getTxtnettotal());
				setHidcmbreftype(getCmbreftype());
				setMode(getMode());
				setFormdetailcode(getFormdetailcode());
				returns="success";
			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.update(getDocno(),getMasterdoc_no(),getTxtrefno(),date,getCmbreftype(),getBranchfrmid(),getLocationfrmid(),getBranchtoid(),getLocationtoid(),getTxtremark(),
						getTxtproductamt(),getTxtnettotal(),getNettotal(),getRefmasterdocno(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,session,request);
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setTxtfrmbranch(getTxtfrmbranch());
					setTxtfrmlocation(getTxtfrmlocation());
					setTxttobranch(getTxttobranch());
					setBranchfrmid(getBranchfrmid());
					setLocationfrmid(getLocationfrmid());
					setBranchtoid(getBranchtoid());
					setRefmasterdocno(getRefmasterdocno());
					setLocationtoid(getLocationtoid());
					setTxttolocation(getTxttolocation());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setHiddate(date.toString());
					setFormdetailcode(getFormdetailcode());
					setHidcmbreftype(getCmbreftype());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setHiddate(date.toString());
					setTxtfrmbranch(getTxtfrmbranch());
					setTxtfrmlocation(getTxtfrmlocation());
					setTxttobranch(getTxttobranch());
					setBranchfrmid(getBranchfrmid());
					setLocationfrmid(getLocationfrmid());
					setRefmasterdocno(getRefmasterdocno());
					setBranchtoid(getBranchtoid());
					setLocationtoid(getLocationtoid());
					setTxttolocation(getTxttolocation());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setHidcmbreftype(getCmbreftype());
					setMsg("Not Updated");
					returns="fail";
				}
			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getCmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getLocationid(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage());
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getCmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setHidcmbreftype(getCmbreftype());
					setMsg("Deleted Successfully");
					returns="success";
				}
				else{
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getCmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setHidcmbreftype(getCmbreftype());
					setMsg("Not Deleted");
					returns="fail";
				}
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}


		return returns;
	}
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 
		 String  issueno=request.getParameter("issueno");
		 
		 
		 bean=DAO.getPrint(doc,request);
	  
		 setLbldocno(bean.getLbldocno());
	    setLbldate(bean.getLbldate());
	   setLblrefno(bean.getLblrefno());
	   setLblreftype(bean.getLblreftype());
	   setLblbranchfrom(bean.getLblbranchfrom());
	    
	    
	   setLbllocationfrom(bean.getLbllocationfrom());
	   setLblissueno(issueno);
	   setLbllocationto(bean.getLbllocationto());
	   setLblremarks(bean.getLblremarks());
		
		  //cl details
		 
		 setLblprintname("Inventory Transfer Receipt");

		    
		    
		 
		
		
		
	  setLblbranch(bean.getLblbranch());
	   setLblcompname(bean.getLblcompname());
	  
	  setLblcompaddress(bean.getLblcompaddress());
	 
	   setLblcomptel(bean.getLblcomptel());
	  
	  setLblcompfax(bean.getLblcompfax());
	   setLbllocation(bean.getLbllocation());
	  

		   
		 return "print";
		 }	
		
	
}
