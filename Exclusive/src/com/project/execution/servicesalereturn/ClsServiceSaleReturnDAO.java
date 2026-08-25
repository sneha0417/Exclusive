package com.project.execution.servicesalereturn;

 

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.*;
import com.connection.ClsConnection;
 
public class ClsServiceSaleReturnDAO  {
	
	ClsCommon commDAO=new ClsCommon();
	
	ClsConnection connDAO=new ClsConnection();
	
	Connection conn;
public int insert(Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
		HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc,int odocno) throws SQLException {
	try{
		int docno;
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false);
		 
		 
		 Statement stmt = conn.createStatement ();
		   ArrayList<String> outamtarray=new ArrayList<>();
		  String upsql="select method from gl_config where field_nme like'tax'";
		   ResultSet resultSet = stmt.executeQuery(upsql);
		    int docval = 0;
		    if (resultSet.next()) {
		    	docval=resultSet.getInt("method");
		    }		  
 if(docval==0)
 {
		    String upsql2="select method from gl_prdconfig where field_nme like'tax'";
			   ResultSet resultSet2 = stmt.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    }
 }
		    
		    
stmt.close();

		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSalereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnipurchase.registerOutParameter(16, java.sql.Types.INTEGER);
		
		 
		
		stmtnipurchase.setInt(18, java.sql.Types.INTEGER);
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setString(2,refno);
		stmtnipurchase.setString(3,acctype);
		stmtnipurchase.setString(4,accdoc);
	   	stmtnipurchase.setString(5,cmbcurr);
		stmtnipurchase.setString(6,currate);
		stmtnipurchase.setString(7,delterms);
		stmtnipurchase.setString(8,payterms);
		stmtnipurchase.setString(9,purdesc);
		stmtnipurchase.setDate(10,purdeldate);
		stmtnipurchase.setDouble(11,nettotal);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,reftype);
		stmtnipurchase.setString(17,mode);
		stmtnipurchase.setInt(19,interstate);
