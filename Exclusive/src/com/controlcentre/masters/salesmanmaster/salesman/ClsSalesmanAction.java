package com.controlcentre.masters.salesmanmaster.salesman;

import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

	@SuppressWarnings("serial")
	public class ClsSalesmanAction extends ActionSupport{
		
		ClsCommon ClsCommon=new ClsCommon();

		ClsSalesmanDAO salesmanDAO= new ClsSalesmanDAO();
		
		private int docno;
		private String salesmanid;
		private String salesmanname;
		private String commission;
		private String txtaccno;
		private String target;
		private String telephone;
		private String mode;
		private String delete;
		private String salesmanmail;
		private String salesmandate;
		private String hidsalesmandate;
		private String msg;
		private String txtaccname;
		private String formdetail;
		private String formdetailcode;
		private String chkstatus;
		private String hidacno;
		
		public String getHidacno() {
			return hidacno;
		}
		public void setHidacno(String hidacno) {
			this.hidacno = hidacno;
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
		public String getTxtaccname() {
			return txtaccname;
		}
		public void setTxtaccname(String txtaccname) {
			this.txtaccname = txtaccname;
		}
		public String getMsg() {
			return msg;
		}
		public void setMsg(String msg) {
			this.msg = msg;
		}
		public String getHidsalesmandate() {
			return hidsalesmandate;
		}
		public void setHidsalesmandate(String hidsalesmandate) {
			this.hidsalesmandate = hidsalesmandate;
		}
		public String getSalesmandate() {
			return salesmandate;
		}
		public void setSalesmandate(String salesmandate) {
			this.salesmandate = salesmandate;
		}
		public String getSalesmanmail() {
			return salesmanmail;
		}
		public void setSalesmanmail(String salesmanmail) {
			this.salesmanmail = salesmanmail;
		}
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
		}
		public String getSalesmanid() {
			return salesmanid;
		}
		public void setSalesmanid(String salesmanid) {
			this.salesmanid = salesmanid;
		}
		public String getSalesmanname() {
			return salesmanname;
		}
		public void setSalesmanname(String salesmanname) {
			this.salesmanname = salesmanname;
		}
		
		public String getTxtaccno() {
			return txtaccno;
		}
		public void setTxtaccno(String txtaccno) {
			this.txtaccno = txtaccno;
		}
		public String getCommission() {
			return commission;
		}
		public void setCommission(String commission) {
			this.commission = commission;
		}
		public String getTarget() {
			return target;
		}
		public void setTarget(String target) {
			this.target = target;
		}
		public String getTelephone() {
			return telephone;
		}
		public void setTelephone(String telephone) {
			this.telephone = telephone;
		}
		public String getMode() {
			return mode;
		}
		public void setMode(String mode) {
			this.mode = mode;
		}
		
		public String getDelete() {
			return delete;
		}
		public void setDelete(String delete) {
			this.delete = delete;
		}
		public String getChkstatus() {
			return chkstatus;
		}
		public void setChkstatus(String chkstatus) {
			this.chkstatus = chkstatus;
		}
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			
			String mode=getMode();
			java.sql.Date SalesmanDate = ClsCommon.changeStringtoSqlDate(getSalesmandate());

			if(mode.equalsIgnoreCase("A")){
				
							int val=salesmanDAO.insert(getSalesmanid(), getSalesmanname(),getHidacno(),getCommission(),getTarget(),getTelephone(),getMode(),session,getSalesmanmail(),SalesmanDate,getFormdetailcode());
							if(val>0){
								//setDatehidden(getDate_brand());
								setHidacno(getHidacno());
								setSalesmanid(getSalesmanid());
								setSalesmanname(getSalesmanname());
								setTxtaccno(getTxtaccno());
								setCommission(getCommission());
								setTarget(getTarget());
								setTelephone(getTelephone());
								setSalesmanmail(getSalesmanmail());
								setHidsalesmandate(SalesmanDate.toString());			
								setDocno(val);
								setTxtaccname(getTxtaccname());
								setMsg("Successfully Saved");
								return "success";
							}
							else if(val==-1){
								setHidacno(getHidacno());
								setSalesmanid(getSalesmanid());
								setSalesmanname(getSalesmanname());
								setTxtaccno(getTxtaccno());
								setCommission(getCommission());
								setTarget(getTarget());
								setTelephone(getTelephone());
								setSalesmanmail(getSalesmanmail());
								setHidsalesmandate(SalesmanDate.toString());			
								setDocno(val);
								setTxtaccname(getTxtaccname());
								setChkstatus("1");
								setMsg("Code Already Exists.");
								return "fail";
							}
							else if(val==-2){
								setHidacno(getHidacno());
								setSalesmanid(getSalesmanid());
								setSalesmanname(getSalesmanname());
								setTxtaccno(getTxtaccno());
								setCommission(getCommission());
								setTarget(getTarget());
								setTelephone(getTelephone());
								setSalesmanmail(getSalesmanmail());
								setHidsalesmandate(SalesmanDate.toString());			
								setDocno(val);
								setTxtaccname(getTxtaccname());
								setChkstatus("1");
								setMsg("Name Already Exists.");
								return "fail";
							}
							else if(val==-3){
								setHidacno(getHidacno());
								setSalesmanid(getSalesmanid());
								setSalesmanname(getSalesmanname());
								setTxtaccno(getTxtaccno());
								setCommission(getCommission());
								setTarget(getTarget());
								setTelephone(getTelephone());
								setSalesmanmail(getSalesmanmail());
								setHidsalesmandate(SalesmanDate.toString());			
								setDocno(val);
								setTxtaccname(getTxtaccname());
								setChkstatus("1");
								setMsg("Account Already Exists.");
								return "fail";
							}
							else{
								setHidacno(getHidacno());
								setSalesmanid(getSalesmanid());
								setSalesmanname(getSalesmanname());
								setTxtaccno(getTxtaccno());
								setCommission(getCommission());
								setTarget(getTarget());
								setTelephone(getTelephone());
								setSalesmanmail(getSalesmanmail());
								setHidsalesmandate(SalesmanDate.toString());			
								setDocno(val);
								setTxtaccname(getTxtaccname());
								setMsg("Not Saved");
								return "fail";
							}	
			}
			
			else if(mode.equalsIgnoreCase("E")){
				int Status=salesmanDAO.edit(getSalesmanid() , getSalesmanname() , getHidacno() , getCommission() , getTarget() ,getTelephone(), getDocno() , getMode() , session,getSalesmanmail(),SalesmanDate,getFormdetailcode());
				if(Status>0){
					setHidacno(getHidacno());
					setSalesmanid(getSalesmanid());
					setSalesmanname(getSalesmanname());
					setTxtaccno(getTxtaccno());
					setCommission(getCommission());
					setTarget(getTarget());
					setTelephone(getTelephone());
					setSalesmanmail(getSalesmanmail());
					setDocno(getDocno());
					setMode(getMode());
					setTxtaccname(getTxtaccname());

					setHidsalesmandate(SalesmanDate.toString());
					setMsg("Updated Successfully");
					
					return "success";
				}
				else if(Status==-1){

					setHidacno(getHidacno());
					setSalesmanid(getSalesmanid());
					setSalesmanname(getSalesmanname());
					setTxtaccno(getTxtaccno());
					setCommission(getCommission());
					setTarget(getTarget());
					setTelephone(getTelephone());
					setSalesmanmail(getSalesmanmail());
					setDocno(getDocno());
					setMode(getMode());
					setTxtaccname(getTxtaccname());

					setHidsalesmandate(SalesmanDate.toString());

					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(Status==-2){

					setHidacno(getHidacno());
					setSalesmanid(getSalesmanid());
					setSalesmanname(getSalesmanname());
					setTxtaccno(getTxtaccno());
					setCommission(getCommission());
					setTarget(getTarget());
					setTelephone(getTelephone());
					setSalesmanmail(getSalesmanmail());
					setDocno(getDocno());
					setMode(getMode());
					setTxtaccname(getTxtaccname());

					setHidsalesmandate(SalesmanDate.toString());

					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(Status==-3){

					setHidacno(getHidacno());
					setSalesmanid(getSalesmanid());
					setSalesmanname(getSalesmanname());
					setTxtaccno(getTxtaccno());
					setCommission(getCommission());
					setTarget(getTarget());
					setTelephone(getTelephone());
					setSalesmanmail(getSalesmanmail());
					setDocno(getDocno());
					setMode(getMode());
					setTxtaccname(getTxtaccname());

					setHidsalesmandate(SalesmanDate.toString());

					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{

					setHidacno(getHidacno());
					setSalesmanid(getSalesmanid());
					setSalesmanname(getSalesmanname());
					setTxtaccno(getTxtaccno());
					setCommission(getCommission());
					setTarget(getTarget());
					setTelephone(getTelephone());
					setSalesmanmail(getSalesmanmail());
					setDocno(getDocno());
					setMode(getMode());
					setTxtaccname(getTxtaccname());
					setHidsalesmandate(SalesmanDate.toString());

					setMsg("Not Updated");
					return "fail";
				}
			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=salesmanDAO.delete(getDocno(),session,getMode(),getFormdetailcode());
			if(Status){
				setHidacno(getHidacno());
				setSalesmanid(getSalesmanid());
				setSalesmanname(getSalesmanname());
				setTxtaccno(getTxtaccno());
				setCommission(getCommission());
				setTarget(getTarget());
				setTelephone(getTelephone());
				setSalesmanmail(getSalesmanmail());
				setHidsalesmandate(SalesmanDate.toString());
				setDocno(getDocno());
				setMode(getMode());
				setTxtaccname(getTxtaccname());

				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{

				setHidacno(getHidacno());
				setSalesmanid(getSalesmanid());
				setSalesmanname(getSalesmanname());
				setTxtaccno(getTxtaccno());
				setCommission(getCommission());
				setTarget(getTarget());
				setTelephone(getTelephone());
				setSalesmanmail(getSalesmanmail());
				setHidsalesmandate(SalesmanDate.toString());
				setDocno(getDocno());
				setMode(getMode());
				setTxtaccname(getTxtaccname());

				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
		
  }

	
