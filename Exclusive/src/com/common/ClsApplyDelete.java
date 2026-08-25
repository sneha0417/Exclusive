package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClsApplyDelete {
   
    public  int getFinanceApplyDelete(Connection conn,int trno) throws SQLException{
    	
		try{
			Statement stmtFinaceApply=conn.createStatement();
		
			int ap_trid=0,tranid=0,id=0,acno=0;
			String atype="";
			double amount=0.00;
			
			  /*Selecting Tran-Id*/
			  ArrayList<String> tranidarray=new ArrayList<>();
			  String sql="select tranid,id,acno from my_jvtran where out_amount!=0 and tr_no="+trno+"";
			  ResultSet resultSet=stmtFinaceApply.executeQuery(sql);
			  
			  while(resultSet.next()){
			   tranidarray.add(resultSet.getString("tranid")+"::"+resultSet.getString("id")+"::"+resultSet.getString("acno"));
			  }
			  /*Selecting Tran-Id Ends*/
			  
			  if(tranidarray.size()>0){
				  
			  /*Selecting Ap_Tran-Id*/
			  for(int i=0;i<tranidarray.size();i++){
			   
			   ArrayList<String> outamtarray=new ArrayList<>();
			   
			   tranid=Integer.parseInt(tranidarray.get(i).split("::")[0]);
			   id=Integer.parseInt(tranidarray.get(i).split("::")[1]); 
			   acno=Integer.parseInt(tranidarray.get(i).split("::")[2]); 
			   
			   String sql1="select atype from my_head where doc_no="+acno+"";
			   ResultSet resultSet1=stmtFinaceApply.executeQuery(sql1);
			   
			   while(resultSet1.next()){
				   atype=resultSet1.getString("atype");
			   }
			   
			   String sql2="";
			  /*Selecting Ap_Tran-Id*/ 
			   if(atype.equalsIgnoreCase("AR")){
				   if(id==1){
					   sql2="select tranid ap_trid,amount from my_outd where ap_trid="+tranid+""; 
				   }else if(id==-1){
					   sql2="select ap_trid,amount from my_outd where tranid="+tranid+"";
				   }
			   }else if(atype.equalsIgnoreCase("AP")){
				   if(id==1){
					   sql2="select ap_trid,amount from my_outd where tranid="+tranid+""; 
				   }else if(id==-1){
					   sql2="select tranid ap_trid,amount from my_outd where ap_trid="+tranid+"";
				   }
			   }
			   
			   ResultSet resultSet2=stmtFinaceApply.executeQuery(sql2);
			   
			   while(resultSet2.next()){
				   outamtarray.add(resultSet2.getInt("ap_trid")+"::"+resultSet2.getDouble("amount"));
			   } 
			  /*Selecting Ap_Tran-Id Ends*/
			   
			  for(int j=0;j<outamtarray.size();j++){
			   
			   ap_trid=Integer.parseInt(outamtarray.get(j).split("::")[0]);
			   amount=Double.parseDouble(outamtarray.get(j).split("::")[1]);

			   String sql3="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
			   int data=stmtFinaceApply.executeUpdate(sql3);
			   
			  }
			  
			  String sql3="update my_jvtran set out_amount=0 where tranid="+tranid+"";
			  int data=stmtFinaceApply.executeUpdate(sql3);
			  
			  /*Apply Updating Ends*/
			  }
			  
			  /*Deleting from my_outd*/
			  String sql4="delete from my_outd where tranid in (SELECT TRANID FROM my_jvtran where TR_NO="+trno+")";
			  int data1=stmtFinaceApply.executeUpdate(sql4);
			  
			  String sql5="delete from my_outd where ap_trid in (SELECT TRANID FROM my_jvtran where TR_NO="+trno+")";
			  int data2=stmtFinaceApply.executeUpdate(sql5);
			  /*Deleting from my_outd ENDS*/
			  
			  /*Updating my_jvtran*/
			  String sql6="update my_jvtran set out_amount=0 where tr_no="+trno+"";
			  int data3=stmtFinaceApply.executeUpdate(sql6);
			  /*Updating my_jvtran ENDS*/
			}
			  
			stmtFinaceApply.close();	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return -1;
		}
		return 1;
	}

}