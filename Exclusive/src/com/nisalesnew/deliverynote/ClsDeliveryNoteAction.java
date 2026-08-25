package com.nisalesnew.deliverynote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
 
 

public class ClsDeliveryNoteAction {
	private int itemtype,itemdocno,docno,accid,costtr_no,hideitemtype,gridlenght,masterdoc_no,salid,acno,currsid,rrefno,masterrrefno;
	private String  date,itemname,salesmanname ,acctype,accname,currs,fixDate,lpono,deliveryDate,deliveryTime,remarks,formdetailcode;
	private String  hideacctype,hiddate, hidfixDate,hiddeliveryDate,hiddeliveryTime,mode,deleted,msg,rreftypeval,rreftype;
	
	
private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	
	
	private String lblBuye,lblTel,lblFax,lblRemarks,lblProject,lblOrderNO,lblDate,lblPoNo,lblSalseman,lblDeliveryDate,lblFixingDate,lbladdresscl,lbldocNO,lbltrnno,lblcltrno;
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	private int logo;
	private String url;
	private String dlyqry;
	
	
	 public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDlyqry() {
		return dlyqry;
	}
	public void setDlyqry(String dlyqry) {
		this.dlyqry = dlyqry;
	}
	public int getLogo() {
		return logo;
	}


	public void setLogo(int logo) {
		this.logo = logo;
	}


	public String getLbltrnno() {
		return lbltrnno;
	}


	public void setLbltrnno(String lbltrnno) {
		this.lbltrnno = lbltrnno;
	}


	public String getLblcltrno() {
		return lblcltrno;
	}
	
	 public void setLblcltrno(String lblcltrno) {
		this.lblcltrno = lblcltrno;
	}

	private double ratess;
	 
	 
	 public int getCurrsid() {
		return currsid;
	}


	public void setCurrsid(int currsid) {
		this.currsid = currsid;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	public int getSalid() {
		return salid;
	}


	public void setSalid(int salid) {
		this.salid = salid;
	}


	public int getAcno() {
		return acno;
	}


	public void setAcno(int acno) {
		this.acno = acno;
	}


	public int getItemtype() {
		return itemtype;
	}


	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}


