package com.controlcentre.settings.usermaster;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;

@SuppressWarnings("serial")
public class ClsUserMasterAction extends ActionSupport{
	ClsConnection ClsConnection=new ClsConnection();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	ClsCommon ClsCommon=new ClsCommon();
	ClsUserMasterDAO userDAO= new ClsUserMasterDAO();
	
	private String jqxUserMasterDate;
	private String hidjqxUserMasterDate;
	private int docno;	
	private String txtuser;
	private String txtusername;
	private String txtbrole;
	private String hidcmbrole;
	private String cmblanguage;
	private String hidcmblanguage;
	private String txtusermail;
	private String txtuserpassword;
	private String txtpasswordconfirm;
	private String cmpermission;
	private String hidcmpermission;
	private String txtmailpswd;
	private String txtmailsign;
	private String txtmailhost;
	private String txtmailport;
	private String mode;
	private String deleted;
	private String msg,langval,permissionval,formdetailcode;
	private int existusermaster;	
	private int txtroleid,levels,hidelevels;	
	
	

	
	
	public String getTxtmailhost() {
		return txtmailhost;
	}

	public void setTxtmailhost(String txtmailhost) {
		this.txtmailhost = txtmailhost;
	}

	public String getTxtmailport() {
		return txtmailport;
	}

	public void setTxtmailport(String txtmailport) {
		this.txtmailport = txtmailport;
	}

	public String getTxtmailpswd() {
		return txtmailpswd;
	}

	public void setTxtmailpswd(String txtmailpswd) {
		this.txtmailpswd = txtmailpswd;
	}

	public String getTxtmailsign() {
		return txtmailsign;
	}

	public void setTxtmailsign(String txtmailsign) {
		this.txtmailsign = txtmailsign;
	}

	public int getHidelevels() {
		return hidelevels;
	}

	public void setHidelevels(int hidelevels) {
		this.hidelevels = hidelevels;
	}

	public int getLevels() {
		return levels;
	}

	public void setLevels(int levels) {
		this.levels = levels;
	}

	public String getLangval() {
		return langval;
	}

	public void setLangval(String langval) { 
		this.langval = langval;
	}

	public String getPermissionval() {
		return permissionval;
	}

	public void setPermissionval(String permissionval) {
		this.permissionval = permissionval;
	}

	public int getTxtroleid() {
		return txtroleid;
	}

	public void setTxtroleid(int txtroleid) {
		this.txtroleid = txtroleid;
	}

	public int getExistusermaster() {
		return existusermaster;
	}

	public void setExistusermaster(int existusermaster) {
		this.existusermaster = existusermaster;
	}

	public String getCmpermission() {
		return cmpermission;
	}

	public void setCmpermission(String cmpermission) {
		this.cmpermission = cmpermission;
	}

	public String getHidcmpermission() {
		return hidcmpermission;
	}

	public void setHidcmpermission(String hidcmpermission) {
		this.hidcmpermission = hidcmpermission;
	}


	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getJqxUserMasterDate() {
		return jqxUserMasterDate;
	}

	public void setJqxUserMasterDate(String jqxUserMasterDate) {
		this.jqxUserMasterDate = jqxUserMasterDate;
	}

	public String getHidjqxUserMasterDate() {
		return hidjqxUserMasterDate;
	}

	public void setHidjqxUserMasterDate(String hidjqxUserMasterDate) {
		this.hidjqxUserMasterDate = hidjqxUserMasterDate;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
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

	public String getTxtuser() {
		return txtuser;
	}

	public void setTxtuser(String txtuser) {
		this.txtuser = txtuser;
	}

	public String getTxtusername() {
		return txtusername;
	}

	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}

	public String getTxtbrole() {
		return txtbrole;
	}

	public void setTxtbrole(String txtbrole) {
		this.txtbrole = txtbrole;
	}

	public String getHidcmbrole() {
		return hidcmbrole;
	}

	public void setHidcmbrole(String hidcmbrole) {
		this.hidcmbrole = hidcmbrole;
	}

	public String getCmblanguage() {
		return cmblanguage;
	}

