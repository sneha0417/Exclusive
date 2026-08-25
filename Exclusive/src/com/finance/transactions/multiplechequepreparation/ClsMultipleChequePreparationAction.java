package com.finance.transactions.multiplechequepreparation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsMultipleChequePreparationAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsMultipleChequePreparationDAO multiChequePreparationDAO= new ClsMultipleChequePreparationDAO();
	ClsMultipleChequePreparationBean multiChequePreparationBean;
	
	private int txtmultiplechequepreparationdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxMultipleChequePreparationDate;
	private String hidjqxMultipleChequePreparationDate;
	private String txtrefno;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private String hidcmbfromcurrency;
	private double txtfromrate;
	private double txtfromamount;
	private double txtfrombaseamount;
	private String txtdescription;
	private String cmbtotype;
	private String hidcmbtotype;
	private int txttodocno;
	private int txttotrno;
	private int txttotranid;
	private String txttoaccid;
	private String txttoaccname;
	private String cmbtocurrency;
	private String hidcmbtocurrency;
	private double txttorate;
	private double txttobaseamount;
	private String hidfromcurrencytype;
	private String hidtocurrencytype;
	private String txtchequeno;
	private String jqxChequeDate;
	private String hidjqxChequeDate;
	
	private String txtchequeduration;
	private String cmbchequefrequency;
	private String hidcmbchequefrequency;
	private String txtnoofcheques;
	private double txtinstamt;
	
	private double txtdrtotal;
	private double txtcrtotal;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Cheque Details Grid
	private int gridlength;

	public int getTxtmultiplechequepreparationdocno() {
		return txtmultiplechequepreparationdocno;
	}
	
	public void setTxtmultiplechequepreparationdocno(
			int txtmultiplechequepreparationdocno) {
		this.txtmultiplechequepreparationdocno = txtmultiplechequepreparationdocno;
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
	
	public String getJqxMultipleChequePreparationDate() {
		return jqxMultipleChequePreparationDate;
	}
	
	public void setJqxMultipleChequePreparationDate(
			String jqxMultipleChequePreparationDate) {
		this.jqxMultipleChequePreparationDate = jqxMultipleChequePreparationDate;
	}
	
	public String getHidjqxMultipleChequePreparationDate() {
		return hidjqxMultipleChequePreparationDate;
	}
	
	public void setHidjqxMultipleChequePreparationDate(
			String hidjqxMultipleChequePreparationDate) {
		this.hidjqxMultipleChequePreparationDate = hidjqxMultipleChequePreparationDate;
	}
	
	public String getTxtrefno() {
		return txtrefno;
	}
	
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	
	public int getTxtfromdocno() {
		return txtfromdocno;
	}
	
	public void setTxtfromdocno(int txtfromdocno) {
		this.txtfromdocno = txtfromdocno;
	}
	
	public String getTxtfromaccid() {
		return txtfromaccid;
	}
	
	public void setTxtfromaccid(String txtfromaccid) {
		this.txtfromaccid = txtfromaccid;
	}
	
	public String getTxtfromaccname() {
		return txtfromaccname;
	}
	
	public void setTxtfromaccname(String txtfromaccname) {
		this.txtfromaccname = txtfromaccname;
	}
	
	public String getCmbfromcurrency() {
		return cmbfromcurrency;
	}
	
	public void setCmbfromcurrency(String cmbfromcurrency) {
		this.cmbfromcurrency = cmbfromcurrency;
	}
	
	public String getHidcmbfromcurrency() {
		return hidcmbfromcurrency;
	}
	
	public void setHidcmbfromcurrency(String hidcmbfromcurrency) {
		this.hidcmbfromcurrency = hidcmbfromcurrency;
	}
	
	public double getTxtfromrate() {
		return txtfromrate;
	}
	
	public void setTxtfromrate(double txtfromrate) {
		this.txtfromrate = txtfromrate;
	}
	
	public double getTxtfromamount() {
		return txtfromamount;
	}
	
	public void setTxtfromamount(double txtfromamount) {
		this.txtfromamount = txtfromamount;
	}
	
	public double getTxtfrombaseamount() {
		return txtfrombaseamount;
	}
	
	public void setTxtfrombaseamount(double txtfrombaseamount) {
		this.txtfrombaseamount = txtfrombaseamount;
	}
	
	public String getTxtdescription() {
		return txtdescription;
	}
	
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	
	public String getCmbtotype() {
		return cmbtotype;
	}
	
	public void setCmbtotype(String cmbtotype) {
		this.cmbtotype = cmbtotype;
	}
	
	public String getHidcmbtotype() {
		return hidcmbtotype;
	}
	
	public void setHidcmbtotype(String hidcmbtotype) {
		this.hidcmbtotype = hidcmbtotype;
	}
	
	public int getTxttodocno() {
		return txttodocno;
	}
	
	public void setTxttodocno(int txttodocno) {
		this.txttodocno = txttodocno;
	}
	
	public int getTxttotrno() {
		return txttotrno;
	}
	
	public void setTxttotrno(int txttotrno) {
		this.txttotrno = txttotrno;
	}
	
	public int getTxttotranid() {
		return txttotranid;
	}
	
	public void setTxttotranid(int txttotranid) {
		this.txttotranid = txttotranid;
	}
	
	public String getTxttoaccid() {
		return txttoaccid;
	}
	
	public void setTxttoaccid(String txttoaccid) {
		this.txttoaccid = txttoaccid;
	}
	
	public String getTxttoaccname() {
		return txttoaccname;
	}
	
	public void setTxttoaccname(String txttoaccname) {
		this.txttoaccname = txttoaccname;
	}
	
	public String getCmbtocurrency() {
		return cmbtocurrency;
	}
	
	public void setCmbtocurrency(String cmbtocurrency) {
		this.cmbtocurrency = cmbtocurrency;
	}
	
	public String getHidcmbtocurrency() {
		return hidcmbtocurrency;
	}
	
	public void setHidcmbtocurrency(String hidcmbtocurrency) {
		this.hidcmbtocurrency = hidcmbtocurrency;
	}
	
	public double getTxttorate() {
		return txttorate;
	}
	
	public void setTxttorate(double txttorate) {
		this.txttorate = txttorate;
	}
	
	public double getTxttobaseamount() {
		return txttobaseamount;
	}
	
	public void setTxttobaseamount(double txttobaseamount) {
		this.txttobaseamount = txttobaseamount;
	}
	
	public String getHidfromcurrencytype() {
		return hidfromcurrencytype;
	}
	
	public void setHidfromcurrencytype(String hidfromcurrencytype) {
		this.hidfromcurrencytype = hidfromcurrencytype;
	}
	
	public String getHidtocurrencytype() {
		return hidtocurrencytype;
	}
	
	public void setHidtocurrencytype(String hidtocurrencytype) {
		this.hidtocurrencytype = hidtocurrencytype;
	}
	
	public String getTxtchequeno() {
		return txtchequeno;
	}
	
	public void setTxtchequeno(String txtchequeno) {
		this.txtchequeno = txtchequeno;
	}
	
	public String getJqxChequeDate() {
		return jqxChequeDate;
	}
	
	public void setJqxChequeDate(String jqxChequeDate) {
		this.jqxChequeDate = jqxChequeDate;
	}
	
	public String getHidjqxChequeDate() {
		return hidjqxChequeDate;
	}
	
	public void setHidjqxChequeDate(String hidjqxChequeDate) {
		this.hidjqxChequeDate = hidjqxChequeDate;
	}
	
	public String getTxtchequeduration() {
		return txtchequeduration;
	}
	
	public void setTxtchequeduration(String txtchequeduration) {
		this.txtchequeduration = txtchequeduration;
	}
	
	public String getCmbchequefrequency() {
		return cmbchequefrequency;
	}
	
	public void setCmbchequefrequency(String cmbchequefrequency) {
		this.cmbchequefrequency = cmbchequefrequency;
	}
	
	public String getHidcmbchequefrequency() {
		return hidcmbchequefrequency;
	}
	
	public void setHidcmbchequefrequency(String hidcmbchequefrequency) {
		this.hidcmbchequefrequency = hidcmbchequefrequency;
	}
	
	public String getTxtnoofcheques() {
		return txtnoofcheques;
	}
	
	public void setTxtnoofcheques(String txtnoofcheques) {
		this.txtnoofcheques = txtnoofcheques;
	}
	
	public double getTxtinstamt() {
		return txtinstamt;
	}
	
	public void setTxtinstamt(double txtinstamt) {
		this.txtinstamt = txtinstamt;
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
	
	public String getMaindate() {
		return maindate;
	}
	
	public void setMaindate(String maindate) {
		this.maindate = maindate;
	}
	
	public String getHidmaindate() {
		return hidmaindate;
	}
	
	public void setHidmaindate(String hidmaindate) {
		this.hidmaindate = hidmaindate;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public int getGridlength() {
		return gridlength;
	}
	
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date multipleChequePreparationDate;
	java.sql.Date chequeDate;
	java.sql.Date hidmultipleChequePreparationDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsMultipleChequePreparationBean bean = new ClsMultipleChequePreparationBean();
		
		multipleChequePreparationDate = commonDAO.changeStringtoSqlDate(getJqxMultipleChequePreparationDate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		hidmultipleChequePreparationDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			Connection conn = null;
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			
			/*Cheque Details Grid Saving*/
			ArrayList<String> chequedetailsarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				chequedetailsarray.add(temp);
			}
			/*Cheque Details Grid Saving Ends*/
			
			/*Bank Payment Grid Saving*/
			ArrayList<String> bankpaymentarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				String[] chequedetails=temp.split("::");
				java.sql.Date chequesdate=(chequedetails[11].trim().equalsIgnoreCase("undefined") || chequedetails[11].trim().equalsIgnoreCase("NaN") || chequedetails[11].trim().equalsIgnoreCase("") ||  chequedetails[11].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(chequedetails[11].trim()));
				
				String strSql = "select acno,if(DATEDIFF('"+chequesdate+"', '"+multipleChequePreparationDate+"')>0,1,0) pdc from my_account where codeno='PDCPV'";
				ResultSet rs = stmt.executeQuery(strSql);
				
				String pdcaccount="",pdc="";
				while(rs.next()) {
					pdcaccount=rs.getString("acno");
					pdc=rs.getString("pdc");
				} 
				
				bankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+Double.parseDouble(chequedetails[4])*-1+"::"+getTxtdescription()+"::"+Double.parseDouble(chequedetails[6])*-1+"::0::0::0::"+pdc+"::"+pdcaccount+"::0::"+chequedetails[10]+"::"+chequedetails[11]);
				bankpaymentarray.add(chequedetails[0]+"::"+chequedetails[1]+"::"+chequedetails[2]+"::"+chequedetails[3]+"::"+chequedetails[4]+"::"+chequedetails[5]+"::"+chequedetails[6]+"::"+chequedetails[7]+"::"+chequedetails[8]+"::"+chequedetails[9]+"::"+pdc+"::"+pdcaccount+"::1::"+chequedetails[10]+"::"+chequedetails[11]);
				
			}
			/*Bank Payment Grid Saving Ends*/
			
						int val=multiChequePreparationDAO.insert(conn,multipleChequePreparationDate,getFormdetailcode(),getTxtrefno(),getTxtdescription(),getTxtfromdocno(),getCmbfromcurrency(),getTxtfromrate(),getTxtfromamount(),getTxtfrombaseamount(),getTxttodocno(),getTxtchequeno(),chequeDate,getTxtchequeduration(),getCmbchequefrequency(),getTxtnoofcheques(),chequedetailsarray,bankpaymentarray,session,request,mode);
						if(val>0.0){

							setTxtmultiplechequepreparationdocno(val);
							setData();
							conn.commit();
							stmt.close();
							conn.close();
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							stmt.close();
							conn.close();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("View")){
	
			multiChequePreparationBean=multiChequePreparationDAO.getViewDetails(session,getTxtmultiplechequepreparationdocno());
			
			setJqxMultipleChequePreparationDate(multiChequePreparationBean.getJqxMultipleChequePreparationDate());
			setTxtrefno(multiChequePreparationBean.getTxtrefno());
			
			setTxtfromdocno(multiChequePreparationBean.getTxtfromdocno());
			setTxtfromaccid(multiChequePreparationBean.getTxtfromaccid());
			setTxtfromaccname(multiChequePreparationBean.getTxtfromaccname());
			setHidcmbfromcurrency(multiChequePreparationBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(multiChequePreparationBean.getHidfromcurrencytype());
			setTxtfromrate(multiChequePreparationBean.getTxtfromrate());
			setTxtfromamount(multiChequePreparationBean.getTxtfromamount());
			setTxtfrombaseamount(multiChequePreparationBean.getTxtfrombaseamount());
			setTxtdescription(multiChequePreparationBean.getTxtdescription());
			
			setTxttodocno(multiChequePreparationBean.getTxttodocno());
			setHidcmbtotype(multiChequePreparationBean.getHidcmbtotype());
			setTxttoaccid(multiChequePreparationBean.getTxttoaccid());
			setTxttoaccname(multiChequePreparationBean.getTxttoaccname());
			setHidcmbtocurrency(multiChequePreparationBean.getHidcmbtocurrency());
			setHidtocurrencytype(multiChequePreparationBean.getHidtocurrencytype());
			setTxttorate(multiChequePreparationBean.getTxttorate());
			setTxttobaseamount(multiChequePreparationBean.getTxttobaseamount());
			setTxtchequeno(multiChequePreparationBean.getTxtchequeno());
			setJqxChequeDate(multiChequePreparationBean.getJqxChequeDate());
			setTxtchequeduration(multiChequePreparationBean.getTxtchequeduration());
			setHidcmbchequefrequency(multiChequePreparationBean.getHidcmbchequefrequency());
			setTxtnoofcheques(multiChequePreparationBean.getTxtnoofcheques());
			setTxtdrtotal(multiChequePreparationBean.getTxtdrtotal());
			setTxtcrtotal(multiChequePreparationBean.getTxtcrtotal());
			setMaindate(multiChequePreparationBean.getMaindate());
			setFormdetailcode(multiChequePreparationBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
}
	
	public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= multiChequePreparationDAO.mcpMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
	}
		
		public void setData() {
			
			setHidjqxMultipleChequePreparationDate(multipleChequePreparationDate.toString());
			setHidmaindate(hidmultipleChequePreparationDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
			setTxtfromrate(getTxtfromrate());
			setTxtfromamount(getTxtfromamount());
			setTxtfrombaseamount(getTxtfrombaseamount());
			setTxtdescription(getTxtdescription());
			
			setHidcmbtotype(getCmbtotype());
			setTxttodocno(getTxttodocno());
			setTxttoaccid(getTxttoaccid());
			setTxttoaccname(getTxttoaccname());
			setHidcmbtocurrency(getCmbtocurrency());
			setHidtocurrencytype(getHidtocurrencytype());
			setTxttorate(getTxttorate());
			setTxttobaseamount(getTxttobaseamount());
			setTxtchequeno(getTxtchequeno());
			setHidjqxChequeDate(chequeDate.toString());
			setTxtchequeduration(getTxtchequeduration());
			setHidcmbchequefrequency(getCmbchequefrequency());
			setTxtnoofcheques(getTxtnoofcheques());
			
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtdrtotal());
			setFormdetailcode(getFormdetailcode());
		}
		 
}
