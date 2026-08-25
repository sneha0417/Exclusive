package com.finance.accountssetup.accountsMaster;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 



 
public class ClsAccMasterAction {
	ClsAccMasterDAO accMasterDAO= new ClsAccMasterDAO();
	ClsCommon commonDAO= new ClsCommon();
	private String category;
	
	private String date_accountmaster;
	
	private int docno;
	private String mainaccgroup;	
	private String mainacccode;
	private String mainacconame;
	
	private String subaccgroup;
	private String subaccgpname;
	private String subacccode;
	private String subaccname;
	
	private String tansaccgroup;
	private String transcaccgpname;
	private String transacccode;
	private String transaccname;
	

	private String interbranch;
	private String branchone;
	private String branchtwo;
	private String mode;
	private String datehidden;
	
	private String main_account;
	private String sub_account;
	private String tran_account;
	
	private int doc;
    private String deleted;
    
    private int radiotick;
    // main acc check val
    private String checksetval;
    private String subchecksetval;
    private String tranchecksetval,formdetailcode;
 // for inter branch tick
    private String intertick;
    // for inter branch chk
    private String interbr1;
    private String interbr2;

	private int otherdis;
	private String msg;
	//	 for del chk
	 private int maindel;
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getInterbr1() {
		return interbr1;
	}

	public void setInterbr1(String interbr1) {
		this.interbr1 = interbr1;
	}

	public String getInterbr2() {
		return interbr2;
	}

	public void setInterbr2(String interbr2) {
		this.interbr2 = interbr2;
	}

	public String getIntertick() {
		return intertick;
	}

	public void setIntertick(String intertick) {
		this.intertick = intertick;
	}

	public String getSubchecksetval() {
		return subchecksetval;
	}

	public void setSubchecksetval(String subchecksetval) {
		this.subchecksetval = subchecksetval;
	}

	public String getTranchecksetval() {
		return tranchecksetval;
	}

	public void setTranchecksetval(String tranchecksetval) {
		this.tranchecksetval = tranchecksetval;
	}

	public String getChecksetval() {
		return checksetval;
	}

	public void setChecksetval(String checksetval) {
		this.checksetval = checksetval;
	}

	public int getRadiotick() {
		return radiotick;
	}

	public void setRadiotick(int radiotick) {
		this.radiotick = radiotick;
	}

	public int getDoc() {
		return doc;
	}