	public void setCmblanguage(String cmblanguage) {
		this.cmblanguage = cmblanguage;
	}

	public String getHidcmblanguage() {
		return hidcmblanguage;
	}

	public void setHidcmblanguage(String hidcmblanguage) {
		this.hidcmblanguage = hidcmblanguage;
	}

	public String getTxtusermail() {
		return txtusermail;
	}

	public void setTxtusermail(String txtusermail) {
		this.txtusermail = txtusermail;
	}

	public String getTxtuserpassword() {
		return txtuserpassword;
	}

	public void setTxtuserpassword(String txtuserpassword) {
		this.txtuserpassword = txtuserpassword;
	}

	public String getTxtpasswordconfirm() {
		return txtpasswordconfirm;
	}

	public void setTxtpasswordconfirm(String txtpasswordconfirm) {
		this.txtpasswordconfirm = txtpasswordconfirm;
	}


	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	ClsUserMasterBean bean = new ClsUserMasterBean();
	public String saveAction() throws ParseException, SQLException{
		
//		System.out.println("test insert ClsUserMasterAction");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		Map<String, String[]> requestParams = request.getParameterMap();

		//ClsEncrypt.decrypt
		
		/*char[] mailpswd = getTxtmailpswd().toCharArray();
	      String emailpass=ClsEncrypt.txtCode(mailpswd);
	      
	      char[]userpswd = getTxtuserpassword().toCharArray();
	      String userpass=ClsEncrypt.txtCode(userpswd);*/
		
		
		System.out.println("======fghjk======"+getTxtuserpassword());
		
		bean.setTxtuser(getTxtuser());
		bean.setTxtusername(getTxtusername());
		bean.setTxtbrole(getTxtbrole());
		bean.setTxtroleid(getTxtroleid());
		bean.setCmblanguage(getCmblanguage());
		bean.setTxtusermail(getTxtusermail());
		bean.setCmpermission(getCmpermission());
		bean.setTxtuserpassword(getTxtuserpassword());
		bean.setTxtmailpswd(getTxtmailpswd());
		bean.setTxtmailsign(getTxtmailsign());
		bean.setDocno(getDocno());
		bean.setMode(getMode());
		bean.setTxtmailhost(getTxtmailhost());
		bean.setTxtmailport(getTxtmailport());
		if(mode.equalsIgnoreCase("A")){
			java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxUserMasterDate());
			ArrayList<String> usermasterarray= new ArrayList<>();
			if(getCmpermission().equalsIgnoreCase("1"))
			{
			
			
			for(int i=0;i<getExistusermaster();i++){
				String temp2=requestParams.get("test"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
				usermasterarray.add(temp2);
			 
			}
			}
//			System.out.println("test insert ClsUserMasterAction2");
			int val=userDAO.insert(bean,session,usermasterarray,sqlStartDate,getFormdetailcode(),getLevels());
//			System.out.println("test insert ClsUserMasterAction3");
			setHidjqxUserMasterDate(sqlStartDate.toString());
			setTxtuser(getTxtuser());
			setTxtusername(getTxtusername());
			setTxtbrole(getTxtbrole());
			setTxtroleid(getTxtroleid());
			setCmblanguage(getCmblanguage());
			setTxtusermail(getTxtusermail());
			setCmpermission(getCmpermission());
			setTxtuserpassword(getTxtuserpassword());
			setTxtpasswordconfirm(getTxtuserpassword());
			setTxtmailpswd(getTxtmailpswd());
			setTxtmailsign(getTxtmailsign());
			setLangval(getCmblanguage()); 
			setPermissionval(getCmpermission());
			
			
		
			if(val>0){
				
				setDocno(val);
				
				setHidjqxUserMasterDate(sqlStartDate.toString());
				setTxtuser(getTxtuser());
				setTxtusername(getTxtusername());
				setTxtbrole(getTxtbrole());
				setTxtroleid(getTxtroleid());
				setCmblanguage(getCmblanguage());
				setTxtusermail(getTxtusermail());
				setCmpermission(getCmpermission());
				setTxtuserpassword(getTxtuserpassword());
				
				setHidelevels(getLevels());
				setLangval(getCmblanguage()); 
				setPermissionval(getCmpermission());
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setHidjqxUserMasterDate(sqlStartDate.toString());
				setTxtuser(getTxtuser());
				setTxtusername(getTxtusername());
				setTxtbrole(getTxtbrole());
				setTxtroleid(getTxtroleid());
				setCmblanguage(getCmblanguage());
				setTxtusermail(getTxtusermail());
				setCmpermission(getCmpermission());
				setTxtuserpassword(getTxtuserpassword());
				setTxtmailpswd(getTxtmailpswd());
				setTxtmailsign(getTxtmailsign());
				setHidelevels(getLevels());
				setLangval(getCmblanguage()); 
				setPermissionval(getCmpermission());
				setMsg("Not Saved");
				
				return "fail";
			}	
			
		}
		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxUserMasterDate());
			ArrayList<String> usermasterarray= new ArrayList<>();
			if(getCmpermission().equalsIgnoreCase("1"))
			{
			
			
			for(int i=0;i<getExistusermaster();i++){
				String temp2=requestParams.get("test"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
				usermasterarray.add(temp2);
			 
			}
			}		
					boolean Status=userDAO.edit(getDocno(),bean,session,usermasterarray,sqlStartDate,getFormdetailcode(),getLevels());
					if(Status){
						setHidjqxUserMasterDate(sqlStartDate.toString());
						setTxtuser(getTxtuser());
						setTxtusername(getTxtusername());
						setTxtbrole(getTxtbrole());
						setTxtroleid(getTxtroleid());
						setCmblanguage(getCmblanguage());
						setTxtusermail(getTxtusermail());
						setCmpermission(getCmpermission());
						setTxtuserpassword(getTxtuserpassword());
						setTxtuserpassword(getTxtuserpassword());
						setDocno(getDocno());
						setTxtmailpswd(getTxtmailpswd());
						setTxtmailsign(getTxtmailsign());
						setHidelevels(getLevels());
						setLangval(getCmblanguage()); 
						setPermissionval(getCmpermission());
						
						
						setMsg("Updated Successfully");
						return "success";
					}
					else{
						setHidjqxUserMasterDate(sqlStartDate.toString());
						setTxtuser(getTxtuser());
						setTxtusername(getTxtusername());
						setTxtbrole(getTxtbrole());
						setTxtroleid(getTxtroleid());
						setCmblanguage(getCmblanguage());
						setTxtusermail(getTxtusermail());
						setCmpermission(getCmpermission());
						setTxtuserpassword(getTxtuserpassword());
						setTxtmailpswd(getTxtmailpswd());
						setTxtmailsign(getTxtmailsign());
						setHidelevels(getLevels());
						setLangval(getCmblanguage()); 
						setPermissionval(getCmpermission());
						setMsg("Not Updated");
						return "fail";
					}
				}
		else if(mode.equalsIgnoreCase("D")){
			java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxUserMasterDate());
			boolean Status=userDAO.delete(bean,session,getFormdetailcode());
		if(Status){
			setHidjqxUserMasterDate(sqlStartDate.toString());
			setTxtuser(getTxtuser());
			setTxtusername(getTxtusername());
			setTxtbrole(getTxtbrole());
			setTxtroleid(getTxtroleid());
			setCmblanguage(getCmblanguage());
			setTxtusermail(getTxtusermail());
			setCmpermission(getCmpermission());
			setTxtuserpassword(getTxtuserpassword());
			setTxtuserpassword(getTxtuserpassword());
			setDocno(getDocno());
			
			setHidelevels(getLevels());
			
			setLangval(getCmblanguage()); 
			setPermissionval(getCmpermission());
			
			
		    setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setHidjqxUserMasterDate(sqlStartDate.toString());
			setTxtuser(getTxtuser());
			setTxtusername(getTxtusername());
			setTxtbrole(getTxtbrole());
			setTxtroleid(getTxtroleid());
			setCmblanguage(getCmblanguage());
			setTxtusermail(getTxtusermail());
			setCmpermission(getCmpermission());
			setTxtuserpassword(getTxtuserpassword());
			
			setHidelevels(getLevels());
			setLangval(getCmblanguage()); 
			setPermissionval(getCmpermission());
			setMsg("Not Deleted");
			return "fail";
		}
		}

		
		else if(mode.equalsIgnoreCase("View")){
			
			if(getDocno()>0)
			{
				
				bean=userDAO.getViewDetails(getDocno());
			java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxUserMasterDate());
			 
			setHidjqxUserMasterDate(sqlStartDate.toString());
			setTxtuser(bean.getTxtuser());
			setTxtusername(bean.getTxtusername());
			setTxtbrole(bean.getTxtbrole());
			setTxtroleid(bean.getTxtroleid());
			setCmblanguage(bean.getCmblanguage());
			setTxtusermail(bean.getTxtusermail());
			setCmpermission(bean.getCmpermission());
			setTxtuserpassword(bean.getTxtuserpassword());
			setTxtmailpswd(bean.getTxtmailpswd());
			setTxtmailsign(bean.getTxtmailsign());
			setTxtpasswordconfirm(bean.getTxtpasswordconfirm());
			setHidelevels(bean.getLevels());
			setLangval(bean.getCmblanguage()); 
			setPermissionval(bean.getCmpermission());
			setDocno(getDocno());
			setTxtmailhost(bean.getTxtmailhost());
			setTxtmailport(bean.getTxtmailport());
			}
		
		}
		
		
		
		/*HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BranchName");
		String mode=getMode();
		ClsUserMasterBean bean = new ClsUserMasterBean();
		

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxUserMasterDate());
		if(mode.equalsIgnoreCase("A")){
						int val=userDAO.insert(getPlateCode(),getPlatename(),sqlStartDate,getAuthName(),session);
						if(val>0.0){
							setPlateCode(getPlateCode());
							setPlatename(getPlatename());
							setDocno(val);
							setDatehidden(getDate_plateCode());
							setAuthId(getAuthName());
//							setDate_plateCode(getDate_plateCode());
							return "success";
						}
						else{
							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("E")){
			boolean Status=userDAO.edit(getDocno(),sqlStartDate,getPlateCode(),getPlatename(),getAuthName(),session);
			if(Status){
				setPlateCode(getPlateCode());
				setPlatename(getPlatename());
				setDatehidden(getDate_plateCode());
				setAuthId(getAuthName());
				setDocno(getDocno());
				setDate_plateCode(getDate_plateCode());
				return "success";
			}
			else{
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=userDAO.delete(getDocno(),session);
		if(Status){
			setPlateCode(getPlateCode());
			setPlatename(getPlatename());
			setDocno(getDocno());
			setDatehidden(getDate_plateCode());
			setAuthId(getAuthName());
			setDate_plateCode(getDate_plateCode());
			setDelete("DELETED");
			return "success";
		}
		else{
			return "fail";
		}
		}
		return "fail";
	}

	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsUserMasterBean> list= ClsUserMasterDAO.list();
			  for(ClsUserMasterBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("code_no", bean.getPlateCode());
			  cellobj.put("code_name",bean.getPlatename());
			  cellobj.put("authname",bean.getAuthName());
			  cellobj.put("authId",bean.getAuthId());
			  cellobj.put("plateDate",bean.getDate_plateCode().toString());
			 cellarray.add(cellobj);
			 }
//			  System.out.println(cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}*/
		return "fail";
	}

	public String changePassword() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String userid=request.getParameter("userid");
		String password=request.getParameter("password");
		Statement stmt5 =null;
		Connection conn =null;
		String result="";
		try{
			conn = ClsConnection.getMyConnection();
			String strsql="update my_user set pass='"+ClsEncrypt.getInstance().encrypt(password)+"' where doc_no="+Integer.parseInt(userid)+"";
			stmt5=conn.createStatement();
			int val2=stmt5.executeUpdate(strsql);
			
			if(val2>0){
				result="success";
			}
			else{
				result="fail";
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		

		return result;
	}

}
