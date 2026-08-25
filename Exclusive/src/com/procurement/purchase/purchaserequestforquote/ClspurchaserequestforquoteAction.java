package com.procurement.purchase.purchaserequestforquote;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 

public class ClspurchaserequestforquoteAction {

	
	
	private String  date,hiddate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,formdetailcode,puraccname,refno,reqmasterdocno, reftype,rrefno,reftypeval,editdata;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,termsgridlength,shipdatagridlenght,shipdocno;
	
 
	


	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax,lblbranchtrno,lbltrnnumber;
	
	
	
	

	
	public String getLbltrnnumber() {
		return lbltrnnumber;
	}

	public void setLbltrnnumber(String lbltrnnumber) {
		this.lbltrnnumber = lbltrnnumber;
	}

	public String getLblbranchtrno() {
		return lblbranchtrno;
	}

	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}



	ClsCommon ClsCommon=new ClsCommon();
	
	
	
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

	public String getEditdata() {
		return editdata;
	}

	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}

	public int getTermsgridlength() {
		return termsgridlength;
	}

	public void setTermsgridlength(int termsgridlength) {
		this.termsgridlength = termsgridlength;
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
	
 
	
	public int getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
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



	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords,lbltelno,lblattn,lblemail,lblproname,lblloc,lblrfq,lblfax;
	
	
	public String getLblfax() {
		return lblfax;
	}

	public void setLblfax(String lblfax) {
		this.lblfax = lblfax;
	}

	public String getLbltelno() {
		return lbltelno;
	}

	public void setLbltelno(String lbltelno) {
		this.lbltelno = lbltelno;
	}

	public String getLblattn() {
		return lblattn;
	}

	public void setLblattn(String lblattn) {
		this.lblattn = lblattn;
	}

	public String getLblemail() {
		return lblemail;
	}

	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}

	public String getLblproname() {
		return lblproname;
	}

	public void setLblproname(String lblproname) {
		this.lblproname = lblproname;
	}

	public String getLblloc() {
		return lblloc;
	}

	public void setLblloc(String lblloc) {
		this.lblloc = lblloc;
	}

	public String getLblrfq() {
		return lblrfq;
	}

	public void setLblrfq(String lblrfq) {
		this.lblrfq = lblrfq;
	}



	private int lbldoc,firstarray,secarray;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	

	 
	
	
	
	

	public String getLblordervaluewords() {
		return lblordervaluewords;
	}

	public void setLblordervaluewords(String lblordervaluewords) {
		this.lblordervaluewords = lblordervaluewords;
	}

	public String getLblordervalue() {
		return lblordervalue;
	}

	public void setLblordervalue(String lblordervalue) {
		this.lblordervalue = lblordervalue;
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

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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



	ClspurchaserequestforquoteDAO saveObj = new ClspurchaserequestforquoteDAO();
	
	ClspurchaserequestforquoteBean viewObj = new ClspurchaserequestforquoteBean();
 
	ClspurchaserequestforquoteBean pintbean = new ClspurchaserequestforquoteBean();
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());

	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
		 
		ArrayList<String> descarray= new ArrayList<>();
 
		
		ArrayList<String> masterarray= new ArrayList<>();
		for(int i=0;i<getServiecGridlength();i++){
			
			 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
 
		ArrayList<String> termsarray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getTermsgridlength();i++){
			
		 
			String temp2=requestParams.get("termg"+i)[0];
		 
		
			termsarray.add(temp2);
			 
		}
		
	ArrayList<String> shiparray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getShipdatagridlenght();i++){
			
		 
			String temp2=requestParams.get("shiptest"+i)[0];
		 
		
			shiparray.add(temp2);
			 
		}
		
		
		
		
		
		
		
		int val=saveObj.insert(masterdate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,getNetTotaldown(),getNettotal(),
				getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,masterarray,getReftype(),
				getReqmasterdocno(),getPrddiscount(),termsarray,getRrefno(),shiparray,getShipdocno());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(vdocno);
			setMasterdoc_no(val);
			
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			
			setHiddate(masterdate.toString());
		 
			//setDelterms(getDelterms());
			//setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
/*			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 
			 setPrddiscount(getPrddiscount());
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());*/
			 
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
             setShipdocno(getShipdocno());
			setMsg("Successfully Saved");
			return "success";
			
		}
		else
		{
			
			
			setHiddate(masterdate.toString());
		 
		//	setDelterms(getDelterms());
		//setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 
				setReqmasterdocno(getReqmasterdocno());
				setReftypeval(getReftype());
				setRrefno(getRrefno());
				
//			 setProductTotal(getProductTotal());
//			 setChkdiscountval(getChkdiscount());
//			 setDescPercentage(getDescPercentage());
//			 setPrddiscount(getPrddiscount());
//			 
//			 setDescountVal(getDescountVal());
//			 setRoundOf(getRoundOf());
//			 setNetTotaldown(getNetTotaldown());
//             setNettotal(getNettotal());
//             setOrderValue(getOrderValue());
//			 
	             
	             setShipto(getShipto());
	             setShipaddress(getShipaddress());
	             setContactperson(getContactperson());
	             setShiptelephone(getShiptelephone());
	             setShipmob(getShipmob());
	             setShipemail(getShipemail());
	             setShipfax(getShipfax());
	             
	             setShipdocno(getShipdocno());
			setMsg("Not Saved");
			return "fail";
			
		}
		
		
		
		
		
		
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
	 
		ArrayList<String> descarray= new ArrayList<>();
	 
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		
	ArrayList<String> termsarray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getTermsgridlength();i++){
			
		 
			String temp2=requestParams.get("termg"+i)[0];
		 
		
			termsarray.add(temp2);
			 
		}
		
		ArrayList<String> shiparray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getShipdatagridlenght();i++){
			
		 
			String temp2=requestParams.get("shiptest"+i)[0];
		 
		
			shiparray.add(temp2);
			 
		}
		
		
		
		
		int val=saveObj.update(getMasterdoc_no(),masterdate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),
				getDelterms(),getPayterms(),getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,
				getNetTotaldown(),getNettotal(),getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,
				masterarray,getReftype(),getReqmasterdocno(),getPrddiscount(),termsarray,getEditdata(),getRrefno(),shiparray,getShipdocno());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			
			setHiddate(masterdate.toString());
			 
			//setDelterms(getDelterms());
			//setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			//duwn
