package com.realestate.maintenancerequest;

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

public class ClsMaintenanceRequestAction {
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	
	private int docno,vocno,txtpropertydocno,txttenantdocno,txtrequestgridlength,vdocno;
	
	public int getVdocno() {
		return vdocno;
	}

	public void setVdocno(int vdocno) {
		this.vdocno = vdocno;
	}

	public int getTxtrequestgridlength() {
		return txtrequestgridlength;
	}

	public void setTxtrequestgridlength(int txtrequestgridlength) {
		this.txtrequestgridlength = txtrequestgridlength;
	}

	public int getTxtpropertydocno() {
		return txtpropertydocno;
	}

	public void setTxtpropertydocno(int txtpropertydocno) {
		this.txtpropertydocno = txtpropertydocno;
	}

	public int getTxttenantdocno() {
		return txttenantdocno;
	}

	public void setTxttenantdocno(int txttenantdocno) {
		this.txttenantdocno = txttenantdocno;
	}

	public String getTxtproperty() {
		return txtproperty;
	}

	public void setTxtproperty(String txtproperty) {
		this.txtproperty = txtproperty;
	}

	public int getDocno() {
		return docno;
	}

	public int setDocno(int docno) {
		return this.docno = docno;
	}

	public int getVocno() {
		return vocno;
	}

	public void setVocno(int vocno) {
		this.vocno = vocno;
	}
 
	private String jqxDate, hiddate,mode,msg,txtproperty,txttenant,formdetailcode,deleted,rtime;
	
	public String getRtime() {
		return rtime;
	}

	public void setRtime(String rtime) {
		this.rtime = rtime;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getTxttenant() {
		return txttenant;
	}

	public void setTxttenant(String txttenant) {
		this.txttenant = txttenant;
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
	ClsMaintenanceRequestDAO  DAO = new ClsMaintenanceRequestDAO();
	ClsMaintenanceRequestBean v = new ClsMaintenanceRequestBean();

	public String saveAction() throws SQLException {
		
		System.out.println("----Maintenance date ----"+getJqxDate());
 
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		if (!(getMode().equalsIgnoreCase("view"))) {

			java.sql.Date masterdate = ClsCommon
					.changeStringtoSqlDate(getJqxDate());
			  
			/* Request Grid */
			ArrayList<String> mrequestarray = new ArrayList<String>();

			for (int i = 0; i < getTxtrequestgridlength(); i++) {
				String rqst = requestParams.get("txtrqst" + i)[0];
				mrequestarray.add(rqst);
			}
			/*Request Grid Ends */
			
			System.out.println("tenant doc no==" +getTxttenantdocno());
			  
			int value = DAO.insert(masterdate,getVdocno(),getRtime(),getDocno(),getTxtpropertydocno(),getTxttenantdocno(),mrequestarray, session, request, getMode());
 
			if (getMode().equalsIgnoreCase("A")) {
				if (value > 0) {
					int dn=Integer.parseInt(request.getAttribute("docno").toString());
					int vn=Integer.parseInt(request.getAttribute("vocno").toString());
					 
					setDocno(dn);
					setVocno(vn); 
					setVdocno(vn);
					int vno = (int) request.getAttribute("vocno");					
					setVocno(vno);				 
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
					 //int dn=Integer.parseInt(request.getAttribute("docno").toString());
					 int vn=Integer.parseInt(request.getAttribute("vocno").toString());
					 
					setDocno(getVdocno());
					setVocno(getVdocno()); 
					setVdocno(getVdocno());

					setMsg("Updated Successfully");
					return "success";
				} else {
					 setDocno(getVdocno());
					setVocno(getVocno());
					setVdocno(getVdocno());

					setHiddate(masterdate.toString()); 

					setMsg("Not Updated");
					return "fail";
				}
			}

			if (getMode().equalsIgnoreCase("D")) {
				if (value > 0) {
					  int dn=Integer.parseInt(request.getAttribute("docno").toString());
					 int vn=Integer.parseInt(request.getAttribute("vocno").toString());
					 
					setDocno(dn);
					setVocno(vn); 
					setVdocno(vn);
					setHiddate(masterdate.toString());
				
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				} else {
					//setMasterdoc_no(value);
					setDocno(getDocno() );
					setVocno(getVocno());
					
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

				String sqls = "select  m.*,m.address1 as paddr1,m.address2 as paddr2, o.primary_owner  owner, t.transtype, aa.area as areaname,m.area as areaid, pt.prtype pname, bm.name bname,s.sal_name,s.mob_no as smob_no"
						+ " from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid "
						+ " left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.prtype "
						+ " left   join rl_unittype ut on ut.doc_no=m.prunit  "
						+ " left  join my_area aa on aa.doc_no=m.area  left join rl_buildingm bm on bm.doc_no=m.unitof "
						+ " left join  my_salm s on s.doc_no=m.contactperson "
						+ " where m.status=3 and m.doc_no="
						+  getDocno() 
						+ "  ";

				System.out.println("property = " + sqls);
				ResultSet rss = stmt.executeQuery(sqls);
				if (rss.first()) {
					setHiddate(rss.getString("date"));					
					//setPropertyname(rss.getString("name"));
					setDocno(rss.getInt("doc_no"));
					setVocno(rss.getInt("voc_no"));					 
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
