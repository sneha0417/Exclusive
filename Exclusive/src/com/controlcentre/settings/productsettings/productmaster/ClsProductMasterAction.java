package com.controlcentre.settings.productsettings.productmaster;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.clientrelations.clientcategory.ClsClientCategoryBean;

public class ClsProductMasterAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsProductMasterDAO pDAO= new ClsProductMasterDAO();
	ClsProductMasterBean bean;
	private int docno;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String ptmdate;
	private String ptmtype;
	private String brand;
	private String branddesc;
	private String date;
	private String unit;
	private String unitdesc;
	private String chkstatus;
	private Double unitfr;
	private String txtcategory;
	private String model; 
	private String brandid;
	private String subcat;
	private String category;
	private String hidcategory;
	private String dept;
	private String hidtest;
	
	
	
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getPtmdate() {
		return ptmdate;
	}
	public void setPtmdate(String ptmdate) {
		this.ptmdate = ptmdate;
	}
	public String getPtmtype() {
		return ptmtype;
	}
	public void setPtmtype(String ptmtype) {
		this.ptmtype = ptmtype;
	}

	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBranddesc() {
		return branddesc;
	}
	public void setBranddesc(String branddesc) {
		this.branddesc = branddesc;
	}

	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getUnitdesc() {
		return unitdesc;
	}
	public void setUnitdesc(String unitdesc) {
		this.unitdesc = unitdesc;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public Double getUnitfr() {
		return unitfr;
	}
	public void setUnitfr(Double unitfr) {
		this.unitfr = unitfr;
	}
	public String getTxtcategory() {
		return txtcategory;
	}
	public void setTxtcategory(String txtcategory) {
		this.txtcategory = txtcategory;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getBrandid() {
		return brandid;
	}
	public void setBrandid(String brandid) {
		this.brandid = brandid;
	}
	public String getSubcat() {
		return subcat;
	}
	public void setSubcat(String subcat) {
		this.subcat = subcat;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getHidCategory() {
		return hidcategory;
	}
	public void setHidCategory(String hidcategory) {
		this.hidcategory = hidcategory;
	}
	public String getHidtest() {
		return hidtest;
	}
	public void setHidtest(String hidtest) {
		this.hidtest = hidtest;
	}
	public String savetypeAction() throws SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String returns="";
		try{
			java.sql.Date date = ClsCommon.changeStringtoSqlDate(getPtmdate());
			if(mode.equalsIgnoreCase("A")){
             System.out.println("in add mode");

				int val=pDAO.insert(date,getFormdetail(),getFormdetailcode(),getPtmtype(),getMode() );
				if(val>0){
					System.out.println("val======="+val);
					setDocno(val);
					setMsg("Successfully Saved");

					returns="success";

				}else if(val==-1){

					

					setMsg("ProductType Already Exists");
					//request.setAttribute("SAVED", "Not Saved");
					//addActionError("Not Saved");
					return "fail";
				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

			else if(mode.equalsIgnoreCase("E")){


				int val=pDAO.update(date,getFormdetail(),getFormdetailcode(),getPtmtype(),getMode(),getDocno() );
				if(val>0.0){
					setDocno(val);
					setMsg("Updated Successfully");

					returns="success";

				}else if(val==-1){

					

					setMsg("ProductType Already Exists");
					//request.setAttribute("SAVED", "Not Saved");
					//addActionError("Not Saved");
					return "fail";
				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

			else if(mode.equalsIgnoreCase("D")){


				int val=pDAO.delete(date,getFormdetail(),getFormdetailcode(),getPtmtype(),getMode(),getDocno() );
				if(val>0.0){
					/*setDocno(0);*/
					setPtmtype("");
					setMsg("Deleted Successfully");

					returns="success";

				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

		}catch(Exception e){
			e.printStackTrace();
		}


		return returns;

	}
	
	public String savedeptAction() throws SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String returns="";
		try{
			java.sql.Date date = ClsCommon.changeStringtoSqlDate(getDate());
			if(mode.equalsIgnoreCase("A")){


				int val=pDAO.insertdept(date,getFormdetail(),getFormdetailcode(),getDept(),getMode() );
				if(val>0){
					setDocno(val);
					setMsg("Successfully Saved");

					returns="success";

				}else if(val==-1){

					

					setMsg("Department Already Exists");
					//request.setAttribute("SAVED", "Not Saved");
					//addActionError("Not Saved");
					return "fail";
				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

			else if(mode.equalsIgnoreCase("E")){


				int val=pDAO.updatedept(date,getFormdetail(),getFormdetailcode(),getDept(),getMode(),getDocno() );
				if(val>0.0){
					setDocno(val);
					setMsg("Updated Successfully");

					returns="success";

				}else if(val==-1){

					

					setMsg("Department Already Exists");
					//request.setAttribute("SAVED", "Not Saved");
					//addActionError("Not Saved");
					return "fail";
				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

			else if(mode.equalsIgnoreCase("D")){


				int val=pDAO.deletedept(date,getFormdetail(),getFormdetailcode(),getPtmtype(),getMode(),getDocno() );
				if(val>0.0){
					/*setDocno(0);*/
					setPtmtype("");
					setMsg("Deleted Successfully");

					returns="success";

				}

				else{

					setMsg("Not Saved");

					returns="fail";
				}	
			}

		}catch(Exception e){
			e.printStackTrace();
		}


		return returns;

	}


	public String savebrandAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		if(mode.equalsIgnoreCase("A")){
			//			System.out.println("date---"+sqlStartDate);
			int val=pDAO.insert(sqlStartDate,getBrand(),getBranddesc(),getMode(),session,getFormdetailcode());
			if(val>0){

				setBrand(getBrand());
				setDocno(val);
				//session.setAttribute("SAVED", "SUCCESSFULLY SAVED");
				setMsg("Successfully Saved");
				addActionMessage("Saved Successfully");
				//							System.out.println(session.getAttribute("SAVED"));
				return "success";
			}
			else if(val==-1){

				setBrand(getBrand());

				setMsg("Brand Already Exists");
				//request.setAttribute("SAVED", "Not Saved");
				//addActionError("Not Saved");
				return "fail";
			}
			else{

				setBrand(getBrand());
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.edit(getDocno(),sqlStartDate,getBrand(),getBranddesc(),session,getFormdetailcode());
			if(Status>0){

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1){

				setBrand(getBrand());
				setDocno(getDocno());


				setMsg("Brand Already Exists");
				return "fail";

			}
			else{

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=pDAO.delete(getDocno(),session,getBrand(),getFormdetailcode());
			if(Status>0){

				setBrand(getBrand());
				setDocno(getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-2){

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

	public String saveunitAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		

		session.getAttribute("BranchName");
		String mode=getMode();
		
	
		if(mode.equalsIgnoreCase("A")){
			int val=pDAO.insert(getUnit(),getUnitdesc(),session,getMode(),getFormdetailcode());
			if(val>0.0){
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
			
				setDocno(val);
				setMsg("Successfully Saved");

				return "success";
			}
			else if(val==-1){
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				//							System.out.println(val);
				//setDocno(val);
				setChkstatus("1");
				setMsg("Unit Already Exists");
				return "fail";
			}
			else{
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				//							System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}


		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.edit(getUnit().trim(),getDocno(),getUnitdesc(),getMode(),session,getFormdetailcode());
			if(Status>0){

				//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setChkstatus("2");
				setMsg("Unit Already Exists");
				return "fail";
			}
			else{
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//				System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
			boolean Status=pDAO.delete(getUnit(),getDocno(),getUnitdesc(),getMode(),session,getFormdetailcode());
			if(Status){
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else{
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	public String savecategoryAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsClientCategoryBean clientcategorybean = new ClsClientCategoryBean();

		if(mode.equalsIgnoreCase("A")){
			int val=pDAO.insert(getFormdetailcode(),getTxtcategory(),mode,session);
			//System.out.println("val for category========="+val);
			if(val>0){

				setDocno(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1)
			{

				setChkstatus("1");
				setMsg("Category Already Exists");
				return "fail";
			}
			else{

				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.edit(getFormdetailcode(),getDocno(),getTxtcategory(),mode,session);
			if(Status>0){



				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			{

				setChkstatus("2");
				setMsg("Category Already Exists");
				return "fail";
			}
			else{

				setMsg("Not Updated");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("D")){
			boolean Status=pDAO.delete(getDocno(),getFormdetailcode(),mode,session);
			if(Status){

				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{

				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

	public String savemodelAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		

		session.getAttribute("BranchName");


		String mode=getMode();
	
		java.sql.Date sqlStartDate=null;
		if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
			sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		}

		if(mode.equalsIgnoreCase("A")){
			int val=pDAO.insert(getModel(),getBrand(),sqlStartDate,session,getMode(),getFormdetailcode());
			if(val>0.0){
				setModel(getModel());
				setBrandid(getBrand());
				setMode(getMode());
				//							System.out.println(val);
				setDocno(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setModel(getModel());
				setBrandid(getBrand());
				setMode(getMode());
				//							System.out.println(val);
				//setDocno(val);
				setChkstatus("1");
				setMsg("Model Already Exists");
				return "fail";
			}
			else{
				setModel(getModel());
				setBrandid(getBrand());
				setMode(getMode());
				//							System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}


		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.edit(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
			if(Status>0){

				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				//					System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				//					System.out.println("Action"+getBrandid());
				//setMode(getMode());
				setChkstatus("2");
				setMsg("Model Already Exists");
				return "fail";
			}
			else{
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				//					System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//				System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=pDAO.delete(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-2){
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	
	public String savesubcategoryAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		

		session.getAttribute("BranchName");


		String mode=getMode();
	
		java.sql.Date sqlStartDate=null;
		if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
			sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		}

		if(mode.equalsIgnoreCase("A")){
			//System.out.println("category======="+getCategory());
			int val=pDAO.insertSubCat(getSubcat(),getCategory(),sqlStartDate,session,getMode(),getFormdetailcode());
			if(val>0.0){
				//System.out.println("category======="+getCategory());
				setHidCategory(getCategory());
				//System.out.println("hidcategory======="+getHidCategory());
				setHidtest(getCategory());
				setSubcat(getSubcat());
				setMode(getMode());
				//							System.out.println(val);
				setDocno(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setMode(getMode());
				//							System.out.println(val);
				//setDocno(val);
				setChkstatus("1");
				setMsg(" SubCategory Already Exists");
				return "fail";
			}
			else{
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setMode(getMode());
				//							System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}


		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.editSubCat(getSubcat(),getDocno(),sqlStartDate,getCategory(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				//					System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				
				//					System.out.println("Action"+getBrandid());
				//setMode(getMode());
				setChkstatus("2");
				setMsg("SubCategory Already Exists");
				return "fail";
			}
			else{
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				
				//					System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//				System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=pDAO.deleteSubCat(getSubcat(),getDocno(),sqlStartDate,getCategory(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-2){
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setHidtest(getCategory());
				setHidCategory(getCategory());
				setSubcat(getSubcat());
				setDocno(getDocno());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}
	

	
	

}