//		System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
 
		stmtnipurchase.executeQuery();
		docno=stmtnipurchase.getInt("docNo");
		int vocno=stmtnipurchase.getInt("vocNo");
		int intrstate=stmtnipurchase.getInt("vinterstate");
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		int tranno=0;
		int j=0;
		int sno=0;
		
		double fdramt=0;
		double tdramt=0;
		
		int count=0;
		
		int iapprovalStatus=3;
		double masteramount=0;
 
		String refdetails="SRR"+""+vocno;
		
		
		String jvdesc="SRR-"+""+invno+""+":-Dated :- "+indateval+"";  
		
		String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
	
		ResultSet tass = stmtnipurchase.executeQuery (trsql);
		
		if (tass.next()) {
	
			tranno=tass.getInt("trno");		
			
	     }
		
		
		
		String appsql="select count(*)   icount from my_apprmaster where status=3 and dtype='"+Formdetailcode+"'";
		
		ResultSet appsqlrs = stmtnipurchase.executeQuery(appsql);
		
		if (appsqlrs.next()) {
	
			count=appsqlrs.getInt("icount");		
			
	     }
		if(count==0)
		{
			
			iapprovalStatus=3;
			
			
		}
		else
		{
			iapprovalStatus=0;
		}
		
		
		request.setAttribute("trans",tranno);
		
		String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
		
		int dd=stmtnipurchase.executeUpdate(trnosql);
	     
				 if(dd<=0)
					{
						conn.close();
						return 0;
						
					}
		//System.out.println("sssssss"+session.getAttribute("USERID").toString());
				 double nettaxtot = 0;
		for(int i=0;i< descarray.size();i++){
			
			String[] purorderarray=descarray.get(i).split("::");
			String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
			String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
			
//			System.out.println("==nettax==="+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim()));
			
			nettaxtot+=Double.parseDouble(nettax);
			
			if(i==descarray.size()-1){
 	System.out.println("==nettaxtot==="+nettaxtot);
				double dramt=(nettotal+nettaxtot)*-1;
				double as=Double.parseDouble(currate);
				double ldramt=dramt*as;
				
				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRR','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 
//			   System.out.println("client account sql ="+sql1);
				 int ss = stmtnipurchase.executeUpdate(sql1);

			     if(ss<=0)
					{
						conn.close();
						return 0;
					}
				
			}
		
/*			double taxper,tax,nettaxamount;
			Statement stmt21=conn.createStatement();
			String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
			ResultSet resultSet3 = stmt21.executeQuery(sqltax);
	    	 while(resultSet3.next()){
	    		 taxper=resultSet3.getDouble("per");
	    		 tax=((nettotal*resultSet3.getDouble("per"))/100);
	    		 nettaxamount=nettotal+tax;
	    	 }
	    	 
	    	 */
			 
	    	 Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+"")); 
		    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
		     {
	
	    		 String sql="INSERT INTO my_srvsaleretd(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,rrowno,brhid,rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
					       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
					       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
					       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
					       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
					       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
					       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
					       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
					       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
					       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
					       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
					       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
					       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
					       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
					       + "'"+(purorderarray[15].trim().equalsIgnoreCase("undefined") || purorderarray[15].trim().equalsIgnoreCase("NaN")||purorderarray[15].trim().equalsIgnoreCase("")|| purorderarray[15].isEmpty()?0:purorderarray[15].trim())+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'"+docno+"')";
	    		// System.out.println("__saled--"+sql);
	    		 int resultSet2 = stmtnipurchase.executeUpdate(sql);
			     
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
					}
			     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
			     int acno=Integer.parseInt(acno1);
			     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
			     fdramt=Double.parseDouble(tmp)*1;
			     tdramt=fdramt*Double.parseDouble(currate);
			    
			     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
		 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:Double.parseDouble(purorderarray[6].trim()))+"',"+tdramt+",0,1,5,"+(i+1)+",0,0,0,'SRR', "
				+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
				+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
				     
			   //  System.out.println("other account sql ="+don);	
			int samp=stmtnipurchase.executeUpdate(don);

			     
			 if(samp<=0)
				{
					conn.close();
					return 0;
					
				}
					//}
			      
			 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
		     {
				 int TRANID=0;
				 sno=sno+1;
				  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
				  double  fdramt1=Double.parseDouble(tmp1)*1;
			    		
			
					String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"' ";
			
					ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
					
					if (tass1.next()) {
				
						TRANID=tass1.getInt("TRANID");	
					
					
						
				     }
					
					String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
							+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1*-1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
							 
			  int costabsq=  stmtnipurchase.executeUpdate(ssql);
			  
			  if(costabsq<=0)
				{
					conn.close();
					return 0;
					
				}
			  
		     }
				String updat="update  my_srvsaleretm set tr_no="+tranno+",invno='"+invno+"',invdate='"+sqlinvdate+"',rrefno='"+odocno+"' where doc_no="+docno+"  ";
				  int tabs=  stmtnipurchase.executeUpdate(updat);
				  if(tabs<=0)
					{
						conn.close();
						return 0;
					}
		     }
	     }
		 if(docval>0){
			 Statement stmt21 = conn.createStatement ();
			 Statement stmtt=conn.createStatement();
			 Statement stmtt2=conn.createStatement();
			 String newjvdesc=jvdesc;
	 
		    		  
		    			 double amount,dramt=0,as,ldramt = 0;
		    			 long acno=0;
		    			 amount=((nettaxtot));
		    			 	dramt=amount;
			 				as=Double.parseDouble(currate);
			 				ldramt=dramt*as;
		    			 
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 if(resultSet4.first()){
		 		    		
			 				acno=resultSet4.getLong("acno");
		 		    	 }
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRR','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
 
			 			if(taxperc>0){	 
			 				int ss = stmtnipurchase.executeUpdate(sql1);
 			 	 
			 			     if(ss<=0)
			 					{
			 						conn.close();
			 						return 0;
			 						
			 					}
			 			}			    		
				       
		    	
		    }
		

		
		 ArrayList<String> arr=new ArrayList<String>(); 
			ClsVatInsert ClsVatInsert=new ClsVatInsert();
			Statement newStatement=conn.createStatement();
			String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
					+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
					+"  sum(a.total9) total9,sum(a.total10) total10, "
					+"  sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
					+"  sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
					+"  from ( "
				+" 	 select  d.nettotal+coalesce(d.tax,0) nettaxamount,if(coalesce(d.tax,0)>0,d.nettotal,0) total1, "
					+"  if(coalesce(d.tax,0)=0,d.nettotal,0) total2 ,0 total3, "
					 +"  0 total4,0 total5, "
					+"  0 total6,0 total7, "
					+"  0 total8,0 total9, "
					+"  0 total10, "
					+"  if(d.tax>0,d.tax,0) tax1,  0 tax2, "
					+"  0 tax3,  0 tax4, "
					+"  0 tax5, 0 tax6, "
					+"  0 tax7,  0 tax8, "
					+"  0 tax9,  0 tax10 "
					 +"  from my_srvsaleretd d where rdocno="+docno+" ) a" ;
			

		//System.out.println("===ABC===="+selectsqls);
			
			
			ResultSet rss101=newStatement.executeQuery(selectsqls);
			if(rss101.first())
				{
				arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
						rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
						rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
						rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
						rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
						rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
						rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
				}   
			
				int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
					if(result==0)	
				        {
						conn.close();
						return docno;
						}
		       

		
		    
	if (docno > 0) {
		conn.commit();
		stmtnipurchase.close();
		conn.close();
		return docno;
	}
}catch(Exception e){	
	conn.close();
e.printStackTrace();	
}
return 0;
}





