package com.controlcentre.masters.product;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsProductAction  {
	ClsProductDAO DAO= new ClsProductDAO();
	ClsProductBean bean=new ClsProductBean();

	ClsCommon ClsCommon=new ClsCommon();
	private int docno,comorbranch,pmgtgridlength;
	private String mode,prddet, stdcostname, stdcostprice, fixname, fixprices, lbrcostname ,lbrcosts,txtarbicprdname,desc1;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private String date;
	private String hiddate;
	private String txtproductcode;
	private String txtproductname;
	private String txtbarcode;
	private String cmbproducttype;
	private String txtproducttype;
	private String cmbbrand;
	private String txtbrand;
	private String cmbcategory;
	private String txtcategory;
	private String cmbsubcategory;
	private String txtsubcategory;
	private String cmbunit;
	private String txtunit;
	private String cmbdept;
	private String textdept;

	private int specGridlen,jqxsedinglength;
	private int suitGridlen;
	private int uomGridlen;
	private int proGridlen,cmbstar,hidecmbstar,cmbmastertype,hidcmbmastertype;

	
 
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public int getJqxsedinglength() {
		return jqxsedinglength;
	}
	public void setJqxsedinglength(int jqxsedinglength) {
		this.jqxsedinglength = jqxsedinglength;
	}
	public String getTxtarbicprdname() {
		return txtarbicprdname;
	}
	public void setTxtarbicprdname(String txtarbicprdname) {
		this.txtarbicprdname = txtarbicprdname;
	}
	public int getCmbmastertype() {
		return cmbmastertype;
	}
	public void setCmbmastertype(int cmbmastertype) {
		this.cmbmastertype = cmbmastertype;
	}
	public int getHidcmbmastertype() {
		return hidcmbmastertype;
	}
	public void setHidcmbmastertype(int hidcmbmastertype) {
		this.hidcmbmastertype = hidcmbmastertype;
	}
	public String getStdcostname() {
		return stdcostname;
	}
	public void setStdcostname(String stdcostname) {
		this.stdcostname = stdcostname;
	}
	public String getStdcostprice() {
		return stdcostprice;
	}
	public void setStdcostprice(String stdcostprice) {
		this.stdcostprice = stdcostprice;
	}
	public String getFixname() {
		return fixname;
	}
	public void setFixname(String fixname) {
		this.fixname = fixname;
	}
	public String getFixprices() {
		return fixprices;
	}
	public void setFixprices(String fixprices) {
		this.fixprices = fixprices;
	}
	public String getLbrcostname() {
		return lbrcostname;
	}
	public void setLbrcostname(String lbrcostname) {
		this.lbrcostname = lbrcostname;
	}
	public String getLbrcosts() {
		return lbrcosts;
	}
	public void setLbrcosts(String lbrcosts) {
		this.lbrcosts = lbrcosts;
	}
	public String getPrddet() {
		return prddet;
	}
	public void setPrddet(String prddet) {
		this.prddet = prddet;
	}
	public int getCmbstar() {
		return cmbstar;
	}
	public void setCmbstar(int cmbstar) {
		this.cmbstar = cmbstar;
	}
	public int getHidecmbstar() {
		return hidecmbstar;
	}
	public void setHidecmbstar(int hidecmbstar) {
		this.hidecmbstar = hidecmbstar;
	}
	public int getSpecGridlen() {
		return specGridlen;
	}
	public void setSpecGridlen(int specGridlen) {
		this.specGridlen = specGridlen;
	}
	public int getSuitGridlen() {
		return suitGridlen;
	}
	public void setSuitGridlen(int suitGridlen) {
		this.suitGridlen = suitGridlen;
	}
	public int getUomGridlen() {
		return uomGridlen;
	}
	public void setUomGridlen(int uomGridlen) {
		this.uomGridlen = uomGridlen;
	}
	public int getProGridlen() {
		return proGridlen;
	}
	public void setProGridlen(int proGridlen) {
		this.proGridlen = proGridlen;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getTxtproductcode() {
		return txtproductcode;
	}
	public void setTxtproductcode(String txtproductcode) {
		this.txtproductcode = txtproductcode;
	}
	public String getTxtproductname() {
		return txtproductname;
	}
	public void setTxtproductname(String txtproductname) {
		this.txtproductname = txtproductname;
	}
	public String getTxtbarcode() {
		return txtbarcode;
	}
	public void setTxtbarcode(String txtbarcode) {
		this.txtbarcode = txtbarcode;
	}
	public String getCmbproducttype() {
		return cmbproducttype;
	}
	public void setCmbproducttype(String cmbproducttype) {
		this.cmbproducttype = cmbproducttype;
	}

	public String getCmbbrand() {
		return cmbbrand;
	}
	public void setCmbbrand(String cmbbrand) {
		this.cmbbrand = cmbbrand;
	}

	public String getCmbcategory() {
		return cmbcategory;
	}
	public void setCmbcategory(String cmbcategory) {
		this.cmbcategory = cmbcategory;
	}

	public String getCmbsubcategory() {
		return cmbsubcategory;
	}
	public void setCmbsubcategory(String cmbsubcategory) {
		this.cmbsubcategory = cmbsubcategory;
	}

	public String getCmbunit() {
		return cmbunit;
	}
	public void setCmbunit(String cmbunit) {
		this.cmbunit = cmbunit;
	}

	public String getCmbdept() {
		return cmbdept;
	}
	public void setCmbdept(String cmbdept) {
		this.cmbdept = cmbdept;
	}
	public String getTxtproducttype() {
		return txtproducttype;
	}
	public void setTxtproducttype(String txtproducttype) {
		this.txtproducttype = txtproducttype;
	}
	public String getTxtbrand() {
		return txtbrand;
	}
	public void setTxtbrand(String txtbrand) {
		this.txtbrand = txtbrand;
	}
	public String getTxtcategory() {
		return txtcategory;
	}
	public void setTxtcategory(String txtcategory) {
		this.txtcategory = txtcategory;
	}
	public String getTxtsubcategory() {
		return txtsubcategory;
	}
	public void setTxtsubcategory(String txtsubcategory) {
		this.txtsubcategory = txtsubcategory;
	}
	public String getTxtunit() {
		return txtunit;
	}
	public void setTxtunit(String txtunit) {
		this.txtunit = txtunit;
	}
	public String getTextdept() {
		return textdept;
	}
	public void setTextdept(String textdept) {
		this.textdept = textdept;
	}
	 
	public int getComorbranch() {
		return comorbranch;
	}
	public void setComorbranch(int comorbranch) {
		this.comorbranch = comorbranch;
	}
	
	
	public int getPmgtgridlength() {
		return pmgtgridlength;
	}
	public void setPmgtgridlength(int pmgtgridlength) {
		this.pmgtgridlength = pmgtgridlength;
	}
	
	
	 
	public String saveProductAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		try{
			java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
			//System.out.println("====mode===="+mode);
			ArrayList<String> prodarray= new ArrayList<>();	   
			ArrayList<String> uomarray= new ArrayList<>();	   
			ArrayList<String> specarray= new ArrayList<>();	   
			ArrayList<String> suitarray= new ArrayList<>();
			ArrayList<String> pmgntarray= new ArrayList<>();
			
			
			ArrayList<String> ssarray= new ArrayList<>();
			
			
			
			 
			int val=0;
		

			if(mode.equalsIgnoreCase("A")){
				
				for(int i=0;i<getJqxsedinglength();i++){
					String temp=requestParams.get("seding"+i)[0];		
					ssarray.add(temp);
				}
				
				
				for(int i=0;i<getProGridlen();i++){
					String temp=requestParams.get("prod"+i)[0];		
					prodarray.add(temp);
				}

				for(int i=0;i<getUomGridlen();i++){
					String temp1=requestParams.get("uom"+i)[0];
					uomarray.add(temp1);
				}

				for(int i=0;i<getSpecGridlen();i++){
					String temp2=requestParams.get("spec"+i)[0];
					specarray.add(temp2);
				}

				for(int i=0;i<getSuitGridlen();i++){
					String temp3=requestParams.get("suit"+i)[0];
					suitarray.add(temp3);
				}
				for(int i=0;i<getPmgtgridlength();i++){
					String temp4=requestParams.get("pmgt"+i)[0];		
					pmgntarray.add(temp4);
				}

				val=DAO.insert(date,getTxtproductname(),getTxtproductcode(),getTxtbarcode(),getCmbproducttype(),getCmbbrand(),getCmbcategory(),
						getCmbsubcategory(),getCmbunit(),getCmbdept(),getMode(),getFormdetailcode(),
						prodarray,uomarray,suitarray,specarray,session,getComorbranch(),pmgntarray,getCmbstar(),getCmbmastertype(),getTxtarbicprdname(),ssarray,getDesc1());

				if(val>0){
					setDocno(val);
					
					if(getTxtbarcode().equalsIgnoreCase("") || getTxtbarcode()==null)
					{
						setTxtbarcode(val+"");	
					}
					else
					{
						setTxtbarcode(getTxtbarcode());	
					}
					
					setTxtarbicprdname(getTxtarbicprdname());
					setHidcmbmastertype(getCmbmastertype());
					
					setHidecmbstar(getCmbstar());
					
					setCmbbrand(getCmbbrand());
					setCmbcategory(getCmbcategory());
					setCmbsubcategory(getCmbcategory());
					setCmbdept(getCmbdept());
					setCmbproducttype(getCmbproducttype());
					setCmbunit(getCmbunit());
					setTxtbrand(getTxtbrand());
					setTxtcategory(getTxtcategory());
					setTxtproducttype(getTxtproducttype());
					setTxtsubcategory(getTxtsubcategory());
					setTxtunit(getTxtunit());
					setTextdept(getTextdept());
				 
					
					setComorbranch(getComorbranch());
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setHidecmbstar(getCmbstar());
					setHidcmbmastertype(getCmbmastertype());
					 setMode("A");
					setMsg("Not Saved");
					return "fail";
				}

			}

			else if(mode.equalsIgnoreCase("E")){
				
				
				for(int i=0;i<getJqxsedinglength();i++){
					String temp=requestParams.get("seding"+i)[0];		
					ssarray.add(temp);
				}
				
				for(int i=0;i<getProGridlen();i++){
					String temp=requestParams.get("prod"+i)[0];		
					prodarray.add(temp);
				}

				for(int i=0;i<getUomGridlen();i++){
					String temp1=requestParams.get("uom"+i)[0];
					uomarray.add(temp1);
				}

				for(int i=0;i<getSpecGridlen();i++){
					String temp2=requestParams.get("spec"+i)[0];
					specarray.add(temp2);
				}

				//System.out.println("==getSuitGridlen()==="+getSuitGridlen());
				
				for(int i=0;i<getSuitGridlen();i++){
					String temp3=requestParams.get("suit"+i)[0];
					//System.out.println("==temp3=="+temp3);
					suitarray.add(temp3);
				}
				for(int i=0;i<getPmgtgridlength();i++){
					String temp4=requestParams.get("pmgt"+i)[0];		
					pmgntarray.add(temp4);
				}
				val=DAO.update(getDocno(),date,getTxtproductname(),getTxtproductcode(),getTxtbarcode(),getCmbproducttype(),getCmbbrand(),getCmbcategory(),
						getCmbsubcategory(),getCmbunit(),getCmbdept(),getMode(),getFormdetailcode(),prodarray,uomarray,suitarray,specarray,
						session,getComorbranch(),pmgntarray,getCmbstar(),getCmbmastertype(),getTxtarbicprdname(),ssarray,getDesc1());

				if(val>0){
					setDocno(val);
					
					if(getTxtbarcode().equalsIgnoreCase("") || getTxtbarcode()==null)
					{
						setTxtbarcode(val+"");	
					}
					else
					{
						setTxtbarcode(getTxtbarcode());	
					}
					setTxtarbicprdname(getTxtarbicprdname());
					setHidcmbmastertype(getCmbmastertype());
					setHidecmbstar(getCmbstar());
					setCmbbrand(getCmbbrand());
					setCmbcategory(getCmbcategory());
					setCmbsubcategory(getCmbcategory());
					setCmbdept(getCmbdept());
					setCmbproducttype(getCmbproducttype());
					setCmbunit(getCmbunit());
					setTxtbrand(getTxtbrand());
					setTxtcategory(getTxtcategory());
					setTxtproducttype(getTxtproducttype());
					setTxtsubcategory(getTxtsubcategory());
					setTxtunit(getTxtunit());
					setTextdept(getTextdept());
					//setMode(getMode());
					setComorbranch(getComorbranch());
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					//setMode(getMode());
					setHidecmbstar(getCmbstar());
					setHidcmbmastertype(getCmbmastertype());
					setMsg("Not Saved");
					return "fail";
				}

			}

			else if(mode.equalsIgnoreCase("D")){

				val=DAO.delete(getDocno(),date,getTxtproductname(),getTxtproductcode(),getTxtbarcode(),getCmbproducttype(),getCmbbrand(),getCmbcategory(),
						getCmbsubcategory(),getCmbunit(),getCmbdept(),getMode(),getFormdetailcode(),prodarray,uomarray,suitarray,specarray,session);

				if(val>0){
					setDocno(val);
					setCmbbrand(getCmbbrand());
					setCmbcategory(getCmbcategory());
					setCmbsubcategory(getCmbcategory());
					setCmbdept(getCmbdept());
					setCmbproducttype(getCmbproducttype());
					setCmbunit(getCmbunit());
					setTxtbrand(getTxtbrand());
					setTxtcategory(getTxtcategory());
					setTxtproducttype(getTxtproducttype());
					setTxtsubcategory(getTxtsubcategory());
					setTxtunit(getTxtunit());
					setTextdept(getTextdept());
				//	setMode(getMode());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				}
				else if(val==-5)
				{
			 
					setChkstatus("5");
					setMsg("Not Deleted");
					return "fail";
					
				}
				
				
				else{
					//setMode(getMode());
					setMsg("Not Deleted");
					return  "fail";
				}

			}

			if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(session,getDocno());
				
				setHidcmbmastertype(bean.getCmbmastertype());
				setHidecmbstar(bean.getCmbstar());
				setTxtproducttype(bean.getTxtproducttype());
				setTxtbrand(bean.getTxtbrand());
				setTxtproductname(bean.getTxtproductname());
				setTxtproductcode(bean.getTxtproductcode());
				setTxtunit(bean.getTxtunit());
				setTxtbarcode(bean.getTxtbarcode());
				setTextdept(bean.getTextdept());
				setTxtcategory(bean.getTxtcategory());
				setTxtsubcategory(bean.getTxtsubcategory());
				setCmbbrand(bean.getCmbbrand());
				setCmbproducttype(bean.getCmbproducttype());
				setCmbcategory(bean.getCmbcategory());
				setCmbsubcategory(bean.getCmbsubcategory());
				setCmbunit(bean.getCmbunit());
				setCmbdept(bean.getCmbdept());
				
				setComorbranch(bean.getComorbranch());
				setDesc1(bean.getDesc1());
				
			 
				setStdcostname(bean.getStdcostname());
				setStdcostprice(bean.getStdcostprice());
				
				setFixname(bean.getFixname());
				setFixprices(bean.getFixprices());
				
				
				setLbrcostname(bean.getLbrcostname());
				setLbrcosts(bean.getLbrcosts());
				
				
				setTxtarbicprdname(bean.getTxtarbicprdname());
				
				 
	 
				return "success";
			}


		}

		catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}


}
