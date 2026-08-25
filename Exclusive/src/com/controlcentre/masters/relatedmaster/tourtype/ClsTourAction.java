package com.controlcentre.masters.relatedmaster.tourtype;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsTourAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsTourDAO serviceDAO= new ClsTourDAO();
	ClsTourBean bean;

	private int docno,childmin,childmax,agemin,agemax,termgridlenght,chkprivate,hidchkprivate;
	public int getChkprivate() {
		return chkprivate;
	}
	public void setChkprivate(int chkprivate) {      
		this.chkprivate = chkprivate;
	}

	private String name,hghtmin,hghtmax,wghtmin,wghtmax,desc;
	public int getHidchkprivate() {
		return hidchkprivate;
	}
	public void setHidchkprivate(int hidchkprivate) {
		this.hidchkprivate = hidchkprivate;
	}   

	private String code;
	private String refund;
	private String hidrefund;
	private String transportation;
	private String hidtransportation;
	
	private String mode;
	
	
	public String getTransportation() {
		return transportation;
	}
	public void setTransportation(String transportation) {
		this.transportation = transportation;
	}
	public String getHidtransportation() {
		return hidtransportation;
	}
	public void setHidtransportation(String hidtransportation) {
		this.hidtransportation = hidtransportation;
	}


	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getHghtmin() {
		return hghtmin;
	}
	public void setHghtmin(String hghtmin) {
		this.hghtmin = hghtmin;
	}
	public String getHghtmax() {
		return hghtmax;
	}
	public void setHghtmax(String hghtmax) {
		this.hghtmax = hghtmax;
	}
	public String getWghtmin() {
		return wghtmin;
	}
	public void setWghtmin(String wghtmin) {
		this.wghtmin = wghtmin;
	}
	public String getWghtmax() {
		return wghtmax;
	}
	public void setWghtmax(String wghtmax) {
		this.wghtmax = wghtmax;
	}
	public int getChildmin() {
		return childmin;
	}
	public void setChildmin(int childmin) {
		this.childmin = childmin;
	}
	public int getChildmax() {
		return childmax;
	}
	public void setChildmax(int childmax) {
		this.childmax = childmax;
	}
	public int getAgemin() {
		return agemin;
	}
	public void setAgemin(int agemin) {
		this.agemin = agemin;
	}
	public int getAgemax() {
		return agemax;
	}
	public void setAgemax(int agemax) {
		this.agemax = agemax;
	}

	private String deleted;
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getRefund() {
		return refund;
	}
	public void setRefund(String refund) {
		this.refund = refund;
	}
	public String getHidrefund() {
		return hidrefund;
	}
	public void setHidrefund(String hidrefund) {
		this.hidrefund = hidrefund;
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
	public int getTermgridlenght() {
		return termgridlenght;
	}
	public void setTermgridlenght(int termgridlenght) {
		this.termgridlenght = termgridlenght;
	}


	public String saveAction() throws ParseException, SQLException{
	//	System.out.println("*** ACTION *****");
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		Map<String, String[]> requestParams = request.getParameterMap();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getName(),getCode(),getRefund(), session,getMode(),getFormdetailcode(),getChildmin(),getChildmax(),getHghtmin(),getHghtmax(),getWghtmin(),getWghtmax(),getAgemin(),getAgemax(),getDesc(),getTransportation(),getChkprivate());
						//System.out.println(val);
						if(val>0){
							setHidchkprivate(getChkprivate());   
							setDesc(getDesc());
							setChildmin(getChildmin());
							setChildmax(getChildmax());
							setHghtmin(getHghtmin());
							setHghtmax(getHghtmax());
							setWghtmin(getWghtmin());
							setWghtmax(getWghtmax());
							setAgemin(getAgemin());
							setAgemax(getAgemax());
							setName(getName());
							setCode(getCode());
							setHidrefund(getRefund());
							setHidtransportation(getHidtransportation());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setHidchkprivate(getChkprivate()); 
							setDesc(getDesc());
							setChildmin(getChildmin());
							setChildmax(getChildmax());
							setHghtmin(getHghtmin());
							setHghtmax(getHghtmax());
							setWghtmin(getWghtmin());
							setWghtmax(getWghtmax());
							setAgemin(getAgemin());
							setAgemax(getAgemax());
							setName(getName());
							setCode(getCode());
							setHidrefund(getRefund());
							setHidtransportation(getHidtransportation());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						
						else{
							setHidchkprivate(getChkprivate()); 
							setDesc(getDesc());
							setChildmin(getChildmin());
							setChildmax(getChildmax());
							setHghtmin(getHghtmin());
							setHghtmax(getHghtmax());
							setWghtmin(getWghtmin());
							setWghtmax(getWghtmax());
							setAgemin(getAgemin());
							setAgemax(getAgemax());
							setName(getName());
							setCode(getCode());
							setHidrefund(getRefund());					
							setHidtransportation(getHidtransportation());
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=serviceDAO.edit(getName(),getCode(),getRefund(),session,getMode(),getDocno(),getFormdetailcode(),getChildmin(),getChildmax(),getHghtmin(),getHghtmax(),getWghtmin(),getWghtmax(),getAgemin(),getAgemax(),getDesc(),getTransportation(),getChkprivate());
				
				if(val>0){
					
					//session.getAttribute("BranchName");
					setHidchkprivate(getChkprivate()); 
					setDesc(getDesc());
					setChildmin(getChildmin());
					setChildmax(getChildmax());
					setHghtmin(getHghtmin());
					setHghtmax(getHghtmax());
					setWghtmin(getWghtmin());
					setWghtmax(getWghtmax());
					setAgemin(getAgemin());
					setAgemax(getAgemax());
					setName(getName());
					setCode(getCode());
					setHidrefund(getRefund());
					setHidtransportation(getHidtransportation());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setHidchkprivate(getChkprivate()); 
					setDesc(getDesc());
					setChildmin(getChildmin());
					setChildmax(getChildmax());
					setHghtmin(getHghtmin());
					setHghtmax(getHghtmax());
					setWghtmin(getWghtmin());
					setWghtmax(getWghtmax());
					setAgemin(getAgemin());
					setAgemax(getAgemax());
					setName(getName());
					setCode(getCode());
					setHidrefund(getRefund());
					setHidtransportation(getHidtransportation());
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Packagetype Already Exists.");
					return "fail";
				}
				else{
					setHidchkprivate(getChkprivate()); 
					setDesc(getDesc());
					setChildmin(getChildmin());
					setChildmax(getChildmax());
					setHghtmin(getHghtmin());
					setHghtmax(getHghtmax());
					setWghtmin(getWghtmin());
					setWghtmax(getWghtmax());
					setAgemin(getAgemin());
					setAgemax(getAgemax());
					setName(getName());
					setCode(getCode());
					setHidrefund(getRefund());
					setHidtransportation(getHidtransportation());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=serviceDAO.delete(getName(),getCode(),getRefund(),session,getMode(),getDocno(),getFormdetailcode(),getChildmin(),getChildmax(),getHghtmin(),getHghtmax(),getWghtmin(),getWghtmax(),getAgemin(),getAgemax(),getDesc(),getTransportation(),getChkprivate());
			if(Status){
				setHidchkprivate(getChkprivate()); 
				setDesc(getDesc());
				setChildmin(getChildmin());
				setChildmax(getChildmax());
				setHghtmin(getHghtmin());
				setHghtmax(getHghtmax());
				setWghtmin(getWghtmin());
				setWghtmax(getWghtmax());
				setAgemin(getAgemin());
				setAgemax(getAgemax());
				setName(getName());
				setCode(getCode());
				setHidrefund(getRefund());
				setHidtransportation(getHidtransportation());
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setHidchkprivate(getChkprivate()); 
				setDesc(getDesc());
				setChildmin(getChildmin());
				setChildmax(getChildmax());
				setHghtmin(getHghtmin());
				setHghtmax(getHghtmax());
				setWghtmin(getWghtmin());
				setWghtmax(getWghtmax());
				setAgemin(getAgemin());
				setAgemax(getAgemax());
				setName(getName());
				setCode(getCode());
				setHidrefund(getRefund());
				setHidtransportation(getHidtransportation());
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
			else if(mode.equalsIgnoreCase("SAVE")){      
//				System.out.println("in action ==term==");
				ArrayList<String> termarray= new ArrayList<>();
				for(int i=0;i<getTermgridlenght();i++){
//					System.out.println("in action ==term=="+getTermgridlenght());
//					System.out.println(getTermgridlenght());
					String temp=requestParams.get("term_test"+i)[0]; 
//					System.out.println("temp=="+temp);
					termarray.add(temp);
//					System.out.println("temp=="+temp);
				}  
			  int val=serviceDAO.termsave(getDocno(),termarray,session,request,mode);
				if(val>0){
					setDesc(getDesc());
					setChildmin(getChildmin());
					setChildmax(getChildmax());
					setHghtmin(getHghtmin());
					setHghtmax(getHghtmax());
					setWghtmin(getWghtmin());
					setWghtmax(getWghtmax());
					setAgemin(getAgemin());
					setAgemax(getAgemax());
					setName(getName());
					setCode(getCode());
					setHidrefund(getRefund());
					setHidtransportation(getHidtransportation());
					setMode(getMode());
				    setDocno(val);						    
				
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setDesc(getDesc());
					setChildmin(getChildmin());
					setChildmax(getChildmax());
					setHghtmin(getHghtmin());
					setHghtmax(getHghtmax());
					setWghtmin(getWghtmin());
					setWghtmax(getWghtmax());
					setAgemin(getAgemin());
					setAgemax(getAgemax());
					setName(getName());
					setCode(getCode());
					setHidrefund(getRefund());
					setHidtransportation(getHidtransportation());
					setMode(getMode());
				    setDocno(val);						    
				
					setMsg("Not Saved");
					return "fail";
				}	
				
			} 
		return "fail";
	}
	

		/*public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsServiceBean> list= serviceDAO.list();
				  for(ClsServiceBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.gettechniciandate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile",bean.getMobile());
				  cellobj.put("email", bean.getEmail());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
*/
}