public boolean edit(int docno,Date sqlStartDate,Date purdeldate, String reftype, String refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,
		String Formdetailcode,int tranno,HttpServletRequest request,Date sqlinvdate,String invno,String indateval,int interstate,Double taxperc,int odocno) throws SQLException {
	
	try{
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false);
		 Statement stmt33 = conn.createStatement ();
		 
		  String upsql="select method from gl_config where field_nme like'tax'";
		   ResultSet resultSet33 = stmt33.executeQuery(upsql);
		    int docval = 0;
		    if (resultSet33.next()) {
		    	docval=resultSet33.getInt("method");
		    }		  
if(docval==0)
{
		    String upsql2="select method from gl_prdconfig where field_nme like'tax'";
			   ResultSet resultSet2 = stmt33.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    }
}
		    
		    
stmt33.close();
		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSalereturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setString(2,refno);
		stmtnipurchase.setString(3,acctype);
		stmtnipurchase.setString(4,accdoc);
	   	stmtnipurchase.setString(5,cmbcurr);
		stmtnipurchase.setString(6,currate);
		stmtnipurchase.setString(7,delterms);
		stmtnipurchase.setString(8,payterms);
		stmtnipurchase.setString(9,purdesc);
		stmtnipurchase.setDate(10,purdeldate);
		stmtnipurchase.setDouble(11,nettotal);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,reftype);
		stmtnipurchase.setInt(16,docno);
		stmtnipurchase.setString(17,"E");
		stmtnipurchase.setInt(18, 0);
		stmtnipurchase.setInt(19,interstate);
		int aaa=stmtnipurchase.executeUpdate();
		docno=stmtnipurchase.getInt("docNo");
