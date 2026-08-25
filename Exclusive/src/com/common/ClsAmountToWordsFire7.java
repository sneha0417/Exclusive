package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;

public class ClsAmountToWordsFire7 {
	
	 String mainCode= "";
	 String mainName= "";
     String subName= "";
     String amt = "";
     String currencytype = "";
     int n = 0;
    
    String string;
    
	String st1[] = { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", };
	   
	String st2[] = { "Hundred", "Thousand", "Lakh", "Crore" };  
	
	String st3[] = { "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", };
	
	String st4[] = { "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
	
	String st5[] = { "Hundred", "Thousand", "Million", "Billion" };
	
	String st6[] = { "test", "test", "test", "test" };
    
	public static void main(String args[]) throws SQLException {
		ClsAmountToWords c = new ClsAmountToWords();
		c.convertAmountToWords("n");
	 }
	
	public String currency() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsConnection ClsConnection=new ClsConnection();
		Connection conn = null;
		
		try{
			    
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
				
				String currencyid=session.getAttribute("CURRENCYID").toString().trim();
				
				String sql = "select code,c_name,fraction,cur_nation from my_curr where doc_no="+currencyid+"";
				
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next ()) {
					/*mainName=rs.getString("c_name");*/
					/*mainCode=rs.getString("code");*/
					subName=rs.getString("fraction");
					currencytype=rs.getString("cur_nation");
				}
				
				if(!(currencytype.equalsIgnoreCase("1"))){
					for(int i=0;i<st6.length;i++){
						st6[i]=st2[i];
					}
					
				}
			stmt.close();	
			conn.close();
			return currencytype;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return "fail";
			}
	}
	
	public String convertAmountToWords(String n) throws SQLException
	 {
		 String str1="",str2 = "";
	     amt=n;
	     currency();
	     
	     int rupees = Integer.parseInt(amt.split("\\.")[0]);
	     int paise = Integer.parseInt(amt.split("\\.")[1]);
	     
	     if(currencytype.equalsIgnoreCase("1")){
				ForeignNumberToWord f = new ForeignNumberToWord();
				str1 = f.convert(rupees);
				str1 += " "+mainName+" ";
				
			    if (paise != 0) {
			      str2 += " and";
			      str2 = " and "+f.convert(paise);
			      str2 += " "+subName+"";
			    }

	       }
			else{
				 str1 = convert(rupees);
			     str1 += " "+mainName+" ";
			     if (paise != 0) {
			      str2 += " and";
			      str2 = " and "+convert(paise);
			      str2 += " "+subName+"";
			     }
			}
	     
	     String converted=mainCode+" "+str1 + str2 + " Only";
	     
		 return converted;
	 }
	
	public class ForeignNumberToWord  

	{
	    private final String[] specialNames = {""," Thousand"," Million"," Billion"," Trillion"," Quadrillion"," Quintillion" };
	    
	    private final String[] tensNames = {""," Ten"," Twenty"," Thirty"," Forty"," Fifty"," Sixty"," Seventy"," Eighty"," Ninety" };
	    
	    private final String[] numNames = {""," One"," Two"," Three"," Four"," Five"," Six"," Seven"," Eight"," Nine"," Ten"," Eleven"," Twelve"," Thirteen"," Fourteen"," Fifteen"," Sixteen"," Seventeen"," Eighteen"," Nineteen" };
	    
	    private String convertLessThanOneThousand(int number) {
	        String current;
	        
	        if (number % 100 < 20){
	            current = numNames[number % 100];
	            number /= 100;
	        }
	        else {
	            current = numNames[number % 10];
	            number /= 10;
	            
	            current = tensNames[number % 10] + current;
	            number /= 10;
	        }
	        if (number == 0) return current;
	        return numNames[number] + " Hundred" + current;
	    }
	    
	    public String convert(int number) {

	        if (number == 0) { return "Zero"; }
	        
	        String prefix = "";
	        
	        if (number < 0) {
	            number = -number;
	            prefix = "negative";
	        }
	        
	        String current = "";
	        int place = 0;
	        
	        do {
	            int n = number % 1000;
	            if (n != 0){
	                String s = convertLessThanOneThousand(n);
	                current = s + specialNames[place] + current;
	            }
	            place++;
	            number /= 1000;
	        } while (number > 0);
	        
	        return (prefix + current).trim();
	    }
	    
	}
	
	
	public String convert(int number) {
		  int n = 1;
		  int word;
		  string = "";
		  while (number != 0) {
		   switch (n) {
		   case 1:
		    word = number % 100;
		    pass(word);
		    if (number > 100 && number % 100 != 0) {
		     show(" ");
		    }
		    number /= 100;
		    break;
		   case 2:
		    word = number % 10;
		    if (word != 0) {
		     show(" ");
		     show(st6[0]);
		     show(" ");
		     pass(word);
		    }
		    number /= 10;
		    break;
		   case 3:
		    word = number % 100;
		    if (word != 0) {
		     show(" ");
		     show(st6[1]);
		     show(" ");
		     pass(word);
		    }
		    number /= 100;
		    break;
		   case 4:
		    word = number % 100;
		    if (word != 0) {
		     show(" ");
		     show(st6[2]);
		     show(" ");
		     pass(word);
		    }
		    number /= 100;
		    break;
		   case 5:
		    word = number % 100;
		    if (word != 0) {
		     show(" ");
		     show(st6[3]);
		     show(" ");
		     pass(word);
		    }
		    number /= 100;
		    break;
		   }
		   n++;
		  }
		  return string;
		 }


		 public void pass(int number) {
		  int word, q;
		  if (number < 10) {
		   show(st1[number]);
		  }
		  if (number > 9 && number < 20) {
		   show(st3[number - 10]);
		  }
		  if (number > 19) {
		   word = number % 10;
		   if (word == 0) {
		    q = number / 10;
		    show(st4[q - 2]);
		   } else {
		    q = number / 10;
		    show(st1[word]);
		    show(" ");
		    show(st4[q - 2]);
		   }
		  }
		 }


		 public void show(String s) {
		  String st;
		  st = string;
		  string = s;
		  string += st;
		 }
}
