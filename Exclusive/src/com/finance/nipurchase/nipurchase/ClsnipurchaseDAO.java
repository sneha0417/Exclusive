package com.finance.nipurchase.nipurchase;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsApplyDelete;
import com.connection.ClsConnection;
public class ClsnipurchaseDAO  {
	
	ClsCommon commDAO=new ClsCommon();
	ClsConnection connDAO=new ClsConnection();
	ClsApplyDelete ClsApplyDelete=new ClsApplyDelete();
	Connection conn;
	
public int insert(Date sqlStartDate,Date purdeldate, String reftype,int refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
		HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate, int ptype,int cmbbilltype,String txtproducttype) throws SQLException {
//	System.out.println("======================txtproducttype==========="+txtproducttype);
	int rcmtaxaccount=0;
	try{
		 int docno,jvmethod=0; 
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false); 
		 
		 Statement stmt = conn.createStatement ();
		 ArrayList<String> outamtarray=new ArrayList<>();
		 
		 String configsql="select method from gl_config where field_nme='JvDescriptionABZ'";
		 ResultSet rs1 = stmt.executeQuery(configsql);  
		 if (rs1.next()) {
			 jvmethod=rs1.getInt("method"); 
		 }	
		 
		 String upsql="select method from gl_config where field_nme='tax'";
		 ResultSet resultSet = stmt.executeQuery(upsql);
		 int docval = 0;
		 int typedocval = 0;
		 if (resultSet.next()) {
		    	docval=resultSet.getInt("method");
		    	typedocval=resultSet.getInt("method");
		 }		  
		 if(docval==0) 
		 {
		    String upsql2="select method from gl_prdconfig where field_nme='tax'";
			   ResultSet resultSet2 = stmt.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    	typedocval=resultSet2.getInt("method");
			    }
 }
 docval=0;  
stmt.close();
		 
		CallableStatement stmtnipurchase= conn.prepareCall("{call nipurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnipurchase.registerOutParameter(16, java.sql.Types.INTEGER);
		stmtnipurchase.setInt(18, java.sql.Types.INTEGER);
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setInt(2,refno);
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
		stmtnipurchase.setInt(20,cmbbilltype);
 
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
		int cstper=0;
		int j=0;
		int sno=0;
		
		double fdramt=0;
		double tdramt=0;
		
		int count=0;
		
		int iapprovalStatus=3;
		 double masteramount=0;
		 if(docval>0){
			 Statement stmt21 = conn.createStatement ();
			 Statement stmtt=conn.createStatement();
			 Statement stmtt2=conn.createStatement();
			
		    		 if(intrstate>0){
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
		 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
		 		    	 while(resultSet3.next()){
		    			 double amount=((nettotal*resultSet3.getDouble("cstper"))/100);
		    			 masteramount=(masteramount+amount);
		    			String sql="insert into my_srvtaxni  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+amount+")";
		    			stmtt.executeUpdate(sql);
		    		 }
		 		    	 }
		    		 else{
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 while(resultSet4.next()){
		    			 double amount=((nettotal*resultSet4.getDouble("per"))/100);
		    			 masteramount=(masteramount+amount);
			    			String sql="insert into my_srvtaxni  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+amount+")";
			    			stmtt.executeUpdate(sql);
		    		 }
				       }
		    	
		    }
		/*if(intrstate>0){
			 for(int i=0;i<outamtarray.size();i++){
			       
				 cstper=Integer.parseInt(outamtarray.get(i).split("::")[1]);
				 System.out.println(cstper);
		}
		}*/

		String refdetails="CPU"+""+vocno;
		
		
		String jvdesc="CPU-INV-"+""+invno+""+":-Dated :- "+indateval+"";  
		
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
		for(int i=0;i< descarray.size();i++){
			
			String[] purorderarray=descarray.get(i).split("::");
			String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
		   // System.out.println("========================descarray==================================="+descarray);
		    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
		     {
			/*	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
						   +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
	*/
	    		 String sql="INSERT INTO my_srvpurd(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,costtype,costcode,remarks,acno,taxper,taxamount,nettaxamount,refrow,brhid,rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
					       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
					       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
					       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
					       + "round("+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+",2),"
					       + "round("+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+",2),"
					       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
					       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
					       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
					       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
					       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
					       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")  ||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
					       + " round("+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN") ||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+",2),"
					       + "round("+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN") ||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+",2),"
					       + "'"+(purorderarray[15].trim().equalsIgnoreCase("undefined") || purorderarray[15].trim().equalsIgnoreCase("NaN")  ||purorderarray[15].trim().equalsIgnoreCase("")|| purorderarray[15].isEmpty()?0:purorderarray[15].trim())+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'"+docno+"') ";