//		System.out.println("=="+stmtnipurchase.toString());
		if(aaa<=0)
		{
			conn.close();
			return false;
			
		}	
		
		int ap_trid=0;
	    double amount=0.00,outamount=0.00;
	    	Statement stmtBPV=conn.createStatement();
	     /*Selecting Tran-Id*/
	      ArrayList<String> tranidarray=new ArrayList<>();
	      String sql11="SELECT TRANID FROM my_jvtran where TR_NO="+tranno+" and acno="+accdoc+" and out_amount!=0";
	      
	     System.out.println("----sql11---"+sql11);
	      
	      ResultSet resultSet=stmtBPV.executeQuery(sql11);
	      
	      while(resultSet.next()){
	       tranidarray.add(resultSet.getString("tranid"));
	      }
	      /*Selecting Tran-Id Ends*/
	      
	      /*Selecting Ap_Tran-Id*/
	      ArrayList<String> outamtarray=new ArrayList<>();

	      for(int i=0;i<tranidarray.size();i++){
	       String sql2="select tranid ap_trid,amount from my_outd where ap_trid="+tranidarray.get(i);
	       
              System.out.println("--1111111111111111111--sql2---"+sql2);
	       ResultSet resultSet1=stmtBPV.executeQuery(sql2);
	       
	       while(resultSet1.next()){
	    	   outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
	       } 

	      }
	      /*Selecting Ap_Tran-Id*/
	   //   System.out.println("----outamtarray---"+outamtarray);
	      for(int i=0;i<outamtarray.size();i++){
	       
	       ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
	       amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

	       String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
	      // System.out.println("----sql4---"+sql4);
	       int data1=stmtBPV.executeUpdate(sql4);
	       
	      }
	    /*Apply-Invoicing Grid Updating Ends*/
	    if(tranidarray.size()>0)  
	    {
	       /*Selecting outamount*/
	        String sql5="select sum(amount) outamount from my_outd where ap_trid="+tranidarray.get(0)+"";
	        
	     //   System.out.println("----sql5---"+sql5);
	        ResultSet resultSet2=stmtBPV.executeQuery(sql5);
	      
	        while(resultSet2.next()){
	       outamount= resultSet2.getDouble("outamount");
	        }
	       /*Selecting outamount Ends*/
	      
	        String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
	       // System.out.println("----sql4--2-"+sql4);
	        int data3=stmtBPV.executeUpdate(sql4);
	       
	     /*Deleting from my_outd*/
	      String sql3="delete from my_outd where ap_trid="+tranidarray.get(0)+"";
	    //  System.out.println("----sql3---"+sql3);
	      
	      int data2=stmtBPV.executeUpdate(sql3);
	     /*Deleting from my_outd Ends*/
	    }
		
				
		   String delsql="Delete from my_srvsaleretd where rdocno="+docno+" and brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
		   stmtnipurchase.executeUpdate(delsql);
		   
		   String delsql1="Delete from my_jvtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql1);
		   
		   String delsql2="Delete from my_costtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql2);
		   
		/*   String delsql3="Delete from my_srvtaxsale where rdocno="+docno+" ";
		   stmtnipurchase.executeUpdate(delsql3);
		   
		   */
		 
			int j=0;
			int sno=0;
			double fdramt=0;
			double tdramt=0;
			Statement stmt =conn.createStatement();
			
			int vocno=0;
			
			String sqlss="select voc_no from my_srvsaleretm where doc_no='"+docno+"' ";
			ResultSet rss=stmt.executeQuery(sqlss);
			
			if(rss.next())
			
			{
				
				vocno=rss.getInt("voc_no");
				
			}
			double masteramount=0;
 
			
			String refdetails="SRR"+""+vocno;
			String jvdesc="SRR-"+""+invno+""+":-Dated :- "+indateval+"";  
			
			double nettaxtot = 0;
			for(int i=0;i< descarray.size();i++){
				 String[] purorderarray=descarray.get(i).split("::");
				 String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
				 String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
				 nettaxtot+=Double.parseDouble(nettax);
				 if(i==descarray.size()-1)
					
				{
					double dramt=(nettotal+nettaxtot)*-1;
					double as=Double.parseDouble(currate);
					double ldramt=dramt*as;
					
					 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRR','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
	
					 int ss = stmtnipurchase.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return false;
							
						}
					
				}
				
			
				Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+""));
			    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
		
			    	String sql="INSERT INTO my_srvsaleretd(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,rrowno,brhid,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
						       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
						       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
						       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
						       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
						       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
						       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
						       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
						       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
						       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
						       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
						       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
						       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
						       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
						  + "'"+(purorderarray[15].trim().equalsIgnoreCase("undefined") || purorderarray[15].trim().equalsIgnoreCase("NaN")||purorderarray[15].trim().equalsIgnoreCase("")|| purorderarray[15].isEmpty()?0:purorderarray[15].trim())+"',"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'"+docno+"')";
				     int resultSet21 = stmtnipurchase.executeUpdate(sql);
				     
				     if(resultSet21<=0)
						{
							conn.close();
							return false;
							
						}
				  String acno1=""+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"";
					    int acno=Integer.parseInt(acno1);
				
					     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					      fdramt=Double.parseDouble(tmp)*1;
					    		
					     		     tdramt=fdramt*Double.parseDouble(currate);
					     
					    		 
					     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', '"+newjvdesc+"', "
						+ "'"+cmbcurr+"','"+currate+"','"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:Double.parseDouble(purorderarray[6].trim()))+"',"+tdramt+",0,1,5,"+(i+1)+",0,0,0,'SRR', "
						+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3,'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
						+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
						     
							 
					
					int samp=	stmtnipurchase.executeUpdate(don);

					     
					 if(samp<=0)
						{
							conn.close();
							return false;
							
						}
						//	}
				 
				 
				 if(!(purorderarray[8].trim().equalsIgnoreCase("undefined")|| purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty() ||purorderarray[8].trim().equalsIgnoreCase("0")))
			     {
					 int TRANID=0;
					 sno=sno+1;
					  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					  double  fdramt1=Double.parseDouble(tmp1)*1;
						String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"' ";
						
						
						
						
						ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
						
						if (tass1.next()) {
					
							TRANID=tass1.getInt("TRANID");	
						
						
							
					     }
						
					
					 
				String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
						+ " "+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+","+fdramt1*-1+",'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"+TRANID+","+tranno+")";
					 
				  int costabsq=  stmtnipurchase.executeUpdate(ssql);
				  
				  if(costabsq<=0)
					{
						conn.close();
						return false;
						
					}
				  
			     }
				
		
				 
				 
				 
			     }
			    
			  
		     }
			
			
			
		   
		   
		   
 
			 
			 
			String updat="update  my_srvsaleretm set invno='"+invno+"',invdate='"+sqlinvdate+"',rrefno='"+odocno+"' where doc_no="+docno+"  ";
				 
			  int tabs=  stmtnipurchase.executeUpdate(updat);
		 
		 
		 
			  if(tabs<=0)
				{
					conn.close();
					return false;
					
				}
			  
			  if(docval>0){
					 Statement stmt21 = conn.createStatement ();
					 Statement stmtt=conn.createStatement();
					 Statement stmtt2=conn.createStatement();
					 String newjvdesc=jvdesc;
			 
				    	 
				    			 double aamount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
					    			 aamount=((nettaxtot));
					    			 dramt=aamount;
						 			 as=Double.parseDouble(currate);
						 			 ldramt=dramt*as;
						 			 acno=resultSet4.getLong("acno");
				 		    	 }	
					 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRR','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'3')";
					 				 
					 			//	System.out.println(sql1);
					 				if(taxperc>0){
					 				 int ss = stmtnipurchase.executeUpdate(sql1);

					 			     if(ss<=0)
					 					{
					 						conn.close();
					 						return false;
					 						
					 					}
					 				}
				    		
						       }
				    	
				    
			 ArrayList<String> arr=new ArrayList<String>(); 
					ClsVatInsert ClsVatInsert=new ClsVatInsert();
					Statement newStatement=conn.createStatement();
					String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
							+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
							+"  sum(a.total9) total9,sum(a.total10) total10, "
							+"  sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
							+"  sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
							+"  from ( "
						+" 	 select  d.nettotal+coalesce(d.tax,0) nettaxamount,if(coalesce(d.tax,0)>0,d.nettotal,0) total1, "
							+"  if(coalesce(d.tax,0)=0,d.nettotal,0) total2 ,0 total3, "
							 +"  0 total4,0 total5, "
							+"  0 total6,0 total7, "
							+"  0 total8,0 total9, "
							+"  0 total10, "
							+"  if(d.tax>0,d.tax,0) tax1,  0 tax2, "
							+"  0 tax3,  0 tax4, "
							+"  0 tax5, 0 tax6, "
							+"  0 tax7,  0 tax8, "
							+"  0 tax9,  0 tax10 "
							 +"  from my_srvsaleretd d where rdocno="+docno+" ) a" ;
					ResultSet rss101=newStatement.executeQuery(selectsqls);
					if(rss101.first())
						{
						arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
								rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
								rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
								rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
								rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
								rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
								rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
						}   
					
						int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
							if(result==0)	
						        {
								conn.close();
								return false;
								}
			
			
		if (aaa > 0) {
		 	conn.commit();
			stmtnipurchase.close();
			conn.close();
			System.out.println("Sucess");
			return true;
		}
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return false;
}