/*			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 */
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
             setShipdocno(getShipdocno());
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
			
			
			setHiddate(masterdate.toString());
		 
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			
			//setDelterms(getDelterms());
			//setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 
			/* setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 */
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
             setShipdocno(getShipdocno());
				setMsg("Not Updated");
			return "fail";
			
		}
		
	 
	}
	else if(mode.equalsIgnoreCase("D")){
		
		
	int val=saveObj.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);
		
		if(val>0)
		{
			
			
		 
			//setDelterms(getDelterms());
		//	setPayterms(getPayterms());
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
	/*		 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());*/
             
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
				return "success";
		}
		else
		{
			//setDelterms(getDelterms());
		//	setPayterms(getPayterms());
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
		//	 setProductTotal(getProductTotal());
			// setChkdiscountval(getChkdiscount());
			// setDescPercentage(getDescPercentage());
			// setPrddiscount(getPrddiscount());
			 
			// setDescountVal(getDescountVal());
			// setRoundOf(getRoundOf());
			// setNetTotaldown(getNetTotaldown());
          //   setNettotal(getNettotal());
         //    setOrderValue(getOrderValue());
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
             setShipdocno(getShipdocno());
             setMsg("Not Deleted");
             return "fail";
 			
		}
		
		
		
	}	
	else if(mode.equalsIgnoreCase("view")){
		
		ClspurchaserequestforquoteDAO ClspurchaserequestforquoteDAO=new ClspurchaserequestforquoteDAO();
		viewObj=ClspurchaserequestforquoteDAO.getViewDetails(getMasterdoc_no());
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(getMasterdoc_no());
 
		
		
		setHiddate(viewObj.getDate());
	//	setHiddeliverydate(viewObj.getDeliverydate());
		//setDelterms(viewObj.getDelterms());
		//setPayterms(viewObj.getPayterms());
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
		 
		 
		 
         
			 setShipdocno(viewObj.getShipdocno());
		     setShipto(viewObj.getShipto());
			 setShipaddress(viewObj.getShipaddress());
			 setContactperson(viewObj.getContactperson());
			 setShiptelephone(viewObj.getShiptelephone());
				
			 setShipmob(viewObj.getShipmob());
			 setShipemail(viewObj.getShipemail());
			 setShipfax(viewObj.getShipfax());
		
		 
		//duwn
		// setProductTotal(viewObj.getProductTotal());
		// setChkdiscountval(viewObj.getChkdiscountval());
		// setDescPercentage(viewObj.getDescPercentage());
		 
		// setPrddiscount(viewObj.getPrddiscount());
		 
		 
		// setDescountVal(viewObj.getDescountVal());
		// setRoundOf(viewObj.getRoundOf());
		// setNetTotaldown(viewObj.getNetTotaldown());
      //   setNettotal(viewObj.getNettotal());
   //      setOrderValue(viewObj.getOrderValue());
		
		
		
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
	
	
		public String printAction() throws ParseException, SQLException{
			
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
			 pintbean=saveObj.getPrint(doc,request,branch);
		  
			 
			
			  //cl details
			 
			    setLblprintname("Purchase Request For Quote");
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			     setLblbranchtrno(pintbean.getLblbranchtrno());
			    
		 	      
	    	     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
	    	     setLbltype(pintbean.getLbltype());
	    	     setLblvendoeacc(pintbean.getLblvendoeacc());  
	    	     setLblvendoeaccName(pintbean.getLblvendoeaccName());
			     setExpdeldate(pintbean.getExpdeldate());
		 
						
	    	           setLbltotal(pintbean.getLbltotal());
		    	       setLblsubtotal(pintbean.getLblsubtotal());
					   setLblbranch(pintbean.getLblbranch());
					   setLblcompname(pintbean.getLblcompname());
					  
					   setLblcompaddress(pintbean.getLblcompaddress());
					   setLblcomptel(pintbean.getLblcomptel());
					   setLblcompfax(pintbean.getLblcompfax());
					   setLbllocation(pintbean.getLbllocation());
					   setLblattn(pintbean.getLblattn());
					   setLblemail(pintbean.getLblemail());
					   setLbltelno(pintbean.getLbltelno());
					   setLbltrnnumber(pintbean.getLbltrnnumber());
					  

					   
					   
					   
					   setFirstarray(pintbean.getFirstarray());
					   
					   setSecarray(pintbean.getSecarray());
					     
			    	   setLblordervalue(pintbean.getLblordervalue());
			    	   setLblordervaluewords(pintbean.getLblordervaluewords());
			   
			 return "print";
			 }	
			
			
	
	
}
