package com.humanresource.setup.hrsetup.agent;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

 
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsAgentAction {
	ClsCommon ClsCommon=new ClsCommon();

	ClsAgentDAO saveDAO= new ClsAgentDAO()	;
	
	private String agentdate,agent,remarks,mode,msg,deleted,chkstatus,datehidden,formdetailcode ;
	private int docno;
 
	public String getAgentdate() {
		return agentdate;
	}
	public void setAgentdate(String agentdate) {
		this.agentdate = agentdate;
	}
	public String getAgent() {
		return agent;
	}
	public void setAgent(String agent) {
		this.agent = agent;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	} 
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String saveAction() throws SQLException {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	
	if(getMode().equalsIgnoreCase("A")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getAgentdate());
 
		int val=saveDAO.insert(formdate,getAgent(),getRemarks(),getMode(),getFormdetailcode(),session,request);
		
		if(val>0) {
			
			 setDocno(val);
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());
				
			 setMsg("Successfully Saved");
			 return "success";
		} else if(val==-1) {
		    setDatehidden(formdate.toString());
		    setAgent(getAgent());
		    setRemarks(getRemarks());
		    setChkstatus("1");
		    
		    setMsg("Agent Already Exists");
	        return "fail";
		}  else {
			 
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());
			
			 setMsg("Not Saved");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("E")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getAgentdate());
 
		int val=saveDAO.Update(getDocno(),formdate,getAgent(),getRemarks(),getMode(),getFormdetailcode(),session,request);
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());
	 			
			 setMsg("Updated Successfully");
			 return "success";
		} else if(val==-1) {
			setDocno(getDocno());
		    setDatehidden(formdate.toString());
		    setAgent(getAgent());
		    setRemarks(getRemarks());
		    setChkstatus("2");
		    setMsg("Agent Already Exists");
	        return "fail";
		}  else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());

			 setMsg("Not Updated");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("D")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getAgentdate());
 
		int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request);
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());
			 
			 setDeleted("DELETED");
			 setMsg("Successfully Deleted");
			 return "success";
		} else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setAgent(getAgent());
			 setRemarks(getRemarks());
			 setMsg("Not Deleted");
             return "fail";
		}
	}
	return "fail";
	}
}
