package com.dashboard.realestate.maintenanceaudit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;

import javax.servlet.http.HttpSession;

import com.common.ClsApplyDelete;
import com.common.ClsVatInsert;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.util.ArrayList;

import net.sf.json.JSONArray;

import java.sql.CallableStatement;

import javax.servlet.http.HttpServletRequest;  

public class ClsMaintenanceAuditDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getPropertyData(String fromdate,String todate,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);   
				}
			 String strsql="select a.* from(select round(coalesce(rm.total,0),2) total,r.jv_vocno,r.blockamt,r.jvtrno,st.name status,p.acno owneracno,r.branch brhid,r.posttrno,p.mrf_acno mrfacno,r.margin,o.acno accountno,o.account_name accountname,ac.acno,r.doc_no,r.voc_no,r.edate date,j.job_desc job,r.comments,ac.refname tenant,if(p.mgprpty=1,'Y','N') managed,p.prid,p.accname property,o.primary_owner owner_name,p.unitno unit_number,r.priority,round(r.est_amt,2) estcost,h.description proname,h.account proacno,if(p.mgprpty=1,'Managed','Non Managed') classified from re_mreq r left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid left join rl_jobmaster j on j.doc_no=r.job_docno left join my_head h on (h.doc_no=r.jbprov and h.atype='ap')"       
						+" left join re_pstatus st on st.doc_no=r.statusid left join (select sum(total) total,rvocno,rbrhid  from re_mreqmgmt group by rvocno) rm on (rm.rvocno=r.voc_no and rm.rbrhid=r.branch) where r.status=3 and  r.mpconfirm=1 and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"'  order by statusid desc)a group by a.voc_no"; 
			 //System.out.println("strsql---->>>"+strsql);              
			ResultSet resultSet = stmt.executeQuery(strsql);        
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray loadRequestGrid(String vocno,String brhid,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmt = conn.createStatement(); 
			 String strsql="";
			 
				  strsql="select rmbjvdocno jvdocno,0 rowdelete,coalesce(rmbjvtrno,0) rmbjvtrno,coalesce(reimbursement,0) reimbursement,r.cpudoc,r.cpuvoc,r.invdoc,r.invvoc,(select acno from my_account where codeno='MAINTENANCE EXPENSE') taxacno,r.rowno,'' chk,st.name status,r.jobdocno,r.rbrhid brhid,j.job_desc job,h.description vendor_name,h.account vendor_acno,h.doc_no vendor_docno,r.rdocno doc_no,r.rvocno voc_no, r.paytype pay, r.estval est_cost, r.margin, r.total,r.description  from re_mreqmgmt r  left join re_mreq re on re.doc_no=r.rdocno left join re_pstatus st on st.doc_no=re.statusid left join rl_jobmaster j on j.doc_no=r.jobdocno left join my_head h on (h.doc_no=r.vndacno and h.atype='ap')"       
							+" where r.rvocno='"+vocno+"' and r.rbrhid='"+brhid+"'"; 
			 //System.out.println("strsql---->>>"+strsql);            
			 ResultSet resultSet = stmt.executeQuery(strsql);            
			 RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public boolean edit(Connection conn,int docno,Date sqlStartDate,Date purdeldate, String reftype, String refno, String acctype,
			String accdoc, String puraccname, String cmbcurr, String currate,
			String delterms, String payterms, String purdesc,
			HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,
			String Formdetailcode,int tranno,HttpServletRequest request,Date sqlinvdate,String invno,String indateval,int interstate,
			Double taxperc, String billingname, String billingtrn, ArrayList<String> agentarray ,String property, String owner, 
			Date sqlcontractfromdate, Date sqlcontracttodate, String rentsalevalue,String manual,int vocno) throws SQLException {
		try{    
			
			 //conn=ClsConnection.getMyConnection();    
			// conn.setAutoCommit(false);
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
			 CallableStatement stmtinvoice= conn.prepareCall("{call propertyInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			 stmtinvoice.setDate(1,sqlStartDate);
			 stmtinvoice.setString(2,refno);
			 stmtinvoice.setString(3,acctype);
			 stmtinvoice.setString(4,accdoc);
			 stmtinvoice.setString(5,cmbcurr);
			 stmtinvoice.setString(6,currate);
			 stmtinvoice.setString(7,delterms);
			 stmtinvoice.setString(8,payterms);
			 stmtinvoice.setString(9,purdesc);
			 stmtinvoice.setDate(10,purdeldate);
			 stmtinvoice.setDouble(11,nettotal);
			 stmtinvoice.setString(12,Formdetailcode);
			 stmtinvoice.setString(13,session.getAttribute("USERID").toString());
			 stmtinvoice.setString(14,session.getAttribute("BRANCHID").toString());
			 stmtinvoice.setString(15,reftype);
			 stmtinvoice.setInt(16,docno);
			 stmtinvoice.setString(17,"E");
			 stmtinvoice.setInt(18, docno);
			 stmtinvoice.setInt(19,interstate);
			 int aaa=stmtinvoice.executeUpdate();
			 docno=stmtinvoice.getInt("docNo");
			 System.out.println("nettotal=="+nettotal);
			 if(aaa<=0)
			 {
				 conn.close();
				 return false;
			 }	
			 ClsApplyDelete applydelete=new ClsApplyDelete();
			 applydelete.getFinanceApplyDelete(conn, tranno);
			 
			 String delsql="Delete from rl_prinvd where rdocno="+docno+" and brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
			 System.out.println("delsql=="+delsql);
			 stmtinvoice.executeUpdate(delsql);
			   
			 String delsql1="Delete from my_jvtran where tr_no="+tranno+" ";
			 System.out.print("delsql=="+delsql1);  
			 stmtinvoice.executeUpdate(delsql1);
		   
			 String delsql2="Delete from my_costtran where tr_no="+tranno+" ";
			 stmtinvoice.executeUpdate(delsql2);
		      
			 String deleteagent="delete from rl_prinvagent where rdocno="+docno;
			 stmtinvoice.executeUpdate(deleteagent);
			
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
			/*if(docno>0){
				String strupdate="update rl_prinvm set property='"+property+"',owner='"+owner+"',fromdate='"+sqlcontractfromdate+"',todate='"+sqlcontracttodate+"',rentsalevalue="+rentsalevalue+",billingname='"+billingname+"',billingtrn='"+billingtrn+"' where doc_no="+docno;
				System.out.println("=== "+strupdate);
				int update=stmt.executeUpdate(strupdate);
				if(update<0){
					return false;
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
			
			String appsql="select count(*)   icount from my_apprmaster where status=3 and dtype='"+Formdetailcode+"'";
			ResultSet appsqlrs = stmtinvoice.executeQuery(appsql);
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
				
				agentpercent=ClsCommon.Round(agentpercent, 2);
				double dramount=0;
				if(!(agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("") || agentarray.get(i).split("::")[2]==null || agentarray.get(i).split("::")[2].trim().equalsIgnoreCase("undefined"))){
					dramount=Double.parseDouble(agentarray.get(i).split("::")[2].trim());
				}

				
				dramount=ClsCommon.Round(dramount, 2);
				agentamount+=dramount;
				double ldramount=dramount*agentrate;
				ldramount=ClsCommon.Round(ldramount, 2);
				String note="Agent Commission of "+agentname+" for INV #"+vocno;
				String strinsertagentjv="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentacno+"','"+note+"','"+agentcurid+"','"+agentrate+"',"+dramount+"*-1,"+
				" "+ldramount+"*-1,0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				System.out.println(strinsertagentjv);
				int insertagentjv=stmt.executeUpdate(strinsertagentjv);
				if(insertagentjv<=0){
					return false;
				}
				String strinsertagentjvexp="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,"+
				" trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)"+
				" values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+agentexpacno+"','"+note+"','"+agentexpcurid+"','"+agentexpcurrate+"',"+dramount+","+
				" "+ldramount+",0,1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
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
			if(descarray.size()-1!=0){
				distributedamt=(gridtotal-agentamount)/(descarray.size()-1);
				}else{
					distributedamt=(gridtotal-agentamount);
				}
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
					clientamt=(ClsCommon.Round(Double.parseDouble(clientamt),2))+"";
					String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+clientjvdesc+"','"+cmbcurr+"','"+currate+"',"+clientamt+","+Double.parseDouble(clientamt)*Double.parseDouble(currate)+",0,1,5,0,0,"+cldocno+",0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
					 
				   System.out.println("client account sql ="+sql1);
					 int ss = stmtinvoice.executeUpdate(sql1);

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
						double dramt=nettotal;
						double as=Double.parseDouble(currate);
						double ldramt=dramt*as;
//						System.out.println("1:"+nettotal);
//						System.out.println("2:"+nettaxtot);
						dramt=ClsCommon.Round(dramt, 2);
						ldramt=ClsCommon.Round(ldramt, 2);
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
						 
					   System.out.println("client account sql ="+sql1);
						 int ss = stmtinvoice.executeUpdate(sql1);

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
				String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
				ResultSet resultSet3 = stmt21.executeQuery(sqltax);
		    	 while(resultSet3.next()){
		    		 taxper=resultSet3.getDouble("per");
		    		 tax=((nettotal*resultSet3.getDouble("per"))/100);
		    		 nettaxamount=nettotal+tax;
		    	 }
		    	 System.out.println("tax === "+tax+" ==== "+nettaxamount);
		    	 
		    	 
				 
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
		    		 System.out.println("__saled--"+sql);  
		    		 int resultSet2 = stmtinvoice.executeUpdate(sql);
				     
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
				    fdramt=ClsCommon.Round(fdramt, 2);
				    tdramt=ClsCommon.Round(tdramt, 2);
				     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
	 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(fdramt*-1)+"',"+(fdramt*Double.parseDouble(currate))*-1+",0,-1,5,"+(gridsrno+1)+",0,0,0,'PRIV', "
					+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
					+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
					     
				   System.out.println("other account sql ="+don);	
				int samp=stmtinvoice.executeUpdate(don);

				     
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
					  fdramt1=ClsCommon.Round(fdramt1, 2);
				
						String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
				
						ResultSet tass1 = stmtinvoice.executeQuery (trsqlss);
						
						if (tass1.next()) {
					
							TRANID=tass1.getInt("TRANID");	
						
						
							
					     }
						
						String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
								+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
								 
				  int costabsq=  stmtinvoice.executeUpdate(ssql);
				  
				  if(costabsq<=0)
					{
						conn.close();
						return false;
						
					}
				  
			     }
					String updat="update  rl_prinvm set tr_no="+tranno+",netamount="+grandtotal+" where doc_no="+docno+"  ";
					  int tabs=  stmtinvoice.executeUpdate(updat);
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
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);   
				 		    	 while(resultSet3.next()){
				 		    		amount=(nettaxtot)*-1;
				    			 	dramt=(nettaxtot)*-1;  
					 				as=Double.parseDouble(currate);
					 				ldramt=dramt*as;
					 				acno=resultSet3.getLong("acno");
					 				System.out.println(((nettaxtot)*-1)+"dramt========="+dramt); 
				 		    	 }   
			 		    	 dramt=ClsCommon.Round(dramt, 2);
			 		    	 ldramt=ClsCommon.Round(ldramt, 2);
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
			 				System.out.println(sql1);
			 				if(taxperc>0){
			 				 int ss = stmtinvoice.executeUpdate(sql1);

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
			 		    	 dramt=ClsCommon.Round(dramt, 2);                  
			 		    	 ldramt=ClsCommon.Round(ldramt, 2);
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'PRIV','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 				 
				 			System.out.println("--sql1jvtran--"+sql1);
				 			if(taxperc>0){	 
				 				int ss = stmtinvoice.executeUpdate(sql1);
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
				
					int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
						if(result==0)	
					        {
							//conn.close();
							//return 0;
							}
			       
						if(docno>0){
							String strjvtally="select round(sum(dramount),2) amt from my_jvtran where tr_no="+tranno;
							ResultSet rsjvtally=stmt.executeQuery(strjvtally);
							while(rsjvtally.next()){
								if(rsjvtally.getDouble("amt")!=0.0){
									System.out.println("JV Amount Not Tallying");
									return false;    
								}
							}
						}
				    
			if (docno > 0) {
			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
					stmtinvoice.executeUpdate(sqlss10);
					System.out.println("sucess");
				//conn.commit();
				stmtinvoice.close();
				//conn.close();    
				return true;
			}

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		/*finally{
			conn.close();
		}*/    
		return false;
	}       	
}
