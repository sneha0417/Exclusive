package com.sales.InventoryTransfer.materialrequest;

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
 
 

 

 
public class ClsMaterialrequestAction
{
	
	ClsMaterialrequestDAO saveObj =new ClsMaterialrequestDAO();
	
	ClsMaterialrequestBean bean  =new ClsMaterialrequestBean();
    private String masterdate, hidmasterdate,  txtlocation,itemname,clientname,site,refno , msg, mode ,deleted, formdetailcode, purdesc,editdata;
    private int txtlocationid, type, cldocno ,docno, siteid ,masterdoc_no,serviecGridlength, hideitemtype, hidetype,itemdocno,itemtype,costtr_no;
    
    private double productTotal; 
                   
       
	 public String  lbldate ,lbltype, lblrefno ,lbldocno,  lblprjname ,lblclname ,lblsite, lbldesc1;
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1;

	public ClsMaterialrequestDAO getSaveObj() {
			return saveObj;
		}
		public void setSaveObj(ClsMaterialrequestDAO saveObj) {
			this.saveObj = saveObj;
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
		public String getLblprjname() {
			return lblprjname;
		}
		public void setLblprjname(String lblprjname) {
			this.lblprjname = lblprjname;
		}
		public String getLblclname() {
			return lblclname;
		}
		public void setLblclname(String lblclname) {
			this.lblclname = lblclname;
		}
		public String getLblsite() {
			return lblsite;
		}
		public void setLblsite(String lblsite) {
			this.lblsite = lblsite;
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


	public String getEditdata() {
		return editdata;
	}


	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}


	public int getCosttr_no() {
		return costtr_no;
	}


	public void setCosttr_no(int costtr_no) {   
		this.costtr_no = costtr_no;
	}


	public int getType() {
		return type;
	}


	public void setType(int type) {
		this.type = type;
	}


	public int getHideitemtype() {
		return hideitemtype;
	}


	public void setHideitemtype(int hideitemtype) {       
		this.hideitemtype = hideitemtype;
	}


	public int getHidetype() {
		return hidetype;
	}


	public void setHidetype(int hidetype) {
		this.hidetype = hidetype;
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

 
	public String getItemname() {
		return itemname;
	}

 
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

 
	public String getClientname() {
		return clientname;
	}
 

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}


 
	public String getSite() {
		return site;
	}

 
	public void setSite(String site) {
		this.site = site;
	}
 
	public String getRefno() {
		return refno;
	}
 
	public void setRefno(String refno) {
		this.refno = refno;
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





	public String getPurdesc() {
		return purdesc;
	}





	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
	}





	public int getTxtlocationid() {
		return txtlocationid;
	}





	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}





	public int getCldocno() {
		return cldocno;
	}





	public void setCldocno(int cldocno) { 
		this.cldocno = cldocno;
	}





	public int getDocno() {
		return docno;
	}





	public void setDocno(int docno) {
		this.docno = docno;
	}





	public int getSiteid() {
		return siteid;
	}





	public void setSiteid(int siteid) {
		this.siteid = siteid;
	}





	public int getMasterdoc_no() {
		return masterdoc_no;
	}





	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}





	public double getProductTotal() {
		return productTotal;
	}





	public void setProductTotal(double productTotal) {
		this.productTotal = productTotal;
	}


	public int getServiecGridlength() {
		return serviecGridlength;
	}


	public void setServiecGridlength(int serviecGridlength) {
		this.serviecGridlength = serviecGridlength;
	}

private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	private String url;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}


	ClsCommon ClsCommon=new ClsCommon();
	ClsCommon com=new ClsCommon();


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

 
 