public boolean delete(int docno,HttpSession session,String mode,String Formdetailcode) throws SQLException {
	try{
		conn=connDAO.getMyConnection();
		
		
		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtnipurchase.setDate(1,null);
		stmtnipurchase.setString(2,null);
		stmtnipurchase.setString(3,null);
		stmtnipurchase.setString(4,null);
	   	stmtnipurchase.setString(5,null);
		stmtnipurchase.setString(6,null);
		stmtnipurchase.setString(7,null);
		stmtnipurchase.setString(8,null);
		stmtnipurchase.setString(9,null);
		stmtnipurchase.setDate(10,null);
		stmtnipurchase.setDouble(11,0.0);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,null);
		stmtnipurchase.setInt(16,docno);
		stmtnipurchase.setString(17,"D");
		stmtnipurchase.setInt(18,0);
		
		int aaa=stmtnipurchase.executeUpdate();
		
		
		if (aaa > 0) {
			stmtnipurchase.close();
			conn.close();
			//System.out.println("Success");
			return true;
		}	
	}catch(Exception e){
		conn.close();
	}
	return false;
}

public   JSONArray accountsDetailsTo(String type,String accno,String accname,String mobileno,String id) throws SQLException {
		
	JSONArray RESULTDATA=new JSONArray();
	
	if(!(id.equalsIgnoreCase("1"))){
		return RESULTDATA;
	}
	
	Connection conn=null;

  try {
	
    String sql="",sqltest="";
    
    if((!(accno.equalsIgnoreCase(""))) && (!(accno.equalsIgnoreCase("NA")))){
		sqltest=sqltest+" and t.account like '%"+accno+"%'  ";
	}
	if((!(accname.equalsIgnoreCase(""))) && (!(accname.equalsIgnoreCase("NA")))){
		sqltest=sqltest+" and t.description like '%"+accname+"%'";
	}
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
	}
	
	conn= connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
    
    if(type.equalsIgnoreCase("GL")||type.equalsIgnoreCase("AR")||type.equalsIgnoreCase("AP")){
    	sql="select a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(cb.rate,2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
                + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
                + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
                + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
                + "where t.atype='"+type+"' and t.m_s=0 "+sqltest;
    }
    else{
    	sql="select a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(cb.rate,2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
            + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
            + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
            + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
            + "where t.atype='AR' and t.m_s=0 and t.den='340'"+sqltest;
    }
    System.out.println("--acc---sql---"+sql);
    ResultSet resultSet = stmtCPV.executeQuery (sql);
    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

public   JSONArray reloddata(HttpSession session,String docno) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();
	if(docno.equalsIgnoreCase("0"))
	{
return RESULTDATA;
	}

    Enumeration<String> Enumeration = session.getAttributeNames();
    int a=0;
    while(Enumeration.hasMoreElements()){
     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
      a=1;
     }
    }
    if(a==0){
  return RESULTDATA;
     }
    String brcid=session.getAttribute("BRANCHID").toString();
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
        	String pySql=(" select (d.nettaxamount-coalesce(aa.nettaxamount,0)) valamount,d.rowno rdocno,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,"
        			+ " d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
        			+ " from my_srvsaled d left join ( select coalesce(sum(nettaxamount),0) nettaxamount,rrowno from my_srvsaleretm m left join  my_srvsaleretd d on d.rdocno=m.doc_no "
        			+ " where m.status<>7 group by rrowno) aa on aa.rrowno=d.rowno left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
        			+ "  where d.rdocno='"+docno+"'  and  (round(d.nettaxamount,2)-round(coalesce(aa.nettaxamount,0),2))>0  ");
    	System.out.println("===11111111====="+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA=commDAO.convertToJSON(resultSet); 
			stmtVeh1.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}

	
