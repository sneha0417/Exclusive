package com.salesandmarketing.Sales.joborder;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsJobOrderAction {

	ClsJobOrderDAO  DAO=new ClsJobOrderDAO();
	private String txtclient,txtclientdet, brand, model,mode ,deleted, msg,formdetailcode,submodel,esize,bsize,csize,regno,txtclientmob;
	private int docno,yom ,clientid ,brandid, modelid, yomid, gridlength,masterdoc_no ;
	
	
	
	private int  typesave,submodelid,esizeid,bsizeid,csizeid,refdocnos;
	
	
	ClsJobOrderBean bean=new ClsJobOrderBean();
	
	
	
	
	
	public String getTxtclientmob() {
		return txtclientmob;
	}
	public void setTxtclientmob(String txtclientmob) {
		this.txtclientmob = txtclientmob;
	}
	public int getRefdocnos() {
		return refdocnos;
	}
	public void setRefdocnos(int refdocnos) {
		this.refdocnos = refdocnos;
	}
	public String getSubmodel() {
		return submodel;
	}
	public void setSubmodel(String submodel) {
		this.submodel = submodel;
	}
	public String getEsize() {
		return esize;
	}
	public void setEsize(String esize) {
		this.esize = esize;
	}
	public String getBsize() {
		return bsize;
	}
	public void setBsize(String bsize) {
		this.bsize = bsize;
	}
	public String getCsize() {
		return csize;
	}
	public void setCsize(String csize) {
		this.csize = csize;
	}
	public int getTypesave() {            
		return typesave;
	}
	public void setTypesave(int typesave) {     
		this.typesave = typesave;
	}
	public int getSubmodelid() {
		return submodelid;
	}
	public void setSubmodelid(int submodelid) {
		this.submodelid = submodelid;
	}
	public int getEsizeid() {
		return esizeid;
	}
	public void setEsizeid(int esizeid) {
		this.esizeid = esizeid;
	}
	public int getBsizeid() {
		return bsizeid;
	}
	public void setBsizeid(int bsizeid) {
		this.bsizeid = bsizeid;
	}
	public int getCsizeid() {
		return csizeid;
	}
	public void setCsizeid(int csizeid) {
		this.csizeid = csizeid;
	}
	
	
	
	
	
	
	
	
	
	
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {  
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getYom() {               
		return yom;
	}
	public void setYom(int yom) {
		this.yom = yom;
	}
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getBrandid() {
		return brandid;
	}
	public void setBrandid(int brandid) {
		this.brandid = brandid;
	}
	public int getModelid() {
		return modelid;
	}
	public void setModelid(int modelid) {
		this.modelid = modelid;
	}
	public int getYomid() {
		return yomid;
	}
	public void setYomid(int yomid) {
		this.yomid = yomid;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	
	

	private int lbldoc;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	
	
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
	
	
	
	private String  custname,custaddress,lblregno,lblbrand,lblmodel,lblsubmodel,lblyom,lblesize,lblbsize,lblcsize;
	
	
	
	
	
	public String getCustname() {
		return custname;
	}
	public void setCustname(String custname) {    
		this.custname = custname;
	}
	public String getCustaddress() {
		return custaddress;
	}
	public void setCustaddress(String custaddress) {
		this.custaddress = custaddress;
	}
	public String getLblregno() {
		return lblregno;
	}
	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}
	public String getLblbrand() {
		return lblbrand;
	}
	public void setLblbrand(String lblbrand) {
		this.lblbrand = lblbrand;
	}
	public String getLblmodel() {
		return lblmodel;
	}
	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}
	public String getLblsubmodel() {
		return lblsubmodel;
	}
	public void setLblsubmodel(String lblsubmodel) {
		this.lblsubmodel = lblsubmodel;
	}
	public String getLblyom() {
		return lblyom;
	}
	public void setLblyom(String lblyom) {
		this.lblyom = lblyom;
	}
	public String getLblesize() {
		return lblesize;
	}
	public void setLblesize(String lblesize) {
		this.lblesize = lblesize;
	}
	public String getLblbsize() {
		return lblbsize;
	}
	public void setLblbsize(String lblbsize) {
		this.lblbsize = lblbsize;
	}
	public String getLblcsize() {
		return lblcsize;
	}
	public void setLblcsize(String lblcsize) {
		this.lblcsize = lblcsize;
	}
	public String saveAction(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="fail";
		int val=0;
		try{

			
 

			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> prodarray= new ArrayList<>();
			

				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}

			
				


				val=DAO.insert(getClientid(),getMode(),getFormdetailcode(),prodarray,session,request,getRegno(),getBrandid(),getModelid(),getYomid(),
							  getTypesave(), getSubmodelid(), getEsizeid(), getBsizeid(), getCsizeid(),getRefdocnos());
				
 
			
				if(val>0){
					int vdocno=(int) request.getAttribute("vocno");

					int refdocnos=(int) request.getAttribute("refdocno");
					 setDocno(vdocno); 
					 
					 setMasterdoc_no(val);
					 
					 setTxtclient(getTxtclient());
					 setTxtclientdet(getTxtclientdet());
					 setBrand(getBrand());
					 setModel(getModel());
					 setYom(getYom());
					 
					 setRefdocnos(getRefdocnos());
					 
					 setRegno(getRegno());
					 setClientid(getClientid());
					 setModelid(getModelid());
					 setYomid(getYomid());
					
			
					setSubmodel(getSubmodel());
					setEsize(getEsize());
					setBsize(getBsize()); 
					setCsize(getCsize()); 
					setTypesave(getTypesave());
					setSubmodelid(getSubmodelid()); 
					setEsizeid(getEsizeid());
					setBsizeid(getBsizeid());
					setCsizeid(getCsizeid());
					
					setRefdocnos(refdocnos);
					 
					
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					 setMasterdoc_no(val);
					 setTxtclient(getTxtclient());
					 setTxtclientdet(getTxtclientdet());
					 setBrand(getBrand());
					 setModel(getModel());
					 setYom(getYom());
					 
						setSubmodel(getSubmodel());
						setEsize(getEsize());
						setBsize(getBsize()); 
						setCsize(getCsize()); 
						setTypesave(getTypesave());
						setSubmodelid(getSubmodelid()); 
						setEsizeid(getEsizeid());
						setBsizeid(getBsizeid());
						setCsizeid(getCsizeid());
					 setRegno(getRegno());
					 setClientid(getClientid());
					 setModelid(getModelid());
					 setYomid(getYomid());
					
						System.out.println("===========INNNN======"+val);
					 
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){

	
				
				returns="success";
			}



		}
		catch(Exception e){
			e.printStackTrace();
		}


		return returns;
	}
	
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 bean=DAO.getPrint(doc,request);
	  
		 
		
		  //cl details
		 
		    setLblprintname("Job Order");
		    setLbldoc(bean.getLbldoc());
		 //   setLbldate(bean.getLbldate());
		    
		  
		    
		    
		   setCustname(bean.getCustname());
		   setCustaddress(bean.getCustaddress()); 
	 	      
		    setLblregno(bean.getLblregno());
		    setLblbrand(bean.getLblbrand());
		    setLblmodel(bean.getLblmodel());
		    setLblsubmodel(bean.getLblsubmodel());  
		    
		    
		    setLblyom(bean.getLblyom());
		    setLblesize(bean.getLblesize());
			    
		    setLblbsize(bean.getLblbsize());
		    setLblcsize(bean.getLblcsize());
					
 
				   setLblbranch(bean.getLblbranch());
				   setLblcompname(bean.getLblcompname());
				  
				   setLblcompaddress(bean.getLblcompaddress());
				   setLblcomptel(bean.getLblcomptel());
				   setLblcompfax(bean.getLblcompfax());
				   setLbllocation(bean.getLbllocation());
	 
		   
		 return "print";
		 }	
		
	
	
	
	
	
	
}
