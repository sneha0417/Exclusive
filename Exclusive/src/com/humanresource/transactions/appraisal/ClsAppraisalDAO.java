package com.humanresource.transactions.appraisal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 
	public class ClsAppraisalDAO {
		
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(int years, int months, Date masterdate, Date payroldate, Date appdate, int empdocno, int hiddeprtment, int hiddesignation, int hidcategory, int hidcmbdept,
			int hidcmbdesignation, int hidcmbcategory, String desc, int change, String formdetailcode, String mode, HttpServletRequest request, HttpSession session, ArrayList<String> comparray) throws SQLException {
		
		Connection conn=null;

		try{
                conn=ClsConnection.getMyConnection();
                conn.setAutoCommit(false);
                
			    CallableStatement apprstmt = conn.prepareCall("{CALL HR_appraisalDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
			    apprstmt.registerOutParameter(20, java.sql.Types.INTEGER);
				apprstmt.setDate(1,masterdate);
				apprstmt.setDate(2,payroldate);
				apprstmt.setDate(3,appdate);
				apprstmt.setInt(4,years);
				apprstmt.setInt(5,months);
				apprstmt.setInt(6,empdocno);
				apprstmt.setInt(7,hiddeprtment);
				apprstmt.setInt(8,hiddesignation);
				apprstmt.setInt(9,hidcategory);
				apprstmt.setInt(10,change);
				apprstmt.setInt(11,hidcmbdept);
				apprstmt.setInt(12,hidcmbdesignation);
				apprstmt.setInt(13,hidcmbcategory);
				apprstmt.setString(14,desc);
				apprstmt.setString(15,mode);
				apprstmt.setString(16,session.getAttribute("USERID").toString().trim());
				apprstmt.setString(17,session.getAttribute("BRANCHID").toString().trim());
				apprstmt.setString(18,session.getAttribute("COMPANYID").toString().trim());
				apprstmt.setString(19,formdetailcode);
				apprstmt.executeQuery();
				int docno=apprstmt.getInt("docNo");
				if(docno<=0) {
					conn.close();
					return 0;
				}	     
			
			CallableStatement stmtEMP1=null;
			
			for(int i=0;i< comparray.size();i++){
			     
				 String[] comarray=comparray.get(i).split("::");
			     if(!(comarray[0].trim().equalsIgnoreCase("undefined")|| comarray[0].trim().equalsIgnoreCase("NaN")||comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty())) {
			    	
			    	  if(!(comarray[5].trim().equalsIgnoreCase("STD")) && ((!(comarray[1].trim().equalsIgnoreCase("undefined")) && !(comarray[1].trim().equalsIgnoreCase("NaN")) && !(comarray[1].trim().equalsIgnoreCase("")) && !(comarray[1].trim().isEmpty())) || ((!(comarray[2].trim().equalsIgnoreCase("undefined")) && !(comarray[2].trim().equalsIgnoreCase("NaN")) && !(comarray[2].trim().equalsIgnoreCase("")) && !(comarray[2].trim().isEmpty()))))) {  	 
			    	  
		              String sql="INSERT INTO hr_incrd(sr_no,awlId,addition,deduction,statutorydeduction,remarks,refdtype,revadd,revded,revstatded,rdocno)VALUES"
				         + " ("+(i+1)+","
				         + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
				         + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
				         + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
				         + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")||comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
				         + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")||comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
				         + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
				         + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
				         + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
				         + "'"+(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim())+"',"
				         +"'"+docno+"')";
				     int resultSet2 = apprstmt.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
					 }
					 
					stmtEMP1 = conn.prepareCall("update hr_empsal set addition=?,deduction=?,statutorydeduction=? where awlId=? and refdtype=? and rdocno=?");
			     	
					stmtEMP1.setString(1,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
					stmtEMP1.setString(2,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
					stmtEMP1.setString(3,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
					stmtEMP1.setString(4,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid 
					stmtEMP1.setString(5,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
					stmtEMP1.setInt(6,empdocno); //empid
					stmtEMP1.executeUpdate();
					
					int data=0;
					String sqls ="select * from hr_empsal where awlid='"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()+"' and refdtype='"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()+"' and rdocno='"+empdocno+"'";
					ResultSet resultSet=stmtEMP1.executeQuery(sqls);
					while(resultSet.next()){
						data=1;
					}
					
					if(data==0) {
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,empdocno); //empid
						stmtEMP1.setString(2,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid
						stmtEMP1.setString(3,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
						stmtEMP1.setString(4,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
						stmtEMP1.setString(5,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
						stmtEMP1.setString(6,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,"APPRAISAL");
						stmtEMP1.executeUpdate();
						
					}
			     }
			    		
			     if((comarray[5].trim().equalsIgnoreCase("STD")) && (!(comarray[3].trim().equalsIgnoreCase("undefined"))  && !(comarray[3].trim().equalsIgnoreCase("NaN")) && !(comarray[3].trim().equalsIgnoreCase("")) && !(comarray[3].trim().isEmpty()))) {
			    			
		    		 String sql="INSERT INTO hr_incrd(sr_no,awlId,addition,deduction,statutorydeduction,remarks,refdtype,revadd,revded,revstatded,rdocno)VALUES"
		  				       + " ("+(i+1)+","
		  				       + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
		  				       + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
		  				       + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
		  				       + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")||comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
		  				       + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")||comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
		  				       + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
		  				       + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
		  				       + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
		  				       + "'"+(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim())+"',"
		  				       +"'"+docno+"')";
		  			  int resultSet2 = apprstmt.executeUpdate(sql);
		  			  if(resultSet2<=0) {
		  					conn.close();
		  					return 0;
		  			  }	
			    	
					stmtEMP1 = conn.prepareCall("update hr_empsal set addition=?,deduction=?,statutorydeduction=? where awlId=? and refdtype=? and rdocno=?");
			     	
					stmtEMP1.setString(1,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
					stmtEMP1.setString(2,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
					stmtEMP1.setString(3,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
					stmtEMP1.setString(4,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid 
					stmtEMP1.setString(5,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
					stmtEMP1.setInt(6,empdocno); //empid
					stmtEMP1.executeUpdate();
					
					int data=0;
					String sqls ="select * from hr_empsal where awlid='"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()+"' and refdtype='"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()+"' and rdocno='"+empdocno+"'";
					ResultSet resultSet=stmtEMP1.executeQuery(sqls);
					while(resultSet.next()){
						data=1;
					}
					
					if(data==0) {
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,empdocno); //empid
						stmtEMP1.setString(2,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid
						stmtEMP1.setString(3,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
						stmtEMP1.setString(4,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
						stmtEMP1.setString(5,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
						stmtEMP1.setString(6,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,"APPRAISAL");
						stmtEMP1.executeUpdate();
						
					}
					
			     }
			    		
			   }
			}
			if (docno > 0) {
				conn.commit();
				apprstmt.close();
				conn.close();
				return docno;
			}
           }  catch (Exception e) {
			  conn.close(); 
			  e.printStackTrace();
		}
		return 0;
	}

	public int update(int docno,int years, int months, Date masterdate, Date payroldate, Date appdate, int empdocno, int hiddeprtment, int hiddesignation, int hidcategory, int hidcmbdept,
		int hidcmbdesignation, int hidcmbcategory, String desc, int change, String formdetailcode, String mode, HttpServletRequest request, HttpSession session, ArrayList<String> comparray) throws SQLException {
	
	Connection conn=null;

	try{
            conn=ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            
		    CallableStatement apprstmt = conn.prepareCall("{CALL HR_appraisalDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
		    apprstmt.setInt(20, docno);
			apprstmt.setDate(1,masterdate);
			apprstmt.setDate(2,payroldate);
			apprstmt.setDate(3,appdate);
			apprstmt.setInt(4,years);
			apprstmt.setInt(5,months);
			apprstmt.setInt(6,empdocno);
			apprstmt.setInt(7,hiddeprtment);
			apprstmt.setInt(8,hiddesignation);
			apprstmt.setInt(9,hidcategory);
			apprstmt.setInt(10,change);
			apprstmt.setInt(11,hidcmbdept);
			apprstmt.setInt(12,hidcmbdesignation);
			apprstmt.setInt(13,hidcmbcategory);
			apprstmt.setString(14,desc);
			apprstmt.setString(15,mode);
			apprstmt.setString(16,session.getAttribute("USERID").toString().trim());
			apprstmt.setString(17,session.getAttribute("BRANCHID").toString().trim());
			apprstmt.setString(18,session.getAttribute("COMPANYID").toString().trim());
			apprstmt.setString(19,formdetailcode);
			int res=apprstmt.executeUpdate();
			docno=apprstmt.getInt("docNo");
			if(res<=0) {
				conn.close();
				return 0;
			}	     
							
			String delsql="delete from hr_incrd where rdocno='"+docno+"'";			
			apprstmt.executeUpdate(delsql);
					
			CallableStatement stmtEMP1=null;
			
			for(int i=0;i< comparray.size();i++){
	    	
		    String[] comarray=comparray.get(i).split("::");
		       	 
		    if(!(comarray[0].trim().equalsIgnoreCase("undefined")|| comarray[0].trim().equalsIgnoreCase("NaN")||comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty())) {
		    	
		       if(!(comarray[5].trim().equalsIgnoreCase("STD")) && ((!(comarray[1].trim().equalsIgnoreCase("undefined")) && !(comarray[1].trim().equalsIgnoreCase("NaN")) && !(comarray[1].trim().equalsIgnoreCase("")) && !(comarray[1].trim().isEmpty())) || ((!(comarray[2].trim().equalsIgnoreCase("undefined")) && !(comarray[2].trim().equalsIgnoreCase("NaN")) && !(comarray[2].trim().equalsIgnoreCase("")) && !(comarray[2].trim().isEmpty()))))) {  	 
		    	  
	              String sql="INSERT INTO hr_incrd(sr_no,awlId,addition,deduction,statutorydeduction,remarks,refdtype,revadd,revded,revstatded,rdocno)VALUES"
			          + " ("+(i+1)+","
			          + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
			          + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
			          + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
			          + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")||comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
			          + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")||comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
			          + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
			          + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
			          + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
			          + "'"+(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim())+"',"
			          +"'"+docno+"')";
	    
			     int resultSet2 = apprstmt.executeUpdate(sql);
			     if(resultSet2<=0) {
						conn.close();
						return 0;
				 }
				 
					stmtEMP1 = conn.prepareCall("update hr_empsal set addition=?,deduction=?,statutorydeduction=? where awlId=? and refdtype=? and rdocno=?");
			     	
					stmtEMP1.setString(1,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
					stmtEMP1.setString(2,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
					stmtEMP1.setString(3,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
					stmtEMP1.setString(4,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid 
					stmtEMP1.setString(5,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
					stmtEMP1.setInt(6,empdocno); //empid
					stmtEMP1.executeUpdate();
					
					int data=0;
					String sqls ="select * from hr_empsal where awlid='"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()+"' and refdtype='"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()+"' and rdocno='"+empdocno+"'";
					ResultSet resultSet=stmtEMP1.executeQuery(sqls);
					while(resultSet.next()){
						data=1;
					}
					
					if(data==0) {
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,empdocno); //empid
						stmtEMP1.setString(2,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid
						stmtEMP1.setString(3,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
						stmtEMP1.setString(4,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
						stmtEMP1.setString(5,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
						stmtEMP1.setString(6,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,"APPRAISAL");
						stmtEMP1.executeUpdate();
						
					}
			     
		    	}
		    		
		    	if((comarray[5].trim().equalsIgnoreCase("STD")) && (!(comarray[3].trim().equalsIgnoreCase("undefined"))  && !(comarray[3].trim().equalsIgnoreCase("NaN")) && !(comarray[3].trim().equalsIgnoreCase("")) && !(comarray[3].trim().isEmpty()))) {
		    			
		    		 String sql="INSERT INTO hr_incrd(sr_no,awlId,addition,deduction,statutorydeduction,remarks,refdtype,revadd,revded,revstatded,rdocno)VALUES"
		  				       + " ("+(i+1)+","
		  				       + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
		  				       + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
		  				       + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
		  				       + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")||comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
		  				       + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")||comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
		  				       + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
		  				       + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
		  				       + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
		  				       + "'"+(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim())+"',"
		  				       +"'"+docno+"')";
		  		  
		  			int resultSet2 = apprstmt.executeUpdate(sql);
		  			if(resultSet2<=0) {
		  					conn.close();
		  					return 0;
		  			}

					stmtEMP1 = conn.prepareCall("update hr_empsal set addition=?,deduction=?,statutorydeduction=? where awlId=? and refdtype=? and rdocno=?");
			     	
					stmtEMP1.setString(1,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
					stmtEMP1.setString(2,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
					stmtEMP1.setString(3,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
					stmtEMP1.setString(4,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid 
					stmtEMP1.setString(5,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
					stmtEMP1.setInt(6,empdocno); //empid
					stmtEMP1.executeUpdate();
					
					int data=0;
					String sqls ="select * from hr_empsal where awlid='"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()+"' and refdtype='"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()+"' and rdocno='"+empdocno+"'";
					ResultSet resultSet=stmtEMP1.executeQuery(sqls);
					while(resultSet.next()){
						data=1;
					}
					
					if(data==0) {
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,empdocno); //empid
						stmtEMP1.setString(2,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid
						stmtEMP1.setString(3,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim()).toString()); //dtype 
						stmtEMP1.setString(4,(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")||comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim()).toString()); //addition
						stmtEMP1.setString(5,(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")||comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim()).toString()); //deduction
						stmtEMP1.setString(6,(comarray[8].trim().equalsIgnoreCase("undefined") || comarray[8].trim().equalsIgnoreCase("NaN")||comarray[8].trim().equalsIgnoreCase("")|| comarray[8].isEmpty()?0:comarray[8].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,"APPRAISAL");
						stmtEMP1.executeUpdate();
						
					}
					
		    	 }
		     }
		}
		if (docno > 0) {
			conn.commit();
			apprstmt.close();
			conn.close();
			return docno;
		}
		
      } catch (Exception e) {
		   conn.close();
		   e.printStackTrace();
	 }
	return 0;
	}

	
	public int delete(int docno, String mode, String formdetailcode, int empdocno, HttpSession session, HttpServletRequest request) throws SQLException {

	Connection conn=null;

	try{
            conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		
		    CallableStatement apprstmt = conn.prepareCall("{CALL HR_appraisalDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
		    apprstmt.setInt(20, docno);
			apprstmt.setDate(1,null);
			apprstmt.setDate(2,null);
			apprstmt.setDate(3,null);
			apprstmt.setInt(4,0);
			apprstmt.setInt(5,0);
			apprstmt.setInt(6,0);
			apprstmt.setInt(7,0);
			apprstmt.setInt(8,0);
			apprstmt.setInt(9,0);
			apprstmt.setInt(10,0);
			apprstmt.setInt(11,0);
			apprstmt.setInt(12,0);
			apprstmt.setInt(13,0);
			apprstmt.setString(14,null);
			apprstmt.setString(15,mode);
			apprstmt.setString(16,session.getAttribute("USERID").toString().trim());
			apprstmt.setString(17,session.getAttribute("BRANCHID").toString().trim());
			apprstmt.setString(18,session.getAttribute("COMPANYID").toString().trim());
			apprstmt.setString(19,formdetailcode);
			int res=apprstmt.executeUpdate();
			docno=apprstmt.getInt("docNo");
			if(res<=0) {
				conn.close();
				return 0;
			}	     
		
			if (docno > 0) {
			
				Statement stmtAppr = conn.createStatement();
				CallableStatement stmtAppr1=null;
				ArrayList<String> comparray= new ArrayList<>();
				
				String sql = "select d.awlId, d.refdtype, d.revadd, d.revded, d.revstatded, d.remarks from hr_incrm m left join hr_incrd d on (m.doc_no=d.rdocno and m.status=3) where d.rdocno=(select max(doc_no) from hr_incrm "  
						+ "where status=3 and empid="+empdocno+" and doc_no!="+docno+")";
				ResultSet resultSet = apprstmt.executeQuery(sql);		
			
				while(resultSet.next()){
					comparray.add(resultSet.getString("awlId")+" ::"+resultSet.getString("refdtype")+" ::"+resultSet.getString("revadd")+" ::"+resultSet.getString("revded")+" ::"+resultSet.getString("revstatded")+" ::"+resultSet.getString("remarks"));
				}
				
				String sql1="DELETE FROM hr_empsal WHERE rdocno="+empdocno+"";
				stmtAppr.executeUpdate(sql1);
				
				for(int i=0;i< comparray.size();i++){
		    	
				   String[] comarray=comparray.get(i).split("::");
			       	 
			       if(!(comarray[0].trim().equalsIgnoreCase("undefined")) && !(comarray[0].trim().equalsIgnoreCase("NaN")) && !(comarray[0].trim().equalsIgnoreCase("")) && !(comarray[0].trim().isEmpty())) {  	 
			    	  
			    	   	stmtAppr1 = conn.prepareCall("INSERT INTO hr_empsal(awlId, refdtype, addition, deduction, statutorydeduction, remarks, rdocno) VALUES(?,?,?,?,?,?,?)");

			    	   	stmtAppr1.setString(1,(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim()).toString()); //alwid 
			    	   	stmtAppr1.setString(2,(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")||comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim()).toString()); //dtype 
			    	   	stmtAppr1.setString(3,(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")||comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim()).toString()); //addition
			    	   	stmtAppr1.setString(4,(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")||comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim()).toString()); //deduction
			    	   	stmtAppr1.setString(5,(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")||comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim()).toString()); //statutorydeduction
			    	   	stmtAppr1.setString(6,(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")||comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?"0":comarray[5].trim()).toString()); //remarks
			    	   	stmtAppr1.setInt(7,empdocno); //empid
						stmtAppr1.executeUpdate();
				     
			    	}
			     
				}
				
				conn.commit();
				apprstmt.close();
				conn.close();
				return docno;
			}
	      } catch (Exception e) {
			  conn.close();
			  e.printStackTrace();
		  }
			return 0;
		}

	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
		  Connection conn=null;
	      JSONArray RESULTDATA1=new JSONArray();
	  
	      try {
	           conn = ClsConnection.getMyConnection();
	           Statement apprstmt = conn.createStatement();
	    
	           String sql = "";
	     
	           if(!(empid.equalsIgnoreCase(""))){
	                  sql=sql+" and codeno like '%"+empid+"%'";
	              }
	              if(!(employeename.equalsIgnoreCase(""))){
	               sql=sql+" and name like '%"+employeename+"%'";
	              }
	              if(!(contact.equalsIgnoreCase(""))){
	                  sql=sql+" and pmmob like '%"+contact+"%'";
	              }
	             
	     sql = 	"select m.doc_no,m.codeno,m.dtjoin,m.pmmob,m.name,m.desc_id,m.dept_id,m.pay_catid,d.desc1 dept,ds.desc1 desig,ca.desc1 category  from hr_empm m left join "
	    	  + "hr_setdept d on d.doc_no=m.dept_id left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setpaycat ca on ca.doc_no=m.pay_catid where m.status=3 and "
	    	  + "m.dtype='EMP' "+sql;
	     
	     ResultSet resultSet1 = apprstmt.executeQuery(sql);
	     
	     RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
	     
	     apprstmt.close();
	     conn.close();
	   } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
	   } finally{
		   conn.close();
	   }
	      return RESULTDATA1;
	  }
 
	public JSONArray basicsalaryfristsearch(String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        try {
        		conn = ClsConnection.getMyConnection();
        		Statement apprstmt = conn.createStatement();

		        String sql = "select CONVERT(b.allowanceid,CHAR(50)) allowanceid,CONVERT(b.allowance,CHAR(50)) allowance,CONVERT(b.refdtype,CHAR(50)) refdtype,CONVERT(b.chktype,CHAR(50)) chktype,CONVERT(if(b.addition=0,' ',round(b.addition,2)),CHAR(100)) addition,"  
		      		+ "CONVERT(if(b.deduction=0,' ',round(b.deduction,2)),CHAR(100)) deduction,CONVERT(if(b.statutorydeduction=0,' ',round(b.statutorydeduction,2)),CHAR(100)) statutorydeduction,CONVERT(if(b.remarks=0,'',b.remarks),CHAR(500)) remarks from ( " 
		      		+ "select m.awlId allowanceid,if(m.refdtype='STD',s.desc1,a.desc1) allowance,if(m.refdtype='0',' ',m.refdtype) refdtype,if(m.refdtype='STD',s.chktype,' ') chktype,m.addition,m.deduction,m.statutorydeduction,m.remarks from hr_empsal m left join " 
		      		+ "hr_setallowance a on m.awlId=a.doc_no left join hr_setdeduction s on m.awlId=s.doc_no where  m.rdocno="+docNo+" union all select * from (select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,if(doc_no>0,'ALC',' ') refdtype,"
		      		+ "CONVERT(' ',CHAR(50)) chktype,' ' addition,' ' deduction,' ' statutorydeduction,' ' remarks from hr_setallowance where status=3 and doc_no>=0 union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'STD' refdtype,"
		      		+ "CONVERT(chktype,CHAR(50)) chktype,' ' addition,' ' deduction, ' ' statutorydeduction,' ' remarks from hr_setdeduction where status=3) a) b group by b.allowanceid,b.refdtype"; 
			      
			     ResultSet resultSet = apprstmt.executeQuery (sql);
			     RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
			     apprstmt.close();
			     conn.close();
          } catch(Exception e){
        	  e.printStackTrace();
        	  conn.close();
          } finally{
        	  conn.close();
          }
        return RESULTDATA;
    }

	public JSONArray grideeditsearch(String docNo) throws SQLException {
    
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
    
		try {
				conn = ClsConnection.getMyConnection();
				Statement apprstmt = conn.createStatement();

				String sql = "select CONVERT(b.allowanceid,CHAR(50)) allowanceid,CONVERT(b.allowance,CHAR(50)) allowance,CONVERT(b.refdtype,CHAR(50)) refdtype,CONVERT(b.chktype,CHAR(50)) chktype,"
						+ "CONVERT(if(b.addition=0,' ',b.addition),CHAR(100)) addition,CONVERT(if(b.deduction=0,' ',b.deduction),CHAR(100)) deduction,CONVERT(if(b.statutorydeduction=0,' ',b.statutorydeduction),CHAR(100)) statutorydeduction,"
						+ "CONVERT(if(b.remarks=0,'',b.remarks),CHAR(500)) remarks,CONVERT(if(b.revadd=0,' ',b.revadd),CHAR(100))  revadd, CONVERT(if(b.revded=0,' ',b.revded),CHAR(100))  revded, CONVERT(if(b.revstatded=0,' ',b.revstatded),CHAR(100)) revstatded from ( " 
						+ "select m.awlId allowanceid,if(m.refdtype='STD',s.desc1,a.desc1) allowance,if(m.refdtype='0',' ',m.refdtype) refdtype,if(m.refdtype='STD',s.chktype,' ') chktype,m.addition,m.deduction,m.statutorydeduction,m.remarks,m.revadd,"
						+ "m.revded, m.revstatded from hr_incrd m left join hr_setallowance a on m.awlId=a.doc_no left join hr_setdeduction s on m.awlId=s.doc_no where m.rdocno="+docNo+" union all select * from ( "  
						+ "select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,if(doc_no>0,'ALC',' ') refdtype,CONVERT(' ',CHAR(50)) chktype,' ' addition,' ' deduction,' ' statutorydeduction,' ' remarks,"
						+ "' ' revadd,' '  revded,' '  revstatded from hr_setallowance where status=3 and doc_no>=0 union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'STD' refdtype,CONVERT(chktype,CHAR(50)) chktype,"
						+ "' ' addition,' ' deduction, ' ' statutorydeduction,' ' remarks, ' ' revadd,' '  revded,' '  revstatded from hr_setdeduction where status=3) a) b group by b.allowanceid,b.refdtype";
				
				ResultSet resultSet = apprstmt.executeQuery(sql);        
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				apprstmt.close();
				conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		return RESULTDATA;
	}

	public JSONArray relodesearch(String docNo) throws SQLException {
    
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
    
		try {
				conn = ClsConnection.getMyConnection();
				Statement apprstmt = conn.createStatement();
				
				String sql = "select m.awlId allowanceid,if(m.refdtype='STD',s.desc1,a.desc1) allowance,if(m.refdtype='0',' ',m.refdtype) refdtype,CONVERT(if(m.addition=0,' ',round(m.addition,2)),CHAR(100)) addition,"  
					+ "CONVERT(if(m.deduction=0,' ',round(m.deduction,2)),CHAR(100)) deduction,CONVERT(if(m.statutorydeduction=0,' ',round(m.statutorydeduction,2)),CHAR(100)) statutorydeduction,"  
					+ "CONVERT(if(m.revadd=0,' ',round(m.revadd,2)),CHAR(100))  revadd,CONVERT(if(m.revded=0,' ',round(m.revded,2)),CHAR(100))  revded, CONVERT(if(m.revstatded=0,' ',round(m.revstatded,2)),CHAR(100)) revstatded,"  
					+ "CONVERT(if(m.remarks=0,'',m.remarks),CHAR(500)) remarks from hr_incrd m  left join hr_setallowance a on m.awlId=a.doc_no and a.status=3  left join hr_setdeduction s on m.awlId=s.doc_no and s.status=3 where m.rdocno="+docNo+"";
				
				ResultSet resultSet = apprstmt.executeQuery(sql);  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				apprstmt.close();
				conn.close();
		  } catch(Exception e){
			  	e.printStackTrace();
			  	conn.close();
		  } finally{
			  conn.close();
		  }
		return RESULTDATA;
	}

	public JSONArray mainSrearch(String empname,String empid,String empdocno,String mobnos) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;

	try {
			 conn = ClsConnection.getMyConnection();
	    	 Statement stmt1 = conn.createStatement();
	    	 
	    	 String sqltest="";
	    		
			 if(!(empname.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.name like '%"+empname+"%'";
			 }
			 if(!(empid.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
			 }
			 if(!(empdocno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and mm.doc_no like '%"+empdocno+"%'";
			 }
			 if(!(mobnos.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.pmmob like '%"+mobnos+"%'";
			 }	 
				 
	    	 String str1Sql=("select m.name,mm.empid,mm.doc_no,mm.date,m.codeno empids,m.pmmob from hr_incrm mm left join hr_empm m on m.doc_no=mm.empid and m.dtype='EMP' "
	    			 + "where mm.status=3 and mm.dtype='HSAP' "+sqltest); 
	    		 
	    	 ResultSet resultSet = stmt1.executeQuery (str1Sql);
			 RESULTDATA=ClsCommon.convertToJSON(resultSet);
			 
			 stmt1.close();
			 conn.close();
	} catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return RESULTDATA;
	}

	public ClsAppraisalBean getViewDetails(int docno) throws SQLException {

	ClsAppraisalBean showBean = new ClsAppraisalBean();
	Connection conn=null;
	
	try { 
		   conn = ClsConnection.getMyConnection();
	       Statement stmt  = conn.createStatement();
	
		   String sqls="select mm.date,mm.month,mm.year,mm.empid,mm.upto,mm.deptid,mm.catid,mm.desigid,d.desc1 dept,ca.desc1 cat,ds.desc1 desig,mm.revised,"
				   + "mm.revdeptid,revcatid,mm.revdesigid,m.codeno,m.dtjoin,m.pmmob,m.name,mm.remarks from hr_incrm mm left join  hr_empm m on m.doc_no=mm.empid "
				   + "and m.dtype='EMP' left join hr_setdept d on d.doc_no=mm.deptid left join hr_setdesig ds on ds.doc_no=mm.desigid left join hr_setpaycat ca "
				   + "on ca.doc_no=mm.catid where mm.status=3 and mm.dtype='HSAP' and  mm.doc_no='"+docno+"' ";
			
			ResultSet resultSet = stmt.executeQuery(sqls);
		
			while (resultSet.next()) {
			
				showBean.setEmpid(resultSet.getString("codeno"));
				showBean.setEmpdocno(resultSet.getInt("empid"));
				showBean.setEmpname(resultSet.getString("name"));
				showBean.setCmbyear(resultSet.getInt("year"));
				showBean.setCmbmonth(resultSet.getInt("month"));
				showBean.setDeprtment(resultSet.getString("dept"));
				showBean.setHiddeprtment(resultSet.getInt("deptid"));
				showBean.setDesignation(resultSet.getString("desig"));
				showBean.setHiddesignation(resultSet.getInt("desigid"));        	   
				showBean.setCategory(resultSet.getString("cat"));
				showBean.setHidcategory(resultSet.getInt("catid"));
				showBean.setChange(resultSet.getInt("revised"));
				showBean.setCmbdept(resultSet.getInt("revdeptid"));
				showBean.setCmbdesignation(resultSet.getInt("revdesigid"));
				showBean.setCmbcategory(resultSet.getInt("revcatid"));
				showBean.setDesc(resultSet.getString("remarks"));
				showBean.setMasterdate(resultSet.getString("date"));
				showBean.setLeastpaydate(resultSet.getString("date"));
				showBean.setJoindate(resultSet.getString("dtjoin"));
				showBean.setPrevappdate(resultSet.getString("upto"));
		}
			
		stmt.close();
		conn.close();
	} catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return showBean;
	}
	
	public ClsAppraisalBean getPrint(HttpServletRequest request,int docNo,String branch) throws SQLException {
			 ClsAppraisalBean bean = new ClsAppraisalBean();
			 Connection conn = null;
			 
			try {
				
					conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement();
					
					String headersql="select 'Appraisal' vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
							+ "b.cstno from hr_incrm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
							+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='HSAP' "
							+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
							
							ResultSet resultSetHead = stmt.executeQuery(headersql);
							
							while(resultSetHead.next()){
								
								bean.setLblcompname(resultSetHead.getString("company"));
								bean.setLblcompaddress(resultSetHead.getString("address"));
								bean.setLblprintname(resultSetHead.getString("vouchername"));
								bean.setLblcomptel(resultSetHead.getString("tel"));
								bean.setLblcompfax(resultSetHead.getString("fax"));
								bean.setLblbranch(resultSetHead.getString("branchname"));
								bean.setLbllocation(resultSetHead.getString("location"));
							}
							
					String sql="select UPPER(e.name) employeename,UPPER(d.desc1) employeedepartment,UPPER(eds.desc1) existingstatusposition,if(m.revised=1,UPPER(nds.desc1),UPPER(eds.desc1)) newstatusposition,UPPER(d.desc1) existingstatusdepartment," 
							+ "if(m.revised=1,UPPER(ndt.desc1),UPPER(d.desc1)) newstatusdepartment,CONCAT('Dhs. ',round(sum(det.addition-det.deduction),2),'/- per month') existingstatusgrosssalary,if(m.revised=1,UPPER(nca.desc1),UPPER(ca.desc1)) newstatuscategory,"
							+ "CONCAT('Dhs. ',round(sum(det.revadd-det.revded),2),'/- per month') newstatusgrosssalary,CONCAT('1st ',mo.monthname,' ',m.year) effectivedate from hr_incrm m left join hr_incrd det on det.rdocno=m.doc_no  left join hr_empm e on m.empid=e.doc_no "
							+ "left join hr_setdept d on d.doc_no=m.deptid left join hr_setdept ndt on ndt.doc_no=m.revdeptId left join hr_setdesig eds on eds.doc_no=m.desigid left join hr_setdesig nds on nds.doc_no=m.revdesigId left join hr_setpaycat ca on ca.doc_no=m.catId "
							+ "left join hr_setpaycat nca on nca.doc_no=m.revcatId left join hr_month mo on mo.doc_no=m.month where m.status=3 and m.dtype='HSAP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
							
						ResultSet resultSet = stmt.executeQuery(sql);
						
						while(resultSet.next()){
							
							bean.setLblemployeename(resultSet.getString("employeename"));
							bean.setLblemployeedepartment(resultSet.getString("employeedepartment"));
							bean.setLblexistingstatusposition(resultSet.getString("existingstatusposition"));
							bean.setLblnewstatusposition(resultSet.getString("newstatusposition"));
							bean.setLblexistingstatusdepartment(resultSet.getString("existingstatusdepartment"));
							bean.setLblnewstatusdepartment(resultSet.getString("newstatusdepartment"));
							bean.setLblexistingstatusgrosssalary(resultSet.getString("existingstatusgrosssalary"));
							bean.setLblnewstatusgrosssalary(resultSet.getString("newstatusgrosssalary"));
							bean.setLbleffectivedate(resultSet.getString("effectivedate"));
							bean.setLblnewstatuscategory(resultSet.getString("newstatuscategory"));
						}
					
					stmt.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return bean;
		}
	
}