public   JSONArray reloaddata(String docno,String odocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(docno.equalsIgnoreCase("0"))
				{
			return RESULTDATA;
				}
		
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				
	 
	        	String pySql=(" select coalesce(aa1.nettaxamount,0)-(coalesce(aa.nettaxamount,0))+d.nettaxamount  valamount,d.rrowno rdocno,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
	        			+ " from  my_srvsaleretd d  "
	        			+ " left join ( select coalesce(sum(nettaxamount),0) nettaxamount,rrowno from my_srvsaleretm m left join  my_srvsaleretd d on d.rdocno=m.doc_no "
	                			+ " where m.status<>7   group by rrowno) aa on aa.rrowno=d.rrowno "
	                		+ " left join ( select coalesce(sum(nettaxamount),0) nettaxamount,rowno  from my_srvsaled d  where '"+odocno+"'  group by rowno) aa1 on aa1.rowno=d.rrowno "		
	        			+ " left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
	        			+ "  where d.rdocno='"+docno+"'  ");
	      	System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
	public   JSONArray accountGridsearch(String type) throws SQLException {
      
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
  try {
     conn = connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             
    String sqq= ("select t.gr_type grtype,t.doc_no,t.account,t.description,c.code curr,c.doc_no curid,c.c_rate from my_head t left join my_curr c "
      + "on t.curid=c.doc_no where atype='"+type+"' and m_s=0 ");
    
    
   // System.out.println("--cczxc-----"+sqq);
    
    ResultSet resultSet = stmtCPV.executeQuery (sqq);
    
   

    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();

  }
  catch(Exception e){
	   conn.close();
   e.printStackTrace();
  }
        return RESULTDATA;
    }
	
	public   JSONArray searchCosttype() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVehclr.executeQuery ("select costtype,costgroup from my_costunit where status=1;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray searchCostcode(String type) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	  
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
			
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		//System.out.println("1111111111111111");
	        		String sql="select costcode code,doc_no,description name,0 reg_no  from my_ccentre where m_s=0;";
	        		//System.out.println("----"+sql );
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
	        	}
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0;";
	        		//System.out.println("----"+sql );
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
	        	}
	        	
	        	conn.close();	

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray refnosearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_head h on h.doc_no=m.acno where m.status<>7 and m.brhid='"+brcid+"'" );
	        	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray slnosearch(String niorderdocno) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		    /*Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(a==0){
		  return RESULTDATA;
		     }*/
		 Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	       	
				String resql=(" select d.srno,d.desc1 desc1,d.unitprice unitprice,d.qty,d.total total,m.type,d.discount,m.acno,h.description,h.account from "
						+ "my_srvlpod d inner join my_srvlpom m on d.rdocno=m.doc_no left join my_head h on h.doc_no=m.acno   where d.rdocno='"+niorderdocno+"' ");
				
				
				//System.out.println("--------------"+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println("fgdg"+RESULTDATA);
	   return RESULTDATA;
	}
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa,String mobileno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	  java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = commDAO.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
 
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
    	} 
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
    	}
        
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement (); 
	        	String pySql=("select m.rrefno,mm.voc_no rvoc_no ,a.per_mob mobno,convert(coalesce(m.refno,''),char(20)) refvocno,m.tr_no,m.doc_no "
	        			+ " ,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        			+ "m.deldate,m.desc1,h.description,h.account,m.interstate,h.atype from my_srvsaleretm m left join my_srvsalem mm on mm.doc_no=m.rrefno left join my_head h on h.doc_no=m.acno  "
	        			+ "  left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' where m.status<>7  "
	        			+ "and m.brhid='"+brcid+"' "+sqltest );
