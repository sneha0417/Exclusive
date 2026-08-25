package com.procurement.purchase.goodsreceiptnotereturn;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 

public class ClsgoodsreceiptnotereturnAction {

	
	ClsCommon ClsCommon=new ClsCommon();	
	
	

	
	private String  masterdate,hidmasterdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,
	formdetailcode,txtlocation,puraccname,refno,refmasterdoc_no, reftype,rrefno,reftypeval,editdata;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,txtlocationid;

	
	//invdate hidinvdate
	// masterdate hidmasterdate refmasterdoc_no txtlocation txtlocationid
	
	
	public double getPrddiscount() {
		return prddiscount;
	}

	public String getEditdata() {
		return editdata;
	}

	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}

	public void setPrddiscount(double prddiscount) {
		this.prddiscount = prddiscount;
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

	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}

	public String getRefmasterdoc_no() {
		return refmasterdoc_no;
	}

	public void setRefmasterdoc_no(String refmasterdoc_no) {
		this.refmasterdoc_no = refmasterdoc_no;
	}

	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}




	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblloc;
	
	
	private int lbldoc;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	


 

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




	ClsgoodsreceiptnotereturnDAO saveObj = new ClsgoodsreceiptnotereturnDAO();
	
	ClsgoodsreceiptnotereturnBean viewObj = new ClsgoodsreceiptnotereturnBean();
 

	ClsgoodsreceiptnotereturnBean  pintbean=new  ClsgoodsreceiptnotereturnBean();

		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

 //System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());
			//  setHidmasterdate() getTxtlocation() getRefmasterdoc_no() 
	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		
 
		 
		 
		
		 
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		int val=saveObj.insert(masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,getNetTotaldown(),getNettotal(),
				getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request, 
				masterarray,getReftype(),getRefmasterdoc_no(),getPrddiscount(),getTxtlocationid() );
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(vdocno);
			setMasterdoc_no(val);
			 
 
			
 
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
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
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 
			 setPrddiscount(getPrddiscount());
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
			 
			setMsg("Successfully Saved");
			return "success";
			
		}
		else
		{
 
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
			 
			 setTxtlocationid(getTxtlocationid());
				setTxtlocation(getTxtlocation());
			//duwn
			 
				setRefmasterdoc_no(getRefmasterdoc_no());
				setReftypeval(getReftype());
				setRrefno(getRrefno());
				
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
			
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
		
		int val=saveObj.update(getMasterdoc_no(),masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),
				getDelterms(),getPayterms(),getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,
				getNetTotaldown(),getNettotal(),getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,
				masterarray,getReftype(),getRefmasterdoc_no(),getPrddiscount(),getTxtlocationid(),getEditdata());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			 
			setReftypeval(getReftype());
			
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
	 
			
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
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
			 
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
		 
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
	
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
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
			 
			 
			 
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
			
				setMsg("Not Updated");
			return "fail";
			
		}
		
	 
	}
	else if(mode.equalsIgnoreCase("D")){
		
		
	int val=saveObj.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);
		
		if(val>0)
		{
			
			 
			setTxtlocation(getTxtlocation());
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
			setTxtlocation(getTxtlocation());
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
			 
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             setMsg("Not Deleted");
             return "fail";
 			
		}
		
		
		
	}	
	else if(mode.equalsIgnoreCase("view")){
		
		ClsgoodsreceiptnotereturnDAO ClsgoodsreceiptnotereturnDAO=new ClsgoodsreceiptnotereturnDAO();
		viewObj=ClsgoodsreceiptnotereturnDAO.getViewDetails(getMasterdoc_no());
		
		
		
		
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
		 
		 
			
		 setReftypeval(viewObj.getReftype());
		 setRrefno(viewObj.getRrefno());
		 
		setRefmasterdoc_no(viewObj.getRefmasterdoc_no());
		
		
		
		 setTxtlocation(viewObj.getTxtlocation());
		
		 setTxtlocationid(viewObj.getTxtlocationid());
		
		 
		 
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
		
		
		
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
	
	
	
		public String printAction() throws ParseException, SQLException{
			
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 
				ClsgoodsreceiptnotereturnDAO ClsgoodsreceiptnotereturnDAO=new ClsgoodsreceiptnotereturnDAO();
			 pintbean=ClsgoodsreceiptnotereturnDAO.getPrint(doc,request);
		  
			 
			
			  //cl details
			 
			    setLblprintname("Goods Receipt Note Return");
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			    
		 	      
	    	     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
 
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
					   

			   
			 return "print";
			 }	
			
	
	
	
	
	
}
