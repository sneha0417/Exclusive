 package com.sales.InventoryTransfer.goodsissuenotereturn;

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
import com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteBean;
import com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO;

 
public class ClsGoodsissuenotereturnAction
{
	
	ClsGoodsissuenotereturnDAO saveObj =new ClsGoodsissuenotereturnDAO();
	ClsCommon com=new ClsCommon();
    private String masterdate, hidmasterdate,  txtlocation,itemname,clientname,site,refno , msg, mode ,deleted, formdetailcode, purdesc,editdata,reftype,reftypeval;
  

	private int txtlocationid, type, cldocno ,docno, siteid ,masterdoc_no,serviecGridlength, hideitemtype, hidetype,itemdocno,itemtype,costtr_no,rrefno,refmasterdoc_no;
    
    private double productTotal;
                   
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


	public int getRrefno() {                   
		return rrefno;
	}


	public void setRrefno(int rrefno) { 
		this.rrefno = rrefno;
	}


	public int getRefmasterdoc_no() {
		return refmasterdoc_no;
	}


	public void setRefmasterdoc_no(int refmasterdoc_no) {
		this.refmasterdoc_no = refmasterdoc_no;
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
			masterarray,getTxtlocationid(),getCldocno(),getSiteid(),getType(),getItemtype(),getCosttr_no(),getReftype(),getRefmasterdoc_no());
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
		    setReftype(getReftype()) ;
		    setRrefno(getRrefno());
		    setRefmasterdoc_no(getRefmasterdoc_no()) ;
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());
 
			 
			 setReftypeval(getReftype());
			 
			 setRrefno(getRrefno());
			 setRefmasterdoc_no(getRefmasterdoc_no());
	 
		 
	 
		 
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
	    
	    setReftype(getReftype()) ;
	    setRrefno(getRrefno());
	    setRefmasterdoc_no(getRefmasterdoc_no()) ;
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

			 
			 setReftypeval(getReftype());
			 
			 setRrefno(getRrefno());
			 setRefmasterdoc_no(getRefmasterdoc_no());
	 
		 
	 
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
	// getHideitemtype getHidetype getItemdocno getItemtype setType   getMasterdate getHidmasterdate
	int val=saveObj.update(masterdate,getRefno(),getPurdesc(),getProductTotal(),session,getMode(),getFormdetailcode(),request, 
			masterarray,getTxtlocationid(),getCldocno(),getSiteid(),getType(),getItemtype(),getCosttr_no(),getMasterdoc_no(),
			getEditdata(),getReftype(),getRefmasterdoc_no(),getDocno());
 
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
	    
	    setReftype(getReftype()) ;
	    setRrefno(getRrefno());
	    setRefmasterdoc_no(getRefmasterdoc_no()) ;
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

		 
			 setReftypeval(getReftype());
			 
			 setRrefno(getRrefno());
			 setRefmasterdoc_no(getRefmasterdoc_no());
		 
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
	 	
	    setReftype(getReftype()) ;
	    setRrefno(getRrefno());
	    setRefmasterdoc_no(getRefmasterdoc_no()) ;
	 	setHidetype(getType());
	 	
	 	setItemname(getItemname());
	 	
	 	setItemdocno(getItemdocno());
	    
		   
	    setCldocno(getCldocno());
	    
	    setClientname(getClientname());
	    
	 	 setSite(getSite());
		    
		    setSiteid(getSiteid());
	    
	    
			 setProductTotal(getProductTotal());
			 setPurdesc(getPurdesc());

		 
	 
			 
			 setReftypeval(getReftype());
			 
			 setRrefno(getRrefno());
			 setRefmasterdoc_no(getRefmasterdoc_no());
	 
				setMsg("Not Updated");
				return "fail";
		
	}
	

	
	
	
	
}
else if(mode.equalsIgnoreCase("view")){
	
 
		
	ClsGoodsissuenotereturnBean	viewObj=new ClsGoodsissuenotereturnBean();
	ClsGoodsissuenotereturnDAO	viewObj1=new ClsGoodsissuenotereturnDAO();
	
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
			 setReftypeval(viewObj.getReftype());
			 setRrefno(viewObj.getRrefno());
			 setRefmasterdoc_no(viewObj.getRefmasterdoc_no());
	 
		
         return "success";
		
	}
		
		
	
 

