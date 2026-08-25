package com.procurement.purchase.purchaserequest;

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
import com.procurement.purchase.purchaseorder.ClspurchaseorderBean;
import com.procurement.purchase.purchaseorder.ClspurchaseorderDAO;
public class ClsPurchaserequestAction {

	
	ClsCommon ClsCommon=new ClsCommon();
	ClsPurchaserequestDAO daos=new ClsPurchaserequestDAO();
	ClsPurchaserequestBean Beans=new ClsPurchaserequestBean();
	
		ClsPurchaserequestBean viewObj = new ClsPurchaserequestBean();
		ClsPurchaserequestDAO saveObj = new ClsPurchaserequestDAO();
	
	
 private int reqgridlenght,masterdoc_no,docno;
 
 private String reqmasterdate,hidreqmasterdate,refno,purdesc,mode,deleted,msg,formdetailcode;

 private String url;
 
 
 private int  hideitemtype, itemdocno,itemtype,costtr_no;
 
 private String itemname;
 
 
 
public String getItemname() {
	return itemname;
}

public void setItemname(String itemname) {
	this.itemname = itemname;
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

public int getDocno() {
	return docno;
}

public void setDocno(int docno) {
	this.docno = docno;
}

 
public int getReqgridlenght() {
	return reqgridlenght;
}

public void setReqgridlenght(int reqgridlenght) {
	this.reqgridlenght = reqgridlenght;
}

public String getReqmasterdate() {
	return reqmasterdate;
}

public void setReqmasterdate(String reqmasterdate) {
	this.reqmasterdate = reqmasterdate;
}

public String getHidreqmasterdate() {
	return hidreqmasterdate;
}

public void setHidreqmasterdate(String hidreqmasterdate) {
	this.hidreqmasterdate = hidreqmasterdate;
}

public String getRefno() {
	return refno;
}

public void setRefno(String refno) {
	this.refno = refno;
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
	
	///print


private String lbldate,lblrefno,lbldesc1;

private int lbldoc;

private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,tinno;	


	
	
				
			public String getTinno() {
	return tinno;
}

public void setTinno(String tinno) {
	this.tinno = tinno;
}

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
			
			public int getLbldoc() {
				return lbldoc;
			}
			
			public void setLbldoc(int lbldoc) {
				this.lbldoc = lbldoc;
			}
			
			public String getLbldesc1() {
				return lbldesc1;
			}
			
			public void setLbldesc1(String lbldesc1) {
				this.lbldesc1 = lbldesc1;
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

ClsPurchaserequestDAO savedata=new ClsPurchaserequestDAO();
	
ClsPurchaserequestBean  pintbean=new  ClsPurchaserequestBean();
	
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	
	String mode=getMode();

//System.out.println("========="+getFormdetailcode());
	//System.out.println("========="+getCmbcurr());

if(mode.equalsIgnoreCase("A")){
java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getReqmasterdate());
 
ArrayList<String> descarray= new ArrayList<>();
for(int i=0;i<getReqgridlenght();i++){
	
 
	String temp2=requestParams.get("reqtest"+i)[0];
 

	descarray.add(temp2);
	 
}



int val=savedata.insert(masterdate,getRefno(),getPurdesc(),session,getMode(),getFormdetailcode(),request,descarray,getItemtype(),getCosttr_no());
int vdocno=(int) request.getAttribute("vocno");
if(val>0)
{
	setDocno(vdocno);
	setMasterdoc_no(val);
	
	
	setHidreqmasterdate(masterdate.toString());
	 
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
 
	//duwn
	 
 	setHideitemtype(getItemtype());
 	
 	setCosttr_no(getCosttr_no());
 
 	setItemname(getItemname());
 	
 	setItemdocno(getItemdocno());
    
	
	
	 
	setMsg("Successfully Saved");
	return "success";
	
}
else
{
	
	
	setHidreqmasterdate(masterdate.toString());
	 
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
 
	 
	setHideitemtype(getItemtype());
	
	setCosttr_no(getCosttr_no());

	setItemname(getItemname());
	
	setItemdocno(getItemdocno());
	 
	
	setMsg("Not Saved");
	return "fail";
	
}






}
else if(mode.equalsIgnoreCase("E")){
java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getReqmasterdate());
 
ArrayList<String> descarray= new ArrayList<>();
for(int i=0;i<getReqgridlenght();i++){
	
 
	String temp2=requestParams.get("reqtest"+i)[0];
 

	descarray.add(temp2);
	 
}

 
int val=savedata.update(getMasterdoc_no(),masterdate,getRefno(),getPurdesc(),session,getMode(),getFormdetailcode(),request,descarray,getItemtype(),getCosttr_no());

if(val>0)
{
	setDocno(getDocno());
	setMasterdoc_no(getMasterdoc_no());
	
	
	setHidreqmasterdate(masterdate.toString());
	 
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
	 
	setHideitemtype(getItemtype());
	
	setCosttr_no(getCosttr_no());

	setItemname(getItemname());
	
	setItemdocno(getItemdocno());
	 
		setMsg("Updated Successfully");
	return "success";
	
}
else
{
	setDocno(getDocno());
	setMasterdoc_no(getMasterdoc_no());
	
	setHidreqmasterdate(masterdate.toString());
	 
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
	 
	setHideitemtype(getItemtype());
	
	setCosttr_no(getCosttr_no());

	setItemname(getItemname());
	
	setItemdocno(getItemdocno());
	
		setMsg("Not Updated");
	return "fail";
	
}


}
else if(mode.equalsIgnoreCase("D")){


int val=savedata.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);

if(val>0)
{
	
	
 
	setDocno(getDocno());
	setMasterdoc_no(getMasterdoc_no());
	 
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
     setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
}
else
{
	 
	setDocno(getDocno());
	setMasterdoc_no(getMasterdoc_no());
	setPurdesc(getPurdesc());
 
	setRefno(getRefno());
     setMsg("Not Deleted");
     return "fail";
		
}



}	

