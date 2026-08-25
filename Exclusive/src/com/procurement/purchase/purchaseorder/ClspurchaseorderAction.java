	package com.procurement.purchase.purchaseorder;

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
 

public class ClspurchaseorderAction {

	
	
	private String  nipurchaseorderdate,hidnipurchaseorderdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,formdetailcode,puraccname,refno,reqmasterdocno, reftype,rrefno,reftypeval,editdata;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,termsgridlength,shipdatagridlenght,shipdocno,header;
	private String lblvocno;
	
 
	public String getLblvocno() {
		return lblvocno;
	}

	public void setLblvocno(String lblvocno) {
		this.lblvocno = lblvocno;
	}

	public int getHeader() {
		return header;
	}

	public void setHeader(int header) {
		this.header = header;
	}



	private String  shipto,watermarks,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax,secndtarray,lbladdress,lblphone,lblfax;

	
	private String contrtype,venland,venphon,lblpreparedby,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
	
		private double st,taxontax1,taxontax2,taxontax3,taxtotal;
		
		
		private int cmbbilltype,hidcmbbilltype;
		
		 private int  hideitemtype, itemdocno,itemtype,costtr_no;
		 
		 private String itemname,lblnettax,lblclienttrno,lblbranchtrno,lblTotalAmounnt;
           
	        private String lblnote,lblpono,lblcontact,lbladdrs,lblcity,lblphoneno,lblfaxx,lblemaill,lblpodate;
		 
		 
	        private String lblamounttot, lbldiscval, lblnetafterdisc , lblnettaxprint3  ,lblsrvamount , lastvaluewords, lastvalue;
	        
	        
	        
		
	public String getLblamounttot() {
				return lblamounttot;
			}

			public void setLblamounttot(String lblamounttot) {
				this.lblamounttot = lblamounttot;
			}

			public String getLbldiscval() {
				return lbldiscval;
			}

			public void setLbldiscval(String lbldiscval) {
				this.lbldiscval = lbldiscval;
			}

			public String getLblnettaxprint3() {
				return lblnettaxprint3;
			}

			public void setLblnettaxprint3(String lblnettaxprint3) {
				this.lblnettaxprint3 = lblnettaxprint3;
			}

	public String getLblnetafterdisc() {
				return lblnetafterdisc;
			}

			public void setLblnetafterdisc(String lblnetafterdisc) {
				this.lblnetafterdisc = lblnetafterdisc;
			}

			public String getLblsrvamount() {
				return lblsrvamount;
			}

			public void setLblsrvamount(String lblsrvamount) {
				this.lblsrvamount = lblsrvamount;
			}

			public String getLastvaluewords() {
				return lastvaluewords;
			}

			public void setLastvaluewords(String lastvaluewords) {
				this.lastvaluewords = lastvaluewords;
			}

			public String getLastvalue() {
				return lastvalue;
			}

			public void setLastvalue(String lastvalue) {
				this.lastvalue = lastvalue;
			}

	public String getLblnote() {
				return lblnote;
			}

			public void setLblnote(String lblnote) {
				this.lblnote = lblnote;
			}

	public String getContrtype() {
				return contrtype;
			}

			public void setContrtype(String contrtype) {
				this.contrtype = contrtype;
			}

	public String getLblTotalAmounnt() {
				return lblTotalAmounnt;
			}

			public void setLblTotalAmounnt(String lblTotalAmounnt) {
				this.lblTotalAmounnt = lblTotalAmounnt;
			}

	public String getLblbranchtrno() {
				return lblbranchtrno;
			}

			public void setLblbranchtrno(String lblbranchtrno) {
				this.lblbranchtrno = lblbranchtrno;
			}

	public String getLblclienttrno() {
				return lblclienttrno;
			}

			public void setLblclienttrno(String lblclienttrno) {
				this.lblclienttrno = lblclienttrno;
			}

	public String getLblnettax() {
				return lblnettax;
			}

			public void setLblnettax(String lblnettax) {
				this.lblnettax = lblnettax;
			}

