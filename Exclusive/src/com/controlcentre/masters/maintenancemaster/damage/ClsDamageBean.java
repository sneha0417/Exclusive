package com.controlcentre.masters.maintenancemaster.damage;

import java.util.*;

public class ClsDamageBean {

	private int docno;
	private String mode;
	private String delete;
	private String dmgid;
	private Date  damagedate;
	private String name1;
	private double dmgcharge;
	private Date damagedatehidden;
	
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
	public String getDelete() {
		return delete;
	}
	public void setDelete(String delete) {
		this.delete = delete;
	}
	public String getDmgid() {
		return dmgid;
	}
	public void setDmgid(String dmgid) {
		this.dmgid = dmgid;
	}
	public Date getDamagedate() {
		return damagedate;
	}
	public void setDamagedate(Date damagedate) {
		this.damagedate = damagedate;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public double getDmgcharge() {
		return dmgcharge;
	}
	public void setDmgcharge(double dmgcharge) {
		this.dmgcharge = dmgcharge;
	}
	public Date getDamagedatehidden() {
		return damagedatehidden;
	}
	public void setDamagedatehidden(Date damagedatehidden) {
		this.damagedatehidden = damagedatehidden;
	}

}
