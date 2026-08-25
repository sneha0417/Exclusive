package com.test;

import java.io.File;
import java.io.FileNotFoundException;

public class Filewalker {

    public void walk( String path ) throws Exception {

        File root = new File( path );
        File[] list = root.listFiles();

        if (list == null) return;

        for ( File f : list ) {
            if ( f.isDirectory() ) {
                walk( f.getAbsolutePath() );
                System.out.println( "Dir:" + f.getAbsoluteFile() );
                
            }
            else {
            	
                System.out.println( "File:" + f.getAbsoluteFile() );
            }
        }
    }
    
    
    public void Settings(){
    	
    	System.out.println("===Settings=====");
    }

  /*  public static void main(String[] args) {
        Filewalker fw = new Filewalker();
        fw.walk("C:\\" );
    }*/

}