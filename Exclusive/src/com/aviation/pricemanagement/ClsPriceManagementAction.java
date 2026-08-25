package com.aviation.pricemanagement;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.google.common.collect.Sets.SetView;

public class ClsPriceManagementAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsPriceManagementDAO pmDAO=new ClsPriceManagementDAO();
	ClsPriceManagementBean viewBean=new ClsPriceManagementBean();
	private String hidcmbtype,msg,mode,deleted,masterdate,hidmasterdate,cmbtype,accdocno,puraccname,txtcurrency,currate,fromdate,hidfromdate,todate,hidtodate,desc1,part_no,pname;
	private int masterdoc_no,docno,puraccid,descgridlenght,currid,pmgridlength,hidpsrno;
	
	
	
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getAccdocno() {
		return accdocno;
	}
	public void setAccdocno(String accdocno) {
		this.accdocno = accdocno;
	}
	public String getPuraccname() {
		return puraccname;
	}
	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}
	public String getTxtcurrency() {
		return txtcurrency;
	}
	public void setTxtcurrency(String txtcurrency) {
		this.txtcurrency = txtcurrency;
	}
	public String getCurrate() {
		return currate;
	}
	public void setCurrate(String currate) {
		this.currate = currate;
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
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public String getPart_no() {
		return part_no;
	}
	public void setPart_no(String part_no) {
		this.part_no = part_no;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getPuraccid() {
		return puraccid;
	}
	public void setPuraccid(int puraccid) {
		this.puraccid = puraccid;
	}
	public int getDescgridlenght() {
		return descgridlenght;
	}
	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}
	
	
	
	public int getPmgridlength() {
		return pmgridlength;
	}
	public void setPmgridlength(int pmgridlength) {
		this.pmgridlength = pmgridlength;
	}
	public int getCurrid() {
		return currid;
	}
	public void setCurrid(int currid) {
		this.currid = currid;
	}
	public int getHidpsrno() {
		return hidpsrno;
	}
	public void setHidpsrno(int hidpsrno) {
		this.hidpsrno = hidpsrno;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date validfrom = ClsCommon.changeStringtoSqlDate(getFromdate());
		java.sql.Date validupto = ClsCommon.changeStringtoSqlDate(getTodate());
		
		if(mode.equalsIgnoreCase("A")){
			
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getPmgridlength();i++){
				String temp2=requestParams.get("pmtest"+i)[0];
				descarray.add(temp2);
			}
			int val=pmDAO.insert(masterdate, validfrom, validupto, getCmbtype(), getPuraccid(), getCurrid(),getDesc1(), getHidpsrno(), mode, session, request,descarray);
			int vocno=(int) request.getAttribute("vocno");
			if(val>0){
				setData();
				setDocno(vocno);
				setMasterdoc_no(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getPmgridlength();i++){
				String temp2=requestParams.get("pmtest"+i)[0];
				descarray.add(temp2);
			}
			boolean status=pmDAO.edit(getMasterdoc_no(),masterdate, validfrom, validupto, getCmbtype(), getPuraccid(), getCurrid(),getDesc1(), getHidpsrno(), mode, session, request,descarray);
			if(status){
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean val=pmDAO.delete(getMasterdoc_no(),session,mode);
			if(val)
			{
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
			    setDeleted("DELETED");
				setMsg("Successfully Deleted");
			    return "success";
			}
			else
			{
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
				setMsg("Not Deleted");
			    return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("view")){
			System.out.println("---view----");
			viewBean=pmDAO.getViewDetails(getMasterdoc_no() , session);
			setDocno(viewBean.getDocno());
			setMasterdoc_no(viewBean.getMasterdoc_no());
			setMasterdate(viewBean.getMasterdate());
			setHidcmbtype(viewBean.getCmbtype());
			setPuraccid(viewBean.getPuraccid());
			setPuraccname(viewBean.getPuraccname());
			setHidpsrno(viewBean.getHidpsrno());
			setPart_no(viewBean.getPart_no());
			setPname(viewBean.getPname());
			setTxtcurrency(viewBean.getTxtcurrency());
			setCurrate(viewBean.getCurrate());
			setCurrid(viewBean.getCurrid());
			setFromdate(viewBean.getFromdate());
			setTodate(viewBean.getTodate());
			setDesc1(viewBean.getDesc1());
			
		}
		return "success";
	}
	public void setData(){
		setMasterdate(getMasterdate());
		setHidmasterdate(getHidmasterdate());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setFromdate(getFromdate());
		setHidfromdate(getHidfromdate());
		setHidtodate(getHidtodate());
		setTodate(getTodate());
		
		setHidcmbtype(getCmbtype());
		//setCmbtype(getCmbtype());
		setPuraccid(getPuraccid());
		setCurrid(getCurrid());
		setDesc1(getDesc1());
		setPart_no(getPart_no());
		setMsg(getMsg());
		setDeleted(getDeleted());
	}
}
