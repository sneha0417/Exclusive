package com.humanresource.transactions.leaveopening;

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
public class ClsLeaveOpeningAction extends ActionSupport{

	ClsCommon commonDAO=new ClsCommon();

	ClsLeaveOpeningDAO leaveOpeningDAO = new ClsLeaveOpeningDAO();
	ClsLeaveOpeningBean leaveOpeningBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String leaveOpeningDate;
	private String hidleaveOpeningDate;
	private int txtleaveopeningdocno;
	
	//Leave Opening Grid
	private int gridlength;
	
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

	public String getLeaveOpeningDate() {
		return leaveOpeningDate;
	}

	public void setLeaveOpeningDate(String leaveOpeningDate) {
		this.leaveOpeningDate = leaveOpeningDate;
	}

	public String getHidleaveOpeningDate() {
		return hidleaveOpeningDate;
	}

	public void setHidleaveOpeningDate(String hidleaveOpeningDate) {
		this.hidleaveOpeningDate = hidleaveOpeningDate;
	}

	public int getTxtleaveopeningdocno() {
		return txtleaveopeningdocno;
	}

	public void setTxtleaveopeningdocno(int txtleaveopeningdocno) {
		this.txtleaveopeningdocno = txtleaveopeningdocno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date leaveOpenDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsLeaveOpeningBean bean = new ClsLeaveOpeningBean();

		leaveOpenDate = commonDAO.changeStringtoSqlDate(getLeaveOpeningDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Leave Opening Grid Saving*/
			ArrayList<String> leaveopeningarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				leaveopeningarray.add(temp);
			}
			/*Leave Opening Grid Saving Ends*/
			
			
						int val=leaveOpeningDAO.insert(getFormdetailcode(),leaveOpenDate,leaveopeningarray,session,request,mode);
						if(val>0.0){
							
							setTxtleaveopeningdocno(val);
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setMsg("Not Saved");
							return "fail";
						}	
		} else if(mode.equalsIgnoreCase("E")){

			/*Leave Opening Grid Saving*/
			ArrayList<String> leaveopeningarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				leaveopeningarray.add(temp);
			}
			/*Leave Opening Grid Saving Ends*/
			
			boolean Status=leaveOpeningDAO.edit(getTxtleaveopeningdocno(),getFormdetailcode(),leaveOpenDate,leaveopeningarray,session,request,mode);
			if(Status){

				setTxtleaveopeningdocno(getTxtleaveopeningdocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtleaveopeningdocno(getTxtleaveopeningdocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
			
	  } else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=leaveOpeningDAO.delete(getTxtleaveopeningdocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtleaveopeningdocno(getTxtleaveopeningdocno());
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

	public void setData() {

    	    if(leaveOpenDate != null){
    	    setHidleaveOpeningDate(leaveOpenDate.toString());
    	    }
			setFormdetailcode(getFormdetailcode());
		}
}

