package com.controlcentre.masters.relatedmaster.hoteltype;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsHotelAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsHotelDAO serviceDAO= new ClsHotelDAO();
	ClsHotelBean bean;

	private int docno;
	private String name;
	private String txtarea;
	private String txtareaid;
	private String vendor;
	private String vendid;
	private String location;
	private String latitude;
	private String longitude;
	private int txtinfmin;
	private int txtinfmax;
	private int txtchildmin;
	private int txtchildmax;
	private int txtteenmin;
	private int txtteenmax;
	private String txtrating;
	private String txthidrating;

	
	
	private String mode;
	private String deleted;
	private int gridlength;
	
	

	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getVendid() {
		return vendid;
	}
	public void setVendid(String vendid) {
		this.vendid = vendid;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	
	
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getTxtarea() {
		return txtarea;
	}
	public void setTxtarea(String txtarea) {
		this.txtarea = txtarea;
	}
	public String getTxtareaid() {
		return txtareaid;
	}
	public void setTxtareaid(String txtareaid) {
		this.txtareaid = txtareaid;
	}
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
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
	
	public int getTxtinfmin() {
		return txtinfmin;
	}
	public void setTxtinfmin(int txtinfmin) {
		this.txtinfmin = txtinfmin;
	}
	public int getTxtinfmax() {
		return txtinfmax;
	}
	public void setTxtinfmax(int txtinfmax) {
		this.txtinfmax = txtinfmax;
	}
	public int getTxtchildmin() {
		return txtchildmin;
	}
	public void setTxtchildmin(int txtchildmin) {
		this.txtchildmin = txtchildmin;
	}
	public int getTxtchildmax() {
		return txtchildmax;
	}
	public void setTxtchildmax(int txtchildmax) {
		this.txtchildmax = txtchildmax;
	}
	public int getTxtteenmin() {
		return txtteenmin;
	}
	public void setTxtteenmin(int txtteenmin) {
		this.txtteenmin = txtteenmin;
	}
	public int getTxtteenmax() {
		return txtteenmax;
	}
	public void setTxtteenmax(int txtteenmax) {
		this.txtteenmax = txtteenmax;
	}
	public String getTxtrating() {
		return txtrating;
	}
	public void setTxtrating(String txtrating) {
		this.txtrating = txtrating;
	}
	public String getTxthidrating() {
		return txthidrating;
	}
	public void setTxthidrating(String txthidrating) {
		this.txthidrating = txthidrating;
	}


	public String saveAction() throws ParseException, SQLException{
		//System.out.println("*** ACTION *****"+getMode());
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> beniarray= new ArrayList<>();
			//System.out.println("getGridlength="+getGridlength());
			for(int i=0;i<getGridlength() ;i++){
				String temp1=requestParams.get("rtest"+i)[0];
				beniarray.add(temp1);
				System.out.println("in action=="+beniarray);   
			}
						int val=serviceDAO.insert(getName(),getTxtareaid(),getLatitude(),getLongitude(),beniarray,getLocation(),getVendid(), session,getMode(),getFormdetailcode(),getTxtinfmin(),getTxtinfmax(),getTxtchildmin(),getTxtchildmax(),getTxtteenmin(),getTxtteenmax(),getTxtrating());
						//System.out.println(val);
						if(val>0){
							setTxtinfmin(getTxtinfmin());
							setTxtinfmax(getTxtinfmax());
							setTxtchildmin(getTxtchildmin());
							setTxtchildmax(getTxtchildmax());
							setTxtteenmin(getTxtteenmin());
							setTxtteenmax(getTxtteenmax());
							setTxthidrating(getTxtrating());
							setName(getName());
							setTxtareaid(getTxtareaid());
							setLatitude(getLatitude());
							setLongitude(getLongitude());
							setLocation(getLocation());
							setVendid(getVendid());
							setVendor(getVendor());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setTxtinfmin(getTxtinfmin());
							setTxtinfmax(getTxtinfmax());
							setTxtchildmin(getTxtchildmin());
							setTxtchildmax(getTxtchildmax());
							setTxtteenmin(getTxtteenmin());
							setTxtteenmax(getTxtteenmax());
							setTxthidrating(getTxtrating());
							setName(getName());
							setTxtareaid(getTxtareaid());
							setLatitude(getLatitude());
							setLongitude(getLongitude());
							setLocation(getLocation());
							setVendid(getVendid());
							setVendor(getVendor());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						
						else{
							setTxtinfmin(getTxtinfmin());
							setTxtinfmax(getTxtinfmax());
							setTxtchildmin(getTxtchildmin());
							setTxtchildmax(getTxtchildmax());
							setTxtteenmin(getTxtteenmin());
							setTxtteenmax(getTxtteenmax());
							setTxthidrating(getTxtrating());
							setName(getName());
							setTxtareaid(getTxtareaid());
							setLatitude(getLatitude());
							setLongitude(getLongitude());
							setLocation(getLocation());
							setVendid(getVendid());
							setVendor(getVendor());
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> beniarray= new ArrayList<>();
			//System.out.println("getGridlength="+getGridlength());
			for(int i=0;i<getGridlength() ;i++){
				String temp1=requestParams.get("rtest"+i)[0];
				beniarray.add(temp1);
				//System.out.println("beniarray=EEE"+beniarray);
			}
			
				int val=serviceDAO.edit(getName(),getTxtareaid(),getLatitude(),getLongitude(),beniarray,getLocation(),getVendid(),session,getMode(),getDocno(),getFormdetailcode(),getTxtinfmin(),getTxtinfmax(),getTxtchildmin(),getTxtchildmax(),getTxtteenmin(),getTxtteenmax(),getTxtrating());
				
				
				
				if(val>0){
					
					//session.getAttribute("BranchName");
					setTxtinfmin(getTxtinfmin());
					setTxtinfmax(getTxtinfmax());
					setTxtchildmin(getTxtchildmin());
					setTxtchildmax(getTxtchildmax());
					setTxtteenmin(getTxtteenmin());
					setTxtteenmax(getTxtteenmax());
					setTxthidrating(getTxtrating());
					setName(getName());
					setTxtareaid(getTxtareaid());
					setLatitude(getLatitude());
					setLongitude(getLongitude());
					setLocation(getLocation());
					setVendid(getVendid());
					setVendor(getVendor());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setTxtinfmin(getTxtinfmin());
					setTxtinfmax(getTxtinfmax());
					setTxtchildmin(getTxtchildmin());
					setTxtchildmax(getTxtchildmax());
					setTxtteenmin(getTxtteenmin());
					setTxtteenmax(getTxtteenmax());
					setTxthidrating(getTxtrating());
					setName(getName());
					setTxtareaid(getTxtareaid());
					setLatitude(getLatitude());
					setLongitude(getLongitude());
					setLocation(getLocation());
					setVendid(getVendid());
					setVendor(getVendor());
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else{
					setTxtinfmin(getTxtinfmin());
					setTxtinfmax(getTxtinfmax());
					setTxtchildmin(getTxtchildmin());
					setTxtchildmax(getTxtchildmax());
					setTxtteenmin(getTxtteenmin());
					setTxtteenmax(getTxtteenmax());
					setTxthidrating(getTxtrating());
					setName(getName());
					setTxtareaid(getTxtareaid());
					setLatitude(getLatitude());
					setLongitude(getLongitude());
					setLocation(getLocation());
					setVendid(getVendid());
					setVendor(getVendor());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				ArrayList<String> beniarray= new ArrayList<>();
				/*System.out.println("getGridlength="+getGridlength());
				for(int i=0;i<getGridlength() ;i++){
					String temp1=requestParams.get("rtest"+i)[0];
					beniarray.add(temp1);
					System.out.println("beniarray="+beniarray);
				}*/
				boolean Status=serviceDAO.delete(getName(),getTxtareaid(),getLatitude(),getLongitude(),beniarray,getLocation(),getVendid(),session,getMode(),getDocno(),getFormdetailcode(),getTxtinfmin(),getTxtinfmax(),getTxtchildmin(),getTxtchildmax(),getTxtteenmin(),getTxtteenmax(),getTxtrating());
			if(Status){
				setTxtinfmin(getTxtinfmin());
				setTxtinfmax(getTxtinfmax());
				setTxtchildmin(getTxtchildmin());
				setTxtchildmax(getTxtchildmax());
				setTxtteenmin(getTxtteenmin());
				setTxtteenmax(getTxtteenmax());
				setTxthidrating(getTxtrating());
				setName(getName());
				setTxtareaid(getTxtareaid());
				setLatitude(getLatitude());
				setLongitude(getLongitude());
				setLocation(getLocation());
				setVendid(getVendid());
				setVendor(getVendor());
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtinfmin(getTxtinfmin());
				setTxtinfmax(getTxtinfmax());
				setTxtchildmin(getTxtchildmin());
				setTxtchildmax(getTxtchildmax());
				setTxtteenmin(getTxtteenmin());
				setTxtteenmax(getTxtteenmax());
				setTxthidrating(getTxtrating());
				setName(getName());
				setTxtareaid(getTxtareaid());
				setLatitude(getLatitude());
				setLongitude(getLongitude());
				setLocation(getLocation());
				setVendid(getVendid());
				setVendor(getVendor());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}

		/*public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsHotelBean> list= serviceDAO.list();
				  for(ClsHotelBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("name",bean.getName());
				  cellobj.put("areaid",bean.getTxtareaid());
				  cellobj.put("area",bean.getTxtarea());
				  cellobj.put("location",bean.getLocation());
				  cellobj.put("latitude",bean.getLatitude());
				  cellobj.put("longitude",bean.getLongitude());
				  
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
*/
}