	public void setDoc(int doc) {
		this.doc = doc;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {

		this.category = category;
	}

	public String getDate_accountmaster() {
		return date_accountmaster;
	}

	public void setDate_accountmaster(String date_accountmaster) {
		this.date_accountmaster = date_accountmaster;
	}


	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getMainaccgroup() {
		return mainaccgroup;
	}

	public void setMainaccgroup(String mainaccgroup) {
		this.mainaccgroup = mainaccgroup;
	}

	public String getMainacccode() {
		return mainacccode;
	}

	public void setMainacccode(String mainacccode) {
		this.mainacccode = mainacccode;
	}

	public String getMainacconame() {
		return mainacconame;
	}

	public void setMainacconame(String mainacconame) {
		this.mainacconame = mainacconame;
	}
	

	public String getSubaccgroup() {
		return subaccgroup;
	}

	public void setSubaccgroup(String subaccgroup) {
		this.subaccgroup = subaccgroup;
	}

	public String getSubaccgpname() {
		return subaccgpname;
	}

	public void setSubaccgpname(String subaccgpname) {
		this.subaccgpname = subaccgpname;
	}

	public String getSubacccode() {
		return subacccode;
	}

	public void setSubacccode(String subacccode) {
		this.subacccode = subacccode;
	}

	public String getSubaccname() {
		return subaccname;
	}

	public void setSubaccname(String subaccname) {
		this.subaccname = subaccname;
	}

	
	public String getTansaccgroup() {
		return tansaccgroup;
	}

	public void setTansaccgroup(String tansaccgroup) {
		this.tansaccgroup = tansaccgroup;
	}

	public String getTranscaccgpname() {
		return transcaccgpname;
	}

	public void setTranscaccgpname(String transcaccgpname) {
		this.transcaccgpname = transcaccgpname;
	}

	public String getTransacccode() {
		return transacccode;
	}

	public void setTransacccode(String transacccode) {
		this.transacccode = transacccode;
	}

	public String getTransaccname() {
		return transaccname;
	}

	public void setTransaccname(String transaccname) {
		this.transaccname = transaccname;
	}



	public String getInterbranch() {
		return interbranch;
	}

	public void setInterbranch(String interbranch) {
		this.interbranch = interbranch;
	}

	public String getBranchone() {
		return branchone;
	}

	public void setBranchone(String branchone) {
		this.branchone = branchone;
	}

	public String getBranchtwo() {
		return branchtwo;
	}

	public void setBranchtwo(String branchtwo) {
		this.branchtwo = branchtwo;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	


	public String getDatehidden() {
		return datehidden;
	}

	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public String getMain_account() {
		return main_account;
	}

	public void setMain_account(String main_account) {
		this.main_account = main_account;
	}

	public String getSub_account() {
		return sub_account;
	}

	public void setSub_account(String sub_account) {
		this.sub_account = sub_account;
	}

	public String getTran_account() {
		return tran_account;
	}

	public void setTran_account(String tran_account) {
		this.tran_account = tran_account;
	}
	

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	
	
	


	public int getOtherdis() {
		return otherdis;
	}

	public void setOtherdis(int otherdis) {
		this.otherdis = otherdis;
	}
	
	
	// for del chk 
	public int getMaindel() {
		return maindel;
	}

	public void setMaindel(int maindel) {
		this.maindel = maindel;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	
	private String currs;
	private int currsid;
	private double ratess;

	
	
	
	public String getCurrs() {
		return currs;
	}

	public void setCurrs(String currs) {        
		this.currs = currs;
	}

	public int getCurrsid() {  
		return currsid;
	}

	public void setCurrsid(int currsid) {
		this.currsid = currsid;
	}

	public double getRatess() {
		return ratess;
	}

	public void setRatess(double ratess) {
		this.ratess = ratess;
	}

	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		java.sql.Date sqlStartDate = commonDAO.changeStringtoSqlDate(getDate_accountmaster());
		
		
		String mode=getMode();
		
		
		
		String accountGroup = "";
		String accountcode= "";
		String accountName= "";
		String accountgpName= "";
		String category= ""; /*m_s */
		String acccategory="";
		
		if(getCategory()!= null)
		{
			
		if(getCategory().equalsIgnoreCase("mainaccount"))
		{
		
			  accountGroup=getMainaccgroup();
			  accountcode=getMainacccode();
			 accountName=getMainacconame();
			 category="1";
			 acccategory=getMain_account();
		}
		else if(getCategory().equalsIgnoreCase("subaccount"))
			
			
			
		{
			 accountGroup=getSubaccgroup();
			 accountgpName=getSubaccgpname();
			  accountcode=getSubacccode();
			  accountName=getSubaccname();
			  category="1";
			  acccategory=getSub_account();
			  
		}
		else if(getCategory().equalsIgnoreCase("transaction"))
		{
			 accountGroup=getTansaccgroup();
			  accountcode=getTransacccode();
		  accountName=getTransaccname();
			  accountgpName= getTranscaccgpname();
			  category="0";
			  acccategory=getTran_account();
		}
			
		}
		
	
		
		if(mode.equalsIgnoreCase("A")){
			
			int val=accMasterDAO.insert(sqlStartDate,accountGroup,category,acccategory, accountcode,accountName,accountgpName,getBranchone(),
					getBranchtwo(),getInterbranch(), getMode(),session,getFormdetailcode(),request,getCurrsid(),getRatess(),getCategory());
			if(val>0){
				setDatehidden(sqlStartDate.toString());
				setRadiotick(getRadiotick());
			
				setDocno(val);
				//if(getMain_account().equalsIgnoreCase("mainacc"))
				 String account=(String) request.getAttribute("accountcode");
				if(acccategory.equalsIgnoreCase("mainacc"))
				{
					setMain_account(acccategory);
					setChecksetval(accountGroup);
					setMainacconame(accountName);
					setMainacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setMainacccode(String.valueOf(val));
					
					}
					else
					{
						setMainacccode(accountcode);
					}*/
					
						
				}
				else if(acccategory.equalsIgnoreCase("subacc"))
				{
					setSub_account(acccategory);
					//setSubaccgroup(accountGroup);
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					//setSubacccode(accountcode);
					setSubaccname(accountName);
					setSubacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(val));
					}
					else
					{
						setSubacccode(accountcode);
					}
						*/
					
				 
					
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
					//setTansaccgroup(accountGroup);
					//setTransacccode(accountcode);
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
					setTransacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setTransacccode(String.valueOf(val));
					}
					else
					{
						setTransacccode(accountcode);
					}
					*/
					setIntertick(getIntertick());
					
					setInterbr1(getBranchone());
					setInterbr2(getBranchtwo());
					
					setCurrs(getCurrs());
					setCurrsid(getCurrsid());
					setRatess(getRatess());
					
					   
					
				}
			
				
				setMsg("Successfully Saved");
				System.out.println(session.getAttribute("SAVED"));
				return "success";
			}
			
