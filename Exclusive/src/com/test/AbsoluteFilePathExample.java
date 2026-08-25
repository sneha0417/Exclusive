package com.test;


import java.io.File;
import java.io.IOException;

import javax.swing.filechooser.FileSystemView;

public class AbsoluteFilePathExample
{
    public static void main(String[] args)
    {	
    	try{
    		
    	   File temp = File.createTempFile("i-am-a-temp-file", ".tmp" );
    	    
        	
    	    String absolutePath = temp.getAbsolutePath();
    	    //System.out.println("File path : " + absolutePath);
    	    
    	    String filePath = absolutePath.
    	    	     substring(0,absolutePath.lastIndexOf(File.separator));
				
    	   // System.out.println("File path===>>>>> : " + filePath);
    	    
    	    
    	    File[] paths;
    	    FileSystemView fsv = FileSystemView.getFileSystemView();

    	    // returns pathnames for files and directory
    	    paths = File.listRoots();

    	    // for each pathname in pathname array
    	    for(File path:paths)
    	    {
    	        // prints file and directory paths
    	        System.out.println("Drive Name: "+path);
    	        System.out.println("Description: "+fsv.getSystemTypeDescription(path));
    	    }
    	    
    	    
    	    
    	    
    	}catch(IOException e){
    		
    	    e.printStackTrace();
    		
    	}
    	
    }
}