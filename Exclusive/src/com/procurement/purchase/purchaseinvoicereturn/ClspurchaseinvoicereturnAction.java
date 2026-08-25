package com.procurement.purchase.purchaseinvoicereturn;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 
public class ClspurchaseinvoicereturnAction {
	
	
	ClsCommon ClsCommon=new ClsCommon();
	
	
	private String  masterdate,txtlocation,hidmasterdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,formdetailcode,puraccname,refno,reqmasterdocno, reftype,rrefno,reftypeval,editdata,lblordervaluewords;
	
	private double currate,netTotaldown,cmbcurrval,productTotal,prddiscount;
	
	private int docno,cmbcurr,accdocno,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,txtlocationid;
	

	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	
	
	private int cmbbilltype,hidcmbbilltype;
	private String trnnumber; 
	
	
	
	public String getTrnnumber() {
		return trnnumber;
	}
	public void setTrnnumber(String trnnumber) {
		this.trnnumber = trnnumber;
	}
	public String getLblordervaluewords() {
		return lblordervaluewords;
	}
	public void setLblordervaluewords(String lblordervaluewords) {
		this.lblordervaluewords = lblordervaluewords;
	}
	
	public double getProductTotal() {
		return productTotal;
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

	public void setProductTotal(double productTotal) {
		this.productTotal = productTotal;
	}

	public double getPrddiscount() {
		return prddiscount;
	}

	public void setPrddiscount(double prddiscount) {   
		this.prddiscount = prddiscount;
	}

	public String getEditdata() {
		return editdata;
	}

	public void setEditdata(String editdata) {
		this.editdata = editdata;
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

	

	public double getNetTotaldown() {
		return netTotaldown;
	}

	public void setNetTotaldown(double netTotaldown) {
		this.netTotaldown = netTotaldown;
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

 

 
	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}


 
	
	
 
	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno ,lblloc,lbltotal;
	
	
	private int lbldoc;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	

 

	
	
	
	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
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






	ClspurchaseinvoicereturnDAO  saveObj = new ClspurchaseinvoicereturnDAO();
	ClspurchaseinvoicereturnBean viewObj = new ClspurchaseinvoicereturnBean();
 
 
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

 

	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		
 
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		 
		
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		 
		     
		
		
		
		int val=saveObj.insert(masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getNetTotaldown(),
				 session,getMode(),getFormdetailcode(),request,masterarray,getReftype(),
				getReqmasterdocno(),getTxtlocationid(),getProductTotal(),getPrddiscount()
				,getSt(),getTaxontax1(),getTaxontax2(),getTaxontax3(),getTaxtotal(),getCmbbilltype());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(vdocno);
			setMasterdoc_no(val);
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
			setHiddeliverydate(deldate.toString());
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
			 
			//duwn
 
	 
		 
			 
			 setPrddiscount(getPrddiscount());
			 setProductTotal(getProductTotal());
		
			 
 
	 
			 setNetTotaldown(getNetTotaldown());
 
 
			setMsg("Successfully Saved");
			return "success";
			
		}
		else
		{
			
			// getMasterdate setHidmasterdate	
			setHidmasterdate(masterdate.toString());
			setHiddeliverydate(deldate.toString());
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
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 
				setReqmasterdocno(getReqmasterdocno());
				setReftypeval(getReftype());
				setRrefno(getRrefno());
				
			 
			 setNetTotaldown(0);
			 setPrddiscount(0);
			 setProductTotal(0);
			  
			setMsg("Not Saved");
			return "fail";
			
		}
		
		
		
		
		
		
	}
 	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		 
		
		
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		 
		
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
	 
		//System.out.println("---getRefno()----"+getRefno()); 
		