//	    		 System.out.println("sql d "+sql);   
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
			     if(reftype.equalsIgnoreCase("NPO"))
					{
			    	 String rownos=""+(purorderarray[15].trim().equalsIgnoreCase("undefined") || purorderarray[15].trim().equalsIgnoreCase("NaN")||purorderarray[15].trim().equalsIgnoreCase("")|| purorderarray[15].isEmpty()?0:purorderarray[15].trim())+"";
						    int rownoss=Integer.parseInt(rownos);
						    String qtyss=""+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"";
						    double qtys=Double.parseDouble(qtyss);
						  
						   String sqlmax="select max(rowno) mrowno from  my_srvpurd where rdocno='"+docno+"' ";
						   ResultSet rs0=stmtnipurchase.executeQuery(sqlmax);
						   if(rs0.first())   
						   {
							    String sqlqss1="update my_srvpurd set refrow="+rownoss+"  where rowno='"+rs0.getInt("mrowno")+"'";
							    stmtnipurchase.executeUpdate(sqlqss1);
						   }     
						    double masterqty=0;
						    String sqlss="select qty,out_qty from my_srvlpod where rowno='"+rownoss+"'";
						    double oqty=0;
						    double mqty=0;
						    ResultSet rsss=stmtnipurchase.executeQuery(sqlss);
						    if(rsss.next())
						    {
						    	oqty=rsss.getDouble("out_qty");
						    	mqty=rsss.getDouble("qty");
						    }
						    masterqty=oqty+qtys;  
						    if(masterqty>mqty)
						    {
						    	masterqty=mqty;
						    }
						    String sqlqss="update my_srvlpod set out_qty="+masterqty+"  where rowno='"+rownoss+"'";
						    //System.out.println("sqlqss--->>>"+sqlqss);        
						    stmtnipurchase.executeUpdate(sqlqss);
					}		 
			    		/* 
			    String addsumsql="SELECT dramount FROM my_jvtran where tr_no="+tranno+" and acno="+acno+" ";
				ResultSet tass2 = stmtnipurchase.executeQuery (addsumsql);
					
					if (tass2.next()) {
				
						
						  fdramt=tass2.getDouble("dramount")+Double.parseDouble(tmp)*1;
						  
					
						  
						 tdramt=fdramt*Double.parseDouble(currate);
					
						  
						  String upsqdata="update my_jvtran set dramount="+fdramt+",ldramount="+tdramt+"  where tr_no="+tranno+" and acno="+acno+" ";
	
						int updateval=	 stmtnipurchase.executeUpdate(upsqdata); 
						 if(updateval<=0)
							{
								conn.close();
								return 0;
								
							}
				     }
					else
					{
	*/		    		 
			     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
 				+ "'"+newjvdesc+"', "
				+ "'"+cmbcurr+"','"+currate+"',round("+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+",2),round("+tdramt+",2),0,1,0,"+(i+1)+",0,0,0,'CPU', "
				+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"',"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+", "
				+ "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"')";
				     
//				System.out.println("----------MY_JVTRAN INSERTION 1-------"+don);
			int samp=stmtnipurchase.executeUpdate(don);
			 if(samp<=0)
				{
					conn.close();
					return 0;
				}
	/*		 if(i==0)
			 {
				 double dramt=(masteramount);
					double as=Double.parseDouble(currate);
					double ldramt=dramt*as;
					
					String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					 
				//	System.out.println(sql1);
					 int ss = stmtnipurchase.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return 0;
							
						} 
			 }*/
			 
					//}
			      
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
							+ " "+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+",round("+fdramt1+",2),'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"+TRANID+","+tranno+")";
							 
			  int costabsq=  stmtnipurchase.executeUpdate(ssql);
			  
			  if(costabsq<=0)
				{
					conn.close();
					return 0;
					
				}
   }
				String updat="update  my_srvpurm set tr_no="+tranno+",invno='"+invno+"',invdate='"+sqlinvdate+"' where doc_no="+docno+"  ";
				  int tabs=  stmtnipurchase.executeUpdate(updat);
				  if(tabs<=0)
					{
						conn.close();
						return 0;
					}
		     }
	     }
		  int taxaccount=0;
		  double typedramt=0;
			 double typeldramt=0;
			 double taxtotal=0;
			 double nettot=0;
		 if(typedocval>0)
		 {
			 Statement stmt11=conn.createStatement();
			 Statement stmt12=conn.createStatement();
			 String sqlss="select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
						+" left join gl_taxmaster m on p.doc_no=m.typeid  and m.type=1 where m.type=1 and  p.doc_no="+ptype+" group by p.doc_no";
					 
					ResultSet rs11=stmt11.executeQuery(sqlss) ;
			 if(rs11.first())
			 {
				 taxaccount=rs11.getInt("taxaccount");
			 }
			 Statement stmt13=conn.createStatement();
			 
			 String rcmtax="select acno rcmtaxaccount from gl_taxmaster where type=2";
			 
			 ResultSet rs13=stmt13.executeQuery(rcmtax) ;
			 
			 if(rs13.next())
			 {
				 rcmtaxaccount=rs13.getInt("rcmtaxaccount");
			 }
			  String sqlssss="select round(sum(nettotal),2)  nettotal,round(sum(taxamount),2) taxamount,round(sum(nettaxamount),2) taxtotal from my_srvpurd where rdocno="+docno+" group by rdocno";
					 
					ResultSet rs111=stmt12.executeQuery(sqlssss) ;
			 if(rs111.first())
			 {
				 
				 typedramt=rs111.getDouble("taxamount");
				 taxtotal=rs111.getDouble("taxtotal");
				 nettot=rs111.getDouble("nettotal");
				 
			 }
			 String updat="update  my_srvpurm set typeid="+ptype+",netamount="+taxtotal+"  where doc_no="+docno+"  ";
			   stmtnipurchase.executeUpdate(updat);
		   }
		 masteramount=0;
		double dramt=(nettot+masteramount+typedramt)*-1;
		double as=Double.parseDouble(currate);
		double ldramt=dramt*as;
		String mposdesc="";
		if(!purdesc.equalsIgnoreCase("")){
			if(jvmethod==1) {  
				mposdesc=jvdesc+" :- "+purdesc;  
			}else {
				mposdesc=purdesc;
			}  
		}else{
			mposdesc=jvdesc+" :- "+purdesc;
		}
		    
		String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+mposdesc+"','"+cmbcurr+"','"+currate+"',round("+dramt+",2),round("+ldramt+",2),0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
		 
