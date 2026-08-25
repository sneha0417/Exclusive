package com.sales.Sales.branchInvoicereturn;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;
import com.google.common.collect.Sets.SetView;


public class ClsbranchInvoicereturnAction {

	ClsbranchInvoicereturnDAO DAO= new ClsbranchInvoicereturnDAO();
	ClsbranchInvoicereturnBean bean= new ClsbranchInvoicereturnBean();
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
	private String cmbmodeofpay;
	private String payDueDate;
	private String hidpayDueDate;
	private String txtlocation,lblduedate,txtdelterms;
	private int    locationid; 



	public String getTxtdelterms() {
		return txtdelterms;
	}
	public void setTxtdelterms(String txtdelterms) {
		this.txtdelterms = txtdelterms;
	}
	public String getLblduedate() {
		return lblduedate;
	}
	public void setLblduedate(String lblduedate) {
		this.lblduedate = lblduedate;
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
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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
	public String getLblsalesPerson() {
		return lblsalesPerson;
	}
	public void setLblsalesPerson(String lblsalesPerson) {
		this.lblsalesPerson = lblsalesPerson;
	}
	public String getLbllocation1() {
		return lbllocation1;
	}
	public void setLbllocation1(String lbllocation1) {
		this.lbllocation1 = lbllocation1;
	}
	public String getTxtlocation() {
		return txtlocation;
	}
	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}
	public int getLocationid() {
		return locationid;
	}
	public void setLocationid(int locationid) {
		this.locationid = locationid;
	}
	public String getCmbmodeofpay() {
		return cmbmodeofpay;
	}
	public void setCmbmodeofpay(String cmbmodeofpay) {
		this.cmbmodeofpay = cmbmodeofpay;
	}
	public String getPayDueDate() {
		return payDueDate;
	}
	public void setPayDueDate(String payDueDate) {
		this.payDueDate = payDueDate;
	}
	public String getHidpayDueDate() {
		return hidpayDueDate;
	}
	public void setHidpayDueDate(String hidpayDueDate) {
		this.hidpayDueDate = hidpayDueDate;
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

	
	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords;
	private int lbldoc,firstarray,secarray;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1;	
	
	
	
	public String saveInvoiceReturnAction(){

		
		System.out.println("inside saveInvoiceReturnAction");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;
		try{


			ArrayList<String> prodarray= new ArrayList<>();
			/*ArrayList<String> termsarray= new ArrayList<>();
			ArrayList<String> servarray= new ArrayList<>();
*/
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("prodg"+i)[0];		
				prodarray.add(temp);
			}

			/*for(int i=0;i<getTermsgridlength();i++){
				String temp=requestParams.get("termg"+i)[0];		
				termsarray.add(temp);
			}

			for(int i=0;i<getServgridlen();i++){
				String temp=requestParams.get("serv"+i)[0];		
				servarray.add(temp);
			}*/

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
				
				java.sql.Date payduedate=ClsCommon.changeStringtoSqlDate(getPayDueDate());

				val=DAO.insert(date,getTxtrefno(),getCmbprice(),getCmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,session,request,
						getRefmasterdocno(),getDescPercentage(),payduedate,getLocationid(),getCmbmodeofpay(),getTxtdelterms());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					 setTxtlocation(getTxtlocation());
                        setLocationid(getLocationid());
					setFormdetailcode(getFormdetailcode());
					
					setTxtdelterms(getTxtdelterms());
					
					setMsg("Successfully Saved");
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					 setTxtlocation(getTxtlocation());
                     setLocationid(getLocationid());
					setFormdetailcode(getFormdetailcode());
					
					setTxtdelterms(getTxtdelterms());
					
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(getMasterdoc_no(),session.getAttribute("BRANCHID").toString());

				setMasterdoc_no(bean.getMasterdoc_no());
				setDocno(bean.getDocno());
				setTxtrefno(bean.getTxtrefno());
				setCmbcurr(bean.getCmbcurr());
				setHidcmbcurrency(bean.getCmbcurr());
				setCurrate(bean.getCurrate());
				setSalespersonid(bean.getSalespersonid());
				setClientid(bean.getClientid());
				setClientid(getClientid());
				setRrefno(bean.getRrefno());
				setCmbreftype(bean.getCmbreftype());
				setHidcmbreftype(bean.getCmbreftype());
				setTxtpaymentterms(bean.getTxtpaymentterms());
				setTxtdescription(bean.getTxtdescription());
				setDescPercentage(bean.getDescPercentage());
				setTxtproductamt(bean.getTxtproductamt());
				setTxtdiscount(bean.getTxtdiscount());
				setTxtnettotal(bean.getTxtnettotal());
				setRoundOf(bean.getRoundOf());
				setProdsearchtype(bean.getProdsearchtype());
				setTxtsalesperson(bean.getTxtsalesperson());
				setRefmasterdocno(bean.getRefmasterdocno());
				setOrderValue(bean.getOrderValue());
				setNettotal(bean.getNettotal());
				
				setTxtdelterms(bean.getTxtdelterms());
                 setTxtlocation(bean.getTxtlocation());
                 setLocationid(bean.getLocationid());

				returns="success";
			}


			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
				java.sql.Date payduedate=ClsCommon.changeStringtoSqlDate(getPayDueDate());

				val=DAO.update(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getCmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,session,request,
						getRefmasterdocno(),getDescPercentage(),payduedate,getLocationid(),getCmbmodeofpay(),getTxtdelterms());
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
					setTxtdelterms(getTxtdelterms());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					 setTxtlocation(getTxtlocation());
	                 setLocationid(getLocationid());
					setFormdetailcode(getFormdetailcode());
					setMsg("Updated Successfully");
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
					setTxtdelterms(getTxtdelterms());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					 setTxtlocation(getTxtlocation());
	                 setLocationid(getLocationid());
					setMsg("Not Updated");
					returns="fail";
				}
			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
				java.sql.Date payduedate=ClsCommon.changeStringtoSqlDate(getPayDueDate());

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getCmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,session,request,
						getRefmasterdocno(),getDescPercentage(),payduedate,getLocationid());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setMsg("Updated Successfully");
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setMsg("Not Updated");
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
		 
		 String  formcode= request.getParameter("formdetailcode");
		 
		
		 bean=DAO.getPrint(doc,request,formcode);
	  
		 
		
		  // cl details
		 
		 if(formcode.equalsIgnoreCase("CASH"))
		 {
			 setLblprintname("Invoice Return");
			 
		 }
		 else  
		 {
			 setLblprintname("Invoice Return"); 
		 }
		    
		    
		    
		    
		    setLbldoc(bean.getLbldoc());
		    setLbldate(bean.getLbldate());
		     setLblrefno(bean.getLblrefno());
		     setLbldesc1(bean.getLbldesc1());
		    
	 	      
	     setLblpaytems(bean.getLblpaytems());
	     setLbldelterms(bean.getLbldelterms());
	     setLbltype(bean.getLbltype());
	     setLblvendoeacc(bean.getLblvendoeacc());  
	     setLblvendoeaccName(bean.getLblvendoeaccName());
		     setExpdeldate(bean.getExpdeldate());
	 
					
	               setLbltotal(bean.getLbltotal());
	    	       setLblsubtotal(bean.getLblsubtotal());
				   setLblbranch(bean.getLblbranch());
				   setLblcompname(bean.getLblcompname());
				  
				   setLblcompaddress(bean.getLblcompaddress());
				   setLblcomptel(bean.getLblcomptel());
				   setLblcompfax(bean.getLblcompfax());
				   setLbllocation(bean.getLbllocation());
				  
				   setLblsalesPerson(bean.getLblsalesPerson());
				   
				   setLbllocation1(bean.getLbllocation1());
				   
				   setFirstarray(bean.getFirstarray());
				   
				   setSecarray(bean.getSecarray());
				     
		    	   setLblordervalue(bean.getLblordervalue());
		    	   setLblordervaluewords(bean.getLblordervaluewords());
		    	   
		    	   setLblduedate(bean.getLblduedate());
		    	   
		   
		 return "print";
		 }	
		
		
	
	
	

}
