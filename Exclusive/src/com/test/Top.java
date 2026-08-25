package com.test;

public class Top {
	
	public Top(String s){
		
		System.out.println("B");
	}
	

}

class Bottom extends Top{

	public Bottom(String s) {
		super(s);
		System.out.println("D");
	}
	
	
}


class Exe{

	public static void main(String args[]){
		
		/*new bottom("C");*/
		
		System.out.println("E");
	}
	
	
}