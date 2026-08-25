package com.dashboard.accounts.postingnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPostingAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	ClsPostingDAO postingDAO=new ClsPostingDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String fromdate;
	private String hidfromdate;
	private String todate;
	private String hidtodate;
	private int chckibbranch;
	private int hidchckibbranch;
	private String txtibbranch;
	private String txtibbranchid;
	private String cmbtype;
	private String hidcmbtype;
	private String date;
	private String hiddate;
	private double txtdrtotal;
	private String txttrno;
	private String txtchequedescription;
	private int jvgridlength;
	private String txtselectedrno;
	private int txtdocno;
	
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

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getHidfromdate() {
		return hidfromdate;
	}

	public void setHidfromdate(String hidfromdate) {
		this.hidfromdate = hidfromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getHidtodate() {
		return hidtodate;
	}

	public void setHidtodate(String hidtodate) {
		this.hidtodate = hidtodate;
	}

	public int getChckibbranch() {
		return chckibbranch;
	}

	public void setChckibbranch(int chckibbranch) {
		this.chckibbranch = chckibbranch;
	}

	public int getHidchckibbranch() {
		return hidchckibbranch;
	}

	public void setHidchckibbranch(int hidchckibbranch) {
		this.hidchckibbranch = hidchckibbranch;
	}

	public String getTxtibbranch() {
		return txtibbranch;
	}

	public void setTxtibbranch(String txtibbranch) {
		this.txtibbranch = txtibbranch;
	}

	public String getTxtibbranchid() {
		return txtibbranchid;
	}

	public void setTxtibbranchid(String txtibbranchid) {
		this.txtibbranchid = txtibbranchid;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
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

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public String getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(String txttrno) {
		this.txttrno = txttrno;
	}
	public String getTxtchequedescription() {
		return txtchequedescription;
	}

	public void setTxtchequedescription(String txtchequedescription) {
		this.txtchequedescription = txtchequedescription;
	}
	public int getJvgridlength() {
		return jvgridlength;
	}

	public void setJvgridlength(int jvgridlength) {
		this.jvgridlength = jvgridlength;
	}

	public String getTxtselectedrno() {
		return txtselectedrno;
	}

	public void setTxtselectedrno(String txtselectedrno) {
		this.txtselectedrno = txtselectedrno;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}


	java.sql.Date dbFromDate;
	java.sql.Date dbToDate;
	java.sql.Date dbPostingDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		 Connection conn  = null;
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		String mode=getMode();
		
		dbFromDate = ClsCommon.changeStringtoSqlDate(getFromdate());
		dbToDate = ClsCommon.changeStringtoSqlDate(getTodate());
		dbPostingDate = ClsCommon.changeStringtoSqlDate(getDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Journal Grid Saving*/
			ArrayList<String> postingarray= new ArrayList<String>();
			
			for(int i=0;i<getJvgridlength();i++){
				String posttemp=requestParams.get("test"+i)[0];
				postingarray.add(posttemp);
			}
			/*Journal Grid Saving Ends*/
			
			/*Ib-Journal Grid Saving*/
			ArrayList<String> ibpostingarray= new ArrayList<String>();
			
			for(int i=0;i<getJvgridlength();i++){
				if(i==0){
					String ibposttemp=requestParams.get("test"+i)[0]+"::"+getCmbbranch()+"::"+getCmbbranch();
					ibpostingarray.add(ibposttemp);
				} else{
					String ibposttemp=requestParams.get("test"+i)[0]+"::"+getTxtibbranchid()+"::"+getCmbbranch();
					ibpostingarray.add(ibposttemp);
				}
			}
			/*Ib-Journal Grid Saving Ends*/
			
			String[] tranarray = getTxttrno().split("::");
			String dtype="";
			int val=postingDAO.insert(getHidchckibbranch(),getTxtibbranchid(),getCmbbranch(),getCmbtype(),dbPostingDate,getTxtdrtotal(),getTxtchequedescription(),getTxtselectedrno(),getTxtdocno(),tranarray,postingarray,ibpostingarray,session,request,mode);
			if(val>0.0){
				setDetail("Accounts");
				setDetailname("Posting");
				setHidfromdate(dbFromDate.toString());
				setHidtodate(dbToDate.toString());
				setHidchckibbranch(getHidchckibbranch());
				setTxtibbranch(getTxtibbranch());
				setHidcmbtype(getCmbtype());
				setHiddate(dbPostingDate.toString());
				if(getCmbtype().equalsIgnoreCase("3") || getCmbtype().equalsIgnoreCase("1")){
					dtype="COT";  
				}
				else if(getCmbtype().equalsIgnoreCase("2") && getHidchckibbranch()==0){
					dtype="JVT";  
				}
				else if(getCmbtype().equalsIgnoreCase("2") && getHidchckibbranch()==1){  
					dtype="IJV";     
				}else{   
					dtype="";   
				}    
				setMsg(dtype+"-"+val+"  Successfully Generated"); 
				return "success";   
			}
			else{
				setDetail("Accounts");
				setDetailname("Posting");
				setHidfromdate(dbFromDate.toString());
				setHidtodate(dbToDate.toString());
				setHidchckibbranch(getHidchckibbranch());
				setTxtibbranch(getTxtibbranch());
				setHidcmbtype(getCmbtype());
				setHiddate(dbPostingDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


