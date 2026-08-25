package com.finance.posting.unclearedchequeprocessing;

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
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsUnclearedChequeProcessingAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsUnclearedChequeProcessingDAO unclrChqPostingDAO= new ClsUnclearedChequeProcessingDAO();
	ClsUnclearedChequeProcessingBean unclrChqPostingBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	
	private String jqxUnclearedChequeProcessingDate;
	private String hidjqxUnclearedChequeProcessingDate;
	private String jqxUnclearedChequeProcessFromDate;
	private String hidjqxUnclearedChequeProcessFromDate;
	private String jqxUnclearedChequeProcessToDate;
	private String hidjqxUnclearedChequeProcessToDate;
	private String postingDate;
	private String hidpostingDate;
	
	private String cmbtype;
	private String hidcmbtype;
	private String txtchqno;
	private String txtchqdt;
	private String txtchqname;
	private int chckpdc;
	private double txtfromrate;
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	private int txtdocno;
	private String txtgriddtype;
	
	//Bank Payment Grid
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

	public String getJqxUnclearedChequeProcessingDate() {
		return jqxUnclearedChequeProcessingDate;
	}

	public void setJqxUnclearedChequeProcessingDate(
			String jqxUnclearedChequeProcessingDate) {
		this.jqxUnclearedChequeProcessingDate = jqxUnclearedChequeProcessingDate;
	}

	public String getHidjqxUnclearedChequeProcessingDate() {
		return hidjqxUnclearedChequeProcessingDate;
	}

	public void setHidjqxUnclearedChequeProcessingDate(
			String hidjqxUnclearedChequeProcessingDate) {
		this.hidjqxUnclearedChequeProcessingDate = hidjqxUnclearedChequeProcessingDate;
	}

	public String getJqxUnclearedChequeProcessFromDate() {
		return jqxUnclearedChequeProcessFromDate;
	}

	public void setJqxUnclearedChequeProcessFromDate(
			String jqxUnclearedChequeProcessFromDate) {
		this.jqxUnclearedChequeProcessFromDate = jqxUnclearedChequeProcessFromDate;
	}

	public String getHidjqxUnclearedChequeProcessFromDate() {
		return hidjqxUnclearedChequeProcessFromDate;
	}

	public void setHidjqxUnclearedChequeProcessFromDate(
			String hidjqxUnclearedChequeProcessFromDate) {
		this.hidjqxUnclearedChequeProcessFromDate = hidjqxUnclearedChequeProcessFromDate;
	}

	public String getJqxUnclearedChequeProcessToDate() {
		return jqxUnclearedChequeProcessToDate;
	}

	public void setJqxUnclearedChequeProcessToDate(
			String jqxUnclearedChequeProcessToDate) {
		this.jqxUnclearedChequeProcessToDate = jqxUnclearedChequeProcessToDate;
	}

	public String getHidjqxUnclearedChequeProcessToDate() {
		return hidjqxUnclearedChequeProcessToDate;
	}

	public void setHidjqxUnclearedChequeProcessToDate(
			String hidjqxUnclearedChequeProcessToDate) {
		this.hidjqxUnclearedChequeProcessToDate = hidjqxUnclearedChequeProcessToDate;
	}

	public String getPostingDate() {
		return postingDate;
	}

	public void setPostingDate(String postingDate) {
		this.postingDate = postingDate;
	}

	public String getHidpostingDate() {
		return hidpostingDate;
	}

	public void setHidpostingDate(String hidpostingDate) {
		this.hidpostingDate = hidpostingDate;
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

	public String getTxtchqno() {
		return txtchqno;
	}

	public void setTxtchqno(String txtchqno) {
		this.txtchqno = txtchqno;
	}

	public String getTxtchqdt() {
		return txtchqdt;
	}

	public void setTxtchqdt(String txtchqdt) {
		this.txtchqdt = txtchqdt;
	}

	public String getTxtchqname() {
		return txtchqname;
	}

	public void setTxtchqname(String txtchqname) {
		this.txtchqname = txtchqname;
	}

	public int getChckpdc() {
		return chckpdc;
	}

	public void setChckpdc(int chckpdc) {
		this.chckpdc = chckpdc;
	}

	public double getTxtfromrate() {
		return txtfromrate;
	}

	public void setTxtfromrate(double txtfromrate) {
		this.txtfromrate = txtfromrate;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getTxtgriddtype() {
		return txtgriddtype;
	}

	public void setTxtgriddtype(String txtgriddtype) {
		this.txtgriddtype = txtgriddtype;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date processingDate;
	java.sql.Date fromDate;
	java.sql.Date toDate;
	java.sql.Date chequeDate;
	java.sql.Date postedDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsUnclearedChequeProcessingBean bean = new ClsUnclearedChequeProcessingBean();
		
		if(!(getJqxUnclearedChequeProcessingDate()==null || getJqxUnclearedChequeProcessingDate().equalsIgnoreCase(""))){
			processingDate = commonDAO.changeStringtoSqlDate(getJqxUnclearedChequeProcessingDate());	
		}
		if(!(getJqxUnclearedChequeProcessFromDate()==null || getJqxUnclearedChequeProcessFromDate().equalsIgnoreCase(""))){
			fromDate = commonDAO.changeStringtoSqlDate(getJqxUnclearedChequeProcessFromDate());
		}
		if(!(getJqxUnclearedChequeProcessToDate()==null || getJqxUnclearedChequeProcessToDate().equalsIgnoreCase(""))){
			toDate = commonDAO.changeStringtoSqlDate(getJqxUnclearedChequeProcessToDate());
		}
		if(!(getTxtchqdt()==null || getTxtchqdt().equalsIgnoreCase(""))){
			chequeDate = commonDAO.changeStringtoSqlDate(getTxtchqdt());
		}
		if(!(getPostingDate()==null || getPostingDate().equalsIgnoreCase(""))){
			postedDate = commonDAO.changeStringtoSqlDate(getPostingDate());
		}
		
		if(mode.equalsIgnoreCase("A")){
			Connection con  = null;
			 
			con = connDAO.getMyConnection();
			Statement stmt = con.createStatement();
			
			String strSql = "select acno from my_account where codeno='PDCPV'";
			ResultSet rs = stmt.executeQuery(strSql);
			
			String pdcaccount="";
			while(rs.next()) {
				pdcaccount=rs.getString("acno");
			} 
			
			stmt.close();
			con.close();
			
			/*Bank Payment Grid Saving*/
			ArrayList<String> bankpaymentarray= new ArrayList<String>();
						
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				bankpaymentarray.add(temp+":: "+pdcaccount);
			}
			/*Bank Payment Grid Saving Ends*/
			
			String[] bankpay=bankpaymentarray.get((getGridlength()-1)).split("::");
			
			int temps=0;
			if((getGridlength()-1)>0){
				temps = ((bankpay[11].equalsIgnoreCase("undefined") || bankpay[11].equalsIgnoreCase("NaN") || bankpay[11].isEmpty()?0:Integer.parseInt(bankpay[11].trim().toString())));
			}
			
			ArrayList<String> bankpaymentarray1= new ArrayList<String>();
			
			int a=0;
			String temp1="";
			for(int i=0;i<=temps;i++){
				if(a==0){
					temp1=requestParams.get("test"+i)[0];
				}
				else{
					temp1=requestParams.get("test"+(i-1))[0];
				}
				String[] bankpays=temp1.split("::");
				
				if(Integer.parseInt(bankpays[11].trim())==i){
					bankpaymentarray1.add(temp1+":: "+pdcaccount);
				}
				else{
					bankpaymentarray1.add("0 :: 0:: 0:: 0:: 0:: 0:: 0:: 0:: 0:: 0:: 0:: 0:: "+pdcaccount);
					a=1;
				}
			}
			
			ArrayList<String> bankpaymentsarray =new ArrayList<String>();

			if(getTxtgriddtype().equalsIgnoreCase("UCP")){
				for(int i=0;i< bankpaymentarray1.size();i++){
					String[] bankpayment=((String) bankpaymentarray1.get(i)).split("::");

					bankpaymentsarray.add(bankpayment[0]+"::"+bankpayment[1]+"::"+bankpayment[2]+"::"+bankpayment[3]+"::"+bankpayment[4]+"::"+bankpayment[5]+"::"+bankpayment[6]+"::"+bankpayment[7]+"::"+bankpayment[8]+"::"+bankpayment[9]+"::"+bankpayment[10]+"::"+pdcaccount);
				}
			}else if(getTxtgriddtype().equalsIgnoreCase("UCR")){
				for(int i=0;i< bankpaymentarray1.size();i++){
					String[] bankpayment=((String) bankpaymentarray1.get(i)).split("::");
					
					if(bankpayment[3].equalsIgnoreCase("true")){
						bankpayment[3]="false";
					}else if(bankpayment[3].equalsIgnoreCase("false")){
						bankpayment[3]="true";
					}
					
					bankpaymentsarray.add(bankpayment[0]+"::"+bankpayment[1]+"::"+bankpayment[2]+"::"+bankpayment[3]+"::"+bankpayment[4]+"::"+bankpayment[5]+"::"+bankpayment[6]+"::"+bankpayment[7]+"::"+bankpayment[8]+"::"+bankpayment[9]+"::"+bankpayment[10]+"::"+pdcaccount);
				}
			}
			
						int val=unclrChqPostingDAO.insert(getFormdetailcode(),postedDate,getTxtdocno(),getTxtgriddtype(),getTxtfromrate(),chequeDate,getTxtchqno(),getTxtchqname(),getChckpdc(),getTxtdrtotal(),bankpaymentsarray,session,request,mode);
						if(val>0.0){
							
							setData();
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		return "fail";
	}
	
	public void setData(){
		if(!(getJqxUnclearedChequeProcessingDate()==null || getJqxUnclearedChequeProcessingDate().equalsIgnoreCase(""))){
			setHidjqxUnclearedChequeProcessingDate(processingDate.toString());
		}
		if(!(getJqxUnclearedChequeProcessFromDate()==null || getJqxUnclearedChequeProcessFromDate().equalsIgnoreCase(""))){
			setHidjqxUnclearedChequeProcessFromDate(fromDate.toString());
		}
		if(!(getJqxUnclearedChequeProcessToDate()==null || getJqxUnclearedChequeProcessToDate().equalsIgnoreCase(""))){
			setHidjqxUnclearedChequeProcessToDate(toDate.toString());
		}
		if(!(getPostingDate()==null || getPostingDate().equalsIgnoreCase(""))){
			setHidpostingDate(postedDate.toString());
		}
		setHidcmbtype(getCmbtype());
		setTxtdocno(getTxtdocno());
		setTxtgriddtype(getTxtgriddtype());
		setFormdetailcode(getFormdetailcode());
	}
}
