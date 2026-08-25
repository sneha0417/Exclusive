package com.finance.nipurchase.nipurchaseorder;



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
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")
	public class ClsnipurchaseorderAction extends ActionSupport{
		ClsnipurchaseorderDAO purorderDAO= new ClsnipurchaseorderDAO(); 
		ClsnipurchaseorderBean pintbean= new ClsnipurchaseorderBean(); 
		ClsCommon commDAO=new ClsCommon();
		private String nipurchaseorderdate;
		private String hidnipurchaseorderdate;
		private int  docno,descgridlenght;
		private String refno,acctype,puraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
		private String deleted;
		private Double nettotal;
		private int masterdoc_no;
		ClsnipurchaseorderBean viewobj= new ClsnipurchaseorderBean();
		

		private int taxaccount,hideproducttype;
		
		private double taxpers ;
		
		private String txtproducttype;
		
		
		// for print 
		private String lbldate,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,venaddress,contactperson,amountinwords;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
		
		private String lblnettotal;
		
		private String lbltaxtot,lbltotal,lbldiscount,lbltotinword;
		
		private String lblcomptrn,lblclienttrn;
		
		private String uname,udate,utime;
		
		
		
		public String getUname() {
			return uname;
		}
		public void setUname(String uname) {
			this.uname = uname;
		}
		public String getUdate() {
			return udate;
		}
		public void setUdate(String udate) {
			this.udate = udate;
		}
		public String getUtime() {
			return utime;
		}
		public void setUtime(String utime) {
			this.utime = utime;
		}
		public String getLblcomptrn() {
			return lblcomptrn;
		}
		public void setLblcomptrn(String lblcomptrn) {
			this.lblcomptrn = lblcomptrn;
		}
		public String getLblclienttrn() {
			return lblclienttrn;
		}
		public void setLblclienttrn(String lblclienttrn) {
			this.lblclienttrn = lblclienttrn;
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
		public String getLbltotinword() {
			return lbltotinword;
		}
		public void setLbltotinword(String lbltotinword) {
			this.lbltotinword = lbltotinword;
		}
		public String getVenaddress() {
			return venaddress;
		}
		public void setVenaddress(String venaddress) {    
			this.venaddress = venaddress;
		}
		public String getContactperson() {
			return contactperson;
		}
		public void setContactperson(String contactperson) {
			this.contactperson = contactperson;
		}
		public String getAmountinwords() {
			return amountinwords;
		}
		public void setAmountinwords(String amountinwords) {
			this.amountinwords = amountinwords;
		}
		public String getLbldate() {
			return lbldate;
		}
		public void setLbldate(String lbldate) {
			this.lbldate = lbldate;
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
		public String getLblnettotal() {
			return lblnettotal;
		}
		public void setLblnettotal(String lblnettotal) {
			this.lblnettotal = lblnettotal;
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
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
		}
		public String getRefno() {    
			return refno;
		}

		public String getAccdocno() {
			return accdocno;
		}
		public void setAccdocno(String accdocno) {
			this.accdocno = accdocno;
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
		public String getPuraccid() {
			return puraccid;
		}

		public void setPuraccid(String puraccid) {
			this.puraccid = puraccid;
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
	
		public Double getNettotal() {
			return nettotal;
		}
		public void setNettotal(Double nettotal) {
			this.nettotal = nettotal;
		}
		public int getDescgridlenght() {
			return descgridlenght;
		}
		public void setDescgridlenght(int descgridlenght) {
			this.descgridlenght = descgridlenght;
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
	
		
		
		public int getMasterdoc_no() {
			return masterdoc_no;
		}
		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}
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
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchaseorderdate());
			java.sql.Date sqlpurdeldate = commDAO.changeStringtoSqlDate(getDeliverydate());
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());

	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			
			////System.out.println("dddddddddd"+requestParams.get("desctest"+i)[0]);
			
			String temp2=requestParams.get("desctest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
			//System.out.println("temp2 "+temp2);
		}
		int val=purorderDAO.insert(sqlStartDate1,sqlpurdeldate,getRefno(),getAcctype(),getAccdocno(),getPuraccname(),
				getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),request,getHideproducttype());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			//System.out.println("---------------"+val);
			
			
			setHidnipurchaseorderdate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
		setCurrate(getCurrate());
		setDelterms(getDelterms());
		setPayterms(getPayterms());
		setPurdesc(getPurdesc());
		setNettotal(getNettotal());
			setDocno(vdocno);
			setMasterdoc_no(val);
			//request.setAttribute("vocno", vocno);
		
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			setHidnipurchaseorderdate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
		setCurrate(getCurrate());
		setDelterms(getDelterms());
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
			for(int i=0;i<getDescgridlenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				descarray.add(temp2);
			 
			}
			boolean Status=purorderDAO.edit(getMasterdoc_no(),sqlStartDate1,sqlpurdeldate,getRefno(),getAcctype(),getAccdocno(),getPuraccname(), 
					getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getHideproducttype());
			if(Status){
				
				setHidnipurchaseorderdate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setRefno(getRefno());
				setAcctypeval(getAcctype());
				setPuraccid(getPuraccid());
				setPuraccname(getPuraccname());
				setCmbcurrval(getCmbcurr());
				setAccdocno(getAccdocno());
		    	setCurrate(getCurrate());
			    setDelterms(getDelterms());
		     	setPayterms(getPayterms());
			    setPurdesc(getPurdesc());
			    setNettotal(getNettotal());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Updated Successfully");
				return "success";
			
			}
			else{
				setHidnipurchaseorderdate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setRefno(getRefno());
				setAcctypeval(getAcctype());
				setPuraccid(getPuraccid());
				setPuraccname(getPuraccname());
				setCmbcurrval(getCmbcurr());
				setAccdocno(getAccdocno());
		    	setCurrate(getCurrate());
			    setDelterms(getDelterms());
		     	setPayterms(getPayterms());
			    setPurdesc(getPurdesc());
			    setNettotal(getNettotal());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Not Updated");
				return "fail";
			}
		}
	else if(mode.equalsIgnoreCase("D")){
			boolean Status=purorderDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
		if(Status){
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
	    	
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			setDocno(getDocno());
			setMsg("Not Deleted");
			return "fail";
		}
	
	}

	else if(mode.equalsIgnoreCase("view")){
		
		
		 
				
				
			viewobj=purorderDAO.getViewDetails(getDocno(),session);
			
			
			 
			setHidnipurchaseorderdate(viewobj.getHidnipurchaseorderdate());
			
			 
			setHiddeliverydate(viewobj.getHiddeliverydate());
			 
			setRefno(viewobj.getRefno());
			 
			setAcctypeval(viewobj.getAcctypeval());
			 
			setPuraccname(viewobj.getPuraccname());
			setCmbcurrval(viewobj.getCmbcurrval());
			setAccdocno(viewobj.getAccdocno());
			setCurrate(viewobj.getCurrate());
			  setHideproducttype(viewobj.getHideproducttype());
			  setTxtproducttype(viewobj.getTxtproducttype());
			  setTaxpers(viewobj.getTaxpers());
			setPuraccid(viewobj.getPuraccid());
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
			
			
			 
			 pintbean=purorderDAO.getPrint(doc,request,session,brhid);
			 
			 
			
			  //cl details
			 
			 
			 
			 setLblclienttrn(pintbean.getLblclienttrn());
			 setLblcomptrn(pintbean.getLblcomptrn());
			 
			          setLblprintname("NI Purchase Order");
			         setLbldate(pintbean.getLbldate());
			    	
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
		   
		   
		   setVenaddress(pintbean.getVenaddress());
		   setContactperson(pintbean.getContactperson());
		   setAmountinwords(pintbean.getAmountinwords());
		   
		   
		   setLbltaxtot(pintbean.getLbltaxtot());
		   setLbltotal(pintbean.getLbltotal());
		   setLbltotinword(pintbean.getLbltotinword());
		   setLbldiscount(pintbean.getLbldiscount());
		   setUname(pintbean.getUname());
		   setUdate(pintbean.getUdate());
		   setUtime(pintbean.getUtime());
		   
		/*   getVenaddress setContactperson getAmountinwords*/
		   
		  
		   if(commDAO.getPrintPath(dtype).contains("jrxml")==true)
		   {
			   HttpServletResponse response = ServletActionContext.getResponse();
			    
			    
			    
			    
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "NIPurchaseOrder";
				 							
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
			       // String path[]=commDAO.getPrintPath(dtype).split("nipurchaseorder/");
			        setUrl(commDAO.getPrintPath(dtype));
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/nipurchase/nipurchaseorder/" +commDAO.getPrintPath(dtype)));
	         	 
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