	public int getItemdocno() {
		return itemdocno;
	}


	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}


	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	public int getAccid() {
		return accid;
	}


	public void setAccid(int accid) {
		this.accid = accid;
	}


	public int getCosttr_no() {
		return costtr_no;
	}


	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}


	public int getHideitemtype() {
		return hideitemtype;
	}


	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}


	public int getGridlenght() {
		return gridlenght;
	}


	public void setGridlenght(int gridlenght) {
		this.gridlenght = gridlenght;
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


	public String getItemname() {
		return itemname;
	}


	public void setItemname(String itemname) {
		this.itemname = itemname;
	}


	public String getSalesmanname() {
		return salesmanname;
	}


	public void setSalesmanname(String salesmanname) {
		this.salesmanname = salesmanname;
	}


	public String getAcctype() {
		return acctype;
	}


	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}


	public String getAccname() {
		return accname;
	}


	public void setAccname(String accname) {
		this.accname = accname;
	}


	public String getCurrs() {
		return currs;
	}


	public void setCurrs(String currs) {
		this.currs = currs;
	}


	public String getFixDate() {
		return fixDate;
	}


	public void setFixDate(String fixDate) {
		this.fixDate = fixDate;
	}


	public String getLpono() {
		return lpono;
	}


	public void setLpono(String lpono) {
		this.lpono = lpono;
	}


	public String getDeliveryDate() {
		return deliveryDate;
	}


	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}


	public String getDeliveryTime() {
		return deliveryTime;
	}


	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}


	public String getRemarks() {
		return remarks;
	}


	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	public String getHideacctype() {
		return hideacctype;
	}


	public void setHideacctype(String hideacctype) {
		this.hideacctype = hideacctype;
	}


	public String getHiddate() {
		return hiddate;
	}


	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}


	public String getHidfixDate() {
		return hidfixDate;
	}


	public void setHidfixDate(String hidfixDate) {
		this.hidfixDate = hidfixDate;
	}


	public String getHiddeliveryDate() {
		return hiddeliveryDate;
	}


	public void setHiddeliveryDate(String hiddeliveryDate) {
		this.hiddeliveryDate = hiddeliveryDate;
	}


	public String getHiddeliveryTime() {
		return hiddeliveryTime;
	}


	public void setHiddeliveryTime(String hiddeliveryTime) {
		this.hiddeliveryTime = hiddeliveryTime;
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


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
	}


	public double getRatess() {
		return ratess;
	}


	public void setRatess(double ratess) {
		this.ratess = ratess;
	}


	public int getRrefno() {
		return rrefno;
	}


	public void setRrefno(int rrefno) {
		this.rrefno = rrefno;
	}


	public int getMasterrrefno() {
		return masterrrefno;
	}


	public void setMasterrrefno(int masterrrefno) {
		this.masterrrefno = masterrrefno;
	}


	public String getRreftypeval() {
		return rreftypeval;
	}


	public void setRreftypeval(String rreftypeval) {
		this.rreftypeval = rreftypeval;
	}


	public String getRreftype() {
		return rreftype;
	}


	public void setRreftype(String rreftype) {
		this.rreftype = rreftype;
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


	public String getLblBuye() {
		return lblBuye;
	}


	public void setLblBuye(String lblBuye) {
		this.lblBuye = lblBuye;
	}


	public String getLblTel() {
		return lblTel;
	}


	public void setLblTel(String lblTel) {
		this.lblTel = lblTel;
	}


	public String getLblFax() {
		return lblFax;
	}


	public void setLblFax(String lblFax) {
		this.lblFax = lblFax;
	}


	public String getLblRemarks() {
		return lblRemarks;
	}


	public void setLblRemarks(String lblRemarks) {
		this.lblRemarks = lblRemarks;
	}


	public String getLblProject() {
		return lblProject;
	}


	public void setLblProject(String lblProject) {
		this.lblProject = lblProject;
	}


	public String getLblOrderNO() {
		return lblOrderNO;
	}


	public void setLblOrderNO(String lblOrderNO) {
		this.lblOrderNO = lblOrderNO;
	}


	public String getLblDate() {
		return lblDate;
	}


	public void setLblDate(String lblDate) {
		this.lblDate = lblDate;
	}


	public String getLblPoNo() {
		return lblPoNo;
	}


	public void setLblPoNo(String lblPoNo) {
		this.lblPoNo = lblPoNo;
	}


	public String getLblSalseman() {
		return lblSalseman;
	}


	public void setLblSalseman(String lblSalseman) {
		this.lblSalseman = lblSalseman;
	}


	public String getLblDeliveryDate() {
		return lblDeliveryDate;
	}


	public void setLblDeliveryDate(String lblDeliveryDate) {
		this.lblDeliveryDate = lblDeliveryDate;
	}


	public String getLblFixingDate() {
		return lblFixingDate;
	}


	public void setLblFixingDate(String lblFixingDate) {
		this.lblFixingDate = lblFixingDate;
	}


	public String getLbladdresscl() {
		return lbladdresscl;
	}


	public void setLbladdresscl(String lbladdresscl) {
		this.lbladdresscl = lbladdresscl;
	}


	public String getLbldocNO() {
		return lbldocNO;
	}


	public void setLbldocNO(String lbldocNO) {
		this.lbldocNO = lbldocNO;
	}


	public String saveAction () throws IOException,SQLException,NullPointerException
	 {
		ClsCommon ClsCommon=new ClsCommon();
		 ClsDeliveryNoteDAO ClsDeliveryNoteDAO=new ClsDeliveryNoteDAO();
		 ClsDeliveryNoteBean ClsDeliveryNoteBean= new ClsDeliveryNoteBean();
		 
	 
		 
		 if(mode.equalsIgnoreCase("A"))
		 {
			 HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				Map<String, String[]> requestParams = request.getParameterMap();
				
				java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
				java.sql.Date fixdate = ClsCommon.changeStringtoSqlDate(getFixDate());
				java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliveryDate());
				 
				ArrayList<String> descarray= new ArrayList<>();
				for(int i=0;i<getGridlenght();i++){
					String temp2=requestParams.get("test"+i)[0];
					descarray.add(temp2);
				}
				
				

				
				
			int val=ClsDeliveryNoteDAO.insert(descarray,masterdate,deldate,getDeliveryTime(),fixdate,getItemtype(),getCosttr_no(),getSalid(),
					getAcno(),getLpono(),getRemarks(),session,request,getFormdetailcode(),getMode(),getCurrsid(),getRatess(),getMasterrrefno(),getRreftype());
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0)
			{
				setdata(val,vdocno,masterdate,fixdate,deldate);
				setMsg("Successfully Saved");
				return "success";
				
			}
			else
			{
				setdata(val,vdocno,masterdate,fixdate,deldate);
				setMsg("Not Saved");
				 return "fail";
			}

			 
		 }
		 else if(mode.equalsIgnoreCase("E"))
		 {
			 HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				Map<String, String[]> requestParams = request.getParameterMap();
				
				java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
				java.sql.Date fixdate = ClsCommon.changeStringtoSqlDate(getFixDate());
				java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliveryDate());
				 
				ArrayList<String> descarray= new ArrayList<>();
				for(int i=0;i<getGridlenght();i++){
					String temp2=requestParams.get("test"+i)[0];
					descarray.add(temp2);
				}
				
				

			int val=ClsDeliveryNoteDAO.update(descarray,masterdate,deldate,getDeliveryTime(),fixdate,getItemtype(),getCosttr_no(),getSalid(),
					getAcno(),getLpono(),getRemarks(),session,request,getFormdetailcode(),getMode(),getCurrsid(),getRatess(),getMasterdoc_no(),getMasterrrefno(),getRreftype());
			 
			if(val>0)
			{
				setdata(getMasterdoc_no(),getDocno(),masterdate,fixdate,deldate);
				setMsg("Updated Successfully");
				return "success";
				
			}
			else
			{
				setdata(getMasterdoc_no(),getDocno(),masterdate,fixdate,deldate);
				setMsg("Not Updated");
				return "fail";
			}

			 
		 }
		 
		 
		 else if(mode.equalsIgnoreCase("D"))
		 {
			 HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				 
				
				java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
				java.sql.Date fixdate = ClsCommon.changeStringtoSqlDate(getFixDate());
				java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliveryDate());
				 
				ArrayList<String> descarray= new ArrayList<>();
				 
				
				

			int val=ClsDeliveryNoteDAO.delete(descarray,masterdate,deldate,getDeliveryTime(),fixdate,getItemtype(),getCosttr_no(),getSalid(),
					getAcno(),getLpono(),getRemarks(),session,request,getFormdetailcode(),getMode(),getCurrsid(),getRatess(),getMasterdoc_no());
			 
			if(val>0)
			{
				setdata(getMasterdoc_no(),getDocno(),masterdate,fixdate,deldate);
				  setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
			}
			else
			{
				setdata(getMasterdoc_no(),getDocno(),masterdate,fixdate,deldate);
				 setMsg("Not Deleted");
				return "fail";
			}

			 
		 }
		 
		 
		 
		 else if(mode.equalsIgnoreCase("view"))
		 {
			 
			 
			 HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				ClsDeliveryNoteBean setbean=new ClsDeliveryNoteBean();
				setbean=ClsDeliveryNoteDAO.getviewDetails(session,getDocno());
				
				 
				
				 setMasterdoc_no(setbean.getMasterdoc_no());
				 setDocno(getDocno());
				 
				setHiddate(setbean.getHiddate());
				setHiddeliveryDate(setbean.getHiddeliveryDate());
				setHiddeliveryTime(setbean.getHiddeliveryTime());
				setHidfixDate(setbean.getHidfixDate());
				
				
		 
				
				
				setMasterrrefno(setbean.getMasterrrefno());
				 
				setRrefno(setbean.getRrefno());
				setRreftypeval(setbean.getRreftypeval());
				
				setHideitemtype(setbean.getHideitemtype());
				setItemdocno(setbean.getItemdocno());
				setItemname(setbean.getItemname());
				setCosttr_no(setbean.getCosttr_no());
				
				
				setSalid(setbean.getSalid());
				setSalesmanname(setbean.getSalesmanname());
				
				setLpono(setbean.getLpono());
				
				
				setAccid(setbean.getAccid());
				setAcno(setbean.getAcno());
				setAccname(setbean.getAccname());
				setHideacctype(setbean.getAcctype());
				
				setCurrs(setbean.getCurrs());
				setCurrsid(setbean.getCurrsid());
				setRatess(setbean.getRatess());
				
				setRemarks(setbean.getRemarks());
				
				
				
				
				
				 
			 
		 }
		 
		 
		 
		 
		 return "fail";
	 }
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		  HttpSession session=request.getSession();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 int logo=Integer.parseInt(request.getParameter("logo"));
		 String dtype=request.getParameter("dtype");
		 
		 ClsCommon common=new ClsCommon();
		 ClsDeliveryNoteDAO ClsDeliveryNoteDAO=new ClsDeliveryNoteDAO();
		 ClsDeliveryNoteBean pintbean= new ClsDeliveryNoteBean();
		 
	 
		 pintbean=ClsDeliveryNoteDAO.getPrint(doc,request);
	  
		 
		
		 
		   setLogo(logo);
		   setLblprintname("Delivery Note");
		   setLbldocNO(pintbean.getLbldocNO());
		   setLblOrderNO(pintbean.getLblOrderNO());
  	   setLblDate(pintbean.getLblDate());
  	   setLblDeliveryDate(pintbean.getLblDeliveryDate());
  	   setLblFixingDate(pintbean.getLblFixingDate());
  	   setLblBuye(pintbean.getLblBuye());
  	   setLbladdresscl(pintbean.getLbladdresscl());
  	   setLblTel(pintbean.getLblTel());
  	   setLblFax(pintbean.getLblFax());
  	   setLblRemarks(pintbean.getLblRemarks());  
  	   setLblProject(pintbean.getLblProject());
  	   setLblPoNo(pintbean.getLblPoNo()); 
  	   setLblSalseman(pintbean.getLblSalseman()); 

				   setLblbranch(pintbean.getLblbranch());
				   setLblcompname(pintbean.getLblcompname());
				  
				   setLblcompaddress(pintbean.getLblcompaddress());
				   setLblcomptel(pintbean.getLblcomptel());
				   setLblcompfax(pintbean.getLblcompfax());
				   setLbllocation(pintbean.getLbllocation());
				  

				   setLblcltrno(pintbean.getLblcltrno());
		    	    
		    	    setLbltrnno(pintbean.getLbltrnno());
		    	  
				   
		    	    if(common.getPrintPath(dtype).contains(".jrxml")==true)
					{				   
						  
	        	  // System.out.println("iside jrxml");
	        	   ClsConnection conobj=new ClsConnection();
												 
	        	   param = new HashMap();
	        	   Connection conn = null;
	        	   conn = conobj.getMyConnection();	        	   
	        	   String reportFileName = common.getPrintPath(dtype);
	        	   try {
	        		   
	        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	        		   imgpath=imgpath.replace("\\", "\\\\");    
	        		   param.put("complogo", imgpath);
	        		   param.put("dlyqry", pintbean.getDlyqry());
	        		   
	        		   param.put("compname", pintbean.getLblcompname());
	        		   param.put("compaddress", pintbean.getLblcompaddress());
	        		   param.put("comptel", pintbean.getLblcomptel());
	        		   param.put("compfax", pintbean.getLblcompfax());
	        		   param.put("comptrno", pintbean.getLbltrnno());
	        		   param.put("logo", logo);
	        		   param.put("buyer", pintbean.getLblBuye());
	        		   param.put("cltrno", pintbean.getLblcltrno());
	        		   param.put("claddress", pintbean.getLbladdresscl());
	        		   param.put("cltel", pintbean.getLblTel());
	        		   param.put("clfax", pintbean.getLblFax());
	        		   param.put("clremarks", pintbean.getLblRemarks());
	        		   param.put("dnno", pintbean.getLbldocNO());
	        		   param.put("dlydate", pintbean.getLblDate());
	        		   param.put("pono", pintbean.getLblPoNo());
	        		   param.put("orderno", pintbean.getLblOrderNO());
	        		   param.put("deldate", pintbean.getLblDeliveryDate());
	        		   
	        		   
	        		   param.put("preparedby", session.getAttribute("USERNAME"));
	        		   
	        		   //param.put("complogo", pintbean.getLblcompname()); reportFileName
	        		   
	        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));	      	     	 
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
	
	public void setdata(int docno,int vocno,Date mdate,Date fdate,Date ddate)
	{
		
		 
		
		setMasterdoc_no(docno);
		setDocno(vocno);
		
		setHiddate(mdate.toString());
		setHiddeliveryDate(ddate.toString());
		setHidfixDate(fdate.toString());
		setHiddeliveryTime(getDeliveryTime());
		
		setItemdocno(getItemdocno());
		setCosttr_no(getCosttr_no());
		setItemname(getItemname());
		setHideitemtype(getItemtype());
		
		setSalesmanname(getSalesmanname());
		setSalid(getSalid());
		
		setHideacctype(getAcctype());
		setAccname(getAccname());
		setAccid(getAccid());
		setAcno(getAcno());
		setCurrs(getCurrs());
		setCurrsid(getCurrsid());
		setRatess(getRatess());
		
		setMasterrrefno(getMasterrrefno());
	 
		setRrefno(getRrefno());
		setRreftypeval(getRreftype());
		
		setLpono(getLpono());
		setRemarks(getRemarks());
		
		
		
		
	}
	
}