			else{
				setDatehidden(sqlStartDate.toString());
				setRadiotick(getRadiotick());
				setDocno(val);
				
				if(acccategory.equalsIgnoreCase("mainacc"))
				{
					
				
					setMain_account(acccategory);
					setChecksetval(accountGroup);
					setMainacconame(accountName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setMainacccode(String.valueOf(val));
					
					}
					else
					{
						setMainacccode(accountcode);
					}
						
				}
				else if(acccategory.equalsIgnoreCase("subacc"))
				{
					setSub_account(acccategory);
					//setSubaccgroup(accountGroup);
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					//setSubacccode(accountcode);
					setSubaccname(accountName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(val));
					}
					else
					{
						setSubacccode(accountcode);
					}
						
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
					//setTansaccgroup(accountGroup);
					//setTransacccode(accountcode);
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setTransacccode(String.valueOf(val));
					}
					else
					{
						setTransacccode(accountcode);
					}
					
					setIntertick(getIntertick());
					
					setInterbr1(getBranchone());
					setInterbr2(getBranchtwo());
					
					setCurrs(getCurrs());
					setCurrsid(getCurrsid());
					setRatess(getRatess());
					
				}
			
				setMsg("Not Saved");
				return "fail";
			}	
			
        }
		else if(mode.equalsIgnoreCase("E")){
			int Status=accMasterDAO.edit(getDocno(),sqlStartDate,accountGroup,category,acccategory, accountcode,accountName,accountgpName,
					getBranchone(),getBranchtwo(),getInterbranch(), getMode(),session,getFormdetailcode(),request,getCurrsid(),getRatess(),getCategory());
			if(Status>0){
				setRadiotick(getRadiotick());
				
				setOtherdis(getOtherdis());
				 String account=(String) request.getAttribute("accountcode");
				if(acccategory.equalsIgnoreCase("mainacc"))
				{  setMain_account(acccategory);
					setChecksetval(accountGroup);
					setMainacconame(accountName);
					setMainacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setMainacccode(String.valueOf(getDocno()));
					
					}
					else
					{
						setMainacccode(accountcode);
					}*/
						
				}
				else if(acccategory.equalsIgnoreCase("subacc"))
				{	
					setSub_account(acccategory);
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					setSubaccname(accountName);
					setSubacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(getDocno()));
					}
					else
					{
						setSubacccode(accountcode);
					}
						*/
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
				
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
					setTransacccode(account);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setTransacccode(String.valueOf(getDocno()));
					}
					else
					{
						setTransacccode(accountcode);
					}*/
					setIntertick(getIntertick());
					setInterbr1(getBranchone());
					setInterbr2(getBranchtwo());
					setCurrs(getCurrs());
					setCurrsid(getCurrsid());
					setRatess(getRatess());
					
				}
				
				setDatehidden(sqlStartDate.toString());
			
				setMsg("Updated Successfully");
				return "success";
			
			}
			
			else{
                setRadiotick(getRadiotick());
				
				setOtherdis(getOtherdis());
				
				if(acccategory.equalsIgnoreCase("mainacc"))
				{  setMain_account(acccategory);
					setChecksetval(accountGroup);
					setMainacconame(accountName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setMainacccode(String.valueOf(getDocno()));
					
					}
					else
					{
						setMainacccode(accountcode);
					}
						
				}
				else if(acccategory.equalsIgnoreCase("subacc"))
				{	
					setSub_account(acccategory);
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					setSubaccname(accountName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(getDocno()));
					}
					else
					{
						setSubacccode(accountcode);
					}
						
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
				
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
					if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setTransacccode(String.valueOf(getDocno()));
					}
					else
					{
						setTransacccode(accountcode);
					}
					setIntertick(getIntertick());
					setInterbr1(getBranchone());
					setInterbr2(getBranchtwo());
					setCurrs(getCurrs());
					setCurrsid(getCurrsid());
					setRatess(getRatess());
					
				}
				
				setDatehidden(sqlStartDate.toString());
			
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
				
			
			boolean Status=accMasterDAO.delete(getDocno(),getMaindel(),session,getFormdetailcode());
		if(Status){
			setRadiotick(getRadiotick());
			if(getOtherdis()==1)
			{
				 acccategory=getMain_account();
				setChecksetval(getMainaccgroup());
				setMainacconame(getMainacconame());
					setMainacccode(getMainacccode());
			}
			else if(getOtherdis()==2)
			{
				setSubchecksetval(getSubaccgroup());
				setSubaccgpname(getSubaccgpname());
				setSubaccname(getSubaccname());
					setSubacccode(getSubacccode());
			}
			else if(getOtherdis()==3)
			{
				setTranchecksetval(getTansaccgroup());
				setTransaccname(getTransaccname());
				setTranscaccgpname(getTranscaccgpname());
					setTransacccode(getTransacccode());
				setIntertick(getIntertick());
				setInterbr1(getBranchone());
				setInterbr2(getBranchtwo());
				setCurrs(getCurrs());
				setCurrsid(getCurrsid());
				setRatess(getRatess());
				
			}
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
		if(getOtherdis()==1)
			{		
				
				setChecksetval(getMainaccgroup());
				setMainacconame(getMainacconame());
			   setMainacccode(getMainacccode());
							}
			else if(getOtherdis()==2)
			{
			setSubchecksetval(getSubaccgroup());
				setSubaccgpname(getSubaccgpname());
			setSubaccname(getSubaccname());
					setSubacccode(getSubacccode());
			}
			else if(getOtherdis()==3)
			{
				setTranchecksetval(getTansaccgroup());
				setTransaccname(getTransaccname());
				setTranscaccgpname(getTranscaccgpname());
					setTransacccode(getTransacccode());
				
				setIntertick(getIntertick());
				setInterbr1(getBranchone());
				setInterbr2(getBranchtwo());
				setCurrs(getCurrs());
				setCurrsid(getCurrsid());
				setRatess(getRatess());
				
			}
			setMsg("Transaction Already Exists");
		
			System.out.println("Action");
			
			
			return "fail";
		}
		}

		return "fail";	
	
	
	}


	/*public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsAccMasterBean> list= ClsAccMasterDAO.list();
			  for(ClsAccMasterBean bean:list){
			 cellobj = new JSONObject();
			 cellobj.put("docno", bean.getDocno());
			 cellobj.put("md", bean.getMd());
			 cellobj.put("date",bean.getDate());
			 cellobj.put("description",bean.getDescription());
			 cellobj.put("head",bean.getHead());
			 cellobj.put("account",bean.getAccount());
			 cellobj.put("m_s",bean.getM_s());
			 cellobj.put("alevel",bean.getAlevel());
			 cellobj.put("grpno",bean.getGrpno());
			 cellobj.put("br1",bean.getBrchone());
			 cellobj.put("br2",bean.getBrchtwo());
			 cellobj.put("den",bean. getDen());
			 
			
			  cellarray.add(cellobj);
			
			 }
			// System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}*/
	
	
	
	}

	
			
