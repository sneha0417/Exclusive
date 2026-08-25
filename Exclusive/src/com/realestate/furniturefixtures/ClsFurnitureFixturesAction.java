package com.realestate.furniturefixtures;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFurnitureFixturesAction {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsFurnitureFixturesDAO furnitureDAO = new ClsFurnitureFixturesDAO();

	// Furniture Grid
	private int furgridlength;
	// Inspection Grid
	private int insgridlength;

	private String mode;
	private String deleted;
	private String msg,roomdesc;
	public String getRoomdesc() {    
		return roomdesc;
	}

	public void setRoomdesc(String roomdesc) {
		this.roomdesc = roomdesc;
	}

	private int docno;

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
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

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public int getFurgridlength() {
		return furgridlength;
	}

	public void setFurgridlength(int furgridlength) {
		this.furgridlength = furgridlength;
	}

	public int getInsgridlength() {
		return insgridlength;
	}

	public void setInsgridlength(int insgridlength) {
		this.insgridlength = insgridlength;
	}

	public String saveAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode = getMode();

		if (mode.equalsIgnoreCase("A")) {
			Connection conn = null;
			conn = connDAO.getMyConnection();
			conn.setAutoCommit(false);

			/* Furniture Grid  */
			ArrayList<String> furniturearray = new ArrayList<String>();

			for (int i = 0; i < getFurgridlength(); i++) {
				String fur = requestParams.get("txtfurniture" + i)[0];
				furniturearray.add(fur);
			}
			/* Furniture Grid  Ends */

			/* Inspection Grid  */
			ArrayList<String> inspectionarray = new ArrayList<String>();

			for (int i = 0; i < getInsgridlength(); i++) {
				String temp = requestParams.get("txtinspection" + i)[0];
				inspectionarray.add(temp);
			}
			/* Inspection Grid  Ends */

			int val = furnitureDAO.insert(conn, getDocno(),getRoomdesc(), furniturearray,
					inspectionarray, session, request, mode);

			if (val > 0) {
				// setData();
				conn.commit();
				conn.close();
				setMsg("Successfully Saved");
				return "success";
			} else {
				// setData();
				conn.close();
				setMsg("Not Saved");
				return "fail";
			}
		}

		return "fail";

	}
}
