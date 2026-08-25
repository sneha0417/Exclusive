package com.cargo.transportmasters.shipment;

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

import com.cargo.transportmasters.mode.ClsModeBean;
import com.common.ClsCommon;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.opensymphony.xwork2.ActionSupport;

public class ClsShipmentAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsShipmentDAO shipmentDAO= new ClsShipmentDAO();
	ClsShipmentBean bean;
	
	private int docno;
	private String shipmentdate;
	private String shipmentid;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	
	
		
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getShipmentdate() {
		return shipmentdate;
	}
	public void setShipmentdate(String shipmentdate) {
		this.shipmentdate = shipmentdate;
	}
	public String getShipmentid() {
		return shipmentid;
	}
	public void setShipmentid(String shipmentid) {
		this.shipmentid = shipmentid;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	
	
	public String saveAction() throws ParseException, SQLException{
     	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

		java.sql.Date shipmntDate = ClsCommon.changeStringtoSqlDate(getShipmentdate());
		
		if(mode.equalsIgnoreCase("A")){
                                            
						int val=shipmentDAO.insert(getDocno(),shipmntDate,getShipmentid(),mode,session,getFormdetailcode());
						if(val>0){
							
							setDocno(val);
							
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{

							setMsg("Not Saved");
							return "fail";
						}		
						
		}
		
		
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> driverarray= new ArrayList<>();

				int Status=shipmentDAO.edit(getDocno(),shipmntDate,getShipmentid(),mode,session,getFormdetailcode());
				if(Status>0){
					
					setMsg("Updated Successfully");
					return "success";
				}
				else
				{
					setMsg("not updated");
					return "fail";

			}
	
		
	}
	


		else if(mode.equalsIgnoreCase("D")){
			boolean Status=shipmentDAO.delete(getDocno(),shipmntDate,getShipmentid(),mode,session,getFormdetailcode());
		if(Status){
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{

			
			setMode(getMode());
			setMsg("Not Deleted");
			return "fail";
		}
		}
	return "fail";
}

		
		
	
	

	
	public  JSONArray searchDetails(){
		
		System.out.println("search deatails action");
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsShipmentBean> list= shipmentDAO.list();
			  for(ClsShipmentBean bean:list){
				  
			  cellobj = new JSONObject();
			  
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("date",bean.getShipmentdate().toString());
			  cellobj.put("shipment",bean.getShipmentid());
			
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}

}



