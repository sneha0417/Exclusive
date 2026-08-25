package com.controlcentre.masters.maintenancemaster;
 
import java.util.*;
 

import com.opensymphony.xwork2.ActionSupport;
 
@SuppressWarnings("serial")
public class ComboBoxAction extends ActionSupport{
 
	private ArrayList<String> fruits;
	private ArrayList<String> aa;
	private String yourFruits;
	private String yourMonth;
 
	public String getYourMonth() {
		return yourMonth;
	}
 
	public void setYourMonth(String yourMonth) {
		this.yourMonth = yourMonth;
	}
 
	public ArrayList<String> getFruits() {
		System.out.println("fruit get");
		return fruits;
	}
 
	public void setFruits(ArrayList<String> fruits) {
		System.out.println("fruit set");
		this.fruits = fruits;
	}
 
	public String getYourFruits() {
		return yourFruits;
	}
 
	public void setYourFruits(String yourFruits) {
		this.yourFruits = yourFruits;
	}
 
	public ComboBoxAction(){
		System.out.println("combo Action");
		fruits = new ArrayList<String>();
		fruits.add("Apple");
		fruits.add("Banana");
		fruits.add("Orange");
		fruits.add("Watermelon");
	}
 
	public String execute() {
		return SUCCESS;
	}
 
	public String display() {
//		Map<String,String> statesList= new HashMap()< String ,String>;
		//statesList.put("CA","California");  
		ComboBoxAction action= new ComboBoxAction();
		return NONE;
	}

	public ArrayList<String> getAa() {
		return aa;
	}

	public void setAa(ArrayList<String> aa) {
		this.aa = aa;
	}
 
}