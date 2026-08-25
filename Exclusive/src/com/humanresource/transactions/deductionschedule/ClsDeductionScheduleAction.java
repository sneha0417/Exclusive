package com.humanresource.transactions.deductionschedule;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.finance.transactions.cashpayment.ClsCashPaymentDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsDeductionScheduleAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsDeductionScheduleDAO deductionScheduleDAO= new ClsDeductionScheduleDAO();
	ClsDeductionScheduleBean deductionScheduleBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String deductionScheduleDate;
	private String hiddeductionScheduleDate;
	private String txtemployeerefno;
	private int txtdeductionscheduledocno;
	private String txtemployeedetails;
	private int txtemployeedocno;
	private double txtamount;
	private int txtinstnos;
	private double txtinstamt;
	private String startDate;
	private String hidstartDate;
	private String txtdescription;
	
	//Deduction Schedule Grid
	private int gridlength;
	
	
	//Print
		private String lblcompname;
		private String lblcompaddress;
		private String lblpobox;
		private String lblprintname;
		private String lblcomptel;
		private String lblcompfax;
		private String lblbranch;
		private String lbllocation;
		private String lblservicetax;
		private String lblpan;
		private String lblcstno;
		private int srno;
		private int amount;
		private String date;
	
	
		//for hide
		private int firstarray;
		private int secarray;
		private int txtheader;
		
		private String url;
		
	
   

	    
		
	    public int getAmount() {
			return amount;
		}

		public void setAmount(int amount) {
			this.amount = amount;
		}

		public String getDate() {
			return date;
		}

		public void setDate(String date) {
			this.date = date;
		}

		public int getSrno() {
			return srno;
		}

		public void setSrno(int srno) {
			this.srno = srno;
		}

		public String getLblpan() {
			return lblpan;
		}

		public void setLblpan(String lblpan) {
			this.lblpan = lblpan;
		}

		public String getLblcstno() {
			return lblcstno;
		}

		public void setLblcstno(String lblcstno) {
			this.lblcstno = lblcstno;
		}

	public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
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

		public String getLblpobox() {
			return lblpobox;
		}

		public void setLblpobox(String lblpobox) {
			this.lblpobox = lblpobox;
		}

		public String getLblprintname() {
			return lblprintname;
		}

		public void setLblprintname(String lblprintname) {
			this.lblprintname = lblprintname;
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

		public String getLblservicetax() {
			return lblservicetax;
		}

		public void setLblservicetax(String lblservicetax) {
			this.lblservicetax = lblservicetax;
		}

		public int getFirstarray() {
			return firstarray;
		}

		public void setFirstarray(int firstarray) {
			this.firstarray = firstarray;
		}

		public int getSecarray() {
			return secarray;
		}

		public void setSecarray(int secarray) {
			this.secarray = secarray;
		}

		public int getTxtheader() {
			return txtheader;
		}

		public void setTxtheader(int txtheader) {
			this.txtheader = txtheader;
		}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getDeductionScheduleDate() {
		return deductionScheduleDate;
	}

	public void setDeductionScheduleDate(String deductionScheduleDate) {
		this.deductionScheduleDate = deductionScheduleDate;
	}

	public String getHiddeductionScheduleDate() {
		return hiddeductionScheduleDate;
	}

	public void setHiddeductionScheduleDate(String hiddeductionScheduleDate) {
		this.hiddeductionScheduleDate = hiddeductionScheduleDate;
	}

	public String getTxtemployeerefno() {
		return txtemployeerefno;
	}

	public void setTxtemployeerefno(String txtemployeerefno) {
		this.txtemployeerefno = txtemployeerefno;
	}

	public int getTxtdeductionscheduledocno() {
		return txtdeductionscheduledocno;
	}

	public void setTxtdeductionscheduledocno(int txtdeductionscheduledocno) {
		this.txtdeductionscheduledocno = txtdeductionscheduledocno;
	}

	public String getTxtemployeedetails() {
		return txtemployeedetails;
	}

	public void setTxtemployeedetails(String txtemployeedetails) {
		this.txtemployeedetails = txtemployeedetails;
	}

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public int getTxtinstnos() {
		return txtinstnos;
	}

	public void setTxtinstnos(int txtinstnos) {
		this.txtinstnos = txtinstnos;
	}

	public double getTxtinstamt() {
		return txtinstamt;
	}

	public void setTxtinstamt(double txtinstamt) {
		this.txtinstamt = txtinstamt;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getHidstartDate() {
		return hidstartDate;
	}

	public void setHidstartDate(String hidstartDate) {
		this.hidstartDate = hidstartDate;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date deductionsScheduleDate;
	java.sql.Date startingDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsDeductionScheduleBean bean = new ClsDeductionScheduleBean();

		deductionsScheduleDate = ClsCommon.changeStringtoSqlDate(getDeductionScheduleDate());
		startingDate = ClsCommon.changeStringtoSqlDate(getStartDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Deduction Schedule Grid Saving*/
			ArrayList<String> deductionschedulearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				deductionschedulearray.add(temp);
			}
			/*Deduction Schedule Grid Saving Ends*/
			
			
						int val=deductionScheduleDAO.insert(getFormdetailcode(),deductionsScheduleDate,getTxtemployeerefno(),getTxtemployeedocno(),getTxtamount(),getTxtinstnos(),startingDate,getTxtinstamt(),getTxtdescription(),deductionschedulearray,session,request,mode);
						if(val>0.0){
							
							setTxtdeductionscheduledocno(val);
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setMsg("Not Saved");
							return "fail";
						}	
		} else if(mode.equalsIgnoreCase("E")){

			/*Deduction Schedule Grid Saving*/
			ArrayList<String> deductionschedulearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				deductionschedulearray.add(temp);
			}
			/*Deduction Schedule Grid Saving Ends*/
			
			boolean Status=deductionScheduleDAO.edit(getTxtdeductionscheduledocno(),getFormdetailcode(),deductionsScheduleDate,getTxtemployeerefno(),getTxtemployeedocno(),getTxtamount(),getTxtinstnos(),startingDate,getTxtinstamt(),getTxtdescription(),deductionschedulearray,session,request,mode);
			if(Status){

				setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
			
	  } else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=deductionScheduleDAO.delete(getTxtdeductionscheduledocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtdeductionscheduledocno(getTxtdeductionscheduledocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
		} else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			deductionScheduleBean=deductionScheduleDAO.getViewDetails(session,getTxtdeductionscheduledocno());
			
			setDeductionScheduleDate(deductionScheduleBean.getDeductionScheduleDate());
			setTxtemployeerefno(deductionScheduleBean.getTxtemployeerefno());
			setTxtemployeedetails(deductionScheduleBean.getTxtemployeedetails());
			setTxtemployeedocno(deductionScheduleBean.getTxtemployeedocno());
			setTxtamount(deductionScheduleBean.getTxtamount());
			setTxtinstnos(deductionScheduleBean.getTxtinstnos());
			setTxtinstamt(deductionScheduleBean.getTxtinstamt());
			setStartDate(deductionScheduleBean.getStartDate());
			setTxtdescription(deductionScheduleBean.getTxtdescription());
			setFormdetailcode(deductionScheduleBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	
	/*public  JSONArray searchDetails(HttpSession session,String empname,String docNo,String date,String amount){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= ClsDeductionScheduleDAO.dscMainSearch(session, empname, docNo, date, amount);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}*/
	
	
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		deductionScheduleBean= new ClsDeductionScheduleBean();    
		ArrayList<String> arraylist = deductionScheduleDAO.getPrintdetails(docno,session);
		request.setAttribute("details",arraylist);
		deductionScheduleBean=deductionScheduleDAO.getPrint(request,docno,branch,header);
		
		setUrl(ClsCommon.getPrintPath("DSC"));   
		setLblcompname(deductionScheduleBean.getLblcompname());
		setLblcompaddress(deductionScheduleBean.getLblcompaddress());
		setLblpobox(deductionScheduleBean.getLblpobox());
		setLblprintname(deductionScheduleBean.getLblprintname());
		setLblcomptel(deductionScheduleBean.getLblcomptel());
		setLblcompfax(deductionScheduleBean.getLblcompfax());
		setLblbranch(deductionScheduleBean.getLblbranch());
		setLbllocation(deductionScheduleBean.getLbllocation());
		setTxtdeductionscheduledocno(deductionScheduleBean.getTxtdeductionscheduledocno());
		setDeductionScheduleDate(deductionScheduleBean.getDeductionScheduleDate());
		setTxtemployeerefno(deductionScheduleBean.getTxtemployeerefno());
		setTxtemployeedetails(deductionScheduleBean.getTxtemployeedetails());
		setTxtamount(deductionScheduleBean.getTxtamount());
		setTxtinstnos(deductionScheduleBean.getTxtinstnos());
		setStartDate(deductionScheduleBean.getStartDate());
		setTxtdescription(deductionScheduleBean.getTxtdescription());
		
		
		
		// for hide
		setFirstarray(deductionScheduleBean.getFirstarray());
		setSecarray(deductionScheduleBean.getSecarray());
		setTxtheader(deductionScheduleBean.getTxtheader());
	
		return "print";
	}
	
	

	public void setData() {

    	    setTxtemployeerefno(getTxtemployeerefno());
    	    setTxtemployeedetails(getTxtemployeedetails());
    	    setTxtemployeedocno(getTxtemployeedocno());
    	    if(deductionsScheduleDate != null){
    	    setHiddeductionScheduleDate(deductionsScheduleDate.toString());
    	    }
    	    setTxtamount(getTxtamount());
    	    setTxtinstnos(getTxtinstnos());
    	    if(startingDate != null){
    	    setHidstartDate(startingDate.toString());
    	    }
    	    setTxtinstamt(getTxtinstamt());  
    	    setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
		}
}