	public String getLblpono() {
				return lblpono;
			}

			public void setLblpono(String lblpono) {
				this.lblpono = lblpono;
			}

			public String getLblcontact() {
				return lblcontact;
			}

			public void setLblcontact(String lblcontact) {
				this.lblcontact = lblcontact;
			}

			public String getLbladdrs() {
				return lbladdrs;
			}

			public void setLbladdrs(String lbladdrs) {
				this.lbladdrs = lbladdrs;
			}

			public String getLblcity() {
				return lblcity;
			}

			public void setLblcity(String lblcity) {
				this.lblcity = lblcity;
			}

			public String getLblphoneno() {
				return lblphoneno;
			}

			public void setLblphoneno(String lblphoneno) {
				this.lblphoneno = lblphoneno;
			}

			public String getLblfaxx() {
				return lblfaxx;
			}

			public void setLblfaxx(String lblfaxx) {
				this.lblfaxx = lblfaxx;
			}

			public String getLblemaill() {
				return lblemaill;
			}

			public void setLblemaill(String lblemaill) {
				this.lblemaill = lblemaill;
			}

			public String getLblpodate() {
				return lblpodate;
			}

			public void setLblpodate(String lblpodate) {
				this.lblpodate = lblpodate;
			}

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

	public String getLbladdress() {
			return lbladdress;
		}

		public void setLbladdress(String lbladdress) {
			this.lbladdress = lbladdress;
		}

		public String getLblphone() {
			return lblphone;
		}

		public void setLblphone(String lblphone) {
			this.lblphone = lblphone;
		}

		public String getLblfax() {
			return lblfax;
		}

		public void setLblfax(String lblfax) {
			this.lblfax = lblfax;
		}

	public String getWatermarks() {
			return watermarks;
		}

		public void setWatermarks(String watermarks) {
			this.watermarks = watermarks;
		}

	public String getSecndtarray() {
			return secndtarray;
		}

		public void setSecndtarray(String secndtarray) {
			this.secndtarray = secndtarray;
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



	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
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

	public String getNipurchaseorderdate() {
		return nipurchaseorderdate;
	}

	public void setNipurchaseorderdate(String nipurchaseorderdate) {
		this.nipurchaseorderdate = nipurchaseorderdate;
	}

	public String getHidnipurchaseorderdate() {
		return hidnipurchaseorderdate;
	}

	public void setHidnipurchaseorderdate(String hidnipurchaseorderdate) {
		this.hidnipurchaseorderdate = hidnipurchaseorderdate;
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



	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords;
	
	
	private int lbldoc,firstarray,secarray;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblcompemail,lblcompweb,lblbranch,lbllocation,lblprintname;	

	 
	private String  lblshipto,lblshipaddress,lblcontactperson,lblshiptelephone,lblshipmob,lblshipemail,lblshipfax;
	
	
	//getLblshipto getLblshipaddress getLblcontactperson getLblshiptelephone getLblshipmob getLblshipemail getLblshipfax
	

	public String getLblshipto() {
		return lblshipto;
	}

	public String getLblcompemail() {
		return lblcompemail;
	}

	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}

	public String getLblcompweb() {
		return lblcompweb;
	}

	public void setLblcompweb(String lblcompweb) {
		this.lblcompweb = lblcompweb;
	}

	public void setLblshipto(String lblshipto) { 
		this.lblshipto = lblshipto;
	}

	public String getLblshipaddress() {
		return lblshipaddress;
	}

	public void setLblshipaddress(String lblshipaddress) {
		this.lblshipaddress = lblshipaddress;
	}

	public String getLblcontactperson() {
		return lblcontactperson;
	}

	public void setLblcontactperson(String lblcontactperson) {
		this.lblcontactperson = lblcontactperson;
	}

	public String getLblshiptelephone() {
		return lblshiptelephone;
	}

	public void setLblshiptelephone(String lblshiptelephone) {
		this.lblshiptelephone = lblshiptelephone;
	}

	public String getLblshipmob() {
		return lblshipmob;
	}

	public void setLblshipmob(String lblshipmob) {
		this.lblshipmob = lblshipmob;
	}

	public String getLblshipemail() {
		return lblshipemail;
	}

	public void setLblshipemail(String lblshipemail) {
		this.lblshipemail = lblshipemail;
	}

	public String getLblshipfax() {
		return lblshipfax;
	}

	public void setLblshipfax(String lblshipfax) {
		this.lblshipfax = lblshipfax;
	}

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

	
	String url;



		
public String getUrl() {
	return url;
}

public void setUrl(String url) {
	this.url = url;
}

private String lbldiscountvalue;
public String getLbldiscountvalue() {
	return lbldiscountvalue;
}

public void setLbldiscountvalue(String lbldiscountvalue) {
	this.lbldiscountvalue = lbldiscountvalue;
}



private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	

	ClspurchaseorderDAO saveObj = new ClspurchaseorderDAO();
	
	ClspurchaseorderBean viewObj = new ClspurchaseorderBean();
 
	ClspurchaseorderBean pintbean = new ClspurchaseorderBean();
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

//System.out.println("=====mode===="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());

	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getNipurchaseorderdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			
		 
			String temp2=requestParams.get("desctest"+i)[0];
		 
		
			descarray.add(temp2);
			 
		}
		
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
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
		
 
		
