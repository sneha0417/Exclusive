package com.humanresource.setup.preinduction;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 

public class ClspreinductionAction {
	ClsCommon ClsCommon =new ClsCommon();
	ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO();
	
	private String  masterdate, hidmasterdate, refno, designation,desc1,grade,report,mode ,deleted, msg,formdetailcode;
	private int docno, designationid,  noofpos,  gradeid, fromsal ,tosal ,reportid,masterdoc_no, lenght1, lenght2, lenght3;
 
	java.sql.Date masterdate1=null;
	
 

	public int getLenght1() {
		return lenght1;
	}

	public void setLenght1(int lenght1) {
		this.lenght1 = lenght1;
	}

	public int getLenght2() {
		return lenght2;
	}

	public void setLenght2(int lenght2) {
		this.lenght2 = lenght2;
	}

	public int getLenght3() {
		return lenght3;
	}

	public void setLenght3(int lenght3) {
		this.lenght3 = lenght3;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getDesignation() {        
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
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

	public int getDesignationid() {
		return designationid;
	}

	public void setDesignationid(int designationid) {   
		this.designationid = designationid;
	}

	public int getNoofpos() {
		return noofpos;
	}

	public void setNoofpos(int noofpos) {
		this.noofpos = noofpos;
	}

	public int getGradeid() {
		return gradeid;
	}

	public void setGradeid(int gradeid) {
		this.gradeid = gradeid;
	}

	public int getFromsal() {
		return fromsal;
	}

	public void setFromsal(int fromsal) {
		this.fromsal = fromsal;
	}

	public int getTosal() {
		return tosal;
	}

	public void setTosal(int tosal) {
		this.tosal = tosal;
	}

	public int getReportid() {
		return reportid;
	}

	public void setReportid(int reportid) {
		this.reportid = reportid;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

 
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
             ArrayList<String> descarray1= new ArrayList<>();
		
             ArrayList<String> descarray2= new ArrayList<>();
             ArrayList<String> descarray3= new ArrayList<>();
      		
     		
		if(!mode.equalsIgnoreCase("D"))
		{
		
		
			
			for(int i=0;i<getLenght1();i++){
				String temp2=requestParams.get("test1"+i)[0];
			 	descarray1.add(temp2);
			 
			} 
	 
		for(int i=0;i<getLenght2();i++){
			String temp2=requestParams.get("test2"+i)[0];
		 	descarray2.add(temp2);
		 
		} 
 
		for(int i=0;i<getLenght3();i++){
			String temp2=requestParams.get("test3"+i)[0];
		 	descarray3.add(temp2);
		 
		} 
		}
		
	 
			masterdate1 = ClsCommon.changeStringtoSqlDate(getMasterdate());	
			int val=ClspreinductionDAO.insert1(masterdate1, session,request,mode,getMasterdoc_no(),getRefno(),getDesc1(), getDesignationid(),
					getNoofpos(),getGradeid(),getFromsal(), getTosal(),getReportid(),getFormdetailcode(),getDocno(),descarray1,descarray2,descarray3);
			
			if(val>0.0){
				int vdocno=(int) request.getAttribute("vocno");
				setDocno(vdocno);
				setMasterdoc_no(vdocno);
				setRefno(getRefno());
				setDesignation(getDesignation());
				setDesignationid(getDesignationid());
				setDesc1(getDesc1());
				setNoofpos(getNoofpos());
				setGrade(getGrade());
				setGradeid(getGradeid());
				setFromsal(getFromsal());
				setTosal(getTosal());
				setReport(getReport());
				setReportid(getReportid());
				setHidmasterdate(masterdate1.toString());
				setGrade(getGrade());
			
			if(mode.equalsIgnoreCase("A"))
			{
				
				
				 setMsg("Successfully Saved");
				 
			}

			if(mode.equalsIgnoreCase("E"))
			{
				
				setMsg("Updated Successfully");
				 
			}
			

			if(mode.equalsIgnoreCase("D"))
			{
				
				 setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				  
			}
			
				
				return "success";
			}
			else
			{
				
				setHidmasterdate(masterdate1.toString());
				setMasterdoc_no(0);
				
				setRefno(getRefno());
				setDesignation(getDesignation());
				setDesignationid(getDesignationid());
				setDesc1(getDesc1());
				setNoofpos(getNoofpos());
				setGrade(getGrade());
				setGradeid(getGradeid());
				
				setFromsal(getFromsal());
				setTosal(getTosal());
				
				setReport(getReport());
				setReportid(getReportid());
				
				if(mode.equalsIgnoreCase("A"))
				{
					setDocno(0);
					 setMsg("Not Saved");
				}
				if(mode.equalsIgnoreCase("E"))
				{
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
					 setMsg("Not Updated");
				}
				if(mode.equalsIgnoreCase("D"))
				{ setDocno(getDocno());
					 setMsg("Not Deleted");
						setMasterdoc_no(getMasterdoc_no());
					 setDeleted("");
				}
				
				
				return "fail";
			}
			
		}
		
	 
	 
	
}
