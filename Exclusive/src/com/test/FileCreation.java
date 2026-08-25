package com.test;
import java.io.File;
import java.io.FileNotFoundException;

import javax.swing.filechooser.FileSystemView;

public class FileCreation extends Filewalker {
	
	
	public static void main(String args[]) throws Exception{
		
		FileCreation c= new FileCreation();
		
		c.test();
		c.Settings();
		
		
	}
	
	public void test() {
		
		try{
			
			System.out.println("ghjvhbghbvhb");
			int a=5/0;
			
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		
	}
	
	public String test(String t1){
		
		
		return t1;
	}
	
  public void Settings(int i){
    	
    	System.out.println("===Settings=====");
    }
	
	
	

}
