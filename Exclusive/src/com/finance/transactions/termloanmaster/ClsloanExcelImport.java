package com.finance.transactions.termloanmaster;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsloanExcelImport {

    public int ExcelImport(String docNo) throws SQLException {
    	ClsConnection ClsConnection=new ClsConnection();

    	 Connection conn = null;
    	
        try{
        	conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			
			String path="";
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='TLON'";
 
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
 
            java.sql.PreparedStatement pstm = null ;
 
    		
    		
 
            FileInputStream input = new FileInputStream(path);
            
 
            POIFSFileSystem fs = new POIFSFileSystem(input);
 
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            Row row;
            
 
            for(int i=1; i<=sheet.getLastRowNum(); i++){
            	
            	java.sql.Date sqlStartDate=null;
                row = sheet.getRow(i);
           
 
                java.util.Date date =(Date) (row.getCell(0).getDateCellValue()==null?"0":row.getCell(0).getDateCellValue());
                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                
                String paymentDate=dateFormat.format(date);
               
    			java.util.Date dateval = dateFormat.parse(paymentDate);
    			sqlStartDate = new java.sql.Date(dateval.getTime());
    			   Cell cell = row.getCell((short)1);
    			int cellType = cell.getCellType();
    			
    			
    			if ( cellType == HSSFCell.CELL_TYPE_NUMERIC )
    				
    			{
    			
    				//System.out.println("------1---");
    				
    				
    			    int chqno =  (int) row.getCell(1).getNumericCellValue();
                    double pramt = (double) row.getCell(2).getNumericCellValue();
                    double intstamt = (double) row.getCell(3).getNumericCellValue();
                    double totamt = (double) row.getCell(4).getNumericCellValue();
                   
                    String sql = "INSERT INTO gl_tln_excel(date, chqno, pramt, intstamt, totamt, id) VALUES"
                    		+ "('"+sqlStartDate+"', '"+chqno+"', '"+pramt+"', '"+intstamt+"', '"+totamt+"','"+docNo+"')";
                    pstm = conn.prepareStatement(sql);
                    pstm.execute();
    				
                
    			}
    			else
    			{
    				
      	
    				//System.out.println("------2---");
                    
                    String chqno =  row.getCell(1).getStringCellValue();
  				   double pramt = (double) row.getCell(2).getNumericCellValue();
  	                double intstamt = (double) row.getCell(3).getNumericCellValue();
  	                double totamt = (double) row.getCell(4).getNumericCellValue();
  	               
  	                String sql = "INSERT INTO gl_tln_excel(date, chqno, pramt, intstamt, totamt, id) VALUES"
  	                		+ "('"+sqlStartDate+"', '"+chqno+"', '"+pramt+"', '"+intstamt+"', '"+totamt+"','"+docNo+"')";
  	                pstm = conn.prepareStatement(sql);
  	                pstm.execute();
    			
    			}
                
             
                
               
            }
            conn.commit();
            pstm.close();
            conn.close();
            input.close();
            return 1;
        }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{ 
		 conn.close();
	 }
	}

}