if(mode.equalsIgnoreCase("A")){
	java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
 
	
 
	
	ArrayList<String> masterarray= new ArrayList<>();
	
	//System.out.println("=====1=="+getServiecGridlength());
	
	for(int i=0;i<getServiecGridlength();i++){
		
	 
		String temp2=requestParams.get("sertest"+i)[0];
	 
	
		masterarray.add(temp2);
		 
	}    
	// getHideitemtype getHidetype getItemdocno getItemtype setType   getMasterdate getHidmasterdate
	int val=saveObj.insert(masterdate,getRefno(),getPurdesc(),getProductTotal(),session,getMode(),getFormdetailcode(),request, 
			masterarray,getTxtlocationid(),getCldocno(),getSiteid(),getType(),getItemtype(),getCosttr_no());
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0)
	{
		 setDocno(vdocno);
	 	setMasterdoc_no(val);
	 	setHidmasterdate(masterdate.toString());
	 	 setRefno(getRefno());
	 	  setTxtlocation(getTxtlocation());
			 
			 setTxtlocationid(getTxtlocationid());
			 
	 	
	 	setHideitemtype(getItemtype());
	 	
	 	setCosttr_no(getCosttr_no());
	 	setHidetype(getType());
	 	
	 	setItemname(getItemname());
	 	
	 	setItemdocno(getItemdocno());
	    
		   
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());
 
		 
	 
		 
	 
		 
		setMsg("Successfully Saved");
		return "success";
		
	}
	else
	{
		 
		 setDocno(vdocno);
	 	setMasterdoc_no(val);
	 	setHidmasterdate(masterdate.toString());
	 	 setRefno(getRefno());
	 	  setTxtlocation(getTxtlocation());
			 
			 setTxtlocationid(getTxtlocationid());
			 
	 	
	 	setHideitemtype(getItemtype());
	 	
	 	
	 	setHidetype(getType());
	 	
	 	setItemname(getItemname());
	 	
	 	setItemdocno(getItemdocno());
	    
		   
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

		 
	 
		 
	 
		setMsg("Not Saved");
		return "fail";
		
	}
	

	
	
	
	
}

if(mode.equalsIgnoreCase("E")){
	java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());

	

	
	ArrayList<String> masterarray= new ArrayList<>();
	
	//System.out.println("=====1=="+getServiecGridlength());
	
	for(int i=0;i<getServiecGridlength();i++){
		
	 
		String temp2=requestParams.get("sertest"+i)[0];
	 
	
		masterarray.add(temp2);
		 
	}    
	 
	int val=saveObj.update(masterdate,getRefno(),getPurdesc(),getProductTotal(),session,getMode(),getFormdetailcode(),request, 
			masterarray,getTxtlocationid(),getCldocno(),getSiteid(),getType(),getItemtype(),getCosttr_no(),getMasterdoc_no(),getEditdata());
 
	if(val>0)
	{
		 setDocno(getDocno());
	 	setMasterdoc_no(getMasterdoc_no());
	 	setHidmasterdate(masterdate.toString());
	 	 setRefno(getRefno());
	 	  setTxtlocation(getTxtlocation());
			 
			 setTxtlocationid(getTxtlocationid());
			 
	 	
	 	setHideitemtype(getItemtype());
	 	
	 	setCosttr_no(getCosttr_no());
	 	setHidetype(getType());
	 	
	 	setItemname(getItemname());
	 	
	 	setItemdocno(getItemdocno());
	    
		   
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

		 
	 
		 
				setMsg("Updated Successfully");
				return "success";
		
	}
	else
	{
		 
		 setDocno(getDocno());
		 	setMasterdoc_no(getMasterdoc_no());
	 	setHidmasterdate(masterdate.toString());
	 	 setRefno(getRefno());
	 	  setTxtlocation(getTxtlocation());
			 
			 setTxtlocationid(getTxtlocationid());
			 
	 	
	 	setHideitemtype(getItemtype());
	 	
	 	
	 	setHidetype(getType());
	 	
	 	setItemname(getItemname());
	 	
	 	setItemdocno(getItemdocno());
	    
		   
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

		 
	 
		 
	 
				setMsg("Not Updated");
				return "fail";
		
	}
	

	
	
	
	
}
else if(mode.equalsIgnoreCase("view")){
	
 
		
	ClsMaterialrequestBean	viewObj=new ClsMaterialrequestBean();
	ClsMaterialrequestDAO	viewObj1=new ClsMaterialrequestDAO();
	
		viewObj=viewObj1.getViewDetails(getMasterdoc_no());
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(getMasterdoc_no());
 
	
		setHidmasterdate(viewObj.getMasterdate());
 
 
		setPurdesc(viewObj.getPurdesc());
 
		setRefno(viewObj.getRefno());
 
		 
 
		
		 setTxtlocation(viewObj.getTxtlocation());
		
		 setTxtlocationid(viewObj.getTxtlocationid());
		
		 
		 
		//duwn
			 setHidetype(viewObj.getType());
		     setHideitemtype(viewObj.getItemtype());
		 	
			 setItemname(viewObj.getItemname());
		 	
			 setItemdocno(viewObj.getItemdocno());
		    
			   
			 setCldocno(viewObj.getCldocno());
		    
			 setClientname(viewObj.getClientname());
		    
			 setSite(viewObj.getSite());
			    
			 setSiteid(viewObj.getSiteid());
		    
			 setCosttr_no(viewObj.getCosttr_no());
		
		
         return "success";
		
	}
		
		
	
 

