package com.finance.accountssetup.clustermaster;

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
public class ClsClusterMasterAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();

    
	ClsClusterMasterDAO clustermasterDAO= new ClsClusterMasterDAO();
	ClsClusterMasterBean clustermasterbean;

	private int txtclmmasterdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String clusterDate;
	private String hidclusterDate;
	private String txtclustername;
	private String txtdescription;
	
	//Cluster Account Grid
	private int gridlength;
	
	public int getTxtclmmasterdocno() {
		return txtclmmasterdocno;
	}

	public void setTxtclmmasterdocno(int txtclmmasterdocno) {
		this.txtclmmasterdocno = txtclmmasterdocno;
	}

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

	public String getClusterDate() {
		return clusterDate;
	}

	public void setClusterDate(String clusterDate) {
		this.clusterDate = clusterDate;
	}

	public String getHidclusterDate() {
		return hidclusterDate;
	}

	public void setHidclusterDate(String hidclusterDate) {
		this.hidclusterDate = hidclusterDate;
	}

	public String getTxtclustername() {
		return txtclustername;
	}

	public void setTxtclustername(String txtclustername) {
		this.txtclustername = txtclustername;
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

	java.sql.Date clusterMasterDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		
		ClsClusterMasterBean bean = new ClsClusterMasterBean();

		if(mode.equalsIgnoreCase("A")){
			clusterMasterDate = ClsCommon.changeStringtoSqlDate(getClusterDate());	
			
			/*Cluster Accounts Grid*/
			ArrayList<String> clusteraccountsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				clusteraccountsarray.add(temp);
			}
			
			int val=clustermasterDAO.insert(clusterMasterDate,getFormdetailcode(),getTxtclustername(),getTxtdescription(),clusteraccountsarray,session,request,mode);
			if(val>0.0){
				
				setTxtclmmasterdocno(val);
				setHidclusterDate(clusterMasterDate==null?null:clusterMasterDate.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setHidclusterDate(clusterMasterDate==null?null:clusterMasterDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			clusterMasterDate = ClsCommon.changeStringtoSqlDate(getClusterDate());	
			
			/*Cluster Accounts Grid*/
			ArrayList<String> clusteraccountsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				clusteraccountsarray.add(temp);
			}
			
			int Status=clustermasterDAO.edit(getTxtclmmasterdocno(),getFormdetailcode(),clusterMasterDate,getTxtclustername(),getTxtdescription(),clusteraccountsarray,session,request,mode);
			
			if(Status>0){
						
						setTxtclmmasterdocno(getTxtclmmasterdocno());
						setHidclusterDate(clusterMasterDate==null?null:clusterMasterDate.toString());
						setData();
				
						setMsg("Updated Successfully");
				        return "success";
			}
			else{
				setData();
				setTxtclmmasterdocno(getTxtclmmasterdocno());
				setHidclusterDate(clusterMasterDate==null?null:clusterMasterDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
		int Status=clustermasterDAO.delete(getTxtclmmasterdocno(),getFormdetailcode(),session,mode);
		if(Status>0){
					setTxtclmmasterdocno(getTxtclmmasterdocno());
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		else if(Status==-1){
			setChkstatus("1");
			setData();
			setMsg("Transaction Already Exists.");
			return "fail";
		}
		else{
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		

		else if(mode.equalsIgnoreCase("View")){
			
			clustermasterbean=clustermasterDAO.getViewDetails(getTxtclmmasterdocno());
			
			setClusterDate(clustermasterbean.getClusterDate());
			setTxtclustername(clustermasterbean.getTxtclustername());
			setTxtdescription(clustermasterbean.getTxtdescription());
			setFormdetailcode(clustermasterbean.getFormdetailcode());
			
			return "success";
		}
		
		return "fail";
}

		public  JSONArray searchAllDetails(HttpSession session,String docno,String date,String clustername,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  cellarray= clustermasterDAO.clusterMainSearch(session,docno,date,clustername,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setTxtclustername(getTxtclustername());
			setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
			
	}
	
}