//	        	System.out.println("===pysql====="+pySql);
	        	
	       
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtmain.close();
			}
			
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public  ClsServiceSaleReturnBean getPrint(int docno, HttpServletRequest request ,HttpSession session) throws SQLException {
		ClsServiceSaleReturnBean bean = new ClsServiceSaleReturnBean();
		  Connection conn = null; // String brcid=session.getAttribute("BRANCHID").toString();
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				/*String resql=("select m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount,m.type,m.acno,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype,m.refno,m.curid,m.rate,m.delterm, "
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,h.account from my_srvsalem m left join my_head h on h.doc_no=m.acno  where m.DOC_NO='"+docno+"' ");
				*/
				String resql = ("select concat('Service Sale :- ',mm.voc_no ) rvoc_no, if(CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))=' NIL , NIL','',CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))) as telno,"
					+ " b.tinno brtinno,round(m.netamount+sum(d.tax),2) nettaxtot,m.refno,coalesce(a.mail1,'') mail1,  coalesce(a.fax1,'') fax1,coalesce(a.per_mob,'') per_mob,a.address, "
					+ "coalesce(a.contactperson,'') contactperson,m.voc_no,date_format(m.date,'%d-%m-%Y') date, a.trnnumber,a.com_mob, m.invno,date_format(m.invdate,'%d-%m-%Y') invdate, "
					+ "round(m.netamount,2) netamount ,m.type,m.acno,if(trim(m.delterm)!='',m.delterm,null) delterm,"
					+ "if(trim(m.payterm)!='',m.payterm,null)payterm,date_format(m.deldate,'%d-%m-%Y') deldate, if(trim(m.desc1)!='',m.desc1,null)desc1,coalesce(h.description,'') description,"
					+ "h.account,round(sum(d.tax),2) taxamount from my_srvsaleretm m  left join my_srvsalem mm on mm.doc_no=m.rrefno left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM'  "
					+ "left join my_srvsaleretd d on m.doc_no=d.rdocno  left join my_brch b on m.brhid=b.doc_no"
					+ "  where m.DOC_NO="+ docno + " group by rdocno");
				//System.out.println("Query++++++++"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				DecimalFormat df = new DecimalFormat("###,##0.00");
			     
			       while(pintrs.next()){
			          bean.setTelno(pintrs.getString("telno"));		    	
			          bean.setCompanytrno(pintrs.getString("brtinno"));
			  
			    bean.setLblcltrnno(pintrs.getString("trnnumber"));
				bean.setAttn(pintrs.getString("contactperson"));
				bean.setLblvenphon(pintrs.getString("per_mob"));
				bean.setLblvenaddress(pintrs.getString("address"));
				bean.setLblvenland(pintrs.getString("com_mob"));
				bean.setFax(pintrs.getString("fax1"));
				bean.setEmail(pintrs.getString("mail1"));
				bean.setRefno(pintrs.getString("refno"));

				bean.setLbldate(pintrs.getString("date"));
			  bean.setLbltype(pintrs.getString("rvoc_no"));
			  
			  //bean. (pintrs.getInt("reftype"));
			  
				bean.setDocvals(pintrs.getString("voc_no"));
				bean.setLblacno(pintrs.getString("account"));
				// upper
				bean.setLblacnoname(pintrs.getString("description"));
				bean.setLbldeldate(pintrs.getString("deldate"));
				bean.setLbldddtm(pintrs.getString("delterm"));

				bean.setLbldsc(pintrs.getString("desc1"));
				bean.setLblpatms(pintrs.getString("payterm"));
				
				bean.setLblnettotal(df.format(pintrs.getDouble("netamount")));
				bean.setLbltaxamount(df.format(pintrs.getDouble("taxamount")));
				//bean.setLblnettaxamount(Float.parseFloat(pintrs.getString("netamount"))+Float.parseFloat(pintrs.getString("taxamount"))+"");
				bean.setLblnettaxamount(df.format(pintrs.getDouble("nettaxtot")));

				ClsAmountToWords c = new ClsAmountToWords();
				bean.setLblamountinwords(c.convertAmountToWords(pintrs.getString("nettaxtot")));

				bean.setLblinvno(pintrs.getString("invno"));
				bean.setLblinvdate(pintrs.getString("invdate"));
			    	     
			    	 
			    	    
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
				 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvsalem r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
				    String companysql = "select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from my_srvsaleretm r inner join my_brch b on  "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"
					+ docno + "' ";
			// System.out.println("----------------"+companysql);
			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql);

			while (resultsetcompany.next()) {
				bean.setLblbranchtrno(resultsetcompany.getString("tinno"));
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				 ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
						String strSqldetail="select d.srno,d.desc1 description,format(d.unitprice,2) unitprice,round(d.qty) qty,format(d.total,2) total,format(d.discount,2) discount,format(d.nettotal,2) nettotal,d.nuprice,"
								+ " d.remarks,h.account account,h.description accname,h.atype accounttype,round(d.taxper,2) taxper,format(d.tax,2) taxperamt,format(d.nettaxamount,2) nettaxamount  from my_srvsaleretd d left join my_head h on h.doc_no=d.acno  "
								+ " where d.rdocno='"+docno+"' ";
					
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
		
							String temp="";
							temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("unitprice")+"::"+rsdetail.getString("total")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal")+"::"+rsdetail.getString("taxper")+"::"+rsdetail.getString("taxperamt")+"::"+rsdetail.getString("nettaxamount") ;
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 

				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}

	
	
	
	public   JSONArray srsmainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa,String mobileno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	  java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = commDAO.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
    	 
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
    	} 
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
    	}
        
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select a.per_mob mobno,convert(coalesce(m.refno,''),char(20)) refvocno,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        			+ "m.deldate,m.desc1,h.description,h.account,m.interstate,h.atype from my_srvsalem m "
	        			+ " left join my_srvsaled d on d.rdocno=m.doc_no  left join my_head h on h.doc_no=m.acno left join (select coalesce(sum(nettaxamount),0) nettaxamount,rrowno from my_srvsaleretm m left join  my_srvsaleretd d on d.rdocno=m.doc_no "
	        			+ "    where m.status<>7 group by rrowno) aa on aa.rrowno=d.rowno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' where m.status<>7  "
	        			+ "and m.brhid='"+brcid+"' "+sqltest+"   group by m.doc_no  having round(coalesce(sum(d.nettaxamount),0),2)-round(coalesce(sum(aa.nettaxamount),0),2)>0 " );
	        	
	        	 
	        	
    	System.out.println("===pysql====="+pySql);
	        	
	       
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtmain.close();
			}
			
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
    }

	
