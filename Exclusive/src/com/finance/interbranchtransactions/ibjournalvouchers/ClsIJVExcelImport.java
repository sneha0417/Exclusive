package com.finance.interbranchtransactions.ibjournalvouchers;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;

import com.connection.ClsConnection;

public class ClsIJVExcelImport {

	ClsConnection connDAO = new ClsConnection();
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			
			String path="";
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='IJVE'";
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
            java.sql.PreparedStatement pstm = null ;
            FileInputStream input = new FileInputStream(path);
            POIFSFileSystem fs = new POIFSFileSystem( input );
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            Row row;
            for(int i=1; i<=sheet.getLastRowNum(); i++){
            	String accounts="",description="";
                row = sheet.getRow(i);
                
                String branch = row.getCell(0).getStringCellValue()=="" || row.getCell(0).getStringCellValue()==null?"0":row.getCell(0).getStringCellValue();
                String type = row.getCell(1).getStringCellValue()=="" || row.getCell(1).getStringCellValue()==null?"0":row.getCell(1).getStringCellValue();
                if(row.getCell(2).getCellType()==1){
                      accounts = row.getCell(2).getStringCellValue()=="" || row.getCell(2).getStringCellValue()==null?"0":row.getCell(2).getStringCellValue().replace("'", " ");
                } else {
                	 accounts = String.valueOf((int) row.getCell(2).getNumericCellValue());	
                }
                String accountname1 = row.getCell(3).getStringCellValue()=="" || row.getCell(3).getStringCellValue()==null?"0":row.getCell(3).getStringCellValue();
                String costtype = row.getCell(4).getStringCellValue()==""  || row.getCell(4).getStringCellValue()==null?"0":row.getCell(4).getStringCellValue();
                int costcode = (int) row.getCell(5).getNumericCellValue();
                double debit = (double) row.getCell(6).getNumericCellValue();
                double credit = (double) row.getCell(7).getNumericCellValue();
                double baseamount = (double) row.getCell(8).getNumericCellValue();
                if(row.getCell(9).getCellType()==1){
                    description = row.getCell(9).getStringCellValue()=="" || row.getCell(9).getStringCellValue()==null?"0":row.getCell(9).getStringCellValue();
                } else {
                	description = String.valueOf((int) row.getCell(9).getNumericCellValue());
                }
                
                String sql = "INSERT INTO my_ijv_excel(branchname, type, accounts, accountname1, costtype, costcode, debit, credit, baseamount, description, id) VALUES"
                		+ "('"+branch+"', '"+type+"', '"+accounts+"', '"+accountname1+"', '"+costtype+"', '"+costcode+"', '"+debit+"', '"+credit+"', '"+baseamount+"', '"+description+"', '"+docNo+"')";
                
                pstm = conn.prepareStatement(sql);
                pstm.execute();
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

