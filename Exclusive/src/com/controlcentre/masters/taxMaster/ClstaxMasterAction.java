package com.controlcentre.masters.taxMaster;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;



public class ClstaxMasterAction {
	
	ClsCommon ClsCommon=new ClsCommon();		
		
	private int docno;
	private String date_coun;
	private int txtprovinceid;
	private int txttypeid;
	private String txttaxname;
	private String txttaxcode;
	private double txtpercentage;
	private double txtcst;
	private String txtappliedon;
	private String  fromdate;
	private String todate;	
	private int accdocno;
	private int status;
	private String txtalice;
	
	private int hidtype;
	private String msg; 
	
	private String hidedate_coun;
	private String txtprovince;
	private String txtprotype;
	private String txtaccname,txtaccno;
	
	private String mode;	
	private String formdetailcode;
	private String deleted;
	
	private String hidtodate;
	 private String hidfromdate;
	 
	 
	 
	 public String getHidtodate() {
	  return hidtodate;
	 }
	 public void setHidtodate(String hidtodate) {
	  this.hidtodate = hidtodate;
	 }
	 public String getHidfromdate() {
	  return hidfromdate;
	 }
	 public void setHidfromdate(String hidfromdate) {
	  this.hidfromdate = hidfromdate;
	 }
	
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	

	public int getHidtype() {
		return hidtype;
	}
	public void setHidtype(int hidtype) {
		this.hidtype = hidtype;
	}
	public String getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(String txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getTxtprovince() {
		return txtprovince;
	}
	public void setTxtprovince(String txtprovince) {
		this.txtprovince = txtprovince;
	}
	public String getTxtprotype() {
		return txtprotype;
	}
	public void setTxtprotype(String txtprotype) {
		this.txtprotype = txtprotype;
	}
	public String getTxtaccname() {
		return txtaccname;
	}
	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate_coun() {
		return date_coun;
	}
	public void setDate_coun(String date_coun) {
		this.date_coun = date_coun;
	}
	public int getTxtprovinceid() {
		return txtprovinceid;
	}
	public void setTxtprovinceid(int txtprovinceid) {
		this.txtprovinceid = txtprovinceid;
	}
	public int getTxttypeid() {
		return txttypeid;
	}
	public void setTxttypeid(int txttypeid) {
		this.txttypeid = txttypeid;
	}
	public String getTxttaxname() {
		return txttaxname;
	}
	public void setTxttaxname(String txttaxname) {
		this.txttaxname = txttaxname;
	}
	public String getTxttaxcode() {
		return txttaxcode;
	}
	public void setTxttaxcode(String txttaxcode) {  
		this.txttaxcode = txttaxcode;
	}
	public double getTxtpercentage() {
		return txtpercentage;
	}
	public void setTxtpercentage(double txtpercentage) {
		this.txtpercentage = txtpercentage;
	}
	public double getTxtcst() {
		return txtcst;
	}
	public void setTxtcst(double txtcst) {
		this.txtcst = txtcst;
	}
	public String getTxtappliedon() {
		return txtappliedon;
	}
	public void setTxtappliedon(String txtappliedon) {
		this.txtappliedon = txtappliedon;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) { 
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public int getAccdocno() {
		return accdocno;
	}
	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getTxtalice() {
		return txtalice;
	}
	public void setTxtalice(String txtalice) {
		this.txtalice = txtalice;
	}
	public String getHidedate_coun() {
		return hidedate_coun;
	}
	public void setHidedate_coun(String hidedate_coun) {
		this.hidedate_coun = hidedate_coun;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	

		
	

	
	public String savetaxtMaster() throws ParseException, SQLException
	  {
		
		
		String result="";
		try{
				ClstaxMasterDAO taxDAO= new ClstaxMasterDAO();
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				String mode=getMode();
				String formcode="";
				int val=0;
				System.out.println("==mode===="+mode);	
				Map<String, String[]> requestParams = request.getParameterMap();
				
				
		
				//System.out.println("==sqldate===="+getDate_coun());
				//System.out.println("==sqldate===="+getFromdate());
				//System.out.println("==sqldate===="+getTodate());
				
				java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getDate_coun());	
				java.sql.Date sqlfromDate = ClsCommon.changeStringtoSqlDate(getFromdate());	 
				java.sql.Date sqltoDate = ClsCommon.changeStringtoSqlDate(getTodate());	 
				
				
			
				if(mode.equalsIgnoreCase("A"))    
				{	  
														
					
				 
					val=ClstaxMasterDAO.insert(getDocno(),sqlDate,getTxtprovinceid(), getTxttypeid(),getTxttaxname(),
					getTxttaxcode(),getTxtpercentage(),getTxtcst(),getTxtappliedon(),sqlfromDate,sqltoDate,
					getAccdocno(),3,getTxtalice(),getMode(),getHidtype());
				
				
					
					
					if(val>0)
					{
							setHidtype(getHidtype());
						
							setTxtaccname(getTxtaccname());
							setAccdocno(getAccdocno());
							setTxtprotype(getTxtprotype());
							setTxtprovince(getTxtprovince());
							setDocno(val);

							setHidedate_coun(sqlDate.toString());
							setHidfromdate(sqlfromDate.toString());
						    setHidtodate(sqltoDate.toString());
							setMsg("Successfully Saved");
							result="success";
					}
					else
					{
							setMsg("Not Saved");
							result="fail";
							
					}
				
				}
		
				
				
				else if(mode.equalsIgnoreCase("D"))
				{
					val=ClstaxMasterDAO.delete(getDocno(),session);
					if(val>0)
					{
						
						setMsg("Successfully Deleted");
						setDeleted("DELETED");
						result="success";
					}
					else
					{
						result="fail";
						setMsg("failed");
					}
					
				}
			
				
				else if(mode.equalsIgnoreCase("E"))
				{
						
									val=taxDAO.update(getDocno(),sqlDate,getTxtprovinceid(), getTxttypeid(),getTxttaxname(),
									getTxttaxcode(),getTxtpercentage(),getTxtcst(),getTxtappliedon(),sqlfromDate,sqltoDate,
									getAccdocno(),3,getTxtalice(),getMode(),getHidtype());
						
						
						
						
						if(val>0)
						{
							setHidtype(getHidtype());
							setTxtaccname(getTxtaccname());
							setAccdocno(getAccdocno());
							setTxtprotype(getTxtprotype());
							setTxtprovince(getTxtprovince());

							setHidedate_coun(sqlDate.toString());
							setHidfromdate(sqlfromDate.toString());
						    setHidtodate(sqltoDate.toString());
							setDocno(val);
							setMsg("Updated Successfully");
							result="success";
						}
						else
						{
							result="fail";
							setMsg("Not Updated");
						}

						
					}		
		
		
		
		
		}
			finally
			{
				
			}
		return result;
		
		
	

	
	  }	
	


}
