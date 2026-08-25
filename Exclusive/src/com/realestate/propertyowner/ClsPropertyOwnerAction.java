package com.realestate.propertyowner;

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
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPropertyOwnerAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsPropertyOwnerDAO propertyOwnerDAO= new ClsPropertyOwnerDAO();
	ClsPropertyOwnerBean propertyOwnerbean;

	private int docno,vocno,natid,txtOwnerId;

	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String hidjqxDate,jqxDate,txtejarino,txtprimeowner,txtcoowner1,txtcoowner2,
	jqxBirthDate,hidjqxBirthDate,txtaddress,txttelepho,txtmobpho,txtemail,txtpassport,
	txtissuedplace,jqxexpiryDate,hidjqxexpiryDate,txtnationality,txtbankname,txtaccountno,
	txtaccountname,txtbankaddress,txtbankcountry,txtbankswift,txtbankiban,txtbankremarks,
	txtaliasname,txtspecialinstructions,txttelepho2,txtmobpho2,txtemail2,hidowneraccount;
	
	public String getHidowneraccount() {
		return hidowneraccount;
	}

	public void setHidowneraccount(String hidowneraccount) {
		this.hidowneraccount = hidowneraccount;
	}


	private int accgridlength,splgridlength;
	
	public int getSplgridlength() {
		return splgridlength;
	}

	public void setSplgridlength(int splgridlength) {
		this.splgridlength = splgridlength;
	}

	public int getAccgridlength() {
		return accgridlength;
	}

	public void setAccgridlength(int accgridlength) {
		this.accgridlength = accgridlength;
	}

	public int getTxtOwnerId() {
		return txtOwnerId;
	}

	public void setTxtOwnerId(int txtOwnerId) {
		this.txtOwnerId = txtOwnerId;
	}
 
	public String getTxtspecialinstructions() {
		return txtspecialinstructions;
	}

	public void setTxtspecialinstructions(String txtspecialinstructions) {
		this.txtspecialinstructions = txtspecialinstructions;
	}

	public String getTxttelepho2() {
		return txttelepho2;
	}

	public void setTxttelepho2(String txttelepho2) {
		this.txttelepho2 = txttelepho2;
	}

	public String getTxtmobpho2() {
		return txtmobpho2;
	}

	public void setTxtmobpho2(String txtmobpho2) {
		this.txtmobpho2 = txtmobpho2;
	}

	public String getTxtemail2() {
		return txtemail2;
	}

	public void setTxtemail2(String txtemail2) {
		this.txtemail2 = txtemail2;
	}

	public String getTxtaliasname() {
		return txtaliasname;
	}

	public void setTxtaliasname(String txtaliasname) {
		this.txtaliasname = txtaliasname;
	}


	private String cmbcurrency;
	private String hidcmbcurrency;
		

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getVocno() {
		return vocno;
	}

	public void setVocno(int vocno) {
		this.vocno = vocno;
	}

	public String getJqxDate() {
		return jqxDate;
	}

	public void setJqxDate(String jqxDate) {
		this.jqxDate = jqxDate;
	}

	public String getHidjqxDate() {
		return hidjqxDate;
	}

	public void setHidjqxDate(String hidjqxDate) {
		this.hidjqxDate = hidjqxDate;
	}

	public String getTxtejarino() {
		return txtejarino;
	}

	public void setTxtejarino(String txtejarino) {
		this.txtejarino = txtejarino;
	}

	public String getTxtprimeowner() {
		return txtprimeowner;
	}

	public void setTxtprimeowner(String txtprimeowner) {
		this.txtprimeowner = txtprimeowner;
	}

	public String getTxtcoowner1() {
		return txtcoowner1;
	}

	public void setTxtcoowner1(String txtcoowner1) {
		this.txtcoowner1 = txtcoowner1;
	}

	public String getTxtcoowner2() {
		return txtcoowner2;
	}

	public void setTxtcoowner2(String txtcoowner2) {
		this.txtcoowner2 = txtcoowner2;
	}

	public String getJqxBirthDate() {
		return jqxBirthDate;
	}

	public void setJqxBirthDate(String jqxBirthDate) {
		this.jqxBirthDate = jqxBirthDate;
	}

	public String getHidjqxBirthDate() {
		return hidjqxBirthDate;
	}

	public void setHidjqxBirthDate(String hidjqxBirthDate) {
		this.hidjqxBirthDate = hidjqxBirthDate;
	}

	public String getTxttelepho() {
		return txttelepho;
	}

	public void setTxttelepho(String txttelepho) {
		this.txttelepho = txttelepho;
	}

	public String getTxtmobpho() {
		return txtmobpho;
	}

	public void setTxtmobpho(String txtmobpho) {
		this.txtmobpho = txtmobpho;
	}

	public String getTxtpassport() {
		return txtpassport;
	}

	public void setTxtpassport(String txtpassport) {
		this.txtpassport = txtpassport;
	}

	public String getTxtissuedplace() {
		return txtissuedplace;
	}

	public void setTxtissuedplace(String txtissuedplace) {
		this.txtissuedplace = txtissuedplace;
	}

	public String getJqxexpiryDate() {
		return jqxexpiryDate;
	}

	public void setJqxexpiryDate(String jqxexpiryDate) {
		this.jqxexpiryDate = jqxexpiryDate;
	}

	public String getHidjqxexpiryDate() {
		return hidjqxexpiryDate;
	}

	public void setHidjqxexpiryDate(String hidjqxexpiryDate) {
		this.hidjqxexpiryDate = hidjqxexpiryDate;
	}

	public String getTxtnationality() {
		return txtnationality;
	}

	public void setTxtnationality(String txtnationality) {
		this.txtnationality = txtnationality;
	}

	

	public int getNatid() {
		return natid;
	}

	public void setNatid(int natid) {
		this.natid = natid;
	}

	public String getTxtbankname() {
		return txtbankname;
	}

	public void setTxtbankname(String txtbankname) {
		this.txtbankname = txtbankname;
	}

	public String getTxtaccountno() {
		return txtaccountno;
	}

	public void setTxtaccountno(String txtaccountno) {
		this.txtaccountno = txtaccountno;
	}

	public String getTxtaccountname() {
		return txtaccountname;
	}

	public void setTxtaccountname(String txtaccountname) {
		this.txtaccountname = txtaccountname;
	}

	public String getTxtbankaddress() {
		return txtbankaddress;
	}

	public void setTxtbankaddress(String txtbankaddress) {
		this.txtbankaddress = txtbankaddress;
	}

	public String getTxtbankcountry() {
		return txtbankcountry;
	}

	public void setTxtbankcountry(String txtbankcountry) {
		this.txtbankcountry = txtbankcountry;
	}

	public String getTxtbankswift() {
		return txtbankswift;
	}

	public void setTxtbankswift(String txtbankswift) {
		this.txtbankswift = txtbankswift;
	}

	public String getTxtbankiban() {
		return txtbankiban;
	}

	public void setTxtbankiban(String txtbankiban) {
		this.txtbankiban = txtbankiban;
	}

	public String getTxtbankremarks() {
		return txtbankremarks;
	}

	public void setTxtbankremarks(String txtbankremarks) {
		this.txtbankremarks = txtbankremarks;
	}


	private String txtcontact;
	private String txtextno;

	

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	 

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}


	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}

	public String getTxtcontact() {
		return txtcontact;
	}

	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}

	public String getTxtextno() {
		return txtextno;
	}

	public void setTxtextno(String txtextno) {
		this.txtextno = txtextno;
	}
 
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
	   /* vendorDate = commonDAO.changeStringtoSqlDate(getJqxVendorDate());*/
		java.sql.Date sqlDate = commonDAO.changeStringtoSqlDate(getJqxDate());
		java.sql.Date sqlbirthdate = null;
		if(getJqxBirthDate()!=null){
		sqlbirthdate = commonDAO.changeStringtoSqlDate(getJqxBirthDate());
		}
		java.sql.Date sqlexpirydate = null;
		if(getJqxexpiryDate()!=null){
		sqlexpirydate = commonDAO.changeStringtoSqlDate(getJqxexpiryDate());
		}
		
		/* accGrid */
		ArrayList<String> accarray = new ArrayList<String>();
		for (int i = 0; i < getAccgridlength(); i++) {
			String spl = requestParams.get("txtaccdet" + i)[0];
			accarray.add(spl);
		}
		/* acc Ends */
		
		/* splGrid */
		ArrayList<String> splarray = new ArrayList<String>();
		for (int i = 0; i < getSplgridlength(); i++) {
			String splins = requestParams.get("splins" + i)[0];
			splarray.add(splins);         
		}
		/* spl Ends */    
		if(mode.equalsIgnoreCase("A")){
			 
						int val=propertyOwnerDAO.insert(sqlDate,getTxtejarino(),getTxtprimeowner(),getTxtcoowner1(),
								getTxtcoowner2(),sqlbirthdate,getTxtaddress(),getTxttelepho(),getTxtmobpho(),
								getTxtemail(),getTxtpassport(),getTxtissuedplace(),sqlexpirydate,getNatid(),
								getTxtbankname(),getTxtaccountno(),getTxtaccountname(),
								getTxtbankaddress(),getTxtbankcountry(),getTxtbankswift(),
								getTxtbankiban(),getTxtbankremarks(),getFormdetailcode(),getCmbcurrency(),getTxtspecialinstructions(),getTxttelepho2(),getTxtmobpho2(),getTxtemail2(),getTxtaliasname(),getTxtOwnerId(),accarray,splarray,session,request);
						System.out.println("val"+val);
						if(val>0){
							System.out.println("validation");
						setDocno(val);
						setTxtOwnerId(val);
						setVocno(Integer.parseInt(request.getAttribute("vocNo").toString()));
						setData();
						//setHidowneraccount(request.getAttribute("acno").toString()); 
						setHidjqxDate(sqlDate.toString());
						setHidjqxBirthDate(sqlbirthdate==null?"":sqlbirthdate.toString());
						setHidjqxexpiryDate(sqlexpirydate==null?"":sqlexpirydate.toString());
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							 
							setHidjqxDate(sqlDate.toString());
							setHidjqxBirthDate(sqlbirthdate==null?"":sqlbirthdate.toString());
							setHidjqxexpiryDate(sqlexpirydate==null?"":sqlexpirydate.toString());
							setMsg("Not Saved");
							return "fail";
						}
		
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=propertyOwnerDAO.edit(getDocno(),getVocno(),sqlDate,getTxtejarino(),getTxtprimeowner(),getTxtcoowner1(),
					getTxtcoowner2(),sqlbirthdate,getTxtaddress(),getTxttelepho(),getTxtmobpho(),
					getTxtemail(),getTxtpassport(),getTxtissuedplace(),sqlexpirydate,getNatid(),
					getTxtbankname(),getTxtaccountno(),getTxtaccountname(),
					getTxtbankaddress(),getTxtbankcountry(),getTxtbankswift(),
					getTxtbankiban(),getTxtbankremarks(),getFormdetailcode(),getCmbcurrency(),getTxtspecialinstructions(),getTxttelepho2(),getTxtmobpho2(),getTxtemail2(),getTxtaliasname(),getTxtOwnerId(),accarray,splarray,session,request);
			if(Status>0){
					
				setDocno(getDocno());
				setVocno(getVocno());
				setTxtOwnerId(getDocno());
				setHidjqxDate(sqlDate.toString());
				setHidjqxBirthDate(sqlbirthdate==null?"":sqlbirthdate.toString());
				setHidjqxexpiryDate(sqlexpirydate==null?"":sqlexpirydate.toString());
				setData();					
				setMsg("Updated Successfully");
			    return "success";
			}
			else{
				 
				setHidjqxDate(sqlDate.toString());
				setHidjqxBirthDate(sqlbirthdate==null?"":sqlbirthdate.toString());
				setHidjqxexpiryDate(sqlexpirydate==null?"":sqlexpirydate.toString());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=propertyOwnerDAO.delete(getDocno(),getFormdetailcode(),session,getMode());
		if(Status>0){
					
					setDocno(getDocno());
				
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		
		else{
			setDocno(getDocno());
			
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		
	
			else if(mode.equalsIgnoreCase("View")){
				System.out.println("=========="+getDocno());
				propertyOwnerbean=propertyOwnerDAO.getViewDetails(getDocno());
				setDocno(propertyOwnerbean.getDocno());
				setJqxDate(propertyOwnerbean.getJqxDate());
				setTxtprimeowner(propertyOwnerbean.getTxtprimeowner());
				setHidcmbcurrency(propertyOwnerbean.getHidcmbcurrency());
				setTxtejarino(propertyOwnerbean.getTxtejarino());
				setTxtcoowner1(propertyOwnerbean.getTxtcoowner1());
				setTxtcoowner2(propertyOwnerbean.getTxtcoowner2());
				setJqxBirthDate(propertyOwnerbean.getJqxBirthDate());
				setTxtaddress(propertyOwnerbean.getTxtaddress());
				setTxttelepho(propertyOwnerbean.getTxttelepho());
				setTxtmobpho(propertyOwnerbean.getTxtmobpho());
				setTxtemail(propertyOwnerbean.getTxtemail());
				setTxtpassport(propertyOwnerbean.getTxtpassport());
				setTxtissuedplace(propertyOwnerbean.getTxtissuedplace());
				setJqxexpiryDate(propertyOwnerbean.getJqxexpiryDate());
				setTxtnationality(propertyOwnerbean.getTxtnationality());
				setTxtbankname(propertyOwnerbean.getTxtbankname());
				setTxtaccountno(propertyOwnerbean.getTxtaccountno());
				setTxtaccountname(propertyOwnerbean.getTxtaccountname());
				setTxtbankaddress(propertyOwnerbean.getTxtbankaddress());
				setTxtbankcountry(propertyOwnerbean.getTxtbankcountry());
				setTxtbankswift(propertyOwnerbean.getTxtbankswift());
				setTxtbankiban(propertyOwnerbean.getTxtbankiban());
				setTxtbankremarks(propertyOwnerbean.getTxtbankremarks());
				setTxtaliasname(propertyOwnerbean.getTxtaliasname());
				setTxtspecialinstructions(propertyOwnerbean.getTxtspecialinstructions());
				setTxttelepho2(propertyOwnerbean.getTxttelepho2());
				setTxtmobpho2(propertyOwnerbean.getTxtmobpho2());
				setTxtemail2(propertyOwnerbean.getTxtemail2());
				setTxtOwnerId(propertyOwnerbean.getTxtOwnerId());				
				//setHidowneraccount(propertyOwnerbean.getHidowneraccount());
				/*setJqxVendorDate(vendorDetailsbean.getJqxVendorDate());
				setTxtcode(vendorDetailsbean.getTxtcode());
				setTxtvendorname(vendorDetailsbean.getTxtvendorname());
				setHidcmbcurrency(vendorDetailsbean.getHidcmbcurrency());
				setHidcmbcategory(vendorDetailsbean.getHidcmbcategory());
				setHidcmbaccgroup(vendorDetailsbean.getHidcmbaccgroup());
				setTxtaccount(vendorDetailsbean.getTxtaccount());
				setTxtcredit_period_min(vendorDetailsbean.getTxtcredit_period_min());
				setTxtcredit_period_max(vendorDetailsbean.getTxtcredit_period_max());
				setTxtcredit_limit(vendorDetailsbean.getTxtcredit_limit());
				setTxtaddress(vendorDetailsbean.getTxtaddress());
				setTxtaddress1(vendorDetailsbean.getTxtaddress1());
				setTxttel(vendorDetailsbean.getTxttel());
				setTxtmob(vendorDetailsbean.getTxtmob());
				setTxtoffice(vendorDetailsbean.getTxtoffice());
				setTxtfax(vendorDetailsbean.getTxtfax());
				setTxtemail(vendorDetailsbean.getTxtemail());
				setTxtcontact(vendorDetailsbean.getTxtcontact());
				setTxtextno(vendorDetailsbean.getTxtextno());
				setFormdetailcode(vendorDetailsbean.getFormdetailcode());*/
				
				
				
				return "success";
			}
			return "fail";
}

			public void setData() {
		
				setTxtaccountno(getTxtaccountno());
				setTxtaddress(getTxtaddress());
				
				setTxtemail(getTxtemail());
				setTxtcontact(getTxtcontact());
				setTxtextno(getTxtextno());
				setFormdetailcode(getFormdetailcode());
			}
	
}