 else if(mode.equalsIgnoreCase("view")){
	
	viewObj=saveObj.getViewDetails(getDocno(),session);
	
	setDocno(viewObj.getDocno());
	setMasterdoc_no(viewObj.getMasterdoc_no());
	
	setPurdesc(viewObj.getPurdesc());
	setHidreqmasterdate(viewObj.getHidreqmasterdate());
	setRefno(viewObj.getRefno());
	
	
	 
	setHideitemtype(viewObj.getItemtype());
	
	setCosttr_no(viewObj.getCosttr_no());

	setItemname(viewObj.getItemname());
	
	setItemdocno(viewObj.getItemdocno());
	
	
	
}



return "fail";





}

public String printAction() throws ParseException, SQLException{
	
	  HttpServletRequest request=ServletActionContext.getRequest();
	 System.out.println("in action");
	 int doc=Integer.parseInt(request.getParameter("docno"));
	 String brhid=request.getParameter("brhid").toString();
	 String dtype=request.getParameter("dtype");
	 ClsPurchaserequestDAO ClsPurchaserequestDAO=new ClsPurchaserequestDAO();
	 pintbean=ClsPurchaserequestDAO.getPrint(doc,request);
	 setUrl(ClsCommon.getPrintPath(dtype));
	 
	
	  //cl details
	 
	 setLblprintname("Purchase Request");
	    setLbldoc(pintbean.getLbldoc());
	    setLbldate(pintbean.getLbldate());
	    setLblrefno(pintbean.getLblrefno());
	    setLbldesc1(pintbean.getLbldesc1());
	    
	    

	
	
	
setLblbranch(pintbean.getLblbranch());
 setLblcompname(pintbean.getLblcompname());

setLblcompaddress(pintbean.getLblcompaddress());

 setLblcomptel(pintbean.getLblcomptel());

setLblcompfax(pintbean.getLblcompfax());
 setLbllocation(pintbean.getLbllocation());
 setTinno(pintbean.getTinno());

 	if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
 		{
 		HttpSession session=request.getSession();
 	    HttpServletResponse response = ServletActionContext.getResponse();
 	   
 	   
 	 
 	 
 	   
 	    ClsConnection conobj=new ClsConnection();
 		
 		 
 		 param = new HashMap();
 		 Connection conn = null;
 		 conn = conobj.getMyConnection();
 	     
 		 //String reportFileName = "PurchaseRequest";
 		 try {
 	                              
 	         param.put("productQuery",pintbean.getPrdQry());
 	         
 	         String imgpath=request.getSession().getServletContext().getRealPath("/icons/city1header.jpg");
 	        	imgpath=imgpath.replace("\\", "\\\\");    
 	          param.put("imghedderpath", imgpath);
 	          
 	          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/city1footer.jpg");
 	        	imgpath2=imgpath2.replace("\\", "\\\\");    
 	          param.put("imgfooterpath", imgpath2);
 	          
 	        	
 	        	 String img=request.getSession().getServletContext().getRealPath("/icons/aitsheader1.jpg");
  	        	img=img.replace("\\", "\\\\");    
  	          param.put("imgheader", img);
  	          
  	          String image=request.getSession().getServletContext().getRealPath("/icons/footer.jpg");
  	        	image=image.replace("\\", "\\\\");    
  	          param.put("footer", image);
  	          
 	          
 	          param.put("docno",doc);
 	          param.put("refno", pintbean.getLblrefno());
 	          param.put("date", pintbean.getLbldate());          
 	          param.put("desc", pintbean.getLbldesc1());
 	          param.put("compname",pintbean.getLblcompname());
 	          param.put("address",pintbean.getLblcompaddress());
 	          param.put("telno",pintbean.getLblcomptel());
 	          param.put("trnno",pintbean.getTinno());
 	          
 	         
 	       //   System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
 	        setUrl(ClsCommon.getPrintPath(dtype));
 	        
 	     JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/Procurement/Purchase/purchaserequest/"+ClsCommon.getPrintPath(dtype)));
 	 	 
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
	
/*public String printAction() throws ParseException, SQLException{
		
	  HttpServletRequest request=ServletActionContext.getRequest();
	 
	 int doc=Integer.parseInt(request.getParameter("docno"));
	 
	 ClsPurchaserequestDAO ClsPurchaserequestDAO=new ClsPurchaserequestDAO();
	 pintbean=ClsPurchaserequestDAO.getPrint(doc,request);
  
	 
	
	  //cl details
	 
	 setLblprintname("Purchase Request");
	    setLbldoc(pintbean.getLbldoc());
	    setLbldate(pintbean.getLbldate());
	    setLblrefno(pintbean.getLblrefno());
	    setLbldesc1(pintbean.getLbldesc1());
	    
	    
 
	
	
	
  setLblbranch(pintbean.getLblbranch());
   setLblcompname(pintbean.getLblcompname());
  
  setLblcompaddress(pintbean.getLblcompaddress());
 
   setLblcomptel(pintbean.getLblcomptel());
  
  setLblcompfax(pintbean.getLblcompfax());
   setLbllocation(pintbean.getLbllocation());
  

	   
	 return "print";
	 }	
	
	
	*/
}