		for(int i=0;i<getShipdatagridlenght();i++){
			
		 
			String temp2=requestParams.get("shiptest"+i)[0];
		 
		
			shiparray.add(temp2);
			 
		}
		
		 
		int val=saveObj.insert(masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,getNetTotaldown(),getNettotal(),
				getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,masterarray,getReftype(),
				getReqmasterdocno(),getPrddiscount(),termsarray,shiparray,getShipdocno(),
				getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3(), getTaxtotal(),getCmbbilltype(),getItemtype(),getCosttr_no());
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
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
		 
			setHidnipurchaseorderdate(masterdate.toString());
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
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 
			 setPrddiscount(getPrddiscount());
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
             
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
             setShipdocno(getShipdocno());
             
             
          	setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
             
			setMsg("Successfully Saved");
			 
			return "success";
			
		}
		else
		{
			
			
			setHidnipurchaseorderdate(masterdate.toString());
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
		
			 
				
			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			 
				setReqmasterdocno(getReqmasterdocno());
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
			 
             
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             setShipdocno(getShipdocno());
             
             
          	setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
			setMsg("Not Saved");
			return "fail";
			
		}
		
		
		
		
		
		
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getNipurchaseorderdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
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
				
				
		
		
		int val=saveObj.update(getMasterdoc_no(),masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),
				getDelterms(),getPayterms(),getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,
				getNetTotaldown(),getNettotal(),getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,descarray,
				masterarray,getReftype(),getReqmasterdocno(),getPrddiscount(),termsarray,getEditdata(),shiparray,getShipdocno(),
				getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3(), getTaxtotal(),getCmbbilltype(),getItemtype(),getCosttr_no());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setReqmasterdocno(getReqmasterdocno());
			
			

			 setSt(getSt()); 
			 setTaxontax1(getTaxontax1());
			 setTaxontax2(getTaxontax2());
			 setTaxontax3(getTaxontax3());
			 setTaxtotal(getTaxtotal());
			 setHidcmbbilltype(getCmbbilltype());
			 
			
			
			setHidnipurchaseorderdate(masterdate.toString());
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
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             setShipdocno(getShipdocno());
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             
          	setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
			
			
			setHidnipurchaseorderdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			

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
			 
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             setShipdocno(getShipdocno());
             
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
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             setShipdocno(getShipdocno());
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
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
             setShipdocno(getShipdocno());
             setShipto(getShipto());
             setShipaddress(getShipaddress());
             setContactperson(getContactperson());
             setShiptelephone(getShiptelephone());
             setShipmob(getShipmob());
             setShipemail(getShipemail());
             setShipfax(getShipfax());
             setMsg("Not Deleted");
             return "fail";
 			
		}
		
		
		
	}	
	else if(mode.equalsIgnoreCase("view")){
		
		
		viewObj=saveObj.getViewDetails(getDocno(),session);
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(viewObj.getMasterdoc_no());
 
		
		
		 setSt(viewObj.getSt()); 
		 setTaxontax1(viewObj.getTaxontax1());
		 setTaxontax2(viewObj.getTaxontax2());
		 setTaxontax3(viewObj.getTaxontax3());
		 setTaxtotal(viewObj.getTaxtotal());
		 setHidcmbbilltype(viewObj.getCmbbilltype());

		
		
		
		setHidnipurchaseorderdate(viewObj.getNipurchaseorderdate());
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
		
		
         
         
			 setShipdocno(viewObj.getShipdocno());
		     setShipto(viewObj.getShipto());
			 setShipaddress(viewObj.getShipaddress());
			 setContactperson(viewObj.getContactperson());
			 setShiptelephone(viewObj.getShiptelephone());
				
			 setShipmob(viewObj.getShipmob());
			 setShipemail(viewObj.getShipemail());
			 setShipfax(viewObj.getShipfax());
		
				setHideitemtype(viewObj.getItemtype());
				
				setCosttr_no(viewObj.getCosttr_no());

				setItemname(viewObj.getItemname());
				
				setItemdocno(viewObj.getItemdocno());
				
		
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
	
	
		public String printAction() throws ParseException, SQLException{
			
			  HttpServletRequest request=ServletActionContext.getRequest();
			  HttpServletResponse response=ServletActionContext.getResponse();
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String brhid=request.getParameter("brhid");
			 String dtype=request.getParameter("dtype");
			 int header=Integer.parseInt(request.getParameter("header")) ;
			 ClspurchaseorderDAO ClspurchaseorderDAO=new ClspurchaseorderDAO();
			 pintbean=ClspurchaseorderDAO.getPrint(doc,request,brhid,dtype);
		  	setUrl(ClsCommon.getPrintPath(dtype));
			 
			
			  //cl details
		  	setLblnote(pintbean.getLblnote());
			   	setLblpodate(pintbean.getLblpodate());
			 setLblpono(pintbean.getLblpono());
			 setLbladdrs(pintbean.getLbladdrs());
			 setLblcontact(pintbean.getLblcontact());
			 setLblphoneno(pintbean.getLblphoneno());
			 setLblfaxx(pintbean.getLblfaxx());
			 setLblemaill(pintbean.getLblemaill());
			    setLblprintname("Purchase Order");
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			     setWatermarks(pintbean.getWatermarks());
		 	      setSecndtarray(pintbean.getSecndtarray());
	    	     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
	    	     setLbltype(pintbean.getLbltype());
	    	     setLblvendoeacc(pintbean.getLblvendoeacc());  
	    	     setLblvendoeaccName(pintbean.getLblvendoeaccName());
			     setExpdeldate(pintbean.getExpdeldate());
			     setLblphone(pintbean.getLblphone());
			     setLblfax(pintbean.getLblfax());	
	    	           setLbltotal(pintbean.getLbltotal());
		    	       setLblsubtotal(pintbean.getLblsubtotal());
					   setLblbranch(pintbean.getLblbranch());
					   setLblcompname(pintbean.getLblcompname());
					  setLblcompemail(pintbean.getLblcompemail());
					  setLblcompweb(pintbean.getLblcompweb());
					  
					   setLblcompaddress(pintbean.getLblcompaddress());
					   setLblcomptel(pintbean.getLblcomptel());
					   setLblcompfax(pintbean.getLblcompfax());
					   setLbllocation(pintbean.getLbllocation());
					  

					   
					   
					   
					   setFirstarray(pintbean.getFirstarray());
					   
					   setSecarray(pintbean.getSecarray());
					     
			    	   setLblordervalue(pintbean.getLblordervalue());
			    	   setLblordervaluewords(pintbean.getLblordervaluewords());
			    	   setLbladdress(pintbean.getLbladdress());
			    	   
			    	   
			    	 
					     setLblshipto(pintbean.getLblshipto());
						 setLblshipaddress(pintbean.getLblshipaddress());
						 setLblcontactperson(pintbean.getLblcontactperson());
						 setLblshiptelephone(pintbean.getLblshiptelephone());
							
						 setLblshipmob(pintbean.getLblshipmob());
						 setLblshipemail(pintbean.getLblshipemail());
						 setLblshipfax(pintbean.getLblshipfax());
						 
						 
					   		 setLblamounttot(pintbean.getLblamounttot());
				     		setLbldiscval(pintbean.getLbldiscval());
				     		setLblnetafterdisc(pintbean.getLblnetafterdisc());
				     		setLblnettaxprint3(pintbean.getLblnettaxprint3());
				     		setLblsrvamount(pintbean.getLblsrvamount());
				     		
				     		 
				     		setLastvalue(pintbean.getLastvalue());
				     		setLastvaluewords(pintbean.getLastvaluewords());
				     		
						 
					
			    	  // System.out.println(getUrl());

					      setLblverifiedat(pintbean.getLblverifiedat());
					      setLblverifiedon(pintbean.getLblverifiedon());
					      setLblapprovedat(pintbean.getLblapprovedat());
					      setLblapprovedon(pintbean.getLblapprovedon());
					      setLblapprovedby(pintbean.getLblapprovedby());
					      setLblverifiedby(pintbean.getLblverifiedby());
					      setLblpreparedon(pintbean.getLblpreparedon());
				    	    setLblpreparedat(pintbean.getLblpreparedat());
				    	    setLblpreparedby(pintbean.getLblpreparedby());
			   	   
			    	   				    	    setLbldiscountvalue(pintbean.getLbldiscountvalue());
			    	   				    	    setLblnettax(pintbean.getLblnettax());
			    	   				    	    setLblclienttrno(pintbean.getLblclienttrno());
			    	   				    	    setLblbranchtrno(pintbean.getLblbranchtrno());
			    	   				    	    setLblTotalAmounnt(pintbean.getLblTotalAmounnt());
			    	   				    	    setHeader(header);
			    	//   getLblshipto getLblshipaddress getLblcontactperson getLblshiptelephone getLblshipmob getLblshipemail getLblshipfax
			    	   
	 if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
							{				   
							  
							//System.out.println("in iffff");
		 						
								 String	strSqldetail2="select @i:=@i+1 as srno,a.* from ("
													+" select desc1 description,round(unitprice,2)  unitprice,round(qty,2) qty,round(total,2) total,round(discount,2)"
													+" discount ,round(nettotal,2) nettotal from my_ordser     where rdocno='"+doc+"') a,(select @i:=0) r";
							    ClsConnection conobj=new ClsConnection();
								
								 param = new HashMap();
								 Connection conn = null;
								 conn = conobj.getMyConnection();
							     
								 String reportFileName = "PurchaseOrder";
								// String docno=request.getParameter("docno");
								 String brchid=request.getParameter("brhid");
								 
								 
								 try {
							                    
							   
							          
							        param.put("termsquery",pintbean.getTermQry());
							        param.put("serviceqry",strSqldetail2);   
							       param.put("productQuery",pintbean.getPrdQry());
							       param.put("brhid", brchid);
							       param.put("vocno", pintbean.getLblvocno());
							       
							       System.out.println("branch"+brchid);
							       System.out.println("docno"+ pintbean.getLblvocno());
							       
							       //  System.out.println("parrram"+param);
							         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
							        	imgpath=imgpath.replace("\\", "\\\\");    
							          param.put("imghedderpath", imgpath);
							          
							          
							          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
							        	imgpath2=imgpath2.replace("\\", "\\\\");    
							          param.put("imgfooterpath", imgpath2);
							          
									  param.put("compname", pintbean.getLblcompname());
							          param.put("compaddress", pintbean.getLblcompaddress());
							          param.put("comptel", pintbean.getLblcomptel());
							          param.put("compfax", pintbean.getLblcompfax());
							           param.put("comptrn", pintbean.getLblbranchtrno());
							      	   param.put("tinno",pintbean.getTinno());
							          param.put("vendor", pintbean.getLblvendoeaccName());
							          param.put("attn", pintbean.getAttn());
							          param.put("tel", pintbean.getTel());
							          param.put("fax", pintbean.getFax());
							          param.put("email", pintbean.getEmail());
							          param.put("docno",Integer.parseInt(pintbean.getLblvocno()));
							          param.put("date", pintbean.getLbldate());
							          param.put("refno", pintbean.getLblrefno());
							          param.put("desc", pintbean.getLbldesc1());  
							          param.put("payterm", pintbean.getLblpaytems());
							          param.put("srvnetamount", pintbean.getSrvtotal());
							          param.put("servquery", pintbean.getSrvQyy());
							          param.put("prdnetamount", pintbean.getLbltotal());
							           param.put("discount", pintbean.getDiscount());
							          param.put("delterm", pintbean.getLbldelterms());
							          param.put("netamount", pintbean.getNetAmountprint());
							          param.put("amountwords", pintbean.getWordnetAmtPrint());
				       

									param.put("totalamnt", pintbean.getJbillprdamnt());
							          param.put("discount", pintbean.getJbilldiscount());
							          param.put("nettotal", pintbean.getLblnettotal());
							          param.put("taxamnt", pintbean.getJbilltax());
							          param.put("srvchrg", pintbean.getJsrvchrg());
							          param.put("netamount", pintbean.getJtotalbill());
							          param.put("amountwords", pintbean.getJbillamntinwords());

							          param.put("prdnetamountwotax", pintbean.getJfire7prdwithdis()); //fire7
						                 param.put("ttotalamnt", pintbean.getJbillprdamnt());
						                 param.put("tdiscount", pintbean.getJbilldiscount());
						                 param.put("taxamnt", pintbean.getJbilltax());
						                 param.put("tsrvchrg", pintbean.getJsrvchrg());
						                 param.put("tnetamount", pintbean.getJtotalbill());
						                 param.put("tamountwords", pintbean.getJbillamntinwords());
						                 param.put("tsrvnetamount", pintbean.getSrvtotal());
						                 
						                 
						                 param.put("f7tnetamount", pintbean.getJf7totalbill());
						                 param.put("f7tamountwords", pintbean.getF7jbillamntinwords());
							          
							          
								  param.put("preparedby",pintbean.getLblpreparedby());
							          param.put("verifiedby",pintbean.getLblverifiedby());
							          param.put("approvedby",pintbean.getLblapprovedby());
							          param.put("prep_date",pintbean.getLblpreparedon());
							          param.put("vre_date",pintbean.getLblverifiedon());
							          param.put("app_date",pintbean.getLblapprovedon());
							          param.put("prep_time",pintbean.getLblpreparedat());
							          param.put("vre_time",pintbean.getLblverifiedat());
							          param.put("app_time",pintbean.getLblapprovedat());
							          param.put("draft_stat",pintbean.getDraftstat());
							          		
								      param.put("custaddress", pintbean.getLbladdress());
							          param.put("clienttrno", pintbean.getTinno());
								  param.put("compnytrno", pintbean.getCompanytrno());
								  param.put("header", header);


							          //fire7
							           String fire7imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7fullheader.jpg");
							           fire7imgpath=fire7imgpath.replace("\\", "\\\\");
							           param.put("fire7fullheadderpath", fire7imgpath);
//							           System.out.println("=== path == "+fire7imgpath);
								        setUrl(ClsCommon.getPrintPath(dtype));
								  
								        // common header for all
								        String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/header.jpg");
								        headerimgpath=headerimgpath.replace("\\", "\\\\");
								           param.put("headerpath", headerimgpath);
//								           System.out.println("=== path == "+headerimgpath);
								        
					              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/Procurement/Purchase/PurchaseOrder/"+ClsCommon.getPrintPath(dtype)));
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