//	 	System.out.println("----------------MY_JVTRAN INSERTION 2"+sql1);
		 int ss = stmtnipurchase.executeUpdate(sql1);

	     if(ss<=0)
			{
				conn.close();
				return 0;
				
			}
	     
	     
		 if(typedocval>0)
		 {
			 
			 
			 if(typedramt!=0)
			 {
			 
			 double as1=Double.parseDouble(currate);
			  typeldramt=typedramt*as1;
		 
			
			String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+taxaccount+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',round("+typedramt+",2),round("+typeldramt+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 
//			System.out.println("---------------MY_JVTRAN INSERTION 3------"+sql11);
			 int ss1 = stmtnipurchase.executeUpdate(sql11);
			double	 rcmdrtaxamount=typedramt*-1;
			double rcmldrtaxamount=typeldramt*-1;
			double rcmvnddramount=dramt-rcmdrtaxamount;
			double rcmvndldramount=ldramt-rcmdrtaxamount;
				if(cmbbilltype==2){
					
					String sql15="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+rcmtaxaccount+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',round("+rcmdrtaxamount+",2),round("+rcmldrtaxamount+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					
//					System.out.println("---------------MY_JVTRAN INSERTION RCM------"+sql15);
					
					int ss2 = stmtnipurchase.executeUpdate(sql15);
					
					String sql17="update my_jvtran set dramount=round("+rcmvnddramount+",2),ldramount=round("+rcmvndldramount+",2)  where tr_no="+tranno+" and acno="+accdoc+" ";
					
//					System.out.println("---------------MY_JVTRAN updating RCM vendor amount------"+sql17);
					
					int ss3 = stmtnipurchase.executeUpdate(sql17);
					
					/*String sql16="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+" :- "+purdesc+"','"+cmbcurr+"','"+currate+"',round("+rcmvnddramount+",2),round("+rcmvndldramount+",2),0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				
					
					System.out.println("---------------MY_JVTRAN INSERTION RCM------"+sql16);
					
					int ss3 = stmtnipurchase.executeUpdate(sql16);*/
					
				}
				 if(ss1<=0)
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
		    		 if(intrstate>0){
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
		 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
		 		    	 while(resultSet3.next()){
		    			 double amount=((nettotal*resultSet3.getDouble("cstper"))/100);
		    			 double dramt1=amount;
		 				double as1=Double.parseDouble(currate);
		 				double ldramt1=dramt1*as1;
		 				
		 				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+resultSet3.getInt("acno")+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',round("+dramt1+",2),round("+ldramt1+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
		 				 
//		 				System.out.println("-----------MY_JVTRAN INSERTION 4--------"+sql1);
		 				 int ss1 = stmtnipurchase.executeUpdate(sql11);

//		 				 System.out.println("ss1====="+ss1);
		 				  if(ss1<=0)
		 					{
		 						conn.close();
		 						return 0;
		 						
		 					}
		    			 
		    		 }
		 		    	 }
		    		 else{
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 while(resultSet4.next()){
		    			 double amount=((nettotal*resultSet4.getDouble("per"))/100);
		    			 double dramt1=amount;
			 				double as1=Double.parseDouble(currate);
			 				double ldramt1=dramt1*as1;
			 				
			 				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+resultSet4.getInt("acno")+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',round("+dramt1+",2),round("+ldramt1+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
//			 				System.out.println("-------my_jvtran insertion 5---------"+sql1);
			 				 int ss1 = stmtnipurchase.executeUpdate(sql11);
			 				 
//			 				 System.out.println("ss1..."+ss1);
			 				 if(ss1<=0)
			 					{
			 						conn.close();
			 						return 0;
			 						
			 					}
			    			 
		    			 
		    		 }
				       }
		    	
		    }
		

	      String sqls= "update  my_jvtran set id=-1 where  dramount<0 and tr_no="+tranno+" ";		
          stmtnipurchase.executeUpdate(sqls);
          String sqls11= "update  my_jvtran set id=1 where  dramount>0 and tr_no="+tranno+" ";		
          stmtnipurchase.executeUpdate(sqls11);
      	
          String sql12="select sum(dramount) drsum from my_jvtran where tr_no="+tranno+" ";
          ResultSet resultSet5 = stmtnipurchase.executeQuery(sql12);
          double drsumamt=0;
          while(resultSet5.next()){
        	  drsumamt=resultSet5.getDouble("drsum");
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

public boolean edit(int docno,Date sqlStartDate,Date purdeldate, String reftype, int refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,
		String Formdetailcode,int tranno,HttpServletRequest request,Date sqlinvdate,String invno,String indateval,int interstate,int ptype,int cmbbilltype) throws SQLException {
	
	int rcmtaxaccount=0;
	
	try{
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false);
		 
		 Statement stmt33 = conn.createStatement ();
		 
		  String upsql="select method from gl_config where field_nme like'tax'";
		   ResultSet resultSet33 = stmt33.executeQuery(upsql);
		    int docval = 0;
		    int typedocval = 0;
			int count=0;
			
			int iapprovalStatus=3;
		    if (resultSet33.next()) {
		    	docval=resultSet33.getInt("method");
		    	typedocval=resultSet33.getInt("method");
		    }		  
		    if(docval==0)
		    {
		    String upsql2="select method from gl_prdconfig where field_nme like'tax'";
			   ResultSet resultSet2 = stmt33.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    	typedocval=resultSet2.getInt("method");
			    }
		    }
		    
		    
stmt33.close();
docval=0;
		CallableStatement stmtnipurchase= conn.prepareCall("{call nipurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setInt(2,refno);
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
		stmtnipurchase.setInt(19, interstate);
		stmtnipurchase.setInt(20,cmbbilltype);
		int aaa=stmtnipurchase.executeUpdate();
		docno=stmtnipurchase.getInt("docNo");
		
		if(aaa<=0)
		{
			conn.close();
			return false;
			
		}	
		
		int ap_trid=0;
	    double amount=0.00,outamount=0.00;
	  Statement stmtBPV=conn.createStatement();
	  ClsApplyDelete.getFinanceApplyDelete(conn, tranno);
	     /*Selecting Tran-Id*/
/*	      ArrayList<String> tranidarray=new ArrayList<>();
	      String sql11="SELECT TRANID FROM my_jvtran where TR_NO="+tranno+" and acno="+accdoc+"";
	      
	   //   System.out.println("----sql11---"+sql11);
	      
	      ResultSet resultSet=stmtBPV.executeQuery(sql11);
	      
	      while(resultSet.next()){
	       tranidarray.add(resultSet.getString("tranid"));
	      }
	      Selecting Tran-Id Ends
	      
	      Selecting Ap_Tran-Id
	      ArrayList<String> outamtarray=new ArrayList<>();

	      for(int i=0;i<tranidarray.size();i++){
	       String sql2="select tranid ap_trid,amount from my_outd where ap_trid="+tranidarray.get(i);
	       
	   //    System.out.println("----sql2---"+sql2);
	       ResultSet resultSet1=stmtBPV.executeQuery(sql2);
	       
	       while(resultSet1.next()){
	        outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
	       } 

	      }
	      Selecting Ap_Tran-Id
	   //   System.out.println("----outamtarray---"+outamtarray);
	      for(int i=0;i<outamtarray.size();i++){
	       
	       ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
	       amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

	       String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
	      // System.out.println("----sql4---"+sql4);
	       int data1=stmtBPV.executeUpdate(sql4);
	       
	      }
	    Apply-Invoicing Grid Updating Ends
	      
	       Selecting outamount
	        String sql5="select sum(amount) outamount from my_outd where ap_trid="+tranidarray.get(0)+"";
	        
	     //   System.out.println("----sql5---"+sql5);
	        ResultSet resultSet2=stmtBPV.executeQuery(sql5);
	      
	        while(resultSet2.next()){
	       outamount= resultSet2.getDouble("outamount");
	        }
	       Selecting outamount Ends
	      
	        String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
	       // System.out.println("----sql4--2-"+sql4);
	        int data3=stmtBPV.executeUpdate(sql4);
	       
	     Deleting from my_outd
	      String sql3="delete from my_outd where ap_trid="+tranidarray.get(0)+"";
	    //  System.out.println("----sql3---"+sql3);
	      
	      int data2=stmtBPV.executeUpdate(sql3);
	     Deleting from my_outd Ends
*/		
				
		   String delsql="Delete from my_srvpurd where rdocno="+docno+" and brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
		   stmtnipurchase.executeUpdate(delsql);
		   
		   String delsql1="Delete from my_jvtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql1);
		   
		   String delsql2="Delete from my_costtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql2);
		   
		   String delsql3="Delete from my_srvtaxni where rdocno="+docno+" ";
		   stmtnipurchase.executeUpdate(delsql3);
			int j=0;
			int sno=0;
			double fdramt=0;
			double tdramt=0;
			Statement stmt =conn.createStatement();
			
			int vocno=0;
			
			String sqlss="select voc_no from my_srvpurm where doc_no='"+docno+"' ";
			ResultSet rss=stmt.executeQuery(sqlss);
			
			if(rss.next())
			
			{
				
				vocno=rss.getInt("voc_no");
				
			}
			 double masteramount=0;

			 if(docval>0){
				 Statement stmt21 = conn.createStatement ();
				 Statement stmtt=conn.createStatement();
				 Statement stmtt2=conn.createStatement();
				
			    		 if(interstate>0){
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
			 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
			 		    	 while(resultSet3.next()){
			    			 double aamount=((nettotal*resultSet3.getDouble("cstper"))/100);
			    			 masteramount=(masteramount+aamount);
			    			String sql="insert into my_srvtaxni  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+aamount+")";
			    			stmtt.executeUpdate(sql);
			    		 }
			 		    	 }
			    		 else{
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
			 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
			 		    	 while(resultSet4.next()){
			    			 double aamount=((nettotal*resultSet4.getDouble("per"))/100);
			    			 masteramount=(masteramount+aamount);
				    			String sql="insert into my_srvtaxni  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+aamount+")";
				    			stmtt.executeUpdate(sql);
			    		 }
					       }
			    	
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
			
			String refdetails="CPU"+""+vocno;
			String jvdesc="CPU-INV-"+""+invno+""+":-Dated :- "+indateval+"";  

			for(int i=0;i< descarray.size();i++){
				 String[] purorderarray=descarray.get(i).split("::");
				 String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
	/*			if(i==0)
					
				{
					
					
					
					
					
					
					double dramt=(nettotal+masteramount)*-1;
					double as=Double.parseDouble(currate);
					double ldramt=dramt*as;
					
					 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
	
					 int ss = stmtnipurchase.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return false;
							
						}
					
				}
				*/
				 if(i==0){
						if(reftype.equalsIgnoreCase("NPO")){
		 				 Statement stmtd=conn.createStatement();
			 					   String sqlmax="select refrow,qty from my_srvpurd where rdocno='"+docno+"' ";
								   ResultSet rs01=stmtnipurchase.executeQuery(sqlmax);
								   while(rs01.next())
								   {
									 String upsql11="update  my_srvlpod set out_qty=out_qty-"+rs01.getDouble("qty")+" where rowno="+rs01.getDouble("refrow")+" "  ;
									 stmtd.executeUpdate(upsql11);
								   }
		 				}   
				 }
			    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
		
		    		 String sql="INSERT INTO my_srvpurd(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,costtype,costcode,remarks,acno,taxper,taxamount,nettaxamount,brhid,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
						       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
						       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
						       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
						       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
						       + "round("+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+",2),"
						       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
						       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
						       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
						       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
						       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
						        + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")  ||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
					       + " round("+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")  ||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+",2),"
					       + "round("+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")  ||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+",2),"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'"+docno+"')";
				     int resultSet21 = stmtnipurchase.executeUpdate(sql);
				     
				     if(resultSet21<=0)
						{
							conn.close();
							return false;
							
						}
				  String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
					    int acno=Integer.parseInt(acno1);
				
					     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					      fdramt=Double.parseDouble(tmp)*1;
					    		
					     		     tdramt=fdramt*Double.parseDouble(currate);
					     
					     			 
					 				if(reftype.equalsIgnoreCase("NPO"))
					 				{
					 					
					 					 String rownos=""+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"";
					 					    int rownoss=Integer.parseInt(rownos);
					 					    String qtyss=""+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"";
					 					    double qtys=Double.parseDouble(qtyss);
					 					    
					 					    
					 					   String sqlmax="select max(rowno) mrowno from  my_srvpurd where rdocno='"+docno+"' ";
										   ResultSet rs0=stmtnipurchase.executeQuery(sqlmax);
										   if(rs0.first())
										   {
											   
											    
											    String sqlqss1="update my_srvpurd set refrow="+rownoss+"  where rowno='"+rs0.getInt("mrowno")+"'";
											    stmtnipurchase.executeUpdate(sqlqss1);
										   }
												 
					 					    
					 					    double masterqty=0;
					 					    
					 					    String sqlsss="select qty,out_qty from my_srvlpod where rowno='"+rownoss+"'";
					 					    double oqty=0;
					 					    double mqty=0;
					 					    ResultSet rsss=stmtnipurchase.executeQuery(sqlsss);
					 					    
					 					    if(rsss.next())
					 					    {
					 					    	oqty=rsss.getDouble("out_qty");
					 					    	mqty=rsss.getDouble("qty");
					 					    }
					 					    
					 					    
					 					    
					 					    masterqty=oqty+qtys;
					 					    
					 					    if(masterqty>mqty)
					 					    {
					 					    	masterqty=mqty;
					 					    }
					 					    
					 					    
					 					    String sqlqss="update my_srvlpod set out_qty="+masterqty+"  where rowno='"+rownoss+"'";
					 					    stmtnipurchase.executeUpdate(sqlqss);
					 					    
					 					    
					 					    
					 					
					 				}
					 			     
					     
				/*	    		 
 		    	    String addsumsql="SELECT dramount FROM my_jvtran where tr_no="+tranno+" and acno="+acno+" ";
						ResultSet tass2 = stmtnipurchase.executeQuery (addsumsql);
							
							if (tass2.next()) {
						
								
								  fdramt=tass2.getDouble("dramount")+Double.parseDouble(tmp)*1;
								  
								 tdramt=fdramt*Double.parseDouble(currate);
							
								  
								  String upsqdata="update my_jvtran set dramount="+fdramt+",ldramount="+tdramt+"  where tr_no="+tranno+" and acno="+acno+" ";
								
								int updateval=	 stmtnipurchase.executeUpdate(upsqdata); 
								 if(updateval<=0)
									{
										conn.close();
										return false;
										
									}
								 
								  
						     }
							else
							{
					    		*/ 
					    		 
					    		 
					    		 
					     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
							 				+ "'"+newjvdesc+"', "
						+ "'"+cmbcurr+"','"+currate+"',round("+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+",2),round("+tdramt+",2),0,1,0,"+(i+1)+",0,0,0,'CPU', "
						+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"',"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+", "
						+ "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"')";
						     
							 
//					System.out.println("--------my_jvtran insertion 6"+don);
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
						+ " "+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+",round("+fdramt1+",2),'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"+TRANID+","+tranno+")";
					 
				  int costabsq=  stmtnipurchase.executeUpdate(ssql);
				  
				  if(costabsq<=0)
					{
						conn.close();
						return false;
						
					}
				  
			     }
				
		
				 
				 
				 
			     }
			    
			  
		     }
			
			
			
			
			
			
			
			  int taxaccount=0;
			  double typedramt=0;
				 double typeldramt=0;
				 
				 double taxtotal=0;
				 
				 double dramt=0;
				 double nettot=0;
			  
			 if(typedocval>0)
			 {
				 
					
				 
					
					  
					  
					  
				 Statement stmt11=conn.createStatement();
				 
				 Statement stmt12=conn.createStatement();
				 String sqlss11="select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
							+" left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where m.type=1 and  p.doc_no="+ptype+" group by p.doc_no";
						 
						ResultSet rs11=stmt11.executeQuery(sqlss11) ;
				 if(rs11.first())
				 {
					 taxaccount=rs11.getInt("taxaccount");
					 
					 
					 
				 }
				 
				
				 
				 
				 String sqlssss="select round(sum(nettotal),2)  nettotal,round(sum(taxamount),2)  taxamount,round(sum(nettaxamount),2) taxtotal from my_srvpurd where rdocno="+docno+" group by rdocno";
						 
						ResultSet rs111=stmt12.executeQuery(sqlssss) ;
				 if(rs111.first())
				 {
					 
					 typedramt=rs111.getDouble("taxamount");
					 taxtotal=rs111.getDouble("taxtotal");
					 
					 nettot=rs111.getDouble("nettotal");
					 
					 
				 }
				 
				 
				 String updat="update  my_srvpurm set typeid="+ptype+",netamount="+taxtotal+" where doc_no="+docno+"  ";
				 
				   stmtnipurchase.executeUpdate(updat);
				 
				   dramt=taxtotal*-1; 
				   
			 }
			 else
			 {
				   dramt=(nettot+masteramount)*-1; 
			 }
				 
			
			 masteramount=0;
			 
			 
			 
			double as=Double.parseDouble(currate);
			double ldramt=dramt*as;
			
			String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"-"+purdesc+"' ,'"+cmbcurr+"','"+currate+"',round("+dramt+",2),round("+ldramt+",2),0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 
