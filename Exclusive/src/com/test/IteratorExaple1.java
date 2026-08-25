package com.test;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

public class IteratorExaple1 {

	public static void main(String args[]){
		
		IteratorExaple1 i1=new IteratorExaple1();
		
		i1.itreate();
	}
	
	public void itreate(){
		
		ArrayList list=new ArrayList();
		
		list.add("1");
		list.add("11");
		list.add("111");
		list.add("1111");
		list.add("11111");
		list.add("111111");
		
	/*	String remove="11";
		ListIterator itr=null; 
		
		itr=list.listIterator();
		
		while(itr.hasNext()){
			
			if(remove.equals((itr.next().toString()))){
				itr.remove();
			}
			
			System.out.println("list==in order==="+itr.next());
		}
		
		while(itr.hasPrevious()){
			
			System.out.println("list==in reverse order==="+itr.previous());
		}*/
		
		List list1= list.subList(1,3);
		
		System.out.println("list====="+list1);
		
	}
	
	
}