return "fail";

	
	}

		
	public String printAction() throws ParseException, SQLException{
		 System.out.println("dtype= pppppppppppppppp=");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    
	    int doc=Integer.parseInt(request.getParameter("docno"));
	    System.out.println("doc=="+doc);
	//    String brhid=request.getParameter("brhid").toString();
	    String dtype=request.getParameter("dtype").toString();
	    System.out.println("dtype=="+dtype);
	    ClsGoodsissuenotereturnDAO clsGIRDAO=new ClsGoodsissuenotereturnDAO();
	    ClsGoodsissuenotereturnBean bean = new ClsGoodsissuenotereturnBean();
	    bean=clsGIRDAO.getPrint(doc,request);

			    
	   
		 
	    if(com.getPrintPath(dtype).contains(".jrxml")==true)
   		{
	    
	    ClsConnection conobj=new ClsConnection();	 
		 param = new HashMap();
		 Connection conn = null;
		 
		 String reportFileName = "GoodsIssueNoteReturn";
		 try {
	            
                    
              conn = conobj.getMyConnection();

              System.out.println("in try ifdtype= pppppppppppppppp=");				
	         /*String productQuery="select @i:=@i+1 srno,a.* from(select brandname,productid  ,productname,  unit,round(qty,2)qty "
	         		+ " from(select brandname , qty,  part_no,productid,productname,unit from ( "
	         		+ "select bd.brandname,d.rdocno,m.doc_no    psrno,sum(d.qty) as qty, "
	         		+ "m.part_no,m.part_no productid, "
	         		+ "m.productname,    u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, "
	         		+ "d.discount dis,d.nettotal netotal from my_girm ma left join my_gird d on(ma.doc_no=d.rdocno) "
	         		+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
	         		+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  left join  my_brand bd on m.brandid=bd.doc_no "
	         		+ "left join my_prddin i    on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid "
	         		+ "and ma.locid=i.locid)  where m.status=3 and  d.rdocno in(2) and  ma.brhid='1'  and ma.locid=1 "
	         		+ "group by i.stockid  order by i.date,i.prdid,i.refstockid ) as a ) as b)a,(select @i:=0)r;"; */
              String productQuery="select @i:=@i+1 srno,a.* from(select if(cost_price='0','',round(cost_price,2))cost_price,brandname,productid  ,productname,  unit,round(qty,2)qty "
              		+ "from(select cost_price,brandname , qty,  part_no,productid,productname,unit from ( "
              		+ "select bd.brandname,d.rdocno,m.doc_no    psrno,sum(d.qty) as qty, "
              		+ "m.part_no,m.part_no productid,d.cost_price, "
              		+ "m.productname,    u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, "
              		+ "d.discount dis,d.nettotal netotal from my_girm ma left join my_gird d on(ma.doc_no=d.rdocno) "
              		+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
              		+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  left join  my_brand bd on m.brandid=bd.doc_no "
              		+ "left join my_prddin i    on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid "
              		+ "and ma.locid=i.locid)  where m.status=3 and  d.rdocno in("+doc+") and d.qty!=0 and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
              		+ "group by i.stockid  order by i.date,i.prdid,i.refstockid ) as a ) as b)a,(select @i:=0)r ;";
	         System.out.println("product query "+productQuery);
	         param.put("productQuery",productQuery);
	         
	         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	        	imgpath=imgpath.replace("\\", "\\\\");    
	          param.put("imghedderpath", imgpath);
	          
	          
	          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        	imgpath2=imgpath2.replace("\\", "\\\\");    
	          param.put("imgfooterpath", imgpath2);
	          
	          param.put("refname", bean.getClient_name());
	          param.put("conperson", bean.getContactperson());
	          param.put("mob", bean.getContact_no());
	          param.put("docno",doc);
	          param.put("date", bean.getPdate());
	          param.put("locname", bean.getLocname());
	          param.put("costdocno",bean.getProject_name());
			        String fire7imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7fullheader.jpg");
	           fire7imgpath=fire7imgpath.replace("\\", "\\\\");
	           param.put("fire7fullheadderpath", fire7imgpath); 
			  
	          String path=com.getPrintPath(dtype);
		       setUrl(path);
		       System.out.println("print==========="+path);
		       JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/sales and marketing/Inventory Transfer/goodsissuenotereturn/"+com.getPrintPath(dtype)));
                 
	          //com/sales and marketing/Inventory Transfer/goodsissuenote/GoodsIssueNote.jrxml
	          //com/sales and marketing/Inventory Transfer/goodsissuenotereturn/GoodsIssueNoteReturn.jrxml
	          
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
