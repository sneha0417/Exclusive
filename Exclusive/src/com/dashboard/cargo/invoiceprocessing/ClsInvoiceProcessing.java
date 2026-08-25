package com.dashboard.cargo.invoiceprocessing;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceProcessing {
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	Connection conn = null;
	
public JSONArray clientData(String clientname,String mob,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		
		Connection conn =null;
        
		try {
			conn=connDAO.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			if(!mob.equalsIgnoreCase("")){
				sqltest+=" and per_mob like '%"+mob+"%'";
			}
			String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return RESULTDATA;
	}


public JSONArray gridData(String cldocno,String branch) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();

	/*if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }*/
	
	Connection conn =null;
    
	try {
		conn=connDAO.getMyConnection();

		   String sqltest="";
		    if(!(cldocno.equalsIgnoreCase(""))||(cldocno.equalsIgnoreCase("0"))){
		     sqltest+=" and m.cldocno = "+cldocno+"";
		    }
		    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        sqltest+=" and m.brhid='"+branch+"'";
		     }
		Statement stmt = conn.createStatement ();
		String sql="select cd.rowno cdifdno,m.brhid branch,m.date,ac.refname client,ed.pol,ed.pod,m.voc_no qotno ,ct.remarks ,ct.tr_no,ct.doc_no jobno,ct.refno,cd.srno,cd.desc1 description,cd.unitprice,cd.qty,cd.qty qutval,"
			      + " cd.total,cd.discount,cd.nettotal,cd.nuprice,cd.acno headdoc,cd.costtype,cd.costcode, cd.remarks,cd.taxper,cd.tax taxperamt,cd.nettaxamount taxamount "
			      + " from cr_qotm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'"
			      + " left join cr_enqm em on m.rrefno=em.doc_no  and m.reftype='ENQ' left join cr_enqd ed on em.doc_no=ed.rdocno "
			      + " left join cr_joblist l on l.enqdocno=ed.doc_no left join cm_srvcontrm ct on l.jobno=ct.tr_no "
			      + " left join cr_cfim cm on cm.refno=ct.tr_no  left join cr_cfid cd on cm.doc_no=cd.rdocno  where 1=1  and invtrno=0 " +sqltest;
		System.out.println("--sqlgrid--"+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=commonDAO.convertToJSON(resultSet);
		stmt.close();
		conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return RESULTDATA;
	}


public int saveData(ArrayList<String> descarray, String hidcldocno,java.sql.Date sqlStartDate, HttpSession session,HttpServletRequest request) throws SQLException {
	// TODO Auto-generated method stub
	Connection conn=null;
	
	try{
	conn=connDAO.getMyConnection();
	conn.setAutoCommit(false);
		String rowno="",jobno="";
		ArrayList<String> jobnos= new ArrayList<>();
		String[] rownos = new String[50];
		for(int i=0;i<descarray.size();i++){
			System.out.println(descarray);
			String[] purorderarray=descarray.get(i).split("::");
			String jobnoss=""+(purorderarray[17].trim().equalsIgnoreCase("undefined") || purorderarray[17].trim().equalsIgnoreCase("NaN")|| purorderarray[17].trim().equalsIgnoreCase("")|| purorderarray[17].isEmpty()?0:purorderarray[17].trim());
			String rownoss=""+(purorderarray[16].trim().equalsIgnoreCase("undefined") || purorderarray[16].trim().equalsIgnoreCase("NaN")|| purorderarray[16].trim().equalsIgnoreCase("")|| purorderarray[16].isEmpty()?0:purorderarray[16].trim());
			if (!jobnos.contains(jobnoss)){
				jobnos.add(jobnoss);
			}
			if(i==0){
				rowno+=rownoss;
			}
			else{
				rowno+=","+rownoss;
			}
			
		}
		for(int i=0;i<jobnos.size();i++){
			if(i==0){
				jobno+=jobnos.get(i);
			}
			else{
				jobno+=","+jobnos.get(i);
			}
		}
		double nettotal=0;
		double taxamount=0;
		double nettaxamont=0;
		Statement stmt111=conn.createStatement();
		String sqlss="SELECT sum(nettotal) nettotal,coalesce(sum(taxamount),0) taxamount,sum(nettotal+coalesce(taxamount,0)) nettaxamont "
				+ " FROM cr_cfid where rowno in ("+rowno+") ";
		
		System.out.println("======sqlss======masterdoc_no========"+sqlss);
		ResultSet rsss=stmt111.executeQuery(sqlss);
		if(rsss.first())
		{
			nettotal=rsss.getDouble("nettotal");
			taxamount=rsss.getDouble("taxamount");
			nettaxamont=rsss.getDouble("nettaxamont");
		}
		
		String acctype="AR";
		String cmbcurr="1";
		String accdoc="0";
		String currate="1";
		 Statement stmt=conn.createStatement();
		 String sqls="select atype,doc_no acno,curid,rate from my_head where den=340 and cldocno='"+hidcldocno+"' ";
		 
		 
		 
			//select type,acno,curid,rate from cr_cfim where doc_no='"+masterdoc_no+"';
		ResultSet rss0101=stmt.executeQuery(sqls);
		if(rss0101.next())
		{acctype=rss0101.getString("atype");
		cmbcurr=rss0101.getString("curid");
		accdoc=rss0101.getString("acno");
		currate=rss0101.getString("rate");
		}
	
		
		
		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnipurchase.registerOutParameter(16, java.sql.Types.INTEGER);
		
		
		stmtnipurchase.setInt(18, java.sql.Types.INTEGER);
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setString(2,jobno);
		stmtnipurchase.setString(3,acctype);
		stmtnipurchase.setString(4,accdoc);
	   	stmtnipurchase.setString(5,cmbcurr);
		stmtnipurchase.setString(6,currate);
		stmtnipurchase.setString(7,"");
		stmtnipurchase.setString(8,"");
		stmtnipurchase.setString(9,"");
		stmtnipurchase.setDate(10,sqlStartDate);
		stmtnipurchase.setDouble(11,nettotal);
		stmtnipurchase.setString(12,"SRS");
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,"SRS");
		stmtnipurchase.setString(17,"A");
		stmtnipurchase.setInt(19,0);
//		System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());

		stmtnipurchase.executeQuery();
	 	int docno=stmtnipurchase.getInt("docNo");
		int mastervocno=stmtnipurchase.getInt("vocNo");
		if(docno<=0)
		{
			conn.close();
			return 0;
		}
		Statement stm2=conn.createStatement();
		double fdramt=0;
		double tdramt=0;
		int sno=0;
		String refdetails="SRS"+""+mastervocno;
		
		
		String jvdesc=refdetails;  
		int tranno=0;
		String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
	
		ResultSet tass = stm2.executeQuery (trsql);
		
		if (tass.next()) {
	
			tranno=tass.getInt("trno");		
			
	     }
		int iapprovalStatus=3;
		
		int count=0;
		String appsql="select count(*)   icount from my_apprmaster where status=3 and dtype='SRS' ";
		
		ResultSet appsqlrs = stm2.executeQuery(appsql);
		
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
		
		
		
		
		String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
		
		int dd=stm2.executeUpdate(trnosql);
	     
				 if(dd<=0)
					{
						conn.close();
						return 0;
						
					}
				 
				String sqlsss="update cr_cfid  set invtrno='"+tranno+"' where rowno in ("+rowno+") ";
				System.out.println("---sqlsss---"+sqlsss);
				stm2.executeUpdate(sqlsss);
				 
				 
					for(int i=0;i< descarray.size();i++){
						
						String[] purorderarray=descarray.get(i).split("::");
						String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
						 
						
						if(i==0){
			 
							double dramt=nettaxamont;
							double as=Double.parseDouble(currate);
							double ldramt=dramt*as;
							
							String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
							 
//						   System.out.println("client account sql ="+sql1);
							 int ss = stmtnipurchase.executeUpdate(sql1);

						     if(ss<=0)
								{
									conn.close();
									return 0;
								}
							
						   }
					

						 
				    	 
					    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
					     {
				
				    		 String sql="INSERT INTO my_srvsaled(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
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
			 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:Double.parseDouble(purorderarray[6].trim())*-1)+"',"+tdramt*-1+",0,-1,5,"+(i+1)+",0,0,0,'SRS', "
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
						    		
						
								String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
						System.out.println("==========trsqlss=========="+trsqlss);
								
								ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
								
								if (tass1.next()) {
							
									TRANID=tass1.getInt("TRANID");	
								
								
									
							     }
								
								String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
										+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
								System.out.println("==========trsqlss=========="+trsqlss);		 
						  int costabsq=  stmtnipurchase.executeUpdate(ssql);
						  
						  if(costabsq<=0)
							{
								conn.close();
								return 0;
								
							}
						  
					     }
							String updat="update  my_srvsalem set tr_no="+tranno+",invno='"+jobno+"',invdate=now()  where doc_no="+docno+"  ";
							  int tabs=  stmtnipurchase.executeUpdate(updat);
							  if(tabs<=0)
								{
									conn.close();
									return 0;
								}
					     }
				     }
					
					
					    String upsql="select method from gl_config where field_nme like'tax'";
					    ResultSet resultSet = stmt.executeQuery(upsql);
					    int docval = 0;
					    if(resultSet.next())
					    {
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
			 
						System.out.println("===docval====="+docval);
			 if(docval>0)
				 
			 {	
				 
				 
				 String newjvdesc=jvdesc;
				 Statement stmtt2=conn.createStatement();
				 double amount,dramt=0,as,ldramt = 0;
   			 long acno=0;
   			 double taxperc=0;
   			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
   			 System.out.println("===upsql1====="+upsql1);
   			 ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		    	 while(resultSet4.next()){
		    		amount=((taxamount)*-1);
   			 	dramt=amount;
	 				as=Double.parseDouble(currate);
	 				ldramt=dramt*as;
	 				acno=resultSet4.getLong("acno");
		    	 }
	 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
	 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
	 				 System.out.println("===sql1====="+sql1); 
			 	  System.out.println("===taxperc====="+taxperc); 
	 			if(taxamount>0 && acno>0){	 
	 				int ss = stmtnipurchase.executeUpdate(sql1);
//	 				 
	 			     if(ss<=0)
	 					{
	 						conn.close();
	 						return 0;
	 					}
	 			}
				 
			 }
				if (docno > 0) {
					conn.commit();
					stmtnipurchase.close();
					conn.close();
					return docno;
				}

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return 0;
}
}
