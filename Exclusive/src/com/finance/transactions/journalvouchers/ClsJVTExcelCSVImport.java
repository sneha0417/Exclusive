package com.finance.transactions.journalvouchers;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.connection.ClsConnection;

public class ClsJVTExcelCSVImport {

	ClsConnection connDAO = new ClsConnection();
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			java.sql.PreparedStatement pstm = null ;
			
			String path="";
			String line = "";
	        String cvsSplitBy = ",";
	        
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='JVTE'";

			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
			BufferedReader br = new BufferedReader(new FileReader(path));
			
			int i=0;
			
            while ((line = br.readLine()) != null) {

            	if(i>0) {
            		
	                // use comma as separator
	                String[] journal = line.split(cvsSplitBy);
	                String type="",account="",accountname="",costtype="NA",costcode="0",description="";
	                double rate=0.00;
	                String sql1 = "select h.atype type,h.account,h.description accountname,'NA' costtype,0 costcode,round(cb.rate,2) rate,CONCAT('HRMS IMPORTED on ',DATE_FORMAT(now(),'%d-%m-%Y')) description from my_head h "
	                		+ "left join my_accounting ac on h.doc_no=ac.acno left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid left join (select max(cr.doc_no) doc_no,cr.curid curid,"
	                		+ "cr.toDate,cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where ac.hr='"+journal[0]+"'";
	
	    			ResultSet rs1 = stmt.executeQuery(sql1);
	    			while(rs1.next()) {
	    				type=rs1.getString("type");
	    				account=rs1.getString("account");
	    				accountname=rs1.getString("accountname");
	    				costtype=rs1.getString("costtype");
	    				costcode=rs1.getString("costcode");
	    				description=rs1.getString("description");
	    				rate=rs1.getDouble("rate");
	    			}
	    			
	    			if(Double.parseDouble(journal[1])>0){
		                
	    				String sql2 = "INSERT INTO my_jvt_excel(type, accounts, accountname1, costtype, costcode, debit, credit, baseamount, description, id) VALUES"
		                		+ "('"+type+"', '"+account+"', '"+accountname+"', '"+costtype+"', 0, '"+journal[1]+"', 0, '"+Double.parseDouble(journal[1])*rate+"', '"+description+"', '"+docNo+"')";
		                
		                pstm = conn.prepareStatement(sql2);
		                pstm.execute();
	                
	    			}
	    			
	    			if(Double.parseDouble(journal[2])>0){
		                
	    				String sql3 = "INSERT INTO my_jvt_excel(type, accounts, accountname1, costtype, costcode, debit, credit, baseamount, description, id) VALUES"
		                		+ "('"+type+"', '"+account+"', '"+accountname+"', '"+costtype+"', 0, 0, '"+journal[2]+"', '"+Double.parseDouble(journal[2])*rate+"', '"+description+"', '"+docNo+"')";
		                
		                pstm = conn.prepareStatement(sql3);
		                pstm.execute();
	                
	    			}

            	}
            	
                i++;
            }

            conn.commit();
            pstm.close();
            conn.close();
            return 1;
        } catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}

}

