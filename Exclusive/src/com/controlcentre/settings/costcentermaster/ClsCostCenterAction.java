package com.controlcentre.settings.costcentermaster;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.finance.accountssetup.accountsMaster.ClsAccMasterDAO;


public class ClsCostCenterAction extends HttpServlet {
	ClsCommon ClsCommon=new ClsCommon();
	ClsCostCenterDAO costMasterDAO= new ClsCostCenterDAO();
	private String category;
	
	private String date_costmaster;
	
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
	

	private String mode;
	private String datehidden;
	
	private String main_account;
	private String sub_account;
	private String tran_account;
	
	private int doc,maindel;
    private String deleted,formdetailcode;
    
    private int radiotick;
    // main acc check val
    private String checksetval;
    private String subchecksetval;
    private String tranchecksetval;
 // for inter branch tick


	private int otherdis;
	private String msg;
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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




	public String getDate_costmaster() {
		return date_costmaster;
	}

	public void setDate_costmaster(String date_costmaster) {
		this.date_costmaster = date_costmaster;
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
	
	
	

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getMaindel() {
		return maindel;
	}

	public void setMaindel(int maindel) {
		this.maindel = maindel;
	}

	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate_costmaster());
		
		
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
			
			int val=costMasterDAO.insert(sqlStartDate,accountGroup,category,acccategory, accountcode,accountName,accountgpName, getMode(),session,getFormdetailcode(),request);
			if(val>0){
				setDatehidden(sqlStartDate.toString());
				setRadiotick(getRadiotick());
			
				setDocno(val);
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
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					setSubaccname(accountName);
					setSubacccode(account);
				/*	if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(val));
					}
					else
					{
						setSubacccode(accountcode);
					}*/
						
					 
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
						setTransacccode(String.valueOf(val));
					}
					else
					{
						setTransacccode(accountcode);
					}*/
					
				
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
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					setSubaccname(accountName);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setSubacccode(String.valueOf(val));
					}
					else
					{*/
						setSubacccode(accountcode);
					/*}*/
						
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
					/*if(accountcode.trim().equalsIgnoreCase(""))	
					{
						setTransacccode(String.valueOf(val));
					}
					else
					{*/
						setTransacccode(accountcode);
					/*}
					*/
				
				}
			
				
				setMsg("Not Saved");
				return "fail";
			}	
			
        }
		else if(mode.equalsIgnoreCase("E")){
			int Status=costMasterDAO.edit(getDocno(),sqlStartDate,accountGroup,category,acccategory, accountcode,accountName,accountgpName, getMode(),session,getFormdetailcode(),request);
			if(Status>0){
				setRadiotick(getRadiotick());
				
				setOtherdis(getOtherdis());
				setDocno(getDocno());
				/*if(acccategory.equalsIgnoreCase("mainacc"))
				{
					//System.out.println("===========");
					//setMainaccgroup(accountGroup);
					
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
				
				}*/
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
						setSubchecksetval(accountGroup);
						setSubaccgpname(accountgpName);
						setSubaccname(accountName);
						setSubacccode(account);
					/*	if(accountcode.trim().equalsIgnoreCase(""))	
						{
							setSubacccode(String.valueOf(val));
						}
						else
						{
							setSubacccode(accountcode);
						}*/
							
						 
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
							setTransacccode(String.valueOf(val));
						}
						else
						{
							setTransacccode(accountcode);
						}*/
						
					
					}
				
				setDatehidden(sqlStartDate.toString());
			
				setMsg("Updated Successfully");
				return "success";
			
			}
			
			else{
				setDatehidden(sqlStartDate.toString());
				setRadiotick(getRadiotick());
			
				setDocno(getDocno());
			
				if(acccategory.equalsIgnoreCase("mainacc"))
				{
					setMain_account(acccategory);
					setChecksetval(accountGroup);
					setMainacconame(accountName);
					
						setMainacccode(accountcode);
					
				}
				else if(acccategory.equalsIgnoreCase("subacc"))
				{
					setSub_account(acccategory);
					setSubchecksetval(accountGroup);
					setSubaccgpname(accountgpName);
					setSubaccname(accountName);
				
						setSubacccode(accountcode);
				
						
					 
				}
				else if(acccategory.equalsIgnoreCase("tranacc"))
				{
					setTran_account(acccategory);
					setTranchecksetval(accountGroup);
					setTransaccname(accountName);
					setTranscaccgpname(accountgpName);
				
						setTransacccode(accountcode);
					
					
				
				}
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
				
		
			boolean Status=costMasterDAO.delete(getDocno(),getMaindel(),session,getFormdetailcode());
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
				
			}
			
			
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
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
				
			}
			setMsg("Transaction Already Exists");
			
			System.out.println("Action");
		
			return "fail";
		}
		}

		return "fail";	
	
	
	}

}
