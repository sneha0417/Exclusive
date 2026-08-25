package com.realestate.propertyrelated.propertyrelatedmaster;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

 
import org.apache.struts2.ServletActionContext;

import com.common.*;
public class ClsPropertyRelatedMasterAction {
	ClsCommon ClsCommon=new ClsCommon();
	
	private String date, name,  plotnumber, txtarea, txtareadet,mode ,deleted ,msg,datehidden;
	private int txtareaid  ,docno,gridlength;
	public String getDate() {
		return date;
	}
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPlotnumber() {
		return plotnumber;
	}
	public void setPlotnumber(String plotnumber) {
		this.plotnumber = plotnumber;
	}
	public String getTxtarea() {
		return txtarea;
	}
	public void setTxtarea(String txtarea) {
		this.txtarea = txtarea;
	}
	public String getTxtareadet() {
		return txtareadet;
	}
	public void setTxtareadet(String txtareadet) {
		this.txtareadet = txtareadet;
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
	public int getTxtareaid() {
		return txtareaid;
	}
	public void setTxtareaid(int txtareaid) {
		this.txtareaid = txtareaid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
 
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	private String formdetailcode;
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	
	 private String ptmdate,hidfgmdate,pcode,ptmtype;
	 

	public String getPtmdate() {
		return ptmdate;
	}
	public void setPtmdate(String ptmdate) {
		this.ptmdate = ptmdate;
	}
	public String getHidfgmdate() {
		return hidfgmdate;
	}
	public void setHidfgmdate(String hidfgmdate) {
		this.hidfgmdate = hidfgmdate;
	}
	public String getPcode() {   
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPtmtype() {
		return ptmtype;
	}
	public void setPtmtype(String ptmtype) {
		this.ptmtype = ptmtype;
	}
	
	 private String udate,prtype,hidudate,unit;
	 private int prtypeid;
	
	
	public String getUdate() {
		return udate;
	}
	public void setUdate(String udate) {
		this.udate = udate;
	}
	public String getPrtype() {
		return prtype;
	}
	public void setPrtype(String prtype) {
		this.prtype = prtype;
	}
	public String getHidudate() {
		return hidudate;
	}
	public void setHidudate(String hidudate) {
		this.hidudate = hidudate;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getPrtypeid() {
		return prtypeid;
	}
	public void setPrtypeid(int prtypeid) {
		this.prtypeid = prtypeid;
	}


	ClsPropertyRelatedMasterDAO ClsPropertyRelatedMasterDAO =new ClsPropertyRelatedMasterDAO();
	
	public String saveAction1() throws SQLException{

 
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
 
	ArrayList<String> aar=null;
	 if(getMode().equalsIgnoreCase("A") || getMode().equalsIgnoreCase("E"))
	 {
		  aar= new ArrayList<>();
 
		for(int i=0;i<getGridlength();i++){
			
           System.out.println("====requestParams=========="+requestParams.get("TEMP"+i)[0]);
			
			 String temp=requestParams.get("TEMP"+i)[0];		
			aar.add(temp);
		}
	 }

 
  java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getDate());
	
 int value=ClsPropertyRelatedMasterDAO.saveBuilding(masterdate,getDocno(),getMode(),getTxtareaid(),getName(),getPlotnumber(),aar,session,request,getFormdetailcode());
		
 
 if(getMode().equalsIgnoreCase("A"))
 {
	 if(value>0)
	 {
		 setDocno(value);
		 
		 setDatehidden(masterdate.toString());
		 
		 setMsg("Successfully Saved");
		 return "success"; 
	 }
	 else
	 {
		 setDatehidden(masterdate.toString());
		 setMsg("Not Saved");
		 return "fail";
	 }
 }
 
 if(getMode().equalsIgnoreCase("E"))
 {
	 if(value>0)
	 {
		 setDatehidden(masterdate.toString());
			setMsg("Updated Successfully");
		 return "success"; 
	 }
	 else
	 {
		 setDatehidden(masterdate.toString());
		 setMsg("Not Updated");
		 return "fail";
	 }
	
 }
 
 if(getMode().equalsIgnoreCase("D"))
 {
	 if(value>0)
	 {
		 setDatehidden(masterdate.toString());
		 setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
	 }
	 else
	 {
		 setDatehidden(masterdate.toString());	
		 setMsg("Not Deleted");
	     
			 setDeleted("");
		 return "fail";
	 }
	 
 }
  
	return "fail";
 
	}
	 
	public String saveAction2() throws SQLException{
 
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	 
	 
	  java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getPtmdate());  
		
	 int value=ClsPropertyRelatedMasterDAO.saveT(masterdate,getDocno(),getMode(),getPtmtype(),getPcode(),session,request,getFormdetailcode());
			
	 
	 if(getMode().equalsIgnoreCase("A"))
	 {
		 if(value>0)
		 {
			 setDocno(value);
			 
			 setDatehidden(masterdate.toString());
			 
			 setMsg("Successfully Saved");
			 return "success"; 
		 }
		 else
		 {
			 setDatehidden(masterdate.toString());
			 setMsg("Not Saved");
			 return "fail";
		 }
		
			
	 }
	 
	 
	 
	 if(getMode().equalsIgnoreCase("E"))
	 {
		 if(value>0)
		 {
			 setDatehidden(masterdate.toString());
				setMsg("Updated Successfully");
			 return "success"; 
		 }
		 else
		 {
			 setDatehidden(masterdate.toString());
			 setMsg("Not Updated");
			 return "fail";
		 }
		
			
	 }
	 
	 
	 
	 if(getMode().equalsIgnoreCase("D"))
	 {
		 if(value>0)
		 {
			 setDatehidden(masterdate.toString());
			 setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
		 }
		 else
		 {
			 setDatehidden(masterdate.toString());	
			 setMsg("Not Deleted");
		     
				 setDeleted("");
			 return "fail";
		 }
		
			
	 }
	 
	 
		return "fail";
	 
		}
		
	
	
	public String saveAction3() throws SQLException{

		 
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	 
	 
	  java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getUdate());  
		
	 int value=ClsPropertyRelatedMasterDAO.saveU(masterdate,getDocno(),getMode(),getPrtypeid(),getUnit(),session,request,getFormdetailcode());
			
	 
	 if(getMode().equalsIgnoreCase("A"))
	 {
		 if(value>0)
		 {
			 setDocno(value);
			 
			 setHidudate(masterdate.toString());
			 
			 setMsg("Successfully Saved");
			 return "success"; 
		 }
		 else
		 {
			 setHidudate(masterdate.toString());
			 setMsg("Not Saved");
			 return "fail";
		 }
		
			
	 }
	 
	 
	 
	 if(getMode().equalsIgnoreCase("E"))
	 {
		 if(value>0)
		 {
			 setHidudate(masterdate.toString());
				setMsg("Updated Successfully");
			 return "success"; 
		 }
		 else
		 {
			 setHidudate(masterdate.toString());
			 setMsg("Not Updated");
			 return "fail";
		 }
		
			
	 }
	 
	 
	 
	 if(getMode().equalsIgnoreCase("D"))
	 {
		 if(value>0)
		 {
			 setHidudate(masterdate.toString());
			 setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
		 }
		 else
		 {
			 setHidudate(masterdate.toString());
			 setMsg("Not Deleted");
		     
				 setDeleted("");
			 return "fail";
		 }
		
			
	 }
	 
	 
		return "fail";
	 
		}
	
}
 