//		 	System.out.println("======my_jvtran insertion  7========"+sql1);
			 int ss = stmtnipurchase.executeUpdate(sql1);

		     if(ss<=0)
				{
					conn.close();
					return false;
					
					
				}
		     
		     
			 if(typedocval>0)
			 {
				 if(typedramt!=0)
				 {
				 double as1=Double.parseDouble(currate);
				  typeldramt=typedramt*as1;
			 
				
				String sql1121="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+taxaccount+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',round("+typedramt+",2),round("+typeldramt+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 
			//	System.out.println(sql1);
				
//				System.out.println("======my_jvtran insertion  8========"+sql1121);
				 int ss1 = stmtnipurchase.executeUpdate(sql1121);

			     if(ss1<=0)
					{
						conn.close();
						return false;
						
						
					}
				 }
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 Statement stmt13=conn.createStatement();
				 
				 String rcmtax="select acno rcmtaxaccount from gl_taxmaster where type=2";
				 
				 ResultSet rs13=stmt13.executeQuery(rcmtax) ;
				 
				 if(rs13.next())
				 {
					 rcmtaxaccount=rs13.getInt("rcmtaxaccount");
				 }
				 
				 
				 
				 double	 rcmdrtaxamount=typedramt*-1;
					
					double rcmldrtaxamount=typeldramt*-1;
					
					double rcmvnddramount=dramt-rcmdrtaxamount;
					
					double rcmvndldramount=ldramt-rcmdrtaxamount;	 
				 
				 
				 
				 
				 

if(cmbbilltype==2){
					
					String sql15="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+rcmtaxaccount+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',round("+rcmdrtaxamount+",2),round("+rcmldrtaxamount+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					
//					System.out.println("---------------MY_JVTRAN EDIT RCM------"+sql15);
					
					int ss2 = stmtnipurchase.executeUpdate(sql15);
					
								
					
					
					
					String sql17="update my_jvtran set dramount=round("+rcmvnddramount+",2),ldramount=round("+rcmvndldramount+",2)  where tr_no="+tranno+" and acno="+accdoc+" ";
					
//					System.out.println("---------------MY_JVTRAN EDIT RCM vendor amount------"+sql17);
					
					int ss3 = stmtnipurchase.executeUpdate(sql17);
					
					/*String sql16="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+" :- "+purdesc+"','"+cmbcurr+"','"+currate+"',round("+rcmvnddramount+",2),round("+rcmvndldramount+",2),0,-1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				
					
					System.out.println("---------------MY_JVTRAN INSERTION RCM------"+sql16);
					
					int ss3 = stmtnipurchase.executeUpdate(sql16);*/
					
				}
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
			 }
		     
		   
		   
		   
		
	//	System.out.println("aaaaaaaaaaaaaaaaa"+aaa);
		/*for(int i=0;i<descarray.size();i++){
	    	
		     String[] purorderarray=descarray.get(i).split("::");
		    
		     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
		     {
		    	 
		    	 String sql="INSERT INTO my_srvpurd(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
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
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'"+docno+"')";*/
		    	 
		/*    	 
	     String sql="update  my_srvpurd set SRNO="+(i+1)+","
	     		   + "qty='"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
			       + "desc1='"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
			       + "unitprice='"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
			       + "total='"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
			       + "discount='"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
			       + "nettotal='"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"'," 
	               + "nuprice='"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
	               + "costtype='"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
	               + "costcode='"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
	                + "remarks='"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
	            + "acno='"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
	            + "brhid='"+session.getAttribute("BRANCHID").toString()+"' where rdocno="+docno+"";*/
	      
	   //  System.out.println(""+sql);
	/*     int resultSet4 = stmtnipurchase.executeUpdate(sql);
	 	if(resultSet4<=0)
		{
			conn.close();
			return false;
			
		} 
		     }
		    
		
		}*/	
			
			
			 
			 
			String updat="update  my_srvpurm set invno='"+invno+"',invdate='"+sqlinvdate+"' where doc_no="+docno+"  ";
				 
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
				    		 if(interstate>0){
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				    			 double aamount=((nettotal*resultSet3.getDouble("cstper"))/100);
				    			 double dramt1=aamount;
				 				double as1=Double.parseDouble(currate);
				 				double ldramt1=dramt1*as1;
				 				
				 				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+resultSet3.getInt("acno")+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',round("+dramt1+",2),round("+ldramt1+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'3')";
				 				 
//				 			System.out.println("-----------my_jvtran insertion 9------"+sql111);
				 				 int ss1 = stmtnipurchase.executeUpdate(sql111);

				 			     if(ss<=0)
				 					{
				 						conn.close();
				 						return false;
				 						
				 					}
				    			 
				    		 }
				 		    	 }
				    		 else{
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
				    			 double aamount=((nettotal*resultSet4.getDouble("per"))/100);
				    			 double dramt1=aamount;
					 				double as1=Double.parseDouble(currate);
					 				double ldramt1=dramt1*as;
					 				
					 				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+resultSet4.getInt("acno")+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',round("+dramt+",2),round("+ldramt+",2),0,1,0,0,0,0,0,0,0,'CPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'3')";
					 				 
