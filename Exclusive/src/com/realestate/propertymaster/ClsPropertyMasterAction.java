package com.realestate.propertymaster;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.*;
import com.connection.ClsConnection;

public class ClsPropertyMasterAction {
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	private String jqxdate, hiddate, owner, propertyname, propertyaddress,hidchequeownersname,
			txtarea, propertydesc, propertytype, unittype, landmark;

	public String getHidchequeownersname() {
		return hidchequeownersname;
	}

	public void setHidchequeownersname(String hidchequeownersname) {
		this.hidchequeownersname = hidchequeownersname;
	}

	private String txtfor, unitno, unitof, bayno,pmode;

	public String getPmode() {
		return pmode;
	}

	public void setPmode(String pmode) {
		this.pmode = pmode;
	}

	private String txtareasqft, builduparea, yard, electricwaterno,
			rdoinsasper, gasconnectionno, acconnectionno, premisesno, mode,
			msg, deleted, formdetailcode, parkingno,owacno,hidchkpforS,hidchkpforR,hidchkpforHC;

	public String getHidchkpforS() {
		return hidchkpforS;
	}

	public void setHidchkpforS(String hidchkpforS) {
		this.hidchkpforS = hidchkpforS;
	}

	public String getHidchkpforR() {
		return hidchkpforR;
	}

	public void setHidchkpforR(String hidchkpforR) {
		this.hidchkpforR = hidchkpforR;
	}

	public String getHidchkpforHC() {
		return hidchkpforHC;
	}

	public void setHidchkpforHC(String hidchkpforHC) {
		this.hidchkpforHC = hidchkpforHC;
	}

	public String getOwacno() {
		return owacno;
	}

	public void setOwacno(String owacno) {
		this.owacno = owacno;
	}

	public String getRdoinsasper() {
		return rdoinsasper;
	}

	public void setRdoinsasper(String rdoinsasper) {
		this.rdoinsasper = rdoinsasper;
	}

	private int cmbtranstype, hidparking, unitofid, ownerid, docno,
			masterdoc_no, hidcmbaccgroup, hidchkmanagedproperty, txtareaid,
			hidpropertytype, hidunittype, hidarm, parking, arm, roomsno, vocno,
			cmbrtainerfund;

	public int getCmbrtainerfund() {
		return cmbrtainerfund;
	}

	public void setCmbrtainerfund(int cmbrtainerfund) {
		this.cmbrtainerfund = cmbrtainerfund;
	}

	public int getVocno() {
		return vocno;
	}

	public void setVocno(int vocno) {
		this.vocno = vocno;
	}

	// saranya on 12/12/19
	private String hidcmbptype, txtoptID, cmbptype, chkpfor, hidchkpfor,
			txtaddress1, txtaddress2, txtaccname, txtlandmark,
			txtcontactnumber, txtspecialnotes, txtarea1, txtyard,
			txtbuilduparea, txtpropertyviews, jqxwarratydate, txtdevelopername,
			txtdevaddress1, txtdevaddress2, txtdevph, txtdevfax,
			txtcontactname, txtcontactmobile, txtdevbankname, txtdevaccno,
			txtdevbankaddress, txtdevbankph, txtdevbankfax,
			txtchequeownersname, txtrentalvaluefrom, txtrentalvalueto,
			txtnewrent, txtrntcmsnperc, txtexpsaleval, txtmgtfeeperc,
			txtadminfee, txtsnagfee, txtothers, hidwarratydate, hidrdoinstype,
			rdoinstype, hidrdoinsasper, txttermsnotes, txtOwCommisionPerc,
			txtOwCommisionAmt, txtTransferfeePerc, txttrnsnetselAmt,
			txtBuyerCommisionPerc, txtBuyerCommisionAmt,
			txtBuyerTransferfeePerc, txtBuyerTransferfeeAmt, txtnetsalepriceow,
			txtownervalueafterded, txttotalselprice, txtaccgroupcode,
			txtaccgroup, txtacc1, txtmodifiedby, txtmodifieddate,
			txtmodifiedcomments, txtmaintainerfund, txtsalesman,sysgenid;

	public String getSysgenid() {
		return sysgenid;
	}

	public void setSysgenid(String sysgenid) {
		this.sysgenid = sysgenid;
	}

	public String getRdoinstype() {
		return rdoinstype;
	}

	public void setRdoinstype(String rdoinstype) {
		this.rdoinstype = rdoinstype;
	}

	public String getHidcmbptype() {
		return hidcmbptype;
	}

	public void setHidcmbptype(String hidcmbptype) {
		this.hidcmbptype = hidcmbptype;
	}

	public String getTxtsalesman() {
		return txtsalesman;
	}