 int val=saveObj.update(getMasterdoc_no(),masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
			getPurdesc(),getNetTotaldown(),
			 session,getMode(),getFormdetailcode(),request,masterarray,getReftype(),
			getReqmasterdocno(),getTxtlocationid(),getProductTotal(),getPrddiscount(),getEditdata(),getSt(),getTaxontax1(),getTaxontax2(),getTaxontax3(),getTaxtotal(),getCmbbilltype());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			setHidmasterdate(masterdate.toString());
			setHiddeliverydate(deldate.toString());
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
			 
			//duwn
 
	 
		 
			 
			 setPrddiscount(getPrddiscount());
			 setProductTotal(getProductTotal());
		
			 
 
	 
			 setNetTotaldown(getNetTotaldown());
 
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
			
			
			setHidmasterdate(masterdate.toString());
			setHiddeliverydate(deldate.toString());
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());               
			
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
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
			 
			//duwn
 
	 
		 
			 
			 setPrddiscount(getPrddiscount());
			 setProductTotal(getProductTotal());
		
			 
 
	 
			 setNetTotaldown(getNetTotaldown());
 
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
 
			 
			 
			 setTxtlocation(getTxtlocation());   
			 setTxtlocationid(getTxtlocationid());
			 

			 
 
			 setNetTotaldown(getNetTotaldown());
 
			 setPrddiscount(getPrddiscount());
			 setProductTotal(getProductTotal());
         
             
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
			 

			 
			 setNetTotaldown(getNetTotaldown());
	         
			 setPrddiscount(getPrddiscount());
			 setProductTotal(getProductTotal());
			 
 
 

           
             
             setMsg("Not Deleted");
             return "fail";
 			
		}
		
		
		
	}	
	else if(mode.equalsIgnoreCase("view")){
		
		ClspurchaseinvoicereturnDAO ClspurchaseinvoicereturnDAO=new ClspurchaseinvoicereturnDAO();
		viewObj=ClspurchaseinvoicereturnDAO.getViewDetails(getMasterdoc_no());
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(getMasterdoc_no());
 
 
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
		 
		 setHidcmbbilltype(viewObj.getBilltype());
			
		 setReftypeval(viewObj.getReftype());
		 setRrefno(viewObj.getRrefno());
		 
		 setReqmasterdocno(viewObj.getReqmasterdocno());
		 
		 
		//duwn
		 
		 setNetTotaldown(viewObj.getNetTotaldown());
         
		 setPrddiscount(viewObj.getPrddiscount());
		 setProductTotal(viewObj.getProductTotal());
		 
		 
		 setTxtlocation(viewObj.getTxtlocation());   
		 setTxtlocationid(viewObj.getTxtlocationid());

         
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
		ClspurchaseinvoicereturnBean pintbean= new ClspurchaseinvoicereturnBean();

		public String printAction() throws ParseException, SQLException{
			
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 
			 ClspurchaseinvoicereturnDAO ClspurchaseinvoicereturnDAO=new ClspurchaseinvoicereturnDAO();
			 pintbean=ClspurchaseinvoicereturnDAO.getPrint(doc,request);
		  
			 
			
			  //cl details
			 
			    setLblprintname("Purchase Invoice Return");
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
	    	     setLbltype(pintbean.getLbltype());
	    	     setLblvendoeacc(pintbean.getLblvendoeacc());  
	    	     setLblvendoeaccName(pintbean.getLblvendoeaccName());
			     setExpdeldate(pintbean.getExpdeldate());
		         setLblbranch(pintbean.getLblbranch());
			     setLblcompname(pintbean.getLblcompname());
					  setLblcompaddress(pintbean.getLblcompaddress());
					   setLblcomptel(pintbean.getLblcomptel());
					   setLblcompfax(pintbean.getLblcompfax());
					   setLbllocation(pintbean.getLbllocation());
					   setLblloc(pintbean.getLblloc());
					   setLbltotal(pintbean.getLbltotal());
					   setLblordervaluewords(pintbean.getLblordervaluewords());
				       setTrnnumber(pintbean.getTrnnumber());
					    
					    
					   
 
			   
			 return "print";
			 }	
			
	
	
	
	
}

	
	
	
	
 
