package com.realestate.jobmaster;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.*;
import com.connection.ClsConnection;

public class ClsJobMasterAction {
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	
	private int docno;
	private String txtjobdesc;
	
	public String getTxtjobdesc() {
		return txtjobdesc;
	}

	public void setTxtjobdesc(String txtjobdesc) {
		this.txtjobdesc = txtjobdesc;
	}

	public int getDocno() {
		return docno;
	}

	public int setDocno(int docno) {
		return this.docno = docno;
	}    
 
	private String jqxDate, hiddate,mode,msg,formdetailcode,deleted;
	
	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	 
	public String getJqxDate() {
		return jqxDate;
	}

	public void setJqxDate(String jqxDate) {
		this.jqxDate = jqxDate;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	ClsJobMasterDAO  DAO = new ClsJobMasterDAO();
	ClsJobMasterBean v = new ClsJobMasterBean();

	public String saveAction() throws SQLException {
		
		System.out.println("----Maintenance date ----"+getJqxDate());
 
		HttpServletRequest request = ServletActionContext.getRequest();   
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		if (!(getMode().equalsIgnoreCase("view"))) {

			java.sql.Date masterdate = ClsCommon
					.changeStringtoSqlDate(getJqxDate());
			     
			int value = DAO.insert(masterdate,getDocno(),getTxtjobdesc(), session, request, getMode());                   
 
			if (getMode().equalsIgnoreCase("A")) {              
				if (value > 0) {
					setDocno(value);
					setHiddate(masterdate.toString());					 
					setMsg("Successfully Saved");
					return "success";
				} else {
					setHiddate(masterdate.toString()); 
					setMsg("Not Saved");
					return "fail";
				}

			}

			if (getMode().equalsIgnoreCase("E")) {
				if (value > 0) {
					setHiddate(masterdate.toString()); 
					setDocno(value);
					setMsg("Updated Successfully");
					return "success";
				} else {
					setDocno(value);
					setHiddate(masterdate.toString()); 
					setMsg("Not Updated");
					return "fail";
				}
			}

			if (getMode().equalsIgnoreCase("D")) {
				if (value > 0) {
					setDocno(value);
					setHiddate(masterdate.toString());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				} else {
					setDocno(value);
					setHiddate(masterdate.toString());
					setMsg("Not Deleted");
					setDeleted("");
					return "fail";
				}
			}
		}

		else if (getMode().equalsIgnoreCase("view")) {
			Connection conn = null;
			try {

				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sqls = "select doc_no,job_desc,created_date where status=3 and doc_no='"+getDocno()+"'";    
				ResultSet rss = stmt.executeQuery(sqls);
				if (rss.first()) {
					setHiddate(rss.getString("date"));					
					setDocno(rss.getInt("doc_no"));
					setTxtjobdesc(rss.getString("job_desc"));					 
				}
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			}

			return "success";
		}

		return "fail";

	}
}