//					 				System.out.println("-------- jvtran insertion 10----"+sql111);
					 				 int ss1 = stmtnipurchase.executeUpdate(sql111);

					 			     if(ss1<=0)
					 					{
					 						conn.close();
					 						return false;
					 						
					 					}
					    			 
				    			 
				    		 }
						       }
				    	
				    }
				
			  
			
			
			   	  String sqls= "update  my_jvtran set id=-1 where  dramount<0 and tr_no="+tranno+" ";		
		          stmtnipurchase.executeUpdate(sqls);
		          String sqls11= "update  my_jvtran set id=1 where  dramount>0 and tr_no="+tranno+" ";		
		          stmtnipurchase.executeUpdate(sqls11);
			
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

		
		CallableStatement stmtnipurchase= conn.prepareCall("{call nipurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
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
		stmtnipurchase.setInt(19,0);
		stmtnipurchase.setInt(20,0);
		
		int aaa=stmtnipurchase.executeUpdate();
		
		int tr_no=0;
		Statement newStatement=conn.createStatement();
		String selectsqls= " select tr_no from my_srvpurm where doc_no="+docno+" " ;
		ResultSet rss101=newStatement.executeQuery(selectsqls);
		if(rss101.first())
			{
			tr_no=rss101.getInt("tr_no");
			}   
		
		ClsApplyDelete.getFinanceApplyDelete(conn,tr_no );	
		
		if (aaa > 0) {
			
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



	public   JSONArray accountsDetailsTo() throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();

		   Connection conn=null;
  try {
	  conn= connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
/*             
    String sql=("select (@i:=@i+1) recno,t.doc_no,t.account,t.description,c.code curr from my_head t,my_acbook a1, "
      + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
      + "and t.cldocno=a1.cldocno and t.atype='"+dtype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
      + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')");*/
    
    /*String sql="select description,doc_no,account from my_head where atype='AP' and m_s=0";*/
    
    String sql= "select coalesce(t1.tax,0) tax,t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
    		+ "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
    		+ "from my_curbook cr where  coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid)"
    		+ "left join my_vndtax t1 on t1.doc_no=a.type  where a.active=1 and t.m_s=0";
    
  // System.out.println("---asdsa---------"+sql); 
    ResultSet resultSet = stmtCPV.executeQuery (sql);
 // System.out.println("------------"+sql);
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
	
	public   JSONArray reloadnipurchase(HttpSession session,String nidoc) throws SQLException {

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
				Statement stmtVeh1 = conn.createStatement ();      
	        	String pySql=(" select d.refrow rowno,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount, d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup "
	        			+ " from my_srvpurd d left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
	        			+ "  where d.rdocno='"+nidoc+"' and d.brhid='"+brcid+"'  "); 
	        //	System.out.println("========"+pySql);
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
			
			    /* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select costcode code,doc_no,description name,0 reg_no  from my_ccentre where m_s=0;";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
				/* AMC & SJOB */
	        	} else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4")) {
	        		
	        		String dtype="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
	        		stmtVehclr.close();
		        
				/* Call Register */
		        } else if(type.equalsIgnoreCase("5")) {
		        	
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
	        		stmtVehclr.close();
			        	
			    /* Fleet */
		        } else if(type.equalsIgnoreCase("6"))
	        	{
	        		
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0;";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
	        	/* IJCE */
	        	}  else if(type.equalsIgnoreCase("7")) {
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from is_jobmaster m left join my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
	        		stmtVehclr.close();
					
				/* Contract */
	        	} else if(type.equalsIgnoreCase("8")) {
	        		
	        		String sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name from hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
	        		stmtVehclr.close();
					
				/* Job Card */
	        	} else if(type.equalsIgnoreCase("9")) {
	        		
	        		String sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1";
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
	        	String pySql=("select    coalesce(m.typeid,0) typeid,coalesce(p.ptype,'') ptype,coalesce(p.per,0) per  ,m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_srvlpod d on d.rdocno=m.doc_no left join my_head h on h.doc_no=m.acno  "
	        			+ " left join (select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
					     +" left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where  p.status=3 and m.type=1 group by p.doc_no and m.typeid>0) p on p.doc_no=m.typeid "
	        			+ " where m.status<>7 and m.brhid='"+brcid+"' and d.qty-d.out_qty>0" );     
//	        	 System.out.println("========"+pySql);
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
	       	
				String resql=(" select d.rowno,d.srno,d.desc1 desc1,d.unitprice unitprice,d.qty-d.out_qty qty,d.unitprice*(d.qty-d.out_qty) total,m.type,d.discount,m.acno,h.description,h.account,d.taxper,(((d.unitprice*(d.qty-d.out_qty))-D.DISCOUNT) * D.TAXPER/100) taxperamt,(((d.unitprice*(d.qty-d.out_qty))-D.DISCOUNT) ) + (((d.unitprice*(d.qty-d.out_qty))-D.DISCOUNT) * D.TAXPER/100)  taxamount  from "
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
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa,String description) throws SQLException {

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
    	if((!(reftypess.equalsIgnoreCase(""))) && (!(reftypess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and m.reftype like '%"+reftypess+"%'";
    	}
    	if((!(description.equalsIgnoreCase(""))) && (!(description.equalsIgnoreCase("NA")))){
    	      sqltest=sqltest+" and m.desc1 like '%"+description+"%' "; 
    	     }
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
    	} 
        
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select convert(coalesce(o.voc_no,''),char(20)) refvocno,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        			+ "m.deldate,m.desc1,h.description,h.account from my_srvpurm m left join my_head h on h.doc_no=m.acno left join my_srvlpom o on m.refno=o.doc_no where m.status<>7  "
	        			+ "and m.brhid='"+brcid+"' "+sqltest );
	        	//System.out.println("========"+pySql);
	        	
	       
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
	 public  ClsnipurchaseBean getPrint(int docno, HttpServletRequest request ,HttpSession session,String brhid) throws SQLException {
		 ClsnipurchaseBean bean = new ClsnipurchaseBean();
		  Connection conn = null; // String brcid=session.getAttribute("BRANCHID").toString();
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				/*String resql=("select m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount,m.type,m.acno,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype,m.refno,m.curid,m.rate,m.delterm, "
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,h.account from my_srvpurm m left join my_head h on h.doc_no=m.acno  where m.DOC_NO='"+docno+"' ");
				*/
				
				String resql=("select  m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.refno,coalesce(a.mail1,'') mail1,  coalesce(a.fax1,'') fax1,coalesce(a.per_mob,'') per_mob,a.address, "
						+ "coalesce(a.contactperson,'') contactperson,a.trnnumber,m.voc_no,date_format(m.date,'%d-%m-%Y') date, "
						+ "round(m.netamount,2) netamount ,m.type,m.acno,if(trim(m.delterm)!='',m.delterm,null)delterm,"
						+ "if(trim(m.payterm)!='',m.payterm,null)payterm,date_format(m.deldate,'%d-%m-%Y') deldate, if(trim(m.desc1)!='',m.desc1,null)desc1,coalesce(h.description,'') description,"
						+ " h.account,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype from my_srvpurm m left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='VND'  where m.DOC_NO="+docno+" ");
				
						//System.out.println("Query++++++++"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   
			    	   
			    	   bean.setAttn(pintrs.getString("contactperson"));
			    	   bean.setTel(pintrs.getString("per_mob"));
			    	   bean.setFax(pintrs.getString("fax1"));
			    	   bean.setEmail(pintrs.getString("mail1"));
			    	   bean.setRefno(pintrs.getString("refno"));
			    	   bean.setLbltrno(pintrs.getString("trnnumber"));
			    	   
			    		    	
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltype(pintrs.getString("reftype"));
			    	    bean.setDocvals(pintrs.getString("voc_no"));
			    	    bean.setLblacno(pintrs.getString("account"));
			    	    //upper
			    	    bean.setLblacnoname(pintrs.getString("description"));
			    	    bean.setLbldeldate(pintrs.getString("deldate"));
			    	    bean.setLbldddtm(pintrs.getString("delterm"));
			    	    
			    	    bean.setLbldsc(pintrs.getString("desc1"));
			    	    bean.setLblpatms(pintrs.getString("payterm"));
			    	   
			    	    
			    	    /*bean.setLblnettotal(pintrs.getString("netamount"));*/
			    	    
			    	    bean.setLblinvno(pintrs.getString("invno"));
			    	    bean.setLblinvdate(pintrs.getString("invdate"));
			    	     
			    	    ClsAmountToWords c= new ClsAmountToWords();
				    	
			    	    bean.setWordnetamount(c.convertAmountToWords(pintrs.getString("netamount")));
			    	
			    	 
			    	    
			       }
				

				stmtprint.close();
				
				//----------//
				
				String strtotal="select round(sum(total),2) total,round(sum(discount),2) discount,round(sum(taxamount),2) taxamount,round(sum(nettaxamount),2) nettotal from my_srvpurd where rdocno="+docno+" group by rdocno;";				
				Statement stmttot=conn.createStatement();
				ResultSet rstot=stmttot.executeQuery(strtotal);
				while(rstot.next()){
					bean.setLbltotal(rstot.getString("total"));
					bean.setLbltaxtot(rstot.getString("taxamount"));
					bean.setLbldiscount(rstot.getString("discount"));
					bean.setLblnettotal(rstot.getString("nettotal"));
					
					ClsAmountToWords c= new ClsAmountToWords();
					
					bean.setLbltotinword(c.convertAmountToWords(rstot.getString("nettotal")));
					
				}
				stmttot.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvpurm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
				    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.tinno,b.stcno,b.cstno from my_srvpurm r inner join my_brch b on  "
				    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
//System.out.println("----------------"+companysql);
			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				    
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	   bean.setLblcomptrn(resultsetcompany.getString("tinno"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				 ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
						String strSqldetail="select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettaxamount,2) nettotal,d.nuprice,round(d.taxper,2) taxper,round(d.taxamount,2) taxamount,"
								+ " d.remarks,h.account account,h.description accname,h.atype accounttype,concat(coalesce(v.reg_no,''),' - ',coalesce(p.code_name,'')) regno  from my_srvpurd d left join my_head h on h.doc_no=d.acno  "
								+ " left join gl_vehmaster v on v.fleet_no=d.costcode and costtype=6"
								+ " left join gl_vehplate p on v.pltid=p.doc_no"
								+ " where d.rdocno='"+docno+"' order by srno";
					
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
		
							String temp="";
						
							temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("unitprice")+"::"+rsdetail.getString("total")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("taxper")+"::"+rsdetail.getString("taxamount")+"::"+rsdetail.getString("nettotal")+"::"+rsdetail.getString("accounttype")+"::"+rsdetail.getString("account")+"::"+rsdetail.getString("accname")+"::"+rsdetail.getString("regno") ;
		
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					
					
					
					String descQry=" select @i:=@i+1 as srno,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
			          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice "
			        		+ "   from my_srvpurd d  where d.rdocno="+docno+" order by d.srno ) a,(select @i:=0) r;";
			           
			           
		          
		          String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
		          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
		          		+ "where  tr.dtype='CPU' and tr.brhid='"+brhid+"' and tr.rdocno="+docno+" and tr.status=3 ) tr "
		          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
		          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
		          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
		          		+ "   tr.dtype='CPU' and tr.rdocno="+docno+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
		        	
		          
		          bean.setDescQry(descQry);
		          bean.setTermQry(termsquery);

				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
		public JSONArray typeFormSearch(HttpSession session) throws SQLException {


			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = connDAO.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql="select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
				+" left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where  p.status=3 and m.type=1  and m.typeid>0 group by p.doc_no order by p.doc_no ";

				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=commDAO.convertToJSON(resultSet);


			}catch(Exception e){
				e.printStackTrace();

			}finally{
				conn.close();
			}
			return RESULTDATA;
		}
		
		
		public ClsnipurchaseBean getViewDetails(int docno, HttpSession session) throws SQLException {
			ClsnipurchaseBean showBean = new ClsnipurchaseBean();
			
			Connection conn=null;
			try { 
				conn = connDAO.getMyConnection();
			 
			Statement stmtmain = conn.createStatement ();
	    	String pySql=("select  if(m.billtype=1, 'ST','RCM') cmbilltype,m.billtype,coalesce(m.typeid,0) typeid,coalesce(p.ptype,'') ptype,coalesce(p.per,0) per  ,convert(coalesce(o.voc_no,''),char(20)) refvocno,m.interstate,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,"
	    			+ " m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	    			+ "m.deldate,m.desc1,h.description,h.account from my_srvpurm m left join my_head h on h.doc_no=m.acno left join my_srvlpom o on m.refno=o.doc_no"
	    			+ " left join (select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
				     +" left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where  p.status=3 and m.type=1 group by p.doc_no and m.typeid>0) p on p.doc_no=m.typeid " 
	    			+ " where   m.status<>7 and m.voc_no='"+docno+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" " );
//	    	System.out.println("========"+pySql);
			ResultSet resultSet = stmtmain.executeQuery(pySql);  

			while (resultSet.next())
			{
				
				
				  
				
				
				  
				  showBean.setHideproducttype(resultSet.getInt("typeid"));
				  showBean.setTxtproducttype(resultSet.getString("ptype"));
				  showBean.setTaxpers(resultSet.getDouble("per"));
				
			
			showBean.setTarannumber(resultSet.getInt("tr_no"));
			
			showBean.setHidinvDate(resultSet.getString("invdate"));
			showBean.setInvno(resultSet.getString("invno"));
			showBean.setHidnipurchasedate(resultSet.getString("date"));
			
			 
			showBean.setHiddeliverydate(resultSet.getString("deldate"));
			showBean.setOrdermasterdoc_no(resultSet.getInt("refno")) ;
			showBean.setRefno(resultSet.getString("refvocno"));
			showBean.setReftypeval(resultSet.getString("reftype"));
			showBean.setAcctypeval(resultSet.getString("type"));
			showBean.setNipuraccid(resultSet.getString("account"));
			showBean.setPuraccname(resultSet.getString("description"));
			showBean.setCmbcurrval(resultSet.getString("curid"));
			showBean.setAccdocno(resultSet.getString("acno"));
			showBean.setCurrate(resultSet.getString("rate"));
			showBean.setCmbbilltype(resultSet.getInt("billtype"));
			//showBean.setHidcmbbilltype(resultSet.getInt("billtype"));
			  showBean.setHidinterstate(resultSet.getInt("interstate"));
			
			showBean.setDelterms(resultSet.getString("delterm"));
			showBean.setPayterms(resultSet.getString("payterm"));
			showBean.setPurdesc(resultSet.getString("desc1"));
			showBean.setNettotal(resultSet.getDouble("netamount"));
			 
			showBean.setDocno(resultSet.getInt("voc_no"));
			showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
			
			
			}
			
			stmtmain.close();
			conn.close();
			}
			catch(Exception e){
				
			e.printStackTrace();
			conn.close();
			}
			return showBean;
			
		}
		
		
    }

	
