package com.realestate.propertyinvoice;

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
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.common.ClsVatInsert;
import com.connection.ClsConnection;
import com.finance.transactions.cashpayment.ClsCashPaymentBean;
import com.project.execution.ServiceSale.ClsServiceSaleBean;

public class ClsPropertyInvoiceDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsPropertyInvoiceBean pintbean= new ClsPropertyInvoiceBean();
	public JSONArray SalesgentSearch(String id) throws SQLException {
        JSONArray data = new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
            Statement stmt= conn.createStatement();
            String salsql = "select doc_no,sal_name  from my_salesman where sal_type='SLA' and status<>7 ;";
            ResultSet resultSet = stmt.executeQuery(salsql);
            data = objcommon.convertToJSON(resultSet);
            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return data;
    }
	public JSONArray getAgent(String docno,String id) throws SQLException {
        JSONArray data = new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn = null;
        try {
            conn =objconn.getMyConnection();
            Statement stmt = conn.createStatement();
            String salsql = "select agent.rdocno,agent.sal_id salid,agent.commpercent commperc,agent.commvalue commamount,sal.sal_name agent from rl_prinvagent agent left join my_salesman sal on (agent.sal_id=sal.doc_no and sal.sal_type='SLA') where agent.rdocno="+docno;
           // System.out.println("-------salsql------" + salsql);
            ResultSet resultSet = stmt.executeQuery(salsql);
            data = objcommon.convertToJSON(resultSet);
            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return data;
    }
	public int insert(Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
			String accdoc, String puraccname, String cmbcurr, String currate,
			String delterms, String payterms, String purdesc,
			HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
			HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc, String billingname, 
			String billingtrn,ArrayList<String> agentarray,int manual, String property, String owner, Date sqlcontractfromdate, Date sqlcontracttodate, String rentsalevalue) throws SQLException {
		Connection conn=null;
		try{
			int docno;
			
			 conn=objconn.getMyConnection();
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
//			System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
	 
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
			if(rentsalevalue.trim().equalsIgnoreCase("") || rentsalevalue==null || rentsalevalue.equalsIgnoreCase("undefined")){
				rentsalevalue="0";
			}
			//rentsalevalue=rentsalevalue.equalsIgnoreCase("")?"0":rentsalevalue;
			if(docno>0){
				String strupdate="update rl_prinvm set property='"+property+"',owner='"+owner+"',fromdate='"+sqlcontractfromdate+"',todate='"+sqlcontracttodate+"',rentsalevalue="+rentsalevalue+",billingname='"+billingname+"',billingtrn='"+billingtrn+"',manual="+manual+" where doc_no="+docno;
				System.out.println("=== "+strupdate);
				int update=stmt.executeUpdate(strupdate);
				if(update<=0){
					return 0;
				}
			}
//			System.out.println(docval);
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
			
			request.setAttribute("trans",tranno);
			String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
			int dd=stmtnipurchase.executeUpdate(trnosql);
					 if(dd<=0)
						{
							conn.close();
							return 0;
						}
					 double nettaxtot = 0;
					 
			double grandtotal=0.0;
			double agentamount=0.0;
			double gridtotal=0.0;//Net Total
			double distributedamt=0.0;
			int gridsrno=0;
			for(int i=0;i<agentarray.size();i++){
				String agentdocno=agentarray.get(i).split("::")[0].trim();
				String stragentdetails="select head.curid,head.rate,head.doc_no,sal.sal_name from my_salm sal left join my_head head on (sal.acc_no=head.doc_no) where sal.doc_no="+agentdocno;
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
				//Update on 05-04-2020 - Account Change
				stragentdetails="select head.doc_no acno,head.curid,head.rate from my_account ac left join my_head head on (ac.acno=head.doc_no)where ac.codeno='AGENTCOMMISSIONACNO'";
				ResultSet rsagentacdetails=stmt.executeQuery(stragentdetails);
				while(rsagentacdetails.next()){
					agentrate=rsagentacdetails.getDouble("rate");
					agentcurid=rsagentacdetails.getInt("curid");
					agentacno=rsagentacdetails.getInt("acno");
				}
				String stragentexpdetails="select head.doc_no acno,head.curid,head.rate from my_account ac left join my_head head on (ac.acno=head.doc_no)where ac.codeno='COMEXP'";
				int agentexpacno=0,agentexpcurid=0;
				double agentexpcurrate=0.0;
				ResultSet rsagentexpdetails=stmt.executeQuery(stragentexpdetails);
				while(rsagentexpdetails.next()){
					agentexpcurrate=rsagentexpdetails.getDouble("rate");
					agentexpcurid=rsagentexpdetails.getInt("curid");
					agentexpacno=rsagentexpdetails.getInt("acno");
				}
				double agentpercent=0;
				if(!(agentarray.get(i).split("::")[1].trim().equalsIgnoreCase("") || agentarray.get(i).split("::")[1]==null || agentarray.get(i).split("::")[1].trim().equalsIgnoreCase("undefined"))){
					agentpercent=Double.parseDouble(agentarray.get(i).split("::")[1].trim());
				}
				
				agentpercent=objcommon.Round(agentpercent, 2);
				double dramount=0;
				if(!(agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("") || agentarray.get(i).split("::")[2]==null || agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("undefined"))){
					dramount=Double.parseDouble(agentarray.get(i).split("::")[2].trim());
				}

				
				dramount=objcommon.Round(dramount, 2);
				agentamount+=dramount;
				double ldramount=dramount*agentrate;
				ldramount=objcommon.Round(ldramount, 2);
				String note="Agent Commission of "+agentname+" for INV #"+vocno;
				String strinsertagentjv="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentacno+"','"+note+"','"+agentcurid+"','"+agentrate+"',"+dramount+"*-1,"+
				" "+ldramount+"*-1,0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				int insertagentjv=stmt.executeUpdate(strinsertagentjv);
				if(insertagentjv<=0){
					return 0;
				}
				String strinsertagentjvexp="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentexpacno+"','"+note+"','"+agentexpcurid+"','"+agentexpcurrate+"',"+dramount+","+
				" "+ldramount+",0,1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				int insertagentjvexp=stmt.executeUpdate(strinsertagentjvexp);
				if(insertagentjvexp<=0){
					return 0;
				}
				String strinsertagent="insert into rl_prinvagent(rdocno,sal_id,commpercent,commvalue,status)values("+docno+","+agentdocno+","+agentpercent+","+dramount+",3)";
				int insertagent=stmt.executeUpdate(strinsertagent);
				if(insertagent<=0){
					return 0;
				}
				gridsrno=gridsrno+2;
			}
			for(int i=0;i<descarray.size();i++){
				String temp[]=descarray.get(i).split("::");
				grandtotal+=Double.parseDouble(temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN")||temp[9].trim().equalsIgnoreCase("")|| temp[9].isEmpty()?"0":temp[9].trim());
				gridtotal+=Double.parseDouble(temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN")||temp[6].trim().equalsIgnoreCase("")|| temp[6].isEmpty()?"0":temp[6].trim());
			}
			System.out.println("Grid Total:"+gridtotal);
			System.out.println("Agent Amount:"+agentamount);
			System.out.println("Account size:");
			distributedamt=(gridtotal-agentamount)/(descarray.size()-1);
			for(int i=0;i< descarray.size();i++,gridsrno++){
				String[] purorderarray=descarray.get(i).split("::");
				String newjvdesc=jvdesc;
				String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
				nettaxtot+=Double.parseDouble(nettax);				
				if(i==descarray.size()-1){
					double dramt=nettotal+nettaxtot;
					double as=Double.parseDouble(currate);
					double ldramt=dramt*as;
					dramt=objcommon.Round(dramt, 2);
					ldramt=objcommon.Round(ldramt, 2);
					String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					 
//				   System.out.println("client account sql ="+sql1);
					 int ss = stmtnipurchase.executeUpdate(sql1);

				     if(ss<=0)
						{
							conn.close();
							return 0;
						}
					
				}
				ClsCommon comm = new ClsCommon();
				double taxper,tax,nettaxamount;
				Statement stmt21=conn.createStatement();
				String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
				ResultSet resultSet3 = stmt21.executeQuery(sqltax);
		    	 while(resultSet3.next()){
		    		 taxper=resultSet3.getDouble("per");
		    		 tax=comm.round(((nettotal*resultSet3.getDouble("per"))/100),session);
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
							conn.close();
							return 0;
							
						}
				     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
				     int acno=Integer.parseInt(acno1);
				     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
				     fdramt=Double.parseDouble(tmp)*1;
				     tdramt=fdramt*Double.parseDouble(currate);
				     fdramt=objcommon.Round(fdramt, 2);
				     tdramt=objcommon.Round(tdramt, 2);
				     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
	 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(fdramt*-1)+"',"+(fdramt*Double.parseDouble(currate))*-1+",0,-1,5,"+(gridsrno+1)+",0,0,0,'PRIV', "
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
					  double  fdramt1=Double.parseDouble(tmp1)*-1;
					  fdramt1=objcommon.Round(fdramt1, 2);	
				
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
						conn.close();
						return 0;
						
					}
				  
			     }
					String updat="update  rl_prinvm set tr_no="+tranno+",netamount="+grandtotal+"  where doc_no="+docno+"  ";
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
			 		    	 dramt=objcommon.Round(dramt, 2);
			 		    	 ldramt=objcommon.Round(ldramt, 2);
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
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
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
			 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
			 		    	 while(resultSet4.next()){
			 		    		amount=((nettaxtot)*-1);
			    			 	dramt=amount;
				 				as=Double.parseDouble(currate);
				 				ldramt=dramt*as;
				 				acno=resultSet4.getLong("acno");
			 		    	 }
			 		    	 dramt=objcommon.Round(dramt, 2);
			 		    	 ldramt=objcommon.Round(ldramt, 2);
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 				 
//				 			System.out.println("--sql1jvtran--"+sql1);
				 			if(taxperc>0){	 
				 				int ss = stmtnipurchase.executeUpdate(sql1);
//				 				System.out.println("+sql1 status++--"+ss);
				 			     if(ss<=0)
				 					{
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
							conn.close();
							return 0;
							}
			       

		if(docno>0){
			String strjvtally="select round(sum(dramount),2) amt from my_jvtran where tr_no="+tranno;
			ResultSet rsjvtally=stmt.executeQuery(strjvtally);
			while(rsjvtally.next()){
				if(rsjvtally.getDouble("amt")!=0.0){
					System.out.println("JV Amount Not Tallying");
					return 0;
				}
			}
		}
			    
		if (docno > 0) {
		    String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
			stmtnipurchase.executeUpdate(sqlss10);
			conn.commit();
			stmtnipurchase.close();
			conn.close();
			return docno;
		}
	}
	catch(Exception e){	
		conn.close();
		e.printStackTrace();
		return 0;
	}
	finally{
		conn.close();
	}
	return 0;
	}
	
	public   JSONArray reloadPropertyInvoiceGrid(String id,String nidoc) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();
			String pySql=(" select d.rowno, d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
				    + "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
				    + " from rl_prinvd d left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
				    + "  where d.rdocno='"+nidoc+"'"); 
		    System.out.println("=====++==="+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);
			data=objcommon.convertToJSON(resultSet); 
			stmtVeh1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return data;
	}
	
	
	public  ClsPropertyInvoiceBean getPrint(int docno, HttpServletRequest request ,HttpSession session) throws SQLException {
		ClsPropertyInvoiceBean bean = new ClsPropertyInvoiceBean();
		  Connection conn = null; // String brcid=session.getAttribute("BRANCHID").toString();
		 // String doc_no=request.getParameter("doc_no");
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String sqltst="";
				 String brcid=session.getAttribute("BRANCHID").toString();
				
	        	String test="select coalesce(rdocno,0)salid from rl_prinvagent where rdocno="+docno+"";
	        	System.out.println("salfetch==="+test);
	        	ResultSet rstt = stmtprint.executeQuery(test);
	        	while(rstt.next()){
	        		
	        		sqltst=" having min(rp.rowno)";
	        		
	        	}
				/*String resql=("select m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount,m.type,m.acno,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype,m.refno,m.curid,m.rate,m.delterm, "
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,h.account from my_srvsalem m left join my_head h on h.doc_no=m.acno  where m.DOC_NO='"+docno+"' ");
				*/
				String resql = ("select  coalesce(r.mgprpty,0)mgprpty,sm.sal_name salagent,coalesce(m.billingname,'') billingname,if(coalesce(m.billingtrn,'')='0','',m.billingtrn) billingtrn,m.voc_no,if(CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))=' NIL , NIL','',CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))) as telno,"
					+ " coalesce(b.tinno,0) brtinno,round(sum(d.nettaxamount),2) nettaxtot,m.refno,coalesce(a.mail1,'') mail1,  coalesce(a.fax1,'') fax1,coalesce(a.per_mob,'') per_mob,a.address, "
					+ "coalesce(a.contactperson,'') contactperson,m.voc_no,date_format(m.date,'%d-%m-%Y') date,coalesce(a.tinno,a.trnnumber) trnnumber,a.com_mob,m.invno,date_format(m.invdate,'%d-%m-%Y') invdate, "
					+ "round(m.netamount,2) netamount,m.type,m.property,m.owner,date_format(m.fromdate,'%d-%m-%Y')fromdate,date_format(m.todate,'%d-%m-%Y')todate,coalesce(round(m.rentsalevalue,2),0)rentsalevalue,coalesce(m.reftype,'')reftype,m.type,m.acno,if(trim(m.delterm)!='',m.delterm,null) delterm,"
					+ "if(trim(m.payterm)!='',m.payterm,null)payterm,date_format(m.deldate,'%d-%m-%Y') deldate, if(trim(m.desc1)!='',m.desc1,null)desc1,coalesce(m.billingname,h.description) description,"
					+ "h.account,round(sum(d.tax),2) taxamount from rl_prinvm m left join rl_tncm mm on m.refno=mm.doc_no left join rl_propertymaster r on r.doc_no=mm.prtype left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM'  "
					+ "left join rl_prinvd d on m.doc_no=d.rdocno  left join my_brch b on m.brhid=b.doc_no left join rl_prinvagent rp on (m.doc_no=rp.rdocno) left join my_salesman sm on rp.sal_id=sm.doc_no"
					+ "  where m.DOC_NO="+ docno + " group by d.rdocno "+sqltst+"");
				//System.out.println("Query++++++++"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				DecimalFormat df = new DecimalFormat("###,##0.00");
			     
			       while(pintrs.next()){
					   bean.setLbldocno(pintrs.getString("voc_no"));
			          bean.setTelno(pintrs.getString("telno"));		    	
			          bean.setCompanytrno(pintrs.getString("brtinno"));
			          
			    bean.setLblcltrnno(pintrs.getString("trnnumber"));
			    if(!pintrs.getString("billingtrn").equalsIgnoreCase("")){
			    	bean.setLblcltrnno(pintrs.getString("billingtrn"));
			    }
			   // System.out.println("tr======"+pintrs.getString("trnnumber"));
				bean.setAttn(pintrs.getString("contactperson"));
				bean.setLblvenphon(pintrs.getString("per_mob"));
				bean.setLblvenaddress(pintrs.getString("address"));
				System.out.println("affff"+pintrs.getString("address"));
				bean.setLblvenland(pintrs.getString("com_mob"));
				bean.setFax(pintrs.getString("fax1"));
				bean.setEmail(pintrs.getString("mail1"));
				bean.setRefno(pintrs.getString("refno"));

				bean.setLbldate(pintrs.getString("date"));
				// bean.setLbltype(pintrs.getString("reftype"));
				bean.setDocvals(pintrs.getString("voc_no"));
				bean.setLblacno(pintrs.getString("account"));
				// upper
				bean.setLblacnoname(pintrs.getString("description"));
				if(!pintrs.getString("billingname").equalsIgnoreCase("")){
			    	bean.setLblacnoname(pintrs.getString("description"));
			    }
				bean.setLbldeldate(pintrs.getString("deldate"));
				bean.setLbldddtm(pintrs.getString("delterm"));

				bean.setLbldsc(pintrs.getString("desc1"));
				bean.setLblpatms(pintrs.getString("payterm"));
				
				bean.setLblnettotal(df.format(pintrs.getDouble("netamount")));
				bean.setLbltaxamount(df.format(pintrs.getDouble("taxamount")));
				//bean.setLblnettaxamount(Float.parseFloat(pintrs.getString("netamount"))+Float.parseFloat(pintrs.getString("taxamount"))+"");
				bean.setLblnettaxamount(df.format(pintrs.getDouble("nettaxtot")));
				bean.setNettaxamount(df.format(pintrs.getDouble("nettaxtot")));
             //  System.out.println(df.format(pintrs.getDouble("nettaxtot")));
				ClsAmountToWords c = new ClsAmountToWords();
				bean.setLblamountinwords(c.convertAmountToWords(pintrs.getString("netamount")));

				bean.setLblinvno(pintrs.getString("invno"));
				bean.setLblinvdate(pintrs.getString("invdate"));
			    bean.setLblreftype(pintrs.getString("reftype"));
			    bean.setLblproperty(pintrs.getString("property"));
			    bean.setLblowner(pintrs.getString("owner"));
			    bean.setBillingname(pintrs.getString("billingname"));
			    bean.setLblfrom(pintrs.getString("fromdate"));
			    bean.setLblto(pintrs.getString("todate"));
			    bean.setLblrentsale(pintrs.getString("rentsalevalue"));
			    bean.setLblsalesagent(pintrs.getString("salagent"));
			    bean.setLblttype(pintrs.getString("type"));
			    bean.setLblmgtype(pintrs.getString("mgprpty"));
			    	    
			       }
				

				stmtprint.close();
				
				Statement stmtinvoice11 = conn.createStatement ();
				
				String bankinfosql = "select name,beneficiary,account,ibanno,swiftcode,logo,address branchaddress from cm_bankdetails where status=3 and brhid='"+session.getAttribute("BRANCHID").toString().trim()+"'";
				ResultSet resultsetbank = stmtinvoice11.executeQuery(bankinfosql);
				System.out.println("branchhhkkkkk"+session.getAttribute("BRANCHID").toString().trim());
				System.out.println("branchhh"+bankinfosql);
				
				String tst="select 'VAT 5%' desc1,sum(round(nettotal,2)) amt,sum(round(tax,2)) tax,sum(round(nettaxamount,2)) total from rl_prinvd where tax!=0 and rdocno="+ docno + " "
						+ "union all select 'VAT 0%' desc1,sum(round(nettotal,2)) amt,sum(round(tax,2)) tax,sum(round(nettaxamount,2)) total from rl_prinvd where tax=0 and rdocno="+ docno + " "
						+ "union all select 'Total' desc1,sum(round(nettotal,2)) amt,sum(round(tax,2)) tax,sum(round(nettaxamount,2)) total from rl_prinvd where rdocno="+ docno + " ;";
				System.out.println("====== "+tst);
				bean.setLbltaxqry(tst);
				while (resultsetbank.next()) {
					bean.setLbllogoimgpath(resultsetbank.getString("logo"));
					bean.setLblbankdetails(resultsetbank.getString("name"));
					bean.setLblbankbeneficiary(resultsetbank.getString("beneficiary"));
					bean.setLblbankaccountno(resultsetbank.getString("account"));
					bean.setLblbeneficiarybank(resultsetbank.getString("swiftcode"));
					bean.setLblbankibanno(resultsetbank.getString("ibanno"));
					bean.setLblcompbranchaddress(resultsetbank.getString("branchaddress"));
				} 
				
				stmtinvoice11.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvsalem r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
				    String companysql = "select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from rl_prinvm r inner join my_brch b on  "
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
					
						String strSqldetail="select d.srno,d.desc1 description,format(d.unitprice,2) unitprice,round(d.qty) qty,format(d.total,2) total,coalesce(format(d.discount,2),'')discount,format(d.nettotal,2) nettotal,d.nuprice,"
								+ " d.remarks,h.account account,h.description accname,h.atype accounttype,round(d.taxper,2) taxper,format(d.tax,2) taxperamt,format(d.nettaxamount,2) nettaxamount  from rl_prinvd d left join my_head h on h.doc_no=d.acno  "
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

					///cargo///////////
					Statement stmtcargo=conn.createStatement();
					String branchsql="select  b.branchname,b.address,b.tel,b.fax,l.loc_name location,coalesce(b.tinno,0) tinno from rl_prinvm m left join my_brch b on m.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no where m.doc_no="+docno;
					System.out.println("====branchsql===="+branchsql);
					ResultSet rsbranch=stmtcargo.executeQuery(branchsql);
					while(rsbranch.next()){
						bean.setLblbranch(rsbranch.getString("branchname"));
						bean.setLblbranchaddress(rsbranch.getString("address"));
						bean.setLblbranchtel(rsbranch.getString("tel"));
						bean.setLblbranchfax(rsbranch.getString("fax"));
						bean.setLbllocation(rsbranch.getString("location"));
						bean.setLblbranchtrno(rsbranch.getString("tinno"));
					}
					rsbranch.close();
					
					 Statement stmt=conn.createStatement();
				
					
					
					String username="select u.USER_NAME preparedby from datalog d left join my_user u on (d.userid=u.DOC_NO) where"
			        		+ " d.ENTRY='A' and d.dtype='PRIV' and d.doc_no="+docno+"";
					System.out.println("rst"+username);
                   
                      
                       ResultSet result=stmt.executeQuery(username);
                      // String uname="";
                       while (result.next())
                       {
                       	//uname=result.getString("preparedby");
                       	bean.setUsername(result.getString("preparedby"));
                       	//System.out.println("rst"+result.getString("USER_NAME"));
                       }
                    //System.out.println("rst====="+uname);
                     
                     stmt.close();
					
			/*		String crsql="select coalesce(m.invno,'') jobno,coalesce(cm.refno,'') cusref,ac.refname,coalesce(ac.address,'') address, "
							+ " coalesce(ac.per_mob,'') per_mob,coalesce(ac.fax1,'') fax1,coalesce(ac.contactPerson,'') contactPerson,coalesce(ac.mail1,'') mail1,coalesce(ac.tinno,0) trnnumber,"
							+ " format(sum(d.unitprice),2) grossrate,format(sum(total),2) grossamount,format(sum(d.discount),2) discount,"
							+ " format(sum(d.unitprice-d.discount),2) taxablerate,format(sum(d.nettotal),2) taxableamount,"
							+ " format(sum(d.tax),2) vatamount,format(sum(d.nettaxamount),2) netamount,round(sum(d.nettaxamount),2) wordsamount, "
							+ " coalesce(cf.mawb,'') mawb,coalesce(cf.mbl,'') mbl,coalesce(cf.hawb,'') hawb,coalesce(cf.hbl,'') hbl,coalesce(cf.shipper,'') shipper,"
							+ " coalesce(cf.consignee,'') consignee,coalesce(cf.carrier,'') carrier,coalesce(cf.flightno,'') flightno,coalesce(cf.voage,'') voage,coalesce(cf.etd,'') etd,"
							+ " coalesce(cf.eta,'') eta,coalesce(cf.ttime,'') ttime,coalesce(cf.boe,'') boe,coalesce(cf.contno,'') contno,"
							+ " coalesce(cf.truckno,'') truckno,coalesce(ed.volume,'') volume,coalesce(ed.noofpacks,'') qty "
							+ " from my_srvsalem m  "
							+ " left join(select invtrno,rdocno  from  cr_cfid where invtrno>0  group by rdocno,invtrno) dd on dd.invtrno=m.tr_no and m.status=3 "
							+ " left join cr_cfim  cf on if(dd.invtrno>0,cf.doc_no=dd.rdocno, cf.tr_no=m.tr_no) left join cm_srvcontrm cm on cf.refno=cm.tr_no"
							+ " left join my_acbook ac on ac.acno=m.acno  and ac.dtype='crm' left join my_srvsaled d on m.doc_no=d.rdocno"
							+ " left join cr_joblist l on l.jobno=cm.tr_no left join cr_enqd ed on l.enqdocno=ed.doc_no "
							+ " where m.doc_no="+docno+" group by m.doc_no";*/
					
					
					
					
				conn.close();



				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		return bean;
		
	
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
		
		conn= objconn.getMyConnection();
	    Statement stmtCPV = conn.createStatement ();
	    
	    if(type.equalsIgnoreCase("GL")||type.equalsIgnoreCase("AR")||type.equalsIgnoreCase("AP")){
	    	sql="select t.atype,coalesce(a.refname,'') billingname,coalesce(a.trnnumber,'') billingtrn,a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(cb.rate,2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
	                + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	                + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	                + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
	                + "where t.atype='"+type+"' and t.m_s=0 "+sqltest;
	    }
	    else{
	    	sql="select t.atype,a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(cb.rate,2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
	            + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	            + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	            + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
	            + "where t.atype='AR' and t.m_s=0 and t.den='340'"+sqltest;
	    }
	  //  System.out.println("--acc---sql---"+sql);
	    ResultSet resultSet = stmtCPV.executeQuery (sql);
	    RESULTDATA=objcommon.convertToJSON(resultSet);
	    
	    stmtCPV.close();
	    conn.close();
	  }
	  catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }
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
    	sqlStartDate = objcommon.changeStringtoSqlDate(datess);
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
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
    	} 
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
    	}
        
	    Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.manual,coalesce(m.property,'') property,coalesce(m.owner,'') owner,m.fromdate,m.todate,round(coalesce(m.rentsalevalue,0),2) rentsalevalue,coalesce(m.billingname,'') billingname,coalesce(m.billingtrn,'') billingtrn,a.per_mob mobno,convert(coalesce(coalesce(t.voc_no,m.refno),''),char(20)) refvocno,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        	+ " m.deldate,m.desc1,h.description,h.account,m.interstate,h.atype from rl_prinvm m left join rl_tncm t on m.refno=t.doc_no left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' where m.status<>7  "
	        	+ " and m.brhid='"+brcid+"' "+sqltest );
	        	System.out.println("===pysql====="+pySql);
	        	
	       
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=objcommon.convertToJSON(resultSet); 
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
	
	public   JSONArray accountGridsearch(String type) throws SQLException {
	      
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
  try {
     conn = objconn.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             
    String sqq= ("select t.gr_type grtype,t.doc_no,t.account,t.description,c.code curr,c.doc_no curid,c.c_rate from my_head t left join my_curr c "
      + "on t.curid=c.doc_no where atype='"+type+"' and m_s=0 ");
    
    
  // System.out.println("--cczxc-----"+sqq);
    
    ResultSet resultSet = stmtCPV.executeQuery (sqq);
    
   

    RESULTDATA=objcommon.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();

  }
  catch(Exception e){
	   conn.close();
   e.printStackTrace();
  }
        return RESULTDATA;
    }
	
	public JSONArray SalesgentSearch() throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
            Statement stmtVeh = conn.createStatement();
            String salsql = "select doc_no,sal_name  from my_salesman where sal_type='SLA' and status<>7 and activestatus='A';";
            ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA =objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
	
	
	public boolean edit(int docno,Date sqlStartDate,Date purdeldate, String reftype, String refno, String acctype,
			String accdoc, String puraccname, String cmbcurr, String currate,
			String delterms, String payterms, String purdesc,
			HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,
			String Formdetailcode,int tranno,HttpServletRequest request,Date sqlinvdate,String invno,String indateval,int interstate,
			Double taxperc, String billingname, String billingtrn, ArrayList<String> agentarray ,String property, String owner, 
			Date sqlcontractfromdate, Date sqlcontracttodate, String rentsalevalue,String manual,int vocno, String brhid) throws SQLException {
		Connection conn=null;
		try{
			
			 conn=objconn.getMyConnection();
			 conn.setAutoCommit(false);
			 Statement stmt= conn.createStatement ();
			 String upsql="select method from gl_config where field_nme like'tax'";
			 ResultSet resultSet33 = stmt.executeQuery(upsql);
			 int docval = 0;
			 if (resultSet33.next()) {
				 docval=resultSet33.getInt("method");
			 }		  
			 if(docval==0)
			 {
				 String upsql2="select method from gl_prdconfig where field_nme like'tax'";
				 ResultSet resultSet2 = stmt.executeQuery(upsql2);
				 if(resultSet2.next()) {
					 docval=resultSet2.getInt("method");
				 }
			 }
			 int owneracno=0;
			 if(reftype!=null){
			if(reftype.equalsIgnoreCase("TNC")){
			 String strgetowneracno="select ownerhead.doc_no owneracno from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner own on own.doc_no=pm.owid left join my_head ownerhead on "+
				" pm.acno=ownerhead.doc_no left join my_acbook ac on (ownerhead.doc_no=ac.acno) left join my_acbook tn on (m.cldocno=tn.cldocno and tn.dtype='CRM') where m.status=3 and m.doc_no='"+refno+"'";
				ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
				while(rsgetowneracno.next()){
					owneracno=rsgetowneracno.getInt("owneracno");
				}
			 }
			 }
				int cldocno=0;
				String strgetcldocno="select coalesce(ac.cldocno,0) cldocno from my_head head left join my_acbook ac on (head.doc_no=ac.acno) where head.doc_no="+accdoc;
				ResultSet rsgetcldocno=stmt.executeQuery(strgetcldocno);
				while(rsgetcldocno.next()){
					cldocno=rsgetcldocno.getInt("cldocno");
				}
			 CallableStatement stmtnipurchase= conn.prepareCall("{call propertyInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			 stmtnipurchase.setString(14,brhid);
			 stmtnipurchase.setString(15,reftype);
			 stmtnipurchase.setInt(16,docno);
			 stmtnipurchase.setString(17,"E");
			 stmtnipurchase.setInt(18, docno);
			 stmtnipurchase.setInt(19,interstate);
			 int aaa=stmtnipurchase.executeUpdate();
			 docno=stmtnipurchase.getInt("docNo");
			 //			System.out.println("=="+stmtnipurchase.toString());
			 if(aaa<=0)
			 {
				 conn.close();
				 return false;
			 }	
			 ClsApplyDelete applydelete=new ClsApplyDelete();
			 applydelete.getFinanceApplyDelete(conn, tranno);
			 
			 /*String delsql="Delete from rl_prinvd where rdocno="+docno+" and brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
			 stmtnipurchase.executeUpdate(delsql);*/  
			   
			 String delsql1="Delete from my_jvtran where tr_no="+tranno+" ";
			 System.out.print(delsql1);
			 stmtnipurchase.executeUpdate(delsql1);
		   
			 String delsql2="Delete from my_costtran where tr_no="+tranno+" ";
			 stmtnipurchase.executeUpdate(delsql2);
		      
			 String deleteagent="delete from rl_prinvagent where rdocno="+docno;
			 stmtnipurchase.executeUpdate(deleteagent);
			
			// int tranno=0;
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
			//rentsalevalue=rentsalevalue.equalsIgnoreCase("")?"0":rentsalevalue;
			if(docno>0){
				String strupdate="update rl_prinvm set property='"+property+"',owner='"+owner+"',fromdate='"+sqlcontractfromdate+"',todate='"+sqlcontracttodate+"',rentsalevalue="+rentsalevalue+",billingname='"+billingname+"',billingtrn='"+billingtrn+"' where doc_no="+docno;
				System.out.println("=== "+strupdate);
				int update=stmt.executeUpdate(strupdate);
				if(update<0){
					return false;
				}
			}

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
			double nettaxtot = 0;
					 
			double grandtotal=0.0;
			double agentamount=0.0;
			double gridtotal=0.0;//Net Total
			double distributedamt=0.0;
			int gridsrno=0;
			for(int i=0;i<agentarray.size();i++){
				String agentdocno=agentarray.get(i).split("::")[0].trim();
				String stragentdetails="select head.curid,head.rate,head.doc_no,sal.sal_name from my_salm sal left join my_head head on (sal.acc_no=head.doc_no) where sal.doc_no="+agentdocno;
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
				//Update on 05-04-2020 - Account Change
				stragentdetails="select head.doc_no acno,head.curid,head.rate from my_account ac left join my_head head on (ac.acno=head.doc_no)where ac.codeno='AGENTCOMMISSIONACNO'";
				ResultSet rsagentacdetails=stmt.executeQuery(stragentdetails);
				while(rsagentacdetails.next()){
					agentrate=rsagentacdetails.getDouble("rate");
					agentcurid=rsagentacdetails.getInt("curid");
					agentacno=rsagentacdetails.getInt("acno");
				}
				String stragentexpdetails="select head.doc_no acno,head.curid,head.rate from my_account ac left join my_head head on (ac.acno=head.doc_no)where ac.codeno='COMEXP'";
				int agentexpacno=0,agentexpcurid=0;
				double agentexpcurrate=0.0;
				ResultSet rsagentexpdetails=stmt.executeQuery(stragentexpdetails);
				while(rsagentexpdetails.next()){
					agentexpcurrate=rsagentexpdetails.getDouble("rate");
					agentexpcurid=rsagentexpdetails.getInt("curid");
					agentexpacno=rsagentexpdetails.getInt("acno");
				}
				double agentpercent=0;
				if(!(agentarray.get(i).split("::")[1].trim().equalsIgnoreCase("") || agentarray.get(i).split("::")[1]==null || agentarray.get(i).split("::")[1].trim().equalsIgnoreCase("undefined"))){
					agentpercent=Double.parseDouble(agentarray.get(i).split("::")[1].trim());
				}
				
				agentpercent=objcommon.Round(agentpercent, 2);
				double dramount=0;
				if(!(agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("") || agentarray.get(i).split("::")[2]==null || agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("undefined"))){
					dramount=Double.parseDouble(agentarray.get(i).split("::")[2].trim());
				}

				
				dramount=objcommon.Round(dramount, 2);
				agentamount+=dramount;
				double ldramount=dramount*agentrate;
				ldramount=objcommon.Round(ldramount, 2);
				String note="Agent Commission of "+agentname+" for INV #"+vocno;
				String strinsertagentjv="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentacno+"','"+note+"','"+agentcurid+"','"+agentrate+"',"+dramount+"*-1,"+
				" "+ldramount+"*-1,0,-1,5,0,0,0,0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
				System.out.println(strinsertagentjv);
				int insertagentjv=stmt.executeUpdate(strinsertagentjv);
				if(insertagentjv<=0){
					return false;
				}
				String strinsertagentjvexp="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentexpacno+"','"+note+"','"+agentexpcurid+"','"+agentexpcurrate+"',"+dramount+","+
				" "+ldramount+",0,1,5,0,0,0,0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
				System.out.println(strinsertagentjvexp);
				int insertagentjvexp=stmt.executeUpdate(strinsertagentjvexp);
				if(insertagentjvexp<=0){
					return false;
				}
				String strinsertagent="insert into rl_prinvagent(rdocno,sal_id,commpercent,commvalue,status)values("+docno+","+agentdocno+","+agentpercent+","+dramount+",3)";
				int insertagent=stmt.executeUpdate(strinsertagent);
				if(insertagent<=0){
					return false;
				}
				gridsrno=gridsrno+2;
			}
			double gridtaxamt=0.0,gridtaxtotal=0.0;
			for(int i=0;i<descarray.size();i++){
				String temp[]=descarray.get(i).split("::");
				System.out.println("grandtotal == "+Double.parseDouble(temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN")||temp[9].trim().equalsIgnoreCase("")|| temp[9].isEmpty()?"0":temp[9].trim()));
				grandtotal+=Double.parseDouble(temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN")||temp[9].trim().equalsIgnoreCase("")|| temp[9].isEmpty()?"0":temp[9].trim());
				gridtotal+=Double.parseDouble(temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN")||temp[6].trim().equalsIgnoreCase("")|| temp[6].isEmpty()?"0":temp[6].trim());
			}
			System.out.println("Grid Total:"+gridtotal);
			System.out.println("Agent Amount:"+agentamount);
			distributedamt=(gridtotal-agentamount)/(descarray.size()-1);
			for(int i=0;i< descarray.size();i++,gridsrno++){
				String[] purorderarray=descarray.get(i).split("::");
				String newjvdesc=jvdesc;
				String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
				nettaxtot+=Double.parseDouble(nettax);	
				System.out.println(nettaxtot);
				if(owneracno==Integer.parseInt(accdoc)){
					if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
				     {
					String clientamt=purorderarray[9].trim();
					String clientjvdesc=purorderarray[13].trim();
					clientamt=(objcommon.Round(Double.parseDouble(clientamt),2))+"";
					String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+clientjvdesc+"','"+cmbcurr+"','"+currate+"',"+clientamt+","+Double.parseDouble(clientamt)*Double.parseDouble(currate)+",0,1,5,0,0,"+cldocno+",0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
					 
				//   System.out.println("client account sql ="+sql1);
					 int ss = stmtnipurchase.executeUpdate(sql1);

				     if(ss<=0)
						{
				    	 System.out.println("Client JV Insert Error");	
				    	 conn.close();
							return false;
						}
				     }
				}
				else{
					if(i==descarray.size()-1){
						//System.out.println("Net Total:"+nettotal);
//						System.out.println("Net Tax Total:"+nettaxtot);
						//double dramt=nettotal+nettaxtot;
						double dramt=grandtotal;
						double as=Double.parseDouble(currate);
						double ldramt=dramt*as;
//						System.out.println("1:"+nettotal);
//						System.out.println("2:"+nettaxtot);
						dramt=objcommon.Round(dramt, 2);
						ldramt=objcommon.Round(ldramt, 2);
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
						 
					  // System.out.println("client account sql ="+sql1);
						 int ss = stmtnipurchase.executeUpdate(sql1);

					     if(ss<=0)
							{
								conn.close();
								return false;
							}
						
					}
				}
				
				ClsCommon comm = new ClsCommon();
				double taxper=0,tax=0,nettaxamount=0;
				Statement stmt21=conn.createStatement();
				String sqltax="select per ,round((("+nettotal+"*per)/100),2) tax,round("+nettotal+"+round((("+nettotal+"*per)/100),2),2) nettot from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
				System.out.println("===== "+sqltax);
				ResultSet resultSet3 = stmt21.executeQuery(sqltax);
		    	 while(resultSet3.next()){
		    		 taxper=resultSet3.getDouble("per");
		    		 // tax=((nettotal*resultSet3.getDouble("per"))/100);
		    		 // tax=comm.Round(((nettotal*resultSet3.getDouble("per"))/100),2);
		    		 tax=resultSet3.getDouble("tax");
		    		 nettaxamount=resultSet3.getDouble("nettot");
		    	 }
		    	// System.out.println("tax === "+tax+" ==== "+nettaxamount);
		    	 
		    	 
				 
		    	 Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+"")); 
			     int detrowno = purorderarray[16].trim().equalsIgnoreCase("undefined")|| purorderarray[16].trim().equalsIgnoreCase("NaN")||purorderarray[16].trim().equalsIgnoreCase("")|| purorderarray[16].isEmpty()?0:Integer.parseInt(purorderarray[16].trim());
		    	 if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
		    		 String sql="";
		    		 if(detrowno>0) {
		    			 sql="UPDATE rl_prinvd SET srno="+(i+1)+",qty='"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
		    			 	+ "desc1='"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
		    			 	+ "unitprice='"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
		    			 	+ "total='"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
		    			 	+ "discount='"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
		    			 	+ "nettotal='"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
		    			 	+ "taxper='"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
		    			 	+ "tax='"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
		    			 	+ "nettaxamount='"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
		    			 	+ "nuprice='"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
		    			 	+ "costtype='"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
		    			 	+ "costcode='"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
		    			 	+ "remarks='"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
		    			 	+ "acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' "
		    			 	+ "WHERE rdocno='"+docno+"' and rowno='"+detrowno+"'";
		    		 }else {
		    			  sql="INSERT INTO rl_prinvd(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
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
							       + "'"+brhid+"',"
							       +"'"+docno+"')";
		    		 }
		    		 System.out.println("__saled--"+sql);
		    		 int resultSet2 = stmtnipurchase.executeUpdate(sql);
				     
				     if(resultSet2<=0)
						{
							conn.close();
							return false;
							
						}
				     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
				     int acno=Integer.parseInt(acno1);
				     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
				     fdramt=Double.parseDouble(tmp)*1;
				     tdramt=fdramt*Double.parseDouble(currate);
				    fdramt=objcommon.Round(fdramt, 2);
				    tdramt=objcommon.Round(tdramt, 2);
				     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
	 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(fdramt*-1)+"',"+(fdramt*Double.parseDouble(currate))*-1+",0,-1,5,"+(gridsrno+1)+",0,0,0,'PRIV', "
					+ "'"+brhid+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
					+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
					     
				  // System.out.println("other account sql ="+don);	
				int samp=stmtnipurchase.executeUpdate(don);

				     
				 if(samp<=0)
					{
						conn.close();
						return false;
						
					}
						//}
				      
				 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
			     {
					 int TRANID=0;
					 sno=sno+1;
					  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					  double  fdramt1=Double.parseDouble(tmp1)*-1;
					  fdramt1=objcommon.Round(fdramt1, 2);
				
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
						conn.close();
						return false;
						
					}
				  
			     }
					String updat="update  rl_prinvm set tr_no="+tranno+",netamount="+grandtotal+" where doc_no="+docno+"  ";
					  int tabs=  stmtnipurchase.executeUpdate(updat);
					  if(tabs<=0)
						{
							conn.close();
							return false;
						}
			     }
		     }
			 if(docval>0){
				 Statement stmt21 = conn.createStatement ();
				 Statement stmtt=conn.createStatement();
				 Statement stmtt2=conn.createStatement();
				 String newjvdesc=jvdesc;
			    		 if(interstate>0){
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
			 		    	 dramt=objcommon.Round(dramt, 2);
			 		    	 ldramt=objcommon.Round(ldramt, 2);
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
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
			 		    	 dramt=objcommon.Round(dramt, 2);
			 		    	 ldramt=objcommon.Round(ldramt, 2);
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+brhid+"',"+tranno+",'"+iapprovalStatus+"')";
				 				 
				 			System.out.println("--sql1jvtran--"+sql1);
				 			if(taxperc>0){	 
				 				int ss = stmtnipurchase.executeUpdate(sql1);
//				 				System.out.println("+sql1 status++--"+ss);
				 			     if(ss<=0)
				 					{
				 						conn.close();
				 						return false;
				 						
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
				
					int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,brhid,""+vocno,1,arr,mode)	;
						if(result==0)	
					        {
							conn.close();
							return false;
							}
			       

			if(docno>0){
				
				String strjvtally="select round(sum(dramount),2) amt from my_jvtran where tr_no="+tranno;
				ResultSet rsjvtally=stmt.executeQuery(strjvtally);
				while(rsjvtally.next()){
					System.out.println("Jv Sum:"+rsjvtally.getDouble("amt"));
					if(rsjvtally.getDouble("amt")!=0.0){
						System.out.println("JV Amount Not Tallying");
						ResultSet rsjvcheck=conn.createStatement().executeQuery("select acno,dramount from my_jvtran where tr_no="+tranno);
						while(rsjvcheck.next()){
							System.out.println(rsjvcheck.getInt("acno")+"::"+rsjvcheck.getDouble("dramount"));
						}
						return false;
					}
				}
			}
				    
			if (docno > 0) {
			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
					stmtnipurchase.executeUpdate(sqlss10);
				conn.commit();
				stmtnipurchase.close();
				conn.close();
				return true;
			}

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return false;  
	}

	
	public boolean delete(int docno,HttpSession session,String mode,String Formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			
			System.out.println("0000000000000000-0000000000000");
			CallableStatement stmtnipurchase= conn.prepareCall("{call propertyInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
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
			int aaa=stmtnipurchase.executeUpdate();
			
			int tr_no=0;
		     
			ArrayList<String> arr=new ArrayList<String>(); 
			ClsVatInsert ClsVatInsert=new ClsVatInsert();
			Statement newStatement=conn.createStatement();
			String selectsqls= " select tr_no from rl_prinvm where doc_no="+docno+" " ;
			System.out.println("selectsqlsselectsqlsselectsqls"+selectsqls);
			ResultSet rss101=newStatement.executeQuery(selectsqls);
			if(rss101.first())
			{
				tr_no=rss101.getInt("tr_no");
			}   
			ClsApplyDelete applydelete=new ClsApplyDelete();
			applydelete.getFinanceApplyDelete(conn, tr_no);
			String strupdatejv="update my_jvtran set status=7 where tr_no="+tr_no;
			int updatejv=stmtnipurchase.executeUpdate(strupdatejv);
			if(updatejv<=0){
				return false;
			}
			int result=ClsVatInsert.vatinsert(1,2,conn,tr_no,0,0,null,Formdetailcode,session.getAttribute("BRANCHID").toString(),"",1,arr,"D")	;
			System.out.println("result"+result);
			if(result==0)	
			{
				conn.close();
				return false;
			}
	 
			
			if (aaa > 0) {
				stmtnipurchase.close();
				conn.close();
				//System.out.println("Success");
				return true;
			}	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}
	
	public ClsPropertyInvoiceBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsPropertyInvoiceBean pintbean= new ClsPropertyInvoiceBean();
		
		Connection conn = null;
		
		try {
			conn = objconn.getMyConnection();
			Statement stmtCPV = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			String sql11="select m.manual,coalesce(m.property,'') property,coalesce(m.owner,'') owner,m.fromdate,m.todate,round(coalesce(m.rentsalevalue,0),2) rentsalevalue,coalesce(m.billingname,'') billingname,coalesce(m.billingtrn,'') billingtrn,a.per_mob mobno,convert(coalesce(coalesce(t.voc_no,m.refno),''),char(20)) refvocno,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        	+ " m.deldate,m.desc1,h.description,h.account,m.interstate,h.atype from rl_prinvm m left join rl_tncm t m.refno=t.doc_no left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' where m.status<>7  "
	        	+ " and m.doc_no="+docNo;
			System.out.println("viewdetails=========="+sql11);
			ResultSet resultSet = stmtCPV.executeQuery (sql11);

			while (resultSet.next()) {
				pintbean.setManual(resultSet.getString("manual"));
				pintbean.setProperty(resultSet.getString("property"));
				pintbean.setOwner(resultSet.getString("owner"));
				if(resultSet.getDate("fromdate")!=null){
					pintbean.setContractfromdate(resultSet.getDate("fromdate").toString());
				}
				if(resultSet.getDate("todate")!=null){
					pintbean.setContracttodate(resultSet.getDate("todate").toString());
				}
				pintbean.setRentsalevalue(resultSet.getString("rentsalevalue"));
				pintbean.setDocno(resultSet.getInt("voc_no"));
				pintbean.setMasterdoc_no(docNo);
				pintbean.setHidcmbreftype(resultSet.getString("reftype"));
				pintbean.setNipurchasedate(resultSet.getDate("date").toString());
				pintbean.setRefno(resultSet.getString("refvocno"));
				pintbean.setOrdermasterdoc_no(resultSet.getInt("refno"));
				pintbean.setAcctypeval(resultSet.getString("type"));
				pintbean.setCmbtype(resultSet.getString("atype"));
				pintbean.setReftypeval(resultSet.getString("reftype"));
				pintbean.setNipuraccid(resultSet.getString("account"));
				pintbean.setPuraccname(resultSet.getString("description"));
				pintbean.setNettotal(resultSet.getDouble("netamount"));
				pintbean.setAccdocno(resultSet.getString("acno"));
				pintbean.setTarannumber(resultSet.getInt("tr_no"));
				pintbean.setBillingname(resultSet.getString("billingname"));
				pintbean.setBillingtrn(resultSet.getString("billingtrn"));
				pintbean.setPurdesc(resultSet.getString("desc1"));
				pintbean.setAcctype(resultSet.getString("atype"));
				pintbean.setCurrate(resultSet.getString("rate"));
				pintbean.setHidcmbcurr(resultSet.getString("curid"));
		    }
			stmtCPV.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return pintbean;
		}
}