	public void setTxtsalesman(String txtsalesman) {
		this.txtsalesman = txtsalesman;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public String getTxtBuyerTransferfeeAmt() {
		return txtBuyerTransferfeeAmt;
	}

	public void setTxtBuyerTransferfeeAmt(String txtBuyerTransferfeeAmt) {
		this.txtBuyerTransferfeeAmt = txtBuyerTransferfeeAmt;
	}

	public String getTxtmaintainerfund() {
		return txtmaintainerfund;
	}

	public void setTxtmaintainerfund(String txtmaintainerfund) {
		this.txtmaintainerfund = txtmaintainerfund;
	}

	public String getTxtoptID() {
		return txtoptID;
	}

	public void setTxtoptID(String txtoptID) {
		this.txtoptID = txtoptID;
	}

	public String getCmbptype() {
		return cmbptype;
	}

	public void setCmbptype(String cmbptype) {
		this.cmbptype = cmbptype;
	}

	public String getChkpfor() {
		return chkpfor;
	}

	public void setChkpfor(String chkpfor) {
		this.chkpfor = chkpfor;
	}

	public String getHidchkpfor() {
		return hidchkpfor;
	}

	public void setHidchkpfor(String hidchkpfor) {
		this.hidchkpfor = hidchkpfor;
	}

	public String getTxtaddress1() {
		return txtaddress1;
	}

	public void setTxtaddress1(String txtaddress1) {
		this.txtaddress1 = txtaddress1;
	}

	public String getTxtaddress2() {
		return txtaddress2;
	}

	public void setTxtaddress2(String txtaddress2) {
		this.txtaddress2 = txtaddress2;
	}

	public String getTxtlandmark() {
		return txtlandmark;
	}

	public void setTxtlandmark(String txtlandmark) {
		this.txtlandmark = txtlandmark;
	}

	public String getTxtcontactnumber() {
		return txtcontactnumber;
	}

	public void setTxtcontactnumber(String txtcontactnumber) {
		this.txtcontactnumber = txtcontactnumber;
	}

	public String getTxtspecialnotes() {
		return txtspecialnotes;
	}

	public void setTxtspecialnotes(String txtspecialnotes) {
		this.txtspecialnotes = txtspecialnotes;
	}

	public String getTxtarea1() {
		return txtarea1;
	}

	public void setTxtarea1(String txtarea1) {
		this.txtarea1 = txtarea1;
	}

	public String getTxtyard() {
		return txtyard;
	}

	public void setTxtyard(String txtyard) {
		this.txtyard = txtyard;
	}

	public String getTxtbuilduparea() {
		return txtbuilduparea;
	}

	public void setTxtbuilduparea(String txtbuilduparea) {
		this.txtbuilduparea = txtbuilduparea;
	}

	public String getTxtpropertyviews() {
		return txtpropertyviews;
	}

	public void setTxtpropertyviews(String txtpropertyviews) {
		this.txtpropertyviews = txtpropertyviews;
	}

	public String getJqxwarratydate() {
		return jqxwarratydate;
	}

	public void setJqxwarratydate(String jqxwarratydate) {
		this.jqxwarratydate = jqxwarratydate;
	}

	public String getTxtdevelopername() {
		return txtdevelopername;
	}

	public void setTxtdevelopername(String txtdevelopername) {
		this.txtdevelopername = txtdevelopername;
	}

	public String getTxtdevaddress1() {
		return txtdevaddress1;
	}

	public void setTxtdevaddress1(String txtdevaddress1) {
		this.txtdevaddress1 = txtdevaddress1;
	}

	public String getTxtdevaddress2() {
		return txtdevaddress2;
	}

	public void setTxtdevaddress2(String txtdevaddress2) {
		this.txtdevaddress2 = txtdevaddress2;
	}

	public String getTxtdevph() {
		return txtdevph;
	}

	public void setTxtdevph(String txtdevph) {
		this.txtdevph = txtdevph;
	}

	public String getTxtdevfax() {
		return txtdevfax;
	}

	public void setTxtdevfax(String txtdevfax) {
		this.txtdevfax = txtdevfax;
	}

	public String getTxtcontactname() {
		return txtcontactname;
	}

	public void setTxtcontactname(String txtcontactname) {
		this.txtcontactname = txtcontactname;
	}

	public String getTxtcontactmobile() {
		return txtcontactmobile;
	}

	public void setTxtcontactmobile(String txtcontactmobile) {
		this.txtcontactmobile = txtcontactmobile;
	}

	public String getTxtdevbankname() {
		return txtdevbankname;
	}

	public void setTxtdevbankname(String txtdevbankname) {
		this.txtdevbankname = txtdevbankname;
	}

	public String getTxtdevaccno() {
		return txtdevaccno;
	}

	public void setTxtdevaccno(String txtdevaccno) {
		this.txtdevaccno = txtdevaccno;
	}

	public String getTxtdevbankaddress() {
		return txtdevbankaddress;
	}

	public void setTxtdevbankaddress(String txtdevbankaddress) {
		this.txtdevbankaddress = txtdevbankaddress;
	}

	public String getTxtdevbankph() {
		return txtdevbankph;
	}

	public void setTxtdevbankph(String txtdevbankph) {
		this.txtdevbankph = txtdevbankph;
	}

	public String getTxtdevbankfax() {
		return txtdevbankfax;
	}

	public void setTxtdevbankfax(String txtdevbankfax) {
		this.txtdevbankfax = txtdevbankfax;
	}

	public String getTxtchequeownersname() {
		return txtchequeownersname;
	}

	public void setTxtchequeownersname(String txtchequeownersname) {
		this.txtchequeownersname = txtchequeownersname;
	}

	public String getTxtrentalvaluefrom() {
		return txtrentalvaluefrom;
	}

	public void setTxtrentalvaluefrom(String txtrentalvaluefrom) {
		this.txtrentalvaluefrom = txtrentalvaluefrom;
	}

	public String getTxtrentalvalueto() {
		return txtrentalvalueto;
	}

	public void setTxtrentalvalueto(String txtrentalvalueto) {
		this.txtrentalvalueto = txtrentalvalueto;
	}

	public String getTxtnewrent() {
		return txtnewrent;
	}

	public void setTxtnewrent(String txtnewrent) {
		this.txtnewrent = txtnewrent;
	}

	public String getTxtrntcmsnperc() {
		return txtrntcmsnperc;
	}

	public void setTxtrntcmsnperc(String txtrntcmsnperc) {
		this.txtrntcmsnperc = txtrntcmsnperc;
	}

	public String getTxtexpsaleval() {
		return txtexpsaleval;
	}

	public void setTxtexpsaleval(String txtexpsaleval) {
		this.txtexpsaleval = txtexpsaleval;
	}

	public String getTxtmgtfeeperc() {
		return txtmgtfeeperc;
	}

	public void setTxtmgtfeeperc(String txtmgtfeeperc) {
		this.txtmgtfeeperc = txtmgtfeeperc;
	}

	public String getTxtadminfee() {
		return txtadminfee;
	}

	public void setTxtadminfee(String txtadminfee) {
		this.txtadminfee = txtadminfee;
	}

	public String getTxtsnagfee() {
		return txtsnagfee;
	}

	public void setTxtsnagfee(String txtsnagfee) {
		this.txtsnagfee = txtsnagfee;
	}

	public String getTxtothers() {
		return txtothers;
	}

	public void setTxtothers(String txtothers) {
		this.txtothers = txtothers;
	}

	public String getHidwarratydate() {
		return hidwarratydate;
	}

	public void setHidwarratydate(String hidwarratydate) {
		this.hidwarratydate = hidwarratydate;
	}

	public String getHidrdoinstype() {
		return hidrdoinstype;
	}

	public void setHidrdoinstype(String hidrdoinstype) {
		this.hidrdoinstype = hidrdoinstype;
	}

	public String getHidrdoinsasper() {
		return hidrdoinsasper;
	}

	public void setHidrdoinsasper(String hidrdoinsasper) {
		this.hidrdoinsasper = hidrdoinsasper;
	}

	public String getTxttermsnotes() {
		return txttermsnotes;
	}

	public void setTxttermsnotes(String txttermsnotes) {
		this.txttermsnotes = txttermsnotes;
	}

	public String getTxtOwCommisionPerc() {
		return txtOwCommisionPerc;
	}

	public void setTxtOwCommisionPerc(String txtOwCommisionPerc) {
		this.txtOwCommisionPerc = txtOwCommisionPerc;
	}

	public String getTxtOwCommisionAmt() {
		return txtOwCommisionAmt;
	}

	public void setTxtOwCommisionAmt(String txtOwCommisionAmt) {
		this.txtOwCommisionAmt = txtOwCommisionAmt;
	}

	public String getTxtTransferfeePerc() {
		return txtTransferfeePerc;
	}

	public void setTxtTransferfeePerc(String txtTransferfeePerc) {
		this.txtTransferfeePerc = txtTransferfeePerc;
	}

	public String getTxttrnsnetselAmt() {
		return txttrnsnetselAmt;
	}

	public void setTxttrnsnetselAmt(String txttrnsnetselAmt) {
		this.txttrnsnetselAmt = txttrnsnetselAmt;
	}

	public String getTxtBuyerCommisionPerc() {
		return txtBuyerCommisionPerc;
	}

	public void setTxtBuyerCommisionPerc(String txtBuyerCommisionPerc) {
		this.txtBuyerCommisionPerc = txtBuyerCommisionPerc;
	}

	public String getTxtBuyerCommisionAmt() {
		return txtBuyerCommisionAmt;
	}

	public void setTxtBuyerCommisionAmt(String txtBuyerCommisionAmt) {
		this.txtBuyerCommisionAmt = txtBuyerCommisionAmt;
	}

	public String getTxtBuyerTransferfeePerc() {
		return txtBuyerTransferfeePerc;
	}

	public void setTxtBuyerTransferfeePerc(String txtBuyerTransferfeePerc) {
		this.txtBuyerTransferfeePerc = txtBuyerTransferfeePerc;
	}

	public String getTxtnetsalepriceow() {
		return txtnetsalepriceow;
	}

	public void setTxtnetsalepriceow(String txtnetsalepriceow) {
		this.txtnetsalepriceow = txtnetsalepriceow;
	}

	public String getTxtownervalueafterded() {
		return txtownervalueafterded;
	}

	public void setTxtownervalueafterded(String txtownervalueafterded) {
		this.txtownervalueafterded = txtownervalueafterded;
	}

	public String getTxttotalselprice() {
		return txttotalselprice;
	}

	public void setTxttotalselprice(String txttotalselprice) {
		this.txttotalselprice = txttotalselprice;
	}

	public String getTxtaccgroupcode() {
		return txtaccgroupcode;
	}

	public void setTxtaccgroupcode(String txtaccgroupcode) {
		this.txtaccgroupcode = txtaccgroupcode;
	}

	public String getTxtaccgroup() {
		return txtaccgroup;
	}

	public void setTxtaccgroup(String txtaccgroup) {
		this.txtaccgroup = txtaccgroup;
	}

	public String getTxtacc1() {
		return txtacc1;
	}

	public void setTxtacc1(String txtacc1) {
		this.txtacc1 = txtacc1;
	}

	public String getTxtmodifiedby() {
		return txtmodifiedby;
	}

	public void setTxtmodifiedby(String txtmodifiedby) {
		this.txtmodifiedby = txtmodifiedby;
	}

	public String getTxtmodifieddate() {
		return txtmodifieddate;
	}

	public void setTxtmodifieddate(String txtmodifieddate) {
		this.txtmodifieddate = txtmodifieddate;
	}

	public String getTxtmodifiedcomments() {
		return txtmodifiedcomments;
	}

	public void setTxtmodifiedcomments(String txtmodifiedcomments) {
		this.txtmodifiedcomments = txtmodifiedcomments;
	}

	public int getCmbcontactperson() {
		return cmbcontactperson;
	}

	public void setCmbcontactperson(int cmbcontactperson) {
		this.cmbcontactperson = cmbcontactperson;
	}

	public int getHidcmbcontactperson() {
		return hidcmbcontactperson;
	}

	public void setHidcmbcontactperson(int hidcmbcontactperson) {
		this.hidcmbcontactperson = hidcmbcontactperson;
	}

	public int getHidunittypeid() {
		return hidunittypeid;
	}

	public void setHidunittypeid(int hidunittypeid) {
		this.hidunittypeid = hidunittypeid;
	}

	public int getHidunitofid() {
		return hidunitofid;
	}

	public void setHidunitofid(int hidunitofid) {
		this.hidunitofid = hidunitofid;
	}

	public int getHidcmbrtainerfund() {
		return hidcmbrtainerfund;
	}

	public void setHidcmbrtainerfund(int hidcmbrtainerfund) {
		this.hidcmbrtainerfund = hidcmbrtainerfund;
	}

	public int getCmbcountry() {
		return cmbcountry;
	}

	public void setCmbcountry(int cmbcountry) {
		this.cmbcountry = cmbcountry;
	}

	public int getHidcmbcountry() {
		return hidcmbcountry;
	}

	public void setHidcmbcountry(int hidcmbcountry) {
		this.hidcmbcountry = hidcmbcountry;
	}

	public int getCmbOwCommision() {
		return cmbOwCommision;
	}

	public void setCmbOwCommision(int cmbOwCommision) {
		this.cmbOwCommision = cmbOwCommision;
	}

	public int getHidcmbOwCommision() {
		return hidcmbOwCommision;
	}

	public void setHidcmbOwCommision(int hidcmbOwCommision) {
		this.hidcmbOwCommision = hidcmbOwCommision;
	}

	public int getCmbOwTransferfee() {
		return cmbOwTransferfee;
	}

	public void setCmbOwTransferfee(int cmbOwTransferfee) {
		this.cmbOwTransferfee = cmbOwTransferfee;
	}

	public int getHidcmbOwTransferfee() {
		return hidcmbOwTransferfee;
	}

	public void setHidcmbOwTransferfee(int hidcmbOwTransferfee) {
		this.hidcmbOwTransferfee = hidcmbOwTransferfee;
	}

	public int getCmbBuyerCommision() {
		return cmbBuyerCommision;
	}

	public void setCmbBuyerCommision(int cmbBuyerCommision) {
		this.cmbBuyerCommision = cmbBuyerCommision;
	}

	public int getHidcmbBuyerCommision() {
		return hidcmbBuyerCommision;
	}

	public void setHidcmbBuyerCommision(int hidcmbBuyerCommision) {
		this.hidcmbBuyerCommision = hidcmbBuyerCommision;
	}

	public int getCmbBuyerTransferfee() {
		return cmbBuyerTransferfee;
	}

	public void setCmbBuyerTransferfee(int cmbBuyerTransferfee) {
		this.cmbBuyerTransferfee = cmbBuyerTransferfee;
	}

	public int getHidcmbBuyerTransferfee() {
		return hidcmbBuyerTransferfee;
	}

	public void setHidcmbBuyerTransferfee(int hidcmbBuyerTransferfee) {
		this.hidcmbBuyerTransferfee = hidcmbBuyerTransferfee;
	}

	public int getCmbaccgroup() {
		return cmbaccgroup;
	}

	public void setCmbaccgroup(int cmbaccgroup) {
		this.cmbaccgroup = cmbaccgroup;
	}

	public int getCmbacc1() {
		return cmbacc1;
	}

	public void setCmbacc1(int cmbacc1) {
		this.cmbacc1 = cmbacc1;
	}

	public int getHidcmbacc1() {
		return hidcmbacc1;
	}

	public void setHidcmbacc1(int hidcmbacc1) {
		this.hidcmbacc1 = hidcmbacc1;
	}

	public int getCmbaccCurrency() {
		return cmbaccCurrency;
	}

	public void setCmbaccCurrency(int cmbaccCurrency) {
		this.cmbaccCurrency = cmbaccCurrency;
	}

	public int getHidcmbaccCurrency() {
		return hidcmbaccCurrency;
	}

	public void setHidcmbaccCurrency(int hidcmbaccCurrency) {
		this.hidcmbaccCurrency = hidcmbaccCurrency;
	}

	private int cmbcontactperson, hidcmbcontactperson, hidunittypeid,
			hidunitofid, hidcmbrtainerfund, cmbcountry, hidcmbcountry,
			cmbOwCommision, hidcmbOwCommision, cmbOwTransferfee,
			hidcmbOwTransferfee, cmbBuyerCommision, hidcmbBuyerCommision,
			cmbBuyerTransferfee, hidcmbBuyerTransferfee, cmbaccgroup, cmbacc1,
			hidcmbacc1, cmbaccCurrency, hidcmbaccCurrency;

	public String getParkingno() {
		return parkingno;
	}

	public void setParkingno(String parkingno) {
		this.parkingno = parkingno;
	}

	public int getParking() {
		return parking;
	}

	public void setParking(int parking) {
		this.parking = parking;
	}

	public String getLandmark() {
		return landmark;
	}

	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getJqxdate() {
		return jqxdate;
	}

	public void setJqxdate(String jqxdate) {
		this.jqxdate = jqxdate;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getPropertyname() {
		return propertyname;
	}

	public void setPropertyname(String propertyname) {
		this.propertyname = propertyname;
	}

	public int getCmbtranstype() {
		return cmbtranstype;
	}

	public void setCmbtranstype(int cmbtranstype) {
		this.cmbtranstype = cmbtranstype;
	}

	public String getPropertyaddress() {
		return propertyaddress;
	}

	public void setPropertyaddress(String propertyaddress) {
		this.propertyaddress = propertyaddress;
	}

	public String getTxtarea() {
		return txtarea;
	}

	public void setTxtarea(String txtarea) {
		this.txtarea = txtarea;
	}

	public String getPropertydesc() {
		return propertydesc;
	}

	public void setPropertydesc(String propertydesc) {
		this.propertydesc = propertydesc;
	}

	public String getPropertytype() {
		return propertytype;
	}

	public void setPropertytype(String propertytype) {
		this.propertytype = propertytype;
	}

	public String getUnittype() {
		return unittype;
	}

	public void setUnittype(String unittype) {
		this.unittype = unittype;
	}

	public int getArm() {
		return arm;
	}

	public void setArm(int arm) {
		this.arm = arm;
	}

	public int getRoomsno() {
		return roomsno;
	}

	public void setRoomsno(int roomsno) {
		this.roomsno = roomsno;
	}

	public String getTxtfor() {
		return txtfor;
	}

	public void setTxtfor(String txtfor) {
		this.txtfor = txtfor;
	}

	public String getUnitno() {
		return unitno;
	}

	public void setUnitno(String unitno) {
		this.unitno = unitno;
	}

	public String getUnitof() {
		return unitof;
	}

	public void setUnitof(String unitof) {
		this.unitof = unitof;
	}

	public String getBayno() {
		return bayno;
	}

	public void setBayno(String bayno) {
		this.bayno = bayno;
	}

	public String getTxtareasqft() {
		return txtareasqft;
	}

	public void setTxtareasqft(String txtareasqft) {
		this.txtareasqft = txtareasqft;
	}

	public String getBuilduparea() {
		return builduparea;
	}

	public void setBuilduparea(String builduparea) {
		this.builduparea = builduparea;
	}

	public String getYard() {
		return yard;
	}

	public void setYard(String yard) {
		this.yard = yard;
	}

	public String getElectricwaterno() {
		return electricwaterno;
	}

	public void setElectricwaterno(String electricwaterno) {
		this.electricwaterno = electricwaterno;
	}

	public String getGasconnectionno() {
		return gasconnectionno;
	}

	public void setGasconnectionno(String gasconnectionno) {
		this.gasconnectionno = gasconnectionno;
	}

	public String getAcconnectionno() {
		return acconnectionno;
	}

	public void setAcconnectionno(String acconnectionno) {
		this.acconnectionno = acconnectionno;
	}

	public String getPremisesno() {
		return premisesno;
	}

	public void setPremisesno(String premisesno) {
		this.premisesno = premisesno;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public int getHidparking() {
		return hidparking;
	}

	public void setHidparking(int hidparking) {
		this.hidparking = hidparking;
	}

	public int getUnitofid() {
		return unitofid;
	}

	public void setUnitofid(int unitofid) {
		this.unitofid = unitofid;
	}

	public int getOwnerid() {
		return ownerid;
	}

	public void setOwnerid(int ownerid) {
		this.ownerid = ownerid;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getHidcmbaccgroup() {
		return hidcmbaccgroup;
	}

	public void setHidcmbaccgroup(int hidcmbaccgroup) {
		this.hidcmbaccgroup = hidcmbaccgroup;
	}

	public int getHidchkmanagedproperty() {
		return hidchkmanagedproperty;
	}

	public void setHidchkmanagedproperty(int hidchkmanagedproperty) {
		this.hidchkmanagedproperty = hidchkmanagedproperty;
	}

	public int getTxtareaid() {
		return txtareaid;
	}

	public void setTxtareaid(int txtareaid) {
		this.txtareaid = txtareaid;
	}

	public int getHidpropertytype() {
		return hidpropertytype;
	}

	public void setHidpropertytype(int hidpropertytype) {
		this.hidpropertytype = hidpropertytype;
	}

	public int getHidunittype() {
		return hidunittype;
	}

	public void setHidunittype(int hidunittype) {
		this.hidunittype = hidunittype;
	}

	public int getHidarm() {
		return hidarm;
	}

	public void setHidarm(int hidarm) {
		this.hidarm = hidarm;
	}

	// special Instruction Grid
	private int splgridlength;

	public int getSplgridlength() {
		return splgridlength;
	}

	public void setSplgridlength(int splgridlength) {
		this.splgridlength = splgridlength;
	}

	// special Instruction Grid
	private int accgridlength;

	public int getAccgridlength() {
		return accgridlength;
	}

	public void setAccgridlength(int accgridlength) {
		this.accgridlength = accgridlength;
	}

	public int selectedfurgridlength;

	public int getSelectedfurgridlength() {
		return selectedfurgridlength;
	}

	public void setSelectedfurgridlength(int selectedfurgridlength) {
		this.selectedfurgridlength = selectedfurgridlength;
	}

	public int no_of_bath, no_of_rooms;

	public int getNo_of_bath() {
		return no_of_bath;
	}

	public void setNo_of_bath(int no_of_bath) {
		this.no_of_bath = no_of_bath;
	}

	public int getNo_of_rooms() {
		return no_of_rooms;
	}

	public void setNo_of_rooms(int no_of_rooms) {
		this.no_of_rooms = no_of_rooms;
	}

	ClsPropertyMasterDAO ClsPropertyMasterDAO = new ClsPropertyMasterDAO();
	ClsPropertyMasterBean v = new ClsPropertyMasterBean();

	public String saveAction() throws SQLException {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		if (!(getMode().equalsIgnoreCase("view"))) {
			java.sql.Date masterdate = ClsCommon
					.changeStringtoSqlDate(getJqxdate());
			java.sql.Date modified_date = null;
			modified_date = getTxtmodifieddate() != null
					|| getTxtmodifieddate() != "" ? ClsCommon
					.changeStringtoSqlDate(getTxtmodifieddate()) : null;

			java.sql.Date warrantydate = null;
			warrantydate = getHidwarratydate() != null
					|| getHidwarratydate() != "" ? ClsCommon
					.changeStringtoSqlDate(getHidwarratydate()) : null;
			/* Special Instructions Grid */
			ArrayList<String> splinstructionarray = new ArrayList<String>();
			for (int i = 0; i < getSplgridlength(); i++) {
				String spl = requestParams.get("txtsplinstructions" + i)[0];
				splinstructionarray.add(spl);
			}
			/* Special Instructions Grid Ends */

			/* Access Grid */
			ArrayList<String> accessarray = new ArrayList<String>();
			for (int i = 0; i < getAccgridlength(); i++) {
				String acc = requestParams.get("txtaccess" + i)[0];
				accessarray.add(acc);
			}
			/* Access Grid Ends */

			/* selectedfurniture Grid */
			ArrayList<String> furniturearray = new ArrayList<String>();
			for (int i = 0; i < getSelectedfurgridlength(); i++) {
				String fur = requestParams.get("txtselectedfur" + i)[0];
				furniturearray.add(fur);
			}
			/* selectedfurniture Grid Ends */

			/* Calculate inspection date starts */

			java.sql.Date insdate = null;
			String instype = "";
			String qry = "";

			Connection cn = ClsConnection.getMyConnection();
			Statement st = cn.createStatement();

			if (getHidrdoinsasper() != null && getHidrdoinsasper() != ""
					&& getHidrdoinsasper().equalsIgnoreCase("P")) {
				if (getHidrdoinstype() != null && getHidrdoinstype() != "") {
					if (getHidrdoinstype().equalsIgnoreCase("HY")) {
						qry = "SELECT DATE_ADD( '" + masterdate
								+ "', INTERVAL 6 month ) insdate";
						ResultSet rst = st.executeQuery(qry);
						while (rst.next()) {
							insdate = rst.getDate("insdate");
						}
					} else if (getHidrdoinstype().equalsIgnoreCase("Q")) {
						qry = "SELECT DATE_ADD( '" + masterdate
								+ "', INTERVAL 3 month ) insdate";
						ResultSet rst = st.executeQuery(qry);
						while (rst.next()) {
							insdate = rst.getDate("insdate");
						}
					} else if (getHidrdoinstype().equalsIgnoreCase("M")) {
						qry = "SELECT DATE_ADD( '" + masterdate
								+ "', INTERVAL 1 month ) insdate";
						ResultSet rst = st.executeQuery(qry);
						while (rst.next()) {
							insdate = rst.getDate("insdate");
						}
					}
				}
			}
 
			/* Calculate inspection date ends */
			
			System.out.println("contact person id : ---"  + getHidcmbcontactperson());

			int value = ClsPropertyMasterDAO.savemaster(masterdate,
					getMasterdoc_no(), getMode(), getOwnerid(),
					getCmbtranstype(), getTxtoptID(), getCmbptype(),
					getHidchkpfor(), getHidchkmanagedproperty(),
					getTxtaddress1(), getTxtaddress2(), getTxtaccname(),
					getTxtlandmark(), getTxtareaid(), getPropertydesc(),
					getHidpropertytype(), getHidcmbcontactperson(),
					getTxtcontactnumber(), getArm(), getRoomsno(), getTxtfor(),
					getTxtspecialnotes(), getHidunittypeid(), getUnitno(),
					getHidunitofid(), getParking(), getParkingno(), getBayno(),
					getTxtarea1(), getTxtyard(), getTxtbuilduparea(),
					getTxtpropertyviews(), getElectricwaterno(),
					getGasconnectionno(), getAcconnectionno(), getPremisesno(),
					getCmbrtainerfund(), getTxtmaintainerfund(),
					getTxtdevelopername(), getTxtdevaddress1(),
					getTxtdevaddress2(), getTxtdevph(), getTxtdevfax(),
					getTxtcontactname(), getTxtcontactmobile(),
					getTxtdevbankname(), getTxtdevaccno(),
					getTxtdevbankaddress(), getTxtdevbankph(),
					getTxtdevbankfax(), getCmbcountry(),
					getTxtchequeownersname(), getTxtrentalvaluefrom(),
					getTxtrentalvalueto(), getTxtnewrent(),
					getTxtrntcmsnperc(), getTxtexpsaleval(),
					getTxtmgtfeeperc(), getTxtadminfee(), getTxtsnagfee(),
					getTxtothers(), warrantydate, getRdoinstype(),
					getRdoinsasper(), getTxttermsnotes(), getCmbOwCommision(),
					getTxtOwCommisionPerc(), getTxtOwCommisionAmt(),
					getCmbOwTransferfee(), getTxtTransferfeePerc(),
					getTxttrnsnetselAmt(), getCmbBuyerCommision(),
					getTxtBuyerCommisionPerc(), getTxtBuyerCommisionAmt(),
					getCmbBuyerTransferfee(), getTxtBuyerTransferfeePerc(),
					getTxtBuyerTransferfeeAmt(), getTxtnetsalepriceow(),
					getTxtownervalueafterded(), getTxttotalselprice(),
					getTxtmodifiedby(), modified_date,
					getTxtmodifiedcomments(), splinstructionarray, accessarray,
					furniturearray, getNo_of_rooms(), getNo_of_bath(), insdate,getHidchkpforS(),getHidchkpforR(),getHidchkpforHC(),
					session, request, getFormdetailcode(),getTxtsalesman(),getOwner());

			/*
			 * getHidcmbaccgroup(),getTxtaccgroupcode(), getTxtaccgroup(),
			 * getHidcmbacc1(), getTxtacc1(), getHidcmbaccCurrency(),
			 */
			// System.out.println("Value="+value);
			if (getMode().equalsIgnoreCase("A")) {
				if (value > 0) {
					setMasterdoc_no(value);
					setDocno(getDocno());
					int vdocno = (int) request.getAttribute("vocno");

					int accnum = (int) request.getAttribute("accountno");
					setCmbrtainerfund(accnum);

					String acname = (String) request.getAttribute("accname");
					setTxtmaintainerfund(acname);

					String owacno = (String) request.getAttribute("owacno");
					setOwacno(owacno);

					String sysgenid = (String) request.getAttribute("sysgenid");
					setSysgenid(sysgenid);
 
					setVocno(vdocno);
					// setDocno(vdocno);
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());  
					setData();
					setMsg("Successfully Saved");
					return "success";
				} else {
					setData();
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());
					setMsg("Not Saved");
					return "fail";
				}

			}

			if (getMode().equalsIgnoreCase("E")) {
				if (value > 0) {
					setData();
					setMasterdoc_no(value);
					setDocno(getDocno());
					setVocno(getVocno());
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());
					String owacno = (String) request.getAttribute("owacno");
					setOwacno(owacno);

					String sysgenid = (String) request.getAttribute("sysgenid");
					setSysgenid(sysgenid);

					setMsg("Updated Successfully");
					return "success";
				} else {
					setData();
					setMasterdoc_no(value);
					setDocno(getDocno());
					setVocno(getVocno());
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());
					setMsg("Not Updated");
					return "fail";
				}
			}

			if (getMode().equalsIgnoreCase("D")) {
				if (value > 0) { 
					
					setData();
					setMasterdoc_no(value);
					setDocno(getDocno());
					setVocno(getVocno());
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				} else {
					setData();
					setMasterdoc_no(value);
					setDocno(getDocno());
					setVocno(getVocno());
					setHidarm(getArm());
					setHidparking(getParking());
					setHiddate(masterdate.toString());
					setHidcmbaccgroup(getCmbtranstype());
					setHidchequeownersname(getTxtchequeownersname());
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
				String masterdocno=request.getParameter("masterdocno")==null?"":request.getParameter("masterdocno");
				if(!masterdocno.equalsIgnoreCase("") && !masterdocno.equalsIgnoreCase("0")){
					setMasterdoc_no(Integer.parseInt(masterdocno));
				}
				String sqls = " select   coalesce(tenancy_cheque_owner_name,'') tenancy_cheque_owner_name,m.contractfor,m.pforrent,m.pforsale,m.pforhc,m.*,trim(m.specialnotes) spnotes,m.propid as sysgenid,m.address1 as paddr1,m.address2 as paddr2, "
						+ " o.primary_owner  owner, t.transtype, aa.area as areaname,m.area as areaid, pt.prtype pname, bm.name bname,s.sal_name,"
						+ " s.mob_no as smob_no,ut.unittype unitname,h.description accname,h.account accountno,m.acno owacno "
						+ " from rl_propertymaster m "
						+ " left join rl_propertryowner o on o.doc_no=m.owid "
						+ " left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.prtype "
						+ " left   join rl_unittype ut on ut.doc_no=m.unittype  "
						+ " left  join my_area aa on aa.doc_no=m.area  left join rl_buildingm bm on bm.doc_no=m.unitof "
						+ " left join  my_salm s on s.doc_no=m.contactperson "
						+ " left join my_head h on h.doc_no=m.mrf_acno"
						+ " where m.status=3 and m.doc_no="+getMasterdoc_no();

				System.out.println("property view query = " + sqls);
				
				ResultSet rss = stmt.executeQuery(sqls);
				if (rss.first()) {
					setHidchequeownersname(rss.getString("tenancy_cheque_owner_name"));    
					setTxtsalesman(rss.getString("contractfor"));     
					setHidcmbaccgroup(rss.getInt("ttype"));
					setHiddate(rss.getString("date"));
					setOwner(rss.getString("owner"));
					setOwnerid(rss.getInt("owid"));
					// setPropertyname(rss.getString("name"));
					setDocno(rss.getInt("doc_no"));
					setVocno(rss.getInt("voc_no"));
					setHidchkmanagedproperty(rss.getInt("mgprpty"));
					setTxtoptID(rss.getString("optId"));
					setHidcmbptype(rss.getString("ptype"));
					setTxtaddress1(rss.getString("paddr1"));
					setTxtaddress2(rss.getString("paddr2"));
					setHidchkpfor(rss.getString("propertyfor"));
					setTxtaccname(rss.getString("accname"));
					setTxtlandmark(rss.getString("landmark"));
					setTxtareaid(rss.getInt("areaid"));
					setTxtarea(rss.getString("areaname"));
					setPropertydesc(rss.getString("desc1"));
					setPropertytype(rss.getString("pname"));
					setHidpropertytype(rss.getInt("prtype"));
					setHidcmbcontactperson(rss.getInt("contactperson"));
					setTxtcontactnumber(rss.getString("smob_no"));
					setHidarm(rss.getInt("add_room"));
					setRoomsno(rss.getInt("no_ofroom"));
					setTxtfor(rss.getString("prfor"));
					//System.out.println("=====" + rss.getString("spnotes"));
					setTxtspecialnotes(rss.getString("spnotes"));
					setUnitno(rss.getString("unitno"));
					setUnittype(rss.getString("unitname"));
					setHidunittypeid(rss.getInt("unittype"));
					setHidunitofid(rss.getInt("unitof"));
					setUnitof(rss.getString("bname"));
					setHidparking(rss.getInt("parking"));
					setParkingno(rss.getString("parking_no"));
					setBayno(rss.getString("bay_no"));
					setTxtarea1(rss.getString("area_sq"));
					setTxtbuilduparea(rss.getString("buildup_area"));
					setTxtyard(rss.getString("yard"));
					setTxtpropertyviews(rss.getString("propertyviews"));
					setElectricwaterno(rss.getString("elec_water"));
					setGasconnectionno(rss.getString("gas_con"));
					setAcconnectionno(rss.getString("ac_con"));
					setPremisesno(rss.getString("pre_no"));
					setTxtdevelopername(rss.getString("dev_name"));
					setTxtdevaddress1(rss.getString("dev_add1"));
					setTxtdevaddress2(rss.getString("dev_add2"));
					setTxtdevph(rss.getString("dev_tel"));
					setTxtdevfax(rss.getString("dev_fax"));
					setTxtcontactname(rss.getString("dev_cont_name"));
					setTxtcontactmobile(rss.getString("dev_cont_mob"));
					setTxtdevbankname(rss.getString("dev_bankname"));
					setTxtdevaccno(rss.getString("dev_bankaccno"));
					setTxtdevbankaddress(rss.getString("dev_bankadd"));
					setTxtdevbankph(rss.getString("dev_banktel"));
					setTxtdevbankfax(rss.getString("dev_bankfax"));
					setHidcmbcountry(rss.getInt("dev_bankcountry"));
					setTxtchequeownersname(rss
							.getString("tenancy_cheque_owner_name"));
					setTxtrentalvaluefrom(rss
							.getString("terms_rentalvaluefrom"));
					setTxtrentalvalueto(rss.getString("terms_rentalvalueto"));
					setTxtnewrent(rss.getString("terms_newrent"));
					setTxtrntcmsnperc(rss.getString("terms_rentcommisiomperc"));
					setTxtexpsaleval(rss.getString("terms_expsalesvalue"));
					setTxtmgtfeeperc(rss.getString("terms_mangfeeperc"));
					setTxtadminfee(rss.getString("terms_adminfee"));
					setTxtsnagfee(rss.getString("terms_snaggingfee"));
					setTxtothers(rss.getString("terms_others"));
					setHidwarratydate(rss.getString("terms_warranty"));
					setHidrdoinstype(rss.getString("terms_insptype"));
					setHidrdoinsasper(rss.getString("terms_insasper"));
					setTxttermsnotes(rss.getString("terms_notes"));
					setHidcmbOwCommision(rss.getInt("ownercomselpriceflag"));
					setTxtOwCommisionPerc(rss.getString("ownercomselpriceperc"));
					setTxtOwCommisionAmt(rss.getString("ownercomselpriceamt"));
					setHidcmbOwTransferfee(rss
							.getInt("ownertransferfeeselpriceflag"));
					setTxtTransferfeePerc(rss
							.getString("ownertransferfeeselpriceperc"));
					setTxttrnsnetselAmt(rss
							.getString("ownertransferfeeselpriceamt"));
					setHidcmbBuyerCommision(rss.getInt("buyercomselpriceflag"));
					setTxtBuyerCommisionPerc(rss
							.getString("buyercomselpriceperc"));
					setTxtBuyerCommisionAmt(rss
							.getString("buyercomselpriceamt"));
					setHidcmbBuyerTransferfee(rss
							.getInt("buyertransferfeeselpriceflag"));
					setTxtBuyerTransferfeePerc(rss
							.getString("buyertransferfeeselpriceperc"));
					setTxtBuyerTransferfeeAmt(rss
							.getString("buyertransferfeeselpriceamt"));
					setTxtnetsalepriceow(rss.getString("netsalespricetoowner"));
					setTxtownervalueafterded(rss
							.getString("valuetoownerafterded"));
					setTxttotalselprice(rss.getString("totalsellingprice"));
					//setTxtsalesman(rss.getString("sal_name"));
					setNo_of_rooms(rss.getInt("no_of_rooms"));
					setNo_of_bath(rss.getInt("no_of_bathroom"));

					setCmbrtainerfund(rss.getInt("accountno"));
					setTxtmaintainerfund(rss.getString("accname"));
					setOwacno(rss.getString("owacno"));
					setSysgenid(rss.getString("sysgenid"));
					
					setHidchkpforR(rss.getString("pforrent"));
					setHidchkpforS(rss.getString("pforsale"));
					setHidchkpforHC(rss.getString("pforhc"));
				  System.out.println("========"+getHidchkpforR());
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

	public void setData() {
		setHidcmbptype(getCmbptype());
		setHidchkpfor(getHidchkpfor());
		setHidchkmanagedproperty(getHidchkmanagedproperty());
		setPropertydesc(getPropertydesc());
		setTxttermsnotes(getTxttermsnotes());
		setTxtspecialnotes(getTxtspecialnotes());
		setTxtpropertyviews(getTxtpropertyviews());
		setHidcmbrtainerfund(getCmbrtainerfund());
		setHidcmbOwCommision(getCmbOwCommision());
		setHidcmbOwTransferfee(getCmbOwTransferfee());
		setHidcmbBuyerCommision(getCmbBuyerCommision());
		setHidcmbBuyerTransferfee(getCmbBuyerTransferfee());
		setTxtcontactnumber(getTxtcontactnumber());
		setHidcmbcountry(getCmbcountry());
		setUnittype(getUnittype());
		setHidunittypeid(getHidunittypeid());
		setHidunitofid(getHidunitofid());
		setUnitof(getUnitof());
		setHidrdoinstype(getRdoinstype());
		setHidrdoinsasper(getRdoinsasper());
		setOwacno(getOwacno());
		setSysgenid(getSysgenid());
		setHidchkpforS(getHidchkpforS());
		setHidchkpforR(getHidchkpforR());
		setHidchkpforHC(getHidchkpforHC());

	}
}