return "fail";

	
	}

	
	public String printAction() throws ParseException, SQLException{
		
		
		
		 
		  HttpServletRequest request=ServletActionContext.getRequest();
HttpSession session=request.getSession();
HttpServletResponse response = ServletActionContext.getResponse();		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		  String dtype=request.getParameter("dtype").toString();
		 ClsMaterialrequestDAO ClsMaterialrequestDAO=new ClsMaterialrequestDAO();
		
		 bean=saveObj.getPrint(doc,request);
	  
		 
		
		  //cl details
		 
		    setLblprintname("Material Request");
		    setLbldocno(bean.getLbldocno());
		    setLbldate(bean.getLbldate());
		     setLblrefno(bean.getLblrefno());
		     setLbldesc1(bean.getLbldesc1());
		     setLbltype(bean.getLbltype());
 
	 
		     setLblprjname(bean.getLblprjname());
		     setLblclname(bean.getLblclname());
		     setLblsite(bean.getLblsite());
	    	     
		     
					
	 
				   setLblbranch(bean.getLblbranch());
				   setLblcompname(bean.getLblcompname());
				  
				   setLblcompaddress(bean.getLblcompaddress());
				   setLblcomptel(bean.getLblcomptel());
				   setLblcompfax(bean.getLblcompfax());
				   setLbllocation(bean.getLbllocation());
				  
	 
				   
				   
				   setLbllocation1(bean.getLbllocation1());
				     String path=com.getPrintPath(dtype);
				        setUrl(path);
		
		 if(com.getPrintPath(dtype).contains(".jrxml")==true)
   		{
	    
	    ClsConnection conobj=new ClsConnection();	 
		 param = new HashMap();
		 Connection conn = null;
		 
		 String reportFileName = "Material Request";
		 try {
	            
                    
              conn = conobj.getMyConnection();

	           					
	         String productQuery="select @i:=@i+1 as srno,a.* from (Select d.specno specid ,m.part_no productid, "
	         		+ "	m.productname, u.unit,round(sum(d.qty),2) qty, round(d.amount,2) amount,round(d.total,2) total, "
	         		+ " round(d.discount,2) discount,round(d.nettotal,2) nettotal , "
	         		+ " round(d.disper,2) disper    from my_gisd  d  left join my_main m on m.doc_no=d.prdId "
	         		+ "	left join my_unitm u on d.unitid=u.doc_no where d.rdocno="+doc+" group by d.psrno) a,(select @i:=0) r"; 
	         param.put("productQuery",productQuery);
	         
	         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	        	imgpath=imgpath.replace("\\", "\\\\");    
	          param.put("imghedderpath", imgpath);
	          
	          
	          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        	imgpath2=imgpath2.replace("\\", "\\\\");    
	          param.put("imgfooterpath", imgpath2);
	          
	          param.put("refname", bean.getRefname());
	          param.put("costdocno", bean.getCostdoc());
	      
	          param.put("conperson", bean.getContperson());
	        
	          param.put("mob", bean.getMob());
	       
	          param.put("docno",doc);
	          param.put("date", bean.getDate());
	          param.put("locname", bean.getLoc_name());
	          param.put("flname", bean.getFlname());
	          param.put("desc", bean.getDesc());
	          
	          //fire7
	           String fire7imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7fullheader.jpg");
	           fire7imgpath=fire7imgpath.replace("\\", "\\\\");
	           param.put("fire7fullheadderpath", fire7imgpath);

	            path=com.getPrintPath(dtype);
		        setUrl(path);
		       System.out.println("print==========="+path);
         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/sales and marketing/Inventory Transfer/goodsissuenote/"+com.getPrintPath(dtype)));
                 
	          //com/sales and marketing/Inventory Transfer/goodsissuenote/GoodsIssueNote.jrxml
	          
	          
       //  JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/sales and marketing/Inventory Transfer/goodsissuenote/" + reportFileName + ".jrxml"));
     	 
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
