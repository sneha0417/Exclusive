package com.dashboard.realestate.tenancycontractposting;

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
import com.common.ClsVatInsert;
import com.connection.ClsConnection;

public class ClsTenancyContractPostingDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	ClsConnection ClsConnection=new ClsConnection();
 
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray accountsDetails(HttpSession session,String dtype,String accountno,String accountname,String currency,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = conobj.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		       System.out.println("====dtype======="+dtype);
	           String den= "";
	           
	            if(dtype.equalsIgnoreCase("CA")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BA")){
					den="305";
				}
				 
				
	           java.sql.Date sqlDate=null;
		       
	           if(check.equalsIgnoreCase("1")){
	        	   
	 
	            
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        	
		         
	        	sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	        	  + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	        	  + "where t.atype='GL' and t.m_s=0 and t.den='"+den+"' "+sqltest; // bank 305 cash 604
		        System.out.println("====sql======="+sql);
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=com.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	
	public   JSONArray listsearch(String branch,String fromdate,String todate,String aa) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    if(!aa.equalsIgnoreCase("yes"))
	    {
	    	return RESULTDATA;
	    }
	    
	   
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	} 

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	 
 
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stm = conn.createStatement ();     
		 
				 
				
				String sql=" select coalesce(pm.unitno,'') unitno,m.recieptstatus,m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.accname pname,"
						+ "  if(m.ttype=1,'Residence','Commercial') protype, if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period,m.nettotal totalamount  "
				+ " from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype "
				+ " left join my_acbook a on a.acno=m.acno  where m.ttype in(1,2) and m.status=3 and m.pstatus=0 and clstatus=0 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'   "+sqltest+" group by m.doc_no  ";
						
            	      System.out.println("-----------"+sql);	
            		   ResultSet resultSet = stm.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		   stm.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public  JSONArray termsloading(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();
 
			int taxmethod=0;
			String sql="select method from gl_config where field_nme='tax'";
			ResultSet rss1=stmt.executeQuery(sql);
			if(rss1.first())
			{
				taxmethod=rss1.getInt("method");
			}
			double  taxper=0;			
 
			if(taxmethod>0)
			{
				String sqls="select coalesce(t.per,0) per,a.tax,m.ttype from rl_tncm m left join my_acbook a on a.acno=m.acno "
						+ "   left join gl_taxmaster t on t.type=2 and per>0 and m.date between t.fromdate "
						+ "   and t.todate and a.tax=1 and m.ttype=2   where m.doc_no='"+docno+"' "; 
				
				ResultSet rss=stmt.executeQuery(sqls);
				if(rss.first())
				{
					taxper=rss.getDouble("per");					 
				}
			}
			
			String salsql="select h.atype,1 qty,convert(if(d.taxvalue>0.0,5.0,0),char(100)) vatper,round(d.taxvalue,2) vatvalue,"+
			" round(d.nettotal,2) total,  m.idno docno, m.description,convert(m.acno,char(100)) acno,"+
			" round(case when d.taxtype='Inclusive' then d.amount-d.taxvalue else d.amount end,2) amount,101 ftype from rl_tncterms d"+
			" left join rl_terms_contract m on d.idno=m.idno left join  my_head h on h.doc_no=m.acno where d.rdocno="+docno+""+
			" union all"+
			" select h.atype,1 qty,convert(if(m.commissionvatvalue>0.0,5.0,0),char(100)) vatper,round(m.commissionvatvalue,2) vatvalue,"+
			" round(case when m.commissionvattype='Inclusive' then m.commisionamt else m.commisionamt+m.commissionvatvalue end,2) total,"+
			" 9 docno,'Commission',convert(h.doc_no,char(100)) acno, round(case when m.commissionvattype='Inclusive' then m.commisionamt-m.commissionvatvalue else"+
			" m.commisionamt end,2) amount,101 ftype from rl_tncm m left join my_head h on (h.doc_no=(select acno from my_account where codeno='COMMISSION ACCOUNT')) where m.doc_no="+docno;
		 
/*			" union all"+
			" select h.atype,0 qty,0 vatper,0 vatvalue, camount total,"+
			" m.sal_id docno, concat(d.sal_name, ' Agent' ) description,convert(d.acc_no,char(100)) acno,camount amount,102 ftype from"+
			" rl_tncagent m left join my_salesman d on (d.doc_no=m.sal_id and d.sal_type='SLA')  left join my_head h on h.doc_no=d.acc_no where m.rdocno="+docno+" and (cper>0 or camount>0)"*/
			System.out.println("-------Tenancy Contract------"+salsql);
			ResultSet resultSet = stmt.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		 
		return RESULTDATA;
	}
	
	
	public  JSONArray agentloading(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement ();  

			String salsql="select   d.sal_name agent,m.sal_id salid,cper commperc,camount commamount from rl_tncagent m left join my_salesman d on (d.doc_no=m.sal_id and d.sal_type='SLA')  where m.rdocno='"+docno+"' ";
			System.out.println("-------salsql------"+salsql);
			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		 
		return RESULTDATA;
	}
	
	
	public  JSONArray paymentloading(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(docno.equalsIgnoreCase("0") || docno.equalsIgnoreCase("")){
			return RESULTDATA;
		}

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement ();    
			/*refno=0 and*/  
			String salsql="select  doc_no, rdocno, slno, desc1 description, date, pamount amount, notes , replace(if(coalesce(chqno,0)='',0,chqno),',',' ') chqno, paidto, payment paymentmethod, bank  bankaccount,recieptno from rl_tncpayment where rdocno='"+docno+"'  ";
				    
		System.out.println("-------salsql------"+salsql);

			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close(); 
		}
		 
		return RESULTDATA;
	}

	  public int insert(Connection conn,Date cashReceiptDate,String formdetailcode,String txtrefno,double txtfromrate,String txtdescription, double txtdrtotal,double txtapplyinvoiceapply,
			  ArrayList<String> cashreceiptarray,ArrayList<String> applyinvoicearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtCRV = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCRV.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtCRV.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtCRV.setDate(1,cashReceiptDate);
			stmtCRV.setString(2,txtrefno);
			stmtCRV.setString(3,txtdescription);
			stmtCRV.setDouble(4,txtdrtotal);
			stmtCRV.setDouble(5,txtfromrate);
			stmtCRV.setString(6,formdetailcode);
			stmtCRV.setString(7,company);
			stmtCRV.setString(8,branch);
			stmtCRV.setString(9,userid);
			stmtCRV.setString(12,mode);
			int datas=stmtCRV.executeUpdate();
			if(datas<=0){
				stmtCRV.close();
				System.out.println("Tenancy Contract CRV Master Insert Error ");
				conn.close();
				return 0;
			}
			int docno=stmtCRV.getInt("docNo");
			int trno=stmtCRV.getInt("itranNo");
			request.setAttribute("tranno1", trno);
			 
			if (docno > 0) {
				
				System.out.println("cashre arry = "+ cashreceiptarray);
					/*Insertion to my_cashbd,my_jvtran,my_outd*/
			int insertData=insertion(conn, docno, trno, formdetailcode, cashReceiptDate, txtrefno, txtfromrate, txtdescription, txtdrtotal, txtapplyinvoiceapply, cashreceiptarray, applyinvoicearray, session,mode);
			if(insertData<=0){
				stmtCRV.close();
				System.out.println("Tenancy Contract CRV Detail Insert Error ");
				conn.close();
				return 0;
			}
			/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
			String strcheckamt="select dramount,ldramount from my_jvtran where tr_no="+trno;
			ResultSet rscheckamt=stmtCRV.executeQuery(strcheckamt);
			while(rscheckamt.next()){
				System.out.println("CRV JV Amt:"+rscheckamt.getDouble("dramount")+"::"+rscheckamt.getDouble("ldramount"));
			}
			String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
			ResultSet resultSet = stmtCRV.executeQuery(sql1);
			 while (resultSet.next()) {
			 total=resultSet.getInt("jvtotal");
			 }

			 if(total == 0){
				 
				stmtCRV.close();
				 
				return docno;
			 }else{
		        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
			    stmtCRV.close();
			    return 0;
		    }
			}
			stmtCRV.close();
			 
	 }catch(Exception e){
		 	e.printStackTrace();
		 	System.out.println("Tenancy Contract CRV Error ");
		 	conn.close();
		 	return 0;
	 }finally{
			 
		}
		return 0;
	}
			
	  public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date cashReceiptDate, String txtrefno, double txtfromrate, 
				 String txtdescription, double txtdrtotal, double txtapplyinvoiceapply,ArrayList<String> cashreceiptarray,ArrayList<String> applyinvoicearray,
				 HttpSession session,String mode) throws SQLException{

			  try{
					 
					CallableStatement stmtCRV;
					Statement stmtCRV1 = conn.createStatement();

					String branch=session.getAttribute("BRANCHID").toString().trim();
					String userid=session.getAttribute("USERID").toString().trim();
					
					/*Cash Receipt Grid and Details Saving*/
					for(int i=0;i< cashreceiptarray.size();i++){
						String[] cashreceipt=cashreceiptarray.get(i).split("::");
						if(!cashreceipt[0].trim().equalsIgnoreCase("undefined") && !cashreceipt[0].trim().equalsIgnoreCase("NaN")){
						
						int cash = 0;
						int id = 0;
						if(cashreceipt[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=-1;
						}
						else if(cashreceipt[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=1;
						}
						
						stmtCRV = conn.prepareCall("{CALL cashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cashbd*/
						stmtCRV.setInt(19,trno); 
						stmtCRV.setInt(20,docno);
						stmtCRV.registerOutParameter(21, java.sql.Types.INTEGER);
						stmtCRV.setInt(1,i); //SR_NO
						stmtCRV.setString(2,(cashreceipt[0].trim().equalsIgnoreCase("undefined") || cashreceipt[0].trim().equalsIgnoreCase("NaN") || cashreceipt[0].trim().isEmpty()?0:cashreceipt[0].trim()).toString());  //doc_no of my_head
						stmtCRV.setString(3,(cashreceipt[1].trim().equalsIgnoreCase("undefined") || cashreceipt[1].trim().equalsIgnoreCase("NaN") || cashreceipt[1].trim().isEmpty()?0:cashreceipt[1].trim()).toString()); //curId
						stmtCRV.setString(4,(cashreceipt[2].trim().equalsIgnoreCase("undefined") || cashreceipt[2].trim().equalsIgnoreCase("NaN") || cashreceipt[2].trim().equals(0) || cashreceipt[2].trim().isEmpty()?1:cashreceipt[2].trim()).toString()); //rate 
						stmtCRV.setInt(5,id); //#credit -1 / debit 1 
						stmtCRV.setString(6,(cashreceipt[4].trim().equalsIgnoreCase("undefined") || cashreceipt[4].trim().equalsIgnoreCase("NaN") || cashreceipt[4].trim().isEmpty()?0:cashreceipt[4].trim()).toString()); //amount
						stmtCRV.setString(7,(cashreceipt[5].trim().equalsIgnoreCase("undefined") || cashreceipt[5].trim().equalsIgnoreCase("NaN") || cashreceipt[5].trim().isEmpty()?0:cashreceipt[5].trim()).toString()); //description
						stmtCRV.setString(8,(cashreceipt[6].trim().equalsIgnoreCase("undefined") || cashreceipt[6].trim().equalsIgnoreCase("NaN") || cashreceipt[6].trim().isEmpty()?0:cashreceipt[6].trim()).toString()); //baseamount
						stmtCRV.setInt(9,cash); //For cash = 0/ party = 1
						stmtCRV.setString(10,(cashreceipt[8].trim().equalsIgnoreCase("undefined") || cashreceipt[8].trim().equalsIgnoreCase("NaN") || cashreceipt[8].trim().equalsIgnoreCase("") || cashreceipt[8].trim().equalsIgnoreCase("0") || cashreceipt[8].trim().isEmpty()?"0":cashreceipt[8].trim()).toString()); //Cost type
						stmtCRV.setString(11,(cashreceipt[9].trim().equalsIgnoreCase("undefined") || cashreceipt[9].trim().equalsIgnoreCase("NaN") || cashreceipt[9].trim().equalsIgnoreCase("") || cashreceipt[9].trim().equalsIgnoreCase("0")|| cashreceipt[9].trim().isEmpty()?"0":cashreceipt[9].trim()).toString()); //Cost Code
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtCRV.setDate(12,cashReceiptDate);
						stmtCRV.setString(13,txtrefno);
						stmtCRV.setInt(14,id);  //id
						stmtCRV.setString(15,(cashreceipt[7].trim().equalsIgnoreCase("undefined") || cashreceipt[7].trim().equalsIgnoreCase("NaN") || cashreceipt[7].trim().isEmpty()?0:cashreceipt[7].trim()).toString());  //out-amount
						/*my_jvtran Ends*/
						
						stmtCRV.setString(16,formdetailcode);
						stmtCRV.setString(17,branch);
						stmtCRV.setString(18,userid);
						stmtCRV.setString(22,mode);
						int detail=stmtCRV.executeUpdate();
							if(detail<=0){
								stmtCRV.close();
								conn.close();
								return 0;
							}
		  				  }
					    }
					    /*Cash Receipt Grid and Details Saving Ends*/
					
						/*Apply-Invoicing Grid Saving*/
						for(int i=0;i< applyinvoicearray.size();i++){
						String[] apply=applyinvoicearray.get(i).split("::");
						if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN")){
						
						stmtCRV = conn.prepareCall("{CALL applyInvoicingDML(?,?,?,?,?,?,?)}");
						/*Insertion to my_outd*/
						stmtCRV.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
						stmtCRV.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
						stmtCRV.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
						stmtCRV.setInt(4,trno);  //tr_no
						stmtCRV.setInt(5,Integer.parseInt((apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString())); //tranid
						stmtCRV.setInt(6,Integer.parseInt((apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString())); //account
						stmtCRV.setString(7,mode);	
						/*Apply-Invoicing Grid Saving Ends*/
						int applyreceiptcheck=stmtCRV.executeUpdate();
							if(applyreceiptcheck<=0){
								stmtCRV.close();
								return 0;
							}
							stmtCRV.close();
						 }
					}	
					
						int trid=0,id = 0;
						/*Selecting Tran-Id & Id*/
						String sqls=("select j.TRANID,j.ID from my_jvtran j inner join my_cashbd d on (d.acno =j.acno and d.tr_no =j.tr_no and d.sr_no=1) where j.tr_no="+trno);
						ResultSet resultSets = stmtCRV1.executeQuery(sqls);
						    
						 while (resultSets.next()) {
							 trid=resultSets.getInt("TRANID");
						     id=resultSets.getInt("ID");
						 }
						 /*Selecting Tran-Id & Id Ends*/
						
						/*Updating my_jvtran*/
						String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
						int data3 = stmtCRV1.executeUpdate(sql3);
						if(data3<=0){
							stmtCRV1.close();
							conn.close();
							return 0;
						}
						/*Updating my_jvtran Ends*/
						
						/*Deleting account of value zero*/
						String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
					    int data = stmtCRV1.executeUpdate(sql2);
					     
					    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
					    int data1 = stmtCRV1.executeUpdate(sql4);
					     /*Deleting account of value zero ends*/
						
		   }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 }
			return 1;
		}

	  public int insertjv(Connection conn,Date journalVouchersDate, String formdetailcode1, String txtrefno, String txtdescription, double txtdrtotal, double txtcrtotal,
				ArrayList<String> journalvouchersarray, HttpSession session,HttpServletRequest request) throws SQLException {
			
		 
			
			try{
				 

				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString();
				String company=session.getAttribute("COMPANYID").toString();
				int total = 0;String formdetailcode ="",referenceId="";
				
				if(formdetailcode1.contains("-")){
					String[] parts = formdetailcode1.split("-");
					formdetailcode = parts[0]; 
					referenceId = parts[1];
				}else{
					formdetailcode=formdetailcode1;
					referenceId="0";
				}
				
				if(txtdrtotal<0){
					txtdrtotal=txtdrtotal*-1;
				}
				
				if(txtcrtotal<0){
					txtcrtotal=txtcrtotal*-1;
				}
				
				CallableStatement stmtJVT = conn.prepareCall("{CALL jvmaDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtJVT.registerOutParameter(11, java.sql.Types.INTEGER);
				stmtJVT.registerOutParameter(12, java.sql.Types.INTEGER);
				
				stmtJVT.setDate(1,journalVouchersDate); //Date
				stmtJVT.setString(2,txtrefno); //Ref No
				stmtJVT.setString(3,txtdescription); //Description
				stmtJVT.setDouble(4,txtdrtotal); //Dr Total
				stmtJVT.setDouble(5,txtcrtotal); //Cr Total
				stmtJVT.setString(6,formdetailcode);
				stmtJVT.setString(7,company);
				stmtJVT.setString(8,branch);
				stmtJVT.setString(9,userid);
				stmtJVT.setString(10,referenceId);//Distinguishing Reference Id
				stmtJVT.setString(13,"A");
				int datas=stmtJVT.executeUpdate();
				if(datas<=0){
					System.out.println("Tenancy Contract JVT Master Insert Error ");
					stmtJVT.close();
					conn.close();
					return 0;
				}
				int docno=stmtJVT.getInt("docNo");
				int trno=stmtJVT.getInt("itranNo");
				request.setAttribute("tranno2", trno);
			 
				if (docno > 0) {

					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journalvoucher=journalvouchersarray.get(i).split("::");
					
					 if(!journalvoucher[0].equalsIgnoreCase("undefined") && !journalvoucher[0].equalsIgnoreCase("NaN")){
					 int icldocno=0,ilapply=0,trid=0,count=0,approvalStatus=0;
					 
					 String sql=("select cldocno,lapply from my_head where doc_no="+(journalvoucher[0].equalsIgnoreCase("undefined") || journalvoucher[0].isEmpty()?0:journalvoucher[0]));
					 ResultSet resultSet = stmtJVT.executeQuery(sql);
					 
					 while (resultSet.next()) {
					 icldocno=resultSet.getInt("cldocno");
					 ilapply=resultSet.getInt("lapply");
					 }
					
					String sqls="select count(*) as icount from my_apprmaster where status=3 and dtype='"+formdetailcode+"'";
					 ResultSet resultSets = stmtJVT.executeQuery(sqls);
					 
					 while (resultSets.next()) {
						 count=resultSets.getInt("icount");
					 }
					 
					 if(count==0){
						 approvalStatus=3;
					 } else if(count>0 && referenceId.equalsIgnoreCase("1")) {
						 approvalStatus=0;
					 } else if(count>0 && !(referenceId.equalsIgnoreCase("1"))) {
						 approvalStatus=3;
					 }
					 
					String sql2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
							+ "dTYPE,brhId,tr_no,STATUS)VALUES('"+journalVouchersDate+"','"+txtrefno+"','"+docno+"',"
							+ "'"+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+"',"
							+ "'"+(journalvoucher[1].trim().equalsIgnoreCase("undefined") || journalvoucher[1].trim().equalsIgnoreCase("NaN") || journalvoucher[1].trim().isEmpty()?0:journalvoucher[1].trim())+"',"
							+ "'"+(journalvoucher[2].trim().equalsIgnoreCase("undefined") || journalvoucher[2].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().isEmpty()?0:journalvoucher[2].trim())+"',"
						    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().equals(0) || journalvoucher[3].trim().isEmpty()?1:journalvoucher[3].trim()).toString()+"',"
						    + "'"+(journalvoucher[4].trim().equalsIgnoreCase("undefined") || journalvoucher[4].trim().equalsIgnoreCase("NaN") || journalvoucher[4].trim().isEmpty()?0:journalvoucher[4].trim())+"',"
						    + "'"+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+"',0,"
						    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
						    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[3].trim().isEmpty()?0:journalvoucher[3].trim())+"',"
						    + "'"+(journalvoucher[7].trim().equalsIgnoreCase("undefined") || journalvoucher[7].trim().equalsIgnoreCase("NaN") || journalvoucher[7].trim().isEmpty()?0:journalvoucher[7].trim())+"',"
						    + "'"+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+"',"
						    + "'"+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().equalsIgnoreCase("") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+"',"
						    + "'"+formdetailcode+"','"+branch+"','"+trno+"',"+approvalStatus+")";
					int data = stmtJVT.executeUpdate(sql2);
					if(data<=0){
						stmtJVT.close();
						conn.close();
						return 0;
					}
					
					 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim());
					 ResultSet resultSet2 = stmtJVT.executeQuery(sql3);
					    
					 while (resultSet2.next()) {
					 trid = resultSet2.getInt("TRANID");
					 }
					
					 if(!journalvoucher[8].equalsIgnoreCase("undefined") && !journalvoucher[8].trim().equalsIgnoreCase("")){
					 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+","
					 		+ ""+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+","
					 	    + ""+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+","+(i+1)+","
					 	    + ""+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+","+trid+","+trno+")";
					 
					 int data2 = stmtJVT.executeUpdate(sql4);
					 if(data2<=0){
						    stmtJVT.close();
							conn.close();
							return 0;
						  }
					 	}
					 }
				}
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtJVT.executeQuery(sql1);
				    
					 while (resultSet.next()) {
						 total=resultSet.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						 
						stmtJVT.close();
						 
						return docno;
					 }else{
					        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
						    stmtJVT.close();
						    return 0;
					    }
				}
				
				 
				 
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 } 
			return 0;
		}
	  
	  
	  
	  public int insert(Connection conn,Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
				String accdoc, String puraccname, String cmbcurr, String currate,
				String delterms, String payterms, String purdesc,
				HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
				HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc) throws SQLException {
			try{
				int docno;
				
				 
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

				CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
//				System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
		 
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
//				System.out.println(docval);
				 /*if(docval>0){
					 Statement stmt21 = conn.createStatement ();
					 Statement stmtt=conn.createStatement();
					 Statement stmtt2=conn.createStatement();
					
				    		 if(intrstate>0){
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				    			 double amount=((nettotal*resultSet3.getDouble("cstper"))/100);
				    			 masteramount=(masteramount+amount);
				    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+amount+")";
				    			stmtt.executeUpdate(sql);
				    		 }
				 		    	 }
				    		 else{
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
				    			 double amount=((nettotal*resultSet4.getDouble("per"))/100);
				    			 masteramount=(masteramount+amount);
					    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+amount+")";
					    			stmtt.executeUpdate(sql);
				    		 }
						       }
				    	
				    }*/
				String refdetails="SRS"+""+vocno;
				
				
				String jvdesc="SRS-"+""+invno+""+":-Dated :- "+indateval+"";  
				
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
					
//					System.out.println("==nettax==="+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim()));
					
					nettaxtot+=Double.parseDouble(nettax);
					
					if(i==descarray.size()-1){
//					System.out.println("==nettaxtot==="+nettaxtot);
						double dramt=nettotal+nettaxtot;
						double as=Double.parseDouble(currate);
						double ldramt=dramt*as;
						
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
						 
		 		   System.out.println("client account sql ="+sql1);
						 int ss = stmtnipurchase.executeUpdate(sql1);

					     if(ss<=0)
							{
								conn.close();
								return 0;
							}
						
					}
				
					double taxper,tax,nettaxamount;
					Statement stmt21=conn.createStatement();
					String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
					ResultSet resultSet3 = stmt21.executeQuery(sqltax);
			    	 while(resultSet3.next()){
			    		 taxper=resultSet3.getDouble("per");
			    		 tax=((nettotal*resultSet3.getDouble("per"))/100);
			    		 nettaxamount=nettotal+tax;
			    	 }
			    	 
			    	 
					 
			    	 Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+"")); 
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
			    	  System.out.println("__saled--"+sql);
			    		 int resultSet2 = stmtnipurchase.executeUpdate(sql);
					     
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
					     int acno=Integer.parseInt(acno1);
					     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					   
					     System.out.println("other account tmp ="+tmp);	
					     
					     fdramt=Double.parseDouble(tmp)*1;
					     tdramt=fdramt*Double.parseDouble(currate);
					     System.out.println("other account currate ="+currate);	
					    
					     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
		 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:Double.parseDouble(purorderarray[6].trim())*-1)+"',"+tdramt*-1+",0,-1,5,"+(i+1)+",0,0,0,'SRS', "
						+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
						+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
						     
					  System.out.println("other account sql ="+don);	
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
									+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
									 
					  int costabsq=  stmtnipurchase.executeUpdate(ssql);
					  
					  if(costabsq<=0)
						{
							conn.close();
							return 0;
							
						}
					  
				     }
						String updat="update  my_srvsalem set tr_no="+tranno+",invno='"+invno+"',invdate='"+sqlinvdate+"' where doc_no="+docno+"  ";
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
				    		 if(intrstate>0){
				    			 double amount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				 		    		amount=((nettaxtot)*-1);
				    			 	dramt=amount;
					 				as=Double.parseDouble(currate);
					 				ldramt=dramt*as;
					 				acno=resultSet3.getLong("acno");
				 		    	 }
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 				 
				 			//	System.out.println(sql1);
				 				if(taxperc>0){
				 				 int ss = stmtnipurchase.executeUpdate(sql1);

				 			     if(ss<=0)
				 					{
				 						conn.close();
				 						return 0;
				 						
				 					}
				 				}
				 		    	 }
				    		 else{
				    			 double amount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
				 		    		amount=((nettaxtot)*-1);
				    			 	dramt=amount;
					 				as=Double.parseDouble(currate);
					 				ldramt=dramt*as;
					 				acno=resultSet4.getLong("acno");
				 		    	 }
					 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					 				 
		 	 			System.out.println("--sql1jvtran--"+sql1);
					 			if(taxperc>0){	 
					 				int ss = stmtnipurchase.executeUpdate(sql1);
//					 				System.out.println("+sql1 status++--"+ss);
					 			     if(ss<=0)
					 					{
					 						conn.close();
					 						return 0;
					 						
					 					}
					 			}			    		
						       }
				    	
				    }
				

				String sqlss="update my_jvtran set id=1 where dramount>0 and tr_no='"+tranno+"' " ;
				stmtnipurchase.executeUpdate(sqlss);
				String sqlss1="update my_jvtran set id=-1 where dramount<0 and tr_no='"+tranno+"' " ;
				stmtnipurchase.executeUpdate(sqlss1);
				
				    
			if (docno > 0) {
				 
				stmtnipurchase.close();
				 
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
		}


		public int insertPropertyInvoice(Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
				String accdoc, String puraccname, String cmbcurr, String currate,
				String delterms, String payterms, String purdesc,
				HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
				HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc, String billingname, 
				String billingtrn,ArrayList<String> agentarray,int manual,java.sql.Connection conn,String property, String owner, Date sqlcontractfromdate, Date sqlcontracttodate, String rentsalevalue) throws SQLException {
			try{
				int docno;
				
				Statement stmt = conn.createStatement ();
				int cldocno=0;
				String strgetcldocno="select coalesce(ac.cldocno,0) cldocno from my_head head left join my_acbook ac on (head.doc_no=ac.acno) where head.doc_no="+accdoc;
				ResultSet rsgetcldocno=stmt.executeQuery(strgetcldocno);
				while(rsgetcldocno.next()){
					cldocno=rsgetcldocno.getInt("cldocno");
				}
				int owneracno=0;
				String strgetowneracno="select ownerhead.doc_no owneracno from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner own on own.doc_no=pm.owid left join my_head ownerhead on "+
				" pm.acno=ownerhead.doc_no left join my_acbook ac on (ownerhead.doc_no=ac.acno) left join my_acbook tn on (m.cldocno=tn.cldocno and tn.dtype='CRM') where m.status=3 and m.doc_no="+refno;
				ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
				while(rsgetowneracno.next()){
					owneracno=rsgetowneracno.getInt("owneracno");
				}
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
				
				CallableStatement stmtnipurchase= conn.prepareCall("{call propertyInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
//				System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
		 
				stmtnipurchase.executeQuery();
				docno=stmtnipurchase.getInt("docNo");
				int vocno=stmtnipurchase.getInt("vocNo");
				int intrstate=stmtnipurchase.getInt("vinterstate");
				request.setAttribute("vocno", vocno);
				if(docno<=0)
				{
					System.out.println("Master Invoice Insert Error");
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
				if(rentsalevalue.trim().equalsIgnoreCase("") || rentsalevalue==null || rentsalevalue.equalsIgnoreCase("undefined")){
					rentsalevalue="0";
				}
				if(docno>0){
					String strupdate="update rl_prinvm set property='"+property+"',owner='"+owner+"',fromdate='"+sqlcontractfromdate+"',todate='"+sqlcontracttodate+"',rentsalevalue="+rentsalevalue+",billingname='"+billingname+"',billingtrn='"+billingtrn+"',manual="+manual+" where doc_no="+docno;
					int update=stmt.executeUpdate(strupdate);
					if(update<=0){
						return 0;
					}
				}
//				System.out.println(docval);
				 /*if(docval>0){
					 Statement stmt21 = conn.createStatement ();
					 Statement stmtt=conn.createStatement();
					 Statement stmtt2=conn.createStatement();
					
				    		 if(intrstate>0){
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				    			 double amount=((nettotal*resultSet3.getDouble("cstper"))/100);
				    			 masteramount=(masteramount+amount);
				    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+amount+")";
				    			stmtt.executeUpdate(sql);
				    		 }
				 		    	 }
				    		 else{
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
				    			 double amount=((nettotal*resultSet4.getDouble("per"))/100);
				    			 masteramount=(masteramount+amount);
					    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+amount+")";
					    			stmtt.executeUpdate(sql);
				    		 }
						       }
				    	
				    }*/
				String refdetails="PRIV"+""+vocno;
				
				System.out.println("==================+"+refno);
				
				String jvdesc="";
				
				 
				int jvm=0;
				Statement sstst=conn.createStatement();
				ResultSet rsssss= sstst.executeQuery("SELECT method FROM GL_PRDCONFIG where field_nme='jvdescpass'") ;
				if(rsssss.first())
				{
					jvm=rsssss.getInt("method");			}

			 
				if(jvm==1)
				{
					jvdesc="Ref No-"+invno+" "+purdesc;
				}
				else
				{
					jvdesc="Ref-"+refno+"-"+invno+" "+purdesc;
				}
				
				
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
				
				request.setAttribute("PRIVTRNO",tranno);
				String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
				int dd=stmtnipurchase.executeUpdate(trnosql);
						 if(dd<=0)
							{
							 System.out.println("TRNO Insert Error");
								conn.close();
								return 0;
							}
						 double nettaxtot = 0;
						 
				double grandtotal=0.0;
				double agentamount=0.0;
				double gridtotal=0.0;//Net Total
				double distributedamt=0.0;
				for(int i=0;i<agentarray.size();i++){
					String agentdocno=agentarray.get(i).split("::")[0].trim();
					String stragentdetails="select head.curid,head.rate,head.doc_no,sal.sal_name from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no ) where sal.sal_type='SLA' and sal.doc_no="+agentdocno;
					double agentrate=0.0;
					int agentcurid=0,agentacno=0;
					String agentname="";
					ResultSet rsagentdetails=stmt.executeQuery(stragentdetails);
					while(rsagentdetails.next()){
						agentrate=rsagentdetails.getDouble("rate");
						agentcurid=rsagentdetails.getInt("curid");
						agentacno=rsagentdetails.getInt("doc_no");
						agentname=rsagentdetails.getString("sal_name");
					}
					double agentpercent=Double.parseDouble(agentarray.get(i).split("::")[1].trim());
					agentpercent=com.Round(agentpercent, 2);
					double dramount=Double.parseDouble(agentarray.get(i).split("::")[2].trim());
					dramount=com.Round(dramount, 2);
					agentamount+=dramount;
					double ldramount=dramount*agentrate;
					ldramount=com.Round(ldramount, 2);
					String note="Agent Commission of "+agentname+" for INV #"+vocno;
					/*String strinsertagentjv="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
					" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
					" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentacno+"','"+note+"','"+agentcurid+"','"+agentrate+"',"+dramount+"*-1,"+
					" "+ldramount+"*-1,0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					int insertagentjv=stmt.executeUpdate(strinsertagentjv);
					if(insertagentjv<=0){
						return 0;
					}*/
					String strinsertagent="insert into rl_prinvagent(rdocno,sal_id,commpercent,commvalue,status)values("+docno+","+agentdocno+","+agentpercent+","+dramount+",3)";
					int insertagent=stmt.executeUpdate(strinsertagent);
					if(insertagent<=0){
						System.out.println("Agent Insert Error");
						conn.close();
						return 0;
					}
				}
				for(int i=0;i<descarray.size();i++){
					String temp[]=descarray.get(i).split("::");
					grandtotal+=Double.parseDouble(temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN")||temp[9].trim().equalsIgnoreCase("")|| temp[9].isEmpty()?"0":temp[9].trim());
					gridtotal+=Double.parseDouble(temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN")||temp[6].trim().equalsIgnoreCase("")|| temp[6].isEmpty()?"0":temp[6].trim());
				}
				System.out.println("Grid Total:"+gridtotal);
				System.out.println("Agent Amount:"+agentamount);
				System.out.println("Account size:");
				//distributedamt=(gridtotal-agentamount)/(descarray.size()-1);
				for(int i=0;i< descarray.size();i++){
					System.out.println("Array Recieved:"+descarray.get(i));
					String[] purorderarray=descarray.get(i).split("::");
					String newjvdesc=jvdesc;
					String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
					nettaxtot+=Double.parseDouble(nettax);
					if(owneracno==Integer.parseInt(accdoc)){
						String clientamt=purorderarray[9].trim();
						String clientjvdesc=purorderarray[13].trim();
						clientamt=(com.Round(Double.parseDouble(clientamt),2))+"";
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+clientjvdesc+"','"+cmbcurr+"','"+currate+"',"+clientamt+","+Double.parseDouble(clientamt)*Double.parseDouble(currate)+",0,1,5,0,0,"+cldocno+",0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
						 
					   System.out.println("client account sql ="+sql1);
						 int ss = stmtnipurchase.executeUpdate(sql1);

					     if(ss<=0)
							{
					    	 System.out.println("Client JV Insert Error");	
					    	 conn.close();
								return 0;
							}
					}
					else{
						if(i==descarray.size()-1){
							double dramt=nettotal;
							double as=Double.parseDouble(currate);
							double ldramt=dramt*as;
							//jvdesc
							dramt=com.Round(dramt, 2);
							ldramt=com.Round(ldramt, 2);
							String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+purdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,"+cldocno+",0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
							 
//						   System.out.println("client account sql ="+sql1);
							 int ss = stmtnipurchase.executeUpdate(sql1);

						     if(ss<=0)
								{
						    	 System.out.println("Client JV Insert Error");	
						    	 conn.close();
									return 0;
								}
							
						}
					}
					
				
					double taxper,tax,nettaxamount;
					Statement stmt21=conn.createStatement();
					String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
					ResultSet resultSet3 = stmt21.executeQuery(sqltax);
			    	 while(resultSet3.next()){
			    		 taxper=resultSet3.getDouble("per");
			    		 tax=((nettotal*resultSet3.getDouble("per"))/100);
			    		 nettaxamount=nettotal+tax;
			    	 }
			    	 
			    	 
					 
			    	 Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+"")); 
				    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
				     {
			
			    		 String sql="INSERT INTO rl_prinvd(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
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
					    	 System.out.println("detail Invoice Insert Error");
								conn.close();
								return 0;
								
							}
					     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
					     int acno=Integer.parseInt(acno1);
					     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					     fdramt=Double.parseDouble(tmp)*1;
					     tdramt=fdramt*Double.parseDouble(currate);
					     int jvid=(fdramt*-1)<0?-1:1;
					     fdramt=com.Round(fdramt, 2);
					     tdramt=com.Round(tdramt, 2);
					     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
		 				+ "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"', "+ "'"+cmbcurr+"','"+currate+"','"+(fdramt*-1)+"',"+(tdramt)*-1+",0,"+jvid+",5,"+(i+1)+",0,0,0,'PRIV', "
						+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
						+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
						     
					   //  System.out.println("other account sql ="+don);	
					int samp=stmtnipurchase.executeUpdate(don);

					     
					 if(samp<=0)
						{
						 System.out.println("Other JV Insert Error");
							conn.close();
							return 0;
							
						}
							//}
					      
					 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
				     {
						 int TRANID=0;
						 sno=sno+1;
						  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
						  double  fdramt1=Double.parseDouble(tmp1)*-1;
						  fdramt1=com.Round(fdramt1, 2);
					
							String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
					
							ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
							
							if (tass1.next()) {
						
								TRANID=tass1.getInt("TRANID");	
							
							
								
						     }
							
							String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
									+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
									 
					  int costabsq=  stmtnipurchase.executeUpdate(ssql);
					  
					  if(costabsq<=0)
						{
						  System.out.println("Costtran Insert Error");
							conn.close();
							return 0;
							
						}
					  
				     }
						String updat="update  rl_prinvm set tr_no="+tranno+" where doc_no="+docno+"  ";
						  int tabs=  stmtnipurchase.executeUpdate(updat);
						  if(tabs<=0)
							{
							  System.out.println("Master Invoice Update Error");
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
				    			 double amount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				 		    		amount=((nettaxtot)*-1);
				    			 	dramt=amount;
					 				as=Double.parseDouble(currate);
					 				ldramt=dramt*as;
					 				acno=resultSet3.getLong("acno");
				 		    	 }
				 		    	 dramt=com.Round(dramt, 2);
				 		    	 ldramt=com.Round(ldramt, 2);
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 				 
				 			//	System.out.println(sql1);
				 				if(taxperc>0){
				 				 int ss = stmtnipurchase.executeUpdate(sql1);

				 			     if(ss<=0)
				 					{
				 			    	System.out.println("Tax JV Insert Error");
				 						conn.close();
				 						return 0;
				 						
				 					}
				 				}
				 		    	 }
				    		 else{
				    			 double amount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
				 		    		amount=((nettaxtot)*-1);
				    			 	dramt=amount;
					 				as=Double.parseDouble(currate);
					 				ldramt=dramt*as;
					 				acno=resultSet4.getLong("acno");
				 		    	 }
				 		    	 dramt=com.Round(dramt, 2);
				 		    	 ldramt=com.Round(ldramt, 2);
					 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					 				 
//					 			System.out.println("--sql1jvtran--"+sql1);
					 			if(taxperc>0){	 
					 				int ss = stmtnipurchase.executeUpdate(sql1);
//					 				System.out.println("+sql1 status++--"+ss);
					 			     if(ss<=0)
					 					{
					 			    	System.out.println("TAX Jv Insert Error");	
					 			    	 conn.close();
					 						return 0;
					 						
					 					}
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
							 +"  from rl_prinvd d where rdocno="+docno+" ) a" ;
					

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
								System.out.println("VAT  Insert Error");
								conn.close();
								return 0;
								}
				       

			if(docno>0){
				String strupdatejv="update my_jvtran set rdocno="+refno+",rtype='TNC' where tr_no="+tranno;
				int updatejv=stmt.executeUpdate(strupdatejv);
				if(updatejv<=0){
					return 0;
				}
				String strjvcheck="select jv.dramount,jv.acno,head.description from my_jvtran jv left join my_head head on (jv.acno=head.doc_no) where jv.tr_no="+tranno;
				ResultSet rsjvcheck=stmt.executeQuery(strjvcheck);
				while(rsjvcheck.next()){
					System.out.println("JV Amt Check:"+rsjvcheck.getInt("acno")+"///"+rsjvcheck.getDouble("dramount")+"///"+rsjvcheck.getString("description"));
				}
				String strjvtally="select round(sum(dramount),2) amt from my_jvtran where tr_no="+tranno;
				ResultSet rsjvtally=stmt.executeQuery(strjvtally);
				while(rsjvtally.next()){
					if(rsjvtally.getDouble("amt")!=0.0){
						System.out.println("JV Amount Not Tallying");
						conn.close();
						return 0;
					}
				}
			}
				    
			if (docno > 0) {
			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
					stmtnipurchase.executeUpdate(sqlss10);
				return docno;
			}
		}
		catch(Exception e){	
			System.out.println("CAtch Error");
			conn.close();
			e.printStackTrace();
			return 0;
		}
		finally{
		}
		return 0;
		}
}
